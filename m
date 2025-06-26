Return-Path: <linux-acpi+bounces-14721-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D40AEA55C
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Jun 2025 20:27:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21ACB3BC9B5
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Jun 2025 18:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E22D92EE5F2;
	Thu, 26 Jun 2025 18:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DLkTv5cW"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7B72EE28F;
	Thu, 26 Jun 2025 18:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750962428; cv=none; b=LKPN8clcyKHSBFuKZ15eSzkGNx1VsSdhrQ9uOb+dVCHOIZSm1pwd7VD91lNr6PzNB4jAB4fcbrNauj79luphuaWV+aiJAPEdwU5rqA3zCHgUauaSlvduY83p7acWzfoDN65zURy7A5svOzA3Eu+x3oij9/tcAUgAEgG72gDaDoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750962428; c=relaxed/simple;
	bh=oDLPT18q/r5Sa/sPW0YO3KNd7eDexr8Kae/BmRJwRFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TOwl6q4z0tKvvjk9RXPMntl0y39ywatoKSB36e8ln4/uXdymWuQoKV5VOScGy679GmYuOz61omxOSaghlKjxMVyBiqSrGfJNHMEqKhNjxg98B8TEqMozlOORSrT7PZ27kdJXYknL+/wbSipaApHDH5znqs6PweYnp3gLQWSBbhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DLkTv5cW; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-74ad4533ac5so1883680b3a.0;
        Thu, 26 Jun 2025 11:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750962426; x=1751567226; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=O3vV8wgU8a7ayXx2BtQsO02S1WK7G3s++lysiciQwb4=;
        b=DLkTv5cWQcI7efo+lMWF462ZU/4CS3HsaobtmNjXxn6W+94l9UOlS3kpsS1G20xWzj
         fZgU7tLE2gHSIDQvrf8r1Y9zMBzFL6RU4hQ0ueni+4JoKP8K4dHQLT3zIvDhxr3i3RUW
         1o2MruoGqEKwF+M7/O8tSpq1L5A+HJWdNrRzocWH2CsPmXgC5c6ykj5mNnb/uvCMAsFl
         OxTCSrYdF5vEc71ShM5XNyych3sDUyDNxygbD75MHFGDwHFbXKw4wI05IIn/Ge2T8+D3
         cDYw3nGVt4IRNDdq8fz0PB31kxZwncqtumhvxMmvQjEppJ79+ugoItoAz5FlfE+gOYHZ
         +J8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750962426; x=1751567226;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O3vV8wgU8a7ayXx2BtQsO02S1WK7G3s++lysiciQwb4=;
        b=FgiuF2Kt+JjwhRDTweppwYpFaxEawwuirVfte1f7aXxw4nSIhrE6Na5O4rM0uQ5m4f
         4KKxr7QFt5kInQ3edy3+SGGlXAhFbb1Ecb61RPBRDgMow9Ou8om4fZz1IrmB1w7i56QE
         8YjNSz3FrFQ2xaPPWR6ieQoSGwEWaI4WNN3nI6CvMKbENiQowQ9DAQky6EXG1ycK1tYj
         BBRj53Jc6Fu84VG1eLXiwk7FRbxX3RhzCp/GxTMKxdfFohG+Gvmo9YtEUG+uptpBnjIy
         vsdHVF8DWuY4b3R/1WOSz3V4V2s8Z2lhpinscbbUL2lSTiGi8hYjkVD4LlN01jwmpYHN
         22AA==
X-Forwarded-Encrypted: i=1; AJvYcCUFlCXmp7VPUb0r1RhXQLQIK5Oo2I20Y0O2c8Exs1cY1uAa+OJcT8vamXdT1+Cr7qyqqnxMDp4w/fWGNw==@vger.kernel.org, AJvYcCVCDqxB/Lc2lOFAqQYVo/EPLKU6pFAuWg+j7HYd8uweNE5vlwupLyQZ2BiHv8t3gVleednqHmtFrIqd26YW@vger.kernel.org, AJvYcCVaVW8GZWjyTDFMxIYMRsVQihdX1Do1NNWB6TDzRbGXYSJu6Ukr/G78xfJvdnMoXe8fhA+1rWsYm1OSB6k=@vger.kernel.org, AJvYcCVcMNiGw3xxSPlKQnESZSJxFE2pUH6Vog9IRo0EjZ3X4NEKgJ4IBOQa12vUIAQ7rUewDGs7UIWOfGxb@vger.kernel.org
X-Gm-Message-State: AOJu0YyEaNNDdI5nV/+FbiS+9Pge+2Kvyv36b2W3evhT9GIsiXMdizZz
	6zB8Gwcw63Pi5NzdCJqSKHhUfProUejlakT8Ls77g3KmcGlfRboyCdQ4
