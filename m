Return-Path: <linux-acpi+bounces-12059-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE17AA5B67F
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Mar 2025 03:08:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EB333AD8D8
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Mar 2025 02:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09FC41E3787;
	Tue, 11 Mar 2025 02:08:18 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B01D1DED47;
	Tue, 11 Mar 2025 02:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741658897; cv=none; b=btA11lOhbP5ZXW1hVVkwTCZQK0Ghd9GhWQLLGD5blzy7PdfwvQSdLZVYfK+l1jKSn/TJdsghma60kyjOfSI172p4x4Okla/NQ55xYcYZCQoR+tJ2+tQY1TvU6p/nufjCwcE9kj0x4oXM4W9pusA/joYGoPtC0joilqBQL7HhfMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741658897; c=relaxed/simple;
	bh=t21Hu0yZSui3qCsc26ScFh7fpk31lFTXL6atqclg6DA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WuVdwgEJJWDW6TdDEZoisRfN5IOtU7TyO7Ksd21KGmxp0sNtY4U0RalujmDEasYqEnRf5ICzVg0heE4FEi87CIZvILA/nd3zmGCP7zndvHK54i3yppN1DxlD/zj+7kPwkpe7PXV81SvrgBygV/+kHeHMHjuuLq5UMX6so+/Myqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-3e1ff7000001d7ae-e9-67cf9b085d26
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
	yunjeong.mun@sk.com,
	Honggyu Kim <honggyu.kim@sk.com>
Subject: Re: [PATCH 2/2 v6] mm/mempolicy: Don't create weight sysfs for memoryless nodes
Date: Tue, 11 Mar 2025 11:07:27 +0900
Message-ID: <20250311020806.404-1-yunjeong.mun@sk.com>
X-Mailer: git-send-email 2.48.1.windows.1
In-Reply-To: <Z871k085e-Th-jTz@gourry-fedora-PF4VCD3F>
References: 
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBIsWRmVeSWpSXmKPExsXC9ZZnkS7H7PPpBl+ey1vMWb+GzWL61AuM
	FiduNrJZ/Lx7nN2iefF6NovVm3wt7i97xmJxu/8cq8WqhdfYLI5vncduse8iUMPOh2/ZLJbv
	62e0uLxrDpvFvTX/WS3mfpnKbLF6TYaDoMfhN++ZPXbOusvu0d12md2j5chbVo/Fe14yeWxa
	1cnmsenTJHaPEzN+s3jsfGjpsbBhKrPH/rlr2D3OXazw+Pj0FovH501yAXxRXDYpqTmZZalF
	+nYJXBkXb5xmLlgmW9G65gtzA+N9kS5GTg4JAROJmTsuMcPYF3fvZQSx2QQ0JA4eOgkU5+AQ
	EVCVaLvi3sXIxcEsMJdF4tyuhWwgNcICERLnHp1mAalhAap5tUEDJMwrYCbR0XiKFWKkpkTD
	pXtMICWcQPFLx2NBwkICPEDV+xkhygUlTs58wgJiMwvISzRvnQ11zS52idnTayFsSYmDK26w
	TGDkn4WkZRaSlgWMTKsYhTLzynITM3NM9DIq8zIr9JLzczcxAuNrWe2f6B2Mny4EH2IU4GBU
	4uENeHQuXYg1say4MvcQowQHs5II78ErQCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8Rt/KU4QE
	0hNLUrNTUwtSi2CyTBycUg2MM2uzbnV8/uC3UNw76J2pBfPZAm7TfYymWsfYCtuj3rguFjX/
	uNeXPaZN6F52pP2fzgm/r67hmSsxIb2k6J4MW8d2nsq3095a9UVds89Zwt797dIur4Dm7wcf
	1pj8CpvQor9dm1943xymRs7XceoSx4oTF+n98pyqK7f/rNx/+Zlf5jR/W1inxFKckWioxVxU
	nAgA1eYo9KsCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMIsWRmVeSWpSXmKPExsXCNUNWR5dj9vl0gyPfhS3mrF/DZjF96gVG
	ixM3G9ksft49zm7RvHg9m8XqTb4W95c9Y7H4/Ow1s8Xt/nOsFqsWXmOzOL51HrvFvotAXYfn
	nmS12PnwLZvF8n39jBaXd81hs7i35j+rxdwvU5ktDl17zmqxek2Gxe9tK9gcRD0Ov3nP7LFz
	1l12j+62y+weLUfesnos3vOSyWPTqk42j02fJrF7nJjxm8Vj50NLj4UNU5k99s9dw+5x7mKF
	x8ent1g8vt328Fj84gOTx+dNcgECUVw2Kak5mWWpRfp2CVwZF2+cZi5YJlvRuuYLcwPjfZEu
	Rk4OCQETiYu79zKC2GwCGhIHD51k7mLk4BARUJVou+LexcjFwSwwl0Xi3K6FbCA1wgIREuce
	nWYBqWEBqnm1QQMkzCtgJtHReIoVYqSmRMOle0wgJZxA8UvHY0HCQgI8QNX7GSHKBSVOznzC
	AmIzC8hLNG+dzTyBkWcWktQsJKkFjEyrGEUy88pyEzNzTPWKszMq8zIr9JLzczcxAqNqWe2f
	iTsYv1x2P8QowMGoxMMb8OhcuhBrYllxZe4hRgkOZiUR3oNXgEK8KYmVValF+fFFpTmpxYcY
	pTlYlMR5vcJTE4QE0hNLUrNTUwtSi2CyTBycUg2MFrM9nJw+XJBXWJkXuMF4l/WKC3l3ihdo
	HXjU3lCW8uWZQ+Q7z12mC5JNQiKFFB9vvvpV6YfWFe3Fm0+EWzPdrD12/1PNbvG0vxPWneK+
	dmHNiejyq8oT5OXlrj56dNdqFmur5v+L7yzuHOc4NetSfI5V1GSnzNn617meSq3+eMfd4n2d
	aSeTmhJLcUaioRZzUXEiAAEEaYmmAgAA
