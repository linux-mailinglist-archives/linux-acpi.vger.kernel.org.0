Return-Path: <linux-acpi+bounces-9913-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23CDE9E4500
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Dec 2024 20:48:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34CEDB6520D
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Dec 2024 17:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99EBA3DAC1E;
	Wed,  4 Dec 2024 16:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ba5vuvCx"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1233DAC00;
	Wed,  4 Dec 2024 16:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733331543; cv=none; b=krzhzLM1FeUFS49HWbvLRxcTqOisfYWTVJmuKuoRKGsKcn5Doi58+hxqmmOfhsVTTCLuKmdCVtEzZgvhxeLPcOPKqMiwafdNaNf8ZC5jDi6NdIFyD6+G05nr9qDVuP6ReIircuBiUIFCChE8XNJQh9VYBlFbCkIhU5geVhkWcjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733331543; c=relaxed/simple;
	bh=7TN0xW6egqreWmtzs9zkF80AingF69k+BcAEFWULy5o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DmTQ2CoUzB4IeAaLRS986230C/oPYjSLelbePPR+fPVyEOGEOfHAUaB8fhv0GeokjDmGqQphB/YZazKbrecG01OEHcJCIK953gzvjVyRFWRIsxKwPJGg7/0HwV+Qe4Lj4y7JQXpP8/YH1JGQOKk9HaNU1lRr70L4RFWLunS+kPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ba5vuvCx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33DC0C4CECD;
	Wed,  4 Dec 2024 16:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733331543;
	bh=7TN0xW6egqreWmtzs9zkF80AingF69k+BcAEFWULy5o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ba5vuvCxzs7h0R5OfmTLgQl94iEzY8Ygo1d84utug0fNTRp+rzEy9wq7CisBm5bPq
	 RkjC1SCBWa6MXl1rrpgruBf+W8FJbZ7fhH9a2jBB1IktkpYh6FWP1R4lp8QnNAnRUs
	 4RYpvvLRCQVC5Hh5uHphlc3VIH9y+RStftRzb04OjVInYANQ4Is4EcRJ0l2JqF6D14
	 z1OWMq9YjtzH6QgsSyYnX9uIqxAtFDJLFCPUNzaDVSTq7EmssYTPEIZPKveBvDSKZz
	 VYLXgCq2rzqI1tGklWr1oLHJeekRljyQz43ALfudP9nF3/TIS73Hmh0btBX7k6+QFG
	 9HRAm57PGW0lQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Adam Young <admiyo@os.amperecomputing.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Sasha Levin <sashal@kernel.org>,
	robert.moore@intel.com,
	rafael.j.wysocki@intel.com,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: [PATCH AUTOSEL 6.12 36/36] mailbox: pcc: Check before sending MCTP PCC response ACK
Date: Wed,  4 Dec 2024 10:45:52 -0500
Message-ID: <20241204154626.2211476-36-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241204154626.2211476-1-sashal@kernel.org>
References: <20241204154626.2211476-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.1
Content-Transfer-Encoding: 8bit

From: Adam Young <admiyo@os.amperecomputing.com>

[ Upstream commit 7f9e19f207be0c534d517d65e01417ba968cdd34 ]

Type 4 PCC channels have an option to send back a response
to the platform when they are done processing the request.
The flag to indicate whether or not to respond is inside
the message body, and thus is not available to the pcc
mailbox.

If the flag is not set, still set command completion
bit after processing message.

In order to read the flag, this patch maps the shared
buffer to virtual memory. To avoid duplication of mapping
the shared buffer is then made available to be used by
the driver that uses the mailbox.

Signed-off-by: Adam Young <admiyo@os.amperecomputing.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Jassi Brar <jassisinghbrar@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mailbox/pcc.c | 61 +++++++++++++++++++++++++++++++++++++------
 include/acpi/pcc.h    |  7 +++++
 2 files changed, 60 insertions(+), 8 deletions(-)

diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
index 94885e411085a..82102a4c5d688 100644
--- a/drivers/mailbox/pcc.c
+++ b/drivers/mailbox/pcc.c
@@ -269,6 +269,35 @@ static bool pcc_mbox_cmd_complete_check(struct pcc_chan_info *pchan)
 	return !!val;
 }
 
