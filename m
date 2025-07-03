Return-Path: <linux-acpi+bounces-14969-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77DFFAF6EBE
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Jul 2025 11:32:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A2371C82734
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Jul 2025 09:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB20928DB54;
	Thu,  3 Jul 2025 09:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="ZJ0QpDZU"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2498E23C4ED
	for <linux-acpi@vger.kernel.org>; Thu,  3 Jul 2025 09:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751535078; cv=none; b=L82fsjMFXs/QK1xRPDtG3/NSa/AUmT3mu8Cak9ZoSpk1pQv0g4KLnhO39ZeZXLhOd8lXX3oAWmNB/nPvpGKcux8NnifzxSNh84T6vL6/JaD0qaubWm0QHG/epLQ4Vd5Z2GJ7/r0hVq/NN+Zds4ZoVd6Ds0XC+Vqr6+4vU3kLw/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751535078; c=relaxed/simple;
	bh=TuOOe17TTK0GmQ0tDt79qSc+86xnI17yc0LFNt1uwAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G1pRdCa7VufEpd/YJwh+DOWprBK5gXVFqy1aFToGSdaDDFjI0mP3IZp0AfuIGpDg5jsXUnsJghQT0ED/xDuovkf3XXfzGmSKFx3nGWvhS7d7BDAFhbHRoVFKXUSyxNn6/+0cpeu6UNCyrTBo7a7l8KiG2OjzzopQqjghf3ZTpKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=ZJ0QpDZU; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-235e1d710d8so93046405ad.1
        for <linux-acpi@vger.kernel.org>; Thu, 03 Jul 2025 02:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1751535076; x=1752139876; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KYfn57qzkkmG/aFpndf/jcsizGLt8T7mJq7PMwyO3ks=;
        b=ZJ0QpDZU0gZw+/ekmPbtcgxXuNpf2zz0Rx+6g8GJIrKPOqQzRd4uBc5Gb1GVg9Wkof
         Syn2vpGr8bgHmi0PZWyaS7y+8x0OuobhmNzhE+fQDxEf1AI3b+MMDnFaszevYi4CuhRE
         TZDAUKySD90MyFkJMNzI0bSjoduBOh6G8u5+wVswIB75rtEqdlc2QS8c/23zvWVmMala
         P37UuXzFj1DpwHFnIcCPylCEBDid9nyuOZwXsfz9iCUa3JlXu0zpJ4h1xD67atgoOpiT
         QbxqQwNDJsA42+6V6u9f6yoglM8kWLpOMYh1sxRvucVmp1E14hIGE7UjhXDuFsrTe/Rx
         zWUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751535076; x=1752139876;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KYfn57qzkkmG/aFpndf/jcsizGLt8T7mJq7PMwyO3ks=;
        b=jQ8QhopMdRE/B6S4PFl8xmcGoWZd6ZueR8jkbN0NJaixd3rqghJZBqFNhjL1cZsCbN
         w7l8RhExk69jT2ZZdM0dKtgdc/iBbqac25Rl8egJX6TsTnL7Nqz1z09LEhAIcXybTkIp
         26w59yzhx2WIAQQ351P4uzOsTI+gR3uYcyXPvq1X3XAXxQ36OEdSr2oXCMdN4vMzEpzP
         DV6BoPlHQe9jGhQHnvbny2DfvqvXj+2BmIXCkghlmSK856iKIJK812n2YR6A/OkQ9dwj
         V2f7Zor4oQpca38YthYfoOzpr3k0aEnd6XnzwF0Ff5G79XEJy4DGnPmJj/3HAv1jgrKJ
         FWNQ==
X-Forwarded-Encrypted: i=1; AJvYcCXdb2JHzXeyo/WpJPzVkjlZ6tyBm9mtHwgSW13cxwRlWBx+yIEMILrK/GeNR8n/EAVVM69PqhR0mHkO@vger.kernel.org
X-Gm-Message-State: AOJu0YzYpKdFID8UPh3BdSEVR2s3k5YJq8pjTEqJoGJxZ/kkpEO4Ni4i
	/na8sFvLQTSef3Y2J2JSjJxGMEtjmosEcbfpgf3XN82r+yE/Ftrn7sZmliF1qWqu2cY=
X-Gm-Gg: ASbGncu6U5+UUbI1ldmwiINsSA2uXyzv8DCu0H6Pubz8jRBWJt1OJD5w7xIks3cGMYq
	VPoS2Zj6YiLrSHZQop8s1wE5vxTYOnyexfsNbBHMmH8Re3ZQVo96JgsYby8QG+RyupJ6mwKZH5F
	1f2cUbD3tIihrJdLXGWgCf6IukfR6AGAMx1n4SkUGyQzi3w6H19Ao6hrQLiHyPA+7gZmkeGFKUr
	FcoKrjX6wyKf5VTqcdBaGfh1ySgpDZJgjft1zOFHgffbxY8X3Z9FM0T+bsRBJlsCwJemJen5RUY
	fT1bob5JtdnabAY79JrBFMD1n2kQ0bUXkPdyqWIig1SPKGMYQhOxuuHf9Wk7QerXolwDDw==
