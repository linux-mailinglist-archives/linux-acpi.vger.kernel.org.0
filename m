Return-Path: <linux-acpi+bounces-9131-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EDB09B691F
	for <lists+linux-acpi@lfdr.de>; Wed, 30 Oct 2024 17:27:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C29CD282624
	for <lists+linux-acpi@lfdr.de>; Wed, 30 Oct 2024 16:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B401A214412;
	Wed, 30 Oct 2024 16:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cy/5HfUm"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40BA4214402
	for <linux-acpi@vger.kernel.org>; Wed, 30 Oct 2024 16:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730305639; cv=none; b=GeySXycjJZn/SSV5tiJOYIEjIg6KmK0dJqp7h/WZ/L6RPrL8f9psSya8HqvxEJ0qti6B5ueeB3ln9f0BuCHbE9QkkFJtjrluP9YXg2146C6WtjgDRJbPUhw20SEdhwpYb42Puzg1PBXv+khK4IlSY6BXQvn/Fpr4AjQna0/g9lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730305639; c=relaxed/simple;
	bh=UblSNSNMS2SOQAz7chOMf7T7raYYYerjDvTtLkicoW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M9MX4Y5+LqMXAD2WnKMOKzYruXEZD2t+ZRI4PkuB5VqFpe4xU691UjOo9Zqwl0GQ3Id5PSmL/g2o4YMKn59HaKR2KkrWA/y23jpkGpMuD+RwwmvynRGvqlOGJ2sivttnzkrAdzr605x26KYxh48G5IziQ9ZcqEuS0DI9iydm5CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cy/5HfUm; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43150ea2db6so262615e9.0
        for <linux-acpi@vger.kernel.org>; Wed, 30 Oct 2024 09:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730305635; x=1730910435; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yYoXZbQ0uAqOxJs4pfuNVgj8x5cCoQnCDnibucZBWDk=;
        b=cy/5HfUm8N0MmnMlV3z95nmaKvlY5zyrVLfLTFzWe6lIVW7aexTo5OSAAMeTln4VXp
         9/FzHUduYIopYKkJmYme4y9CeURJudoeyo8j3rmpsQ5QTS46dBL5hyDoGVld3vaBwEtq
         pCVy6Lf170OnZiaUy9YL1Hxj/2Xg92L2vuX8PUGSj0mMHI06nUPlzWrP8aVc0gzkSb8A
         66SPL9ij54X1L0VSXDM8NND0t0T48nIzhCWVfhw3J9uZG1xe3WM4Cd8JkCj9JTW5E3m7
         AS1Oawz9dn+FCLZPXA4MrnhRrf2bAjG937eMVB3q0I6Z+JAe+vR1HuylIeuk1OulrmyU
         57Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730305635; x=1730910435;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yYoXZbQ0uAqOxJs4pfuNVgj8x5cCoQnCDnibucZBWDk=;
        b=S916r4UugwDj3HwjxLAz4OhOOFHU0yZf8W5VKd4ZXm87MsVc/Hur/hnzjFeuxjzVha
         /Rjsggv3dQqdEMCl+dP6+muxTLCTwO5SAIH604H6l/mVyf0YsPdNK/DvOiHhU7M0Lpgn
         jVZ7xxjYrGM+ZhW4f4xZ1Q5aFMfNC4M2iqDoJFXDkJStaQYQ9wF7qmyTBCm5lzRt8vVD
         bzDAykb7HJS5A/np0uXJD4SwCFqainXjnCdY9+3uJATmqHbhru2+QAuiifjXKMLlr8rs
         Dd0xS0r3x38MFCu3dIIP3529WYti2Ist8CNbXTZw6RzVYlE4gHn7xz/0Zc8265Ov4T8a
         btYQ==
X-Forwarded-Encrypted: i=1; AJvYcCXPCMpW5NTAiKUIIb8PAwc2mgOUZZisAGwcpU5AJSf0L7AoH8+sOvqZIfxbOXsVk0hh+M+345CuCIyx@vger.kernel.org
X-Gm-Message-State: AOJu0YyevH9aPOyMNOJA0M8BF18EtUOVXHN4KLO6lob3Vk0QDuQu2jr0
	TZtg6/VvSIQfwCHnscjAby6z6H8C45KW7U59xH5pbujlBx9tpMRduycwtuMu2A==
