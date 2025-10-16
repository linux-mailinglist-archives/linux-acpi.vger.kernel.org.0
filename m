Return-Path: <linux-acpi+bounces-17836-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AD6E7BE52EB
	for <lists+linux-acpi@lfdr.de>; Thu, 16 Oct 2025 21:09:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 953A94FA18C
	for <lists+linux-acpi@lfdr.de>; Thu, 16 Oct 2025 19:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E0DE24635E;
	Thu, 16 Oct 2025 19:08:55 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E61523D7DF;
	Thu, 16 Oct 2025 19:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760641735; cv=none; b=sKHvwnI8l2qs/poR5YaKA7qk/dsnXznaTesVUEYzRR5zDymfPJkpJOIV0z+F+RsoQW37XYZzjfXPSoLLd8fAjtJl709JbHlsDpZMmIkgCgY7vo1XIS6X2e5ZiU21HtNaKggJRNdRhWWXwEZLeDAjiMPAhX8pPuPeKR2pp+SL+vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760641735; c=relaxed/simple;
	bh=V8rB88qtXmWHi5vXK1iHgPh/KZXkQFJee0Jir6Tkfxk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sKpN1t7wKpJRcxJ4kCjjhQfxoKWrjMZJLhYk2ucOYbV7stNuRUf108FWiU7uWfrdMkqvo4QRx79ei0SWXY0pSBpXVL7EnpMg2YrmEUrEOxSDNEaRIXS7Icm9OSbcsY9428MRjn+o4s4aifvbmftzjQsBj2NoO7pgWPPK0j0wRaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8595426B9;
	Thu, 16 Oct 2025 12:08:44 -0700 (PDT)
Received: from e133711.arm.com (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 26B6A3F66E;
	Thu, 16 Oct 2025 12:08:51 -0700 (PDT)
From: Sudeep Holla <sudeep.holla@arm.com>
Date: Thu, 16 Oct 2025 20:08:16 +0100
Subject: [PATCH 2/6] mailbox: pcc: Wire up ->last_tx_done() for PCC
 channels
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251016-pcc_mb_updates-v1-2-0fba69616f69@arm.com>
References: <20251016-pcc_mb_updates-v1-0-0fba69616f69@arm.com>
In-Reply-To: <20251016-pcc_mb_updates-v1-0-0fba69616f69@arm.com>
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>, 
 Adam Young <admiyo@os.amperecomputing.com>, 
 Robbie King <robbiek@xsightlabs.com>, Huisong Li <lihuisong@huawei.com>, 
 Jassi Brar <jassisinghbrar@gmail.com>, 
 Cristian Marussi <cristian.marussi@arm.com>
X-Mailer: b4 0.14.3

Some PCC users poll for completion between transfers and benefit from
the knowledge of previous Tx completion check through the mailbox
framework's ->last_tx_done() op.

Hook up the last_tx_done callback in the PCC mailbox driver so the mailbox
framework can correctly query the completion status of the last transmitted
message. This aligns PCC with other controllers that already implement such
last_tx_done status query.

No functional change unless callers use ->last_tx_done(). Normal Tx and
IRQ paths are unchanged. This change just improves synchronization and
avoids unnecessary timeouts for non-interrupt driven channels by ensuring
correct completion detection for PCC channels that don’t rely on interrupts.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/mailbox/pcc.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
index f6714c233f5a..2b690c268cf0 100644
--- a/drivers/mailbox/pcc.c
+++ b/drivers/mailbox/pcc.c
@@ -445,6 +445,13 @@ static int pcc_send_data(struct mbox_chan *chan, void *data)
 	return ret;
 }
 
+static bool pcc_last_tx_done(struct mbox_chan *chan)
+{
+	struct pcc_chan_info *pchan = chan->con_priv;
+
+	return pcc_mbox_cmd_complete_check(pchan);
+}
+
 /**
  * pcc_startup - Called from Mailbox Controller code. Used here
  *		to request the interrupt.
@@ -490,6 +497,7 @@ static const struct mbox_chan_ops pcc_chan_ops = {
 	.send_data = pcc_send_data,
 	.startup = pcc_startup,
 	.shutdown = pcc_shutdown,
+	.last_tx_done = pcc_last_tx_done,
 };
 
 /**

-- 
2.34.1


