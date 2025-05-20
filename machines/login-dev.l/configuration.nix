{config, pkgs, ...}:

{
  imports = [
    ../../modules/image.nix
    ../../modules/base.nix
    ../../users/root.nix
    ../../users/rescue.nix
    ../../users/login.nix
  ];

  networking.firewall.allowedTCPPorts = [22 80 3000 9100];

  age.secrets."login-dev-internal-secrets" = {
    file = ../../secrets/login-dev-internal-secrets.age;
    mode = "600";
    owner = "login";
    group = "users";
  };

  age.secrets."login-dev-external-secrets" = {
    file = ../../secrets/login-dev-external-secrets.age;
    mode = "600";
    owner = "login";
    group = "users";
  };

  noo.services.login = {
    enable = true;
    clients = [
      {
        client_id = "documentation-test";
        grant_types = ["authorization_code"];
        redirect_uris = [
          "https://dev.login.lpm.feri.um.si/access-control/documentation/static/oauth2-redirect.html"
        ];
        post_logout_redirect_uris = [
          "http://dev.login.lpm.feri.um.si/access-control/documentation/static/oauth2-redirect.html"
        ];
        uuid = "005d2d94-2016-474d-b9e9-e08da12b52bb";
        token_endpoint_auth_method = "none";
        origin = "https://dev.login.lpm.feri.um.si";
      }
      {
        client_id = "documentation-test-local";
        application_type = "native";
        grant_types = ["authorization_code"];
        redirect_uris = [
          "http://localhost:3000/access-control/documentation/static/oauth2-redirect.html"
        ];
        post_logout_redirect_uris = [
          "http://localhost:3000/access-control/documentation/static/oauth2-redirect.html"
        ];
        uuid = "acfd7160-3139-44b1-9c94-1afabbeae815";
        token_endpoint_auth_method = "none";
        origin = "http://localhost:3000";
      }
      {
        client_id = "login-test";
        application_type = "native";
        grant_types = ["authorization_code"];
        redirect_uris = ["si.um.feri.lpm://login-test" "http://localhost:18000"];
        post_logout_redirect_uris = ["si.um.feri.lpm://login-test" "http://localhost:18000"];
        uuid = "6bfc2116-f375-4844-8d60-7c99b7c71f8a";
        token_endpoint_auth_method = "none";
        origin = "http://localhost:18000";
      }
      {
        client_id = "qaferi";
        grant_types = ["authorization_code"];
        redirect_uris = ["https://dev.collab.lpm.feri.um.si"];
        post_logout_redirect_uris = ["https://dev.collab.lpm.feri.um.si"];
        uuid = "3d595412-bbfd-47fb-b42c-55277ac38485";
        token_endpoint_auth_method = "none";
        origin = "https://dev.collab.lpm.feri.um.si";
      }
      {
        client_id = "qaferi-pora";
        grant_types = ["authorization_code"];
        redirect_uris = ["https://pora.collab.lpm.feri.um.si"];
        post_logout_redirect_uris = ["https://pora.collab.lpm.feri.um.si"];
        uuid = "518a653a-7562-4fa7-bf43-2ef3a2c3c961";
        token_endpoint_auth_method = "none";
        origin = "https://pora.collab.lpm.feri.um.si";
      }
      {
        client_id = "qaferi-rri";
        grant_types = ["authorization_code"];
        redirect_uris = ["https://rri.collab.lpm.feri.um.si"];
        post_logout_redirect_uris = ["https://rri.collab.lpm.feri.um.si"];
        uuid = "12112d97-31ea-40c5-bdac-47ab88aa35a6";
        token_endpoint_auth_method = "none";
        origin = "https://rri.collab.lpm.feri.um.si";
      }
      {
        client_id = "qaferi-vr";
        grant_types = ["authorization_code"];
        redirect_uris = ["https://vr.collab.lpm.feri.um.si"];
        post_logout_redirect_uris = ["https://vr.collab.lpm.feri.um.si"];
        uuid = "b76b90ff-ce4d-4ffc-b2ba-e61e9b594019";
        token_endpoint_auth_method = "none";
        origin = "https://vr.collab.lpm.feri.um.si";
      }
      {
        client_id = "qaferi-test2";
        grant_types = ["authorization_code"];
        redirect_uris = ["https://test.collab.lpm.feri.um.si"];
        post_logout_redirect_uris = ["https://test.collab.lpm.feri.um.si"];
        uuid = "b809636a-02b7-4d02-8220-1211f888e4c4";
        token_endpoint_auth_method = "none";
        origin = "https://test.collab.lpm.feri.um.si";
      }
      {
        client_id = "qaferi-rwx";
        grant_types = ["authorization_code"];
        redirect_uris = ["https://collab.lpm.rwx.si"];
        post_logout_redirect_uris = ["https://collab.lpm.rwx.si"];
        uuid = "4ad4d279-f928-4633-acf3-a9bf2ffe419f";
        token_endpoint_auth_method = "none";
        origin = "https://collab.lpm.rwx.si";
      }
      {
        client_id = "qaferi-catalog-dev";
        grant_types = ["authorization_code"];
        redirect_uris = ["https://collab.pmd.lpm.feri.um.si"];
        post_logout_redirect_uris = ["https://collab.pmd.lpm.feri.um.si"];
        uuid = "60c22204-5fe8-4366-8783-17f1d4adbae0";
        token_endpoint_auth_method = "none";
        origin = "https://collab.pmd.lpm.feri.um.si";
      }
      {
        client_id = "catalog-web-feri";
        grant_types = ["authorization_code"];
        redirect_uris = ["https://katalog.krajsa-izobrazevanja.feri.um.si/login"];
        post_logout_redirect_uris = ["https://katalog.krajsa-izobrazevanja.feri.um.si/login"];
        uuid = "53740745-b742-4a68-8340-33eecf863692";
        token_endpoint_auth_method = "none";
        origin = "https://katalog.krajsa-izobrazevanja.feri.um.si/login";
      }
      {
        client_id = "catalog-web";
        grant_types = ["authorization_code"];
        redirect_uris = ["https://catalog.pmd.lpm.feri.um.si/login"];
        post_logout_redirect_uris = ["https://catalog.pmd.lpm.feri.um.si/login"];
        uuid = "75a75d33-0b67-4928-a957-49ab895ed095";
        token_endpoint_auth_method = "none";
        origin = "https://catalog.pmd.lpm.feri.um.si";
      }
      {
        client_id = "catalog-local";
        application_type = "native";
        grant_types = ["authorization_code"];
        redirect_uris = ["http://localhost:18000/login" "si.um.feri.lpm.pmd.catalog://login"];
        post_logout_redirect_uris = ["http://localhost:18000/login" "si.um.feri.lpm.pmd.catalog://login"];
        uuid = "58fc9150-b40c-42b5-b57a-26b19307b7b4";
        token_endpoint_auth_method = "none";
        origin = "http://localhost:18000";
      }
      {
        client_id = "catalog-backend";
        redirect_uris = [];
        response_types = [];
        grant_types = [];
        uuid = "3bee67dc-bcac-4160-99ee-bc3e2aff13a2";
        client_secret = "dXnTKT0qTqZHQxFwMKX5u8wOnyTO7zASgAw0tf4biagaI1aGDy";
        origin = "http://localhost:3000";
      }
      {
        client_id = "qaferi-test";
        redirect_uris = [];
        response_types = [];
        grant_types = [];
        client_secret = "dXnTKT0qTqZHQxFwMKX5u8wOnyTO7zASgAw0tf4biagaI1aGDy";
        uuid = "e0bb2ea3-a105-405d-9d9b-0a6ce02439d3";
        origin = "http://localhost:3000";
      }
      {
        client_id = "grades-backend";
        redirect_uris = [];
        response_types = [];
        grant_types = ["client_credentials"];
        uuid = "59f00876-4ecd-4d52-a30b-c645ce2c0658";
        client_secret = "dXnTKT0qTqZHQxFwMKX5u8wOnyTO7zASgAw0tf4biagaI1aGDy";
        scope = "delegated";
        origin = "http://localhost:3000";
      }
      {
        client_id = "grades-local";
        application_type = "native";
        grant_types = ["authorization_code"];
        redirect_uris = ["http://localhost:18000"];
        post_logout_redirect_uris = ["http://localhost:18000"];
        uuid = "78794601-71e3-424d-b7aa-6d243890c97b";
        token_endpoint_auth_method = "none";
        origin = "http://localhost:18000";
      }
    ];
    profilePictures = {
      enable = true;
      address = "https://dev.login.lpm.feri.um.si";
    };

    service = {
      enable = true;
      address = "https://dev.login.lpm.feri.um.si";
      internalSecretsFile = config.age.secrets.login-dev-internal-secrets.path;
      externalSecretsFile = config.age.secrets.login-dev-external-secrets.path;
    };
    database.enable = true;
  };
}
