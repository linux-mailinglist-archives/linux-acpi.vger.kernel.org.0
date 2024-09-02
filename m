Return-Path: <linux-acpi+bounces-8075-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A3CC968338
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Sep 2024 11:30:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B473BB22E05
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Sep 2024 09:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDBDF1C3301;
	Mon,  2 Sep 2024 09:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1ICVgLgw"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CAC91C32F1
	for <linux-acpi@vger.kernel.org>; Mon,  2 Sep 2024 09:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725269401; cv=none; b=TG2MHO1gDmyz6Q/qiiS8jwOKAMqVtXWtn6geYhwWFXuoVi1EOKrt7Maz3i2lDbZdHTrIBhEBZiVn+hle+YEr6MA8szs6X5mBNE52azUpuue0sNNc8e5sOQf+rArqNqIUMUWBBBb7dKbaTKSt6U0K6cU4q50sSqeLbeUTRQSYqCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725269401; c=relaxed/simple;
	bh=B1qmeunmzRW7j1S/b5dM9pv6wNVyxv2E53BOHoVet/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aJ1K84BZK8ARSVoLqxFCk3PqgVIWlrLTrhtwU9iqzvvGWChb2HmDbWxi+sX2KusmHSJiH2WAZZuayBRT3toPVzjtpiTeXcoCLmgLPRCrNgwEasY0U0GCq60zM6MG250YhsD7Uif4RP55fBmiEXZGDo9vGlPFZ+K6HYB2+oKKxbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1ICVgLgw; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5c247dd0899so9292a12.1
        for <linux-acpi@vger.kernel.org>; Mon, 02 Sep 2024 02:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725269398; x=1725874198; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VJE54eIljBo+04QQocBk6CxFcwFwa7n+6hpWhqzR/Xc=;
        b=1ICVgLgwB79+g8ZU8p4vyVpp7IPlZr5BO0Tcy5t2HbaAUpCww2UoAVgFlT0UFeACoB
         /CeRMc+6vYVA3p6hSkFn+R0aSQMzxnUzzSqzJAi2sCB/OjyTGiuZqVbH1nqIifwVqafK
         T891u1WKUA4xWX5sxk3Vglc8AObZHVbUBi5kLgyF3Wd2AEOj7BHo961GyJbi1vR3XH40
         ekA45rUqDR/YDmlSXbDLht5mJVhuXodOWWT1ovqqyvjJe+ix/D00x9k2dyWe9qW7W95/
         cEpLYhsuhdkDeWg2tpGRw5PyQubTbrX5NO6QE/j1oMTjEuIT5dkemOjojDBKDy1OILMt
         C++g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725269398; x=1725874198;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VJE54eIljBo+04QQocBk6CxFcwFwa7n+6hpWhqzR/Xc=;
        b=LxwyZyXWUM4Grlo8Rp3g6eclLX3oAbRDJlWJfFVYtWK7T6jLYX29Y4auDcwnFW0xl4
         XY6ffnNWWBAbh9FD6K6INly9CpRTG2tsGTuoopeChd+wK8HRK8RiRTu+/H8YOO7Ea4q0
         tS8eHHB3BFLH9fcXO8vZY/KJGYWz7pRjzpaaUjx0WRcIUQjdXTFnA7TJkOWsgcXDDfwX
         gqij5vg/dUCvcHpMzywd0OlAAKQMZ+Seb/Oer6iPcKJlYUX7B+gPV8ujfrh3LkOe0ppM
         8c8oKdHYDxhfEMav0gKCUT3nHAPkexV1efqIMDjJlnLwJv80ILQuhZeWPOdJ1C9nW/5m
         lfMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUo6DjY7nKjUH8UM1oa/cYaqbCeJUtdKdWWf0+hJkVCW701ZHSgVGOwXxyJDSJ+ZqDvGC5S4iT7nQQd@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6q6ROHvu1eoXVdoIXZWd1P55rzYEojajs7YuHS8nJypHKzjcj
	JEm4ND1Uo8+rMOk252dOgGQ5Q3iwQGtmv9G7ThpHUfRPYJmIC897pfA3jEyGaw==
