Return-Path: <linux-acpi+bounces-12062-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A6B5A5B7AB
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Mar 2025 05:03:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4D0418944EF
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Mar 2025 04:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F8121E5B79;
	Tue, 11 Mar 2025 04:03:03 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1FDC1D555;
	Tue, 11 Mar 2025 04:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741665783; cv=none; b=ADyvp/Qn0NyiK1mjYsCvk3+O8YwCjQwdJ9ThTssa7e7x9+7nDtrXlJ7hcyR4SUmBhG8bINTOSN7vnM+3D+gsKj+XCrXGXG3fz5DAf0DYsFB0XNZMa74SKMnzajR4EKo1Rrq7YDDbPa99UbUI7bq/ncrvlwpcR/16kb3AnebPTWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741665783; c=relaxed/simple;
	bh=YurqVvHXQp1aiEyK7VmaCHhOskfFdqgMG11qhnK0I40=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=duhOk6Vs4W4QxyQoRaekoOGd+k+U9X/LS9CpH49IQ8qNVKH9QclBSe2KddA0nzR2BB5YusGP8t5VJ0icS2pb4zEd434fNiK8e5hScUe2sEJIQavn+zTtC3S7BGYt07y42+yOodOY0iBFgkZga80P104Udk6qb34/BMTjG1/QZp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-3c9ff7000001d7ae-56-67cfb5eed2d1
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
Date: Tue, 11 Mar 2025 13:02:07 +0900
Message-ID: <20250311040252.425-1-yunjeong.mun@sk.com>
X-Mailer: git-send-email 2.48.1.windows.1
In-Reply-To: <Z8-jLIugrb86KBSZ@gourry-fedora-PF4VCD3F>
References: 
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNIsWRmVeSWpSXmKPExsXC9ZZnke67refTDfa9tbSYs34Nm8X0qRcY
	LU7cbGSz+Hn3OLtF8+L1bBarN/la3F/2jMXidv85VotVC6+xWRzfOo/dYt9FoIadD9+yWSzf
	189ocXnXHDaLe2v+s1rM/TKV2WL1mgwHQY/Db94ze+ycdZfdo7vtMrtHy5G3rB6L97xk8ti0
	qpPNY9OnSeweJ2b8ZvHY+dDSY2HDVGaP/XPXsHucu1jh8fHpLRaPz5vkAviiuGxSUnMyy1KL
	9O0SuDJ2LJvOVHDUrKJnyQaWBsY+1S5GTg4JAROJrmM72GHsQ3PngtlsAhoSBw+dZO5i5OAQ
	EVCVaLvi3sXIxcEs0MYicfPVYkaQGmGBCIlzj06zgNgsQDXfH79mA7F5Bcwkvm84xgQxU1Oi
	4dI9MJsTKL7g6ExWEFtIgEfi1Yb9jBD1ghInZz4Bm8MsIC/RvHU2M8gyCYFt7BJT7m1lhRgk
	KXFwxQ2WCYz8s5D0zELSs4CRaRWjUGZeWW5iZo6JXkZlXmaFXnJ+7iZGYJQtq/0TvYPx04Xg
	Q4wCHIxKPLwBj86lC7EmlhVX5h5ilOBgVhLhPXgFKMSbklhZlVqUH19UmpNafIhRmoNFSZzX
	6Ft5ipBAemJJanZqakFqEUyWiYNTqoHRJ6T4z5VtEU/uXpJl+K8jVzhjU2jf5X+3i8+VWM89
	3j5rp7F8St3GqXuu+EwPNHDXuFz7UuZW2TID1x9HWmyDNC/LSsjc/yzpf+z/o9hbp2yTzih1
	2O3Yl6CSK1m4OOjSaev0DQzruaQvNMmE1bU9WrWwTF5f82lhkcdkjVd3U+Qz/qheX+GpxFKc
	kWioxVxUnAgAQ6OLYq4CAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAIsWRmVeSWpSXmKPExsXCNUNWR/fd1vPpBq9e6ljMWb+GzWL61AuM
	FiduNrJZ/Lx7nN2iefF6NovVm3wt7i97xmLx+dlrZovb/edYLVYtvMZmcXzrPHaLfReBug7P
	PclqsfPhWzaL5fv6GS0u75rDZnFvzX9Wi7lfpjJbHLr2nNVi9ZoMBxGPw2/eM3vsnHWX3aO7
	7TK7R8uRt6wei/e8ZPLYtKqTzWPTp0nsHidm/Gbx2PnQ0mNhw1Rmj/1z17B7nLtY4fHx6S0W
	j2+3PTwWv/jA5PF5k1yAQBSXTUpqTmZZapG+XQJXxo5l05kKjppV9CzZwNLA2KfaxcjJISFg
	InFo7lx2EJtNQEPi4KGTzF2MHBwiAqoSbVfcuxi5OJgF2lgkbr5azAhSIywQIXHu0WkWEJsF
	qOb749dsIDavgJnE9w3HmCBmako0XLoHZnMCxRccnckKYgsJ8Ei82rCfEaJeUOLkzCdgc5gF
	5CWat85mnsDIMwtJahaS1AJGplWMIpl5ZbmJmTmmesXZGZV5mRV6yfm5mxiB8bSs9s/EHYxf
	LrsfYhTgYFTi4Q14dC5diDWxrLgy9xCjBAezkgjvwStAId6UxMqq1KL8+KLSnNTiQ4zSHCxK
	4rxe4akJQgLpiSWp2ampBalFMFkmDk6pBsYLAlvPaTRv/rLX3fuKcHhNAtfBJJWkk2uitnSG
	Zei/enTKjStu6ZauvhXaH2cUyVc6bn7HdsNf48zULB+/7vW5dx+WmRmcevY797wtm6R07mvT
	mHVHXY877dwRF73YbH7Z1PNMy57+6Ildui+qyvnmtAdeMmWv38te1t73Y/I295ba7vNLPyor
	sRRnJBpqMRcVJwIApvCxRaMCAAA=
