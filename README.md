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

# Notes and Ideas

## IDEA: Rust Implementation
The goal of the proposed Rust implementation would be to replace the shell script parts with Rust code and libraries. Instead of a `bash` script wrapping `gpg` and `tar`; it would be a single binary that create an encrypted `tar` archive that is compatible with `gpg` and `tar`; but maybe not this script. 

### Rust Libraries to Use
* tar
* openssl
* std

### Maybe Scrap Backwards Compatiblity With the Script?
For the Rust implementation

## IDEA: `.rawr` file format
`.rawr` files will consist of multiple parts; a (possibly) unencrypted header, and a definitely encrypted rest of the file. The header will be of some yet-to-be-determined size to store what cipher was used for automatic cipher detection. The cipher might be obfuscated in some way to prevent cryptanalysis of the rest of the file. 

### Possible Structure of a `.rawr` file
	* Header detailing the cipher used for the body
	* Body containing data encrypted by the cipher defined in the header

### Other `.rawr` Idea
Have the header encrypted using a cipher that CANNOT be user-defined like the body cipher. 

The header will be encrypted with a user-defined key. 

The header will contain a region that indicates what cipher was used to encrypt the body; and the key for the body.

The body will be encrypted using a user-defined cipher and a large secondary key.

*Maybe nested encrypted containers of arbitrary depth???*

## Links That I Might Find Useful In the Future
	* [openssl:symm](https://docs.rs/openssl/0.10.32/openssl/symm/index.html)
