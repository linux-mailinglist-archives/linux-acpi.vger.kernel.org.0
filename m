Return-Path: <linux-acpi+bounces-11852-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D814A50565
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Mar 2025 17:43:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D1B216D990
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Mar 2025 16:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FE13255E20;
	Wed,  5 Mar 2025 16:39:19 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D07425486F;
	Wed,  5 Mar 2025 16:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741192759; cv=none; b=cHNqTv4we8pewKV03ixPNoLZMcQkPXfzWGBZ+NzX26qu29i7/o7Fe3ZyHTSyc28i/RC/z5lZBDfBpKPdnJ/qMabMuLwtuDbdVXRk2Na3hZ82fuU0A+PXUGCwWmq/tQCNuP13zWXALlYYOjXGCwlcrpmvq0+Jely3rkY/NhoZ6FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741192759; c=relaxed/simple;
	bh=VmwKuVvkYDG4YPm05QVYADtfrrgD8ss+7erDgcmSENk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f/z9YTD276YgqZYC9sSWX/Hpj9SXEiy9b6T8GF3o+aAoo85UmWjmAvVGhYvWZ85snSL/g4bE4cnM9bUuAXvtbPnaafBcT1RPViizwQn8OBC431ynTuuqe/osWEt7OjfsX5awBqTZX/sOM0Qfn2yLtE8XGEjuY3+UpYlfRJ38r9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8B41F1713;
	Wed,  5 Mar 2025 08:39:28 -0800 (PST)
