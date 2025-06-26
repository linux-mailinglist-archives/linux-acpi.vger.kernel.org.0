Return-Path: <linux-acpi+bounces-14746-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D220AEA67F
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Jun 2025 21:33:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB8111C41A13
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Jun 2025 19:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17FD42EF66E;
	Thu, 26 Jun 2025 19:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yxwk1fVw"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D71A7263E;
	Thu, 26 Jun 2025 19:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750966382; cv=none; b=ZC017uaREfkUrw1VlddCxCLGtLzz5RO7ir9o8sFdFwaykMk8X6vUUxEYNZiKxkFixKOuZATzcNIMcn/41zZxRuKyQNDNwjlCkgr+5PqigeQi+bbDXhurSRxDIXCTb9ADKCrHMUvmir3v3IIFSrFu9+CyVKNXgipPxeBVqQcFw/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750966382; c=relaxed/simple;
	bh=GXLSQpyOSW8zkSqfRDb+zJwdI2C3UQxiIb7u8clYfiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=INPVt38x9xKO9Yszw2sRewfmhD5dBSVuAsIor0IWy75RmpmOvPg7O5gwG+xQ5bVC/zSaRvxMMg4WZpMiCcj2G8kxFzPxNp1kLQ11jRljE39S13hLVy9YDbrBaitOFAqdvdu+/u8Nm5+X68SbWCPlTublUbJyrbEmxcGl7vxLgXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yxwk1fVw; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3138e64b42aso1677066a91.0;
        Thu, 26 Jun 2025 12:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750966379; x=1751571179; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=m/R9rN4rd3teIYtN33M/gD0Ro4+crAJV8M3wqmcxyoU=;
        b=Yxwk1fVwBanbvOHulahzMgTCMhMwXLxxKZgLLmksiwEOwLqpMTviqIEuEOSXaF9PkU
         yCWSDFCvTV76FOR7KxhyqU9pOQzMr8S3RkzINaZeZehftaFjQsx/EjSjyrskSKqkSZj9
         JQ8PWoWpgVNZC394lIR8BDPIlYOAmZXUi/4IlE9bDZjeQsUUaeq6s2u/koiReoNHYulV
         ohdDb/sow1zmIznm3pZawOPv8OL5GddEraRK35bScFZO4kiESkRcwht2g2LcS7BhBkvm
         wbBGJbaBQPioRXndA4iosoJx1wDC9CTcsSpWkfEpZOOQZNdhPeXyejPh4GIC5ch6tRZW
         jhiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750966379; x=1751571179;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m/R9rN4rd3teIYtN33M/gD0Ro4+crAJV8M3wqmcxyoU=;
        b=IDekWviPhY/1St9F2uyHkgoHY4JELgV8d9KzxDaK/CeCUHOHV/30F508VZsBKlc2sR
         1HIA/nYRj6Ulh4WJw1d0yUYtlsQD1SaHvJDh9eeC4lKfCBpubCna4KFihhookVKQUZUW
         8xHgnjy4jLEFePXm7Ex3yndxiX7gF7aeOsN2OWs3kTLl0edKsXOXs5CHykMTsakr6IX7
         eEQ5a3VJdJIWgH0HxfLzALZ66f2hk+l30rmWtKEIy4N+pF3hu9ayEEQzCSG55p6hQ2a8
         1fog/rMCVX+qY49yQc2yFFYTDI2Gffe8HxD9EApCsV5TkYwdTN5AeYs3+RsExhqo4Q2c
         c6hg==
X-Forwarded-Encrypted: i=1; AJvYcCU4vwoiRWJxwlzmAEC6UR1ICwXdPqtln2mlP72/cip4oiWsE9lYECna6uYuIUX8nRpBUxCza99zAXd67pI=@vger.kernel.org, AJvYcCX3JHmBJN9jaZKWsTIZjaIB3uc6hgTr3z8yhDBfk+d/v0PlN7Fwf4bifT3u9nrVBQPeDIquzVTieecPrw==@vger.kernel.org, AJvYcCXOTIMSI4rw8LvdEKMV5JRX2420YFYT0hA6E6bfrGoZeSM2Ii8LMOarIPNJBufFi53CcfRdPyTQs6P8@vger.kernel.org, AJvYcCXjKe9Q7LYdcYcoiuyGj2LHh1K4uP/u6Mo/8mt81GY7is3tf1RuUJuak9K8pTd7BZJixjTTPmeGdkCk1Gma@vger.kernel.org
X-Gm-Message-State: AOJu0YwkIryJNStmTVFGIbyt1oUHOEcPBzuiLzjj7eMJafvitQNjXpws
	v9NAj20eeDvkZSlt6n3YTxb/ZH02k0W/26p4kNnHFEb2SKY5tas0uj/G
