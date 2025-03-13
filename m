Return-Path: <linux-acpi+bounces-12202-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A647EA5F9DC
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Mar 2025 16:29:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8480A7AAF65
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Mar 2025 15:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A54BC269818;
	Thu, 13 Mar 2025 15:29:19 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2DF5269809;
	Thu, 13 Mar 2025 15:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741879759; cv=none; b=CYf/yFKdtflskTI0rBjQxznsyjLYRbhXkTMcQuM2CZ7toDNSA/Xyzgk+IrGQhhfOsY4b/IqyYRufnMAEHaGI1WmNrBD3ZkKgM31WhhHQrt+V8uEnrhBLzvQsDI4NFI+NKELXkqB3HzdCJjhqoOroegH/bTO9/6Z4yJIJGJqhh34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741879759; c=relaxed/simple;
	bh=2xOSO0qI0Yp+T224QwvCJECRbLvlQqE6m009JdNfF2E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l8wQdqe4v5RR3ga+EeGygb5K0kfaoMC5mBfRtGATfrHPNrs4BpRSKcfUEIrd9zCNFtklqYe13NETLpV8ou8/kavqGmMvSsE//urvGOsqX1VFXkQCjSPd2rbFfjzT6rWxFUZNxW3aVP0IhaLmUs1wCa0HUToZF4D0KG7BTKhp+3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BDBF31F91;
	Thu, 13 Mar 2025 08:29:24 -0700 (PDT)
Received: from e133711.arm.com (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 47D4B3F694;
	Thu, 13 Mar 2025 08:29:13 -0700 (PDT)
From: Sudeep Holla <sudeep.holla@arm.com>
Date: Thu, 13 Mar 2025 15:28:48 +0000
Subject: [PATCH v3 02/13] mailbox: pcc: Always clear the platform ack
 interrupt first
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250313-pcc_fixes_updates-v3-2-019a4aa74d0f@arm.com>
References: <20250313-pcc_fixes_updates-v3-0-019a4aa74d0f@arm.com>
In-Reply-To: <20250313-pcc_fixes_updates-v3-0-019a4aa74d0f@arm.com>
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>, 
 Jassi Brar <jassisinghbrar@gmail.com>, Huisong Li <lihuisong@huawei.com>, 
 Adam Young <admiyo@os.amperecomputing.com>, 
 Robbie King <robbiek@xsightlabs.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4871; i=sudeep.holla@arm.com;
 h=from:subject:message-id; bh=2xOSO0qI0Yp+T224QwvCJECRbLvlQqE6m009JdNfF2E=;
 b=owEBbQKS/ZANAwAIAQBBurwxfuKYAcsmYgBn0vnD5RryRhdOXd85+3gPEr7EtIgt+ZT6GkopZ
 Jd8m13K8qCJAjMEAAEIAB0WIQS6ceUSBvMeskPdk+EAQbq8MX7imAUCZ9L5wwAKCRAAQbq8MX7i
 mPtQD/4geIdurw9ljohM8myDtjvlcPJl1eHut67vvjS0nje/q7eZethsbWiYK0PiPgmT432b2in
 hgBJfPIEP/2y257zgjHaivgcdPK6vOaqLkp5hYqS9DzBZhqGinDZdJQWQfvYMSamPCWGBDfXe+F
 4pE4RzMfiRgK9lH6xZEDRJz+nMi9fhsshBggd92TUsmbF5EjmpJTtHlh5ML9oqXkT852/V6P5Py
 98qvFrztCb07t3HzYKljV12bANSo4g+2AmKfKPjQos0OwT5xfoODteeUNi4HdcuMbyuCJmRdfxT
 qTgNTISLmNlJpThIj9UVe4iCalYhU15tnMfORa1Hb0cAxtDNRNYCmKTSMRUvhSImEynHu+NKCkC
 jiWi0a9JTtl7B35X7ZL1YFyxS+gU8vjAXg8f3iGHzhFkXuFxh26H3EoB1il/4AZO2+TYhVXlcbS
 YI21YyzxSjiapTNt9/PwW0KBNg4bOUV2IGAm/JDVWWWTbdWNxuaVNiQpzN0csw2jdpZ4tYkvq2f
 X1PKmIpTBBZ3h0X10Cs69uRWSS8cBGAbnmiHLmpW1+GY7BkAMubOil3JbtcbjRPmZgJKh33Jna5
 UuAC1a+BmceqYZr+yQvKC2nm33lKoKb4/2Ec9GZQhjF7hiAefu2qpQBKBckQWjCCcB/RyKnJsnC
 Wdu5sJiJaTYd6Yg==
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
Tested-by: Huisong Li <lihuisong@huawei.com>
Tested-by: Adam Young <admiyo@os.amperecomputing.com>
Tested-by: Robbie King <robbiek@xsightlabs.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/mailbox/pcc.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
index 8fd4d0f79b090eeea1c7779061841ef507083687..f8215a8f656a460b38806d4c002470c3fe1e3c9c 100644
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
2.34.1


