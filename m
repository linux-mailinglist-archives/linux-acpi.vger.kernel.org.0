Return-Path: <linux-acpi+bounces-7103-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3636693E25B
	for <lists+linux-acpi@lfdr.de>; Sun, 28 Jul 2024 03:04:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 678B01C2102D
	for <lists+linux-acpi@lfdr.de>; Sun, 28 Jul 2024 01:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AFE518FDD2;
	Sun, 28 Jul 2024 00:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jespk0hm"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0256718FDD4;
	Sun, 28 Jul 2024 00:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722127813; cv=none; b=BBl+GMLYwCP56H/KcW6xQIT7FMFjeuzucI4Gdz0AahninQ4rsURcQtI7Fa0uvxHGDjdYnXP2Maf4lc2IvQLDE8ggQQpUZkk3VG+1j/w7sqAe4gKyr4He+OBg6ZNTGZ3oEDr/7AidwfDIz69VdO1/wkVw3M9Y9+G6gAqDMnjfIns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722127813; c=relaxed/simple;
	bh=JK3qAXZx9OP5sKsCnNbQiezrzBw5GNI2/oiwObCJSUo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VDgadkWUuUGA3AafAzUC9xSbeZb7We+HY+Wcdoe4sbWP31dix8w2RKiQxXSn7GtSUG0W1Ycy+0mrE8jxsEMVOeEmu2eqT/yovykQU6bYJzyuj+LZVdAnq9ZQ6iG2407dmOYzMvG948LD9o/ea3hjBIyXXs+6rlVdyPaZpP5mXko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jespk0hm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9BE0C4AF09;
	Sun, 28 Jul 2024 00:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722127812;
	bh=JK3qAXZx9OP5sKsCnNbQiezrzBw5GNI2/oiwObCJSUo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Jespk0hm6iC16uVYNgJT3/bPliEwMlHvYuQRgvXXhOxHT42lK6ewMMbikz+ZakaJp
	 PczGk2/X+8GC/wvlMi/l1GcBiQKsGReKSBWri24zyREjr5m2JsNQlgrpKjL35/vdtl
	 tQTRfWvVGxqPJziDMK2F1UduyBpxm9sMkiOG1pi52d7aSRSL9Xz91hk7FtQALQMxTY
	 OjKOoJYhrDdamCZ+lNGSrU/P0kpsvkOe8A2QvITaHu41U2JHvXlTbMImxFIZbCuJHF
	 9ZeFAJFIDontaEaERlKKxlfWKtB55LTVIRQpKsecvIJuDsuPCvGq+GegslNLmrxAIB
	 G1a+nD27R5xgg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 2/2] ACPI: SBS: manage alarm sysfs attribute through psy core
Date: Sat, 27 Jul 2024 20:50:08 -0400
Message-ID: <20240728005009.1708832-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728005009.1708832-1-sashal@kernel.org>
References: <20240728005009.1708832-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.223
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
index e6d9f4de28000..54396cb8930a4 100644
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
@@ -509,7 +514,10 @@ static int acpi_battery_read(struct acpi_battery *battery)
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
@@ -539,10 +547,6 @@ static int acpi_battery_add(struct acpi_sbs *sbs, int id)
 		goto end;
 	}
 
-	result = device_create_file(&battery->bat->dev, &alarm_attr);
-	if (result)
-		goto end;
-	battery->have_sysfs_alarm = 1;
       end:
 	printk(KERN_INFO PREFIX "%s [%s]: Battery Slot [%s] (battery %s)\n",
 	       ACPI_SBS_DEVICE_NAME, acpi_device_bid(sbs->device),
@@ -554,11 +558,8 @@ static void acpi_battery_remove(struct acpi_sbs *sbs, int id)
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


