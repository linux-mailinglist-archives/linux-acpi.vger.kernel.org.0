Return-Path: <linux-acpi+bounces-12078-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87AF2A5BF5F
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Mar 2025 12:41:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C68DB175E53
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Mar 2025 11:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45594254857;
	Tue, 11 Mar 2025 11:41:07 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4610253331;
	Tue, 11 Mar 2025 11:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741693267; cv=none; b=Yw+l83Ep+MXp3IvAGuaJhl1C+NIhXbXSyph8ILYhnBfba3K1Prerk9DbbsfHouKeBYEOpyLBgzY9zBF5UGzVcp3PtRb7+bKLDhb6NGKMiCMEqrdU/NccPXle9e8XZni1VpwZTY3p/eBihKF2Z5U7p5WLHZHKVQf5Dn1va7JcfvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741693267; c=relaxed/simple;
	bh=pJOG8csIWPPDOfgQc+UAEgcctcr7SDhTkMAIsGK9jNw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=EhaqeHVcj0BJOg6aVoGGSZKf6nExPS84ydHLTpC935ze33FtQlHsySaq1NjqedeuIhVczCht3NsEphUuSbt25WzMMfWqZGy+wVy8fk0YPe0TJHX72Z06ZHJVuBxJqoqjflB7MMZc/frCZJyCtPKUrMfOWxo95xz9W1bGQ5ZLD8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4ZBsD216QDz1f07m;
	Tue, 11 Mar 2025 19:36:34 +0800 (CST)
Received: from dggemv703-chm.china.huawei.com (unknown [10.3.19.46])
	by mail.maildlp.com (Postfix) with ESMTPS id 1B3FD140158;
	Tue, 11 Mar 2025 19:40:55 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 11 Mar 2025 19:40:54 +0800
Received: from [10.67.121.59] (10.67.121.59) by kwepemn100009.china.huawei.com
 (7.202.194.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 11 Mar
 2025 19:40:54 +0800
Message-ID: <4ecf3a7a-7a68-fd56-ed93-fbae82e2b0e3@huawei.com>
Date: Tue, 11 Mar 2025 19:40:53 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2 01/13] mailbox: pcc: Fix the possible race in updation
 of chan_in_use flag
To: Sudeep Holla <sudeep.holla@arm.com>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Jassi Brar <jassisinghbrar@gmail.com>, Adam Young
	<admiyo@os.amperecomputing.com>, Robbie King <robbiek@xsightlabs.com>
References: <20250305-pcc_fixes_updates-v2-0-1b1822bc8746@arm.com>
 <20250305-pcc_fixes_updates-v2-1-1b1822bc8746@arm.com>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <20250305-pcc_fixes_updates-v2-1-1b1822bc8746@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemn100009.china.huawei.com (7.202.194.112)


在 2025/3/6 0:38, Sudeep Holla 写道:
> From: Huisong Li <lihuisong@huawei.com>
>
> The function mbox_chan_received_data() calls the Rx callback of the
> mailbox client driver. The callback might set chan_in_use flag from
> pcc_send_data(). This flag's status determines whether the PCC channel
> is in use.
>
> However, there is a potential race condition where chan_in_use is
> updated incorrectly due to concurrency between the interrupt handler
> (pcc_mbox_irq()) and the command sender(pcc_send_data()).
>
> The 'chan_in_use' flag of a channel is set to true after sending a
> command. And the flag of the new command may be cleared erroneous by
> the interrupt handler afer mbox_chan_received_data() returns,
>
> As a result, the interrupt being level triggered can't be cleared in
> pcc_mbox_irq() and it will be disabled after the number of handled times
> exceeds the specified value. The error log is as follows:
>
>    |  kunpeng_hccs HISI04B2:00: PCC command executed timeout!
>    |  kunpeng_hccs HISI04B2:00: get port link status info failed, ret = -110
>    |  irq 13: nobody cared (try booting with the "irqpoll" option)
>    |  Call trace:
>    |   dump_backtrace+0x0/0x210
>    |   show_stack+0x1c/0x2c
>    |   dump_stack+0xec/0x130
>    |   __report_bad_irq+0x50/0x190
>    |   note_interrupt+0x1e4/0x260
>    |   handle_irq_event+0x144/0x17c
>    |   handle_fasteoi_irq+0xd0/0x240
>    |   __handle_domain_irq+0x80/0xf0
>    |   gic_handle_irq+0x74/0x2d0
>    |   el1_irq+0xbc/0x140
>    |   mnt_clone_write+0x0/0x70
>    |   file_update_time+0xcc/0x160
>    |   fault_dirty_shared_page+0xe8/0x150
>    |   do_shared_fault+0x80/0x1d0
>    |   do_fault+0x118/0x1a4
>    |   handle_pte_fault+0x154/0x230
>    |   __handle_mm_fault+0x1ac/0x390
>    |   handle_mm_fault+0xf0/0x250
>    |   do_page_fault+0x184/0x454
>    |   do_translation_fault+0xac/0xd4
>    |   do_mem_abort+0x44/0xb4
>    |   el0_da+0x40/0x74
>    |   el0_sync_handler+0x60/0xb4
>    |   el0_sync+0x168/0x180
>    |  handlers:
>    |   pcc_mbox_irq
>    |  Disabling IRQ #13
>
> To solve this issue, pcc_mbox_irq() must clear 'chan_in_use' flag before
> the call to mbox_chan_received_data().
>
> Signed-off-by: Huisong Li <lihuisong@huawei.com>
> (sudeep.holla: Minor updates to the subject and commit message)
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>   drivers/mailbox/pcc.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
> index 82102a4c5d68839170238540a6fed61afa5185a0..f2e4087281c70eeb5b9b33371596613a371dff4f 100644
> --- a/drivers/mailbox/pcc.c
> +++ b/drivers/mailbox/pcc.c
> @@ -333,10 +333,15 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
>   	if (pcc_chan_reg_read_modify_write(&pchan->plat_irq_ack))
>   		return IRQ_NONE;
>   
> +	/*
> +	 * Clear this flag immediately after updating interrupt ack register
> +	 * to avoid possible race in updatation of the flag from
> +	 * pcc_send_data() that could execute from mbox_chan_received_data()
This comment may be inappropriate becuase of the moving of clearing 
interrupt ack register in patch 2/13.
I suggested that fix it in this patch or patch 2/13.
> +	 */
> +	pchan->chan_in_use = false;
>   	mbox_chan_received_data(chan, NULL);
>   
>   	check_and_ack(pchan, chan);
> -	pchan->chan_in_use = false;
>   
>   	return IRQ_HANDLED;
>   }
>

