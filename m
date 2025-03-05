Return-Path: <linux-acpi+bounces-11860-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F260A5077E
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Mar 2025 18:58:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0E097A88CC
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Mar 2025 17:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25E17252908;
	Wed,  5 Mar 2025 17:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="momoyEWA"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538F12505B8
	for <linux-acpi@vger.kernel.org>; Wed,  5 Mar 2025 17:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741197362; cv=none; b=TZVZqVib+PG+zpYSTOtVbElCjXkhPRncHOvXkgJyaP4KoVnK8/w15LOR1uWm3GyuO4dYPnAOX06JRDtu55zWe1ow8QQKyXNd3SaWGthXWeIPpThIgcSpUi3sxyhgOqxuoc+TUHvOwABK6ft70/nl89TOWAWFDqu3OiHJA1g9kCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741197362; c=relaxed/simple;
	bh=TUPQEmrW/zlDUggHE/0eBZQD2cfbqcK2BAfpEugKfy8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jncqpNYrL/yIlGLGO7Vnt3+2GvmBidDdfKhcF88pj9A8g7CPqgcs9eGBUM314AgXLWDRaTfuDaCKASbHf+mdMJgYORDwMJrWdHhZh8R068mvA/i8EDe+wuJJj1jZbaxDWUl0xRxL2m6tmO+EwSpGN7Xe8MHusNiw9mVv+P6tESc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=momoyEWA; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7c07cd527e4so628138785a.3
        for <linux-acpi@vger.kernel.org>; Wed, 05 Mar 2025 09:56:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1741197359; x=1741802159; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+ep2jN4skgI+D4W4EsgQGzXEpA82GjT/riHpbC+3iOM=;
        b=momoyEWA1uwQT59ACHn6cPhBRRVwjCvd/D00IEUvD8ULjOMXySHCDWYSd9z/yVOTMP
         oG72CN7BnrQDpgYVlsHG0Jk0KQ0ebSPSiZB+FvOfdsC8qp6VTSdRbLDJCLhzWYuEJWoY
         2v35NyfYxdrK6EhI2eMjixmCg9uDh2DK9oxX0DBSIRxRtrFjHa9wswQhnptQmQT5vFEn
         wkFkKfiMZC2jn4QuMDnwRR5W8l4QvBbu+QJy+zS1//D3zixL63YMPiiBu52Ouv9b7e2P
         YtGXgKlQkiD3mJSNouR4nXhhezVNvS1oFPZxtDA5kc7MPbYTSVD9fAQgdoH7z2hklJEe
         689g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741197359; x=1741802159;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+ep2jN4skgI+D4W4EsgQGzXEpA82GjT/riHpbC+3iOM=;
        b=BHSU8OTOXneFggLp9YkZvcdWaFHsjAlI4E6xTQp54aIiM1Mn9XmK+Auvzt4oSKlbO6
         YeLIV907LJaNRhd2V4RY2vlQQOp56uZQcszlidv13EB1owI7Tm2J7lFjvg9Ki+albe1o
         n/p4wY36Mkodew046uifz3G/VRIHvUGkQliqTBLSZVuYUpplCh+bKM8MA3076T5ZxK0d
         SfsCfUYnma86mSeH/fZkSbOVcC2yz7IagmJ1LqA6oKB4PuA1sAWivt9Z0nea5KOyQ95e
         w+BInnUuEnXf4n2iwaBIdt5xcZvwJ1SivsM/byxbQfhI/YGva1PRLWdsnrYLiUAnEgrC
         Zh0g==
X-Forwarded-Encrypted: i=1; AJvYcCU4FtjL+C6oRbhGD4D8w/6k4VKpSLLO2wrF/LJyZX4ZQlyn2Q4P8lCjfDpoE+JlUv/Ytj80EmFjOAVP@vger.kernel.org
X-Gm-Message-State: AOJu0YzUYkG/k+0QmxL1r1jgBRl6EEvSD5upt4qW9rRNOQ9gKuRVllGi
	nB4i3VnKepYyLaQ7NIyCHl8EApxohssf81yc2sZRX59F0YuQDqbKU0UtfkZOdow=
X-Gm-Gg: ASbGnctsZ3LvuTTDzqARSyXCi15r6DWgnOP5JWnWaQiEVbTFylEmdXgPGV+RzC02M2/
	79mcVKFwsWQ+jETTToDF2GWDI9w/FHPOb3ktkuceNjoFNyGHCW0mLO5ecqLX3UEPrELNcjzRoxG
	5ryWK23FsuYSOOt1EC4JSoBp8sPJKU/gOvd7n6tg2Sicueo5eux9LWGQLNJRduZIXCsdP2te/4D
	myB6f45Gn8jW3ZaWLvuXVlF5rVbGg9NwkISvs96xT6xZGdFxjrEN9vhWFqVZnBIqWV9pq7oT/Pe
	VBPHL80nF0CKm+XVs00=
X-Google-Smtp-Source: AGHT+IE075gQ9paRBr5FJqePHxLiGeTWllaX8jx4kAg32gkUcqpKhkxzc9FKZ5jSjzoHlrJkCTJ+cQ==
X-Received: by 2002:a05:620a:8908:b0:7c3:cbad:5729 with SMTP id af79cd13be357-7c3d8e7ae8cmr768466685a.25.1741197359262;
        Wed, 05 Mar 2025 09:55:59 -0800 (PST)
Received: from ziepe.ca ([130.41.10.206])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c3b4c9e120sm486128485a.11.2025.03.05.09.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 09:55:58 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tpsyL-00000001TVM-2YSq;
	Wed, 05 Mar 2025 13:55:57 -0400
Date: Wed, 5 Mar 2025 13:55:57 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Russell King <linux@armlinux.org.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Stuart Yoder <stuyoder@gmail.com>,
	Laurentiu Tudor <laurentiu.tudor@nxp.com>,
	Nipun Gupta <nipun.gupta@amd.com>,
	Nikhil Agarwal <nikhil.agarwal@amd.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Charan Teja Kalla <quic_charante@quicinc.com>
Subject: Re: [PATCH v2 2/4] iommu: Resolve ops in iommu_init_device()
Message-ID: <20250305175557.GI5011@ziepe.ca>
References: <cover.1740753261.git.robin.murphy@arm.com>
 <fa4b6cfc67a352488b7f4e0b736008307ce9ac2e.1740753261.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa4b6cfc67a352488b7f4e0b736008307ce9ac2e.1740753261.git.robin.murphy@arm.com>

On Fri, Feb 28, 2025 at 03:46:31PM +0000, Robin Murphy wrote:
> Since iommu_init_device() was factored out, it is in fact the only
> consumer of the ops which __iommu_probe_device() is resolving, so let it
> do that itself rather than passing them in. This also puts the ops
> lookup at a more logical point relative to the rest of the flow through
> __iommu_probe_device().
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
> 
> v2: New
> 
>  drivers/iommu/iommu.c | 30 ++++++++++++++++--------------
>  1 file changed, 16 insertions(+), 14 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

