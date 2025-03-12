import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';

class PrivateJobsPage extends StatefulWidget {
  @override
  _PrivateJobsPageState createState() => _PrivateJobsPageState();
}

class _PrivateJobsPageState extends State<PrivateJobsPage> {
  final List<Map<String, String>> forms = [
    {
      'title': 'Infosys',
      'description': 'Infosys It Jobs',
      'url': 'https://in.findajob.website/registration/index.php?campaign=facebook-infosys-ldn&version=2&utm_medium=paid&utm_source=ig&utm_id=120217055978730327&utm_content=120217055978770327&utm_term=120217055978780327&utm_campaign=120217055978730327&fbclid=PAZXh0bgNhZW0BMABhZGlkAasYxq0wr1cBpuAT_D-Ma-nq3wNMTqVv2DLtB_ArXNViUj96DiSXvPVpqDCfYPsDk11FhA_aem_hJHx-05sPIwJnOb2PvFF5w',
      'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTn7pqwQe4ncAaF26On1VRBw3zPHsCoAhGDUQ&s',
      'video': 'https://www.youtube.com/watch?v=IOX_Krhy44Q',
    },
    {
      'title': 'TCSNextStep',
      'description': 'TCSNextStep NQT Application form',
      'url': 'https://nextstep.tcs.com/campus/#/',
      'image': 'https://www.freshersnow.com/wp-content/uploads/2022/04/TCS-Company.png',
      'video': 'https://www.youtube.com/watch?v=54RiEhkAJdU'
    },
    {
      'title': 'Amazon',
      'description': 'Amazon Job Application Form',
      'url': 'https://www.amazon.jobs/en/search?base_query=GO-AI+Operations',
      'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTMnYPXIDmRTKpj1drsmIRD_0NJJLVIVnMJNA&s',
      'video': 'https://www.youtube.com/watch?v=uZrM7H5Ao3s',
    },
    {
      'title': 'Wipro',
      'description': 'Wipro SIM Hiring',
      'url': 'https://app.joinsuperset.com/join/#/signup/student/jobprofiles/ed576c6d-5565-4f67-96f5-97771dff45c0',
      'image': 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAQ8AAAC6CAMAAACHgTh+AAACcFBMVEX////u7u7t7e339/fy8vL7+/smFTn19fX5+flRWJIVJU86RIBSRGEXAiw8eLioCksVLmUTACnINj7WRTP///t0Q3pbTGofNG8AAACiF1YeCzHu8PMAAD0AABcQACYdADXxfg9OOV/+xwDpYw0aep0Nf3YakE+FgZiFPHEJACQAACEAABD2//8jeqMseaoAfjYAABz8qwAAbpUgUJQAAEAAAE0AD1QAGFoAABIlNHWZAC1GTot9P3XlRQClEVAATp0mYKkAQI3S2+Tj8exipSu33NIAImAAADWRlK+JsgAAAE+YuysGGEUNKGa+vcuIiZg9OU5waIKNlLTBvMb55try8OWXACbPGgCLTHWaADiDp8RWm7LB1eGjt9PR6t9Nl45Yl6XG3eCTuclSgbgAgGZhkrkZX6oYi3wQfn2tz9AAdkcWfJBkoqW7yuIQfIQAbKJjgq2Jx7JssIktmX90rr8/ZKBEk4x8sZew1r84k2cAeCVkm4VVonJMfaZgbY5RWIGNsrBhb4o5i6d4m8gAKHRgZo+jp7mAia2Ovl1TWG9coSF/q5aixoeRuGpapWuvzZne7NFCpoRDR3Cgv5eIs3DO47YAUo3s5L0AbmTN0YKTv1QAI21Wd5uMqLukw1udl6UqJkF8donMlLFnHGG/aJHlz9mcN2+SAVmrmLD1351TNWP+1Fz3ynzmv8/3tFnlv8/ylTG+rL7wiUXfh4HDFxzJVWf34rPxtJjSWlWDZYb9wTfop5XMeZyzTHDSna3xtIp8VYTtoH/SeonllIz81Wv1oDPymlz1ypDzggC/QVXjMQD21MrzvZXzsGfiYD7qgVxu9k4xAAAcIElEQVR4nO2di18UR7aAe7qrqcYREW1FKEQjyrMN4osM+GwURyMNOIwEF5MrPjZm13vVjZvo7sK6yhBMsjHszZLd3L08dBJNYoiBVTcqeZls9pJs/qV7qqpfM8wIGJEZM2V+mKlp6pz++tQ5p05Xt4LgNOSxmohd3aLT7eqVnG7k6vY4B8tOr+Ic7IktUHJ65dgCsTOEW6DrYJfAibVTYgp0a5fikeKR4pHikeKR4pHikeKR4jHTPES7RfBwWgQPu6HYB0fwsFsED6dbij2Gm8dUBLq0cwv0ON0RPFwCkdMU2W6Kq9vplV290oQHY6cXxx7D1StNKHBi7VwCpdhjxBbo1m6KBm53T8LAXQfHmX4xDVyckoHHERhhbrGnX2yB0zjhnYM9U+Hx4BM+tnYT8vCkeKR4pHikeKR4pHikeDxiHg8hwY7Id2Me/MDp/yQS7Im0m1r6L0ip5m5uNI/neu6BzS213vek6h+JyYPKq9FSPERLnLhv9erVPyO2eghJGP3EeGiCbAJB6s9WL4f2JDHVU8TW/cd0+Pqnw+PZF5/7jzaVi8QHAMfKJ5cvb+Pqqa0HT82Zc2q/6lbv8eax/dCKFSvePsyBqOcAB5jHcjZjZFxzZMscaEf2u5R+vHngn69Y8fzzK1YclWiXchhgrFxp8hCkcwzHnDkHyczymLDgGZOHOLF643gcfQHM4xfP/+KX9BqI6j7qPcBEOA/x4Byz6W4eUxEYrxzrdMfj8ZDr05MriDMe1ER+yWRKIrWPJ5evPMbUqbF4bGllnwWVECIoUxH4wOX6qSXYrnz3R63npAOHDq341X8+/4s2s7P1D2Af//U3hFiC7cwXKhCj/cfnHN5HpiLwwddzk5zwpkTn4Kmv96UTJ09uNw1c/hXMl+dXPH/AOpi0vdjWijGf8EePMBxHzlHtcM3hzUfWrNl8qiaWwOStf9QUlkM7wQSKuObVnx/6+a8POGOoqizZ6u2jk2XzcUwPlvZs3rJly5o1vlOPFQ/lpfLCQkAiYv7r5NmXX3auOFuQutRrPXfu8H5CtUOE0qBAslsfJx41pwFH4aHyE+bR4BXdXiU6QCr8W5CjbwYca2gLPX48Cstfco6eTMLAeHAgdf7HiQc5WV74QmHhGd3JqyaVQCGymVvHYzZfhKPl5YXlZ36jxBYYP6FUjm9lQHzpVkHg8eAh6L89/duX5Skn2Jgc30pxrDGTVcjNZFfunmQ8EEYeOx8jshA3wUbYOsnoBYdSs+936af2cBwk1O7t8OvytPF40Px0UuV/jyJDpi1NojytarquoHHpIu+QiEgkleHorK2rq6306up05aexx3tY9fXthWfOnKxx4404ATAKLlQ6tnr16n1mN9EJ8sQ6AQ/uqcyeC622ksQRaLaHcT2nYb3/LMvBTsabfuqB37c9S7NSRFbC+mU1DyD7D845eEwab+AworE+m/GYu35PDO0Sv/7BctLCchRHYiusYZ4DW/DgVlYvZAbSCouXLXN4WI7iIXRx85g7t/KsFWySisdJloOdaY0j8SRd1LWBKSAdFvtPrt5PO9nidss+GpeRe2TOY25S85jAPn5DefyeTg2pbfXy1X9QHR77FVBC0ludihDwUP3rTR7r22Nol/g8aiAHKzxzIp7/OPo28DhAZwbCrS+2cR/Ztpku9Y9JIsLnTp06dc7h4cH6LpNHnr2WSSoeQs1JyMGi0hn55JnCl00gzz13gCWs7gC579SWOfvh7NV9W4+sWXP+bw4PUfCvq4PoUre2M5Z2ScDDzMEieLwMeXs5swUkK4oZSBwemqC31mDqPPgyLt3hAX3+ynVr167vcoplycaDtQgeJ2AOleuWQDGaB3TTW3MeLB5hy7geFw8PVvRQUUh3nUzy83gWcrTT0QJjpP/qQbaMO27x4N1YVVU2Mmn1h3QSR2BS7eff/tJLerTAGAm21Lpma7bvz6ymKBH3GCBQNrxr8/LWteuqk3Mm7n5+fkGjbxAIAh9DkRR8n9sXdregHz51WJeRKnV1dIDLcAkUQnm7Z0HLm6U73Ym7n//iK9teqXEqHaa51dTQiyLaN4UiBGIJ09HFSANXVYi7yLu+rm79LicVUVSjlOEAIN2OKSfsfv7gtgvbLrxS4xzNdN5+uvBVIZ4DlI+1tdFVHFZU97mAgXvUUCVdtbhirKy2580yW54xgXYJUP947cK2bdsuvCZF8vgtxNnt43jI20/QofSVq1cfU0Qsnjt3wCWQHqZ01dJVS22P000adls81vYlPA/1dcbjdaef8fhjTB6/f/vtX8M0gnx9+WFwFQePHNniumtLD5NMHl4Xj55Ztn3U22onKg/hjW3b/rrtwhtOVY/xuAjzRXbUQxJz8W8eWkFvS4F9rGyVkAiLly3HoFsjtnaqwVZxeXscidixDydzT1we6rYLFy68HozyH+BPJUc9JB84SgUefeHQz2CtKusvtko059h85BSgOHbw1H7J1A4pHesqK3f0ODmp4vIftUngPwT1jdfeUh33EWO/tqgePXPmTfp5+1H6U8LsdiX2tO2D6UI2r1mztdXUTkRqqL3d77qfrUhkrWkgO+on0i4ReEQdHIuHfLK8vNzplfjtShFB4AUeW4EHvfAsNouQNygq9BqhEPMtskcI7d7BZovLapKHR4z0X5QPnDnznJuHWz3yu61bffTUVdXsg18gHXl5O/pDTCBSWr0lO3as6yKxBSb0fn6Egi4g8FmRML2j7T6XqPRfP3ccpove3mlIHqvXS33G7h0GE+iRadlZUnEsgQm+n1/+07b/Joprz/yJl3QZuu8jG6aHourZlZXrDdn8JYN7jLwi2T5EkBWBYX14urrRTNd6LgjJyBvW8WBub5VzT2oJpLMh+oJ6zOpgpZ2V+tcyHru7icvACaxsOtp1PlJC7ucnhES7I/mVCxd0O9oIQuuZ8jfdAvGzIpZbj5xTBLKfOg3z9zmPDmsYyz7OIkegf21ebe3u9Wvb6R3MhKx/kODFi6yc41bv4htvSW6JJ149YAlESJSOHvq1oh7+85NEOnyEbrFEEveJevb6tU56IfXwiBKSbYGhtWY5dZ1fQgnJQ+v9686nX2crObd67tgLn1TzK0RvRUpy29unZfnAwaMCPr55To2w77jOB5f0rnYn2xKMXTvy8kraZWRNAdIz12p1hiImIg91586nn975F+KJF74jbqkgRApfOICwTjD3Hwjmy9GtvlOqh+lCdYYou4tBQarH3w58kL1AD7G7D9n0T22RkpD20Qs4nt7517g8cPCtixE83jwNxoSRy5+2bn3nfyADpdUTcG+kMW/37rUUCBYllTeFH4zPVjIcc7Ozs+s6SXLyeO3CK0GnH+OaGnN/ndPZ9jeRdHYYKhPIvGhekcDvZ3tkaU97u7mCI2fpundWNphHdl1HYvIQXt/59M6ne+PyqHnlwjbbQE4UEktkRLxVhM5163sIe/7FqLV50JPQ5+ZVVuZ18G3uRbVgGZTG3MTlEfzL//6lNzq+uOzj4p9sHPKrp2PykEWha93aHgwZNcyXzh27d7MaGL0lI/Wwpf/6LjY2rZtxIOA/cALs5zeXIhHxFtcgnoDE8aeuJF2tsSskkTyw2OnVmULUn+5az/wpzBfZ2MU9aCXTRO+Za/GYa0hx4ss07+fnA5j1aViHmPVpc2BZQBiauTWeHch/uKrZ5oH0h2JX5iVVNvt4BR5Otm5dkWoKJLqu0HK9ABka85+7WFVdMOBjthf+VIZUNBP7+RHSaYPYxi5ooF43+Uq0m0CYIOx7dj11HWGk6oG++vq+gHP9PToNrwrvtqzFCNSzj5BcmBe0PWv3LJ3Vk5VQ3a5dftYbWsdmSHalTpdjHjXkpaXmSnNn6gzs59dnN0CjxgkS9YZFjRLjIYT6Gxr6GwWPTL9na3Klvr+/XhH8DVn5pSUlud0Bcwi1CPpl0phWUlpSmtXHZOoD/RklJSX5ad0hsHSuXkdpXr/O9hcatbWQgbKgQnbVURx1PXxKIln3V/t8IbPgOgP1D9JYmpu7uEhgEvsWpy0OcB5P5OfmlhUJSM7KYN+D6rOzcvsDsxflprGWVTZg2sLs/NwGo38x6181QBXvK1vMD0rLWLRQlLl6pKN7P99/Spcx2XXt7NdDtQCkNtuQLD+nurV79DzUvnzQupvODEHsz03LeILykAg9ofyAguQlcJ75lAeanUFPMM1quWVmZW9hVlruEquf4gyVpTmtpFu3nBExQgT0kFkYMXlIRofPe9ZZHHokQTdChj5TPCSjH06tX1fAP/tLQf+nAtQJXi/jlMbxoJieWpzF/qf0usWD8Vn1VOnibvA0gaxc/nEV+6K00RLmX7uuh2auBrWJXVZ1nehEdiKhSjp7fHW+HlYnmwEeCM8GrUv7ZFEhi5iF0/uFcjd0ltTDwpPxKHHxyOhv7OvrzmC20q87PPIbBq4MUKeip1EcpQ2NV650l9D/XWSln911c9fRlZ0a6pnb02XHRzAbXTTvhcq61+fzeuHHO8bM1E+FIpgaWQsJ/M8q7hhC1LHCiWQEFHGcfWQtNGRBlUL97KT7bB4Z9XBBVXpRQ3SYVUW6LKukj86vjNmmo+naVVlLn5YBr2kY5iYHQQplv1N3vsNgG5Sx3kFp0Jb9jj4TPERVfwqMewn83c89JVU/UAJ/N0AMjOYBM4tqiYW+EnYoNnmA21HMkdPgY/4TggypEhL66BRMM9f4xO/XVT4p9nRaC/9QHT17Xzb9BvLYOq/VfO0zYh9IeAJOYFVIGIAzZEQWh+QBcLIlA/ThjKj5krFQZqUQzCjklogmDwBgCkSLGF6e7iK5kY5k3ZHVi0KiRMsg4CHYhICubPPsOz2gi+jzOs0OOo+Uhyj0raLTgE773LTQEhpCyGyAsMiAtCzaPsB42EXDQohGoDLd5JH1BL2YVKDBPbGZYKv0sCzzjqxe66tsl5BH9tPTzu5QbPOgTUewunvHxcMXcj1p9Oj280uBUmoYjXC2TxVJ3fBXSSMwyC2F9ZeIlGge7AlSsA+dBtUyw+Hh4ekiDbYZAIAXgBVjMf3IfSc7dx17UDszAx89x5BlET7ICWWjzsWjLuSqCz/C/fyk20wsctNEIcCcJs0bzDBJeZQWwe8QPl9MvLJB3eZThiDK5nzhAmXGo5FYJ2Aw+2BXQzKyfb5Oeo32MPvwAlrV5sHWe1H24dL5Ue7nry/liUVpvYzIwhLzQ8DhAf5D9ETy4NFoMcypSB4qtRuYVR6TB3WopfU8mqpGVxeL0DqNqb4QzGHF8Fn+gwYhct7Fw+sqtT7S+sd1M6Hqh+RAvb6If0gT78dDIA0ZzG/iKB4YleWymM0FssBd0seCKVKNkHkueud5ryGxanwXB8K9q9DpOFRfx9R2Pz48Huzc4GJfoQEFliMsCxnADo98h8ds3otpNErLP0vTb9N/mAKFhfk0OTVHZkGrP8AChbTH50s3d+ZhhTtAEeMuSL58PVbOVu3wMJSZqo+xk8stJSAUfBqbMPnW8jWSR25avUEEHBjgqXhANnlY9gEjBvJZZgJrVBI4W8oSdhajkac9Pf08Oxm9s7PTMAMCloyQ31rQgr8BEtXwx5sdUj0zxcOgc2RxPR8dd1Mg/ZaGkfMFUo7+7sbufmZD+d00+EbygBnQTSFk5DfAYYzzIpHf08dd4DbYA3ed1dXVXp6Rgp9R3UtaQfeeB3s5n24oaObqp0vowpaYVdIAJKr59iIs0j5YApu1hP+dFqCnFDVfIIloYBaWm7+E/xXiWiNZCvkZZcOXnp5e3cUeiFH0rvRqf0QU0P3+kCGoM3m/srEE1iJmygY5ZWlamf3odJR9OC0rI8DUibIPCCN62iqnKpDl50+kIvFKny6wqGN4GQ8Gz0j3gq10unbcMXNR2NbVGeMRWJXVYD9nreqLcstsBReX5ucvcvHIX8KS+oyyWQE+DeTZi/PzF6e5BKr6wrJ8dtSSsjJY/lH1RG3w0oJGwt1HNfDwhmT6lEwnZZPu3WOfur6na49BVLaNaMZ46LNLrjtjC42m+dNW1DjQ2EjrNdyfPjHQTdd9/d19Ev8FUTUaBwYaQy6BoNr1xgYaWLpZ+ZDxUC9fKi7W+bmE0r3eLhnT9JXhSE/3mUtgnQVcn5ffvJq5/fx6wLXDAosBx35lRZYV+p2Vf0h6ABqx82MUQyCSZXqUYQtEmhB+970rkikQ1vsswVZDFg/+hZjOP1dDsPXM5H5+LEXckcDOnQoY3dy2z/MPRcKKgmXXbQ3iyHN6BRhDwrZAZfCOJoYlQUZYDfVRR8K0g0yVn3+1KNE32HVWczzp1Z2ikMj7+QXX+laMmH7Bq73mfhkP+WeF+4LaQwDTO3ur7vILiq+8v+D9BZAJ8wtq+g8/TX0kw8IBBhOKq10C7Od38cDmet/C8cGyT4MmEPRhhSPRNeE1Qbjc0nKXCUB68YYNCxZcUcwJr/P4wl4yg/0Oj2paQE3o/ZZxeSyzDIR4mpwxHB7atVE5vGnvKB8l/G5xcfGCK5LlAIm/szNE+HuX9rh4tCcnD6H3nj1fmMCPvg6aPFjWgZA2tHfvXZdAGmeKAzhGQMBuHl0oiXhEhCvi5hH8uKBJUJtkQcIa9mBxLKwNVrXk2AdrWvjye+9ep7vDFEEJXDd0R6BkRRvKwy8nEQ/ifi8jHGzuQaQCm5pUYazgE0Ejw2MEDY/8XUQ5mUPWwKODokZEUWLFRaXo8wULFhq2QKy77MOIq12C8CCz83Nz8xkPErzR61aP3LgadO+YubmxQNCGm+eL6NbILVGyX4tD7u5tyQlDYORK/+PSAmjv67ZA1UrPIGGNr12C8JDrl/T3LxlQqd8EJ+pskhLJjYqKT9081O+aBO128y1RC385pjnqje7NyWm5rPGRcbi4eAMFcsX1RGqomhKB7FVJeB48IaWRgASXLVt2w8XjXhQPJhCPicSDiORKB+60ZOZsyjF5aKPFtG1YUCRbAkUk6bRe1qlL99EuYfbzK3TTJGWCIOlwihYiIR991AteIWo/v/VKGIeH2AJtVDNXBUOUBrQrpkAPS3FVwf18ZSztEm8/vxK8EYz4LEt0d38wKCtxfkMTR0fDmjR09+4osbbvy88wA7lkqLxDQIRA2i3FG+PBmhvN9D2fLRN7JWWbW/CTTz7T4lxQcrmq6m5Ygtji9Grh9y5Bu6Ly/clKqLGxsUh3K52Q+/lZI7RN4I7uLV26lNbYCCbREx6HqzIz99KZ4urFmjj4j8Eh+sZlEKh//j51rpeKJFvrhNxvyXGgqx9eDY7nQdwSrxYULAVfiZt6iet5D2VsVNSwmJmZ2TLk8BgaHR2SENZkWWO1ZgF/zmLN5wvev2I/Bp6wPAiBALvsA9c+ZMpDJDwNs/rU7z5rIhB8Cwq+0IhHVm+z44dHICXD0peQtFMPyw8dzNy0qeWOZr8eAwmDlzYUL2BtoW7vYU1YHleX0XYvkgeE3YqrJEIiBBntk40FBU0Iibeam8fAqYzMnzdyG3u0MLhTS+C1qk05OTlVMH9MgVh4ptjisSBg3dZPXB73GI8PnBgLPMBoKioqYDEXKZB8v3HjJ4jg283zR26B0cyDFobcQNOoKXCBNA/Jydl0V7MEYh5rNtBSAF37JjqPDzkPp5fZxzLgcXUcj+D3nzRpIh5rnt/8BXSNzW8eleyJwQTKwIMCydEsBal98OyM1kaswnbi8ggyHq41C+NxtaLiIxTNw0M0iKrwc+zWV5JrDLfAwZZN0OzMnQpkVQCYMxs2FCf+fPGQ3nufftAbFV8IabqByPj0nxU+Yqb/IuZLOzEHDCQzM2yLREL4UrFpIc+I0+dPnZLij3w/P0HB4Pj8A+KLOIVyrKihwTuDdPDw3b17c4Y0t0AwkHdZuqrbiiTr+/mF4D9vBIWog2MIlMItVVVVmaJgPkQQIVAaLH6v+NK7z4RdNwiS8/38pOnrgoJvMJk4/b9Lpwl1G3Tt5olMsIHW6OCVa6LmGiNp3s8fyeOf3y5dWtBEJpzwKJO1TTys2AZ+bWiIBWMsSVhBcQQmYP2DRw+elE6Gh/U+ekSamphMxLxoy90IHqOZMIdyBrF9OknFgwSvfvjhDRLJI/hNwdLPKCUijN2+ad5zkLCmMfdKtNvzRm5do7p8SYFUmWGW8xhlmQhN3ietXeLwEHlOWnGDRIQrEhzrZWtarWkjJKcciNZ0O0yBiNrYCMtR6ZH/qqram8P/gQPOQ8mkmXtOznstYSt5TyIekKhWVNCsNPp9KLy8jtjaZeNN1nu7ubn5Fk1M8TDlMfIlG/janSHNVJzxuFPFM9WcljvSZLVLJB73KljrjbrfYDbs8BDnQ2umKzYyPM/mQe+/2NkW49ECK10G5DJCScjjQ2YeFcGYPETtu//buLGAzRdYvgCPYeChfUXto/maqV1kAnWnZRMAyaRl9yTkwe4sVNBieux0lwjfffMNdx9NzD5uAw+kDc8bmTcqj9OO8hitogE4JzOnZTAJ5wv406ufAo6mODxcAlXmP9gj2RiPXRuzSgXmgeBnuT/dRCcMrQ5Nmz990Px0cu/nJ8HeJpFMojythL8YE3nOSKIPRhpt7PNQJstZq0Y1T0yBPz4/jT3edLz/lBAE69sHOAFpFGbIqIduAdDCl8E87oYnJZC3RHo/v6MeeIumz77/fkyL2D82qeknXq5qyWxpucumiKaEh8Kxw1Xi1j9i8SC9Hy9duvTb7yZ+YVg0j1GWt2dWmfVCjHEc75BUPPA3S2krcO0JmhwPc1kHXuOaZt23TX4epPdrzuOzSfHgM58JDLdYPAa1GAKTlUfTx5zHN26BcetjEo0oXOC1ln9ZPJQYApOUhwd/z3lYVWZZbGrC9hORkTyQFh6+NTwEi3qqVVVL1Hx5LHiQ3m8LlhYUfG/6U/Xmvzdu/KHJ2ksWwQOW/PNH5o2MfMn2ryuXW1jSkZljv03mceDhIWMff/v1TY/J44sCaLDYN98lo6ljX900k1LZXPLPGxlllMI5VSwHu6bFEpi0PESiEfiPS2zaWMCA3OQ8tPB8yNebTSLk75zHvHk8GOE7dzdtumxn6I+Ox/Tmp2wVYqaLY5xHwQ/s38XCwfms0Tu40MLzrGbloeFwWNamIjDB3s8fffsi+o6ExnlsLPiBDSPcbmY8RoZVdp/hX/Pmcx5j5tD0nUQTa5fQ+/nvd3tLJMECc77wvmHOY/4tkWVbw6Z53Gqa0MDjCEy8/fzug8e9P1nUPttIa2M/BMfzgAlv+9OpTfhEr3/E5+Eh5ObSjQVfWP32fMFcvZsj0JqH5Z8MD3pbX3PdW/s3BzImmeqRr4a/ahKmGBCSmYeH7pBxBAaHIdz+MKZFq/fT4RElUBoLh4PSOPV+ujwQwWYxPcVDeDgJZYrHNPCYUj32wd7P/yPS/6kW9GNol3j7+ZOpudE8qn9v7aFe0NgCE2w//3S4I9e/If5Y1D9SPFI8UjxSPFI8UjxSPJh6cQue9+UxidvLD6McG6fgORGPxN/PP1G5Po7A+5TrxwtMov38sQ9OmPWcJ6a9/XTX+ykeKR4pHikeKR4pHikeKR6PmseD5qdTShcfRnn6EeWn03cCsfE+7BOYUGCi7uf/sdMvVf9I8UjxSPFIbB7/DwmfytMOIYivAAAAAElFTkSuQmCC',
      'video': 'https://www.youtube.com/watch?v=qwYXyMW_DUo&list=UULFnYD9b1YZgZlCsuc8CTRfQg',
    },
    {
      'title': 'Cognizant',
      'description': 'Cognizant Off-Campus Hiring',
      'url': 'https://app.joinsuperset.com/join/#/signup/student/jobprofiles/80927bc8-841c-4055-a89d-e207fdb67bd9',
      'image': 'data:image/png;base64,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',
      'video': 'https://www.youtube.com/watch?v=j6STjA84hRs&list=UULFnYD9b1YZgZlCsuc8CTRfQg',
    },
  ];

