Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 364C1447ED6
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Nov 2021 12:25:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239234AbhKHL1s (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 8 Nov 2021 06:27:48 -0500
Received: from mout.gmx.net ([212.227.17.22]:41875 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239220AbhKHL1r (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 8 Nov 2021 06:27:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1636370563;
        bh=K79wqPStqcTfK5nLIvxLt2yDFN8raIwyDHqiPgY+PHc=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=Iil8zKbQDwR3Nlg+ymOUpymQS9X1Mc+jbLXtA+yVF4SDdcwftUD6iVyibZ6wTz7fb
         Qc0Hcteal9dThlbJ/iNZLRdm5NTkZeKDClDySSPytppBB80v28nV6u18LsDpLiHQir
         Ny1SVC50YGwrAIYi9pHquhjsrGZ1aixItLj5nI/g=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.194.160]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MBDj4-1msKD70Bvq-00CkHo; Mon, 08
 Nov 2021 12:22:43 +0100
Date:   Mon, 8 Nov 2021 12:22:32 +0100
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
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
Message-ID: <YYkIeBSCFka9yrqC@latitude>
References: <20211027211715.12671-1-digetx@gmail.com>
 <20211027211715.12671-28-digetx@gmail.com>
 <YYbqlmOM95q7Hbjo@latitude>
 <be0c74c6-05a9-cad5-c285-6626d05f8860@gmail.com>
 <9a22c22d-94b1-f519-27a2-ae0b8bbf6e99@roeck-us.net>
 <658cf796-e3b1-f816-1e15-9e9e08b8ade0@gmail.com>
 <5a17fee3-4214-c2b9-abc1-ab9d6071591b@roeck-us.net>
 <c0b52994-51f5-806b-b07e-3e70d8217ffc@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="SrzUzzmYivmDpJiW"
Content-Disposition: inline
In-Reply-To: <c0b52994-51f5-806b-b07e-3e70d8217ffc@gmail.com>
X-Provags-ID: V03:K1:7qbQ+qoRzv7lpS+bZXlBkiHc8d3ndyzVjxZiUEx4fWU8LOwR4tV
 sJ6wX31cULMNt4suZs8Fc9nNWwTvT28rf28Ux8jItr0YArRnxNHgajX8j3pR27WJ8X4+rN1
 P6mwBUOnAtBBxh5xjfJsjiXu6SboLYbT6DrsS8jQkTim87V5oSocZwSYV15yBIZybWDcxi2
 yhhXSfTVo1fjkR9G3NiNg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:yjkPkKMrbPg=:X1ZiIBM9wmN7jnP9s16Cfb
 sBqYerCPdYu35MyKm/gIqDt8Gw/FOK/47i1VNVZ2GZyzu2N+w6bq5umB4vcv2LdlVvVXasJFU
 hHItgn4p2+gcrIXW8dm47/l7t1HQaw7UgtUqyeXqDu69ghAqCYZXx0eX60EUrsUOpoEgYDyVn
 oP9a1XYVWqB1j9J0R0WURMEfCLIEiPQoq7Rbx4EPDsJbUZtdggotJ5Zu652F4YThXYIsp6IMf
 gllsRU1HwQ6JjxuK8cXPPYaD+LLKehorJRlrq+y8qXUM6ylWXrOoGKNZLGsZkAONax4WYMqIW
 d3FGkGXLV4f+esApgI7PsCMvrwTK22lrWu5ViPmU4x2nHZP+ZTPAZuJtgSimwyu20amazZwYK
 Z4vpwY5CSzJZCDfMI5DZ0Ptk/Ztz1Q6g/A3jF9otZwKjtdDGI+4EVCvameWf3xn488EZ8v6YU
 At13Fas5vppLSoa/xpMWgEaXqdhRWW3BWFKDkwwIzAy8iepAVZKdxWuiNZ5V838e4pssIjwOP
 b9I/WUoeoSIjaVUx2uwI4jdditk+sE4UWUM/0QolX7ispKs/G3XyXxRQRgZ6B7X3V60FM1FjB
 RAlEp0a5931lWVr5xqZfoR1dAUpRgm1O9Vjh40HLSfiunbwWOc0bQ0ONdbOPoSLykjVMQhxlP
 xtpeZidtvOHYL9oWOJQZIFjHLJGmJNbSfzBBXrzNQMUN8I0KHFPgGMy1RqdguPf3PUJKELugu
 Nk3jRxSbdt395Sseo31kU92jjNpYb9PTuVNaM1aWS4Q4yTc9cIXxk1+LRFP9bIgg/V6iwob0M
 2xQWxNH/EiCfUWEHwJvuTGBqhgThj/glAo/CZxZAe/L3n3D6849ukZO9fYf8H8Nk2y5a5UHWh
 pvbdLd9gXcXQ6r/K+x80Dm4oeeZ7NvEbfgA19DwbuESar56ohW+JqsXIhz3AyR62ShQOe3+FE
 5fRkZdNNItdvlDY7CkW9kJ0ItIF7cQw1aNvt9OvV6ho/I2LuKv3w1ibUywvt8uxjpQ795s++f
 LtodIi5u3n67HADZypUokVR2nausSwp0lMroUVKyNyJ3Q2D2RhV5rxgHndlU1/Jjw3Lcz380m
 nnoGWxFp59yGiw=
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


--SrzUzzmYivmDpJiW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Nov 07, 2021 at 08:42:33PM +0300, Dmitry Osipenko wrote:
[...]
> EC drivers tend to use higher priority in general. Jonathan, could you
> please confirm that NTXEC driver is a more preferable restart method
> than the watchdog?

Yes. The original firmware uses the NTXEC to restart, and it works well,
so I do think it's preferable.


Best regards,
Jonathan

--SrzUzzmYivmDpJiW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAmGJCE4ACgkQCDBEmo7z
X9vVoBAAyZoJJUbTWWKI6c/HY4wq3sRDukultq5nSNIOH4RAFsTFD2FbiBB7LDaG
v/9oOqoTUDuR3AkaHFnk5+h5gLRqeePoH1KU8fa7bc7NPatTUVt54SqhQSRfUfrF
+0eRt3WHt2lZpZjaY8kj/vz5AkubzCmwVqSKoLUdCW/qi+UphZHp75E2XXypK/o3
dt1dmPA1D0pXB1WdwLSZjtCn5lIOucdssKLl1UyXQzFmuKBPkjOcuuQqwm5Ietoz
T4EEl/js2iIbui0e5ml9611nZoTLhVYMkxRcLi7gRHWTn9NmVzzJdubJH6Ajwp8E
M9TOi2NtYbSk+pGvTwawfKaw+aROUuKqGOGc+9TFeu+V5pCMAIZ1wybNExZph5jp
/o58QQUdszFwjMq7A4zdXSufKug8CpsYILhtcSx57wtGJ/OW7ZDtmX679x4jAvgX
XeMWuW8x08UFauDBHsvw9aIIgKg7ZlJ+bQ5WdgtsiuXrZEEbTNbW1kjbKAvHS9dP
o3MB/Lbi/rN/448ImnHtShmihh7ug6s+oUDbW6wFzCFvcfLbOs/Sfz35f5wNTHQW
ReNPRgH+pTvzZvulDdrSA6GAnH8mfFE7IkC/3BP6BJE28ug1GvJrRtvylwp29ZW/
Qu0z+FCaFjPu5yOr8rspC9YUdGolKnMg1msMwjgbe58vH9+EDDQ=
=fkgc
-----END PGP SIGNATURE-----

--SrzUzzmYivmDpJiW--
