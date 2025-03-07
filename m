Return-Path: <linux-acpi+bounces-11926-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CCBA6A56704
	for <lists+linux-acpi@lfdr.de>; Fri,  7 Mar 2025 12:46:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12DD01897D48
	for <lists+linux-acpi@lfdr.de>; Fri,  7 Mar 2025 11:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87C47211A29;
	Fri,  7 Mar 2025 11:46:55 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B829D20C46C;
	Fri,  7 Mar 2025 11:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741348015; cv=none; b=GHh2f9vyzE5w/SBSHPbEqLsi3UPsdpvzxKFhvKg52bPiabODisiid3Si/yfo2K78+D+zZxaN/p/18NnQmmHGOp4SbPot+IYSK433SuvtuieTFlnv88eK+fcLsdG/cPhNT8MQ6svNDcB1afiDf5LjBTNBNqgqOl8vzmZp1DNY9Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741348015; c=relaxed/simple;
	bh=AL9cZoRUfEXtZJtSLQC01WQ7USliEeAxH9nTF54vJyA=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Maxjh7Ivw6stjBHDpocyU7BUrrXpUwfDxLzUmFLvJvDenW8PA9GSlgedlT5NFJlGUyS0MJrWgOi4ON/Ue6kQGg2Ecw5DnQjipyW8SCeCe2CuImK+VXRzIqcjbZBKB5unPCw5cgNgHNCTRMOdCDHhgqqa96sBJwWqTn40qSTCVV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-3c9ff7000001d7ae-50-67cadca6c5cc
Message-ID: <9c0d8aa8-cac7-4679-aece-af88e8129345@sk.com>
Date: Fri, 7 Mar 2025 20:46:46 +0900
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: kernel_team@skhynix.com, Joshua Hahn <joshua.hahnjy@gmail.com>,
 harry.yoo@oracle.com, ying.huang@linux.alibaba.com,
 gregkh@linuxfoundation.org, rakie.kim@sk.com, akpm@linux-foundation.org,
 rafael@kernel.org, lenb@kernel.org, dan.j.williams@intel.com,
 Jonathan.Cameron@huawei.com, dave.jiang@intel.com, horen.chuang@linux.dev,
 hannes@cmpxchg.org, linux-kernel@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-mm@kvack.org, kernel-team@meta.com,
 yunjeong.mun@sk.com
Subject: Re: [PATCH 2/2 v6] mm/mempolicy: Don't create weight sysfs for
 memoryless nodes
Content-Language: ko
To: Gregory Price <gourry@gourry.net>
References: <20250226213518.767670-1-joshua.hahnjy@gmail.com>
 <20250226213518.767670-2-joshua.hahnjy@gmail.com>
 <b8ac8654-92bd-4c08-a3fc-e28a7be5e0e6@sk.com>
 <Z8cqe3BCdobsV4-2@gourry-fedora-PF4VCD3F>
 <f64819e2-8dc6-4907-b8bf-faec66eecd0e@sk.com>
 <Z8ncOp2H54WE4C5s@gourry-fedora-PF4VCD3F>
