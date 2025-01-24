Return-Path: <linux-acpi+bounces-10815-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA06A1B9A7
	for <lists+linux-acpi@lfdr.de>; Fri, 24 Jan 2025 16:48:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F8491888420
	for <lists+linux-acpi@lfdr.de>; Fri, 24 Jan 2025 15:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B2EE156879;
	Fri, 24 Jan 2025 15:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="GaOTwk+w"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E55814AD17
	for <linux-acpi@vger.kernel.org>; Fri, 24 Jan 2025 15:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737733702; cv=none; b=n+0lSSgWmK1eAUCnccE79y9r1nmn+iu2FV5FQabMoUb1gvwn7OQX3CvOBjNi+dP0TEkESV8EQ5WzK4AlmUnxmJh+HdQq5ccmaVbcFuzuSPa8kTwBdo2gQnz9wowgsRVOVk0tciZsRfiNwHA/d6lO1W/Wu9bUB2x7whSo1RlHnFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737733702; c=relaxed/simple;
	bh=vV35Mn7e+hzGvBxfwK2B/OBtMH5woGqqePsZPgqMYnY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kwcB75t+Cz42cK6FAlu5c/7vyOODbK887SceGdT+2ymGqeQki+9oNAzSZzfYXuwx142ordjeqJK6oplP901J4IX4TB9WVeGv+ZlZu3HYNgAUcpkck8ex/QAaJtQKE9NSpZt91z2a1K10d57QyNhFKPPCWF8sbVRgGKQrkPN4ZwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=GaOTwk+w; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7b9bc648736so227258885a.1
        for <linux-acpi@vger.kernel.org>; Fri, 24 Jan 2025 07:48:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1737733699; x=1738338499; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=m562TZx/BdOCXnSumLiFkdR7KvTDmTP7YvRm+7CCcuI=;
        b=GaOTwk+wQD7Ah0XQQUYppOqmGgDL+3ZGQvr0SGlBZqFeih3LzZKnSP261KydanGefO
         sq0gm1fSzwEYiryWI7ziUOUHsIximaqKa+geuYckLSyU+xOqNb5935mr9opFaWZCJNCz
         R2KuQP7DNVRUTuu9jdlWizXkhLfsMeAVjVLLy/eKyyKSrVjOEmiG0K/A6LfbEL1eutUj
         99N4o4CAS3WfBAzWm2DY+VOPLijevBQVzko/M7fbUjEV65rM9jT6BPemI4yaUV6aUZV/
         pH8/4oLfzky3ffgYtw+EIgs3rxVrdGLMHdgxFud1mOAnaua1sa2HRInje0cw8Ek6uwGS
         Y3kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737733699; x=1738338499;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m562TZx/BdOCXnSumLiFkdR7KvTDmTP7YvRm+7CCcuI=;
        b=PLPQTLSDaFV2q6UQNrFsYnV2Pyxv0S5IBliTQ2dt51tSkxJnKAInm5d9okWP0JAn3b
         vaTwa2OMYUjQzXecyYdmv9mSMGYNAUEGEmN0jLEeRFc90fUq4z6G9/9Gn9M7xLkgyqq2
         IzszO0JRbDsKKtx4YZpmyxQxlURHCf3k2Fep5D3i1Qtt1m0GzQJfqEYY9Sffh5k3ShFE
         mgtk/uvOmqOL1mp/5z8E0I08beMJekqO6MYy9nRWQkTcOrIi7xKXSNweT7PgM4mJzol+
         hjP3tBuLd5j8WE8g7Fvk7Qs6TOQVvgDHJ8yYQOJoD83T+x67skvG7/9S/yJdIP158vNH
         ElAg==
