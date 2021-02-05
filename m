Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0A80311566
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Feb 2021 23:32:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231634AbhBEWaH (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 5 Feb 2021 17:30:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232504AbhBEOSh (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 5 Feb 2021 09:18:37 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFABEC0617A9
        for <linux-acpi@vger.kernel.org>; Fri,  5 Feb 2021 07:46:21 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id s18so8273636ljg.7
        for <linux-acpi@vger.kernel.org>; Fri, 05 Feb 2021 07:46:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hMpmQh4IUGRgsJR41Q5X9O/NGLMcy5IsXFZf5uXN0uE=;
        b=IJo69IA1k7ICZONK1GmjaPJo25auJq/6rtFYOIo6g9nOx25hASkYn+k7bo3CHWK9MU
         1Q3dfns4ztDCk4a4GVanSiSUVrum+vzS8pvAJFaEfjaCehasPOELf6vX4pqwVVwmKLjq
         cA/36LGh1i1gYNuGGgTcWcMK9PtFxvXznsXw0z75iw6g+eWWMdsT2HsZDxFsizJSl8gh
         oaj1maZW2LSb6rRdke7YBQMfBQEkp1e/LvijVXqS4T3gw5bg9vljfYDCBzKzTriH0YwG
         C5f04Jg3PBdSpHb1LYIP+hSVPxZVMBZCgVdUnHovAoWVO4i5fMYHm9l7WLpsNMEyEXy2
         slSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hMpmQh4IUGRgsJR41Q5X9O/NGLMcy5IsXFZf5uXN0uE=;
        b=C+Nzup/Njw2UnrU1nqIPRT48XtAMymbMEijwVLsZiTB5zE1QG8go8X9BV2xO1WANMz
         2Abt8Dn6gD9YRigrzxxhNiPiYBbLxzOt0+Y2aYuzTibcLqIhV90z5oFXd8yKjdxO1WqX
         tkX35gf9JRY6B9OqtH+VBVV7WKLMC2EZSqtgO9XSiGraiAwPFEkQ1107J+2V1lqUreRR
         JEJFw/DqYrnkiU8p24Mewg9Qv6V5loqtBW6SIZY/WEJuxTiCkpA0eYKhp7cIAC0zzpPb
         zNZzJaA/uGydWEpxAStOmFh3ibdE+aBOO8Cx/xIBdUJtmb/qt0R/fUFGPdOA9aVGu+Ip
         7Erg==
X-Gm-Message-State: AOAM532gkvgnU8I+u98TpeRxzIs5q8+DUHSn7XZbllzs5O3vg5oIO1Xb
        oRb+N9M2f+dG36N0c/c1eJtwr3CxsJtmWJBPd+oVKz7XLmI=
X-Google-Smtp-Source: ABdhPJzgiylGZL3GclcK4A9lJV7QmdtPi0OudetSRY4KXjxdPlFjtQ8KqBvA6S4SV5UQF+zSWH1Qye8Txe6/mHnUr0g=
X-Received: by 2002:adf:f40d:: with SMTP id g13mr5666864wro.142.1612539633762;
 Fri, 05 Feb 2021 07:40:33 -0800 (PST)
MIME-Version: 1.0
References: <CA+GA0_sPC3rp5K4qwZm-u+W1C=+2Y2p-dbF4DMdHkKaTpeKKkg@mail.gmail.com>
 <CAJZ5v0iapmc8ywuySwexwTagKr89Hj7TPXkAvd_HXMhdLoyyQQ@mail.gmail.com>
 <1f0f7273-597e-cdf0-87d1-908e56c13133@linux.intel.com> <CA+GA0_v3JUWS3G3=R4XuQ=OW91cpwiBP1Rp=uzYOF8c9TUJ46w@mail.gmail.com>
 <CA+GA0_sCdowanpZmg==c+xVqqNxG5whLGsKHaCfSmpERBhqMzA@mail.gmail.com>
 <1dc2639a-ecbc-c554-eaf6-930256dcda96@linux.intel.com> <CA+GA0_sZm2pqOfA3LsNQowb930QS_g5CiCCGthzsS=vAjB9Rjg@mail.gmail.com>
 <CAJZ5v0h+Kwn5u293QO+H2rfGx-ZMBr18tMCLB7jHKHWWRaovOw@mail.gmail.com>
 <CAJZ5v0h8abkdrdN97RHouzxynPBFXBoAuMSb7Zy56+-sTXkPKQ@mail.gmail.com>
 <CA+GA0_vYdxFj_SPWgdkufo04VaOuWqcNTSck6gvnMfN07ZdO_Q@mail.gmail.com>
 <CA+GA0_vKyJZSQZ9bA6_BSDeGfRZ_nz86gj2aVHaOoy1h57CMzA@mail.gmail.com>
 <CA+GA0_u8NA90GmMSDO-Ejg-C2YEXCn8rnVZpk-_+eXcDm7XRpg@mail.gmail.com>
 <CAJZ5v0hqHihRdad16Djo+R1ezjFHt2YffgDg59TYYKJSSjmA4Q@mail.gmail.com>
 <CA+GA0_s7atD4O_DP0NXwVUVvdia2NWwSEfW2Mcw-UoJ9effPvg@mail.gmail.com>
 <CA+GA0_sZQXACjuzYYvrJq-vF-mmjaq82SJ=kifqo4Utv45s5Yg@mail.gmail.com> <CA+GA0_vSA51NbyTDtW-2A4aCCp+xXN_BtJfPFAJesRYM0eo9WQ@mail.gmail.com>
In-Reply-To: <CA+GA0_vSA51NbyTDtW-2A4aCCp+xXN_BtJfPFAJesRYM0eo9WQ@mail.gmail.com>
From:   =?UTF-8?Q?Marcin_=C5=9Alusarz?= <marcin.slusarz@gmail.com>
Date:   Fri, 5 Feb 2021 16:40:05 +0100
Message-ID: <CA+GA0_sOQeQsaa1JFO3+ySqdLU6BNxrJRrHjqtheEuj60ZmwhA@mail.gmail.com>
Subject: [PATCH] soundwire: intel: fix possible crash when no device is
  detected (was Re: Crash in acpi_ns_validate_handle triggered by soundwire on
 Linux 5.10)
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        Erik Kaneda <erik.kaneda@intel.com>,
        "Slusarz, Marcin" <marcin.slusarz@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Well, this is embarrassing. There's no compiler bug, just me being
confused, because I looked at handle instead of *handle.
The stack protector thing was of course a red herring - it
changed what is on the stack and where...

If the patch below will be corrupted by the Gmail interface, I also
pushed it here:
https://github.com/marcinslusarz/linux/tree/soundwire_fix

----
From: =3D?UTF-8?q?Marcin=3D20=3DC5=3D9Alusarz?=3D <marcin.slusarz@intel.com=
>
Subject: [PATCH] soundwire: intel: fix possible crash when no device is
 detected

acpi_walk_namespace can return success without executing our
callback which initializes info->handle.
If the random value in this structure is a valid address (which
is on the stack, so it's quite possible), then nothing bad will
happen, because:
sdw_intel_scan_controller
 -> acpi_bus_get_device
 -> acpi_get_device_data
 -> acpi_get_data_full
 -> acpi_ns_validate_handle
will reject this handle.

However, if the value from the stack doesn't point to a valid
address, we get this:

BUG: kernel NULL pointer dereference, address: 0000000000000050
PGD 0 P4D 0
Oops: 0000 [#1] SMP NOPTI
CPU: 6 PID: 472 Comm: systemd-udevd Tainted: G        W
5.10.0-1-amd64 #1 Debian 5.10.4-1
Hardware name: HP HP Pavilion Laptop 15-cs3xxx/86E2, BIOS F.05 01/01/2020
RIP: 0010:acpi_ns_validate_handle+0x1a/0x23
Code: 00 48 83 c4 10 5b 5d 41 5c 41 5d 41 5e 41 5f c3 0f 1f 44 00 00
48 8d 57 ff 48 89 f8 48 83 fa fd 76 08 48 8b 05 0c b8 67 01 c3 <80> 7f
08 0f 74 02 31 c0 c3 0f 1f 44 00 00 48 8b 3d f6 b7 67 01 e8
RSP: 0000:ffffc388807c7b20 EFLAGS: 00010213
RAX: 0000000000000048 RBX: ffffc388807c7b70 RCX: 0000000000000000
RDX: 0000000000000047 RSI: 0000000000000246 RDI: 0000000000000048
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: ffffffffc0f5f4d1 R11: ffffffff8f0cb268 R12: 0000000000001001
R13: ffffffff8e33b160 R14: 0000000000000048 R15: 0000000000000000
FS:  00007f24548288c0(0000) GS:ffff9f781fb80000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000050 CR3: 0000000106158004 CR4: 0000000000770ee0
PKRU: 55555554
Call Trace:
 acpi_get_data_full+0x4d/0x92
 acpi_bus_get_device+0x1f/0x40
 sdw_intel_acpi_scan+0x59/0x230 [soundwire_intel]
 ? strstr+0x22/0x60
 ? dmi_matches+0x76/0xe0
 snd_intel_dsp_driver_probe.cold+0xaf/0x163 [snd_intel_dspcfg]
 azx_probe+0x7a/0x970 [snd_hda_intel]
 local_pci_probe+0x42/0x80
 ? _cond_resched+0x16/0x40
 pci_device_probe+0xfd/0x1b0
 really_probe+0x205/0x460
 driver_probe_device+0xe1/0x150
 device_driver_attach+0xa1/0xb0
 __driver_attach+0x8a/0x150
 ? device_driver_attach+0xb0/0xb0
 ? device_driver_attach+0xb0/0xb0
 bus_for_each_dev+0x78/0xc0
 bus_add_driver+0x12b/0x1e0
 driver_register+0x8b/0xe0
 ? 0xffffffffc0f65000
 do_one_initcall+0x44/0x1d0
 ? do_init_module+0x23/0x250
 ? kmem_cache_alloc_trace+0xf5/0x200
 do_init_module+0x5c/0x250
 __do_sys_finit_module+0xb1/0x110
 do_syscall_64+0x33/0x80
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

CC: stable@vger.kernel.org
Signed-off-by: Marcin =C5=9Alusarz <marcin.slusarz@intel.com>
---
 drivers/soundwire/intel_init.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/soundwire/intel_init.c b/drivers/soundwire/intel_init.=
c
index cabdadb09a1b..bc8520eb385e 100644
--- a/drivers/soundwire/intel_init.c
+++ b/drivers/soundwire/intel_init.c
@@ -405,11 +405,12 @@ int sdw_intel_acpi_scan(acpi_handle *parent_handle,
 {
     acpi_status status;

+    info->handle =3D NULL;
     status =3D acpi_walk_namespace(ACPI_TYPE_DEVICE,
                      parent_handle, 1,
                      sdw_intel_acpi_cb,
                      NULL, info, NULL);
-    if (ACPI_FAILURE(status))
+    if (ACPI_FAILURE(status) || info->handle =3D=3D NULL)
         return -ENODEV;

     return sdw_intel_scan_controller(info);
--=20
2.29.2
