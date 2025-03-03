Return-Path: <linux-acpi+bounces-11711-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE348A4BD0C
	for <lists+linux-acpi@lfdr.de>; Mon,  3 Mar 2025 11:56:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C0FD172B51
	for <lists+linux-acpi@lfdr.de>; Mon,  3 Mar 2025 10:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A5C51F8755;
	Mon,  3 Mar 2025 10:53:40 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E1261F791E;
	Mon,  3 Mar 2025 10:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740999220; cv=none; b=pSo8/KS4a3qumypdk+9/tuKlWTkAtWXeh5UJKzw7NY5FJFgHvmx6x/1vNXhIlHo5V7qcqe9qYJ3dRk5ySgosNl7Ve3d2Dk6UrzcBkEGYTehLI/jiJ///TkTEmaZ//QoVbL3LXDzhNl0mnzqOgNP/EYd2UX422lV+gjxYswYTppc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740999220; c=relaxed/simple;
	bh=/1idv0gKwQTkta21Z/N8pYBowlvpzsLMWC0CYxTJA3w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d6NNfSOfefOE3PfH4Qr3eVFgQti7gP7glEV1uGSEfLHonD/Ab5/ei4DHFfMCBW+gysVnTJXbf9eFg5twYypUVxK0c1gDm/SYoJ0aTkZLo/DwZWrtds4H7PQUFOj687564zGNXVDBTSg/27ZqWs7MVCxCIv8IfLwTCccSSrqBITM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5CFA21FCD;
	Mon,  3 Mar 2025 02:53:52 -0800 (PST)
Received: from e133711.arm.com (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 40E673F673;
	Mon,  3 Mar 2025 02:53:37 -0800 (PST)
From: Sudeep Holla <sudeep.holla@arm.com>
Date: Mon, 03 Mar 2025 10:51:45 +0000
Subject: [PATCH 10/14] soc: hisilicon: kunpeng_hccs: Simplify PCC shared
 memory region handling
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250303-pcc_fixes_updates-v1-10-3b44f3d134b1@arm.com>
References: <20250303-pcc_fixes_updates-v1-0-3b44f3d134b1@arm.com>
In-Reply-To: <20250303-pcc_fixes_updates-v1-0-3b44f3d134b1@arm.com>
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>, 
 Jassi Brar <jassisinghbrar@gmail.com>, Huisong Li <lihuisong@huawei.com>, 
 Adam Young <admiyo@os.amperecomputing.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6214; i=sudeep.holla@arm.com;
 h=from:subject:message-id; bh=/1idv0gKwQTkta21Z/N8pYBowlvpzsLMWC0CYxTJA3w=;
 b=owEBbQKS/ZANAwAIAQBBurwxfuKYAcsmYgBnxYoi6vcxSZaG0sHVa3JebeebwsbybmU5fCbyH
 T/XmpEJ6YKJAjMEAAEIAB0WIQS6ceUSBvMeskPdk+EAQbq8MX7imAUCZ8WKIgAKCRAAQbq8MX7i
 mMxpEACJXHy//3/3BmXe6VvvQZvTJq4wJfOUxF5DHytYxtWoj0jYx22WD0amQvU/bJriWU2D7ho
 NZiSts/WBUVNN6bdL92y3Nl0iIFXDqriFccJ42aqcK6q0VTtUavbmSVaV+f/I6Wa4kcZcgER016
 pPgJZbGlXxss0LSR9ekmkbLzlD37D+dQ0tHur/OsrPfLG4uZ4LB8mEYAx4hbBchkJYmPXz0y8QJ
 mjPFtKBvQFJFa/gRNpH5IANall/qTuK5zGFlf5ZjL/bQMZs5rbAVXZZRTUN317aaCDbK9AE5yyE
 I+TfVBp2LkWAiuSjOjU9QkwTPRpa4AGBHVnqmOSth9J/iiGOf/MQlgjNVYpQ3oMBSFHqHBNNjyB
 6Y5drensEICn21biT6PQK2lK2Owe+SZMpHHmx77rDX3yMl5Nka8qSjrMiyb9tpqaLUU0lNZ4gtH
 CKNfD/KdBURFI9pGUhAOwHRfrqWHP6lrP02qrpfXQrLeLrQ0fdJRNXlWzLf5w6ZTDkF3dC/ocLP
 o5DkvNrBZtKanD4C0GeeeXCkBEyTEZPgSc6DHPmxCZk6If0K2XNE4RAMCTflngqM4LV7LZ32el4
 SDha47gE3k+2tZPcZzgl54QYjojHcyGANPtdq8PorsCkFr1Iz3FUInaKdgYhXxsFm+odWzeDvn5
 NVs43S8A7eZKYkw==
X-Developer-Key: i=sudeep.holla@arm.com; a=openpgp;
 fpr=7360A21742ADF5A11767C1C139CFD4755FE2D5B4

The PCC driver now handles mapping and unmapping of shared memory
areas as part of pcc_mbox_{request,free}_channel(). Without these before,
this Kunpeng HCCS driver did handling of those mappings like several
other PCC mailbox client drivers.

There were redundant operations, leading to unnecessary code. Maintaining
the consistency across these driver was harder due to scattered handling
of shmem.

Just use the mapped shmem and remove all redundant operations from this
driver.

Cc: Huisong Li <lihuisong@huawei.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/soc/hisilicon/kunpeng_hccs.c | 38 ++++++++++++------------------------
 drivers/soc/hisilicon/kunpeng_hccs.h |  2 --
 2 files changed, 13 insertions(+), 27 deletions(-)

diff --git a/drivers/soc/hisilicon/kunpeng_hccs.c b/drivers/soc/hisilicon/kunpeng_hccs.c
index 8aa8dec14911cdcdc2a2d11606bf6159144e9489..3b57189cd778f507afaa89bf47f0fa834043c244 100644
--- a/drivers/soc/hisilicon/kunpeng_hccs.c
+++ b/drivers/soc/hisilicon/kunpeng_hccs.c
@@ -167,10 +167,6 @@ static void hccs_pcc_rx_callback(struct mbox_client *cl, void *mssg)
 
 static void hccs_unregister_pcc_channel(struct hccs_dev *hdev)
 {
-	struct hccs_mbox_client_info *cl_info = &hdev->cl_info;
-
-	if (cl_info->pcc_comm_addr)
-		iounmap(cl_info->pcc_comm_addr);
 	pcc_mbox_free_channel(hdev->cl_info.pcc_chan);
 }
 
@@ -179,6 +175,7 @@ static int hccs_register_pcc_channel(struct hccs_dev *hdev)
 	struct hccs_mbox_client_info *cl_info = &hdev->cl_info;
 	struct mbox_client *cl = &cl_info->client;
 	struct pcc_mbox_chan *pcc_chan;
+	struct mbox_chan *mbox_chan;
 	struct device *dev = hdev->dev;
 	int rc;
 
@@ -196,7 +193,7 @@ static int hccs_register_pcc_channel(struct hccs_dev *hdev)
 		goto out;
 	}
 	cl_info->pcc_chan = pcc_chan;
