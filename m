Return-Path: <linux-acpi+bounces-7105-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50E1893E261
	for <lists+linux-acpi@lfdr.de>; Sun, 28 Jul 2024 03:05:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F28B1C20442
	for <lists+linux-acpi@lfdr.de>; Sun, 28 Jul 2024 01:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06D05190070;
	Sun, 28 Jul 2024 00:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vCc+rtrC"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E3619006D;
	Sun, 28 Jul 2024 00:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722127817; cv=none; b=Yvuj9lOz5EbJvnSeLXvhWdVqmiftHNGYtMSyyta/s2fJ4Ohh+Ou9LOfcxdE3RxtkSFu5p20lhcEaoaYkkSIYXVIXu8Q7G3j7POJdOlWnbRG9YQcG4puPLidl5R6GMQiqTEaLG5RhIogc61oaVFxesIByaXgFIJinfI1wwcHmxNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722127817; c=relaxed/simple;
	bh=iUu8uRfZlQAYF+nvzko7diJlChUItsfTwEICYfckrG8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jnJEcpffFZPo0ELBkIKBDTqqlAsoSQRzqCGTe5anQle0lz4a4uujFsX7tWHPmU2T1CZnXLkBqPlQr/F8KGKFemakAIrWtsrBBBcHl8G+DP1fJOcEvuovWuzhmF2hxL1DnzsUmNVlmXpJnjk3z4fGvUiI8KivJD8AHsxQW3ZXNFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vCc+rtrC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCAA8C4AF07;
	Sun, 28 Jul 2024 00:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722127817;
	bh=iUu8uRfZlQAYF+nvzko7diJlChUItsfTwEICYfckrG8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vCc+rtrCQG/r+XxRnL0vuyr3nlyUh+RCDF6i9xhi8N/IlgL4CwnQGKXUS29l/+WoT
	 Gg6kV7IRTgfjWy26iVg0L1T+b1T9ugy2VepomeNPWG8w7msmlcNklQcItwVKZktqVq
	 zkLFX4R/2Ro7jZPsfOZTN4HAxIZZwASjJ5oG6ebFMPtrnzvaBqEikTaYBWgCfDzLep
	 1TLea4ByzNp6NcaMhmmIL1Bbl96uLiettdRr3nDe2/HjyVETCQQ1RxxoYFeupLQRTH
	 +W70wuZoHI1/3OuL14u1bP1Ete61KZWUlQnSpfn+cOgJASJKe8xiZ46gE+JGslWaFd
	 i9ciZJ/33FQ3Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 2/2] ACPI: SBS: manage alarm sysfs attribute through psy core
Date: Sat, 27 Jul 2024 20:50:13 -0400
Message-ID: <20240728005013.1709163-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728005013.1709163-1-sashal@kernel.org>
References: <20240728005013.1709163-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.281
Content-Transfer-Encoding: 8bit

From: Thomas Weißschuh <linux@weissschuh.net>

[ Upstream commit 6bad28cfc30988a845fb3f59a99f4b8a4ce8fe95 ]

Let the power supply core register the attribute.

This ensures that the attribute is created before the device is
announced to userspace, avoiding a race condition.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/sbs.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/acpi/sbs.c b/drivers/acpi/sbs.c
index 6e88224f60f09..4aa55d8d43859 100644
--- a/drivers/acpi/sbs.c
+++ b/drivers/acpi/sbs.c
@@ -80,7 +80,6 @@ struct acpi_battery {
 	u16 spec;
 	u8 id;
 	u8 present:1;
-	u8 have_sysfs_alarm:1;
 };
 
 #define to_acpi_battery(x) power_supply_get_drvdata(x)
@@ -465,12 +464,18 @@ static ssize_t acpi_battery_alarm_store(struct device *dev,
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
@@ -512,7 +517,10 @@ static int acpi_battery_read(struct acpi_battery *battery)
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
@@ -542,10 +550,6 @@ static int acpi_battery_add(struct acpi_sbs *sbs, int id)
 		goto end;
 	}
 
-	result = device_create_file(&battery->bat->dev, &alarm_attr);
-	if (result)
-		goto end;
-	battery->have_sysfs_alarm = 1;
       end:
 	printk(KERN_INFO PREFIX "%s [%s]: Battery Slot [%s] (battery %s)\n",
 	       ACPI_SBS_DEVICE_NAME, acpi_device_bid(sbs->device),
@@ -557,11 +561,8 @@ static void acpi_battery_remove(struct acpi_sbs *sbs, int id)
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
-- 
2.43.0