X-Gm-Gg: ASbGnctsm7jRzRR4BMcHStM5L5VlV5wdzM8EP7e/iBydc7dVX4rZRvOJMjkbV6uxIdD
	uhKdahml5Y+SA4uEAbYrcvL5TSE5v0PVzT55xyFUWLrrnZpg/QDKW5cRIujrsDw/cs06+wUX3E9
	au9FKSURqpXyU2p1KoGoOPynT88aP27vZLrommvV4LMOW9Iv67FfkO6bvPZ2FC05oU3ldr9yt8B
	cHeSG+OG6srn9MhU8Y9lf1LqvMOS1lL+Uwfac0mDlztHclTvoA74oddXvrHoxQhby/bR0nQqGdm
	jN6XHvLOgWEdOAngXztk08FnkGeQgKsPs6fIfY1zfwMFXuJPEzkVtbzGdfJG98fonayYG543wg=
	=
X-Google-Smtp-Source: AGHT+IGG3UhnUrMa1aMDwQjcY62uTP35ESZKA6oCm5GDfqxuyG+v/KrhK1orjEJRlWtJ4Q9X6noSMQ==
X-Received: by 2002:a17:90b:3890:b0:313:1a8c:c2c6 with SMTP id 98e67ed59e1d1-318c92ec03emr327976a91.16.1750966379268;
        Thu, 26 Jun 2025 12:32:59 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:9c8f:acd3:efcb:bc3d])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-315f54412c6sm4810148a91.43.2025.06.26.12.32.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 12:32:58 -0700 (PDT)
Date: Thu, 26 Jun 2025 12:32:56 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Hans de Goede <hansg@kernel.org>
Cc: Mario Limonciello <superm1@kernel.org>, 
	Mika Westerberg <westeri@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	"open list:GPIO ACPI SUPPORT" <linux-gpio@vger.kernel.org>, "open list:GPIO ACPI SUPPORT" <linux-acpi@vger.kernel.org>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:INPUT (KEYBOARD, MOUSE, JOYSTICK, TOUCHSCREEN)..." <linux-input@vger.kernel.org>, Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH v2 3/3] Input: soc_button_array: Only debounce cherryview
 and baytrail systems
Message-ID: <blkvhrhch4y7psjqi6mlpn4q2qqrggwosw47plwizbxnjvlh5o@dux3as52kbqd>
References: <20250625181342.3175969-1-superm1@kernel.org>
 <20250625181342.3175969-4-superm1@kernel.org>
 <f5e1d50f-d85e-45a3-a131-f2da603c620c@kernel.org>
 <57e9b1d5-faf1-4c7a-87fc-047e0dc102f9@kernel.org>
 <a9bed0b4-b050-468b-91cb-bc4c81352046@kernel.org>
 <8fc9051f-bef3-43fc-83a1-172a0eb599dc@kernel.org>
 <du46jt3mmkvceestjadbqmxbztp5xcurg4pzwzmqavo3pnfmak@tcfnufcu6de5>
 <55b4cd56-1812-4048-bf16-4b5b94a842d7@kernel.org>
 <vmjnwfg2mqr2anugefjtzezimcep27gi64d4wsctiu476w73rl@oo6r4o33jk44>
 <06ad432d-e138-4457-8180-bc35f08feed6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <06ad432d-e138-4457-8180-bc35f08feed6@kernel.org>