From: Honggyu Kim <honggyu.kim@sk.com>
In-Reply-To: <Z8ncOp2H54WE4C5s@gourry-fedora-PF4VCD3F>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNIsWRmVeSWpSXmKPExsXC9ZZnoe6yO6fSDbpX61rMWb+GzWL61AuM
	FiduNrJZ/Lx7nN2iefF6NovVm3wt7i97xmJxu/8cq8WqhdfYLI5vncduse8iUMPOh2/ZLJbv
	62e0uLxrDpvFvTX/WS3mfpnKbLF6TYaDoMfhN++ZPXbOusvu0d12md2j5chbVo/Fe14yeWxa
	1cnmsenTJHaPEzN+s3jsfGjpsbBhKrPH/rlr2D3OXazw+Pj0FovH501yAXxRXDYpqTmZZalF
	+nYJXBk9R3YzFSxTq/j0YQdjA+McmS5GTg4JAROJ3hcT2GHsl3fuMILYvAKWEjv/n2XpYuTg
	YBFQkZjSGQARFpQ4OfMJC4gtKiAvcf/WDKBWLg5mgcfMEp/udDGDJIQFoiR2vvrLBGIzC4hI
	zO5sYwaZIyKgKtF2xR2kXkhgJZNEz64rYHvZBNQkrrycBFbPKWAmMef6AVaIXjOJrq1djBC2
	vMT2t3OYQZolBG6xS7Tvn8UGcbSkxMEVN1gmMArOQnLgLCS7ZyGZNQvJrAWMLKsYhTLzynIT
	M3NM9DIq8zIr9JLzczcxAqN4We2f6B2Mny4EH2IU4GBU4uH1mHoyXYg1say4MvcQowQHs5II
	r9r2U+lCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeY2+lacICaQnlqRmp6YWpBbBZJk4OKUaGC2Z
	j710E5gYlhNrJfTTWfMy2wa9l+pS3e3OWomq89p2bvb4lBTj8+1Ly6zcEyEdX+fVftyx3PB0
	j/DL244VZ5S+BrQf3FrzXO7QLi2h4r68q4uvH5NY4Jjwf82kpPPb84z6HB0+awYtluM+0357
	XirLLtuKS2bTD3ox5OzY8kFbYdFGlwm/45VYijMSDbWYi4oTAVbdux/eAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02RbUhTYRTHeXbv7r1bLq5r5YOVwjIhSc1IeYyISMknQ/Fb4Re95GVbzhc2
	G1MaGKnlNEzRsjVDE1bpQhjonJUOZ+mMLJks0pmM3lQa2ZRKTMwlgd9+nPP/nXPgMITUSUYy
	quIyXlPMqeWUmBS3xiXEW3zjiiOu7ihk7rFS6E7LW4DG3l+l0OrsKI2udfZQqNuWheYsX0g0
	0zAhRF0dXgqN9t6n0eDkpuBqcwuRwx+g0MPBBoA8A2YKfbBuCFHbSguBhr1fhajbqkRrfY+o
	UzLs+vadwA7TLI3rajw0rhoJCHHnswUBtnXVUtgWbKLxWOsaiR3+VNxR2ULgoTYrjScm9fjH
	52kS/5zBuHN+SYCXbVE5bK74RAGvVul4TeLJfLGyfuSpoNQSqw8u9YNKYN5nBCIGssfggs8H
	QixhU6Fj4zVpBAxDsjGwuTZnqxwO3Xc/kSHezUbDuelW2gjEDMF+JGDQZyRCjV1sLnQsrgtC
	TLAyeK+2hgjNkbEHYc1URigvZR8LYP3AFB3KUGwsnFpo+pcXsSnQ/M4p3HJToLHXCLY4GtoD
	ZuIW2Gnadodp2wrTNsW0TWkHZBeQqYp1RZxKnZygLVSWF6v0CRdLimxg868Ww5/GfrDiyRgG
	LAPkYRLc4lZIhZxOW140DCBDyGWSWPu4Qiop4MoreE1JnuaymtcOg70MKY+QZJ7n86Wsgivj
	C3m+lNf87woYUWQlOG2gDBbThdUnVTHt8xEb58Jf5fnjq3UrMfU+o/1KW9qDTu52arXBfeNQ
	Y1owMDRistknZo4fTgT4ZXLr8wPLeTnR6aJs7M2+tKrvfuOl1s807QnLbHY76xZdo9ly2ACr
	z+5HohceR911ZZLt94D9aIWnb0fWr5t+hTO9hJCTWiWXFEdotNxfKIs33tMCAAA=
X-CFilter-Loop: Reflected



