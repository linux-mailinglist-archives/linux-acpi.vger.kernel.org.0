Return-Path: <linux-acpi+bounces-14731-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC069AEA5DA
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Jun 2025 20:54:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2075F3AA504
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Jun 2025 18:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B278E2EE998;
	Thu, 26 Jun 2025 18:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gXHsGyna"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010BE28D8FE;
	Thu, 26 Jun 2025 18:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750964038; cv=none; b=DcUzdvoHucIjoHhB5l2XzDFwxQtGB1ck/exqldEuAT3S6xo/irnALkXzl7hNGS3t6SYy0csOMfbP2TWmkVBtb7PtUziLxd1Qkfwysw7AuguqDMhg6MLALeT/yheDsJcxJ3bttEmWzIb/cOB5WWXsh0VhD1conBnM+auwJdlLyq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750964038; c=relaxed/simple;
	bh=eSd+W62ZmrEs0u9X1aX1h0TxhZg19pt4hdlo/vzP7VU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n6uSBm5n5VC2FVsCq1HvyT8NMl6RHUzWV/0cgzQ4GN8LU34c2cHzr4xeFXTZ51/682JbmzJF/C+dE4RxhQwrkkFdRQtmu/VWByIrQQZyUVM8K0Tq20A0uX8k01fEAwnj99f4jHnJegtWIlWMgGFjZV5Jha1pc1hd/vEig6pWOwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gXHsGyna; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-23526264386so14518415ad.2;
        Thu, 26 Jun 2025 11:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750964036; x=1751568836; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DZHVP2rmRcrCN3buEI5xZHWZRQLkAIzVepe2gnh5VLc=;
        b=gXHsGyna6TLaewjzLZbeAq1+wHtNO5h/hcDYOgXd3+/fOEwAFcdCGzVKNFDfZvSznC
         84aJipAZyr3O/jtgME/oa03pWEqmX3VeDwMb3Nm65IqAR93fc79OdyQMUPZEgoV1ax9R
         3rzpNdhpE0+NiKfbAYh1sHHhgLrpuWEToTY9KpQyRGqLh1/gItICiPVbp+DRWxHedDKp
         z/PZFwQOnhBFoFJ0ymHVeVM1RybayPRYBKEBmKbIPM7hVYKJDzujy9oM5Sa5NU95xEOT
         2m7zTePYoHbf9c2XmfdqS2K5dnBDxoLNC1eoXfWUtG8zlYMo9sFDqBHiQqiGZVRRfPnp
         TuJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750964036; x=1751568836;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DZHVP2rmRcrCN3buEI5xZHWZRQLkAIzVepe2gnh5VLc=;
        b=awDwignV2dZpr8C8/IIzjKHhvBLmZiaxv2mco4Xj+5BfW+ZL03vnuvIGK6E1DSg5ao
         XB50nwV0bDVHNbFYlU/lydKNotkKdcP1+gR8mtqP4pK4oCVMJy3Tw9ylH5swiVubhU47
         ndFC/V1tGqrxg3B+9G/52k0b/bi/jsdVC+ciyCrzU6b4MRn/DWPI4CI5ipOX14epQ0YL
         S0Dm24am7lrnsFYz/qI00Vwd0Q1d6waeVhhik70E+Bswrzlj6QlyuzO8xVlWt+48WINu
         BKy/OnnALNDK+lZRjlhSSa5TBRrmBa4Qgdiw/Shdewd/19hglnNc5W0w8/Lw2ifb91KA
         dSzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUl17DvNYsVSq8VbkAUVFuCILC5CtgO6b1Yl94oD1oX5gtwwJFJG5B8LvAatIliIoZDbtsJ/zAQTjM2ePgN@vger.kernel.org, AJvYcCVYQM2hJgjMfD27BUZih44as299iXGLnFJf/VE3OcXPavWFIBqwqZfqTAwALe6MIuByMMgcpEhH2PQZ+58=@vger.kernel.org, AJvYcCWxBa/Gl5I7zsjdXPxx1wET/SgcQM8DKm9KBY2IAh0U21UGHY/knoRgmyf/Qtl5AMsIDlsNd5F9NDWk@vger.kernel.org, AJvYcCXYG1+JXSBhgcWmHLW5VIiD92Rb9hc+UyQcq5r2bGQ5Tq0nj6PVzIXoJTqbpTN5Ju0WPJe582g6ePieVQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwVzKJ/TpVJM/qXTYo/+XCvrbWT8GqYA4ouUyeO6n8/VTQuc2/9
	INU+lXWqJdF3qTrL3RdLhC1h0o5UWldntWoWDpnbjZLLzRezoTDJT+xH