X-Gm-Gg: ASbGncsxMO+y4FjB9pN0KScOYnRq2l/ss8pmGow3phqrTDXvQh8vaZgBodaVrjhGq3X
	VF8Uuy7e3I1FvqL6EZxCKXiqNZwVoSmlnDCYUbAEOmgfnGc7lEvSTKszzFSVuAduzQy645m47gO
	x1eN3p0vGayf+OxbfDMCbbmVlZ0VgId2G/DBCkir+pHo4+TLPH7oWJ8qsgwdguxmvUPNU+7vrsa
	cS+a1cTiIb2IzitQMKRXmPKN2gspSBNWQxyzmJqjRdLqaIY3cIXJHibUm7gqx6wqqD2qv6XocrH
	VzhX8MhoLw==
X-Google-Smtp-Source: AGHT+IEOBtDGTbd6gFd1Z2+Q52Kfzjw/j8SXp0CbEXKBAIwCsXgB74M2Jp4jqtd+Hp2Dw2dtDYw8jw==
X-Received: by 2002:a05:600c:1d83:b0:42c:acd7:b59b with SMTP id 5b1f17b1804b1-431b3cdeb16mr11198215e9.6.1730305635387;
        Wed, 30 Oct 2024 09:27:15 -0700 (PDT)
Received: from google.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431bd9ca818sm25801655e9.40.2024.10.30.09.27.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 09:27:08 -0700 (PDT)
Date: Wed, 30 Oct 2024 16:26:59 +0000
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
Subject: Re: [PATCH v3 7/9] iommu/arm-smmu-v3: Expose the arm_smmu_attach
 interface
Message-ID: <ZyJeU9Kkos6RibsR@google.com>
References: <0-v3-e2e16cd7467f+2a6a1-smmuv3_nesting_jgg@nvidia.com>
 <7-v3-e2e16cd7467f+2a6a1-smmuv3_nesting_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7-v3-e2e16cd7467f+2a6a1-smmuv3_nesting_jgg@nvidia.com>

On Wed, Oct 09, 2024 at 01:23:13PM -0300, Jason Gunthorpe wrote:
> The arm-smmuv3-iommufd.c file will need to call these functions too.
> Remove statics and put them in the header file. Remove the kunit
> visibility protections from arm_smmu_make_abort_ste() and
> arm_smmu_make_s2_domain_ste().
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Mostafa Saleh <smostafa@google.com>

