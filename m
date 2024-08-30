Return-Path: <linux-acpi+bounces-8014-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45F84966527
	for <lists+linux-acpi@lfdr.de>; Fri, 30 Aug 2024 17:19:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 034D3284549
	for <lists+linux-acpi@lfdr.de>; Fri, 30 Aug 2024 15:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE1FD1B3B35;
	Fri, 30 Aug 2024 15:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yBuV3BSX"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2EE31B1D42
	for <linux-acpi@vger.kernel.org>; Fri, 30 Aug 2024 15:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725031164; cv=none; b=F3shveBDUGzgeCjyYYcG+EFoqs2AT7d210S6PIkahWSetoirBfTO/c9K3M/CBtNe4rhAcgM8ouNcdWJ8hG+lSFatTfUzKtswAXLGqNg3BlEF3JLXyqWdNTy+vEvZwaKShjP3U/bN0rnZr8Z6wgIB0CO0fDRACGeAR8g5ZLKu4Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725031164; c=relaxed/simple;
	bh=TN34IkHTB3xFmPDXJVWNqnuJgXI2VhZk+0qeC/YyaoU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QizjF+BSdDHftl3Y2SUN2Ip1IpTjEnR2UPwi1fHD5nmyV0jKDl4qrw2t4oowNTnZiHcJeTZKfyMrMn5/ehlVWNLMlXcTfyVP0utqQ1BU7VU3zyw28tBXl1Fh2wfIDEnDVURubaPt52G6hM6HTo3f5AV2Xfxj2i8PjAvCi3bEiVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yBuV3BSX; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42ba8928f1dso55545e9.1
        for <linux-acpi@vger.kernel.org>; Fri, 30 Aug 2024 08:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725031161; x=1725635961; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hSR4CDDBMGHLTY53mPoCGeCmaHdTc6N/OptBYrns6bs=;
        b=yBuV3BSXX7jWppf/5SvdyoGQzhNEkGuG4AtWv+ho2IPVu15SPBEkYoxI+Fu6RYwYY2
         i6XtFenU+NrQh8XoMzbzcDErdPAgm4L31/yd9UyTDvM0T+DP5yHQ9B8MlKbKAvHVLwZY
         KeviHT43QdQ5qKzSH/AX8NFN+uxnOm9mcLRqSMT57XMK2XN84dGM+3wK1DuyIX/NjN3V
         HKO/ncRb4kn/fpE7ag3idQXQxUaR2wjRo1BMPV0hiZ56koff2RM6AX6rTvCgfVOBeUuY
         BNa9k/T9fkZUjUPw/wlsuVxhbGmFntl9PeuPIrnGCEnshZo5FCwg/JiH4BWY8cFzmrWf
         VjYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725031161; x=1725635961;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hSR4CDDBMGHLTY53mPoCGeCmaHdTc6N/OptBYrns6bs=;
        b=dTXRgtekxVWkAndPyQHGLEVThF7QML+VeIjctRI4lbyEbU5qk15HJxKC9bHFrQo3FU
         3af/zr0U304zhn69EsnHzCRXKU8Fq2p5tvunCHxtxCrKEWHRXIi3tz4THsVe5odZTswc
         Gbj9a9W8ikABfvxclPWJ+nnwIxFxUP3XieMFr8WEvP4Zhcdm2Vs6j1N5NWd7R72N+s+Z
         +KdlWSRZjwcuSjRCLTJucgrXlQEPtmpK0ZPvuMUjwL7yaHrj2vAj5158tDBs0DtBBsUx
         Btu78bUPTqky1GAMaVsR4wgmr7fMt6tOcim5EIAbldL1unXJbteWbGB9xnXc3jwsJPZI
         AhAg==
X-Forwarded-Encrypted: i=1; AJvYcCX/0i0FelnHR0LDZvKc8nEt3Hifpkf/H1ofMuEeEMSBI94Fjum4RXf/rEMsmjlM4U4YJ0tfIgrR1RG7@vger.kernel.org
X-Gm-Message-State: AOJu0YyUpXalWzbIa5l6htqeE2SjUs38A7wn2SKuA5yAqTep1NYYbjyY
	x7zELD2Jk4vUHijwFyCZnfdMguLb+etqLObmt6ZoX6utXiPjiYVmZorOf0JhMw==
X-Google-Smtp-Source: AGHT+IH33QDfWr834aP/FbPyWymRNJ19qWI8WrgjZBRqjMOmaoTgMIX2NYGXshtUvAlTwf4XpXrQqQ==
X-Received: by 2002:a05:600c:1da1:b0:42b:892a:333b with SMTP id 5b1f17b1804b1-42bbaa2b0a9mr1445535e9.2.1725031160899;
        Fri, 30 Aug 2024 08:19:20 -0700 (PDT)
