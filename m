Return-Path: <linux-acpi+bounces-12318-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77730A66D4F
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Mar 2025 09:04:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE8A13B4AE0
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Mar 2025 08:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8C381C84B1;
	Tue, 18 Mar 2025 08:02:56 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F32381AA791;
	Tue, 18 Mar 2025 08:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742284976; cv=none; b=VJa+11eyyQeU7y4f6YYVjAGtszn37AdOB3f2SJsrQ7VUxnl8u3wAKDFW0ahXS9pqUvQ9/ozzDDPZJH/Od/69A3775mWmT0phAp4sLSgurIJ3DKFPz95yCH6B+HaZm3uTvcz7r713Ya/PBFwI4Hox4JkhntThtSkZW8SMGdLyePQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742284976; c=relaxed/simple;
	bh=6tmfjSUaa+b8uAjt/O5vSHnSI8u+YZ48edARkdy8ZzU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JZNmKWTdjj2smR3lJiCS7OWJCEyelJpzT2sk4LwLnQuXU+Kc+caJ8zk6Pdch83gpdB9RDge/03OT3cnB72Z+v/CvoNJ9HtoL/SV7OgMWszTUf9jh/mJav3RWXDzZ995qUnh9af/h8+KybuaE9I8/I+6tMkmt+dfEhnVb7jFlNfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-09-67d928a8ae53
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
Date: Tue, 18 Mar 2025 17:02:38 +0900
Message-ID: <20250318080246.1058-1-yunjeong.mun@sk.com>
X-Mailer: git-send-email 2.48.1.windows.1
In-Reply-To: <Z8-_SXm0JGjXTegL@gourry-fedora-PF4VCD3F>
References: 
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAIsWRmVeSWpSXmKPExsXC9ZZnke4KjZvpBptOcFrMWb+GzWL61AuM
	FiduNrJZ/Lx7nN2iefF6NovVm3wt7i97xmJxu/8cq8WqhdfYLI5vncduse8iUMPOh2/ZLJbv
	62e0uLxrDpvFvTX/WS3mfpnKbLF6TYaDoMfhN++ZPXbOusvu0d12md2j5chbVo/Fe14yeWxa
	1cnmsenTJHaPEzN+s3jsfGjpsbBhKrPH/rlr2D3OXazw+Pj0FovH501yAXxRXDYpqTmZZalF
	+nYJXBlta8IL1upV/Dqwjq2BcYZKFyMnh4SAicT6Rd+YYexrXQuYQGw2AQ2Jg4dOAsU5OEQE
	VCXarrh3MXJxMAu0sUjcfLWYEaRGWCBC4tyj0ywgNgtQTd/sl+wgNq+AucT5/nnsEDM1JRou
	3QObySlgJjHtyG2wuJAAj8SrDfsZIeoFJU7OfMICsotZQF1i/TwhkDCzgLxE89bZzCB7JQSO
	sUusefwfaqakxMEVN1gmMArMQtI+C6F9FpL2BYzMqxiFMvPKchMzc0z0MirzMiv0kvNzNzEC
	43FZ7Z/oHYyfLgQfYhTgYFTi4d3BfiNdiDWxrLgy9xCjBAezkgiv+5Pr6UK8KYmVValF+fFF
	pTmpxYcYpTlYlMR5jb6VpwgJpCeWpGanphakFsFkmTg4pRoYRefF9+vN0RQInrXH/I3NxMVa
	fy9KG8d3nHo4M+h62JV1J9/fnXmx/ZHe7wWMEWlrq1Ysa7eT6PvhtV70Vts6O2P981e6Nk78
	sb+05TOP6tY71ny9zyP/xW0L/HP3SbHSHemUgJ4t4vKrq53uTcjZvFdhaXVSjfDRjRWCz4MY
	xLec5ixpm5u7Q4mlOCPRUIu5qDgRAMCmBzHDAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKIsWRmVeSWpSXmKPExsXCNUNWR3e5xs10g+4L5hZz1q9hs5g+9QKj
	xYmbjWwWP+8eZ7doXryezWL1Jl+L+8uesVh8fvaa2eJ2/zlWi1ULr7FZHN86j91i30WgrsNz
	T7Ja7Hz4ls1i+b5+RovLu+awWdxb85/VYu6XqcwWh649Z7VYvSbDQcTj8Jv3zB47Z91l9+hu
	u8zu0XLkLavH4j0vmTw2repk89j0aRK7x4kZv1k8dj609FjYMJXZY//cNewe5y5WeHx8eovF
	49ttD4/FLz4weXzeJBcgEMVlk5Kak1mWWqRvl8CV0bYmvGCtXsWvA+vYGhhnqHQxcnJICJhI
	XOtawARiswloSBw8dJK5i5GDQ0RAVaLtinsXIxcHs0Abi8TNV4sZQWqEBSIkzj06zQJiswDV
	9M1+yQ5i8wqYS5zvn8cOMVNTouHSPbCZnAJmEtOO3AaLCwnwSLzasJ8Rol5Q4uTMJywgu5gF
	1CXWzxMCCTMLyEs0b53NPIGRdxaSqlkIVbOQVC1gZF7FKJKZV5abmJljqlecnVGZl1mhl5yf
	u4kRGHnLav9M3MH45bL7IUYBDkYlHt4d7DfShVgTy4orcw8xSnAwK4nwuj+5ni7Em5JYWZVa
	lB9fVJqTWnyIUZqDRUmc1ys8NUFIID2xJDU7NbUgtQgmy8TBKdXAqO3q8NsoN/mrx6LJs/+z
	c87PbPVY93N1mnJz5l9TXrarnrd/Cbs+zLguFZnW+cJiW07t/kl/P39c9uxK7bHfbEatW+v3
	f/vYKdPSkhRk883bMa5+i4t6wYTNcrsKysMkefbULD8qupl/g8vj9ufLjWo2/C/UePP3raDw
	d4tyh0/sh0JdzJtvKLEUZyQaajEXFScCALU/Yo+4AgAA
