#include <opencv2/opencv.hpp>
#include <iostream>
// g++ computerlab5.cpp -o cam `pkg-config --cflags --libs opencv4`
int main() {
    std::cout << "Старт программы\n";

    // Попробуем такой конструктор (на Windows иногда помогает CAP_DSHOW)
    cv::VideoCapture cap(0, cv::CAP_DSHOW);
    if (!cap.isOpened()) {
        std::cerr << "Ошибка: не удалось открыть камеру 0\n";
        std::cerr << "Попробуй включить/выключить камеру или сменить индекс (1, 2...)\n";
        std::cin.get(); // чтобы окно консоли не закрывалось сразу
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
