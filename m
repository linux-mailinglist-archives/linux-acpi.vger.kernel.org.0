Return-Path: <linux-acpi+bounces-11991-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96F1FA59454
	for <lists+linux-acpi@lfdr.de>; Mon, 10 Mar 2025 13:28:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CDF2188B77E
	for <lists+linux-acpi@lfdr.de>; Mon, 10 Mar 2025 12:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A587227EBB;
	Mon, 10 Mar 2025 12:26:58 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F58C22423E;
	Mon, 10 Mar 2025 12:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741609618; cv=none; b=f/mXhcAKpdNz4LwCoB6/BGIvxY4J8zEP+6O7OG0Mbf7yuub1HkgHiuKB3kiz2S1qmmPbpn+J22zG+SVIkWwdJBAs5sLGR2ghMCNQj7SyhbU/rz34jc7RgGKPxl5pD1oc8KMemklbdYwDGan/AkbU4gk/qov2y2rFEsxMTQB++Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741609618; c=relaxed/simple;
	bh=EXAFn8QnTluKjBOG8QHCZx5SfK4hGrmt9U3EDlFi1p8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=sziT+59na9IisEN2WRfLJVuhi3KZdbimKHf8vfFINTpJ84irOB4cCQZ8v1JB+p8pHWaAq268CHnRo/F1KhEy30LNVumbtoTYeI2qx+11XaMsWMUmnPNMg/T5hTsoMYWZi+q5oI64g/yjq5k2j/J4hfSKWaLb9TY6DAsY4Ac5viE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-3e1ff7000001d7ae-93-67ceda89a610
Message-ID: <9caca3a8-280a-45bd-a081-cf4a28f05f21@sk.com>
Date: Mon, 10 Mar 2025 21:26:48 +0900
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Honggyu Kim <honggyu.kim@sk.com>
Subject: Re: [PATCH 2/2 v6] mm/mempolicy: Don't create weight sysfs for
 memoryless nodes
To: Gregory Price <gourry@gourry.net>
Cc: kernel_team@skhynix.com, Joshua Hahn <joshua.hahnjy@gmail.com>,
 harry.yoo@oracle.com, ying.huang@linux.alibaba.com,
 gregkh@linuxfoundation.org, rakie.kim@sk.com, akpm@linux-foundation.org,
 rafael@kernel.org, lenb@kernel.org, dan.j.williams@intel.com,
 Jonathan.Cameron@huawei.com, dave.jiang@intel.com, horen.chuang@linux.dev,
 hannes@cmpxchg.org, linux-kernel@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-mm@kvack.org, kernel-team@meta.com,
 yunjeong.mun@sk.com
References: <20250226213518.767670-1-joshua.hahnjy@gmail.com>
 <20250226213518.767670-2-joshua.hahnjy@gmail.com>
 <b8ac8654-92bd-4c08-a3fc-e28a7be5e0e6@sk.com>
 <Z8cqe3BCdobsV4-2@gourry-fedora-PF4VCD3F>
 <f64819e2-8dc6-4907-b8bf-faec66eecd0e@sk.com>
 <Z8ncOp2H54WE4C5s@gourry-fedora-PF4VCD3F>
 <9c0d8aa8-cac7-4679-aece-af88e8129345@sk.com>
 <Z8syE7l5H35pk9T5@gourry-fedora-PF4VCD3F>