X-Google-Smtp-Source: AGHT+IHQ535n0QA2COW4KxgJhYDC5l8yNht6HeovLAUQ6LzoicprfT4zy9/VUUX2qQcf/7mXsoAJng==
X-Received: by 2002:a17:903:19e7:b0:234:d292:be7a with SMTP id d9443c01a7336-23c6e4e4c8fmr85926675ad.1.1751535076424;
        Thu, 03 Jul 2025 02:31:16 -0700 (PDT)
Received: from sunil-laptop ([103.97.166.196])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb2f0babsm158604535ad.58.2025.07.03.02.31.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 02:31:15 -0700 (PDT)
Date: Thu, 3 Jul 2025 15:01:00 +0530
From: Sunil V L <sunilvl@ventanamicro.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Anup Patel <apatel@ventanamicro.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
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
Subject: Re: [PATCH v7 15/24] ACPI: property: Add support for cells property
Message-ID: <aGZN1HzGk1nBWEHw@sunil-laptop>
References: <20250702051345.1460497-1-apatel@ventanamicro.com>
 <20250702051345.1460497-16-apatel@ventanamicro.com>
 <CAJZ5v0iYYuK2GF2Pg3NiO4vLFzoYm6Q3Dnk5O2DkMJm1R3qSfQ@mail.gmail.com>
 <aGUaFX9WgTW1I_ZO@smile.fi.intel.com>
 <CAJZ5v0h=qzS67Xu6NUfN_LmQUmKF9=AtkaRrTx81td0m-mRNNg@mail.gmail.com>
 <aGVK7NxRdDIGRzNR@sunil-laptop>
 <CAJZ5v0hTzrxqfejxSxqh9igiDp=8LkBw+FGSf9CJ7j3RyTJLBQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0hTzrxqfejxSxqh9igiDp=8LkBw+FGSf9CJ7j3RyTJLBQ@mail.gmail.com>

On Wed, Jul 02, 2025 at 06:56:48PM +0200, Rafael J. Wysocki wrote:
> On Wed, Jul 2, 2025 at 5:06 PM Sunil V L <sunilvl@ventanamicro.com> wrote:
> >
> > On Wed, Jul 02, 2025 at 02:39:30PM +0200, Rafael J. Wysocki wrote:
> > > On Wed, Jul 2, 2025 at 1:38 PM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:
> > > >
> > > > On Wed, Jul 02, 2025 at 12:20:55PM +0200, Rafael J. Wysocki wrote:
> > > > > On Wed, Jul 2, 2025 at 7:16 AM Anup Patel <apatel@ventanamicro.com> wrote:
> > > >
> > > > ...
> > > >
> > > > > >  static int acpi_fwnode_get_reference_args(const struct fwnode_handle *fwnode,
> > > > > >                                           const char *propname, const char *nargs_prop,
> > > > > >                                           unsigned int args_count, unsigned int index,
> > > >
> > > > > >         const struct acpi_device_data *data;
> > > > > >         struct fwnode_handle *ref_fwnode;
> > > > > >         struct acpi_device *device;
> > > > > > +       unsigned int nargs_count;
> > > > > >         int ret, idx = 0;
> > > >
> > > > > > +                       nargs_count = acpi_fwnode_get_args_count(device, nargs_prop);
> > > > >
> > > > > I think it should work the same way as it used to for the callers that
> > > > > pass args_count, so maybe
> > > > >
> > > > > if (!args_count)
> > > > >         args_count = acpi_fwnode_get_args_count(device, nargs_prop);
> > > >
> > > > But this is different variable.
> > >
> > > Of course it is different.  It is an acpi_fwnode_get_reference_args() parameter.
> > >
> > > > > >                         element++;
> > > > > > -
> > > > > >                         ret = acpi_get_ref_args(idx == index ? args : NULL,
> > > > > >                                                 acpi_fwnode_handle(device),
> > > > > > -                                               &element, end, args_count);
> > > > > > +                                               &element, end,
> > > > > > +                                               nargs_count ? nargs_count : args_count);
> > > > >
> > > > > And this change would not be necessary?
> > > >
> > > > This is not the same check as proposed above.
> > >
> > > No, it is not.
> > >
> > > It just makes the function work the same way it did before the change
> > > for the callers who passed nozero args_count and so they might be
> > > forgiven expecting that it would be taken into account.
> >
> > But if we do like this, the expectation of
> > fwnode_property_get_reference_args() will differ for DT and ACPI, right?
> > I mean nargs_prop should take higher precedence than nargs.
> 
> So you basically want acpi_fwnode_get_reference_args() to take
> nargs_prop into account (which could be explained much cleaner in the
> patch changelogs).
> 
Sure. Let me improve the commit message in the next version.
.
> Also, your changes don't modify the behavior of
> __acpi_node_get_property_reference() AFAICS, so this is OK.
> 
That's correct.

> Never mind then, but you could pass nargs_prop along with the
> additional device parameter to acpi_get_ref_args() and make that
> function obtain the nargs_prop value.  In the patch, you need to get
> the nargs_prop value before calling it anyway in both places in which
> it is used.
That's better. Let me update acpi_get_ref_args() itself in the next
version.

Thanks!
Sunil



