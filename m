Return-Path: <linux-acpi+bounces-18154-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D578C01DF1
	for <lists+linux-acpi@lfdr.de>; Thu, 23 Oct 2025 16:45:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAC013B45AF
	for <lists+linux-acpi@lfdr.de>; Thu, 23 Oct 2025 14:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E99D32D433;
	Thu, 23 Oct 2025 14:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rLebnEoi"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680FC32C33E
	for <linux-acpi@vger.kernel.org>; Thu, 23 Oct 2025 14:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761230252; cv=none; b=ALbQ0jCfl0gAkUOuFGDiHgKKLarFXoQZtg6x+GI2ed66G4K8y/kgIGWz4SwLqZV6eTwEpwVGFWor4j3yL70ydBQD4Wp/nRe19EtwWiLLb9LHDclXucKApDBFDI+lgSR0JKdVRZcdvViIFATsqlEua2WEvDObZWOe1vg63+23Rks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761230252; c=relaxed/simple;
	bh=nmuhkbmYIHwlo0bTfpa+yRu9VeKXePgg3mUVlnPW/hk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SkkEqYL9naAPsot6FH6twAWN6XFCLnOJz6oZ9ow+EVdO3Okz1k79JUt6ux8Uug5qPOLIO1MncFwNklX7/tNp92J9Da4if215LUY1sBUzNztGCt+q5sp6xR23e3VZYA/aLWIswuMpwkkQR0SHN4vTeYn77NvUDOCm/TDnEHTdcXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rLebnEoi; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-63e076e24f2so1907213a12.3
        for <linux-acpi@vger.kernel.org>; Thu, 23 Oct 2025 07:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761230249; x=1761835049; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ee6AwS0Oh4FU6B7RPC1MCPwDY310ZfKGYiiyM7hDKvU=;
        b=rLebnEoi3xAthwvzlwYlMIp+nhcTKXkzb9pNLATNIEs800jS4/28MdR9dyENRY2owv
         q7lbFDtUtZsmz6cfTdsy2EvVhSLjTFXLca+O9RehRzrUYCY0ZxbQ+U9BLD25rkKVj02B
         Mpp+qGmY46hwujcGpBHFfc9R5nOXb8BaGW993QK6lHC9Q+bpAFQSfc9tV4i2jENH6n2Y
         TFydqP6qzOtPJQbi4wp4rQ0NZUVkWd9RNqZ7vAm8veLrNRvWbKHK99LRRT+yZaeKlpOb
         8Cc/EGUN+KxrVpUmzepIrXvkXD3eba/azHI0KEoLcfrnKFLEm4Q3ltnKMMxC+lCZQMqI
         qPLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761230249; x=1761835049;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ee6AwS0Oh4FU6B7RPC1MCPwDY310ZfKGYiiyM7hDKvU=;
        b=kyPPcWqCouUupNeHaWv+bJQOeqqELoMt/5ngx+Ltupr0nYyMlhi9FNLiiSBkdRdO/j
         OJxIqYLmI8zcv1NhWXj3voYH/s5SM4sJeX9/vYlMe1Usq2sOn6xX8Fm6gr8SDlQpfdJd
         fixEFSBI+AOq5AoNMuAc4zcl6S7WT9yq7SMs1iyTbmVf9hP4Pcy3CB6Cv92X15HwHXRt
         43zW8gZzj2v3stG0p+qLA0VfG9oqFqA844vmpnOaTLzdAxmHubdgh8AhMRKr6H0alQAt
         Rap45VAxFnqzlGuQQTUfwExFM0/FepSikFMP6rEFZaEGiN7yEsxvLABy2RBHPKm63DL+
         TvIQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7guyVjKGwDnO9QLNqG/2o7YTZMVhzDIDMxUvF462xnwQxUxE0qE/tkM3yVzHz1vsDPgbyxq7QbT2b@vger.kernel.org
X-Gm-Message-State: AOJu0YzsxGwW0l5HgbEafmcvhdsiNIMxQPIjubZ11JfaJ63IVfOWptFk
	4W/hV6KTP8d1+QB6YfYqNYxYdZ65XKgnyTRWC+4XyHQ1H8C1/K1UxvxzKnbwn3IfTtoAbYKY7ra
	xcWeYZovpMWPbXVuMjrEqz3YuIRjdD9c7ZeEeO2Sl
