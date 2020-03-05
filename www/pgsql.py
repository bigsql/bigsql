
def print_header(pWidth):
  print('<center><table><tr><td> \n')

  print('<table height=100 width=' + str(pWidth) + ' border=0 bgcolor=black cellpadding=2> \n' +
        '  <tr> \n' + \
        '    <td width=250><img width=250 src=img/pgsql-banner.png /></td> \n' + \
        '    <td width=375><center><font color=whitesmoke>\n' + \
        '     Linux on ARM & AMD,<br>plus a bit of OSX!<br>\n' + \
        '    </font></center></td>\n' + \
        '    <td width=400><font size=-1 color=whitesmoke>\n' + \
        '<center><b>Installation Instructions:</b></center>\n' + \
        '<code>REPO=https://pgsql-io-download.s3.amazonaws.com/REPO/<br>\n' + \
        'python -c "$(curl -fsSL $REPO/install.py)</code>"\n' + \
        '<br>&nbsp;<br>\n' + \
        '<center><b>Usage Instructions:</b></center>\n' + \
        '<code>cd pgsql;\n' + \
        './io install pg11; ./io start pg11;<br>\n'
        './io install timescaledb-pg11</code>' + \
        '    </td>\n' + \
        '  </tr>\n' + \
        '</table>\n\n')

  print("&nbsp;<br>Presently tested for" + \
        " <b>1)</b> Linux on EL7/EL8,&nbsp; Amazon Linux 2,&nbsp; and Ubuntu 16.04/18.04 &nbsp;&nbsp;" + \
        " <b>2)</b> OSX on High Sierra 10.13 and newer")

 
def print_footer():
  print('&copy; BigSQL 2020, All rights reserved.')
