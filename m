Return-Path: <linux-acpi+bounces-14750-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0D28AEA772
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Jun 2025 21:55:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EE371C430B9
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Jun 2025 19:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E322EFD96;
	Thu, 26 Jun 2025 19:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LcPjM6PN"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417CB253F3D;
	Thu, 26 Jun 2025 19:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750967705; cv=none; b=NLy0Xhrl8BFVx6hRW6AUgid5NzBZKI08vGRhStZcFOvyCO3QOqhhStqcLiUTLpasyNSYm6qXWpPYbphE5368Hsr5Bcs6w9GaM8D66Jgykz1w4v+hvzjoqJDnH6B8BXtLL4WBqvPCs6sKxktYAp3MvrgFE9xp7i7PBWXPfGOFUy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750967705; c=relaxed/simple;
	bh=nPiNgS1GkyhSisN49ESTbxXayr8Cq9EcSK13zRYuAB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uFTk66FMniPSz7zhufgJbthE22FViYfUCtj9Opl9mswXbpkjWbpyU7TJhDFxZ3HmrIqy65syg+CSmWFkJ8lnplMdvILCI1gxT3uP8uVGemBPGM1I6eqXW7ThKhMZ0aAWAI19/WweFBL95gGskizCYs61Nv6agqN2Us61dGvFvHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LcPjM6PN; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b34a6d0c9a3so1406547a12.3;
        Thu, 26 Jun 2025 12:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750967702; x=1751572502; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cc0we5YTaDBI0Ft6hDkn9wijRV+gwWudalwa/I8ZARQ=;
        b=LcPjM6PNWPdl7ESZMVeB9pd9apNO3NuPihQjkxp7AjFNt34kDTgPnfkVZZw1+L6QR7
         yzYS4MsImAwq6jX2L3ub6BxiHSe7xyoiewbWp6P8adiCXU0TkiaILvITLBTLtcon7Zem
         e2YytGCQ4o9xBQkdxLOHbkVpf2SxxzkAAb2y0lkPpf1QBFcmSnIq8ILlR3nFGcOFHoyF
         05Y/G+WeJzjLApguuuTu/xAUrTm62uqSVRA3EkVIZW8/WxgLfquo/mGA0wbI1KcfBnh1
         8QhwckWWroNugR2ccKYAWB4y9S9xITulc+Tj5BxV16lF7pgc1FGDa71kXB+aCwfkq5kE
         Hx2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750967702; x=1751572502;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cc0we5YTaDBI0Ft6hDkn9wijRV+gwWudalwa/I8ZARQ=;
        b=B/o1cuGHmsJLykjt3LJG+YMtr2UBlm2hPhQXJ1iqqVpJPKJlzvJgg1esoqbTa/q5Ok
         J6486swcZD2e6Sy24aRm/bsQLFdI0/hjUaI/6Y7TbN7+mlmLlnBlmhQAhdhCyGl8nbn2
         2gphygZMAwENumjdEtNypwRryTH9zPd3YDUno42XYDgSclo6bPG23wnzL9JGt6S8SJ+i
         rZQ6lVohy4GA2nCajB4eN8lCXr2sBOhzMyr5jpP6/iw99ciyaTp2GIvJ2JwO+mP4cb+l
         9ehjgxh+I5gUB31/jrn0xBnU7HUsQAPShMmHK4SJz8O0Y7Q3/11HjNt2aDLrf+h3kto8
         tYgQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFUMQaF9yL7fgr2a7UonpvWP4M3uF7jGanvVfTB/t4BzTL1Ulias07M4pWA+oPnAFYQDGxoCqHr/sp6uM=@vger.kernel.org, AJvYcCVcuvPlWBUV7k+82pb2N2s7U6iec511o9bDrWxh1EZKiBxtKnpPT9F5+yeIDI8rPrQR6tDXPJJUADqy+A==@vger.kernel.org, AJvYcCWCUpB/AOSJAcR/5yY/NpagkUbZOrnLjZSR0YwRyUj8RDT3VjJVHl2byAf417B/0FJZeAj0mkvibLcA@vger.kernel.org, AJvYcCWjlhEWezDiZrXa6DIwzQdupNo7AalK/Tf5B+SPIeXlerIavRXtG4QLBnmNWXKW2GqvY/CuwPDJCld3YppF@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1JK5FpXs21GeJfVQYncNf5GIZtn+uvfKCVnISvAhjQ4DvOUpV
	Lc3xQHr7eSwbwpXlrhaGMf6JAVBEOU39aWIWw4wFGxuQqMggE+OiRP8d