-	cl_info->mbox_chan = pcc_chan->mchan;
+	mbox_chan = pcc_chan->mchan;
 
 	/*
 	 * pcc_chan->latency is just a nominal value. In reality the remote
@@ -206,34 +203,24 @@ static int hccs_register_pcc_channel(struct hccs_dev *hdev)
 	cl_info->deadline_us =
 			HCCS_PCC_CMD_WAIT_RETRIES_NUM * pcc_chan->latency;
 	if (!hdev->verspec_data->has_txdone_irq &&
-	    cl_info->mbox_chan->mbox->txdone_irq) {
+	    mbox_chan->mbox->txdone_irq) {
 		dev_err(dev, "PCC IRQ in PCCT is enabled.\n");
 		rc = -EINVAL;
 		goto err_mbx_channel_free;
 	} else if (hdev->verspec_data->has_txdone_irq &&
-		   !cl_info->mbox_chan->mbox->txdone_irq) {
+		   !mbox_chan->mbox->txdone_irq) {
 		dev_err(dev, "PCC IRQ in PCCT isn't supported.\n");
 		rc = -EINVAL;
 		goto err_mbx_channel_free;
 	}
 
-	if (!pcc_chan->shmem_base_addr ||
-	    pcc_chan->shmem_size != HCCS_PCC_SHARE_MEM_BYTES) {
+	if (pcc_chan->shmem_size != HCCS_PCC_SHARE_MEM_BYTES) {
 		dev_err(dev, "The base address or size (%llu) of PCC communication region is invalid.\n",
 			pcc_chan->shmem_size);
 		rc = -EINVAL;
 		goto err_mbx_channel_free;
 	}
 
-	cl_info->pcc_comm_addr = ioremap(pcc_chan->shmem_base_addr,
-					 pcc_chan->shmem_size);
-	if (!cl_info->pcc_comm_addr) {
-		dev_err(dev, "Failed to ioremap PCC communication region for channel-%u.\n",
-			hdev->chan_id);
-		rc = -ENOMEM;
-		goto err_mbx_channel_free;
-	}
-
 	return 0;
 
 err_mbx_channel_free:
@@ -246,7 +233,7 @@ static int hccs_wait_cmd_complete_by_poll(struct hccs_dev *hdev)
 {
 	struct hccs_mbox_client_info *cl_info = &hdev->cl_info;
 	struct acpi_pcct_shared_memory __iomem *comm_base =
-							cl_info->pcc_comm_addr;
+							cl_info->pcc_chan->shmem;
 	u16 status;
 	int ret;
 
@@ -289,7 +276,7 @@ static inline void hccs_fill_pcc_shared_mem_region(struct hccs_dev *hdev,
 		.status = 0,
 	};
 
-	memcpy_toio(hdev->cl_info.pcc_comm_addr, (void *)&tmp,
+	memcpy_toio(hdev->cl_info.pcc_chan->shmem, (void *)&tmp,
 		    sizeof(struct acpi_pcct_shared_memory));
 
 	/* Copy the message to the PCC comm space */
