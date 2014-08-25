FROM busybox:latest
VOLUME ["/test1"]
VOLUME ["/test2"]
RUN ["/bin/touch", "/test1/empty-file1"]
RUN ["/bin/touch", "/test2/empty-file2"]
