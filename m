Return-Path: <linux-acpi+bounces-17389-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93FC3BA8830
	for <lists+linux-acpi@lfdr.de>; Mon, 29 Sep 2025 11:04:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AE3A1896BDA
	for <lists+linux-acpi@lfdr.de>; Mon, 29 Sep 2025 09:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9732723C506;
	Mon, 29 Sep 2025 09:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="hFqxCdsE"
X-Original-To: linux-acpi@vger.kernel.org
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA6C208994;
	Mon, 29 Sep 2025 09:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759136650; cv=none; b=a64SGGfNQzdTkVfJl8RJOmfP8HfeMpCwcXOrECjXWmkBXUzmMHY6KPLxxA8O8lexShNR0ckeVv7tPZb+w452Mxpn5C82+nQrxxSTVqhvB7EkG5I+8OjvutD3A4v3+4g4lIqeRvtjJK9d/A+JV8/CK/T1zhQbiVN+1vm2V2mnVy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759136650; c=relaxed/simple;
	bh=Pvnrp3hxvsLyvMPzdpgX1QHFoUDsSYJDUnUwTU+Kr5M=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=kXJMVm6UjLnPoD9440oIejUJsA2m9c7yQE8KR0Q3ZODzIham8t24YDGE0nDTL/4FGCAxoyPCDyQCVmy1/eVFIhseMTADuiuO2JapjJZybYLpY6a4ZMyaGc7rxz84jx6l/hbiYv8QalOA2gVDh6uosFYSzm8LfQaOoGGGV1nhogM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=hFqxCdsE; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=/HWtjlVeP9SWCpKiQq9t3W3n3XGxDg3Htcl9KL67snA=;
	b=hFqxCdsEfRxs/FrcxYa4h9sSffmskYQpWXOj8ApJEsUTmk86LI/ialmiYmGTL18eGQy99luT8
	HPrNDS9CmOr9U4HVet1tsGDllEIEsbFAzhgec5mvR1c9ZPsZq/WHYoPiwSJPKu6LkEZ2rkGzM7y
	67jd7anWvZ9AjtvIkNfDHQM=
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4cZwGv3b0Yz12LGD;
	Mon, 29 Sep 2025 17:04:07 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 3C615180488;
	Mon, 29 Sep 2025 17:03:59 +0800 (CST)
Received: from [10.174.178.247] (10.174.178.247) by
 dggpemf500002.china.huawei.com (7.185.36.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 29 Sep 2025 17:03:58 +0800
Subject: Re: [PATCH v3] ACPI: AGDI: Add interrupt signaling mode support
To: "Kazuhiro Abe (Fujitsu)" <fj1078ii@fujitsu.com>, 'Ilkka Koskinen'
	<ilkka@os.amperecomputing.com>, 'Sudeep Holla' <sudeep.holla@arm.com>
CC: 'Lorenzo Pieralisi' <lpieralisi@kernel.org>, "'Rafael J. Wysocki'"
	<rafael@kernel.org>, 'Len Brown' <lenb@kernel.org>,
	"'linux-acpi@vger.kernel.org'" <linux-acpi@vger.kernel.org>,
	"'linux-arm-kernel@lists.infradead.org'"
	<linux-arm-kernel@lists.infradead.org>, "'linux-kernel@vger.kernel.org'"
	<linux-kernel@vger.kernel.org>
References: <20250905042751.945616-1-fj1078ii@aa.jp.fujitsu.com>
 <bd45c06a-77cc-2ab3-122e-41dee1aee0ac@os.amperecomputing.com>
 <TY3PR01MB99836C3D57503E70C8B8C9E9D509A@TY3PR01MB9983.jpnprd01.prod.outlook.com>
 <TY3PR01MB9983025D434CAA2CDF83656BD511A@TY3PR01MB9983.jpnprd01.prod.outlook.com>
 <3bbdc50e-a55c-96ed-a8db-6bbce1760ee4@huawei.com>
 <TY3PR01MB9983E784E31A612B9BA23255D51BA@TY3PR01MB9983.jpnprd01.prod.outlook.com>
From: Hanjun Guo <guohanjun@huawei.com>
Message-ID: <b8ab020f-8298-cadd-70ee-9325c32b968f@huawei.com>
Date: Mon, 29 Sep 2025 17:03:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <TY3PR01MB9983E784E31A612B9BA23255D51BA@TY3PR01MB9983.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 dggpemf500002.china.huawei.com (7.185.36.57)

On 2025/9/29 15:32, Kazuhiro Abe (Fujitsu) wrote:
> Hi Hanjun,
> 
>>> Hi Hanjun & Sudeep
>>>
>>>> Hi Ilkka
>>>>
>>>>> Hi Kazuhiro,
>>>>>
>>>>> On Fri, 5 Sep 2025, Kazuhiro Abe wrote:
>>>>>> AGDI has two types of signaling modes: SDEI and interrupt.
>>>>>> Currently, the AGDI driver only supports SDEI.
>>>>>> Therefore, add support for interrupt signaling mode The interrupt
>>>>>> vector is retrieved from the AGDI table, and call panic function
>>>>>> when an interrupt occurs.
>>>>>>
>>>>>> Signed-off-by: Kazuhiro Abe<fj1078ii@aa.jp.fujitsu.com>
>>>>>
>>>>> Looks good to me.
>>>>>
>>>>> Reviewed-by: Ilkka Koskinen<ilkka@os.amperecomputing.com>
>>>>>
>>>> Thanks for your review.
>>>>
>>>> Best Regards,
>>>> Kazuhiro Abe
>>>>
>>>>> Hanjun & Sudeep, what's your thought on enabling the use of regular
>>>>> interrupts here? I do agree the spec talks about non-maskable ones
>>>>> and to my understanding that's what the idea was indeed.
>>> Do you have any thoughts on this matter?
>> For the real use case, if the system is in failure state, for example, the system is
>> panic, the CPU will not handle regular interrupts, so what's the use case do you
>> have to use regular interrupt?
> This driver is designed to operate with NMI enabled.
> 
> However, on current ARM64 platforms, NMI functionality may not be active unless
> "pseudo NMI" is explicitly specified via a kernel command-line parameter.
> In such scenarios, we've included regular interrupt handling as a last resort,
> anticipating rare cases where some cores might still be able to receive regular
> interrupts even if other cores are unresponsive.
> 
> To reiterate, the underlying assumption is that NMI(now pseudo NMI) is enabled for use.

OK. Please send a new version, I will ack it
if you address my comments.

Thanks
Hanjun

