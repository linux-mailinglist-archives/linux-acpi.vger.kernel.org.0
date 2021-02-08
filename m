Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF0EF3131B6
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Feb 2021 13:04:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231816AbhBHMD6 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 8 Feb 2021 07:03:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233545AbhBHMBx (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 8 Feb 2021 07:01:53 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99FADC06174A
        for <linux-acpi@vger.kernel.org>; Mon,  8 Feb 2021 04:01:12 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id c18so16596404ljd.9
        for <linux-acpi@vger.kernel.org>; Mon, 08 Feb 2021 04:01:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gpqaC8q+dDCiC/7z/gO4zBXqcNiiB51jlwzypuvmhz4=;
        b=dbyIRxu9Elntvw/tICXuJL2fE7et4as4CfMEcZiRUJ/gnbaIHqR9LEKUq2GkdFjXw8
         Dg7cFh9yZnd/kmDfR8tvHHgwhuEsZVLbnX3FEN9TbdpI9Hyht2n1EkCa3C6ouX1ma3KQ
         ExBgXuKigCVbUoClaaGWyxB2b1LJ1da6bB5R9dTduGotrLuniAjJ0tVzx71VHOoi48zU
         hYY/R6LX8BbjI9EjqNLvHKN4tQIMGusSKvskfzFymlzNfuYSVJG7o4xy4R+uX7T5cZXc
         a7ReveIy4YRvJDdZ/gXRQjM2JCrp+DdB8sbkwHw6gmq+suq/WvfuyV5q7twmK0hoocW/
         Fcig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gpqaC8q+dDCiC/7z/gO4zBXqcNiiB51jlwzypuvmhz4=;
        b=S9qXKZYnRuH9fnAXkkyEHYydJNL1WHqQZpYJYhx7McPGBTCv64ibJ1RQ45U1q/zlJB
         Y20Vl0yKyJdk3KeVRAmB16f+vgC76fTYhBnHCcE7NOubP0+BHs/erGQIphHJkcbg5IIC
         PW75potvnytAuLlEosfFI3lLmAv4bSQJOPcK6EwulH68KXd0gRQxO0W+M6bJRoQjmuaW
         WmnvMsluR0sBHc+bPLboNVoFelDstLNyp1dRvO1T4OkaLBPx/EqP0OhXPwjCRQ+VLQDV
         DGA0gtwFbjclwj/xubCQqZJ5hYP2UU0ym3tKkPM3IaPo0Ow7KTHEY6raiQ5ATxh6RNyy
         A5GA==
X-Gm-Message-State: AOAM532Q7/Nsd/30JiyHOdL3SNKE256ZUayLQVlDzF6ApRFzMaM3m3pe
        KT0/M5HIRL+72WCHNB767qQos0qV8oxJQA==
X-Google-Smtp-Source: ABdhPJwLCranmkEPlpkEV80x6Krw4T91MOjPD+rJNZqqEDaGa2bwb9utJcuBc4tfV+GQvDhihY9J3w==
X-Received: by 2002:a2e:9b03:: with SMTP id u3mr503050lji.216.1612785671058;
        Mon, 08 Feb 2021 04:01:11 -0800 (PST)
Received: from localhost.localdomain (109241203030.gdansk.vectranet.pl. [109.241.203.30])
        by smtp.gmail.com with ESMTPSA id t15sm719086lft.239.2021.02.08.04.01.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 04:01:10 -0800 (PST)
From:   =?UTF-8?q?Marcin=20=C5=9Alusarz?= <marcin.slusarz@gmail.com>
To:     alsa-devel@alsa-project.org, linux-acpi@vger.kernel.org
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Salvatore Bonaccorso <carnil@debian.org>,
        marcin.slusarz@intel.com
Subject: [PATCH 1/2] soundwire: intel: fix possible crash when no device is detected
Date:   Mon,  8 Feb 2021 13:01:03 +0100
Message-Id: <20210208120104.204761-1-marcin.slusarz@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <a3f01a5d-d7a5-8280-4091-b2486b01a782@linux.intel.com>
References: <a3f01a5d-d7a5-8280-4091-b2486b01a782@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Marcin Ślusarz <marcin.slusarz@intel.com>

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
CPU: 6 PID: 472 Comm: systemd-udevd Tainted: G        W         5.10.0-1-amd64 #1 Debian 5.10.4-1
Hardware name: HP HP Pavilion Laptop 15-cs3xxx/86E2, BIOS F.05 01/01/2020
RIP: 0010:acpi_ns_validate_handle+0x1a/0x23
Code: 00 48 83 c4 10 5b 5d 41 5c 41 5d 41 5e 41 5f c3 0f 1f 44 00 00 48 8d 57 ff 48 89 f8 48 83 fa fd 76 08 48 8b 05 0c b8 67 01 c3 <80> 7f 08 0f 74 02 31 c0 c3 0f 1f 44 00 00 48 8b 3d f6 b7 67 01 e8
RSP: 0000:ffffc388807c7b20 EFLAGS: 00010213
RAX: 0000000000000048 RBX: ffffc388807c7b70 RCX: 0000000000000000
RDX: 0000000000000047 RSI: 0000000000000246 RDI: 0000000000000048
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: ffffffffc0f5f4d1 R11: ffffffff8f0cb268 R12: 0000000000001001
R13: ffffffff8e33b160 R14: 0000000000000048 R15: 0000000000000000
FS:  00007f24548288c0(0000) GS:ffff9f781fb80000(0000) knlGS:0000000000000000
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
Signed-off-by: Marcin Ślusarz <marcin.slusarz@intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/intel_init.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/soundwire/intel_init.c b/drivers/soundwire/intel_init.c
index cabdadb09a1b..bc8520eb385e 100644
--- a/drivers/soundwire/intel_init.c
+++ b/drivers/soundwire/intel_init.c
@@ -405,11 +405,12 @@ int sdw_intel_acpi_scan(acpi_handle *parent_handle,
 {
 	acpi_status status;
 
+	info->handle = NULL;
 	status = acpi_walk_namespace(ACPI_TYPE_DEVICE,
 				     parent_handle, 1,
 				     sdw_intel_acpi_cb,
 				     NULL, info, NULL);
-	if (ACPI_FAILURE(status))
+	if (ACPI_FAILURE(status) || info->handle == NULL)
 		return -ENODEV;
 
 	return sdw_intel_scan_controller(info);
-- 
2.25.1

