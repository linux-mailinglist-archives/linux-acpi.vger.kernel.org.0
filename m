Return-Path: <linux-acpi+bounces-16848-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06B37B55F2B
	for <lists+linux-acpi@lfdr.de>; Sat, 13 Sep 2025 09:58:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D1AFAC573B
	for <lists+linux-acpi@lfdr.de>; Sat, 13 Sep 2025 07:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D9882E8DEE;
	Sat, 13 Sep 2025 07:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="iS8+ebxX"
X-Original-To: linux-acpi@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F022C86D;
	Sat, 13 Sep 2025 07:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757750290; cv=none; b=DYQATlvrrmpeBPFZphYTxXVfSJrSlKIwF0+CWZZEppNMjXfj//JF/iHn1oTn4U5lNeQUmkNzv8HZI/OsrfgWuxviF4JC7gs9+8slFUmnFMy81DWcZntT9cSF3uNtf+OJSnloLlk2JxhIE9kZJWLodR8/ZWvMs2ZspIi/zzVTUec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757750290; c=relaxed/simple;
	bh=THAkk9ylkO0a1eInA/LqLgXmsjx6b1Mxt2eJnjPWVgE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mzig3ypwHQuJ8GADxZ+7yMNkEI9CAm7QHGdzNd87muXjA51V5SzU6eRI5381vTcNBDXWvb59LlTH+UrGWrs65lAVjjoxUWaiZRS4MQSj0s1/059W/YNgcUDn5BdS2kIDt/F1ULfxF2wt2o7XzSRQGvVIKMoCvbQq4CE/d4YVGt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=iS8+ebxX; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=vX
	moRsZzsXj/p3p291VVyyHZ4Vfb9J9AiC73Dbu1X98=; b=iS8+ebxXsZZYDdMxsw
	p7im/ijB1Sf67UtDVXFUSCVsCgY+5/QBtOJrLkADutfdpUi7Gc5qx/B7VfLRbX+h
	2+7BiIrcDB+PZZ6C8TF+ETjPv6vg846RQVKyYqrFXSQ43/78qLJmyhZaTrlu9cGZ
	DvywHIoDiZd6SsT5xZ+lOqANE=
Received: from MS-CMFLBWVCLQRG.localdomain (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wD3t2vBI8VoWkzAAw--.6585S2;
	Sat, 13 Sep 2025 15:56:50 +0800 (CST)
From: GuangFei Luo <luogf2025@163.com>
To: rafael@kernel.org,
	gregkh@linuxfoundation.org
Cc: dan.carpenter@linaro.org,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	lkp@intel.com,
	luogf2025@163.com,
	sre@kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v5] ACPI: battery: prevent sysfs_add_battery re-entry on rapid events
Date: Sat, 13 Sep 2025 15:56:48 +0800
Message-ID: <20250913075648.698043-1-luogf2025@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250910142653.313360-1-luogf2025@163.com>
References: <20250910142653.313360-1-luogf2025@163.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3t2vBI8VoWkzAAw--.6585S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3AF43ur1kWw4fWF43uF18Grg_yoWxuryDpa
	yrCayUKrW8GF48JwsF9F1Utryrurs0qF9rWr95Cr92kasrur1DArWIqFyUAF47GrykC3yx
	ZFn5t3Wrtr1xWw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U04iUUUUUU=
X-CM-SenderInfo: poxrwwisqskqqrwthudrp/xtbBXxTHmWjFEa7oRwABsp

When removing and reinserting the laptop battery, ACPI can trigger
two notifications in quick succession:
  - ACPI_BATTERY_NOTIFY_STATUS (0x80)
  - ACPI_BATTERY_NOTIFY_INFO   (0x81)

Both notifications call acpi_battery_update(). Because the events
happen very close in time, sysfs_add_battery() can be re-entered
before battery->bat is set, causing a duplicate sysfs entry error.

This patch ensures that sysfs_add_battery() is not re-entered
when battery->bat is already non-NULL, preventing the duplicate
sysfs creation and stabilizing battery hotplug handling.

