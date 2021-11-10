Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5C1144BEF8
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Nov 2021 11:46:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbhKJKsy (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 10 Nov 2021 05:48:54 -0500
Received: from mout.gmx.net ([212.227.15.18]:48747 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231171AbhKJKsx (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 10 Nov 2021 05:48:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1636541050;
        bh=h45DiQjGY0Dfm8CE9cn4qF+342ykeQ4Uk5C/gkooaIw=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=kmUfRHIzmoViydSucYTxEQG1FNJ8CWRzX0F3WYOX1d2VD3eujCwT6kC0uAXqWmZLt
         eMJ+M/8iTWkQKI5o+Bspt5/1og5A5qZCqV0IRSD+beJIRF0/33jVnOkUer8fEeU46q
         NY7uVn1Yx5reMWfFjuhrJ2jc6HS5QmKSQvralaIo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.194.160]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MYeQr-1nEmW91Bsx-00Vcng; Wed, 10
 Nov 2021 11:44:10 +0100
Date:   Wed, 10 Nov 2021 11:43:55 +0100
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Guenter Roeck <linux@roeck-us.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Lee Jones <lee.jones@linaro.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King <linux@armlinux.org.uk>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Joshua Thompson <funaho@jurai.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Helge Deller <deller@gmx.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>, Tony Lindgren <tony@atomide.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Pavel Machek <pavel@ucw.cz>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-sh@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-acpi@vger.kernel.org,
        linux-omap@vger.kernel.org, openbmc@lists.ozlabs.org,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 27/45] mfd: ntxec: Use devm_register_power_handler()
Message-ID: <YYuia9KFdi+ETT+I@latitude>
References: <20211027211715.12671-1-digetx@gmail.com>
 <20211027211715.12671-28-digetx@gmail.com>
 <YYbqlmOM95q7Hbjo@latitude>
 <be0c74c6-05a9-cad5-c285-6626d05f8860@gmail.com>
 <9a22c22d-94b1-f519-27a2-ae0b8bbf6e99@roeck-us.net>
 <658cf796-e3b1-f816-1e15-9e9e08b8ade0@gmail.com>
 <5a17fee3-4214-c2b9-abc1-ab9d6071591b@roeck-us.net>
 <c0b52994-51f5-806b-b07e-3e70d8217ffc@gmail.com>
 <YYkIeBSCFka9yrqC@latitude>
 <04103df3-1ef4-b560-a5cb-fa51737d28ad@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2Vc8voT8F+nWl+5t"
Content-Disposition: inline
In-Reply-To: <04103df3-1ef4-b560-a5cb-fa51737d28ad@gmail.com>
X-Provags-ID: V03:K1:Jd3HsvpIvSkd1z9MZ8A+M8pmRMEjtJGTIH5/rKKzl1zv92guAhj
 9dWDOhUd2UJZ9MerqFJu2sL0Vqy01eD3StlZDn4FJIminWyxKafYCrFSKtByuDa87GeS9OR
 qeoUp0E4UiW3sjAndGidVfCkZjgUQcURUuhYsgKl5H5XKG1g/BTOt0/CSBYYpcJ5Udag/gd
 3wpmaE1MgAr/8Zxl8PaIg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:9zHz1F4x458=:7Vp+bYm0dzpDVbvG6/Jg2u
 qI4IrtGWKiV/jMQFkG7dyJBbQvpEWwPJ76d/zJSyX1M1lKNm0KMizgdWYVXyIW/XoqBwKPv1D
 53+DzXdLuVgOm0wkoIG2GeQ/nb/c84AhvSEAoevpHCl6VEXR6fOvbN82cXa7985eDdl8UKM+O
 4h3Is/MA4WoDtRBZ1OqiFsYx8FLL1RBd0E7FqR319PSJ/bJwJAdPbaC1JvQk6kHH3/NBFt26i
 Q3DgkmG6muY/n8xv9b9V7t/ZWlppYtelF1o5MvHu2J00j2PbYSZX9eozu/Doat8V94rSWUKYb
 8pSdnLPUWq70O5KtVp9tTAFvyw/H1FShEa0gt9n4kbbOSofwKtWPp3w6ndwZn0vqQiMqSpx5F
 pW+VpkbxvWsOFEWJJsTGH2eqGFH7HNRknQZl+87wW5wtL7KvGgF3QsbsIAWrKtzB9X/8WrLGE
 Q2bThe7j50/eherGVoafg+OX1FpxcH8SkWxWRwHOYPY6MAcfWvoCbb0Lrq1TuMCEIR21SYzz/
 nKcIQ2MIMbO6pJev1gnsMMspAiK9v/yDDf2YfwA5W5cMnog6ZH1EP7GjRP+V1L4WGIVmIYWjZ
 cHGTxKjNY18j227bPzrRrZw1mR3FZxmby4QNq9M2UubsB6oeBGdjh2aJPUPJBCfs/+3a18KA+
 xA6FQOnu4L1XhctfO1s8iX0YD6ideSBMb0KHUFr1N0LQgA0QEITEwNFtzGkPBB/gQ91Mtb/BO
 /mpnNG0EzJaO/w5CiG92jdML3JVtyvpMLyLhPWE0HyQ2mtmYYeRjCDxP5oDHzH4e/JAELuTV1
 U+KgtcC4SdatS1E3xSGfYaEWJnZD3guRw2ZDMVMPz1QzGYvBbk1uTXDDTpqBpiWB9POVDvyMU
 RZN7S/dzQnujlcpYxqJMiIBsYFZJI3saxm1eCZh79EkYKtr+yxECJAHRe1ooDxlvmf+PdmvFz
 teW5eV+FQ6Z8TxYl0+/Pxm1aaTMg360Uf5O3Yxxq+6pW+Cr9pdW+jbwf3FWQ4Opb03KxmWDUJ
 J/4DosOxyxjcCBCxt9avnDv6aic7H0cD/lL1HPIA+I+KJ0H2Wh10gm+vMHpsdMkzEHCpK13Dh
 +VtVl/6MSAYdCs=
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


--2Vc8voT8F+nWl+5t
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 08, 2021 at 02:36:42PM +0300, Dmitry Osipenko wrote:
> 08.11.2021 14:22, Jonathan Neusch=C3=A4fer =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > On Sun, Nov 07, 2021 at 08:42:33PM +0300, Dmitry Osipenko wrote:
> > [...]
> >> EC drivers tend to use higher priority in general. Jonathan, could you
> >> please confirm that NTXEC driver is a more preferable restart method
> >> than the watchdog?
> >=20
> > Yes. The original firmware uses the NTXEC to restart, and it works well,
> > so I do think it's preferable.
>=20
> Thank you, then I'll update the NTXEC patch like this:
>=20
> https://github.com/grate-driver/linux/commit/22da3d91f1734d9a0ed036220ad4=
ea28465af988

I tested again, but sys_off_handler_reboot called a bogus pointer
(probably reboot_prepare_cb). I think it was left uninitialized in
ntxec_probe, which uses devm_kmalloc. I guess we could switch it to
devm_kzalloc:

diff --git a/drivers/mfd/ntxec.c b/drivers/mfd/ntxec.c
index 1f55dfce14308..30364beb4b1d0 100644
--- a/drivers/mfd/ntxec.c
+++ b/drivers/mfd/ntxec.c
@@ -144,7 +144,7 @@ static int ntxec_probe(struct i2c_client *client)
 	const struct mfd_cell *subdevs;
 	size_t n_subdevs;
=20
-	ec =3D devm_kmalloc(&client->dev, sizeof(*ec), GFP_KERNEL);
+	ec =3D devm_kzalloc(&client->dev, sizeof(*ec), GFP_KERNEL);
 	if (!ec)
 		return -ENOMEM;
=20


With that done, it works flawlessly.


Thanks,
Jonathan

--2Vc8voT8F+nWl+5t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAmGLoj4ACgkQCDBEmo7z
X9tbGw/9GW9TBNeJDqVwinH41nEM2TsnygEKpr7D3uPWXiWIIh7wxva0XnLkeDOr
YZUOSFjLglCoW9n8UjIgpmScFQ9OY5em2dY9iSOPk55FYy/kkD1LKXl8Qbto3Xjr
XRwv4EDIxlfO2uvjXgc07E2zGjiZdqaFwcIiMz1l8Rns6jC+AbzO0KFcoffXXKCg
oCDi/e1hnVfze/XGWTTSXbofwfAKHJPVE11uF8lK2Uqv0THOAbvpIQdZiQPaNuVe
bZuJ1p6wMxzjc6HiB8C6aJ0sy5Po98ZKWTAvvqFXBitgvOx0VCgKfJfqS+06qxiA
gYnxdQAIJjcwrBJYfpry4rg9nBYvH7Jao/uKYoXSm73mtXdEqG4oIQIZ0eC7jS/d
dRGjzR5mrhaA3G8mWMssxg6RX1EGpYBimy7XGpgml/bIXrEjGYZi3FaGZSnk9UTd
oAutr3b9I43OZFYo/gRKjQmEl9C1Ru/ZsmKDin75X8hfCzrFOoAUCLQ7X/tbbPoF
As6x8TUBJY8Zd9xBW2i/4sm+ZPAuMG5TMzzpRj/DEs2RN5UouXycBqzTFNleFYYf
LuwPDYZYSqe75uXgu0K0weup8tULnVfBuvOJDR5yMF7tf90iNku7JIcIXjtKglWH
EA0twe/kQWknjeUcmaR65U1v+cf8ekV6V8TVrEKb4cCEYf3HPBw=
=z+7h
-----END PGP SIGNATURE-----

--2Vc8voT8F+nWl+5t--