X-Forwarded-Encrypted: i=1; AJvYcCV49AT01b5CyOLrdbxaseIEsH71TK14Gn05GIhfsNeB0Svbjm/NBZDnYFOVB2Oi//ARzrwwf64MhfMg@vger.kernel.org
X-Gm-Message-State: AOJu0YyCp1wALg/sklC1zgCJqsMw42pbtOoreYXiJ+kEptYh137y9BlR
	VjoABqnySf8hSWQGNuChMCpYo2GNSYWMCNQiXZs1h7qgs/xu/97UdRXmAjtzkj8=
X-Gm-Gg: ASbGncv9af8MxO2YveDcnI50SbpgIg5y0E9oaXQW7lec+UsZ4BWakk+vKA65Dps17mp
	sdW/WmNjnHaQMl43CoaScImmjziyavSTI80spDwcu2pLr2XPilkmYwEJ1aZmvWgyEQ33LHGa4ze
	iEdwf6hhifIRSvLCbSHLSDv97EK7w2wLUh4gQojpXBSVfeYDVp46b3UAGRQpixbFxkEXjy116br
	XVbylzL1XOTZ5+Z8GKjp4P4lz0aaS8Xd1gMqn442tPTTo2TebVGq0ZbZFNhlOIfkQyU9Larja5V
	NR7HXkxcIg2WnHc45hjmkK5TG4e915JHIYn0zVX67rmSKD0H0Y3dWj/rnJp7aY0=
X-Google-Smtp-Source: AGHT+IHAmF9H/uJyOZ1fy3dvSN0mMIgEX3R3qF1HUo1sYQICkvQxxUc2gSc15oHllcaWPb/TZ5k1Sw==
X-Received: by 2002:a05:620a:2687:b0:7b6:d70a:86df with SMTP id af79cd13be357-7be6320aee0mr4993653785a.27.1737733699074;
        Fri, 24 Jan 2025 07:48:19 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7be9aeee9b7sm104073185a.68.2025.01.24.07.48.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2025 07:48:18 -0800 (PST)
Date: Fri, 24 Jan 2025 10:48:16 -0500
From: Gregory Price <gourry@gourry.net>
To: Matthew Wilcox <willy@infradead.org>
Cc: Joshua Hahn <joshua.hahnjy@gmail.com>, hyeonggon.yoo@sk.com,
	ying.huang@linux.alibaba.com, rafael@kernel.org, lenb@kernel.org,
	gregkh@linuxfoundation.org, akpm@linux-foundation.org,
	honggyu.kim@sk.com, rakie.kim@sk.com, dan.j.williams@intel.com,
	Jonathan.Cameron@huawei.com, dave.jiang@intel.com,
	horen.chuang@linux.dev, hannes@cmpxchg.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-mm@kvack.org, kernel-team@meta.com
Subject: Re: [PATCH v3] Weighted interleave auto-tuning
Message-ID: <Z5O2QATuhvRnygcx@gourry-fedora-PF4VCD3F>
References: <20250115185854.1991771-1-joshua.hahnjy@gmail.com>
 <Z5Mr8WQGEZZjp9Uu@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z5Mr8WQGEZZjp9Uu@casper.infradead.org>

On Fri, Jan 24, 2025 at 05:58:09AM +0000, Matthew Wilcox wrote:
> On Wed, Jan 15, 2025 at 10:58:54AM -0800, Joshua Hahn wrote:
> > On machines with multiple memory nodes, interleaving page allocations
> > across nodes allows for better utilization of each node's bandwidth.
> > Previous work by Gregory Price [1] introduced weighted interleave, which
> > allowed for pages to be allocated across NUMA nodes according to
> > user-set ratios.
> 
> I still don't get it.  You always want memory to be on the local node or
> the fabric gets horribly congested and slows you right down.  But you're
> not really talking about NUMA, are you?  You're talking about CXL.
> 
> And CXL is terrible for bandwidth.  I just ran the numbers.
> 
> On a current Intel top-end CPU, we're looking at 8x DDR5-4800 DIMMs,
> each with a bandwidth of 38.4GB/s for a total of 300GB/s.
> 
> For each CXL lane, you take a lane of PCIe gen5 away.  So that's
> notionally 32Gbit/s, or 4GB/s per lane.  But CXL is crap, and you'll be
> lucky to get 3 cachelines per 256 byte packet, dropping you down to 3GB/s.
> You're not going to use all 80 lanes for CXL (presumably these CPUs are
> going to want to do I/O somehow), so maybe allocate 20 of them to CXL.
> That's 60GB/s, or a 20% improvement in bandwidth.  On top of that,
> it's slow, with a minimum of 10ns latency penalty just from the CXL
> encode/decode penalty.
>

