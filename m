Return-Path: <linux-acpi+bounces-20500-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WJahAf/UcWk+MgAAu9opvQ
	(envelope-from <linux-acpi+bounces-20500-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jan 2026 08:42:55 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A2F8D629C3
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jan 2026 08:42:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 58F05365634
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jan 2026 07:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBB6E47DFAA;
	Thu, 22 Jan 2026 07:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=picoheart-com.20200927.dkim.feishu.cn header.i=@picoheart-com.20200927.dkim.feishu.cn header.b="jhH9+h6A"
X-Original-To: linux-acpi@vger.kernel.org
Received: from sg-1-33.ptr.blmpb.com (sg-1-33.ptr.blmpb.com [118.26.132.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881B131AF2C
	for <linux-acpi@vger.kernel.org>; Thu, 22 Jan 2026 07:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769067314; cv=none; b=LtEfPe9N6b3Bw4cSoNPfTPXi1D0vKEl8UY3EPGB4CyjuhQ3OrQUwnX1dhn81ghBX/OjWC/zY3JUV1o7MsnaPdBvyXBfXES4DbpR2LJBfwD3UHxMywv8ceA6L+lqbrzot1DYiZ3gotK3ArOv/oxLNsVsgdUg52waIvemeBb1IPG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769067314; c=relaxed/simple;
	bh=ZA0dShh7LmxgkvKWG26Qxxa83Xo5UPsRGqNF5OMLKA4=;
	h=References:Date:Message-Id:Mime-Version:To:Cc:In-Reply-To:
	 Content-Type:From:Subject; b=UvanpAy7AVVz5Jc3mOLwiK2i+YKJoeNM/ss5ECI/klybohRi2XO0/2temB3xo5mSLmmxATRdAxfFhOxwyEAlZ+FQmjaEfC0CCK0WarS2lOh8bbeo251UrfyJGu2AE0iNVaALFaCO3vJ4/oY1g6p8azh7AhCSzGM67VcKybhbPgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=picoheart.com; spf=pass smtp.mailfrom=picoheart.com; dkim=pass (2048-bit key) header.d=picoheart-com.20200927.dkim.feishu.cn header.i=@picoheart-com.20200927.dkim.feishu.cn header.b=jhH9+h6A; arc=none smtp.client-ip=118.26.132.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=picoheart.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=picoheart.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=picoheart-com.20200927.dkim.feishu.cn; t=1769067294;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=01FP4vC/jj6alLbiTxMoouO+ZRSgO8bEdY/088MJqcA=;
 b=jhH9+h6AHNS2KkO5f4Zec42IGeHlvuo9vSXwxd+jiKkpEJOKkTi7rWdJOMGHXLKhctyhPR
 VrM7bErmHnwghcMI2vPN6QRu96+Cd+atsZoFvpaV11yiHRg5sNwmaH20M+ihAsIwVvA0l9
 Sg/QFlD1GUF86MUqVG0snmzxsb+rTZ0rOcxR6Vg5VJAO+dyuanMByrag3S5ero+XtR70jf
 niyjNX07WFXktwMWPbnoQM8IxnwwotNp/qOoq/vEMklXOcWsQWm/weqvwfR+Mvs/TXwF6h
 181ZMf9pdCNmBuJd0ry9aW/Nd/IAGZ10BJWmneEDmG7xAbO3VerXEV54v/IdNw==
References: <20260122073446.45628-1-yang.yicong@picoheart.com>
Date: Thu, 22 Jan 2026 15:34:45 +0800
Message-Id: <20260122073446.45628-2-yang.yicong@picoheart.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
To: <rafael@kernel.org>, <lenb@kernel.org>, <tglx@kernel.org>, 
	<gregkh@linuxfoundation.org>, <dakr@kernel.org>
Content-Transfer-Encoding: 7bit
Cc: <akpm@linux-foundation.org>, <apatel@ventanamicro.com>, <pjw@kernel.org>, 
	<palmer@dabbelt.com>, <aou@eecs.berkeley.edu>, <alex@ghiti.fr>, 
	<geshijian@picoheart.com>, <weidong.wd@picoheart.com>, 
	<yang.yicong@picoheart.com>, <linux-acpi@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
In-Reply-To: <20260122073446.45628-1-yang.yicong@picoheart.com>
Received: from G9WYR9K0VW ([58.250.122.114]) by smtp.feishu.cn with ESMTPS; Thu, 22 Jan 2026 15:34:52 +0800
X-Original-From: Yicong Yang <yang.yicong@picoheart.com>
X-Lms-Return-Path: <lba+26971d31c+d2fcd4+vger.kernel.org+yang.yicong@picoheart.com>
Content-Type: text/plain; charset=UTF-8
From: "Yicong Yang" <yang.yicong@picoheart.com>
Subject: [PATCH 1/2] ACPI: scan: Use async schedule function for acpi_scan_clear_dep_fn
X-Mailer: git-send-email 2.50.1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[picoheart-com.20200927.dkim.feishu.cn:s=s1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20500-lists,linux-acpi=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[picoheart.com];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yang.yicong@picoheart.com,linux-acpi@vger.kernel.org];
	DKIM_TRACE(0.00)[picoheart-com.20200927.dkim.feishu.cn:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[linux-acpi];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns,picoheart-com.20200927.dkim.feishu.cn:dkim]
X-Rspamd-Queue-Id: A2F8D629C3
X-Rspamd-Action: no action

The device object rescan in acpi_scan_clear_dep_fn is scheduled
in the system workqueue which is not guaranteed to be finished
before entering userspace. This will cause the problem that
some key devices are missed when the init task try to find them,
e.g. console devices and root devices (PCIe nvme, etc).
This issues is more possbile to happen on RISCV since these
devices using GSI interrupt may depend on APLIC and will be
scanned in acpi_scan_clear_dep_queue() after APLIC initialized.

Fix this by scheduling the acpi_scan_clear_dep_queue() using async
schedule function rather than the system workqueue. The deferred
works will be synchronized by async_synchronize_full() before
entering init task.

Update the comment as well.

Signed-off-by: Yicong Yang <yang.yicong@picoheart.com>
---
 drivers/acpi/scan.c | 35 ++++++++++++++++-------------------
 1 file changed, 16 insertions(+), 19 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 416d87f9bd10..bf0d8ba9ba19 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -5,6 +5,7 @@
 
 #define pr_fmt(fmt) "ACPI: " fmt
 
+#include <linux/async.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
@@ -2365,39 +2366,35 @@ struct acpi_scan_clear_dep_work {
 	struct acpi_device *adev;
 };
 
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
+	 *   before entering init task by the async_synchronize_full()
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

