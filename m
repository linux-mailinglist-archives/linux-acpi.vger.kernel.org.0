Return-Path: <linux-acpi+bounces-19065-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BD49DC6D69B
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Nov 2025 09:28:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id D20E82C3AD
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Nov 2025 08:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08F1930F542;
	Wed, 19 Nov 2025 08:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="j4uSMDHh"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4983C312816
	for <linux-acpi@vger.kernel.org>; Wed, 19 Nov 2025 08:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763540911; cv=none; b=HV99nuv4f/wVnEW68EfvXOSrmfow5+z/bHaNFTUwFCxk8JoOwwbH+GkL6BA7ExnAvvRYh70m2ZYVZFdjqNrgOCYdVIXAn72kOU4syeSYYO5RCzBsAyVOhIeUbh58CAZSnxzvJbgWE1xcqhMoZ86aYnspas2gZww5VcrmJ3jhbmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763540911; c=relaxed/simple;
	bh=lmYLzH/vRCoZWx9GcCIPbhMdAPwmlKzUuFFCbm/YiSc=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KHQn1UOt0ndi7S7dl/prK6YrmlizURNwhQtcIa0ppCoZbAXnbdMKQRCTUocQRxxWONutW5MTVM5CxZd3E1K2YBHaZZu6KeaNKx2LlnmrH/qKqL1d6sriu+WQact4oNpS1Pq2UtQ3IpamVrgcS39+IxFrmYW49yXaXqtuCCisF2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=j4uSMDHh; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5959105629bso3355253e87.2
        for <linux-acpi@vger.kernel.org>; Wed, 19 Nov 2025 00:28:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1763540908; x=1764145708; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:references
         :mime-version:in-reply-to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dVGbJbobGW41//3xdSH+mnA69VzyuyVEuHOyjqTZEfQ=;
        b=j4uSMDHhKuGfkXFm/jGGtFOopWHL4y3FEgrH8YLbdPkbqvQMAJVvctf3BZxRlRnGXr
         K21lxm9aUputxVaIB2j8HKSql758N3mzXHifvW5FaTk7nmnwBSg97AK4cJEFgwDk/zrC
         UsxwZE7EeTarqF7RKvMUXXa3uY/fN5gswfzQ5lN6Uyh451AL9ZIHjKCK2okh3JSFTipd
         el5VtBOH7Y3vSJ5+sjRk8BaqsDyMKpGqWr4h11lhBGUm1ZAG9NOxTW6EQUYdGsq6zP/R
         2sqIz6aREiNqShslQPm5pimcYrSE/vFmvAp0hKC2/IVcBqhkC/MT4RmTANSOPKCWGnJj
         5HnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763540908; x=1764145708;
        h=content-transfer-encoding:cc:to:subject:message-id:date:references
         :mime-version:in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dVGbJbobGW41//3xdSH+mnA69VzyuyVEuHOyjqTZEfQ=;
        b=AAjJZPFbd9zE2lJ8rrJ4e36q5gCK1vYpjRCLjniiv002lyKr4blUVBH3IVL37pk8tD
         OBBMUnp3U+uDL3rjhHwXwh+L4TC+FXopLLUnwQp3e50QmwxCnM7CiecWKbLCGnwA0x19
         mt6cJqFTPgtLQFTr/U0tv3uYye7dYrmdyFLeM4ZlZkBnJtROXYI+tPn+8i1CcuwbEPdN
         u2Gc2njpN0S/9ZbiOmJ6eTTINRzyZZEKQyqZRTN0shwRKeDkKfd9cAGjqoFYfqqzODWY
         um7Cmows5l1dt5uCsdZNmFlLkZTtXlpIWS+Hvm3Z55wu3w6NOOBtjkjM0o24CX+nUrKL
         50iw==
X-Forwarded-Encrypted: i=1; AJvYcCXhrIwoFo2urqRZuGnFZxFweX0o9n4c3+ENsy9Wr4nSeMPWlsZpRY7xVShJcR3pLtdtiJ3YTJC6YHBH@vger.kernel.org
X-Gm-Message-State: AOJu0YyP5V1BKHbF1Wjvh5r4crD/kV0D2+Z/sdCdBwVQkpUE9DjoRSH8
	htGFb5amafm1zFxO/y7IY1k3KFMtLEWN3WVGN8lMo/8iMX/mjg8I2p73VIWG17I767rsSmdQCen
	T4PYdypGzqA9n8xucfW3MIbJIhDLsXyEb00J01U+iMg==
X-Gm-Gg: ASbGncsm1oEAz2NdNTailG+GRkkgeDL3VpWVLPIZFUNvU4bJDo7wibOmChztnM3hF4R
	kL/XIV2LtvOBg67JnWU+ti+D83O2FtHlONSR0luTEJh+XW0t/2VPIWbTTXGnN0J0JU243F+wT29
	pim8RxGvdqMizqaXjv5goOn8B6vhPMNSkE2xnql127ysQav5g1aBBmveUvSasvsq421x1WCCcM/
	qa2rONyHavoSfFjMISbMUGkRyHqqd9G8+RPdRINvO6Ytt50NPorvDpEb/2WK/e9yEsvpx4cWfSD
	NCP7YgVYpcKl+ExSeGkHVeiBTsi/Nh03mZA5Vw==
