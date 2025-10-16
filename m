Return-Path: <linux-acpi+bounces-17835-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E1DBE52E5
	for <lists+linux-acpi@lfdr.de>; Thu, 16 Oct 2025 21:09:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FDA01AA0D45
	for <lists+linux-acpi@lfdr.de>; Thu, 16 Oct 2025 19:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 341F823EA9F;
	Thu, 16 Oct 2025 19:08:54 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8553B22D4FF;
	Thu, 16 Oct 2025 19:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760641734; cv=none; b=kCc5TW4Xq6Myqn59Pwu2JDRIIUygB484OTow+yR54YZdknfsSGszC0GQKZLQNnD6XR2avT+9rQPX0VIWyf2Myoj06S6fLGKRpqabYf/HYzpYNxLjIyYJ+mz1yS2iRa2QYDN77NXTuLbLDS8CXzlHroPYuhWBr2I0gOOoobooEco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760641734; c=relaxed/simple;
	bh=uLrYXi2/iyPCwCIDHxtSg6mF7HS4sj9x6MlSArcqM0c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=paCRQyRZML//pr+2QLjN5iLtjIh6dLZo2tsJ4K7EZdEpAF33dfyub64U/U9el9n/b/YQmR592MS351yoC5TGKhVehtv5HCG1Fx0bzdk6iL5nYDToENw8/Q9k6FgfHvvAfre5LeLTgjp6XRWpOAU6hqcP6pqQVJ9HxOTQSbPhoQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E4E001713;
	Thu, 16 Oct 2025 12:08:42 -0700 (PDT)
Received: from e133711.arm.com (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 837FC3F66E;
	Thu, 16 Oct 2025 12:08:49 -0700 (PDT)
From: Sudeep Holla <sudeep.holla@arm.com>
Date: Thu, 16 Oct 2025 20:08:15 +0100
Subject: [PATCH 1/6] Revert "mailbox/pcc: support mailbox management of the
 shared buffer"
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251016-pcc_mb_updates-v1-1-0fba69616f69@arm.com>
References: <20251016-pcc_mb_updates-v1-0-0fba69616f69@arm.com>
In-Reply-To: <20251016-pcc_mb_updates-v1-0-0fba69616f69@arm.com>
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>, 
 Adam Young <admiyo@os.amperecomputing.com>, 
 Robbie King <robbiek@xsightlabs.com>, Huisong Li <lihuisong@huawei.com>, 
 Jassi Brar <jassisinghbrar@gmail.com>, 
 Cristian Marussi <cristian.marussi@arm.com>
X-Mailer: b4 0.14.3

This reverts commit 5378bdf6a611a32500fccf13d14156f219bb0c85.

Commit 5378bdf6a611 ("mailbox/pcc: support mailbox management of the shared buffer")
attempted to introduce generic helpers for managing the PCC shared memory,
but it largely duplicates functionality already provided by the mailbox
core and leaves gaps:

1. TX preparation: The mailbox framework already supports this via
  ->tx_prepare callback for mailbox clients. The patch adds
  pcc_write_to_buffer() and expects clients to toggle pchan->chan.manage_writes,
  but no drivers set manage_writes, so pcc_write_to_buffer() has no users.

2. RX handling: Data reception is already delivered through
   mbox_chan_received_data() and client ->rx_callback. The patch adds an
   optional pchan->chan.rx_alloc, which again has no users and duplicates
   the existing path.

3. Completion handling: While adding last_tx_done is directionally useful,
   the implementation only covers Type 3/4 and fails to handle the absence
   of a command_complete register, so it is incomplete for other types.

Given the duplication and incomplete coverage, revert this change. Any new
requirements should be addressed in focused follow-ups rather than bundling
multiple behavioral changes together.

Fixes: 5378bdf6a611 ("mailbox/pcc: support mailbox management of the shared buffer")
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/mailbox/pcc.c | 102 ++------------------------------------------------
 include/acpi/pcc.h    |  29 --------------
 2 files changed, 4 insertions(+), 127 deletions(-)

diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
index 0a00719b2482..f6714c233f5a 100644
--- a/drivers/mailbox/pcc.c
+++ b/drivers/mailbox/pcc.c
@@ -306,22 +306,6 @@ static void pcc_chan_acknowledge(struct pcc_chan_info *pchan)
 		pcc_chan_reg_read_modify_write(&pchan->db);
 }
 
-static void *write_response(struct pcc_chan_info *pchan)
-{
-	struct pcc_header pcc_header;
-	void *buffer;
-	int data_len;
-
-	memcpy_fromio(&pcc_header, pchan->chan.shmem,
-		      sizeof(pcc_header));
-	data_len = pcc_header.length - sizeof(u32) + sizeof(struct pcc_header);
-
-	buffer = pchan->chan.rx_alloc(pchan->chan.mchan->cl, data_len);
-	if (buffer != NULL)
-		memcpy_fromio(buffer, pchan->chan.shmem, data_len);
-	return buffer;
-}
-
 /**
  * pcc_mbox_irq - PCC mailbox interrupt handler
  * @irq:	interrupt number
@@ -333,8 +317,6 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
 {
 	struct pcc_chan_info *pchan;
 	struct mbox_chan *chan = p;
-	struct pcc_header *pcc_header = chan->active_req;
-	void *handle = NULL;
 
 	pchan = chan->con_priv;
 
@@ -358,17 +340,7 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
 	 * required to avoid any possible race in updatation of this flag.
 	 */
 	pchan->chan_in_use = false;
-
-	if (pchan->chan.rx_alloc)
-		handle = write_response(pchan);
-
-	if (chan->active_req) {
-		pcc_header = chan->active_req;
-		if (pcc_header->flags & PCC_CMD_COMPLETION_NOTIFY)
-			mbox_chan_txdone(chan, 0);
-	}
-
-	mbox_chan_received_data(chan, handle);
+	mbox_chan_received_data(chan, NULL);
 
 	pcc_chan_acknowledge(pchan);
 