[  476.117945] sysfs: cannot create duplicate filename '/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0A:00/power_supply/BAT1'
[  476.118896] CPU: 1 UID: 0 PID: 185 Comm: kworker/1:4 Kdump: loaded Not tainted 6.12.38+deb13-amd64 #1  Debian 6.12.38-1
[  476.118903] Hardware name: Gateway          NV44             /SJV40-MV        , BIOS V1.3121 04/08/2009
[  476.118906] Workqueue: kacpi_notify acpi_os_execute_deferred
[  476.118917] Call Trace:
[  476.118922]  <TASK>
[  476.118929]  dump_stack_lvl+0x5d/0x80
[  476.118938]  sysfs_warn_dup.cold+0x17/0x23
[  476.118943]  sysfs_create_dir_ns+0xce/0xe0
[  476.118952]  kobject_add_internal+0xba/0x250
[  476.118959]  kobject_add+0x96/0xc0
[  476.118964]  ? get_device_parent+0xde/0x1e0
[  476.118970]  device_add+0xe2/0x870
[  476.118975]  __power_supply_register.part.0+0x20f/0x3f0
[  476.118981]  ? wake_up_q+0x4e/0x90
[  476.118990]  sysfs_add_battery+0xa4/0x1d0 [battery]
[  476.118998]  acpi_battery_update+0x19e/0x290 [battery]
[  476.119002]  acpi_battery_notify+0x50/0x120 [battery]
[  476.119006]  acpi_ev_notify_dispatch+0x49/0x70
[  476.119012]  acpi_os_execute_deferred+0x1a/0x30
[  476.119015]  process_one_work+0x177/0x330
[  476.119022]  worker_thread+0x251/0x390
[  476.119026]  ? __pfx_worker_thread+0x10/0x10
[  476.119030]  kthread+0xd2/0x100
[  476.119033]  ? __pfx_kthread+0x10/0x10
[  476.119035]  ret_from_fork+0x34/0x50
[  476.119040]  ? __pfx_kthread+0x10/0x10
[  476.119042]  ret_from_fork_asm+0x1a/0x30
[  476.119049]  </TASK>
[  476.142552] kobject: kobject_add_internal failed for BAT1 with -EEXIST, don't try to register things with the same name in the same directory.
[  476.415022] ata1.00: unexpected _GTF length (8)
[  476.428076] sd 0:0:0:0: [sda] Starting disk
[  476.835035] ata1.00: unexpected _GTF length (8)
[  476.839720] ata1.00: configured for UDMA/133
[  491.328831] sysfs: cannot create duplicate filename '/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0A:00/power_supply/BAT1'
[  491.329720] CPU: 1 UID: 0 PID: 185 Comm: kworker/1:4 Kdump: loaded Not tainted 6.12.38+deb13-amd64 #1  Debian 6.12.38-1
[  491.329727] Hardware name: Gateway          NV44             /SJV40-MV        , BIOS V1.3121 04/08/2009
[  491.329731] Workqueue: kacpi_notify acpi_os_execute_deferred
[  491.329741] Call Trace:
[  491.329745]  <TASK>
[  491.329751]  dump_stack_lvl+0x5d/0x80
[  491.329758]  sysfs_warn_dup.cold+0x17/0x23
[  491.329762]  sysfs_create_dir_ns+0xce/0xe0
[  491.329770]  kobject_add_internal+0xba/0x250
[  491.329775]  kobject_add+0x96/0xc0
[  491.329779]  ? get_device_parent+0xde/0x1e0
[  491.329784]  device_add+0xe2/0x870
[  491.329790]  __power_supply_register.part.0+0x20f/0x3f0
[  491.329797]  sysfs_add_battery+0xa4/0x1d0 [battery]
[  491.329805]  acpi_battery_update+0x19e/0x290 [battery]
[  491.329809]  acpi_battery_notify+0x50/0x120 [battery]
[  491.329812]  acpi_ev_notify_dispatch+0x49/0x70
[  491.329817]  acpi_os_execute_deferred+0x1a/0x30
[  491.329820]  process_one_work+0x177/0x330
[  491.329826]  worker_thread+0x251/0x390
[  491.329830]  ? __pfx_worker_thread+0x10/0x10
[  491.329833]  kthread+0xd2/0x100
[  491.329836]  ? __pfx_kthread+0x10/0x10
[  491.329838]  ret_from_fork+0x34/0x50
[  491.329842]  ? __pfx_kthread+0x10/0x10
[  491.329844]  ret_from_fork_asm+0x1a/0x30
[  491.329850]  </TASK>
[  491.329855] kobject: kobject_add_internal failed for BAT1 with -EEXIST, don't try to register things with the same name in the same directory.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/r/202509101620.yI0HZ5gT-lkp@intel.com/
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/r/202509101620.yI0HZ5gT-lkp@intel.com/
Fixes: 508df92d1f8d ("ACPI: battery: register power_supply subdevice only when battery is present")
Signed-off-by: GuangFei Luo <luogf2025@163.com>
Cc: stable@vger.kernel.org
---
v5:
  - Move changelog above the '---' line as per submission guidelines.

v4:
  - Uses guard(mutex) for battery->sysfs_lock in sysfs_add_battery().
  - Since sysfs_add_battery() now handles the battery->bat check with
    proper locking,the extra if (!battery->bat) check at the call site
    has become redundant.

v3:
  - Modified the earlier approach: since sysfs_add_battery() is invoked
    from multiple places, the most reliable way is to add the lock inside
    the function itself.
  - sysfs_remove_battery() had a similar race issue in the past, which was
    fixed by adding a lock as well. Reference:
    https://lore.kernel.org/all/9c921c22a7f33397a6774d7fa076db9b6a0fd669
        .1312318300.git.len.brown@intel.com/

v2:
 - Fix missing mutex_unlock in acpi_battery_update()
   (Reported-by: kernel test robot)

v1:
 - Initial patch to handle race when hotplugging battery, preventing
   duplicate sysfs entries.
---
 drivers/acpi/battery.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 6905b56bf3e4..20d68f3e881f 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -850,6 +850,10 @@ static void __exit battery_hook_exit(void)
 
 static int sysfs_add_battery(struct acpi_battery *battery)
 {
+	guard(mutex)(&battery->sysfs_lock);
+	if (battery->bat)
+		return 0;
+
 	struct power_supply_config psy_cfg = {
 		.drv_data = battery,
 		.attr_grp = acpi_battery_groups,
@@ -1026,11 +1030,9 @@ static int acpi_battery_update(struct acpi_battery *battery, bool resume)
 		return result;
 	acpi_battery_quirks(battery);
 
-	if (!battery->bat) {
-		result = sysfs_add_battery(battery);
-		if (result)
-			return result;
-	}
+	result = sysfs_add_battery(battery);
+	if (result)
+		return result;
 
 	/*
 	 * Wakeup the system if battery is critical low
@@ -1112,12 +1114,12 @@ static int battery_notify(struct notifier_block *nb,
 			result = acpi_battery_get_info(battery);
 			if (result)
 				return result;
-
-			result = sysfs_add_battery(battery);
-			if (result)
-				return result;
 		}
 
+		result = sysfs_add_battery(battery);
+		if (result)
+			return result;
+
 		acpi_battery_init_alarm(battery);
 		acpi_battery_get_state(battery);
 		break;
-- 
2.43.0