X-Google-Smtp-Source: AGHT+IHpIKDQdDCuSD5aC6RJDCP4olJa23kIDa27jGhFcUPgUnvS6nsKicP7DS5dN2M1XRORlBy+CmfgfEm+EF+jvpo=
X-Received: by 2002:a05:6512:63d1:20b0:596:9bfa:91a4 with SMTP id
 2adb3069b0e04-5969bfa92d1mr161624e87.2.1763540908313; Wed, 19 Nov 2025
 00:28:28 -0800 (PST)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 19 Nov 2025 00:28:26 -0800
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 19 Nov 2025 00:28:26 -0800
From: Bartosz Golaszewski <brgl@bgdev.pl>
In-Reply-To: <c8aea0bd3907957a6f40078e1198959cd8c0d613.camel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251106-reset-gpios-swnodes-v6-0-69aa852de9e4@linaro.org>
	 <20251106-reset-gpios-swnodes-v6-8-69aa852de9e4@linaro.org>
	 <0d251a35a438ebf3e14c6762df7ece079ee1d164.camel@pengutronix.de>
	 <CAMRc=MfAw-HyofSL52PY0H57rBJZAo215gryxWyS8x-d+wcjRg@mail.gmail.com> <c8aea0bd3907957a6f40078e1198959cd8c0d613.camel@pengutronix.de>
Date: Wed, 19 Nov 2025 00:28:26 -0800
X-Gm-Features: AWmQ_bnYJGMomsJM1ilqgm7pNysW9ersB2afvl4w1mIrbhuwPT8nNrRhok8Mnxc
Message-ID: <CAMRc=MfsyZ3wqMSQ9jcTFHp2RUrZ=Ge1xdPY44VAGqJ9_XD7QA@mail.gmail.com>
Subject: Re: [PATCH v6 8/8] reset: gpio: use software nodes to setup the GPIO lookup
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Linus Walleij <linus.walleij@linaro.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 19 Nov 2025 09:19:30 +0100, Philipp Zabel <p.zabel@pengutronix.de> =
said:
> On Di, 2025-11-18 at 18:08 +0100, Bartosz Golaszewski wrote:
>> On Tue, Nov 18, 2025 at 5:44=E2=80=AFPM Philipp Zabel <p.zabel@pengutron=
ix.de> wrote:
>> >
>> > On Do, 2025-11-06 at 15:32 +0100, Bartosz Golaszewski wrote:
>> > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>> > >
>> > > GPIO machine lookup is a nice mechanism for associating GPIOs with
>> > > consumers if we don't know what kind of device the GPIO provider is =
or
>> > > when it will become available. However in the case of the reset-gpio=
, we
>> > > are already holding a reference to the device and so can reference i=
ts
>> > > firmware node. Let's setup a software node that references the relev=
ant
>> > > GPIO and attach it to the auxiliary device we're creating.
>> > >
>> > > Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
>> > > Acked-by: Linus Walleij <linus.walleij@linaro.org>
>> > > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>> > > ---
>> >
>> > I'll apply this with the following patch squashed in:
>
> Strike that, I'll have to wait for the SPI issue to be resolved.
>
>> > diff --git a/drivers/reset/core.c b/drivers/reset/core.c
>> > index 3edf04ae8a95..8a7b112a9a77 100644
>> > --- a/drivers/reset/core.c
>> > +++ b/drivers/reset/core.c
>> > @@ -945,7 +945,7 @@ static int __reset_add_reset_gpio_device(const str=
uct of_phandle_args *args)
>> >         of_node_get(rgpio_dev->of_args.np);
>> >
>> >         rgpio_dev->swnode =3D fwnode_create_software_node(properties, =
NULL);
>> > -       ret =3D PTR_ERR(rgpio_dev->swnode);
>> > +       ret =3D PTR_ERR_OR_ZERO(rgpio_dev->swnode);
>> >         if (ret)
>> >                 goto err_put_of_node;
>>
>> Huh? Why?
>
> PTR_ERR(ptr) is just (long)ptr, so a valid swnode pointer makes ret
> non-zero and takes us into the error path. PTR_ERR_OR_ZERO() includes
> the IS_ERR() check and returns 0 for non-error pointers.
>
> And there is a (false-positive) sparse warning:
>
>  drivers/reset/core.c:978 __reset_add_reset_gpio_device() warn: passing z=
ero to 'PTR_ERR'
>
> I think it would be better to return to the explicit IS_ERR() check
> from v5.
>

Yes, it was like this in my initial submission and seems like it's more
readable and doesn't cause this confusion. I will go back to it. Though
I'm not sure if the SPI issue will require a v5 - I'm looking into fixing i=
t
in the affected driver.

Bart