@@ -412,24 +384,9 @@ pcc_mbox_request_channel(struct mbox_client *cl, int subspace_id)
 	pcc_mchan = &pchan->chan;
 	pcc_mchan->shmem = acpi_os_ioremap(pcc_mchan->shmem_base_addr,
 					   pcc_mchan->shmem_size);
-	if (!pcc_mchan->shmem)
-		goto err;
-
-	pcc_mchan->manage_writes = false;
-
-	/* This indicates that the channel is ready to accept messages.
-	 * This needs to happen after the channel has registered
-	 * its callback. There is no access point to do that in
-	 * the mailbox API. That implies that the mailbox client must
-	 * have set the allocate callback function prior to
-	 * sending any messages.
-	 */
-	if (pchan->type == ACPI_PCCT_TYPE_EXT_PCC_SLAVE_SUBSPACE)
-		pcc_chan_reg_read_modify_write(&pchan->cmd_update);
-
-	return pcc_mchan;
+	if (pcc_mchan->shmem)
+		return pcc_mchan;
 
-err:
 	mbox_free_channel(chan);
 	return ERR_PTR(-ENXIO);
 }
@@ -460,38 +417,8 @@ void pcc_mbox_free_channel(struct pcc_mbox_chan *pchan)
 }
 EXPORT_SYMBOL_GPL(pcc_mbox_free_channel);
 
-static int pcc_write_to_buffer(struct mbox_chan *chan, void *data)
-{
-	struct pcc_chan_info *pchan = chan->con_priv;
-	struct pcc_mbox_chan *pcc_mbox_chan = &pchan->chan;
-	struct pcc_header *pcc_header = data;
-
-	if (!pchan->chan.manage_writes)
-		return 0;
-
-	/* The PCC header length includes the command field
-	 * but not the other values from the header.
-	 */
-	int len = pcc_header->length - sizeof(u32) + sizeof(struct pcc_header);
-	u64 val;
-
-	pcc_chan_reg_read(&pchan->cmd_complete, &val);
-	if (!val) {
-		pr_info("%s pchan->cmd_complete not set", __func__);
-		return -1;
-	}
-	memcpy_toio(pcc_mbox_chan->shmem,  data, len);
-	return 0;
-}
-
-
 /**
- * pcc_send_data - Called from Mailbox Controller code. If
- *		pchan->chan.rx_alloc is set, then the command complete
- *		flag is checked and the data is written to the shared
- *		buffer io memory.
- *
- *		If pchan->chan.rx_alloc is not set, then it is used
+ * pcc_send_data - Called from Mailbox Controller code. Used
  *		here only to ring the channel doorbell. The PCC client
  *		specific read/write is done in the client driver in
  *		order to maintain atomicity over PCC channel once
@@ -507,37 +434,17 @@ static int pcc_send_data(struct mbox_chan *chan, void *data)
 	int ret;
 	struct pcc_chan_info *pchan = chan->con_priv;
 
-	ret = pcc_write_to_buffer(chan, data);
-	if (ret)
-		return ret;
-
 	ret = pcc_chan_reg_read_modify_write(&pchan->cmd_update);
 	if (ret)
 		return ret;
 
 	ret = pcc_chan_reg_read_modify_write(&pchan->db);
-
 	if (!ret && pchan->plat_irq > 0)
 		pchan->chan_in_use = true;
 
 	return ret;
 }
 
-
-static bool pcc_last_tx_done(struct mbox_chan *chan)
-{
-	struct pcc_chan_info *pchan = chan->con_priv;
-	u64 val;
-
-	pcc_chan_reg_read(&pchan->cmd_complete, &val);
-	if (!val)
-		return false;
-	else
-		return true;
-}
-
-
-
 /**
  * pcc_startup - Called from Mailbox Controller code. Used here
  *		to request the interrupt.
@@ -583,7 +490,6 @@ static const struct mbox_chan_ops pcc_chan_ops = {
 	.send_data = pcc_send_data,
 	.startup = pcc_startup,
 	.shutdown = pcc_shutdown,
-	.last_tx_done = pcc_last_tx_done,
 };
 
 /**
diff --git a/include/acpi/pcc.h b/include/acpi/pcc.h
index 9af3b502f839..840bfc95bae3 100644
--- a/include/acpi/pcc.h
+++ b/include/acpi/pcc.h
@@ -17,35 +17,6 @@ struct pcc_mbox_chan {
 	u32 latency;
 	u32 max_access_rate;
 	u16 min_turnaround_time;
-
-	/* Set to true to indicate that the mailbox should manage
-	 * writing the dat to the shared buffer. This differs from
-	 * the case where the drivesr are writing to the buffer and
-	 * using send_data only to  ring the doorbell.  If this flag
-	 * is set, then the void * data parameter of send_data must
-	 * point to a kernel-memory buffer formatted in accordance with
-	 * the PCC specification.
-	 *
-	 * The active buffer management will include reading the
-	 * notify_on_completion flag, and will then
-	 * call mbox_chan_txdone when the acknowledgment interrupt is
-	 * received.
-	 */
-	bool manage_writes;
-
-	/* Optional callback that allows the driver
-	 * to allocate the memory used for receiving
-	 * messages.  The return value is the location
-	 * inside the buffer where the mailbox should write the data.
-	 */
-	void *(*rx_alloc)(struct mbox_client *cl,  int size);
-};
-
-struct pcc_header {
-	u32 signature;
-	u32 flags;
-	u32 length;
-	u32 command;
 };
 
 /* Generic Communications Channel Shared Memory Region */

-- 
2.34.1


