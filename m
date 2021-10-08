Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95EAD426EE8
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Oct 2021 18:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237689AbhJHQ1g (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 8 Oct 2021 12:27:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:55033 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237468AbhJHQ1X (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 8 Oct 2021 12:27:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633710327;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TARDfeMsRqg/3JhoEm/6776uxW1K8VdCuI/7/bMxpsE=;
        b=T6dkhbJ30oDPLnHd07PYSYJESIOVwNzs5qCo7JPZrPTv5ErYeplBh7OiQoQVzI0tO0Ek23
        VcFxt1TKE0aXKEV2zSwPvlh5cB0MnQWTMuiGr20HQzPqGSVVwd8fTOo7bchgIMfMSKvHAk
        Zs3qCH9EOMH9vZX90qi8WYJi1jHvGEw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-558-kIc4rRLjOv6f4TuZDnxzkg-1; Fri, 08 Oct 2021 12:25:24 -0400
X-MC-Unique: kIc4rRLjOv6f4TuZDnxzkg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2F6EF8464BA;
        Fri,  8 Oct 2021 16:23:18 +0000 (UTC)
Received: from x1.localdomain (unknown [10.39.192.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D46DA60BF1;
        Fri,  8 Oct 2021 16:23:13 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andy@infradead.org>,
        Daniel Scally <djrscally@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Kate Hsuan <hpa@redhat.com>, linux-media@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [PATCH 10/12] platform/x86: int3472: Pass tps68470_clk_platform_data to the tps68470-regulator MFD-cell
Date:   Fri,  8 Oct 2021 18:21:19 +0200
Message-Id: <20211008162121.6628-11-hdegoede@redhat.com>
In-Reply-To: <20211008162121.6628-1-hdegoede@redhat.com>
References: <20211008162121.6628-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Pass tps68470_clk_platform_data to the tps68470-clk MFD-cell,
so that sensors which use the TPS68470 can find their clock.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/platform/x86/intel/int3472/tps68470.c | 28 +++++++++++++------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/drivers/platform/x86/intel/int3472/tps68470.c b/drivers/platform/x86/intel/int3472/tps68470.c
index e95b0f50b384..bd01acb177c4 100644
--- a/drivers/platform/x86/intel/int3472/tps68470.c
+++ b/drivers/platform/x86/intel/int3472/tps68470.c
@@ -5,6 +5,7 @@
 #include <linux/mfd/core.h>
 #include <linux/mfd/tps68470.h>
 #include <linux/platform_device.h>
+#include <linux/platform_data/tps68470.h>
 #include <linux/regmap.h>
 
 #include "common.h"
@@ -17,12 +18,6 @@ static const struct mfd_cell tps68470_cros[] = {
 	{ .name = "tps68470_pmic_opregion" },
 };
 
-static const struct mfd_cell tps68470_win[] = {
-	{ .name = "tps68470-gpio" },
-	{ .name = "tps68470-clk" },
-	{ .name = "tps68470-regulator" },
-};
-
 static const struct regmap_config tps68470_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
@@ -105,10 +100,17 @@ static int skl_int3472_tps68470_calc_type(struct acpi_device *adev)
 static int skl_int3472_tps68470_probe(struct i2c_client *client)
 {
 	struct acpi_device *adev = ACPI_COMPANION(&client->dev);
+	struct tps68470_clk_platform_data clk_pdata = {};
+	struct mfd_cell *cells;
 	struct regmap *regmap;
 	int device_type;
 	int ret;
 
+	ret = skl_int3472_get_sensor_adev_and_name(&client->dev, NULL,
+						   &clk_pdata.consumer_dev_name);
+	if (ret)
+		return ret;
+
 	regmap = devm_regmap_init_i2c(client, &tps68470_regmap_config);
 	if (IS_ERR(regmap)) {
 		dev_err(&client->dev, "Failed to create regmap: %ld\n", PTR_ERR(regmap));
@@ -126,9 +128,19 @@ static int skl_int3472_tps68470_probe(struct i2c_client *client)
 	device_type = skl_int3472_tps68470_calc_type(adev);
 	switch (device_type) {
 	case DESIGNED_FOR_WINDOWS:
-		ret = devm_mfd_add_devices(&client->dev, PLATFORM_DEVID_NONE,
-					   tps68470_win, ARRAY_SIZE(tps68470_win),
+		cells = kcalloc(3, sizeof(*cells), GFP_KERNEL);
+		if (!cells)
+			return -ENOMEM;
+
+		cells[0].name = "tps68470-gpio";
+		cells[1].name = "tps68470-clk";
+		cells[1].platform_data = &clk_pdata;
+		cells[1].pdata_size = sizeof(clk_pdata);
+		cells[2].name = "tps68470-regulator";
+
+		ret = devm_mfd_add_devices(&client->dev, PLATFORM_DEVID_NONE, cells, 3,
 					   NULL, 0, NULL);
+		kfree(cells);
 		break;
 	case DESIGNED_FOR_CHROMEOS:
 		ret = devm_mfd_add_devices(&client->dev, PLATFORM_DEVID_NONE,
-- 
2.31.1

