Return-Path: <linux-acpi+bounces-17839-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B6DBBE5309
	for <lists+linux-acpi@lfdr.de>; Thu, 16 Oct 2025 21:10:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D41A9488BE4
	for <lists+linux-acpi@lfdr.de>; Thu, 16 Oct 2025 19:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FEA225F984;
	Thu, 16 Oct 2025 19:08:59 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 801BC2571AA;
	Thu, 16 Oct 2025 19:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760641739; cv=none; b=Lm4ZPw864NERLQ5AZmb6jTG3vFdS2JVzVgQZ3WB86jPF20hMOT4/Umb6p/i3TvubnHRwpRCyE8oKXeH4efC1TM8Rf/P3Nd17IoFq7tW69sXyrf/0QbWAzHC6IwHzyH/i9cxhzC4Ali3LeccVo32LC0EfrTQcFqoreVHkFhGJdYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760641739; c=relaxed/simple;
	bh=TcLZBptfMmxPgr+fAZMbOjN+sil3hhOQPsw4F6Xo8zQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hc2mSk52UQ2PRlFIkhPCO9w5zLJXFC/xpIbO0jeQpDqaAo6nHtMReoLOilaoG+XmO9g8VfFd/I937v8zhcsZc5Vd+gNiVBnVvY6hz4eG4vYCMklOdHzPy7DUcd8j+ECT6lOakUE99Tpnly/KsES5faGF1hs2eC6hPO4QzyMlBbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 631871713;
	Thu, 16 Oct 2025 12:08:49 -0700 (PDT)
Received: from e133711.arm.com (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 04FCE3F66E;
	Thu, 16 Oct 2025 12:08:55 -0700 (PDT)
From: Sudeep Holla <sudeep.holla@arm.com>
Date: Thu, 16 Oct 2025 20:08:19 +0100
Subject: [PATCH 5/6] mailbox: pcc: Initialize SHMEM before binding the
 channel with the client
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251016-pcc_mb_updates-v1-5-0fba69616f69@arm.com>
References: <20251016-pcc_mb_updates-v1-0-0fba69616f69@arm.com>
In-Reply-To: <20251016-pcc_mb_updates-v1-0-0fba69616f69@arm.com>
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>, 
 Adam Young <admiyo@os.amperecomputing.com>, 
 Robbie King <robbiek@xsightlabs.com>, Huisong Li <lihuisong@huawei.com>, 
 Jassi Brar <jassisinghbrar@gmail.com>, 
 Cristian Marussi <cristian.marussi@arm.com>
X-Mailer: b4 0.14.3

The PCC channel's shared memory region must be set up before the
mailbox controller binds the channel with the client, as the binding
process may trigger client operations like startup() that may rely on
SHMEM being initialized.

Reorder the setup sequence to ensure the shared memory is ready before
binding. Initialize and map the PCC shared memory (SHMEM) prior to
calling mbox_bind_client() so that clients never observe an uninitialized
or NULL SHMEM during bind-time callbacks or early use in startup().

This makes the PCC mailbox channel bring-up order consistent and
eliminates a race between SHMEM setup and client binding.

This will be needed in channel startup to clear/acknowledge any pending
interrupts before enabling them.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/mailbox/pcc.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
index 33bd2d05704b..2829ec51b47f 100644
--- a/drivers/mailbox/pcc.c
+++ b/drivers/mailbox/pcc.c
@@ -378,18 +378,20 @@ pcc_mbox_request_channel(struct mbox_client *cl, int subspace_id)
 		return ERR_PTR(-EBUSY);
 	}
 
-	rc = mbox_bind_client(chan, cl);
-	if (rc)
-		return ERR_PTR(rc);
-
 	pcc_mchan = &pchan->chan;
 	pcc_mchan->shmem = acpi_os_ioremap(pcc_mchan->shmem_base_addr,
 					   pcc_mchan->shmem_size);
-	if (pcc_mchan->shmem)
-		return pcc_mchan;
+	if (!pcc_mchan->shmem)
+		return ERR_PTR(-ENXIO);
 
-	mbox_free_channel(chan);
-	return ERR_PTR(-ENXIO);
+	rc = mbox_bind_client(chan, cl);
+	if (rc) {
+		iounmap(pcc_mchan->shmem);
+		pcc_mchan->shmem = NULL;
+		return ERR_PTR(rc);
+	}
+
+	return pcc_mchan;
 }
 EXPORT_SYMBOL_GPL(pcc_mbox_request_channel);
 

-- 
2.34.1


