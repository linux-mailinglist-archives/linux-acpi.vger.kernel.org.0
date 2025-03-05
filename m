Return-Path: <linux-acpi+bounces-11848-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E94E7A5056B
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Mar 2025 17:43:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AF7B3B248C
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Mar 2025 16:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03048253F3C;
	Wed,  5 Mar 2025 16:39:12 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C70D253F09;
	Wed,  5 Mar 2025 16:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741192751; cv=none; b=ilcw0pIgfMDhAJsExFlsLuPx1yLntavFR2FDKjRG4B2PqEz0+uK1FGJuv1UBu8WIMsHDdHPsYl2CteXH3CGZGGm5xCwKaO6arCnWAGZ70Aj+nNSYl4GPhHxURC325zPjt3icINM1HR3kJuq/iNNPNjO88BEnXPiAPQvLQCQs6JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741192751; c=relaxed/simple;
	bh=cIMK+n2o3rsEDin9AdC2kdUyZidm53z6uq3MCcTwSQg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tqyGMwvO8p5zYyqOYqltg2IHvRCzW+ThfC8tF/UDF18QL1eTixncBLgm4i7j08uRpo0l883eX9AtGYmT51dXIVCY7PtXGdk8NehRkQ1xKxMOxdYgEUlP3cd2q3xQgLru7N/yoouyWVIsKJQ1XHXlw4CUYbz6/P88TDwh2xnpHJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 69EF01007;
	Wed,  5 Mar 2025 08:39:23 -0800 (PST)
