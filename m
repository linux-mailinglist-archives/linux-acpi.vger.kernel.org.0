Return-Path: <linux-acpi+bounces-9347-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6800D9BDE54
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Nov 2024 06:39:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 687661C22DC9
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Nov 2024 05:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E07561917E4;
	Wed,  6 Nov 2024 05:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gkxY0evp"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5060C18FDD0
	for <linux-acpi@vger.kernel.org>; Wed,  6 Nov 2024 05:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730871570; cv=none; b=RhtpeygreDwHesQ21pC772gj3XVZA5o3c7lyVIGWLoM3ts77kDBbsQ9TiYJHFdXwQvgRydehr/hj72jRjGWyCBwwI2GNJ/VQ8dfJM5QWN0ybxgs21JW/zx9zMOBOAOzzwYuheXTLPATFVfcGffR6ci3Im1hb0E0d50+9raGbuHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730871570; c=relaxed/simple;
	bh=3qBDiqpY9XDqbY2Y9odYYAPqOm9MdhCQLElgiaodrH0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y2vIu+HtZYJq/rJuEmTsVgw1orJteAu6RXpVKAs44BcNBpxodlBXFEnkJ2u9Mak4SZ90NLcR/dlAwR2+tJPPNldlzAF3DtWL+9wnZdss/A6pnWIMEFHlI1T9CEgONtyYIe2hmYAgESbx9VNeSqfZF+IhaHLvOhs3ptnWNdZ1bmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gkxY0evp; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-539f53973fdso446518e87.1
        for <linux-acpi@vger.kernel.org>; Tue, 05 Nov 2024 21:39:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730871565; x=1731476365; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AN4uQlg4JmmnskoZUbD9ajWs6/v+l9dkVw03I1zm8cw=;
        b=gkxY0evpc78lyNkTILVk409H9nFTRzkmUYLkkxqIXf9UU6lmHGyKrEFkeynN+XO6WG
         /Q9Tm8PR3aYI1fwbAtPXk2pus0+f4b8dgy22oH7m87l/yy3N6YUz4T1LB2DCfDi/L9CS
         pJWvrrXJIqtam7RlqNMhIyC2s53syrMYWv6k7/GOpKntprws5X7vLWHi+wIAHn0/NKED
         pjKlAOCNBMpENcEdrDYvuk5sObDjpoHESmLHh1HpQRgXBTE5Rs7EgdO03GvFzSqUFtJj
         IQRf0mFOQGC9v+vPWaepd/nBs8s+SrNibqV2+EAmcfGdth+kaLRJ6zxQ+eczbIeKwNe+
         pRWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730871565; x=1731476365;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AN4uQlg4JmmnskoZUbD9ajWs6/v+l9dkVw03I1zm8cw=;
        b=wQMDOd6w+5TBMR7KULK7mZkfPws9j+I5d3B1NCG08o/jlZvwPupB8ZZDAS0T0emF9D
         hmLfb3HDIeye1n8/9zd7Ocq7YhIS+tD54/SQXg+Q7fVzE/C1kJwBPddjE38iHjMdX/+S
         +XqKe9zTioNQ9g1LcXRh/6qIjCX4kmkkKWUD3nN4wiIkiSOCpANOXUA68omnn4hezEL2
         t9U2iDCiF3bnmU9RYlMNna92hBUirJjfQlvegG4d9QaDaCM18R0k8dLo4d4M0HYCP4R5
         ZnSr9J9tkUNM9l1R8Bay9V/XHXnf+95Q5fAKKRfDYwyAtZYKX4apjmoLGFBHhueGdj9C
         YsfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVxMUjkuLv9Z0Xon/CaHNmMRb8buFEtTgm0qihHJBZg6hJ3f6mOJ8mwHaipFlGuh+CfFe3PZjUfKYsQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5wcfmgxgsAJDeFPPIyMi7mTpvPq8fwTWIg4HqCJ+ooZgOdzCv
	ooL3F28P8rniAxEnLaZqASUtlainAYW/HtXWMASrZ5grrTSwprgANxM564o7t0UXkeFH928cv29
	IQnnKUghWXJN+C16VCztdSxsDIDJsYyhewJBOAg==
