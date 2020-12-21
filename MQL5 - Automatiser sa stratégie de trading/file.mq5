//+----------------------------------------------------------------------------------+
//|                                                                         file.mq5 |
//|                                       https://github.com/victor-algo/channel.git |
//|                         https://www.youtube.com/channel/UCmpooeG7KV1pgHFIkG5mJfA |
//+----------------------------------------------------------------------------------+

void OnInit(){
   
   writeFile();
   readFile();

}

void writeFile(){

   int fileHandle = FileOpen("test.txt", FILE_WRITE|FILE_COMMON);
   
   if(fileHandle != INVALID_HANDLE){
      
      for(int i = 0; i <10; i += 1){
      
         FileWrite(fileHandle, (string)i);
      
      }
   }
   
  FileClose(fileHandle);
   
}


void readFile(){

   int fileHandle = FileOpen("test.txt", FILE_READ|FILE_COMMON);

   if(fileHandle != INVALID_HANDLE){

      while(!FileIsEnding(fileHandle)){
 
         string row = FileReadString(fileHandle);
         Print(row);
        
      }
   }
   
   FileClose(fileHandle);
   
}