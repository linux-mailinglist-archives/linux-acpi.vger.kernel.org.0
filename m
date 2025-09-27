Return-Path: <linux-acpi+bounces-17367-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 219DFBA5850
	for <lists+linux-acpi@lfdr.de>; Sat, 27 Sep 2025 04:55:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FEE81C06D50
	for <lists+linux-acpi@lfdr.de>; Sat, 27 Sep 2025 02:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE27F20A5E5;
	Sat, 27 Sep 2025 02:55:53 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3372017996;
	Sat, 27 Sep 2025 02:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758941753; cv=none; b=iq0flI3yDRpku1etTufp6/JmCn+N6w2BQTsLYo/P3kQBb4TGl1hjeGHgGxmAZbV/6/nHmDx0EWLO4E0RvG1PcdT3KOridudESwPMi2WbADvKxdBRELisDeo9vWNGya86B5FW2miKuLkJ5FXfRp08qXi6doV9Th/idCSt6TCokes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758941753; c=relaxed/simple;
	bh=Rv0N7J37HFHOwbWTV8VxmztIRCujr9xCLL4FoSP2rts=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=ngClFgTBpouXwzuem02eWsuG3xcLzscfmdYGic1CnV48qYmfKHsDRzE3E9ylmdNd2n+uoSGC1Nuj25BZ1LLDtPxWzWxlmHiWMrEBwAu5eGKOhewizZk+N6pe8VCGsatHjqaisrpBrFafD7weiFWsPvJoWf7XVbpr77g3sYh3Tgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4cYX7C19WHz1R8ds;
	Sat, 27 Sep 2025 10:52:39 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 48E7114011F;
	Sat, 27 Sep 2025 10:55:49 +0800 (CST)
Received: from [10.174.178.247] (10.174.178.247) by
 dggpemf500002.china.huawei.com (7.185.36.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 27 Sep 2025 10:55:48 +0800
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
From: Hanjun Guo <guohanjun@huawei.com>
Message-ID: <3bbdc50e-a55c-96ed-a8db-6bbce1760ee4@huawei.com>
Date: Sat, 27 Sep 2025 10:55:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <TY3PR01MB9983025D434CAA2CDF83656BD511A@TY3PR01MB9983.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 dggpemf500002.china.huawei.com (7.185.36.57)

On 2025/9/19 13:05, Kazuhiro Abe (Fujitsu) wrote:
> Hi Hanjun & Sudeep
> 
>> Hi Ilkka
>>
>>> Hi Kazuhiro,
>>>
>>> On Fri, 5 Sep 2025, Kazuhiro Abe wrote:
>>>> AGDI has two types of signaling modes: SDEI and interrupt.
>>>> Currently, the AGDI driver only supports SDEI.
>>>> Therefore, add support for interrupt signaling mode The interrupt
>>>> vector is retrieved from the AGDI table, and call panic function
>>>> when an interrupt occurs.
>>>>
>>>> Signed-off-by: Kazuhiro Abe <fj1078ii@aa.jp.fujitsu.com>
>>>
>>>
>>> Looks good to me.
>>>
>>> Reviewed-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
>>>
>>
>> Thanks for your review.
>>
>> Best Regards,
>> Kazuhiro Abe
>>
>>>
>>> Hanjun & Sudeep, what's your thought on enabling the use of regular
>>> interrupts here? I do agree the spec talks about non-maskable ones and
>>> to my understanding that's what the idea was indeed.
> 
> Do you have any thoughts on this matter?

For the real use case, if the system is in failure state, for example,
the system is panic, the CPU will not handle regular interrupts, so
what's the use case do you have to use regular interrupt?

Thanks
Hanjun