@@ -309,7 +296,7 @@ static inline void hccs_fill_ext_pcc_shared_mem_region(struct hccs_dev *hdev,
 		.command = cmd,
 	};
 
-	memcpy_toio(hdev->cl_info.pcc_comm_addr, (void *)&tmp,
+	memcpy_toio(hdev->cl_info.pcc_chan->shmem, (void *)&tmp,
 		    sizeof(struct acpi_pcct_ext_pcc_shared_memory));
 
 	/* Copy the message to the PCC comm space */
@@ -321,12 +308,13 @@ static int hccs_pcc_cmd_send(struct hccs_dev *hdev, u8 cmd,
 {
 	const struct hccs_verspecific_data *verspec_data = hdev->verspec_data;
 	struct hccs_mbox_client_info *cl_info = &hdev->cl_info;
+	struct mbox_chan *mbox_chan = cl_info->pcc_chan->mchan;
 	struct hccs_fw_inner_head *fw_inner_head;
 	void __iomem *comm_space;
 	u16 space_size;
 	int ret;
 
-	comm_space = cl_info->pcc_comm_addr + verspec_data->shared_mem_size;
+	comm_space = cl_info->pcc_chan->shmem + verspec_data->shared_mem_size;
 	space_size = HCCS_PCC_SHARE_MEM_BYTES - verspec_data->shared_mem_size;
 	verspec_data->fill_pcc_shared_mem(hdev, cmd, desc,
 					  comm_space, space_size);
@@ -334,7 +322,7 @@ static int hccs_pcc_cmd_send(struct hccs_dev *hdev, u8 cmd,
 		reinit_completion(&cl_info->done);
 
 	/* Ring doorbell */
-	ret = mbox_send_message(cl_info->mbox_chan, &cmd);
+	ret = mbox_send_message(mbox_chan, &cmd);
 	if (ret < 0) {
 		dev_err(hdev->dev, "Send PCC mbox message failed, ret = %d.\n",
 			ret);
@@ -356,9 +344,9 @@ static int hccs_pcc_cmd_send(struct hccs_dev *hdev, u8 cmd,
 
 end:
 	if (verspec_data->has_txdone_irq)
-		mbox_chan_txdone(cl_info->mbox_chan, ret);
+		mbox_chan_txdone(mbox_chan, ret);
 	else
-		mbox_client_txdone(cl_info->mbox_chan, ret);
+		mbox_client_txdone(mbox_chan, ret);
 	return ret;
 }
 
diff --git a/drivers/soc/hisilicon/kunpeng_hccs.h b/drivers/soc/hisilicon/kunpeng_hccs.h
index dc267136919b7bf3ecc0deb8cf7291267dd91789..f0a9a5618d9735e959633059192449b10d5bbf16 100644
--- a/drivers/soc/hisilicon/kunpeng_hccs.h
+++ b/drivers/soc/hisilicon/kunpeng_hccs.h
@@ -60,10 +60,8 @@ struct hccs_chip_info {
 
 struct hccs_mbox_client_info {
 	struct mbox_client client;
-	struct mbox_chan *mbox_chan;
 	struct pcc_mbox_chan *pcc_chan;
 	u64 deadline_us;
-	void __iomem *pcc_comm_addr;
 	struct completion done;
 };
 

-- 
2.34.1


