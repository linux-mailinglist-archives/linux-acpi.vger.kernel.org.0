Return-Path: <linux-acpi+bounces-11799-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D61A4E768
	for <lists+linux-acpi@lfdr.de>; Tue,  4 Mar 2025 18:03:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A92D342419D
	for <lists+linux-acpi@lfdr.de>; Tue,  4 Mar 2025 16:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F22FC24EA97;
	Tue,  4 Mar 2025 16:32:28 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from beeline1.cc.itu.edu.tr (beeline1.cc.itu.edu.tr [160.75.25.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A0127CB0A
	for <linux-acpi@vger.kernel.org>; Tue,  4 Mar 2025 16:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=160.75.25.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741105948; cv=pass; b=KWicHruQZAu6JY2gKlVnIo92zTOuBCuZmpp4wx88Qq/09jvTb3mt++sP+H2bnYTDbjSoajcMk1ur95hLlTA96zB4pfw/9lkORCq9wYbDL13AkkOpYWnEf687bK1kfyKrCRqXzUTg3uL7sIdC+zEF8HcFmmDRqyOTZKTnUU13YaQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741105948; c=relaxed/simple;
	bh=ZHQsw9JxtEtWCNtTod+FBGG8c1aDXetOsMB/Gq2BJcg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z7HJv+3Ux35I6blzpd0BEw7A+gRPuLThiyYOeh1AcXxHU01yF0l/rToizrSzfVzv++172QIPb6ZztSmW0HwWPVvw0LR4lVrT7bcRqzhi9FPDbXNkjmRIku8R5VXKOYshLJ4Z8Hsa+AHbXDZjMOzSD/M5ITmr0u/J4E7/J8zaYzY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com; spf=none smtp.mailfrom=cc.itu.edu.tr; arc=none smtp.client-ip=217.140.110.172; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=pass smtp.client-ip=160.75.25.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline1.cc.itu.edu.tr (Postfix) with ESMTPS id 44D5240D573D
	for <linux-acpi@vger.kernel.org>; Tue,  4 Mar 2025 19:32:25 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6h4Q1JQfzG1pN
	for <linux-acpi@vger.kernel.org>; Tue,  4 Mar 2025 19:30:30 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 8BF344272F; Tue,  4 Mar 2025 19:30:25 +0300 (+03)
X-Envelope-From: <linux-kernel+bounces-541450-bozkiru=itu.edu.tr@vger.kernel.org>
Received: from fgw2.itu.edu.tr (fgw2.itu.edu.tr [160.75.25.104])
	by le2 (Postfix) with ESMTP id D896D42E93
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 13:57:01 +0300 (+03)
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by fgw2.itu.edu.tr (Postfix) with SMTP id AE2342DCDE
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 13:57:01 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BC0918960FE
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 10:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D6CE1F891D;
	Mon,  3 Mar 2025 10:53:40 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AC471F76A8;
	Mon,  3 Mar 2025 10:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740999218; cv=none; b=vEYFZ2BEpUWq4THomZMVQmGx4bA/XWgOZPmdvJryl8co0j4CL79vSC6gNfeIZ0uDMzzBG3GqDcDG7unxGRCqbd4RU3eQNMsgKYGUz97UmgZs6TqcYuWZ6W09w/uoEb5nMLc8lGR082cSm0ARMzWw/fJS2b9bdsT3ojSiSIOyj6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740999218; c=relaxed/simple;
	bh=ZHQsw9JxtEtWCNtTod+FBGG8c1aDXetOsMB/Gq2BJcg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZE89FdAb8lc0lPtRgtRXlB25QRO+JzFYQVCRRttYQIsgDCL6rLWDZ+WezuAHgtyIsfoqaMXj9pdHFRbtSfc/uVwBnJo/uMgzxAuO5dXbx7m5jCwQYlkDkYEv7JjwP7tgyAtu7WfDIKFtesTlMgXO7UUVSDwoAYMH9qA3TWuXrRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0F20012FC;
	Mon,  3 Mar 2025 02:53:51 -0800 (PST)
Received: from e133711.arm.com (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E749E3F673;
	Mon,  3 Mar 2025 02:53:35 -0800 (PST)
From: Sudeep Holla <sudeep.holla@arm.com>
Date: Mon, 03 Mar 2025 10:51:44 +0000
Subject: [PATCH 09/14] mailbox: pcc: Refactor and simplify check_and_ack()
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250303-pcc_fixes_updates-v1-9-3b44f3d134b1@arm.com>
References: <20250303-pcc_fixes_updates-v1-0-3b44f3d134b1@arm.com>
In-Reply-To: <20250303-pcc_fixes_updates-v1-0-3b44f3d134b1@arm.com>
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>, 
 Jassi Brar <jassisinghbrar@gmail.com>, Huisong Li <lihuisong@huawei.com>, 
 Adam Young <admiyo@os.amperecomputing.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3243; i=sudeep.holla@arm.com;
 h=from:subject:message-id; bh=ZHQsw9JxtEtWCNtTod+FBGG8c1aDXetOsMB/Gq2BJcg=;
 b=owEBbQKS/ZANAwAIAQBBurwxfuKYAcsmYgBnxYoiRklIW0oglv683T42D8WPodP5k/f1q9Eff
 bTWohLZyPSJAjMEAAEIAB0WIQS6ceUSBvMeskPdk+EAQbq8MX7imAUCZ8WKIgAKCRAAQbq8MX7i
 mLeIEADUI/vKVRKk1CquSAGR2zhz9eRH/k7AjwBgDLyr/beQc/92U8vdcykP/NlpdhC9qGerAdO
 iksgfayzpUE0R8K4Tk7unsvk3TvCVY8cw0BAnrA4dILaKRxqlMBTRCShB+UzdO9JyBSYMd7ctbA
 93aKKmjf0310RSYH1Znf7KrPTZf+FuGZrd5THdq2pT5fYuhw4YT+/RiUvUxccuTGmyDJfYky2Hz
 4yqxyL4301KTqUKh0kMn/WFwQBMvpIVFTMopuRLdoQfrW93SpPmJmZeETA+WROwaTV1iVqin1yg
 CJyZgYIBVfyytVz3xch0YOdYYP0yKOSoeGkYt2BvyXG+u4zspD1Gf5Z74Q6E//j7so15Bsc6flJ
 F0omSfAlWhDqDYUS9gjOGTLyCrM61mv2hIRNpwtYE85t/Q4vceQQoSPZdQKH5lf4UMoPXdbD1Rq
 QKhHXQ0iUDFYKN9/HEBTtfo51nAQgPgrvqUNuve+a2KOginyGtrAbMsM2YIFzRwPMRmqhd9T4Pg
 4/YVSWjObUUy7gG/KGfiW38pz/23u4sqyQkSWY7ZYGIQMDCXrCQzL4eIo5lRP6UD5DEz3eKEEER
 tDh/pkj1bEj/KBFf4QWWpju2LwQr8r+v32nXJvLjydL9Z3h7rxcd/rGGEzMyllPoz2dHwogBJ+m
 0uxUQ+n1q+ANsGA==
X-Developer-Key: i=sudeep.holla@arm.com; a=openpgp;
 fpr=7360A21742ADF5A11767C1C139CFD4755FE2D5B4
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6h4Q1JQfzG1pN
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741710632.00532@YWPtbdHzp/kZbBos1vJ28A
X-ITU-MailScanner-SpamCheck: not spam

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
 drivers/mailbox/pcc.c | 38 ++++++++++++++------------------------
 1 file changed, 14 insertions(+), 24 deletions(-)

diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
index 5f2e2b727d99f07c44e87e44c11ba0aefe3a2318..17500d4122af3194011eb47bc91efa4317cd8a32 100644
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
@@ -288,33 +286,25 @@ static int pcc_mbox_error_check_and_clear(struct pcc_chan_info *pchan)
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
-	if (pcc_hdr.flags & PCC_ACK_FLAG_MASK)
-		pcc_send_data(chan, NULL);
-	else
-		pcc_chan_reg_read_modify_write(&pchan->cmd_update);
+	if (ioread32(&pcc_hdr->flags) & PCC_ACK_FLAG_MASK)
+		pcc_chan_reg_read_modify_write(&pchan->db);
+
 }
 
 /**
@@ -352,7 +342,7 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
 	pchan->chan_in_use = false;
 	mbox_chan_received_data(chan, NULL);
 
-	check_and_ack(pchan, chan);
+	pcc_chan_check_and_ack(pchan);
 
 	return IRQ_HANDLED;
 }

-- 
2.34.1



