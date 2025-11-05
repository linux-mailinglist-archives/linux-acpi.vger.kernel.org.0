Return-Path: <linux-acpi+bounces-18528-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F10CC34B3C
	for <lists+linux-acpi@lfdr.de>; Wed, 05 Nov 2025 10:11:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00AAF188F47B
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Nov 2025 09:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED9102F8BC3;
	Wed,  5 Nov 2025 09:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="Zqe6BIiU"
X-Original-To: linux-acpi@vger.kernel.org
Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38BA7296BA9;
	Wed,  5 Nov 2025 09:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762333623; cv=none; b=KvyJlX6tWg0dxMAfI+yM7LqpL9tSjSBwrbJdSEKFrmjw4lLc84ZB32amdtxWf8YDZX7TCdm6nQPj3zNsTC0d/Hzrzud/9V5WBB0X7V6z02FAfcjijqaWQc5Jfo5L/c1n5a2juwf+zvpw9/YhdUjRtCphcuFA+0y1MYEvHTjJn1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762333623; c=relaxed/simple;
	bh=G3mXvrrysdRF1DEi+b4mjgB9uEBy3UbZMEhO9DUx0lM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=txrlrdnlv25UVI6Bkbhh5qb0zHl2nbWehUTOVt/2DbMSBImemcPubjVl8/+Pyx+icsMSDHpYofIiBnVBgmDbPUIINVe2RbOyBqBsUzq6avvc4nicdjCQ4yTbc0QT7yn/1UpFY4o/uYL8vzqi/RmdPwaU1UPMvf+ao+AhNwfAGk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=Zqe6BIiU; arc=none smtp.client-ip=113.46.200.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=Vj/Wfm557RNXCs1yIGAz+txNLRH3xhaa459WlTk0izU=;
	b=Zqe6BIiUDRIo19BTyg7d5Ejf4o1SEtwJFR2Mx2SugMZ7dHpMDmnLQ52F26FevUvBS+1Cfyl/5
	rkqQtDmwwyZ9KHz1eVjVxPitLz/q15ixGxWLmi3fgjmshslsWRbwLM5eht4HiJkxlkbI435PHXx
	0jBEvLVwtIw/5WkN98aiPN8=
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4d1fYG2LQrzmV6n;
	Wed,  5 Nov 2025 17:05:22 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id ADF641A016C;
	Wed,  5 Nov 2025 17:06:57 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 5 Nov 2025 17:06:57 +0800
Received: from [10.67.121.59] (10.67.121.59) by kwepemn100009.china.huawei.com
 (7.202.194.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 5 Nov
 2025 17:06:56 +0800
Message-ID: <aad95665-fb6a-477a-b419-4ad88c5db7d2@huawei.com>
Date: Wed, 5 Nov 2025 17:06:56 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/7] ACPI: processor: idle: Disable ACPI idle if get
 power information failed in power notify
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: <lenb@kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <Sudeep.Holla@arm.com>,
	<linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<zhanjie9@hisilicon.com>, <zhenglifeng1@huawei.com>, <yubowen8@huawei.com>
References: <20251103084244.2654432-1-lihuisong@huawei.com>
 <20251103084244.2654432-5-lihuisong@huawei.com>
 <CAJZ5v0idhxfOa8_Zp4Z_j5Rqh4GW4JsBpGT_hT=v=NgcEZRb+g@mail.gmail.com>
 <339a202a-86aa-46f5-b45d-aea653f3e382@huawei.com>
 <CAJZ5v0ii=ZJeCisXx3EOOMfqe8rRn=FvKBDsNuBucxvM0WXvgg@mail.gmail.com>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <CAJZ5v0ii=ZJeCisXx3EOOMfqe8rRn=FvKBDsNuBucxvM0WXvgg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemn100009.china.huawei.com (7.202.194.112)


在 2025/11/5 0:19, Rafael J. Wysocki 写道:
> On Tue, Nov 4, 2025 at 10:54 AM lihuisong (C) <lihuisong@huawei.com> wrote:
>>
>> 在 2025/11/4 2:09, Rafael J. Wysocki 写道:
>>> On Mon, Nov 3, 2025 at 9:42 AM Huisong Li <lihuisong@huawei.com> wrote:
>>>> The old states may not be usable any more if get power information
>>>> failed in power notify. The ACPI idle should be disabled entirely.
>>> How does it actually disable anything?  It only changes the
>>> acpi_processor_power_state_has_changed() return value AFAICS, but that
>>> return value isn't checked.
>> The acpi_processor_power_state_has_changed() will disable all cpuidle
>> device first.
>> AFAICS, the disabled cpuidle_device would not do cpuidle, please see
>> cpuidle_not_available() and cpuidle_idle_call().
>> It's enough for this?
> Well, not really.
>
> acpi_processor_register_idle_driver() has been changed to call
> acpi_processor_get_power_info() for each CPU before registering the
> idle driver and if that is successful, it will set
> flags.power_setup_done for the given processor and call
> acpi_processor_setup_cpuidle_states().  That processor need not be
> CPU0.
>
> However, the code updated by the $subject patch calls
> acpi_processor_get_power_info() for CPU0 and the patch would make it
> skip re-enabling cpuidle for all CPUs if it failed.
>
> It essentially needs to do what is done in
> acpi_processor_register_idle_driver(): find a CPU for which
> acpi_processor_get_power_info() does not fail, then call
> acpi_processor_setup_cpuidle_states() and re-enable cpuidle for all
> CPUs unless acpi_processor_get_power_info() fails for all of them.
 From the initialization perspective, I also think this approach is 
appropriate.
>
> But there is still a question of whether or not this addresses any
> breakage seen in the field.  If not, maybe it's better to leave this
> code as is for the time being?
AFAICS, this power notify can be received on each CPU.
It may be appropriate to update cpuidle state of this CPU if ACPI idle 
supports per-cpu idle state.
Now that all CPUs have the same idle state.
I think it is ok to keep here the same as the initialization logic as 
you said above.
>
> I don't see why it is part of this series to be honest.  It is not a cleanup.
Yes, now it's more like a bugfix.
>

