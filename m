Return-Path: <linux-acpi+bounces-4204-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B07ED876BED
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Mar 2024 21:37:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E219A1C218AD
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Mar 2024 20:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0091F5D900;
	Fri,  8 Mar 2024 20:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="SzrPtdCt"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7122B1D52D
	for <linux-acpi@vger.kernel.org>; Fri,  8 Mar 2024 20:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709930260; cv=none; b=Ay2PlOYeIxeFuZlEPvK4laekH1ynUXb/Zzi8yWhESEZudhGWU3vArvtDi9yvrj6R4BspTTCBpq0Ti8j4o+zugZIu9W0y8Kjcjtxr0DjDdXq0sFJttUMpS6RDnaAJOhXG+/zzxN4WBo5j2utBmd0eK7pclfP7HDN5luDX/GIZO9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709930260; c=relaxed/simple;
	bh=QVuJYBg7eAXpV6Ijtmm49xelHY48E81cS9xdFZ2y8ww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oLuRbDJwT58YmY+/NcT0DiOOmV16Noo6cvMY/+YD8uB7EWqKimRuqAcrl7JEGTBMbIF6laLqq9QSjxOcoS1Ur+cp2QoDhkpeCN5ajinI2vG51Iemx9Xtoy06QlrlCNfWVpvsrl4kaC5f2pkWORhdrL9VTNvYThE34VWtHqY2U30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=SzrPtdCt; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6e4eaa4b394so1145351a34.1
        for <linux-acpi@vger.kernel.org>; Fri, 08 Mar 2024 12:37:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1709930258; x=1710535058; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8AtBhhUJsX7iCjuz60QlnI9oeTh8ox4hiuWAL+2qFxI=;
        b=SzrPtdCtETYaH+fXoFNcVZ674Y60rUoV24SHjrWWDyPuffz3hHq4no4/0zSaV3YAOd
         3pITU2krQ+XDZV8KTm8DbbDUxfHgTrcSBp72H+2XuUj2wSERwR6Oq5tIbH84/e8violY
         XBkz2lEi58aCBxCQXU+EnRkfJyyex8DnTmOfPlrkwUAUEBulOTXwb4wB6svmuAjMCBrv
         vNqwD49cXpsvWh6R50V+4fN8EusTzt9GcGUyuuTKPnJDEHlTeqpvynw0A/KxKFND/6gd
         PScL6wYo2bwUE7ZOCdsUUCPHc/JvD2GTo+8RU/G8n2zK0OU/XMH7/nnXo0bRNxpOXj3g
         mn9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709930258; x=1710535058;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8AtBhhUJsX7iCjuz60QlnI9oeTh8ox4hiuWAL+2qFxI=;
        b=UCyBF7zde1ubBHQgRDhnN0cj6Tq358itIvv+FSgTLFafChAXJgV4rDDwkTmvyrju43
         +WG+x3fivCoBZmr5z7xIWKd7B3+gzUH23FDN0R3EstsGYdW1532tbS/WTZPNne0UDvGC
         22md83rVcMhXftohTHSj2MnX0ZvEJbCHtDCqYsX6928JxKv+4ifuautDpQQ47ZoNiD2m
         kGVFxspfaBcWh9wqWXDDIYhnKHtWJvOqWWMp483GQeVrRfYvCIhma16xA9AGshOwKJ/H
         1/pOjkHmMzSQ3LTn/oIAEszO0tv6MVMlxHVkcqMYnwzm699/Lv37UMo5Bb+gCN2v1fLp
         7VIw==
X-Forwarded-Encrypted: i=1; AJvYcCW/lQfwXrgFl7JT64Wd2mLXUWO1ddvcVX5C5FOvOCjAb7e/FFMZtY8zc7Yx9yd6TR8n1yNJXE6NUG9BfC0rSNR3kyiJ1nxB1OKn2g==
X-Gm-Message-State: AOJu0Yzul5hSuXH4iWYF0MpJEYG0BJMMh8dPwcxAbjffNLh3vzwyuf5A
	QBslEqePsrDaWfDBjzK2eEZ29IWuYbElH0Yq+aO+nYb1LuQs9nMLdKJsvYKkDyo=
X-Google-Smtp-Source: AGHT+IFbgpl0pB6g2XaoyrWZZStUAXJBL7gQEaHjPXP/ruZgANeVKSb/3hxLcl0YhzvyQSM42+vm+A==
X-Received: by 2002:a05:6870:7a0d:b0:21f:ab17:44c3 with SMTP id hf13-20020a0568707a0d00b0021fab1744c3mr272908oab.24.1709930258434;
        Fri, 08 Mar 2024 12:37:38 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id gu19-20020a056870ab1300b0022154dd4eb0sm47251oab.4.2024.03.08.12.37.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 12:37:38 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rigyH-007y3a-Aw;
	Fri, 08 Mar 2024 16:37:37 -0400
Date: Fri, 8 Mar 2024 16:37:37 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Vineet Gupta <vgupta@kernel.org>, Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-acpi@vger.kernel.org, iommu@lists.linux.dev,
	devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v3 7/7] dma-mapping: Simplify arch_setup_dma_ops()
Message-ID: <20240308203737.GB9225@ziepe.ca>
References: <cover.1707493264.git.robin.murphy@arm.com>
 <f0ea76846c89a65dfe42933d78d770004bb3de01.1707493264.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0ea76846c89a65dfe42933d78d770004bb3de01.1707493264.git.robin.murphy@arm.com>

On Fri, Feb 09, 2024 at 04:50:04PM +0000, Robin Murphy wrote:
> The dma_base, size and iommu arguments are only used by ARM, and can
> now easily be deduced from the device itself, so there's no need to pass
> them through the callchain as well.
> 
> Acked-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
> v2: Make sure the ARM changes actually build (oops...)
> ---
>  arch/arc/mm/dma.c               |  3 +--
>  arch/arm/mm/dma-mapping-nommu.c |  3 +--
>  arch/arm/mm/dma-mapping.c       | 16 +++++++++-------
>  arch/arm64/mm/dma-mapping.c     |  3 +--
>  arch/mips/mm/dma-noncoherent.c  |  3 +--
>  arch/riscv/mm/dma-noncoherent.c |  3 +--
>  drivers/acpi/scan.c             |  7 +------
>  drivers/hv/hv_common.c          |  6 +-----
>  drivers/of/device.c             |  4 +---
>  include/linux/dma-map-ops.h     |  6 ++----
>  10 files changed, 19 insertions(+), 35 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

