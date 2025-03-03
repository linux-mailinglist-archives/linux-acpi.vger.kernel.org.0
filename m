Return-Path: <linux-acpi+bounces-11714-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54DA2A4BD17
	for <lists+linux-acpi@lfdr.de>; Mon,  3 Mar 2025 11:57:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A819173540
	for <lists+linux-acpi@lfdr.de>; Mon,  3 Mar 2025 10:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E0471FA14B;
	Mon,  3 Mar 2025 10:53:45 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE49A1F3D31;
	Mon,  3 Mar 2025 10:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740999225; cv=none; b=mkyxuUmVCz2mRb/Q5QVLHRK0Hx3WY2RKCqXde1k0UWfpcv1xc8tAmoAR5FBgVOZkX3k1I27N+9d/j32WIhF2EnUQLml2clREuakcQppl3vmk044J0emObHtisg7yXENWdLam/YcKgqXOQ4qm9DV9A0yzNSu84KlBrjJEjc/lltU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740999225; c=relaxed/simple;
	bh=tFkBXBO/atiCQgL+I5PaOZGXAVe1jBN5O3xNDo6yR1U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iMd1wbZUosYdSxt1KmR35JCPICHLIBgwokxiyUzYMNox2cm1bLzBAk6rlvWzHjg3uYIesF6SJj5Cd9tsR7d1YgQm7QRZmhDpXiYTJdyqXXrm7CbaCFlg0QPby303gjKoB+H4ATz/U0jcAZAnYWIHZw06Wu4VP1etiXd7Z1LdwfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 33A0512FC;
	Mon,  3 Mar 2025 02:53:57 -0800 (PST)
Received: from e133711.arm.com (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E84E63F673;
	Mon,  3 Mar 2025 02:53:41 -0800 (PST)
From: Sudeep Holla <sudeep.holla@arm.com>
Date: Mon, 03 Mar 2025 10:51:48 +0000
Subject: [PATCH 13/14] ACPI: PCC: Simplify PCC shared memory region
 handling
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250303-pcc_fixes_updates-v1-13-3b44f3d134b1@arm.com>
References: <20250303-pcc_fixes_updates-v1-0-3b44f3d134b1@arm.com>
In-Reply-To: <20250303-pcc_fixes_updates-v1-0-3b44f3d134b1@arm.com>
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>, 
 Jassi Brar <jassisinghbrar@gmail.com>, Huisong Li <lihuisong@huawei.com>, 
 Adam Young <admiyo@os.amperecomputing.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2287; i=sudeep.holla@arm.com;
 h=from:subject:message-id; bh=tFkBXBO/atiCQgL+I5PaOZGXAVe1jBN5O3xNDo6yR1U=;
 b=owEBbQKS/ZANAwAIAQBBurwxfuKYAcsmYgBnxYoi9kbIIwhM7SN4/rMMClfDqLF6rC6WBUHLg
 wObMXTYtF+JAjMEAAEIAB0WIQS6ceUSBvMeskPdk+EAQbq8MX7imAUCZ8WKIgAKCRAAQbq8MX7i
 mL7QEACM8MCcc67ol1zd5JF6UmlSojZjf1D0hsEF5O5ueNd7RHwsyUMli77cfb2ZmtSf6TTCUY3
 rRbFCmJkN+1Ly5iIXTJgoD701eEa2b0qD97DH9rAlWmBQqTGvxq55XlKcrvAyb0J72oBafzTY7L
 SQ3Z0ZpixC1zZW/6aFM8QeS2Hx8BaZbiBYxCUl8yld4fg4xWf5jX2x6j2hwhENWIUi/NmOUh4iH
 Dq+uXh/4EGtyADRInM/R84QSqJOqd41NNdoOx4StYzwrV5xBVtdnGOl0U/TGdE/2bwRircAWphv
 x2s1t4cH//+KjbAD972Rzio/kVgFq6Y1Y6dVJovGcRvYkbN63BdlJ34tDDatZ3lhF0tTaqX7HRJ
 FA4zoJc7ZoIenI649M/41bS31adFEyl0uora+DMw+C0DGn26B6cSAX7rKQv7YPkmq8GC1sZ87NQ
 Z1NfMObNVVYbSjyNmda7mCiHFOl58igJ2/atrZXhZ6bpxn/0k0PR91+HmM9C2yygbmm6rwgXA0B
 JDeK5O7n+IwPkFh0GDDWa4fY6TXLOwU/8EoZS+kFmJ+/74ir6xTVMyYQphGF4OeHa3t9av4UwVH
 9j4l4oKNC0paEJjPq1yM+x4bxahMTbJiEB2ImH16YY2jtEBK81V/dnREKM7AjOthoD44R481mct
 vhmWxWSTKAoGHGg==
X-Developer-Key: i=sudeep.holla@arm.com; a=openpgp;
 fpr=7360A21742ADF5A11767C1C139CFD4755FE2D5B4

The PCC driver now handles mapping and unmapping of shared memory
areas as part of pcc_mbox_{request,free}_channel(). Without these before,
this ACPI PCC opregion driver did handling of those mappings like several
other PCC mailbox client drivers.

There were redundant operations, leading to unnecessary code. Maintaining
the consistency across these driver was harder due to scattered handling
of shmem.

Just use the mapped shmem and remove all redundant operations from this
driver.

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/acpi/acpi_pcc.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/acpi/acpi_pcc.c b/drivers/acpi/acpi_pcc.c
index 07a034a53acac1e8307265bcc5572054d34d971f..97064e943768ad9f1704effa13dddbc0876a9452 100644
--- a/drivers/acpi/acpi_pcc.c
+++ b/drivers/acpi/acpi_pcc.c
@@ -31,7 +31,6 @@
 
 struct pcc_data {
 	struct pcc_mbox_chan *pcc_chan;
-	void __iomem *pcc_comm_addr;
 	struct completion done;
 	struct mbox_client cl;
 	struct acpi_pcc_info ctx;
@@ -81,14 +80,6 @@ acpi_pcc_address_space_setup(acpi_handle region_handle, u32 function,
 		ret = AE_SUPPORT;
 		goto err_free_channel;
 	}
-	data->pcc_comm_addr = acpi_os_ioremap(pcc_chan->shmem_base_addr,
-					      pcc_chan->shmem_size);
-	if (!data->pcc_comm_addr) {
-		pr_err("Failed to ioremap PCC comm region mem for %d\n",
-		       ctx->subspace_id);
-		ret = AE_NO_MEMORY;
-		goto err_free_channel;
-	}
 
 	*region_context = data;
 	return AE_OK;
@@ -113,7 +104,7 @@ acpi_pcc_address_space_handler(u32 function, acpi_physical_address addr,
 	reinit_completion(&data->done);
 
 	/* Write to Shared Memory */
-	memcpy_toio(data->pcc_comm_addr, (void *)value, data->ctx.length);
+	memcpy_toio(data->pcc_chan->shmem, (void *)value, data->ctx.length);
 
 	ret = mbox_send_message(data->pcc_chan->mchan, NULL);
 	if (ret < 0)
@@ -134,7 +125,7 @@ acpi_pcc_address_space_handler(u32 function, acpi_physical_address addr,
 
 	mbox_chan_txdone(data->pcc_chan->mchan, ret);
 
-	memcpy_fromio(value, data->pcc_comm_addr, data->ctx.length);
+	memcpy_fromio(value, data->pcc_chan->shmem, data->ctx.length);
 
 	return AE_OK;
 }

-- 
2.34.1


