// Copy bytes from one place to another
void memory_copy(unsigned char* src, unsigned char* dst, int no_bytes){
  for(int i = 0; i < no_bytes; i++){
    *(dst + i) = *(src + i);
  }
}
