containername = centos7sshdtest
imagename = backuppc:latest
hostport = 4444

clean:
	- sudo docker kill $(containername)
	- sudo docker rm $(containername)

build:
	sudo docker build -t $(imagename) .

run: clean build
	sudo docker run -d -p $(hostport):22 --name $(containername) $(imagename)

enter: run
	sudo docker exec -it $(containername) bash
