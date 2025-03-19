Return-Path: <linux-acpi+bounces-12347-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68DBEA688F1
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Mar 2025 10:58:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8285C1628CE
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Mar 2025 09:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7ACF213230;
	Wed, 19 Mar 2025 09:56:42 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 944B8202C5C;
	Wed, 19 Mar 2025 09:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742378202; cv=none; b=pHJ2T++S6LyHJz4Hew5sFm6a2ZRRuZzK7wMSNrxEP/uBjG/rqXXBNAXA1sAcEyZnL1DWLcRLQvJWtdou56Q29mS+wPMa1FqfxcjR/WCaqVKTgkNkBTayKQ1SassFjiTbXvCBY2p5vsPewT+47GeCykoRAlVwDX8qVV3NSV9b8qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742378202; c=relaxed/simple;
	bh=4sEeMuXL5HIcpxs6iW8rxCZgQ9Iil/jn+d60m+Jgr5c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XAd1woxiBMpLdU0CXbml6kACrNARoFjyLcbKmrJ04ngRg+l1OSg0YK1uZg/uVPYyR/iBQF7N21PeubbCAabYD4GF3wRyLHg5pix7QwtNRxcdE4fSZ8xKQSBKdwhdCbNDC0NjEYMpqiS/Jc5UJIOrtB9U3rb4sp0DSGNOiHIs1CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-74-67da94d1fc57
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
Date: Wed, 19 Mar 2025 18:56:21 +0900
Message-ID: <20250319095630.1075-1-yunjeong.mun@sk.com>
X-Mailer: git-send-email 2.48.1.windows.1
In-Reply-To: <Z9mNiWm1pNIxiu0t@gourry-fedora-PF4VCD3F>
References: 
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIIsWRmVeSWpSXmKPExsXC9ZZnoe7FKbfSDebMk7eYs34Nm8X0qRcY
	LU7cbGSz+Hn3OLtF8+L1bBarN/la3F/2jMXidv85VotVC6+xWRzfOo/dYt9FoIadD9+yWSzf
	189ocXnXHDaLe2v+s1rM/TKV2WL1mgwHQY/Db94ze+ycdZfdo7vtMrtHy5G3rB6L97xk8ti0
	qpPNY9OnSeweJ2b8ZvHY+dDSY2HDVGaP/XPXsHucu1jh8fHpLRaPz5vkAviiuGxSUnMyy1KL
	9O0SuDIWbf/CUvBBsqKr5Qt7A+McoS5GTg4JAROJlSfPMsLYZ+bNZAOx2QQ0JA4eOsncxcjB
	ISKgKtF2xb2LkYuDWaCNReLmq8Vg9cICERLnHp1mAbFZgGpW9vWA2bwC5hLXlj9ih5ipKdFw
	6R4TiM0pYCYxvfkt2HwhAR6JVxv2M0LUC0qcnPmEBWQXs4C6xPp5YKcxC8hLNG+dzQyyV0Lg
	FLvEn0uTmCFmSkocXHGDZQKjwCwk7bMQ2mchaV/AyLyKUSgzryw3MTPHRC+jMi+zQi85P3cT
	IzAil9X+id7B+OlC8CFGAQ5GJR5eg6Cb6UKsiWXFlbmHGCU4mJVEeN2fXE8X4k1JrKxKLcqP
	LyrNSS0+xCjNwaIkzmv0rTxFSCA9sSQ1OzW1ILUIJsvEwSnVwKi3Q0NsB3uufm9NkNJ6P462
	D8aci3sfHdp9ccKLeyEhzc8kPnc2PLiXcWqbkdfst0fXBdzabpi5mEv79LVQL76yf75yVlEN
	PzuPLtFkVz7d4X3R1sni0Zrddmc6r3tO3CL2NU9uzmzxRbGpM37dWOtRIC6k9PpaeNjXifte
	nTwoy/fE4du8hrlKLMUZiYZazEXFiQBGu0ERxAIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGIsWRmVeSWpSXmKPExsXCNUNWR/filFvpBls7uS3mrF/DZjF96gVG
	ixM3G9ksft49zm7RvHg9m8XqTb4W95c9Y7H4/Ow1s8Xt/nOsFqsWXmOzOL51HrvFvotAXYfn
	nmS12PnwLZvF8n39jBaXd81hs7i35j+rxdwvU5ktDl17zmqxek2Gg4jH4TfvmT12zrrL7tHd
	dpndo+XIW1aPxXteMnlsWtXJ5rHp0yR2jxMzfrN47Hxo6bGwYSqzx/65a9g9zl2s8Pj49BaL
	x7fbHh6LX3xg8vi8SS5AIIrLJiU1J7MstUjfLoErY9H2LywFHyQrulq+sDcwzhHqYuTkkBAw
	kTgzbyYbiM0moCFx8NBJ5i5GDg4RAVWJtivuXYxcHMwCbSwSN18tZgSpERaIkDj36DQLiM0C
	VLOyrwfM5hUwl7i2/BE7xExNiYZL95hAbE4BM4npzW/B5gsJ8Ei82rCfEaJeUOLkzCcsILuY
	BdQl1s8DO4dZQF6ieets5gmMvLOQVM1CqJqFpGoBI/MqRpHMvLLcxMwcU73i7IzKvMwKveT8
	3E2MwNhbVvtn4g7GL5fdDzEKcDAq8fAaBN1MF2JNLCuuzD3EKMHBrCTC6/7keroQb0piZVVq
	UX58UWlOavEhRmkOFiVxXq/w1AQhgfTEktTs1NSC1CKYLBMHp1QDo8jWq51v3DKePTwtOX1x
	styGi9uY70yJX8L86dr02csV1vx+t+P08oSYZM2o3doh/5nereBd+unyf5vYWtHjCwKf24tc
	AhqgaZ4/bXKI98pfSZstHWZXxh5m3CZ5jG9NfmQaD+ef4M95zwQ+Waxj8NizNHjm5fjgG7u4
	Jfy2zZj58efZww+X7ldiKc5INNRiLipOBABZ/3vbuQIAAA==