X-Google-Smtp-Source: AGHT+IHjBDWncMa0JFzAVRBZvunVV3/xf27Bk1UBfEqTh/oBWIS4ZrnlqS4ID0HplL23Cxhn09935A==
X-Received: by 2002:a05:6402:51c8:b0:5c2:62c8:30a with SMTP id 4fb4d7f45d1cf-5c262c80401mr55276a12.1.1725269398075;
        Mon, 02 Sep 2024 02:29:58 -0700 (PDT)
Received: from google.com (109.36.187.35.bc.googleusercontent.com. [35.187.36.109])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8989021960sm532554566b.79.2024.09.02.02.29.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 02:29:57 -0700 (PDT)
Date: Mon, 2 Sep 2024 09:29:53 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: acpica-devel@lists.linux.dev, Hanjun Guo <guohanjun@huawei.com>,
	iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org,
	Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Robert Moore <robert.moore@intel.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>, Will Deacon <will@kernel.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	Eric Auger <eric.auger@redhat.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Moritz Fischer <mdf@kernel.org>,
	Michael Shavit <mshavit@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>, patches@lists.linux.dev,
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH v2 2/8] iommu/arm-smmu-v3: Use S2FWB when available
Message-ID: <ZtWFkR0eSRM4ogJL@google.com>
References: <0-v2-621370057090+91fec-smmuv3_nesting_jgg@nvidia.com>
 <2-v2-621370057090+91fec-smmuv3_nesting_jgg@nvidia.com>
 <ZtHhdj6RAKACBCUG@google.com>
 <20240830164019.GU3773488@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240830164019.GU3773488@nvidia.com>

On Fri, Aug 30, 2024 at 01:40:19PM -0300, Jason Gunthorpe wrote:
> On Fri, Aug 30, 2024 at 03:12:54PM +0000, Mostafa Saleh wrote:
> > > +	/*
> > > +	 * If for some reason the HW does not support DMA coherency then using
> > > +	 * S2FWB won't work. This will also disable nesting support.
> > > +	 */
> > > +	if (FIELD_GET(IDR3_FWB, reg) &&
> > > +	    (smmu->features & ARM_SMMU_FEAT_COHERENCY))
> > > +		smmu->features |= ARM_SMMU_FEAT_S2FWB;
> > I think that’s for the SMMU coherency which in theory is not related to the
> > master which FWB overrides, so this check is not correct.
> 
> Yes, I agree, in theory.
> 
> However the driver today already links them together:
> 
> 	case IOMMU_CAP_CACHE_COHERENCY:
> 		/* Assume that a coherent TCU implies coherent TBUs */
> 		return master->smmu->features & ARM_SMMU_FEAT_COHERENCY;
> 
> So this hunk was a continuation of that design.
> 
> > What I meant in the previous thread that we should set FWB only for coherent
> > masters as (in attach s2):
> > 	if (smmu->features & ARM_SMMU_FEAT_S2FWB && dev_is_dma_coherent(master->dev)
> > 		// set S2FWB in STE
> 
> I think as I explained in that thread, it is not really correct
> either. There is no reason to block using S2FWB for non-coherent
> masters that are not used with VFIO. The page table will still place
> the correct memattr according to the IOMMU_CACHE flag, S2FWB just
> slightly changes the encoding.

It’s not just the encoding that changes, as
- Without FWB, stage-2 combine attributes
- While with FWB, it overrides them.

So a cacheable mapping in stage-2 can lead to a non-cacheable
(or with different cachableitiy attributes) transaction based on the
input. I am not sure though if there is such case in the kernel.

Also, that logic doesn't only apply to VFIO, but also for stage-2
only SMMUs that use stage-2 for kernel DMA.

> 
> For VFIO, non-coherent masters need to be blocked from VFIO entirely
> and should never get even be allowed to get here.
> 
> If anything should be changed then it would be the above
> IOMMU_CAP_CACHE_COHERENCY test, and I don't know if
> dev_is_dma_coherent() would be correct there, or if it should do some
> ACPI inspection or what.

I agree, I believe that this assumption is not accurate, I am not sure
what is the right approach here, but in concept I think we shouldn’t
enable FWB for non-coherent devices (using dev_is_dma_coherent() or
other check)

Thanks,
Mostafa
> 
> So let's drop the above hunk, it already happens implicitly because
> VFIO checks it via IOMMU_CAP_CACHE_COHERENCY and it makes more sense
> to put the assumption in one place.
> 
> Thanks,
> Jason

