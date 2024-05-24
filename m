Return-Path: <linux-acpi+bounces-5976-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EDB08CE4DF
	for <lists+linux-acpi@lfdr.de>; Fri, 24 May 2024 13:32:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A18591F22144
	for <lists+linux-acpi@lfdr.de>; Fri, 24 May 2024 11:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A2D8565D;
	Fri, 24 May 2024 11:32:02 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5607884FA7;
	Fri, 24 May 2024 11:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716550322; cv=none; b=qqyaQSlOH0/fr3Ovy5kuNVXl57+2Sh080cYEExcAhtAnXi/T8wXEjXoWkKbFVLmqIdXiD1A5IKWtrbgNRZJ1RdlIrFpwbljm620iYHXOeENtR6xhNcDaTdZ8dXDW7BFSlUyJC5gFQT3R3mOZyVlqiL+xGj0c6eD5qvRrrd/lDTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716550322; c=relaxed/simple;
	bh=TOMv4HGNG/iu1oe6JyE5qhb7UCcWecdYavBK8qV99wQ=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R8vyXclYOhR20/JFNWWy/sf3h23yvvb/F7FoTEnIfnnbjUC31OkhQja5CG6bm6kgCfDerp4pbLJykaQWx1qn3qdMnJXnkRCVXRoiF3dxAdxqI+Rnbljkii98gMr9eOXqX7YcqE2IZEjAM2fWv6JB1Pg0xGlqwuV6qOHrSt54bOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Vm2pg5rFXz6JBX1;
	Fri, 24 May 2024 19:28:11 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 9A811140B2F;
	Fri, 24 May 2024 19:31:56 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 24 May
 2024 12:31:56 +0100
Date: Fri, 24 May 2024 12:31:55 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<mahesh.natu@intel.com>, <rafael@kernel.org>
Subject: Re: [ACPI Code First ECN] Enumerate "Inclusive Linear Address Mode"
 memory-side caches
Message-ID: <20240524123155.00005b0a@Huawei.com>
In-Reply-To: <664f707125537_18c429438@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <663ea70884cfd_db82d29414@dwillia2-xfh.jf.intel.com.notmuch>
	<20240517174550.0000242a@Huawei.com>
	<6647bbf6c88e3_2c2629451@dwillia2-xfh.jf.intel.com.notmuch>
	<20240520125333.00007a47@Huawei.com>
	<664cc3a76e7d_2c2629462@dwillia2-xfh.jf.intel.com.notmuch>
	<20240523124947.000034df@Huawei.com>
	<664f707125537_18c429438@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Thu, 23 May 2024 09:36:01 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> Jonathan Cameron wrote:
> > >   
> > > > > > Whilst the CXL side of things (and I assume your hardware migration engine)
> > > > > > don't provide a way to recover this, it would be possible to build
> > > > > > a system that otherwise looked like you describe that did provide access
> > > > > > to the tag bits and so wouldn't present the aliasing problem.      
> > > > > 
> > > > > Aliasing problem? All direct-mapped caches have aliases, it just happens that
> > > > > this address mode allows direct-addressability of at least one alias.    
> > > > 
> > > > As I understand this the problem is you get address A in the error record,
> > > > but that actually means any of A, A + N, A + 2N etc and the issue is you
> > > > have no way of recovering which alias you have. 
> > > > 
> > > > Another implementation might have the same aliasing in the cache, but allow
> > > > for establishing which one you have (the hardware inherently has to know that
> > > > but I presume in this case doesn't provide a way to look it up - or if it
> > > > does, then issue here is that the OS querying of the CXL device doesn't know
> > > > about that interface?).  So I think the critical here is that information is
> > > > not available, not that aliasing occurs.    
> > > 
> > > The critical information is that the address range is extended by the cache
> > > capacity compared to the typical case. Maybe "extended-linear" is the term I was
> > > searching for last Friday when I could not think of a better bikeshed color?
> > > 
> > > The reason an "extended-linear" indicator is important is for the driver to
> > > recognize that the CXL address range programmed into the decoders is only a
> > > subset of the system-physical address ranges that may route traffic to CXL. So
> > > when the memory-side-cache is in this "extended" mode there are more addresses
> > > that may route to CXL.  
> > 
> > I think we need to be careful with decoders here because the extra translation in the
> > path means they aren't in HPA space as such.  They are in a new HPA+ space.
> > In your case I think the translation is such that addresses are the bottom of the
> > HPA window, but they could just as easily be the top of the HPA window or not
> > within it at all...  
> 
> No need for an HPA+ concept. This is just an HPA vs SPA distinction,
> similar to what we dealt with here:
> 
> 0cab68720598 cxl/pci: Fix disabling memory if DVSEC CXL Range does not match a CFMWS window

