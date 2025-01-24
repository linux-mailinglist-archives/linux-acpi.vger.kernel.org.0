Return-Path: <linux-acpi+bounces-10809-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 80214A1B02B
	for <lists+linux-acpi@lfdr.de>; Fri, 24 Jan 2025 06:58:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76851188D654
	for <lists+linux-acpi@lfdr.de>; Fri, 24 Jan 2025 05:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9131C1D7E31;
	Fri, 24 Jan 2025 05:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eF8xY1e9"
X-Original-To: linux-acpi@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3DF1D7E3E;
	Fri, 24 Jan 2025 05:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737698306; cv=none; b=Aa33Z+1DXVqst/NDtpHQ7VA2gzRaBwHAoH70z3Q4H2nWWW2qZTEaOeeqnopEE0sAZETitUGGDLSQTEmBsepmebNBbE01q9mIgyNvgBlYEk3D1MfnsoNYuDiB8BI7Jj3MvSBKNniyW/lKaFYYacu37+iuyWvPyIdfbFYzYBh7s9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737698306; c=relaxed/simple;
	bh=+tTd/GT6GrfnQPTYWfKp2oZ1lvffZicnNE2av2idxnM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SF7wmMqtRGTD0U+LiSlKe8zpoMHmH9ha5f/v/sRW8W/XdHsxczdQ0XUt0MI5IKeDXOfIGmO7ZcqNGgdFXU23MGEn5EQZpl862j7Il9tnrGCPqzU9dzQx+bG2l0c+FpBIPzp+uEs2P+6jbnB2J1uNM/bCcuXdQxbvj9BCivgzKk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=eF8xY1e9; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=wxNlNLDu+fIZSQcO3Iicv//qqn4spfDKGdfi3EWd53Q=; b=eF8xY1e9uuwkHz3VVz56Evp0qC
	SIQoqiI1q46U5oh/ECKxBpzx4P//huxRF1BV1o06Wc0j3od0aGrYIvEEReWR8KH5EN+iwW/I/TpJu
	rV6Yw5HgAhf9gqwfUake9tuk/VQtym3wSxxUbkC4hCNK4OIp3vJSnXAgASIwWVBYRyWRcicbTRRBR
	4AberFy1PKbz992G/bQRyHtWpGO3s5IplPAwsfCc5Ff6+Z/jZcAhKxs4Go9q6cTr8deWOhvR7dL2E
	YLvz3QNBTL4PN1R8ZwNKk8k6x2QMZ1RDWfSV0iOO7Bi62+aqklZbgiC+09NQsPSEhV6+hovSdwfvo
	awNWBcAw==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tbChl-0000000Di6h-1UWa;
	Fri, 24 Jan 2025 05:58:09 +0000
Date: Fri, 24 Jan 2025 05:58:09 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: gourry@gourry.net, hyeonggon.yoo@sk.com, ying.huang@linux.alibaba.com,
	rafael@kernel.org, lenb@kernel.org, gregkh@linuxfoundation.org,
	akpm@linux-foundation.org, honggyu.kim@sk.com, rakie.kim@sk.com,
	dan.j.williams@intel.com, Jonathan.Cameron@huawei.com,
	dave.jiang@intel.com, horen.chuang@linux.dev, hannes@cmpxchg.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-mm@kvack.org, kernel-team@meta.com
Subject: Re: [PATCH v3] Weighted interleave auto-tuning
Message-ID: <Z5Mr8WQGEZZjp9Uu@casper.infradead.org>
References: <20250115185854.1991771-1-joshua.hahnjy@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250115185854.1991771-1-joshua.hahnjy@gmail.com>

On Wed, Jan 15, 2025 at 10:58:54AM -0800, Joshua Hahn wrote:
> On machines with multiple memory nodes, interleaving page allocations
> across nodes allows for better utilization of each node's bandwidth.
> Previous work by Gregory Price [1] introduced weighted interleave, which
> allowed for pages to be allocated across NUMA nodes according to
> user-set ratios.

I still don't get it.  You always want memory to be on the local node or
the fabric gets horribly congested and slows you right down.  But you're
not really talking about NUMA, are you?  You're talking about CXL.

And CXL is terrible for bandwidth.  I just ran the numbers.

On a current Intel top-end CPU, we're looking at 8x DDR5-4800 DIMMs,
each with a bandwidth of 38.4GB/s for a total of 300GB/s.

For each CXL lane, you take a lane of PCIe gen5 away.  So that's
notionally 32Gbit/s, or 4GB/s per lane.  But CXL is crap, and you'll be
lucky to get 3 cachelines per 256 byte packet, dropping you down to 3GB/s.
You're not going to use all 80 lanes for CXL (presumably these CPUs are
going to want to do I/O somehow), so maybe allocate 20 of them to CXL.
That's 60GB/s, or a 20% improvement in bandwidth.  On top of that,
it's slow, with a minimum of 10ns latency penalty just from the CXL
encode/decode penalty.

Putting page cache in the CXL seems like nonsense to me.  I can see it
making sense to swap to CXL, or allocating anonymous memory for tasks
with low priority on it.  But I just can't see the point of putting
pagecache on CXL.

