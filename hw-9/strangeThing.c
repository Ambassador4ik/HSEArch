#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <stdbool.h>

// Буфер для чисел
int buffer[40];
int buffer_size = 0;
pthread_mutex_t buffer_mutex;

// Условная переменная для оповещения о готовности пары чисел
pthread_cond_t buffer_cond;

// Для отслеживания состояния выполнения
int active_generators = 20;
int active_summators = 0;

// Функция для генерации чисел от 1 до 20 с задержкой
void* number_generator(void* arg) {
    int number = *((int*) arg);
    sleep(rand() % 7 + 1);

    pthread_mutex_lock(&buffer_mutex);
    buffer[buffer_size++] = number;
    printf("Поток %d: число %d отправлено в буфер.\n", number, number);
    --active_generators;
    pthread_cond_signal(&buffer_cond); // Оповещаем о новом числе
    pthread_mutex_unlock(&buffer_mutex);

    free(arg);
    return NULL;
}

// Функция потока сумматора
void* adder_thread(void* args) {
    int* pair = (int*) args;
    sleep(rand() % 4 + 3);

    pthread_mutex_lock(&buffer_mutex);
    int sum = pair[0] + pair[1];
    buffer[buffer_size++] = sum;
    printf("Сумматор: числа %d и %d суммированы. Результат %d отправлен в буфер.\n", pair[0], pair[1], sum);
    --active_summators;  // Уменьшаем количество активных сумматоров
    pthread_cond_signal(&buffer_cond); // Оповещаем о возможности суммирования новой пары
    pthread_mutex_unlock(&buffer_mutex);

    free(pair);
    return NULL;
}

// Поток, отслеживающий поступление данных
void* watcher_thread(void* arg) {
    while (1) {
        pthread_mutex_lock(&buffer_mutex);

        while (buffer_size < 2) {
            if (active_generators == 0 && active_summators == 0) {
                // Все генераторы и сумматоры завершили работу
                pthread_mutex_unlock(&buffer_mutex);
                return NULL;
            }
            pthread_cond_wait(&buffer_cond, &buffer_mutex);
        }

        int* pair = malloc(2 * sizeof(int));
        pair[0] = buffer[--buffer_size];
        pair[1] = buffer[--buffer_size];
        pthread_mutex_unlock(&buffer_mutex);

        pthread_t adder;
        active_summators++;  // Увеличиваем количество активных сумматоров
        if (pthread_create(&adder, NULL, adder_thread, pair) != 0) {
            perror("Не удалось создать поток сумматора");
            return NULL;
        }
        pthread_detach(adder);
    }
    return NULL;
}

int main() {
    srand(time(NULL));
    pthread_mutex_init(&buffer_mutex, NULL);
    pthread_cond_init(&buffer_cond, NULL);

    pthread_t watcher;
    if (pthread_create(&watcher, NULL, watcher_thread, NULL) != 0) {
        perror("Не удалось создать поток наблюдателя");
        return EXIT_FAILURE;
    }

    for (int i = 1; i <= 20; ++i) {
        pthread_t thread;
        int* number = malloc(sizeof(int));
        *number = i;
        if (pthread_create(&thread, NULL, number_generator, number) != 0) {
            perror("Не удалось создать поток генератора чисел");
            return EXIT_FAILURE;
        }
        pthread_detach(thread);
    }

    // Ждем завершения работы потока watcher
    pthread_join(watcher, NULL);

    pthread_mutex_lock(&buffer_mutex);
    int result = buffer_size == 1 ? buffer[0] : -1;
    printf("Финальный результат: %d\n", result);
    pthread_mutex_unlock(&buffer_mutex);

    pthread_mutex_destroy(&buffer_mutex);
    pthread_cond_destroy(&buffer_cond);

    return result == 210 ? EXIT_SUCCESS : EXIT_FAILURE;
}
