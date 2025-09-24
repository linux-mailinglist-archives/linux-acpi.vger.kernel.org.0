Return-Path: <linux-acpi+bounces-17284-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 78A36B9B820
	for <lists+linux-acpi@lfdr.de>; Wed, 24 Sep 2025 20:37:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 95DDF4E2BD2
	for <lists+linux-acpi@lfdr.de>; Wed, 24 Sep 2025 18:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5D322DFA54;
	Wed, 24 Sep 2025 18:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sW1RaeMv"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864DE1FDD;
	Wed, 24 Sep 2025 18:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758739031; cv=none; b=GdxkGk9mVajy4i5C6ZdM16W6I1AS6nwgZ7TTqo7+sJCRmraHL/N9RALl9RWhexly9PixGPf8dyEGz4McX8Yt/Aav5JftyCSzZnKJti6ur5ktDYftdzDjazpmuaEELUcXYS8olyF/9jzy3qbQRF7WbPvWqRDuoZUCXXUsY3Q5L1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758739031; c=relaxed/simple;
	bh=nsUaCT7b/udINKA8PswOzKfoXxSOugiWaZZjsvX32YY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Xs3tGfZ/Xa6wyWcxe60mxM8mHjRrNSzRBnrW3DNB9IPbUl8XQVoUGZhwLUaCDW7CJ3Vh+09hZMyyys+xDmU4uelY83RV3EcvYWXdWGW+6ylVwUVIdqHDiJMOIifmBitHlK8E2PLbaJZwIM9Wpx/iykTx1B/8fKslkbDhJMxDAb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sW1RaeMv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0DB5C4CEE7;
	Wed, 24 Sep 2025 18:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758739031;
	bh=nsUaCT7b/udINKA8PswOzKfoXxSOugiWaZZjsvX32YY=;
	h=From:To:Cc:Subject:Date:From;
	b=sW1RaeMvc+J6zCInpOUzz3q4WR//9sOGO+KtjV0H6z+Jaxe1rOm4178ToPMwR9FOz
	 ni7mxoEdroMngWVagC/2fMVgHAUUKcEydC/KTpVhLWc8xdx7aP+bMDKn60bdXkvbLh
	 3qodUS0zGE4EmA5sqEk03lUpEJBloFjD8qC70bsWS00wr+JAMWuf9sW2W934fqLVH7
	 BQRHGjjCHoH0fadb4WLSqDYYov4zGrlBHbB2WQYyiqwCSYBJuLNnAgHhrNmsStiRN7
	 44+3Pwnd95l0qqMyle6LJ4b9ju0qr8xd3i0rt2M6qgng4p+6nw8IBmIQp/41G8jijE
	 zrDiq+6B3KBAA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 GuangFei Luo <luogf2025@163.com>,
 Thomas =?ISO-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Subject:
 [PATCH v1] ACPI: battery: Add synchronization between interface updates
Date: Wed, 24 Sep 2025 20:37:05 +0200
Message-ID: <2820680.mvXUDI8C0e@rafael.j.wysocki>
Organization: Linux Kernel Development
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

There is no synchronization between different code paths in the ACPI
battery driver that update its sysfs interface or its power supply
class device interface.  In some cases this results to functional
failures due to race conditions.

One example of this is when two ACPI notifications:

  - ACPI_BATTERY_NOTIFY_STATUS (0x80)
  - ACPI_BATTERY_NOTIFY_INFO   (0x81)

are triggered (by the platform firmware) in a row with a little delay
in between after removing and reinserting a laptop battery.  Both
notifications cause acpi_battery_update() to be called and if the delay
between them is sufficiently small, sysfs_add_battery() can be re-entered
before battery->bat is set which leads to a duplicate sysfs entry error:

 sysfs: cannot create duplicate filename '/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0A:00/power_supply/BAT1'
 CPU: 1 UID: 0 PID: 185 Comm: kworker/1:4 Kdump: loaded Not tainted 6.12.38+deb13-amd64 #1  Debian 6.12.38-1
 Hardware name: Gateway          NV44             /SJV40-MV        , BIOS V1.3121 04/08/2009
 Workqueue: kacpi_notify acpi_os_execute_deferred
 Call Trace:
  <TASK>
  dump_stack_lvl+0x5d/0x80
  sysfs_warn_dup.cold+0x17/0x23
  sysfs_create_dir_ns+0xce/0xe0
  kobject_add_internal+0xba/0x250
  kobject_add+0x96/0xc0
  ? get_device_parent+0xde/0x1e0
  device_add+0xe2/0x870
  __power_supply_register.part.0+0x20f/0x3f0
  ? wake_up_q+0x4e/0x90
  sysfs_add_battery+0xa4/0x1d0 [battery]
  acpi_battery_update+0x19e/0x290 [battery]
  acpi_battery_notify+0x50/0x120 [battery]
  acpi_ev_notify_dispatch+0x49/0x70
  acpi_os_execute_deferred+0x1a/0x30
  process_one_work+0x177/0x330
  worker_thread+0x251/0x390
  ? __pfx_worker_thread+0x10/0x10
  kthread+0xd2/0x100
  ? __pfx_kthread+0x10/0x10
  ret_from_fork+0x34/0x50
  ? __pfx_kthread+0x10/0x10
  ret_from_fork_asm+0x1a/0x30
  </TASK>
 kobject: kobject_add_internal failed for BAT1 with -EEXIST, don't try to register things with the same name in the same directory.

