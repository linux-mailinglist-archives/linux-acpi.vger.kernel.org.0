Return-Path: <linux-acpi+bounces-12067-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DA68A5BCC5
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Mar 2025 10:52:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC80A16F130
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Mar 2025 09:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75DDE230997;
	Tue, 11 Mar 2025 09:52:07 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F5571DE4CC;
	Tue, 11 Mar 2025 09:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741686727; cv=none; b=bfQrSYjKOKEM86qXngJlGpoz2SJX2xjQTsoZmiucZ9S22y2Ic2Ip0s18cJOyN22WfUFMuYz9QqCGL7pBrQRdkgjvNubBy8rn+xGXDdVmKmKRS0yV0qVIGYjMPo+bHF+QvGAXAe5dT2h/sSPx181XTQinRM78Mj9kbkbNcEuDv08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741686727; c=relaxed/simple;
	bh=o341G45nOxRikhySnJbABEgZ/+2uLLTiz19NN7pxkyc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j4zgLzx/nbC+baK+4YmtTo6MzHPtXkDyo1e/ML7i/I68GOAeLPUT6KQprqhqkIBz1IkkBjZagQ0lRfswj8QoOFYB8FckZM8U31fHcH6wuQAbh4v+0IjaMe286ezu6iAqtVRXkRBhZ1SjLopK+ErWnZDaplhTfpBe1dfdSJPhS6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-8c-67d007b9adfb
From: Yunjeong Mun <yunjeong.mun@sk.com>
To: Gregory Price <gourry@gourry.net>
Cc: kernel_team@skhynix.com,
	Joshua Hahn <joshua.hahnjy@gmail.com>,
	harry.yoo@oracle.com,
	ying.huang@linux.alibaba.com,
	gregkh@linuxfoundation.org,
	rakie.kim@sk.com,
	akpm@linux-foundation.org,
	rafael@kernel.org,
	lenb@kernel.org,
	dan.j.williams@intel.com,
	Jonathan.Cameron@huawei.com,
	dave.jiang@intel.com,
	horen.chuang@linux.dev,
	hannes@cmpxchg.org,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-mm@kvack.org,
	kernel-team@meta.com,
	Honggyu Kim <honggyu.kim@sk.com>
