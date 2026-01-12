Return-Path: <linux-acpi+bounces-20189-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6536FD123B2
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Jan 2026 12:19:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DA95C3018340
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Jan 2026 11:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D225B3563E0;
	Mon, 12 Jan 2026 11:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="OhLvrOHc"
X-Original-To: linux-acpi@vger.kernel.org
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817B335502B;
	Mon, 12 Jan 2026 11:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768216753; cv=none; b=U0ZzgtFCmDxPZKDWAOrv8HEauMvWNQFRjG56NduKAqeLggo53iJqElEMopUpMml/QeOj4ItIldeNbhXmPNMzJ82WclxRwNL/jsoEPl3zQZYP0FJjoJkn6erG54EAtbYSy5PxNtgg1ZkhMa1MiXBljRlURSmXxEYgp2KSZJYGEik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768216753; c=relaxed/simple;
	bh=WxyNRiGuG01AOiq2H4pBiKTl9CaYpO4P89RF2V4ZbnY=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=byllFCWfyrHw2sjMAxDkvNimeFPlPt208a//pFVG4OdfLb3BlY4qpXODPbHKT7XRg7YvmVZ6bKC5QA6dXkYZmiLI3TW+GVebFGEIRe7MIpUz0GaamKEM/hlgo+QdoAtUb9yHLTrwY3O2YsgTxlMbjMWcWVEAoEB4nar6kfG8H6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=OhLvrOHc; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=NdZJLToY2Ej4OvZBaUkPm/IoNabzNjVOg9KJ0nKt4xc=;
	b=OhLvrOHcODqkHK5yEVvd9ipUetPEw1hlno/DfSxW4j+OHCtv3znUX8KZkXwtB3D8A2Of2e0S7
	/+XqGjTKfcZcwZqnTVVCYNP2C/tYEP3BtHJl1Z696VkoH3HgRIIgJ9Wf/mOYcXdB32tcHY7nOyt
	QfMz3UJC1xfJzhSc2kH+Fbc=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4dqVD00b0gzcZyc;
	Mon, 12 Jan 2026 19:15:28 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 2DD794056E;
	Mon, 12 Jan 2026 19:19:09 +0800 (CST)
Received: from [10.174.178.247] (10.174.178.247) by
 dggpemf500002.china.huawei.com (7.185.36.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 12 Jan 2026 19:19:08 +0800
Subject: Re: [PATCH v2] ACPI: PPTT: Dump PPTT table when error detected
To: Feng Tang <feng.tang@linux.alibaba.com>
CC: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Jeremy Linton <jeremy.linton@arm.com>, James Morse <james.morse@arm.com>,
	Joanthan Cameron <Jonathan.Cameron@huawei.com>, Sudeep Holla
	<sudeep.holla@arm.com>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20251231104909.80362-1-feng.tang@linux.alibaba.com>
 <8358233d-cfcd-451f-319a-f7b27743faa1@huawei.com>
 <aWJqhuhuQUAKMDpF@U-2FWC9VHC-2323.local>
From: Hanjun Guo <guohanjun@huawei.com>
Message-ID: <152465d1-08cc-898e-8ed7-9b603faaabc5@huawei.com>
Date: Mon, 12 Jan 2026 19:19:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <aWJqhuhuQUAKMDpF@U-2FWC9VHC-2323.local>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 dggpemf500002.china.huawei.com (7.185.36.57)

On 2026/1/10 23:04, Feng Tang wrote:
> Hi Hanjun,
> 
[...]
>>>
>>> It provides a global and straightforward view of the hierarchy of the
>>> processor and caches info of the platform, and from the offset info
>>> (the 3rd column), the child-parent relation could be checked.
>>>
>>> With this, the root cause of the original issue was pretty obvious,
>>> that there were some caches items missing which caused the issue when
>>> building up scheduler domain.
>>
>> Just a discussion, can we just dump the raw PPTT table via acpidump
>> in user space when we meet the problem? With the raw PPTT table, we
>> can go though the content to see if we have problems.
> 
> Good point! We can use iasl to decode the PPTT table. And this dump
> is still useful as:
> * when enabling new silicon or new firmware (APCI tables), sometimes it
>    can't make to boot to user space when the issue happens.
> * This dump shows the processor and cache items separately and cleanly,
>    while the P[]/C[] index imply the numbers. In an 128 core product ARM
>    sever, the print with this patch is about 500 line, while the acpidump
>    is about 10,000 lines and harder to parse.

Thanks for the user case, it makes sense to me.

> 
[...]
>>>    /**
>>>     * topology_get_acpi_cpu_tag() - Find a unique topology value for a feature
>>>     * @table: Pointer to the head of the PPTT table
>>> @@ -565,6 +638,8 @@ static int topology_get_acpi_cpu_tag(struct acpi_table_header *table,
>>>    	}
>>>    	pr_warn_once("PPTT table found, but unable to locate core %d (%d)\n",
>>>    		    cpu, acpi_cpu_id);
>>> +
>>> +	acpi_dump_pptt_table(table);
>>
>> I think it would be good to dump it as needed, as a debug feature.
> 
> Makes sense to me. Should I add a kernel config option or a module
> parameter for it, or just change the pr_info to pr_debug (it's in
> a unlikely error path)?

PPTT driver can not be compiled as a module, I would like to add a
kernel config for it.

Thanks
Hanjun

