Return-Path: <linux-acpi+bounces-12319-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1903BA6721A
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Mar 2025 12:05:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC63019A61B8
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Mar 2025 11:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E307F20A5E1;
	Tue, 18 Mar 2025 11:02:59 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E091207E12;
	Tue, 18 Mar 2025 11:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742295779; cv=none; b=pt6FUP0pDae+A2q3v+0s9B3fp9EZa9rHsSNj7g2YA9HK2sZUdAzpdd7A4sewqgIyy8D9zGpxzR2gS937JnUsxKD5JFdcS+2+fW2SWZcBPKInmo+seF6ujzzkibUFm5ySDYLE2kOpjFw2vqD6/tvz+m7WiRlfdzm1QY9uQyNZ9R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742295779; c=relaxed/simple;
	bh=inmzikSgrjwt3qEL77+9M42DOxNLbkjK8lnwd+z0YJ0=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=WH5EvCSztRjBxlwwu9FVpHyy2JloopT2NffCvR1ksUgQCipl5Z24AGe0A4tsHjS+QxS+5E99WbyOrmjf0RA1HcbLr7DlXxPV9nRoWiYfNnYIO/chVl8EE6jDNCz6qasUEjKzE92AAY6maIqMg3y/QscADHqT/johIdM8n441t14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-e1-67d952d63e8c
Message-ID: <ed0004ea-c8d6-4ba9-ba40-0c9a97d98db6@sk.com>
Date: Tue, 18 Mar 2025 20:02:46 +0900
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
 linux-acpi@vger.kernel.org, linux-mm@kvack.org, kernel-team@meta.com
Subject: Re: [PATCH 2/2 v6] mm/mempolicy: Don't create weight sysfs for
 memoryless nodes
Content-Language: ko
To: Yunjeong Mun <yunjeong.mun@sk.com>, Gregory Price <gourry@gourry.net>
References: <20250318080246.1058-1-yunjeong.mun@sk.com>
From: Honggyu Kim <honggyu.kim@sk.com>
In-Reply-To: <20250318080246.1058-1-yunjeong.mun@sk.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDIsWRmVeSWpSXmKPExsXC9ZZnke71oJvpBgueM1rMWb+GzWL61AuM
	FiduNrJZ/Lx7nN2iefF6NovVm3wt7i97xmJxu/8cq8WqhdfYLI5vncduse8iUMPOh2/ZLJbv
	62e0uLxrDpvFvTX/WS3mfpnKbLF6TYaDoMfhN++ZPXbOusvu0d12md2j5chbVo/Fe14yeWxa
	1cnmsenTJHaPEzN+s3jsfGjpsbBhKrPH/rlr2D3OXazw+Pj0FovH501yAXxRXDYpqTmZZalF
	+nYJXBkTX79iKVggXrFpzhT2BsYvgl2MnBwSAiYS/e+b2WDsy3t7GUFsXgFLiQ+n17CC2CwC
	qhL/H65nhYgLSpyc+YQFxBYVkJe4f2sGexcjFwezwBlmid2tX8CahQWiJHa++ssEYjMLiEjM
	7mxjBrFFBDwlDh/8C9YsJGAucfF5AzuIzSagJnHl5SSwek4BC4klR++zQvSaSXRt7WKEsOUl
	mrfOZgZZJiFwjV2i5d92qKslJQ6uuMEygVFwFpIDZyHZPQvJrFlIZi1gZFnFKJSZV5abmJlj
	opdRmZdZoZecn7uJERjHy2r/RO9g/HQh+BCjAAejEg+vATC+hVgTy4orcw8xSnAwK4nwuj+5
	ni7Em5JYWZValB9fVJqTWnyIUZqDRUmc1+hbeYqQQHpiSWp2ampBahFMlomDU6qBUe96f0z5
	jBNrL5U03f8263Tpjvj7Rn9Xur6c97DfN3Cv+6Rtz3b+Ttrf9MXDwzSI6ZWzc/3uTQc4wjZa
	nghWLfX/suRa3/XGkGdnzhl/EL2/4OhbkdrI8zzhf92KN1dE75gzoUZo9g6H9sgXMnvm1Iva
	bd3y/kfVrRPiGfbWsp3y8odiwr9blimxFGckGmoxFxUnAgBFxw0b3wIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrIIsWRmVeSWpSXmKPExsXCNUNLT/da0M10g+WnjC3mrF/DZjF96gVG
	ixM3G9ksft49zm7RvHg9m8XqTb4W95c9Y7G43X+O1WLVwmtsFse3zmO32HcRqOHw3JOsFjsf
	vmWzWL6vn9Hi8q45bBb31vxntZj7ZSqzxaFrz1ktVq/JsPi9bQWbg4jH4TfvmT12zrrL7tHd
	dpndo+XIW1aPxXteMnlsWtXJ5rHp0yR2jxMzfrN47Hxo6bGwYSqzx/65a9g9zl2s8Pj49BaL
	x7fbHh6LX3xg8vi8SS5AIIrLJiU1J7MstUjfLoErY+LrVywFC8QrNs2Zwt7A+EWwi5GTQ0LA
	ROLy3l5GEJtXwFLiw+k1rCA2i4CqxP+H61kh4oISJ2c+YQGxRQXkJe7fmsHexcjFwSxwhlli
	d+sXsGZhgSiJna/+MoHYzAIiErM725hBbBEBT4nDB/+CNQsJmEtcfN7ADmKzCahJXHk5Caye
	U8BCYsnR+6wQvWYSXVu7GCFseYnmrbOZJzDyzUJyxywkK2YhaZmFpGUBI8sqRpHMvLLcxMwc
	U73i7IzKvMwKveT83E2MwIhdVvtn4g7GL5fdDzEKcDAq8fAaACNZiDWxrLgy9xCjBAezkgiv
	+5Pr6UK8KYmVValF+fFFpTmpxYcYpTlYlMR5vcJTE4QE0hNLUrNTUwtSi2CyTBycUg2Mfquv
	Jskb12hlVDY/OszEN8dVcvq0f20cczJCl509cWH7x7iu2DfzQzY5zt/x143p7qJ1d40nF899
	cYvv1LwjVhmZDltt7c59uOJ381aB6I55KZXS1g/vrHs8Of30G+Xgus6wp4EtzwTzv3GEqFsW
	rCxL6DgkdbR7gsEboUKv4GUO0RPE/dZpKLEUZyQaajEXFScCAHLK5+nUAgAA
