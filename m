Return-Path: <linux-acpi+bounces-11715-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1758A4BD21
	for <lists+linux-acpi@lfdr.de>; Mon,  3 Mar 2025 11:58:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A45BF3A2815
	for <lists+linux-acpi@lfdr.de>; Mon,  3 Mar 2025 10:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 815591FA84F;
	Mon,  3 Mar 2025 10:53:46 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEA911F3D3E;
	Mon,  3 Mar 2025 10:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740999226; cv=none; b=IirKDGzTjljvRQ+RvebVNzGPd8huXbM5bpcYfGDj9EMniwOp1pOt9/riWLJArvCVEDClU/Jaoogzm2N+wQ1pDIXDQ+fMUHOgGRaxIYDNMe03feTmvokNBn01f+ipz/tT4Y5+u9XDiC3vq7RkpFQiuLX+zDsRPC/rX48M+rdxGgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740999226; c=relaxed/simple;
	bh=iFUeJHey5yoWOaCDwHA/+dkaY+Qb1DUk7Ye5n0Pdfn4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gycejg/2vrx/5M7kBSzhDdGXZGO3iHaDEv2q5RGFy8aV5/EbiJQGxLrIbNmKZzS7t1zGjI2rF0v8FoFQnodY629zwHv3Dc6HTf5EWnqWUgATy+a2PQN/RonouSdCu+K+s3mbAeUTdoWNRFRxKTCUcHalE+t5cKh9XeeGfBp+YY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A562B2008;
	Mon,  3 Mar 2025 02:53:58 -0800 (PST)
Received: from e133711.arm.com (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 656AA3F673;
	Mon,  3 Mar 2025 02:53:43 -0800 (PST)
From: Sudeep Holla <sudeep.holla@arm.com>
Date: Mon, 03 Mar 2025 10:51:49 +0000
Subject: [PATCH 14/14] ACPI: CPPC: Simplify PCC shared memory region
 handling
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250303-pcc_fixes_updates-v1-14-3b44f3d134b1@arm.com>
References: <20250303-pcc_fixes_updates-v1-0-3b44f3d134b1@arm.com>
In-Reply-To: <20250303-pcc_fixes_updates-v1-0-3b44f3d134b1@arm.com>
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>, 
 Jassi Brar <jassisinghbrar@gmail.com>, Huisong Li <lihuisong@huawei.com>, 
 Adam Young <admiyo@os.amperecomputing.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2873; i=sudeep.holla@arm.com;
 h=from:subject:message-id; bh=iFUeJHey5yoWOaCDwHA/+dkaY+Qb1DUk7Ye5n0Pdfn4=;
 b=owEBbQKS/ZANAwAIAQBBurwxfuKYAcsmYgBnxYoi9kDd5Yg50QoICLz/87VFVMCqajuK2k4tJ
 ee/kfospo6JAjMEAAEIAB0WIQS6ceUSBvMeskPdk+EAQbq8MX7imAUCZ8WKIgAKCRAAQbq8MX7i
 mNPlD/wKs0oZNESqFnya6yAPNwWVMvlz3wPn6ZiOKWmC3VxPb41oPR1y68g5ncSeExZdRDrhrdh
 QtevZRzzRb1uQXWRXJzs1ICTZwL15hnTW9NVPH3quCAyuuY5azDIShgaz0LpKFrcamRtm73Vlwv
 dFhRy71zXvY8qBUeB/6j6LzAIKpaAwKeJUmBsGxoQh6kZDIF+gvmQtsC82Bxzwr9muvlfYr6N3V
 MsF6cQsDC6tWfZBRDtFXk/skwFfUl0cxiNkAeSvUEfAE9+BuAtyqMs4fwf3yIJkgCQvF4R9+fY8
 tGkqpnwXbZKE6BTN0AW+b/wp1DzaHCVOME7CHU9eJjydv8+2QGCmDBEnMuyrG6XMqNRvGcze8F+
 rn90+zknT2u5NToFaT2u3wIEGwKO1lSEwlquXceyT/w7zB5NaE81zo5x0bRhFsp7OCvDWe1ZIoa
 7ALoQ4DcsUipXjI0gJ0myKhPuoQYdN0GEalSiu8Qc6UBA212ieACoH/JJJP4XtnbrRyIh4v/dXw
 ATuNcrPUuMqnW+CmLa+Dl4CPrdwSvSz5KXsfKHOjGAXpxN0HKKPo4OzLdKBWX/Qw/lzSJ29BYrU
 CQqNrwUumAgzHrphmxDk+Qb62b/OMc/eXqi6l5IKbQlRLyl7wLgh+Lhbb8j09ksjzx2yF2RUq7U
 FyFH4ZS2lU5XZYg==
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

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
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


