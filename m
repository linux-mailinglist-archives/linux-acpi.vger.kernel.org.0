Return-Path: <linux-acpi+bounces-11842-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 213C9A50554
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Mar 2025 17:42:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 522483AA73F
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Mar 2025 16:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD0631ACEAD;
	Wed,  5 Mar 2025 16:39:03 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0633419DF41;
	Wed,  5 Mar 2025 16:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741192743; cv=none; b=FcT7rHgCKk0mPZVybyz9Z1ZiyKqMFQ0gVKVq/X9vURMUKkQGHLscS0cB0x048c5nsajjc6UOh2QaN6DKcRh/E9HpPBlqlJ+LeymBN07CpyK7Y2NUuFBh6Jwdk5IbAAjpfIvEE1CG3gUYN0Bi2omQ+bTzjgLM+uQ/6YHeQgzreVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741192743; c=relaxed/simple;
	bh=s7B+ahRe/ZrUp9puXvR0Xlhm02ueQhd2vnuyBhYBT4w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LlHviubIpTMNv/F1FozlrTWm/kbeoBzHvU8cC6OLs4NmzguW8J06qP0LYjNE5HbuOHPD8jdWPSXN1dloPCbqalRLVXvTQOYI9hOFVn+Ie948kfksgr5l5IKZWHbeucE1a3nlNxttKKSb8RWTKJ43FrQ9kMHJ+EUAanc5rVgw5cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 98BD71713;
	Wed,  5 Mar 2025 08:39:14 -0800 (PST)
Received: from e133711.arm.com (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 30E5D3F5A1;
	Wed,  5 Mar 2025 08:39:00 -0800 (PST)
From: Sudeep Holla <sudeep.holla@arm.com>
Date: Wed, 05 Mar 2025 16:38:06 +0000
Subject: [PATCH v2 02/13] mailbox: pcc: Always clear the platform ack
 interrupt first
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250305-pcc_fixes_updates-v2-2-1b1822bc8746@arm.com>
References: <20250305-pcc_fixes_updates-v2-0-1b1822bc8746@arm.com>
In-Reply-To: <20250305-pcc_fixes_updates-v2-0-1b1822bc8746@arm.com>
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>, 
 Jassi Brar <jassisinghbrar@gmail.com>, Huisong Li <lihuisong@huawei.com>, 
 Adam Young <admiyo@os.amperecomputing.com>, 
 Robbie King <robbiek@xsightlabs.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4712; i=sudeep.holla@arm.com;
 h=from:subject:message-id; bh=s7B+ahRe/ZrUp9puXvR0Xlhm02ueQhd2vnuyBhYBT4w=;
 b=owEBbQKS/ZANAwAIAQBBurwxfuKYAcsmYgBnyH4evRpTuF123iDB5y1GdK8xJsTkhVLbO8sOs
 elKveJw+bCJAjMEAAEIAB0WIQS6ceUSBvMeskPdk+EAQbq8MX7imAUCZ8h+HgAKCRAAQbq8MX7i
 mMEUD/4v/Fp6tmnX9I4A+awLnmgk/+qqIyGlVhtZXOES/xK+wN8lvCA4no+Ps6QtQS6Fl3TS+x8
 kUrJ14afbjXnFMxGVc5CtK1YWSc/BX0rmnFcLjMklXW9IrMtvyUp7+C5Hn/utLRYX80jYdZl2Jo
 Qovsk7zuDAu0VKOCCNj3MSlwgCI1nHL4+VgnedCsE4OXnMozOkcfStmwfNUSVM1zp5HJMvuKGwF
 spIIL/q4SSvx5dP5zgnMjD/qQXjILNBegkRkPKiF8FGN8Vak8Y85lnizthprAVE5KzKIRwSxY8t
 ikAxbQ1feq/lEtmWGLPMNx1Gxht00FeuPYTrivtPhmzBWBPk8udmHQ2YPRV+4qmycPYA4I1p/wP
 jKnwqK12aG1QlOHUu4LyvLZ/GlNZsl9TCHmHMPdPQdRsFcry8vTlRtHyr0xCkD2YB8E/oVXOJFc
 yXk5/6dvH6zhywCAnH+guEbvD9drm0kgxQkB9IH7Q44s6xLqNFpUqo9q51FXmscpmpHKbWSlaGd
 J1PEroS5Btmo9VT7Gr2GF7OP2V4CjYshruEDtD4ARw0yunTSpIyPLww6+Qd5lk/HJKhfMJpfzFm
 fLfyNEwSWkIa4GDpfXnE7gbShsNW7x86fAskXIEelRGZ6sWpEJpYGqFtrYixxr1zR2ZSzM2rZDn
 RclVZYZZPtvXABg==
X-Developer-Key: i=sudeep.holla@arm.com; a=openpgp;
 fpr=7360A21742ADF5A11767C1C139CFD4755FE2D5B4

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
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/mailbox/pcc.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
index f2e4087281c70eeb5b9b33371596613a371dff4f..4c582fa2b8bf4c9a9368dba8220f567555dba963 100644
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
 	 * Clear this flag immediately after updating interrupt ack register
 	 * to avoid possible race in updatation of the flag from

-- 
2.34.1


