Return-Path: <linux-acpi+bounces-11791-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC796A4E5F8
	for <lists+linux-acpi@lfdr.de>; Tue,  4 Mar 2025 17:32:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3B3919C72CB
	for <lists+linux-acpi@lfdr.de>; Tue,  4 Mar 2025 16:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85957291FBF;
	Tue,  4 Mar 2025 16:02:43 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from beeline3.cc.itu.edu.tr (beeline3.cc.itu.edu.tr [160.75.25.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD4F2673BA
	for <linux-acpi@vger.kernel.org>; Tue,  4 Mar 2025 16:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=160.75.25.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741104163; cv=pass; b=aAV989qGdEuRFiprUSPlfBGd67pAVNjwLyySP+cS+xrEeDZoSeiMadRJN6UuWjMcNONeiOs81Rj4HYbqPzUaNjQb6Ltb2H9eQEAQI62Nc5Nx00ENFsEeXgL4CAjCKKmHIvvvmQXv7FOlkmR5QYtbUdPFKhJKQlK9tUK3NzyUUuI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741104163; c=relaxed/simple;
	bh=hI4KFNGqi6KDUZUIDZyqHSLYmiqQIHbxM+e+qaBmu6M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Yfvj/ExHm0HEG0m/cmtefq2KPwMsXbK3FW95eOPOp8ITwfi8ziLfuTbBYxHW4eM5rOUIbzcK3BMIJ6raiCpy5gBX0PWbQh9GGr0E0c2mfWVJ+Z4UIvi/uy6nkHhVqfpK12qfHEMXBxy0zP5NGqyFeldsZPdeQT046GwWSw9SUR4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com; spf=none smtp.mailfrom=cc.itu.edu.tr; arc=none smtp.client-ip=217.140.110.172; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=pass smtp.client-ip=160.75.25.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline3.cc.itu.edu.tr (Postfix) with ESMTPS id 27DED40CECAB
	for <linux-acpi@vger.kernel.org>; Tue,  4 Mar 2025 19:02:40 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6gR71xtlzG1pG
	for <linux-acpi@vger.kernel.org>; Tue,  4 Mar 2025 19:01:39 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id AE8904272B; Tue,  4 Mar 2025 19:01:27 +0300 (+03)
X-Envelope-From: <linux-kernel+bounces-541446-bozkiru=itu.edu.tr@vger.kernel.org>
Received: from fgw1.itu.edu.tr (fgw1.itu.edu.tr [160.75.25.103])
	by le2 (Postfix) with ESMTP id AA22842D9B
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 13:56:50 +0300 (+03)
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by fgw1.itu.edu.tr (Postfix) with SMTP id 401D93064C07
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 13:56:50 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64D163B1675
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 10:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A3191F7545;
	Mon,  3 Mar 2025 10:53:36 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 353051F5424;
	Mon,  3 Mar 2025 10:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740999214; cv=none; b=RG//Cg3cj0CICpAZ6CzBG6cK4p6lClHy+2z4C0odWS05V44XugGqjGlnO1WshyaSlkBpnQG89fJrdek2RfflmJCLC+uoud/AO3NSIGfr6/pL0T1b7T9rxjfCad2hW35TKjG3iTrtBywaW2vdbIXqgYedj2RafoC0+tqL3mj4bZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740999214; c=relaxed/simple;
	bh=hI4KFNGqi6KDUZUIDZyqHSLYmiqQIHbxM+e+qaBmu6M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZcIIq876/hSNIIcdHxrTSkMnNyvZwKUZ6to84iTpdLPkl0wCNpfGWB9nLNzZG3l8Clj0cYBhXjm/y+UU0egEclPvBBmLydhiOaHflG9Gi7Ar3j9dZmFsp2CiWHwvqbhoWUWYBqqmjCxp8NwBdmv0ErWXE3BxWDGGtxrnFEWLzg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1A7FB202C;
	Mon,  3 Mar 2025 02:53:47 -0800 (PST)
Received: from e133711.arm.com (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F2D223F673;
	Mon,  3 Mar 2025 02:53:31 -0800 (PST)
From: Sudeep Holla <sudeep.holla@arm.com>
Date: Mon, 03 Mar 2025 10:51:41 +0000
Subject: [PATCH 06/14] mailbox: pcc: Refactor error handling in irq handler
 into separate function
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250303-pcc_fixes_updates-v1-6-3b44f3d134b1@arm.com>
References: <20250303-pcc_fixes_updates-v1-0-3b44f3d134b1@arm.com>
In-Reply-To: <20250303-pcc_fixes_updates-v1-0-3b44f3d134b1@arm.com>
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>, 
 Jassi Brar <jassisinghbrar@gmail.com>, Huisong Li <lihuisong@huawei.com>, 
 Adam Young <admiyo@os.amperecomputing.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2269; i=sudeep.holla@arm.com;
 h=from:subject:message-id; bh=hI4KFNGqi6KDUZUIDZyqHSLYmiqQIHbxM+e+qaBmu6M=;
 b=owEBbQKS/ZANAwAIAQBBurwxfuKYAcsmYgBnxYohtMjw/FViW2/BmGmcZM6r2Ctg0hMbgjmJp
 lWUQ+GR7emJAjMEAAEIAB0WIQS6ceUSBvMeskPdk+EAQbq8MX7imAUCZ8WKIQAKCRAAQbq8MX7i
 mEJBEADBTxKSEQ8UnGWF5bl9tmRpwqAHrj63Pn/Ls2i/ZdUdyRFDmHIFg0MQpbxP24Fx2zJ0wyh
 P8KG8InGCuT9AVXf4Mq8+AUNoe5guBi3OfD0j7ssyz5QZybfg40MU1qIk7MZ+7c8gjbZIm34ZWP
 OXUuPLoQ3V5NjH6uqOXS7Rnq7Wtte+l/6dXayvuZH/Zs4DMEhAmuqG+0lh5EcWQ1maNGlDZJiJl
 kK5Uikz/t2eU4rEW2jhF6fMlo8Icu/oB849BBUey3RyCi1yRG2QUCC4nvnkDEXQkw858jmwq+YT
 7oIC5hyz749QjpUc2308OWNUr1aZsslTXJx6ccoDsQVoP634/lEve4AnKRCqLx59J8c/mPcq7Cd
 5z5CoIcDo1VPzLdTKnnPWQ0n66iqiqmCLWAgEJRkKi+h3UanlPTeKBKmlqOAglWtgg5f3rgfxOH
 hcb3HBDv1DKGcXua83DPyoAIpq5mtsyqGramMBR016iaiwdnmiLJFObIjhKBuVb7VvLJZlZ2Xkv
 tA+Q9OTF/d/NGhLD6hcSyBF5/BdWwca6nhMNFGRIEUZ+bj6eB2n5eCyxVAn63SgxNoykLMn2nS7
 PVqgdaV/vxfaxNHHLHpW0S51Lh9+hjeFZaOSYmDDLP2QFNUBJm+x5b9g73W6T6P8FSr3GNZ9b3m
 ZEOAreGcddvjsww==
X-Developer-Key: i=sudeep.holla@arm.com; a=openpgp;
 fpr=7360A21742ADF5A11767C1C139CFD4755FE2D5B4
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6gR71xtlzG1pG
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741708900.02839@fdHYs5fkzC3V8Edp5Y0MzQ
X-ITU-MailScanner-SpamCheck: not spam

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
index a0fdafc3ef71d20c73ff58ef065201e6dc911396..e693675ce1fbd8d01d0640b3053a5c1882bdbce7 100644
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
+	if (!pcc_mbox_error_check_and_clear(pchan))
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



