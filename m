Return-Path: <linux-acpi+bounces-10274-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2662B9FAA18
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Dec 2024 06:55:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 870C5164EA2
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Dec 2024 05:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A127184E0A;
	Mon, 23 Dec 2024 05:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NKRfP4lN"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4C4848C;
	Mon, 23 Dec 2024 05:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734933301; cv=none; b=kQLI/GbfhgRNe7jbKD/jLzgEArV4Ck9vbPyumKqv9E7QC7Yqh/aRmGriSuv7B8r/zZ5UBJMoxftAzV+ry1aH21Qnq+9Nx6nKnbqghH8dSP0TCAvWYREqrdu9fBZ7s0iwRLu7ungTk2QPNcwHtlMhU0cQGNtw0kEm+Rm5yRO9kBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734933301; c=relaxed/simple;
	bh=ZJVOkgFLd0Y+Ea6jVJaX/EpXfP1cUhUToodwA5hjz7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HzagTbp0AhAjuRinlpxJ4QRoFJPRydHaJI9bEFVO6IThSGlIL5FaNjU8V+LGVSz1NnVNTquqXlKVsRzO59n6IJm27p6iJn09NZFHB+8/Zv8GbQTowsoyRMqXxuNc6v949TwerGF162wv5RLvHJFcDLnFfS8Sy78/y18+Y0Q+ifo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NKRfP4lN; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e387ad7abdaso3567435276.0;
        Sun, 22 Dec 2024 21:54:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734933299; x=1735538099; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=td3BchGiN0Y2T1FyIeHhP2Qs9BYr17m94w3ji2wgySk=;
        b=NKRfP4lNMoUPaEk+YUA3sWkrub7NB5c1bWfqGGcAuq8ghlriCFOyzo+oN4puBrk7tA
         0ZdnJ8dj59p3ovCgMqjDZbvlLCdKEncpWYPU3zKRgeDLe9IUxBISidJP8RrKPsFS3Okm
         gDw3mQUIDZJxF9pUUNDLDc5ajrEewnEK3/uU5x7JMk+dEiYZxpg6vOXYM0EUHCh6S2IM
         OxY+f/gb3q6HrqWvCOCvvgd3jIJT2JZVJgHe9z0tgWlZAkJmt4y+YbUPMwSQ0FHhgZRi
         i3QBzDrQieUb7E8ZTXdTpGI2W3nsAAZ4NLL+N0P8nQLrPI+GsSTOnX0YhnAjmNay+9b6
         iDlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734933299; x=1735538099;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=td3BchGiN0Y2T1FyIeHhP2Qs9BYr17m94w3ji2wgySk=;
        b=Us23XTwCnU8Bq8btYCRPedtw2JSMIPcTQ6wkMSwe5uAXsXzS+UlY4vTFWoxmUYXwSq
         RIaqykciRG+3tNjA9n4gA9oZ24vu1+5cdj9pibO0jTVv5PknKQkA3b7eZlMkFiuFsDJP
         Fjxbxsv7um6l6Xiyh3H+M+M6+Frcei7SXJLmsfWnDRDfhFDoBPNBVzpfOjD+xXBDNxXV
         iYI+EkZbZfZvCquxwLcFm8X0n3gpnTAerNO95dBS9+4jpkGfkdSwM+EIe34UHLn65qIF
         i8LOnvqlkJSH2y335unokl+uDl4XU5HDQNZjSOJTxmrn9zZA5IglvyXSii3XyBT296KE
         l8TA==
X-Forwarded-Encrypted: i=1; AJvYcCUADXeVXUP4gewsBcxC2H8rK6xf2sNae7VreWoiI05cgBQ0yKLpzEISApewZIMUbpHHgY6Va4Scqky/@vger.kernel.org, AJvYcCVUPIxt1/++wvKy7kBXaWHnfynOPH9siLa+3YjvzvdwFPla9eMXKl/HgnwMkCnBoQjZ2gJOKXhWct4JxMO6@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2MK3gq4IWRPrt3v+ghEM1dB/fXrMMxSawehqgGSNC4EAK09Pl
	5PlM8AXOH6YlJgKJM8IwCJs6OzTvhuGmyqCAoybta8vQcdIibFWBEdRmHg==
X-Gm-Gg: ASbGnctL+tKrteUfRUbk8QUOh7yBzGUddrFIW8mnp5SigX8X32LrllgbW99shfUa7zN
	iJyZuhGsubnihZpHasBN/kgFe+5fVf/RGeq/u97N2eb5965xUVYWE9seZbwdkQ7sJBAi43ljsgk
	aIepL9O3O673iPqXBcxe8ks5TVXN6fonWQS4BbJtBptSKwjd9rt8JeZPjqnk6YmKKlwO/tlJ8H6
	u4fgok0xX/XnSHTfETa6hreJc7BPFJLip8roqTDW8IcWb35Uz88+Q==
