#include <opencv2/opencv.hpp>
#include <cstdio>

/*
g++ computerlab5.cpp -o cam -I/usr/include/opencv4 \
  -lopencv_core \
  -lopencv_imgproc \
  -lopencv_highgui \
  -lopencv_videoio
*/

int main() {
    printf("Старт программы\n");

    cv::VideoCapture cap(0);
    if (!cap.isOpened()) {
        fprintf(stderr, "Ошибка: не удалось открыть камеру 0\n");
        return -1;
    }

    printf("Камера успешно открыта\n");

    cv::Mat frame;
    cv::namedWindow("test", cv::WINDOW_AUTOSIZE);

    // ИЗМЕРЕНИЯ
    double freq = cv::getTickFrequency();  // тиков в секунду
    int64_t ticks_start = cv::getTickCount();

    double all_processing_time_sum = 0.0;
    double processing_time_sum     = 0.0;
    double reading_time_sum        = 0.0;
    double writing_time_sum        = 0.0;
    long long frame_count          = 0;

    while (true) {
        int64_t t0 = cv::getTickCount();

        cap >> frame;
        int64_t t1 = cv::getTickCount();

        if (frame.empty()) {
            fprintf(stderr, "Пустой кадр, выходим\n");
            break;
        }

        int64_t t2 = cv::getTickCount();

        // ОБРАБОТКА
        cv::flip(frame, frame, 1);
        cv::cvtColor(frame, frame, cv::COLOR_BGR2GRAY);
        cv::threshold(frame, frame, 128, 255, cv::THRESH_BINARY);

        int64_t t3 = cv::getTickCount();

        // ВЫВОД
        cv::imshow("test", frame);

        int64_t t4 = cv::getTickCount();

        double dt_read   = (t1 - t0) / freq;   // считывание
        double dt_prc    = (t3 - t2) / freq;   // обработка
        double dt_write  = (t4 - t3) / freq;   // вывод
        double dt_allprc = (t4 - t0) / freq;   // всё вместе (кадр)

        all_processing_time_sum += dt_allprc;
        processing_time_sum     += dt_prc;
        reading_time_sum        += dt_read;
        writing_time_sum        += dt_write;
        frame_count++;

        int key = cv::waitKey(33);
        if (key == 27) { // ESC
            printf("Нажат ESC, выходим\n");
            break;
        }
    }

    int64_t ticks_end = cv::getTickCount();
    double total_time = (ticks_end - ticks_start) / freq;

    printf("Завершение программы\n");
    printf("Всего кадров: %lld\n", frame_count);
    printf("Общее время работы: %.6f сек\n", total_time);
    printf("Суммарное время обработки кадров (read+proc+write): %.6f сек\n",
           all_processing_time_sum);
    printf("Суммарное время ТОЛЬКО обработки: %.6f сек\n",
           processing_time_sum);
    printf("Суммарное время считывания: %.6f сек\n",
           reading_time_sum);
    printf("Суммарное время вывода: %.6f сек\n",
           writing_time_sum);

    // даже если что-то нулевое — всё равно печатаем
    double fps = (total_time > 0.0) ? (frame_count / total_time) : 0.0;

    double all_proc_cpu_share = (total_time > 0.0)
        ? all_processing_time_sum / total_time : 0.0;
    double proc_cpu_share = (total_time > 0.0)
        ? processing_time_sum / total_time : 0.0;
    double read_cpu_share = (total_time > 0.0)
        ? reading_time_sum / total_time : 0.0;
    double write_cpu_share = (total_time > 0.0)
        ? writing_time_sum / total_time : 0.0;

    printf("Средний FPS: %.3f кадров/сек\n", fps);
    printf("Доля времени на всю обработку (read+proc+write): %.2f %%\n",
           all_proc_cpu_share * 100.0);
    printf("Доля времени ТОЛЬКО обработки: %.2f %%\n",
           proc_cpu_share * 100.0);
    printf("Доля времени на считывание: %.2f %%\n",
           read_cpu_share * 100.0);
    printf("Доля времени на вывод (imshow): %.2f %%\n",
           write_cpu_share * 100.0);
    printf("Среднее время ЧИСТОЙ обработки одного кадра: %.3f мс\n",
           (frame_count > 0)
               ? (processing_time_sum / frame_count) * 1000.0
               : 0.0);

    return 0;
}
