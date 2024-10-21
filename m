Return-Path: <linux-acpi+bounces-8881-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2F849A6F03
	for <lists+linux-acpi@lfdr.de>; Mon, 21 Oct 2024 18:04:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DEB828465C
	for <lists+linux-acpi@lfdr.de>; Mon, 21 Oct 2024 16:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A51C61E5705;
	Mon, 21 Oct 2024 16:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="OCjT4gO+"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5611DF754
	for <linux-acpi@vger.kernel.org>; Mon, 21 Oct 2024 16:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729526665; cv=none; b=qfq2W6wKQAQ8so/B1rmyzDqdSzshzfIoFf0Yp/dG64i3xxHAqroZMPZwgtrO2TepFZ+GnI22NWVRTjnxi5eCzFB8/1xMorPYZXuPxljjBfmVN3GOVC230ccE079O9IS7x/P6T6r2HotG+ADW5uKTHdFY/51pEJvL0fzn36lGA5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729526665; c=relaxed/simple;
	bh=fgBxXU6/mvfxSEzp9Z5Mz10C8iq6DE4jqzKSltRUPVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ncf9VWcv8lTTTkElQQxH1utsUh5ahidEi3wcsyrWeOKLB4LKc8gZysHid/y1H5XTKmJe9qSLby8Qm/VMZfNglIZbeyOvFJUKmaGvpbVrprAb0JxcI/uvvaOIFFdixtbNYZuOgmcK4SkhaGMjIezY1Vp8nAeq51EieKD8ySwmMko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=OCjT4gO+; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-460ace055d8so26869501cf.1
        for <linux-acpi@vger.kernel.org>; Mon, 21 Oct 2024 09:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1729526663; x=1730131463; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=l84e0UnSnb5/wXRcsEl1eXO6u1LE4VmYmgz6RFMIs3w=;
        b=OCjT4gO+WfiDnOM3STiAoLa60z9lfEK9rQuCCSM4G+KTOg/XBQghr8x1UcELjQY+p+
         eF15xtpLLHKALJsNR1rOhZzdwZC03Rs9RObEEI9yGnaVjbGyCwS+xTo9uj90biPeCSf2
         OxUzV2LTTRKG0xR8SYJL+CzrmAc+opbkvN5zHNs6RhDzwf0Oo3VbP5js6oF4ubd6VFcF
         MEvh77msnmZiu3muh3OgqDOTD3QzPElbQjLQJvIt08TaQYx1tLUob359JeHLj4mTSStQ
         cPQsbEJu9jprMRvUYdv/OpHo1Aqr48Ab4RSVNb+98+MLAFZ9rqdJtYg3mQHvMkZqzA8/
         GaTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729526663; x=1730131463;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l84e0UnSnb5/wXRcsEl1eXO6u1LE4VmYmgz6RFMIs3w=;
        b=rmStn5AmPrrj4TJIrTC4cNbPlZz6oAaH61yMl2FlCVRgUmWvlLO9mF1PJY75YrrFmA
         K9RxQxfst5FdwlP1AvuZKjlB5zeF0gAPjFMpXFrZ+oM9EJRbTzP5wmQGvvANg9ToNGZ1
         woObmWky3sR4ujg3+m1q/qf8uAC8N1NLsUqkvKeBYAoqyXiTs5DmcFeuxiQGK5K26wv8
         MD7syQoMpDX9ukBP4yOgs2Ch+JaXjLZxPqhyqyjTtjSPN5p8qdYvh6SKQS5Cl3ZCozPc
         TZjU6TYPhlYKMHgkMNZTNnuPm6KqrgHkU1bWKpG7GzuzNj5nWzLTC46GkdqNSvFil2j0
         s7ig==
X-Forwarded-Encrypted: i=1; AJvYcCXlSCUVz6K2ui+GiAqDnfQQyCDjaNfAFTK/1v+u/db5rim7513S1SQlYNHjTVU+5AhrSZUCYeuses70@vger.kernel.org
X-Gm-Message-State: AOJu0Yyn6WUkmB34v55XqiWhm1UG+dlN9/BWkorgEC5swbS2HN/EWVpo
	0C6KOd/j6Ur34N2e7vgCnepwpS+BZULLiKf/TD50YQf9RncGVt0gxe6fPSjSwUo=
X-Google-Smtp-Source: AGHT+IF6+iVm5LbiJbyoiX1o00pqae4N2gKWe1rpx48Z3dEJTuR25irME1treebcR3ivdgDlUf6STg==
X-Received: by 2002:a05:622a:47ca:b0:458:4e4c:b692 with SMTP id d75a77b69052e-460aed8cb72mr174768891cf.36.1729526662589;
        Mon, 21 Oct 2024 09:04:22 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-460d3d71664sm19231821cf.71.2024.10.21.09.04.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 09:04:21 -0700 (PDT)
Date: Mon, 21 Oct 2024 12:04:23 -0400
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
Message-ID: <ZxZ7h335O9hgB20l@PC2K9PVX.TheFacebook.com>
References: <20241016192445.3118-1-gourry@gourry.net>
 <20241016192445.3118-3-gourry@gourry.net>
 <7b877356-f5c5-4996-904b-6c3b71389255@redhat.com>
 <ZxZpTlnhYPqg-tGh@PC2K9PVX.TheFacebook.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxZpTlnhYPqg-tGh@PC2K9PVX.TheFacebook.com>

On Mon, Oct 21, 2024 at 10:46:38AM -0400, Gregory Price wrote:
> On Mon, Oct 21, 2024 at 01:12:26PM +0200, David Hildenbrand wrote:
> > 
> > > +	/* Consider hotplug advisement value (if set) */
> > > +	order = memblock_probe_size_order();
> > 
> > "size_order" is a very weird name. Just return a size?
> > 
> > memory_block_advised_max_size()
> > 
> > or sth like that?
> > 
> 
> There isn't technically an overall "max block size", nor any alignment
> requirements - so order was a nice way of enforcing 2-order alignment
> while also having the ability to get a -1/-EBUSY/whatever out.
> 
> I can change it if it's a big sticking point - but that's my reasoning.
> 

maybe change to

memory_block_advise_max_size
memory_block_probe_max_size

but still take in / return an order?

~Gregory

