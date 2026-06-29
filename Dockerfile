FROM dart:3.12

WORKDIR /app

COPY . .

RUN dart pub get

CMD ["dart","run","bin/track.dart"]