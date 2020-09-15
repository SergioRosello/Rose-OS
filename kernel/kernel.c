void main(){
  // Create a pointer to a char and point it to the first text cell of
  // video memory (i.e. the top-left of the screen)
  char *video_memory = (char*) 0xb8000;
  // at the address pointed to by the video_memory, store a character 'X'
  // (i.e. display X on the top-left of the screen)
  *video_memory = 'X';
}
