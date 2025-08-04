Return-Path: <linux-acpi+bounces-15518-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A22DEB1A654
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Aug 2025 17:45:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3441621E35
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Aug 2025 15:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D587F221FC3;
	Mon,  4 Aug 2025 15:44:27 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-m32117.qiye.163.com (mail-m32117.qiye.163.com [220.197.32.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D4B221FDC;
	Mon,  4 Aug 2025 15:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754322267; cv=none; b=dsGIZupobmIST4SgM4LuXpaABVpFKbOwzv50HjOpu/aPRn7FP75ntf8MvHK0hXDo06lOYesRloOWPDxQE6KvqfBAWH1IKFVtLH6qxuv5Ed8iRII4BUP8Qc1eq1tyF3EtmgyyJQB3ScW2ZpVImet7zjAMft7jChi+j2rZa7ZnC1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754322267; c=relaxed/simple;
	bh=hsk6mw1fNdQeDmc6GdjZYLJn8zb/NmfxSTDxHHkAI00=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZHuVKCsw5lxkiUk3QdxC8/iXvPubeonrw48hWXwrJXVmChJJLNYCXdbN8o78N6lT0DD4X9Q6dItLbPNQQX6zBP86vhZ+qnBo29paqTIcFt2NTMk5yvMHwAVs6y/xclr6EajZOApBQIp/ufH8H/wkX8W4aTk7T3kNxE/3UXXqPDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn; spf=pass smtp.mailfrom=easystack.cn; arc=none smtp.client-ip=220.197.32.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=easystack.cn
Received: from localhost.localdomain (unknown [218.94.118.90])
	by smtp.qiye.163.com (Hmail) with ESMTP id e1e51986;
	Mon, 4 Aug 2025 20:15:01 +0800 (GMT+08:00)
From: Zhen Ni <zhen.ni@easystack.cn>
To: Markus.Elfring@web.de,
	sudeep.holla@arm.com,
	jassisinghbrar@gmail.com
Cc: linux-acpi@vger.kernel.org,
	Zhen Ni <zhen.ni@easystack.cn>,
	stable@vger.kernel.org
Subject: [PATCH v3] mailbox: pcc: Add missed acpi_put_table() to fix memory leak
Date: Mon,  4 Aug 2025 20:14:53 +0800
Message-Id: <20250804121453.75525-1-zhen.ni@easystack.cn>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20250804074115.44573-1-zhen.ni@easystack.cn>
References: <20250804074115.44573-1-zhen.ni@easystack.cn>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a987501af800229kunm8239557b498f5f
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFJQjdXWS1ZQUlXWQ8JGhUIEh9ZQVkaT0xKVhlJHUNCSR9MTBpJQlYVFAkWGhdVGRETFh
	oSFyQUDg9ZV1kYEgtZQVlJSkNVQk9VSkpDVUJLWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
	VKQktLWQY+

In pcc_mbox_probe(), the PCCT table acquired via acpi_get_table() is
only released in error paths but not in the success path. Fix a
permanent ACPI memory leak when the driver successfully initializes. Add
the goto label 'err_nomem'.

Fixes: ce028702ddbc ("mailbox: pcc: Move bulk of PCCT parsing into pcc_mbox_probe")
Cc: stable@vger.kernel.org
Signed-off-by: Zhen Ni <zhen.ni@easystack.cn>
---
Changes in v2:
- Add tags of 'Fixes' and 'Cc'
- Change goto target from out_put_pcct to e_nomem
---
Changes in v3:
- Add goto label err_nomem, keep the err label.
- Update commit msg
---
 drivers/mailbox/pcc.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
index f6714c233f5a..b5ce3a5d2e7a 100644
--- a/drivers/mailbox/pcc.c
+++ b/drivers/mailbox/pcc.c
@@ -761,22 +761,16 @@ static int pcc_mbox_probe(struct platform_device *pdev)
 
 	pcc_mbox_channels = devm_kcalloc(dev, count, sizeof(*pcc_mbox_channels),
 					 GFP_KERNEL);
-	if (!pcc_mbox_channels) {
-		rc = -ENOMEM;
-		goto err;
-	}
+	if (!pcc_mbox_channels)
+		goto err_nomem;
 
 	chan_info = devm_kcalloc(dev, count, sizeof(*chan_info), GFP_KERNEL);
-	if (!chan_info) {
-		rc = -ENOMEM;
-		goto err;
-	}
+	if (!chan_info)
+		goto err_nomem;
 
 	pcc_mbox_ctrl = devm_kzalloc(dev, sizeof(*pcc_mbox_ctrl), GFP_KERNEL);
-	if (!pcc_mbox_ctrl) {
-		rc = -ENOMEM;
-		goto err;
-	}
+	if (!pcc_mbox_ctrl)
+		goto err_nomem;
 
 	/* Point to the first PCC subspace entry */
 	pcct_entry = (struct acpi_subtable_header *) (
@@ -827,8 +821,11 @@ static int pcc_mbox_probe(struct platform_device *pdev)
 	rc = mbox_controller_register(pcc_mbox_ctrl);
 	if (rc)
 		pr_err("Err registering PCC as Mailbox controller: %d\n", rc);
-	else
-		return 0;
+	goto err;
+
+err_nomem:
+	rc = -ENOMEM;
+	goto err;
 err:
 	acpi_put_table(pcct_tbl);
 	return rc;
-- 
2.20.1


