Return-Path: <linux-acpi+bounces-9130-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B83159B6918
	for <lists+linux-acpi@lfdr.de>; Wed, 30 Oct 2024 17:26:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB7B21C2174C
	for <lists+linux-acpi@lfdr.de>; Wed, 30 Oct 2024 16:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCCE42141D3;
	Wed, 30 Oct 2024 16:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PPDF618W"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FBF92141BA
	for <linux-acpi@vger.kernel.org>; Wed, 30 Oct 2024 16:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730305586; cv=none; b=ElZ4IuXxg/OTfrQtr0s1hi9qrg7Ka5mYBRrpHo4seQm3hnt8ErJdU5234+T2pRwk276hOmJLzyqCt6wmM/oruL0Yjo7kuBIef8Qyplk7kOso3nXzAU2xsA1+J/9wPoUGBnMVZUDDEzi+A0APU4ew2Fj8sXhfDGwUXVPcfkcq5MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730305586; c=relaxed/simple;
	bh=wzGL5UpvG0bdwTiYnT824JUIRPqrqwRpm/7xcQNirR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lr4VSgms3LQy5h/476J0O8LeE70Pb1y4/9HsIAhFLlXTTMkCw/EBOxYtMhFts3bJl2moKM/HM/xyrR7S1z9JKcH5QnH0lJPybUj4nkAS+ATuRbk9v+mqhBPKig6YNGj5zZMaWY2Kd1BwcDOEHi7KpPnhw3K73WzZlJREfAkNUzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PPDF618W; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43150ea2db6so262145e9.0
        for <linux-acpi@vger.kernel.org>; Wed, 30 Oct 2024 09:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730305583; x=1730910383; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7UYLjFAMj81rJ/LVUvePRD+K/hBtRYfZ9cIPVkpzOQ4=;
        b=PPDF618W1eFTLYEf3PAHxca+hmoaMvU+HoML1FCAs2kh1sVzkF52wKTSlpa3GWb31+
         QtGeKw9NqMitsyEMf8lCAGQ/alJQhHoHtxnNqvUd8gLXMhTsfE2+ag0/+Kf0Kq5hoHrW
         bk8w7dNosMgKPmX1YDbmeoZl5bVK6BnSioFMZL8CQxmNeyD1JqwqVLzaTLYuw+SJ/ocO
         Jba2Q313dTixKsp6nziu6XzSW7HqaclzSsawhByNSh2XFCox84JQwF9rutdb29xhV9da
         GZimvamS9unkTsUyVav3lmG80SNwkTvszVsJhT78oSQDnhAlSBsbq2aktZDVP5rlQl2J
         e5cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730305583; x=1730910383;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7UYLjFAMj81rJ/LVUvePRD+K/hBtRYfZ9cIPVkpzOQ4=;
        b=tJmBusRyN6fltZVkzKYb7B9BGM+f0T8mcgCuNcj/3AerwJa03igdJ10PqvHYcpZ19N
         OqtngS2q8c7COecPnAo/kiaHahH4/1jeg+K3kNBg+hN0kN9IQ23F4zdXkGjkPGUuYUK7
         OOX4NNhhSYQT2fmlwt0CQNt+6Hr4pEloSfU4fMnl5vniApgs/iALTXjUyG0OQmySQrRP
         09MmvuUhTGIY6l2D9gWaxFnkct12YtorRjh6nHDSIeqKelVU17AK7VouKI3PmfdpGty2
         46hLT0vgUIvTManvXgVecDA9OxgCl8vj1Q40SQz5fdqBtRZTkanieNo0fnVX3K4bwgCM
         6b9Q==
X-Forwarded-Encrypted: i=1; AJvYcCU1U6kVHRpPrnBGus7W/ETXF0DBGO0uQdWS4TdjIGnrK4aG+X5bjfdRSbLoOp/L9sfGBQ16/5VcQAgY@vger.kernel.org
X-Gm-Message-State: AOJu0YzM2QBEet0NtaeUSaw6uObHP8C20PVgB2WZ4MyfZCSTLX1Ctsfs
	Sww0GVZocyXmZOoVRws4a9DaL0mOMOGh42/w0PkHx6x/cyOlF4cJEtU/sPyQ3Q==
