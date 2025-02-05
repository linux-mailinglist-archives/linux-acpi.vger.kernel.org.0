Return-Path: <linux-acpi+bounces-10894-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F66CA281C2
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Feb 2025 03:26:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCCBD3A28A3
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Feb 2025 02:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC35212D63;
	Wed,  5 Feb 2025 02:26:21 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30C8878F4C;
	Wed,  5 Feb 2025 02:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738722381; cv=none; b=hEwdwVaC25R+uI10H2gZeGSqaEdzilkIBkS0xGXLwlT0NRB0LXzdenGAEZwPPS+Z/m1hLzs9PkFvwgSYIbs4kgU94/u47lJkmZEGgfhgq/MJYJwcT1sLPYPt1PsdA1KW/mGu6fWDQ8OC0Y3hNAsKqMeQEeo3pUmSxUdeptTMDUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738722381; c=relaxed/simple;
	bh=oXc3Z/KC1NQ+sl7reJD3khhtese/luU+Yn32+xn6Cio=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=GrFOrBIIAxGFfsImjDQJRDfWPBm19g2rockXhU1qcVe1a0AvBKAWNnOZB2ABGIiKul72KhrU+c/5sSAzYaB5EsuMLI3CSISoRZfkIKlc6JEW1JlnQ1EPh7mggyNrQ6iT7bzicgGmDoeOB6YmfpPR8JYwKjoLEJhvjG7bbFieVSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-3c9ff7000001d7ae-4d-67a2cc3f7de9
Message-ID: <5b9a3776-8661-423a-853f-87fa8b9a7633@sk.com>
Date: Wed, 5 Feb 2025 11:26:06 +0900
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: kernel_team@skhynix.com, Joshua Hahn <joshua.hahnjy@gmail.com>,
 ying.huang@linux.alibaba.com, rafael@kernel.org, lenb@kernel.org,
 gregkh@linuxfoundation.org, akpm@linux-foundation.org, rakie.kim@sk.com,
 dan.j.williams@intel.com, Jonathan.Cameron@huawei.com, dave.jiang@intel.com,
 horen.chuang@linux.dev, hannes@cmpxchg.org, linux-kernel@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-mm@kvack.org, kernel-team@meta.com,
 42.hyeyoo@gmail.com, Honggyu Kim <honggyu.km@gmail.com>
Subject: Re: [PATCH v4] Weighted Interleave Auto-tuning
Content-Language: ko
To: Gregory Price <gourry@gourry.net>
References: <20250202141247.2219681-1-joshua.hahnjy@gmail.com>
 <a2b428ed-212a-4e39-bcf7-5ab67249132d@sk.com>
 <Z6Di3oLQg64W0hAM@gourry-fedora-PF4VCD3F>