X-Gm-Gg: ASbGncv75GF/38XFZsEt/rXR3Y5IYMZSL+IRX94B56B4dXBoKBUWu7RohRpsJvMK42A
	nZ4gA5cgtLzTdgw0ocdi9cy0avBgkKAgnBOb+oIjct1WCsr8q6dKsB/YJOI3vohjMn6Wjc8wMbJ
	QDyx9gKnbjiA9mu5XqjSaFhDG2UPCBG3nm4tIB5vWjJED6055OnfPbDJ/mX8g3lzLwbIjhLBDQg
	5MtsVdUFFzD4P76hObQNtWS4jPJKAHo/u4rZAjrBHhF/wCdQPqxTKV+14b02P/irWZH27wHThJm
	M8OIMYlmNbVcd3WezHfWsGZP7x4MGvYAZ0FjByPHiyrPwEOU4U/qPszSP5pETR0=
X-Google-Smtp-Source: AGHT+IEsIWO1ChAP9ccr/IdhcP/eXhTSFmTDQwnbgtNRIWX2WjGVZAzevHwE7vG0sc8CLsknrkrknQ==
X-Received: by 2002:a17:90a:d603:b0:313:db0b:75e4 with SMTP id 98e67ed59e1d1-318c9288263mr415627a91.33.1750967702264;
        Thu, 26 Jun 2025 12:55:02 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:9c8f:acd3:efcb:bc3d])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-318c1502b9bsm488388a91.42.2025.06.26.12.55.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 12:55:01 -0700 (PDT)
Date: Thu, 26 Jun 2025 12:54:58 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Mario Limonciello <superm1@kernel.org>
Cc: Hans de Goede <hansg@kernel.org>, Mika Westerberg <westeri@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Linus Walleij <linus.walleij@linaro.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, "open list:GPIO ACPI SUPPORT" <linux-gpio@vger.kernel.org>, 
	"open list:GPIO ACPI SUPPORT" <linux-acpi@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:INPUT (KEYBOARD, MOUSE, JOYSTICK, TOUCHSCREEN)..." <linux-input@vger.kernel.org>, Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH v2 3/3] Input: soc_button_array: Only debounce cherryview
 and baytrail systems
Message-ID: <mkgtrb5gt7miyg6kvqdlbu4nj3elym6ijudobpdi26gp4xxay5@rsa6ytrjvj2q>
References: <f5e1d50f-d85e-45a3-a131-f2da603c620c@kernel.org>
 <57e9b1d5-faf1-4c7a-87fc-047e0dc102f9@kernel.org>
 <a9bed0b4-b050-468b-91cb-bc4c81352046@kernel.org>
 <8fc9051f-bef3-43fc-83a1-172a0eb599dc@kernel.org>
 <du46jt3mmkvceestjadbqmxbztp5xcurg4pzwzmqavo3pnfmak@tcfnufcu6de5>
 <55b4cd56-1812-4048-bf16-4b5b94a842d7@kernel.org>
 <vmjnwfg2mqr2anugefjtzezimcep27gi64d4wsctiu476w73rl@oo6r4o33jk44>
 <06ad432d-e138-4457-8180-bc35f08feed6@kernel.org>
 <blkvhrhch4y7psjqi6mlpn4q2qqrggwosw47plwizbxnjvlh5o@dux3as52kbqd>
 <5297e128-1906-4617-9c6c-f16498ef4907@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5297e128-1906-4617-9c6c-f16498ef4907@kernel.org>

