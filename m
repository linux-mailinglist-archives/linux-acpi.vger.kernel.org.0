Return-Path: <linux-acpi+bounces-8122-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BBDF496A9F8
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Sep 2024 23:21:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEB161C24763
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Sep 2024 21:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 961FD1EC005;
	Tue,  3 Sep 2024 21:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="kOs9ZcSa"
X-Original-To: linux-acpi@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE37923D7;
	Tue,  3 Sep 2024 21:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725398468; cv=none; b=hAHtWHCmr6V2wB3DhpjahPZm5bi+0uX4NV+UoD1MQ0f9rj25fXKc3CEgYkalPjAbdubcHH/U5ITs7ePqSPfiO3eDwXZgIFMIzYYTVldnlZ9yOjhmonrp7CIA+bTNgLufxaSPn+mpbtYoIF6HFW6wEbWuvwOa3F13hjyBWqVVhhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725398468; c=relaxed/simple;
	bh=feI6qY4jjD+0WN4jJzjv7SNR+3ZIObQjmhsMuajAvj8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=LhC2s8UOibZyuIJJffdjGBQyoeADNXl/ld1gQP/hbhLRtBo2jI35l5YWDhdss+xIReIHDZHgavXuhR+zL2s6i5c0AzatdOoWpDFE8cm9y5hvLcZ+L7W3ef8yTMc3+zov2ttNP5rSfS6XINcLb2+uu3PspZocrJSUhHMIhXI6qqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=kOs9ZcSa; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1725398453;
	bh=feI6qY4jjD+0WN4jJzjv7SNR+3ZIObQjmhsMuajAvj8=;
	h=From:Date:Subject:To:Cc:From;
	b=kOs9ZcSaDNYpgmnvlD6XIgpAL8KL6ijAY468UvfM3UeW0KzK3w0f9rHbksjxB91i8
	 TUkt3DA1P3oPCrR3axazASEEKv0BXG2p+820FXy9VEVQIHYVIX3ngC/x/Eag9JgHMx
	 HXpgVkInG4DCOPrxjQAmMJfdAScaKpljZFbLPWt8=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Tue, 03 Sep 2024 23:20:46 +0200
Subject: [PATCH] ACPI: battery: use driver core managed async probing
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240903-acpi-battery-async-v1-1-e4deb74fcdba@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAK1912YC/x3MQQ5AMBBA0avIrE0yqgRXEYtRg9mUtCJE3F1j+
 Rb/PxAlqETosgeCnBp18wlFnoFb2S+COiWDIWOppRLZ7YojH4eEGzne3iHTVJmamtqKhRTuQWa
 9/mk/vO8HBWz6lGQAAAA=
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Arjan van de Ven <arjan@linux.intel.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725398452; l=2613;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=feI6qY4jjD+0WN4jJzjv7SNR+3ZIObQjmhsMuajAvj8=;
 b=c3sl/3WAdcpLcoKFP1M1Oy6uCCwv+aUtx8rmefwzdm789nUr68yOznFQY8mrS702OD5z2YeHT
 CRdS9PaoToaDURhH56xpcQX+6Co2StdLJIVDDRES7UCK4TH3J7LIByw
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

In commit 0f66af530116 ("ACPI: battery: asynchronous init") the ACPI
battery driver switched to a custom async driver probing to avoid
delaying the system boot.
In the meantime the driver core gained its own async probing logic for
"slow devices which probing order is not essential for booting the system".
Switch over to the core logic and drop the custom one.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/acpi/battery.c | 31 +++++++------------------------
 1 file changed, 7 insertions(+), 24 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index da3a879d638a..de59a1e80557 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -10,7 +10,6 @@
 
 #define pr_fmt(fmt) "ACPI: battery: " fmt
 
-#include <linux/async.h>
 #include <linux/delay.h>
 #include <linux/dmi.h>
 #include <linux/jiffies.h>
@@ -50,8 +49,6 @@ MODULE_AUTHOR("Alexey Starikovskiy <astarikovskiy@suse.de>");
 MODULE_DESCRIPTION("ACPI Battery Driver");
 MODULE_LICENSE("GPL");
 
-static async_cookie_t async_cookie;
-static bool battery_driver_registered;
 static int battery_bix_broken_package;
 static int battery_notification_delay_ms;
 static int battery_ac_is_broken;
@@ -1311,37 +1308,23 @@ static struct acpi_driver acpi_battery_driver = {
 		.remove = acpi_battery_remove,
 		},
 	.drv.pm = &acpi_battery_pm,
+	.drv.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 };
 
-static void __init acpi_battery_init_async(void *unused, async_cookie_t cookie)
-{
-	int result;
-
-	if (acpi_quirk_skip_acpi_ac_and_battery())
-		return;
-
-	dmi_check_system(bat_dmi_table);
-
-	result = acpi_bus_register_driver(&acpi_battery_driver);
-	battery_driver_registered = (result == 0);
-}
-
 static int __init acpi_battery_init(void)
 {
-	if (acpi_disabled)
+	if (acpi_disabled || acpi_quirk_skip_acpi_ac_and_battery())
 		return -ENODEV;
 
-	async_cookie = async_schedule(acpi_battery_init_async, NULL);
-	return 0;
+	dmi_check_system(bat_dmi_table);
+
+	return acpi_bus_register_driver(&acpi_battery_driver);
 }
 
 static void __exit acpi_battery_exit(void)
 {
-	async_synchronize_cookie(async_cookie + 1);
-	if (battery_driver_registered) {
-		acpi_bus_unregister_driver(&acpi_battery_driver);
-		battery_hook_exit();
-	}
+	acpi_bus_unregister_driver(&acpi_battery_driver);
+	battery_hook_exit();
 }
 
 module_init(acpi_battery_init);

---
base-commit: 67784a74e258a467225f0e68335df77acd67b7ab
change-id: 20240903-acpi-battery-async-a0d5260864e4

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