X-Gm-Gg: ASbGncvWRrikty0dhkWDpSOaEvb+tlnYtM4ETQjOgifuK6SN2oG0jCkbrDe9Ms2Ywtb
	7azgylSGIb5r5e2Ztbby4g01KMvEnvIVWWTG9XfJP4JZLx/dAvwa7ubNER6CTNUPcLVW/PpEdaZ
	eD5yY/7UzvNocMSmwQy4H26+xpnc7CIKQ+0m6EqPuaaerS9c7+WZY3a/JW8MlfFUo1OJcqxV7yZ
	tg+a7K6BNlrOFFu8aVdQCS0YF1/MQb0XnlJBzBsBDPoOhFCi4wLjd7FUNN6jYBOvsCJBt6Pw68w
	aVox6eiUMNfSuMf3RdyWU9dC7kMnZ4stpC+CN8I51ZBYaOavcdmuS0U2iSGT9iE=
X-Google-Smtp-Source: AGHT+IFusYX/Pt/FlUUiNvwucbYSeRtoJpyJeWrPTDwzjZyUC1UV9GcqXz0kITSDkE6CSKkJu8DuRg==
X-Received: by 2002:a17:903:28c:b0:236:94ac:cc1a with SMTP id d9443c01a7336-23ac4624558mr4694395ad.27.1750964036156;
        Thu, 26 Jun 2025 11:53:56 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:9c8f:acd3:efcb:bc3d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23abe32be58sm4376655ad.86.2025.06.26.11.53.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 11:53:55 -0700 (PDT)
Date: Thu, 26 Jun 2025 11:53:53 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Mario Limonciello <superm1@kernel.org>
Cc: Hans de Goede <hansg@kernel.org>, Mika Westerberg <westeri@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Linus Walleij <linus.walleij@linaro.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, "open list:GPIO ACPI SUPPORT" <linux-gpio@vger.kernel.org>, 
	"open list:GPIO ACPI SUPPORT" <linux-acpi@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:INPUT (KEYBOARD, MOUSE, JOYSTICK, TOUCHSCREEN)..." <linux-input@vger.kernel.org>, Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH v2 3/3] Input: soc_button_array: Only debounce cherryview
 and baytrail systems
Message-ID: <vmjnwfg2mqr2anugefjtzezimcep27gi64d4wsctiu476w73rl@oo6r4o33jk44>
References: <20250625181342.3175969-1-superm1@kernel.org>
 <20250625181342.3175969-4-superm1@kernel.org>
 <f5e1d50f-d85e-45a3-a131-f2da603c620c@kernel.org>
 <57e9b1d5-faf1-4c7a-87fc-047e0dc102f9@kernel.org>
 <a9bed0b4-b050-468b-91cb-bc4c81352046@kernel.org>
 <8fc9051f-bef3-43fc-83a1-172a0eb599dc@kernel.org>
 <du46jt3mmkvceestjadbqmxbztp5xcurg4pzwzmqavo3pnfmak@tcfnufcu6de5>
 <55b4cd56-1812-4048-bf16-4b5b94a842d7@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <55b4cd56-1812-4048-bf16-4b5b94a842d7@kernel.org>

