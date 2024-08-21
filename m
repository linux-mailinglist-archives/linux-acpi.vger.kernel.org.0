Return-Path: <linux-acpi+bounces-7761-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E68C95996D
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Aug 2024 13:19:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4419281B5F
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Aug 2024 11:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83B9F209FEE;
	Wed, 21 Aug 2024 09:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kdPmpc8F"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D5F209FCB
	for <linux-acpi@vger.kernel.org>; Wed, 21 Aug 2024 09:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724234022; cv=none; b=pP3/Ik1u9H/fxtXvEsyIwdQxnjVUNqb32CIjzIo5IOCz+/AHtq1/3nySh/QJiLt+6Qvc1Xdw9dzvGggJEP5LP88FkqOoHc59GIwOBTA8BFGXfaQbvVhewi1J/ecVchklFtX3n9VXVPRbTSCE2D7s93kxBp3Owx26HgFKdtZxmqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724234022; c=relaxed/simple;
	bh=4jQk83b9P8NGlcRViTcEt37cvEix9cl6+yXwsGxW3nI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q8PytjW+uqTn+J3jI1nQHftFJRMpzH/rl7ZWC+2pTqI+d4ryjaXsZrbx/S0BBBAbIMA4QN6u2g0nqoB9/OrUjox6vR7HZyz+ci5J0AUqqwj54tpcC/exV9QzkTMJ9N3K9BsRHbkXnExxjuPoTDfpolFmWEuCHltHdWY8DKJ3RLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kdPmpc8F; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-429d1a9363aso40075e9.1
        for <linux-acpi@vger.kernel.org>; Wed, 21 Aug 2024 02:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724234019; x=1724838819; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=shPtI4yPMxhwNt4uha1HbLqCMGDAgRxC+dkJsclhuHA=;
        b=kdPmpc8FoXvoQo4bnaf4cdMw8AE2MZj7LVTVmrq4SMfFNktMQmtn60naWWrskOW5bk
         GPy0xbwY5XzJNQwku22Ehx7oQBiOxzdi/MVnd0MXmCx/B943SXRNwZ6xioM2WYqxUpSk
         jB0KhmGpaV4+UBSd0pD+OIntW3so1ddwy/2/5viM+3NEKXOXHtVFWBUoccq6CEndBlfl
         y3KsDSQbMhiypsbGUcu9xwrUm+r40WiiYxzpsAIROg3TBdIlIL3cMO5fNehFwFPt84Ot
         NP4zGXh096q0dyZ/Qiy5Psi+i+9Cv97MYVOR4OMoX7kuCt64HtTLOtEq5mO6ECg/m2rP
         C+ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724234019; x=1724838819;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=shPtI4yPMxhwNt4uha1HbLqCMGDAgRxC+dkJsclhuHA=;
        b=QmkR870t1vm3jfU7+I+lqRwo5JU0STeT6bow1XwnAou10XQQEgoeJqiRovUYXbOMTN
         fU3ZYTvG8lFewUjlrEi8afBjQndR0Bl1yPpQUSweKlj/M/Cs4elqtE9m6WtQD6FQnEpU
         86o4ldGEeNP4jzEWVX/y6VmJ9VQoXTXcUsi1cLUnH4cGj8A+svHDSpvhCaBrrRmzFWZJ
         t6ie5CWa32luIaa7Fw/GYm3EaX/5bwZNHIDmyYwKgjotmjKW0WCcufmvtAYrv/q5hIuz
         pLcQe1+gJ2DE4wCexsP7MtehjgLUKoSbTU28QyjGq+Z6PW0ZyxVz/Aa3itW2+7buB+2M
         qu4g==
X-Forwarded-Encrypted: i=1; AJvYcCV0/0StjD1YyKFvOU3Uk8eiGJiCF3wQ7/kqffuch5P71RWrLodRd4gcp/b4bc9tpsBJLN4hmMwtuLvT@vger.kernel.org
X-Gm-Message-State: AOJu0YxTAzzGLbz2iIaJizO0emTgWTp5BR2bXhgPOF3nRNrlT2Eajjxh
	b2t8Qu05byMkbBTjqoQdwB4PPo5fQGUFXz2TPYulFIcjjum+YvWiwCY5ySEGyw==
X-Google-Smtp-Source: AGHT+IHUAEyavgkTbRh5dHjOmtVDPm5Mvfn00nNuswalwfrfossBr6xCiGgGPEQlL0lIyjnw6dvHOA==
X-Received: by 2002:a05:600c:1d9a:b0:426:6413:b681 with SMTP id 5b1f17b1804b1-42ab615a8acmr2142795e9.6.1724234018435;
        Wed, 21 Aug 2024 02:53:38 -0700 (PDT)
Received: from google.com (203.75.199.104.bc.googleusercontent.com. [104.199.75.203])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-371a937a5f4sm10928107f8f.51.2024.08.21.02.53.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 02:53:37 -0700 (PDT)
Date: Wed, 21 Aug 2024 09:53:33 +0000
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
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
	Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH 2/8] iommu/arm-smmu-v3: Use S2FWB when available
Message-ID: <ZsW5HRZj2O2hGQYc@google.com>
References: <0-v1-54e734311a7f+14f72-smmuv3_nesting_jgg@nvidia.com>
 <2-v1-54e734311a7f+14f72-smmuv3_nesting_jgg@nvidia.com>
 <ZsRUDaFLd85O8u4Z@google.com>
 <20240820120102.GB3773488@nvidia.com>
 <ZsT0Fd5FHS47gm0-@google.com>
 <20240820202138.GH3773488@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240820202138.GH3773488@nvidia.com>

