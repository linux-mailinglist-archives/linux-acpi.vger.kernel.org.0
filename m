Return-Path: <linux-acpi+bounces-11841-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F050A5054E
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Mar 2025 17:41:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C2123A0F76
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Mar 2025 16:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F9511A5B8F;
	Wed,  5 Mar 2025 16:39:02 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 984DA191F66;
	Wed,  5 Mar 2025 16:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741192742; cv=none; b=JTG+tEY4KIF7TXz1vz2HZitkEWgxWvX14uMz2g383GpBwDo4zjyS/7X7tj7YF0I7BiLnmlw1nevVM9l8o/sbq0KVfWTvSi4c1qKzMZkVgrXdrMXBzro+oG2FM5a9iq0GxngSi/SaciasvsmamK7di1ti2AoRxPU3LZGD3kswq/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741192742; c=relaxed/simple;
	bh=g9voXRH9b5scUtRJQUT9IkYk1Q1woAlbAN5ZVwPOsw0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Fg7iJndJEgQnpmhqRKt/aHrF6ZppVUHH92u8a9FuvrsdAOswGhSyEEeZvgH/SkIEuEHTxH+MxP37Us0OBD9vBYFbZyBrzuQZ/+2BtRwWdoPGwHwC0JElQTPFs4u3rC02cer+8Nczvl1c6E3n5U2Uam3QooBQnNdT7IeDnTQgGFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 266831007;
	Wed,  5 Mar 2025 08:39:13 -0800 (PST)
Received: from e133711.arm.com (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B2C653F5A1;
	Wed,  5 Mar 2025 08:38:58 -0800 (PST)
From: Sudeep Holla <sudeep.holla@arm.com>
Date: Wed, 05 Mar 2025 16:38:05 +0000
Subject: [PATCH v2 01/13] mailbox: pcc: Fix the possible race in updation
 of chan_in_use flag
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250305-pcc_fixes_updates-v2-1-1b1822bc8746@arm.com>
References: <20250305-pcc_fixes_updates-v2-0-1b1822bc8746@arm.com>
In-Reply-To: <20250305-pcc_fixes_updates-v2-0-1b1822bc8746@arm.com>
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>, 
 Jassi Brar <jassisinghbrar@gmail.com>, Huisong Li <lihuisong@huawei.com>, 
 Adam Young <admiyo@os.amperecomputing.com>, 
 Robbie King <robbiek@xsightlabs.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3054; i=sudeep.holla@arm.com;
 h=from:subject:message-id; bh=V6iDNkf7FB8p7g5HOzBVjRnuDYthQbqnBHp6HSZoQ4M=;
 b=owEBbQKS/ZANAwAIAQBBurwxfuKYAcsmYgBnyH4eFfRXbdJVo7fM20REaros5LzuuqUZWFuvu
 uS87yr5R6OJAjMEAAEIAB0WIQS6ceUSBvMeskPdk+EAQbq8MX7imAUCZ8h+HgAKCRAAQbq8MX7i
 mOQlEAC4nSoZMV7mnkebG2/TGHeV/HEO2YzCQrnCqwREIy9tOmVfsIEB35W6nF/44S8O0XvrkqU
 QYaXpjsbm2gDJAHsSFsVc/+FCCweCrjZXOAtK4Sd/G8kp1dAcxYXbzXDu9A4bmX7Buh8Rkzegu1
 DWsE1/S7Wqct7EW0/ZAsZlzwZm26+IVThJYUb3crunt/5JYiKWGOg4k/EoKHzRWTtv7KMMATaY5
 mGHkjictRTm+IZmUWc6Hqs9gL3fVXvdktNKIO1EwOs8Ek6SKy3PIEBxTlnM6sopyYlcvKq+x0LT
 +X1iZQKR0zCNJNlwH1g+yy/IGaos971c2yy4+Ah8Zb9EhUHHzVbhJSIMckjGe2GkTUGbMwgCKVg
 4R1Ytq8Sv1yz28RAJFQ93RGNo0F+YOwxb31+75FTfoGxqsNv75xNNawvXsVgtZQy3dg0Bqk1LWD
 Es3Ni6QkRPtXvZ7Wg1PfU4BGkzg65txP6MnfMGzMVxMkLvSmOj4zRVywHyvQmJtJ3jgLwhPM2Af
 4y0Y64VUmdi2Wm+OKts7G6qEu/Ds1xlW/KUxsc1Rked2puMJxRYtgBePFvTWdfqxqEQRXorJ/XE
 VxEYy+XjiZzN/qlA6pBW3fj7jNXrBhZvp+g8xw3C/wmdXd2XtufD/alex0Aq1TK/lIsxZgElOXs
 AdUXeFmWVUBic5Q==
X-Developer-Key: i=sudeep.holla@arm.com; a=openpgp;
 fpr=7360A21742ADF5A11767C1C139CFD4755FE2D5B4

From: Huisong Li <lihuisong@huawei.com>

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

Signed-off-by: Huisong Li <lihuisong@huawei.com>
(sudeep.holla: Minor updates to the subject and commit message)
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/mailbox/pcc.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
index 82102a4c5d68839170238540a6fed61afa5185a0..f2e4087281c70eeb5b9b33371596613a371dff4f 100644
--- a/drivers/mailbox/pcc.c
+++ b/drivers/mailbox/pcc.c
@@ -333,10 +333,15 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
 	if (pcc_chan_reg_read_modify_write(&pchan->plat_irq_ack))
 		return IRQ_NONE;
 
+	/*
+	 * Clear this flag immediately after updating interrupt ack register
+	 * to avoid possible race in updatation of the flag from
+	 * pcc_send_data() that could execute from mbox_chan_received_data()
+	 */
+	pchan->chan_in_use = false;
 	mbox_chan_received_data(chan, NULL);
 
 	check_and_ack(pchan, chan);
-	pchan->chan_in_use = false;
 
 	return IRQ_HANDLED;
 }

-- 
2.34.1


