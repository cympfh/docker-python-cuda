TAG := cympfh/python-cuda:3.6.9-10
build:
	docker build -t $(TAG) .

test:
	docker run --rm $(TAG) ls /usr/local/cuda-10.0/targets/x86_64-linux/lib/libcublas.so.10.0
	docker run --rm $(TAG) ls /usr/lib/x86_64-linux-gnu/libcudnn.so.7
	docker run --rm -it $(TAG) bash -c '[ "$$(python --version)" == "Python 3.6.9" ]'
	docker run --rm $(TAG) which pip

test-gpu: test
	docker run --gpus all --rm $(TAG) nvidia-smi
