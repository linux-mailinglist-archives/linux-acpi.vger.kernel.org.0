Return-Path: <linux-acpi+bounces-11533-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC20FA47385
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Feb 2025 04:20:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA85B3A6185
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Feb 2025 03:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2D8C156230;
	Thu, 27 Feb 2025 03:20:14 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01E7F433C8;
	Thu, 27 Feb 2025 03:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740626414; cv=none; b=ClMav7odxlCnFIrvYfMyHWD+wj8rylx4w5xQbJ+Y1Z1QMDBi2N2LonWyWQ+tuLFMyUAieZV8eDAiKGRG4ew/xY/+q5ShfrcJpJXeyTE1uyn9bJZ+xTThkh786SlCFCcJPvSeLZh0SyA0C3HjGFnMYlb0juqJjPVMPqLIo1rcG0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740626414; c=relaxed/simple;
	bh=R1oUGUJ3OqUHv0YN/Ju4WgkqxoyLksUqGo2pit4ydF4=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=M80bLhKAsDUe+TnuiAK9GawNn2ObWG/y4ochw/gKm8mPjhzS5Rlk2X2+TLqf25wD4lEn0x3xnBs779gif/W8uzMzCU6CRrphjBSU8sHZ8U4rvoTLjaitwDjLmetvL+3xtu0IlSoAwAR4rQxqPBgN2xxYa+q8CTpaFkIXooGxzAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-3e1ff7000001d7ae-83-67bfd9e6a2cf
Message-ID: <c43c64f4-e697-468e-80af-87bd02a95ba2@sk.com>
Date: Thu, 27 Feb 2025 12:20:03 +0900
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: kernel_team@skhynix.com, gregkh@linuxfoundation.org, rakie.kim@sk.com,
 akpm@linux-foundation.org, rafael@kernel.org, lenb@kernel.org,
 dan.j.williams@intel.com, Jonathan.Cameron@huawei.com, dave.jiang@intel.com,
 horen.chuang@linux.dev, hannes@cmpxchg.org, linux-kernel@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-mm@kvack.org, kernel-team@meta.com,
 yunjeong.mun@sk.com
Subject: Re: [PATCH 2/2 v6] mm/mempolicy: Don't create weight sysfs for
 memoryless nodes
Content-Language: ko
From: Honggyu Kim <honggyu.kim@sk.com>
To: Joshua Hahn <joshua.hahnjy@gmail.com>, gourry@gourry.net,
 harry.yoo@oracle.com, ying.huang@linux.alibaba.com
References: <20250226213518.767670-1-joshua.hahnjy@gmail.com>
 <20250226213518.767670-2-joshua.hahnjy@gmail.com>
 <b8ac8654-92bd-4c08-a3fc-e28a7be5e0e6@sk.com>
In-Reply-To: <b8ac8654-92bd-4c08-a3fc-e28a7be5e0e6@sk.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFIsWRmVeSWpSXmKPExsXC9ZZnoe6zm/vTDX6d4LeYs34Nm8X0qRcY
	LU7cbGSz+Hn3OLtF8+L1bBarN/la3F/2jMXidv85VotVC6+xWRzfOo/dYt9FoIadD9+yWSzf
	189ocXnXHDaLe2v+s1rM/TKV2WL1mgwHQY/Db94ze+ycdZfdo7vtMrtHy5G3rB6L97xk8ti0
	qpPNY9OnSeweJ2b8ZvHY+dDSY2HDVGaP/XPXsHucu1jh8fHpLRaPz5vkAviiuGxSUnMyy1KL
	9O0SuDI27MoouC9VMbWtha2B8aZoFyMnh4SAicTH3q9sXYwcYPa0AwIgYV4BS4nnXU/ZQWwW
	AVWJ/193sEHEBSVOznzCAmKLCshL3L81A6iGi4NZoIVZYtKpVcwgCWGBKImdr/4ygdjMAiIS
	szvbwOJsAmoSV15OAouLCBRJHJ/xmRGkWUhgIaPErJ4HLCBHcApYSZw6zAHRaybRtbWLEcKW
	l2jeOpsZpF5C4Bq7xOynU9khHpCUOLjiBssERsFZSA6chWT3LCSzZiGZtYCRZRWjUGZeWW5i
	Zo6JXkZlXmaFXnJ+7iZGYAwvq/0TvYPx04XgQ4wCHIxKPLwR4vvThVgTy4orcw8xSnAwK4nw
	cmbuSRfiTUmsrEotyo8vKs1JLT7EKM3BoiTOa/StPEVIID2xJDU7NbUgtQgmy8TBKdXAuEJD
	47rW7e49RrxxOU83GGr8cDjVv+gc92oZ3gnBDEZ3O/Pkv82XPFTwaGvWyu3c0nIlq8W1H6w8
	98E0xrtCr3+K0uuVuXuaom1Pqfc73NeLDrBk2ChouOv5rHdum/Ut9l+6u2oBT0Abs8jR3UK7
	MiWztj7gv3J1/7SdZ2K8Zz9bYcH5V8VzvhJLcUaioRZzUXEiAOhEgyvdAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPIsWRmVeSWpSXmKPExsXCNUNLT/fpzf3pBoeWmVvMWb+GzWL61AuM
	FiduNrJZ/Lx7nN2iefF6NovVm3wt7i97xmJxu/8cq8WqhdfYLI5vncduse8iUMPhuSdZLXY+
	fMtmsXxfP6PF5V1z2CzurfnPajH3y1Rmi0PXnrNarF6TYfF72wo2BxGPw2/eM3vsnHWX3aO7
	7TK7R8uRt6wei/e8ZPLYtKqTzWPTp0nsHidm/Gbx2PnQ0mNhw1Rmj/1z17B7nLtY4fHx6S0W
	j2+3PTwWv/jA5PF5k1yAQBSXTUpqTmZZapG+XQJXxoZdGQX3pSqmtrWwNTDeFO1i5OCQEDCR
	mHZAoIuRk4NXwFLieddTdhCbRUBV4v/XHWwQcUGJkzOfsIDYogLyEvdvzQCq4eJgFmhhlph0
	ahUzSEJYIEpi56u/TCA2s4CIxOzONrA4m4CaxJWXk8DiIgJFEsdnfGYEaRYSWMgoMavnAQvI
	EZwCVhKnDnNA9JpJdG3tYoSw5SWat85mnsDINwvJHbOQrJiFpGUWkpYFjCyrGEUy88pyEzNz
	TPWKszMq8zIr9JLzczcxAqN1We2fiTsYv1x2P8QowMGoxMMbIb4/XYg1say4MvcQowQHs5II
	L2fmnnQh3pTEyqrUovz4otKc1OJDjNIcLErivF7hqQlCAumJJanZqakFqUUwWSYOTqkGRse6
	tvgfko7WarMv1GxP7ri0gSHjxrrrG5QDPP8qxaUr1/CG/67/c8pyo/UWAaEvn9IFxbLuBZVe
	fryNZcfG4Li5jyQO67o3TFyeWPFy735Ha/ZFriVVSuo26aHNH08lL/ryJtCj8f2zYFkebq22
	pdNurJjk89+w4o/Y74y+BPk+hyX87ifUlViKMxINtZiLihMBTgQItdICAAA=
