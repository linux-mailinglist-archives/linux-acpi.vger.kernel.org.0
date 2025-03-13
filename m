Return-Path: <linux-acpi+bounces-12200-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 203EEA5F9D9
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Mar 2025 16:29:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97DB917FFBA
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Mar 2025 15:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FB61268FF9;
	Thu, 13 Mar 2025 15:29:16 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B811F267F4F;
	Thu, 13 Mar 2025 15:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741879756; cv=none; b=hbILuYgE/+W9jCDCufVGb3GblSX3MJJWP/Ki+MOLH3ACe9Jk3zb72xeIQd/VeJKYTo9YNtLOz/TJq1d8/LsrV9jp0ciFHjGzQllxav544NB14nKNkGFA1IRlXngFYptI5JO8UyW5hsZlicq/4eCfuRM71o0x6VyENaftnaCm24g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741879756; c=relaxed/simple;
	bh=NQbyptRwAeP3RHevwuUTs6vCxAkaqegjdsMRF6siQF4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lRCe9D6jbNGdLuAQuHk3sMzGlaEr5LZsyDpXg4/Nk8DP/PdrGux0g54ptvWaXxrhW4dRp/Vf5eNsLk8giN6VGdBAYBs+goLgFGhReUxZ11S48t4Vj4YRFYjlO546RbQD8GAR8VZtsWVsegEWT/HGiTJrhEngwVY+6574gt3vGeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4AC271516;
	Thu, 13 Mar 2025 08:29:23 -0700 (PDT)
Received: from e133711.arm.com (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C94933F694;
	Thu, 13 Mar 2025 08:29:11 -0700 (PDT)
From: Sudeep Holla <sudeep.holla@arm.com>
Date: Thu, 13 Mar 2025 15:28:47 +0000
Subject: [PATCH v3 01/13] mailbox: pcc: Fix the possible race in updation
 of chan_in_use flag
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250313-pcc_fixes_updates-v3-1-019a4aa74d0f@arm.com>
References: <20250313-pcc_fixes_updates-v3-0-019a4aa74d0f@arm.com>
In-Reply-To: <20250313-pcc_fixes_updates-v3-0-019a4aa74d0f@arm.com>
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>, 
 Jassi Brar <jassisinghbrar@gmail.com>, Huisong Li <lihuisong@huawei.com>, 
 Adam Young <admiyo@os.amperecomputing.com>, 
 Robbie King <robbiek@xsightlabs.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3240; i=sudeep.holla@arm.com;
 h=from:subject:message-id; bh=dxK+XKYYiFPaimo8uMWpmsf+NJk31atPdAwkPEBgDVs=;
 b=owEBbQKS/ZANAwAIAQBBurwxfuKYAcsmYgBn0vnDRyhuZxpA6nNUZalpyyOa820Eh0x8ALXzJ
 mKyysNuSHSJAjMEAAEIAB0WIQS6ceUSBvMeskPdk+EAQbq8MX7imAUCZ9L5wwAKCRAAQbq8MX7i
 mO6/EACeOvjYrH8qLAi4BZJSChAtzS4xIC4AXnqsVPKQvn3qUgURiSsnwbZzkOFjDgFNcEvTP/6
 SYxWQDT3hcdyzPE4lznS8yKCvRomC4FJ7CjHuRf1KrqQ00LgVBMCBcRMEk8RxuVZK5z0jWFiLW8
 Clnpka5WCG32x0Amlpd99A6kjnma4pxPLl+mJ7FMvhF6Kn1hDk2xQkvPXogLBr7bnquJNw9dVX1
 4vAnjEPzUiiQur6nAPeibz5FNWDDW1aO3p9s1J5fDDHdcHdywfaVwHF66NORu8b0StijVqVRdQP
 iVmrXi8duvDzdVss7w7eiL18TXpC3Zkw8fVC6Z666v+tiDT4sKGgLjQM6jyEv8q5XvnDmyjwD8M
 OcuS1zpQP8GMda6nCgmbZBjmkK/WeyHHj2x57sj4/Io+Elsd/UNc3Ft9pWWzaoM+rG6mriqPw3L
 15xSajaRMYzPj1qyq/lyZc05RgK6idonM7y8Vgf/QD+VyvffxVC948FohTRApel5OI+UX9luL/F
 W5QXhVE3vFU/NV1FcoO76FlX1V4csSlu3QJuA7Q5ag/K6TwdRRuU2GLzfR72aW760M3E1Mm6TYN
 ngKjhMJYa7R+v3XnjDAvuY5+IwVoyWeyDHnFaHbBOUW6G4pG+0XEqz/cBCb9O6utDTFy5dgZpbK
 qxNa+WvkuLAM78A==
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

Tested-by: Adam Young <admiyo@os.amperecomputing.com>
Tested-by: Robbie King <robbiek@xsightlabs.com>
Signed-off-by: Huisong Li <lihuisong@huawei.com>
(sudeep.holla: Minor updates to the subject, commit message and comment)
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/mailbox/pcc.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
index 82102a4c5d68839170238540a6fed61afa5185a0..8fd4d0f79b090eeea1c7779061841ef507083687 100644
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
2.34.1


