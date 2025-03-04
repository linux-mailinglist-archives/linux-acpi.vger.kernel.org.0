Return-Path: <linux-acpi+bounces-11765-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2335A4DE61
	for <lists+linux-acpi@lfdr.de>; Tue,  4 Mar 2025 13:53:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C4B63B142A
	for <lists+linux-acpi@lfdr.de>; Tue,  4 Mar 2025 12:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D0631FFC74;
	Tue,  4 Mar 2025 12:53:27 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F961FF605;
	Tue,  4 Mar 2025 12:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741092807; cv=none; b=eFuk/PTEBDDQmHC++qMETrtFKcDFgx9GB3AEq9ZiWbwyoDpSk6+kfEzzsRcDgK6r5Ot6Irt2vcSN6K0AwPtrrSRHHpfPlexvOF+LSaJ3AK+InvaXqdayHeOJUVyPJCjK4TcaqF4aT/qQbJKthIS9ZifOA1U8NkyjrGu2TvjuIoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741092807; c=relaxed/simple;
	bh=k7rFah0C8AqcVxALjvT6enFaV3UT2iSy6VtvbL4WNsc=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Fi3nPBo+JGo/EjPymAJi3p4P9s+lUZXcTOakinuQVpqIpNUdI9T6KExENYM26zoNrMlyqHax2YpDkdOeM4etS6xPIzv5fHahk0SVLHZHsIRj4K8Un0R4a+yIw4Cp2WXeTfIlbjI8BAxsUU9PQ0hLArbFLOGRaf5dt560fJq4ZA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-3c9ff7000001d7ae-95-67c6f7bab570
Message-ID: <b049e0d8-a9d2-456f-aa97-148f4a6d8071@sk.com>
Date: Tue, 4 Mar 2025 21:53:13 +0900
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: kernel_team@skhynix.com, gourry@gourry.net, harry.yoo@oracle.com,
 ying.huang@linux.alibaba.com, gregkh@linuxfoundation.org, rakie.kim@sk.com,
 akpm@linux-foundation.org, rafael@kernel.org, lenb@kernel.org,
 dan.j.williams@intel.com, Jonathan.Cameron@huawei.com, dave.jiang@intel.com,
 horen.chuang@linux.dev, hannes@cmpxchg.org, linux-kernel@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-mm@kvack.org, kernel-team@meta.com,
 yunjeong.mun@sk.com
Subject: Re: [PATCH 2/2 v6] mm/mempolicy: Don't create weight sysfs for
 memoryless nodes