There are also other scenarios in which analogous issues may occur.

Address this by using a common lock in all of the code paths leading
to updates of driver interfaces: ACPI Notify () handler, system resume
callback and post-resume notification, device addition and removal.

This new lock replaces sysfs_lock that has been used only in
sysfs_remove_battery() which now is going to be always called under
the new lock, so it doesn't need any internal locking any more.

Fixes: 10666251554c ("ACPI: battery: Install Notify() handler directly")
Closes: https://lore.kernel.org/linux-acpi/20250910142653.313360-1-luogf2025@163.com/
Reported-by: GuangFei Luo <luogf2025@163.com>
Tested-by: GuangFei Luo <luogf2025@163.com>
Cc: 6.6+ <stable@vger.kernel.org> # 6.6+
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/battery.c |   36 +++++++++++++++++++++++-------------
 1 file changed, 23 insertions(+), 13 deletions(-)

--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -92,7 +92,7 @@ enum {
 
 struct acpi_battery {
 	struct mutex lock;
-	struct mutex sysfs_lock;
+	struct mutex update_lock;
 	struct power_supply *bat;
 	struct power_supply_desc bat_desc;
 	struct acpi_device *device;
@@ -904,15 +904,12 @@ static int sysfs_add_battery(struct acpi
 
 static void sysfs_remove_battery(struct acpi_battery *battery)
 {
-	mutex_lock(&battery->sysfs_lock);
-	if (!battery->bat) {
-		mutex_unlock(&battery->sysfs_lock);
+	if (!battery->bat)
 		return;
-	}
+
 	battery_hook_remove_battery(battery);
 	power_supply_unregister(battery->bat);
 	battery->bat = NULL;
-	mutex_unlock(&battery->sysfs_lock);
 }
 
 static void find_battery(const struct dmi_header *dm, void *private)
@@ -1072,6 +1069,9 @@ static void acpi_battery_notify(acpi_han
 
 	if (!battery)
 		return;
+
+	guard(mutex)(&battery->update_lock);
+
 	old = battery->bat;
 	/*
 	 * On Acer Aspire V5-573G notifications are sometimes triggered too
@@ -1094,21 +1094,22 @@ static void acpi_battery_notify(acpi_han
 }
 
 static int battery_notify(struct notifier_block *nb,
-			       unsigned long mode, void *_unused)
+			  unsigned long mode, void *_unused)
 {
 	struct acpi_battery *battery = container_of(nb, struct acpi_battery,
 						    pm_nb);
-	int result;
 
-	switch (mode) {
-	case PM_POST_HIBERNATION:
-	case PM_POST_SUSPEND:
+	if (mode == PM_POST_SUSPEND || mode == PM_POST_HIBERNATION) {
+		guard(mutex)(&battery->update_lock);
+
 		if (!acpi_battery_present(battery))
 			return 0;
 
 		if (battery->bat) {
 			acpi_battery_refresh(battery);
 		} else {
+			int result;
+
 			result = acpi_battery_get_info(battery);
 			if (result)
 				return result;
@@ -1120,7 +1121,6 @@ static int battery_notify(struct notifie
 
 		acpi_battery_init_alarm(battery);
 		acpi_battery_get_state(battery);
-		break;
 	}
 
 	return 0;
@@ -1198,6 +1198,8 @@ static int acpi_battery_update_retry(str
 {
 	int retry, ret;
 
+	guard(mutex)(&battery->update_lock);
+
 	for (retry = 5; retry; retry--) {
 		ret = acpi_battery_update(battery, false);
 		if (!ret)
@@ -1230,7 +1232,7 @@ static int acpi_battery_add(struct acpi_
 	if (result)
 		return result;
 
-	result = devm_mutex_init(&device->dev, &battery->sysfs_lock);
+	result = devm_mutex_init(&device->dev, &battery->update_lock);
 	if (result)
 		return result;
 
@@ -1262,6 +1264,8 @@ fail_pm:
 	device_init_wakeup(&device->dev, 0);
 	unregister_pm_notifier(&battery->pm_nb);
 fail:
+	guard(mutex)(&battery->update_lock);
+
 	sysfs_remove_battery(battery);
 
 	return result;
@@ -1281,6 +1285,9 @@ static void acpi_battery_remove(struct a
 
 	device_init_wakeup(&device->dev, 0);
 	unregister_pm_notifier(&battery->pm_nb);
+
+	guard(mutex)(&battery->update_lock);
+
 	sysfs_remove_battery(battery);
 }
 
@@ -1297,6 +1304,9 @@ static int acpi_battery_resume(struct de
 		return -EINVAL;
 
 	battery->update_time = 0;
+
+	guard(mutex)(&battery->update_lock);
+
 	acpi_battery_update(battery, true);
 	return 0;
 }