X-Gm-Gg: ASbGncsG3qFjHueSgAO3yjSMdRXDV+WX8SmPF573ZBJ8Q7yFG8VV+v7BkRJl3BYdpP4
	nsW29qPVHXAEzIz4iiQcW030dVZjcuFGqX7BNtWbCROaZeO82Ibigd7QWlJ4m2QKpWZAGBkupxU
	cNHA0ORVfR2HxUYqe4JrTbxXj/dWzgQzPNbWb9rWogr4ZZhQv+jWZbwFEGe1D9gTMX+D4d3ItLB
	CG5FLzIV3EcP3q9gUYJp6bgLLP45EFTOuUOdLHyfIpJ+gzwmu+oE0EciA8DC5zSY7984q43mnaH
	jKH75uXrISptgwIMnvRIwlj3cWRZnC+r7cPN0uNSQx29S0j+SABD6rgZcnPcuHk=
X-Google-Smtp-Source: AGHT+IHgvB5vfIak0gyaCsnSNBHpbe+KRoD8iOXRRL1Z4EwbPyyOJAqHCsgH9fqpjZ/5u/JuBCTSPw==
X-Received: by 2002:a05:6a20:db0a:b0:215:e02f:1eb8 with SMTP id adf61e73a8af0-220a1007db5mr65991637.14.1750962426363;
        Thu, 26 Jun 2025 11:27:06 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:9c8f:acd3:efcb:bc3d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af541b627sm295107b3a.38.2025.06.26.11.27.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 11:27:05 -0700 (PDT)
Date: Thu, 26 Jun 2025 11:27:03 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Mario Limonciello <superm1@kernel.org>
Cc: Hans de Goede <hansg@kernel.org>, Mika Westerberg <westeri@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Linus Walleij <linus.walleij@linaro.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, "open list:GPIO ACPI SUPPORT" <linux-gpio@vger.kernel.org>, 
	"open list:GPIO ACPI SUPPORT" <linux-acpi@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:INPUT (KEYBOARD, MOUSE, JOYSTICK, TOUCHSCREEN)..." <linux-input@vger.kernel.org>, Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH v2 3/3] Input: soc_button_array: Only debounce cherryview
 and baytrail systems
Message-ID: <du46jt3mmkvceestjadbqmxbztp5xcurg4pzwzmqavo3pnfmak@tcfnufcu6de5>
References: <20250625181342.3175969-1-superm1@kernel.org>
 <20250625181342.3175969-4-superm1@kernel.org>
 <f5e1d50f-d85e-45a3-a131-f2da603c620c@kernel.org>
 <57e9b1d5-faf1-4c7a-87fc-047e0dc102f9@kernel.org>
 <a9bed0b4-b050-468b-91cb-bc4c81352046@kernel.org>
 <8fc9051f-bef3-43fc-83a1-172a0eb599dc@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8fc9051f-bef3-43fc-83a1-172a0eb599dc@kernel.org>

