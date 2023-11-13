Return-Path: <linux-acpi+bounces-1461-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F697EA4E1
	for <lists+linux-acpi@lfdr.de>; Mon, 13 Nov 2023 21:33:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FB511F226FA
	for <lists+linux-acpi@lfdr.de>; Mon, 13 Nov 2023 20:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8ED3250F2
	for <lists+linux-acpi@lfdr.de>; Mon, 13 Nov 2023 20:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="flqyw7pV"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFFDF249F5
	for <linux-acpi@vger.kernel.org>; Mon, 13 Nov 2023 20:19:02 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9C06D75
	for <linux-acpi@vger.kernel.org>; Mon, 13 Nov 2023 12:19:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699906740;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sqWGwV812/CXYndzj2W50PA7KOMPm+tHC+e+xjD2/M0=;
	b=flqyw7pVz6uNBBQQ2S5tLqgyHjs2xVfzD4uhNah7b6k0rwqfXW/Qi9sCL55QOV4Wp5Dm8n
	eC4UMRKE8dWDd74dRqpwbiqZVcslr/Cs3azqQ/hVSaHOxnqmc6Y4UcqeZIn+q9W/gJCYrR
	+oqy7dRR/Lu7VzKLnZ/Z61Zud3J2W5I=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-47MDfDGnOXCTNwqQZIb9Uw-1; Mon, 13 Nov 2023 15:18:59 -0500
X-MC-Unique: 47MDfDGnOXCTNwqQZIb9Uw-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-41e58a33efaso58097421cf.2
        for <linux-acpi@vger.kernel.org>; Mon, 13 Nov 2023 12:18:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699906739; x=1700511539;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sqWGwV812/CXYndzj2W50PA7KOMPm+tHC+e+xjD2/M0=;
        b=a0mHSJ0m4QvF5fAdZ9UHfTM44aRKMklxntV/mbdwGIk6Qjr41bSYDgcCNKxKuDdSx7
         jVIwsXAAsp/SzkXtn+6mipuD0MPhACsH2AvlYZVPsSzh2XMfNIcrkIcbj4KQEkTlBbwI
         4gAxkjnJxNv0hGaEo2cVBXXsVterJtf5J8b/fVGhUOU+dNFLeIrzuiEosj4czqVbH39t
         pteDrEA9vK+fVxs4bfghurzxphBXODXkcsA2L48+/SadGmlVtS/PSBySBrxsuHbk01IZ
         iFvzWKqYBlSE2DJ7M5Yo/+qn3+9EDw3NT8ENBlqq69PeunSmAcMeegahSFR52wAEl2Av
         v5tw==
X-Gm-Message-State: AOJu0YyVEqZBDyBytlGdQNvsD47aApXseVNzjzoTgwStNCjRItW4/crc
	HZVcKoenq8RMOkIPmZBp+5Hbixu/PssvczhK/bfGNmBYhFoQOyEcsLtQqgzCQp54j21549CQlJF
	Zest6a5rCH4UKx+YiEsRpeg==
X-Received: by 2002:a05:622a:1908:b0:41c:b6cf:a49e with SMTP id w8-20020a05622a190800b0041cb6cfa49emr292149qtc.10.1699906739317;
        Mon, 13 Nov 2023 12:18:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGJ4aN/cKUvDweqjuNq1K11+iEyXGsjit6950JrTQD9aZT2d8xoiBctpmKNKw2vmVX7XqpdQA==
X-Received: by 2002:a05:622a:1908:b0:41c:b6cf:a49e with SMTP id w8-20020a05622a190800b0041cb6cfa49emr292104qtc.10.1699906739106;
        Mon, 13 Nov 2023 12:18:59 -0800 (PST)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id j5-20020ac84f85000000b00405502aaf76sm2177375qtw.57.2023.11.13.12.18.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 12:18:58 -0800 (PST)
Date: Mon, 13 Nov 2023 13:18:57 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: acpica-devel@lists.linuxfoundation.org, 
	Alyssa Rosenzweig <alyssa@rosenzweig.io>, Albert Ou <aou@eecs.berkeley.edu>, asahi@lists.linux.dev, 
	Lu Baolu <baolu.lu@linux.intel.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Dexuan Cui <decui@microsoft.com>, devicetree@vger.kernel.org, 
	David Woodhouse <dwmw2@infradead.org>, Frank Rowand <frowand.list@gmail.com>, 
	Hanjun Guo <guohanjun@huawei.com>, Haiyang Zhang <haiyangz@microsoft.com>, 
	Christoph Hellwig <hch@lst.de>, iommu@lists.linux.dev, 
	Jean-Philippe Brucker <jean-philippe@linaro.org>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Joerg Roedel <joro@8bytes.org>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-hyperv@vger.kernel.org, linux-mips@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-snps-arc@lists.infradead.org, linux-tegra@vger.kernel.org, 
	Russell King <linux@armlinux.org.uk>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Hector Martin <marcan@marcan.st>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Robert Moore <robert.moore@intel.com>, 
	Rob Herring <robh+dt@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Sudeep Holla <sudeep.holla@arm.com>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, 
	Sven Peter <sven@svenpeter.dev>, Thierry Reding <thierry.reding@gmail.com>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Krishna Reddy <vdumpa@nvidia.com>, 
	Vineet Gupta <vgupta@kernel.org>, virtualization@lists.linux-foundation.org, 
	Wei Liu <wei.liu@kernel.org>, Will Deacon <will@kernel.org>, 
	Zhenhua Huang <quic_zhenhuah@quicinc.com>
Subject: Re: [PATCH RFC 14/17] iommu: Remove pointless iommu_fwspec_free()
Message-ID: <22mlpmrdftubxzr46qci26p3aqojvv5p4ffroshlzubtwcw5cr@jwcl5scuttdi>
References: <0-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
 <14-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>


