Return-Path: <linux-acpi+bounces-13190-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB319A97504
	for <lists+linux-acpi@lfdr.de>; Tue, 22 Apr 2025 21:00:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FF73178F8A
	for <lists+linux-acpi@lfdr.de>; Tue, 22 Apr 2025 19:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC269296D06;
	Tue, 22 Apr 2025 19:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="JY8owS40"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB7C1DE3C3
	for <linux-acpi@vger.kernel.org>; Tue, 22 Apr 2025 19:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745348441; cv=none; b=t/u9AYr3CDtcfKXGDJzpdvYa/npKkYbwOAHOYt+LZZWKN0cahF6LPlZ3QYeeCj7j/zOBntWPnnqt8vtJqZP9BK2BKrW2hERAd6mzMxWR+qpz+CYNmPuZU6RRPPb9CiZEzxVpAQcEBdrm+jCTUZrem2Vz2adlq0MfdfpqN+4jRZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745348441; c=relaxed/simple;
	bh=4QLSLmrkPbs1yBBussuVmcH9d86k1ZJ8t0dZp5NXcyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eWRACCbajuThIFyOwOQsSa+Dpz7wamZ3K9OE/yZgTFkBBm2o5RLqMJYwYZJ4V3vZrkZloTVS30puH9hqvHEPTXjxdJlhACw6yaNbJiu6Bk02BmrxveS0Q3Npc9N87ZCz3Qm/as19DyqCANJhKUvt9WJvmvMQmk+s7fU+oKK1kBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=JY8owS40; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6eaf1b6ce9aso63253226d6.2
        for <linux-acpi@vger.kernel.org>; Tue, 22 Apr 2025 12:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1745348437; x=1745953237; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TMh0izLSzqmAU5ORZxGehcX6J35ZOvbIe3zUy9tlNbQ=;
        b=JY8owS40K0jtYFjGrIcxtLhyDsimWfnz3h5yTgIVzRuElVJmlJtejUKPgbU/d59FzH
         MSC5YMdutpF5U5TrzKTZ4tEEAnoX31AJvZJi9BcoxUsjNBlsZwT/XLGs3PQdnqSRtbSf
         Tz9+BEKtRg033DJQzjJWU6M0t+3S6Csle0omxMsJXQxtBB9Nl+cJ0kA9OPbLljaBYiO6
         1BEiewxh8X5Cad7DJj/PMq7mXBGxiWqpmD+Yktr5aKLE94WyqP9nRUuvDv7TL8h5L8Bg
         b68MuACOKY5ZBE28Tnzo6CdslZSUTJKarqMcGjp55aEhLW6I6THokC/tX36ovO0y4Wif
         8w5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745348437; x=1745953237;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TMh0izLSzqmAU5ORZxGehcX6J35ZOvbIe3zUy9tlNbQ=;
        b=J+z5H2S8oBBXUW7bSHqNWGH8al2JCfRTo2dp2VY8LfbuxZserpaJmFZdPu+aqZy50e
         rMjjdbfHK7q5BrNHZTedzDxCKG2Zo4cQ0JBevk+4uF/p3xAmsKjVOKEoz2Jd21hU7Q9E
         y1jz+NhZL7LiQmlb4gzmrLBuQNPg1f+jJMCKp2li/d6k1Iv1ABvvgUBFHPw6vtdGxz73
         6sJUymajlCGl5Jort2iQO8G/WQHgbigId84hohEJ2O1FbFS/FMwst1Ojmq8fwOkC/fPt
         NG6QLvMWIULWVMINckhSzCT1YO447eN1z/tILgvuACBDWRkYaTZ7WVzQ6B3HYMW/S+kr
         LesA==
X-Forwarded-Encrypted: i=1; AJvYcCVbDKld9m2lr6VZS6+o3tvc1fIfqCOII6VSChkxmOreSUKhefO4Rz46dphAOcr/6QBIhrJVvy8qeCTe@vger.kernel.org
X-Gm-Message-State: AOJu0Yyt4nM6a1zQNnF7tGZ1j6tuUxT6YQB2NRaBMIFC8eTJVjKs1Way
	0n1SCdNDfCUKEnPGCUv3SId8KQT2x6CjGex8d723C7mcTyZ9wgQuwHuDVTu9o6I=
