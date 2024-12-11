Return-Path: <linux-acpi+bounces-10088-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B39F9EC76C
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Dec 2024 09:37:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7907816A4B5
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Dec 2024 08:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93AF81D6195;
	Wed, 11 Dec 2024 08:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="M+2GV2US"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165E71CACF6
	for <linux-acpi@vger.kernel.org>; Wed, 11 Dec 2024 08:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733906244; cv=none; b=LXUIlQuDAGaOAxRCIXIq8oMp73jF/gr/tXkK2qyShZd6/LQEBykWYuIZD7QK0uqHzmWXSFIYlXztz3fXObUfeKrBgiBwXZJ3wjxjYspfq/x8KeJ36GPi/i1UlE748oEJgtrHqYw9dhQpFEV3TvZ5zSN5zywseQbVMnPniGd6QxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733906244; c=relaxed/simple;
	bh=XBgmqrGOR+TiaTyhJ7G4EyEffKB3hn5wBPa+e60msYg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jSQQHnaD52DglBZ+VEcai559otUHCSiRqouKp1pT7uqU+lh8ifO96tjXW4WdddUfeFwVduiqEJmnGWpg8/MynwoTZcUoHR5WKJBiFoHFeL3ieIpgQmUrK5G1xyECFuTtMpCIxGTRDNMGHRDiP1ri+0bZVBGBEperCjdPwEi8ewE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=M+2GV2US; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-21619108a6bso37933845ad.3
        for <linux-acpi@vger.kernel.org>; Wed, 11 Dec 2024 00:37:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733906242; x=1734511042; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qbJ9A+m8ws44k2uM8AYTsZl/eWYOAV0rPVSUcQb9sbo=;
        b=M+2GV2USUjUURNNQOHKoxso/OSG5FCUmN5QKRjvSj0pgS6jmm7Z9PFl8232ZkIj7bz
         xBAdZKdS0IsHy40UYWfqDrusy8w0tfZ1NUSij5vs4Kw59w5fTg/O/lu383zdSLffo6A2
         Vb7xqLLSUTmlCDDht+QJ3ypyD4tdaoiq6SAt4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733906242; x=1734511042;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qbJ9A+m8ws44k2uM8AYTsZl/eWYOAV0rPVSUcQb9sbo=;
        b=XXDkvXFqPTEXe7BAkeWbdZB5WpJ6FA2bNiHSB++SrqY6WjXXhtXMWS4VPoKU6uzNp1
         MHiSwliVyVcuq/kpTMQ07smIMnLEDSLS/XAdRnhiXJS4/VF3ojRGd8VwwV97W5zNrKvA
         JV7ZBI+gJx/oYvc8xKui7ShwrIGufoCj9gMbpvUoYcNr+NenaSaudgUXX9vNoiriZPaI
         1LN0xctoTTMpxFFinam5XEGid6bONM1r42dls2aa6DS1+gl9r4PXaRWx46Y2CSfxK9zb
         FL0knjK0i3oikvSiI8E122uSN9gE83eZxxiwISRo+VXYF0mTNqChnud8l8N2ux1aS3c0
         YT3w==
X-Forwarded-Encrypted: i=1; AJvYcCVBC1o07xP6sLAWc3V18dwP+q7c0FdPNKYcmDCnuibLHZ2WUNNiEOUZ+ksr3ulJW5eqy61CLuv2YkvJ@vger.kernel.org
X-Gm-Message-State: AOJu0YyQ4+r/+HhMhqtKyw2Ygnc8f7yb5K5tkljPwDeW6JoSJRukUbxe
	OPfHu1fD8L+qvP093qUt9bCHj1YfmHaOqosfGlPoHtSTzY7FpS7ILsd1m49HJhfjG8fQGb7oKTg
	=
X-Gm-Gg: ASbGncvqi/S+9W1HaKcqaNYuOnYUqhqb7ZN/EpQmOcg+BP7Cl7LruC+VKhwdKiVj7ZX
	NybDX3AgMrSQAnyn/DXUXbnhRj3foz5lHOaXZe026kc3qhnrEaIEn7ck5OW6T3udTgMU9LHakqx
	GzAz56sYjrER7zQn8hfqbKtFqNQKYlMqQrSJvrNAqV5ndZ7addfG7k1X5z/ackNKv0r8jZRbmkI
	o43X2SPKDXj4apGTWyo+4xXQs1A5mwK+5SDIh8bf4RD0sMd1A2DeJckXSHrKee5ZLaUeOSIKAkY
	aFZjijI+qCoAjxo3
