#include <iostream>
#include <cstdio>
#include <libusb.h>

using namespace std;

void print_device_info(libusb_device *dev);

int main() {
    libusb_context *ctx = nullptr;
    libusb_device **devs = nullptr;

    int r = libusb_init(&ctx);          // инициализация libusb
    if (r < 0) {
        fprintf(stderr, "Ошибка: libusb_init вернул код %d\n", r);
        return 1;
    }

    // по желанию: включить подробные логи
    libusb_set_debug(ctx, 3);

    // получить список устройств
    ssize_t cnt = libusb_get_device_list(ctx, &devs);
    if (cnt < 0) {
        fprintf(stderr, "Ошибка: libusb_get_device_list вернул код %zd\n", cnt);
        libusb_exit(ctx);
        return 1;
    }

    printf("Найдено устройств: %zd\n\n", cnt);
    printf("Класс   Vendor  Product   Серийный номер\n");
    printf("-----   ------  -------   ------------------------------\n");

    for (ssize_t i = 0; i < cnt; ++i) {
        print_device_info(devs[i]);
    }

    libusb_free_device_list(devs, 1);   // освободить список
    libusb_exit(ctx);                   // завершить работу с libusb
    return 0;
}

void print_device_info(libusb_device *dev) {
    libusb_device_descriptor desc;
    int r = libusb_get_device_descriptor(dev, &desc);
    if (r < 0) {
        fprintf(stderr, "Ошибка: не удалось получить дескриптор устройства, код %d\n", r);
        return;
    }

    // печатаем класс, vendor, product
    printf("0x%02x   0x%04x  0x%04x   ",
           desc.bDeviceClass,
           desc.idVendor,
           desc.idProduct);

    // теперь пытаемся вывести серийный номер
    if (desc.iSerialNumber == 0) {
        // у устройства нет серийного номера (или он не указан)
        printf("<серийный номер отсутствует>\n");
        return;
    }

    libusb_device_handle *handle = nullptr;
    r = libusb_open(dev, &handle);
    if (r != 0 || handle == nullptr) {
        // чаще всего сюда попадаем, если нет прав доступа
        printf("<нет доступа к устройству, код %d>\n", r);
        return;
    }

    unsigned char serial[256];
    int len = libusb_get_string_descriptor_ascii(
        handle,
        desc.iSerialNumber,
        serial,
        sizeof(serial)
    );

    if (len > 0) {
        printf("%s\n", serial);
    } else {
        printf("<не удалось прочитать серийный номер, код %d>\n", len);
    }

    libusb_close(handle);
}
