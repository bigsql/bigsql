
def print_header(pWidth):
  print('<center><table><tr><td> \n')

  print('<table height=100 width=' + str(pWidth) + ' border=0 bgcolor=black cellpadding=2> \n' +
        '  <tr> \n' + \
        '    <td><img width=325 src=img/pgsql-banner.png /></td> \n' + \
        '    <td width=375><center><font color=whitesmoke>\n' + \
        '     Linux on ARM & AMD plus OSX & Windows<br>&nbsp;<br>\n' + \
        '      <a href=""><font color=whitesmoke>FAQ</font></a>&nbsp;&nbsp;&nbsp;\n' + \
        '      <a href=""><font color=whitesmoke>About Us</font></a>\n' + \
        '    </font></center></td>\n' + \
        '    <td width=400><font size=-1 color=whitesmoke>\n' + \
        '<center><b>Installation Instructions:</b></center>\n' + \
        '<code>BUCKET=https://bigsql-apg-download.s3.amazonaws.com<br>\n' + \
        'INSTALLER=$BUCKET/REPO/install.py<br>\n' + \
        'python -c "$(curl -fsSL $INSTALLER)</code>"\n' + \
        '<br>&nbsp;<br>\n' + \
        '<center><b>Usage Instructions:</b></center>\n' + \
        '<code>cd bigsql; ./apg info; ./apg list; ./apg help;\n' + \
        './apg install pg11; ./apg start pg11;\n'
        './apg install all-extensions</code>' + \
        '    </td>\n' + \
        '  </tr>\n' + \
        '</table>\n\n')

 
def print_footer():
  print('&copy; BigSQL 2012-2020, All rights reserved.')
