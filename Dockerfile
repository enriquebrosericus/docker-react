FROM node:16-alpine as builder

USER node

RUN mkdir -p /home/node/app

WORKDIR '/home/node/app'

COPY --chown=node:node package.json .
RUN npm install
COPY --chown=node:node . .

#all the assets will be created in build dir
RUN npm run build 


#phase 2 (run)
FROM nginx

COPY --from=builder /home/node/app/build /usr/share/nginx/html

#apparently, we don't even need to start nginx
