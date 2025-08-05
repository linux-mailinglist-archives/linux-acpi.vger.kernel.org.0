Return-Path: <linux-acpi+bounces-15529-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C69A2B1B027
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Aug 2025 10:24:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8658F189409B
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Aug 2025 08:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93EF925229C;
	Tue,  5 Aug 2025 08:24:54 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-m3285.qiye.163.com (mail-m3285.qiye.163.com [220.197.32.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99DA202C48;
	Tue,  5 Aug 2025 08:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754382294; cv=none; b=H1S2GltWvz++JOiylbH/TFNP9TjfnMaV+7/JANnlRYnNX/oh5vSw1zUuTKs1N/NmHfXSAC10XZEswLiWVtA5DNKKb8TxJ/x8FWihcCO3wEoc+3uZRvQohrrMC8TNsqjSMRrDHX1UpwUB4cPGs2+FFmHVMLGrnzd/oyg4fy0Xcfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754382294; c=relaxed/simple;
	bh=VYW+2NN+F2UHY23WdMo4xYuy8k582nMwCF9udAoT1lk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LzG2gGpD5t7w3uc8lfh1ofO3ZR9qRVxJvz/ibGhjEDMrb1HeQ312UmwljZwq9fUx6hUSgo6oikN8AHagYncQ/mi7hJARMEBj4XA5u3RtkXx6FyQkTFOaSkPhnrbudmE8rlXUkpd7vLTNMQNI1TUzjgC264uN1pQhTKPNSIW3h90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn; spf=pass smtp.mailfrom=easystack.cn; arc=none smtp.client-ip=220.197.32.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=easystack.cn
Received: from localhost.localdomain (unknown [218.94.118.90])
	by smtp.qiye.163.com (Hmail) with ESMTP id e26bf448;
	Tue, 5 Aug 2025 11:48:38 +0800 (GMT+08:00)
From: Zhen Ni <zhen.ni@easystack.cn>
To: Markus.Elfring@web.de,
	sudeep.holla@arm.com,
	jassisinghbrar@gmail.com
Cc: linux-acpi@vger.kernel.org,
	Zhen Ni <zhen.ni@easystack.cn>,
	stable@vger.kernel.org
Subject: [PATCH v4] mailbox: pcc: Add missed acpi_put_table() to fix memory leak
Date: Tue,  5 Aug 2025 11:48:29 +0800
Message-Id: <20250805034829.168187-1-zhen.ni@easystack.cn>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20250804121453.75525-1-zhen.ni@easystack.cn>
References: <20250804121453.75525-1-zhen.ni@easystack.cn>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a98785871330229kunmd0caaa9c52bda0
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFJQjdXWS1ZQUlXWQ8JGhUIEh9ZQVlCGB4dVh0eSB4ZSUpJSx9DSlYVFAkWGhdVGRETFh
	oSFyQUDg9ZV1kYEgtZQVlJSkNVQk9VSkpDVUJLWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
	VKQktLWQY+

Fixes a permanent ACPI memory leak in the success path by adding
acpi_put_table().
Renaming generic 'err' label to 'put_table' for clarity.

Fixes: ce028702ddbc ("mailbox: pcc: Move bulk of PCCT parsing into pcc_mbox_probe")
Cc: stable@vger.kernel.org
Signed-off-by: Zhen Ni <zhen.ni@easystack.cn>
---
Changes in v4:
- Change goto target from err to put_table.
- Remove goto tatget err_nomem
- Update commit msg
Changes in v3:
- Add goto label err_nomem, keep the err label.
- Update commit msg
Changes in v2:
- Add tags of 'Fixes' and 'Cc'
- Change goto target from out_put_pcct to e_nomem
---
 drivers/mailbox/pcc.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
index f6714c233f5a..d8420c87b615 100644
--- a/drivers/mailbox/pcc.c
+++ b/drivers/mailbox/pcc.c
@@ -763,19 +763,19 @@ static int pcc_mbox_probe(struct platform_device *pdev)
 					 GFP_KERNEL);
 	if (!pcc_mbox_channels) {
 		rc = -ENOMEM;
-		goto err;
+		goto put_table;
 	}
 
 	chan_info = devm_kcalloc(dev, count, sizeof(*chan_info), GFP_KERNEL);
 	if (!chan_info) {
 		rc = -ENOMEM;
-		goto err;
+		goto put_table;
 	}
 
 	pcc_mbox_ctrl = devm_kzalloc(dev, sizeof(*pcc_mbox_ctrl), GFP_KERNEL);
 	if (!pcc_mbox_ctrl) {
 		rc = -ENOMEM;
-		goto err;
+		goto put_table;
 	}
 
 	/* Point to the first PCC subspace entry */
@@ -796,17 +796,17 @@ static int pcc_mbox_probe(struct platform_device *pdev)
 		    !pcc_mbox_ctrl->txdone_irq) {
 			pr_err("Platform Interrupt flag must be set to 1");
 			rc = -EINVAL;
-			goto err;
+			goto put_table;
 		}
 
 		if (pcc_mbox_ctrl->txdone_irq) {
 			rc = pcc_parse_subspace_irq(pchan, pcct_entry);
 			if (rc < 0)
-				goto err;
+				goto put_table;
 		}
 		rc = pcc_parse_subspace_db_reg(pchan, pcct_entry);
 		if (rc < 0)
-			goto err;
+			goto put_table;
 
 		pcc_parse_subspace_shmem(pchan, pcct_entry);
 
@@ -827,9 +827,8 @@ static int pcc_mbox_probe(struct platform_device *pdev)
 	rc = mbox_controller_register(pcc_mbox_ctrl);
 	if (rc)
 		pr_err("Err registering PCC as Mailbox controller: %d\n", rc);
-	else
-		return 0;
-err:
+
+put_table:
 	acpi_put_table(pcct_tbl);
 	return rc;
 }
-- 
2.20.1