X-Gm-Gg: ASbGnctY3wCXwXgYbh9JKTWZ6+AvAnbNwqoyh0urFxxRzEE08pGlFVCc0vjVy5JCvUv
	ncRitvBAaZhLClpEop3TCXsIB3mOB/yfQzMkrlR6xk643YO5PKTFFBEpkWrEkcubiT/w+77k2Pa
	/AMpJdaJCG6M0emafr/JnjL0o0pFDwi0vub+vnUGxukkiFWp9ZbXtSQHdkp9BYlqjg1HPfwjWZr
	+lscz1FKd0XqfmtkCtmavr0cblzVO9vUDzDuSKXpBPgMcQzIXjHvONX5ysZ1FCXLzdvM2yZ
X-Google-Smtp-Source: AGHT+IFbp9ZMt0Cy9ClZs0lHFOJ9QBTf1Z2cJvn57Dc7ncVUrW+Ms8Oh3ADagb0PL+IsUmXpI99hN+aEX8b0luZ9bjY=
X-Received: by 2002:a05:6402:5656:b0:637:8faa:9df7 with SMTP id
 4fb4d7f45d1cf-63c1f6cefdamr18256821a12.29.1761230248590; Thu, 23 Oct 2025
 07:37:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251002113404.3117429-1-srosek@google.com> <20251002113404.3117429-5-srosek@google.com>
 <CAJZ5v0is66vO05fbxooRxkn_wAZr_g9Wr-D-RtFH32gNzE726A@mail.gmail.com>
In-Reply-To: <CAJZ5v0is66vO05fbxooRxkn_wAZr_g9Wr-D-RtFH32gNzE726A@mail.gmail.com>
From: =?UTF-8?Q?S=C5=82awomir_Rosek?= <srosek@google.com>
Date: Thu, 23 Oct 2025 16:37:16 +0200
X-Gm-Features: AS18NWCacGG2PPS7_pVbR5EN39z6gluv3FRZP2OC0tyFulfV8k4iQblvSkQOwk8
Message-ID: <CAF3aWvFwJqMK7sGY97Wy=Ja7+=CnWnS3yDS4M4G4mEPZNSeL=A@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] ACPI: DPTF: Remove not supported INT340X IDs
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Alex Hung <alexhung@gmail.com>, Hans de Goede <hansg@kernel.org>, 
	Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>, AceLan Kao <acelan.kao@canonical.com>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Zhang Rui <rui.zhang@intel.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Tomasz Nowicki <tnowicki@google.com>, 
	Stanislaw Kardach <skardach@google.com>, Michal Krawczyk <mikrawczyk@google.com>, 
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2025 at 8:48=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Thu, Oct 2, 2025 at 1:34=E2=80=AFPM Slawomir Rosek <srosek@google.com>=
 wrote:
> >
> > Remove not supported INT340X and Wildcat Lake ACPI device IDs
> > from scan handler.
>
> I guess "not supported" means "no driver binds to them".

Right, I will clarify this.

>
> > Fixes: 3230bbfce8a9 ("ACPI: introduce ACPI int340x thermal scan handler=
")
> > Fixes: 9cf45756a4b9 ("ACPI: DPTF: Support for Wildcat Lake")
> > Signed-off-by: Slawomir Rosek <srosek@google.com>
> > ---
> >  drivers/acpi/dptf/int340x_thermal.c | 6 ------
> >  1 file changed, 6 deletions(-)
> >
> > diff --git a/drivers/acpi/dptf/int340x_thermal.c b/drivers/acpi/dptf/in=
t340x_thermal.c
> > index 26522ddfcbaa..7d1308b1f513 100644
> > --- a/drivers/acpi/dptf/int340x_thermal.c
> > +++ b/drivers/acpi/dptf/int340x_thermal.c
> > @@ -21,12 +21,6 @@ static const struct acpi_device_id int340x_thermal_d=
evice_ids[] =3D {
> >         ACPI_INT3406_DEVICE_IDS,
> >         ACPI_INT3407_DEVICE_IDS,
> >         ACPI_PCH_FIVR_DEVICE_IDS,
> > -       {"INT3408"},
> > -       {"INT3409"},
> > -       {"INT340A"},
> > -       {"INT340B"},
> > -       {"INTC10FF"},
> > -       {"INTC1102"},
> >         {""},
> >  };
> >
> > --
> > 2.51.0.618.g983fd99d29-goog
> >

