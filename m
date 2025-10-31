Return-Path: <linux-acpi+bounces-18396-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC9B7C23FB3
	for <lists+linux-acpi@lfdr.de>; Fri, 31 Oct 2025 10:02:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0220C1A64317
	for <lists+linux-acpi@lfdr.de>; Fri, 31 Oct 2025 09:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9670432E69E;
	Fri, 31 Oct 2025 09:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="mx/8I1W9"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8064332E151
	for <linux-acpi@vger.kernel.org>; Fri, 31 Oct 2025 09:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761901258; cv=none; b=V7CYX/oPFo9okStfkRZnWv2H6YiAE5d8M+9kvl9gj2mr411z9UOJ0whSNEhKqhRkQhdivmjdHJxMhnVsaZl9QcFh+EosmQ2DUMisgROb5Aok7wR8yAHW0LmncztHTe56am2afGj4TbNxGXABkikkT1wtBkf5C8LXaVIBIST3dC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761901258; c=relaxed/simple;
	bh=kfJpm0mLG9RdVDLearjYwAtnnJ9GdvDB4BJl81FcoME=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s9nMkbMn3ILrZbNEhVCcsQlHJbFB4vO48Fc/NdbwOiy2EDuEfNf4oYJ8Fib6euN3rPNKc3bVvur0VL35prmdpycNVFE3p3nGnKx1gyO5iSncO5gDhZg3Hhs6wkRAEY1Hz1dEsEcselsTQOxo7jBwfSXQRnAgnbSjhJnAHoPhS3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=mx/8I1W9; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5930e30857bso2720843e87.0
        for <linux-acpi@vger.kernel.org>; Fri, 31 Oct 2025 02:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1761901254; x=1762506054; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U2zWXQAb4J66gJtbZXDf79DLTVt9tmjwLAqTV9wFU9Q=;
        b=mx/8I1W9aWd83I/4PUh5rOijXjOuPVLCESJyddwTtK9pntRpbBCU5G9mBv/C1d4XpE
         Bvqu238tixij/r7x3kPS1kwgkpY/T6VfsJOuxfx/UaIbIqiTs26WoCJyxww5JYngUbCW
         guxez/lJ2ovjpTGkTY1pxPWkjJh4XsYlcowmu/gBi4zn1MF74n1HqXh+JRCj/BENonyc
         3cVz43n3WTzXNW19+QCoBxa4XK07S/iRPw8FxknaIjH9phvv5swro8ptOEhMlaabD7Pg
         rMOUHmpAoZPeMoBIdRvdfjJTynMfI7kHUUoXG1auoFSFpk6HRGlJaGM/yEGmB2bN4Z2n
         nlww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761901254; x=1762506054;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U2zWXQAb4J66gJtbZXDf79DLTVt9tmjwLAqTV9wFU9Q=;
        b=Rniin3gj6WPTeD1yFQOxt46Ao7QJe+VpgZYulKjiutAmAh2qtOG1ZU5UNDWn4w1RdW
         9lkk22KAl8PboOsNPboFk4G3Bl2aVYk36wNOLl/jYAIRc93MzhqyIMypEljB1rLaf6xa
         yAYC3gJLyN3vzlKVl5KiomOETC2oiGzvS+SU4ZXdQJgFG6BmPSEWlDogc2JTnfe5g87M
         3HMCUsRXpdzbvNCHOD7fqL+dKE08HAp7fYpElxgmHVfEENmJWcQI+3UIYavlBBG3Twlv
         Z7QiPx9vpyqC6Gk2ePi7D4Q2xqAnYrEvRdCpam3USozc5nkLuZ6QAOoXIJnwcxdh2jjo
         cH7g==
X-Forwarded-Encrypted: i=1; AJvYcCWWuG345jWaih8RPKdnycPyHVzJkAskRboLeBXsT1sMngjcojLeHX3dZogzavPGmR6zalBFAOwjE3uL@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4u7U2WKyKmejopmmyMm/6l/M5donni0172lh7Jo/ihPjeSMKz
	ufHcRl8R99EYLzf/7tswgoIJVFtr6TeMt1GtG+kmkZMXx82Y+kQdg6o2JbIXNvVD9PwT4ismhF8
	7Hn2oMi4n4SVBH7/9AzG/a0RittCF5BhIaxH2p3fvpg==
