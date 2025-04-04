Return-Path: <linux-acpi+bounces-12721-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AA4BA7B328
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Apr 2025 02:12:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78A077A7A64
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Apr 2025 00:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56CFF1A4E9E;
	Fri,  4 Apr 2025 00:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="raQwEwbr"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9161A23BC;
	Fri,  4 Apr 2025 00:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743725091; cv=none; b=T+DM/YZP/DVyh9Rr2XzjDJOcE++cHIZY2hgbarNgJXf4qNaePbt67Zot1A56+D4Zo1HqnVKLg3FwVowR5tfzovCKrVyWsftWqsKHC9Hp3TamAvub5/Umy6/pg/9/3GsufVU2HhtTMPypsusnSp9/UKpwz8GU8zU+fisD1sgVGZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743725091; c=relaxed/simple;
	bh=2LZwgFsvQiuGHzmI3VxM3i5naQvHdkOqP1v6udfxjYs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FuvDgoVhoh3fEq5cfDLh4raRU6n0jsA/2W5a74JG10AJlV01Ur9z10MQOX5KMaN81Ss4naXVj/7H2tNHmPyxPogMDg6PnrxI9NzVelW1A2w9NBbqOooX6AsSIl5gbLJbM3wAMvpHX4IW9zrp/PZUqCz7VI7wqqy3sEVjAg+1Ypw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=raQwEwbr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 136DBC4CEE9;
	Fri,  4 Apr 2025 00:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743725091;
	bh=2LZwgFsvQiuGHzmI3VxM3i5naQvHdkOqP1v6udfxjYs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=raQwEwbru9FtnRasxmw41Sn42qxQtljYr6bOwnFY/iy5UatyenLwdBNTB2oK0RyIh
	 vKwEyaTzHXVPO9dNhS4yGyYUMrxmllWLPCrCs7NghAW3YtV79c7yKdp9EfuScIFLUL
	 QK0fRctvva7Wplg3KtWJhNfUer1CdKAUYvsuCFldh7A6oB0pRNuTOBA2i2SdtVTgEl
	 x2ZBV+g6UHIIBJvzquhuZjtgWRUdloVFDdwPI+9yEGwQnETw9BohGDGHR/HNjNBK2v
	 +UYco+H3WsBEV5r7WRnFdiQKrP2uMUJhapAW2+jWMtVOt1S7y3SJkIK1yHul+hq5t7
	 ZcXbE8SNi4N0g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	Robbie King <robbiek@xsightlabs.com>,
	Huisong Li <lihuisong@huawei.com>,
	Adam Young <admiyo@os.amperecomputing.com>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 23/23] mailbox: pcc: Always clear the platform ack interrupt first
Date: Thu,  3 Apr 2025 20:04:00 -0400
Message-Id: <20250404000402.2688049-23-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250404000402.2688049-1-sashal@kernel.org>
References: <20250404000402.2688049-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14
Content-Transfer-Encoding: 8bit

From: Sudeep Holla <sudeep.holla@arm.com>

[ Upstream commit cf1338c0e02880cd235a4590eeb15e2039c873bc ]

The PCC mailbox interrupt handler (pcc_mbox_irq()) currently checks
for command completion flags and any error status before clearing the
interrupt.

The below sequence highlights an issue in the handling of PCC mailbox
interrupts, specifically when dealing with doorbell notifications and
acknowledgment between the OSPM and the platform where type3 and type4
channels are sharing the interrupt.

-------------------------------------------------------------------------
| T |       Platform Firmware         |    OSPM/Linux PCC driver        |
|---|---------------------------------|---------------------------------|
| 1 |                                 | Build message in shmem          |
| 2 |                                 | Ring Type3 chan doorbell        |
| 3 | Receives the doorbell interrupt |                                 |
| 4 | Process the message from OSPM   |                                 |
| 5 | Build response for the message  |                                 |
| 6 | Ring Platform ACK interrupt on  |                                 |
|   |  Type3 chan to OSPM             | Received the interrupt          |
| 7 | Build Notification in Type4 Chan|                                 |
| 8 |                                 | Start processing interrupt in   |
|   |                                 |  pcc_mbox_irq() handler         |
| 9 |                                 | Enter PCC handler for Type4 chan|
|10 |                                 | Check command complete cleared  |
|11 |                                 | Read the notification           |
|12 |                                 | Clear Platform ACK interrupt    |
|   | No effect from the previous step yet as the Platform ACK          |
|   |  interrupt has not yet been triggered for this channel            |
|13 | Ring Platform ACK interrupt on  |                                 |
|   | Type4 chan to OSPM              |                                 |
|14 |                                 | Enter PCC handler for Type3 chan|
|15 |                                 | Command complete is set.        |
|16 |                                 | Read the response.              |
|17 |                                 | Clear Platform ACK interrupt    |
|18 |                                 | Leave PCC handler for Type3     |
|19 |                                 | Leave pcc_mbox_irq() handler    |
|20 |                                 | Re-enter pcc_mbox_irq() handler |
|21 |                                 | Enter PCC handler for Type4 chan|
|22 |                                 | Leave PCC handler for Type4 chan|
|23 |                                 | Enter PCC handler for Type3 chan|
|24 |                                 | Leave PCC handler for Type3 chan|
|25 |                                 | Leave pcc_mbox_irq() handler    |
-------------------------------------------------------------------------

The key issue occurs when OSPM tries to acknowledge platform ack
interrupt for a notification which is ready to be read and processed
but the interrupt itself is not yet triggered by the platform.

This ineffective acknowledgment leads to an issue later in time where
the interrupt remains pending as we exit the interrupt handler without
clearing the platform ack interrupt as there is no pending response or
notification. The interrupt acknowledgment order is incorrect.

To resolve this issue, the platform acknowledgment interrupt should
always be cleared before processing the interrupt for any notifications
or response.

Reported-by: Robbie King <robbiek@xsightlabs.com>
Reviewed-by: Huisong Li <lihuisong@huawei.com>
Tested-by: Huisong Li <lihuisong@huawei.com>
Tested-by: Adam Young <admiyo@os.amperecomputing.com>
Tested-by: Robbie King <robbiek@xsightlabs.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Jassi Brar <jassisinghbrar@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mailbox/pcc.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
index 8fd4d0f79b090..f8215a8f656a4 100644
--- a/drivers/mailbox/pcc.c
+++ b/drivers/mailbox/pcc.c
@@ -313,6 +313,10 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
 	int ret;
 
 	pchan = chan->con_priv;
+
+	if (pcc_chan_reg_read_modify_write(&pchan->plat_irq_ack))
+		return IRQ_NONE;
+
 	if (pchan->type == ACPI_PCCT_TYPE_EXT_PCC_MASTER_SUBSPACE &&
 	    !pchan->chan_in_use)
 		return IRQ_NONE;
@@ -330,9 +334,6 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
 		return IRQ_NONE;
 	}
 
-	if (pcc_chan_reg_read_modify_write(&pchan->plat_irq_ack))
-		return IRQ_NONE;
-
 	/*
 	 * Clear this flag after updating interrupt ack register and just
 	 * before mbox_chan_received_data() which might call pcc_send_data()
-- 
2.39.5


