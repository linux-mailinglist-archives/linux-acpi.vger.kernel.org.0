Return-Path: <linux-acpi+bounces-15419-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD50B16154
	for <lists+linux-acpi@lfdr.de>; Wed, 30 Jul 2025 15:21:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06B4416A9CA
	for <lists+linux-acpi@lfdr.de>; Wed, 30 Jul 2025 13:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3A59265CAB;
	Wed, 30 Jul 2025 13:21:00 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-m1973199.qiye.163.com (mail-m1973199.qiye.163.com [220.197.31.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD66E1531E3
	for <linux-acpi@vger.kernel.org>; Wed, 30 Jul 2025 13:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753881660; cv=none; b=MGsoDYXbYjCIZy7vWb88P59jjYT+LsZbmjyVZh6hTMJWaACk7scuvMs8qQWFZ5ZD5A6AhKc4xQhn38swF6re7b7qhkpJzrzc/z4+BAYYgaQed108v255DvLUcuLwSRmo59UVis2LfWGQYXWhs+yxwafJLZqalC7Z/UybK4OySJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753881660; c=relaxed/simple;
	bh=buSAAuE3jhA4CJ9SRu0YEm87vPVm4Zkxc48QH7+Rz5E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WrnAN9dd6/xlVI2RXDDGnfpDI2Fp9uv7xbPFqA0Y1UIiIes0biO4PwtEkTib/CvWkToKXMans+nuvLpH9YbZzR3M1g5SMfvHYVG7VkRSDMcSYF6y1WPD/fRE93RaikJ3ImreuNd2f9wQ1iOO+tfYbI1BYkHke2cntxjC9rKHmbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn; spf=pass smtp.mailfrom=easystack.cn; arc=none smtp.client-ip=220.197.31.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=easystack.cn
Received: from localhost.localdomain (unknown [218.94.118.90])
	by smtp.qiye.163.com (Hmail) with ESMTP id de08c15c;
	Wed, 30 Jul 2025 20:45:17 +0800 (GMT+08:00)
From: Zhen Ni <zhen.ni@easystack.cn>
To: sudeep.holla@arm.com,
	jassisinghbrar@gmail.com
Cc: linux-acpi@vger.kernel.org,
	Zhen Ni <zhen.ni@easystack.cn>
Subject: [PATCH] mailbox: pcc: Add missed acpi_put_table() to fix memory leak
Date: Wed, 30 Jul 2025 20:45:08 +0800
Message-Id: <20250730124508.939257-1-zhen.ni@easystack.cn>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a985b5d99d20229kunm4047c82cc9d7
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFJQjdXWS1ZQUlXWQ8JGhUIEh9ZQVlDT01CVkgfSRpJT00YTE4aGFYVFAkWGhdVGRETFh
	oSFyQUDg9ZV1kYEgtZQVlJSkNVQk9VSkpDVUJLWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
	VKQktLWQY+

In pcc_mbox_probe(), the PCCT table acquired via acpi_get_table()
is only released in error paths but not in the success path. This
leads to a permanent ACPI memory leak when the driver successfully
initializes.

The label name 'err' is no longer accurate because it handles both:
1. Error cases
2. Success case

Signed-off-by: Zhen Ni <zhen.ni@easystack.cn>
---
 drivers/mailbox/pcc.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
index f6714c233f5a..509b6a96c785 100644
--- a/drivers/mailbox/pcc.c
+++ b/drivers/mailbox/pcc.c
@@ -763,19 +763,19 @@ static int pcc_mbox_probe(struct platform_device *pdev)
 					 GFP_KERNEL);
 	if (!pcc_mbox_channels) {
 		rc = -ENOMEM;
-		goto err;
+		goto out_put_pcct;
 	}
 
 	chan_info = devm_kcalloc(dev, count, sizeof(*chan_info), GFP_KERNEL);
 	if (!chan_info) {
 		rc = -ENOMEM;
-		goto err;
+		goto out_put_pcct;
 	}
 
 	pcc_mbox_ctrl = devm_kzalloc(dev, sizeof(*pcc_mbox_ctrl), GFP_KERNEL);
 	if (!pcc_mbox_ctrl) {
 		rc = -ENOMEM;
-		goto err;
+		goto out_put_pcct;
 	}
 
 	/* Point to the first PCC subspace entry */
@@ -796,17 +796,17 @@ static int pcc_mbox_probe(struct platform_device *pdev)
 		    !pcc_mbox_ctrl->txdone_irq) {
 			pr_err("Platform Interrupt flag must be set to 1");
 			rc = -EINVAL;
-			goto err;
+			goto out_put_pcct;
 		}
 
 		if (pcc_mbox_ctrl->txdone_irq) {
 			rc = pcc_parse_subspace_irq(pchan, pcct_entry);
 			if (rc < 0)
-				goto err;
+				goto out_put_pcct;
 		}
 		rc = pcc_parse_subspace_db_reg(pchan, pcct_entry);
 		if (rc < 0)
-			goto err;
+			goto out_put_pcct;
 
 		pcc_parse_subspace_shmem(pchan, pcct_entry);
 
@@ -827,9 +827,8 @@ static int pcc_mbox_probe(struct platform_device *pdev)
 	rc = mbox_controller_register(pcc_mbox_ctrl);
 	if (rc)
 		pr_err("Err registering PCC as Mailbox controller: %d\n", rc);
-	else
-		return 0;
-err:
+
+out_put_pcct:
 	acpi_put_table(pcct_tbl);
 	return rc;
 }
-- 
2.20.1


