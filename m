Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FE6644707C
	for <lists+linux-acpi@lfdr.de>; Sat,  6 Nov 2021 21:56:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbhKFU7Y (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 6 Nov 2021 16:59:24 -0400
Received: from mout.gmx.net ([212.227.17.20]:45699 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229723AbhKFU7X (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sat, 6 Nov 2021 16:59:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1636232056;
        bh=Mwd00qb2ZiJx72AR8VOZy+k9pKeasCOoFRxt9I1uV2U=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=C0sCrT8yqXlZxZN/D8t3r5AoxwhULAsJ8jy0NerNyYtNdbWgnqBYX9Y6CiU9MHxYu
         zquWuU6nUJY+jyfB4yNiyLcx1VtjpHa5bjIspLTdTbHxN0xolbUGlTJ6HhUeKdKZyT
         nslIEB0sT9+3bcpa5ZRh7JRv4jOvvxznOxhoRVuE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([87.79.195.52]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MOA3F-1n7sEw3p2f-00OWCa; Sat, 06
 Nov 2021 21:54:16 +0100
Date:   Sat, 6 Nov 2021 21:54:06 +0100
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Lee Jones <lee.jones@linaro.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
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
        Chen-Yu Tsai <wens@csie.org>,
        Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Tony Lindgren <tony@atomide.com>,
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
Message-ID: <YYbqlmOM95q7Hbjo@latitude>
References: <20211027211715.12671-1-digetx@gmail.com>
 <20211027211715.12671-28-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="EIEte5+tjVxDHmE6"
Content-Disposition: inline
In-Reply-To: <20211027211715.12671-28-digetx@gmail.com>
X-Provags-ID: V03:K1:SVFlmtuvvynO7MrtDzObaEyN/WaPcv8tOsGAlIRvdbuKBKDAEQ/
 nVePqR5eYOMd9xdpGO5unEqHbls4MbMcwDHHiD/2xW054xRTDPzVuInIGVNwfhVnOpuaRe4
 ac8qzmvsisWAHTSwATyyh2lQM4j3GTT+YgfTlnX+xnTkWWDcDQ1QJM/FLNOUp2gu+vKNebi
 4PIdlh56euOWziRZzNIlQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:u5Fne7zv3PE=:dNBEMEjx9T9adiFRODtMYS
 bP1c0hzh59ZKklI1R2cCTJxmTQB45y+QzZX2y0PFbg7yQDeDmSxw52obaEhQa1OdTD86QHXVu
 bbxucMZOIMSbjbLPCif24qpNcHVpf4XClB+BVAEEUwNoQd2u+UA3qLozpzzQZNC8E146erRcl
 EAKHMtg1jl5nUIbs95J8LLOgltdAEihA4JrPrtzt7z304ULnl8JDCKZ1GtxLnSmRKL2GPNjji
 BW4Wh4ednr1BPkh3V5pGtcs7sYJeT+fCg9+1Ao3TSUyI/IMvOamAK8fVGMSOSa8NHso9PeZQG
 p+/g7H+fY7krRTHyMZXbNHeGC6zFFjT+rzUWo+KzQQxtKMn72KqFsaG2rKGpecWbyuM0yrSA3
 xhBNrwHcineUl3uAIRxEl8UFkkXss6eAsh3Q7PLKHNXtaR46/z4OumfDtDC9mwHJVuXp9n3KM
 M7BF+sRUvasT/1Hjw3WGpiUE/z6upYRlSC4e82UllEXyFN6W5gyX4r9kjFZV6JMJQR4UbuEW1
 4g31iHAtTXNZxCvREA7FhQCKM9rtiy8KysUGnceOt3v+aXNzH7SzuQRyJ9+2MgAUQhI7LT2+v
 VClVfxb0rprv/xqBe8DR8WZ7vcK3mCHHlNMCIkYs+6FCITYMw1DHU+CCMKRJej3SCQwR1LGqj
 hUPkhNKbB6PRt/vk+6c77kVWLHqNnHOCN73BdRo6Txp4mZxNOEbbazHi+tZW5jEpWLgiTWfNM
 nvxwa10sJSG8hWu5gGN/aF40RAay1aoGu/k5TA+el84toB3VY6ini0lBJUlrb8M4zbzR9pa9/
 Pm44sh1ruNP7AzMnsBiAzzZX6lqJDAsa+TO5YVhuM9bbKS9hD1KoschPm0B4aJf++t2+ahC/M
 b/QH4Oe5cluIsKILSHGZSoRrX9sqCtW26taTpZQSEsbNePGKbzsw8Oa3lejuRZ+LJbcUK2xLt
 ttQpHqsFbUZlBFAYwpFpRbcNm/+LQLWVCLIU9Rk9O9c0hSOeoGw2PLPC+aL/hsmQVrqlLI/F5
 NAfMG2YBy//Wmh7LL2E3535/ea8r6g8I6Rr7Y4YuBRiuLWpoBhkDI8ZJxuoe0BuQmictlfruZ
 QdH3qyP8a6Ex3I=
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


--EIEte5+tjVxDHmE6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Oct 28, 2021 at 12:16:57AM +0300, Dmitry Osipenko wrote:
> Use devm_register_power_handler() that replaces global pm_power_off
> variable and allows to register multiple power-off handlers. It also
> provides restart-handler support, i.e. all in one API.
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---

When I boot with (most of) this patchset applied, I get the warning at
kernel/reboot.c:187:

	/*
	 * Handler must have unique priority. Otherwise call order is
	 * determined by registration order, which is unreliable.
	 */
	WARN_ON(!atomic_notifier_has_unique_priority(&restart_handler_list, nb));

As the NTXEC driver doesn't specify a priority, I think this is an issue
to be fixed elsewhere.

Other than that, it works and looks good, as far as I can tell.


For this patch:

Reviewed-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
Tested-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>


Best regards,
Jonathan
---

Full Oops log:

[    3.523294] ------------[ cut here ]------------
[    3.528193] WARNING: CPU: 0 PID: 1 at kernel/reboot.c:187 register_resta=
rt_handler+0x4c/0x58
[    3.536975] Modules linked in:
[    3.540312] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.15.0-00021-gcb24=
c628b307 #622
[    3.548214] Hardware name: Freescale i.MX50 (Device Tree Support)
[    3.554357] [<c0111540>] (unwind_backtrace) from [<c010cdd0>] (show_stac=
k+0x10/0x14)
[    3.562183] [<c010cdd0>] (show_stack) from [<c0bf240c>] (dump_stack_lvl+=
0x58/0x70)
[    3.569824] [<c0bf240c>] (dump_stack_lvl) from [<c0127604>] (__warn+0xd4=
/0x154)
[    3.577191] [<c0127604>] (__warn) from [<c0bec844>] (warn_slowpath_fmt+0=
x74/0xa8)
[    3.584727] [<c0bec844>] (warn_slowpath_fmt) from [<c01593c8>] (register=
_restart_handler+0x4c/0x58)
[    3.593823] [<c01593c8>] (register_restart_handler) from [<c08676c8>] (_=
_watchdog_register_device+0x13c/0x27c)
[    3.603889] [<c08676c8>] (__watchdog_register_device) from [<c0867868>] =
(watchdog_register_device+0x60/0xb4)
[    3.613764] [<c0867868>] (watchdog_register_device) from [<c08678f8>] (d=
evm_watchdog_register_device+0x3c/0x84)
[    3.623898] [<c08678f8>] (devm_watchdog_register_device) from [<c1146454=
>] (imx2_wdt_probe+0x254/0x2ac)
[    3.633346] [<c1146454>] (imx2_wdt_probe) from [<c06feb74>] (platform_pr=
obe+0x58/0xb8)
[    3.641314] [<c06feb74>] (platform_probe) from [<c06fb2f8>] (call_driver=
_probe+0x24/0x108)
[    3.649636] [<c06fb2f8>] (call_driver_probe) from [<c06fbe08>] (really_p=
robe.part.0+0xa8/0x358)
[    3.658384] [<c06fbe08>] (really_probe.part.0) from [<c06fc1c4>] (__driv=
er_probe_device+0x94/0x208)
[    3.667470] [<c06fc1c4>] (__driver_probe_device) from [<c06fc368>] (driv=
er_probe_device+0x30/0xc8)
[    3.676468] [<c06fc368>] (driver_probe_device) from [<c06fcb0c>] (__driv=
er_attach+0xe0/0x1c4)
[    3.685032] [<c06fcb0c>] (__driver_attach) from [<c06f9a20>] (bus_for_ea=
ch_dev+0x74/0xc0)
[    3.693253] [<c06f9a20>] (bus_for_each_dev) from [<c06faeb8>] (bus_add_d=
river+0x100/0x208)
[    3.701563] [<c06faeb8>] (bus_add_driver) from [<c06fd8a0>] (driver_regi=
ster+0x88/0x118)
[    3.709696] [<c06fd8a0>] (driver_register) from [<c06fe920>] (__platform=
_driver_probe+0x44/0xdc)
[    3.718522] [<c06fe920>] (__platform_driver_probe) from [<c01022ac>] (do=
_one_initcall+0x78/0x388)
[    3.727444] [<c01022ac>] (do_one_initcall) from [<c1101708>] (do_initcal=
ls+0xcc/0x110)
[    3.735413] [<c1101708>] (do_initcalls) from [<c110198c>] (kernel_init_f=
reeable+0x1ec/0x250)
[    3.743896] [<c110198c>] (kernel_init_freeable) from [<c0bfe724>] (kerne=
l_init+0x10/0x128)
[    3.752224] [<c0bfe724>] (kernel_init) from [<c010011c>] (ret_from_fork+=
0x14/0x38)
[    3.759844] Exception stack(0xc40adfb0 to 0xc40adff8)
[    3.764933] dfa0:                                     00000000 00000000 =
00000000 00000000
[    3.773143] dfc0: 00000000 00000000 00000000 00000000 00000000 00000000 =
00000000 00000000
[    3.781351] dfe0: 00000000 00000000 00000000 00000000 00000013 00000000
[    3.788347] irq event stamp: 143613
[    3.792102] hardirqs last  enabled at (143623): [<c01a3ebc>] __up_consol=
e_sem+0x50/0x60
[    3.800397] hardirqs last disabled at (143632): [<c01a3ea8>] __up_consol=
e_sem+0x3c/0x60
[    3.808491] softirqs last  enabled at (143612): [<c0101518>] __do_softir=
q+0x2f8/0x5b0
[    3.816591] softirqs last disabled at (143603): [<c01307dc>] __irq_exit_=
rcu+0x160/0x1d8
[    3.825014] ---[ end trace 7f6709d2c89774b4 ]---

--EIEte5+tjVxDHmE6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAmGG624ACgkQCDBEmo7z
X9s6ChAAk6BAeo5fWoSSZHjjpn6ATqjK8ym6Qwe2EuauLkxbrtHK3OsbljBzCdtj
p4LUnHOvUjWpnlBRfbbZSXKo5B0LxFtUhe/Cz9IDICft4K2DmOExc+xY9zQNcjMO
rNIxDh4Q8qUdWv4c4B3p812s36yVKoaAGT6XHR9ISWOWmTWq/SNXiFetn9KdMaRs
INw4aNL0grB717V8ucg5RtEOcrLEHRPf6Rv0b6yhfRdBQGx5XCatsdkofBcM9Rlr
ECVr+SDk6hoMvPgqbnK3hh1fU0MGiDoyHN/+PhdW5k71EoqynneLlz1xhU4P1TAQ
4leH70X0lvTJSlpZ+dWkgVGkGzE8LtrjCwhCzZvf+UKqhKf4VWp9LInkiRU2mEaN
ZGeaNLEL/oEE2nHZuWuW8imYr/WoYQKyZX+rG/g+aViMxom4/RC/IF5GFWxInCgi
IBVFSiKxJOwKvKHZrsiJsk+zqcmb1TRObyYd0ecsOPD413IWwnFIl6502QRQolJH
UvdIANNtt2/XORmBBNNGCQtZJ82srfxBpn9jzBtCZu03m4RymWvURbqbIx7mAiz0
6nj5cArubiCB8WOnOcCmsgHzLZDzN2SAy5UFxsELy67LUXWjsGMG++sHbkDuaiji
/h71rvx5wmakG7quyBIQDCUtxgSMJL73yZA4N8UsQABCsmnNXgE=
=jBJI
-----END PGP SIGNATURE-----

--EIEte5+tjVxDHmE6--
