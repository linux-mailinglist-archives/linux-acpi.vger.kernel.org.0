Return-Path: <linux-acpi+bounces-7100-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C17BC93E252
	for <lists+linux-acpi@lfdr.de>; Sun, 28 Jul 2024 03:04:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7867E1F217FD
	for <lists+linux-acpi@lfdr.de>; Sun, 28 Jul 2024 01:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A7B518FC70;
	Sun, 28 Jul 2024 00:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aW0heuSz"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12382364BA;
	Sun, 28 Jul 2024 00:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722127807; cv=none; b=FpnQnU2ZZ9YOkdAZFl0olYC+sxr2YIPKJxHOjkrt2XFsDt8yMmoth/wVazc/mStSwhgQ80VlFDjwAv6mdzO2lkozuJHKZx73Y/tdNmap7LzBmCgBkc+QegE4BaHv0EZir+DJvYNhrgIW2nvKwgclAqGROH7usR1itCp1UHyusg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722127807; c=relaxed/simple;
	bh=xtuA6cEeaYsVGY9BrJqwUeWQG98xiJnwqUmTmOYplCc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EKdwS1Dw6Q++QnQL47E+BZv49e3/G5sm0h8A/KOUggFW2NAtwNaPHrSXLVWlyHANPgZzSi1ITl72BKAqLtNmS+5xlnLaeVWwfLddbjvetnYBXLl6bzuQ3IJJk/opRpvqlsMl/5Ll8sSU9DKZwqM86tTUSOFDwJVv8qvrXzO1Vko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aW0heuSz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1183C4AF07;
	Sun, 28 Jul 2024 00:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722127806;
	bh=xtuA6cEeaYsVGY9BrJqwUeWQG98xiJnwqUmTmOYplCc=;
	h=From:To:Cc:Subject:Date:From;
	b=aW0heuSz14UDy8bLvdM3K9oC6bt0tRtb+bnQmYZ8rgtoE30NUTxZnoETo5JwktYIU
	 CZpMj35YGZj1hQOA2RkCIwsseFkyclFLh1CpvDLst+NxhVqEiRTDGhgrBi35y/0h1K
	 5mRwK6jDEBcCHWmOF0YYVAJACIFo1w0Z+x9HbAWwQ12tcTtAsP9laDCe/8QzZeOAsF
	 QDapfD3SOx2t1dhhdRYBxm6/F4QBF7zfKlygy9tfCWivyO5XPwFgGOPD39LPvR4+ka
	 1+9kJjvUFd8LBG/HXvjPd6WzlLo7rtcQhpykmu+2YZWNXLQeSGeMQ15aSqEcR3kSrZ
	 y+wI1Wn7JJ4Ag==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 1/2] ACPI: battery: create alarm sysfs attribute atomically
Date: Sat, 27 Jul 2024 20:50:02 -0400
Message-ID: <20240728005004.1708494-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.164
Content-Transfer-Encoding: 8bit

From: Thomas Weißschuh <linux@weissschuh.net>

[ Upstream commit a231eed10ed5a290129fda36ad7bcc263c53ff7d ]

Let the power supply core register the attribute.
This ensures that the attribute is created before the device is
announced to userspace, avoid a race condition.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/battery.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index c7569151fd02a..aed4132985a96 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -676,12 +676,18 @@ static ssize_t acpi_battery_alarm_store(struct device *dev,
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
@@ -818,7 +824,10 @@ static void __exit battery_hook_exit(void)
 
 static int sysfs_add_battery(struct acpi_battery *battery)
 {
-	struct power_supply_config psy_cfg = { .drv_data = battery, };
+	struct power_supply_config psy_cfg = {
+		.drv_data = battery,
+		.attr_grp = acpi_battery_groups,
+	};
 	bool full_cap_broken = false;
 
 	if (!ACPI_BATTERY_CAPACITY_VALID(battery->full_charge_capacity) &&
@@ -863,7 +872,7 @@ static int sysfs_add_battery(struct acpi_battery *battery)
 		return result;
 	}
 	battery_hook_add_battery(battery);
-	return device_create_file(&battery->bat->dev, &alarm_attr);
+	return 0;
 }
 
 static void sysfs_remove_battery(struct acpi_battery *battery)
@@ -874,7 +883,6 @@ static void sysfs_remove_battery(struct acpi_battery *battery)
 		return;
 	}
 	battery_hook_remove_battery(battery);
-	device_remove_file(&battery->bat->dev, &alarm_attr);
 	power_supply_unregister(battery->bat);
 	battery->bat = NULL;
 	mutex_unlock(&battery->sysfs_lock);
-- 
2.43.0


