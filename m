Return-Path: <linux-acpi+bounces-16442-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C677B478D2
	for <lists+linux-acpi@lfdr.de>; Sun,  7 Sep 2025 05:52:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F07E01B241DA
	for <lists+linux-acpi@lfdr.de>; Sun,  7 Sep 2025 03:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B00461B0437;
	Sun,  7 Sep 2025 03:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="aRcc4k/0"
X-Original-To: linux-acpi@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C71B0315D3D;
	Sun,  7 Sep 2025 03:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757217129; cv=none; b=K84juzqGrIIIWHdDgta+M9809bRWHP2CyrdDkOZ02QQ3JQaLZ+CCJ0SYbcs7tt0AquQCAzXHo1jEC+6eq0UXovyN5070G8kRGsPZfMZbMqArWaoRtBdFHJv1q0LL9njQXD6+wsMP+gCC6uYFKtbKWvUfOg8GxwXvWSsqpJKwbHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757217129; c=relaxed/simple;
	bh=Tl8YpPtuRNIadTCPhU/fMyQ53LFlCEAX9RW7s4o69cc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fA8FDaKQqGmFE3P6MOk77MhGUF/uyIOi4u/nzrD2jZCUnyp+w6FjFdNYHGCuU2EeaNLvYCONCXF3nKu/VRpIRMnK11uBL9BLodMNU8EAPXNk933iFn1754sNG9zuV/xT6tHXHqBHFsM+bbdRAQxX0zzhiCdRZsHHsjtRHK6WHi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=aRcc4k/0; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=V/
	xQFFWxTDo1tog0Es80vL2GMWcHu/THTjRpMN4btPM=; b=aRcc4k/0htN3TFWm4G
	/1YmU+8zMkbO8X2qmJyje6EtP94KHMJxE2DaHZGON88oXAvwMlOHQnNCGRz9ktDV
	oTosxPe6QIaE/Hpj17Xu2vqhrpvXeESEVsRb2/R1w7TEaXeFi9nagtjnlXxTk38g
	KFY4pY8mHGakCo4hdWm9wKlWo=
Received: from MS-CMFLBWVCLQRG.localdomain (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgD3_z1cAb1oHz8iCA--.51324S2;
	Sun, 07 Sep 2025 11:51:57 +0800 (CST)
From: GuangFei Luo <luogf2025@163.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	luogf2025@163.com
Subject: [PATCH] ACPI: battery: prevent sysfs_add_battery re-entry on rapid events
Date: Sun,  7 Sep 2025 11:51:54 +0800
Message-ID: <20250907035154.223983-1-luogf2025@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgD3_z1cAb1oHz8iCA--.51324S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3AF43ur1kWw4fWF43uF18Grg_yoW7Grykpa
	1rKayUKrW8JF4kJwsI9F4UKFyxuFs0qF9rWr95Jrn2kasrCw1DAryxZFyUX3W7GrykZ3yx
	ZFn5t3Wrtw1xWw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U918QUUUUU=
X-CM-SenderInfo: poxrwwisqskqqrwthudrp/xtbBXxDBmWi88ZrvpAAAsj

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

Fixes: 508df92d1f8d ("ACPI: battery: register power_supply subdevice only when battery is present")
Signed-off-by: GuangFei Luo <luogf2025@163.com>
Cc: stable@vger.kernel.org
---
 drivers/acpi/battery.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 6905b56bf3e4..3801fd34c969 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -1026,11 +1026,13 @@ static int acpi_battery_update(struct acpi_battery *battery, bool resume)
 		return result;
 	acpi_battery_quirks(battery);
 
+	mutex_lock(&battery->sysfs_lock);
 	if (!battery->bat) {
 		result = sysfs_add_battery(battery);
 		if (result)
 			return result;
 	}
+	mutex_unlock(&battery->sysfs_lock);
 
 	/*
 	 * Wakeup the system if battery is critical low
-- 
2.43.0


