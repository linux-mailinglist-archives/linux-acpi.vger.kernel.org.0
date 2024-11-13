Return-Path: <linux-acpi+bounces-9523-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 962CC9C666A
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Nov 2024 02:02:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54DD82837B8
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Nov 2024 01:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA438A936;
	Wed, 13 Nov 2024 01:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pfEGiEBH"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3BEA29CFB
	for <linux-acpi@vger.kernel.org>; Wed, 13 Nov 2024 01:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731459716; cv=none; b=RGw+6cjNFUox9bAA3+/i6dNKxbxEcnM99E538/d1Fzyjm6pHwa3z8RhaLnDPpdMzGOol71hAZs8zJmfz/xpjA8dg7VugDYXFXdA/tSkNwfiupyYTL09LHuaN1qxMv/AD6UpDeCululaFq0aDONQ6AG/Nm9ZPneCCl01lz9Rz8E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731459716; c=relaxed/simple;
	bh=5v0Pumd1wdfkWfYkDyIym/XT5Jsmn2z22aIpke3ZD48=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uwcHocURC/4pMmgYLU9pFNDdjcFQIbX9alfc0GsV5zlAA0e5xe0N09Ca8nTechyueDGBtQcPUREM7UoRbMYYZrys3gw9jFHmo+4NI4v9zt8ZVBXsIxgDWVJD43liZpPM1dA3ICQi/XeSRiEMd9EbIpG60S3yPbaou5kc2bNgegc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pfEGiEBH; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-53d9ff8f1e4so372439e87.2
        for <linux-acpi@vger.kernel.org>; Tue, 12 Nov 2024 17:01:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731459713; x=1732064513; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=X/yyOuGNVIzT+zYvh4v3hplD3RNbNSCQhrz/FBYBpRw=;
        b=pfEGiEBHjjWhr390kchqE8sKFazOC66AAW8ruPbLb3K39ostOaXd3xLFpFdwyr7Os1
         kdi3WQtTYsbIRAN6tj1LxNpvLIRNEAzN6Ii3p5vy3MIXeLohMK8Wc0or7tc0g2mETkIz
         NrrupDB3y1lFdaEjFP2+js3M0r0ff+wUMinUUkwOyP85VGm1SPL80Pj9uDuqOsZQHGyY
         4Y0wXQA++M447tcoLAOhUJpjwARNC6/M10Y5qCPxOFZjLvCKikf6UxWKKs44m5eWugTo
         WRaxC3xcTeYxS4v8p9I5OMI3DjAu9Ykngghp8rpgGIkFfuzdF32puQPiXFsipJ0qsBEp
         9gRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731459713; x=1732064513;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X/yyOuGNVIzT+zYvh4v3hplD3RNbNSCQhrz/FBYBpRw=;
        b=OjaCihCCbO1LJH8wF4Mso6hCmaF/Gjfk/JxAlrcO9dOsvWGtHMGPgD5FjvTsP+e70+
         xq4Nm+149vosdmDM5jpAfueuZKbB4Rmaaq6//iXZiakipJGLNe5kNbrVrPlNrCpLM5/q
         lascxUaHWW2JM/gvap3Zkxw4Abz9FbdI6lUmZBd4vioLDB5yJTPo1UdyTMfvfwW112mU
         uthL4zz28MyyfP/dgENR7zRTmgIc3y+VGSEe+u0FqirGOH4cyh8BaawOF8oSSzeC+HKZ
         AJMLxqxYQHXKzcdMCuyBUT2G+nKaPrDd37DdjflKsEIiNH4QsdA0/BERvEDGXITf1ybq
         eDyw==
X-Forwarded-Encrypted: i=1; AJvYcCWNC9UVgJC833cfIunm/VTZj8zrSfO1pWyWi5Jvh4565mV+URTIaI7KAAGOd/blzUbXCPfVUHX99DyM@vger.kernel.org
X-Gm-Message-State: AOJu0YxA6jpgfQwyEsuDGpPzAI5zJmLzC1xqwMOeoHdOjN5Gu9zXspER
	c/DEhdU/0DxxinzXlVE4EHwN5/y4G4o3oISpEZntrCz3MBswMW4RJYOtwi5hVvvDsmKWQex3BBI
	NVMF4RH1EGpOBalyHBsMiz7M7Lq6J/1Q6JV89kQ==
X-Google-Smtp-Source: AGHT+IGrTpBP4XZN2inszS5LiWIDhaTOAjWYv1IN45jLudjPrpRKEn2OnUUglHnQBM+zZuWyWdAuDjaQVoneTf1/DNk=
X-Received: by 2002:a05:6512:ba0:b0:539:e436:f1cd with SMTP id
 2adb3069b0e04-53d862d38c5mr9315032e87.16.1731459712927; Tue, 12 Nov 2024
 17:01:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0-v4-9e99b76f3518+3a8-smmuv3_nesting_jgg@nvidia.com> <20241112182938.GA172989@nvidia.com>
In-Reply-To: <20241112182938.GA172989@nvidia.com>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Wed, 13 Nov 2024 09:01:41 +0800
Message-ID: <CABQgh9HOHzeRF7JfrXrRAcGB53o29HkW9rnVTf4JefeVWDvzyQ@mail.gmail.com>
Subject: Re: [PATCH v4 00/12] Initial support for SMMUv3 nested translation
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

On Wed, 13 Nov 2024 at 02:29, Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> On Wed, Oct 30, 2024 at 09:20:44PM -0300, Jason Gunthorpe wrote:
> > Jason Gunthorpe (7):
> >   iommu/arm-smmu-v3: Support IOMMU_DOMAIN_NESTED
> >   iommu/arm-smmu-v3: Use S2FWB for NESTED domains
> >   iommu/arm-smmu-v3: Allow ATS for IOMMU_DOMAIN_NESTED
> >
> > Nicolin Chen (5):
> >   iommu/arm-smmu-v3: Support IOMMU_VIOMMU_ALLOC
> >   iommu/arm-smmu-v3: Support IOMMU_HWPT_INVALIDATE using a VIOMMU object
>
> Applied to iommufd for-next along with all the dependencies and the
> additional hunk Zhangfei pointed out.

Thanks Jason, I have verified on aarch64 based on your
jason/smmuv3_nesting branch

https://github.com/Linaro/linux-kernel-uadk/tree/6.12-wip
https://github.com/Linaro/qemu/tree/6.12-wip

Still need this hack
https://github.com/Linaro/linux-kernel-uadk/commit/eaa194d954112cad4da7852e29343e546baf8683

One is adding iommu_dev_enable/disable_feature IOMMU_DEV_FEAT_SVA,
which you have patchset before.
The other is to temporarily ignore S2FWB or CANWBS.

Thanks

