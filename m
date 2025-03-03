Return-Path: <linux-acpi+bounces-11709-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57F97A4BD07
	for <lists+linux-acpi@lfdr.de>; Mon,  3 Mar 2025 11:56:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38830172B5D
	for <lists+linux-acpi@lfdr.de>; Mon,  3 Mar 2025 10:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D9D81F76C0;
	Mon,  3 Mar 2025 10:53:37 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF7CC1F63DD;
	Mon,  3 Mar 2025 10:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740999217; cv=none; b=IC66tP1wrbnpTA4TgGVXD6dzt3equOJPGctoUzP6Ca5/y+a7czy3U0Ridny1Yxv2fRPjT5P9SYQI5cVyE/TSxPuh6Szkl0LxsO5BUhfnBUITvy1Tmv5oKWH6KAYL/RlAu4PdGtEzYLG7QZhkQV+g9x4ejPMPWHtG4c9bKU6NBs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740999217; c=relaxed/simple;
	bh=u/6pDnj8GfpGPxOvBmX+S5++Zzp9jiVA6YkVnv/RF7w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=vAVmJqJ4djFx4kNuiSXGogjHbwipeU3mwNpBVmw0zTHeN1tKOSV8KGiGGdHdpe9jhcnPIpkWmZe2Y3oBG/LG2WUg2ENer45lFJmrKb1hkh8Ye3zt/2QiB9SOvpHWkR+aZ9KucLUHsgPA9oQKcKqZhqsA71BzcKcBmYCdfPQ7oes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B59052050;
	Mon,  3 Mar 2025 02:53:49 -0800 (PST)
Received: from e133711.arm.com (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 999CF3F673;
	Mon,  3 Mar 2025 02:53:34 -0800 (PST)
From: Sudeep Holla <sudeep.holla@arm.com>
Date: Mon, 03 Mar 2025 10:51:43 +0000
Subject: [PATCH 08/14] mailbox: pcc: Always map the shared memory
 communication address
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250303-pcc_fixes_updates-v1-8-3b44f3d134b1@arm.com>
References: <20250303-pcc_fixes_updates-v1-0-3b44f3d134b1@arm.com>
In-Reply-To: <20250303-pcc_fixes_updates-v1-0-3b44f3d134b1@arm.com>
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>, 
 Jassi Brar <jassisinghbrar@gmail.com>, Huisong Li <lihuisong@huawei.com>, 
 Adam Young <admiyo@os.amperecomputing.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2829; i=sudeep.holla@arm.com;
 h=from:subject:message-id; bh=u/6pDnj8GfpGPxOvBmX+S5++Zzp9jiVA6YkVnv/RF7w=;
 b=owEBbQKS/ZANAwAIAQBBurwxfuKYAcsmYgBnxYohv0tbYJUI9NBdgz6trA4YrihHK9pvMOqaW
 iekSWMGbJOJAjMEAAEIAB0WIQS6ceUSBvMeskPdk+EAQbq8MX7imAUCZ8WKIQAKCRAAQbq8MX7i
 mN9DEACmnhnEl+a/7SPtIdCrcfL9HFOkAree8/iMwdErsgYhZZeIKr4EzujhoNPxqnFEnNxRReQ
 pZ9C/G+vL2HZcYyhOKpgDmsKuC1bZfGZUvj4yc0IMUUNoCrnwMSIyzAXLFdRS0/LtHhnhB1TU3m
 tSslNs4OIY8TzozNl4DhqObXHFR5uUJHif/DTUf+OB/SM53WTXHnGzTosINQbpRW3aar8dOjbh1
 SC+x9onWUT7Fcsc8yaM3IMRJHRotdlbqgBbYox/BnGBEKDzAvMsRnTJVJWvPZQoplismugucYk0
 kBVvhVM+Yskr4i9t5N+H7XEreaxnn/iXk1i6Hca5Oj1rEogQxQ151Fc/YYg4Q3sgkOg2wZ6eCkF
 eTuzkDWVRCjOje0wVBnzW88Xuv+NGPyXOArDJN6fAhFqptXY5S+WFkX7qM7/hxEwPaDhNTAelBw
 GKx12zL8/KCMQ5VMHk0cClrAkMIDtheoiXG4N62HofNiu1PKY7vsvgI2pvVL9wQ/ygyYTgFKbn9
 0pGWKgM3UDcgeawnArentODV/spALgxmhRXq6T0QN8kRkuERmH2EVpb+eJERfEoEfZ9o3+fP1lO
 lPyq5z5Nul+noTXW7vN9GhC1E+v6wdZNYh+NpmSCflz42+8yJFNsBJapb5MCUmxhwbISSzh74VY
 RkURlvzUACEr2rQ==
X-Developer-Key: i=sudeep.holla@arm.com; a=openpgp;
 fpr=7360A21742ADF5A11767C1C139CFD4755FE2D5B4

Currently the shared memory communication address was mapped by the
mailbox client drivers leading to all sorts of inconsistencies.

It also has resulted in the inconsistent attributes used while mapping
the shared memory regions.

In order to remove/eliminate any issues, let us ensures the shared
memory address is always mapped and unmapped when the PCC channels are
requested and release.

We need to map them as the ACPI PCCT associates these shared memory
with each channel subspace and may need use the headers in those
memory to manage the transport.

Since there are no users of pcc_chan_ioremap() and also it is mapped
by default, we can stop exporting it and make it static function.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/mailbox/pcc.c | 10 +++++++---
 include/acpi/pcc.h    |  5 -----
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
index f230e512c29b79fc03e429145180ff049a250d2d..5f2e2b727d99f07c44e87e44c11ba0aefe3a2318 100644
--- a/drivers/mailbox/pcc.c
+++ b/drivers/mailbox/pcc.c
@@ -357,7 +357,7 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
 	return IRQ_HANDLED;
 }
 
