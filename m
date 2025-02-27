Return-Path: <linux-acpi+bounces-11532-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A334EA47306
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Feb 2025 03:36:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07D613ADA26
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Feb 2025 02:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42AF91B0425;
	Thu, 27 Feb 2025 02:32:38 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2CBE17A2F7;
	Thu, 27 Feb 2025 02:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740623558; cv=none; b=P7/RXIYU9ALKoQydZAIW5dBzEfo5hZvIAjAZQwc6s+gmwu5tLoOrhQuRTb9g/cYkHlawLB0vPgbHwfxhRNu73DTj+iGUi9GBh920VKjVvT+232tEHV5DUA4GZbgBpbERUybb2O0cl6o2Wds+MTmWwwp8xzh+FjDoQ2Icq1fLU9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740623558; c=relaxed/simple;
	bh=rcZzV1+yyOYgRs0JzYcXNOpIDUWuhSnP4b3WaJ28ETQ=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=fTawSKTYCOXgwROa3z09JlANqhlA2t8SZcZSc/g7mkhX4Pg2/BmnP4JJG8swpadvwNv0R6EhLCfLTnW2IyWubD2lm/FsK5Ce0TeZg3nS0F4az79lJMPaX/w/5xQK9TRVp8a+DKpYexB50HtNl4qlNx0XIll8TypDfg6kjCl0XKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-3e1ff7000001d7ae-21-67bfcebd10c6
Message-ID: <b8ac8654-92bd-4c08-a3fc-e28a7be5e0e6@sk.com>
Date: Thu, 27 Feb 2025 11:32:26 +0900
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
To: Joshua Hahn <joshua.hahnjy@gmail.com>, gourry@gourry.net,
 harry.yoo@oracle.com, ying.huang@linux.alibaba.com
References: <20250226213518.767670-1-joshua.hahnjy@gmail.com>
 <20250226213518.767670-2-joshua.hahnjy@gmail.com>
From: Honggyu Kim <honggyu.kim@sk.com>
In-Reply-To: <20250226213518.767670-2-joshua.hahnjy@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNIsWRmVeSWpSXmKPExsXC9ZZnoe7ec/vTDZZcMbeYs34Nm8X0qRcY
	LU7cbGSz+Hn3OLtF8+L1bBarN/la3F/2jMXidv85VotVC6+xWRzfOo/dYt9FoIadD9+yWSzf
	189ocXnXHDaLe2v+s1rM/TKV2WL1mgwHQY/Db94ze+ycdZfdo7vtMrtHy5G3rB6L97xk8ti0
	qpPNY9OnSeweJ2b8ZvHY+dDSY2HDVGaP/XPXsHucu1jh8fHpLRaPz5vkAviiuGxSUnMyy1KL
	9O0SuDLmX9vMWtArUrFvk2wD4yy+LkZODgkBE4l/H1oZYey3u7ewg9i8ApYS2zd9YQKxWQRU
	Ja437GGBiAtKnJz5BMwWFZCXuH9rBlA9FwezQAuzxKRTq5hBEsICURI7X/0Fa2YWEJGY3dkG
	FhcRKJI4PuMz2DIhgUKJq3v7wWw2ATWJKy8ngdVzCthJfP/XwALRaybRtbWLEcKWl9j+dg4z
	yDIJgUvsEgc6trNAXC0pcXDFDZYJjIKzkBw4C8nuWUhmzUIyawEjyypGocy8stzEzBwTvYzK
	vMwKveT83E2MwCheVvsnegfjpwvBhxgFOBiVeHgjxPenC7EmlhVX5h5ilOBgVhLh5czcky7E
	m5JYWZValB9fVJqTWnyIUZqDRUmc1+hbeYqQQHpiSWp2ampBahFMlomDU6qBccnziKnchY8+
	tHfVqh6SqeN0jzQoyNpnMuO+9lwj1t6b9zzSdQx/T/i48V6n7oI1z2+d59q69//2KXd/N7G2
	/L9+sOjl4ZMvDrjKqCr90/WZI/JO/9SCR5f1xSz1k6Jsd+XPPVe0bOq6z3a2kR9+SPhKspy4
	/OT39u3+Ll8mCKot1Xq+bOvM5SFKLMUZiYZazEXFiQC7PhKr3gIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrAIsWRmVeSWpSXmKPExsXCNUNLT3fvuf3pBjc6dCzmrF/DZjF96gVG
	ixM3G9ksft49zm7RvHg9m8XqTb4W95c9Y7G43X+O1WLVwmtsFse3zmO32HcRqOHw3JOsFjsf
	vmWzWL6vn9Hi8q45bBb31vxntZj7ZSqzxaFrz1ktVq/JsPi9bQWbg4jH4TfvmT12zrrL7tHd
	dpndo+XIW1aPxXteMnlsWtXJ5rHp0yR2jxMzfrN47Hxo6bGwYSqzx/65a9g9zl2s8Pj49BaL
	x7fbHh6LX3xg8vi8SS5AIIrLJiU1J7MstUjfLoErY/61zawFvSIV+zbJNjDO4uti5OSQEDCR
	eLt7CzuIzStgKbF90xcmEJtFQFXiesMeFoi4oMTJmU/AbFEBeYn7t2YA1XNxMAu0MEtMOrWK
	GSQhLBAlsfPVX7BmZgERidmdbWBxEYEiieMzPjOC2EIChRJX9/aD2WwCahJXXk4Cq+cUsJP4
	/q+BBaLXTKJraxcjhC0vsf3tHOYJjHyzkNwxC8mKWUhaZiFpWcDIsopRJDOvLDcxM8dUrzg7
	ozIvs0IvOT93EyMwXpfV/pm4g/HLZfdDjAIcjEo8vBHi+9OFWBPLiitzDzFKcDArifByZu5J
	F+JNSaysSi3Kjy8qzUktPsQozcGiJM7rFZ6aICSQnliSmp2aWpBaBJNl4uCUamDMFIib5Gk3
	k5v/NMe01Yfnavur5qyY2/HmNfv3R00Khz+rP+XhKHrPlqjX1Ll9VbjBkd8bA/PtCiV5Vz3S
	4Wb4W9R1oGyRnd4P1oPnNv+POnuQdR0L69YdRT9ufd3+d+WVOcdM9/pKPVEQUvjVxbSp5mCu
	6hRpH/n/NxdWm7h+W+tdcHrNxZnWSizFGYmGWsxFxYkAqqI149MCAAA=