X-CFilter-Loop: Reflected

Hi Gregory, I have one more question below.

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

Thanks for confirm. Honggyu represented it as a tree sturcture:
rootport/ 
├── socket0
│   ├── cross-host-bridge0 -> SRAT && CEDT (interleave on) --> NODE 2
│   │   ├── host-bridge0 -> CEDT
│   │   │   ├── cxl0 -> CEDT
│   │   │   └── cxl1-> CEDT
│   │   └── host-bridge1 -> CEDT
│   │       ├── cxl2 -> CEDT
│   │       └── cxl3 -> CEDT
│   └── dram0 -> SRAT ---------------------------------------> NODE 0
└── socket1
    ├── cross-host-bridge1 -> SRAT && CEDT (interleave on)---> NODE 3
    │   ├── host-bridge2 -> CEDT
    │   │   ├── cxl4 -> CEDT
    │   │   └── cxl5 -> CEDT
    │   └── host-bridge3 -> CEDT
    │       ├── cxl6 -> CEDT
    │       └── cxl7 -> CEDT
    └── dram1 -> SRAT ---------------------------------------> NODE 1

> As you mention below, the code in acpi/numa/srat.c will create 1 NUMA
> node per SRAT Memory Affinity Entry - and then also 1 NUMA node per
> CFMWS that doesn't have a matching SRAT entry (with a known corner case
> for a missing SRAT which doesn't apply here).
> 
> So essentialy what the system is doing is marking that it's absolutely
> possible to create 1 region per device and also 1 region that
> interleaves across host each pair of host bridges (I presume this is a
> dual socket system?).
> 
> So, tl;dr: All these nodes are valid and this configuration is correct.

I am wondering if all 12 nodes specifed as 'possible' is indeed correct.
The definiton of 'possible' is:
 - 'Nodes that could be possibly become online at some point'. 
IMHO, it seems like there should only be 4 nodes specified as 'possible'.

> 
> Weighted interleave presently works fine as intended, but with the
> inclusion of the auto-configuration, there will be issues for your
> system configuration. This means we probably need to consider
> merging these as a group.
> 
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