-int pcc_mbox_ioremap(struct mbox_chan *chan)
+static int pcc_mbox_ioremap(struct mbox_chan *chan)
 {
 	struct pcc_chan_info *pchan_info;
 	struct pcc_mbox_chan *pcc_mbox_chan;
@@ -374,7 +374,6 @@ int pcc_mbox_ioremap(struct mbox_chan *chan)
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(pcc_mbox_ioremap);
 
 /**
  * pcc_mbox_request_channel - PCC clients call this function to
@@ -409,7 +408,12 @@ pcc_mbox_request_channel(struct mbox_client *cl, int subspace_id)
 	if (rc)
 		return ERR_PTR(rc);
 
-	return &pchan->chan;
+	rc = pcc_mbox_ioremap(chan);
+	if (!rc)
+		return &pchan->chan;
+
+	mbox_free_channel(chan);
+	return ERR_PTR(rc);
 }
 EXPORT_SYMBOL_GPL(pcc_mbox_request_channel);
 
diff --git a/include/acpi/pcc.h b/include/acpi/pcc.h
index 699c1a37b8e7846362bae35477eb5736be15d79e..0462bb9da6513a241f3b652b8e203299a1d990c7 100644
--- a/include/acpi/pcc.h
+++ b/include/acpi/pcc.h
@@ -38,7 +38,6 @@ struct pcc_mbox_chan {
 extern struct pcc_mbox_chan *
 pcc_mbox_request_channel(struct mbox_client *cl, int subspace_id);
 extern void pcc_mbox_free_channel(struct pcc_mbox_chan *chan);
-extern int pcc_mbox_ioremap(struct mbox_chan *chan);
 #else
 static inline struct pcc_mbox_chan *
 pcc_mbox_request_channel(struct mbox_client *cl, int subspace_id)
@@ -46,10 +45,6 @@ pcc_mbox_request_channel(struct mbox_client *cl, int subspace_id)
 	return ERR_PTR(-ENODEV);
 }
 static inline void pcc_mbox_free_channel(struct pcc_mbox_chan *chan) { }
-static inline int pcc_mbox_ioremap(struct mbox_chan *chan)
-{
-	return 0;
-};
 #endif
 
 #endif /* _PCC_H */

-- 
2.34.1


