Return-Path: <linux-acpi+bounces-7097-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B605893E248
	for <lists+linux-acpi@lfdr.de>; Sun, 28 Jul 2024 03:03:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AE0E1F21B2C
	for <lists+linux-acpi@lfdr.de>; Sun, 28 Jul 2024 01:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33A2618EFDD;
	Sun, 28 Jul 2024 00:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="baG10eCr"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B27118EFD7;
	Sun, 28 Jul 2024 00:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722127797; cv=none; b=otQ8LPsZM/YIv8zjVR954nxg9jW2WFbAHJCPxaslhbLMIhEWq1fV46uudmImEsyniTOdSBefkkc+2USz/o6RfaWQ6GhXLce6XPhI9V0Vyz7owupmkS1KSf/J9MNd0C1RwrOl1XphjI96zy1ZA85cvlYSgG6ufTurrtVvdigieLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722127797; c=relaxed/simple;
	bh=yGBweUcZO+Zw9oWzbVlvO0DmroUAliq2QcI67+BhO5o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KdEQCy6OtCD4rTU1karngn/c2xfRZisMC7ZyV/kS72ru3+tiDSxuzT6fphOyB/Tf9WQlur1ecmfiPqzlvnrHsWKEMSuCAjNeftM8xGf18/rvcQ2VefpVIG2wjpJNbxMsuxBtHgZcviGKQpef4aCW+1dz5JPys3ivvaukSjYy6uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=baG10eCr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F141CC32781;
	Sun, 28 Jul 2024 00:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722127796;
	bh=yGBweUcZO+Zw9oWzbVlvO0DmroUAliq2QcI67+BhO5o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=baG10eCr8tDoPTLWnOUh/Bf007guL66hkx5QCQRuig0bXiE5RVgqdgFrpNBXTQ6gg
	 chZpqhPlQFC/oDRJsukSR35EtXEDQs2k7/ay1UbmnTAakTOhbof/WXlkxqNPI/H17C
	 t/x2GsE6XmPj+cW2Rn24HzgOCi5trjmjgILD1MBiD4eWuCMqEv2Af2NF+6WEFKE+LH
	 tAZ41dKbUxXRUHuwxeATig9Slz136laOz6im9kvkWclA5RCKyDPD0GWR7lBA4ur1vP
	 gVf6ty4ochDaJO2NekjianTwAE9+P1QQcDAkuXRBoOb4h778BqNuFaYL5vmbm31GUp
	 XgcCN9Fplv8mg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 2/3] ACPI: SBS: manage alarm sysfs attribute through psy core
Date: Sat, 27 Jul 2024 20:49:50 -0400
Message-ID: <20240728004952.1707781-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728004952.1707781-1-sashal@kernel.org>
References: <20240728004952.1707781-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.43
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
index 94e3c000df2e1..fdeb46ed21d69 100644
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
-- 
2.43.0