Subject: Re: [PATCH 2/2 v6] mm/mempolicy: Don't create weight sysfs for memoryless nodes
Date: Tue, 11 Mar 2025 18:51:45 +0900
Message-ID: <20250311095151.446-1-yunjeong.mun@sk.com>
X-Mailer: git-send-email 2.48.1.windows.1
In-Reply-To: <Z8-_SXm0JGjXTegL@gourry-fedora-PF4VCD3F>
References: 
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFIsWRmVeSWpSXmKPExsXC9ZZnke5O9gvpBitatC3mrF/DZjF96gVG
	ixM3G9ksft49zm7RvHg9m8XqTb4W95c9Y7G43X+O1WLVwmtsFse3zmO32HcRqGHnw7dsFsv3
	9TNaXN41h83i3pr/rBZzv0xltli9JsNB0OPwm/fMHjtn3WX36G67zO7RcuQtq8fiPS+ZPDat
	6mTz2PRpErvHiRm/WTx2PrT0WNgwldlj/9w17B7nLlZ4fHx6i8Xj8ya5AL4oLpuU1JzMstQi
	fbsErowH+5wKZqtXzJvbxNLAeFCui5GTQ0LAROLKpqtsMPaG///ZQWw2AQ2Jg4dOMncxcnCI
	CKhKtF1x72Lk4mAWaGORuPlqMSNIjbBAhMS5R6dZQGwWoJrDa7tZQWxeATOJT11bGSFmako0
	XLrHBGJzAsWnHbkNNl9IgEfi1Yb9jBD1ghInZz4Bm8MsIC/RvHU2M8gyCYFN7BJbj19ngRgk
	KXFwxQ2WCYz8s5D0zELSs4CRaRWjUGZeWW5iZo6JXkZlXmaFXnJ+7iZGYIwtq/0TvYPx04Xg
	Q4wCHIxKPLwBj86lC7EmlhVX5h5ilOBgVhLhPXgFKMSbklhZlVqUH19UmpNafIhRmoNFSZzX
	6Ft5ipBAemJJanZqakFqEUyWiYNTqoExlJVdqY07b/08O6f+I2erXL/dmnjl6aRzG2uV18YG
	Xbp3X/bHoWCj1Ie5LYsD7xtFW55kaP2jsFjvDxN/vWnA309lF3bvmKT5c9oidbbtm4rse3/l
	cR/fEf5jZU0ow/dskRlsmnN3XfidlbG84HXD9NcLT6Q0bbZefU3fYVd26+681S/ncW32UmIp
	zkg01GIuKk4EAMS5iz+tAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnkeLIzCtJLcpLzFFi42LhmiGro7uT/UK6wcbJ8hZz1q9hs5g+9QKj
	xYmbjWwWP+8eZ7doXryezWL1Jl+L+8uesVh8fvaa2eJ2/zlWi1ULr7FZHN86j91i30WgrsNz
	T7Ja7Hz4ls1i+b5+RovLu+awWdxb85/VYu6XqcwWh649Z7VYvSbDQcTj8Jv3zB47Z91l9+hu
	u8zu0XLkLavH4j0vmTw2repk89j0aRK7x4kZv1k8dj609FjYMJXZY//cNewe5y5WeHx8eovF
	49ttD4/FLz4weXzeJBcgEMVlk5Kak1mWWqRvl8CV8WCfU8Fs9Yp5c5tYGhgPynUxcnJICJhI
	bPj/nx3EZhPQkDh46CRzFyMHh4iAqkTbFfcuRi4OZoE2FombrxYzgtQIC0RInHt0mgXEZgGq
	Oby2mxXE5hUwk/jUtZURYqamRMOle0wgNidQfNqR22DzhQR4JF5t2M8IUS8ocXLmE7A5zALy
	Es1bZzNPYOSZhSQ1C0lqASPTKkaRzLyy3MTMHFO94uyMyrzMCr3k/NxNjMBoWlb7Z+IOxi+X
	3Q8xCnAwKvHwBjw6ly7EmlhWXJl7iFGCg1lJhPfgFaAQb0piZVVqUX58UWlOavEhRmkOFiVx
	Xq/w1AQhgfTEktTs1NSC1CKYLBMHp1QDo/HZsIu3j+86ujsq3YevIZWtd4lyze5JTmrGu0IO
	XSk3OfQ79s/BRwXKS7m1ubbzTbYTy351wfBm5hdHm50fJPmY93gIiKVXNM7Q58/zrPQ+JrGe
	8dI1wbmhHhV6lUzKHr3yi+zn1XrVlloLWp7Iaykx3OMawfw9sotVYeuauoelLxv3LI1VYinO
	SDTUYi4qTgQAUPZYdqICAAA=
X-CFilter-Loop: Reflected

Hi Gregory, thanks for kind explanation.

On Tue, 11 Mar 2025 00:42:49 -0400 Gregory Price <gourry@gourry.net> wrote:
> On Tue, Mar 11, 2025 at 01:02:07PM +0900, Yunjeong Mun wrote:
> 
> forenote - Hi Andrew, please hold off on the auto-configuration patch
> for now, the sk group has identified a hotplug issue we need to work out
> and we'll likely need to merge these two patch set together.  I really
> appreciate your patience with this feature.
> 
> > Hi Gregory,
> >
> > In my understanding, the reason we are seeing 12 NUMA node is because
> > it loops through node_states[N_POSSIBLE] and its value is 4095 (twelves ones)
> > in the code [1]  below:
> > 
> ... snip ...
> 
> Appreciated, so yes this confirms what i thought was going on.  There's
> 4 host bridges, 2 devices on each host bridge, and an extra CFMWS per
> socket that is intended to interleave across the host bridges.
> 
> As you mention below, the code in acpi/numa/srat.c will create 1 NUMA
> node per SRAT Memory Affinity Entry - and then also 1 NUMA node per
> CFMWS that doesn't have a matching SRAT entry (with a known corner case
> for a missing SRAT which doesn't apply here).
> 
> So essentialy what the system is doing is marking that it's absolutely
> possible to create 1 region per device and also 1 region that
> interleaves across host each pair of host bridges (I presume this is a
> dual socket system?).

