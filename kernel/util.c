// Copy bytes from one place to another
void memory_copy(char* src, char* dst, int no_bytes){
  for(int i = 0; i < no_bytes; i++){
    *(dst + i) = *(src + i);
  }
}