  String searchQuery = "";

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> filteredForms = forms
        .where((form) => form['title']!.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(title: Text('PrivateJobs Forms')),
      body: Column(
        children: [
          _buildSearchBar(),
          Expanded(child: _buildFormsList(filteredForms)),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        onChanged: (query) {
          setState(() {
            searchQuery = query;
          });
        },
        decoration: InputDecoration(
          hintText: "Search forms...",
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }

  Widget _buildFormsList(List<Map<String, String>> forms) {
    return ListView.builder(
      itemCount: forms.length,
      itemBuilder: (context, index) {
        return _buildPrivateJobsCard(forms[index]);
      },
    );
  }

  Widget _buildPrivateJobsCard(Map<String, String> form) {
    return Card(
      margin: EdgeInsets.all(10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 4,
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(form['image']!, width: 60, height: 60, fit: BoxFit.cover),
        ),
        title: Text(form['title']!, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(form['description']!),
        trailing: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF6366F1),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FormDetailsPage(form: form),
              ),
            );
          },
          child: Text("Open", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}

class FormDetailsPage extends StatelessWidget {
  final Map<String, String> form;

  FormDetailsPage({required this.form});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(form['title']!)),
      body: Center(  // Ensures the grid is centered
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,  // Centers content vertically
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.center,
              child: GridView.count(
                shrinkWrap: true,  // Ensures the GridView doesn't take full height
                crossAxisCount: 2,  // 2 columns
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                childAspectRatio: 0.7,  // Adjust the height of the grid items
                children: [
                  _buildGridItem(Icons.edit, "Fill the form here", () => _launchURL(form['url']!)),
                  _buildGridItem(Icons.play_circle_fill, "Watch the video", () {
                    if (form.containsKey('video') && form['video']!.isNotEmpty) {
                      _launchURL(form['video']!);
                    } else {
                      _showError(context);
                    }
                  }),
                  _buildGridItem(Icons.share, "Share the link", () {
                    _shareContent("Check out this form: ${form['url']!}");
                  }),
                  _buildGridItem(Icons.favorite, "Favorite", () {
                    // Add favorite logic
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildGridItem(IconData icon, String title, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(color: Colors.black, blurRadius: 5, spreadRadius: 2),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 60, color: Colors.blue),
            SizedBox(height: 10),
            Text(title, textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
          ],
        ),
      ),
    );
  }
}
void _shareContent(String content) {
  Share.share(content);
}
void _showError(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text('No video available for this form.')),
  );
}
void _launchURL(String url) async {
  Uri uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  } else {
    throw 'Could not launch $url';
  }
}