Correct, it is a dual socket system. Thank you for the detailed explanation.
It has been helpful for analyzing the code.
> 
> So, tl;dr: All these nodes are valid and this configuration is correct.
> 
> Weighted interleave presently works fine as intended, but with the
> inclusion of the auto-configuration, there will be issues for your
> system configuration. This means we probably need to consider
> merging these as a group.
> 

We believe our propsed hot plug patch should be added as a hot-fix to v6.14, 
because it can be addressed independently of auto-configuring feature.
Rakie will send v2 patch soon.

> During boot, the following will occur
> 
> 1) drivers/acpi/numa/srat.c marks 12 nodes as possible
>    0-1) Socket nodes
>    2-3) Cross-host-bridge interleave nodes
>    4-11) single region nodes
> 
> 2) drivers/cxl/* will probe the various devices and create
>    a root decoder for each CXL Fixed Memory Window
>    decoder0.0 - decoder11.0  (or maybe decoder0.0 - decoder0.11)
> 
> 3) during probe auto-configuration of wieghted interleave occurs as a
>    result of this code being called with hmat or cdat data:
> 
> void node_set_perf_attrs() {
> ...
> 	/* When setting CPU access coordinates, update mempolicy */
> 	if (access == ACCESS_COORDINATE_CPU) {
> 		if (mempolicy_set_node_perf(nid, coord)) {
> 			pr_info("failed to set mempolicy attrs for node %d\n",
> 				nid);
> 		}
> 	}
> ...
> }
> 
> under the current system, since we calculate with N_POSSIBLE, all nodes
> will be assigned weights (assuming HMAT or CDAT data is available for
> all of them).
> 
> We actually have a few issues here
> 
> 1) If all nodes are included in the weighting reduction, we're actually
>    over-representing a particular set of hardware.  The interleave node
>    and the individual device nodes would actually over-represent the
>    bandwidth available (comparative to the CPU nodes).
> 
> 2) As stated on this patch line, just switching to N_MEMORY causes
>    issues with hotplug - where the bandwidth can be reported, but if
>    memory hasn't been added yet then we'll end up with wrong weights
>    because it wasn't included in the calculation.
> 
> 3) However, not exposing the nodes because N_MEMORY isn't set yet
>    a) prevents pre-configuration before memory is onlined, and
>    b) hides the implications of hotplugging memory into a node from the
>       user (adding memory causes a re-weight and may affect an
>       interleave-all configuration).
> 
> but - i think it's reasonable that anyone using weighted-interleave is
> *probably* not going to have nodes come and go.  It just seems like a
> corner case that isn't reasonable to spend time supporting.
> 
> So coming back around to the hotplug patch line, I do think it's
> reasonable hide nodes marked !N_MEMORY, but consider two issues:
> 
> 1) In auto mode, we need to re-weight on hotplug to only include
>    onlined nodes.  This is because the reduction may be sensitive
>    to the available bandwidth changes.
> 
>    This behavior needs to be clearly documented.
> 
> 2) We need to clearly define what the weight of a node will be when
>    in manual mode and a node goes (memory -> no memory -> memory)
>    a) does it retain it's old, manually set weight?
>    b) does it revert to 1?
> 
> Sorry for the long email, just working through all the implications.
> 
> I think the proposed hotplug patch is a requirement for the
> auto-configuration patch set.
> 
> ~Gregory
> 
Best regards,
Yunjeong