Received: from google.com (109.36.187.35.bc.googleusercontent.com. [35.187.36.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bbc8de253sm15086625e9.0.2024.08.30.08.19.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 08:19:20 -0700 (PDT)
Date: Fri, 30 Aug 2024 15:19:16 +0000
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
Subject: Re: [PATCH v2 5/8] iommu/arm-smmu-v3: Report
 IOMMU_CAP_ENFORCE_CACHE_COHERENCY for CANWBS
Message-ID: <ZtHi9DkSjev7pLfr@google.com>
References: <0-v2-621370057090+91fec-smmuv3_nesting_jgg@nvidia.com>
 <5-v2-621370057090+91fec-smmuv3_nesting_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5-v2-621370057090+91fec-smmuv3_nesting_jgg@nvidia.com>

Hi Jason,

On Tue, Aug 27, 2024 at 12:51:35PM -0300, Jason Gunthorpe wrote:
> HW with CANWBS is always cache coherent and ignores PCI No Snoop requests
> as well. This meets the requirement for IOMMU_CAP_ENFORCE_CACHE_COHERENCY,
> so let's return it.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Mostafa Saleh <smostafa@google.com>

> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 35 +++++++++++++++++++++
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  1 +
>  2 files changed, 36 insertions(+)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index e2b97ad6d74b03..c2021e821e5cb6 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -2253,6 +2253,9 @@ static bool arm_smmu_capable(struct device *dev, enum iommu_cap cap)
>  	case IOMMU_CAP_CACHE_COHERENCY:
>  		/* Assume that a coherent TCU implies coherent TBUs */
>  		return master->smmu->features & ARM_SMMU_FEAT_COHERENCY;
> +	case IOMMU_CAP_ENFORCE_CACHE_COHERENCY:
> +		return dev_iommu_fwspec_get(dev)->flags &
> +		       IOMMU_FWSPEC_PCI_RC_CANWBS;
>  	case IOMMU_CAP_NOEXEC:
>  	case IOMMU_CAP_DEFERRED_FLUSH:
>  		return true;
> @@ -2263,6 +2266,28 @@ static bool arm_smmu_capable(struct device *dev, enum iommu_cap cap)
>  	}
>  }
>  
> +static bool arm_smmu_enforce_cache_coherency(struct iommu_domain *domain)
> +{
> +	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
> +	struct arm_smmu_master_domain *master_domain;
> +	unsigned long flags;
> +	bool ret = false;
nit: we can avoid the goto, if we inverse the logic of ret (and set it
to false if device doesn't support CANWBS)

> +	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
> +	list_for_each_entry(master_domain, &smmu_domain->devices,
> +			    devices_elm) {
> +		if (!(dev_iommu_fwspec_get(master_domain->master->dev)->flags &
> +		      IOMMU_FWSPEC_PCI_RC_CANWBS))
> +			goto out;
> +	}
> +
> +	smmu_domain->enforce_cache_coherency = true;
> +	ret = true;
> +out:
> +	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
> +	return ret;
> +}
> +
>  struct arm_smmu_domain *arm_smmu_domain_alloc(void)
>  {
>  	struct arm_smmu_domain *smmu_domain;
> @@ -2693,6 +2718,15 @@ static int arm_smmu_attach_prepare(struct arm_smmu_attach_state *state,
>  		 * one of them.
>  		 */
>  		spin_lock_irqsave(&smmu_domain->devices_lock, flags);
> +		if (smmu_domain->enforce_cache_coherency &&
> +		    !(dev_iommu_fwspec_get(master->dev)->flags &
> +		      IOMMU_FWSPEC_PCI_RC_CANWBS)) {
> +			kfree(master_domain);
> +			spin_unlock_irqrestore(&smmu_domain->devices_lock,
> +					       flags);
> +			return -EINVAL;
> +		}
> +
>  		if (state->ats_enabled)
>  			atomic_inc(&smmu_domain->nr_ats_masters);
>  		list_add(&master_domain->devices_elm, &smmu_domain->devices);
> @@ -3450,6 +3484,7 @@ static struct iommu_ops arm_smmu_ops = {
>  	.owner			= THIS_MODULE,
>  	.default_domain_ops = &(const struct iommu_domain_ops) {
>  		.attach_dev		= arm_smmu_attach_dev,
> +		.enforce_cache_coherency = arm_smmu_enforce_cache_coherency,
>  		.set_dev_pasid		= arm_smmu_s1_set_dev_pasid,
>  		.map_pages		= arm_smmu_map_pages,
>  		.unmap_pages		= arm_smmu_unmap_pages,
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> index 7e8d2f36faebf3..45882f65bfcad0 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> @@ -787,6 +787,7 @@ struct arm_smmu_domain {
>  	/* List of struct arm_smmu_master_domain */
>  	struct list_head		devices;
>  	spinlock_t			devices_lock;
> +	bool				enforce_cache_coherency : 1;
>  
>  	struct mmu_notifier		mmu_notifier;
>  };
> -- 
> 2.46.0
> 

