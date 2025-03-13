Return-Path: <linux-acpi+bounces-12210-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6036A5F9F4
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Mar 2025 16:31:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B7A77AF0AD
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Mar 2025 15:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7298426AA88;
	Thu, 13 Mar 2025 15:29:30 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE15B268FF9;
	Thu, 13 Mar 2025 15:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741879770; cv=none; b=TfQFynoblgpnfN7FoG5mIKktqGdLm5PuwLbUDOk9TA2FZTM/io47a1MathixV0C/RU1dfCulwH+6kQ6h/BMqIFRPXNclIZb0uQa/m88yw40vQyGvdAv57zx8wu/BHCUCzHbQKJAA8AQnAgjKkygsp/op7Q4q/qocgaH2Mxel61k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741879770; c=relaxed/simple;
	bh=g2RUvDMQ2GBh1kicDpIWYqj1etweoptS+UnASfqEnjU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FWp0Vkpjvz1ZyyZ4Z6LUFiPjVY+nWM76bvfdZhxRiJRa8eSM79NVoxl5oJ3bitSYqovPcClEO6T1P2kkuGtc4RAuys3p55G0khGvLV9D410JJ77EtoHeU+KrG9WHzG0zB4TIaRtEmQEs1X4Ms0FXCqyVbJWIvdVhB0BTqEvCaVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B38581516;
	Thu, 13 Mar 2025 08:29:38 -0700 (PDT)
Received: from e133711.arm.com (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C70113F694;
	Thu, 13 Mar 2025 08:29:26 -0700 (PDT)
From: Sudeep Holla <sudeep.holla@arm.com>
Date: Thu, 13 Mar 2025 15:28:57 +0000
Subject: [PATCH v3 11/13] hwmon: (xgene-hwmon) Simplify PCC shared memory
 region handling
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250313-pcc_fixes_updates-v3-11-019a4aa74d0f@arm.com>
References: <20250313-pcc_fixes_updates-v3-0-019a4aa74d0f@arm.com>
In-Reply-To: <20250313-pcc_fixes_updates-v3-0-019a4aa74d0f@arm.com>
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>, 
 Jassi Brar <jassisinghbrar@gmail.com>, Huisong Li <lihuisong@huawei.com>, 
 Adam Young <admiyo@os.amperecomputing.com>, 
 Robbie King <robbiek@xsightlabs.com>, Jean Delvare <jdelvare@suse.com>, 
 Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3739; i=sudeep.holla@arm.com;
 h=from:subject:message-id; bh=g2RUvDMQ2GBh1kicDpIWYqj1etweoptS+UnASfqEnjU=;
 b=owEBbQKS/ZANAwAIAQBBurwxfuKYAcsmYgBn0vnE4FydmkyNvEATnXYkie6JdXUFcWu91UUbb
 a4XUAfUw6OJAjMEAAEIAB0WIQS6ceUSBvMeskPdk+EAQbq8MX7imAUCZ9L5xAAKCRAAQbq8MX7i
 mLNHEADHv4egWlf3fUQ+XNfYRbFc0rKJWGm6QvNzZgmLAkYX5IM2LwYsfdArTAslOhl7X+B5mHt
 jUpS2np6N8aA6dLa6LYanNRU+++HKeMv3fIWz49zruzgy8uP+n75t1Vg9rFI5RQniXBt4UDcn9u
 SKyEVtv50AqPsStPgWow43jqKq3eMThiHn4a1bnjJplXc95U3R2vMYUsFHTVjb6GqNVg9PvonRu
 VUDGNko/X5CwvtbBLzckB6neaHVPZu70rMYt5NeBck+uuZg9ECFVta1trcB7QSfI6/M43X80T9S
 U3bL2XIEO+d38wdyje0kM6t3miT7pXJ+dwEK1NgxYXg49Wx0XCXt+OJZwXiICofRQgzke3r7Kc0
 NESYdXn2CGvYU1bLum5oftaqgDiQQSJ07mHginHXmzWrGKEsS9HHkNyy72P+DwaRmv37wnfllKs
 6AU0+Mm4sF6nCb7Up+sj758W2qF9BF9aERVr6zMiFVBKo5dJkqgcrB/oFV2eWW9g59/EbPcydT8
 ICQF0lKMvsvqfYvrdV7CppRfQtNwkHEZKd0mcDACSr7w52k89/itnipfv/w9YDjsERNGWJAHkjp
 SPpBGJFnQZ5/ogakdq0ilFwAh6iPhOZpLsvPx36S+w16Yb7jj3FpTPER6ENT6jRNY20+N7Z5pXn
 ooDxpyfSwCPTSqA==
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
index 7087197383c96cb97e4623f419afed01d4f3c716..ea350d4de902c4e6fc4de1cd54a8b75edfad1119 100644
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
-		if (IS_ERR_OR_NULL(ctx->pcc_comm_addr)) {
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


