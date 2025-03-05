Return-Path: <linux-acpi+bounces-11847-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57003A50566
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Mar 2025 17:43:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A43453AA2A4
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Mar 2025 16:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C4A253F0D;
	Wed,  5 Mar 2025 16:39:10 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4DE2253B6C;
	Wed,  5 Mar 2025 16:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741192750; cv=none; b=F3hOXu9fFHneU7FlsBSFGYtSX/k/44mDiUmQyJ+yDWybJMKK1lP5HW++DZEeaZM+EyY1BLsE2BTQV9NOUX7k8kzx6CX74fOnY9X1ANWt/NImLXOOL3pLG2qPwYpLySIr3Zl+kjrt62LStuVSlNt/jbCT8ujutx4F5sa102VC4jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741192750; c=relaxed/simple;
	bh=3gG4bhdBBdPQXYHnCh1tDD44kshqbRCDD5IBuZJ5OCQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ce6T1jo2VLcYRGM3tU0KZJYy4qurYftw7cROn6AcqN1QZMqvtT5ea8epQn/NrGWIP1w8XwJXD1kmBWR6qB7Q6M37PMaoWhuvAsUTZsD5Tp0y/lN+jhFrgzbMr95chaoHdM7WAfzcgIKq4IcvQM4Gw9uTqkWv61DtBRSDEV0nkRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EBA0F175D;
	Wed,  5 Mar 2025 08:39:21 -0800 (PST)
Received: from e133711.arm.com (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 841883F5A1;
	Wed,  5 Mar 2025 08:39:07 -0800 (PST)
From: Sudeep Holla <sudeep.holla@arm.com>
Date: Wed, 05 Mar 2025 16:38:11 +0000
Subject: [PATCH v2 07/13] mailbox: pcc: Always map the shared memory
 communication address
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250305-pcc_fixes_updates-v2-7-1b1822bc8746@arm.com>
References: <20250305-pcc_fixes_updates-v2-0-1b1822bc8746@arm.com>
In-Reply-To: <20250305-pcc_fixes_updates-v2-0-1b1822bc8746@arm.com>
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>, 
 Jassi Brar <jassisinghbrar@gmail.com>, Huisong Li <lihuisong@huawei.com>, 
 Adam Young <admiyo@os.amperecomputing.com>, 
 Robbie King <robbiek@xsightlabs.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3589; i=sudeep.holla@arm.com;
 h=from:subject:message-id; bh=3gG4bhdBBdPQXYHnCh1tDD44kshqbRCDD5IBuZJ5OCQ=;
 b=owEBbQKS/ZANAwAIAQBBurwxfuKYAcsmYgBnyH4fKGUhzok51QkKceWpORVOsgFh4eaCT86xb
 Ap8QvMV+7WJAjMEAAEIAB0WIQS6ceUSBvMeskPdk+EAQbq8MX7imAUCZ8h+HwAKCRAAQbq8MX7i
 mAt4EADVZw+JPfCSfHGsbdintdw7QqBVsxE/5Jbgs0YTNfb3HRGGSNnHt7ULjk7gJToWABMuded
 1HsSdhUYAOiicBhuaMk+J0FAV8SJJVtULfkKzLMvLtSZYmdMt91WTxIYZmF8JAWgblSybtKcK+R
 x9m2BmgpRgEE4qnYwT3mAIAWjKr5wQFZd6REvfZj6GAtAEzc+KJ1+3BALwBvemn2s4tlRMs9fxq
 UGaazyhSEvvM3LDgl7dFS/+F1yxobViQGNBa9dDoEmRI0KH6T18c5Hes1k872eV2o79fjmrZvO9
 E587oC7AgwmlmsayO3V6F+OfpHDntjNRsbngD94o8uNlbVDK2wgknvQLWeQDvuh2JShTCJQ/JMY
 E31ovzHPopOTu6AgPhWdNWv0Si9Lr3sZGrM8qaXxqPoZ3RaTE4YvB1CnjPqoJak7MtBfqugWOTI
 gPNWmy6wsbBmNxPI18wWo/nifSmEimlkODMoWSxvuhcZ4gs+fBKfseoLcwPYFWJyiAw0F0Xj31W
 qmZ2oPBkeaGr5o8/a3aoxnHgWNfkBkEdhYXoYtuXBko3ScpwnMlegX4zhvon0ASCVc8/YE3n9Yw
 2AJ3RYUuKqLv2cjGUMHlQ9NdhCY2L8FuPpBKW/TuvwqWK6vxJ9Ou7fGxxq0HK8KqpUNurOVLZNL
 6P1CoAMiiTr7qOQ==
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
with each channel subspace and may need use the status or the flags in
the headers of those shared memory communication address regions to
manage the transport/channel.

Since there are no users of pcc_chan_ioremap() and also it is mapped
by default, we can stop exporting it and merge the functionality into
pcc_mbox_request_channel().

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/mailbox/pcc.c | 29 +++++++++--------------------
 include/acpi/pcc.h    |  5 -----
 2 files changed, 9 insertions(+), 25 deletions(-)

diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
index 41bd14851216e8c4f03052c81aaf938a5e5c5343..b3d133170aac7f8acfd1999564c69b7fe4f6d582 100644
--- a/drivers/mailbox/pcc.c
+++ b/drivers/mailbox/pcc.c
@@ -372,6 +372,7 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
 struct pcc_mbox_chan *
 pcc_mbox_request_channel(struct mbox_client *cl, int subspace_id)
 {
+	struct pcc_mbox_chan *pcc_mchan;
 	struct pcc_chan_info *pchan;
 	struct mbox_chan *chan;
 	int rc;
@@ -390,7 +391,14 @@ pcc_mbox_request_channel(struct mbox_client *cl, int subspace_id)
 	if (rc)
 		return ERR_PTR(rc);
 
-	return &pchan->chan;
+	pcc_mchan = &pchan->chan;
+	pcc_mchan->shmem = acpi_os_ioremap(pcc_mchan->shmem_base_addr,
+					   pcc_mchan->shmem_size);
+	if (pcc_mchan->shmem)
+		return pcc_mchan;
+
+	mbox_free_channel(chan);
+	return ERR_PTR(-ENXIO);
 }
 EXPORT_SYMBOL_GPL(pcc_mbox_request_channel);
 
@@ -419,25 +427,6 @@ void pcc_mbox_free_channel(struct pcc_mbox_chan *pchan)
 }
 EXPORT_SYMBOL_GPL(pcc_mbox_free_channel);
 
