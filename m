Return-Path: <linux-acpi+bounces-6283-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7774C9015E3
	for <lists+linux-acpi@lfdr.de>; Sun,  9 Jun 2024 13:13:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20C231F21235
	for <lists+linux-acpi@lfdr.de>; Sun,  9 Jun 2024 11:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 577D12C190;
	Sun,  9 Jun 2024 11:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="dPVBYW5Z"
X-Original-To: linux-acpi@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A787B282E5;
	Sun,  9 Jun 2024 11:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717931619; cv=none; b=EVHJICLiMWdaeNe1GujqgbT3VnZPdK7VBW4Zox8S0edekALaujahJo2x9qTV0rmR7M1IkjFNJnhjTEsAYNf2PjQqLedZ9/In9MqLGT0HAsWKcE33ZyD6oq0YmEVxVFHjYaz2BAoBLe7O2qThII9mT29pa27JIUcox4TajIL9ix0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717931619; c=relaxed/simple;
	bh=BV+oswdjo+GnBuL0pDMh4r7BZxfSayoPjlLPADR1Rl8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=NDlDa3nzOd6zfv0wC1aBUGB26IXWpr/3y9Hpgn3+DgXa1rQaGlt881vzpGu5HV0Y0PCAdwIO2XHNEK/1bIvsp7nDUOLshZP2KE3i4Uivq0KL5TBzkSV/rMmUQDjtA/qpBsBaMUY2opnYVpiJ2c6OK8TD7OB2vdniaOOpoXY1aTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=dPVBYW5Z; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1717931614;
	bh=BV+oswdjo+GnBuL0pDMh4r7BZxfSayoPjlLPADR1Rl8=;
	h=From:Date:Subject:To:Cc:From;
	b=dPVBYW5ZJEgEJYulhTsw4SU3sH9EC20PyGF4lecg/RyM+L1hPU9i87QUeJkPbkjUC
	 CSYriBCNy1GWhBX1Qc4ghDQoD6paOaDeOaOLAGyvVgjSSTklk234ROX2qLmJXTQgDB
	 6n+gKknHX8b+XyNQzCvM4mUIC0njr8eIJBvH0+bw=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sun, 09 Jun 2024 13:13:28 +0200
Subject: [PATCH] ACPI: SBS: manage alarm sysfs attribute through psy core
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240609-acpi-sbs-sysfs-group-v1-1-7f0bf95523e7@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAFeOZWYC/x3MTQ5AMBBA4avIrE0y6ie4ilhUTZkNTSeEiLtrL
 L/Few8oR2GFPnsg8ikq+5ZQ5Bm41W4Lo8zJYMhU1FCH1gVBnRT1Vq+4xP0IWJMtaXa1b42FlIb
 IXq5/O4zv+wE8CvH2ZgAAAA==
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717931613; l=2884;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=BV+oswdjo+GnBuL0pDMh4r7BZxfSayoPjlLPADR1Rl8=;
 b=skQzhFl1dCsplgUOI3yH040AlRupnm77EfNVRU198/eApMnR/dMPm9OpxDzMtOsOPTt9DKxdH
 0FlB1WswbAkBpHsoFJESNL7UyCavbFmj36L6ATbppZIyAa4t2xUjA57
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Let the power supply core register the attribute.
This ensures that the attribute is created before the device is
announced to userspace, avoiding a race condition.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Only compile-tested.

This is the SBS equivalent of
"ACPI: battery: create alarm sysfs attribute atomically" [0]

[0] https://lore.kernel.org/lkml/20240609-acpi-battery-cleanup-v1-5-344517bdca73@weisss
---
 drivers/acpi/sbs.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/acpi/sbs.c b/drivers/acpi/sbs.c
index dc8164b182dc..442c5905d43b 100644
--- a/drivers/acpi/sbs.c
+++ b/drivers/acpi/sbs.c
@@ -77,7 +77,6 @@ struct acpi_battery {
 	u16 spec;
 	u8 id;
 	u8 present:1;
-	u8 have_sysfs_alarm:1;
 };
 
 #define to_acpi_battery(x) power_supply_get_drvdata(x)
@@ -462,12 +461,18 @@ static ssize_t acpi_battery_alarm_store(struct device *dev,
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
 /* --------------------------------------------------------------------------
                                  Driver Interface
    -------------------------------------------------------------------------- */
@@ -518,7 +523,10 @@ static int acpi_battery_read(struct acpi_battery *battery)
 static int acpi_battery_add(struct acpi_sbs *sbs, int id)
 {
 	struct acpi_battery *battery = &sbs->battery[id];
-	struct power_supply_config psy_cfg = { .drv_data = battery, };
+	struct power_supply_config psy_cfg = {
+		.drv_data = battery,
+		.attr_grp = acpi_battery_groups,
+	};
 	int result;
 
 	battery->id = id;
@@ -548,10 +556,6 @@ static int acpi_battery_add(struct acpi_sbs *sbs, int id)
 		goto end;
 	}
 
-	result = device_create_file(&battery->bat->dev, &alarm_attr);
-	if (result)
-		goto end;
-	battery->have_sysfs_alarm = 1;
       end:
 	pr_info("%s [%s]: Battery Slot [%s] (battery %s)\n",
 	       ACPI_SBS_DEVICE_NAME, acpi_device_bid(sbs->device),
@@ -563,11 +567,8 @@ static void acpi_battery_remove(struct acpi_sbs *sbs, int id)
 {
 	struct acpi_battery *battery = &sbs->battery[id];
 
-	if (battery->bat) {
-		if (battery->have_sysfs_alarm)
-			device_remove_file(&battery->bat->dev, &alarm_attr);
+	if (battery->bat)
 		power_supply_unregister(battery->bat);
-	}
 }
 
 static int acpi_charger_add(struct acpi_sbs *sbs)

---
base-commit: 771ed66105de9106a6f3e4311e06451881cdac5e
change-id: 20240609-acpi-sbs-sysfs-group-50a30dc5f82a

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


