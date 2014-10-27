#include <iostream>

int main(int argc, char **argv) {
    // std::cout << "Hello world!" << std::endl;
    std::string hello = ((std::string)"Hello") + ' ' + "world!";
    std::cout << hello << std::endl;
    return 0;
}

