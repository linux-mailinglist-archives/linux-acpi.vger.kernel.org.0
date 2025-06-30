Return-Path: <linux-acpi+bounces-14851-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96D4BAED696
	for <lists+linux-acpi@lfdr.de>; Mon, 30 Jun 2025 10:04:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB58F176BFE
	for <lists+linux-acpi@lfdr.de>; Mon, 30 Jun 2025 08:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A90623A9A3;
	Mon, 30 Jun 2025 08:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="ZwMmpHJ2"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B152A23496F
	for <linux-acpi@vger.kernel.org>; Mon, 30 Jun 2025 08:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751270578; cv=none; b=hZ589o3aZdXcffBTxeMRfHrGhhev5VgXkluWvhv7QrXteOr/dXe0RWQ6mw6JV5AhrAFROjzpq2XAOkHb1dt/0cqLR3oA0aCuR0oesQU4yf0ZUQubczwx8VAm5FmCwjE/94w4svZUTUFZYoa3HvW5lSnO0f/+KE/sf2xlpx1YWQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751270578; c=relaxed/simple;
	bh=zgMSdYUK9yNCJ2s3hpP0j/gTKnVm2enHM9w454p24n8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fk3vATxGGpCWCIgnjHAJMSoq2xu9y5iw5xgLvu+h8O6x49XiPXr06fBM9F72sGyOIHmHwwIOgi/kMwJCmqtzhqKNJOe8CjX9ewxsor+pI+bVJ5VlPwPAHHoNq0Oe7pGH9Au3oFmbpDo5WLljaw3oTpJgbJ9aLqX7pEOst0mmgJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=ZwMmpHJ2; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-450cfb790f7so33799135e9.0
        for <linux-acpi@vger.kernel.org>; Mon, 30 Jun 2025 01:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1751270575; x=1751875375; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ska9I3Y1aB1MGchq/+g1Gg5HtDvHRWWCZw8erAwmjVs=;
        b=ZwMmpHJ2okjzzQ4B6SP6Qq14E3pyLz0aagaOtFlMmzclPHu6kCxYhMsA8IlPb6rHrn
         tB6PeFJ12MwiAzQJVMyk0CGMvkqBeLh1oZ0L8rC3E3GkdgAju3prK3MTfnXAzVOcV/U4
         YQ/phOWMNw2mQ53n2bix8LE7HZtIl+hAm0pThaMsdzlefeCa3u9qAgjytWRHks4xnLR2
         t6GvXnIAPwOLvQ2Toh6ScIuLLmlWEtKCGtOId8hpAggSpkrvKW/4VN6qr2aqPG4/BTK0
         hCj3Uv4lBm1YlTu68O/WopzvY29xiQbN2g1zkkfT0aMefKyfx5hLpIDkvYurRhD3FE0f
         Xr9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751270575; x=1751875375;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ska9I3Y1aB1MGchq/+g1Gg5HtDvHRWWCZw8erAwmjVs=;
        b=V7Mwp/9XOKsmB4WIvgx+G+Ut7lYRzkdGkhKFJjoIkbAqFx8gXI5U1iyCgh60iex7+c
         Va+mAvc6kDWqERFud6Z6+/DK7dJot0xX8XZtbG3ufLdlNCRFfAAzB4F2Hr8eVHCPFN/h
         1515cvj856fZe4rysIDywc6HItqSfZpz38grI9if8Nre03KLoAtBEFi3hA+HUdJO3CuT
         wA1gRDp6I84m88RrnwmxPDNq5hjc9ev07+DdtcNMk89IU6ODQTa23JgnLR6KKcDknYOB
         1q1vHtZFC4/JSF3sv7J1fPQQz87wxO1JGRg/in99qdYx0GKQMNu1+cjRmzSALN+LW7Vm
         xnkg==
X-Forwarded-Encrypted: i=1; AJvYcCVxtZwoxyWI7Qn9S+xLczNLDd75Vjk9UuowpouyaSlOXHF4Q1PpUu8ygb5P05HSqKczoP2+5VCjRm3y@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf6lalUP6Xt4Ry0pUMDv+qSc2tOmtxu4qRcarezwweGtgDiVZl
	4qZ1EedSFUJBnA+wuJbV1uBycyhCnfGDTbTrl/TROdELyvkTAQEDg9kiVdvM/d4MdMo=