X-CFilter-Loop: Reflected

Hi Gregory,

On Mon, 10 Mar 2025 22:42:52 -0400 Gregory Price <gourry@gourry.net> wrote:
> On Tue, Mar 11, 2025 at 11:07:27AM +0900, Yunjeong Mun wrote:
> > Hi Gregory,
> > 
> > In my understanding, both SRAT and CFMWS have the above device and interleave setup.
> > 
> > and below are the CFMWS configurations (with some unnecessary lines removed):
> > 
> > [0A4h 0164 001h]               Subtable Type : 01 [CXL Fixed Memory Window Structure]
> > [0ACh 0172 008h]         Window base address : 0000002080000000 <- Memory region
> > [0B4h 0180 008h]                 Window size : 0000032780000000
> > [0BCh 0188 001h]          Interleave Members : 01           <-- 2-way interleave
> > [0BDh 0189 001h]       Interleave Arithmetic : 01
> > [0C8h 0200 004h]                First Target : 00000043     <-- host bridge id  
> > [0CCh 0204 004h]                 Next Target : 00000053     <-- host bridge id 
> > 
> > ...
> > 
> > [170h 0368 001h]               Subtable Type : 01 [CXL Fixed Memory Window Structure]
> > [178h 0376 008h]         Window base address : 0000064F80000000
> > [180h 0384 008h]                 Window size : 0000033000000000
> > [188h 0392 001h]          Interleave Members : 01          <-- 2-way interleave
> > [189h 0393 001h]       Interleave Arithmetic : 01
> > [194h 0404 004h]                First Target : 00000143    <-- host bridge id
> > [198h 0408 004h]                 Next Target : 00000153    <-- host bridge id
> >
> 
> Are you able to share all CXL Fixed Memory Window Structures in the
> CEDT?  Just want to confirm some suspicions here about why we're seeing
> 12 NUMA nodes.  This explains 2 and suggests there's at least 4 host
> bridges - but not the other 8.
>

Ok, there are 10 CFMWS entries and 4 host bridges in cedt.dsl.
Below is the information for all CFMWS entries and host bridge in the CEDT:

[024h 0036 001h]               Subtable Type : 00 [CXL Host Bridge Structure]
[028h 0040 004h]      Associated host bridge : 00000043

[044h 0068 001h]               Subtable Type : 00 [CXL Host Bridge Structure]
[048h 0072 004h]      Associated host bridge : 00000053

[064h 0100 001h]               Subtable Type : 00 [CXL Host Bridge Structure]
[068h 0104 004h]      Associated host bridge : 00000143

[084h 0132 001h]               Subtable Type : 00 [CXL Host Bridge Structure]
[088h 0136 004h]      Associated host bridge : 00000153
 
[0A4h 0164 001h]               Subtable Type : 01 [CXL Fixed Memory Window Structure]
[0ACh 0172 008h]         Window base address : 0000002080000000
[0B4h 0180 008h]                 Window size : 0000032780000000
[0BCh 0188 001h]          Interleave Members : 01
[0BDh 0189 001h]       Interleave Arithmetic : 01
[0C8h 0200 004h]                First Target : 00000043
[0CCh 0204 004h]                 Next Target : 00000053

