Return-Path: <linux-acpi+bounces-20608-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4M2VAhQSd2kibwEAu9opvQ
	(envelope-from <linux-acpi+bounces-20608-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Jan 2026 08:04:52 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 644E484AC4
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Jan 2026 08:04:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C268E30010E6
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Jan 2026 07:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3196D28850E;
	Mon, 26 Jan 2026 07:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=picoheart-com.20200927.dkim.feishu.cn header.i=@picoheart-com.20200927.dkim.feishu.cn header.b="THbeQmMl"
X-Original-To: linux-acpi@vger.kernel.org
Received: from sg-1-33.ptr.blmpb.com (sg-1-33.ptr.blmpb.com [118.26.132.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6C42882D6
	for <linux-acpi@vger.kernel.org>; Mon, 26 Jan 2026 07:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769411089; cv=none; b=W/4PHBrdNcV7MtFfF5LVR2vBRrPl1CHxuPvcmoXzQYqLrWbGOwsu3YqWgVi9PTnwkCRkhEXvxtRgkDn7i+jU9dSsAbjwUL8K9GiANv4Pbc2qzemo2duNZ8+UOAccjK0Rxc5N5WimLnLCpvPYiwm81rmWXlx/4sp8pSY7lqx4JJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769411089; c=relaxed/simple;
	bh=k+Pq56kaBhDIsqjnSPFEoByzYgErIeuMA6WPFjuz0OU=;
	h=Content-Type:Subject:Date:To:Mime-Version:From:Message-Id:Cc; b=oT77CMHT/iR2BYbro1z9htRCl8F0LW/A8qanAOmqesAqjP5QgKaXe3j+O9/EfHSogJLEKpt15Tmw9kmYxIxd17Tci8QwFZrDr8kZ6jGJXtBQqWILqutVMwwe2CgyLEs5YpRmQ4eCmTE3w2anKXgPY4Z7Da8V0DE1f5aYOKTic9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=picoheart.com; spf=pass smtp.mailfrom=picoheart.com; dkim=pass (2048-bit key) header.d=picoheart-com.20200927.dkim.feishu.cn header.i=@picoheart-com.20200927.dkim.feishu.cn header.b=THbeQmMl; arc=none smtp.client-ip=118.26.132.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=picoheart.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=picoheart.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=picoheart-com.20200927.dkim.feishu.cn; t=1769411079;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=2yqg21lLKCVliEF5qtOlAEdet7rXGcpZ87WW4mE12/o=;
 b=THbeQmMlKUpE4f6/9nMw1N8liRgkaihY/TPMDgYMisa1gtB6LaIper8ZLYUxmWGHHjrgzU
 G0UFkKtfI5g2icP/j6/qSSPzJDFm2jnVs2zMugsatOM9MmpNnvGh/zXtqmPT2zkHpxiBgm
 Vvfm+iWZFDyX5djzPxWPTq3nWSPuPyymNk+j+YSRPMjXligWFReuWzAhUifs3WZ4SSHaEl
 MMnqrLHkEWZu534FezsrnwnC1/puohK0zjuw1+obbPU6i5Flfwq/uTCeI+cM5/R1yxg47o
 sFNeYEz/2dRWY5o1w9NDEeirFg4AZhXy/jJ6cF1YC0Wiq7RWA536Y2zB6AJeeQ==
Content-Type: text/plain; charset=UTF-8
X-Lms-Return-Path: <lba+269771205+d05844+vger.kernel.org+yang.yicong@picoheart.com>
Subject: [PATCH v2] ACPI: scan: Use async schedule function for acpi_scan_clear_dep_fn
Date: Mon, 26 Jan 2026 15:04:27 +0800
To: <rafael@kernel.org>, <lenb@kernel.org>, <tglx@kernel.org>, 
	<gregkh@linuxfoundation.org>, <dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: "Yicong Yang" <yang.yicong@picoheart.com>
Message-Id: <20260126070427.64574-1-yang.yicong@picoheart.com>
Received: from G9WYR9K0VW ([58.250.122.114]) by smtp.feishu.cn with ESMTPS; Mon, 26 Jan 2026 15:04:35 +0800
X-Original-From: Yicong Yang <yang.yicong@picoheart.com>
X-Mailer: git-send-email 2.50.1
Content-Transfer-Encoding: 7bit
Cc: <akpm@linux-foundation.org>, <apatel@ventanamicro.com>, <pjw@kernel.org>, 
	<palmer@dabbelt.com>, <aou@eecs.berkeley.edu>, <alex@ghiti.fr>, 
	<geshijian@picoheart.com>, <weidong.wd@picoheart.com>, 
	<yang.yicong@picoheart.com>, <linux-acpi@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[picoheart-com.20200927.dkim.feishu.cn:s=s1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[picoheart.com];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-20608-lists,linux-acpi=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yang.yicong@picoheart.com,linux-acpi@vger.kernel.org];
	DKIM_TRACE(0.00)[picoheart-com.20200927.dkim.feishu.cn:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_TWELVE(0.00)[17];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,picoheart.com:mid,picoheart.com:email,picoheart-com.20200927.dkim.feishu.cn:dkim]
X-Rspamd-Queue-Id: 644E484AC4
X-Rspamd-Action: no action

The device object rescan in acpi_scan_clear_dep_fn is scheduled
in the system workqueue which is not guaranteed to be finished
before entering userspace. This will cause the problem that
some key devices are missing when userspace init task tries to
find them. Two issues observed on our RISCV platforms:

- kernel panic due to userspace init cannot have an opened
  console. the console device scanning is queued by
  acpi_scan_clear_dep_queue and not finished by the time
  userspace init process running, thus by the time userspace
  init running, no console is created
- entering rescue shell due to no root devices (PCIe nvme in
  our case) found. same reason as above, the PCIe host bridge
  scanning is queued in above and finished after init process
  running.

The reason is because both devices (console, PCIe host bridge)
depend on riscv-aplic irqchip to serve their interrupts (console's
wired interrupt and PCI's INTx interrupts). In order to keep the
dependency these devices are scanned and created after riscv-aplic
initialized. The riscv-aplic is initialized in device_initcall and
queue the device scan work with acpi_scan_clear_dep_queue, it's
close to the time running userspace init process. Since system_dfl_wq
is used in acpi_scan_clear_dep_queue and no synchronization,
the issues will happen if userspace init runs before these devices
are ready.

The solution is to wait for the queued work finished before
entering userspace init. One possible way is to use a dedicated
workqueue instead of the system_dfl_wq, and explicitly flush
it somewhere in the initcall stage before entering userspace.
One other way is to use async_schedule_dev_nocall() for these
device scanning. It's designed for asynchronous initialization
and will work same as before since it's using a dedicated
unbound workqueue as well, but the kernel init code will
wait for the work finished (async_synchronize_full) right before
entering userspace init.

This patch use the second approach. Compared to a dedicated
workqueue, it's simpler since the async schedule framework have
handled most works like synchronization, memory allocation of
works and workqueue. The ACPI code only needs to focus on its
work. A dedicated workqueue for this could also be redundant
since some platforms don't need acpi_scan_clear_dep_queue()
for their device scanning.

Signed-off-by: Yicong Yang <yang.yicong@picoheart.com>
---
Change since v1:
Refine the commit message to:
- include the issues and the analysis
- include the reason for using the async schedule rather than
  a dedicated workqueue
Link: https://lore.kernel.org/linux-riscv/20260122073446.45628-2-yang.yicong@picoheart.com/

 drivers/acpi/scan.c | 40 ++++++++++++++++------------------------
 1 file changed, 16 insertions(+), 24 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 416d87f9bd10..64fcbd6a6adc 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -5,6 +5,7 @@
 
 #define pr_fmt(fmt) "ACPI: " fmt
 
+#include <linux/async.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
@@ -2360,44 +2361,35 @@ static int acpi_dev_get_next_consumer_dev_cb(struct acpi_dep_data *dep, void *da
 	return 0;
 }
 
-struct acpi_scan_clear_dep_work {
-	struct work_struct work;
-	struct acpi_device *adev;
-};
-
-static void acpi_scan_clear_dep_fn(struct work_struct *work)
+static void acpi_scan_clear_dep_fn(void *dev, async_cookie_t cookie)
 {
-	struct acpi_scan_clear_dep_work *cdw;
-
-	cdw = container_of(work, struct acpi_scan_clear_dep_work, work);
+	struct acpi_device *adev = to_acpi_device(dev);
 
 	acpi_scan_lock_acquire();
-	acpi_bus_attach(cdw->adev, (void *)true);
+	acpi_bus_attach(adev, (void *)true);
 	acpi_scan_lock_release();
 
-	acpi_dev_put(cdw->adev);
-	kfree(cdw);
+	acpi_dev_put(adev);
 }
 
 static bool acpi_scan_clear_dep_queue(struct acpi_device *adev)
 {
-	struct acpi_scan_clear_dep_work *cdw;
-
 	if (adev->dep_unmet)
 		return false;
 
-	cdw = kmalloc(sizeof(*cdw), GFP_KERNEL);
-	if (!cdw)
-		return false;
-
-	cdw->adev = adev;
-	INIT_WORK(&cdw->work, acpi_scan_clear_dep_fn);
 	/*
-	 * Since the work function may block on the lock until the entire
-	 * initial enumeration of devices is complete, put it into the unbound
-	 * workqueue.
+	 * Async schedule the deferred acpi_scan_clear_dep_fn() since:
+	 * - acpi_bus_attach() needs to hold acpi_scan_lock which cannot
+	 *   be acquired under acpi_dep_list_lock (held here)
+	 * - the deferred work at boot stage is ensured to be finished
+	 *   before userspace init task by the async_synchronize_full()
+	 *   barrier
+	 *
+	 * Use _nocall variant since it'll return on failure instead of
+	 * run the function synchronously.
 	 */
-	queue_work(system_dfl_wq, &cdw->work);
+	if (!async_schedule_dev_nocall(acpi_scan_clear_dep_fn, &adev->dev))
+		return false;
 
 	return true;
 }
-- 
2.34.1

