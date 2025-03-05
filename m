Return-Path: <linux-acpi+bounces-11853-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63B8BA50579
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Mar 2025 17:46:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79E103AC58B
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Mar 2025 16:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2AE42561B9;
	Wed,  5 Mar 2025 16:39:20 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CF4024FBFF;
	Wed,  5 Mar 2025 16:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741192760; cv=none; b=Ru1ngJe7pSIKeD66TAuYnhq2TX2emBxlUPjlflFBVfiF0FQHY805C7WAkIsmHRCUZojN7/V/rkBBV3Sf7PqEwcUbg4w5kL0sjD73bJJco582jN8vyKOuEOw628UmHc+9FGvobzYmgW9S2IPvJgufJh6Dbwyltt9s+UC8FRDvShg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741192760; c=relaxed/simple;
	bh=aXg6RgwqMQoYUSR7L+4RvyibSNxPKGi4o12ZLke9smI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U5ZSm/M5zjd486O1rAcrLvuaydVEgKJB4EdDnm5A6K1216B15s39nQpLZC0QCtLUwnaMKXIxqZmRci0C/LShTGCN6e4M3DX9UTdLcXr6G7alXc/WwoY8bcxPjX/uROvGTkvR3uExqJ7a4+jyXqJFd8zdk3TLSW8q/WcTKhsr6QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C2C351FC7;
	Wed,  5 Mar 2025 08:39:31 -0800 (PST)
Received: from e133711.arm.com (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 378763F5A1;
	Wed,  5 Mar 2025 08:39:17 -0800 (PST)
From: Sudeep Holla <sudeep.holla@arm.com>
Date: Wed, 05 Mar 2025 16:38:17 +0000
Subject: [PATCH v2 13/13] ACPI: CPPC: Simplify PCC shared memory region
 handling
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250305-pcc_fixes_updates-v2-13-1b1822bc8746@arm.com>
References: <20250305-pcc_fixes_updates-v2-0-1b1822bc8746@arm.com>
In-Reply-To: <20250305-pcc_fixes_updates-v2-0-1b1822bc8746@arm.com>
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>, 
 Jassi Brar <jassisinghbrar@gmail.com>, Huisong Li <lihuisong@huawei.com>, 
 Adam Young <admiyo@os.amperecomputing.com>, 
 Robbie King <robbiek@xsightlabs.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2920; i=sudeep.holla@arm.com;
 h=from:subject:message-id; bh=aXg6RgwqMQoYUSR7L+4RvyibSNxPKGi4o12ZLke9smI=;
 b=owEBbQKS/ZANAwAIAQBBurwxfuKYAcsmYgBnyH4gPx1dHylhzc+hzQAl1gZ4CiNIGIFYDC34D
 XwznlJ9Li2JAjMEAAEIAB0WIQS6ceUSBvMeskPdk+EAQbq8MX7imAUCZ8h+IAAKCRAAQbq8MX7i
 mG8TD/9zfSb/B6KYlL7LRhNtJq+s3Ce5HgOBWOAO2dtKICkKodsRhwn35yzxng0UKCRVDVaJWI1
 aWPKGpieOyK7UbsKeU0KtSDvLFEFRfFABybfp//g1pp8OA0Fx9Eju/BPGPSoq00auoKqQABU4P3
 ejWFhD6+w1xzFIevXftMUWJFWx8aa4ow0+UkTm3Wrk4Ic0L+JQjQnmyPzn8dk9RUB+RXDifUNYd
 WTtQ9i9jq6dCm2sSjRduHqMsQvk0oWYc9nbXU5kVDew5PAVkhMidupu+FpYUOYMJ5NfNPozkN1+
 nS8NLnBmy7qDH3b2wk2THWLttThfHDIRyXeAkWXc4rFp1mVIQAGvjU3uXH4Ix1Bw9/yco+Ao/bW
 lh/8jTKdqygp5SLmBMdNS3dwaIWhPjR8TBjKmprkPhfbcGzlX/dogjmd/CLhPjwbQ2K4ufJdVUO
 C/zyelFN2yUOv8l+B6iYFcJhF/mVfo7QDggxIt8jXVRm+eAEmvGMsjOoAXoaswf4uUSImFe76fk
 NLiK41ensv0XCR60TbaAQ8lMzcWdGv/DH7hdaFKttC1a/bZhApiCAGPFVZqwv8TT6ESbB4jByGn
 y7HxEdLak5Tr7zDirfUHIUoQMBZw00LccyvQAbndViIyBvSmwR1GEBsQXamK0+5tg2yYY/Y6EC9
 1QKE0hcrxDwFzQA==
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


