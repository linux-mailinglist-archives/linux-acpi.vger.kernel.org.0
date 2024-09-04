Return-Path: <linux-acpi+bounces-8137-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB4BC96B28C
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Sep 2024 09:14:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55D98B26CD7
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Sep 2024 07:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F3B31474B9;
	Wed,  4 Sep 2024 07:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="ou7Rffa8"
X-Original-To: linux-acpi@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1FA146A83;
	Wed,  4 Sep 2024 07:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725433991; cv=none; b=DIjMs0P8wTlCAUf4rGn5E8gQt+Le+pe219EfnwKetqoA3z1QqcT5/1wXD6iNPVj0CUKembu31iK+GuX6vKHVstA7dG2hs+jaeLJod5IHn6oj/I7Q3XXMs8dECAV+Sj9NVCZRObQE8jWBtDsKIDgAt3srgJcvcR3w1RohSspi4VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725433991; c=relaxed/simple;
	bh=/F26bT56Alfb0hZVxsZjubPK5KJki1t5EcCZVGq2Z/M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pGv031iHRCsBBNWU4hfCmOqFBfY/SmxaVCrzGZ45WLB4p//FpX62FvXZgHwhoi8kmNgAEYj4UrF3ttwdaBytVk+U7N+BLXMgeVcKHoNWl0i2E4/LoVtlOXG3lUkFrXOG5MUTwCOq6b+L9tXlM8HMoKubG8g+YGAh4cuEqELr6fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=ou7Rffa8; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1725433985;
	bh=/F26bT56Alfb0hZVxsZjubPK5KJki1t5EcCZVGq2Z/M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ou7Rffa8mn+GyKcKdIBhSyCn5G8aEqsVw1pI6DtCzLTMsaqx7bzxPKwSDIFif8t+X
	 xY/XdRIETapoRnzL3H1+p1hqOCbB6whjOfnfZSb/+ueoRjclNla32UxwGer0ahH6Ss
	 1+id8xguyGY+3byjlM2LPXcbkEO+M24fFt1U/cxI=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Wed, 04 Sep 2024 09:12:55 +0200
Subject: [PATCH 4/5] ACPI: battery: use DEFINE_SIMPLE_DEV_PM_OPS
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240904-acpi-battery-cleanups-v1-4-a3bf74f22d40@weissschuh.net>
References: <20240904-acpi-battery-cleanups-v1-0-a3bf74f22d40@weissschuh.net>
In-Reply-To: <20240904-acpi-battery-cleanups-v1-0-a3bf74f22d40@weissschuh.net>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725433984; l=1499;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=/F26bT56Alfb0hZVxsZjubPK5KJki1t5EcCZVGq2Z/M=;
 b=nCthR7VdRbmYhdGY+0xQsNJJIeRAl9jWACe/UDguKsPm9DUI4LduoH8p4lpUDbctDoAvb0Q3B
 Awn4C5zoD0uDqVw4fbvcyGRW1YoIJZRdj3hpV79nuOiIHUS3m9yh3CU
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Use the recommended macro to define the PM ops.
Also use pm_sleep_ptr() when assigning the ops to the driver.
This allows the removal of the ifdef CONFIG_PM_SLEEP.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/acpi/battery.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index da50ca8df007..4bd746f8c0ac 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -1274,7 +1274,6 @@ static void acpi_battery_remove(struct acpi_device *device)
 	sysfs_remove_battery(battery);
 }
 
-#ifdef CONFIG_PM_SLEEP
 /* this is needed to learn about changes made in suspended state */
 static int acpi_battery_resume(struct device *dev)
 {
@@ -1291,11 +1290,8 @@ static int acpi_battery_resume(struct device *dev)
 	acpi_battery_update(battery, true);
 	return 0;
 }
-#else
-#define acpi_battery_resume NULL
-#endif
 
-static SIMPLE_DEV_PM_OPS(acpi_battery_pm, NULL, acpi_battery_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(acpi_battery_pm, NULL, acpi_battery_resume);
 
 static struct acpi_driver acpi_battery_driver = {
 	.name = "battery",
@@ -1305,7 +1301,7 @@ static struct acpi_driver acpi_battery_driver = {
 		.add = acpi_battery_add,
 		.remove = acpi_battery_remove,
 		},
-	.drv.pm = &acpi_battery_pm,
+	.drv.pm = pm_sleep_ptr(&acpi_battery_pm),
 };
 
 static void __init acpi_battery_init_async(void *unused, async_cookie_t cookie)

-- 
2.46.0


