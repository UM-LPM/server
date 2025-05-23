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

  age.secrets."collab-client-secret" = {
    file = ../../secrets/collab-client-secret.age;
    mode = "600";
    owner = "login";
    group = "users";
  };

  age.secrets."catalog-client-secret" = {
    file = ../../secrets/grades-client-secret.age;
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
        client_id = "qaferi";
        grant_types = ["authorization_code"];
        redirect_uris = ["https://dev.collab.lpm.feri.um.si"];
        post_logout_redirect_uris = ["https://dev.collab.lpm.feri.um.si"];
        uuid = "3d595412-bbfd-47fb-b42c-55277ac38485";
        token_endpoint_auth_method = "none";
        origin = "https://dev.collab.lpm.feri.um.si";
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
        client_id = "catalog-local";
        application_type = "native";
        grant_types = ["authorization_code"];
        redirect_uris = ["http://localhost:18000/login" "si.um.feri.lpm.pmd.catalog://login"];
        post_logout_redirect_uris = [
          "http://localhost:18000/login"
          "si.um.feri.lpm.pmd.catalog://login"
        ];
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
        client_secret_path = config.age.secrets.catalog-client-secret.path;
        origin = "http://localhost:3000";
      }
      {
        client_id = "qaferi-test";
        redirect_uris = [];
        response_types = [];
        grant_types = [];
        client_secret_path = config.age.secrets.collab-client-secret.path;
        uuid = "e0bb2ea3-a105-405d-9d9b-0a6ce02439d3";
        origin = "http://localhost:3000";
      }
      {
        client_id = "grades-backend";
        redirect_uris = [];
        response_types = [];
        grant_types = ["client_credentials"];
        uuid = "59f00876-4ecd-4d52-a30b-c645ce2c0658";
        client_secret_path = config.age.secrets.grades-client-secret.path;
        scope = "delegated";
        origin = "http://localhost:3000";
      }
      {
        client_id = "grades-local";
        application_type = "native";
        grant_types = ["authorization_code"];
        redirect_uris = ["http://localhost:18000"];
        post_logout_redirect_uris = [
          "http://localhost:18000"
        ];
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
