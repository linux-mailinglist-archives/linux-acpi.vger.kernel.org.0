Return-Path: <linux-acpi+bounces-8882-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C0F99A6F31
	for <lists+linux-acpi@lfdr.de>; Mon, 21 Oct 2024 18:17:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DF3F28357F
	for <lists+linux-acpi@lfdr.de>; Mon, 21 Oct 2024 16:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29EA61CCB29;
	Mon, 21 Oct 2024 16:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="NRtPB5xQ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2CD1991C2
	for <linux-acpi@vger.kernel.org>; Mon, 21 Oct 2024 16:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729527431; cv=none; b=utyloNamtZjxx0/gwyzBt0dtIonFSaGDddLPyXJjEwD+HBq53IQ6vpe6Ew3RhjBQYSg4gmZLVcPRWJUQA+gM7Z5yeMRY8VdMOTuqKW736joMxK1UipLnIu3h8AX0ULukhz/2uGKpXyMqqABHKPT4kxZ3jNDAhaHbHTSuNdXk4qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729527431; c=relaxed/simple;
	bh=nX/1rDDEMfdGbK4oP/qb8TFBYHJGcq4PCXVIxP7Du+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Epfg0IIky4KWsMNFAbZ+VF2jMZ7/P+q3d8/tF+Q8cSWumt21XYssgm/guxP79UaadMYeQDD2DVhO3K/1xsSgPVOBQD8hF1Qw9ubueIyi1eOEtYnepnFgmmPM8zzlpkye9JDXLF4TDdlLe+oTYyccq9l4DzM0VZDqCZNXc6lCfH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=NRtPB5xQ; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-460e6d331d6so6541071cf.2
        for <linux-acpi@vger.kernel.org>; Mon, 21 Oct 2024 09:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1729527427; x=1730132227; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gEfONzhDqFGNtDvGcVV2OjNwgNeswu1gnCdcntMBt+E=;
        b=NRtPB5xQ4M+w3j2vJ+NviNHxBPeKP8euHOHsnTTWraogv25IbRUdZgGMYcjrGsmsZK
         veScMkNzTPCGHbmWAuXqhMfRc4dHJSUi6dUW5WZ3UrKvd7esfS8xakYalOaLQRAzMGLx
         4+UmPc4zA4dehDhDLH8q3+9/yTAxwniqN9tM55sD10BP4cIMN1i7PvK9SYSWRg+LHpVY
         kaSutnLuF3J0wYOsXTz70NMG4UjRNeAo8+jaz32L/35z/opJEJjwWl+ZcBgLFbbAhB7V
         Q/K4zN0tlz/C6GHpGZNVcHyXxDVMhrCFRo2YFV4xa7wTVnnIm3VTgY/2Q4uRKTHdu4de
         aCBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729527427; x=1730132227;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gEfONzhDqFGNtDvGcVV2OjNwgNeswu1gnCdcntMBt+E=;
        b=DzWABJXpLccTs/c6FJvdewdHMz5kFfzd0fensLbvhtkI1HwHUDW//14WvmM3jDGj1G
         JyGlUCmyJxtR9oHrIr9fjO40g434Abjqsy83sP1NF9vD//C7QeceFWbqBIyJHESMtGF/
         rg2PRv6ncBeaOM5RicVxDLSEzeXam/pSmGiunC1VaBqF4AAjp0kM3vZJMNDx5NNkAjpw
         yVvguUmfBbG65fDtcJhVVOJEY5Q3oqYPx5T3pp3g5H9EyDyDyF9jKNOiU9fyd1p6to07
         LdhYczGvllLxM786d1t3BD0J6dBi+ySj7R/rfkCJpQIj2cQQ7x5kC6f3Puv364nlMVK+
         SWjA==
X-Forwarded-Encrypted: i=1; AJvYcCVX0+1LRXz93xPT2hnZN0QbsaWEm/lrMYLGqfFu2/ToaAZqH8vqvFDfb6lw4Yf93q3DE3W0IapJ5QUo@vger.kernel.org
X-Gm-Message-State: AOJu0YwsoUfkMHr+k1EC1sWhakcW/xW4zHMPHZ4QcR8jpzlx9L4Q1TGb
	1xWgLUeifThENhqzEpN+FbDm6vDAooehj2YFvNkmRLwVTg996HIXuUAUaIqwfNY=
X-Google-Smtp-Source: AGHT+IFlwa+hY7tlLp1VVOtE4ZB+LHnzpcwpYzAHWBfO5e5xtdUCSHXs+mU0bRAc7fVRuYNN4H/eYw==
X-Received: by 2002:a05:622a:1992:b0:45f:8ee:1859 with SMTP id d75a77b69052e-460aeba0e48mr203414481cf.0.1729527426826;
        Mon, 21 Oct 2024 09:17:06 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-460d3cbb3c3sm19515151cf.52.2024.10.21.09.17.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 09:17:06 -0700 (PDT)
