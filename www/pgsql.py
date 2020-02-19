
def print_header(pWidth):
  print('<center><table><tr><td> \n')

  print('<table height=100 width=' + str(pWidth) + ' border=0 bgcolor=black cellpadding=2> \n' +
        '  <tr> \n' + \
        '    <td width=250><img width=250 src=img/pgsql-io.png /></td> \n' + \
        '    <td width=400><center><font color=whitesmoke>\n' + \
        '     Linux on ARM & AMD<br>&nbsp;<br>\n' + \
        '      <a href=""><font color=whitesmoke>FAQ</font></a>&nbsp;&nbsp;&nbsp;\n' + \
        '      <a href=""><font color=whitesmoke>About Us</font></a>\n' + \
        '    </font></center></td>\n' + \
        '    <td width=425><font size=-1 color=whitesmoke>\n' + \
        '<center><b>Installation Instructions:</b></center>\n' + \
        '<code>BUCKET=https://pgsql-io-download.s3.amazonaws.com<br>\n' + \
        'INSTALLER=$BUCKET/REPO/install.py<br>\n' + \
        'python -c "$(curl -fsSL $INSTALLER)</code>"\n' + \
        '<br>&nbsp;<br>\n' + \
        '<center><b>Usage Instructions:</b></center>\n' + \
        '<code>cd pgsql; ./io info; ./io list; ./io help;\n' + \
        './io install pg11; ./io start pg11;\n'
        './io install all-extensions</code>' + \
        '    </td>\n' + \
        '  </tr>\n' + \
        '</table>\n\n')

 
def print_footer():
  print('&copy; BigSQL 2012-2020, All rights reserved.')