[0D0h 0208 001h]               Subtable Type : 01 [CXL Fixed Memory Window Structure]
[0D8h 0216 008h]         Window base address : 0000034800000000
[0E0h 0224 008h]                 Window size : 00000163C0000000
[0E8h 0232 001h]          Interleave Members : 00
[0F4h 0244 004h]                First Target : 00000043

[0F8h 0248 001h]               Subtable Type : 01 [CXL Fixed Memory Window Structure]
[100h 0256 008h]         Window base address : 000004ABC0000000
[108h 0264 008h]                 Window size : 00000163C0000000
[110h 0272 001h]          Interleave Members : 00
[111h 0273 001h]       Interleave Arithmetic : 00
[11Ch 0284 004h]                First Target : 00000053

[120h 0288 001h]               Subtable Type : 01 [CXL Fixed Memory Window Structure]
[128h 0296 008h]         Window base address : 00000C2F80000000
[130h 0304 008h]                 Window size : 000002F840000000
[138h 0312 001h]          Interleave Members : 00
[139h 0313 001h]       Interleave Arithmetic : 00
[144h 0324 004h]                First Target : 00000043


[148h 0328 001h]               Subtable Type : 01 [CXL Fixed Memory Window Structure]
[150h 0336 008h]         Window base address : 00000F27C0000000
[158h 0344 008h]                 Window size : 000002F840000000
[160h 0352 001h]          Interleave Members : 00
[161h 0353 001h]       Interleave Arithmetic : 00
[16Ch 0364 004h]                First Target : 00000053

[170h 0368 001h]               Subtable Type : 01 [CXL Fixed Memory Window Structure]
[178h 0376 008h]         Window base address : 0000064F80000000
[180h 0384 008h]                 Window size : 0000033000000000
[188h 0392 001h]          Interleave Members : 01
[189h 0393 001h]       Interleave Arithmetic : 01
[194h 0404 004h]                First Target : 00000143
[198h 0408 004h]                 Next Target : 00000153

[19Ch 0412 001h]               Subtable Type : 01 [CXL Fixed Memory Window Structure]
[1A4h 0420 008h]         Window base address : 0000097F80000000
[1ACh 0428 008h]                 Window size : 0000015800000000
[1B4h 0436 001h]          Interleave Members : 00
[1B5h 0437 001h]       Interleave Arithmetic : 00
[1C0h 0448 004h]                First Target : 00000143

[1C4h 0452 001h]               Subtable Type : 01 [CXL Fixed Memory Window Structure]
[1CCh 0460 008h]         Window base address : 00000AD780000000
[1D4h 0468 008h]                 Window size : 0000015800000000
[1DCh 0476 001h]         Interleave Members : 00 
[1DDh 0477 001h]       Interleave Arithmetic : 00 
[1E8h 0488 004h]                First Target : 00000153

[1ECh 0492 001h]               Subtable Type : 01 [CXL Fixed Memory Window Structure]
[1F4h 0500 008h]         Window base address : 0000122000000000
[1FCh 0508 008h]                 Window size : 000002F000000000
[204h 0516 001h]          Interleave Members : 00
[205h 0517 001h]       Interleave Arithmetic : 00
[210h 0528 004h]                First Target : 00000143

[214h 0532 001h]               Subtable Type : 01 [CXL Fixed Memory Window Structure]
[21Ch 0540 008h]         Window base address : 0000151000000000
[224h 0548 008h]                 Window size : 000002F000000000
[22Ch 0556 001h]          Interleave Members : 00
[22Dh 0557 001h]       Interleave Arithmetic : 00
[238h 0568 004h]                First Target : 00000153

In my understanding, the reason we are seeing 12 NUMA node is because
it loops through node_states[N_POSSIBLE] and its value is 4095 (twelves ones)
in the code [1]  below:

        for_each_node_state(nid, N_POSSIBLE) {
                err = add_weight_node(nid, wi_kobj);
                if (err) {
                        pr_err("failed to add sysfs [node%d]\n", nid);
                        break;
                }
        }

Since I'm not familiar with the CEDT, I'm wondering if you mean that N_POSSIBLE 
is associated with the number of CFMWS.

[1] https://github.com/torvalds/linux/blob/v6.14-rc6/mm/mempolicy.c#L3508-L3514

> ~Gregory
> 

Best regrads,
Yunjeong

