
def print_header(pWidth):
  print("<title>PGSQL-IO: PostgreSQL Distro</title>")

  print("<center>")


  print('<table border=0 bgcolor=black width=' + str(pWidth) + '>\n' +
        '  <tr> \n' + \
        '    <td><img src=img/pgsql-banner5.png /></td> \n' + \
        '  </tr>\n' + \
        '</table>\n\n')

  print("<table bgcolor=white width=" + str(pWidth) + " cellpadding=1 >")

  print("<tr><td colspan=2>&nbsp;<br><font size=+2><b>Introduction</b></font><p>" + \
"PGSQL-IO is the next generation of BigSQL.  We have added support for ARM and \n" + \
"OSX; optimized for Docker and K8's; and made \n" + \
"our selection of components much more complete and accurate. \n" + \
"<br>&nbsp;</td></tr>")

  print("<tr><td width=175 align=right><b>Tested with:</b></td><td width=725>")
  print("Python 2.7+, Amazon Linux 2, CentOS/RHEL 7+,&nbsp; Ubuntu 16+, &nbsp; " + \
        "and OSX 10.13+")
  print("</td></tr>")

  print("<tr><td></td></tr>")

  print("<tr><td align=right><b>Install command line:</b></td><td>")
  print('<textarea readonly rows=1 cols=90>python3 -c "$(curl -fsSL https://pgsql-io-download.s3.amazonaws.com/REPO/install.py)"</textarea>')
  print("</td></tr>")
  
  print("<tr><td></td></tr>")

  print("<tr><td align=right><b>Usage sample:</b></td><td>")
  print('<textarea readonly rows=1 cols=90>cd pgsql; ./io install pg11; ./io start pg11; ./io install timescaledb-pg11</textarea>') 
  print("</td></tr>")

  print("</table>")


def print_footer():
  print('&copy; 2020, All rights reserved.')
