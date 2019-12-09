from flask import Blueprint, render_template

_download = Blueprint('_download', __name__, template_folder='templates')


@_download.route('/oscg_download/')
def oscg_download():
    return render_template('oscg_download.html', name="oscgDownload")


@_download.route('/oscg_archive_download/')
def oscg_archive_download():
    return render_template('oscg_download.html', name="oscgDownload")