Thanks,
Mostafa
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 22 ++++-------------
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h | 27 +++++++++++++++++----
>  2 files changed, 27 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 80847fa386fcd2..b4b03206afbf48 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -1549,7 +1549,6 @@ static void arm_smmu_write_ste(struct arm_smmu_master *master, u32 sid,
>  	}
>  }
>  
> -VISIBLE_IF_KUNIT
>  void arm_smmu_make_abort_ste(struct arm_smmu_ste *target)
>  {
>  	memset(target, 0, sizeof(*target));
> @@ -1632,7 +1631,6 @@ void arm_smmu_make_cdtable_ste(struct arm_smmu_ste *target,
>  }
>  EXPORT_SYMBOL_IF_KUNIT(arm_smmu_make_cdtable_ste);
>  
> -VISIBLE_IF_KUNIT
>  void arm_smmu_make_s2_domain_ste(struct arm_smmu_ste *target,
>  				 struct arm_smmu_master *master,
>  				 struct arm_smmu_domain *smmu_domain,
> @@ -2505,8 +2503,8 @@ arm_smmu_get_step_for_sid(struct arm_smmu_device *smmu, u32 sid)
>  	}
>  }
>  
> -static void arm_smmu_install_ste_for_dev(struct arm_smmu_master *master,
> -					 const struct arm_smmu_ste *target)
> +void arm_smmu_install_ste_for_dev(struct arm_smmu_master *master,
> +				  const struct arm_smmu_ste *target)
>  {
>  	int i, j;
>  	struct arm_smmu_device *smmu = master->smmu;
> @@ -2671,16 +2669,6 @@ static void arm_smmu_remove_master_domain(struct arm_smmu_master *master,
>  	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
>  }
>  
> -struct arm_smmu_attach_state {
> -	/* Inputs */
> -	struct iommu_domain *old_domain;
> -	struct arm_smmu_master *master;
> -	bool cd_needs_ats;
> -	ioasid_t ssid;
> -	/* Resulting state */
> -	bool ats_enabled;
> -};
> -
>  /*
>   * Start the sequence to attach a domain to a master. The sequence contains three
>   * steps:
> @@ -2701,8 +2689,8 @@ struct arm_smmu_attach_state {
>   * new_domain can be a non-paging domain. In this case ATS will not be enabled,
>   * and invalidations won't be tracked.
>   */
> -static int arm_smmu_attach_prepare(struct arm_smmu_attach_state *state,
> -				   struct iommu_domain *new_domain)
> +int arm_smmu_attach_prepare(struct arm_smmu_attach_state *state,
> +			    struct iommu_domain *new_domain)
>  {
>  	struct arm_smmu_master *master = state->master;
>  	struct arm_smmu_master_domain *master_domain;
> @@ -2784,7 +2772,7 @@ static int arm_smmu_attach_prepare(struct arm_smmu_attach_state *state,
>   * completes synchronizing the PCI device's ATC and finishes manipulating the
>   * smmu_domain->devices list.
>   */
> -static void arm_smmu_attach_commit(struct arm_smmu_attach_state *state)
> +void arm_smmu_attach_commit(struct arm_smmu_attach_state *state)
>  {
>  	struct arm_smmu_master *master = state->master;
>  
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> index 66261fd5bfb2d2..c9e5290e995a64 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> @@ -830,21 +830,22 @@ struct arm_smmu_entry_writer_ops {
>  	void (*sync)(struct arm_smmu_entry_writer *writer);
>  };
>  
> +void arm_smmu_make_abort_ste(struct arm_smmu_ste *target);
> +void arm_smmu_make_s2_domain_ste(struct arm_smmu_ste *target,
> +				 struct arm_smmu_master *master,
> +				 struct arm_smmu_domain *smmu_domain,
> +				 bool ats_enabled);
> +
>  #if IS_ENABLED(CONFIG_KUNIT)
>  void arm_smmu_get_ste_used(const __le64 *ent, __le64 *used_bits);
>  void arm_smmu_write_entry(struct arm_smmu_entry_writer *writer, __le64 *cur,
>  			  const __le64 *target);
>  void arm_smmu_get_cd_used(const __le64 *ent, __le64 *used_bits);
> -void arm_smmu_make_abort_ste(struct arm_smmu_ste *target);
>  void arm_smmu_make_bypass_ste(struct arm_smmu_device *smmu,
>  			      struct arm_smmu_ste *target);
>  void arm_smmu_make_cdtable_ste(struct arm_smmu_ste *target,
>  			       struct arm_smmu_master *master, bool ats_enabled,
>  			       unsigned int s1dss);
> -void arm_smmu_make_s2_domain_ste(struct arm_smmu_ste *target,
> -				 struct arm_smmu_master *master,
> -				 struct arm_smmu_domain *smmu_domain,
> -				 bool ats_enabled);
>  void arm_smmu_make_sva_cd(struct arm_smmu_cd *target,
>  			  struct arm_smmu_master *master, struct mm_struct *mm,
>  			  u16 asid);
> @@ -902,6 +903,22 @@ static inline bool arm_smmu_master_canwbs(struct arm_smmu_master *master)
>  	       IOMMU_FWSPEC_PCI_RC_CANWBS;
>  }
>  
> +struct arm_smmu_attach_state {
> +	/* Inputs */
> +	struct iommu_domain *old_domain;
> +	struct arm_smmu_master *master;
> +	bool cd_needs_ats;
> +	ioasid_t ssid;
> +	/* Resulting state */
> +	bool ats_enabled;
> +};
> +
> +int arm_smmu_attach_prepare(struct arm_smmu_attach_state *state,
> +			    struct iommu_domain *new_domain);
> +void arm_smmu_attach_commit(struct arm_smmu_attach_state *state);
> +void arm_smmu_install_ste_for_dev(struct arm_smmu_master *master,
> +				  const struct arm_smmu_ste *target);
> +
>  #ifdef CONFIG_ARM_SMMU_V3_SVA
>  bool arm_smmu_sva_supported(struct arm_smmu_device *smmu);
>  bool arm_smmu_master_sva_supported(struct arm_smmu_master *master);
> -- 
> 2.46.2
> 