On Tue, Aug 20, 2024 at 05:21:38PM -0300, Jason Gunthorpe wrote:
> On Tue, Aug 20, 2024 at 07:52:53PM +0000, Mostafa Saleh wrote:
> > On Tue, Aug 20, 2024 at 09:01:02AM -0300, Jason Gunthorpe wrote:
> > > On Tue, Aug 20, 2024 at 08:30:05AM +0000, Mostafa Saleh wrote:
> > > > Hi Jason,
> > > > 
> > > > On Tue, Aug 06, 2024 at 08:41:15PM -0300, Jason Gunthorpe wrote:
> > > > > Force Write Back (FWB) changes how the S2 IOPTE's MemAttr field
> > > > > works. When S2FWB is supported and enabled the IOPTE will force cachable
> > > > > access to IOMMU_CACHE memory and deny cachable access otherwise.
> > > > > 
> > > > > This is not especially meaningful for simple S2 domains, it apparently
> > > > > doesn't even force PCI no-snoop access to be coherent.
> > > > > 
> > > > > However, when used with a nested S1, FWB has the effect of preventing the
> > > > > guest from choosing a MemAttr that would cause ordinary DMA to bypass the
> > > > > cache. Consistent with KVM we wish to deny the guest the ability to become
> > > > > incoherent with cached memory the hypervisor believes is cachable so we
> > > > > don't have to flush it.
> > > > > 
> > > > > Turn on S2FWB whenever the SMMU supports it and use it for all S2
> > > > > mappings.
> > > > 
> > > > I have been looking into this recently from the KVM side as it will
> > > > use FWB for the CPU stage-2 unconditionally for guests(if supported),
> > > > however that breaks for non-coherent devices when assigned, and
> > > > limiting assigned devices to be coherent seems too restrictive.
> > > 
> > > kvm's CPU S2 doesn't care about non-DMA-coherent devices though? That
> > > concept is only relevant to the SMMU.
> >
> > Why not? That would be a problem if a device is not dma coherent,
> > and the VM knows that and maps it’s DMA memory as non cacheable.
> > But it would be overridden by FWB in stage-2 to be cacheable,
> > it would lead to coherency issues.
> 
> Oh, from that perspective yes, but the entire point of S2FWB is that
> VM's can not create non-coherent access so it is a bit nonsense to ask
> for both S2FWB and try to assign a non-DMA coherent device.

Yes, but KVM sets FWB unconditionally and would use cacheable mapping
for stage-2, and I expect the same for the nested SMMU.

> 
> > Yes, that also breaks (although I think this is an easier problem to
> > solve)
> 
> Well, it is easy to solve, just don't use S2FWB and manually flush the
> caches before the hypervisor touches any memory. :)

Yes, although that means virtualized devices would have worse
performance :/ but I guess there is nothing more to do here.

I have some ideas about that, I can send patches to the kvm list
as an RFC.

> 
> > What I mean is the master itself not the SMMU (the SID basically),
> > so in that case the STE shouldn’t have FWB enabled.
> 
> That doesn't matter, those cases will not pass in IOMMU_CACHE and they
> will work fine with S2FWB turned on.
> 

But that won’t be the case in nested? Otherwise why we use FWB in the
first place.

> > > Also bear in mind VFIO won't run unless ARM_SMMU_FEAT_COHERENCY is set
> > > so we won't even get a chance to ask for a S2 domain.
> > 
> > Oh, I think that is only for the SMMU, not for the master, the
> > SMMU can be coherent (for pte, ste …) but the master can still be
> > non coherent. Looking at how VFIO uses it, that seems to be a bug?
> 
> If there are mixes of SMMU feature and dev_is_dma_coherent() then it
> would be a bug yes..
> 

I think there is a bug, I was able to assign a “non-coherent” device with
VFIO with no issues, and it allows it as long as the SMMU is coherent.

> I recall we started out trying to use dev_is_dma_coherent() but
> Christoph explained it doesn't work that generally:
> 
> https://lore.kernel.org/kvm/20220406135150.GA21532@lst.de/
> 
> Seems we sort of gave up on it, too complicated. Robin had a nice
> observation of the complexity:
> 
>     Disregarding the complete disaster of PCIe No Snoop on Arm-Based 
>     systems, there's the more interesting effectively-opposite scenario 
>     where an SMMU bridges non-coherent devices to a coherent interconnect. 
>     It's not something we take advantage of yet in Linux, and it can only be 
>     properly described in ACPI, but there do exist situations where 
>     IOMMU_CACHE is capable of making the device's traffic snoop, but 
>     dev_is_dma_coherent() - and device_get_dma_attr() for external users - 
>     would still say non-coherent because they can't assume that the SMMU is 
>     enabled and programmed in just the right way.
> 
> Anyhow, for the purposes of KVM and VFIO, devices that don't work with
> IOMMU_CACHE are not allowed. From an API perspective
> IOMMU_CAP_CACHE_COHERENCY is supposed to return if the struct device
> can use IOMMU_CACHE.
> 
> The corner case where we have a ARM_SMMU_FEAT_COHERENCY SMMU but
> somehow specific devices don't support IOMMU_CACHE is not properly
> reflected in IOMMU_CAP_CACHE_COHERENCY. I don't know how to fix that,
> and we've been ignoring it for a long time now :)

Thanks a lot for the extra context!

Maybe the SMMUv3 .capable, should be changed to check if the device is
coherent (instead of using dev_is_dma_coherent, it can use lower level
functions from the supported buses)

Also, I think supporting IOMMU_CACHE is not enough, as the SMMU can
support it but the device is still not coherent.

Thanks,
Mostafa

> 
> Jason

