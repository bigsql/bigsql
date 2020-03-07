
def print_header(pWidth):
  print("<center>")

  print('<table border=0 bgcolor=black width=' + str(pWidth) + '>\n' +
        '  <tr> \n' + \
        '    <td><img src=img/pgsql-banner5.png /></td> \n' + \
        '  </tr>\n' + \
        '</table>\n\n')

  print("&nbsp;<p>")

  print("<table width=" + str(pWidth) + " cellpadding=2 >")

  print("<tr><td align=right><b>Tested with:</b></td><td>")
  print("Amazon Linux 2, CentOS/RHEL 7+,&nbsp; Ubuntu 16+, &nbsp; " + \
        "and OSX 10.13+")
  print("</td></tr>")

  print("<tr><td></td></tr>")

  print("<tr><td align=right><b>Install command line:</b></td><td>")
  print('<textarea rows=1 cols=100>python3 -c "$(curl -fsSL https://pgsql-io-download.s3.amazonaws.com/REPO/install.py)"</textarea>')
  print("</td></tr>")
  
  print("<tr><td></td></tr>")

  print("<tr><td align=right><b>Usage sample:</b></td><td>")
  print('<textarea rows=1 cols=100>cd pgsql; ./io install pg11; ./io start pg11; ./io install timescaledb-pg11</textarea>') 
  print("</td></tr>")

  print("</table>")

def print_footer():
  print('&copy; 2020, All rights reserved.')
