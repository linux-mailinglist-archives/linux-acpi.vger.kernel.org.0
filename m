Return-Path: <linux-acpi+bounces-2495-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5353815F2A
	for <lists+linux-acpi@lfdr.de>; Sun, 17 Dec 2023 14:07:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B16E1F21EF2
	for <lists+linux-acpi@lfdr.de>; Sun, 17 Dec 2023 13:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F198F44364;
	Sun, 17 Dec 2023 13:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="MfPHfxSX"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591FB42ABB
	for <linux-acpi@vger.kernel.org>; Sun, 17 Dec 2023 13:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-77f552d4179so172978685a.1
        for <linux-acpi@vger.kernel.org>; Sun, 17 Dec 2023 05:06:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1702818413; x=1703423213; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KImPZocudnA0Xid9bPae7bvgNXTlGpXerlYRqfFZmS0=;
        b=MfPHfxSXkor6ksyXCZguDaP3qwObFWL6B7+wc6rlY1NZWv0fWhwi1atdEEPevaQr10
         EFq3D5aJYsnu1kqQ+SDxYhJN5lUtpSMeXffTI5KTgDacoxKi6KXhI+FSLB6zum9BiWwg
         RU+XRgwEyIgzGp5xz6MbBYaLq//fa/AFCfRn2nnwCvFvFvont9210vGskSXLTFcgwcul
         fuCzyz9ZnT0fE37m2zlEzswqlvXJt+GngC9O7H5GrxK+f1UHcbokfSwb04fy7AYRXmGx
         mWsVqWU1eM/Gg+ECLTAjaW/wcQ7V8GJYJ9qOyCSVyUUuEWJFARyXfGBCPIoYcXzaQ+qI
         GB6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702818413; x=1703423213;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KImPZocudnA0Xid9bPae7bvgNXTlGpXerlYRqfFZmS0=;
        b=LXN7zXp2XM19h2amz6zGyN7w/L+8CGxKMTU6jKi8fHWn1Kvu8HdFZjgkd5+yFuuaGH
         73KbH5WTUwOy6GIHmZ7qIjvhqIIGy+4HOMKRl51/lBfW3HxPWhvDYPekhH3hIYJ2X6J5
         yihYLzfe+ElViJrKUNh9KYWvParMOjkkBxdtzpVvM6K/LF0PdiNGlugWXQqepmHeGFWh
         gB2GW9KbkZV1XI7IKhZ210fAgM2Ds5wUPrgRS3s/sOo187CFfY1xdAyQwmixhRhjUzgt
         KsfdDmiiBhsrl2au4xCBVUKfj79xHtkFI7Z9LOtgMYZnVRs8K4MVVDQ1LBAnr/t3RWIT
         ihhg==
X-Gm-Message-State: AOJu0YxlH8Ef9uyfccHK/5BO8UIQs5GEiZK9vHptDS2llbryXLNajMu0
	fg6CFQftRmbWa1qP4IZmpgQCUQ==
X-Google-Smtp-Source: AGHT+IHTVjfMN59xpIf4XTLv2Tg1BapJF9ANCTlx2a8wYFY7k8a4DvzAyzksTBDM70stjssrCc4n+g==
X-Received: by 2002:a05:620a:24c2:b0:77f:849f:72a5 with SMTP id m2-20020a05620a24c200b0077f849f72a5mr12897578qkn.94.1702818413199;
        Sun, 17 Dec 2023 05:06:53 -0800 (PST)
Received: from ziepe.ca ([208.169.72.58])
        by smtp.gmail.com with ESMTPSA id a26-20020a05620a439a00b007788bb0ab8esm7536493qkp.19.2023.12.17.05.06.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Dec 2023 05:06:52 -0800 (PST)
Received: from jgg by jggl with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rEqr5-00013m-DC;
	Sun, 17 Dec 2023 09:06:51 -0400
Date: Sun, 17 Dec 2023 09:06:51 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Joerg Roedel <joro@8bytes.org>, Christoph Hellwig <hch@lst.de>,
	Vineet Gupta <vgupta@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
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
	Rob Herring <robh+dt@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-acpi@vger.kernel.org, iommu@lists.linux.dev,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v2 6/7] iommu/dma: Centralise iommu_setup_dma_ops()
Message-ID: <ZX7ya38NBluYyrOK@ziepe.ca>
References: <cover.1702486837.git.robin.murphy@arm.com>
 <5d89190b35720bf5b66621f46b6d3c85323d8eab.1702486837.git.robin.murphy@arm.com>
 <20231214165126.GA3726750@myrica>
 <2d87c1dc-cc95-4d92-968c-9d6e6e6439ff@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d87c1dc-cc95-4d92-968c-9d6e6e6439ff@arm.com>

On Thu, Dec 14, 2023 at 06:22:49PM +0000, Robin Murphy wrote:

> Taking yet another look, there's not actually one single place we can do
> this right now which will work in a manageable way for all cases.

The dma ops should be set after changing the translation and there is
only one place that attachs the domain? What prevents putting it
there?

> @@ -3217,18 +3220,9 @@ static ssize_t iommu_group_store_type(struct iommu_group *group,
>  	if (ret)
>  		goto out_unlock;
> -	/*
> -	 * Release the mutex here because ops->probe_finalize() call-back of
> -	 * some vendor IOMMU drivers calls arm_iommu_attach_device() which
> -	 * in-turn might call back into IOMMU core code, where it tries to take
> -	 * group->mutex, resulting in a deadlock.
> -	 */
> -	mutex_unlock(&group->mutex);
> -
>  	/* Make sure dma_ops is appropriatley set */
>  	for_each_group_device(group, gdev)
> -		iommu_group_do_probe_finalize(gdev->dev);
> -	return count;

If we are turning this into something that only works for the ARM DMA
then the remaining caller should be guarded by an IS_ENABLED

Jason