X-CFilter-Loop: Reflected

Hi Joshua,

On 2/27/2025 6:35 AM, Joshua Hahn wrote:
> We should never try to allocate memory from a memoryless node. Creating a
> sysfs knob to control its weighted interleave weight does not make sense,
> and can be unsafe.
> 
> Only create weighted interleave weight knobs for nodes with memory.
> 
> Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
> ---
>   mm/mempolicy.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index 4cc04ff8f12c..50cbb7c047fa 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -3721,7 +3721,7 @@ static int add_weighted_interleave_group(struct kobject *root_kobj)
>   		return err;
>   	}
>   
> -	for_each_node_state(nid, N_POSSIBLE) {

Actually, we're aware of this issue and currently trying to fix this.
In our system, we've attached 4ch of CXL memory for each socket as
follows.

         node0             node1
       +-------+   UPI   +-------+
       | CPU 0 |-+-----+-| CPU 1 |
       +-------+         +-------+
       | DRAM0 |         | DRAM1 |
       +---+---+         +---+---+
           |                 |
       +---+---+         +---+---+
       | CXL 0 |         | CXL 4 |
       +---+---+         +---+---+
       | CXL 1 |         | CXL 5 |
       +---+---+         +---+---+
       | CXL 2 |         | CXL 6 |
       +---+---+         +---+---+
       | CXL 3 |         | CXL 7 |
       +---+---+         +---+---+
         node2             node3

The 4ch of CXL memory are detected as a single NUMA node in each socket,
but it shows as follows with the current N_POSSIBLE loop.

$ ls /sys/kernel/mm/mempolicy/weighted_interleave/
node0 node1 node2 node3 node4 node5
node6 node7 node8 node9 node10 node11

> +	for_each_node_state(nid, N_MEMORY) {

But using N_MEMORY doesn't fix this problem and it hides the entire CXL
memory nodes in our system because the CXL memory isn't detected at this
point of creating node*.  Maybe there is some difference when multiple
CXL memory is detected as a single node.

We have to create more nodes when CXL memory is detected later.  In 
addition, this part can be changed to "for_each_online_node(nid)"
although N_MEMORY is also fine here.

We've internally fixed it using a memory hotpluging callback so we can
upload another working version later.

Do you mind if we continue fixing this work?

Thanks,
Honggyu

>   		err = add_weight_node(nid, wi_kobj);
>   		if (err) {
>   			pr_err("failed to add sysfs [node%d]\n", nid);