X-CFilter-Loop: Reflected



On 2/27/2025 11:32 AM, Honggyu Kim wrote:
> Hi Joshua,
> 
> On 2/27/2025 6:35 AM, Joshua Hahn wrote:
>> We should never try to allocate memory from a memoryless node. Creating a
>> sysfs knob to control its weighted interleave weight does not make sense,
>> and can be unsafe.
>>
>> Only create weighted interleave weight knobs for nodes with memory.
>>
>> Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
>> ---
>>   mm/mempolicy.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
>> index 4cc04ff8f12c..50cbb7c047fa 100644
>> --- a/mm/mempolicy.c
>> +++ b/mm/mempolicy.c
>> @@ -3721,7 +3721,7 @@ static int add_weighted_interleave_group(struct 
>> kobject *root_kobj)
>>           return err;
>>       }
>> -    for_each_node_state(nid, N_POSSIBLE) {
> 
> Actually, we're aware of this issue and currently trying to fix this.
> In our system, we've attached 4ch of CXL memory for each socket as
> follows.
> 
>          node0             node1
>        +-------+   UPI   +-------+
>        | CPU 0 |-+-----+-| CPU 1 |
>        +-------+         +-------+
>        | DRAM0 |         | DRAM1 |
>        +---+---+         +---+---+
>            |                 |
>        +---+---+         +---+---+
>        | CXL 0 |         | CXL 4 |
>        +---+---+         +---+---+
>        | CXL 1 |         | CXL 5 |
>        +---+---+         +---+---+
>        | CXL 2 |         | CXL 6 |
>        +---+---+         +---+---+
>        | CXL 3 |         | CXL 7 |
>        +---+---+         +---+---+
>          node2             node3
> 
> The 4ch of CXL memory are detected as a single NUMA node in each socket,
> but it shows as follows with the current N_POSSIBLE loop.
> 
> $ ls /sys/kernel/mm/mempolicy/weighted_interleave/
> node0 node1 node2 node3 node4 node5
> node6 node7 node8 node9 node10 node11
> 
>> +    for_each_node_state(nid, N_MEMORY) {

Thinking it again, we can leave it as a separate patch but add our patch 
on top of it.

The only concern I have is having only N_MEMORY patch hides weight
setting knobs for CXL memory and it makes there is no way to set weight 
values to CXL memory in my system.

IMHO, this and our patch is better to be submitted together.

Thanks,
Honggyu

> 
> But using N_MEMORY doesn't fix this problem and it hides the entire CXL
> memory nodes in our system because the CXL memory isn't detected at this
> point of creating node*.  Maybe there is some difference when multiple
> CXL memory is detected as a single node.
> 
> We have to create more nodes when CXL memory is detected later.  In 
> addition, this part can be changed to "for_each_online_node(nid)"
> although N_MEMORY is also fine here.
> 
> We've internally fixed it using a memory hotpluging callback so we can
> upload another working version later.
> 
> Do you mind if we continue fixing this work?
> 
> Thanks,
> Honggyu
> 
>>           err = add_weight_node(nid, wi_kobj);
>>           if (err) {
>>               pr_err("failed to add sysfs [node%d]\n", nid);
> 