Date: Mon, 21 Oct 2024 12:17:08 -0400
From: Gregory Price <gourry@gourry.net>
To: David Hildenbrand <david@redhat.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-mm@kvack.org,
	dan.j.williams@intel.com, ira.weiny@intel.com,
	dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
	rafael@kernel.org, lenb@kernel.org, rppt@kernel.org,
	akpm@linux-foundation.org, alison.schofield@intel.com,
	Jonathan.Cameron@huawei.com, rrichter@amd.com, ytcoode@gmail.com,
	haibo1.xu@intel.com, dave.jiang@intel.com
Subject: Re: [PATCH v2 2/3] x86: probe memblock size advisement value during
 mm init
Message-ID: <ZxZ-hOrVp52seena@PC2K9PVX.TheFacebook.com>
References: <20241016192445.3118-1-gourry@gourry.net>
 <20241016192445.3118-3-gourry@gourry.net>
 <7b877356-f5c5-4996-904b-6c3b71389255@redhat.com>
 <ZxZpTlnhYPqg-tGh@PC2K9PVX.TheFacebook.com>
 <eb380e90-f5f5-40d5-b0a7-54b2bb50f7a3@redhat.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb380e90-f5f5-40d5-b0a7-54b2bb50f7a3@redhat.com>

On Mon, Oct 21, 2024 at 05:57:28PM +0200, David Hildenbrand wrote:
> On 21.10.24 16:46, Gregory Price wrote:
> > On Mon, Oct 21, 2024 at 01:12:26PM +0200, David Hildenbrand wrote:
> > > 
> > > 
> > > Am 16.10.24 um 21:24 schrieb Gregory Price:
> > > > Systems with hotplug may provide an advisement value on what the
> > > > memblock size should be.  Probe this value when the rest of the
> > > > configuration values are considered.
> > > > 
> > > > The new heuristic is as follows
> > > > 
> > > > 1) set_memory_block_size_order value if already set (cmdline param)
> > > > 2) minimum block size if memory is less than large block limit
> > > > 3) [new] hotplug advise: lesser of advise value or memory alignment
> > > > 4) Max block size if system is bare-metal
> > > > 5) Largest size that aligns to end of memory.
> > > > 
> > > > Suggested-by: David Hildenbrand <david@redhat.com>
> > > > Signed-off-by: Gregory Price <gourry@gourry.net>
> > > > ---
> > > >    arch/x86/mm/init_64.c | 16 ++++++++++++++++
> > > >    1 file changed, 16 insertions(+)
> > > > 
> > > > diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
> > > > index ff253648706f..b72923b12d99 100644
> > > > --- a/arch/x86/mm/init_64.c
> > > > +++ b/arch/x86/mm/init_64.c
> > > > @@ -1439,6 +1439,7 @@ static unsigned long probe_memory_block_size(void)
> > > >    {
> > > >    	unsigned long boot_mem_end = max_pfn << PAGE_SHIFT;
> > > >    	unsigned long bz;
> > > > +	int order;
> > > >    	/* If memory block size has been set, then use it */
> > > >    	bz = set_memory_block_size;
> > > > @@ -1451,6 +1452,21 @@ static unsigned long probe_memory_block_size(void)
> > > >    		goto done;
> > > >    	}
> > > > +	/* Consider hotplug advisement value (if set) */
> > > > +	order = memblock_probe_size_order();
> > > 
> > > "size_order" is a very weird name. Just return a size?
> > > 
> > > memory_block_advised_max_size()
> > > 
> > > or sth like that?
> > > 
> > 
> > There isn't technically an overall "max block size", nor any alignment
> > requirements - so order was a nice way of enforcing 2-order alignment
> > while also having the ability to get a -1/-EBUSY/whatever out.
> 
> I see. But we (MM) just call it "order" then, like pageblock_order,
> max_order, compound_order ... but here we use "size everywhere" so I prefer
> to just sticking to that.
> 
> > 
> > I can change it if it's a big sticking point - but that's my reasoning.
> 
> Simply enforce it when setting the size. We call it "memory_block_size"
> everywhere and it's also a power-of-2 etc and sanity-check that in
> memory_dev_init().
> 
>

Disregard my other email.  Didn't see this one come through.

I'll switch to a size and check alignment. Probably i need to play
with the locking mechanism to avoid changing after it's probe the
first time, but i'll poke at it.

So probably i change to an ssize_t for the arg and return value.

~Gregory

