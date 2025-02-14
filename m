Return-Path: <linux-acpi+bounces-11200-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD72FA366C0
	for <lists+linux-acpi@lfdr.de>; Fri, 14 Feb 2025 21:15:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6CED3AC8A9
	for <lists+linux-acpi@lfdr.de>; Fri, 14 Feb 2025 20:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 459271DB127;
	Fri, 14 Feb 2025 20:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="lDdgc3y7"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD311DA63D
	for <linux-acpi@vger.kernel.org>; Fri, 14 Feb 2025 20:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739564080; cv=none; b=kHiWvd+8Mo0dLj1vKxg4S8EkgdkLpJHphfqsmjnd5e7YFF2Sn8Xrg6ZEVdISpizrJ0akSu4tXyxJxmfFM30XlLq0msZQP6ojS/Y+38yaEz3qUlsk/77yokqkCpVYMBNII9DnDH4kKEvW59b98C3F80Jrvi2XNvRztKtljsZkRY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739564080; c=relaxed/simple;
	bh=YNsBtJJ9+cy2UshunM7rNUNI3Qb2RchH6uhbFDj9n5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hb45u+bjhISUUG54sEDEyuH4nxE+4Sfszm5WDqjE0PaU6JB2v4Ya96q2HHXbCHYZ03cpGDYS5wHvs1Y0CN5iOIldBMek+x4fp3AjmEQctM5YrfSDhOduTUMnFXQwFv2eEfeb6qcRiB3O9zWotI5z57JkgcuFyKKJH8oiBph73rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=lDdgc3y7; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7c05c22d32aso424187985a.2
        for <linux-acpi@vger.kernel.org>; Fri, 14 Feb 2025 12:14:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1739564077; x=1740168877; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aitcMe7WROI3inmWPb5j5yTibRGZT3eFja/8dsNPCSo=;
        b=lDdgc3y71bo8L0V8hpCdEtVgcsYESprTduXIi+kFt0zRyUBJTudrWt7COhlV/BBLji
         5ZkMyQmRRCnytLs+RviwSVnWQOUoM5cP3ErSy21ZoSWjTaurrbfAeOLlOz47ThtY1fmC
         FUlgo2rNZt2vfHG+MFiY/pf6R6M/Ppt/VKABJ4J0S5yCZTzfNBiG/G8XHBO7ymhTkzq4
         20ubMy9bEoplUkIsMCUNIc3rJPoNAuW8WmZphPHnp6uSlSve6YYVLYFopk6107RDJFBN
         7obB/RiGZMO7NKpkJS8XE23hj8SP8OqV5dlORQbhZ8Cw+0rpdqFpPn+NC5hiIEfe8k0v
         yuTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739564077; x=1740168877;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aitcMe7WROI3inmWPb5j5yTibRGZT3eFja/8dsNPCSo=;
        b=qt8p83LHmHt14dL+2akX4zPMZXjWlobX+AGfmuNutJJTjyIRspQH7M+zwUZ0mllUIP
         7Jn2M6yQTx0mB4SN/m/6e1331Gt7Et5V/Z/f9D3vH4g3nqLykTme3iRNZR2+Qdl+80Yc
         zzsR90cUnVn2Oq1v3pS3EXufTzGFma+jTR/v/646Gl7UrO1F7tMkmgBffz4H5RHjkA0s
         qD/G3aW+q57E/LSf1d3A68KDolkkKkWyRXBqnrfhcF0Wjn1yGac9XNZW1Y3Q0lwhZz7a
         d8qIerOJ3gzqO0HAyEO+GHzXTg2g3k1kJ//c+yGa5ZIRKo1w0pEY5XWmKDh1x8m1j/dQ
         LAew==
X-Forwarded-Encrypted: i=1; AJvYcCVOFgIiEdlHCYpUNkLooN2QNWd96IH5i+03fjTvvqoS/KGvc6RuU3o7bgQRJ1BuOFwvlSE06xXsW4AF@vger.kernel.org
X-Gm-Message-State: AOJu0YzrbpFLsE+St2ZpJ4CGaMcTdnZG+A3ksyIixdScxGr1i6i8o+5p
	6BYwbu1K0uMJmQLhLekKPxo3U0YAnfvalLXEI7q1/4nJI8gppkJa5bVSuZfFNdk=
X-Gm-Gg: ASbGncvzVw5s0uocsxZo0flsC4ZIRj+J26pDOFW29Fwksq4iuHvHPcQHzGtO/MaZc/A
	Zv2W9ZgyZ8RNUzhQxrwUn3HzG8SeXoYdy6R5SNwo9X2XLxvoU7NPxIDHr+p3w49MKokI6YMK8Jn
	mP9NkgNmD/riv8k4cYFSQsFKnp1CiO6F6M/OPuf38CV2W7M7QbYNur2qZiDg7WeeRfiqqgA+x7c
	ZYsFzeaKXlh3IVUp4IkPs/4BWUnEfOS+iIBwYq5oCD/RGeZVE80nbx00p1yNlgsbcfJvV3UyXsS
	GlAEH/SmAIGhD5TII/39rzuX2c5mokT7oHfYZ41rcjlte9pw5Rujlxp8M6o15qVU
