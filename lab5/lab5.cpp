#include <opencv2/opencv.hpp>
#include <iostream>

/*
g++ computerlab5.cpp -o cam -I/usr/include/opencv4 \
  -lopencv_core \
  -lopencv_imgproc \
  -lopencv_highgui \
  -lopencv_videoio
  */

int main() {
    std::cout << "Старт программы\n";

    cv::VideoCapture cap(0);
    if (!cap.isOpened()) {
        std::cerr << "Ошибка: не удалось открыть камеру 0\n";
        return -1;
    }

    std::cout << "Камера успешно открыта\n";

    cv::Mat frame;
    cv::namedWindow("test", cv::WINDOW_AUTOSIZE);

    // ==== ИЗМЕРЕНИЯ ====
    double freq = cv::getTickFrequency();  // тиков в секунду в моем процессоре
    int64_t ticks_start = cv::getTickCount(); // число тиков процессора в момент старта программы
    double processing_time_sum = 0.0; // суммарное время обработки (в секундах)
    long long frame_count = 0;        // количество кадров

    while (true) {
        // ---- начало измерения времени обработки кадра ----
        int64_t t0 = cv::getTickCount();

        cap >> frame;
        if (frame.empty()) {
            std::cerr << "Пустой кадр, выходим\n";
            break;
        }

        // преобразования
        cv::flip(frame, frame, 1);
        cv::cvtColor(frame, frame, cv::COLOR_BGR2GRAY);
        cv::threshold(frame, frame, 128, 255, cv::THRESH_BINARY);

        cv::imshow("test", frame);

        // ---- конец измерения обработки ----
        int64_t t1 = cv::getTickCount();
        double dt = (t1 - t0) / freq;       // время обработки одного кадра (сек)
        processing_time_sum += dt;
        frame_count++;

        // Пауза ожидания клавиши — это уже НЕ обработка, а просто задержка
        int key = cv::waitKey(33);
        if (key == 27) { // ESC
            std::cout << "Нажат ESC, выходим\n";
            break;
        }
    }

    int64_t ticks_end = cv::getTickCount();
    double total_time = (ticks_end - ticks_start) / freq; // всё время работы программы

    std::cout << "Завершение программы\n";
    std::cout << "Всего кадров: " << frame_count << "\n";
    std::cout << "Общее время работы: " << total_time << " сек\n";
    std::cout << "Суммарное время обработки кадров: " << processing_time_sum << " сек\n";

    if (total_time > 0 && frame_count > 0) {
        double fps = frame_count / total_time;
        double cpu_share = processing_time_sum / total_time; // доля времени

        std::cout << "Средний FPS: " << fps << " кадров/сек\n";
        std::cout << "Доля времени на обработку: "
                  << cpu_share * 100.0 << " %\n";
        std::cout << "Среднее время обработки одного кадра: "
                  << (processing_time_sum / frame_count) * 1000.0
                  << " мс\n";
    }

    return 0;
}
