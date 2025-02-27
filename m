Return-Path: <linux-acpi+bounces-11538-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB0C0A476B0
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Feb 2025 08:36:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B4F47A1BE6
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Feb 2025 07:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD3B821CFFB;
	Thu, 27 Feb 2025 07:36:19 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0921EB194;
	Thu, 27 Feb 2025 07:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740641779; cv=none; b=JxvRyT7rdjHnSwntGqlsvgxgz4HWmlmy4+LyUfpJTyUY8jdLn7S2AwDRi4UxMLsySoZ8iLUU1+TSfgCKTIZMaViakLU4J2XD9aJ3g7zzTWdXfPy5Ww/BM4/Jy6xlqEKjjnLbqwDA/CCFJCkxS/UgIKl3NwyUoxGK2iR1U7f5d7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740641779; c=relaxed/simple;
	bh=q6J1MD/XaTTNsDSjjbF3e3Wl8GO7LFMiz+NC6qOo/Z4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fuOVL3KA6W9TAz9AF47vy1xutwGfHEtME1+P8+9IVvJggJMJ7DJ8qIQFQK0kqs5OMFjOlFdCAgMqBptD2NceDk9RkpZYus/PybUMIAf6FJgLLC6jaRCe4MeVLs3ifpsZd3s+hYk8HNpyE2dNIb1FSvVV5oBWVDpQBBHK3mOCvXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Z3NNZ41BPz9w7m;
	Thu, 27 Feb 2025 15:33:02 +0800 (CST)
Received: from dggemv704-chm.china.huawei.com (unknown [10.3.19.47])
	by mail.maildlp.com (Postfix) with ESMTPS id CABFB18010B;
	Thu, 27 Feb 2025 15:36:07 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 27 Feb 2025 15:36:07 +0800
Received: from localhost.localdomain (10.28.79.22) by
 kwepemn100009.china.huawei.com (7.202.194.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 27 Feb 2025 15:36:07 +0800
From: Huisong Li <lihuisong@huawei.com>
To: <sudeep.holla@arm.com>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<jassisinghbrar@gmail.com>, <liuyonglong@huawei.com>, <lihuisong@huawei.com>
Subject: [PATCH] mailbox: pcc: Fix can't clear level interrupt of type3 in cornor case
Date: Thu, 27 Feb 2025 15:23:41 +0800
Message-ID: <20250227072341.28693-1-lihuisong@huawei.com>
X-Mailer: git-send-email 2.22.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemn100009.china.huawei.com (7.202.194.112)

The mbox_chan_received_data() will call Rx callback of mbox client driver
using type3 to set the flag of command completion. Then driver can continue
to do something like sending a new command. In this case, the rest of the
interrupt handler function may be concurrent with pcc_send_data().

The 'chan_in_use' flag of a channel is true after sending a command. And
the flag of the new command may be cleared by the running interrupt handler
in cornor case. As a result, the interrupt being level triggered can't be
cleared in pcc_mbox_irq() and it will be disabled after the number of
handled times exceeds the specified value. The error log is as follows:

[519082.811553] kunpeng_hccs HISI04B2:00: PCC command executed timeout!
[519082.828532] kunpeng_hccs HISI04B2:00: get port link status info failed, ret = -110.
[519082.833438] irq 13: nobody cared (try booting with the "irqpoll" option)
[519082.844622] CPU: 304 PID: 15206 Comm: systemd-journal Kdump: loaded Tainted: G           OE     5.10.0 #5
[519082.854959] Hardware name: To be filled by O.E.M. To be filled by O.E.M./To be filled by O.E.M., BIOS Nezha B800 V3.1.0 01/02/2024
[519082.867467] Call trace:
[519082.870709]  dump_backtrace+0x0/0x210
[519082.875145]  show_stack+0x1c/0x2c
[519082.879240]  dump_stack+0xec/0x130
[519082.883421]  __report_bad_irq+0x50/0x190
[519082.888122]  note_interrupt+0x1e4/0x260
[519082.892740]  handle_irq_event+0x144/0x17c
[519082.897519]  handle_fasteoi_irq+0xd0/0x240
[519082.902386]  __handle_domain_irq+0x80/0xf0
[519082.907255]  gic_handle_irq+0x74/0x2d0
[519082.911774]  el1_irq+0xbc/0x140
[519082.915698]  mnt_clone_write+0x0/0x70
[519082.920131]  file_update_time+0xcc/0x160
[519082.924832]  fault_dirty_shared_page+0xe8/0x150
[519082.930133]  do_shared_fault+0x80/0x1d0
[519082.934737]  do_fault+0x118/0x1a4
[519082.938821]  handle_pte_fault+0x154/0x230
[519082.943600]  __handle_mm_fault+0x1ac/0x390
[519082.948465]  handle_mm_fault+0xf0/0x250
[519082.953075]  do_page_fault+0x184/0x454
[519082.957595]  do_translation_fault+0xac/0xd4
[519082.962555]  do_mem_abort+0x44/0xb4
[519082.966817]  el0_da+0x40/0x74
[519082.970554]  el0_sync_handler+0x60/0xb4
[519082.975160]  el0_sync+0x168/0x180
[519082.979243] handlers:
[519082.982300] [<0000000039882697>] pcc_mbox_irq
[519082.987433] Disabling IRQ #13

To solve this issue, pcc_mbox_irq() clear 'chann_in_use' flag immediately
after clearing interrupt ack register.

Signed-off-by: Huisong Li <lihuisong@huawei.com>
---
 drivers/mailbox/pcc.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
index 82102a4c5d68..077ff98366cb 100644
--- a/drivers/mailbox/pcc.c
+++ b/drivers/mailbox/pcc.c
@@ -333,10 +333,20 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
 	if (pcc_chan_reg_read_modify_write(&pchan->plat_irq_ack))
 		return IRQ_NONE;
 
+	/*
+	 * The mbox_chan_received_data() will call Rx callback of mbox
+	 * client driver using type3 to set the flag of command completion.
+	 * Then driver can continue to do something like sending a new
+	 * command. In this case, the rest of the interrupt handler
+	 * function may be concurrent with pcc_send_data().
+	 * To avoid the 'chan_in_use' flag of new command being cleared by
+	 * interrupt handler, clear this flag immediately after clearing
+	 * interrupt ack register.
+	 */
+	pchan->chan_in_use = false;
 	mbox_chan_received_data(chan, NULL);
 
 	check_and_ack(pchan, chan);
-	pchan->chan_in_use = false;
 
 	return IRQ_HANDLED;
 }
-- 
2.22.0


