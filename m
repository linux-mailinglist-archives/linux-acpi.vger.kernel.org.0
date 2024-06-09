Return-Path: <linux-acpi+bounces-6282-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 51DA59014D3
	for <lists+linux-acpi@lfdr.de>; Sun,  9 Jun 2024 09:28:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C68F8B2178A
	for <lists+linux-acpi@lfdr.de>; Sun,  9 Jun 2024 07:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B43E12C87C;
	Sun,  9 Jun 2024 07:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="eIfy82LF"
X-Original-To: linux-acpi@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E22219FD;
	Sun,  9 Jun 2024 07:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717918044; cv=none; b=fqci4wl9CTXgFqz9pdryBH0V1KcQLG9YukJoVZYeWT2t5LU0C+5n9Fn6MdzDbNdJSaOQ8x3KbOPNQs9BjsLi+JmQh6Esz+zN28zL/78+vzP8hS7Y7jxcLNboKMSeL5xjYrqaH4+IGQim12ZGAZIL9T4CEhRZIUG5hDTYBLWwSZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717918044; c=relaxed/simple;
	bh=crKUY1rY4xCPn07shXAjd8yyC8WWLChy41PfeTmkTLE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oer0+En97CiFwCbw6NO0S+w4/ioMnXr3QJdyqZa0JEM1YvejVZrFg1NKRoRKbhgPbQfMYJwpLw9/ic6LHpJ223zuJEaE0d0v38sLLWB2Q5yOF+ftLtTCQ6TkYjsGcXL/mpk/h0MXvwDfnP774liUgEvc6mAoPvbhTQ3CDfWPgcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=eIfy82LF; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1717918036;
	bh=crKUY1rY4xCPn07shXAjd8yyC8WWLChy41PfeTmkTLE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=eIfy82LF79CnPxY5a4+4mXzbxRUaYo9O4Rolis+0ggjr4mKPMj9hYi/ie0bDyqIPF
	 C4/O1836cwGCmWXnOKa4ZjFCUBRLHWczfjX5L1s3SxQDUNm0ayrpD3OUX3uUeNThz1
	 JoTEq98oM59wSoDzrK/O/Q6lUCc5mXVsu4ZAea8E=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sun, 09 Jun 2024 09:27:16 +0200
Subject: [PATCH 5/5] ACPI: battery: create alarm sysfs attribute atomically
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240609-acpi-battery-cleanup-v1-5-344517bdca73@weissschuh.net>
References: <20240609-acpi-battery-cleanup-v1-0-344517bdca73@weissschuh.net>
In-Reply-To: <20240609-acpi-battery-cleanup-v1-0-344517bdca73@weissschuh.net>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717918035; l=2012;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=crKUY1rY4xCPn07shXAjd8yyC8WWLChy41PfeTmkTLE=;
 b=fdI38Y5I3pGAfU1AoOjow1ssMuRGbzcNtkhpOEGqmmuWM9N3FwfjdQW62IZuTY09byfjbm44f
 DQiAHhiP1s0BZYLt1BVHULXa8hByYQ1HePR7ctc9dZQq4ZmxmfTANYt
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Let the power supply core register the attribute.
This ensures that the attribute is created before the device is
announced to userspace, avoid a race condition.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/acpi/battery.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 5f47bd58aff3..d289b98a2cca 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -678,12 +678,18 @@ static ssize_t acpi_battery_alarm_store(struct device *dev,
 	return count;
 }
 
-static const struct device_attribute alarm_attr = {
+static struct device_attribute alarm_attr = {
 	.attr = {.name = "alarm", .mode = 0644},
 	.show = acpi_battery_alarm_show,
 	.store = acpi_battery_alarm_store,
 };
 
+static struct attribute *acpi_battery_attrs[] = {
+	&alarm_attr.attr,
+	NULL
+};
+ATTRIBUTE_GROUPS(acpi_battery);
+
 /*
  * The Battery Hooking API
  *
@@ -823,7 +829,10 @@ static void __exit battery_hook_exit(void)
 
 static int sysfs_add_battery(struct acpi_battery *battery)
 {
-	struct power_supply_config psy_cfg = { .drv_data = battery, };
+	struct power_supply_config psy_cfg = {
+		.drv_data = battery,
+		.attr_grp = acpi_battery_groups,
+	};
 	bool full_cap_broken = false;
 
 	if (!ACPI_BATTERY_CAPACITY_VALID(battery->full_charge_capacity) &&
@@ -868,7 +877,7 @@ static int sysfs_add_battery(struct acpi_battery *battery)
 		return result;
 	}
 	battery_hook_add_battery(battery);
-	return device_create_file(&battery->bat->dev, &alarm_attr);
+	return 0;
 }
 
 static void sysfs_remove_battery(struct acpi_battery *battery)
@@ -879,7 +888,6 @@ static void sysfs_remove_battery(struct acpi_battery *battery)
 		return;
 	}
 	battery_hook_remove_battery(battery);
-	device_remove_file(&battery->bat->dev, &alarm_attr);
 	power_supply_unregister(battery->bat);
 	battery->bat = NULL;
 	mutex_unlock(&battery->sysfs_lock);

-- 
2.45.2


