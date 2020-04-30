
def print_header(pWidth):
  print("<title>PGSQL: PostgreSQL Community Edition</title>")

  print("<center>")

  print('<table border=0 bgcolor=black cellpadding=0 width=' + str(pWidth) + '>\n' +
        '  <tr> \n' + \
        '    <td><img src=img/pgsql-banner6.png /></td> \n' + \
        '  </tr>\n' + \
        '</table>\n\n')

  print("<table bgcolor=whitesmoke width=" + str(pWidth) + " cellpadding=0 >")
  print("<tr><td>&nbsp;</td></tr>")

  string = \
"""\
PGSQL is the PostgreSQL Community Edition that is developer friendly and cross-platform.
We fully embrace both core PostgreSQL and it's rich eco-system of over
50 enterprise-class extensions, applications & connectors.
We support Linux (both AMD64 & ARM64), OSX, and Windows.
Our Linux support includes Centos/RHEL, Ubuntu/Debian/Raspbian, and openSUSE.
\
"""
  print("  <tr><td colspan=2><h2>Introduction</h2></td></tr>")
  print("  <tr><td colspan=2>\n" + string + "<br>&nbsp;\n" + \
        "  </td></tr>")
  print("</table>")

  print("<table bgcolor=white width=" + str(pWidth) + " cellpadding=1 >")
  print("  <tr><td>&nbsp;</td></tr>")

  string = \
"""\
<tr><td colspan=2>
<table>
  <tr>
    <td width=275><h2>Download & Usage</h2></td>
    <td><img width=55% height=55% src=img/platforms.png /></td>
  </tr>
</table>
</td></tr>

<tr><td colspan=2>
We are verfied & tested with Python 2.7 & 3.5+; Amazon Linux 2; 
CentOS/RHEL 7 & 8; Ubuntu LTS 16, 18 & 20; Debian 9 & 10; 
opensSUSE 12 & 13; Windows 10 Subsytem for Linux, and OSX 10.13.
We run in a sandboxed environment that is perfect for running
in the development, container, bare metal, or cloud environment
of your choice.

<br>&nbsp;</td></tr>
<tr><td width=240 align=right><b>Install command line:</b></td>
  <td><input type='text' size=80 value =
'python3 -c "$(curl -fsSL https://pgsql-io-download.s3.amazonaws.com/REPO/install.py "' readonly='readonly' />
  </td>
</tr>
<tr><td>&nbsp;</td></tr>
<tr><td align=right><p><b>Usage sample:</b></td>
    <td>
      <input type='text' size=80 value =
'cd pgsql; ./io install pg11; ./io start pg11; ./io install timescale' readonly='readonly' />
    </td>
</tr>
</table>
\
"""
  print(string)


def print_footer():
  print('<center><table><tr> \n' + \
        '   <td width=450>&copy; 2020 PGSQL.IO, LLC, All rights reserved.</td> \n' + \
        '   <td width=450 align=right><a href="https://lussier.io">denis@lussier.io</a></td> \n' + \
        '</tr></table></center>')
