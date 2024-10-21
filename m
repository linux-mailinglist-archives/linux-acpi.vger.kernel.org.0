Return-Path: <linux-acpi+bounces-8879-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC35C9A6CD7
	for <lists+linux-acpi@lfdr.de>; Mon, 21 Oct 2024 16:51:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 783DC280DA4
	for <lists+linux-acpi@lfdr.de>; Mon, 21 Oct 2024 14:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFF881D3195;
	Mon, 21 Oct 2024 14:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="KzJIYkmU"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44621EABD0
	for <linux-acpi@vger.kernel.org>; Mon, 21 Oct 2024 14:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729522290; cv=none; b=mEnIsMxqjX7OzVWxzYNhGE+zklnhS2TtTFC3u9JBjcmjgDPL0KvPRS1kZPRv8FuY0pZdvdtPgs1LrplAwyQnHvFxH7ah9BKEx9wwlqNuEwW9zYahodKhN1unKa3twpMJffqreGynfCLQtt/dN+ZAp6m5+XtrsdUBc1Ys6a6bcn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729522290; c=relaxed/simple;
	bh=QVHFdisx4eEjt0lCgGFJr6A8Y0gozB27bbYjgPgKtH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mxMYpNZrZPfjYjGQcV5qeyhOBRxuuPjANUPvYm6tWPLhoJ8TRCL5pGegAYzBwFnq6EtUVIjG0DkffKSxWu9IsFWMd7rbWOpS58kkUBn5R1HPWUh/Gl6gfRdLUV3jg5JFuWc2zTAxE2E5+Oas6CWMuQav2ER5NPGvUL+xOJDAEzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=KzJIYkmU; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7181885ac34so1709286a34.3
        for <linux-acpi@vger.kernel.org>; Mon, 21 Oct 2024 07:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1729522288; x=1730127088; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0LCFqGRL1GXXjFNSMHo10rPFkuAROAlT9eOq0w6KPjw=;
        b=KzJIYkmUXxuNGvQRPnh4cruC7wjdBdhg1WM3XaRyMZQ6rE7hq42wVwI3oFgq3imYIL
         Cw5Lz4g2guOURw5q9W8EWChAQR7JQhHxWpH6vWeWGivTHfbNuniMebhoaev9457Julrg
         cnoY1G/akWIPuBqU0+zoFAYjEVSS+9UiB/jVnM6QTJrj5Pw1OEMM0jePqyuPa7mF1CBh
         PIbgrzCbhZKyG0ncXZS8Ec+6xBPagGRaBpwojL05sxyjHKcfMFBwTIQNZT2kMsVqUCsS
         afwew6LeHmxqId5pTXJhXmc7Sh8Iwn6T2vAbW1aqqlLGMMyiEoXh1XbeXHhGv9KcbWv1
         cxNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729522288; x=1730127088;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0LCFqGRL1GXXjFNSMHo10rPFkuAROAlT9eOq0w6KPjw=;
        b=OPz2i74gQg2S5qa/9rJQNhZ/FqQA9lHMKZQ5AGAs/o1ddYzsLO3nBmAVqujaZLI+Xx
         OWo58PgqdrY59+Skdt+ed8tuJXP6DDCC2OmhJWVi2TYt4xv9sSfaSCu3mKticIID6uJx
         UNiBMCfQ4pS52zl/YCCs0zuFuS7ubNwa2jxucTBGq0ozK/7yVjL2sJwR/0VNI8+s8ukp
         jF9vzZb6D2kqH1wXpj776vLWp60svrTSwRIXVujD0T8WEo+bqH+KRUnqalAX6Ax7Bk6T
         RifPykq9bECxSZGeh/ueyHWvyzYKUGA3MrEnNIZ10gbxc4DGs6lBdCvvoaY1OfP3TTz0
         L/Lw==
X-Forwarded-Encrypted: i=1; AJvYcCVsk+Wq6QrmVueRBRjP5NoodYcKktUtKwb+ocvj2ubXG+ETY/EhLzNaPBk3fWy7FHWo68iUYM8trYQm@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2E+SqRv0DOseGwQJtPNEXSLjpvAzD4a5ViUZ0xx5RCWhkHp3O
	OvUUN62oWovLBMwX5l30GVrBKK3DfTvAQQCII8hFdBV7q1Or3IOX6Yc/RlbZ24M=
