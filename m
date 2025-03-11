Return-Path: <linux-acpi+bounces-12083-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 732FEA5BFF0
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Mar 2025 13:02:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6147174259
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Mar 2025 12:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8519221DBC;
	Tue, 11 Mar 2025 12:02:23 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD6671CDA0B;
	Tue, 11 Mar 2025 12:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741694543; cv=none; b=OqmA2BQIqHXVh6KNwky8N/til2U6PpOXGPiopKCngzj4l1KTSvYVGL2/lPz0z5R98zWct4/tXKrdi0iAO18axpnuOjMQUz7FMwCTjABREOoDh9tH9RhNgEvMRG7UEUtGIDPOLr0qLoy302st2ju5fM7fTrmNu0hH070wY/AwqEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741694543; c=relaxed/simple;
	bh=Bmb2tzliIGNBiIX24m2PDco4gc9/BfA6OUhbq+dpSK8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LTAma+qrh6XZl4MzEQj889iEiVTzp60svKnmgthXq4mKKN1K4ICGHURW1QD+qffQbvJWL2Iss4v1q2sSjcSztHqXoDfshgNO3kHipxlW7nBz+N3DxGlqqNkeqFt7lgDW/BsQSSAkqRFx/15YwhBzoLS5b8mCodCkwbRw8KJEMEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 05937152B;
	Tue, 11 Mar 2025 05:02:32 -0700 (PDT)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B40943F673;
	Tue, 11 Mar 2025 05:02:19 -0700 (PDT)
Date: Tue, 11 Mar 2025 12:02:16 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: "lihuisong (C)" <lihuisong@huawei.com>
Cc: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Adam Young <admiyo@os.amperecomputing.com>,
	Robbie King <robbiek@xsightlabs.com>
Subject: Re: [PATCH v2 01/13] mailbox: pcc: Fix the possible race in updation
 of chan_in_use flag
Message-ID: <Z9AmSEBL_UcZ2Hoo@bogus>
References: <20250305-pcc_fixes_updates-v2-0-1b1822bc8746@arm.com>
 <20250305-pcc_fixes_updates-v2-1-1b1822bc8746@arm.com>
 <4ecf3a7a-7a68-fd56-ed93-fbae82e2b0e3@huawei.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4ecf3a7a-7a68-fd56-ed93-fbae82e2b0e3@huawei.com>

On Tue, Mar 11, 2025 at 07:40:53PM +0800, lihuisong (C) wrote:
> 
> 在 2025/3/6 0:38, Sudeep Holla 写道:
> > From: Huisong Li <lihuisong@huawei.com>
> > 
> > The function mbox_chan_received_data() calls the Rx callback of the
> > mailbox client driver. The callback might set chan_in_use flag from
> > pcc_send_data(). This flag's status determines whether the PCC channel
> > is in use.
> > 
> > However, there is a potential race condition where chan_in_use is
> > updated incorrectly due to concurrency between the interrupt handler
> > (pcc_mbox_irq()) and the command sender(pcc_send_data()).
> > 
> > The 'chan_in_use' flag of a channel is set to true after sending a
> > command. And the flag of the new command may be cleared erroneous by
> > the interrupt handler afer mbox_chan_received_data() returns,
> > 
> > As a result, the interrupt being level triggered can't be cleared in
> > pcc_mbox_irq() and it will be disabled after the number of handled times
> > exceeds the specified value. The error log is as follows:
> > 
> >    |  kunpeng_hccs HISI04B2:00: PCC command executed timeout!
> >    |  kunpeng_hccs HISI04B2:00: get port link status info failed, ret = -110
> >    |  irq 13: nobody cared (try booting with the "irqpoll" option)
> >    |  Call trace:
> >    |   dump_backtrace+0x0/0x210
> >    |   show_stack+0x1c/0x2c
> >    |   dump_stack+0xec/0x130
> >    |   __report_bad_irq+0x50/0x190
> >    |   note_interrupt+0x1e4/0x260
> >    |   handle_irq_event+0x144/0x17c
> >    |   handle_fasteoi_irq+0xd0/0x240
> >    |   __handle_domain_irq+0x80/0xf0
> >    |   gic_handle_irq+0x74/0x2d0
> >    |   el1_irq+0xbc/0x140
> >    |   mnt_clone_write+0x0/0x70
> >    |   file_update_time+0xcc/0x160
> >    |   fault_dirty_shared_page+0xe8/0x150
> >    |   do_shared_fault+0x80/0x1d0
> >    |   do_fault+0x118/0x1a4
> >    |   handle_pte_fault+0x154/0x230
> >    |   __handle_mm_fault+0x1ac/0x390
> >    |   handle_mm_fault+0xf0/0x250
> >    |   do_page_fault+0x184/0x454
> >    |   do_translation_fault+0xac/0xd4
> >    |   do_mem_abort+0x44/0xb4
> >    |   el0_da+0x40/0x74
> >    |   el0_sync_handler+0x60/0xb4
> >    |   el0_sync+0x168/0x180
> >    |  handlers:
> >    |   pcc_mbox_irq
> >    |  Disabling IRQ #13
> > 
> > To solve this issue, pcc_mbox_irq() must clear 'chan_in_use' flag before
> > the call to mbox_chan_received_data().
> > 
> > Signed-off-by: Huisong Li <lihuisong@huawei.com>
> > (sudeep.holla: Minor updates to the subject and commit message)
> > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> > ---
> >   drivers/mailbox/pcc.c | 7 ++++++-
> >   1 file changed, 6 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
> > index 82102a4c5d68839170238540a6fed61afa5185a0..f2e4087281c70eeb5b9b33371596613a371dff4f 100644
> > --- a/drivers/mailbox/pcc.c
> > +++ b/drivers/mailbox/pcc.c
> > @@ -333,10 +333,15 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
> >   	if (pcc_chan_reg_read_modify_write(&pchan->plat_irq_ack))
> >   		return IRQ_NONE;
> > +	/*
> > +	 * Clear this flag immediately after updating interrupt ack register
> > +	 * to avoid possible race in updatation of the flag from
> > +	 * pcc_send_data() that could execute from mbox_chan_received_data()
> This comment may be inappropriate becuase of the moving of clearing
> interrupt ack register in patch 2/13.
> I suggested that fix it in this patch or patch 2/13.

Right, I did think of updating or did update and missed to commit.
I wanted to update something like:
"
Clear this flag after updating interrupt ack register and just before
mbox_chan_received_data() which might call pcc_send_data() where the
flag is set again to start new transfer
"

Hope that is more apt to the current situation.

-- 
Regards,
Sudeep

