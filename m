Return-Path: <linux-acpi+bounces-15511-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E66CB19CD5
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Aug 2025 09:41:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5F8416986A
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Aug 2025 07:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 684BA1DE8A0;
	Mon,  4 Aug 2025 07:41:41 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-m32105.qiye.163.com (mail-m32105.qiye.163.com [220.197.32.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728682E3705;
	Mon,  4 Aug 2025 07:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754293301; cv=none; b=gRSNXpjzD/7Ok0EoH3cfkQNob5t1iK3EykuvKMbq6AVuQkE6HIpTnr9bzxGwuaBQxjzJrMggtru97c2fhWvb9zwIcajCtPLCJ+BwfuDTuIWl8ISIoQcFpqkjFcmunMvVW+6EG0YsrBPZ4t/AfK+PKWfqKwihJuLho1yXjfwiFJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754293301; c=relaxed/simple;
	bh=a4k+ImDSS1kwPzRCmxturSiTZ5nwOlX3mgptNTfnGRo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EB4VTUE7EPhpRQAtEgyFmDkeGzFCyfO/BXwQ0yFHKGzARDaxb9/xsICiufXlqFIefFJ5VaJEB91FNMGL3NFDhkBPy9v1NV7N22yuAdf+ZAqVAUYcDv4uYSPbK8q8VEwnMvZXla0yaD88MnHu0SAvPzYK6qrDF+MdFFmZoK59P+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn; spf=pass smtp.mailfrom=easystack.cn; arc=none smtp.client-ip=220.197.32.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=easystack.cn
Received: from localhost.localdomain (unknown [218.94.118.90])
	by smtp.qiye.163.com (Hmail) with ESMTP id e1adb6a9;
	Mon, 4 Aug 2025 15:41:24 +0800 (GMT+08:00)
From: Zhen Ni <zhen.ni@easystack.cn>
To: Markus.Elfring@web.de,
	sudeep.holla@arm.com,
	jassisinghbrar@gmail.com
Cc: linux-acpi@vger.kernel.org,
	Zhen Ni <zhen.ni@easystack.cn>,
	stable@vger.kernel.org
Subject: [PATCH v2] mailbox: pcc: Add missed acpi_put_table() to fix memory leak
Date: Mon,  4 Aug 2025 15:41:15 +0800
Message-Id: <20250804074115.44573-1-zhen.ni@easystack.cn>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20250730124508.939257-1-zhen.ni@easystack.cn>
References: <20250730124508.939257-1-zhen.ni@easystack.cn>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9874072fc50229kunme07da2d845a460
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFJQjdXWS1ZQUlXWQ8JGhUIEh9ZQVlDGR5OVkgYT0weGE5KQhpDS1YVFAkWGhdVGRETFh
	oSFyQUDg9ZV1kYEgtZQVlJSkNVQk9VSkpDVUJLWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
	VKQktLWQY+

In pcc_mbox_probe(), the PCCT table acquired via acpi_get_table()
is only released in error paths but not in the success path. This
leads to a permanent ACPI memory leak when the driver successfully
initializes.

Fixes: ce028702ddbc ("mailbox: pcc: Move bulk of PCCT parsing into pcc_mbox_probe")
Cc: stable@vger.kernel.org
Signed-off-by: Zhen Ni <zhen.ni@easystack.cn>
---
Changes in v2:
- Add tags of 'Fixes' and 'Cc'
- Change goto target from out_put_pcct to e_nomem
---
 drivers/mailbox/pcc.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
index f6714c233f5a..b5b4e3665593 100644
--- a/drivers/mailbox/pcc.c
+++ b/drivers/mailbox/pcc.c
@@ -763,19 +763,19 @@ static int pcc_mbox_probe(struct platform_device *pdev)
 					 GFP_KERNEL);
 	if (!pcc_mbox_channels) {
 		rc = -ENOMEM;
-		goto err;
+		goto e_nomem;
 	}
 
 	chan_info = devm_kcalloc(dev, count, sizeof(*chan_info), GFP_KERNEL);
 	if (!chan_info) {
 		rc = -ENOMEM;
-		goto err;
+		goto e_nomem;
 	}
 
 	pcc_mbox_ctrl = devm_kzalloc(dev, sizeof(*pcc_mbox_ctrl), GFP_KERNEL);
 	if (!pcc_mbox_ctrl) {
 		rc = -ENOMEM;
-		goto err;
+		goto e_nomem;
 	}
 
 	/* Point to the first PCC subspace entry */
@@ -796,17 +796,17 @@ static int pcc_mbox_probe(struct platform_device *pdev)
 		    !pcc_mbox_ctrl->txdone_irq) {
 			pr_err("Platform Interrupt flag must be set to 1");
 			rc = -EINVAL;
-			goto err;
+			goto e_nomem;
 		}
 
 		if (pcc_mbox_ctrl->txdone_irq) {
 			rc = pcc_parse_subspace_irq(pchan, pcct_entry);
 			if (rc < 0)
-				goto err;
+				goto e_nomem;
 		}
 		rc = pcc_parse_subspace_db_reg(pchan, pcct_entry);
 		if (rc < 0)
-			goto err;
+			goto e_nomem;
 
 		pcc_parse_subspace_shmem(pchan, pcct_entry);
 
@@ -827,9 +827,8 @@ static int pcc_mbox_probe(struct platform_device *pdev)
 	rc = mbox_controller_register(pcc_mbox_ctrl);
 	if (rc)
 		pr_err("Err registering PCC as Mailbox controller: %d\n", rc);
-	else
-		return 0;
-err:
+
+e_nomem:
 	acpi_put_table(pcct_tbl);
 	return rc;
 }
-- 
2.20.1


