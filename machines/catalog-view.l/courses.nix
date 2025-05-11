{fetchurl}:
let
  revision = builtins.readFile ./revision;
in
fetchurl {
  urls = [
    "http://catalog-manage.l:8080/api/course/short-courses/3b88bf36-eb8b-4c9f-bd29-545451665e87?timestamp=${revision}"
    "https://scms.catalog.lpm.rwx.si/vse/api/course/short-courses/3b88bf36-eb8b-4c9f-bd29-545451665e87?timestamp=${revision}"
  ];
  hash = "sha256-dDXsCEmmWr4bMmLUvAhMkVNHs1FW8nZRPEZeNZ7aSos=";
}
