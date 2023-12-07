#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <sys/time.h>

#define NUM_THREADS 1000
#define DATA_SIZE 100000000

// Структура для передачи данных в поток
struct ThreadData {
    double *A;
    double *B;
    long start;
    long end;
    double sum;
};

// Функция векторного произведения для потока
void *dot_product(void *args) {
    struct ThreadData *data = (struct ThreadData*) args;
    double sum = 0.0;
    for (long i = data->start; i < data->end; ++i) {
        sum += data->A[i] * data->B[i];
    }
    data->sum = sum;
    return NULL;
}

// Функция для однопоточного расчета
double dot_product_single_thread(double *A, double *B, long n) {
    double sum = 0.0;
    for (long i = 0; i < n; ++i) {
        sum += A[i] * B[i];
    }
    return sum;
}

// Функция для печати заголовка таблицы
void print_header() {
    printf("%-15s %-14s %-15s\n", "Element Count", "Thread Count", "Time Elapsed, ms");
    printf("%-15s %-14s %-15s\n", "-------------", "------------", "----------------");
}

// Функция для печати строки таблицы с данными
void print_row(long elements, int threads, double time) {
    printf("%-15ld %-14d %-15.2f\n", elements, threads, time);
}

int main() {
    long n = DATA_SIZE; // Объем данных
    double *A = (double*) malloc(n * sizeof(double));
    double *B = (double*) malloc(n * sizeof(double));

    // Наполнение векторов данными
    for (long i = 0; i < n; ++i) {
        A[i] = i + 1;
        B[i] = n - i;
    }

    // Многопоточный расчет
    pthread_t threads[NUM_THREADS];
    struct ThreadData thread_data[NUM_THREADS];
    long chunk_size = n / NUM_THREADS;

    struct timeval start, end;
    double elapsed; // Переменная для измерения времени
    double result = 0.0;

    // Запуск таймера
    gettimeofday(&start, NULL);

    for (int i = 0; i < NUM_THREADS; ++i) {
        thread_data[i].A = A;
        thread_data[i].B = B;
        thread_data[i].start = i * chunk_size;
        thread_data[i].end = (i == NUM_THREADS - 1) ? n : (i + 1) * chunk_size;
        pthread_create(&threads[i], NULL, dot_product, &thread_data[i]);
    }

    for (int i = 0; i < NUM_THREADS; ++i) {
        pthread_join(threads[i], NULL);
        result += thread_data[i].sum;
    }

    // Остановка таймера и вычисление времени
    gettimeofday(&end, NULL);
    elapsed = (end.tv_sec - start.tv_sec) * 1000.0;
    elapsed += (end.tv_usec - start.tv_usec) / 1000.0;
    print_header();
    print_row(n, NUM_THREADS, elapsed);

    // Однопоточный расчет
    gettimeofday(&start, NULL);
    result = dot_product_single_thread(A, B, n);
    gettimeofday(&end, NULL);
    elapsed = (end.tv_sec - start.tv_sec) * 1000.0;
    elapsed += (end.tv_usec - start.tv_usec) / 1000.0;
    print_row(n, 1, elapsed);

    free(A);
    free(B);

    return 0;
}