X-Gm-Gg: ASbGncuIwjNpM9nPeSu0e+XTX0qrJBEw3EMVeMtk8zQURMEDMLdq1w9s/Fz/6cj/xcZ
	y1TwbgNeRnqRlxW97SQFQXg2XCSEvs0qWq8WhrSgUHo5nwlNFXG3aMH4HKZ1TbQhZy7y+FrHFst
	cAM+Z07TBl4u1G5fwkXc3AVjg76K7OZ67iiM0J3TiIv3Vhr3o84t8FgP2RZY7IHc9fp7SubUBUq
	yqoMBVe8OyTsfpxeSATXe5POkpBv7dqpHqCyjzyukZL+ALObZ5FlFmpByB0DZWssP0XTEC7SM3t
	XRa81YgYfGZpdaIaGnNYOEFU3J+eT/mXacRpmOR8oSfOSG2l+gKyVsQtgAIQ
X-Google-Smtp-Source: AGHT+IF9DvJJg0skDidkDsih4Ch3HhJLBIarQJZKBHX8xHPqB+4mHwpjYWK0XFUsByASmkbm+oOmbg==
X-Received: by 2002:a05:6000:dcb:b0:3a5:8977:e10f with SMTP id ffacd0b85a97d-3a917603b5cmr7981361f8f.28.1751270574863;
        Mon, 30 Jun 2025 01:02:54 -0700 (PDT)
Received: from localhost ([2a02:8308:a00c:e200::5485])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a892e5f842sm9499471f8f.86.2025.06.30.01.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 01:02:54 -0700 (PDT)
Date: Mon, 30 Jun 2025 10:02:53 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Sunil V L <sunilvl@ventanamicro.com>
Cc: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-acpi@vger.kernel.org, iommu@lists.linux.dev, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Len Brown <lenb@kernel.org>, Tomasz Jeznach <tjeznach@rivosinc.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Anup Patel <apatel@ventanamicro.com>, 
	Atish Patra <atishp@rivosinc.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH v3 2/3] ACPI: scan: Add support for RISC-V in
 acpi_iommu_configure_id()
Message-ID: <20250630-c479c6607cf8c1430f11336f@orel>
References: <20250630034803.1611262-1-sunilvl@ventanamicro.com>
 <20250630034803.1611262-3-sunilvl@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250630034803.1611262-3-sunilvl@ventanamicro.com>

On Mon, Jun 30, 2025 at 09:18:02AM +0530, Sunil V L wrote:
> acpi_iommu_configure_id() currently supports only IORT (ARM) and VIOT.
> Add support for RISC-V as well.
> 
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/acpi/scan.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index fb1fe9f3b1a3..70f57d58fd61 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -11,6 +11,7 @@
>  #include <linux/kernel.h>
>  #include <linux/acpi.h>
>  #include <linux/acpi_iort.h>
> +#include <linux/acpi_rimt.h>
>  #include <linux/acpi_viot.h>
>  #include <linux/iommu.h>
>  #include <linux/signal.h>
> @@ -1628,8 +1629,12 @@ static int acpi_iommu_configure_id(struct device *dev, const u32 *id_in)
>  	}
>  
>  	err = iort_iommu_configure_id(dev, id_in);
> -	if (err && err != -EPROBE_DEFER)
> -		err = viot_iommu_configure(dev);
> +	if (err && err != -EPROBE_DEFER) {
> +		err = rimt_iommu_configure_id(dev, id_in);
> +		if (err && err != -EPROBE_DEFER)
> +			err = viot_iommu_configure(dev);
> +	}

This can just be

  err = iort_iommu_configure_id(dev, id_in);
  if (err...
     err = rimt_iommu_configure_id(dev, id_in);
  if (err...
     err = viot_iommu_configure(dev);

Thanks,
drew

> +
>  	mutex_unlock(&iommu_probe_device_lock);
>  
>  	return err;
> -- 
> 2.43.0
> 