X-Google-Smtp-Source: AGHT+IHoDhb+PaM59+jBILIKJ2hlCxqFe/W/055KiyUDzOz7pBQySROKaYjMnEWmDhmYQwvzoPswCQ==
X-Received: by 2002:a17:902:d4cb:b0:216:6855:15f with SMTP id d9443c01a7336-21778699ca2mr31154675ad.51.1733906242242;
        Wed, 11 Dec 2024 00:37:22 -0800 (PST)
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com. [209.85.216.53])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-216637467aasm38767085ad.49.2024.12.11.00.37.20
        for <linux-acpi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2024 00:37:21 -0800 (PST)
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2ee51f8c47dso4744696a91.1
        for <linux-acpi@vger.kernel.org>; Wed, 11 Dec 2024 00:37:20 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVhkLGlt5hYzOoV8XfnEE/KYcO90hpppowaqeZb0Tkw3+o3mhzE88zPkuIgfRyq3/eUO9w6CUIQxLv6@vger.kernel.org
X-Received: by 2002:a17:90b:4c84:b0:2ea:aa56:499 with SMTP id
 98e67ed59e1d1-2f127f555a9mr3269053a91.1.1733906240145; Wed, 11 Dec 2024
 00:37:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241210-fix-ipu-v3-0-00e409c84a6c@chromium.org>
 <20241210-fix-ipu-v3-7-00e409c84a6c@chromium.org> <20241211091954.42a5c778@foz.lan>
 <Z1lOCGJvgFcqmR3R@kekkonen.localdomain>
In-Reply-To: <Z1lOCGJvgFcqmR3R@kekkonen.localdomain>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Wed, 11 Dec 2024 09:37:07 +0100
X-Gmail-Original-Message-ID: <CANiDSCvPNf2KiEpr6Tboon6bjUxwEkD=+_AQjhiOA7RDTTpnCw@mail.gmail.com>
X-Gm-Features: AZHOrDlaYtacxTR4SrQpC121lb8rk1oSdpiMfzTs7ikEYNouO9W71c6h8nTE3PY
Message-ID: <CANiDSCvPNf2KiEpr6Tboon6bjUxwEkD=+_AQjhiOA7RDTTpnCw@mail.gmail.com>
Subject: Re: [PATCH v3 7/7] media: ipu-bridge: Remove unneeded conditional compilations
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Robert Moore <robert.moore@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
	Dan Carpenter <dan.carpenter@linaro.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
	acpica-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Wed, 11 Dec 2024 at 09:32, Sakari Ailus <sakari.ailus@linux.intel.com> wrote:
>
> Hi Mauro,
>
> On Wed, Dec 11, 2024 at 09:19:54AM +0100, Mauro Carvalho Chehab wrote:
> > > @@ -768,15 +755,10 @@ static int ipu_bridge_ivsc_is_ready(void)
> > >     unsigned int i;
> > >
> > >     for (i = 0; i < ARRAY_SIZE(ipu_supported_sensors); i++) {
> > > -#if IS_ENABLED(CONFIG_ACPI)
> > >             const struct ipu_sensor_config *cfg =
> > >                     &ipu_supported_sensors[i];
> > >
> > >             for_each_acpi_dev_match(sensor_adev, cfg->hid, NULL, -1) {
> > > -#else
> > > -           while (false) {
> > > -                   sensor_adev = NULL;
> > > -#endif
> > >                     if (!ACPI_PTR(sensor_adev->status.enabled))
> > >                             continue;
> > >
> > >
> >
> > Considering that you drop patch 1, and keep the ACPI dependencies
> > at the header, as proposed by patches 2-6:
> >
> > Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kerenel.org>
>
> The 1st patch fixes a compilation warning when CONFIG_ACPI is disabled.
> Merging that patch as a temporary solution is simply easier than making
> arragements for merging the ACPI patches to the Media tree so the last
> patch may be merged, too.
>
> Besides, the fix should also be backported.
>
> Ricardo: how about adding Cc: stable for that one?

Adding:
    Cc: stable@kernel.org
    Fixes: 8810e055b575 ("media: intel/ipu6: Fix build with !ACPI")
to v4

Regards!

>
> --
> Regards,
>
> Sakari Ailus



-- 
Ricardo Ribalda

