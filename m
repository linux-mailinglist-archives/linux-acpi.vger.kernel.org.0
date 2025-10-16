Return-Path: <linux-acpi+bounces-17838-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 20AE1BE52F7
	for <lists+linux-acpi@lfdr.de>; Thu, 16 Oct 2025 21:09:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 207084FBA95
	for <lists+linux-acpi@lfdr.de>; Thu, 16 Oct 2025 19:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1A10257826;
	Thu, 16 Oct 2025 19:08:57 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0DBB24A066;
	Thu, 16 Oct 2025 19:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760641737; cv=none; b=iKIpRyf5M2jOiSFhrHGVZgSgTbTSEOR1XHnr7bTgPpClJvKZOvtCD5l+nTWfCCVSinwAdrIZHQhuiOd96Rszq1ZIW/7bWyjX563gruY2iWIHNB3pedytBGvGAyMIC1hz2QG0I7RO0ng/RBIXfKaixqRuD35C/DxoMINH4kz3kHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760641737; c=relaxed/simple;
	bh=nL/7E4Cxx/lpUPRqpCtNNr30pPpkOpZXBsHXhjwAxZ0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lrK5JbwQQwZ/7QeTszJpBPWXcgKLu4e3u+H8Iu0V9V8lkSYgjjRVAgoDkJNpOemOpXMO43ecAWqGrQ4WuW2lmY6//HeXAiFDBZsPG1TUvT9Af9lsv9U3MTyFk0GNkLClaX/HC2EQ7koLl97xlg8jEiqpZsVt9nL/PqUp+aP8Cp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BFD2A1688;
	Thu, 16 Oct 2025 12:08:47 -0700 (PDT)
Received: from e133711.arm.com (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 620F03F66E;
	Thu, 16 Oct 2025 12:08:54 -0700 (PDT)
From: Sudeep Holla <sudeep.holla@arm.com>
Date: Thu, 16 Oct 2025 20:08:18 +0100
Subject: [PATCH 4/6] mailbox: pcc: Mark Tx as complete in PCC IRQ handler
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251016-pcc_mb_updates-v1-4-0fba69616f69@arm.com>
References: <20251016-pcc_mb_updates-v1-0-0fba69616f69@arm.com>
In-Reply-To: <20251016-pcc_mb_updates-v1-0-0fba69616f69@arm.com>
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>, 
 Adam Young <admiyo@os.amperecomputing.com>, 
 Robbie King <robbiek@xsightlabs.com>, Huisong Li <lihuisong@huawei.com>, 
 Jassi Brar <jassisinghbrar@gmail.com>, 
 Cristian Marussi <cristian.marussi@arm.com>
X-Mailer: b4 0.14.3

The PCC IRQ handler clears channel-in-use and notifies clients with
mbox_chan_received_data(), but it does not explicitly mark the
transmit as complete. In IRQ completion mode this could leave Tx complete
waiters hanging or lead to generic timeouts in the mailbox core.

Invoke mbox_chan_txdone() in the IRQ path once the platform has
acknowledged the transfer so the core can wake any waiters and update
state accordingly.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/mailbox/pcc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
index 327e022973db..33bd2d05704b 100644
--- a/drivers/mailbox/pcc.c
+++ b/drivers/mailbox/pcc.c
@@ -341,6 +341,7 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
 	 */
 	pchan->chan_in_use = false;
 	mbox_chan_received_data(chan, NULL);
+	mbox_chan_txdone(chan, 0);
 
 	pcc_chan_acknowledge(pchan);
 

-- 
2.34.1


