Return-Path: <linux-acpi+bounces-7738-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3529958ED7
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Aug 2024 21:53:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 244E21C20C6B
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Aug 2024 19:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1687B15E5CF;
	Tue, 20 Aug 2024 19:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xMdQRFj0"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02AAC15C13E
	for <linux-acpi@vger.kernel.org>; Tue, 20 Aug 2024 19:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724183584; cv=none; b=XEM4r1l0hQoFrX9Tpc1bwq2Xp4tWmVPYKlV/tDViWXJqg3IRJROf45fH7JIZSMmsA7pqPgnWm4Rik8vz8z2si27QjiX0+itFrTQM+58nARvhC/+0m6baEDWGMjjG8gHeF7T1znTp+Xma+65LzkSBfE4NJKSwuuNQ6/90rxazwiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724183584; c=relaxed/simple;
	bh=f2EDYJYaLCiAoxFHTZr78tEIJO4+g6e/klYwcujCItM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o0CFGQBApAM60Wky2KmPNg5RYNi0en6URaeMKMef6ishYVPQdI0T1wYvUXekNzMX2eLS3u4rLNqqZhESiy3AduEc9mLYQJtLcOMOj/hLK3SmjmTqCgrCDxQbG6Y60FB6x1qUVxRNhv7sQy5BGS62Ic6EijbBqt5GWYnFswMLI1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xMdQRFj0; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-428e12f6e56so15105e9.0
        for <linux-acpi@vger.kernel.org>; Tue, 20 Aug 2024 12:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724183579; x=1724788379; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yp4vfYpCGOdYBS/m6HmbaB98zMN6C60AGpKXCWzp5n0=;
        b=xMdQRFj0JSXdYww327jq0mT27vvEdL6RCGhn/DKhZts6fzDkPJfN9VbewwjyB77vFY
         5lnz3cR9LsZNQ8vIsB+lMOGLWz1FCVS67/N7uYV08iMzbGFKcysMg17kbFbYOuVFDhhu
         9ms+FuLgcOzBVo/OhL9dWbGF44+UY/QvRr9lOnWziZpN7hsnAEXXJTvtLudToR/uaCzS
         sv0jJJA+z61K9v/mKAL71hznJAcLjwxYPb1T60SAIISBuNtP8cMay0P42K3cEWn58+L7
         LOaIMDAxy95WVY1WRt+qTp64kofQwaxe2KUr6bKKWd+BHu/gF9k76EV9+O5c9NF4GY07
         z+jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724183579; x=1724788379;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yp4vfYpCGOdYBS/m6HmbaB98zMN6C60AGpKXCWzp5n0=;
        b=Q+TuzEMS5AfTZQ8/Y1jd6VtBDYqasbeKUe4CA1Pzw2l+2elB2XhGT3O2DU3DSRhtDA
         U+CUHuVGdPqbqH8YoYEJq+Qn02BkSjRUenKNQfF4pb+BwYAqKEKYqZLs2XvI1EZ/5RcN
         wXxGBd9Xs1lHkBRsDotDYOh+DVgyMvtaWllb97tr/vHNSy1bXkVNWhpkCNwDtQJcRaks
         rhmrkhfU/NHI/Mkpozchh5DCNMY4V3MHkVt6ShJWYx87FRs4+mcLUAX+RFqpYyBwrfZu
         ZuUVt6b2KhCRP5e1Ssoft2mgtbCTDRUSTyYDRruK10bLv/5eh5f0E9jTPmP7aRFPDU3l
         ooOw==
X-Forwarded-Encrypted: i=1; AJvYcCX9TTPIUN1SY/N4H3OOST58Vf3W4m0Vt0s/vSWUtqRc02uA+M8AsjJg/EgFvK7lWBE5IE1pMIf0zEqa@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9j5vplpseEIEzVeO7jzbXmSYLKgjCuxk3gpAxKJMyEzYSD9SH
	SGWbNXl0xc0Q5eQYSKicwWWj7OnvXfeJpjInqlsn066ivh/174esbRWoQRk/Qw==
X-Google-Smtp-Source: AGHT+IEIPDf3d+uDL/Y/8Kxr91qxpv+48637k6O2srNTmFhDwf9KvmOeUX+rRg1Oapmp/C3vcKZSsw==
X-Received: by 2002:a05:600c:1f07:b0:424:898b:522b with SMTP id 5b1f17b1804b1-42ab78c1aa8mr1113155e9.1.1724183578856;
        Tue, 20 Aug 2024 12:52:58 -0700 (PDT)