From the original - the performance tests show considerable opportunity
in the scenarios where DRAM bandwidth is pressured - as you can either

1) Lower the DRAM bandwidth pressure by offloading some cachelines to
   CXL - reducing latency on DRAM and reducing average latency overall.

   The latency cost on CXL lines gets amortized over all DRAM fetches
   no longer hitting stalls.

2) Under full-pressure scenarios (DRAM and CXL are saturated), the
   additional lanes / buffers provide more concurrent fetches - i.e.
   you're just doing more work (and avoiding going to storage).

   This is the weaker of the two scenarios.

No one is proposing we switch the default policy to weighted interleave.

= Performance summary =
(tests may have different configurations, see extended info below)
1) MLC (W2) : +38% over DRAM. +264% over default interleave.
   MLC (W5) : +40% over DRAM. +226% over default interleave.
2) Stream   : -6% to +4% over DRAM, +430% over default interleave.
3) XSBench  : +19% over DRAM. +47% over default interleave.

=====================================================================
Performance tests - MLC
From - Ravi Jonnalagadda <ravis.opensrc@micron.com>

Hardware: Single-socket, multiple CXL memory expanders.

Workload:                               W2
Data Signature:                         2:1 read:write
DRAM only bandwidth (GBps):             298.8
DRAM + CXL (default interleave) (GBps): 113.04
DRAM + CXL (weighted interleave)(GBps): 412.5
Gain over DRAM only:                    1.38x
Gain over default interleave:           2.64x

Workload:                               W5
Data Signature:                         1:1 read:write
DRAM only bandwidth (GBps):             273.2
DRAM + CXL (default interleave) (GBps): 117.23
DRAM + CXL (weighted interleave)(GBps): 382.7
Gain over DRAM only:                    1.4x
Gain over default interleave:           2.26x

=====================================================================
Performance test - Stream
From - Gregory Price <gregory.price@memverge.com>

Hardware: Single socket, single CXL expander

Summary: 64 threads, ~18GB workload, 3GB per array, executed 100 times
Default interleave : -78% (slower than DRAM)
Global weighting   : -6% to +4% (workload dependant)
mbind  weights     : +2.5% to +4% (consistently better than DRAM)

=====================================================================
Performance tests - XSBench
From - Hyeongtak Ji <hyeongtak.ji@sk.com>

Hardware: Single socket, Single CXL memory Expander

NUMA node 0: 56 logical cores, 128 GB memory
NUMA node 2: 96 GB CXL memory
Threads:     56
Lookups:     170,000,000

Summary: +19% over DRAM. +47% over default interleave.


> Putting page cache in the CXL seems like nonsense to me.  I can see it
> making sense to swap to CXL, or allocating anonymous memory for tasks
> with low priority on it.  But I just can't see the point of putting
> pagecache on CXL.

No one said anything about page cache - but it depends.

If you can keep your entire working set in-memory and on-CXL, as opposed
to swapping to disk - you win.  "Swapping to CXL" incurs a bunch of page
faults, that sounds like a lose.

However - the stream test from the original proposal agrees with you
that just making everything interleaved (code, pagecache, etc) is at
best a wash:

Global weighting   : -6% to +4% (workload dependant)

But targeting specific regions can provide a modest bump

mbind weights      : +2.5% to +4% (consistently better than DRAM)

~Gregory

