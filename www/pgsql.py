
def print_header(pWidth):
  print("<title>PostgreSQL Community Edition</title>")

  print("<center>")


  print('<table border=0 bgcolor=black cellpadding=0 width=' + str(pWidth) + '>\n' +
        '  <tr> \n' + \
        '    <td><img src=img/pgsql-banner5.png /></td> \n' + \
        '  </tr>\n' + \
        '</table>\n\n')

  print("<table bgcolor=whitesmoke width=" + str(pWidth) + " cellpadding=0 >")
  string = \
"""\
PGSQL.IO is the developer friendly cross-platform PostgreSQL Community Edition
that fully embraces core PostgreSQL and it's rich eco-system of over
50 enterprise-class extensions, applications & connectors.
Recently we have added support for ARM,
OSX, and Windows; added to our AMD Linux support to include Ubuntu & Debian;
optimized for Docker and Kubernetes; and made
our selection of components much more complete, up to date and accurate.
\
"""
  print("<tr><td colspan=2>&nbsp;<br><font size=+2><b><u>Introduction</u></b></font><p>" + \
    string + "<br>&nbsp;</td></tr>")
  print("</table>")


  print("<table bgcolor=white width=" + str(pWidth) + " cellpadding=1 >")
  print("<tr><td colspan=2>&nbsp;<br><font size=+2><b><u>Download & Usage</u></b></font><p>")
  print("We are verfied & tested with: Python 2.7, Amazon Linux 2, CentOS/RHEL 7+, Ubuntu 16+, \n" + \
        "Debian 9+, Windows 10 Subsytem for Linux, and OSX 10.13+ &nbsp; \n" + \
        "We run in a sandboxed environment that is perfect for running as non-root \n" + \
        "in your development evironment and in a containerized environment \n" + \
        "in the public, private or hybrid cloud of your choice.")
  print("<br>&nbsp;</td></tr>")

  print("<tr><td align=right><b>Install command line:</b></td><td>")
  print("<input type='text' size=80 value ='" + \
        'python3 -c "$(curl -fsSL https://pgsql-io-download.s3.amazonaws.com/REPO/install.py)"' + \
        "' readonly='readonly'>")
  print("</td></tr>")

  print("<tr><td>&nbsp;</td></tr>")
  
  print("<tr><td align=right><p><b>Usage sample:</b></td><td>")
  print("<input type='text' size=80 value ='" + \
        'cd pgsql; ./io install pg11; ./io start pg11; ./io install timescale' + \
        "' readonly='readonly'>")
  print("</td></tr>")

  print("</table>")


def print_footer():
  print('<center><table><tr> \n' + \
        '   <td width=450>&copy; 2020, All rights reserved.</td> \n' + \
        '   <td width=450 align=right>denis@lussier.io</td> \n' + \
        '</tr></table></center>')
