Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A0891AE258
	for <lists+linux-acpi@lfdr.de>; Fri, 17 Apr 2020 18:36:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726054AbgDQQge (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 17 Apr 2020 12:36:34 -0400
Received: from mout.gmx.net ([212.227.15.19]:46019 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725877AbgDQQgd (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 17 Apr 2020 12:36:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1587141379;
        bh=8pFHmIheWGUpA07/gHTetCESr9IbCxJLIOfzMMbgHGg=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=WeTPuYQ+1EN7d8+OPAJwTSgX3bgAk8+q+ZXUAmsRUbE0a3LX7oFbFuO4O9YI2kszc
         Konc60a2tjowtP+xqW35kmWr/qe3cgz6djNm5rk7Dws7vGox3qHkU+hWdakBl6I13h
         obZvxjFnnfpAED0KlgJP8yXlEQs7bO3hI3Qzt1YI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.178.23] ([77.1.39.83]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MhU9Z-1im0EC2l7r-00ego9; Fri, 17
 Apr 2020 18:36:19 +0200
Subject: Re: regression 5.6.4->5.6.5 at drivers/acpi/ec.c
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Randy Dunlap <rdunlap@infradead.org>
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>,
        ACPI Devel Mailing List <linux-acpi@vger.kernel.org>
References: <fdd9ce1d-146a-5fbf-75c5-3a9384603312@gmx.de>
 <5478a950-4355-8084-ea7d-fe8b270bf2e3@infradead.org>
 <5392275.BHAU0OPJTB@kreacher>
From:   =?UTF-8?Q?Toralf_F=c3=b6rster?= <toralf.foerster@gmx.de>
Autocrypt: addr=toralf.foerster@gmx.de; prefer-encrypt=mutual; keydata=
 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
Message-ID: <4b21c095-fbe5-1138-b977-a505baa41a2b@gmx.de>
Date:   Fri, 17 Apr 2020 18:36:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <5392275.BHAU0OPJTB@kreacher>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:x6KjDxrNJJNddY94VGILPv7evVxzHIDKEZ55GYdd8btiD6AYfA4
 qq7XtisXDOqxY7p6Hk7XUrVvzqJ0+BTDRHQolYc4uItyhL00ZaQo0pUF9EH+xlR3EchHib/
 oV+W7z3rTfNIY8Spgp/dG7822cB8/SZjp3o7cRQjTihqze6563C4RsxWfEJUNLfJ97WqOCq
 CaKmLDRGWUkeJ1c8J53Hg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:4StItY4LyDI=:ddDN8SShJTI0FplmF7pj7I
 YzrPsA2siiscRFL/AGPVkigOSjxs+LafjBoGOhr/mhcwYcLAIvUiM3XUfFmizZb03gJ78O4F3
 lU229v96/0Y3IEG9LxamRY3vpa8w885CCFiVQ2NtKlw32UOYmaB7BPZHjtWeT0w3nC9uphqRp
 gHMylRWI/FtIwxZsHwTTA7ktPSYHIIWzI2s1Hj4fcm3l2y1qB3JiNG8qdlgVuyqIXooai5Irm
 5d9RLssuJqF5fBF2xmCrO6ZdGs44L+uVb75bhSo4MhgyHmromOOeUy2f2UPbVBHWYGjJ1LtHc
 4kcfbEwYx540ExR3DdXRbnWgyTcXAzoJUprx61ICkc8ghz7R6ovGmVjzEZ4XMXJv0ERxTYpqb
 BW8AOHy+StF65NtlGOUR3XL11wwrgn6DD4QNAXR6XDO87BhP1epfOhEN240hhzwYtWfBSFeuJ
 dDPbWLuTalGfgy6d7hTQKdj4QEl43VLTFq2af7CDB48Pw19FTgrKMWW5XvPXcH1vVfsZ8OCW3
 y9T3hD0NBMEkQvO+zk3YyWvWn61oLrNzk1+2PZzlgfcJ4hC3oStY29qPDiyLmMoL7tmzl5L69
 qAEtWK1rwJkQfMjb1TZ3S3EPVQTGY821J6IV1W1o83ppDr6Xl/mt3mfPZo6TzFYJAZHz70UoW
 vvUK2TrWZtwvr0uS5c4FyUMlrs3LHzB5TweN48+CU3Pz+gvtci8oni3ncIjsQ/Z29nltpkYsw
 izqGe+FaUiJc1M7PB2wW6/9+q0gjitTr6oLurJawn80qup3ibWo/Y9ZC8USd+eVtSIYvAw5hR
 IJkmbCF9/UFGcLfWCFnq8Dcc9NcdHYSJsD/AtOVC0nxY37ybeRm1Wb5epwEyFBjP5wmUFy0ne
 wug/R9vRGNZEdE4iGI5oZQLNEt52JGQ4yyFuIu9gENgw0GTJ2Az28lrvwTjweO/nf9vaSHevg
 Ol/qDuC8TJjqBdOURNckvNal9tfw5pvH7ut4in1mOGHCJHDzhIEkoD5xvzy+HVM14xYxHlPgB
 duggus8OEs97J4YsNssf7TVcOrzqPbHgNhIr0ag4rXNbrFqWPKQ2pjt/4MnAmciYi8M25fsZ1
 cmguNmPrqfQNgAabfvbwJEbztXyEHKfScypk9+ZV5ufjKgcjvPCrRyRA6BNPuNu3YdEcva7Mc
 MSWIxxpVIjvKVSSlzSv2eqnivHe7nhUStUBdEzaRGaZxaZamLC69V2hy/Zy5R8PqBrgveOJaB
 aBQRkJi2LxlIuvZu6
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 4/17/20 5:53 PM, Rafael J. Wysocki wrote:
> Does the patch below (untested) make any difference?
>
> ---
>  drivers/acpi/ec.c |    5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> Index: linux-pm/drivers/acpi/ec.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-pm.orig/drivers/acpi/ec.c
> +++ linux-pm/drivers/acpi/ec.c
> @@ -2067,7 +2067,10 @@ static struct acpi_driver acpi_ec_driver
>  		.add =3D acpi_ec_add,
>  		.remove =3D acpi_ec_remove,
>  		},
> -	.drv.pm =3D &acpi_ec_pm,
> +	.drv =3D {
> +		.probe_type =3D PROBE_FORCE_SYNCHRONOUS,
> +		.pm =3D &acpi_ec_pm,
> +	},
>  };
>
>  static void acpi_ec_destroy_workqueues(void)
I'd say no, but for completeness:


pci 0000:03:00.0: reg 0x10: [mem 0xe0400000-0xe0401fff 64bit]
pci 0000:03:00.0: PME# supported from D0 D3hot D3cold
pci 0000:00:1c.1: PCI bridge to [bus 03]
pci 0000:00:1c.1:   bridge window [mem 0xe0400000-0xe04fffff]
ACPI: EC: interrupt unblocked
ACPI: EC: event unblocked
ACPI: EC: EC_CMD/EC_SC=3D0x66, EC_DATA=3D0x62
ACPI: EC: GPE=3D0x25
ACPI: \_SB_.PCI0.LPC_.EC__: Boot ECDT EC initialization complete
ACPI: \_SB_.PCI0.LPC_.EC__: EC: Used to handle transactions and events
ACPI: EC: EC_CMD/EC_SC=3D0x66, EC_DATA=3D0x62
ACPI: EC: GPE=3D0x25
ACPI: \_SB_.PCI0.LPC_.EC__: Boot ECDT EC initialization complete
ACPI: \_SB_.PCI0.LPC_.EC__: EC: Used to handle transactions and events
=2D-----------[ cut here ]------------
Could not request EC data io port 0x62
WARNING: CPU: 2 PID: 1 at drivers/acpi/ec.c:1677 acpi_ec_add+0x26e/0x280
Modules linked in:
CPU: 2 PID: 1 Comm: swapper/0 Tainted: G                T 5.6.5 #6
Hardware name: LENOVO 20AQCTO1WW/20AQCTO1WW, BIOS GJET92WW (2.42 ) 03/03/2=
017
RIP: 0010:acpi_ec_add+0x26e/0x280
Code: fe ff ff 48 8b 75 10 48 c7 c7 d0 27 7b b2 e8 81 c7 b6 ff 0f 0b e9 c9=
 fe ff ff 48 8b 75 18 48 c7 c7 a8 27 7b b2 e8 6a c7 b6 ff <0f> 0b e9 8a fe=
 ff ff 41 bc f4 ff ff ff e9 ac fe ff ff 48 83 3d f8
RSP: 0000:ffffa7e980053c80 EFLAGS: 00010282
RAX: 0000000000000000 RBX: ffffa359700b3800 RCX: 0000000000000000
RDX: 0000000000000026 RSI: ffffffffb306f666 RDI: ffffffffb306fa66
RBP: ffffa35970ab6300 R08: 00000000894e0463 R09: 0000000000000026
R10: 000000000000000f R11: ffffa7e980053aa8 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000001 R15: 0000000000000030
FS:  0000000000000000(0000) GS:ffffa35972700000(0000) knlGS:00000000000000=
00
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 00000001a480a001 CR4: 00000000001606e0
Call Trace:
 acpi_device_probe+0x40/0x100
 really_probe+0xe8/0x2d0
 driver_probe_device+0x57/0xd0
 ? driver_allows_async_probing+0x50/0x50
 bus_for_each_drv+0x90/0xe0
 __device_attach+0xea/0x160
 acpi_bus_register_early_device+0x4b/0x70
 acpi_ec_init+0x2ee/0x361
 acpi_init+0x410/0x4a0
 ? acpi_sleep_proc_init+0x4c/0x4c
 do_one_initcall+0x93/0x1f0
 kernel_init_freeable+0x3e7/0x4cc
 ? rest_init+0xc0/0xc0
 kernel_init+0x6/0x110
 ? rest_init+0xc0/0xc0
 ret_from_fork+0x35/0x40
=2D--[ end trace a946e45fe1b78ebc ]---
=2D-----------[ cut here ]------------
Could not request EC cmd io port 0x66
WARNING: CPU: 2 PID: 1 at drivers/acpi/ec.c:1679 acpi_ec_add+0x257/0x280
Modules linked in:
CPU: 2 PID: 1 Comm: swapper/0 Tainted: G        W       T 5.6.5 #6
Hardware name: LENOVO 20AQCTO1WW/20AQCTO1WW, BIOS GJET92WW (2.42 ) 03/03/2=
017
RIP: 0010:acpi_ec_add+0x257/0x280
Code: 8b 55 00 48 89 ef 48 89 10 e8 65 e0 ff ff 48 8b 2d 4e d7 3b 01 e9 4a=
 fe ff ff 48 8b 75 10 48 c7 c7 d0 27 7b b2 e8 81 c7 b6 ff <0f> 0b e9 c9 fe=
 ff ff 48 8b 75 18 48 c7 c7 a8 27 7b b2 e8 6a c7 b6
RSP: 0000:ffffa7e980053c80 EFLAGS: 00010282
RAX: 0000000000000000 RBX: ffffa359700b3800 RCX: 0000000000000000
RDX: 0000000000000025 RSI: ffffffffb306f665 RDI: ffffffffb306fa65
RBP: ffffa35970ab6300 R08: 000000008997875e R09: 0000000000000025
R10: 000000000000000f R11: ffffa7e980053aa8 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000001 R15: 0000000000000030
FS:  0000000000000000(0000) GS:ffffa35972700000(0000) knlGS:00000000000000=
00
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 00000001a480a001 CR4: 00000000001606e0
Call Trace:
 acpi_device_probe+0x40/0x100
 really_probe+0xe8/0x2d0
 driver_probe_device+0x57/0xd0
 ? driver_allows_async_probing+0x50/0x50
 bus_for_each_drv+0x90/0xe0
 __device_attach+0xea/0x160
 acpi_bus_register_early_device+0x4b/0x70
 acpi_ec_init+0x2ee/0x361
 acpi_init+0x410/0x4a0
 ? acpi_sleep_proc_init+0x4c/0x4c
 do_one_initcall+0x93/0x1f0
 kernel_init_freeable+0x3e7/0x4cc
 ? rest_init+0xc0/0xc0
 kernel_init+0x6/0x110
 ? rest_init+0xc0/0xc0
 ret_from_fork+0x35/0x40
=2D--[ end trace a946e45fe1b78ebd ]---
iommu: Default domain type: Translated
pci 0000:00:02.0: vgaarb: setting as boot VGA device
pci 0000:00:02.0: vgaarb: VGA device added: decodes=3Dio+mem,owns=3Dio+mem=
,locks=3Dnone
pci 0000:00:02.0: vgaarb: bridge control possible
vgaarb: loaded
SCSI subsystem initialized
libata version 3.00 loaded.
ACPI: bus type USB registered
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
pps_core: LinuxPPS API ver. 1 registered

=2D-
Toralf
