FROM alpine:latest

# install golang (just copy files... so easy things go in golang world)
COPY --from=golang:1.15-alpine /usr/local/go/ /usr/local/go/
ENV PATH="/usr/local/go/bin:${PATH}"

# install all the stuff
RUN apk add -U --no-cache vim curl git bash ruby ruby-json ruby-etc nodejs npm
RUN gem install rubocop rubocop-performance rubocop-rails rubocop-rspec rubocop-faker
RUN npm install eslint babel-eslint eslint-plugin-react escope -g


# If docker installed not in rootlestt mode:
# Add group and user on whos behalf vim will be run.
# The user and group ids should be the same as the
# user and group ids on the host OS
# RUN addgroup --gid 1000 vimide
# RUN adduser -D -G "" -u 1000 -G vimide editor

# will be the workdir and the preferable point to mount volumes
WORKDIR /vimide/mnt
# RUN chown editor:vimide .

# If docker installed not in rootlestt mode:
# switch to the main user
# USER editor

# install vim plugins
RUN mkdir /root/.vim
RUN curl -fLo /root/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
COPY colors /root/.vim/colors
COPY vimrc /root/.vim
RUN vim +PlugInstall +qall >> /dev/null
COPY .eslintrc.json /root

#CMD ["echo", "hello"]
