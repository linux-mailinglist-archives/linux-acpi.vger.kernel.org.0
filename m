Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 267DD2CF404
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Dec 2020 19:28:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730227AbgLDS1w (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 4 Dec 2020 13:27:52 -0500
Received: from mga01.intel.com ([192.55.52.88]:60456 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730131AbgLDS1w (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 4 Dec 2020 13:27:52 -0500
IronPort-SDR: ykzOAGa1+0dab2T75nu2+g0Wbw7jeHKd5TO8BJRMMHrs3ng8Pc9UpW66kekElszJOKQnLbvrTS
 sVx1jeuC+hAQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9825"; a="191668463"
X-IronPort-AV: E=Sophos;i="5.78,393,1599548400"; 
   d="scan'208";a="191668463"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2020 10:26:07 -0800
IronPort-SDR: H1WGPK39oNj/eNKm23P/oQnORIS9zt0ytKpu554yijiSPqweQjWVR/M5oXdCSal1zg2ML5CvtZ
 Yz3zLMEOmitQ==
X-IronPort-AV: E=Sophos;i="5.78,393,1599548400"; 
   d="scan'208";a="540793142"
Received: from jalmerix-mobl3.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.255.70.143])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2020 10:26:07 -0800
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org (open list:ACPI FAN DRIVER)
Subject: [PATCH] ACPI: fan: fix warning with CONFIG_DEBUG_LOCK_ALLOC
Date:   Fri,  4 Dec 2020 12:25:45 -0600
Message-Id: <20201204182545.8322-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On a TigerLake device with CONFIG_DEBUG_LOCK_ALLOC the following
warning is thrown:

[   13.784413] BUG: key ffff88810ea5a080 has not been registered!
[   13.784722] DEBUG_LOCKS_WARN_ON(1)
[   13.784737] WARNING: CPU: 2 PID: 1 at kernel/locking/lockdep.c:4623
lockdep_init_map_waits+0x25e/0x310
[   13.787831] Call Trace:
[   13.787902]  __kernfs_create_file+0xa5/0x180
[   13.788016]  sysfs_add_file_mode_ns+0x120/0x270
[   13.788138]  sysfs_create_file_ns+0xcd/0x120
[   13.788256]  ? sysfs_add_file_mode_ns+0x270/0x270
[   13.788381]  ? fan_get_max_state+0x70/0x70
[   13.788491]  ? sort_r+0x1a5/0x200
[   13.788579]  acpi_fan_probe+0x63b/0x7a0

Dynamically-allocated attributes need to be initialized to make
lockdep happy, see include/linux/sysfs.h

Fixes: d19e470b6605c ('ACPI: fan: Expose fan performance state information')
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/acpi/fan.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/fan.c b/drivers/acpi/fan.c
index 66c3983f0ccc..9cab806298ff 100644
--- a/drivers/acpi/fan.c
+++ b/drivers/acpi/fan.c
@@ -357,6 +357,7 @@ static int acpi_fan_get_fps(struct acpi_device *device)
 		fps->dev_attr.store = NULL;
 		fps->dev_attr.attr.name = fps->name;
 		fps->dev_attr.attr.mode = 0444;
+		sysfs_attr_init(&fps->dev_attr.attr);
 		status = sysfs_create_file(&device->dev.kobj, &fps->dev_attr.attr);
 		if (status) {
 			int j;
-- 
2.25.1

