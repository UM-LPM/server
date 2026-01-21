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

  age.secrets."login-internal-secrets" = {
    file = ../../secrets/login-internal-secrets.age;
    mode = "600";
    owner = "login";
    group = "users";
  };

  age.secrets."login-external-secrets" = {
    file = ../../secrets/login-external-secrets.age;
    mode = "600";
    owner = "login";
    group = "users";
  };

  age.secrets."collab-client-secret" = {
    file = ../../secrets/collab-client-secret.age;
    mode = "600";
    owner = "login";
    group = "users";
  };

  age.secrets."catalog-client-secret" = {
    file = ../../secrets/catalog-client-secret.age;
    mode = "600";
    owner = "login";
    group = "users";
  };

  age.secrets."grades-client-secret" = {
    file = ../../secrets/grades-client-secret.age;
    mode = "600";
    owner = "login";
    group = "users";
  };

  age.secrets."grades-dev-client-secret" = {
    file = ../../secrets/grades-dev-client-secret.age;
    mode = "600";
    owner = "login";
    group = "users";
  };

  noo.services.login = {
    enable = true;

    clients = [
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
        client_id = "qaferi-rsasm";
        grant_types = ["authorization_code"];
        redirect_uris = ["https://rsasm.collab.lpm.feri.um.si"];
        post_logout_redirect_uris = ["https://rsasm.collab.lpm.feri.um.si"];
        uuid = "f9393531-919c-4a66-a58e-3eb88566e36d";
        token_endpoint_auth_method = "none";
        origin = "https://rsasm.collab.lpm.feri.um.si";
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
        origin = "https://katalog.krajsa-izobrazevanja.feri.um.si";
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
        client_id = "catalog-web-scms";
        grant_types = ["authorization_code"];
        redirect_uris = ["https://upravljanje-katalog.lpm.feri.um.si/login"];
        post_logout_redirect_uris = [
          "https://upravljanje-katalog.lpm.feri.um.si/login"
        ];
        uuid = "0dad4170-2024-4a96-badb-7a80f9bb42f8";
        token_endpoint_auth_method = "none";
        origin = "https://upravljanje-katalog.lpm.feri.um.si";
      }
      {
        client_id = "catalog-web-scms-um";
        grant_types = ["authorization_code"];
        redirect_uris = ["https://upravljanje-katalog.um.si/login"];
        post_logout_redirect_uris = [
          "https://upravljanje-katalog.um.si/login"
        ];
        uuid = "646e4dac-0f9a-4788-88f0-bc216fa5152a";
        token_endpoint_auth_method = "none";
        origin = "https://upravljanje-katalog.um.si";
      }
      {
        client_id = "catalog-web-scms-dev";
        grant_types = ["authorization_code"];
        redirect_uris = ["https://dev.upravljanje-katalog.lpm.feri.um.si/login"];
        post_logout_redirect_uris = [
          "https://dev.upravljanje-katalog.lpm.feri.um.si/login"
        ];
        uuid = "f1bbc2c4-cd90-4614-8ca8-32199aefb879";
        token_endpoint_auth_method = "none";
        origin = "https://dev.upravljanje-katalog.lpm.feri.um.si";
      }
      {
        client_id = "catalog-backend";
        redirect_uris = [];
        response_types = [];
        grant_types = [];
        uuid = "3bee67dc-bcac-4160-99ee-bc3e2aff13a2";
        client_secret_path = config.age.secrets.catalog-client-secret.path;
      }
      {
        client_id = "qaferi-backend";
        redirect_uris = [];
        response_types = [];
        grant_types = [];
        client_secret_path = config.age.secrets.collab-client-secret.path;
        uuid = "e0bb2ea3-a105-405d-9d9b-0a6ce02439d3";
      }
      {
        client_id = "grades-backend";
        redirect_uris = [];
        response_types = [];
        grant_types = ["client_credentials"];
        uuid = "59f00876-4ecd-4d52-a30b-c645ce2c0658";
        client_secret_path = config.age.secrets.grades-client-secret.path;
        scope = "delegated";
      }
      {
        client_id = "grades-dev-backend";
        redirect_uris = [];
        response_types = [];
        grant_types = ["client_credentials"];
        uuid = "b07f4e69-f5d8-4182-9049-7eab38ce4a20";
        client_secret_path = config.age.secrets.grades-dev-client-secret.path;
        scope = "delegated";
      }
      {
        client_id = "catalog-local";
        application_type = "native";
        grant_types = ["authorization_code"];
        redirect_uris = [
          "http://localhost:18000/login"
          "si.um.feri.lpm.pmd.catalog://login"
        ];
        post_logout_redirect_uris = [
          "http://localhost:18000/login"
          "si.um.feri.lpm.pmd.catalog://login"
        ];
        uuid = "58fc9150-b40c-42b5-b57a-26b19307b7b4";
        token_endpoint_auth_method = "none";
        origin = "http://localhost:18000";
      }
      {
        client_id = "catalog-manage";
        grant_types = ["authorization_code"];
        redirect_uris = [
          "https://upravljanje-katalog.lpm.feri.um.si"
        ];
        post_logout_redirect_uris = [
          "https://upravljanje-katalog.lpm.feri.um.si"
        ];
        uuid = "ef82d04b-0b3e-4201-b1ce-57376317cde2";
        token_endpoint_auth_method = "none";
        origin = "https://upravljanje-katalog.lpm.feri.um.si";
      }
      {
        client_id = "catalog-manage-local";
        application_type = "native";
        grant_types = ["authorization_code"];
        redirect_uris = [
          "http://localhost:18000"
        ];
        post_logout_redirect_uris = [
          "http://localhost:18000"
        ];
        uuid = "f05e6b2f-1326-4a8b-881d-21f9d6844b76";
        token_endpoint_auth_method = "none";
        origin = "http://localhost:18000";
      }
      {
        client_id = "grades";
        application_type = "native";
        grant_types = ["authorization_code"];
        redirect_uris = [
          "https://grades.lpm.feri.um.si/auth.html"
          "si.um.feri.lpm.grades://oauthredirect"
          "https://login.lpm.feri.um.si/app/grades"
        ];
        post_logout_redirect_uris = [
          "https://grades.lpm.feri.um.si/auth.html"
          "si.um.feri.lpm.grades://oauthredirect"
        ];
        uuid = "7384a521-1dd3-4e0a-84d0-26917b33ec1c";
        token_endpoint_auth_method = "none";
        origin = "https://grades.lpm.feri.um.si";
      }
      {
        client_id = "grades-dev";
        application_type = "native";
        grant_types = ["authorization_code"];
        redirect_uris = [
          "https://dev.grades.lpm.feri.um.si/auth.html"
          "si.um.feri.lpm.grades://oauthredirect"
          "https://login.lpm.feri.um.si/app/grades"
        ];
        post_logout_redirect_uris = [
          "https://dev.grades.lpm.feri.um.si/auth.html"
          "si.um.feri.lpm.grades://oauthredirect"
        ];
        uuid = "7384a521-1dd3-4e0a-84d0-26917b33ec1c";
        token_endpoint_auth_method = "none";
        origin = "https://dev.grades.lpm.feri.um.si";
      }
      {
        client_id = "grades-local";
        application_type = "native";
        grant_types = ["authorization_code"];
        redirect_uris = ["http://localhost:18000/auth.html" "si.um.feri.lpm.grades://oauthredirect"];
        post_logout_redirect_uris = [
          "http://localhost:18000/auth.html"
        ];
        uuid = "78794601-71e3-424d-b7aa-6d243890c97b";
        token_endpoint_auth_method = "none";
        origin = "http://localhost:18000";
      }
    ];

    profilePictures = {
      enable = true;
      address = "https://login.lpm.feri.um.si";
    };

    service = {
      enable = true;
      address = "https://login.lpm.feri.um.si";
      internalSecretsFile = config.age.secrets.login-internal-secrets.path;
      externalSecretsFile = config.age.secrets.login-external-secrets.path;
    };
    database.enable = true;
  };
}
