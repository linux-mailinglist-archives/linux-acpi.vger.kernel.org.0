Return-Path: <linux-acpi+bounces-14450-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5C3EADF1E6
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Jun 2025 17:55:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A3AD1889FA5
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Jun 2025 15:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 925872F004F;
	Wed, 18 Jun 2025 15:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c55xp1fm"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A282F0045
	for <linux-acpi@vger.kernel.org>; Wed, 18 Jun 2025 15:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750261908; cv=none; b=NSqeyBacBHPVkZalx+UmEBQ352834NTWJU3EnhrbuWDtoEBw+hqnLO1svwgc8Geockqu6iK2lbLS88uriV/sxHISlzt0zxgjHEZJrvsp3ZPcre7KbKm5vbTlM8+KvbMkNJAlsYWQ3AS2fHzmnFI+IX1Cqsb+O5sgOYro8w771S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750261908; c=relaxed/simple;
	bh=23FzxqtG6GgAE/fMAHJQU0Q8RmYqZeTXf4zDRHmSZjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q4QhJlI+6/M7V8ENwMqk4fRmDZuAyl/fSQoVWhZ9/egwBsuZiANNtEOxTy0xdFcxv0OABebf+btangHlwqTaF+Kqbdk/A2ACO7q7SEgOnNhYZlUDC9DYf5gPqIosS07jB/97y1tj6WqBw81JRIrg2eVNOHOzth9Xvy3rqd/piSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=c55xp1fm; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-4067b7d7e52so1806663b6e.2
        for <linux-acpi@vger.kernel.org>; Wed, 18 Jun 2025 08:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750261906; x=1750866706; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kYPQPWqeQ8cFIac7fW7Mg6b3Vri4HsDMay80nKR0axs=;
        b=c55xp1fmqzOZBOMkoe7L873bU+mSZ8BBkTBQpR/nx/b2HHDr3aSSw5F+Gp2XRsOdzH
         brJvGvmvTSizkgr1uWhWw5btrWfDuApfSSu6igvBho7Q3F9XUew+hNdAaGpd1MI8D3hz
         uM3Xsw6lNE42p/x1P4YH5gZ7gViPjndUKVDKq8OfufLzEKfUs2duMzJwO+LtL6nNAe/8
         zC8VlxsIi/8JLQRz24utqI/+xLScMmZd5ij7Xy8NKx6VvfCNZCEF0IsuC74CMCuTugRi
         CyGsdp8BwwDSatoGPB7nzQS71Uzj3hk6pnUrOHdYBmdJIxk4mUYYYpiPyxcjq2Rm5QCG
         YYnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750261906; x=1750866706;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kYPQPWqeQ8cFIac7fW7Mg6b3Vri4HsDMay80nKR0axs=;
        b=SBhuDtT/hjKpuEqEawRxFZqNSOSaHpl3lzUnKCg8xkrKS01EXpjxV3BeFjiLcHv9dj
         RDA6Yc/m3MirDih1lxUrqH3AbE87Cyjk+nWG4kGS4V59ZL5iYXfzdAT+z8GpQM0hXslJ
         2lfCWxz6EWKJTZp3oMAmViyyb3gqDLG21TQkBrDVBqzmzZj0ApaIHsLc8oZVHMwC6ED4
         FzaMinBYWRU3lGeEnRmUGreteRMIAGFe3AFY2FyvK1o5G7R2hBCKOXoO8dy9ltEZAXGt
         0d4K6uf/37CdftIkBtugomNJ4qG67jTBflE6wRh90j7Wm/gnXQun6MDf2hWtHWeGdwmQ
         nvcw==
X-Forwarded-Encrypted: i=1; AJvYcCWK3/0OhvFd/8Jvdkr3gjKEDw/4MhiSa2U2ssuTWVxVhB+me0avMfYhOxvNZbwyBCwlLMsNopKDvTt0@vger.kernel.org
X-Gm-Message-State: AOJu0YxOMHhiaLdzFmelhP7DZf5luLa//W5e+a3MvTQvhFWglpafpIKD
	Kyki71OhRpf3mI+fF7LoxV36sbIMNyX+K+Vx/kMchXQ78oPjRthV/wWueqEH2fouLlM=
