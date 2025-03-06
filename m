Return-Path: <linux-acpi+bounces-11891-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA2ADA54AF0
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Mar 2025 13:40:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F393F16DA51
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Mar 2025 12:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F28A420B1E4;
	Thu,  6 Mar 2025 12:39:40 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85B991FC0E5;
	Thu,  6 Mar 2025 12:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741264780; cv=none; b=SL8Ur9wCDIAUNYJtVbLwdcYtqLPrkbQTUIDwTUYgEdwm9UtQt8ZI9CiiXRNIolPQoKCkA3o70x/KVDtFjd0Bbcxohh8vMbN4spgiGDfQrsel132MBb6A9rSzeYCAnJlHdK0KFQ0PZlFoBVfnfPZF5/2QOzFRQgT+dU1WooBsYiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741264780; c=relaxed/simple;
	bh=JJ0Q91q0isqR2yrIt+oeh7eBi8iOTsMa2VAjIHpmSgU=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=nUplEDukIqHjKbUAHOnwH0NqPXUVBxB39p+dl44UkDbHz1OuhAQAiNjsfxCInJjBkZJU45KX1dFXBxZBF+i/z2LiXBcnL7Wn8U0vcfhJQYfcZ8OpULn1ARDB2Y6QXvxSIVcFE8uL148feY/BNY+A1kjpjr61k/ItuzU02a9sWog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-3c9ff7000001d7ae-ed-67c9977f06ad
Message-ID: <f64819e2-8dc6-4907-b8bf-faec66eecd0e@sk.com>
Date: Thu, 6 Mar 2025 21:39:26 +0900
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
To: Gregory Price <gourry@gourry.net>
References: <20250226213518.767670-1-joshua.hahnjy@gmail.com>
 <20250226213518.767670-2-joshua.hahnjy@gmail.com>
 <b8ac8654-92bd-4c08-a3fc-e28a7be5e0e6@sk.com>
 <Z8cqe3BCdobsV4-2@gourry-fedora-PF4VCD3F>
