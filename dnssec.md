# Utilização do dnssec

Gerar as chaves:
```
dnssec-keygen -r /dev/urandom -f KSK -a RSASHA1 -b 1024 -n ZONE dominio.com.br
```

Assinar o domínio:

```
dnssec-signzone -S -z -o dominio.com.br db.dominio.com.br
```

Atualizar o named.conf:

```
zone "dominio.com.br" {
type master;
file "/etc/namedb/db.dominio.com.br.signed";
...
};
```

```
dnssec-keygen -a alg -b bits [-n type] [options] name
```


      -a algorithm: RSA | RSAMD5 | DH | DSA | RSASHA1 | HMAC-MD5 | HMAC-SHA1 | HMAC-SHA224 | HMAC-SHA256 |  HMAC-SHA384 | HMAC-SHA512
      -b key size, in bits:
          RSAMD5: [512..4096]
          RSASHA1: [512..4096]
          DH: [128..4096]
          DSA: [512..1024] and divisible by 64
          HMAC-MD5: [1..512]
          HMAC-SHA1: [1..160]
          HMAC-SHA224: [1..224]
          HMAC-SHA256: [1..256]
          HMAC-SHA384: [1..384]
          HMAC-SHA512: [1..512]
      -n nametype: ZONE | HOST | ENTITY | USER | OTHER
          (DNSKEY generation defaults to ZONE
      name: owner of the key

  Outras opções:

      -c <class> (default: IN)
      -d <digest bits> (0 => max, default)
      -e use large exponent (RSAMD5/RSASHA1 only)
      -f keyflag: KSK
      -g <generator> use specified generator (DH only)
      -t <type>: AUTHCONF | NOAUTHCONF | NOAUTH | NOCONF (default: AUTHCONF)
      -p <protocol>: default: 3 [dnssec]
      -s <strength> strength value this key signs DNS records with (default: 0)
      -r <randomdev>: a file containing random data
      -v <verbose level>
      -k : generate a TYPE=KEY key

  Na saída do comando deverá ter os seguintes arquivos:

      K<name>+<alg>+<id>.key, K<name>+<alg>+<id>.private

Usage:

```
 dnssec-signzone [options] zonefile [keys]
```

```
Options: (default value in parenthesis)
   -c class (IN)
   -d directory
   directory to find keyset files (.)
   -g: generate DS records from keyset files
   -s [YYYYMMDDHHMMSS|+offset]:
   RRSIG start time - absolute|offset (now - 1 hour)
   -e [YYYYMMDDHHMMSS|+offset|"now"+offset]:
   RRSIG end time  - absolute|from start|from now (now + 30 days)
   -i interval:
   cycle interval - resign if < interval from end ( (end-start)/4 )
   -j jitter:
   randomize signature end time up to jitter seconds
   -v debuglevel (0)
   -o origin:
   zone origin (name of zonefile)
   -f outfile:
   file the signed zone is written in (zonefile + .signed)
   -I format:
```

