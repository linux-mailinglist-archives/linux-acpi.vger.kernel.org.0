Return-Path: <linux-acpi+bounces-14762-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AC82CAEAE5A
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Jun 2025 07:09:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34EAC7A5ACA
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Jun 2025 05:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BDCA1DDC18;
	Fri, 27 Jun 2025 05:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="addMr8tI"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABCE01D63FC;
	Fri, 27 Jun 2025 05:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751000938; cv=none; b=AGATLU225+tqbU2qmmedUQgGc9RSjutR1m2+iacLZZ+0fGvM6OWqeDIkZVVQpeX6rpyRuye5yyS35PlSW1laSh1ddYHZrWHA9893Y2k0WvRpWlGbT8xHqK8sd5H39dwvRNUeAlcuPWNp9uzXp1T/gfu+rr3tMlpGW1fLLX8aWo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751000938; c=relaxed/simple;
	bh=GGD3kjPxzyXXHzWHeMkLRj2W5+J8c35toNNTgt3aUrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KRAAQtMVKrJ/X4cYEXLu/xKZ7GflwZ2ImfK7ULiFUdhmR4fDhoA0ctvXDJAy00ieceeNe9b0CP/PGvnsjgErzXa9ue/Q12047vPgkWTDL+oPD07JjlbdHi3RHcqNFoXZRlOJu5GBPU1ZR7dS2raFmVaQtEPaZ49oTrAkA55Eqjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=addMr8tI; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3137c2021a0so1531187a91.3;
        Thu, 26 Jun 2025 22:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751000936; x=1751605736; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qzYHBJyZhW0vPsWk1sR//L1GcVn+VNgmG8IeMnrCWM4=;
        b=addMr8tI09H67dLeaAQP0gij9OXMSElKMfFqi6vWTkzeLPHqRCPIX3B00KxkaTZ318
         YNZyStwkq+QNGp7PRGJqEifcgGUKXfPYTCB3R6oapBuTZVO4H+8G/BrKZzSzmJlvqW8E
         YwqQ/XFKonInfcP3K9e9lMWqTQYz3D1gSqoY2RSE1mMAW0SzQLcwfojoEP6CqbhiAKSV
         Qe99V4otxnMpUmBzfhzOWSQFAd/TJSNuWKIbA8ZKJrpwZ+eU0RyDprsARkHDI3mnJc+P
         SoY/WXrxjXs29tu8EdFo3e1nsqouA2ykFD7VvOuKmudolgs1j4TTKnICt7pjuL7yrlEL
         soWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751000936; x=1751605736;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qzYHBJyZhW0vPsWk1sR//L1GcVn+VNgmG8IeMnrCWM4=;
        b=pS/iBFT2PZO4L81qyZPxOZZo2W1VG3HrJ9d+F978J4dTXOnQIop2RMmKm9Naf8cR3H
         vXcAGQFDwzKrL+3tw8qLcaiWEVGCyWGPSZKAsE14GOHuqu7HP5ovr3oFsCWUNBcOzJPg
         6Tjs7MhK7/rJd/vRG2vpNTObXfpvR47MJucfvHfm8EZccO1rj/mATLvnLVcdmLLj5Z1R
         6FwDJS477pQX/xVtqd5W2iIXL6NPc/CMalNQ7Dz/h/u0cwaodNFvI5wG1G+ipK5H17Tz
         Ru6HRST1zVXyxBI6kCIrDv21udnyetoyaGYTQ7ydtjYjMqpvrjI6Go8GGIaNPl7ai/kX
         ZAvA==
X-Forwarded-Encrypted: i=1; AJvYcCUKiL6/EsIJqZ5ajNDIxJsuohjvZVdmNZaycmhKnnuspuz5bYmZPrxN08uGE7Thx1/aVSs45Zx8YAnyyKBh@vger.kernel.org, AJvYcCWizBDbDo6wdj6QALV8DCy72Zlsr5ZeKtBUG6BEuObbjxVl0vwsV/pf/OPrLwqoImYx5kgvb8YKyLXmkg==@vger.kernel.org, AJvYcCX5xohNJfZzDjsaguJbGPQHBloptcnXc5X0G0vnWleszVLRj9HzQeyuAFqbH0mwVFQaZs4LIRaMnV99@vger.kernel.org, AJvYcCXXrfUuJtmDUNWanYPiVEnqYMw+AIwAq2pD+WpfRWs77w+PyYG6Vuh0zRiCpuQbkIiHeuBE7lW2lPjkXGk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaXucY6dspT5eclqgGSR0w6VQft+dl8fUQLoa5x2zli9gJpnld
	Z74hDZ5yjIVhNZxjb6wHD5D6u+P3Eial6wxQXfzyKt2YbB2wEIu2lXoTYuhvUw==
