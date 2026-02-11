#include <stdio.h>
#include <stdlib.h>
#include <syslog.h>
#include <fcntl.h>
#include <unistd.h>
#include <string.h>
#include <errno.h>

int main (int argc, char *argv[])
{
    //set syslog
    openlog("writer", LOG_PID, LOG_USER);
    //check nr of arg
    if (argc != 3)
    {
        syslog(LOG_ERR, "Invalid nr of arg: %d", argc-1);
        fprintf(stderr, "Usage : %s <file> <string>\n", argv[0]);
        closelog();
        return 1;
    }
    
    const char *filename = argv[1];
    const char *text = argv[2];
    
    int fd = open(filename, O_WRONLY | O_CREAT | O_TRUNC, 0644);
    if (fd == -1)
    {
        syslog(LOG_ERR, "Error for oppening file: %s: %s", filename, strerror(errno));
        perror("open");
        closelog();
        return 1;
    }
    syslog(LOG_DEBUG, "Writing %s to %s", text, filename);
    
    //write to file
    
    ssize_t nr = write (fd, text, strlen(text));
    if (nr == -1)
    {
        syslog(LOG_ERR, "Error writing to file %s: %s", filename, strerror(errno));
        perror("write");
        close(fd);
        closelog();
        return 1;
    }
    else if (nr != strlen(text))
    {
        syslog(LOG_ERR, "Partial write to %s", filename);
    }
    
    close(fd);
    closelog();
    return 0;
        
        
 }

