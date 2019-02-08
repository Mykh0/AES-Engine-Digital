
  #include <stdint.h>
  #include <assert.h>
  #include <dirent.h>
  #include <fcntl.h>
  #include <stdio.h>
  #include <stdlib.h>
  #include <string.h>
  #include <sys/mman.h>
  #include <unistd.h>
  #include <stddef.h>
  #include <math.h>

  #define MAP_SIZE 4096UL
  #define MAP_MASK (MAP_SIZE -1)
  #define AES_BASE_ADDR 0x70000000
  #define MAX_KEY_SIZE 8
  #define MAX_DATA_SIZE 4
  //this function gets physical address of the memory and
  //gives virtual address which is understandable for the OS
  //through this function we can have directly access to the memory without needing the device drive
  void* getVirtualAddress(int phys_addr)  {
    void* mapped_base;
    int memfd;
    void* mapped_dev_base;
    off_t dev_base = phys_addr;

    memfd = open("/dev/mem", O_RDWR | O_SYNC);

    if (memfd ==  -1) {
    printf("can't open /dev/mem\n");
    exit(0);
    }

    mapped_base = mmap(0, MAP_SIZE, PROT_READ | PROT_WRITE, MAP_SHARED, memfd, dev_base & ~MAP_MASK);

    if(mapped_base == (void*) -1) {
      printf("can't map the memory to user space.\n");
      exit(0);
    }

    mapped_dev_base =  mapped_base + (dev_base & MAP_MASK);
    return mapped_dev_base;
  }

  static char * readFile(char* systemPath)
  {
    int size = 3024;
    int fileread = open(systemPath, O_RDONLY);
    void *buffer;

    buffer = malloc(sizeof(void) * size);
    read(fileread, buffer, size);
    close(fileread);
    return buffer;
  }
 
/*
* [decrypt/encrypt] [key_length] [Key] [Data]
* [decrypt/encrypt] 0 eccrypt
*                   1 decrypt
* [key_length]  0 128-bit
*               1 192-bit
*               2 256-bit
*               3 reserved
*/ 
  int main(int argc, char **argv) {
    int* aes = getVirtualAddress(AES_BASE_ADDR);
    int encryptSelect, keyLength, i, j, k, l;
    uint32_t key[MAX_KEY_SIZE], data[MAX_DATA_SIZE], control, dataOut[MAX_DATA_SIZE];
    char keyBuffer[300], dataBuffer[300];

    char dataList[5][8] =
    {
      {0, 0}
    };

    char keyList[9][8] = 
    {
      {0, 0}
    };

    encryptSelect = (int)strtol(argv[1], NULL, 2);
    keyLength = (int)strtol(argv[2], NULL, 2);
    printf("EncryptSelect: %d\n", encryptSelect);
    printf("KeyLength: %d\n", keyLength);
    sprintf(keyBuffer, "%s\n", argv[3]);
    sprintf(dataBuffer, "%s\n", argv[4]);
// Seems to copy the initial value (which wouln't even fit) the keyList array
    for(i = 0; i < 8; i++) {  
      for(j = 0; j < 8; j++) {
        keyList[i][j] = keyBuffer[j + i * 8];
      }
      printf("Key hex %d: %s\n", i, keyList[i]);
      key[i] = (uint32_t)strtoul(keyList[i], NULL, 16);
      printf("Key int: %u\n", key[i]);
    }

    for (k = 0; k < 4; k++) {
      for (l = 0; l < 8; l++) {
        dataList[k][l] = dataBuffer[l + k * 8];
      }
      data[k] = (uint32_t)strtoul(dataList[k], NULL, 16);
      printf("Data hex %d: %s\n", k, dataList[k]);
      printf("Data integer: %u\n", data[k]);
    }

    control |= keyLength << 0;
    control |= encryptSelect << 2;
    control |= 1 << 3;

    (*(unsigned *) (aes + 0)) =  data[3];
    (*(unsigned *) (aes + 1)) =  data[2];
    (*(unsigned *) (aes + 2)) =  data[1];
    (*(unsigned *) (aes + 3)) =  data[0];
    (*(unsigned *) (aes + 4)) =  key[4];
    (*(unsigned *) (aes + 5)) =  key[5];
    (*(unsigned *) (aes + 6)) =  key[6];
    (*(unsigned *) (aes + 7)) =  key[7];
    (*(unsigned *) (aes + 8)) =  key[8];
    (*(unsigned *) (aes + 9)) =  key[9];
    (*(unsigned *) (aes + 10)) = key[10];
    (*(unsigned *) (aes + 11)) = key[11];
    (*(unsigned *) (aes + 16)) = control;
    control |= 0 << 3;
    dataOut[0] = (*(unsigned *) (aes + 12));
    dataOut[1] = (*(unsigned *) (aes + 13));
    dataOut[2] = (*(unsigned *) (aes + 14));
    dataOut[3] = (*(unsigned *) (aes + 15)); 
    (*(unsigned *) (aes + 16)) = control;
    printf("Result\n\n%x%x%x%x\n\n", dataOut[3], dataOut[2], dataOut[1], dataOut[0]);
    return 0;
  }