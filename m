Return-Path: <linux-acpi+bounces-10317-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DCC29FD9E8
	for <lists+linux-acpi@lfdr.de>; Sat, 28 Dec 2024 11:24:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F26818832FE
	for <lists+linux-acpi@lfdr.de>; Sat, 28 Dec 2024 10:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB0CA13D8A3;
	Sat, 28 Dec 2024 10:24:10 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CBDA69D2B;
	Sat, 28 Dec 2024 10:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735381450; cv=none; b=p9qJUkUrAHhzDbjZgp8MtGrzuSVlT07YmmaBVfPEAL/RGHhkPs383OlK5ad+vYXV+gVAmLhxdpLXP8p+sbjQx3hFU//tFLmNLKUCFBv/QR+nEGmMG5WKdMRwCaC27dOiubnphv8qwhHa0DXAIUtkbCiwCpIkrEYvDsX8hgzcX70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735381450; c=relaxed/simple;
	bh=YngjxGWq1Tv+ALdG1TKrseFe9btby2iXeFwHDXig0dk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=V1GXhtyHVKkXTww2U5GixG/UGmVxOIE5Jc6pIubEyYEscGrcRlCW2y8QoV5wgAuHAxdmApcKNU9g+Kyt9XesWFVcDIHFwEqDJuU5wqka27pNjK8ccOZi4/nG9RoEig/tbFQTi4HNVD+2NWF1H3CRfAjBYDp9AfxN7yzSSl16Ml8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4YKz0S4JN2zgZVc;
	Sat, 28 Dec 2024 18:20:56 +0800 (CST)
Received: from dggpemf200009.china.huawei.com (unknown [7.185.36.246])
	by mail.maildlp.com (Postfix) with ESMTPS id 335EE180A9E;
	Sat, 28 Dec 2024 18:23:57 +0800 (CST)
Received: from [10.67.121.188] (10.67.121.188) by
 dggpemf200009.china.huawei.com (7.185.36.246) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 28 Dec 2024 18:23:56 +0800
Message-ID: <a980db9a-831b-c950-e5bf-80d422a91015@huawei.com>
Date: Sat, 28 Dec 2024 18:23:56 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] acpi: Fix hed module initialization order when it is
 built-in
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC: "Rafael J. Wysocki" <rafael@kernel.org>, <lenb@kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<M.Chehab@huawei.com>, <roberto.sassu@huawei.com>, <shiju.jose@huawei.com>,
	<prime.zeng@hisilicon.com>, <linuxarm@huawei.com>,
	<mchehab+huawei@kernel.org>
References: <20241115035014.1339256-1-tanxiaofei@huawei.com>
 <CAJZ5v0h4-cSFs+ED3ymJKHKkEAproXCtB2t3cP1wcyd6eq=Sgg@mail.gmail.com>
 <dfa67fab-e9c1-baec-dd86-6c6ba79eabeb@huawei.com>
 <20241223193300.00000b32@huawei.com>
From: Xiaofei Tan <tanxiaofei@huawei.com>
In-Reply-To: <20241223193300.00000b32@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemf200009.china.huawei.com (7.185.36.246)

Hi Jonathan,

在 2024/12/24 3:33, Jonathan Cameron 写道:
> On Mon, 23 Dec 2024 17:31:08 +0800
> Xiaofei Tan <tanxiaofei@huawei.com> wrote:
>
>> Hi Rafael,
>>
>> 在 2024/12/11 1:59, Rafael J. Wysocki 写道:
>>> On Fri, Nov 15, 2024 at 4:56 AM Xiaofei Tan <tanxiaofei@huawei.com> wrote:
>>>> When the module hed is built-in, the init order is determined by
>>>> Makefile order.
>>> Are you sure?
>> yes
> We had a similar fix in CXL recently (which is why I suggested this approach
> internally when tanxiaofei mentioned the problem).
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/cxl?id=6575b268157f37929948a8d1f3bafb3d7c055bc1
>
> The related discussion for the CXL patch was the first time I'd come across solution
> to load order for built in cases.
>
Yes :)

>>>> That order violates expectations. Because the module
>>>> hed init is behind evged. RAS records can't be handled in the
>>>> special time window that evged has initialized while hed not.
>>>> If the number of such RAS records is more than the APEI HEST error
>>>> source number, the HEST resources could be occupied all, and then
>>>> could affect subsequent RAS error reporting.
>>> Well, the problem is real, but does the change really prevent it from
>>> happening or does it just increase the likelihood of success?
>> It can be completely solved if the driver used as built-in way. If build HED as a
>> module, it not solved.
> Can we enforce that condition not happening with appropriate Kconfig?
> It's annoying to restrict build options, but if needed to make it work
> then better than not working!

Agree,  i will change ACPI_HED from tristate to bool if there are no other comments, thanks.

>
> Jonathan
>
>
>>> In the latter case, and generally speaking too, it would be better to
>>> add explicit synchronization between evged and hed.
>>>   
>>>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>>> Signed-off-by: Xiaofei Tan <tanxiaofei@huawei.com>
>>>> ---
>>>>    drivers/acpi/Makefile | 8 +++++++-
>>>>    1 file changed, 7 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
>>>> index 61ca4afe83dc..54f60b7922ad 100644
>>>> --- a/drivers/acpi/Makefile
>>>> +++ b/drivers/acpi/Makefile
>>>> @@ -15,6 +15,13 @@ endif
>>>>
>>>>    obj-$(CONFIG_ACPI)             += tables.o
>>>>
>>>> +#
>>>> +# The hed.o needs to be in front of evged.o to avoid the problem that
>>>> +# RAS errors cannot be handled in the special time window of startup
>>>> +# phase that evged has initialized while hed not.
>>>> +#
>>>> +obj-$(CONFIG_ACPI_HED)         += hed.o
>>>> +
>>>>    #
>>>>    # ACPI Core Subsystem (Interpreter)
>>>>    #
>>>> @@ -95,7 +102,6 @@ obj-$(CONFIG_ACPI_HOTPLUG_IOAPIC) += ioapic.o
>>>>    obj-$(CONFIG_ACPI_BATTERY)     += battery.o
>>>>    obj-$(CONFIG_ACPI_SBS)         += sbshc.o
>>>>    obj-$(CONFIG_ACPI_SBS)         += sbs.o
>>>> -obj-$(CONFIG_ACPI_HED)         += hed.o
>>>>    obj-$(CONFIG_ACPI_EC_DEBUGFS)  += ec_sys.o
>>>>    obj-$(CONFIG_ACPI_BGRT)                += bgrt.o
>>>>    obj-$(CONFIG_ACPI_CPPC_LIB)    += cppc_acpi.o
>>>> --
>>>> 2.33.0
>>>>   
>>> .
> .

