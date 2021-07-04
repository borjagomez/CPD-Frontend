run:
	yarn serve

deploy:
	yarn build
	gcloud app deploy --quiet