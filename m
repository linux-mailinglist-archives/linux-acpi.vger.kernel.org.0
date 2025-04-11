Return-Path: <linux-acpi+bounces-12977-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B42CFA85BBF
	for <lists+linux-acpi@lfdr.de>; Fri, 11 Apr 2025 13:34:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CE1519E68CD
	for <lists+linux-acpi@lfdr.de>; Fri, 11 Apr 2025 11:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5956E298CD9;
	Fri, 11 Apr 2025 11:31:56 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB587278E60;
	Fri, 11 Apr 2025 11:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744371116; cv=none; b=Ygqs0UZMVvmHu5sMebNg5SMxUR07JwHFDuei5ST5mAgEmhtSoShhNZMsHEp90mlhkQDbP6bQxzKauyarnXYdlMH8j1DU7YfpEv94rQY0iMjRJO73V/K/h7uo0sLd1PddJ9MU6XzY5BULLJzvGRA9TOrvwBgOh4yMy5saWdlgWcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744371116; c=relaxed/simple;
	bh=aLvMBz2ah1Gbaj8cL1la3W7NMjyuYp7nuvaHRKjRnMQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=L1xJEXR6GBQxPDC1+Om8zbKiZCtTf4T/+J1BkMplRfbRxUEwNEh0FpoSsr2VNHSlnoSIPTt/71c6rdoQzY0uYzDWyoyu1Q484jZMot7EMq1webxJ/bDkSuKgT090R9J9IEygxDeMcDlATUCjmmnGZC0nEqBmoCeConN8yStx7o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com; spf=none smtp.mailfrom=foss.arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=foss.arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 19AE7106F;
	Fri, 11 Apr 2025 04:31:54 -0700 (PDT)
Received: from usa.arm.com (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 59AB73F694;
	Fri, 11 Apr 2025 04:31:53 -0700 (PDT)
From: Sudeep Holla <sudeep.holla@arm.com>
To: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Adam Young <admiyo@os.amperecomputing.com>
Subject: [PATCH 2/2] ACPI: CPPC: Simplify PCC shared memory region handling
Date: Fri, 11 Apr 2025 12:31:44 +0100
Message-Id: <20250411113144.1151094-2-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250411113144.1151094-1-sudeep.holla@arm.com>
References: <20250411113144.1151094-1-sudeep.holla@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The PCC driver now handles mapping and unmapping of shared memory
areas as part of pcc_mbox_{request,free}_channel(). Without these before,
this ACPI CPPC driver did handling of those mappings like several
other PCC mailbox client drivers.

There were redundant operations, leading to unnecessary code. Maintaining
the consistency across these driver was harder due to scattered handling
of shmem.

Just use the mapped shmem and remove all redundant operations from this
driver.

Cc: Rafael J. Wysocki <rafael@kernel.org>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/acpi/cppc_acpi.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index f193e713825a..d972157a79b6 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -47,7 +47,6 @@
 
 struct cppc_pcc_data {
 	struct pcc_mbox_chan *pcc_channel;
-	void __iomem *pcc_comm_addr;
 	bool pcc_channel_acquired;
 	unsigned int deadline_us;
 	unsigned int pcc_mpar, pcc_mrtt, pcc_nominal;
@@ -95,7 +94,7 @@ static DEFINE_PER_CPU(int, cpu_pcc_subspace_idx);
 static DEFINE_PER_CPU(struct cpc_desc *, cpc_desc_ptr);
 
 /* pcc mapped address + header size + offset within PCC subspace */
-#define GET_PCC_VADDR(offs, pcc_ss_id) (pcc_data[pcc_ss_id]->pcc_comm_addr + \
+#define GET_PCC_VADDR(offs, pcc_ss_id) (pcc_data[pcc_ss_id]->pcc_channel->shmem + \
 						0x8 + (offs))
 
 /* Check if a CPC register is in PCC */
@@ -223,7 +222,7 @@ static int check_pcc_chan(int pcc_ss_id, bool chk_err_bit)
 	int ret, status;
 	struct cppc_pcc_data *pcc_ss_data = pcc_data[pcc_ss_id];
 	struct acpi_pcct_shared_memory __iomem *generic_comm_base =
-		pcc_ss_data->pcc_comm_addr;
+					pcc_ss_data->pcc_channel->shmem;
 
 	if (!pcc_ss_data->platform_owns_pcc)
 		return 0;
@@ -258,7 +257,7 @@ static int send_pcc_cmd(int pcc_ss_id, u16 cmd)
 	int ret = -EIO, i;
 	struct cppc_pcc_data *pcc_ss_data = pcc_data[pcc_ss_id];
 	struct acpi_pcct_shared_memory __iomem *generic_comm_base =
-		pcc_ss_data->pcc_comm_addr;
+					pcc_ss_data->pcc_channel->shmem;
 	unsigned int time_delta;
 
 	/*
@@ -571,15 +570,6 @@ static int register_pcc_channel(int pcc_ss_idx)
 		pcc_data[pcc_ss_idx]->pcc_mpar = pcc_chan->max_access_rate;
 		pcc_data[pcc_ss_idx]->pcc_nominal = pcc_chan->latency;
 
-		pcc_data[pcc_ss_idx]->pcc_comm_addr =
-			acpi_os_ioremap(pcc_chan->shmem_base_addr,
-					pcc_chan->shmem_size);
-		if (!pcc_data[pcc_ss_idx]->pcc_comm_addr) {
-			pr_err("Failed to ioremap PCC comm region mem for %d\n",
-			       pcc_ss_idx);
-			return -ENOMEM;
-		}
-
 		/* Set flag so that we don't come here for each CPU. */
 		pcc_data[pcc_ss_idx]->pcc_channel_acquired = true;
 	}
-- 
2.34.1


