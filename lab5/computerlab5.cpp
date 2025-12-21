#include <opencv2/opencv.hpp>
#include <iostream>
// g++ computerlab5.cpp -o cam `pkg-config --cflags --libs opencv4`

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
        std::cerr << "Попробуй включить/выключить камеру или сменить индекс (1, 2...)\n";
        return -1;
    }

    std::cout << "Камера успешно открыта\n";

    cv::Mat frame;
    cv::namedWindow("test", cv::WINDOW_AUTOSIZE);

    while (true) {
        cap >> frame;
        if (frame.empty()) {
            std::cerr << "Пустой кадр, выходим\n";
            break;
        }

        cv::flip(frame, frame, 1);

        cv::cvtColor(frame, frame, cv::COLOR_BGR2GRAY);
        cv::threshold(frame, frame, 128, 255, cv::THRESH_BINARY);

        cv::imshow("test", frame);

        int key = cv::waitKey(33);
        if (key == 27) { // ESC
            std::cout << "Нажат ESC, выходим\n";
            break;
        }
    }

    std::cout << "Завершение программы\n";
    return 0;
}
