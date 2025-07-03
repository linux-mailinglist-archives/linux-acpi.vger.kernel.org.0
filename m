Return-Path: <linux-acpi+bounces-14970-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 44CCFAF7103
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Jul 2025 12:54:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8388D7ACB12
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Jul 2025 10:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 200652E3390;
	Thu,  3 Jul 2025 10:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="XsywZlyF"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1D32E2EED
	for <linux-acpi@vger.kernel.org>; Thu,  3 Jul 2025 10:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751540075; cv=none; b=aCChuPtQ2iCrx/elf6OSBCEVHw+QNRmNyqlfEi2YVI3x+tyWjEypu87f99AtBKeOkATi26AUtIHNoDUwfZ8tRFnI4vOW3WXVCgJZadI4KAHlQDyPw/WA/hPZCeyMc7D5t2p4L+9F1ImlLwlwqoJ/0cDcRP5N8GupvEtXV+DTiGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751540075; c=relaxed/simple;
	bh=9Um7uqVayv1y9jJFqULzHKt3MEGzxLbLkz23BHaitvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TUKYKRtPsobjku/k2YNaRuO54oZ6NFrto0oufzqq7y+Ey+l04TMu6E8OeitVaPQNdTuJkm+meyyo1S83z14LT4hQxkD/z5HYfU8QfByguLCRgRLo6al1eVdeXRYoeK8XGVq6NbM5xOnNAb6DxbVpF2fxNhdg2s5Xm/VcqDmRpJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=XsywZlyF; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-22c33677183so68760725ad.2
        for <linux-acpi@vger.kernel.org>; Thu, 03 Jul 2025 03:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1751540073; x=1752144873; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2s+0RaBS3vJpNgepBHSmk/I/U4Dvicv46WDE7RU8TKg=;
        b=XsywZlyFZKDwUjRTunWPaMQwmKfQIjlzjqhqMs2eLfuv79cc9CIu/BAOs4yJmruXaD
         5ztuQUrvRkFL7ZAawFO90LoW+h8TavRg5CzQG1pfOqo0IusW2IMivbJRH5Zvu+smQLg6
         KxUq+pTXMQFXXGU72hipZUFB9eMR3yoAbYSKoR//9rKWG/0NB94qmMSmfhYFbiyb/xKG
         xd1T1h0RgelmR+PAR4b2WKuU2efv3cQAXqMavOKaqhO6AVfHYi+0R/vIidaj3BoUGhxO
         xhu628Bny1QzZ481DpjTr5kUXw5axzJinK3MRsJ1w0fwG/hMJjFN6p3eNZ1yn78SEmwz
         aN3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751540073; x=1752144873;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2s+0RaBS3vJpNgepBHSmk/I/U4Dvicv46WDE7RU8TKg=;
        b=T9hjn3fB5SWSq0NIzIbzdAnPB4prEIPqm8ISjZqeidjU+IBLWoZD2yXxfHvaa+LYXa
         BVGPsy5L8fGLrm5vuq0HamQMmTvlIm6pH97eE37TcXcCpFSpsIucbn+Yi5nMki8MkPpb
         HxoU8iEy2KOPk3OTjIQaOQYtRkm0p/VZrBoZFlk++umn2OFhOQWc6BfcYvIaD7Q1W4vb
         GwWdavJ/oZrDbBYGr4d7wCMnu0J2EQxsajudotPQ42oegwXyaZ1yS6e897cGkvbWROSe
         e80ZKZ+2adzcgFMJLE5oPGXB2GnDbV8s87kOwBClHDdWd3pljzhEKMFSzYLbr0+X6GiZ
         Md3g==
X-Forwarded-Encrypted: i=1; AJvYcCWZzO8Txt3JCKfVqMTVtvHukhCYcAfntw47y/UXaVzQDAQN3krxYmIDboglUgo4htTKldkv0nOR2adi@vger.kernel.org
X-Gm-Message-State: AOJu0YyZOHwPWGyP5b1dkkPh5TwjIWBMCYpPv8m8iU2/DBuZmhKe8ace
	8YlcvkDiupCutienPMPqmKekXpQkiSs42H5B+8ZYrGvLOE2A5/mxc5JNJ6XlkTfzsa4=