On Thu, Jun 26, 2025 at 09:04:22PM +0200, Hans de Goede wrote:
> Hi Dmitry,
> 
> On 26-Jun-25 20:53, Dmitry Torokhov wrote:
> > On Thu, Jun 26, 2025 at 01:30:15PM -0500, Mario Limonciello wrote:
> >> On 6/26/2025 1:27 PM, Dmitry Torokhov wrote:
> >>> On Wed, Jun 25, 2025 at 03:34:07PM -0500, Mario Limonciello wrote:
> >>>> On 6/25/25 2:42 PM, Hans de Goede wrote:
> >>>>> Hi,
> >>>>>
> >>>>> On 25-Jun-25 9:23 PM, Mario Limonciello wrote:
> >>>>>> On 6/25/25 2:03 PM, Hans de Goede wrote:
> >>>>>>> Hi,
> >>>>>>>
> >>>>>>> On 25-Jun-25 8:13 PM, Mario Limonciello wrote:
> >>>>>>>> From: Mario Limonciello <mario.limonciello@amd.com>
> >>>>>>>>
> >>>>>>>> commit 5c4fa2a6da7fb ("Input: soc_button_array - debounce the buttons")
> >>>>>>>> hardcoded all soc-button-array devices to use a 50ms debounce timeout
> >>>>>>>> but this doesn't work on all hardware.  The hardware I have on hand
> >>>>>>>> actually prescribes in the ASL that the timeout should be 0:
> >>>>>>>>
> >>>>>>>> GpioInt (Edge, ActiveBoth, Exclusive, PullUp, 0x0000,
> >>>>>>>>             "\\_SB.GPIO", 0x00, ResourceConsumer, ,)
> >>>>>>>> {   // Pin list
> >>>>>>>>        0x0000
> >>>>>>>> }
> >>>>>>>>
> >>>>>>>> Many cherryview and baytrail systems don't have accurate values in the
> >>>>>>>> ASL for debouncing and thus use software debouncing in gpio_keys. The
> >>>>>>>> value to use is programmed in soc_button_array.  Detect Cherry View
> >>>>>>>> and Baytrail using ACPI HID IDs used for those GPIO controllers and apply
> >>>>>>>> the 50ms only for those systems.
> >>>>>>>>
> >>>>>>>> Cc: Hans de Goede <hansg@kernel.org>
> >>>>>>>> Fixes: 5c4fa2a6da7fb ("Input: soc_button_array - debounce the buttons")
> >>>>>>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> >>>>>>>
> >>>>>>> I'm not a fan of this approach, I believe that we need to always debounce
> >>>>>>> when dealing with mechanical buttons otherwise we will get unreliable /
> >>>>>>> spurious input events.
> >>>>>>>
> >>>>>>> My suggestion to deal with the issue where setting up debouncing at
> >>>>>>> the GPIO controller level is causing issues is to always use software
> >>>>>>> debouncing (which I suspect is what Windows does).
> >>>>>>>
> >>>>>>> Let me copy and pasting my reply from the v1 thread with
> >>>>>>> a bit more detail on my proposal:
> >>>>>>>
> >>>>>>> My proposal is to add a "no_hw_debounce" flag to
> >>>>>>> struct gpio_keys_platform_data and make the soc_button_array
> >>>>>>> driver set that regardless of which platform it is running on.
> >>>>>>>
> >>>>>>> And then in gpio_keys.c do something like this:
> >>>>>>>
> >>>>>>> diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
> >>>>>>> index f9db86da0818..2788d1e5782c 100644
> >>>>>>> --- a/drivers/input/keyboard/gpio_keys.c
> >>>>>>> +++ b/drivers/input/keyboard/gpio_keys.c
> >>>>>>> @@ -552,8 +552,11 @@ static int gpio_keys_setup_key(struct platform_device *pdev,
> >>>>>>>             bool active_low = gpiod_is_active_low(bdata->gpiod);
> >>>>>>>               if (button->debounce_interval) {
> >>>>>>> -            error = gpiod_set_debounce(bdata->gpiod,
> >>>>>>> -                    button->debounce_interval * 1000);
> >>>>>>> +            if (ddata->pdata->no_hw_debounce)
> >>>>>>> +                error = -EINVAL;
> >>>>>>> +            else
> >>>>>>> +                error = gpiod_set_debounce(bdata->gpiod,
> >>>>>>> +                        button->debounce_interval * 1000);
> >>>>>>>                 /* use timer if gpiolib doesn't provide debounce */
> >>>>>>>                 if (error < 0)
> >>>>>>>                     bdata->software_debounce =
> >>>>>>>
> >>>>>>> So keep debouncing, as that will always be necessary when dealing with
> >>>>>>> mechanical buttons, but always use software debouncing to avoid issues
> >>>>>>> like the issue you are seeing.
> >>>>>>>
> >>>>>>> My mention of the BYT/CHT behavior in my previous email was to point
> >>>>>>> out that those already always use software debouncing for the 50 ms
> >>>>>>> debounce-period. It was *not* my intention to suggest to solve this
> >>>>>>> with platform specific quirks/behavior.
> >>>>>>>
> >>>>>>> Regards,
> >>>>>>>
> >>>>>>> Hans
> >>>>>>
> >>>>>> I mentioned on the v1 too, but let's shift conversation here.
> >>>>>
> >>>>> Ack.
> >>>>>
> >>>>>> So essentially all platforms using soc_button_array would always turn on software debouncing of 50ms?
> >>>>>
> >>>>> Yes that is what my proposal entails.
> >>>>>
> >>>>>> In that case what happens if the hardware debounce was ALSO set from the ASL?  You end up with double debouncing I would expect.
> >>>>>
> >>>>> A hardware debounce of say 25 ms would still report the button down
> >>>>> immediately, it just won't report any state changes for 25 ms
> >>>>> after that, at least that is how I would expect this to work.
> >>>>>
> >>>>> So the 50 ms ignore-button-releases for the sw debounce will start
> >>>>> at the same time as the hw ignore-button-release window and basically
> >>>>> the longest window will win. So having both active should not really
> >>>>> cause any problems.
> >>>>>
> >>>>> Still only using one or the other as you propose below would
> >>>>> be better.
> >>>>>
> >>>>>> Shouldn't you only turn on software debouncing when it's required?
> >>>>>>
> >>>>>> I'm wondering if considering the first two patches we should have gpio-keys look up if hardware can support debounce, and then "only if it can't" we program the value from soc button array.
> >>>>>>
> >>>>>> It can be done by having gpio_keys do a "get()" on debounce.  Iff the driver returns -ENOTSUPP /then/ program the software debounce.
> >>>>>
> >>>>> Any special handling here should be done in soc_button_array since
> >>>>> this is specific to how with ACPI we have the GPIO resource
> >>>>> descriptors setting up the hw-debounce and then the need to do
> >>>>> software debounce when that was not setup.
> >>>>>
> >>>>> As for checking for -ENOTSUPP I would make soc_button_array
> >>>>> do something like this.
> >>>>>
> >>>>> ret = debounce_get()
> >>>>> if (ret <= 0)
> >>>>> 	use-sw-debounce;
> >>>>>
> >>>>> If hw-debounce is supported but not setup, either because
> >>>>> the exact debounce value being requested is not supported
> >>>>> or because the DSDT specified 0, then sw-debouncing should
> >>>>> also be used.
> >>>>>
> >>>>> Note this will still require the use of a new no_hw_debounce
> >>>>> flag so that we don't end up enabling hw-debounce in
> >>>>> the hw-debounce is supported but not setup case.
> >>>>>
> >>>>> Regards,
> >>>>>
> >>>>> Hans
> >>>>>
> >>>>
> >>>> I did some experiments with your proposal (letting SW debounce get
> >>>> programmed) and everything seems to work fine*.  I think you're right that
> >>>> setting a double debounce would be worst one wins.
> >>>
> >>> I am confused, can you explain why do we need this new no_hw_debounce
> >>> flag? If AMD gpio driver is unable to program 50 ms debounce for a given
> >>> pin but does not return an error (or returns an error but leaves system
> >>> in a bad state) that is the issue in that driver and needs to be fixed
> >>> there? Why do we need to change soc_button_driver at all?
> >>>
> >>> Thanks.
> >>>
> >>
> >> The requested 50ms HW debounce gets programmed to the hardware register
> >> successfully.  It is within bound that the GPIO controller can support.
> >>
> >> The problem is the power button does not function with a 50ms debounce.
> >> The firmware asserted that 0ms should have been programmed (by the _CRS
> >> value in GpioInt).
> > 
> > I do not understand how debounce that is within the controller's
> > supported range can not work. The button is a switch that reports on and
> > off, there is nothing more to it, is there?
> > 
> > I feel there is a deeper problem that we simply trying to paper over.
> 
> Note that on x86 wakeup events and GPIO IRQs typically use a different
> event mechanism / path under the hood (PME events to resume from suspend).
> It is not just a case of marking the IRQ used while running as a wakeup
> source.
> 
> So it is possible that setting the hw-debouncing is in some way interfering
> with the reporting of x86 PME events while the system is suspended.

Still this looks like platform issue, not driver issue. Should GPIO
driver refuse programming debounce if pin is configured as potential
wakeup source then?

> 
> Most systems where soc_button_array is used don't support hw-debouncing
> in the first place, so on most systems this change is a no-op.

The change is not limited to soc_button_array driver, we need to add
flags to gpio_keys as well... 

Thanks.

-- 
Dmitry

