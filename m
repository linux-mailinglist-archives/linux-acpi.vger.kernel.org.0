Return-Path: <linux-acpi+bounces-11846-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22EEDA50555
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Mar 2025 17:42:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78F7816A661
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Mar 2025 16:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2610D253B6D;
	Wed,  5 Mar 2025 16:39:09 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79DF8253B49;
	Wed,  5 Mar 2025 16:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741192749; cv=none; b=gJWIf7uelM11HNHvHR1ju0Gn/dMia2JOKSq4F7PXcleZO9FWquHR1S+8RjiFyj0ZAba45qps96wsyQBXeRjpZIF8j7y/xVwbs/FFjSXKd9eEODRhwFnL2ASAixrq6JFR2ZzLKcUIaUC4EsBAeSe8mXX2Tp65n1O6nCZvf53lA/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741192749; c=relaxed/simple;
	bh=DRH/HW8c1VcvGJoJWUjrx/wudPtyFYzck+Lc7GivUvQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LU4QKE6nfNq6f9nYkBLiYRDZ3vJ5UcIjYI62v4+mVa5Ug+fs65sSKhCUxABZNEbGDvPXprcGO1mI71/rYKp5ZlDJT44cVjh6toUMjLCPKoWw6uTNPi6pGAe7orG/M7lFoJoe0y6EYqj2WY8qAPrP7CDoVCVISBfCtBK4k7zeo0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 86EF41007;
	Wed,  5 Mar 2025 08:39:20 -0800 (PST)
Received: from e133711.arm.com (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 11C273F5A1;
	Wed,  5 Mar 2025 08:39:05 -0800 (PST)
From: Sudeep Holla <sudeep.holla@arm.com>
Date: Wed, 05 Mar 2025 16:38:10 +0000
Subject: [PATCH v2 06/13] mailbox: pcc: Refactor error handling in irq
 handler into separate function
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250305-pcc_fixes_updates-v2-6-1b1822bc8746@arm.com>
References: <20250305-pcc_fixes_updates-v2-0-1b1822bc8746@arm.com>
In-Reply-To: <20250305-pcc_fixes_updates-v2-0-1b1822bc8746@arm.com>
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>, 
 Jassi Brar <jassisinghbrar@gmail.com>, Huisong Li <lihuisong@huawei.com>, 
 Adam Young <admiyo@os.amperecomputing.com>, 
 Robbie King <robbiek@xsightlabs.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2268; i=sudeep.holla@arm.com;
 h=from:subject:message-id; bh=DRH/HW8c1VcvGJoJWUjrx/wudPtyFYzck+Lc7GivUvQ=;
 b=owEBbQKS/ZANAwAIAQBBurwxfuKYAcsmYgBnyH4fjyyoihzv7P4evKi/PgcHENfIFGeNed1Gr
 /CjennMOqiJAjMEAAEIAB0WIQS6ceUSBvMeskPdk+EAQbq8MX7imAUCZ8h+HwAKCRAAQbq8MX7i
 mK6jEACzRTSrhQCUszDp1kapXWaARXGrfjmx0KApmsHP3mK3i3nlpb+eElzqp+x2/6JRjPeaIH/
 f/e2Gi376ZE6Hotqd1jIfHQX+DiAesxRBwYfyDn/49owNtgemmA2ZfbG94PhXka5FhhBNpiqsbG
 WxCJJ43ma5gJ3Dig9RWO4cQ0CM47smuCeUauAcfX5D7jE5EEn1zJ+NE49oBOP14ipzOjbjSkbrM
 nkTHz8lprh2PRvWNLuF0BlIaRTDO5t0XifUtFSuV2sb7UtvjjediRT2RPyqqsZqeNRTNYPrXKgt
 L6rZiOhhxJ70BkCdSRgaNrZXhWkMMPx9fA2G52Z1+ufSEe8MB6XuwsZaMU2x+k6KcR9u4r5q/3A
 wgGUXW1fej4hAMlNd5jtHXT27He5hSNE1j7di+mSWVyVByb93pzLB6CD78ZLsdXjrO53pxHq+OV
 5vxm2UUjEd9PsUupiPRfSyNoniGmsUGwCXz1GpNXu8OhQ7G1KwQtf14GNDjPwgPBqvIcDP3nChj
 WdP0squIfDC13q77ogsPkw+ifKANTxPdL0nWRHY7S1vaON2ZjkSZMisjtKAGa/oTCv2lP80dk+E
 fFPrGk3ro3a1VN3FXB9np+WC63rYU8rB35crRyx38pio7iS90u8p6Myh7MGiRZiomQZEW8GjVLt
 KJ2lWBQKEiCNTqw==
X-Developer-Key: i=sudeep.holla@arm.com; a=openpgp;
 fpr=7360A21742ADF5A11767C1C139CFD4755FE2D5B4

The existing error handling logic in pcc_mbox_irq() is intermixed with the
main flow of the function. The command complete check and the complete
complete update/acknowledgment are nicely factored into separate functions.

Moves error detection and clearing logic into a separate function called:
pcc_mbox_error_check_and_clear() by extracting error-handling logic from
pcc_mbox_irq().

This ensures error checking and clearing are handled separately and it
improves maintainability by keeping the IRQ handler focused on processing
events.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/mailbox/pcc.c | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
index b1b8223b5da7002fc522523dbc82f6124215439a..41bd14851216e8c4f03052c81aaf938a5e5c5343 100644
--- a/drivers/mailbox/pcc.c
+++ b/drivers/mailbox/pcc.c
@@ -269,6 +269,25 @@ static bool pcc_mbox_cmd_complete_check(struct pcc_chan_info *pchan)
 	return !!val;
 }
 
+static int pcc_mbox_error_check_and_clear(struct pcc_chan_info *pchan)
+{
+	u64 val;
+	int ret;
+
+	ret = pcc_chan_reg_read(&pchan->error, &val);
+	if (ret)
+		return ret;
+
+	val &= pchan->error.status_mask;
+	if (val) {
+		val &= ~pchan->error.status_mask;
+		pcc_chan_reg_write(&pchan->error, val);
+		return -EIO;
+	}
+
+	return 0;
+}
+
 static void check_and_ack(struct pcc_chan_info *pchan, struct mbox_chan *chan)
 {
 	struct acpi_pcct_ext_pcc_shared_memory pcc_hdr;
@@ -309,8 +328,6 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
 {
 	struct pcc_chan_info *pchan;
 	struct mbox_chan *chan = p;
-	u64 val;
-	int ret;
 
 	pchan = chan->con_priv;
 
@@ -324,15 +341,8 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
 	if (!pcc_mbox_cmd_complete_check(pchan))
 		return IRQ_NONE;
 
-	ret = pcc_chan_reg_read(&pchan->error, &val);
-	if (ret)
+	if (pcc_mbox_error_check_and_clear(pchan))
 		return IRQ_NONE;
-	val &= pchan->error.status_mask;
-	if (val) {
-		val &= ~pchan->error.status_mask;
-		pcc_chan_reg_write(&pchan->error, val);
-		return IRQ_NONE;
-	}
 
 	/*
 	 * Clear this flag immediately after updating interrupt ack register

-- 
2.34.1


