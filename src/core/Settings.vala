namespace LAview.Core {

	public class AppSettings {
		Settings settings;

		string _lyx_path;
		string _latexmk_pl_path;
		string _perl_path;
		string[] _templates_strv;

		public string lyx_path {
			get { return _lyx_path; }
			set {
				if (settings != null) settings.set_string ("lyx-path", value);
				_lyx_path = value;
			}
			default = "lyx";
		}

		public string latexmk_pl_path {
			get { return _latexmk_pl_path; }
			set {
				if (settings != null) settings.set_string ("latexmk-pl-path", value);
				_latexmk_pl_path = value;
			}
			default = "latexmk";
		}

		public string perl_path {
			get { return _perl_path; }
			set {
				if (settings != null) settings.set_string ("perl-path", value);
				_perl_path = value;
			}
			default = "perl";
		}

		public string[] templates {
			get { return _templates_strv; }
			set {
				if (settings != null) settings.set_strv("templates", _templates_strv);
				_templates_strv = value;
			}
		}

		public AppSettings () throws Error {
			string schema_file = AppDirs.settings_dir+"/gschemas.compiled";
			if (!File.new_for_path (schema_file).query_exists ())
				throw new IOError.NOT_FOUND ("File "+schema_file+" not found");
			SettingsSchemaSource sss = new SettingsSchemaSource.from_directory (AppDirs.settings_dir, null, false);
			string schema_name = "ws.backbone.laview.core-"+Config.VERSION_MAJOR.to_string();
			SettingsSchema schema = sss.lookup (schema_name, false);
			if (schema == null) {
				throw new IOError.NOT_FOUND ("Schema "+schema_name+" not found in "+schema_file);
			}
			settings = new Settings.full (schema, null, null);

			_lyx_path = settings.get_string("lyx-path");
			settings.changed["lyx-path"].connect (() => {
				_lyx_path = settings.get_string("lyx-path");
			});
			_latexmk_pl_path = settings.get_string("latexmk-pl-path");
			settings.changed["latexmk-pl-path"].connect (() => {
				_latexmk_pl_path = settings.get_string("latexmk-pl-path");
			});
			_perl_path = settings.get_string("perl-path");
			settings.changed["perl-path"].connect (() => {
				_perl_path = settings.get_string("perl-path");
			});

		}
	}
}