X-Gm-Gg: ASbGncv3fA+vTqsa/qjTv8u4oM9xAAKVnQrtJ44f133RQbC6W0S7cg9wMPQS04Vatoz
	lIjH/AR4e2Zs4SMvegJd1Sqjw1V5LEy51p0TLsCXgR3PqP20P59m/SVqNvfsq01rFi6g7EtVwxh
	QIB5NLdgqBl+u43pYXUimEvLbNwMRhop21XOSEAFSHqzjFz7hMowM23exqNLomn9DC0Dvb9JrMf
	2+UfMPUjpdTWamacF4Ku7LCuva2+C/PEgHhZ5+QBEGc21Ugh5cEZzRm/cRyLoZkLNPxdOrN72Ue
	W78/nQQVxsETl7lvEtcmmowGGSnP2qMeh1h8M/TQr7nHk35ysz+bMuM9wuHmlg==
X-Google-Smtp-Source: AGHT+IH1Mhc+7U9MAaFCHKKqwle9PlTT8iA47PwKcFwo61/ZxXTKs7Yrl4GgMM/FbLCE9rASPsYu9Q==
X-Received: by 2002:a17:90b:2c83:b0:312:1508:fb4d with SMTP id 98e67ed59e1d1-318c931997emr2995067a91.33.1751000935767;
        Thu, 26 Jun 2025 22:08:55 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:d0c7:d92:6a17:eb62])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-318c14e2a72sm1260861a91.27.2025.06.26.22.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 22:08:55 -0700 (PDT)
Date: Thu, 26 Jun 2025 22:08:52 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Mario Limonciello <superm1@kernel.org>
Cc: Hans de Goede <hansg@kernel.org>, Mika Westerberg <westeri@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Linus Walleij <linus.walleij@linaro.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, "open list:GPIO ACPI SUPPORT" <linux-gpio@vger.kernel.org>, 
	"open list:GPIO ACPI SUPPORT" <linux-acpi@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:INPUT (KEYBOARD, MOUSE, JOYSTICK, TOUCHSCREEN)..." <linux-input@vger.kernel.org>, Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH v2 3/3] Input: soc_button_array: Only debounce cherryview
 and baytrail systems
Message-ID: <75wqpbcfhtvwv7ity77obmwsyswk5crxjpxmboayqj6lvvq7jg@7ojjp25blz5q>
References: <a9bed0b4-b050-468b-91cb-bc4c81352046@kernel.org>
 <8fc9051f-bef3-43fc-83a1-172a0eb599dc@kernel.org>
 <du46jt3mmkvceestjadbqmxbztp5xcurg4pzwzmqavo3pnfmak@tcfnufcu6de5>
 <55b4cd56-1812-4048-bf16-4b5b94a842d7@kernel.org>
 <vmjnwfg2mqr2anugefjtzezimcep27gi64d4wsctiu476w73rl@oo6r4o33jk44>
 <06ad432d-e138-4457-8180-bc35f08feed6@kernel.org>
 <blkvhrhch4y7psjqi6mlpn4q2qqrggwosw47plwizbxnjvlh5o@dux3as52kbqd>
 <5297e128-1906-4617-9c6c-f16498ef4907@kernel.org>
 <mkgtrb5gt7miyg6kvqdlbu4nj3elym6ijudobpdi26gp4xxay5@rsa6ytrjvj2q>
 <90ff69f1-0308-4591-9374-5319922f0870@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <90ff69f1-0308-4591-9374-5319922f0870@kernel.org>