To: Joshua Hahn <joshua.hahnjy@gmail.com>
References: <20250303215638.317539-1-joshua.hahnjy@gmail.com>
Content-Language: ko
From: Honggyu Kim <honggyu.kim@sk.com>
In-Reply-To: <20250303215638.317539-1-joshua.hahnjy@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNIsWRmVeSWpSXmKPExsXC9ZZnoe6u78fSDTYcFrGYs34Nm8X0qRcY
	LU7cbGSz+Hn3OLtF8+L1bBarN/la3F/2jMXidv85VotVC6+xWRzfOo/dYt9FoIadD9+yWSzf
	189ocXnXHDaLe2v+s1rM/TKV2WL1mgwHQY/Db94ze+ycdZfdo7vtMrtHy5G3rB6L97xk8ti0
	qpPNY9OnSeweJ2b8ZvHY+dDSY2HDVGaP/XPXsHucu1jh8fHpLRaPz5vkAviiuGxSUnMyy1KL
	9O0SuDK+HT3HVLBRo+Jvzz6WBsblCl2MnBwSAiYSGx+sZ4Gx/9z5yQxi8wpYSsy+f58NxGYR
	UJF4tu8EC0RcUOLkzCdgtqiAvMT9WzPYuxi5OJgFzjJLnJ67hwkkISwQJbHz1V8wW0RAU+JE
	6ySwoUICthLzHr4As5kFRCRmd7aB2WwCahJXXk4Cqufg4BSwk9jwVxGixEyia2sXI4QtL9G8
	dTYzyC4JgUvsEqdWTGOCOFpS4uCKGywTGAVnIblvFpIVs5DMmoVk1gJGllWMQpl5ZbmJmTkm
	ehmVeZkVesn5uZsYgVG8rPZP9A7GTxeCDzEKcDAq8fCeWHA0XYg1say4MvcQowQHs5IIr+nn
	Y+lCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeY2+lacICaQnlqRmp6YWpBbBZJk4OKUaGCeopwXX
	bH79cSlnVt7M5sw9s/4qLNmn+Dhi1ppFSgVam8XnTHqkzf6rQ2GlGdduTfcpVaxT6wwfvmq7
	W3Dn1VOx1MBtv33y3v9881cwa+O3eM09d/3b9uq/WOIVxfTg1ZzfTiKRa62Z7s+dJnn5Piv/
	wyalLPNNLvY8JSITXqkwd05TzPNY812JpTgj0VCLuag4EQC5tL5S3gIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPIsWRmVeSWpSXmKPExsXCNUNLT3fX92PpBmsLLOasX8NmMX3qBUaL
	Ezcb2Sx+3j3ObtG8eD2bxepNvhb3lz1jsbjdf47VYtXCa2wWx7fOY7fYdxGo4fDck6wWOx++
	ZbNYvq+f0eLyrjlsFvfW/Ge1mPtlKrPFoWvPWS1Wr8mw+L1tBZuDiMfhN++ZPXbOusvu0d12
	md2j5chbVo/Fe14yeWxa1cnmsenTJHaPEzN+s3jsfGjpsbBhKrPH/rlr2D3OXazw+Pj0FovH
	t9seHotffGDy+LxJLkAgissmJTUnsyy1SN8ugSvj29FzTAUbNSr+9uxjaWBcrtDFyMkhIWAi
	8efOT2YQm1fAUmL2/ftsIDaLgIrEs30nWCDighInZz4Bs0UF5CXu35rB3sXIxcEscJZZ4vTc
	PUwgCWGBKImdr/6C2SICmhInWieBDRUSsJWY9/AFmM0sICIxu7MNzGYTUJO48nISUD0HB6eA
	ncSGv4oQJWYSXVu7GCFseYnmrbOZJzDyzUJyxiwkk2YhaZmFpGUBI8sqRpHMvLLcxMwcU73i
	7IzKvMwKveT83E2MwGhdVvtn4g7GL5fdDzEKcDAq8fAa3D2WLsSaWFZcmXuIUYKDWUmE1/Qz
	UIg3JbGyKrUoP76oNCe1+BCjNAeLkjivV3hqgpBAemJJanZqakFqEUyWiYNTqoGRW2eWgGO8
	/J7yRfkuK84J5Ot+Krl+bRXDo2eiAqKSXl11RSbx15cpFMaxLaxj/q64/Sv/83WfP7oe/aN/
	OFzeTu+ditqp9rfvwxdcvsc/8aPyjNDdbk9sdzlrJZZfq+o70FYlEcJh3uAUZagh5flK8/kM
	jfP3Xl/8dcFr0TLBl/4tN86LL1JRYinOSDTUYi4qTgQAHB2/vdICAAA=
X-CFilter-Loop: Reflected

Hi Joshua,

On 3/4/2025 6:56 AM, Joshua Hahn wrote:
> On Thu, 27 Feb 2025 12:20:03 +0900 Honggyu Kim <honggyu.kim@sk.com> wrote:
> 
> Hi Honggyu, thank you for taking time to review my patch, as always!

My pleasure!