X-CFilter-Loop: Reflected

Hi Gregory,

On Mon, 10 Mar 2025 10:22:11 -0400 Gregory Price <gourry@gourry.net> wrote:
> On Mon, Mar 10, 2025 at 09:26:48PM +0900, Honggyu Kim wrote:
> > Yeah, the proximity domain detects the node correctly as follows in dmesg.
> > 
> >  [  0.009915] ACPI: SRAT: Node 0 PXM 0 [mem 0x00000000-0x7fffffff]
> >  [  0.009917] ACPI: SRAT: Node 0 PXM 0 [mem 0x100000000-0x207fffffff]
> >  [  0.009919] ACPI: SRAT: Node 1 PXM 1 [mem 0x60f80000000-0x64f7fffffff]
> >  [  0.009924] ACPI: SRAT: Node 2 PXM 6 [mem 0x2080000000-0x807fffffff] hotplug
> >  [  0.009925] ACPI: SRAT: Node 3 PXM 7 [mem 0x64f80000000-0x6cf7fffffff] hotplug
> > 
> > It is printed even before CXL detection.
> > 
> 
> I wrote a some documentation on some example configurations last friday
> 
> https://lore.kernel.org/linux-mm/Z226PG9t-Ih7fJDL@gourry-fedora-PF4VCD3F/T/#m2780e47df7f0962a79182502afc99843bb046205
> 

I've checked our CFMWS configurations using the information from this link and 
wrote them below.

> This isn't exhaustive, but as I said with Rakie, I think your
> configuration is probably ok - if slightly confusing.
> 

I wonder if the below data is sufficient for your review in Rakies's
email [1]. Please let me know.

> What I'm going to guess is happening is you have 1 CFMWS per device that
> do not have matching SRAT entries, and then the CFMWS covering these:
> 
> >  [  0.009924] ACPI: SRAT: Node 2 PXM 6 [mem 0x2080000000-0x807fffffff] hotplug
> >  [  0.009925] ACPI: SRAT: Node 3 PXM 7 [mem 0x64f80000000-0x6cf7fffffff] hotplug
> 
> have interleave set up
> 

In my understanding, both SRAT and CFMWS have the above device and interleave setup.

Below are the SRAT entries (with some unnecessary lines removed) :

[A128h 41256 001h]               Subtable Type : 01 [Memory Affinity]  
[A12Ah 41258 004h]            Proximity Domain : 00000006  
[A130h 41264 008h]                Base Address : 0000002080000000
[A138h 41272 008h]              Address Length : 0000006000000000  
                                     Enabled : 1  
                               Hot Pluggable : 1  
...
  
[A150h 41296 001h]               Subtable Type : 01 [Memory Affinity]  
[A152h 41298 004h]            Proximity Domain : 00000007  
[A158h 41304 008h]                Base Address : 0000064F80000000
[A160h 41312 008h]              Address Length : 0000008000000000  
                                     Enabled : 1  
                               Hot Pluggable : 1  

and below are the CFMWS configurations (with some unnecessary lines removed):

[0A4h 0164 001h]               Subtable Type : 01 [CXL Fixed Memory Window Structure]
[0ACh 0172 008h]         Window base address : 0000002080000000 <- Memory region
[0B4h 0180 008h]                 Window size : 0000032780000000
[0BCh 0188 001h]          Interleave Members : 01           <-- 2-way interleave
[0BDh 0189 001h]       Interleave Arithmetic : 01
[0C8h 0200 004h]                First Target : 00000043     <-- host bridge id  
[0CCh 0204 004h]                 Next Target : 00000053     <-- host bridge id 

...

[170h 0368 001h]               Subtable Type : 01 [CXL Fixed Memory Window Structure]
[178h 0376 008h]         Window base address : 0000064F80000000
[180h 0384 008h]                 Window size : 0000033000000000
[188h 0392 001h]          Interleave Members : 01          <-- 2-way interleave
[189h 0393 001h]       Interleave Arithmetic : 01
[194h 0404 004h]                First Target : 00000143    <-- host bridge id
[198h 0408 004h]                 Next Target : 00000153    <-- host bridge id

[1] https://lore.kernel.org/linux-mm/Z87zpg3TLRReikgu@gourry-fedora-PF4VCD3F/

Best regards,
Yunjeong

