# checkpasswd.sh
Talking to my lady about strong passwords -- the need for them -- I wanted to show the weakness of some of her passwords.
## bash (not POSIX complient) script to check password against the "Have I been Pwned?" Database

## Usage: 
 + File must be executable: `chmod +x checkpasswd.sh`
 1. Basic usage (prompted for password to check): `./checkpasswd.sh`
 2. Take password as command line argument: `./checkpasswd.sh <PASSWORD>`
 3. Check list of passwords in text file, one per line: `.checkpasswd.sh --file <FILE NAME>`
    + Passwords are not echo'd, line numbers are returned