Received: from e133711.arm.com (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 024B33F5A1;
	Wed,  5 Mar 2025 08:39:08 -0800 (PST)
From: Sudeep Holla <sudeep.holla@arm.com>
Date: Wed, 05 Mar 2025 16:38:12 +0000
Subject: [PATCH v2 08/13] mailbox: pcc: Refactor and simplify
 check_and_ack()
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250305-pcc_fixes_updates-v2-8-1b1822bc8746@arm.com>
References: <20250305-pcc_fixes_updates-v2-0-1b1822bc8746@arm.com>
In-Reply-To: <20250305-pcc_fixes_updates-v2-0-1b1822bc8746@arm.com>
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>, 
 Jassi Brar <jassisinghbrar@gmail.com>, Huisong Li <lihuisong@huawei.com>, 
 Adam Young <admiyo@os.amperecomputing.com>, 
 Robbie King <robbiek@xsightlabs.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3255; i=sudeep.holla@arm.com;
 h=from:subject:message-id; bh=cIMK+n2o3rsEDin9AdC2kdUyZidm53z6uq3MCcTwSQg=;
 b=owEBbQKS/ZANAwAIAQBBurwxfuKYAcsmYgBnyH4feH/zpixLfwK1FIMsiLYeun31q3x7DjtWE
 38wETNpmQ6JAjMEAAEIAB0WIQS6ceUSBvMeskPdk+EAQbq8MX7imAUCZ8h+HwAKCRAAQbq8MX7i
 mPSaD/0SqruOF5TMB89h/SJ7N9Gar+UBqixxFlGmCdBwc0PwKs60XV+ORSdQC0YHGy/jGjNKy9e
 cRvtmteTRjJwvqjAs8m7u6SVaYqQPYvdELlBITUzgl/hSwRwFefujJ4piaHeB7ZGXEadwwJv0ih
 lBDTsZDIRL4R58ztikkmNmMeAFNJN9a1rkNOwmChCprFQssiHu6vWsIdhwFTpQzxhTIKCThCpHu
 aLkP2B/u7LcoG3VwJu1tSYmYOTXyv9L7LriEZyr9cc54O89yg58h7j5ATjsxIx+5x6XIi61MjXn
 ADInbZ+aidihC+To4FYJSx6EKMgMkg6uK7HoU0wlATLdCNXMi+/X8W6iRQO730oGY96FV73/tX2
 mNT5mBB1hrODPMvvylgnArNUaBvwKx1+/tIMekofYygy7xmMNPuA6/Xj+jiyWyGDiBIuzPbTxFs
 e2j3PxHueIQsPS1C54hOwGIY8AYesHpI6/ylViFcCIbLnYjOtW/x9afghUcehD/tAtXp/tkNHVp
 B0Fk8zpsbbqmp3XDPMfwbm/xMSKOKXef9Kz/U+rbySx/V7+qNFd+fufLrM5+L5KVcDAau0MH/tk
 f6ayv0a6mBjpDoNw893xtnRcLDuJSTXkZQud8g7EpAEXD8i/YakwRrES8QRTCN5MhaVNpcRv0b+
 op1IWru87Hxz+/g==
X-Developer-Key: i=sudeep.holla@arm.com; a=openpgp;
 fpr=7360A21742ADF5A11767C1C139CFD4755FE2D5B4

The existing check_and_ack() function had unnecessary complexity. The
logic could be streamlined to improve code readability and maintainability.

The command update register needs to be updated in order to acknowledge
the platform notification through type 4 channel. So it can be done
unconditionally. Currently it is complicated just to make use of
pcc_send_data() which also executes the same updation.

In order to simplify, let us just ring the doorbell directly from
check_and_ack() instead of calling into pcc_send_data(). While at it,
rename it into pcc_chan_check_and_ack() to maintain consistency in the
driver.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/mailbox/pcc.c | 37 +++++++++++++------------------------
 1 file changed, 13 insertions(+), 24 deletions(-)

diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
index b3d133170aac7f8acfd1999564c69b7fe4f6d582..90d6f5e24df7e796f8c29705808eb6df2806c1f2 100644
--- a/drivers/mailbox/pcc.c
+++ b/drivers/mailbox/pcc.c
@@ -117,8 +117,6 @@ struct pcc_chan_info {
 static struct pcc_chan_info *chan_info;
 static int pcc_chan_count;
 
-static int pcc_send_data(struct mbox_chan *chan, void *data);
-
 /*
  * PCC can be used with perf critical drivers such as CPPC
  * So it makes sense to locally cache the virtual address and
@@ -288,33 +286,24 @@ static int pcc_mbox_error_check_and_clear(struct pcc_chan_info *pchan)
 	return 0;
 }
 
-static void check_and_ack(struct pcc_chan_info *pchan, struct mbox_chan *chan)
+static void pcc_chan_check_and_ack(struct pcc_chan_info *pchan)
 {
-	struct acpi_pcct_ext_pcc_shared_memory pcc_hdr;
+	struct acpi_pcct_ext_pcc_shared_memory __iomem *pcc_hdr;
 
 	if (pchan->type != ACPI_PCCT_TYPE_EXT_PCC_SLAVE_SUBSPACE)
 		return;
-	/* If the memory region has not been mapped, we cannot
-	 * determine if we need to send the message, but we still
-	 * need to set the cmd_update flag before returning.
-	 */
-	if (pchan->chan.shmem == NULL) {
-		pcc_chan_reg_read_modify_write(&pchan->cmd_update);
-		return;
-	}
-	memcpy_fromio(&pcc_hdr, pchan->chan.shmem,
-		      sizeof(struct acpi_pcct_ext_pcc_shared_memory));
+
+	pcc_chan_reg_read_modify_write(&pchan->cmd_update);
+
+	pcc_hdr = pchan->chan.shmem;
+
 	/*
-	 * The PCC slave subspace channel needs to set the command complete bit
-	 * after processing message. If the PCC_ACK_FLAG is set, it should also
-	 * ring the doorbell.
-	 *
-	 * The PCC master subspace channel clears chan_in_use to free channel.
+	 * The PCC slave subspace channel needs to set the command
+	 * complete bit after processing message. If the PCC_ACK_FLAG
+	 * is set, it should also ring the doorbell.
 	 */
-	if (pcc_hdr.flags & PCC_CMD_COMPLETION_NOTIFY)
-		pcc_send_data(chan, NULL);
-	else
-		pcc_chan_reg_read_modify_write(&pchan->cmd_update);
+	if (ioread32(&pcc_hdr->flags) & PCC_CMD_COMPLETION_NOTIFY)
+		pcc_chan_reg_read_modify_write(&pchan->db);
 }
 
 /**
@@ -352,7 +341,7 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
 	pchan->chan_in_use = false;
 	mbox_chan_received_data(chan, NULL);
 
-	check_and_ack(pchan, chan);
+	pcc_chan_check_and_ack(pchan);
 
 	return IRQ_HANDLED;
 }

-- 
2.34.1