On Wed, Jun 25, 2025 at 03:34:07PM -0500, Mario Limonciello wrote:
> On 6/25/25 2:42 PM, Hans de Goede wrote:
> > Hi,
> > 
> > On 25-Jun-25 9:23 PM, Mario Limonciello wrote:
> > > On 6/25/25 2:03 PM, Hans de Goede wrote:
> > > > Hi,
> > > > 
> > > > On 25-Jun-25 8:13 PM, Mario Limonciello wrote:
> > > > > From: Mario Limonciello <mario.limonciello@amd.com>
> > > > > 
> > > > > commit 5c4fa2a6da7fb ("Input: soc_button_array - debounce the buttons")
> > > > > hardcoded all soc-button-array devices to use a 50ms debounce timeout
> > > > > but this doesn't work on all hardware.  The hardware I have on hand
> > > > > actually prescribes in the ASL that the timeout should be 0:
> > > > > 
> > > > > GpioInt (Edge, ActiveBoth, Exclusive, PullUp, 0x0000,
> > > > >            "\\_SB.GPIO", 0x00, ResourceConsumer, ,)
> > > > > {   // Pin list
> > > > >       0x0000
> > > > > }
> > > > > 
> > > > > Many cherryview and baytrail systems don't have accurate values in the
> > > > > ASL for debouncing and thus use software debouncing in gpio_keys. The
> > > > > value to use is programmed in soc_button_array.  Detect Cherry View
> > > > > and Baytrail using ACPI HID IDs used for those GPIO controllers and apply
> > > > > the 50ms only for those systems.
> > > > > 
> > > > > Cc: Hans de Goede <hansg@kernel.org>
> > > > > Fixes: 5c4fa2a6da7fb ("Input: soc_button_array - debounce the buttons")
> > > > > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> > > > 
> > > > I'm not a fan of this approach, I believe that we need to always debounce
> > > > when dealing with mechanical buttons otherwise we will get unreliable /
> > > > spurious input events.
> > > > 
> > > > My suggestion to deal with the issue where setting up debouncing at
> > > > the GPIO controller level is causing issues is to always use software
> > > > debouncing (which I suspect is what Windows does).
> > > > 
> > > > Let me copy and pasting my reply from the v1 thread with
> > > > a bit more detail on my proposal:
> > > > 
> > > > My proposal is to add a "no_hw_debounce" flag to
> > > > struct gpio_keys_platform_data and make the soc_button_array
> > > > driver set that regardless of which platform it is running on.
> > > > 
> > > > And then in gpio_keys.c do something like this:
> > > > 
> > > > diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
> > > > index f9db86da0818..2788d1e5782c 100644
> > > > --- a/drivers/input/keyboard/gpio_keys.c
> > > > +++ b/drivers/input/keyboard/gpio_keys.c
> > > > @@ -552,8 +552,11 @@ static int gpio_keys_setup_key(struct platform_device *pdev,
> > > >            bool active_low = gpiod_is_active_low(bdata->gpiod);
> > > >              if (button->debounce_interval) {
> > > > -            error = gpiod_set_debounce(bdata->gpiod,
> > > > -                    button->debounce_interval * 1000);
> > > > +            if (ddata->pdata->no_hw_debounce)
> > > > +                error = -EINVAL;
> > > > +            else
> > > > +                error = gpiod_set_debounce(bdata->gpiod,
> > > > +                        button->debounce_interval * 1000);
> > > >                /* use timer if gpiolib doesn't provide debounce */
> > > >                if (error < 0)
> > > >                    bdata->software_debounce =
> > > > 
> > > > So keep debouncing, as that will always be necessary when dealing with
> > > > mechanical buttons, but always use software debouncing to avoid issues
> > > > like the issue you are seeing.
> > > > 
> > > > My mention of the BYT/CHT behavior in my previous email was to point
> > > > out that those already always use software debouncing for the 50 ms
> > > > debounce-period. It was *not* my intention to suggest to solve this
> > > > with platform specific quirks/behavior.
> > > > 
> > > > Regards,
> > > > 
> > > > Hans
> > > 
> > > I mentioned on the v1 too, but let's shift conversation here.
> > 
> > Ack.
> > 
> > > So essentially all platforms using soc_button_array would always turn on software debouncing of 50ms?
> > 
> > Yes that is what my proposal entails.
> > 
> > > In that case what happens if the hardware debounce was ALSO set from the ASL?  You end up with double debouncing I would expect.
> > 
> > A hardware debounce of say 25 ms would still report the button down
> > immediately, it just won't report any state changes for 25 ms
> > after that, at least that is how I would expect this to work.
> > 
> > So the 50 ms ignore-button-releases for the sw debounce will start
> > at the same time as the hw ignore-button-release window and basically
> > the longest window will win. So having both active should not really
> > cause any problems.
> > 
> > Still only using one or the other as you propose below would
> > be better.
> > 
> > > Shouldn't you only turn on software debouncing when it's required?
> > > 
> > > I'm wondering if considering the first two patches we should have gpio-keys look up if hardware can support debounce, and then "only if it can't" we program the value from soc button array.
> > > 
> > > It can be done by having gpio_keys do a "get()" on debounce.  Iff the driver returns -ENOTSUPP /then/ program the software debounce.
> > 
> > Any special handling here should be done in soc_button_array since
> > this is specific to how with ACPI we have the GPIO resource
> > descriptors setting up the hw-debounce and then the need to do
> > software debounce when that was not setup.
> > 
> > As for checking for -ENOTSUPP I would make soc_button_array
> > do something like this.
> > 
> > ret = debounce_get()
> > if (ret <= 0)
> > 	use-sw-debounce;
> > 
> > If hw-debounce is supported but not setup, either because
> > the exact debounce value being requested is not supported
> > or because the DSDT specified 0, then sw-debouncing should
> > also be used.
> > 
> > Note this will still require the use of a new no_hw_debounce
> > flag so that we don't end up enabling hw-debounce in
> > the hw-debounce is supported but not setup case.
> > 
> > Regards,
> > 
> > Hans
> > 
> 
> I did some experiments with your proposal (letting SW debounce get
> programmed) and everything seems to work fine*.  I think you're right that
> setting a double debounce would be worst one wins.

I am confused, can you explain why do we need this new no_hw_debounce
flag? If AMD gpio driver is unable to program 50 ms debounce for a given
pin but does not return an error (or returns an error but leaves system
in a bad state) that is the issue in that driver and needs to be fixed
there? Why do we need to change soc_button_driver at all?

Thanks.

-- 
Dmitry

