Return-Path: <linux-acpi+bounces-12726-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73223A7B3B7
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Apr 2025 02:24:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30EFE3B55D1
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Apr 2025 00:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A652192B81;
	Fri,  4 Apr 2025 00:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Av8ifEPL"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305B5204F82;
	Fri,  4 Apr 2025 00:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743725218; cv=none; b=a+coiQAews7qDkzDLl0h1J/mO2SHYiSbHVRXCYtLM1QvKJL5KOGliJRi/V9mt+F5EaI65jXReMeOfByfvJlZtZy5uftW/DhZ2WhXSKUSyeXM1kUXCPYkS3cyLDRa6Ud4c9DUHttZQWySeJdv0IbC+zFhOUcFWmWdy6sRHKU2xAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743725218; c=relaxed/simple;
	bh=e5RyO+AZ9x3PVZLJ/XfuNStV0atV5+YiTuU4XRtK238=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N1GlQS4w8ri4AEpXukZqSKKKOhXf41m8dxNQmda/AFc/wpNy+kWRL+9OlsVlHYHLey3wrIf9FpkYO4GCp4UYfDDOUecrgfX8ruiPNDLtSe0n5JiULpEJx8FmKG8EibXGUiv0YvmkKucT6BR0wwlqvwUgoxAFC5LLOefzsyzvdPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Av8ifEPL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E0C3C4CEE3;
	Fri,  4 Apr 2025 00:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743725218;
	bh=e5RyO+AZ9x3PVZLJ/XfuNStV0atV5+YiTuU4XRtK238=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Av8ifEPL5V0miEe1dZOJpwKBz5rRPTuUTCArGPkXwLSclWLj5uvtx4nmIjKWQ4Dsv
	 IdTYWAC3gcISFzxIFC9mbw4RLHsJNxZ0tGtWWN1rVXUvnrtczS89BotbJHo9cJ1+Gy
	 7Zl0iiOBwUDPCiH5SKrQi1h7oodF/1LM8r1iItqMWIkutvlUZdKm67eD6w5SLz+QG+
	 hkMqMl+1HONlJMjk9gqQKNxjpoXi2C0K4ceZqFDOilQPGQsPdA4p1FyGDu0ZgTEjYc
	 s+PnK6CDxSGTUTgd7F+wyfC7b+k7pQ/dSO9mSF7GYnAp/b7kHdGuE/ApwZxOw4dLKi
	 8y9DI2kS2403A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Huisong Li <lihuisong@huawei.com>,
	Adam Young <admiyo@os.amperecomputing.com>,
	Robbie King <robbiek@xsightlabs.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 15/16] mailbox: pcc: Fix the possible race in updation of chan_in_use flag
Date: Thu,  3 Apr 2025 20:06:23 -0400
Message-Id: <20250404000624.2688940-15-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250404000624.2688940-1-sashal@kernel.org>
References: <20250404000624.2688940-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.85
Content-Transfer-Encoding: 8bit

From: Huisong Li <lihuisong@huawei.com>

[ Upstream commit 9779d45c749340ab461d595c1a4a664cb28f3007 ]

The function mbox_chan_received_data() calls the Rx callback of the
mailbox client driver. The callback might set chan_in_use flag from
pcc_send_data(). This flag's status determines whether the PCC channel
is in use.

However, there is a potential race condition where chan_in_use is
updated incorrectly due to concurrency between the interrupt handler
(pcc_mbox_irq()) and the command sender(pcc_send_data()).

The 'chan_in_use' flag of a channel is set to true after sending a
command. And the flag of the new command may be cleared erroneous by
the interrupt handler afer mbox_chan_received_data() returns,

As a result, the interrupt being level triggered can't be cleared in
pcc_mbox_irq() and it will be disabled after the number of handled times
exceeds the specified value. The error log is as follows:

  |  kunpeng_hccs HISI04B2:00: PCC command executed timeout!
  |  kunpeng_hccs HISI04B2:00: get port link status info failed, ret = -110
  |  irq 13: nobody cared (try booting with the "irqpoll" option)
  |  Call trace:
  |   dump_backtrace+0x0/0x210
  |   show_stack+0x1c/0x2c
  |   dump_stack+0xec/0x130
  |   __report_bad_irq+0x50/0x190
  |   note_interrupt+0x1e4/0x260
  |   handle_irq_event+0x144/0x17c
  |   handle_fasteoi_irq+0xd0/0x240
  |   __handle_domain_irq+0x80/0xf0
  |   gic_handle_irq+0x74/0x2d0
  |   el1_irq+0xbc/0x140
  |   mnt_clone_write+0x0/0x70
  |   file_update_time+0xcc/0x160
  |   fault_dirty_shared_page+0xe8/0x150
  |   do_shared_fault+0x80/0x1d0
  |   do_fault+0x118/0x1a4
  |   handle_pte_fault+0x154/0x230
  |   __handle_mm_fault+0x1ac/0x390
  |   handle_mm_fault+0xf0/0x250
  |   do_page_fault+0x184/0x454
  |   do_translation_fault+0xac/0xd4
  |   do_mem_abort+0x44/0xb4
  |   el0_da+0x40/0x74
  |   el0_sync_handler+0x60/0xb4
  |   el0_sync+0x168/0x180
  |  handlers:
  |   pcc_mbox_irq
  |  Disabling IRQ #13

To solve this issue, pcc_mbox_irq() must clear 'chan_in_use' flag before
the call to mbox_chan_received_data().

Tested-by: Adam Young <admiyo@os.amperecomputing.com>
Tested-by: Robbie King <robbiek@xsightlabs.com>
Signed-off-by: Huisong Li <lihuisong@huawei.com>
(sudeep.holla: Minor updates to the subject, commit message and comment)
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Jassi Brar <jassisinghbrar@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mailbox/pcc.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
index 82102a4c5d688..8fd4d0f79b090 100644
--- a/drivers/mailbox/pcc.c
+++ b/drivers/mailbox/pcc.c
@@ -333,10 +333,16 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
 	if (pcc_chan_reg_read_modify_write(&pchan->plat_irq_ack))
 		return IRQ_NONE;
 
+	/*
+	 * Clear this flag after updating interrupt ack register and just
+	 * before mbox_chan_received_data() which might call pcc_send_data()
+	 * where the flag is set again to start new transfer. This is
+	 * required to avoid any possible race in updatation of this flag.
+	 */
+	pchan->chan_in_use = false;
 	mbox_chan_received_data(chan, NULL);
 
 	check_and_ack(pchan, chan);
-	pchan->chan_in_use = false;
 
 	return IRQ_HANDLED;
 }
-- 
2.39.5


