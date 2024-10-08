Return-Path: <linux-acpi+bounces-8616-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D251499534D
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Oct 2024 17:22:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F40601C25758
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Oct 2024 15:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB251DFE2D;
	Tue,  8 Oct 2024 15:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="ZtI11w+j"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76F81E0495
	for <linux-acpi@vger.kernel.org>; Tue,  8 Oct 2024 15:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728400928; cv=none; b=R72J4DITr5A7Zr1ZGl0SjRU2RvtdoGYSLoWKTlEZ4iSqkm14Y458xwTMJDb5ee3AnnRSKWmTaRm0t0u/bNZCBaLIO27vYLt114z0ty/fRMxcnXCRkzxzkC90i6iiTLE+6pyZ/sxKekyPylQkuBDiGIm7NuFbTPbwoMPAfWtJ2Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728400928; c=relaxed/simple;
	bh=3hNLYOGxFEk/QG9fzsv0VGS8Q4v9VUxQyk8dxvdDmAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VuDpbMmjX8/fsTwG1Bgl3nr1r9EbwEo6kcEBkwS8ZXqxKWuUqqcsy8ICwM/8Xps/LzK7nnXBwEjigZNJHEqmcBLoHEaxpqQKHeYaWApOypZJWwjnlOTLguDUTU4Di0XG+/uhIa/rT6Cx9JGIX6MAc4FyEp/K/iuktoyErbRNN0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=ZtI11w+j; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7a9ab721058so572198985a.1
        for <linux-acpi@vger.kernel.org>; Tue, 08 Oct 2024 08:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1728400926; x=1729005726; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XZ67u8RxgzRAwx2Ool9AQUwW74l6Qtl1I/8HA1yVK7o=;
        b=ZtI11w+jtp1wDLPTjJriENfyaUN27ukJSDZhn15aAnQRJx/DBCvy/KPwEeie3UiXdV
         wPphXu0ZVmC2AGClKeFDgb0RPNtlFloUN+LhSVwM72Jgr87IyXFG4QobA3qqD16pTwyF
         baVW1m/sZffmaLNEIKIJDXdaDFsDObIouFDmYz/04Z/JRmPKHj7Xe3Gt+AyKZdUf+vSV
         7O++oZciC3rCCR3Wgjkxza8/pB62u5gB0iGg9AuB1YoY/cLCkgoBM70rZf+Rk4prJCgA
         pPnC+7BJNt3WE7RV03SNgESnOB+UbEJ+vfdM7KpRdTzZUOtUhiIRFLEeXYhzFOxABHyM
         gxHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728400926; x=1729005726;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XZ67u8RxgzRAwx2Ool9AQUwW74l6Qtl1I/8HA1yVK7o=;
        b=mglh0FJfdXF5BEQUV+aXkBxfa6uD5tQIC715zkAiZRu/PDqKNYZxQYGSAe0TlEn0Gl
         AmX+/ixLX3Jw5nhKjMkHRjSgs8pit3cTV72H2u3OK9BxOKBiMMJk1eHAks6p/iPMUpzz
         QvbZou9wV3OIxGgkVOqbNP4anTsq0DeGTOycSi6jOCECOku20UBnw56+8DEhmSHZmENA
         6xedVoXdMIWspSRUheabJAXyCSLXjjfgt1BWZyHmVLL5Wv2EKPFSQ1JJgOT8S2489lxL
         dD2lh8GtSVU/Of4gjopaLgic7+6RamivJ2wk9EqhkpLNwyXCn+kNUdROE3mCbt9d425j
         Z/sg==
X-Forwarded-Encrypted: i=1; AJvYcCUovU/Tc/G+7v1m+v6ank2qUNcsXBzKkP6+wjgrI/9bvBvs/Q4+3QXB40ZgXe25/w+FcWhP4KIQkssg@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0Py0us1aL4XHYvyzCw9XgERKqQs8f73h+ei2p/Ikv+l07+orR
	+tNIYb9IhGiJdH8EX8LNfcrztmUFyUdN3b2SSCqFve/E/TGjXXngjOxEgnRBHak=
X-Google-Smtp-Source: AGHT+IGMO0Tvvi9+VmcOsgILzXspWMlWZQ5WxVaJLr0S8i8w6Q2UsaoDkhwE/bfLc/fA5kw9BP3AeA==
X-Received: by 2002:a05:620a:1791:b0:7a9:95f6:e372 with SMTP id af79cd13be357-7afcf03a0e9mr69595385a.2.1728400925668;
        Tue, 08 Oct 2024 08:22:05 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ae7562caf3sm361427285a.36.2024.10.08.08.22.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 08:22:05 -0700 (PDT)
Date: Tue, 8 Oct 2024 11:21:55 -0400
From: Gregory Price <gourry@gourry.net>
To: David Hildenbrand <david@redhat.com>
Cc: linux-cxl@vger.kernel.org, x86@kernel.org, linux-mm@kvack.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
	osalvador@suse.de, gregkh@linuxfoundation.org, rafael@kernel.org,
	akpm@linux-foundation.org, dan.j.williams@intel.com,
	Jonathan.Cameron@huawei.com, alison.schofield@intel.com,
	rrichter@amd.com, terry.bowman@amd.com, lenb@kernel.org,
	dave.jiang@intel.com, ira.weiny@intel.com
Subject: Re: [PATCH 1/3] memory: extern memory_block_size_bytes and
 set_memory_block_size_order
Message-ID: <ZwVOE6JRS8Fd9_a8@PC2K9PVX.TheFacebook.com>
References: <20241008044355.4325-1-gourry@gourry.net>
 <20241008044355.4325-2-gourry@gourry.net>
 <039e8c87-c5da-4469-b10e-e57dd5662cff@redhat.com>
 <ZwVG8Z3GRYLoL_Jk@PC2K9PVX.TheFacebook.com>
 <d3203f2c-eff6-4e84-80cd-3c6f58dab292@redhat.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d3203f2c-eff6-4e84-80cd-3c6f58dab292@redhat.com>

On Tue, Oct 08, 2024 at 05:02:33PM +0200, David Hildenbrand wrote:
> On 08.10.24 16:51, Gregory Price wrote:
> > > > +int __weak set_memory_block_size_order(unsigned int order)
> > > > +{
> > > > +	return -ENODEV;
> > > > +}
> > > > +EXPORT_SYMBOL_GPL(set_memory_block_size_order);
> > > 
> > > I can understand what you are trying to achieve, but letting arbitrary
> > > modules mess with this sounds like a bad idea.
> > > 
> > 
> > I suppose the alternative is trying to scan the CEDT from inside each
> > machine, rather than the ACPI driver?  Seems less maintainable.
> > 
> > I don't entirely disagree with your comment.  I hummed and hawwed over
> > externing this - hence the warning in the x86 machine.
> > 
> > Open to better answers.
> 
> Maybe an interface to add more restrictions on the maximum size might be
> better (instead of setting the size/order, you would impose another upper
> limit).

That is effectively what set_memory_block_size_order is, though.  Once
blocks are exposed to the allocators, its no longer safe to change the
size (in part because it was built assuming it wouldn't change, but I
imagine there are other dragons waiting in the shadows to bite me).

So this would basically amount to a lock-bit being set in the architecture,
beyond which block size can no longer be changed and a big ol' splat
can be generated that says "NO TOUCH".

> Just imagine having various users of such an interface ..

I don't wanna D:

> 
> -- 
> Cheers,
> 
> David / dhildenb
> 