Content-Language: ko
From: Honggyu Kim <honggyu.kim@sk.com>
In-Reply-To: <Z8cqe3BCdobsV4-2@gourry-fedora-PF4VCD3F>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDIsWRmVeSWpSXmKPExsXC9ZZnoW799JPpBtd/iVvMWb+GzWL61AuM
	FiduNrJZ/Lx7nN2iefF6NovVm3wt7i97xmJxu/8cq8WqhdfYLI5vncduse8iUMPOh2/ZLJbv
	62e0uLxrDpvFvTX/WS3mfpnKbLF6TYaDoMfhN++ZPXbOusvu0d12md2j5chbVo/Fe14yeWxa
	1cnmsenTJHaPEzN+s3jsfGjpsbBhKrPH/rlr2D3OXazw+Pj0FovH501yAXxRXDYpqTmZZalF
	+nYJXBn7D5xiLrilVtF04j9zA+N36S5GTg4JAROJOV1XmWHsr+evs4LYvAKWEvMX7QezWQRU
	JK6eWMkMEReUODnzCQuILSogL3H/1gz2LkYuDmaBx8wSn+50gRUJC0RJ7Hz1l6mLkYNDREBV
	ou2KO0iNkMBZRokV6x6ygdQwC4hIzO5sA6tnE1CTuPJyEhOIzSlgJtHyu58FosZMomtrFyOE
	LS+x/e0cZpBBEgK32CVOzFkMdbWkxMEVN1gmMArOQnLgLCQ7ZiGZNQvJrAWMLKsYhTLzynIT
	M3NM9DIq8zIr9JLzczcxAuN4We2f6B2Mny4EH2IU4GBU4uH1mHoyXYg1say4MvcQowQHs5II
	70U/oBBvSmJlVWpRfnxRaU5q8SFGaQ4WJXFeo2/lKUIC6YklqdmpqQWpRTBZJg5OqQZGr3LJ
	bytXnZXT+eGyQq/zY/bNXVMPWviZBYTH/lV06bqlkaYlcNVdc5+Pa0LPX9Ga5rMtD7bWfC4+
	lN2Ve/NhqNWzrV/k8mffSZT626T+Vb+gUqHqqbHDvQBG76PHfuy0Xty/6z6T0ikFVrEGsfC9
	kcUyssydq24bdBuv7JnCcUDlXKt14UklluKMREMt5qLiRADfqXmK3wIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrIIsWRmVeSWpSXmKPExsXCNUNLT7d++sl0gwdrOSzmrF/DZjF96gVG
	ixM3G9ksft49zm7RvHg9m8XqTb4W95c9Y7G43X+O1WLVwmtsFse3zmO32HcRqOHw3JOsFjsf
	vmWzWL6vn9Hi8q45bBb31vxntZj7ZSqzxaFrz1ktVq/JsPi9bQWbg4jH4TfvmT12zrrL7tHd
	dpndo+XIW1aPxXteMnlsWtXJ5rHp0yR2jxMzfrN47Hxo6bGwYSqzx/65a9g9zl2s8Pj49BaL
	x7fbHh6LX3xg8vi8SS5AIIrLJiU1J7MstUjfLoErY/+BU8wFt9Qqmk78Z25g/C7dxcjJISFg
	IvH1/HVWEJtXwFJi/qL9YDaLgIrE1RMrmSHighInZz5hAbFFBeQl7t+awd7FyMXBLPCYWeLT
	nS6wImGBKImdr/4ydTFycIgIqEq0XXEHqRESOMsosWLdQzaQGmYBEYnZnW1g9WwCahJXXk5i
	ArE5BcwkWn73s0DUmEl0be1ihLDlJba/ncM8gZFvFpI7ZiEZNQtJyywkLQsYWVYximTmleUm
	ZuaY6hVnZ1TmZVboJefnbmIERuyy2j8TdzB+uex+iFGAg1GJh9dj6sl0IdbEsuLK3EOMEhzM
	SiK8F/2AQrwpiZVVqUX58UWlOanFhxilOViUxHm9wlMThATSE0tSs1NTC1KLYLJMHJxSDYws
	06O6S+W7VjFM/FHQZ7jlC+fl62feX1foMfdWPzAjOOmWgvICFfbmILEEduYjAfPeXllx/OPi
	U8m5u3SVxd9d7mEp9Jhk/rThAqfxlwXWx64k72LJ3nhkd0d8+rzYkgQjh+0ro+smrnb68VNQ
	+twbNvWZ3QzvvL4v7Z9W8132oXXfwSr+y/1KLMUZiYZazEXFiQDNibwU1AIAAA==
X-CFilter-Loop: Reflected

Hi Gregory,

On 3/5/2025 1:29 AM, Gregory Price wrote:
> On Thu, Feb 27, 2025 at 11:32:26AM +0900, Honggyu Kim wrote:
>> Actually, we're aware of this issue and currently trying to fix this.
>> In our system, we've attached 4ch of CXL memory for each socket as
>> follows.
>>
>>          node0             node1
>>        +-------+   UPI   +-------+
>>        | CPU 0 |-+-----+-| CPU 1 |
>>        +-------+         +-------+
>>        | DRAM0 |         | DRAM1 |
>>        +---+---+         +---+---+
>>            |                 |
>>        +---+---+         +---+---+
>>        | CXL 0 |         | CXL 4 |
>>        +---+---+         +---+---+
>>        | CXL 1 |         | CXL 5 |
>>        +---+---+         +---+---+
>>        | CXL 2 |         | CXL 6 |
>>        +---+---+         +---+---+
>>        | CXL 3 |         | CXL 7 |
>>        +---+---+         +---+---+
>>          node2             node3
>>
>> The 4ch of CXL memory are detected as a single NUMA node in each socket,
>> but it shows as follows with the current N_POSSIBLE loop.
>>
>> $ ls /sys/kernel/mm/mempolicy/weighted_interleave/
>> node0 node1 node2 node3 node4 node5
>> node6 node7 node8 node9 node10 node11
> 
> This is insufficient information for me to assess the correctness of the
> configuration. Can you please show the contents of your CEDT/CFMWS and
> SRAT/Memory Affinity structures?
> 
> mkdir acpi_data && cd acpi_data
> acpidump -b
> iasl -d *
> cat cedt.dsl  <- find all CFMWS entries
> cat srat.dsl  <- find all Memory Affinity entries

