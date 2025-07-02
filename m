Return-Path: <linux-acpi+bounces-14943-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6648EAF5C33
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Jul 2025 17:07:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23CBE3A57A6
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Jul 2025 15:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45E832D0C7D;
	Wed,  2 Jul 2025 15:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="mpA7MfC4"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14A42D0C87
	for <linux-acpi@vger.kernel.org>; Wed,  2 Jul 2025 15:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751468798; cv=none; b=qE2lZTn8iycWJIxZE6RCWA0Vm6PthAKCYjl4yimqwUIlwrvGNcHZVxyC+mhXAmbGZ9nV3erGMnG2rS6DuIWNKDbjxOdMiUGRI1w3d6/ZAOEafzkFs4mrXKf3BcnJjla5Kvr/iD6jo0e85ddZ9QwNY0/20dtcWAddKEwOqXORdqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751468798; c=relaxed/simple;
	bh=68MAtXNRMrOlaqudDNa6dyhIXhKNWKCJp2ZktqVgKfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KHjkANctLPs/di2k4568r6samly48/vpkwncGzgcp8zhSZUFrjPlHZKrdTGrgnGp2Cbv98frzSkaz7osPA8/hIq8upO/Q6CjLMZmJEmkGK0arTMYukLx5UfJcLKTZhFwVp8gO9RVExaYQdf9+maeur304BhE/xwVX8Ud8WzW0wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=mpA7MfC4; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-235e1d710d8so83156035ad.1
        for <linux-acpi@vger.kernel.org>; Wed, 02 Jul 2025 08:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1751468796; x=1752073596; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DuxrgWn37wvxnmqKJavpfaOGptqxe8oR/pHOsdwVSXg=;
        b=mpA7MfC4Zt8G8Q2vqphc//2YrzrTFQPdfBMtdqUOf2tQ52hLWPE9XbULaLXAEquHkL
         uxyMzrOHQusOEk+1K2Ll635NnZ5zW/6ZemPEldrFtwIvArAy5EiwHANlxkeovsIUdjr8
         N5bfC2QAhN629IM7vgormxDklMpVpdalPQEcg9wYZzJXXQtKGvHUzS+sy//68RSJzd8z
         Da2jqfXgxTTGxCZfNyv6j+QnoEuZyqpnFCvOqA8tDRWh9SRqHbOy8TKGubZsr0HIFEdm
         ctJ9lT3tdw3Qja8sFzifAlDr1aeTisM7KHH3FDieuTugZBSH33MAVuINYUk1V5uogTeu
         O5vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751468796; x=1752073596;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DuxrgWn37wvxnmqKJavpfaOGptqxe8oR/pHOsdwVSXg=;
        b=aDACofQXr7Eq+iGgC7NEbqANHpeTy9UiPV6Wn6mnfgCoV4wxRcnEzHD06b4ClJbLzp
         1V0OeXPVLztjFe2FiNGJoA92Q5oPIHoCyT2s+ZVl5V4hUJTQnRNR5gUqpuo4dbU/QHTH
         uqPdMyae5qcUqoiEaVSY+lXY5f4i6gwGuVE3ihvkpKQUdZOVcG94E9Ui/Hv8RhoYoGDc
         cA6IIi+0U3+RBYvqWLDgn8vk2iBDPirbTezeHFq4mfrAZ8ahELBiZGdHaO7+DDjEgEjD
         uqgfknyKx4D9Xvjq/dIqwfzm4F7BREWEAwXiV39iKezyExv/S7zS4VCv/Bqt9RnGE/Up
         DKyw==
X-Forwarded-Encrypted: i=1; AJvYcCUsXzH6HHXeb6RgPrmxTYy2hBGMMRVSLWiB2+80yCA6wB8c1K0lqxrrfkFj9XJOG30+gaf8R8INw1xV@vger.kernel.org
X-Gm-Message-State: AOJu0YzE+SNyi1eYNgmDZ0tql3hm+jgbjJ6PT/K9rmSc1kc1wVL4bclc
	6LZwB7E1R4wyoxydxvmu9FWUF7UHq5TeDpsVPRRD1y8L0QHV59dJh0TNlFRoI6vGrh8=
