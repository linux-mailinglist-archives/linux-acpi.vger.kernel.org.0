Return-Path: <linux-acpi+bounces-7096-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A63D93E245
	for <lists+linux-acpi@lfdr.de>; Sun, 28 Jul 2024 03:02:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F101EB22AAB
	for <lists+linux-acpi@lfdr.de>; Sun, 28 Jul 2024 01:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 064F018EFCE;
	Sun, 28 Jul 2024 00:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JlO/+OTc"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF4F38FB0;
	Sun, 28 Jul 2024 00:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722127795; cv=none; b=EjBXZCchOCxOJ1spEkwQP2kQpLqSDfCGVGD3lOYLqBpABMvs1PNs76nCK0IY1XciqW1z93bnh4Yl/3UfoKoCM3XMSX7euPPtXAgCY7ipq6jai2eV0a1u+K7vIrI3NEFFy83MROcMh9HQjWGQ4L1GJZNPZbwgCdQXfzNSTDXueXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722127795; c=relaxed/simple;
	bh=44z9Ey99VsR77QqXFgMqKoza8ap0GSNF+3UenvHmg0I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AvUTNZdZio0VpPq4mVkdeSsqIVQQIEfD0Q47gHYPgIM6Vpoj3g5IRY+hclS4JDLq0+Fm1qb6xISpIajO3Lq5YiAQpk3WgYMEl6LOcgA8tUaEkAm89OV0S/utb39lbS6zQuhhBDOtaCGrAdCB7J3i19QxB4HvXpMGx3P2eIfTxdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JlO/+OTc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68694C4AF07;
	Sun, 28 Jul 2024 00:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722127795;
	bh=44z9Ey99VsR77QqXFgMqKoza8ap0GSNF+3UenvHmg0I=;
	h=From:To:Cc:Subject:Date:From;
	b=JlO/+OTcqFoi9Xm5uLNNTs3ZHN6EVIh7uDY3KqfthmXEv1xuPWrA/8V9kW0spi3Yw
	 V1MJIlaIeJ5Y8KafeniST4v6DISmp0nTPfM0ELNd8oITfW+iKReHMVPW8BUq6tWFq1
	 TBZDCxzGMRElSiWMj1yeprF6Yh+ShAvlMSN3TxZZeaWTkSBzJKEddtc6nwnnmD1WIz
	 seO1Uhrm6EKCXTEBid/Pg0f1/4AlWKK3ohqRcMSV8U6hNbbO075kny2ZF+Hp3K8uP1
	 Y5aKIJjeS81HFp/cG2zkELEuLSntYEEqxbc7oybZFP5PyD+ELyhSIuHjyXQGJLASF1
	 fcj7oMDjTr5Yg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 1/3] ACPI: battery: create alarm sysfs attribute atomically
Date: Sat, 27 Jul 2024 20:49:49 -0400
Message-ID: <20240728004952.1707781-1-sashal@kernel.org>
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
X-stable-base: Linux 6.6.43
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
index 969bf81e8d546..7f7ad94f22b91 100644
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
2.43.0