I'm not able to provide all the details as srat.dsl has too much info.

   $ wc -l srat.dsl
   25229 srat.dsl

Instead, I can show you that there are 4 diffferent proximity domains
with "Enabled : 1" with the following filtered output from srat.dsl.

   $ grep -E "Proximity Domain :|Enabled : " srat.dsl | cut -c 31- | sed 
'N;s/\n//' | sort | uniq
          Enabled : 0       Enabled : 0
   Proximity Domain : 00000000       Enabled : 0
   Proximity Domain : 00000000       Enabled : 1
   Proximity Domain : 00000001       Enabled : 1
   Proximity Domain : 00000006       Enabled : 1
   Proximity Domain : 00000007       Enabled : 1

We don't actually have to use those complicated commands to check this
as dmesg clearly prints the SRAT and node numbers as follows.

   [    0.009915] ACPI: SRAT: Node 0 PXM 0 [mem 0x00000000-0x7fffffff]
   [    0.009917] ACPI: SRAT: Node 0 PXM 0 [mem 0x100000000-0x207fffffff]
   [    0.009919] ACPI: SRAT: Node 1 PXM 1 [mem 
0x60f80000000-0x64f7fffffff]
   [    0.009924] ACPI: SRAT: Node 2 PXM 6 [mem 
0x2080000000-0x807fffffff] hotplug
   [    0.009925] ACPI: SRAT: Node 3 PXM 7 [mem 
0x64f80000000-0x6cf7fffffff] hotplug

The memoryless nodes are printed as follows after those ACPI, SRAT,
Node N PXM M messages.

   [    0.010927] Initmem setup node 0 [mem 
0x0000000000001000-0x000000207effffff]
   [    0.010930] Initmem setup node 1 [mem 
0x0000060f80000000-0x0000064f7fffffff]
   [    0.010992] Initmem setup node 2 as memoryless
   [    0.011055] Initmem setup node 3 as memoryless
   [    0.011115] Initmem setup node 4 as memoryless
   [    0.011177] Initmem setup node 5 as memoryless
   [    0.011238] Initmem setup node 6 as memoryless
   [    0.011299] Initmem setup node 7 as memoryless
   [    0.011361] Initmem setup node 8 as memoryless
   [    0.011422] Initmem setup node 9 as memoryless
   [    0.011484] Initmem setup node 10 as memoryless
   [    0.011544] Initmem setup node 11 as memoryless

This is related why the 12 nodes at sysfs knobs are provided with the
current N_POSSIBLE loop.

> 
> Basically I need to know:
> 1) Is each CXL device on a dedicated Host Bridge?
> 2) Is inter-host-bridge interleaving configured?
> 3) Is intra-host-bridge interleaving configured?
> 4) Do SRAT entries exist for all nodes?

Are there some simple commands that I can get those info?

> 5) Why are there 12 nodes but only 10 sources? Are there additional
>     devices left out of your diagram? Are there 2 CFMWS but and 8 Memory
>     Affinity records - resulting in 10 nodes? This is strange.

My blind guess is that there could be a logic node that combines 4ch of
CXL memory so there are 5 nodes per each socket.  Adding 2 nodes for
local CPU/DRAM makes 12 nodes in total.

> 
> By default, Linux creates a node for each proximity domain ("PXM")
> detected in the SRAT Memory Affinity tables. If SRAT entries for a
> memory region described in a CFMWS is absent, it will also create an
> node for that CFMWS.
> 
> Your reported configuration and results lead me to believe you have
> a combination of CFMWS/SRAT configurations that are unexpected.
> 
> ~Gregory

Not sure about this part but our approach with hotplug_memory_notifier()
resolves this problem.  Rakie will submit an initial working patchset 
soonish.

Thanks,
Honggyu