Content-Language: ko
In-Reply-To: <Z8syE7l5H35pk9T5@gourry-fedora-PF4VCD3F>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDIsWRmVeSWpSXmKPExsXC9ZZnoW7nrXPpBpOmKVjMWb+GzWL61AuM
	FiduNrJZ/Lx7nN2iefF6NovVm3wt7i97xmJxu/8cq8WqhdfYLI5vncduse8iUMPOh2/ZLJbv
	62e0uLxrDpvFvTX/WS3mfpnKbLF6TYaDoMfhN++ZPXbOusvu0d12md2j5chbVo/Fe14yeWxa
	1cnmsenTJHaPEzN+s3jsfGjpsbBhKrPH/rlr2D3OXazw+Pj0FovH501yAXxRXDYpqTmZZalF
	+nYJXBlbnh9mLpguUjF95lGWBsZ1/F2MnBwSAiYSN+bvZoexN05qZwaxeQUsJfa++8oCYrMI
	qEq8m9XABhEXlDg58wlYXFRAXuL+rRlgvWwCahJXXk5iArGFBaIkdr76C2RzcIgA9bZdce9i
	5OJgFnjMLPHpThcziCMk0MoscXnPBLAGZgERidmdbWCLOQXMJC7NWMUGETeT6NraxQhhy0ts
	fzsHrFlC4Bq7xOoXZxkhrpaUOLjiBssERsFZSA6chWTuLCSzZiGZtYCRZRWjUGZeWW5iZo6J
	XkZlXmaFXnJ+7iZGYBwvq/0TvYPx04XgQ4wCHIxKPLwP5p1NF2JNLCuuzD3EKMHBrCTCe/DK
	uXQh3pTEyqrUovz4otKc1OJDjNIcLErivEbfylOEBNITS1KzU1MLUotgskwcnFINjKv+BC6v
	CNapLvqqYJC/ysU8a6HV9okfgn8uePPztF3R7MIdHAdEhX3aaz+Z6DBP7n48qyTGL6Q199Gu
	HFHrzdHBE3LuhvTamh7VW7bh+NK3f/pnhDYZncuYVeC8xCeEV0PdYZ3l/hSFtKtlGzqlklOk
	dp6Q17lx4u6k5zciBaetPaa220eJXYmlOCPRUIu5qDgRAFOaNt3fAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrIIsWRmVeSWpSXmKPExsXCNUNLT7fz1rl0gzet3BZz1q9hs5g+9QKj
	xYmbjWwWP+8eZ7doXryezWL1Jl+L+8uesVjc7j/HarFq4TU2i+Nb57Fb7LsI1HB47klWi50P
	37JZLN/Xz2hxedccNot7a/6zWsz9MpXZ4tC156wWq9dkWPzetoLNQcTj8Jv3zB47Z91l9+hu
	u8zu0XLkLavH4j0vmTw2repk89j0aRK7x4kZv1k8dj609FjYMJXZY//cNewe5y5WeHx8eovF
	49ttD4/FLz4weXzeJBcgEMVlk5Kak1mWWqRvl8CVseX5YeaC6SIV02ceZWlgXMffxcjJISFg
	IrFxUjsziM0rYCmx991XFhCbRUBV4t2sBjaIuKDEyZlPwOKiAvIS92/NYAex2QTUJK68nMQE
	YgsLREnsfPUXyObgEAHqbbvi3sXIxcEs8JhZ4tOdLmYQR0iglVni8p4JYA3MAiISszvbwBZz
	CphJXJqxig0ibibRtbWLEcKWl9j+dg7zBEa+WUjumIWkfRaSlllIWhYwsqxiFMnMK8tNzMwx
	1SvOzqjMy6zQS87P3cQIjNhltX8m7mD8ctn9EKMAB6MSD++DeWfThVgTy4orcw8xSnAwK4nw
	HrxyLl2INyWxsiq1KD++qDQntfgQozQHi5I4r1d4aoKQQHpiSWp2ampBahFMlomDU6qBkZNn
	W67wvRK35YkfWJiL+mdxn9i5+OEqB76CbTunX5J7XXm3Z//6ae4t05t26fee5FiRvPCJjOau
	KDbj7595y3YyOn+3Yn/jdMMw8NmN691ah7f+e/Rg05u4j+H23VNPWH8Tr/IsOhC8a8p5Sy4G
	RRnJDrb9X62sIidIB/Y+/WLJa3ni5pO2Z0osxRmJhlrMRcWJANJP0sPUAgAA
X-CFilter-Loop: Reflected

Hi Gregory,

On 3/8/2025 2:51 AM, Gregory Price wrote:
> On Fri, Mar 07, 2025 at 08:46:46PM +0900, Honggyu Kim wrote:
>> You can see more info below.
>>
>>    $ cd /sys/devices/system/node
>>
>>    $ ls -d node*
>>    node0  node1  node2  node3
>>
>>    $ cat possible
>>    0-11
> 
> We're split across two threads now, but i'll add this context
> 
> I'm basically asking whether there should be 12 nodes possible. It seems
> like there should only be 4 nodes possible - 2 for sockets, 2 for host
> bridges.

Ack. If the N_POSSIBLE itself becomes 4, then I agree this problem can simply be 
resolved.

> 
> Unless I'm misunderstanding, it should be the case that a given physical
> address can only be hosted by 1 numa node (proximity domain).

Yeah, the proximity domain detects the node correctly as follows in dmesg.

  [  0.009915] ACPI: SRAT: Node 0 PXM 0 [mem 0x00000000-0x7fffffff]
  [  0.009917] ACPI: SRAT: Node 0 PXM 0 [mem 0x100000000-0x207fffffff]
  [  0.009919] ACPI: SRAT: Node 1 PXM 1 [mem 0x60f80000000-0x64f7fffffff]
  [  0.009924] ACPI: SRAT: Node 2 PXM 6 [mem 0x2080000000-0x807fffffff] hotplug
  [  0.009925] ACPI: SRAT: Node 3 PXM 7 [mem 0x64f80000000-0x6cf7fffffff] hotplug

It is printed even before CXL detection.

> 
> So it *should* be the case that you either have 4 nodes possible or 10
> nodes possible, not 12.  But I could be missing a piece of context.
> 
>> Which command do we need for this info specifically?  My output doesn't
>> provide some useful info for that.
>>
>>    $ acpidump -b
>>    $ iasl -d *
>>    $ cat cedt.dsl
>>        ...
>>    **** Unknown ACPI table signature [CEDT]
>>
> 
> You probably have an old version of acpidump here, you might need to get
> a newer version that knows about the CEDT.

I just used the newest acpica and was able to dump CEDT properly.  But its
output is also very long so it'd be helpful if you could tell us which specific
info you need.

> 
> You'll also want to get all the Memory Affinity entries from srat.dsl
> 
>> Not sure about it.  This must be fixed ASAP because current kernel is
>> broken on this issue and the fix should go into hotfix tree first.
>>
> 
> I agree something is broken, I'm not convinced what is broken.

Yeah, we should fix the broken status hopefully before v6.14 release.

Thanks,
Honggyu

> 
>> If you can think this is just a bandaid, but leaving it bleeding as is
>> not the right approach.
>>
> 
> This affects userland, we shouldn't thrash on this. Lets get it right.
> 
> ~Gregory