X-Gm-Gg: ASbGncs2IHKhsU6Wkebj/jWXr08tYRLI1KLe3flPtboYraBZw0eutn3cMAkzCPFxPkI
	8nPnl7+sEOkG1waxRJK0YnHjglzPKsWapFzYxdW/2OFJt+YqHPebtRfxIriaJyXwAZFAqAMN6DS
	rPUWmzJHO8omeRkfMylhZgIgsN0QQ5IcLO1r/qSwQBUDOdMZHas5NHVtn0NoenLR3xk6VknNYpv
	KpZvsYjJLbM+a0Y2c5CY9lzOBnESzd50Gc5FMMu8hLSLvjMKZjaKp1RRgEBGvhf722meiH2Xt8m
	H231BEaOEHPiK8y6jgx/71UHho1vMD03+zRoW6dtvi6FUe/W4MfcLmvUqjka1R31clg+hg==
X-Google-Smtp-Source: AGHT+IEayU19ekj4WiD0uxOsXBOzhuBGyVO7ozD4bXpw7JPLUlbTFpVZ7FSEPPWrdW6ZBL27rOJyQQ==
X-Received: by 2002:a17:902:e78d:b0:234:8c3d:2912 with SMTP id d9443c01a7336-23c6e4e2a1bmr41479125ad.11.1751468796094;
        Wed, 02 Jul 2025 08:06:36 -0700 (PDT)
Received: from sunil-laptop ([103.97.166.196])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb3ba530sm130521215ad.200.2025.07.02.08.06.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 08:06:35 -0700 (PDT)
Date: Wed, 2 Jul 2025 20:36:20 +0530
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
Message-ID: <aGVK7NxRdDIGRzNR@sunil-laptop>
References: <20250702051345.1460497-1-apatel@ventanamicro.com>
 <20250702051345.1460497-16-apatel@ventanamicro.com>
 <CAJZ5v0iYYuK2GF2Pg3NiO4vLFzoYm6Q3Dnk5O2DkMJm1R3qSfQ@mail.gmail.com>
 <aGUaFX9WgTW1I_ZO@smile.fi.intel.com>
 <CAJZ5v0h=qzS67Xu6NUfN_LmQUmKF9=AtkaRrTx81td0m-mRNNg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0h=qzS67Xu6NUfN_LmQUmKF9=AtkaRrTx81td0m-mRNNg@mail.gmail.com>

On Wed, Jul 02, 2025 at 02:39:30PM +0200, Rafael J. Wysocki wrote:
> On Wed, Jul 2, 2025 at 1:38 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > On Wed, Jul 02, 2025 at 12:20:55PM +0200, Rafael J. Wysocki wrote:
> > > On Wed, Jul 2, 2025 at 7:16 AM Anup Patel <apatel@ventanamicro.com> wrote:
> >
> > ...
> >
> > > >  static int acpi_fwnode_get_reference_args(const struct fwnode_handle *fwnode,
> > > >                                           const char *propname, const char *nargs_prop,
> > > >                                           unsigned int args_count, unsigned int index,
> >
> > > >         const struct acpi_device_data *data;
> > > >         struct fwnode_handle *ref_fwnode;
> > > >         struct acpi_device *device;
> > > > +       unsigned int nargs_count;
> > > >         int ret, idx = 0;
> >
> > > > +                       nargs_count = acpi_fwnode_get_args_count(device, nargs_prop);
> > >
> > > I think it should work the same way as it used to for the callers that
> > > pass args_count, so maybe
> > >
> > > if (!args_count)
> > >         args_count = acpi_fwnode_get_args_count(device, nargs_prop);
> >
> > But this is different variable.
> 
> Of course it is different.  It is an acpi_fwnode_get_reference_args() parameter.
> 
> > > >                         element++;
> > > > -
> > > >                         ret = acpi_get_ref_args(idx == index ? args : NULL,
> > > >                                                 acpi_fwnode_handle(device),
> > > > -                                               &element, end, args_count);
> > > > +                                               &element, end,
> > > > +                                               nargs_count ? nargs_count : args_count);
> > >
> > > And this change would not be necessary?
> >
> > This is not the same check as proposed above.
> 
> No, it is not.
> 
> It just makes the function work the same way it did before the change
> for the callers who passed nozero args_count and so they might be
> forgiven expecting that it would be taken into account.

But if we do like this, the expectation of
fwnode_property_get_reference_args() will differ for DT and ACPI, right?
I mean nargs_prop should take higher precedence than nargs.

Thanks!
Sunil