X-Gm-Gg: ASbGncuDoCe3qMrNli9nPARTRiXUaAyjH5wwXleHaPvbXZJ1JKobNs0yR2xdKVGYB/2
	Yd28h29CgRN47ONoWOvcBj4buYziIK1n94H1B4DNO7CU2ZHBLGL1rAWS5SgPEUTEIlQXyZz/wu7
	W6LSaVJMxMBM2V1QaxNQAT51iWng0qv1KL0vkg1icbSL6ya3LyiuhCP506lh/Of/h33agRoJhFb
	zM8T4vdWVwFSET1sq73MZL8trk4akX+YGYK2uBL/xS2qH4VBRQKBm5uc/zIYhzCOAJ04F2lUFls
	bPJAg1qqqEm4i7lDml2qjtlOVaruz8A3n0iJTMUysb73/7m1bEx5i8I1wHeW1q1yxX5BGw==
X-Google-Smtp-Source: AGHT+IFq25HTQ9QEIhNCp27zmZLx97EGsAxug71BXz+j7RxWXx0ck3JUwKi8dLTS3DtAE17Jq1LekQ==
X-Received: by 2002:a17:903:2307:b0:234:8a4a:adad with SMTP id d9443c01a7336-23c797fd795mr34397665ad.26.1751540072871;
        Thu, 03 Jul 2025 03:54:32 -0700 (PDT)
Received: from sunil-laptop ([103.97.166.196])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb3b9344sm158881255ad.192.2025.07.03.03.54.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 03:54:32 -0700 (PDT)
Date: Thu, 3 Jul 2025 16:24:18 +0530
From: Sunil V L <sunilvl@ventanamicro.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Anup Patel <apatel@ventanamicro.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Alexandre Ghiti <alex@ghiti.fr>, Len Brown <lenb@kernel.org>,
	Rahul Pathak <rpathak@ventanamicro.com>,
	Leyfoon Tan <leyfoon.tan@starfivetech.com>,
	Atish Patra <atish.patra@linux.dev>,
	Andrew Jones <ajones@ventanamicro.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Anup Patel <anup@brainfault.org>, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 21/24] mailbox/riscv-sbi-mpxy: Add ACPI support
Message-ID: <aGZhWlxxQG0Z8awP@sunil-laptop>
References: <20250702051345.1460497-1-apatel@ventanamicro.com>
 <20250702051345.1460497-22-apatel@ventanamicro.com>
 <aGUl_S9irfhlHmy2@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aGUl_S9irfhlHmy2@smile.fi.intel.com>

On Wed, Jul 02, 2025 at 03:28:45PM +0300, Andy Shevchenko wrote:
> On Wed, Jul 02, 2025 at 10:43:42AM +0530, Anup Patel wrote:
> > From: Sunil V L <sunilvl@ventanamicro.com>
> > 
> > Add ACPI support for the RISC-V SBI message proxy (MPXY) based
> > mailbox driver.
> 
> ...
> 
> > -		if (dev_of_node(dev))
> > +		if (is_of_node(fwnode)) {
> >  			of_msi_configure(dev, dev_of_node(dev));
> > +		} else if (is_acpi_device_node(fwnode)) {
> > +			msi_domain = irq_find_matching_fwnode(imsic_acpi_get_fwnode(dev),
> > +							      DOMAIN_BUS_PLATFORM_MSI);
> > +			dev_set_msi_domain(dev, msi_domain);
> > +		}
> 
> Actually you don't need to have the if-else-if if I am not mistaken.
> The OF does almost the same as it's done in the second branch for ACPI case.
> How many MSI parents this may have?
> 
OF already has a well defined interface to configure the MSI domain. The
mechanisms existing today are different for DT vs ACPI to find out the
fwnode of the MSI controller. So, it is done differently.

In RISC-V case at least, there will be only one MSI parent.

Thanks,
Sunil