X-Google-Smtp-Source: AGHT+IHcAvHvPa2U3uHHthKi6B0l3wXkXlDgXZwArI+r4vHFC+TJ7ZOjq7ukqAmwUA5y82uIugQ6AQ==
X-Received: by 2002:a05:6830:2703:b0:718:cc7:c6df with SMTP id 46e09a7af769-7181a89ee87mr6856700a34.22.1729522287780;
        Mon, 21 Oct 2024 07:51:27 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ce0091bc72sm17782326d6.73.2024.10.21.07.51.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 07:51:27 -0700 (PDT)
Date: Mon, 21 Oct 2024 10:51:28 -0400
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
Subject: Re: [PATCH v2 0/3] mm/memblock,x86,acpi: hotplug memory alignment
 advisement
Message-ID: <ZxZqcPTPqJkg-ZIH@PC2K9PVX.TheFacebook.com>
References: <20241016192445.3118-1-gourry@gourry.net>
 <c811debe-32db-4c77-a799-ee89427a5174@redhat.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c811debe-32db-4c77-a799-ee89427a5174@redhat.com>

On Mon, Oct 21, 2024 at 11:51:38AM +0200, David Hildenbrand wrote:
> 
> 
> Am 16.10.24 um 21:24 schrieb Gregory Price:
> > When physical address regions are not aligned to memory block size,
> > the misaligned portion is lost (stranded capacity).
> > 
> > Block size (min/max/selected) is architecture defined. Most architectures
> > tend to use the minimum block size or some simplistic heurist. On x86,
> > memory block size increases up to 2GB, and is otherwise fitted to the
> > alignment of non-hotplug (special purpose memory).
> > 
> > CXL exposes its memory for management through the ACPI CEDT (CXL Early
> > Detection Table) in a field called the CXL Fixed Memory Window.  Per
> > the CXL specification, this memory must be aligned to at least 256MB.
> > 
> > When a CFMW aligns on a size less than the block size, this causes a
> > loss of up to 2GB per CFMW on x86.  It is not uncommon for CFMW to be
> > allocated per-device - though this behavior is BIOS defined.
> > 
> > This patch set provides 3 things:
> >   1) implement advise/probe functions in mm/memblock.c to report/probe
> >      architecture agnostic hotplug memory alignment advice.
> >   2) update x86 memblock size logic to consider the hotplug advice
> >   3) add code in acpi/numa/srat.c to report CFMW alignment advice
> > 
> > The advisement interfaces are design to be called during arch_init
> > code prior to allocator and smp_init.  start_kernel will call these
> > through setup_arch() (via acpi and mm/init_64.c on x86), which occurs
> > prior to mm_core_init and smp_init - so no need for atomics.
> > 
> > There's an attempt to signal callers to advise() that probe has already
> > occurred, but this is predicated on the notion that probe() actually
> > occurs (which presently only happens on x86). This is to assist debugging
> > future users who may mistakenly call this after allocator or smp init.
> > 
> > Likewise, if probe() occurs more than once, we return -EBUSY to prevent
> > inconsistent values from being reported - i.e. this interaction should
> > happen exactly once, and all other behavior is an error / the probed
> > value should be acquired via memory_block_size_bytes() instead.
> > 
> > Suggested-by: Ira Weiny <ira.weiny@intel.com>
> > Suggested-by: David Hildenbrand <david@redhat.com>
> > Suggested-by: Dan Williams <dan.j.williams@intel.com>
> > Signed-off-by: Gregory Price <gourry@gourry.net>
> 
> Just as a side note, a while ago there was a discussion about variable-sized
> memory blocks -- essentially removing memory_block_size_bytes().
>

If you have any links, happy to do some reading up on it.  Was going to look
into some more memblock behavior in the future so it's worth looking at.

> 
> The main issue is that this would change /sys/devices/system/memory/ in ways
> it could break existing user space. I believe there are other corner cases
> that are a bit nasty to handle (e.g., removing parts of a larger memory
> block), but likely it could be handled.
> 

This is why I wanted to avoid a new interface in the first place and just
piggyback on set_memory_block_size_order - now there are two interfaces to
do the same thing and more hurdles.  But I suppose the suggestive-nature of
this one makes it far less offensive since it can be completely ignored.

~Gregory