Received: from google.com (203.75.199.104.bc.googleusercontent.com. [104.199.75.203])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-371898b89bdsm13811059f8f.112.2024.08.20.12.52.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 12:52:58 -0700 (PDT)
Date: Tue, 20 Aug 2024 19:52:53 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: acpica-devel@lists.linux.dev,
	Alex Williamson <alex.williamson@redhat.com>,
	Hanjun Guo <guohanjun@huawei.com>, iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>, Kevin Tian <kevin.tian@intel.com>,
	kvm@vger.kernel.org, Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Robert Moore <robert.moore@intel.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>, Will Deacon <will@kernel.org>,
	Eric Auger <eric.auger@redhat.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Moritz Fischer <mdf@kernel.org>,
	Michael Shavit <mshavit@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>, patches@lists.linux.dev,
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH 2/8] iommu/arm-smmu-v3: Use S2FWB when available
Message-ID: <ZsT0Fd5FHS47gm0-@google.com>
References: <0-v1-54e734311a7f+14f72-smmuv3_nesting_jgg@nvidia.com>
 <2-v1-54e734311a7f+14f72-smmuv3_nesting_jgg@nvidia.com>
 <ZsRUDaFLd85O8u4Z@google.com>
 <20240820120102.GB3773488@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240820120102.GB3773488@nvidia.com>

On Tue, Aug 20, 2024 at 09:01:02AM -0300, Jason Gunthorpe wrote:
> On Tue, Aug 20, 2024 at 08:30:05AM +0000, Mostafa Saleh wrote:
> > Hi Jason,
> > 
> > On Tue, Aug 06, 2024 at 08:41:15PM -0300, Jason Gunthorpe wrote:
> > > Force Write Back (FWB) changes how the S2 IOPTE's MemAttr field
> > > works. When S2FWB is supported and enabled the IOPTE will force cachable
> > > access to IOMMU_CACHE memory and deny cachable access otherwise.
> > > 
> > > This is not especially meaningful for simple S2 domains, it apparently
> > > doesn't even force PCI no-snoop access to be coherent.
> > > 
> > > However, when used with a nested S1, FWB has the effect of preventing the
> > > guest from choosing a MemAttr that would cause ordinary DMA to bypass the
> > > cache. Consistent with KVM we wish to deny the guest the ability to become
> > > incoherent with cached memory the hypervisor believes is cachable so we
> > > don't have to flush it.
> > > 
> > > Turn on S2FWB whenever the SMMU supports it and use it for all S2
> > > mappings.
> > 
> > I have been looking into this recently from the KVM side as it will
> > use FWB for the CPU stage-2 unconditionally for guests(if supported),
> > however that breaks for non-coherent devices when assigned, and
> > limiting assigned devices to be coherent seems too restrictive.
> 
> kvm's CPU S2 doesn't care about non-DMA-coherent devices though? That
> concept is only relevant to the SMMU.
> 

Why not? That would be a problem if a device is not dma coherent,
and the VM knows that and maps it’s DMA memory as non cacheable.
But it would be overridden by FWB in stage-2 to be cacheable,
it would lead to coherency issues.

> The issue on the KVM side is you can't put device MMIO into the CPU S2
> using S2FWB and Normal Cachable, it will break the MMIO programming
> model. That isn't "coherency" though.> 
> It has to be Normal-NC, which this patch does:
> 
> https://lore.kernel.org/r/20240224150546.368-4-ankita@nvidia.com

Yes, that also breaks (although I think this is an easier problem to
solve)

> 
> > But for SMMUv3, S2FWB is per stream, can’t we just use it if the master
> > is DMA coherent?
> 
> Sure, that seems to be a weird corner. Lets add this:
> 
> @@ -4575,7 +4575,12 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
>  
>         /* IDR3 */
>         reg = readl_relaxed(smmu->base + ARM_SMMU_IDR3);
> -       if (FIELD_GET(IDR3_FWB, reg))
> +       /*
> +        * If for some reason the HW does not support DMA coherency then using
> +        * S2FWB won't work. This will also disable nesting support.
> +        */
> +       if (FIELD_GET(IDR3_FWB, reg) &&
> +           (smmu->features & ARM_SMMU_FEAT_COHERENCY))
>                 smmu->features |= ARM_SMMU_FEAT_S2FWB;
>         if (FIELD_GET(IDR3_RIL, reg))
>                 smmu->features |= ARM_SMMU_FEAT_RANGE_INV;
> 
> IMHO it would be weird to make HW that has S2FWB but not coherency,
> but sure let's check it.
> 
What I mean is the master itself not the SMMU (the SID basically),
so in that case the STE shouldn’t have FWB enabled.

> Also bear in mind VFIO won't run unless ARM_SMMU_FEAT_COHERENCY is set
> so we won't even get a chance to ask for a S2 domain.

Oh, I think that is only for the SMMU, not for the master, the
SMMU can be coherent (for pte, ste …) but the master can still be
non coherent. Looking at how VFIO uses it, that seems to be a bug?

Thanks,
Mostafa

> 
> Jason