+static void check_and_ack(struct pcc_chan_info *pchan, struct mbox_chan *chan)
+{
+	struct acpi_pcct_ext_pcc_shared_memory pcc_hdr;
+
+	if (pchan->type != ACPI_PCCT_TYPE_EXT_PCC_SLAVE_SUBSPACE)
+		return;
+	/* If the memory region has not been mapped, we cannot
+	 * determine if we need to send the message, but we still
+	 * need to set the cmd_update flag before returning.
+	 */
+	if (pchan->chan.shmem == NULL) {
+		pcc_chan_reg_read_modify_write(&pchan->cmd_update);
+		return;
+	}
+	memcpy_fromio(&pcc_hdr, pchan->chan.shmem,
+		      sizeof(struct acpi_pcct_ext_pcc_shared_memory));
+	/*
+	 * The PCC slave subspace channel needs to set the command complete bit
+	 * after processing message. If the PCC_ACK_FLAG is set, it should also
+	 * ring the doorbell.
+	 *
+	 * The PCC master subspace channel clears chan_in_use to free channel.
+	 */
+	if (le32_to_cpup(&pcc_hdr.flags) & PCC_ACK_FLAG_MASK)
+		pcc_send_data(chan, NULL);
+	else
+		pcc_chan_reg_read_modify_write(&pchan->cmd_update);
+}
+
 /**
  * pcc_mbox_irq - PCC mailbox interrupt handler
  * @irq:	interrupt number
@@ -306,14 +335,7 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
 
 	mbox_chan_received_data(chan, NULL);
 
-	/*
-	 * The PCC slave subspace channel needs to set the command complete bit
-	 * and ring doorbell after processing message.
-	 *
-	 * The PCC master subspace channel clears chan_in_use to free channel.
-	 */
-	if (pchan->type == ACPI_PCCT_TYPE_EXT_PCC_SLAVE_SUBSPACE)
-		pcc_send_data(chan, NULL);
+	check_and_ack(pchan, chan);
 	pchan->chan_in_use = false;
 
 	return IRQ_HANDLED;
@@ -365,14 +387,37 @@ EXPORT_SYMBOL_GPL(pcc_mbox_request_channel);
 void pcc_mbox_free_channel(struct pcc_mbox_chan *pchan)
 {
 	struct mbox_chan *chan = pchan->mchan;
+	struct pcc_chan_info *pchan_info;
+	struct pcc_mbox_chan *pcc_mbox_chan;
 
 	if (!chan || !chan->cl)
 		return;
+	pchan_info = chan->con_priv;
+	pcc_mbox_chan = &pchan_info->chan;
+	if (pcc_mbox_chan->shmem) {
+		iounmap(pcc_mbox_chan->shmem);
+		pcc_mbox_chan->shmem = NULL;
+	}
 
 	mbox_free_channel(chan);
 }
 EXPORT_SYMBOL_GPL(pcc_mbox_free_channel);
 
+int pcc_mbox_ioremap(struct mbox_chan *chan)
+{
+	struct pcc_chan_info *pchan_info;
+	struct pcc_mbox_chan *pcc_mbox_chan;
+
+	if (!chan || !chan->cl)
+		return -1;
+	pchan_info = chan->con_priv;
+	pcc_mbox_chan = &pchan_info->chan;
+	pcc_mbox_chan->shmem = ioremap(pcc_mbox_chan->shmem_base_addr,
+				       pcc_mbox_chan->shmem_size);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pcc_mbox_ioremap);
+
 /**
  * pcc_send_data - Called from Mailbox Controller code. Used
  *		here only to ring the channel doorbell. The PCC client
diff --git a/include/acpi/pcc.h b/include/acpi/pcc.h
index 9b373d172a776..699c1a37b8e78 100644
--- a/include/acpi/pcc.h
+++ b/include/acpi/pcc.h
@@ -12,6 +12,7 @@
 struct pcc_mbox_chan {
 	struct mbox_chan *mchan;
 	u64 shmem_base_addr;
+	void __iomem *shmem;
 	u64 shmem_size;
 	u32 latency;
 	u32 max_access_rate;
@@ -31,11 +32,13 @@ struct pcc_mbox_chan {
 #define PCC_CMD_COMPLETION_NOTIFY	BIT(0)
 
 #define MAX_PCC_SUBSPACES	256
+#define PCC_ACK_FLAG_MASK	0x1
 
 #ifdef CONFIG_PCC
 extern struct pcc_mbox_chan *
 pcc_mbox_request_channel(struct mbox_client *cl, int subspace_id);
 extern void pcc_mbox_free_channel(struct pcc_mbox_chan *chan);
+extern int pcc_mbox_ioremap(struct mbox_chan *chan);
 #else
 static inline struct pcc_mbox_chan *
 pcc_mbox_request_channel(struct mbox_client *cl, int subspace_id)
@@ -43,6 +46,10 @@ pcc_mbox_request_channel(struct mbox_client *cl, int subspace_id)
 	return ERR_PTR(-ENODEV);
 }
 static inline void pcc_mbox_free_channel(struct pcc_mbox_chan *chan) { }
+static inline int pcc_mbox_ioremap(struct mbox_chan *chan)
+{
+	return 0;
+};
 #endif
 
 #endif /* _PCC_H */
-- 
2.43.0