X-Gm-Gg: ASbGncsdm4JHu1UqKpE+9Dz0USxNZrkYzPl+nSfCDNgJ71KKZPNlyXhuKLe4ze6S0eU
	HNPLlAIv9QSA/QaxTDJsNBMFcDgR9qbAawCktUUI1pXMnRi/KUEJz7MqleQ2yc1taErR+9Gm9dz
	sGuCXtObj3deojGMm5ac2DRDzyFSRUiNXRROo91AcjrEjLcHIvIKrny772mlMxgNv5uwq7eAJZy
	iaYvBSH1J1Feg5+8VgOrr/7Ez/twLfE46Vdb3GZEOaYfGLoilVw1EQhR8mk82DrrHAyu1uhuspg
	383lGun0nwnC4oah
X-Google-Smtp-Source: AGHT+IH9CdyA/9CpR4yuZJkUQBQIcmzJf4sYm4WcPQACoUSrA5BoL7natdG3cIpjNxAp+exZosbxpHf54nNaLort178=
X-Received: by 2002:a05:6512:3e0d:b0:592:f9c6:9736 with SMTP id
 2adb3069b0e04-5941d563fdfmr953358e87.56.1761901249206; Fri, 31 Oct 2025
 02:00:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029-reset-gpios-swnodes-v3-0-638a4cb33201@linaro.org>
 <20251029-reset-gpios-swnodes-v3-3-638a4cb33201@linaro.org>
 <aQMy00pxp7lrIrvh@smile.fi.intel.com> <CAMRc=MdP58d=o7ZL4bAdsaYwzrs6nJo3bhS7Jf1UkDNwPOnAsg@mail.gmail.com>
 <aQRyFSHWzccTPa3M@smile.fi.intel.com>
In-Reply-To: <aQRyFSHWzccTPa3M@smile.fi.intel.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 31 Oct 2025 10:00:37 +0100
X-Gm-Features: AWmQ_bknobk-QJWbVtapIqlH_lufop-oiWv3enLciZJOoLidz7raNrtQVaowNic
Message-ID: <CAMRc=McT+Q8ZVk9_HTyWd6uS0OoP92E_phwef7CDyDVeNbJCqA@mail.gmail.com>
Subject: Re: [PATCH v3 03/10] software node: allow referencing firmware nodes
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Krzysztof Kozlowski <krzk@kernel.org>, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-acpi@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 31, 2025 at 9:24=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Oct 30, 2025 at 04:17:48AM -0700, Bartosz Golaszewski wrote:
> > On Thu, 30 Oct 2025 10:41:39 +0100, Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> said:
> > > On Wed, Oct 29, 2025 at 01:28:37PM +0100, Bartosz Golaszewski wrote:
> > >>
> > >> At the moment software nodes can only reference other software nodes=
.
> > >> This is a limitation for devices created, for instance, on the auxil=
iary
> > >> bus with a dynamic software node attached which cannot reference dev=
ices
> > >> the firmware node of which is "real" (as an OF node or otherwise).
> > >>
> > >> Make it possible for a software node to reference all firmware nodes=
 in
> > >> addition to static software nodes. To that end: add a second pointer=
 to
