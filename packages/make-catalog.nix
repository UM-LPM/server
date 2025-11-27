{lib, fetchurl}:
{
  catalog,
  revision,
  hash
}:
fetchurl {
  urls = [
    "http://catalog-manage-dev.l:8080/api/catalog/${catalog}?timestamp=${revision}"
    "https://dev.upravljanje-katalog.lpm.feri.um.si/catalog/${catalog}?timestamp=${revision}"
    "http://catalog-manage.l:8080/api/catalog/${catalog}?timestamp=${revision}"
    "https://upravljanje-katalog.lpm.feri.um.si/api/catalog/${catalog}?timestamp=${revision}"
  ];
  inherit hash;
}
