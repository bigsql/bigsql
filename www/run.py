# -*- coding: utf-8 -*-
from flask import Flask, render_template, request, redirect

from config import JSON_SETTINGS, add_logging_config


app = Flask(__name__)

app.config["APPLICATION_ROOT"] = JSON_SETTINGS.get('PREFIX','')
app = add_logging_config(app)

app.config['protocol'] = JSON_SETTINGS.get('protocol', 'https')
app.config['download-link'] = JSON_SETTINGS.get('download_link',"http://oscg-downloads.s3.amazonaws.com/")
app.config['TEMPLATES_AUTO_RELOAD'] = True

app.config.from_object(__name__)


def before_request():
    app.jinja_env.cache = {}

app.before_request(before_request)

from werkzeug.contrib.fixers import ProxyFix
app.wsgi_app = ProxyFix(app.wsgi_app, num_proxies=2)

with app.app_context():
    app.logger.error("Server Started")


@app.route('/home')
def test():
    return render_template('home.html', name='home')


@app.route('/')
def home():
    app.logger.info("Remote address : " + request.headers.get('X-Forwarded-For', request.remote_addr))
    return render_template('index.html', name='index')


@app.route('/health_check')
def health_check():
    return render_template('index.html', name='index')


@app.route('/about/')
def about():
    return render_template('about.html', name='about')


@app.route('/forum/')
def forum():
    return render_template('forum.html', name='forum')


@app.route('/cassandra/fdw/')
@app.route('/docs/cassandra/fdw/')
def cassandra_fdw():
    return render_template('cassandra/fdw/index.html', name='cassandraFdw')


@app.route('/components/')
def components():
    return render_template('components.html', name='components')


@app.route('/hadoopfdw/')
@app.route('/docs/hadoopfdw/')
def hadoopfdw():
    return render_template('hadoopfdw/index.html', name='hadoopfdw')

@app.route('/postgresql/installers/')
def postgresql_installer():
    return render_template('postgresql/installers.html', name='postgresqlInstaller')


@app.route('/postgresql/')
@app.route('/oscg_home_download.jsp/')
def postgresql_installer_home():
    return render_template('postgresql/installers.html', name='postgresqlInstallerHome')


@app.route('/pgdevops/')
def pgdevops_home():
    return render_template('pgdevops/index.html', name='pgDevopsHome')


@app.route('/pgha/')
def pgha():
    return render_template('pgha/index.html', name='pgha')


@app.route('/docs/')
def docs():
    return render_template('docs/index.html', name='docs')


@app.route('/docs/security/')
def docs_security():
    return render_template('docs/security/index.html', name='docsSecurity')

@app.route('/docs/sudo/')
def docs_sudo():
    return render_template('docs/sudo/index.html', name='docsSudo')


@app.route('/docs/postgis/postgis/')
def postgis_docs():
    return render_template('docs/postgis/postgis.html', name="docsPostGis")

@app.route('/archive.jsp/')
@app.route('/postgresql/archive-packages/')
def postgis_archive_packages():
    return render_template('postgresql/archive-packages.html', name="postGisArchivePackages")


@app.route('/docs/rpm/')
def docs_rpm():
    return render_template('docs/rpm.html', name="docsRpm")


@app.route('/docs/deb/')
def docs_deb():
    return render_template('docs/deb.html', name="docsDeb")


@app.route('/docs/debugger/')
def docs_debugger():
    return render_template('docs/debugger/index.html', name="docsDebugger")

@app.route('/docs/pgtsql/')
def docs_pgtsql():
    return render_template('docs/pgtsql/index.html', name="docsPgtsql")


@app.route('/pg_background/')
@app.route('/components/pg_background/')
def pg_background():
    return render_template('pg_background/index.html', name="pgBackground")


@app.route('/postgresql/sandboxes/')
@app.route('/postgresql/installers/sandboxes/')
def sandboxes():
    return render_template('postgresql/sandboxes.html', name="sandboxes")


@app.route('/package-manager/')
def package_manager():
    return render_template('package-manager.html', name="packageManager")

@app.route('/upgrade_osx/')
def upgrade_osx():
    return render_template('upgrade_osx/index.html', name="upgradeOsx")


@app.route('/upgrade_linux/')
def upgrade_linux():
    return render_template('upgrade_linux/index.html', name="upgradeLinux")


@app.route('/upgrade_windows/')
def upgrade_windows():
    return render_template('upgrade_windows/index.html', name="upgradeWin")


@app.route('/pgadmin3/')
def pg_admin3():
    return render_template('pgadmin3/index.html', name="pgAdmin3")


@app.route('/pgadmin4/')
def pg_admin4():
    return render_template('pgadmin4/index.html', name="pgAdmin4")


@app.route('/pgcentral/')
def pgcentral():
    return render_template('pgcentral/index.html', name="pgcentral")


@app.route('/patroni/')
def patroni():
    return render_template('patroni/index.html', name="patroni")


@app.route('/news/')
def news():
    return render_template('news/index.html', name="news")


@app.route('/downloads.jsp/')
@app.route('/download/')
@app.route('/postgresql/packages.jsp/')
def download():
    return redirect("postgresql/installers.jsp", code=302)


@app.route('/docs/plprofiler/')
def docs_plprofiler():
    return render_template('docs/plprofiler/profiler.html', name="docsPlProfiler")


@app.route('/docs/profiler/')
def profiler():
    return redirect("docs/plprofiler/", code=302)


@app.route('/docs/accesspg_win/pgcli/pgcli/')
def accesspg_win():
    return redirect("docs/accesspg_win/accesspg_win", code=302)


@app.route('/se/')
def se_home_redirect():
    return redirect('/', code=302)


@app.route('/se/<path:path>')
def se_links_redirect(path):
    return redirect(path, code=302)


@app.route('/<path:path>.jsp/')
def catch_all_jsps(path):
    try:
        if '.' not in path:
            return render_template(path + '.html')
        else:
            return render_template(path)
    except Exception, ex:
        app.logger.error("(404) Page not found path : " + path)
        return render_template('404.html')


@app.route('/<path:path>/')
def catch_all(path):
    try:
        if '.' not in path:
            return render_template(path + '.html')
        else:
            return render_template(path)
    except Exception, ex:
        app.logger.error(str(ex))
    try:
        return render_template(path + '/index.html')
    except Exception, ex:
        app.logger.error(str(ex))
        app.logger.error("(404) Page not found path : " + path)
        return render_template('404.html')


from download_controller import _download


app.register_blueprint(_download)


if __name__ == '__main__':
    app.run(host='0.0.0.0')
