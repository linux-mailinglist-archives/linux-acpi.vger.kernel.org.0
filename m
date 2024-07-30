Return-Path: <linux-acpi+bounces-7123-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 678B69413C0
	for <lists+linux-acpi@lfdr.de>; Tue, 30 Jul 2024 15:58:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DBB6283DD3
	for <lists+linux-acpi@lfdr.de>; Tue, 30 Jul 2024 13:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EA881A08AF;
	Tue, 30 Jul 2024 13:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="U6/GSkaM"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8324E1A08A2
	for <linux-acpi@vger.kernel.org>; Tue, 30 Jul 2024 13:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722347921; cv=none; b=NAfEfCFoN9u2uk/+wbsKHmKNxEpQGMRpcSRfFJSoL/CCs/M9k+fQKxJdJcgjctogTpe+NfF0LW4axkouJB2mzKUkJfhom46AHxeO/5zVKQohyR5TKLiGa968tSGYRCZww2tUIFGQDAaK3HFthepm9KjsLGJuoab6kPHdkTdUw+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722347921; c=relaxed/simple;
	bh=qMDI8Txx2njAcU5Reye0dNUUUWTOOVW/fJ23UzgpSTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KHMTXm0cCwcf4lLYaxuMUnVKmYfYxgShC//tq7KJ+4LglUiSdW149TlkvuBr8XO04I8E8pbu/Pub1LqEYtmwSkhyz0jc7i+1rW0p3HNTnQ8+VTrNaJIbEVy5foCpriMFk0qH0FT3QJW42j7k32F2IA3WWJyqc61Yeo5iKniiwNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=U6/GSkaM; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5d608060241so329255eaf.1
        for <linux-acpi@vger.kernel.org>; Tue, 30 Jul 2024 06:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1722347918; x=1722952718; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ATUTooqDMnWGW5E1fYr0Sr3nb1EzdDxUUFedVVh1pgc=;
        b=U6/GSkaMCEB27M8VYG2xUPbq33iqFrQwj1EcWK1evY4Rh99MvrImPQqH4sxo/no35M
         ZnZBOQzYeEe0xETz4P40zTjkzTHnWRwjkQTOht4MRg7ZLwrXrPXeghmPy7Gcxwvgiv7P
         nDd68dcK1RqJGZ6qr4Q80/bHkFyVXm2NZau45I1xaOge8EhF2a+/JlW2BMUotRH0RRia
         tgqO0+e9DKflk5sQbDHnGqj5d3VIH6wUgOns6xzn4yPGg+w5CHwbH5STjeZ3dKLpDhqn
         edajALYzOH+XgyrtSdcYIWGs8VnTEZq7pMvHZMrFc86flyyCb937RynVeO+5QcmcY3Wo
         3I2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722347918; x=1722952718;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ATUTooqDMnWGW5E1fYr0Sr3nb1EzdDxUUFedVVh1pgc=;
        b=L0FfzGcW5/Wk6p1m1sFWhraBf2+4LvEb8uDPTG8zfXaKgFhWuX+2mB9baxzJwNvfZt
         JYIN3+oZhrfmlC1InsK3XppZ7Rpal6fpaGfsapWI0am49djP3D4Edbk2UJTDP4nS50gY
         GAqRQUwvcbqei3msvj+YSnqhx+81sRDn3dpjWZtTDeGEF0FdLSx/9GiGTfXZpAQ+dWXO
         7eSpPYNNLNNTi94siybnKOruFBGTbrpzqKtyfLnwKC+Lrd7sLRi5q7yhwhAH8+cLJEFr
         6WWcSasS1LidBSLdzdRzq6XqmM6s0q0EJR9NmqP4prCXh89xkLEo+9XRFTBYIhPEohiU
         Ulrg==
X-Forwarded-Encrypted: i=1; AJvYcCWx9AmMmf/QHdax6jqdIXhxgsIfkddxIBve8PQCkfGT4SUqxXz5SlmXo2+nPtkR3lOc7O0iVSnD3CQeEay/6nr9DxyY1G4LVMOWaA==
X-Gm-Message-State: AOJu0YwOSAX0L2pLdJFtsZTttqYjtBSFpF2e4dhg95ldgzHraBXFCiA6
	cPCYA1Dq9M+cSS8vk+4CUcxaOCt8ij198IUwjRL7/wWIR03EiuHUT6uf7qmJKQuT/PddaDvVigy
	hZxU=
X-Google-Smtp-Source: AGHT+IEB0R02KAtBKOdEuupPo31Ehi9o3/bH6CEDRLJQE5M2iZ8R1f9GZvJTLTFz9X93WcC0w11tfg==
X-Received: by 2002:a05:6358:761c:b0:1aa:b8ba:6d with SMTP id e5c5f4694b2df-1adc06d8458mr1901148955d.23.1722347918310;
        Tue, 30 Jul 2024 06:58:38 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb3f9407c3sm63534996d6.71.2024.07.30.06.58.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 06:58:38 -0700 (PDT)