Received: from e133711.arm.com (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AC4D73F5A1;
	Wed,  5 Mar 2025 08:39:13 -0800 (PST)
From: Sudeep Holla <sudeep.holla@arm.com>
Date: Wed, 05 Mar 2025 16:38:15 +0000
Subject: [PATCH v2 11/13] hwmon: (xgene-hwmon) Simplify PCC shared memory
 region handling
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250305-pcc_fixes_updates-v2-11-1b1822bc8746@arm.com>
References: <20250305-pcc_fixes_updates-v2-0-1b1822bc8746@arm.com>
In-Reply-To: <20250305-pcc_fixes_updates-v2-0-1b1822bc8746@arm.com>
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>, 
 Jassi Brar <jassisinghbrar@gmail.com>, Huisong Li <lihuisong@huawei.com>, 
 Adam Young <admiyo@os.amperecomputing.com>, 
 Robbie King <robbiek@xsightlabs.com>, Jean Delvare <jdelvare@suse.com>, 
 Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3724; i=sudeep.holla@arm.com;
 h=from:subject:message-id; bh=VmwKuVvkYDG4YPm05QVYADtfrrgD8ss+7erDgcmSENk=;
 b=owEBbQKS/ZANAwAIAQBBurwxfuKYAcsmYgBnyH4f1iOFe9jqRV3Bif+vaT+vxFyCxxBIBGGaM
 nOsG+DgzVKJAjMEAAEIAB0WIQS6ceUSBvMeskPdk+EAQbq8MX7imAUCZ8h+HwAKCRAAQbq8MX7i
 mNTsD/0d19dmGO7lpCYSMLtxq1MAL7ZH3HvLtIuYVhTx3IwLIQI73MtgAliPWi3tOnoEaK0KzKK
 alOGT0IzCh5y2yjcLUJ5xhI6nbwvVbaziOfwL6akDNvlIhHeSOOc9eNFct3tD6ZgxOqcRIg+EYh
 eLE8lhUkd7+YtrY1Mhmnz2/TAhVsCupzCDjBmeSuNFBVgAHxuk7HznVHp8Ok6sKIe9V8siNFsqt
 wiKus4CBsI/hu7NA3NQBiU4H3gQYLeq76Tj/SBRrrzE8kFI92E0XQJ1uB1GPb3mo8nX5Z0CgGN+
 826fdsFQdFIQaoyPqYbRwrnWo7fylrUoHlwVOPqjV/dwp5CMUYHdNl6eviz1HxBsveKT6S4r5Wq
 B8h6IHBEtuxfrBmIjVk/WAVDVYm+S3ZAF6DZ5rFnY9IlbtrL2c8QiBOlS+1YRwzgsuSXvbeCnx/
 hNyEVuthL7TnSGSxxSrxVxobj6Z3GJrKOzvNr9YRBjXU8adIgJ6Cf+S1/RDZhc5JXks5gKPaCku
 +JXXp4UciIecmZlDqA/e2u3SLLDG6P0whMlV/9kFAjtxPqOYVNBYgE6BKku/gGdfjDcQ9iNU8PE
 RXlKJwPFI59FgYyG4/NR5O4bobmYdSRqI131Ydwvt0jme3694e7iphq6PZmxQpUq1O3UuEwGW+Q
 SCC2W0vxMQOJxpQ==
X-Developer-Key: i=sudeep.holla@arm.com; a=openpgp;
 fpr=7360A21742ADF5A11767C1C139CFD4755FE2D5B4

The PCC driver now handles mapping and unmapping of shared memory
areas as part of pcc_mbox_{request,free}_channel(). Without these before,
this xgene hwmon driver did handling of those mappings like several
other PCC mailbox client drivers.

There were redundant operations, leading to unnecessary code. Maintaining
the consistency across these driver was harder due to scattered handling
of shmem.

Just use the mapped shmem and remove all redundant operations from this
driver.

Cc: Jean Delvare <jdelvare@suse.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: linux-hwmon@vger.kernel.org
Acked-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/hwmon/xgene-hwmon.c | 40 ++++------------------------------------
 1 file changed, 4 insertions(+), 36 deletions(-)

diff --git a/drivers/hwmon/xgene-hwmon.c b/drivers/hwmon/xgene-hwmon.c
index 1e3bd129a922d25ff25142d864503377773304a8..ea350d4de902c4e6fc4de1cd54a8b75edfad1119 100644
--- a/drivers/hwmon/xgene-hwmon.c
+++ b/drivers/hwmon/xgene-hwmon.c
@@ -102,9 +102,6 @@ struct xgene_hwmon_dev {
 
 	struct device		*hwmon_dev;
 	bool			temp_critical_alarm;
-
-	phys_addr_t		comm_base_addr;
-	void			*pcc_comm_addr;
 	u64			usecs_lat;
 };
 
@@ -125,7 +122,8 @@ static u16 xgene_word_tst_and_clr(u16 *addr, u16 mask)
 
 static int xgene_hwmon_pcc_rd(struct xgene_hwmon_dev *ctx, u32 *msg)
 {
-	struct acpi_pcct_shared_memory *generic_comm_base = ctx->pcc_comm_addr;
+	struct acpi_pcct_shared_memory __iomem *generic_comm_base =
+							ctx->pcc_chan->shmem;
 	u32 *ptr = (void *)(generic_comm_base + 1);
 	int rc, i;
 	u16 val;
@@ -523,7 +521,8 @@ static void xgene_hwmon_rx_cb(struct mbox_client *cl, void *msg)
 static void xgene_hwmon_pcc_rx_cb(struct mbox_client *cl, void *msg)
 {
 	struct xgene_hwmon_dev *ctx = to_xgene_hwmon_dev(cl);
-	struct acpi_pcct_shared_memory *generic_comm_base = ctx->pcc_comm_addr;
+	struct acpi_pcct_shared_memory __iomem *generic_comm_base =
+							ctx->pcc_chan->shmem;
 	struct slimpro_resp_msg amsg;
 
 	/*
@@ -649,7 +648,6 @@ static int xgene_hwmon_probe(struct platform_device *pdev)
 	} else {
 		struct pcc_mbox_chan *pcc_chan;
 		const struct acpi_device_id *acpi_id;
-		int version;
 
 		acpi_id = acpi_match_device(pdev->dev.driver->acpi_match_table,
 					    &pdev->dev);
@@ -658,8 +656,6 @@ static int xgene_hwmon_probe(struct platform_device *pdev)
 			goto out_mbox_free;
 		}
 
-		version = (int)acpi_id->driver_data;
-
 		if (device_property_read_u32(&pdev->dev, "pcc-channel",
 					     &ctx->mbox_idx)) {
 			dev_err(&pdev->dev, "no pcc-channel property\n");
@@ -685,34 +681,6 @@ static int xgene_hwmon_probe(struct platform_device *pdev)
 			goto out;
 		}
 
-		/*
-		 * This is the shared communication region
-		 * for the OS and Platform to communicate over.
-		 */
-		ctx->comm_base_addr = pcc_chan->shmem_base_addr;
-		if (ctx->comm_base_addr) {
-			if (version == XGENE_HWMON_V2)
-				ctx->pcc_comm_addr = (void __force *)devm_ioremap(&pdev->dev,
-								  ctx->comm_base_addr,
-								  pcc_chan->shmem_size);
-			else
-				ctx->pcc_comm_addr = devm_memremap(&pdev->dev,
-								   ctx->comm_base_addr,
-								   pcc_chan->shmem_size,
-								   MEMREMAP_WB);
-		} else {
-			dev_err(&pdev->dev, "Failed to get PCC comm region\n");
-			rc = -ENODEV;
-			goto out;
-		}
-
-		if (!ctx->pcc_comm_addr) {
-			dev_err(&pdev->dev,
-				"Failed to ioremap PCC comm region\n");
-			rc = -ENOMEM;
-			goto out;
-		}
-
 		/*
 		 * pcc_chan->latency is just a Nominal value. In reality
 		 * the remote processor could be much slower to reply.

-- 
2.34.1


