FROM node:alpine as builder

# RUN apk update && apk upgrade && apk add --no-cache bash openssh
# RUN apk add --update python krb5 krb5-libs gcc make g++ krb5-dev

RUN mkdir -p /app
WORKDIR '/app'
COPY package*.json ./
RUN npm install
COPY ./ ./
#executing the build that actually compiles the code into a build directory "/app/build" <-- all the stuff we care about for the next phase
RUN npm run build


FROM nginx
#copy from the builder step above for the only directory that we really care about.
COPY --from=builder /app/build /usr/share/nginx/html

#not going to do anything on local desktop, but elasticbeanstalk pays attention to this
EXPOSE 80
