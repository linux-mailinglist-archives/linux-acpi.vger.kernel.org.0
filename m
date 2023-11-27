Return-Path: <linux-acpi+bounces-1840-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D3557FAD78
	for <lists+linux-acpi@lfdr.de>; Mon, 27 Nov 2023 23:32:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD768B20FBB
	for <lists+linux-acpi@lfdr.de>; Mon, 27 Nov 2023 22:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F42B3C46F
	for <lists+linux-acpi@lfdr.de>; Mon, 27 Nov 2023 22:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5F2E131;
	Mon, 27 Nov 2023 13:41:14 -0800 (PST)
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-1f9efd5303cso2476927fac.0;
        Mon, 27 Nov 2023 13:41:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701121274; x=1701726074;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pI2M+j6ioFcb4GQHCuGwFJdfm9icuD7b8LXD5YDuNJg=;
        b=ruXGmity9u8iNcq4s2Fu+4PczWS3t5PJZVDV3xTRDH0MgCl7uv0HrVSMsnTD/C+att
         oo8t8/esSu0wfJ965ibKeFcNrjPbc/qDOwyNNO9uoeDEa2wAWbRYRzwliw5G1kyYswnk
         dA69puYXQ3OgH7hBvK/vv3nsrWvgw0EvjVM62b/JkXF4k/zN+nTwY24jFZgQuNH8TLDi
         HBZktOK+ZKb+arjd91eRp7c6p4h46fUi3nTChoUMd8YLrddtZ8PFb0ec+WYxci55jMNc
         ej7t6TDX+0O5ERiUB61wg3MaXkK3xsMYGbcRHFNonFPEbJOZZjyRcNrFh3JzKMmbPtZy
         zPMg==
X-Gm-Message-State: AOJu0YzI3OQarTFcBlLgjfge5w3HanntNUNIWouJKZDSj9WJdIIL+Qq+
	BULaP3EPN7EFDlSHV+U19A==
X-Google-Smtp-Source: AGHT+IGFvSz34MKUy/WxsVB8cBQNpehhrzjKecPe0agYQUZpudaSX6ZWR8xRNmcDqWBXrxt6W+KwRA==
X-Received: by 2002:a05:6870:e0cb:b0:1f9:385a:f6ef with SMTP id a11-20020a056870e0cb00b001f9385af6efmr14434582oab.19.1701121274068;
        Mon, 27 Nov 2023 13:41:14 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id mm23-20020a056871729700b001eaf486140asm2190758oac.28.2023.11.27.13.41.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 13:41:13 -0800 (PST)
Received: (nullmailer pid 3795972 invoked by uid 1000);
	Mon, 27 Nov 2023 21:41:12 -0000
Date: Mon, 27 Nov 2023 15:41:12 -0600
From: Rob Herring <robh@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, frowand.list@gmail.com, james.quinlan@broadcom.com, m.szyprowski@samsung.com, hch@lst.de, devicetree@vger.kernel.org, lenb@kernel.org, robh+dt@kernel.org, rafael@kernel.org, iommu@lists.linux.dev
Subject: Re: [PATCH] dma-mapping: Don't store redundant offsets
Message-ID: <170112126999.3795360.2028083328309296729.robh@kernel.org>
References: <94e0cec15546ef2be61d90869e499e40e2a55308.1700849106.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94e0cec15546ef2be61d90869e499e40e2a55308.1700849106.git.robin.murphy@arm.com>


On Fri, 24 Nov 2023 18:10:03 +0000, Robin Murphy wrote:
> A bus_dma_region necessarily stores both CPU and DMA base addresses for
> a range, so there's no need to also store the difference between them.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/acpi/scan.c        |  1 -
>  drivers/of/address.c       |  1 -
>  include/linux/dma-direct.h | 19 ++++++++++++-------
>  kernel/dma/direct.c        |  1 -
>  4 files changed, 12 insertions(+), 10 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>


