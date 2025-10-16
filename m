Return-Path: <linux-acpi+bounces-17837-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A1DCBE52F1
	for <lists+linux-acpi@lfdr.de>; Thu, 16 Oct 2025 21:09:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D30731AA0F0F
	for <lists+linux-acpi@lfdr.de>; Thu, 16 Oct 2025 19:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6462E252904;
	Thu, 16 Oct 2025 19:08:56 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2BF42405E1;
	Thu, 16 Oct 2025 19:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760641736; cv=none; b=GooTDw60VNuUU4zFBxITkLRaEZDPAXyyxnNL/b7Azs6jqdcd5qg0h7h09/N+pFdHDPsw5JmheQ5JOpewYVu2igLXdMLuD+9Jm4Tl1wa/g3kN0EiH3p3OR0Sjxt7aBluS7vvKA6MMYkq6oksXhVILjnq6gYFVzd8qbD0W6rBVH9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760641736; c=relaxed/simple;
	bh=PpaQ7BCEXv9Ro94oij7wAw/f4BpfXUSkCtsNnzFifvM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t62w4zpOvB0V+ae5NEw+Yqv9olnUj0SR1154Uy22GKPdXmfGKY9cO/3fXrCDggfSHxED/yc1I0Q9Ex/NDcFen70ZrOx51uC9cUfuuwKp1WDvhZcrtgK1uam7JkOmKh4dlpr4MDd4SluVfq6VPocQap1LjMHFBU50wVMRQXyBuj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2BD4426BA;
	Thu, 16 Oct 2025 12:08:46 -0700 (PDT)
Received: from e133711.arm.com (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BEAC03F66E;
	Thu, 16 Oct 2025 12:08:52 -0700 (PDT)
From: Sudeep Holla <sudeep.holla@arm.com>
Date: Thu, 16 Oct 2025 20:08:17 +0100
Subject: [PATCH 3/6] mailbox: pcc: Set txdone_irq/txdone_poll based on PCCT
 flags
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251016-pcc_mb_updates-v1-3-0fba69616f69@arm.com>
References: <20251016-pcc_mb_updates-v1-0-0fba69616f69@arm.com>
In-Reply-To: <20251016-pcc_mb_updates-v1-0-0fba69616f69@arm.com>
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>, 
 Adam Young <admiyo@os.amperecomputing.com>, 
 Robbie King <robbiek@xsightlabs.com>, Huisong Li <lihuisong@huawei.com>, 
 Jassi Brar <jassisinghbrar@gmail.com>, 
 Cristian Marussi <cristian.marussi@arm.com>
X-Mailer: b4 0.14.3

The PCC controller currently enables txdone via IRQ if the PCCT exposes
platform capability to generate command completion interrupt, but it
leaves txdone_poll unchanged. Make the behaviour explicit:

  - If ACPI_PCCT_DOORBELL is present, use txdone_irq and disable polling.
  - Otherwise, disable txdone_irq and fall back to txdone_poll.

Configure the PCC mailbox to use interrupt-based completion for PCC types
that signal completion via IRQ using TXDONE_BY_IRQ, and fall back to
polling for others using TXDONE_BY_POLL.

This ensures the PCC driver uses the appropriate completion mechanism
according to the PCCT table definition and makes the completion mode
unambiguous avoiding mixed signalling when the platform lacks a doorbell
flag set.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/mailbox/pcc.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
index 2b690c268cf0..327e022973db 100644
--- a/drivers/mailbox/pcc.c
+++ b/drivers/mailbox/pcc.c
@@ -791,8 +791,13 @@ static int pcc_mbox_probe(struct platform_device *pdev)
 		(unsigned long) pcct_tbl + sizeof(struct acpi_table_pcct));
 
 	acpi_pcct_tbl = (struct acpi_table_pcct *) pcct_tbl;
-	if (acpi_pcct_tbl->flags & ACPI_PCCT_DOORBELL)
+	if (acpi_pcct_tbl->flags & ACPI_PCCT_DOORBELL) {
 		pcc_mbox_ctrl->txdone_irq = true;
+		pcc_mbox_ctrl->txdone_poll = false;
+	} else {
+		pcc_mbox_ctrl->txdone_irq = false;
+		pcc_mbox_ctrl->txdone_poll = true;
+	}
 
 	for (i = 0; i < count; i++) {
 		struct pcc_chan_info *pchan = chan_info + i;

-- 
2.34.1