On Thu, Jun 26, 2025 at 01:30:15PM -0500, Mario Limonciello wrote:
> On 6/26/2025 1:27 PM, Dmitry Torokhov wrote:
> > On Wed, Jun 25, 2025 at 03:34:07PM -0500, Mario Limonciello wrote:
> > > On 6/25/25 2:42 PM, Hans de Goede wrote:
> > > > Hi,
> > > > 
> > > > On 25-Jun-25 9:23 PM, Mario Limonciello wrote:
> > > > > On 6/25/25 2:03 PM, Hans de Goede wrote:
> > > > > > Hi,
> > > > > > 
> > > > > > On 25-Jun-25 8:13 PM, Mario Limonciello wrote:
> > > > > > > From: Mario Limonciello <mario.limonciello@amd.com>
> > > > > > > 
> > > > > > > commit 5c4fa2a6da7fb ("Input: soc_button_array - debounce the buttons")
> > > > > > > hardcoded all soc-button-array devices to use a 50ms debounce timeout
> > > > > > > but this doesn't work on all hardware.  The hardware I have on hand
> > > > > > > actually prescribes in the ASL that the timeout should be 0:
> > > > > > > 
> > > > > > > GpioInt (Edge, ActiveBoth, Exclusive, PullUp, 0x0000,
> > > > > > >             "\\_SB.GPIO", 0x00, ResourceConsumer, ,)
> > > > > > > {   // Pin list
> > > > > > >        0x0000
> > > > > > > }
> > > > > > > 
> > > > > > > Many cherryview and baytrail systems don't have accurate values in the
> > > > > > > ASL for debouncing and thus use software debouncing in gpio_keys. The
> > > > > > > value to use is programmed in soc_button_array.  Detect Cherry View
> > > > > > > and Baytrail using ACPI HID IDs used for those GPIO controllers and apply
> > > > > > > the 50ms only for those systems.
> > > > > > > 
> > > > > > > Cc: Hans de Goede <hansg@kernel.org>
> > > > > > > Fixes: 5c4fa2a6da7fb ("Input: soc_button_array - debounce the buttons")
> > > > > > > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> > > > > > 
> > > > > > I'm not a fan of this approach, I believe that we need to always debounce
> > > > > > when dealing with mechanical buttons otherwise we will get unreliable /
> > > > > > spurious input events.
> > > > > > 
> > > > > > My suggestion to deal with the issue where setting up debouncing at
> > > > > > the GPIO controller level is causing issues is to always use software
> > > > > > debouncing (which I suspect is what Windows does).
> > > > > > 
> > > > > > Let me copy and pasting my reply from the v1 thread with
> > > > > > a bit more detail on my proposal:
> > > > > > 
> > > > > > My proposal is to add a "no_hw_debounce" flag to
> > > > > > struct gpio_keys_platform_data and make the soc_button_array
> > > > > > driver set that regardless of which platform it is running on.
> > > > > > 
> > > > > > And then in gpio_keys.c do something like this:
> > > > > > 
> > > > > > diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
> > > > > > index f9db86da0818..2788d1e5782c 100644
> > > > > > --- a/drivers/input/keyboard/gpio_keys.c
> > > > > > +++ b/drivers/input/keyboard/gpio_keys.c
> > > > > > @@ -552,8 +552,11 @@ static int gpio_keys_setup_key(struct platform_device *pdev,
> > > > > >             bool active_low = gpiod_is_active_low(bdata->gpiod);
> > > > > >               if (button->debounce_interval) {
> > > > > > -            error = gpiod_set_debounce(bdata->gpiod,
> > > > > > -                    button->debounce_interval * 1000);
> > > > > > +            if (ddata->pdata->no_hw_debounce)
> > > > > > +                error = -EINVAL;
> > > > > > +            else
> > > > > > +                error = gpiod_set_debounce(bdata->gpiod,
> > > > > > +                        button->debounce_interval * 1000);
> > > > > >                 /* use timer if gpiolib doesn't provide debounce */
> > > > > >                 if (error < 0)
> > > > > >                     bdata->software_debounce =
> > > > > > 
> > > > > > So keep debouncing, as that will always be necessary when dealing with
> > > > > > mechanical buttons, but always use software debouncing to avoid issues
> > > > > > like the issue you are seeing.
> > > > > > 
> > > > > > My mention of the BYT/CHT behavior in my previous email was to point
> > > > > > out that those already always use software debouncing for the 50 ms
> > > > > > debounce-period. It was *not* my intention to suggest to solve this
> > > > > > with platform specific quirks/behavior.
> > > > > > 
> > > > > > Regards,
> > > > > > 
> > > > > > Hans
> > > > > 
> > > > > I mentioned on the v1 too, but let's shift conversation here.
> > > > 
> > > > Ack.
> > > > 
> > > > > So essentially all platforms using soc_button_array would always turn on software debouncing of 50ms?
> > > > 
> > > > Yes that is what my proposal entails.
> > > > 
> > > > > In that case what happens if the hardware debounce was ALSO set from the ASL?  You end up with double debouncing I would expect.
> > > > 
> > > > A hardware debounce of say 25 ms would still report the button down
> > > > immediately, it just won't report any state changes for 25 ms
> > > > after that, at least that is how I would expect this to work.
> > > > 
> > > > So the 50 ms ignore-button-releases for the sw debounce will start
> > > > at the same time as the hw ignore-button-release window and basically
> > > > the longest window will win. So having both active should not really
> > > > cause any problems.
> > > > 
> > > > Still only using one or the other as you propose below would
> > > > be better.
> > > > 
> > > > > Shouldn't you only turn on software debouncing when it's required?
> > > > > 
> > > > > I'm wondering if considering the first two patches we should have gpio-keys look up if hardware can support debounce, and then "only if it can't" we program the value from soc button array.
> > > > > 
> > > > > It can be done by having gpio_keys do a "get()" on debounce.  Iff the driver returns -ENOTSUPP /then/ program the software debounce.
> > > > 
> > > > Any special handling here should be done in soc_button_array since
> > > > this is specific to how with ACPI we have the GPIO resource
> > > > descriptors setting up the hw-debounce and then the need to do
> > > > software debounce when that was not setup.
> > > > 
> > > > As for checking for -ENOTSUPP I would make soc_button_array
> > > > do something like this.
> > > > 
> > > > ret = debounce_get()
> > > > if (ret <= 0)
> > > > 	use-sw-debounce;
> > > > 
> > > > If hw-debounce is supported but not setup, either because
> > > > the exact debounce value being requested is not supported
> > > > or because the DSDT specified 0, then sw-debouncing should
> > > > also be used.
> > > > 
> > > > Note this will still require the use of a new no_hw_debounce
> > > > flag so that we don't end up enabling hw-debounce in
> > > > the hw-debounce is supported but not setup case.
> > > > 
> > > > Regards,
> > > > 
> > > > Hans
> > > > 
> > > 
> > > I did some experiments with your proposal (letting SW debounce get
> > > programmed) and everything seems to work fine*.  I think you're right that
> > > setting a double debounce would be worst one wins.
> > 
> > I am confused, can you explain why do we need this new no_hw_debounce
> > flag? If AMD gpio driver is unable to program 50 ms debounce for a given
> > pin but does not return an error (or returns an error but leaves system
> > in a bad state) that is the issue in that driver and needs to be fixed
> > there? Why do we need to change soc_button_driver at all?
> > 
> > Thanks.
> > 
> 
> The requested 50ms HW debounce gets programmed to the hardware register
> successfully.  It is within bound that the GPIO controller can support.
> 
> The problem is the power button does not function with a 50ms debounce.
> The firmware asserted that 0ms should have been programmed (by the _CRS
> value in GpioInt).

I do not understand how debounce that is within the controller's
supported range can not work. The button is a switch that reports on and
off, there is nothing more to it, is there?

I feel there is a deeper problem that we simply trying to paper over.

-- 
Dmitry

