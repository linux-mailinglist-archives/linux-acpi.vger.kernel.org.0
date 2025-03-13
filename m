Return-Path: <linux-acpi+bounces-12212-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DDB9FA5F9FD
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Mar 2025 16:32:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48927421C6A
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Mar 2025 15:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEE3126B098;
	Thu, 13 Mar 2025 15:29:33 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BA6726A1D0;
	Thu, 13 Mar 2025 15:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741879773; cv=none; b=Yx80IuYO56kpckcXMrdUCucmdjYQq8AEIuBKheKhnBVMGg3LNOrNwzfs/YOT4JNLDiop2WMBXZiDWsqaDN5qNqpYqx8Qz10aS6UV9ZpJDLT6Axzaw6Bp7WS86f2Xkd5XwP0kCsrEAIhb43jTbpXjEA2j1ZCCV1E6i+31iTnqLSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741879773; c=relaxed/simple;
	bh=aXg6RgwqMQoYUSR7L+4RvyibSNxPKGi4o12ZLke9smI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FWGibt1/13jeNZYEaLYWf7zdm/rnTuxc9mV1zP04RlfuE7i676WUm87p6dG7fq4y1JZKVeNyXXU+IGIyLBjyS3vDDJy61872XzoWKYZuwzqaF756zkbmnsdS4E3DKD1wa2ke9PeC0isY5Jg9iCUgJlairm9sjvAkszj4DUnkv1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ECE99201B;
	Thu, 13 Mar 2025 08:29:41 -0700 (PDT)
Received: from e133711.arm.com (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 536A33F694;
	Thu, 13 Mar 2025 08:29:30 -0700 (PDT)
From: Sudeep Holla <sudeep.holla@arm.com>
Date: Thu, 13 Mar 2025 15:28:59 +0000
Subject: [PATCH v3 13/13] ACPI: CPPC: Simplify PCC shared memory region
 handling
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250313-pcc_fixes_updates-v3-13-019a4aa74d0f@arm.com>
References: <20250313-pcc_fixes_updates-v3-0-019a4aa74d0f@arm.com>
In-Reply-To: <20250313-pcc_fixes_updates-v3-0-019a4aa74d0f@arm.com>
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>, 
 Jassi Brar <jassisinghbrar@gmail.com>, Huisong Li <lihuisong@huawei.com>, 
 Adam Young <admiyo@os.amperecomputing.com>, 
 Robbie King <robbiek@xsightlabs.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2920; i=sudeep.holla@arm.com;
 h=from:subject:message-id; bh=aXg6RgwqMQoYUSR7L+4RvyibSNxPKGi4o12ZLke9smI=;
 b=owEBbQKS/ZANAwAIAQBBurwxfuKYAcsmYgBn0vnFlGRXwjy9cTaaMj/r+JhxSEJ57FZdBydxK
 1a8OYIWgDCJAjMEAAEIAB0WIQS6ceUSBvMeskPdk+EAQbq8MX7imAUCZ9L5xQAKCRAAQbq8MX7i
 mJfHD/9er9/XFfWSnZPvTNnmLDJwIrPdU9JK/+seka+nu4TghpzbUe8J6vvCiUUVCrx/n1Incjg
 VGLbRP/MSpIgDoAKXgNgW8Cz4HF7fxbOmDeyihn0/g6JIsYlPq/UXwqdwirSbwDcjqku/GOfgEd
 dqFk9ofzSIYISae8m1O6Q+z6sZ7qD4sFFLR/iDYiKuEiAoPBPUoSgVP158syGWVJVMWmpO0xz0B
 BtHeOxriZYzb4YkrXvrTUe/vLYBVkvwZaJyUMOwdWpBkpagdhlQxowIjLH2Prtqen+pyAvBV/0z
 IvmzIjdB76qXkh9e2579JiDpOnyEiisePjbjYGPfyiwzWpQYzYrCrXYlYwTtF6bLP2eKhSsrN8k
 DyBnclrqdTJPMIg89tIaentznacDmAqkd9AYv+G+qrMgDe2a14UlV25wuUYKnmgWzwrE9xy6SWz
 xmiJsSDoo+6Se0hXl1r71Boc60zqeo+MGOWRPTE59uqSBxPuop3NAZ2CBIDRV9CapTfBHeu8ibF
 YlWbllMFj39ZSnsBSiDeNaInb4xynstu5Q+gz2Z3DcfP0/Rmbe9tyH2/MgKfC1k1EHKR7IBeZEi
 BET/4O2v/LH7kPFAdqXsuYtqhSC4DmHuyYp2WPCNLWslts+lLtBZWuS+bIkwiuOTnlemOXgADNh
 hR/1u6rr0GWS0dg==
X-Developer-Key: i=sudeep.holla@arm.com; a=openpgp;
 fpr=7360A21742ADF5A11767C1C139CFD4755FE2D5B4

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
Acked-by: Rafael J. Wysocki <rafael@kernel.org>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/acpi/cppc_acpi.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index f193e713825ac24203ece5f94d6cf99dd4724ce4..d972157a79b6ade2f3738c90128e8692141b3ee5 100644
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


