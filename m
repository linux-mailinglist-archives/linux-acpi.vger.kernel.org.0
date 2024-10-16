Return-Path: <linux-acpi+bounces-8807-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B0C199FEBD
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Oct 2024 04:24:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC54A1C22BC2
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Oct 2024 02:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DCEB158522;
	Wed, 16 Oct 2024 02:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a8Keb95B"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5DF13B2A9
	for <linux-acpi@vger.kernel.org>; Wed, 16 Oct 2024 02:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729045444; cv=none; b=DroJtr24nAuptY2g/i7pl76qPX+ljVcyx6zGSinGyt33lczuWjBE2l4fgH0Z7aekNET5WCg/0U7EAmgJiHDfQZ+ehKZdyVqnCKG6V8YQfkug4Q0kgSiNAqAAK46m52tt+1HYlOWKeKxuR3x3ZJlcxk6z+kd/mEi2YT1vywc8qw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729045444; c=relaxed/simple;
	bh=+GF1oCaa4XIdm2rCPBWvV+uTROdOd1KyxDhkbhawAvc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OeCO0FH3KwngCS4fK8StQ9qizt400EoxiQng93gfu7mlBvxaM+N7R5BL3/ZQrB61o9992Z/11Tz564/iw3L2s8RMgX+I3CfGBFaK/p5Ur5V/I/rcl9v6m4Lo/prsY64WITJMi63NtryK81q7N+CfG75ciAtJGroVHeQEKaTYC/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=a8Keb95B; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-539e59dadebso4813986e87.0
        for <linux-acpi@vger.kernel.org>; Tue, 15 Oct 2024 19:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729045441; x=1729650241; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qiWvrpKzeq83YnQqOE7ISPaRFxYtddrp60dv+zolb9U=;
        b=a8Keb95BB4+H22P3VAxGwn4pWfLSxCEJgdY1R6qATrJ3lUJKy8dPuet6llakvjkc8m
         xBdQTDau1nLF5+AflGAXSt9syeQl517ZcP36pwmz0ERuJgVdTUgneBEoV+IN8RrDG98r
         aGVJ1oteGbLIwFepCpviquLf4C8/rD3YaGt2wgtf/ayxBQ/OejHZWnlVRbloKQ4CzVMe
         VrwKlHpjRaMBbEsSx9evxozYix492Sa4C0bdBEESjCwFxQjrd2/71SROuJVDvul7DtVT
         CYsliKRfh8v9urSYEg4jiw4SvyFV7ekWKCfdYZv9huY1JuP0lITHGBY7fYuO6Zpbo5zS
         URIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729045441; x=1729650241;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qiWvrpKzeq83YnQqOE7ISPaRFxYtddrp60dv+zolb9U=;
        b=sK3Tdfj7KLQW1p8cVgV+EE1NZyyOyPbgjrMcH8+X44diPtAXpAfUBzBNAGgcPpca3d
         gyj43y6rKbjEGYIK/00goW4T9GeGCkDeKsIymFtQrf3ddrnMq7Bm58bI6G2nZT+NWnT/
         8AZhAJ1oN9W56sAT0uPbrslPshrZgxtn+R3bMe+MpjJN1bCkmq4NjHD0EdER/3odb9R3
         ZseRAH1/RmHPNk+gSbi/j7Hut/zshYSG1QnZCQPUt4eej6WM9rznXSukmwbW77eMj62j
         pL3L3AGuRJ0QtxjyymSodlMyVGFIhrOv2F/luKVZ6MmSPnA9YLtRbbiy/9qbkcr7LFXm
         HrHg==
X-Forwarded-Encrypted: i=1; AJvYcCVR6+7xgrqxWmcNyLbHNnAUJ2ea9hqE07K9dUD8X8ru19cMiuNhJFOx1rR/0WSlbybOMvpROD19Frc2@vger.kernel.org
X-Gm-Message-State: AOJu0YwWSIwgSKzzysEk8iUhjaHzHJYLswOZ1OKwkvAqHc5sJ3q6NO/h
	xbBdTfXl8XxlP3P1MgLACR1sHt4rFtbAr8tGKA2w8KjQv19Ae5me58/CVDS2tCeHHjzr782UIPl
	yIYyRAVL7m23hu+9P2gfIrqVWgXGGvhpzM/dV4g==
X-Google-Smtp-Source: AGHT+IEV/byr5lu2UsUC2RRVM2gDVA1eLiMxNLS7gT854PVdY6PhxgM/HLAZnNXx36HxSizxkKPg933nd9PyJjzpqHw=
X-Received: by 2002:a05:6512:3094:b0:539:da76:c77e with SMTP id
 2adb3069b0e04-53a03f045ecmr1718387e87.5.1729045440632; Tue, 15 Oct 2024
 19:24:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0-v2-621370057090+91fec-smmuv3_nesting_jgg@nvidia.com>
In-Reply-To: <0-v2-621370057090+91fec-smmuv3_nesting_jgg@nvidia.com>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Wed, 16 Oct 2024 10:23:49 +0800
Message-ID: <CABQgh9E32c5inrn=Q5HWThuJQ4xV=EFWLGwbyxVLHQVUZ_uYCA@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] Initial support for SMMUv3 nested translation
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: acpica-devel@lists.linux.dev, Hanjun Guo <guohanjun@huawei.com>, 
	iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>, Kevin Tian <kevin.tian@intel.com>, 
	kvm@vger.kernel.org, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Robert Moore <robert.moore@intel.com>, Robin Murphy <robin.murphy@arm.com>, 
	Sudeep Holla <sudeep.holla@arm.com>, Will Deacon <will@kernel.org>, 
	Alex Williamson <alex.williamson@redhat.com>, Eric Auger <eric.auger@redhat.com>, 
	Jean-Philippe Brucker <jean-philippe@linaro.org>, Moritz Fischer <mdf@kernel.org>, 
	Michael Shavit <mshavit@google.com>, Nicolin Chen <nicolinc@nvidia.com>, patches@lists.linux.dev, 
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"

Hi, Jason

On Tue, 27 Aug 2024 at 23:51, Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> This brings support for the IOMMFD ioctls:
>
>  - IOMMU_GET_HW_INFO
>  - IOMMU_HWPT_ALLOC_NEST_PARENT
>  - IOMMU_DOMAIN_NESTED
>  - ops->enforce_cache_coherency()
>
> This is quite straightforward as the nested STE can just be built in the
> special NESTED domain op and fed through the generic update machinery.
>
> The design allows the user provided STE fragment to control several
> aspects of the translation, including putting the STE into a "virtual
> bypass" or a aborting state. This duplicates functionality available by
> other means, but it allows trivially preserving the VMID in the STE as we
> eventually move towards the VIOMMU owning the VMID.
>
> Nesting support requires the system to either support S2FWB or the
> stronger CANWBS ACPI flag. This is to ensure the VM cannot bypass the
> cache and view incoherent data, currently VFIO lacks any cache flushing
> that would make this safe.

What if the system does not support S2FWB or CANWBS, any workaround to
passthrough?
Currently I am testing nesting by ignoring this check.

Thanks

