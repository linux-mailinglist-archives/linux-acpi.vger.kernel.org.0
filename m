Return-Path: <linux-acpi+bounces-5307-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E13A88AE915
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Apr 2024 16:07:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EE521C21CE1
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Apr 2024 14:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17849137900;
	Tue, 23 Apr 2024 14:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pxI8wOD4"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874C880040
	for <linux-acpi@vger.kernel.org>; Tue, 23 Apr 2024 14:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713881276; cv=none; b=uTI+IO8TuBaEyFlhSXSllu66+Jazznhow79Q/ZCBApY4bqR/n70pzCiCZOif+6Xa4om77mPMZ7m3ALAmV4xUWmSxB8gbbHOjK9OXcVDMyO+a35dMdNV/MCUuRVWzZkIATzoWIg0G7avSpXLmiQvo0QGe1UAAddMddh6dvF4oyJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713881276; c=relaxed/simple;
	bh=SCCRcYBSUWi6YZAeBOgGaAFk9sSP20YVxD8KQauNigo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gz7LkWZHfmi1x3zXrn0sxJn/tZhnQ3VhdhI1caKcjKNs+mf/diAZD2YyfH5JiXZ/13tM01V55Sy5zkMHonw+nqd8gLx8UNN2pk/lsKGReHSXh8ddxgI5f+yj0ZaoocRVipT6AYWoj1h+iDqWphNLDFZKzqjAX6yZbHZ9tliQn8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pxI8wOD4; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4196c62bb4eso30303235e9.2
        for <linux-acpi@vger.kernel.org>; Tue, 23 Apr 2024 07:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713881271; x=1714486071; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ivZL1KMf5HVtw/Oo+a4INAZ/yDs5tBPuPTBsYEgRcbc=;
        b=pxI8wOD4CgCSFvS/2oXD5Wa0VC2b9Z+SImYYKaDd4Hkat8Zs98WqkstnCJjYktLCBF
         Xzyt9HF6RpvmJFNIrIJ9x9s5YQQl+R+LoQFRbfmu4SbP9zAJuZo5393mF+H2cvsF2W9D
         0/pvcFO/ucwlqPdAiiE5SzsPoqI0VsPJeGbjklVxjFV3r+Jmp01+T9JkMw1mH0SkNr72
         nvgbX2sN7+pRa+Mqc8m1ecW9o1Yu9NKCHHYqrHavsqjwnI/Hz/45bwqyhxVLediTwt+s
         F1vHN4pNOVWD1TaeBUeW8/8Yiw86g++tjKrkxAtn8yo6Jepf7gzjdQWgC1/RNCJ+BwAR
         4asg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713881271; x=1714486071;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ivZL1KMf5HVtw/Oo+a4INAZ/yDs5tBPuPTBsYEgRcbc=;
        b=Ie33X9AkS3G9L2Z8diBGlKLPX4ZJ8H9P0WhHNVfYXq1z+70oxMiyJW/+6qmiorw6E+
         e8XrxvpPnqmUGwNPZOPtVNNzmd6i3V6yYrbS9+n+59G8e3ONd9WDlMbcFL1WcTnBuh1x
         yVAR2FfzEVmNxtT2sMGwdm099ZFiX37s35N+w3gjnDBbOIqJIrSyeWWufQRUBO7ZbA8i
         GeCbdZ8ymHAPd3t9GufUmgq5a1hANDBBf2lqZH7VyNFeVvVv3SC+VD94TVtOOphdUGJk
         dl2H/rR+VzTX+qyKor4kp7IfA6XeD+SHkeQIuV8lsDRzZVjmrY+yYVsw+rFbrfVprLR6
         9GWg==
X-Forwarded-Encrypted: i=1; AJvYcCX3HdsWDj1akYYoyHzPzH5CAinghFTM17CLIVOANUFwesOhTFt2BAKvdoyzsXg7hci93s6v9N3+NCEN6Y8rnC5QM5+V61l3nbAqzw==
X-Gm-Message-State: AOJu0Yzn2X3eTC3gcE7bNUOuTvQT2vVHTn6IKoX1MykC7GQ66/0jFDlN
	PnIWQaVfPKNzgP0IpU5QSc1lVLGiJfW8mOXM7XmS3Pp6gDWVJIuYVwSaliZZLGE=
X-Google-Smtp-Source: AGHT+IEIwm2tVBxncnsuTwhWGS/GtsX0X8yGwreFbsWOjkFsI91R+e9ti269gvGnFYpY+RoCeixbxQ==
X-Received: by 2002:a05:600c:1e1b:b0:41a:7370:85ab with SMTP id ay27-20020a05600c1e1b00b0041a737085abmr4113391wmb.33.1713881270854;
        Tue, 23 Apr 2024 07:07:50 -0700 (PDT)
Received: from myrica ([2.221.137.100])
        by smtp.gmail.com with ESMTPSA id o3-20020a05600c4fc300b00418f7605249sm18226069wmq.24.2024.04.23.07.07.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 07:07:50 -0700 (PDT)
Date: Tue, 23 Apr 2024 15:08:03 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 0/4] iommu: Remove iommu_fwspec ops
Message-ID: <20240423140803.GA931103@myrica>
References: <cover.1713523251.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1713523251.git.robin.murphy@arm.com>

On Fri, Apr 19, 2024 at 05:55:58PM +0100, Robin Murphy wrote:
> Hi All,
> 
> Building on top of the arch_setup_dma_ops() cleanup[1], the next step
> down the chain is {acpi,of}_dma_configure()... There's plenty to do
> here, but it may as well start with this fairly self-contained little
> cleanup, pruning yet more redundancy and exposed API surface.

Tested with QEMU: SMMUv3 DT/IORT, virtio-iommu builtin/module DT/VIOT arm64/x86

Tested-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

> 
> Thanks,
> Robin.
> 
> [1] https://lore.kernel.org/linux-iommu/cover.1713523152.git.robin.murphy@arm.com
> 
> 
> Robin Murphy (4):
>   iommu: Resolve fwspec ops automatically
>   ACPI: Retire acpi_iommu_fwspec_ops()
>   OF: Simplify of_iommu_configure()
>   iommu: Remove iommu_fwspec ops
> 
>  drivers/acpi/arm64/iort.c             | 19 +++-------
>  drivers/acpi/scan.c                   | 38 +++++---------------
>  drivers/acpi/viot.c                   | 11 ++----
>  drivers/iommu/arm/arm-smmu/arm-smmu.c |  3 +-
>  drivers/iommu/iommu-priv.h            |  7 ++++
>  drivers/iommu/iommu.c                 | 20 +++++------
>  drivers/iommu/mtk_iommu_v1.c          |  2 +-
>  drivers/iommu/of_iommu.c              | 50 ++++++++++-----------------
>  drivers/iommu/tegra-smmu.c            |  2 +-
>  drivers/of/device.c                   | 30 ++++++----------
>  include/acpi/acpi_bus.h               |  3 +-
>  include/linux/iommu.h                 | 15 ++------
>  12 files changed, 66 insertions(+), 134 deletions(-)
> 
> -- 
> 2.39.2.101.g768bb238c484.dirty
> 