X-Gm-Gg: ASbGncuwJAST+9QcWgfxrNOPWCc+2UHH30nnZMTL2gBDERECZ01EuczCGMdfS/dnEoI
	cuuKORld0W8th9WpmxObAmvkPHqvUv5gfmDLvHt7xRHhw9Rv6zHmJFMxYCcLZgQMXd/lEsTMkhR
	LaIdwcrSIa/LV18YHboXH9f0XHXjeSDTI1gdz2hb+H3+zS7yRRxZqAx/s//xF2x0z5a92/uekQU
	wrQV5hbSj0YBrH3qR5tMNFJEjeFthiZIHoucCqnJAW1Ea4ulmrAadD8brfXPaJZHT6LYD88hud9
	GX22g+LJpQ==
X-Google-Smtp-Source: AGHT+IF5k+xhEFV5HljKvzF9cSpzzYGRlJbocUjKE5hnuGSngP/vDOPF5xH9U8BJE4SMib7JrVlCvw==
X-Received: by 2002:a05:600c:1e04:b0:431:43a1:4cac with SMTP id 5b1f17b1804b1-431b4a21ba1mr10153235e9.3.1730305582787;
        Wed, 30 Oct 2024 09:26:22 -0700 (PDT)
Received: from google.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058bb4287sm15691567f8f.114.2024.10.30.09.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 09:26:21 -0700 (PDT)
Date: Wed, 30 Oct 2024 16:26:16 +0000
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
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH v3 6/9] iommu/arm-smmu-v3: Implement
 IOMMU_HWPT_ALLOC_NEST_PARENT
Message-ID: <ZyJeKPvMRBaKpMeJ@google.com>
References: <0-v3-e2e16cd7467f+2a6a1-smmuv3_nesting_jgg@nvidia.com>
 <6-v3-e2e16cd7467f+2a6a1-smmuv3_nesting_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6-v3-e2e16cd7467f+2a6a1-smmuv3_nesting_jgg@nvidia.com>

On Wed, Oct 09, 2024 at 01:23:12PM -0300, Jason Gunthorpe wrote:
> For SMMUv3 the parent must be a S2 domain, which can be composed
> into a IOMMU_DOMAIN_NESTED.
> 
> In future the S2 parent will also need a VMID linked to the VIOMMU and
> even to KVM.
> 
> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
> Tested-by: Nicolin Chen <nicolinc@nvidia.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Mostafa Saleh <smostafa@google.com>

Thanks,
Mostafa

> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 996774d461aea2..80847fa386fcd2 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -3114,7 +3114,8 @@ arm_smmu_domain_alloc_user(struct device *dev, u32 flags,
>  			   const struct iommu_user_data *user_data)
>  {
>  	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
> -	const u32 PAGING_FLAGS = IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
> +	const u32 PAGING_FLAGS = IOMMU_HWPT_ALLOC_DIRTY_TRACKING |
> +				 IOMMU_HWPT_ALLOC_NEST_PARENT;
>  	struct arm_smmu_domain *smmu_domain;
>  	int ret;
>  
> @@ -3127,6 +3128,14 @@ arm_smmu_domain_alloc_user(struct device *dev, u32 flags,
>  	if (IS_ERR(smmu_domain))
>  		return ERR_CAST(smmu_domain);
>  
> +	if (flags & IOMMU_HWPT_ALLOC_NEST_PARENT) {
> +		if (!(master->smmu->features & ARM_SMMU_FEAT_NESTING)) {
> +			ret = -EOPNOTSUPP;
> +			goto err_free;
> +		}
> +		smmu_domain->stage = ARM_SMMU_DOMAIN_S2;
> +	}
> +
>  	smmu_domain->domain.type = IOMMU_DOMAIN_UNMANAGED;
>  	smmu_domain->domain.ops = arm_smmu_ops.default_domain_ops;
>  	ret = arm_smmu_domain_finalise(smmu_domain, master->smmu, flags);
> -- 
> 2.46.2
> 

