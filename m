Return-Path: <linux-acpi+bounces-11849-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3DA0A50567
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Mar 2025 17:43:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E0527A695D
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Mar 2025 16:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DB64254873;
	Wed,  5 Mar 2025 16:39:13 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4321253F2C;
	Wed,  5 Mar 2025 16:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741192753; cv=none; b=rDwY0bfPcZCZ15atPL5Z4oNw/GNA0QDFN4W0hWZEsF6D2oZljRQoL6vBNFzL1wKN+00yYNAPtgZSty79wz4vNTswqROEUpktqa0GOYfbiBYIS0aSath6VDSPVDlnTxFlRHzcodXxpyn/aFcbMqga305JkyTiWrQ1Hn2WkTL6nuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741192753; c=relaxed/simple;
	bh=9UGEN/buW+rB+SNY16YtJWZHD/wQwocyB/zk8N1p+qs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ihoEhxomvO8xAlBivalLBUl/GVDzCxwSNFfv2W94ukI8uPJS1lwEJn0nSkO7nWafpmVpg0vdCW+Hnx/PtXofQzwnVu6hBHrYzU+D4aJdz2Uhsdzh7V43P0Wsm7MPB5r40USaY/6Fx9qQm4lEhLB4CUQtLMJVItP9KFokV+HDRzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DC05C1713;
	Wed,  5 Mar 2025 08:39:24 -0800 (PST)
Received: from e133711.arm.com (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 749223F5A1;
	Wed,  5 Mar 2025 08:39:10 -0800 (PST)
From: Sudeep Holla <sudeep.holla@arm.com>
Date: Wed, 05 Mar 2025 16:38:13 +0000
Subject: [PATCH v2 09/13] soc: hisilicon: kunpeng_hccs: Simplify PCC shared
 memory region handling
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250305-pcc_fixes_updates-v2-9-1b1822bc8746@arm.com>
References: <20250305-pcc_fixes_updates-v2-0-1b1822bc8746@arm.com>
In-Reply-To: <20250305-pcc_fixes_updates-v2-0-1b1822bc8746@arm.com>
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>, 
 Jassi Brar <jassisinghbrar@gmail.com>, Huisong Li <lihuisong@huawei.com>, 
 Adam Young <admiyo@os.amperecomputing.com>, 
 Robbie King <robbiek@xsightlabs.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6401; i=sudeep.holla@arm.com;
 h=from:subject:message-id; bh=9UGEN/buW+rB+SNY16YtJWZHD/wQwocyB/zk8N1p+qs=;
 b=owEBbQKS/ZANAwAIAQBBurwxfuKYAcsmYgBnyH4fbNicEXX8dRnc3g4kt0HU6ujLG7YZH+NO5
 iHP5Dp9vGyJAjMEAAEIAB0WIQS6ceUSBvMeskPdk+EAQbq8MX7imAUCZ8h+HwAKCRAAQbq8MX7i
 mMvmD/9VEP0bw8XE1ng3NGmPzUvmC5SQsFexTpgL0Im6UTnjAv+E8CVXQy7LQidjVtOZjvcaPZC
 lXzziGS4aN0tdljrf20xY7bwQZLOO0QvMCd20pKsU6kHizYnvG52ddD7oJx9f/E8hqGXDqHViLL
 +Ea5MtItT3RngR1SKomUiwSshzYSZxUTQmiwdDLfvWO3zHdO+7ouM/gbwH/RRep7zkF569rv3+l
 Y89q+xgS3DhOqffMwHZ2Zu5Vc+omI5sNo+xiPwpyDFRoU6rk8kdN1Ezk3FkRlkHg3LcLM96paaw
 +Ghf4EYonEBhMmeq3Dn1HpIQz7GzM3We76bcChavlSXZv7ImQv/wVFbX7RF7KKOsCv2f9x/X3Iu
 2/frQTSPJtVnZ7o8WpS35iuroZJBg71CZWazAmr90uY31UaSZQvCiFU6TgNqHGjiBTldyisJeSG
 4aq16eMeYspEL2cBHmLZFquI/QRHE6IfFT1/8+2mi+7wPM7DPgCuOvgyB68WFFXCXp9ZIEV+8uF
 wu8sRarYx++eGKedgBWSeDcT4z0AbmIfUaYRh+oei9XaravtncXtr5CZLu1amfnp8vsn0QC0gnJ
 f5aD5ASUUr82HMib6UVzSgEIH8bKd+awUSM+HIPZmSN6HMRuSpSs3J/uZkcMZ4mPy5F+YMrEPB6
 N3gCHIyLV4AYnAQ==
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
Reviewed-by: Huisong Li <lihuisong@huawei.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/soc/hisilicon/kunpeng_hccs.c | 42 +++++++++++++-----------------------
 drivers/soc/hisilicon/kunpeng_hccs.h |  2 --
 2 files changed, 15 insertions(+), 29 deletions(-)

diff --git a/drivers/soc/hisilicon/kunpeng_hccs.c b/drivers/soc/hisilicon/kunpeng_hccs.c
index 8aa8dec14911cdcdc2a2d11606bf6159144e9489..02b2e5ce40b313c8c3cf462c5c2f1d0c53f612f6 100644
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
-		dev_err(dev, "The base address or size (%llu) of PCC communication region is invalid.\n",
-			pcc_chan->shmem_size);
+	if (pcc_chan->shmem_size != HCCS_PCC_SHARE_MEM_BYTES) {
+		dev_err(dev, "Base size (%llu) of PCC communication region must be %d bytes.\n",
+			pcc_chan->shmem_size, HCCS_PCC_SHARE_MEM_BYTES);
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