> > >> struct software_node_ref_args of type struct fwnode_handle. The core
> > >> swnode code will first check the swnode pointer and if it's NULL, it
> > >> will assume the fwnode pointer should be set. Rework the helper macr=
os
> > >> and deprecate the existing ones whose names don't indicate the refer=
ence
> > >> type.
> > >>
> > >> Software node graphs remain the same, as in: the remote endpoints st=
ill
> > >> have to be software nodes.
> > >
> > > ...
> > >
> > >> -#define SOFTWARE_NODE_REFERENCE(_ref_, ...)                       \
> > >> +#define __SOFTWARE_NODE_REF(_ref, _node, ...)                     \
> > >>  (const struct software_node_ref_args) {                           \
> > >> -  .node =3D _ref_,                                          \
> > >> +  ._node =3D _ref,                                          \
> > >>    .nargs =3D COUNT_ARGS(__VA_ARGS__),                       \
> > >>    .args =3D { __VA_ARGS__ },                                \
> > >>  }
> > >
> > > Okay, looking at this again I think we don't need a new parameter.
> > > We may check the type of _ref_
> > > (actually why are the macro parameters got renamed here and elsewhere=
?)
> > > and assign the correct one accordingly. I think this is what _Generic=
()
> > > is good for.
> > >
> >
> > Oh, that's neat, I would love to use _Generic() here but I honest to go=
d have
> > no idea how to make it work. I tried something like:
> >
> > #define __SOFTWARE_NODE_REF(_ref, ...)                          \
> > _Generic(_ref,                                                  \
> >         const struct software_node *:                           \
> >                 (const struct software_node_ref_args) {         \
> >                         .swnode =3D _ref,                         \
> >                         .nargs =3D COUNT_ARGS(__VA_ARGS__),       \
> >                         .args =3D { __VA_ARGS__ },                \
> >                 },                                              \
> >         struct fwnode_handle *:                                 \
> >                 (const struct software_node_ref_args) {         \
> >                         .fwnode =3D _ref,                         \
> >                         .nargs =3D COUNT_ARGS(__VA_ARGS__),       \
> >                         .args =3D { __VA_ARGS__ },                \
> >                 }                                               \
> >         )
> >
> >
> > But this fails like this:
> >
> > In file included from ./include/linux/acpi.h:16,
> >                  from drivers/reset/core.c:8:
> > drivers/reset/core.c: In function =E2=80=98__reset_add_reset_gpio_devic=
e=E2=80=99:
> > drivers/reset/core.c:958:52: error: initialization of =E2=80=98const st=
ruct
> > software_node *=E2=80=99 from incompatible pointer type =E2=80=98struct=
 fwnode_handle
> > *=E2=80=99 [-Wincompatible-pointer-types]
> >   958 |                                                    parent->fwno=
de,
> >       |                                                    ^~~~~~
> > ./include/linux/property.h:374:35: note: in definition of macro
> > =E2=80=98__SOFTWARE_NODE_REF=E2=80=99
> >   374 |                         .swnode =3D _ref,                      =
   \
> >
> > So the right branch is not selected. How exactly would you use it here?
>
> I believe this is an easy task.
>
> But first of all, your series doesn't compile AFAICS:
>
> drivers/reset/core.c:981:6: error: variable 'ret' is used uninitialized w=
henever 'if' condition is true [-Werror,-Wsometimes-uninitialized]
>   981 |         if (IS_ERR(rgpio_dev->swnode))
>       |             ^~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/reset/core.c:1001:9: note: uninitialized use occurs here
>        1001 |         return ret;
>             |                ^~~
> drivers/reset/core.c:981:2: note: remove the 'if' if its condition is alw=
ays false
>   981 |         if (IS_ERR(rgpio_dev->swnode))
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   982 |                 goto err_put_of_node;
>       |                 ~~~~~~~~~~~~~~~~~~~~
> drivers/reset/core.c:905:13: note: initialize the variable 'ret' to silen=
ce this warning
>   905 |         int id, ret, lflags;
>       |                    ^
>       |                     =3D 0
> 1 error generated.
>

You're not wrong but for the record: it builds fine for me with
aarch64-linux-gnu-gcc 14.2 for some reason so I didn't notice it. I'll
fix it.

> So, but to the topic
>
> I have applied this and get the only error as per above
>
>  (const struct software_node_ref_args) {                                \
>  -       ._node =3D _ref,                                          \
>  +       .swnode =3D _Generic(_ref, const struct software_node *: _ref, d=
efault: NULL), \
>  +       .fwnode =3D _Generic(_ref, struct fwnode_handle *: _ref, default=
: NULL), \
>

That works, thanks for the idea.

Bartosz