X-Google-Smtp-Source: AGHT+IGsFRPjGmU2jUQUncJajK9khnE2ittP0pIrAS4W9FuB6bkWLjdialS0cef7hyRF/XMa2E8HRw==
X-Received: by 2002:a25:1544:0:b0:e47:f4e3:8800 with SMTP id 3f1490d57ef6-e538c235df5mr6531636276.16.1734933298778;
        Sun, 22 Dec 2024 21:54:58 -0800 (PST)
Received: from alphacentauri ([2800:bf0:82:1159:1ea9:11b1:7af9:1277])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e537cf46b5bsm2295342276.37.2024.12.22.21.54.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Dec 2024 21:54:57 -0800 (PST)
Date: Mon, 23 Dec 2024 00:54:54 -0500
From: Kurt Borja <kuurtb@gmail.com>
To: Armin Wolf <W_Armin@gmx.de>
Cc: platform-driver-x86@vger.kernel.org, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, Mark Pearson <mpearson-lenovo@squebb.ca>, 
	Mario Limonciello <mario.limonciello@amd.com>, Hans de Goede <hdegoede@redhat.com>, 
	Gergo Koteles <soyer@irl.hu>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] ACPI: platform_profile: Add
 devm_platform_profile_register()
Message-ID: <w2pu2epu4ly5s3rmvuh3vcnsm5vyonxbcvz3po57dwiikfpdsd@x3uldtjpzwmr>
References: <20241221070817.3764-2-kuurtb@gmail.com>
 <20241221070817.3764-4-kuurtb@gmail.com>
 <5f173547-f643-4ac1-919b-cd864b2969fe@gmx.de>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f173547-f643-4ac1-919b-cd864b2969fe@gmx.de>

On Sun, Dec 22, 2024 at 11:09:44PM +0100, Armin Wolf wrote:
> Am 21.12.24 um 08:08 schrieb Kurt Borja:
> 
> > Platform profile's lifetime is usually tied to a device's lifetime,
> > therefore add a device managed version of platform_profile_register().
> > 
> > Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> > ---
> >   drivers/acpi/platform_profile.c  | 27 +++++++++++++++++++++++++++
> >   include/linux/platform_profile.h |  2 +-
> >   2 files changed, 28 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
> > index 75a1415190ac..d0c88decef8b 100644
> > --- a/drivers/acpi/platform_profile.c
> > +++ b/drivers/acpi/platform_profile.c
> > @@ -519,6 +519,33 @@ int platform_profile_remove(struct platform_profile_handler *pprof)
> >   }
> >   EXPORT_SYMBOL_GPL(platform_profile_remove);
> > 
> > +static void devm_platform_profile_release(struct device *dev, void *res)
> > +{
> > +	platform_profile_remove(*(struct platform_profile_handler **) res);
> 
> Please introduce a local variable instead of using a convoluted cast like this.

Sure!

> 
> > +}
> > +
> > +int devm_platform_profile_register(struct platform_profile_handler *pprof)
> > +{
> > +	struct platform_profile_handler **dr;
> > +	int ret;
> > +
> > +	dr = devres_alloc(devm_platform_profile_release, sizeof(*dr), GFP_KERNEL);
> > +	if (!dr)
> > +		return -ENOMEM;
> 
> Maybe it would make sense to turn dr into a normal pointer? AFAIK there is no benefit in
> having another pointer if we can just use the original pointer.

Please, tell me if I'm wrong. devres_alloc returns a pointer to the data
buffer of the devres struct and the handler is already allocated by the
driver, so the only way to store *pprof is to have dr be **.

> 
> Thanks,
> Armin Wolf
> 
> > +
> > +	ret = platform_profile_register(pprof);
> > +	if (ret) {
> > +		devres_free(dr);
> > +		return ret;
> > +	}
> > +
> > +	*dr = pprof;
> > +	devres_add(pprof->dev, dr);
> > +
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(devm_platform_profile_register);
> > +
> >   static int __init platform_profile_init(void)
> >   {
> >   	int err;
> > diff --git a/include/linux/platform_profile.h b/include/linux/platform_profile.h
> > index 0682bb4c57e5..d8114435865b 100644
> > --- a/include/linux/platform_profile.h
> > +++ b/include/linux/platform_profile.h
> > @@ -41,7 +41,7 @@ struct platform_profile_handler {
> > 
> >   int platform_profile_register(struct platform_profile_handler *pprof);
> >   int platform_profile_remove(struct platform_profile_handler *pprof);
> > +int devm_platform_profile_register(struct platform_profile_handler *pprof);
> >   int platform_profile_cycle(void);
> >   void platform_profile_notify(struct platform_profile_handler *pprof);
> > -

BTW, I just saw this -. I'll remove it on v2.

> >   #endif  /*_PLATFORM_PROFILE_H_*/