X-CFilter-Loop: Reflected



On 3/18/2025 5:02 PM, Yunjeong Mun wrote:
> Hi Gregory, I have one more question below.
> 
> On Tue, 11 Mar 2025 00:42:49 -0400 Gregory Price <gourry@gourry.net> wrote:
>> On Tue, Mar 11, 2025 at 01:02:07PM +0900, Yunjeong Mun wrote:
>>
>> forenote - Hi Andrew, please hold off on the auto-configuration patch
>> for now, the sk group has identified a hotplug issue we need to work out
>> and we'll likely need to merge these two patch set together.  I really
>> appreciate your patience with this feature.
>>
>>> Hi Gregory,
>>>
>>> In my understanding, the reason we are seeing 12 NUMA node is because
>>> it loops through node_states[N_POSSIBLE] and its value is 4095 (twelves ones)
>>> in the code [1]  below:
>>>
>> ... snip ...
>>
>> Appreciated, so yes this confirms what i thought was going on.  There's
>> 4 host bridges, 2 devices on each host bridge, and an extra CFMWS per
>> socket that is intended to interleave across the host bridges.
>>
> 
> Thanks for confirm. Honggyu represented it as a tree sturcture:
> rootport/
> ├── socket0
> │   ├── cross-host-bridge0 -> SRAT && CEDT (interleave on) --> NODE 2
> │   │   ├── host-bridge0 -> CEDT
> │   │   │   ├── cxl0 -> CEDT
> │   │   │   └── cxl1-> CEDT
> │   │   └── host-bridge1 -> CEDT
> │   │       ├── cxl2 -> CEDT
> │   │       └── cxl3 -> CEDT
> │   └── dram0 -> SRAT ---------------------------------------> NODE 0
> └── socket1
>      ├── cross-host-bridge1 -> SRAT && CEDT (interleave on)---> NODE 3
>      │   ├── host-bridge2 -> CEDT
>      │   │   ├── cxl4 -> CEDT
>      │   │   └── cxl5 -> CEDT
>      │   └── host-bridge3 -> CEDT
>      │       ├── cxl6 -> CEDT
>      │       └── cxl7 -> CEDT
>      └── dram1 -> SRAT ---------------------------------------> NODE 1

Some simple corrections here.  host-bridge{0-3} above aren't detected from CEDT.
The corrected structure is as follows.

rootport/
├── socket0
│   ├── cross-host-bridge0 -> SRAT && CEDT (interleave on) --> NODE 2
│   │   ├── host-bridge0
│   │   │   ├── cxl0 -> CEDT
│   │   │   └── cxl1-> CEDT
│   │   └── host-bridge1
│   │       ├── cxl2 -> CEDT
│   │       └── cxl3 -> CEDT
│   └── dram0 -> SRAT ---------------------------------------> NODE 0
└── socket1
      ├── cross-host-bridge1 -> SRAT && CEDT (interleave on)---> NODE 3
      │   ├── host-bridge2
      │   │   ├── cxl4 -> CEDT
      │   │   └── cxl5 -> CEDT
      │   └── host-bridge3
      │       ├── cxl6 -> CEDT
      │       └── cxl7 -> CEDT
      └── dram1 -> SRAT ---------------------------------------> NODE 1

Thanks,
Honggyu