On Thu, Jun 26, 2025 at 04:39:34PM -0500, Mario Limonciello wrote:
> On 6/26/2025 2:54 PM, Dmitry Torokhov wrote:
> > On Thu, Jun 26, 2025 at 02:37:19PM -0500, Mario Limonciello wrote:
> > > On 6/26/2025 2:32 PM, Dmitry Torokhov wrote:
> > > > On Thu, Jun 26, 2025 at 09:04:22PM +0200, Hans de Goede wrote:
> > > > > Hi Dmitry,
> > > > > 
> > > > > On 26-Jun-25 20:53, Dmitry Torokhov wrote:
> > > > > > On Thu, Jun 26, 2025 at 01:30:15PM -0500, Mario Limonciello wrote:
> > > > > > > On 6/26/2025 1:27 PM, Dmitry Torokhov wrote:
> > > > > > > > On Wed, Jun 25, 2025 at 03:34:07PM -0500, Mario Limonciello wrote:
> > > > > > > > > On 6/25/25 2:42 PM, Hans de Goede wrote:
> > > > > > > > > > Hi,
> > > > > > > > > > 
> > > > > > > > > > On 25-Jun-25 9:23 PM, Mario Limonciello wrote:
> > > > > > > > > > > On 6/25/25 2:03 PM, Hans de Goede wrote:
> > > > > > > > > > > > Hi,
> > > > > > > > > > > > 
> > > > > > > > > > > > On 25-Jun-25 8:13 PM, Mario Limonciello wrote:
> > > > > > > > > > > > > From: Mario Limonciello <mario.limonciello@amd.com>
> > > > > > > > > > > > > 
> > > > > > > > > > > > > commit 5c4fa2a6da7fb ("Input: soc_button_array - debounce the buttons")
> > > > > > > > > > > > > hardcoded all soc-button-array devices to use a 50ms debounce timeout
> > > > > > > > > > > > > but this doesn't work on all hardware.  The hardware I have on hand
> > > > > > > > > > > > > actually prescribes in the ASL that the timeout should be 0:
> > > > > > > > > > > > > 
> > > > > > > > > > > > > GpioInt (Edge, ActiveBoth, Exclusive, PullUp, 0x0000,
> > > > > > > > > > > > >               "\\_SB.GPIO", 0x00, ResourceConsumer, ,)
> > > > > > > > > > > > > {   // Pin list
> > > > > > > > > > > > >          0x0000
> > > > > > > > > > > > > }
> > > > > > > > > > > > > 
> > > > > > > > > > > > > Many cherryview and baytrail systems don't have accurate values in the
> > > > > > > > > > > > > ASL for debouncing and thus use software debouncing in gpio_keys. The
> > > > > > > > > > > > > value to use is programmed in soc_button_array.  Detect Cherry View
> > > > > > > > > > > > > and Baytrail using ACPI HID IDs used for those GPIO controllers and apply
> > > > > > > > > > > > > the 50ms only for those systems.
> > > > > > > > > > > > > 
> > > > > > > > > > > > > Cc: Hans de Goede <hansg@kernel.org>
> > > > > > > > > > > > > Fixes: 5c4fa2a6da7fb ("Input: soc_button_array - debounce the buttons")
> > > > > > > > > > > > > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> > > > > > > > > > > > 
> > > > > > > > > > > > I'm not a fan of this approach, I believe that we need to always debounce
> > > > > > > > > > > > when dealing with mechanical buttons otherwise we will get unreliable /
> > > > > > > > > > > > spurious input events.
> > > > > > > > > > > > 
> > > > > > > > > > > > My suggestion to deal with the issue where setting up debouncing at
> > > > > > > > > > > > the GPIO controller level is causing issues is to always use software
> > > > > > > > > > > > debouncing (which I suspect is what Windows does).
> > > > > > > > > > > > 
> > > > > > > > > > > > Let me copy and pasting my reply from the v1 thread with
> > > > > > > > > > > > a bit more detail on my proposal:
> > > > > > > > > > > > 
> > > > > > > > > > > > My proposal is to add a "no_hw_debounce" flag to
> > > > > > > > > > > > struct gpio_keys_platform_data and make the soc_button_array
> > > > > > > > > > > > driver set that regardless of which platform it is running on.
> > > > > > > > > > > > 
> > > > > > > > > > > > And then in gpio_keys.c do something like this:
> > > > > > > > > > > > 
> > > > > > > > > > > > diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
> > > > > > > > > > > > index f9db86da0818..2788d1e5782c 100644
> > > > > > > > > > > > --- a/drivers/input/keyboard/gpio_keys.c
> > > > > > > > > > > > +++ b/drivers/input/keyboard/gpio_keys.c
> > > > > > > > > > > > @@ -552,8 +552,11 @@ static int gpio_keys_setup_key(struct platform_device *pdev,
> > > > > > > > > > > >               bool active_low = gpiod_is_active_low(bdata->gpiod);
> > > > > > > > > > > >                 if (button->debounce_interval) {
> > > > > > > > > > > > -            error = gpiod_set_debounce(bdata->gpiod,
> > > > > > > > > > > > -                    button->debounce_interval * 1000);
> > > > > > > > > > > > +            if (ddata->pdata->no_hw_debounce)
> > > > > > > > > > > > +                error = -EINVAL;
> > > > > > > > > > > > +            else
> > > > > > > > > > > > +                error = gpiod_set_debounce(bdata->gpiod,
> > > > > > > > > > > > +                        button->debounce_interval * 1000);
> > > > > > > > > > > >                   /* use timer if gpiolib doesn't provide debounce */
> > > > > > > > > > > >                   if (error < 0)
> > > > > > > > > > > >                       bdata->software_debounce =
> > > > > > > > > > > > 
> > > > > > > > > > > > So keep debouncing, as that will always be necessary when dealing with
> > > > > > > > > > > > mechanical buttons, but always use software debouncing to avoid issues
> > > > > > > > > > > > like the issue you are seeing.
> > > > > > > > > > > > 
> > > > > > > > > > > > My mention of the BYT/CHT behavior in my previous email was to point
> > > > > > > > > > > > out that those already always use software debouncing for the 50 ms
> > > > > > > > > > > > debounce-period. It was *not* my intention to suggest to solve this
> > > > > > > > > > > > with platform specific quirks/behavior.
> > > > > > > > > > > > 
> > > > > > > > > > > > Regards,
> > > > > > > > > > > > 
> > > > > > > > > > > > Hans
> > > > > > > > > > > 
> > > > > > > > > > > I mentioned on the v1 too, but let's shift conversation here.
> > > > > > > > > > 
> > > > > > > > > > Ack.
> > > > > > > > > > 
> > > > > > > > > > > So essentially all platforms using soc_button_array would always turn on software debouncing of 50ms?
> > > > > > > > > > 
> > > > > > > > > > Yes that is what my proposal entails.
> > > > > > > > > > 
> > > > > > > > > > > In that case what happens if the hardware debounce was ALSO set from the ASL?  You end up with double debouncing I would expect.
> > > > > > > > > > 
> > > > > > > > > > A hardware debounce of say 25 ms would still report the button down
> > > > > > > > > > immediately, it just won't report any state changes for 25 ms
> > > > > > > > > > after that, at least that is how I would expect this to work.
> > > > > > > > > > 
> > > > > > > > > > So the 50 ms ignore-button-releases for the sw debounce will start
> > > > > > > > > > at the same time as the hw ignore-button-release window and basically
> > > > > > > > > > the longest window will win. So having both active should not really
> > > > > > > > > > cause any problems.
> > > > > > > > > > 
> > > > > > > > > > Still only using one or the other as you propose below would
> > > > > > > > > > be better.
> > > > > > > > > > 
> > > > > > > > > > > Shouldn't you only turn on software debouncing when it's required?
> > > > > > > > > > > 
> > > > > > > > > > > I'm wondering if considering the first two patches we should have gpio-keys look up if hardware can support debounce, and then "only if it can't" we program the value from soc button array.
> > > > > > > > > > > 
> > > > > > > > > > > It can be done by having gpio_keys do a "get()" on debounce.  Iff the driver returns -ENOTSUPP /then/ program the software debounce.
> > > > > > > > > > 
> > > > > > > > > > Any special handling here should be done in soc_button_array since
> > > > > > > > > > this is specific to how with ACPI we have the GPIO resource
> > > > > > > > > > descriptors setting up the hw-debounce and then the need to do
> > > > > > > > > > software debounce when that was not setup.
> > > > > > > > > > 
> > > > > > > > > > As for checking for -ENOTSUPP I would make soc_button_array
> > > > > > > > > > do something like this.
> > > > > > > > > > 
> > > > > > > > > > ret = debounce_get()
> > > > > > > > > > if (ret <= 0)
> > > > > > > > > > 	use-sw-debounce;
> > > > > > > > > > 
> > > > > > > > > > If hw-debounce is supported but not setup, either because
> > > > > > > > > > the exact debounce value being requested is not supported
> > > > > > > > > > or because the DSDT specified 0, then sw-debouncing should
> > > > > > > > > > also be used.
> > > > > > > > > > 
> > > > > > > > > > Note this will still require the use of a new no_hw_debounce
> > > > > > > > > > flag so that we don't end up enabling hw-debounce in
> > > > > > > > > > the hw-debounce is supported but not setup case.
> > > > > > > > > > 
> > > > > > > > > > Regards,
> > > > > > > > > > 
> > > > > > > > > > Hans
> > > > > > > > > > 
> > > > > > > > > 
> > > > > > > > > I did some experiments with your proposal (letting SW debounce get
> > > > > > > > > programmed) and everything seems to work fine*.  I think you're right that
> > > > > > > > > setting a double debounce would be worst one wins.
> > > > > > > > 
> > > > > > > > I am confused, can you explain why do we need this new no_hw_debounce
> > > > > > > > flag? If AMD gpio driver is unable to program 50 ms debounce for a given
> > > > > > > > pin but does not return an error (or returns an error but leaves system
> > > > > > > > in a bad state) that is the issue in that driver and needs to be fixed
> > > > > > > > there? Why do we need to change soc_button_driver at all?
> > > > > > > > 
> > > > > > > > Thanks.
> > > > > > > > 
> > > > > > > 
> > > > > > > The requested 50ms HW debounce gets programmed to the hardware register
> > > > > > > successfully.  It is within bound that the GPIO controller can support.
> > > > > > > 
> > > > > > > The problem is the power button does not function with a 50ms debounce.
> > > > > > > The firmware asserted that 0ms should have been programmed (by the _CRS
> > > > > > > value in GpioInt).
> > > > > > 
> > > > > > I do not understand how debounce that is within the controller's
> > > > > > supported range can not work. The button is a switch that reports on and
> > > > > > off, there is nothing more to it, is there?
> > > > > > 
> > > > > > I feel there is a deeper problem that we simply trying to paper over.
> > > > > 
> > > > > Note that on x86 wakeup events and GPIO IRQs typically use a different
> > > > > event mechanism / path under the hood (PME events to resume from suspend).
> > > > > It is not just a case of marking the IRQ used while running as a wakeup
> > > > > source.
> > > > > 
> > > > > So it is possible that setting the hw-debouncing is in some way interfering
> > > > > with the reporting of x86 PME events while the system is suspended.
> > > > 
> > > > Still this looks like platform issue, not driver issue. Should GPIO
> > > > driver refuse programming debounce if pin is configured as potential
> > > > wakeup source then?
> > > 
> > > How can the driver intricate details about the hardware connected to the
> > > GPIO and how it behaves?
> > > 
> > > The driver is "dumb" and programs the registers according to the calls given
> > > to it.
> > 
> > I do not think driver needs to know details of hardware connected to
> > GPIO. I know you mentioned that it may be connected to an EC that does
> > its own debouncing, however this should make no difference from AP
> > standpoint: you are still dealing with a GPIO line and your GPIO
> > controller does debouncing for that line (which may be unnecessary
> > because the line will not be bouncing).
> > 
> > Hans mentioned that it is possible that this debounce interferes with
> > the platform reporting wakeup events. I can easily believe that. But
> > that means that if there is another peripheral device similarly attached
> > to such GPIO configured for wakeup, device that does not use gpio_keys
> > driver, it will have the same issue. And I wonder if the solution is for
> > your GPIO provider driver to refuse programming debounce for GPIOs that
> > are marked as wake capable.
> 
> Hmm; how would we guarantee there was no regressions for other systems with
> such a heuristics change?
> 
> IE what if there is a system that doesn't use soc-button-array and has a
> non-zero debounce value in the GpioInt from _AEI() and is wake capable?
> "Today" that would be programmed to the GPIO register.

That is exactly what I am saying. I am asserting that if there is
another system that does not use soc-button-array (or rather gpio-keys)
and it programs GPIO debounce for GPIO that is used for wakeup then on
the same platform it will be similarly broken. It is not GPIO-consumer
driver specific, it is platform/GPIO provider specific behavior.

> 
> If we're aiming for a driver specific heuristic another alternative is to
> clear debounce for everything at suspend and restore it at resume.
> 
> I actually did that and it seems to work fine on this affected system, so
> I'll draft it up as an alternative to patch v3 3/4.

I guess this also an option...

Thanks.

-- 
Dmitry

