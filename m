Return-Path: <linux-acpi+bounces-7102-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3762393E258
	for <lists+linux-acpi@lfdr.de>; Sun, 28 Jul 2024 03:04:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 692FD1C20E9E
	for <lists+linux-acpi@lfdr.de>; Sun, 28 Jul 2024 01:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1F1818FDC6;
	Sun, 28 Jul 2024 00:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sqia1RXS"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E542C1A2;
	Sun, 28 Jul 2024 00:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722127811; cv=none; b=KXtKLvYuOX5dEnLpt/a8O57KUi+WoAE9tODDMAENJ7aUeV0Gn2BuDDnTFSbPdjLF55XFJpE1Ynlqs8tyYA61wJiZnDatC0L1nNscmDXzc5O22HJcVKwKfQqo5+AN4anNVmpnYanbyXCqqjRXctUMsqC7wX+jrrpPi9vIOtOuTWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722127811; c=relaxed/simple;
	bh=dKui23z/M5oTXKpognxgfzapWZJaHXHLGJZyi+YdHEo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KVDoviFKFjDQ/UVugPAtZmzwbQhI6HKDSeEL4n+0DUZAXOzKjIvOGAMlxpkq0E3k9AafthmZ2db3JveafR9o0tBvAJeSuRQ4wt27G39wzsOjIIcU9959f9C3jiwGki9xEs2d/5y9ulUYHi2XZre1mkX9+FgU63UxPoyKCoTa6Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sqia1RXS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BB4DC32781;
	Sun, 28 Jul 2024 00:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722127811;
	bh=dKui23z/M5oTXKpognxgfzapWZJaHXHLGJZyi+YdHEo=;
	h=From:To:Cc:Subject:Date:From;
	b=Sqia1RXS+jjfuYSGQ8+KyLuvF0+6WX0M+jsylK/QktkI43FXoK6JfdCCNpJeGLeeG
	 LdXEgyeU4gHd7fEMVc6UbW0ezfKNyn0znEJe8q8CmxnBY96mnPWq/ElmC9gY9GSvjm
	 PMeDTU4rp27SNaoyVo3Zrm3J098KDrd7qKQciA440fBPAe2fCRvwe33R3v4P8hrdwA
	 f6OMXTHGFMSXo/zpPpqzsna0OoJnV8CCDpX59pT8V0n1TnwpR6Dlv3pzAgt2dzNCYc
	 X5dv1UQ/E8fNqB2GjNJTuoJSbDfjg3bv0P/hvvsN6k2V3y0PTpR4gvvOYkiN5YQrt+
	 qb2AbMXQIP9ZA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 1/2] ACPI: battery: create alarm sysfs attribute atomically
Date: Sat, 27 Jul 2024 20:50:07 -0400
Message-ID: <20240728005009.1708832-1-sashal@kernel.org>
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
X-stable-base: Linux 5.10.223
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
index 8b43efe97da5d..2e1462b8929c0 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -670,12 +670,18 @@ static ssize_t acpi_battery_alarm_store(struct device *dev,
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
@@ -812,7 +818,10 @@ static void __exit battery_hook_exit(void)
 
 static int sysfs_add_battery(struct acpi_battery *battery)
 {
-	struct power_supply_config psy_cfg = { .drv_data = battery, };
+	struct power_supply_config psy_cfg = {
+		.drv_data = battery,
+		.attr_grp = acpi_battery_groups,
+	};
 	bool full_cap_broken = false;
 
 	if (!ACPI_BATTERY_CAPACITY_VALID(battery->full_charge_capacity) &&
@@ -857,7 +866,7 @@ static int sysfs_add_battery(struct acpi_battery *battery)
 		return result;
 	}
 	battery_hook_add_battery(battery);
-	return device_create_file(&battery->bat->dev, &alarm_attr);
+	return 0;
 }
 
 static void sysfs_remove_battery(struct acpi_battery *battery)
@@ -868,7 +877,6 @@ static void sysfs_remove_battery(struct acpi_battery *battery)
 		return;
 	}
 	battery_hook_remove_battery(battery);
-	device_remove_file(&battery->bat->dev, &alarm_attr);
 	power_supply_unregister(battery->bat);
 	battery->bat = NULL;
 	mutex_unlock(&battery->sysfs_lock);
-- 
2.43.0