> I thought I had sent this, but it seems like it was left in my draft
> without being sent.
> 
> I will follow Gregory's advice and we will drop the patch from this series,
> and send the first patch only (with Yunjeong's changes). Thanks again!

It'd be great if you could add her with the following.
Co-developed-by: Yunjeong Mun <yunjeong.mun@sk.com>

> 
>>
>> On 2/27/2025 11:32 AM, Honggyu Kim wrote:
>>> Hi Joshua,
>>>
>>> On 2/27/2025 6:35 AM, Joshua Hahn wrote:
>>>> We should never try to allocate memory from a memoryless node. Creating a
>>>> sysfs knob to control its weighted interleave weight does not make sense,
>>>> and can be unsafe.
>>>>
>>>> Only create weighted interleave weight knobs for nodes with memory.
>>>>
>>>> Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
>>>> ---
>>>>    mm/mempolicy.c | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
>>>> index 4cc04ff8f12c..50cbb7c047fa 100644
>>>> --- a/mm/mempolicy.c
>>>> +++ b/mm/mempolicy.c
>>>> @@ -3721,7 +3721,7 @@ static int add_weighted_interleave_group(struct
>>>> kobject *root_kobj)
>>>>            return err;
>>>>        }
>>>> -    for_each_node_state(nid, N_POSSIBLE) {
>>>
>>> Actually, we're aware of this issue and currently trying to fix this.
>>> In our system, we've attached 4ch of CXL memory for each socket as
>>> follows.
>>>
>>>           node0             node1
>>>         +-------+   UPI   +-------+
>>>         | CPU 0 |-+-----+-| CPU 1 |
>>>         +-------+         +-------+
>>>         | DRAM0 |         | DRAM1 |
>>>         +---+---+         +---+---+
>>>             |                 |
>>>         +---+---+         +---+---+
>>>         | CXL 0 |         | CXL 4 |
>>>         +---+---+         +---+---+
>>>         | CXL 1 |         | CXL 5 |
>>>         +---+---+         +---+---+
>>>         | CXL 2 |         | CXL 6 |
>>>         +---+---+         +---+---+
>>>         | CXL 3 |         | CXL 7 |
>>>         +---+---+         +---+---+
>>>           node2             node3
>>>
>>> The 4ch of CXL memory are detected as a single NUMA node in each socket,
>>> but it shows as follows with the current N_POSSIBLE loop.
>>>
>>> $ ls /sys/kernel/mm/mempolicy/weighted_interleave/
>>> node0 node1 node2 node3 node4 node5
>>> node6 node7 node8 node9 node10 node11

FYI, we used to set node2 and node3 only for weights for CXL memory here
and ignored node{4-11}.  That sounds silly but it worked.

> 
> I see. For my education, would you mind explaining how the numbering works
> here? I am not very familiar with this setup, and not sure how you would
> figure out what node is which, just by looking at the numbering.

Regarding the numbering, I'm not 100% sure, but I guess there could be a
logical NUMA node that combines 4ch of CXL memory and 4 nodes for CXL 
memory so in total 5 nodes per socket.

I don't have much knowledge on this but maybe this is related to PXM
(Proximity Domain).

> 
>>>> +    for_each_node_state(nid, N_MEMORY) {
>>
>> Thinking it again, we can leave it as a separate patch but add our patch
>> on top of it.
> 
> That sounds good to me.
> 
>> The only concern I have is having only N_MEMORY patch hides weight
>> setting knobs for CXL memory and it makes there is no way to set weight
>> values to CXL memory in my system.
> 
> You can use weighted interleave auto-tuning : -)

Not possible because using N_MEMORY doesn't provide "node" knobs for CXL
memory at all as follows.

$ ls /sys/kernel/mm/mempolicy/weighted_interleave/
node0 node1

We need node2 and node3 for CXL memory here.

> In all seriousness, this makes sense. It seems pretty problematic that
> the knobs aren't created for the CXL channels,

Yeah, it's even worse than the current status.

> and I'm not sure that hiding> it is the correct approach here (it was not my intent, either).

It isn't your problem but we shouldn't hide those nodes until it is
correctly fixed with hot plugging event handler.

> 
>> IMHO, this and our patch is better to be submitted together.
> 
> That sounds good. We can hold off on this patch then, and just consider
> the first patch of this series. Thank you for letting me know!

The N_POSSIBLE and N_MEMORY stuffs should had been fixed earlier than
this work. I will take a few days if we can submit it together.

> 
> Thank you for always reviewing my patches. Have a great day!
> Joshua

Thanks for your work and have a great day you too!

Kind regards,
Honggyu

> 
> Sent using hkml (https://github.com/sjp38/hackermail)
> 