-int pcc_mbox_ioremap(struct mbox_chan *chan)
-{
-	struct pcc_chan_info *pchan_info;
-	struct pcc_mbox_chan *pcc_mbox_chan;
-
-	if (!chan || !chan->cl)
-		return -1;
-	pchan_info = chan->con_priv;
-	pcc_mbox_chan = &pchan_info->chan;
-
-	pcc_mbox_chan->shmem = acpi_os_ioremap(pcc_mbox_chan->shmem_base_addr,
-					       pcc_mbox_chan->shmem_size);
-	if (!pcc_mbox_chan->shmem)
-		return -ENXIO;
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(pcc_mbox_ioremap);
-
 /**
  * pcc_send_data - Called from Mailbox Controller code. Used
  *		here only to ring the channel doorbell. The PCC client
diff --git a/include/acpi/pcc.h b/include/acpi/pcc.h
index d1e506f041c5a80857d4a025fa3c1803746ba4b9..840bfc95bae3329605da5f66cf37b7d2ca183f48 100644
--- a/include/acpi/pcc.h
+++ b/include/acpi/pcc.h
@@ -37,7 +37,6 @@ struct pcc_mbox_chan {
 extern struct pcc_mbox_chan *
 pcc_mbox_request_channel(struct mbox_client *cl, int subspace_id);
 extern void pcc_mbox_free_channel(struct pcc_mbox_chan *chan);
-extern int pcc_mbox_ioremap(struct mbox_chan *chan);
 #else
 static inline struct pcc_mbox_chan *
 pcc_mbox_request_channel(struct mbox_client *cl, int subspace_id)
@@ -45,10 +44,6 @@ pcc_mbox_request_channel(struct mbox_client *cl, int subspace_id)
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


