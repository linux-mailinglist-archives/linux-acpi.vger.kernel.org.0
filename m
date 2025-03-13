Return-Path: <linux-acpi+bounces-12207-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D962A5F9EC
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Mar 2025 16:31:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0546419C351F
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Mar 2025 15:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FD7B26A0A4;
	Thu, 13 Mar 2025 15:29:25 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 779D2269D1A;
	Thu, 13 Mar 2025 15:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741879765; cv=none; b=a9/b15F4JsmnSbJz8e/ftserR6D9pXLBnfLJ8KdJfCVEP/xzyQNDFi8YlzfunpokSpCX+ED9/gpgMNDRxPFZwHfndl5NiXfs8845UdXEZzXNxwa5m11BIwONR5uB/poubszFhy2ofDgb2uIimgwsdBwLhwDKz53Xv1D7U9JhZx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741879765; c=relaxed/simple;
	bh=b506LJ/DgSFb4iMltW733r4/qI1uomV1PVxdm2q7lW0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YatbME+JAGUKm0B6PtmGPvk2L1wwE8inRIXA5jnhSsjFQK9KnfRX/c5t/1crr/89tuScJShp3I9TvupCS4JQo/4X87OQzU7nU25WFv0QvuzrYTmL2Z0Jl3CrVKwWqvtE6SoADbxXWVZuQd0IFRvThWy2LoBPsCHPQI2fYCZFlkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 90D69201B;
	Thu, 13 Mar 2025 08:29:33 -0700 (PDT)
Received: from e133711.arm.com (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1B7153F694;
	Thu, 13 Mar 2025 08:29:21 -0700 (PDT)
From: Sudeep Holla <sudeep.holla@arm.com>
Date: Thu, 13 Mar 2025 15:28:54 +0000
Subject: [PATCH v3 08/13] mailbox: pcc: Refactor and simplify
 check_and_ack()
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250313-pcc_fixes_updates-v3-8-019a4aa74d0f@arm.com>
References: <20250313-pcc_fixes_updates-v3-0-019a4aa74d0f@arm.com>
In-Reply-To: <20250313-pcc_fixes_updates-v3-0-019a4aa74d0f@arm.com>
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>, 
 Jassi Brar <jassisinghbrar@gmail.com>, Huisong Li <lihuisong@huawei.com>, 
 Adam Young <admiyo@os.amperecomputing.com>, 
 Robbie King <robbiek@xsightlabs.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3351; i=sudeep.holla@arm.com;
 h=from:subject:message-id; bh=b506LJ/DgSFb4iMltW733r4/qI1uomV1PVxdm2q7lW0=;
 b=owEBbQKS/ZANAwAIAQBBurwxfuKYAcsmYgBn0vnEIPYdszekxa1VG+nNm/5JsA5W8yNYUY2sA
 m0hIgE9GqqJAjMEAAEIAB0WIQS6ceUSBvMeskPdk+EAQbq8MX7imAUCZ9L5xAAKCRAAQbq8MX7i
 mFY7D/0S2iqoBwLbuzHGtGhKnDm9Z9IPcJ/bGeAuou9uGuKrw4coWAQy3koA7iREXd5QDK+zhMd
 ulYV6vDDAJbNdZ6FZIpwLK2PZ7c5FToSez0na1o7xPBJrDLxgwpGVBEie1ZveO4IhwpaVpZfTn0
 NDlcaOdaosolW9haWz5EdfQJusJ4GxRFIxh7d6Zh1h3F+y3mmV9rQdR65aML2sGb1qflUJhAtZZ
 yHqejholy+RHUWVXtQEKf0cJuoZQ8f+C7UBB0k9lGAZa7DxY3ZCLvV2rherUwAMNLlPPYxSnr9V
 64HPdsWA9m1gaaGK4xD7usL17VADAl+EFm8MtK70ZGg0gzi7/CDTku1ER98hgs/Z2BHNRwB+vhP
 p2x8p/W1IZcvO8NfSr3kULCFWiE8f09tZjjeVjmb1yR0zsliPukM0Hsnws/JdnLQue6BrEpEmVl
 LEoaQcp0eezXIncluwndWuqcd+1ZUfRRY2qVHhgbhQy8qs1SYhuz2zzsdIIPMSoUILnZkiPw7ui
 9HZDtFBUZuNiu9lcdek1+DpcJlSIMu5dezd1+fi4n95SJ9UguSsNk4BZ872z3QcwQuLLW1KiBBw
 OzN0hgrJFwnRklyPk12l2/C2QA9sHN19PpTqrmmD858B/BVnZsVt3UoraZpvAiVOZcT88OykN/H
 gP0UUgd1t1ofJDQ==
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

Acked-by: Huisong Li <lihuisong@huawei.com>
Tested-by: Adam Young <admiyo@os.amperecomputing.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/mailbox/pcc.c | 37 +++++++++++++------------------------
 1 file changed, 13 insertions(+), 24 deletions(-)

diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
index d6671c18750eaa7de92f49d1ec9ad97eedadec1d..f6714c233f5ab740cb43259ca9306ac6e85f5e4b 100644
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
+static void pcc_chan_acknowledge(struct pcc_chan_info *pchan)
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
@@ -353,7 +342,7 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
 	pchan->chan_in_use = false;
 	mbox_chan_received_data(chan, NULL);
 
-	check_and_ack(pchan, chan);
+	pcc_chan_acknowledge(pchan);
 
 	return IRQ_HANDLED;
 }

-- 
2.34.1


