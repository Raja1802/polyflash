FROM node:16.14

WORKDIR /app

ENV NODE_ENV=production
COPY package.json .
RUN yarn set version berry
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update -qq && apt-get install -y yarn

COPY .yarn tsconfig.json .yarnrc.yml /
RUN yarn install
COPY . ./
RUN yarn build
EXPOSE $PORT
#CMD [ "node", "dist/index.js" ] -p $PORT

#CMD ["npm", "run", "start"] --port $PORT
CMD yarn start
USER node
