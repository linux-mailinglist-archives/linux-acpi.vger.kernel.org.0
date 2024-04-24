Return-Path: <linux-acpi+bounces-5331-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40D6F8B0B36
	for <lists+linux-acpi@lfdr.de>; Wed, 24 Apr 2024 15:39:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF68E1F22718
	for <lists+linux-acpi@lfdr.de>; Wed, 24 Apr 2024 13:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4836515FA7D;
	Wed, 24 Apr 2024 13:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oY+3fx0g"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48C015D5CF
	for <linux-acpi@vger.kernel.org>; Wed, 24 Apr 2024 13:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713965693; cv=none; b=bMGUEDz6yIzM1y8vLdzK+dOFOMoCyT+OJDuE0SvnQtjTictwgXYcaBeEhDtRoU49xJxyfnjqmgmh1srxA8or6mwyezBgP4Y3jqdvPJh68nO/b3e+ALHqi5IaUz/5U/4INi6871G8gaM1p1swsyeakTv6LlHdBhDkm9TBqid0Q1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713965693; c=relaxed/simple;
	bh=v5uts0F+G005dBPvbk0jOnlqwhvA4TASHvWq3ETeWdw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tCeilAZFufcHddGcnRdw9wTiJEiq3yYRxDAhA3ov76btNU3S2mOV5+2Wej6qoyn7LLDRjVTNRmqTFNDLA/Btwg5spXDYAi/kLhOWw017cUCzs8oNIbm1OFGbiv6veM9b8aJJ84GOSjjMQhndoom24cVaSlhptKPrQkhLBFyTjHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oY+3fx0g; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-de480576c3cso6169329276.2
        for <linux-acpi@vger.kernel.org>; Wed, 24 Apr 2024 06:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713965691; x=1714570491; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v5uts0F+G005dBPvbk0jOnlqwhvA4TASHvWq3ETeWdw=;
        b=oY+3fx0gQCP4JdIzfu5YUlLxKHqmaBqlM9oZmXqM5rMYPv8WRwObnn/i/Acl2Lq9PY
         qewv8MG2IXzRg/2YB59vw824iXr3W0KwztRRhxzubXLzsWu44yFyvIDTEiRqhjP3U/IH
         yb3KWNb26saDPdkdn9YLVigbqTNO7ezBc2Gns+fc0iG8+UXcKW88vys5zWNVcshCaPAf
         MhS/Yvn3wnNY+hSsA4kvwd683IV+P3PxDT+SEr9BqiAyMuA1579t5Ng5wsfBsHDETuem
         +NhXucaYEu8wECoq47CFc8kPjVZOEcl5evjYRXJUFRTWgXZ7q+aE+lTiPU1vlzliy5LN
         o8Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713965691; x=1714570491;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v5uts0F+G005dBPvbk0jOnlqwhvA4TASHvWq3ETeWdw=;
        b=vms0J4ITT+dIBE5c3liHwYXgeMOXwmkWRDKhRo2dDQcEiOAjPVLelZwEI/Gx8LBhzK
         B671u3ox4TxArGMXWRKtDT6q2OLIq3U5T6+jclM6h2s5nr7GHVJluyQg2xP3c19fJmEy
         0lx477s3lJpl7NbTQRCimIyfeU3vXzcbUu4OR+RalT6UZxmkzJkE6tEgL4+CaqSGHpBG
         nuLq1q3hUdN8Hv2XSBSROaZsycSjLQ0mmTGV7A06YqnPMCVT2Ybj3Uqy8AZE3MTBZk+P
         cYIJ6TrNfCb/VIu13ToWsw/t3BOrwMFyiyIfDNqe68gHv8zdkeEBHNS35Ts4vgRXOF8Q
         U5zQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8TZg+662rgy05So76FHpNvdIc4NWxiFgGy8fu06qagMraHangGWLbths3JWpzGrlu34CUIvsCmJFIV6XkDlDrxmoX6pWrl8baZQ==
X-Gm-Message-State: AOJu0YxtpzKsOQgLE+89obNr4RouF4yi5suzffUkFiYc2VOFPqPgqRUn
	K4Udy8iLczcM531s1URgoduKZ5JLe6aQlb+NIzAawhK5lcqBUsYzihxa2IhGFyIQNxmcI1e0P1F
	TuGMAgdzr4VOEBSenUZQ7geZ/mCQaHTqWzVruSg==
X-Google-Smtp-Source: AGHT+IHyyl3VXRzVgrpc497VuwR/tGfdtBR3F2BBQ+lp1bkMbMbay8ctwKEQp7xRENbiJ8Hez152lECflDB33HFqk9M=
X-Received: by 2002:a25:a1a7:0:b0:de5:53a6:24ed with SMTP id
 a36-20020a25a1a7000000b00de553a624edmr2514259ybi.50.1713965690752; Wed, 24
 Apr 2024 06:34:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240422164658.217037-1-sui.jingfeng@linux.dev>
 <Zie3ebHOEpWHj1qV@smile.fi.intel.com> <d5bc1e73-a553-451e-ab74-f5f0ca259c6b@linux.dev>
 <hcltp2bbxxg2t7ibmzgiib7mgbwgmvzwnnq6mochdh7c4h76r3@bxj6yk5zq64e> <ZikE4qOVO7rgIs9a@smile.fi.intel.com>
In-Reply-To: <ZikE4qOVO7rgIs9a@smile.fi.intel.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 24 Apr 2024 16:34:39 +0300
Message-ID: <CAA8EJpr1FSjizAh6Dp5Bmux3NrGYh=BfHFL4D1fa87Og4ymY0w@mail.gmail.com>
Subject: Re: [PATCH v2] software node: Implement device_get_match_data fwnode callback
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Sui Jingfeng <sui.jingfeng@linux.dev>, dri-devel@lists.freedesktop.org, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Daniel Scally <djrscally@gmail.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 24 Apr 2024 at 16:11, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Wed, Apr 24, 2024 at 12:37:16AM +0300, Dmitry Baryshkov wrote:
> > On Wed, Apr 24, 2024 at 12:49:18AM +0800, Sui Jingfeng wrote:
> > > On 2024/4/23 21:28, Andy Shevchenko wrote:
> > > > On Tue, Apr 23, 2024 at 12:46:58AM +0800, Sui Jingfeng wrote:
>
> ...
>
> > But let me throw an argument why this patch (or something similar) look=
s
> > to be necessary.
> >
> > Both on DT and non-DT systems the kernel allows using the non-OF based
> > matching. For the platform devices there is platform_device_id-based
> > matching.
> >
> > Currently handling the data coming from such device_ids requires using
> > special bits of code, e.g. platform_get_device_id(pdev)->driver_data to
> > get the data from the platform_device_id. Having such codepaths goes
> > against the goal of unifying DT and non-DT paths via generic property /
> > fwnode code.
> >
> > As such, I support Sui's idea of being able to use device_get_match_dat=
a
> > for non-DT, non-ACPI platform devices.
>
> I'm not sure I buy this. We have a special helpers based on the bus type =
to
> combine device_get_match_data() with the respective ID table crawling, se=
e
> the SPI and I=C2=B2C cases as the examples.

I was thinking that we might be able to deprecate these helpers and
always use device_get_match_data().

--=20
With best wishes
Dmitry