X-CFilter-Loop: Reflected

Hi Gregory, thanks for your kind explanation.

On Tue, 18 Mar 2025 11:13:13 -0400 Gregory Price <gourry@gourry.net> wrote:
> On Tue, Mar 18, 2025 at 08:02:46PM +0900, Honggyu Kim wrote:
> > 
> > 
> > On 3/18/2025 5:02 PM, Yunjeong Mun wrote:
> > 
> > Some simple corrections here.  host-bridge{0-3} above aren't detected from CEDT.
> > The corrected structure is as follows.
> > 
> > rootport/
> > ├── socket0
> > │   ├── cross-host-bridge0 -> SRAT && CEDT (interleave on) --> NODE 2
> > │   │   ├── host-bridge0
> > │   │   │   ├── cxl0 -> CEDT
>                           node 4
> > │   │   │   └── cxl1-> CEDT
>                           node 5
> > │   │   └── host-bridge1
> > │   │       ├── cxl2 -> CEDT
>                           node 6
> > │   │       └── cxl3 -> CEDT
>                           node 7
> > │   └── dram0 -> SRAT ---------------------------------------> NODE 0
> > └── socket1
> >      ├── cross-host-bridge1 -> SRAT && CEDT (interleave on)---> NODE 3
> >      │   ├── host-bridge2
> >      │   │   ├── cxl4 -> CEDT
>                            node 8
> >      │   │   └── cxl5 -> CEDT
>                            node 9
> >      │   └── host-bridge3
> >      │       ├── cxl6 -> CEDT
>                            node 10
> >      │       └── cxl7 -> CEDT
>                            node 11
> >      └── dram1 -> SRAT ---------------------------------------> NODE 1
> > 
> 
> This is correct and expected.
> 
> All of these nodes are "possible" depending on how the user decides to
> program the CXL decoders and expose memory to the page allocator.
> 
> In your /sys/bus/cxl/devices/ you should have something like
> 
>   decoder0.0  decoder0.1  decoder0.2   decoder0.3
>   decoder0.4  decoder0.5  decoder0.6   decoder0.7
>   decoder0.8  decoder0.9
> 

Yes, I can see many decoder#.# files in there, and their devtype values are
shown below:
    $ cat /sys/bus/cxl/devices/decoder*/devtype
    cxl_decoder_root
    ...
    cxl_decoder_switch
    ...
    cxl_decoder_endpoint

> These are the root decoders that should map up directly with each CEDT
> CFMWS entry.
> 
> 2 of them should have interleave settings.
> 
> If you were to then program the endpoint and hostbridge decoders with
> the matching non-interleave address values from the other CEDT entries,
> you could bring each individual device online in its own NUMA node.
> 

I think this means that I can program the endpoint(=cxl_decoder_endpoint)
to map to the 8 CFMWS, and the hostbridge decoder (=cxl_decoder switch) to map
to another 2 CFMWS(cross-host bridge).

> Or, you can do what you're doing now, and program the endpoints to map
> to the 2 cross-host bridge interleave root decoders.

In my understanding, that kind of programming is done at the firmware or BIOS 
layer, right?

> 
> So your platform is giving you the option of how to online your devices,
> and as such it needs to mark nodes as "possible" even if they're unused.
> 

Thank you for the clear explanation. I now understand why 'possible' has such
value.

> ~Gregory
> 

Best regards,
Yunjeong

