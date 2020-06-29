Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CFD120E1B3
	for <lists+linux-acpi@lfdr.de>; Mon, 29 Jun 2020 23:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731665AbgF2U6m (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 29 Jun 2020 16:58:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731247AbgF2TNC (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 29 Jun 2020 15:13:02 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22BB3C0085C5;
        Mon, 29 Jun 2020 04:16:26 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: andrzej.p)
        with ESMTPSA id CFAED2A0518
From:   Andrzej Pietrasiewicz <andrzej.p@collabora.com>
To:     linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
        netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Vishal Kulkarni <vishal@chelsio.com>,
        "David S . Miller" <davem@davemloft.net>,
        Jiri Pirko <jiri@mellanox.com>,
        Ido Schimmel <idosch@mellanox.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Intel Linux Wireless <linuxwifi@intel.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Peter Kaestle <peter@piie.net>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Sebastian Reichel <sre@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Support Opensource <support.opensource@diasemi.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        Heiko Stuebner <heiko@sntech.de>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Allison Randal <allison@lohutok.net>,
        Enrico Weigelt <info@metux.net>,
        Gayatri Kammela <gayatri.kammela@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v6 01/11] acpi: thermal: Fix error handling in the register function
Date:   Mon, 29 Jun 2020 13:16:05 +0200
Message-Id: <20200629111615.18131-2-andrzej.p@collabora.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200629111615.18131-1-andrzej.p@collabora.com>
References: <CAHLCerO2XOOX9akEwaTu_cjSqRycFpNmoVxkSe36L8B4ALWidA@mail.gmail.com>
 <20200629111615.18131-1-andrzej.p@collabora.com>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The acpi_thermal_register_thermal_zone() is missing any error handling.
This needs to be fixed.

Signed-off-by: Andrzej Pietrasiewicz <andrzej.p@collabora.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/acpi/thermal.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index 19067a5e5293..6de8066ca1e7 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -901,23 +901,35 @@ static int acpi_thermal_register_thermal_zone(struct acpi_thermal *tz)
 	result = sysfs_create_link(&tz->device->dev.kobj,
 				   &tz->thermal_zone->device.kobj, "thermal_zone");
 	if (result)
-		return result;
+		goto unregister_tzd;
 
 	result = sysfs_create_link(&tz->thermal_zone->device.kobj,
 				   &tz->device->dev.kobj, "device");
 	if (result)
-		return result;
+		goto remove_tz_link;
 
 	status =  acpi_bus_attach_private_data(tz->device->handle,
 					       tz->thermal_zone);
-	if (ACPI_FAILURE(status))
-		return -ENODEV;
+	if (ACPI_FAILURE(status)) {
+		result = -ENODEV;
+		goto remove_dev_link;
+	}
 
 	tz->tz_enabled = 1;
 
 	dev_info(&tz->device->dev, "registered as thermal_zone%d\n",
 		 tz->thermal_zone->id);
+
 	return 0;
+
+remove_dev_link:
+	sysfs_remove_link(&tz->thermal_zone->device.kobj, "device");
+remove_tz_link:
+	sysfs_remove_link(&tz->device->dev.kobj, "thermal_zone");
+unregister_tzd:
+	thermal_zone_device_unregister(tz->thermal_zone);
+
+	return result;
 }
 
 static void acpi_thermal_unregister_thermal_zone(struct acpi_thermal *tz)
-- 
2.17.1

