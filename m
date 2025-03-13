Return-Path: <linux-acpi+bounces-12206-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BD7DA5F9E5
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Mar 2025 16:30:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BD8D3BE642
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Mar 2025 15:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAFFD26A082;
	Thu, 13 Mar 2025 15:29:23 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00A0C269CE4;
	Thu, 13 Mar 2025 15:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741879763; cv=none; b=WhJ8aWgAm5+eMH4KBhBrqZ6x3FqT4VYyVWoUV0n0Ht1WLny6MLOLucbQungCOITLF81uzXDa4BjjnmYJssDYoSvNuuyjlNu9VZrbDdFcrZBCcWYKu5+vCSikeR0BEnmJDivwcH6N0BsLPoMUkk+n/HDmF+Y1urS3kR/GsDB7PKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741879763; c=relaxed/simple;
	bh=B8EHb3LaVA8gfgQZgvspynE6VO7zbRl64pscQoRy7m0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZpOZsBjfXWpbs8hqPvRE7zGtex0YUTHPxvVrlMq69KstKZglRm1jUWS/TsVk+mD7SjgPqQe82o+USjaC9x7p+Zn+r8v6Ir4Cl+puPlSvX0AfIK7KYoKgCT9xvfPMqhGZfZdNPyKFS01YQT3HhPueVCQwxht8nd1LoCkvdLKZuD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1E40A1F91;
	Thu, 13 Mar 2025 08:29:32 -0700 (PDT)
Received: from e133711.arm.com (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9CEF83F694;
	Thu, 13 Mar 2025 08:29:20 -0700 (PDT)
From: Sudeep Holla <sudeep.holla@arm.com>
Date: Thu, 13 Mar 2025 15:28:53 +0000
Subject: [PATCH v3 07/13] mailbox: pcc: Always map the shared memory
 communication address
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250313-pcc_fixes_updates-v3-7-019a4aa74d0f@arm.com>
References: <20250313-pcc_fixes_updates-v3-0-019a4aa74d0f@arm.com>
In-Reply-To: <20250313-pcc_fixes_updates-v3-0-019a4aa74d0f@arm.com>
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>, 
 Jassi Brar <jassisinghbrar@gmail.com>, Huisong Li <lihuisong@huawei.com>, 
 Adam Young <admiyo@os.amperecomputing.com>, 
 Robbie King <robbiek@xsightlabs.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3933; i=sudeep.holla@arm.com;
 h=from:subject:message-id; bh=B8EHb3LaVA8gfgQZgvspynE6VO7zbRl64pscQoRy7m0=;
 b=owEBbQKS/ZANAwAIAQBBurwxfuKYAcsmYgBn0vnE36q77T/PggfaIViWENqh1cHyygfb/NozL
 yvxbEZLoMuJAjMEAAEIAB0WIQS6ceUSBvMeskPdk+EAQbq8MX7imAUCZ9L5xAAKCRAAQbq8MX7i
 mG9gD/9+NbYExu97OOzyLW0tB1KyrODE0/5oBrEinhMdKNfssELj29NpeISq6FSmLH32Tf6ByVR
 g1QYvyLRyS5h+q34mubFj7vDvkGxKRF+EzzkXIUKfSytOgrGPNhZCeE0tHLUevc4ICfbFSjdzS9
 mWBikdTbQC2aS34iWB5yY/IkmqgNLUIzEoV2FjMSZy+g/BmqvIPMmh5CHKhbJlqP0MPEX5Nfla8
 98Kbp19om0lwJrR7VxqXzkSQoXhXPEPvwhyRufwY3+3ooluLgT1lwsT+GQ5Fn8Es8Ln0VTqxf1D
 EEluBGXMEIxTsvjwG/uYkl3CHM1yNZNxEBj72cwZyfr+T63KYVvratZi2/7WvZDsr3ZrCm2RWlz
 9dt4RVdWn8sNUlfr878GBeox0PcWXneOU++AE6Ssdi+EIoSnJTpaJ/StryL9r2IMx4nbh/Um5Tx
 fv8RgHqKYretyZXi+kwKqhDZd7I1gOGo5LAm2LqV0xSSlntV6KKH8Y+AYiaqKALZ2ZAVDtJxzNP
 OZsX/XbMY+bWlOT9HAFwgNRe68G7gD9n7YA+Zoo0ac+JKnKRTGYPt8LDUP/dZYRlcUnHS/Zq4Z8
 +JZs7CrSfFwAuzu9KmOC5k+ROcnpfRDE/+OtrpSFZjvhpqvIkvQ3Z4/g1Oqv+xb+pQh8F4+Lqcu
 o2zKI92OoeEx6Yw==
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

Note, until all the drivers using PCC start using this mapped shmem,
there might be double mapping of the shared memory address. This
shouldn't have any impact on existing mbox client drivers.

Since there are no users of pcc_chan_ioremap() and also it is mapped
by default, we can stop exporting it and merge the functionality into
pcc_mbox_request_channel().

Acked-by: Huisong Li <lihuisong@huawei.com>
Tested-by: Huisong Li <lihuisong@huawei.com>
Tested-by: Adam Young <admiyo@os.amperecomputing.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/mailbox/pcc.c | 29 +++++++++--------------------
 include/acpi/pcc.h    |  5 -----
 2 files changed, 9 insertions(+), 25 deletions(-)

diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
index c9e46e2266a46cad2d482c6a15e2737c47275ffb..d6671c18750eaa7de92f49d1ec9ad97eedadec1d 100644
--- a/drivers/mailbox/pcc.c
+++ b/drivers/mailbox/pcc.c
@@ -373,6 +373,7 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
 struct pcc_mbox_chan *
 pcc_mbox_request_channel(struct mbox_client *cl, int subspace_id)
 {
+	struct pcc_mbox_chan *pcc_mchan;
 	struct pcc_chan_info *pchan;
 	struct mbox_chan *chan;
 	int rc;
@@ -391,7 +392,14 @@ pcc_mbox_request_channel(struct mbox_client *cl, int subspace_id)
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
 
@@ -420,25 +428,6 @@ void pcc_mbox_free_channel(struct pcc_mbox_chan *pchan)
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