Date: Mon, 29 Jul 2024 23:18:16 -0400
From: Gregory Price <gourry@gourry.net>
To: "Huang, Ying" <ying.huang@intel.com>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, dave.jiang@intel.com,
	Jonathan.Cameron@huawei.com, horenchuang@bytedance.com,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	dan.j.williams@intel.com, lenb@kernel.org,
	"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: Re: [PATCH] acpi/hmat,mm/memtier: always register hmat adist
 calculation callback
Message-ID: <ZqhbePA9Egcxyx7o@PC2K9PVX.TheFacebook.com>
References: <20240726215548.10653-1-gourry@gourry.net>
 <87ttg91046.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <ZqelvPwM2MIG26wY@PC2K9PVX.TheFacebook.com>
 <877cd3u1go.fsf@yhuang6-desk2.ccr.corp.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877cd3u1go.fsf@yhuang6-desk2.ccr.corp.intel.com>

On Tue, Jul 30, 2024 at 09:12:55AM +0800, Huang, Ying wrote:
> Gregory Price <gourry@gourry.net> writes:
> 
> > On Mon, Jul 29, 2024 at 09:02:33AM +0800, Huang, Ying wrote:
> >> Gregory Price <gourry@gourry.net> writes:
> >> 
> >> > In the event that hmat data is not available for the DRAM tier,
> >> > or if it is invalid (bandwidth or latency is 0), we can still register
> >> > a callback to calculate the abstract distance for non-cpu nodes
> >> > and simply assign it a different tier manually.
> >> >
> >> > In the case where DRAM HMAT values are missing or not sane we
> >> > manually assign adist=(MEMTIER_ADISTANCE_DRAM + MEMTIER_CHUNK_SIZE).
> >> >
> >> > If the HMAT data for the non-cpu tier is invalid (e.g. bw = 0), we
> >> > cannot reasonable determine where to place the tier, so it will default
> >> > to MEMTIER_ADISTANCE_DRAM (which is the existing behavior).
> >> 
> >> Why do we need this?  Do you have machines with broken HMAT table?  Can
> >> you ask the vendor to fix the HMAT table?
> >>
> >
> > It's a little unclear from the ACPI specification whether HMAT is
> > technically optional or not (given that the kernel handles missing HMAT
> > gracefully, it certainly seems optional). In one scenario I have seen
> > incorrect data, and in another scenario I have seen the HMAT omitted
> > entirely. In another scenario I have seen the HMAT-SLLBI omitted while
> > the CDAT is present.
> 
> IIUC, HMAT is optional.  Is it possible for you to ask the system vendor
> to fix the broken HMAT table.
> 

In this case we are (BW=0), but in the other cases, there is technically
nothing broken.  That's my concern.

> > In all scenarios the result is the same: all nodes in the same tier.
> 
> I don't think so, in drivers/dax/kmem.c, we will put memory devices
> onlined by kmem.c in another tier by default.
> 

This presumes driver configured devices, which is not always the case.

kmem.c will set MEMTIER_DEFAULT_DAX_ADISTANCE

but if BIOS/EFI has set up the node instead, you get the default of
MEMTIER_ADISTANCE_DRAM if HMAT is not present or otherwise not sane.

Not everyone is going to have the ability to get a platform vendor to
fix a BIOS bug, and I've seen this in production.

> > The HMAT is explicitly described as "A hint" in the ACPI spec.
> >
> > ACPI 5.2.28.1 HMAT Overview
> >
> > "The software is expected to use this information as a hint for
> > optimization, or when the system has heterogeneous memory"
> >
> > If something is "a hint", then it should not be used prescriptively.
> >
> > Right now HMAT appears to be used prescriptively, this despite the fact
> > that there was a clear intent to separate CPU-nodes and non-CPU-nodes in
> > the memory-tier code. So this patch simply realizes this intent when the
> > hints are not very reasonable.
> 
> If HMAT isn't available, it's hard to put memory devices to
> appropriate memory tiers without other information.

Not having a CPU is "other information".  What tier a device belongs to
is really arbitrary, "appropriate" is at best a codified opinion.

> In commit
> 992bf77591cb ("mm/demotion: add support for explicit memory tiers"),
> Aneesh pointed out that it doesn't work for his system to put
> non-CPU-nodes in lower tier.
> 

This seems like a bug / something else incorrect.  I will investigate.

> Even if we want to use other information to put memory devices to memory
> tiers, we can register another adist calculation callback instead of
> reusing hmat callback.
> 

I suppose during init, we could register a default adist callback with
CPU/non-CPU checks if HMAT is not sane. I can look at that.

It might also be worth having some kind of modal mechanism, like:

echo "auto" > /sys/.../memory_tiering/mode     # Auto select mode
echo "hmat" > /sys/.../memory_tiering/mode     # Use HMAT Info
echo "simple" > /sys/.../memory_tiering/mode   # CPU vs non-CPU Node
echo "topology" > /sys/.../memory_tiering/mode # More complex

To abstract away the hardware complexities as best as possible.

But the first step here would be creating two modes.  HMAT-is-sane and
CPU/Non-CPU seems reasonable to me but open to opinions.

~Gregory

