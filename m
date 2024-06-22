Return-Path: <linux-acpi+bounces-6583-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B16D691316D
	for <lists+linux-acpi@lfdr.de>; Sat, 22 Jun 2024 03:34:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14F722865D9
	for <lists+linux-acpi@lfdr.de>; Sat, 22 Jun 2024 01:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B91414A04;
	Sat, 22 Jun 2024 01:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="sDqwaRZL"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1327FB;
	Sat, 22 Jun 2024 01:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719020055; cv=none; b=sWqy5NVu9MRc0WWqD+ad4weneu6WRifTe41dWztKgRpI4GIKP18sILCkfRsV+NSlnf5dsoUcGc4gTFC8T3ywRs07pGDMf8BiNkZleIPNPvG2VX7wVHuWUHlIXTCojNngHGZNgjkPi8pNH0+131YxCiFk3ksPvpjNBsg1Ktu60MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719020055; c=relaxed/simple;
	bh=qm2vMyK4qA3/y0Ko7/pKvfxx5RuC8dDvYU8t1o6RE0M=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=tFzZbpX1LXLF5ag+fBEksV6EeMWy+XpO5/VrwUlDFUPD4efR99mluUY0pKAHeVl7ylXhklPrjHZDzyfDgR9JUikHZjxWKA4HqpIBCbLBnGrFcnSaaeP6uHj8iS59jtqiLrgOpPxdy47pZEvuJNLhDzczG9pCw7i34+aBa3/FTVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=sDqwaRZL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16263C2BBFC;
	Sat, 22 Jun 2024 01:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1719020055;
	bh=qm2vMyK4qA3/y0Ko7/pKvfxx5RuC8dDvYU8t1o6RE0M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sDqwaRZLFfHd0f1KM1T9LFUkgNQ3fBnIJdbjPE/4sd9gdDOOCgF2/9GQpF8iF2ZlL
	 gnrSdzqtK3iQ4xxFCtE49X5p5HjU0AFeCnkcB+Juai0z+YfstoWZyvB4nG/fTZcDFt
	 4rOwheB3ecFSZ+f7JM2Z6NNVqXqvsmNczKzfjZ4E=
Date: Fri, 21 Jun 2024 18:34:13 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: "Ho-Ren (Jack) Chuang" <horen.chuang@linux.dev>
Cc: "Jonathan Cameron" <Jonathan.Cameron@Huawei.com>, "Huang, Ying"
 <ying.huang@intel.com>, "Gregory Price" <gourry.memverge@gmail.com>,
 aneesh.kumar@linux.ibm.com, mhocko@suse.com, tj@kernel.org,
 john@jagalactic.com, "Eishan Mirakhur" <emirakhur@micron.com>,
 "Vinicius Tavares Petrucci" <vtavarespetr@micron.com>, "Ravis OpenSrc"
 <Ravis.OpenSrc@micron.com>, "Alistair Popple" <apopple@nvidia.com>,
 "Srinivasulu Thanneeru" <sthanneeru@micron.com>, "SeongJae Park"
 <sj@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown
 <lenb@kernel.org>, Dave Jiang <dave.jiang@intel.com>, Dan Williams
 <dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, "Ho-Ren (Jack) Chuang" <horenc@vt.edu>,
 "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>, "Ho-Ren (Jack) Chuang"
 <horenchuang@gmail.com>, linux-cxl@vger.kernel.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v1] memory tier: consolidate the initialization of
 memory tiers
Message-Id: <20240621183413.1638e7453a0bed2af5f44273@linux-foundation.org>
In-Reply-To: <20240621044833.3953055-1-horen.chuang@linux.dev>
References: <20240621044833.3953055-1-horen.chuang@linux.dev>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 21 Jun 2024 04:48:30 +0000 "Ho-Ren (Jack) Chuang" <horen.chuang@linux.dev> wrote:

> If we simply move the set_node_memory_tier() from memory_tier_init() to
> late_initcall(), it will result in HMAT not registering the
> mt_adistance_algorithm callback function,

Immediate reaction: then don't do that!

> because set_node_memory_tier()
> is not performed during the memory tiering initialization phase,
> leading to a lack of correct default_dram information.
> 
> Therefore, we introduced a nodemask to pass the information of the
> default DRAM nodes. The reason for not choosing to reuse
> default_dram_type->nodes is that it is not clean enough. So in the end,
> we use a __initdata variable, which is a variable that is released once
> initialization is complete, including both CPU and memory nodes for HMAT
> to iterate through.
> 
> Besides, since default_dram_type may be checked/used during the
> initialization process of HMAT and drivers, it is better to keep the
> allocation of default_dram_type in memory_tier_init().

What is this patch actually aiming to do?  Is it merely a code cleanup,
or are there functional changes?

> Signed-off-by: Ho-Ren (Jack) Chuang <horenchuang@bytedance.com>
> ---
> Hi all,
> 
> The current memory tier initialization process is distributed across two
> different functions, memory_tier_init() and memory_tier_late_init(). This
> design is hard to maintain. Thus, this patch is proposed to reduce the
> possible code paths by consolidating different initialization patches into one.

Ah, there it is.  Please make this the opening paragraph, not an aside
buried below the ^---$.

I'll await review input before proceeding with this, thanks.

