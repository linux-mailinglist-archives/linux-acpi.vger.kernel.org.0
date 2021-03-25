Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A9E4349977
	for <lists+linux-acpi@lfdr.de>; Thu, 25 Mar 2021 19:26:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbhCYS0C (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 25 Mar 2021 14:26:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:38430 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229533AbhCYSZ3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 25 Mar 2021 14:25:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 50CF6ACFC;
        Thu, 25 Mar 2021 18:25:27 +0000 (UTC)
Message-ID: <9b206c4d00dfe8b7f941260f18909914b2b2eecb.camel@suse.de>
Subject: Re: [PATCH] clk: Mark fwnodes when their clock provider is added
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>, corbet@lwn.net,
        gregkh@linuxfoundation.org, rafael@kernel.org, khilman@kernel.org,
        ulf.hansson@linaro.org, len.brown@intel.com, lenb@kernel.org,
        pavel@ucw.cz, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, frowand.list@gmail.com, maz@kernel.org,
        tglx@linutronix.de, saravanak@google.com
Cc:     nicolas.ferre@microchip.com, claudiu.beznea@microchip.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-acpi@vger.kernel.org,
        geert@linux-m68k.org, kernel-team@android.com,
        linux-rpi-kernel <linux-rpi-kernel@lists.infradead.org>
Date:   Thu, 25 Mar 2021 19:25:24 +0100
In-Reply-To: <d24bebc5-0f78-021f-293f-e58defa32531@samsung.com>
References: <20210205222644.2357303-9-saravanak@google.com>
         <20210210114435.122242-1-tudor.ambarus@microchip.com>
         <20210210114435.122242-2-tudor.ambarus@microchip.com>
         <CGME20210325133159eucas1p297b769beb681743fb32d362a86cc6e3e@eucas1p2.samsung.com>
         <d24bebc5-0f78-021f-293f-e58defa32531@samsung.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-LP3OfhoAoNoMIlo+oggY"
User-Agent: Evolution 3.38.4 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


--=-LP3OfhoAoNoMIlo+oggY
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2021-03-25 at 14:31 +0100, Marek Szyprowski wrote:
> Hi
>=20
> On 10.02.2021 12:44, Tudor Ambarus wrote:
> > This is a follow-up for:
> > commit 3c9ea42802a1 ("clk: Mark fwnodes when their clock provider is ad=
ded/removed")
> >=20
> > The above commit updated the deprecated of_clk_add_provider(),
> > but missed to update the preferred of_clk_add_hw_provider().
> > Update it now.
> >=20
> > Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
>=20
> This patch, which landed in linux-next as commit 6579c8d97ad7 ("clk:=20
> Mark fwnodes when their clock provider is added") causes the following=
=20
> NULL pointer dereference on Raspberry Pi 3b+ boards:
>=20
> --->8---
>=20
> raspberrypi-firmware soc:firmware: Attached to firmware from=20
> 2020-01-06T13:05:25
> Unable to handle kernel NULL pointer dereference at virtual address=20
> 0000000000000050
> Mem abort info:
> =C2=A0=C2=A0 ESR =3D 0x96000004
> =C2=A0=C2=A0 EC =3D 0x25: DABT (current EL), IL =3D 32 bits
> =C2=A0=C2=A0 SET =3D 0, FnV =3D 0
> =C2=A0=C2=A0 EA =3D 0, S1PTW =3D 0
> Data abort info:
> =C2=A0=C2=A0 ISV =3D 0, ISS =3D 0x00000004
> =C2=A0=C2=A0 CM =3D 0, WnR =3D 0
> [0000000000000050] user address but active_mm is swapper
> Internal error: Oops: 96000004 [#1] PREEMPT SMP
> Modules linked in:
> CPU: 0 PID: 10 Comm: kworker/0:1 Not tainted 5.12.0-rc4+ #2764
> Hardware name: Raspberry Pi 3 Model B (DT)
> Workqueue: events deferred_probe_work_func
> pstate: 00000005 (nzcv daif -PAN -UAO -TCO BTYPE=3D--)
> pc : of_clk_add_hw_provider+0xac/0xe8
> lr : of_clk_add_hw_provider+0x94/0xe8
> sp : ffff8000130936b0
> x29: ffff8000130936b0 x28: ffff800012494e04
> x27: ffff00003b18cb05 x26: ffff00003aa5c010
> x25: 0000000000000000 x24: 0000000000000000
> x23: ffff00003aa1e380 x22: ffff8000106830d0
> x21: ffff80001233f180 x20: 0000000000000018
> x19: 0000000000000000 x18: ffff8000124d38b0
> x17: 0000000000000013 x16: 0000000000000014
> x15: ffff8000125758b0 x14: 00000000000184e0
> x13: 000000000000292e x12: ffff80001258dd98
> x11: 0000000000000001 x10: 0101010101010101
> x9 : ffff80001233f288 x8 : 7f7f7f7f7f7f7f7f
> x7 : fefefefeff6c626f x6 : 5d636d8080808080
> x5 : 00000000006d635d x4 : 0000000000000000
> x3 : 0000000000000000 x2 : 540eb5edae191600
> x1 : 0000000000000000 x0 : 0000000000000000
> Call trace:
> =C2=A0=C2=A0of_clk_add_hw_provider+0xac/0xe8
> =C2=A0=C2=A0devm_of_clk_add_hw_provider+0x5c/0xb8
> =C2=A0=C2=A0raspberrypi_clk_probe+0x110/0x210
> =C2=A0=C2=A0platform_probe+0x90/0xd8
> =C2=A0=C2=A0really_probe+0x108/0x3c0
> =C2=A0=C2=A0driver_probe_device+0x60/0xc0
> =C2=A0=C2=A0__device_attach_driver+0x9c/0xd0
> =C2=A0=C2=A0bus_for_each_drv+0x70/0xc8
> =C2=A0=C2=A0__device_attach+0xec/0x150
> =C2=A0=C2=A0device_initial_probe+0x10/0x18
> =C2=A0=C2=A0bus_probe_device+0x94/0xa0
> =C2=A0=C2=A0device_add+0x47c/0x780
> =C2=A0=C2=A0platform_device_add+0x110/0x248
> =C2=A0=C2=A0platform_device_register_full+0x120/0x150
> =C2=A0=C2=A0rpi_firmware_probe+0x158/0x1f8
> =C2=A0=C2=A0platform_probe+0x90/0xd8
> =C2=A0=C2=A0really_probe+0x108/0x3c0
> =C2=A0=C2=A0driver_probe_device+0x60/0xc0
> =C2=A0=C2=A0__device_attach_driver+0x9c/0xd0
> =C2=A0=C2=A0bus_for_each_drv+0x70/0xc8
> =C2=A0=C2=A0__device_attach+0xec/0x150
> =C2=A0=C2=A0device_initial_probe+0x10/0x18
> =C2=A0=C2=A0bus_probe_device+0x94/0xa0
> =C2=A0=C2=A0deferred_probe_work_func+0x70/0xa8
> =C2=A0=C2=A0process_one_work+0x2a8/0x718
> =C2=A0=C2=A0worker_thread+0x48/0x460
> =C2=A0=C2=A0kthread+0x134/0x160
> =C2=A0=C2=A0ret_from_fork+0x10/0x18
> Code: b1006294 540000c0 b140069f 54000088 (3940e280)
> ---[ end trace 7ead5ec2f0c51cfe ]---
>=20
> This patch mainly revealed that clk/bcm/clk-raspberrypi.c driver calls=
=20
> devm_of_clk_add_hw_provider(), with a device pointer, which has a NULL=
=20
> dev->of_node. I'm not sure if adding a check for a NULL np in=20
> of_clk_add_hw_provider() is a right fix, though.

I believe the right fix is not to call 'devm_of_clk_add_hw_provider()' if
'pdev->dev.of_node =3D=3D NULL'. In such case, which is RPi3's, only the CP=
U clock
is used, and it's defined and queried later through
devm_clk_hw_register_clkdev().

@Marek, I don't mind taking care of it if it's OK with you.

Regards,
Nicolas



--=-LP3OfhoAoNoMIlo+oggY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAmBc1ZQACgkQlfZmHno8
x/4/cwgApx9UVDHRcpZ+rQEOKxGZTTXSUbWvYW7ZZOKlx/kyViTeiN1O4oP8+r43
gh0xAJOqyscnNko26PhVXwnnbqSHoybYK+M+fr8dXWmEanEPoCAjaRXCua+IOIS5
v8I7LCfC0IEz7hvIl9MHh5Z7o9uemr4gKj4p7KiYDnU2ksZD0/1sCaw2fVq4uS5Z
4yao5SnyTjXcJ3mjmQayPUkh3jGrZkSCC5r7GamGibFq49WLJawONbhscimpFtAn
xylSgcgnkUDiP5X2WM3lYLOfG2rYifXdkUSqahSfw7lmL3YmNlYvUvTk5CZEKc88
wQikLex04QNJMnySXNu/djsgI2v1aA==
=QlQJ
-----END PGP SIGNATURE-----

--=-LP3OfhoAoNoMIlo+oggY--