X-Gm-Gg: ASbGncsHSWWZ1RyTncoN0bb0oKaKWuseEHxfxOUu6Dnsp5lk3OgBMu4s4YoJvYpbyLl
	/Kdxo5vOEAp5X5RiiOoL6PaJbFLUIAMfMWsBNoWo8jK4uHuvb8SUMFG8h2XbPeYs/CxjKEJ7mbS
	ygs6UhYBYTLDUP+mD8DoaJtCzRWZi0OgdyVXhyNX2YTcThmK+rbZLdAKdtAlGjH6ysZbac3RXK/
	nEVhWzlrD4bHw0aNhaPVVvuxc3jsaKNL5vAMWLLRG1IvCJwuo5d1DqQqTzOq/SiiMY7JovkU84z
	yFiFBINFuwjq1lB93l0zYALGZdcMS1LLAmUlrfT9sR/HNocD5BNmA6RP5rV9pJRBmgA2jX6UoPI
	qv8zEDec+uLIQwamZRu0=
X-Google-Smtp-Source: AGHT+IHbq+pHzTQuxxdUufVp0+5UWeEWnmEdvfzQVGDaZiAVyxBLUWwXVLbiir8zvtHTZQ/owxmlMQ==
X-Received: by 2002:a05:6214:3008:b0:6ea:d361:a4ca with SMTP id 6a1803df08f44-6f2c46557e7mr318335806d6.32.1745348437625;
        Tue, 22 Apr 2025 12:00:37 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-219-86.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.219.86])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f2c2c21da6sm60863536d6.98.2025.04.22.12.00.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 12:00:36 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1u7IrE-00000006vVF-1Cvg;
	Tue, 22 Apr 2025 16:00:36 -0300
Date: Tue, 22 Apr 2025 16:00:36 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: William McVicker <willmcvicker@google.com>
Cc: Robin Murphy <robin.murphy@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
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
Subject: Re: [PATCH v2 4/4] iommu: Get DT/ACPI parsing into the proper probe
 path
Message-ID: <20250422190036.GA1213339@ziepe.ca>
References: <cover.1740753261.git.robin.murphy@arm.com>
 <e3b191e6fd6ca9a1e84c5e5e40044faf97abb874.1740753261.git.robin.murphy@arm.com>
 <aAa2Zx86yUfayPSG@google.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aAa2Zx86yUfayPSG@google.com>

On Mon, Apr 21, 2025 at 02:19:35PM -0700, William McVicker wrote:
> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> index 1813cfd0c4bd..6d124447545c 100644
> --- a/drivers/base/platform.c
> +++ b/drivers/base/platform.c
> @@ -1440,8 +1440,8 @@ static void platform_shutdown(struct device *_dev)
>  
>  static int platform_dma_configure(struct device *dev)
>  {
> -       struct platform_driver *drv = to_platform_driver(dev->driver);
>         struct fwnode_handle *fwnode = dev_fwnode(dev);
> +       struct platform_driver *drv;
>         enum dev_dma_attr attr;
>         int ret = 0;
>  
> @@ -1451,8 +1451,12 @@ static int platform_dma_configure(struct device *dev)
>                 attr = acpi_get_dma_attr(to_acpi_device_node(fwnode));
>                 ret = acpi_dma_configure(dev, attr);
>         }
> -       /* @drv may not be valid when we're called from the IOMMU layer */
> -       if (ret || !dev->driver || drv->driver_managed_dma)
> +       /* @dev->driver may not be valid when we're called from the IOMMU layer */
> +       if (ret || !dev->driver)
> +               return ret;
> +
> +       drv = to_platform_driver(dev->driver);
> +       if (drv->driver_managed_dma)
>                 return ret;
>  
>         ret = iommu_device_use_default_domain(dev);

The diagnosis looks right to me, but pedantically I think it should
have a READ_ONCE():

struct driver *drv = READ_ONCE(dev->driver);

And then never touch dev->driver again in the function.

Send a proper patch?

Jason

