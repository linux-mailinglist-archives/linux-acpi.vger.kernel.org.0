Return-Path: <linux-acpi+bounces-7104-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2962E93E25E
	for <lists+linux-acpi@lfdr.de>; Sun, 28 Jul 2024 03:05:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A26B3B213C7
	for <lists+linux-acpi@lfdr.de>; Sun, 28 Jul 2024 01:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 072073FB01;
	Sun, 28 Jul 2024 00:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RFDCRs3i"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31173F9ED;
	Sun, 28 Jul 2024 00:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722127816; cv=none; b=EpzC8mVTGEIwIe1kWZk0XvUyjZVj4OWOxj4qSWJwO/oWIzU1PjyRRccVOruxbkXLlTpFbxG+YJz9MVo1ZgIwpujpLjZZnj/VzZKaSoDL5hXziVa/uvBAZqfg7Uh5OX0htnIR8lXMvgNEvmb8ntMz4WdxrmLT4txJShlHGN+7rjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722127816; c=relaxed/simple;
	bh=M3FA21KqY2VBIocuUbLbAx2fIOfNpLowb3wv2XKfxTU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=f5T5peTXRSmFyrVPr6cBkUmALoVZjuSHCwOxhl5SiYRE9sJMyqTnSFnV0hyB1CmhmqBjHwaluRNJF7748iZ0UZa2SYjlp4DGUCYeIZodEzxhcUToSTLsPLkYuc63rFtFwShqglhZe8b8E3aKLarZ/hLSFMpk9eH1eYDzFkkxjKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RFDCRs3i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63159C32781;
	Sun, 28 Jul 2024 00:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722127816;
	bh=M3FA21KqY2VBIocuUbLbAx2fIOfNpLowb3wv2XKfxTU=;
	h=From:To:Cc:Subject:Date:From;
	b=RFDCRs3iKQY8ONFxNyZissk0xlbQ0wW7JX9/ZAsf/4edhzDTQN38NNwLDrGkWKaNa
	 8R+Y+fK57OzNuEA/+mtnspWTlNg8MfM2iGemwGPYwI4hjnxwGYuBRKyVrYlk56T08C
	 umXs77tHMaMX8W0Oga6YOi8cTqS4+Lq9hnuH7SJNRr8i+MJUw0+q2XX9QdXvPHZTpt
	 1U0y4dvhBvRSK/B7WsMSSgWDU7qZ+bZ5shat2PQ3drlM3koquCCMaeK+ORGML+6jvr
	 aAXPKhIvTqVK5dkKEBhdh1YnOl49JleZLawIHjcdcB3N3EZsbphEFmXexG9q/aRMNG
	 zFuDdJN59ydGw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 1/2] ACPI: battery: create alarm sysfs attribute atomically
Date: Sat, 27 Jul 2024 20:50:12 -0400
Message-ID: <20240728005013.1709163-1-sashal@kernel.org>
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
X-stable-base: Linux 5.4.281
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
index a49a09e3de1b3..af78f76a28729 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -681,12 +681,18 @@ static ssize_t acpi_battery_alarm_store(struct device *dev,
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