X-Gm-Gg: ASbGncsqIQuz+mxdMl2YX+l1PZM4m3TOUVrLy5zGDgtdyK6pIIZHJ+uIZJRFkdctFSz
	wepo2A6nTucLZVofbRtHM2pWmxt6KceXLeZUfhtlP1VWRudfW1x9vXqHbmZusA1OPJU65SYgpfS
	ZNx2ulTqCSdUYv2traxXu5GusPUfSv/QsvCH5k1jYYeyXHHNnwlD5Mtofs+mVsVoi+GaZpitiRi
	graib56SX0ZCaZZSxFUAOh9EtvoK8pHbwJyyhnZlf+Pyo5g7fcxyNd3QEELAFzmqTEsnl4xp0dB
	KSIHPgjXwHRG4eji2L0pwJ9CAeNTaiBzqhlhLLuR0lCgrRhfeAtsTdlMbl3FtOUc6sADLQ==
X-Google-Smtp-Source: AGHT+IF4tQv5VuEQMCpbEPVkO8mXIAv9i/Gb5HQeEcizVo5ZWGkRY/icNXe2XOorHfOXGX7eq/SdMA==
X-Received: by 2002:a05:6808:2124:b0:408:fbb6:f4cb with SMTP id 5614622812f47-40a7c0fbb45mr11582833b6e.6.1750261905772;
        Wed, 18 Jun 2025 08:51:45 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:1b3b:c162:aefa:da1b])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-40a741b882csm2367776b6e.48.2025.06.18.08.51.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 08:51:44 -0700 (PDT)
Date: Wed, 18 Jun 2025 18:51:42 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Zaid Alali <zaidal@os.amperecomputing.com>, rafael@kernel.org,
	lenb@kernel.org, james.morse@arm.com, bp@alien8.de, kees@kernel.org,
	gustavoars@kernel.org, Jonathan.Cameron@huawei.com,
	sudeep.holla@arm.com, jonathanh@nvidia.com,
	u.kleine-koenig@baylibre.com, viro@zeniv.linux.org.uk,
	ira.weiny@intel.com, alison.schofield@intel.com,
	dan.j.williams@intel.com, gregkh@linuxfoundation.org,
	peterz@infradead.org, dave.jiang@intel.com,
	Benjamin.Cheatham@amd.com, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v9 5/7] ACPI: APEI: EINJ: Create debugfs files to enter
 device id and syndrome
Message-ID: <2859fb82-1579-4d45-a8ee-2e3de184fa0d@suswa.mountain>
References: <20250612231327.84360-1-zaidal@os.amperecomputing.com>
 <20250612231327.84360-6-zaidal@os.amperecomputing.com>
 <3a143d53-8731-4afc-9117-bac49ea96db1@suswa.mountain>
 <aFLbgkhB5Q4ZbAZl@agluck-desk3>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aFLbgkhB5Q4ZbAZl@agluck-desk3>

On Wed, Jun 18, 2025 at 08:30:10AM -0700, Luck, Tony wrote:
> On Wed, Jun 18, 2025 at 06:21:39PM +0300, Dan Carpenter wrote:
> > On Thu, Jun 12, 2025 at 04:13:25PM -0700, Zaid Alali wrote:
> > > +static ssize_t u128_read(struct file *f, char __user *buf, size_t count, loff_t *off)
> > > +{
> > > +	char output[2 * COMPONENT_LEN + 1];
> > > +	u8 *data = f->f_inode->i_private;
> > > +	int i;
> > > +
> > > +	if (*off >= sizeof(output))
> > > +		return 0;
> > 
> > No need for this check.  simple_read_from_buffer() will do the
> > right thing.
> 
> True. But why waste cycles populating the output buffer
> when it will be ignored? The normal flow here is that
> a user will likely try to read a <stdio.h> sized buffer
> and get back 33 bytes. Then read again to find EOF. That
> second read doesn't need to do all the "sprintf()"s.
> 

Ah.  Okay, I didn't realize that.

regards,
dan carpenter