On Thu, Jun 26, 2025 at 02:37:19PM -0500, Mario Limonciello wrote:
> On 6/26/2025 2:32 PM, Dmitry Torokhov wrote:
> > On Thu, Jun 26, 2025 at 09:04:22PM +0200, Hans de Goede wrote:
> > > Hi Dmitry,
> > > 
> > > On 26-Jun-25 20:53, Dmitry Torokhov wrote:
> > > > On Thu, Jun 26, 2025 at 01:30:15PM -0500, Mario Limonciello wrote:
> > > > > On 6/26/2025 1:27 PM, Dmitry Torokhov wrote:
> > > > > > On Wed, Jun 25, 2025 at 03:34:07PM -0500, Mario Limonciello wrote:
> > > > > > > On 6/25/25 2:42 PM, Hans de Goede wrote:
> > > > > > > > Hi,
> > > > > > > > 
> > > > > > > > On 25-Jun-25 9:23 PM, Mario Limonciello wrote:
> > > > > > > > > On 6/25/25 2:03 PM, Hans de Goede wrote:
> > > > > > > > > > Hi,
> > > > > > > > > > 
> > > > > > > > > > On 25-Jun-25 8:13 PM, Mario Limonciello wrote:
> > > > > > > > > > > From: Mario Limonciello <mario.limonciello@amd.com>
> > > > > > > > > > > 
> > > > > > > > > > > commit 5c4fa2a6da7fb ("Input: soc_button_array - debounce the buttons")
> > > > > > > > > > > hardcoded all soc-button-array devices to use a 50ms debounce timeout
> > > > > > > > > > > but this doesn't work on all hardware.  The hardware I have on hand
> > > > > > > > > > > actually prescribes in the ASL that the timeout should be 0:
> > > > > > > > > > > 
> > > > > > > > > > > GpioInt (Edge, ActiveBoth, Exclusive, PullUp, 0x0000,
> > > > > > > > > > >              "\\_SB.GPIO", 0x00, ResourceConsumer, ,)
> > > > > > > > > > > {   // Pin list
> > > > > > > > > > >         0x0000
> > > > > > > > > > > }
> > > > > > > > > > > 
> > > > > > > > > > > Many cherryview and baytrail systems don't have accurate values in the
> > > > > > > > > > > ASL for debouncing and thus use software debouncing in gpio_keys. The
> > > > > > > > > > > value to use is programmed in soc_button_array.  Detect Cherry View
> > > > > > > > > > > and Baytrail using ACPI HID IDs used for those GPIO controllers and apply
> > > > > > > > > > > the 50ms only for those systems.
> > > > > > > > > > > 
> > > > > > > > > > > Cc: Hans de Goede <hansg@kernel.org>
> > > > > > > > > > > Fixes: 5c4fa2a6da7fb ("Input: soc_button_array - debounce the buttons")
> > > > > > > > > > > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> > > > > > > > > > 
> > > > > > > > > > I'm not a fan of this approach, I believe that we need to always debounce
> > > > > > > > > > when dealing with mechanical buttons otherwise we will get unreliable /
> > > > > > > > > > spurious input events.
> > > > > > > > > > 
> > > > > > > > > > My suggestion to deal with the issue where setting up debouncing at
> > > > > > > > > > the GPIO controller level is causing issues is to always use software
> > > > > > > > > > debouncing (which I suspect is what Windows does).
> > > > > > > > > > 
> > > > > > > > > > Let me copy and pasting my reply from the v1 thread with
> > > > > > > > > > a bit more detail on my proposal:
> > > > > > > > > > 
> > > > > > > > > > My proposal is to add a "no_hw_debounce" flag to
> > > > > > > > > > struct gpio_keys_platform_data and make the soc_button_array
> > > > > > > > > > driver set that regardless of which platform it is running on.
> > > > > > > > > > 
> > > > > > > > > > And then in gpio_keys.c do something like this:
> > > > > > > > > > 
> > > > > > > > > > diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
> > > > > > > > > > index f9db86da0818..2788d1e5782c 100644
> > > > > > > > > > --- a/drivers/input/keyboard/gpio_keys.c
> > > > > > > > > > +++ b/drivers/input/keyboard/gpio_keys.c
> > > > > > > > > > @@ -552,8 +552,11 @@ static int gpio_keys_setup_key(struct platform_device *pdev,
> > > > > > > > > >              bool active_low = gpiod_is_active_low(bdata->gpiod);
> > > > > > > > > >                if (button->debounce_interval) {
> > > > > > > > > > -            error = gpiod_set_debounce(bdata->gpiod,
> > > > > > > > > > -                    button->debounce_interval * 1000);
> > > > > > > > > > +            if (ddata->pdata->no_hw_debounce)
> > > > > > > > > > +                error = -EINVAL;
> > > > > > > > > > +            else
> > > > > > > > > > +                error = gpiod_set_debounce(bdata->gpiod,
> > > > > > > > > > +                        button->debounce_interval * 1000);
> > > > > > > > > >                  /* use timer if gpiolib doesn't provide debounce */
> > > > > > > > > >                  if (error < 0)
> > > > > > > > > >                      bdata->software_debounce =
> > > > > > > > > > 
> > > > > > > > > > So keep debouncing, as that will always be necessary when dealing with
> > > > > > > > > > mechanical buttons, but always use software debouncing to avoid issues
> > > > > > > > > > like the issue you are seeing.
> > > > > > > > > > 
> > > > > > > > > > My mention of the BYT/CHT behavior in my previous email was to point
> > > > > > > > > > out that those already always use software debouncing for the 50 ms
> > > > > > > > > > debounce-period. It was *not* my intention to suggest to solve this
> > > > > > > > > > with platform specific quirks/behavior.
> > > > > > > > > > 
> > > > > > > > > > Regards,
> > > > > > > > > > 
> > > > > > > > > > Hans
> > > > > > > > > 
> > > > > > > > > I mentioned on the v1 too, but let's shift conversation here.
> > > > > > > > 
> > > > > > > > Ack.
> > > > > > > > 
> > > > > > > > > So essentially all platforms using soc_button_array would always turn on software debouncing of 50ms?
> > > > > > > > 
> > > > > > > > Yes that is what my proposal entails.
> > > > > > > > 
> > > > > > > > > In that case what happens if the hardware debounce was ALSO set from the ASL?  You end up with double debouncing I would expect.
> > > > > > > > 
> > > > > > > > A hardware debounce of say 25 ms would still report the button down
> > > > > > > > immediately, it just won't report any state changes for 25 ms
> > > > > > > > after that, at least that is how I would expect this to work.
> > > > > > > > 
> > > > > > > > So the 50 ms ignore-button-releases for the sw debounce will start
> > > > > > > > at the same time as the hw ignore-button-release window and basically
> > > > > > > > the longest window will win. So having both active should not really
> > > > > > > > cause any problems.
> > > > > > > > 
> > > > > > > > Still only using one or the other as you propose below would
> > > > > > > > be better.
> > > > > > > > 
> > > > > > > > > Shouldn't you only turn on software debouncing when it's required?
> > > > > > > > > 
> > > > > > > > > I'm wondering if considering the first two patches we should have gpio-keys look up if hardware can support debounce, and then "only if it can't" we program the value from soc button array.
> > > > > > > > > 
> > > > > > > > > It can be done by having gpio_keys do a "get()" on debounce.  Iff the driver returns -ENOTSUPP /then/ program the software debounce.
> > > > > > > > 
> > > > > > > > Any special handling here should be done in soc_button_array since
> > > > > > > > this is specific to how with ACPI we have the GPIO resource
> > > > > > > > descriptors setting up the hw-debounce and then the need to do
> > > > > > > > software debounce when that was not setup.
> > > > > > > > 
> > > > > > > > As for checking for -ENOTSUPP I would make soc_button_array
> > > > > > > > do something like this.
> > > > > > > > 
> > > > > > > > ret = debounce_get()
> > > > > > > > if (ret <= 0)
> > > > > > > > 	use-sw-debounce;
> > > > > > > > 
> > > > > > > > If hw-debounce is supported but not setup, either because
> > > > > > > > the exact debounce value being requested is not supported
> > > > > > > > or because the DSDT specified 0, then sw-debouncing should
> > > > > > > > also be used.
> > > > > > > > 
> > > > > > > > Note this will still require the use of a new no_hw_debounce
> > > > > > > > flag so that we don't end up enabling hw-debounce in
> > > > > > > > the hw-debounce is supported but not setup case.
> > > > > > > > 
> > > > > > > > Regards,
> > > > > > > > 
> > > > > > > > Hans
> > > > > > > > 
> > > > > > > 
> > > > > > > I did some experiments with your proposal (letting SW debounce get
> > > > > > > programmed) and everything seems to work fine*.  I think you're right that
> > > > > > > setting a double debounce would be worst one wins.
> > > > > > 
> > > > > > I am confused, can you explain why do we need this new no_hw_debounce
> > > > > > flag? If AMD gpio driver is unable to program 50 ms debounce for a given
> > > > > > pin but does not return an error (or returns an error but leaves system
> > > > > > in a bad state) that is the issue in that driver and needs to be fixed
> > > > > > there? Why do we need to change soc_button_driver at all?
> > > > > > 
> > > > > > Thanks.
> > > > > > 
> > > > > 
> > > > > The requested 50ms HW debounce gets programmed to the hardware register
> > > > > successfully.  It is within bound that the GPIO controller can support.
> > > > > 
> > > > > The problem is the power button does not function with a 50ms debounce.
> > > > > The firmware asserted that 0ms should have been programmed (by the _CRS
> > > > > value in GpioInt).
> > > > 
> > > > I do not understand how debounce that is within the controller's
> > > > supported range can not work. The button is a switch that reports on and
> > > > off, there is nothing more to it, is there?
> > > > 
> > > > I feel there is a deeper problem that we simply trying to paper over.
> > > 
> > > Note that on x86 wakeup events and GPIO IRQs typically use a different
> > > event mechanism / path under the hood (PME events to resume from suspend).
> > > It is not just a case of marking the IRQ used while running as a wakeup
> > > source.
> > > 
> > > So it is possible that setting the hw-debouncing is in some way interfering
> > > with the reporting of x86 PME events while the system is suspended.
> > 
> > Still this looks like platform issue, not driver issue. Should GPIO
> > driver refuse programming debounce if pin is configured as potential
> > wakeup source then?
> 
> How can the driver intricate details about the hardware connected to the
> GPIO and how it behaves?
> 
> The driver is "dumb" and programs the registers according to the calls given
> to it.

I do not think driver needs to know details of hardware connected to
GPIO. I know you mentioned that it may be connected to an EC that does
its own debouncing, however this should make no difference from AP
standpoint: you are still dealing with a GPIO line and your GPIO
controller does debouncing for that line (which may be unnecessary
because the line will not be bouncing).

Hans mentioned that it is possible that this debounce interferes with
the platform reporting wakeup events. I can easily believe that. But
that means that if there is another peripheral device similarly attached
to such GPIO configured for wakeup, device that does not use gpio_keys
driver, it will have the same issue. And I wonder if the solution is for
your GPIO provider driver to refuse programming debounce for GPIOs that
are marked as wake capable.

> 
> > 
> > > 
> > > Most systems where soc_button_array is used don't support hw-debouncing
> > > in the first place, so on most systems this change is a no-op.
> > 
> > The change is not limited to soc_button_array driver, we need to add
> > flags to gpio_keys as well...
> 
> That's exactly what the patch v3 3/4 is doing.

What I was trying to say is that we are not only touching
soc_button_array driver but also have to make changes to more generic
gpio_keys driver which I would like to avoid if possible.

Thanks.

-- 
Dmitry