From: Honggyu Kim <honggyu.kim@sk.com>
In-Reply-To: <Z6Di3oLQg64W0hAM@gourry-fedora-PF4VCD3F>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBIsWRmVeSWpSXmKPExsXC9ZZnoa79mUXpBgcfc1lM7DGwmLN+DZvF
	9KkXGC1O3Gxks/h59zi7RfPi9WwWqzf5WszZeYfZ4nb/OVaLVQuvsVkc3zqP3WLfRaCGnQ/f
	slks39fPaHF51xw2i3tr/rNazP0yldli9ZoMByGPw2/eM3vsnHWX3aO77TK7R8uRt6wei/e8
	ZPLYtKqTzWPTp0nsHidm/Gbx2PnQ0mNhw1Rmj/1z17B7nLtY4fF5k1wAbxSXTUpqTmZZapG+
	XQJXxp//7gXbBSq+7kxoYDzH08XIySEhYCLRO2cyI4x9a+ldNhCbV8BS4supVjCbRUBF4u36
	7+wQcUGJkzOfsIDYogLyEvdvzQCKc3EwC7xnllj0/xZrFyMHh7CAucTX5SogNcwCIhKzO9uY
	QcIiAqoSbVfcQcqFBGYxStxaMxFsJpuAmsSVl5OYQGxOATOJgyt62CB6zSS6tnYxQtjyEtvf
	zmEGaZYQOMcucWF2EzPE0ZJADTdYJjAKzkJy3ywku2chmTULyawFjCyrGIUy88pyEzNzTPQy
	KvMyK/SS83M3MQLjd1ntn+gdjJ8uBB9iFOBgVOLhdWBclC7EmlhWXJl7iFGCg1lJhPf09gXp
	QrwpiZVVqUX58UWlOanFhxilOViUxHmNvpWnCAmkJ5akZqemFqQWwWSZODilGhiZtsy+wrp8
	/5+791d+d/hwwVsp5Y7g1inhavIh3xM/tS7t5bbYdujVca0fMc/qPna7ZuyLaW7dU3Pjxv9P
	j7p/XZ5aLJmsPvVC0/HVxxdcL/zYw7iQf//Mu+elT3LZbbXZnJF8drFzj5co/8ayAyePPftu
	fCNgUoy1+e3+qEVZDwUlLzzePHuepxJLcUaioRZzUXEiAIl8UlzbAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBIsWRmVeSWpSXmKPExsXCNUNLT9fuzKJ0g/4b1hYTewws5qxfw2Yx
	feoFRosTNxvZLH7ePc5u0bx4PZvF6k2+FnN23mG2uN1/jtVi1cJrbBbHt85jt9h3Eajh8NyT
	rBY7H75ls1i+r5/R4vKuOWwW99b8Z7WY+2Uqs8Wha89ZLVavyXAQ8Tj85j2zx85Zd9k9utsu
	s3u0HHnL6rF4z0smj02rOtk8Nn2axO5xYsZvFo+dDy09FjZMZfbYP3cNu8e5ixUe3257eCx+
	8YHJ4/MmuQD+KC6blNSczLLUIn27BK6MP//dC7YLVHzdmdDAeI6ni5GTQ0LAROLW0rtsIDav
	gKXEl1OtYDaLgIrE2/Xf2SHighInZz5hAbFFBeQl7t+aARTn4mAWeM8ssej/LdYuRg4OYQFz
	ia/LVUBqmAVEJGZ3tjGDhEUEVCXarriDlAsJzGKUuLVmIthMNgE1iSsvJzGB2JwCZhIHV/Sw
	QfSaSXRt7WKEsOUltr+dwzyBkW8WkjNmIVkxC0nLLCQtCxhZVjGKZOaV5SZm5pjqFWdnVOZl
	Vugl5+duYgTG57LaPxN3MH657H6IUYCDUYmH14FxUboQa2JZcWXuIUYJDmYlEd7T2xekC/Gm
	JFZWpRblxxeV5qQWH2KU5mBREuf1Ck9NEBJITyxJzU5NLUgtgskycXBKNTAefs74InNWj+iP
	/QYdWpfdzH852DcYMEzdtefsxnMTFtybfE+uueBLW0JG8qSZAlbifzcHfJc+PSNuy5ILttc7
	b3QyfbvNdTK4YnPCtkXyR7bFzVx3ae/y5wGra2OMl/w62Nld8U7iRfGtLW5m3Un76jU6DFfl
	LuKaU27TtXmWnrAfo8v5ul+3lViKMxINtZiLihMB67xO2MsCAAA=
X-CFilter-Loop: Reflected

Hi Gregory,

On 2/4/2025 12:38 AM, Gregory Price wrote:
> On Mon, Feb 03, 2025 at 09:44:29PM +0900, Honggyu Kim wrote:
>> Hi Joshua,
>>
>>> A node offlining (or even onlining with no new bandwidth information)
>>> will just mean that the node inherits whatever value is stored in
>>> iw_table at that moment, whether that contains the default values
>>> created on init or the last values that it had taken.
>>
>> It looks the call sequence is as follows.
>>
>>    cxl_region_perf_attrs_callback()
>>    -> cxl_region_update_coordinates()
>>    -> node_set_perf_attrs()
>>    -> mempolicy_set_node_perf()
>>    -> reduce_interleave_weights()
>>
>> I haven't searched all the paths of cxl_region_perf_attrs_callback() via
>> cxlr->memory_notifier.notifier_call callback pointer, but maybe this
>> function is not called when a node is offlined, then I get node
>> offlining doesn't trigger re-weight calculation.
> 
> This function is called any time a memory block status changes.
> 
> static int cxl_region_perf_attrs_callback(struct notifier_block *nb,
>                                            unsigned long action, void *arg)
> {
> ...
>          if (nid == NUMA_NO_NODE || action != MEM_ONLINE)
>                  return NOTIFY_DONE;
> ...
> }

Ah, that's clear now.

> 
> But it doesn't do anything if it's not a call to online a memory block,
> so the cached performance data in mempolicy won't change when blocks
> are taken offline.
> 
> So the time the scenario you are proposing can arrise is when the device
> does not provide performance information (missing CDAT).
> 
> 
> If a user sets manual mode - they're on the hook to manage everything.
> 
> This is system-wide setting - not a per-task setting.  We've yet to see
> any strong use-case for individual task weights. If there is a use case
> for a task not being subject to system-wide weight changes then it's a
> use case for task-local weights.
> 
> ~Gregory

Thanks for the explanation.  Then except for the nitpicks that I left,
I'm fine with this.

Thanks,
Honggyu

