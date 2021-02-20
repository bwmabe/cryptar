# cryptar
a  gpg and tar wrapperer for making encrypted archives, rawr

## Why
I like to create encrypted `.tar.gz` archives to transport things like private
ssh keys or other sensitive information over channels that I don't 100% trust.
e.g. email, cloud services, physical flash drives, etc

## Future Plans
	* Make this more feature-y? Like proper argument handling!
	* Maybe turn it into a "real" package somehow?

## Usage
```
usage: cryptar.sh COMMAND [ARGS...]"
    decrypt: cryptar.sh dec FILE [DEST]"
    encrypt: cryptar.sh enc ARCHIVE_NAME FILE_1 [FILE_2, ... FILE_N]"
    list   : cryptar.sh ls FILE"
```
