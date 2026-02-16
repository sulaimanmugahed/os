{...}:{
  virtualisation.docker.enable = true;


  virtualisation.oci-containers = {
    backend = "docker";
    containers = {
      postgres = {
        autoStart = true;
        image = "postgres:16";
        ports = [ "5432:5432" ];
        environment = {
          POSTGRES_USER = "postgres";
          POSTGRES_PASSWORD = "postgres";
        };
        volumes = [
          "/var/lib/postgres-data:/var/lib/postgresql/data"
        ];

      };
    };

  };
}