X-Google-Smtp-Source: AGHT+IGnMpUVAQSaoCinCLx2FBIU+4N7ViIjMJqQfxMTZ4fEWvtSzvHCiXUgAsqSsNDrtdOvrjsIMg==
X-Received: by 2002:ad4:4eed:0:b0:6d4:e0a:230e with SMTP id 6a1803df08f44-6e66ccc114cmr11243186d6.16.1739564077030;
        Fri, 14 Feb 2025 12:14:37 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e65daffdbbsm24455776d6.99.2025.02.14.12.14.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 12:14:36 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tj255-0000000GmgQ-3jtW;
	Fri, 14 Feb 2025 16:14:35 -0400
Date: Fri, 14 Feb 2025 16:14:35 -0400
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
Subject: Re: [PATCH 2/2] iommu: Get DT/ACPI parsing into the proper probe path
Message-ID: <20250214201435.GF3696814@ziepe.ca>
References: <cover.1739486121.git.robin.murphy@arm.com>
 <c2f0ae276fd5a18e1653bae8bb0c51670e35b283.1739486121.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c2f0ae276fd5a18e1653bae8bb0c51670e35b283.1739486121.git.robin.murphy@arm.com>

On Thu, Feb 13, 2025 at 11:49:00PM +0000, Robin Murphy wrote:

> much just calling the same path twice. At client driver probe time,
> dev->driver is obviously set; conversely at device_add(), or a
> subsequent bus_iommu_probe(), any device waiting for an IOMMU really

Could you put the dev->driver test into iommu_device_use_default_domain()?

It looks like many of the cases are just guarding that call.

> should *not* have a driver already, so we can use that as a condition to
> disambiguate the two cases, and avoid recursing back into the IOMMU core
> at the wrong times.

Which sounds like this:

> +		mutex_unlock(&iommu_probe_device_lock);
> +		dev->bus->dma_configure(dev);
> +		mutex_lock(&iommu_probe_device_lock);
> +	}

Shouldn't call iommu_device_use_default_domain() ?

But... I couldn't guess what the problem with calling it is?

In the not-probed case it will see dev->iommu_group is NULL and succeed.

The probed case could be prevented by checking dev->iommu_group sooner
in __iommu_probe_device()?

Anyhow, the approach seems OK

> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index 9f4efa8f75a6..42b8f1833c3c 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -1619,6 +1619,9 @@ static int acpi_iommu_configure_id(struct device *dev, const u32 *id_in)
>  {
>  	int err;
>  
> +	if (device_iommu_mapped(dev))
> +		return 0;

This is unlocked and outside a driver context, it should have a
comment explaining why races with probe can't happen?

> +	/*
> +	 * For FDT-based systems and ACPI IORT/VIOT, the common firmware parsing
> +	 * is buried in the bus dma_configure path. Properly unpicking that is
> +	 * still a fairly big job, so for now just invoke the whole thing. Our
> +	 * bus_iommu_probe() walk may see devices with drivers already bound,
> +	 * but that must mean they're already configured - either probed by
> +	 * another IOMMU, or there was no IOMMU for iommu_fwspec_init() to wait
> +	 * for - so either way we can safely skip this and avoid worrying about
> +	 * those recursing back here thinking they need a replay call.
> +	 */
> +	if (!dev->driver && dev->bus->dma_configure) {
> +		mutex_unlock(&iommu_probe_device_lock);
> +		dev->bus->dma_configure(dev);
> +		mutex_lock(&iommu_probe_device_lock);
> +	}
> +
> +	/*
> +	 * At this point, either valid devices now have a fwspec, or we can
> +	 * assume that only one of Intel, AMD, s390, PAMU or legacy SMMUv2 can
> +	 * be present, and that any of their registered instances has suitable
> +	 * ops for probing, and thus cheekily co-opt the same mechanism.
> +	 */
> +	ops = iommu_fwspec_ops(dev_iommu_fwspec_get(dev));
> +	if (!ops)
> +		return -ENODEV;
> +
>  	/* Device is probed already if in a group */
>  	if (dev->iommu_group)
>  		return 0;

This is the test I mean, if iommu_group is set then
dev->iommu->iommu_dev->ops is supposed to be valid too. It seems like
it should be done earlier..

> +	/*
> +	 * And if we do now see any replay calls, they would indicate someone
> +	 * misusing the dma_configure path outside bus code.
> +	 */
> +	if (dev_iommu_fwspec_get(dev) && dev->driver)
> +		dev_WARN(dev, "late IOMMU probe at driver bind, something fishy here!\n");

WARN_ON_ONCE or dump_stack() to get the stack trace out?

> @@ -121,6 +121,9 @@ int of_iommu_configure(struct device *dev, struct device_node *master_np,
>  	if (!master_np)
>  		return -ENODEV;
>  
> +	if (device_iommu_mapped(dev))
> +		return 0;

Same note

> @@ -151,7 +154,12 @@ int of_iommu_configure(struct device *dev, struct device_node *master_np,
>  		iommu_fwspec_free(dev);
>  	mutex_unlock(&iommu_probe_device_lock);
>  
> -	if (!err && dev->bus)
> +	/*
> +	 * If we have reason to believe the IOMMU driver missed the initial
> +	 * iommu_probe_device() call for dev, try to fix it up. This should
> +	 * no longer happen unless of_dma_configure() is being misused.
> +	 */
> +	if (!err && dev->driver)
>  		err = iommu_probe_device(dev);

This is being conservative? After some time of nobody complaining
it can be removed?

Jason

