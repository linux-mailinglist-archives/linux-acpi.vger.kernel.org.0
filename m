Return-Path: <linux-acpi+bounces-19154-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 001B5C74529
	for <lists+linux-acpi@lfdr.de>; Thu, 20 Nov 2025 14:46:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 22C004F7634
	for <lists+linux-acpi@lfdr.de>; Thu, 20 Nov 2025 13:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D4A340273;
	Thu, 20 Nov 2025 13:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="r2nzrc/D"
X-Original-To: linux-acpi@vger.kernel.org
Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20494340A63;
	Thu, 20 Nov 2025 13:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763645263; cv=none; b=ogEbrC91rMiIlUozcSVvYXLssLbt/nmbdci9OUDr7H3vR4tNLjo14OkMVLnBdnNNbZVcjjLpdk+gMfrxGDnavxNJULeBZ2uAORa+xKQQTNFG4NvqhZY7t6YYOs54WRqMwdMtVDe6rBg1WR4X54OZjFTHqwRc1IqYiiRAU2Wpq5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763645263; c=relaxed/simple;
	bh=8/NKczoH0AnVDeOw9MDNS7nK+HcHsxEBO3ZNNeuJ1TQ=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=doFo6GBk+jWHt8x5JfMsos9Pzw8KBmSCb0oHcXX8j/89FjVM7zZipJ9f+8DTm3gEOJNC1gk93Kny2saW2/YbKN+PcDr0Sl8+fm3TkPb14rn13sburRvYJgARAYmbng7HI1ePoJKNbqeCEGRswXzAza1618sG6GkF1VhdGUmDGBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=r2nzrc/D; arc=none smtp.client-ip=113.46.200.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=jNEzn90qst9+tzt5npqkID2YagZTvAG48V9awJpqiDQ=;
	b=r2nzrc/DCcKTo0+mULrDN7m5oQt/7yw0GrmV0gWWv9Hj3X4PNOFy8ilip2a9QK87MU6M3hG3Z
	rEziwRHrdZVFnMWgNLkbyEDALrt5ZOZxVrp9w8eD/8+yPC7MStt519nD7EZaqVP2vWLmfC7CRxy
	pEMj9wBhQiQl4XggeHhRVqY=
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4dBzcl1CjPzmV7k;
	Thu, 20 Nov 2025 21:25:43 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id C246A1A016C;
	Thu, 20 Nov 2025 21:27:27 +0800 (CST)
Received: from [10.174.178.247] (10.174.178.247) by
 dggpemf500002.china.huawei.com (7.185.36.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 20 Nov 2025 21:27:26 +0800
Subject: Re: [PATCH v4] ACPI: AGDI: Add interrupt signaling mode support
To: "Kazuhiro Abe (Fujitsu)" <fj1078ii@fujitsu.com>, Will Deacon
	<will@kernel.org>
CC: Lorenzo Pieralisi <lpieralisi@kernel.org>, Sudeep Holla
	<sudeep.holla@arm.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown
	<lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Ilkka Koskinen
	<ilkka@os.amperecomputing.com>, Catalin Marinas <catalin.marinas@arm.com>
References: <20251017073935.1746365-1-fj1078ii@aa.jp.fujitsu.com>
 <a93e845a-b084-a680-7158-68363c492b75@huawei.com>
 <aQokdBkjFqw9ZGRt@willie-the-truck>
 <6b14156b-9734-f0e0-5954-57cc76576a37@huawei.com>
 <OSCPR01MB163100DEFA746D8A44FA0A1E3D5D6A@OSCPR01MB16310.jpnprd01.prod.outlook.com>
From: Hanjun Guo <guohanjun@huawei.com>
Message-ID: <6d110b4f-a1e6-2092-f529-bd527fc00f6d@huawei.com>
Date: Thu, 20 Nov 2025 21:27:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <OSCPR01MB163100DEFA746D8A44FA0A1E3D5D6A@OSCPR01MB16310.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 dggpemf500002.china.huawei.com (7.185.36.57)

On 2025/11/18 18:09, Kazuhiro Abe (Fujitsu) wrote:
> Hi Hanjun,
> 
> Thanks for your comments.
> 
>>>>> AGDI has two types of signaling modes: SDEI and interrupt.
>>>>> Currently, the AGDI driver only supports SDEI.
>>>>> Therefore, add support for interrupt signaling mode The interrupt
>>>>> vector is retrieved from the AGDI table, and call panic function
>>>>> when an interrupt occurs.
>>>>>
>>>>> Reviewed-by: Ilkka Koskinen<ilkka@os.amperecomputing.com>
>>>>> Signed-off-by: Kazuhiro Abe<fj1078ii@aa.jp.fujitsu.com>
>>>>> ---
>>>>> Hanjun, I have addressed all your comments.
>>>>> Please review them.
>>>>>
>>>>> v3->v4
>>>>>     - Add a comment to the flags member.
>>>>>     - Fix agdi_interrupt_probe.
>>>>>     - Fix agdi_interrupt_remove.
>>>>>     - Add space in struct initializsation.
>>>>>     - Delete curly braces.
>>>> Looks good to me,
>>>>
>>>> Acked-by: Hanjun Guo<guohanjun@huawei.com>
>>> I wasn't cc'd on the original patch but I couldn't figure out why it
>>> uses IRQF_NO_AUTOEN when requesting the irq given that the first thing
>>> it does is enable it.
>> Sorry for the late reply, seems this comment was addressed.
>>
>> But when I go back to read the latest AGDI spec [0], I see the signaling mode
>> can be SDEI*and*  interrupt:
>>
>> Flags node structures 1 36 Bits [1:0]: Signaling mode:
>>
>> 2: Both SDEI and Interrupt-based signaling is supported. While an SDEI event
>> handler is registered, the platform is allowed to not generate the wired interrupt
>>
>> So which means we need to support both SDEI and interrupt when the
>> signaling mode is 2, but for now, the code is
>>
>> +	if (agdi_table->flags & ACPI_AGDI_SIGNALING_MODE)
>> +		pdata.gsiv = agdi_table->gsiv;
>> +	else
>> +		pdata.sdei_event = agdi_table->sdei_event;
>>
>> Kazuhiro, could you take a look again?
> I don't think enabling both interrupt and SDEI makes sense.
> Therefore, we need to choose one but we can't know which one is preferred for each platform.
> On the other hand, before this patch the code is:
> 
>         if (agdi_table->flags & ACPI_AGDI_SIGNALING_MODE) {
>                 pr_warn("Interrupt signaling is not supported");
>                 goto err_put_table;
>         }
> 
> ...and SDEI is used when mode is 2. This behavior will not be changed by this patch.
> Therefore, It seems for me this patch is reasonable for now.
> I would appreciate your thoughts on this.

I had a talk to firmware guy about this, they say even with both
supported, the platform will use the same interrupt number to
trigger, and the spec says:

While an SDEI event handler is registered, the platform is allowed to
not generate the wired interrupt

I think this patch is ready to go.

Thanks
Hanjun