Sure, if we can avoid a reference to 'subset' then I think this is
fine - or avoid relating this to decoders at all.

> 
> Typically HPA and SPA are a 1:1 relationship, but in this case there is
> a memory-side cache that sometimes translates the SRAT SPA to CXL HPA vs
> DDR HPA. For any given SPA in the SRAT range there is no way to know
> whether it is currently dynamically mapped to CXL or DDR.
> 
> > |     HPA window 1 - Length = Cache + CXL                 |
> > |   HPA+ window 1 - Length = CXL only |  
> 
> HPA windows are never impacted by this memory side cache addressing.
> 
> 
> > 
> > or
> > |     HPA window 1 - Length = Cache + CXL                |
> >                    |   HPA+ window 1 - Length = CXL only |
> > 
> > or for giggles
> > 
> > |     HPA window 1 - Length = Cache + CXL                |
> >                                                    |   HPA+ window - Length = CXL only |
> > 
> > last one might seem odd but if you are packing multiple of these you might get
> > |     HPA window 1 - Length = Cache + CXL      |   HPA window 2 Ln = Cache + CXL           |
> > |   HPA+ window 1 - Length = CXL only |  HPA+ window 2  Len = CXL only|
> > 
> > To reduce decoder costs in the fabric (yeah we don't do this today but the
> > bios might :)  
> 
> No, BIOS should have no opporunity to confuse "HPA" layout. Let me see
> if I can cutoff this line of confusion in the next rev and explicitly
> call out SPA vs HPA expectations.
> 
> > So should the text say anything about decoder address vs (SRAT / HMAT addressing)
> > Maybe reasonable to say it's contained and aligned so modulo maths works?
> > This is a bit odd as HMAT wouldn't typically provide this info, but this addressing
> > mode already incorporates it sort of...  
> 
> SRAT portrays capacity, HMAT portrays cache and address organization.
> There is no need for bringing CXL decoder concepts into the HMAT.

Absolutely - avoid any reference to decoders and we are fine.

> 
> [..]
> > > > > I still disagree with the implication that "inclusion" is a property of the
> > > > > cache and not the address layout for this ECN.    
> > > > 
> > > > It's an ECN about caches - the chance of misunderstanding is high.
> > > > Maybe there isn't a better option, but it definitely makes me feel uncomfortable.    
> > > [..]  
> > > > Maybe hyphen will help? Inclusive-linear Address mode?
> > > > to avoid reading this as separate adjectives as in that this is an
> > > > 'inclusive' cache that has a 'linear address' mode?    
> > > 
> > > Try this on for size:
> > > 
> > > * "When Address Mode is 1 'Extended-Linear' it indicates that the associated
> > >    address range (SRAT.MemoryAffinityStructure.Length) is comprised of the
> > >    backing store capacity extended by the cache capacity. It is arranged such
> > >    that there are N directly addressable aliases of a given cacheline where N is
> > >    the ratio of target memory proximity domain size and the memory side cache
> > >    size. Where the N aliased addresses for a given cacheline all share the same
> > >    result for the operation 'address modulo cache size'. This setting is only
> > >    allowed when 'Cache Associativity' is 'Direct Map'."  
> > > 
> > >   
> > I don't promise not to change my mind, but today LGTM.  
> 
> This sounds very similar to the voice that is always in my mind when
> reviewing code, reminds me of one of my favorite Star Wars quotes, "I am
> altering the deal, pray I do not alter it any further."

:)

Jonathan