X-Google-Smtp-Source: AGHT+IHkFZmS15Yat+yA6wTIjddaBPNP6Qu4/1YXgkU7r7C/EE/mZc+JCaJP3gRrzyZ+p7mBuvSg1qn/MJDQimjHDOk=
X-Received: by 2002:a05:6512:4803:b0:53b:1ede:9174 with SMTP id
 2adb3069b0e04-53d7cff7502mr316569e87.28.1730871564937; Tue, 05 Nov 2024
 21:39:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0-v4-9e99b76f3518+3a8-smmuv3_nesting_jgg@nvidia.com>
 <9-v4-9e99b76f3518+3a8-smmuv3_nesting_jgg@nvidia.com> <CABQgh9HoGFGDTEqziQt6WrJ7Bm9d-0c259PYsms3nOVEidn5BA@mail.gmail.com>
 <20241104171931.GB10193@nvidia.com>
In-Reply-To: <20241104171931.GB10193@nvidia.com>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Wed, 6 Nov 2024 05:39:13 +0000
Message-ID: <CABQgh9HSAhat3_P43F_z07oqDaJ9h_YrZ-+SdHZ=ijzrZD1CVw@mail.gmail.com>
Subject: Re: [PATCH v4 09/12] iommu/arm-smmu-v3: Support IOMMU_DOMAIN_NESTED
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: acpica-devel@lists.linux.dev, iommu@lists.linux.dev, 
	Joerg Roedel <joro@8bytes.org>, Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org, 
	Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Robert Moore <robert.moore@intel.com>, Robin Murphy <robin.murphy@arm.com>, 
	Sudeep Holla <sudeep.holla@arm.com>, Will Deacon <will@kernel.org>, 
	Alex Williamson <alex.williamson@redhat.com>, Donald Dutile <ddutile@redhat.com>, 
	Eric Auger <eric.auger@redhat.com>, Hanjun Guo <guohanjun@huawei.com>, 
	Jean-Philippe Brucker <jean-philippe@linaro.org>, Jerry Snitselaar <jsnitsel@redhat.com>, 
	Moritz Fischer <mdf@kernel.org>, Michael Shavit <mshavit@google.com>, Nicolin Chen <nicolinc@nvidia.com>, 
	patches@lists.linux.dev, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 4 Nov 2024 at 17:19, Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> On Thu, Oct 31, 2024 at 02:21:11PM +0800, Zhangfei Gao wrote:
>
> > > +static struct iommu_domain *
> > > +arm_vsmmu_alloc_domain_nested(struct iommufd_viommu *viommu, u32 flags,
> > > +                             const struct iommu_user_data *user_data)
> > > +{
> > > +       struct arm_vsmmu *vsmmu = container_of(viommu, struct arm_vsmmu, core);
> > > +       struct arm_smmu_nested_domain *nested_domain;
> > > +       struct iommu_hwpt_arm_smmuv3 arg;
> > > +       int ret;
> > > +
> > > +       if (flags)
> > > +               return ERR_PTR(-EOPNOTSUPP);
> >
> > This check fails when using user page fault, with flags =
> > IOMMU_HWPT_FAULT_ID_VALID (4)
> > Strange, the check is not exist in last version?
> >
> > iommufd_viommu_alloc_hwpt_nested ->
> > viommu->ops->alloc_domain_nested(viommu, flags, user_data) ->
> > arm_vsmmu_alloc_domain_nested
>
> It should permit IOMMU_HWPT_FAULT_ID_VALID, I'll add this hunk:
>
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
> @@ -178,12 +178,18 @@ arm_vsmmu_alloc_domain_nested(struct iommufd_viommu *viommu, u32 flags,
>                               const struct iommu_user_data *user_data)
>  {
>         struct arm_vsmmu *vsmmu = container_of(viommu, struct arm_vsmmu, core);
> +       const u32 SUPPORTED_FLAGS = IOMMU_HWPT_FAULT_ID_VALID;
>         struct arm_smmu_nested_domain *nested_domain;
>         struct iommu_hwpt_arm_smmuv3 arg;
>         bool enable_ats = false;
>         int ret;
>
> -       if (flags)
> +       /*
> +        * Faults delivered to the nested domain are faults that originated by
> +        * the S1 in the domain. The core code will match all PASIDs when
> +        * delivering the fault due to user_pasid_table
> +        */
> +       if (flags & ~SUPPORTED_FLAGS)
>                 return ERR_PTR(-EOPNOTSUPP);

Thanks Jason, this works

