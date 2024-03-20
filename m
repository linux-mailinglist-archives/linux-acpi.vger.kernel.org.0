Return-Path: <linux-acpi+bounces-4389-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1069880ABB
	for <lists+linux-acpi@lfdr.de>; Wed, 20 Mar 2024 06:37:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6541828399B
	for <lists+linux-acpi@lfdr.de>; Wed, 20 Mar 2024 05:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EC5F14291;
	Wed, 20 Mar 2024 05:36:57 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from njjs-sys-mailin01.njjs.baidu.com (mx314.baidu.com [180.101.52.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE92817557
	for <linux-acpi@vger.kernel.org>; Wed, 20 Mar 2024 05:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.101.52.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710913017; cv=none; b=Hk39mhOHwJ7QpY0Xyb25uw5FKlpFpn2DGfOucN44e8HwfEc7l5hwiYdxLcfvB7HPVjGdUdtFVfOdkVo5sk43lD8iK5oJCTq0jQShFoG4jIiFTlDlu+7SIn39IiEoj8EMyDG7BzLy2VsGqYc2n1FQIZFfe7N2YurZsONx6g/zVG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710913017; c=relaxed/simple;
	bh=o3Z7/yNfu36AsYV0iejFlvdnfK6b0aFiAcpDb6yU13A=;
	h=From:To:Cc:Subject:Date:Message-Id; b=YJEZYBCbN/EEqVwHX+C7Th1L5UVMs+upOTlqBB1zAYNBPoVEa8OIjsSvGM4FcgeCK8sXWqLrVjaZHqPebPJ/SCGshfGtvslFxMEot/9APvyEt38nBO3iLYxuC8bJQrvxh03e/7VK1Smp9Suxt6XzbhEV9+v8Kvbx+ifSp3+u/MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=180.101.52.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
Received: from localhost (bjhw-sys-rpm015653cc5.bjhw.baidu.com [10.227.53.39])
	by njjs-sys-mailin01.njjs.baidu.com (Postfix) with ESMTP id 4D7717F00044;
	Wed, 20 Mar 2024 13:27:28 +0800 (CST)
From: Li RongQing <lirongqing@baidu.com>
To: rafael@kernel.org,
	lenb@kernel.org,
	james.morse@arm.com,
	tony.luck@intel.com,
	bp@alien8.de,
	linux-acpi@vger.kernel.org
Cc: Li RongQing <lirongqing@baidu.com>
Subject: [PATCH] acpi/ghes: load balance timers
Date: Wed, 20 Mar 2024 13:27:24 +0800
Message-Id: <20240320052724.41099-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.9.4
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

Kernel needs to set up a timer for each poll type notification, On
some system, these are tens of thousands of timers, which expires
periodically and preempt one CPU which calls ghes_probe at boot stage

so load balance evenly timers to all online cpus, reduce task jitter

Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 drivers/acpi/apei/ghes.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index ab2a82c..7bc7053 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -934,9 +934,10 @@ static int ghes_proc(struct ghes *ghes)
 	return rc;
 }
 
-static void ghes_add_timer(struct ghes *ghes)
+static void ghes_add_timer(struct ghes *ghes, bool probe)
 {
 	struct acpi_hest_generic *g = ghes->generic;
+	static int cpu_running_timer;
 	unsigned long expire;
 
 	if (!g->notify.poll_interval) {
@@ -946,7 +947,16 @@ static void ghes_add_timer(struct ghes *ghes)
 	}
 	expire = jiffies + msecs_to_jiffies(g->notify.poll_interval);
 	ghes->timer.expires = round_jiffies_relative(expire);
-	add_timer(&ghes->timer);
+
+	if (probe) {
+		cpu_running_timer = cpumask_next(cpu_running_timer, cpu_online_mask);
+		if (cpu_running_timer >= nr_cpu_ids)
+			cpu_running_timer = cpumask_first(cpu_online_mask);
+
+		add_timer_on(&ghes->timer, cpu_running_timer);
+	} else {
+		add_timer_on(&ghes->timer, raw_smp_processor_id());
+	}
 }
 
 static void ghes_poll_func(struct timer_list *t)
@@ -958,7 +968,7 @@ static void ghes_poll_func(struct timer_list *t)
 	ghes_proc(ghes);
 	spin_unlock_irqrestore(&ghes_notify_lock_irq, flags);
 	if (!(ghes->flags & GHES_EXITING))
-		ghes_add_timer(ghes);
+		ghes_add_timer(ghes, false);
 }
 
 static irqreturn_t ghes_irq_func(int irq, void *data)
@@ -1388,7 +1398,7 @@ static int ghes_probe(struct platform_device *ghes_dev)
 	switch (generic->notify.type) {
 	case ACPI_HEST_NOTIFY_POLLED:
 		timer_setup(&ghes->timer, ghes_poll_func, 0);
-		ghes_add_timer(ghes);
+		ghes_add_timer(ghes, true);
 		break;
 	case ACPI_HEST_NOTIFY_EXTERNAL:
 		/* External interrupt vector is GSI */
-- 
2.9.4


