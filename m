Return-Path: <linux-acpi+bounces-11702-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD053A4BCEE
	for <lists+linux-acpi@lfdr.de>; Mon,  3 Mar 2025 11:53:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED6CF3AAD58
	for <lists+linux-acpi@lfdr.de>; Mon,  3 Mar 2025 10:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8AEF1F3D31;
	Mon,  3 Mar 2025 10:53:28 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B0F21F17E5;
	Mon,  3 Mar 2025 10:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740999208; cv=none; b=HUiJFEMDuPHahmqg3a8rEEIwQm78sWFHRPpOO7AaE66G1U84rWl9Zhmi5D+TlDkQa8NZoYHBV2e4J693f920ju5/YpUvROG+TIooe6lPkEbFc9FVxdj+wyGetmvvDSzz9li3epHHgdfeRR6kONyhWDzSc6VrQ+q0I47wg+ntyU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740999208; c=relaxed/simple;
	bh=g9voXRH9b5scUtRJQUT9IkYk1Q1woAlbAN5ZVwPOsw0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lVbb4pRTYdVQk2h0cf8LK3AyuA4Zt4UjCRrPQYjtPU2yIqyQeQRw0e5wtQIJAPqs0SaqJtftbXDOvDY3mZft0R9qwA0G2+3WT0LR1SPpifHj/s4QnYqAMKlPytpk+0p3KJRHBgWjR242tq7/P0nYTYSRt7hqmtQNE88nT+OG14Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5AE5712FC;
	Mon,  3 Mar 2025 02:53:40 -0800 (PST)
Received: from e133711.arm.com (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3EAAE3F673;
	Mon,  3 Mar 2025 02:53:25 -0800 (PST)
From: Sudeep Holla <sudeep.holla@arm.com>
Date: Mon, 03 Mar 2025 10:51:36 +0000
Subject: [PATCH 01/14] mailbox: pcc: Fix the possible race in updation of
 chan_in_use flag
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250303-pcc_fixes_updates-v1-1-3b44f3d134b1@arm.com>
References: <20250303-pcc_fixes_updates-v1-0-3b44f3d134b1@arm.com>
In-Reply-To: <20250303-pcc_fixes_updates-v1-0-3b44f3d134b1@arm.com>
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>, 
 Jassi Brar <jassisinghbrar@gmail.com>, Huisong Li <lihuisong@huawei.com>, 
 Adam Young <admiyo@os.amperecomputing.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3054; i=sudeep.holla@arm.com;
 h=from:subject:message-id; bh=V6iDNkf7FB8p7g5HOzBVjRnuDYthQbqnBHp6HSZoQ4M=;
 b=owEBbQKS/ZANAwAIAQBBurwxfuKYAcsmYgBnxYohU2Ovtmr4qvaGn/sgdbGVNgixC3C3wyS5+
 sJABEakylCJAjMEAAEIAB0WIQS6ceUSBvMeskPdk+EAQbq8MX7imAUCZ8WKIQAKCRAAQbq8MX7i
 mCSvEAC0jkjX+3Pbc642V3BITLszz4Xj/lsxjE5pyY+biE7BNcQ+yBxWT6R+fFxQbNas1oXn5M2
 m+7c5iWayb+5jX1Yg2VNccrheMh2vWg2gHZ4az1yEcBlS5jKzA+qpr/n1hkzgr9CDiTC4hj3keF
 swXlvbX4zpGvLllzGtaEm70e5LJbP2mcxTGAUFEl9XGNiV0dW9N56WAFx2WmF2wAcdprrPghamP
 UcKk6M6/OGIk7OYNC7hPQgZL8saJCbXCq+ixgt5QsfuAw8htPDPQ5J3d64Ow4j4UzikxAjoxWoe
 SbdNkgSzirtS+0R/xEcyb0mRfwtSIO9jyrlda1RmgeQ3MbIiL9pRVxjx/v9rzhUX/uQMeJbwONF
 Wj0P6IqZs4K16fARRmTOqHxiHumt+j2aMdgNWysfMHybHjUKk+4chmLFe3Hob2G44hqMt384LIl
 KDWdsVoDEm58GOrlQc7CkLb8uS1Xy+Q9peY8l1CIaOC3Ouc9LdtOIjs0aO4V84dUMG50VCr13zQ
 NWsrhz2mKgsrOEs6TrKYPcs0ahPO2yGjRvuxKgxMSxzOSV/K3S2kFZLinaexKk81jLDFEHgduyY
 58+i4VRcqcm+0QOTuuKj7pj0IB7yXlYFFY0oWK5IVp+6XcSK+QSqCeSQV3tXABBtmEPDgL3o8i7
 jdesBPic4vi6pbg==
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