On 3/7/2025 2:32 AM, Gregory Price wrote:
> On Thu, Mar 06, 2025 at 09:39:26PM +0900, Honggyu Kim wrote:
>>
>> The memoryless nodes are printed as follows after those ACPI, SRAT,
>> Node N PXM M messages.
>>
>>    [    0.010927] Initmem setup node 0 [mem
>> 0x0000000000001000-0x000000207effffff]
>>    [    0.010930] Initmem setup node 1 [mem
>> 0x0000060f80000000-0x0000064f7fffffff]
>>    [    0.010992] Initmem setup node 2 as memoryless
>>    [    0.011055] Initmem setup node 3 as memoryless
>>    [    0.011115] Initmem setup node 4 as memoryless
>>    [    0.011177] Initmem setup node 5 as memoryless
>>    [    0.011238] Initmem setup node 6 as memoryless
>>    [    0.011299] Initmem setup node 7 as memoryless
>>    [    0.011361] Initmem setup node 8 as memoryless
>>    [    0.011422] Initmem setup node 9 as memoryless
>>    [    0.011484] Initmem setup node 10 as memoryless
>>    [    0.011544] Initmem setup node 11 as memoryless
>>
>> This is related why the 12 nodes at sysfs knobs are provided with the
>> current N_POSSIBLE loop.
>>
> 
> This isn't actually why, this is another symptom.  This gets printed
> because someone is marking nodes 4-11 as possible and setup_nr_node_ids
> reports 12 total nodes
> 
> void __init setup_nr_node_ids(void)
> {
>          unsigned int highest;
> 
>          highest = find_last_bit(node_possible_map.bits, MAX_NUMNODES);
>          nr_node_ids = highest + 1;
> }
> 
> Given your configuration data so far, we may have a bug somewhere (or
> i'm missing a configuration piece).

Maybe there could be some misunderstanding on this issue.
This isn't a problem of NUMA detection for CXL memory but just a problem
of number of "node" knobs only for weighted interleave.

The number of nodes in 'numactl -H' shows the correct nodes even without
our fix.

   $ numactl -H
   available: 4 nodes (0-3)
   node 0 cpus: 0 1 2 3 ...
   node 0 size: 128504 MB
   node 0 free: 118563 MB
   node 1 cpus: 144 145 146 147 ...
   node 1 size: 257961 MB
   node 1 free: 242628 MB
   node 2 cpus:
   node 2 size: 393216 MB
   node 2 free: 393216 MB
   node 3 cpus:
   node 3 size: 524288 MB
   node 3 free: 524288 MB
   node distances:
   node     0    1    2    3
      0:   10   21   14   24
      1:   21   10   24   14
      2:   14   24   10   26
      3:   24   14   26   10

You can see more info below.

   $ cd /sys/devices/system/node

   $ ls -d node*
   node0  node1  node2  node3

   $ cat possible
   0-11

   $ cat online
   0-3

   $ cat has_memory
   0-3

   $ cat has_normal_memory
   0-1

   $ cat has_cpu
   0-1

>>> Basically I need to know:
>>> 1) Is each CXL device on a dedicated Host Bridge?
>>> 2) Is inter-host-bridge interleaving configured?
>>> 3) Is intra-host-bridge interleaving configured?
>>> 4) Do SRAT entries exist for all nodes?
>>
>> Are there some simple commands that I can get those info?
>>
> 
> The content of the CEDT would be sufficient - that will show us the
> number of CXL host bridges.

Which command do we need for this info specifically?  My output doesn't
provide some useful info for that.

   $ acpidump -b
   $ iasl -d *
   $ cat cedt.dsl
       ...
   **** Unknown ACPI table signature [CEDT]

> 
>>> 5) Why are there 12 nodes but only 10 sources? Are there additional
>>>      devices left out of your diagram? Are there 2 CFMWS but and 8 Memory
>>>      Affinity records - resulting in 10 nodes? This is strange.
>>
>> My blind guess is that there could be a logic node that combines 4ch of
>> CXL memory so there are 5 nodes per each socket.  Adding 2 nodes for
>> local CPU/DRAM makes 12 nodes in total.
>>
> 
> The issue is that nodes have associated memory regions.  If there are
> multiple nodes with overlapping memory regions, that seems problematic.
> 
> If there are "possible nodes" without memory and no real use case
> (because the memory is associated with the aggregate node) then those
> nodes probably shouldn't be reported as possible.
> 
> the tl;dr here is we should figure out what is marking those nodes as
> possible.
> 
>> Not sure about this part but our approach with hotplug_memory_notifier()
>> resolves this problem.  Rakie will submit an initial working patchset
>> soonish.
> 
> This may just be a bandaid on the issue.  We should get our node
> configuration correct from the get-go.

Not sure about it.  This must be fixed ASAP because current kernel is
broken on this issue and the fix should go into hotfix tree first.

If you can think this is just a bandaid, but leaving it bleeding as is
not the right approach.

Our fix was posted a few hours ago.  Please have a look, then think
about the apprach again.
https://lore.kernel.org/linux-mm/20250307063534.540-1-rakie.kim@sk.com

Thanks,
Honggyu

> 
> ~Gregory


