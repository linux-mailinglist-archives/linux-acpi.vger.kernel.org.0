Return-Path: <linux-acpi+bounces-11685-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE31EA4B04C
	for <lists+linux-acpi@lfdr.de>; Sun,  2 Mar 2025 08:30:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70C57168EE0
	for <lists+linux-acpi@lfdr.de>; Sun,  2 Mar 2025 07:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E6A11CD215;
	Sun,  2 Mar 2025 07:30:15 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E151C1420DD;
	Sun,  2 Mar 2025 07:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740900614; cv=none; b=JREa/mGNqaT1oinP08N3t4hL+2xPHnYrGq8j1BGTanCtNZfoD+N7jCTtWHZscQhOYw2HMOq8Kv90VJssWHuv44Pp6uWvVZMxS2w1F0yoGE8n6xJ442yyzImGbX9N16s1Qbl0246apRVyNumczMnl1DR+OPC4WoLJkl1baLXuIgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740900614; c=relaxed/simple;
	bh=d7NlhC7hvLuzq9JoF9qYrayoB11kqa8d/MrYlOXyNz8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=c2mQip92PjGjyGoANMv99HKHxMv1LMYVxLp9Awf0f12BBwovDv54NFJbxSDFCcH0slnViAi+HyqkJLeyytW5cKieCrSKGBcO1KU3Za6pZOjEtZFT5vJ9keo6SQVrdWDWxEEKUB7ezVCYdG1oepXc2WD2lpXZkAmY5WcR+B+O4MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Z5D691jQ6z21p0m;
	Sun,  2 Mar 2025 15:26:57 +0800 (CST)
Received: from dggemv711-chm.china.huawei.com (unknown [10.1.198.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 8E8AB1A0188;
	Sun,  2 Mar 2025 15:30:03 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 2 Mar 2025 15:30:03 +0800
Received: from [10.67.121.59] (10.67.121.59) by kwepemn100009.china.huawei.com
 (7.202.194.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sun, 2 Mar
 2025 15:30:02 +0800
Message-ID: <05e7a220-7886-77ad-af58-7847c679579a@huawei.com>
Date: Sun, 2 Mar 2025 15:30:01 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] mailbox: pcc: Fix can't clear level interrupt of type3 in
 cornor case
To: Sudeep Holla <sudeep.holla@arm.com>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<jassisinghbrar@gmail.com>, <liuyonglong@huawei.com>
References: <20250227072341.28693-1-lihuisong@huawei.com>
 <Z8HlHDAUWqQOjrCH@bogus>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <Z8HlHDAUWqQOjrCH@bogus>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemn100009.china.huawei.com (7.202.194.112)


在 2025/3/1 0:32, Sudeep Holla 写道:
> On Thu, Feb 27, 2025 at 03:23:41PM +0800, Huisong Li wrote:
>> The mbox_chan_received_data() will call Rx callback of mbox client driver
>> using type3 to set the flag of command completion. Then driver can continue
>> to do something like sending a new command. In this case, the rest of the
>> interrupt handler function may be concurrent with pcc_send_data().
>>
> Understood and valid issue/bug.
>
>> The 'chan_in_use' flag of a channel is true after sending a command. And
>> the flag of the new command may be cleared by the running interrupt handler
>> in cornor case. As a result, the interrupt being level triggered can't be
>> cleared in pcc_mbox_irq() and it will be disabled after the number of
>> handled times exceeds the specified value. The error log is as follows:
>>
>> [519082.811553] kunpeng_hccs HISI04B2:00: PCC command executed timeout!
>     ^^^^
> These timestamps are useless, needs to be dropped.
Got it. Thanks.
>
>> [519082.828532] kunpeng_hccs HISI04B2:00: get port link status info failed, ret = -110.
>> [519082.833438] irq 13: nobody cared (try booting with the "irqpoll" option)
>> [519082.844622] CPU: 304 PID: 15206 Comm: systemd-journal Kdump: loaded Tainted: G           OE     5.10.0 #5
>> [519082.854959] Hardware name: To be filled by O.E.M. To be filled by O.E.M./To be filled by O.E.M., BIOS Nezha B800 V3.1.0 01/02/2024
> "To be filled by O.E.M." interesting. Either as silicon vendor, some prefer
> to leave it this way to ensure the O.E.M fill them correctly or the firmware
> engineers are not bothered to get these right as nothing breaks without
> these.
>
> Anyways, good example of what not to have in the products, as it is completely
> useless.
>
> [...]
Thanks for pointing it out.
Please ignore this. will drop the line.
>
>> To solve this issue, pcc_mbox_irq() clear 'chann_in_use' flag immediately
>> after clearing interrupt ack register.
>>
> This may be correct way of fixing the issue here, but I am questioning the
> existence of this flag now. I have some rework on this file. I will pick
This flag is for shared interrupt case on type3. please see:
3db174e478cb ("mailbox: pcc: Support shared interrupt for multiple 
subspaces")

We may need to fix it first before your refactoring this file. After 
all, it's an issue.
A little modification is more easily to backport and merge.
If it's ok for you, I'll update this commit log.
> this up if I think this is needed as it may conflict with my changes or
> we will drop the flag completely. Give a week or so, will post the changes
> and we can take it from there.
>
Looking forward to your rework.


/Huisong

>
> .

