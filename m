Return-Path: <linux-acpi+bounces-14738-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6C58AEA610
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Jun 2025 21:06:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C02A2560782
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Jun 2025 19:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C11802EF654;
	Thu, 26 Jun 2025 19:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kjqeD0QA"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C732EE60F;
	Thu, 26 Jun 2025 19:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750964776; cv=none; b=QQ2+NDYU0eyXOKR8nRnDqcs0QOHdDfbYdwxnFUVTUPjgAmTXWHC7H3gzblDjfdw/7lZ5m9Ywmy75wmRLdDGQoZpfNgFX8pLiXA4TbbPZpgXH+SzrlGGad00+2TGb/zH+anPybkMacXGsjlQiF1Ve/Pv4rrMq1LmmGL/5uerpn3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750964776; c=relaxed/simple;
	bh=gIobQwobxCQrjdnRCr0mJeQ17a/MXlGg/ieJ/QdsAuc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=utB63ESP9Wg2HFv9b7EbKih/5yb+bt4lbPXKigDyIubJ/lsNy17MyrBARwnG56ZEHFsMQnJhNq9ySqD0E6EPVdYL3oOBPXf09ELIQuHeFgajtPeJHCNadjJYqfzw6tAKpi0cHWjXAbagZPwVTl5sUwWD4gVPJrdNH4yZpGTTBik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kjqeD0QA; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b170c99aa49so1038557a12.1;
        Thu, 26 Jun 2025 12:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750964774; x=1751569574; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9Mz5PxV5u4URRxls1DxehZVlzWnepIHlLrU8BSZeUK0=;
        b=kjqeD0QAa/8DT6M4Q0NBqkk3GA4DgInCj2sB3j/9+r5Tq9NHi5oqkzSEect608PEUs
         HWpFw9i5ybQV3maargKAmBXPLOnSXU3Gtmon4QprXpQjKynVHpIkxh8LMfE5+j9yLtzG
         L9DWMVpPbj5FJS2RjdYn80Y7RDV3EftSbGHPK4WkIW8TTjH9P0SAG+xl0UNENbt2Cyo8
         cO8fMDTISdFXe643455E6D31UFvwfjoemwI3YHaI86L+acpf8fHTn7f3ZQ/HA23+yGPC
         YvfWRqfrTG2FUX8HqTcjxm2j6JMqTYj5M4TTa0mGD+F57V8KeobRT1++Dm7Dg+ndxq9I
         qrrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750964774; x=1751569574;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Mz5PxV5u4URRxls1DxehZVlzWnepIHlLrU8BSZeUK0=;
        b=LGZRE5c/b7vZ48YLF6XV4RrTKvNvoxfbVW//EpVENL+u4CRwDJW2T3Q8tcjaiBw30h
         VGL4pmJy5T6JXFXmMl2paW2rWRX/roubK+C2gZmxqjkomsrA3LrwSuOPcBzWLnbHVTVp
         Cc7BJ5wbxU67KkE775cfry4vudelxAniS71SYm6/rIPPm1/JDPjwuzx/NHRcSJk3i0gI
         XVVCu4vInmNQZwWquEqtEAbg3lb4IY3gbDgM16vXC5IjEpqva5vN2L9vCS9HUv/qg5Ub
         IsKOaj3UklSfxFVZGdxLGVeep2IQqH19TbmDnqA3b4BNKW9kVP92vQDJ+vFRgSWomNNR
         MMZw==
X-Forwarded-Encrypted: i=1; AJvYcCVp2rrUhtiRzriOFYwQoVrbkWvRw8PV+x1EXBjc4HxFSI1c99r18c2RZEuOsd31MSd0xN+Hb7vgwOQTKQ==@vger.kernel.org, AJvYcCW4EkqpMGQo08YAe/EpJn96+zqjZScezMZZMvOmVPc7+QiVmbUttnjO15YOw1g+93JEWsOX3m4iiug7@vger.kernel.org, AJvYcCWUZC2jq8dN8105+sp1L+OJ4AZun40NJXrwW8E6pAm/TxpDox0tUkQB6kRc5/+T/HJujGgB8qGgJj4bAkIh@vger.kernel.org, AJvYcCWwDZR398Z3diNFEeQb0WBb6a2xJvu6BEKHzIbZllZbrXYSed7GCW/tR7xdBl0gI6sz9bz0ArmquKjgeAE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe+3GgXVUwfNVswqHU6umKY94O/Bs4hHd6fSkOXKKBIMbqmGOP
	l90GUfxnPS003sxgIyQ4OX4cKSZuOWTF1Jl1/7MM7UUsLcNC4jmCWZi3
X-Gm-Gg: ASbGncvEkvZUKKlZjLMlovVwwU0doWcKS0Dv17K56qxyCiXCpzWIL3Vsw1Nx7rZqha2
	yB/8LjPCKMGwlA4QhLcNkdeVIKdklChTmWsejfMyK4sglwLmI1nxpANHOfDoM01/dW/GksnBHe9
	5vxh8Zggpsmr5eZ+R6O6d4k1Sj3Nq+OJAVwsTIcovcjjcGY9nMxU4027b92nxrSelCVKnuDvARs
	84MSaxPDRH7LVfPA5b34+K/nTZ8Dd9/HHLs2NTdY3jE9YogfTxLn3545O/EtxIkzQ76k6gt9MH7
	+jR6hhpi04KM7Q1/1JZYyj067y1LIJrRrIPAOWJGQgLx0BiFX4dhWhEeQqSZLbU=
X-Google-Smtp-Source: AGHT+IF6v+aQi4C/ZoF4wjQEyR5F2FYOvK31F3S49E4J2kT/le4rr/P7+VpQ2FEZvE7fjkxg3rEj2A==
X-Received: by 2002:a05:6a21:392:b0:21f:ed74:7068 with SMTP id adf61e73a8af0-220a169c7f9mr182097637.23.1750964774015;
        Thu, 26 Jun 2025 12:06:14 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:9c8f:acd3:efcb:bc3d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af540b443sm386171b3a.15.2025.06.26.12.06.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 12:06:13 -0700 (PDT)
Date: Thu, 26 Jun 2025 12:06:11 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Mario Limonciello <superm1@kernel.org>
Cc: Hans de Goede <hansg@kernel.org>, Mika Westerberg <westeri@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Linus Walleij <linus.walleij@linaro.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, "open list:GPIO ACPI SUPPORT" <linux-gpio@vger.kernel.org>, 
	"open list:GPIO ACPI SUPPORT" <linux-acpi@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:INPUT (KEYBOARD, MOUSE, JOYSTICK, TOUCHSCREEN)..." <linux-input@vger.kernel.org>, Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH v3 4/4] Input: Don't send fake button presses to wake
 system
Message-ID: <tpetaw6qdwojt46fcmzlmy2hdegbuwcjnbah7uebj6ilegfk4y@5uo6a7ediaw2>
References: <20250625215813.3477840-1-superm1@kernel.org>
 <20250625215813.3477840-5-superm1@kernel.org>
 <710f7c04-0099-4611-b2ea-4dd4219ad5e2@kernel.org>
 <23f30094-68cc-47fe-86e0-5289cb41e940@kernel.org>
 <rn2kp5tog2agvswva2ipqq2ytiqdcgccnocudsg6ckwfh4roei@provk2g6dita>
 <363c2b92-4bfc-4537-9fca-025eef09526f@kernel.org>
 <nxticocp26r5mmpkttritw76h5igw7bdpus6zaf5krkso2h5xy@wna6m2quekfi>
 <cbbf0caf-82ce-4427-9844-b11e0f5cacdb@kernel.org>
 <obpakvzyludc4jskqzyxf65dhqds7ie3jkbfsqdve32ouuaili@xvogkmwvbmbf>
 <bf97081a-e766-405e-9385-3657135b8c0f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf97081a-e766-405e-9385-3657135b8c0f@kernel.org>

On Thu, Jun 26, 2025 at 01:55:29PM -0500, Mario Limonciello wrote:
> On 6/26/2025 1:48 PM, Dmitry Torokhov wrote:
> > On Thu, Jun 26, 2025 at 01:20:54PM -0500, Mario Limonciello wrote:
> > > On 6/26/2025 1:07 PM, Dmitry Torokhov wrote:
> > > > On Thu, Jun 26, 2025 at 12:53:02PM -0500, Mario Limonciello wrote:
> > > > > 
> > > > > 
> > > > > On 6/26/25 12:44 PM, Dmitry Torokhov wrote:
> > > > > > Hi Mario,
> > > > > > 
> > > > > > On Thu, Jun 26, 2025 at 06:33:08AM -0500, Mario Limonciello wrote:
> > > > > > > 
> > > > > > > 
> > > > > > > On 6/26/25 3:35 AM, Hans de Goede wrote:
> > > > > > > > Hi Mario,
> > > > > > > > 
> > > > > > > > On 25-Jun-25 23:58, Mario Limonciello wrote:
> > > > > > > > > From: Mario Limonciello <mario.limonciello@amd.com>
> > > > > > > > > 
> > > > > > > > > Sending an input event to wake a system does wake it, but userspace picks
> > > > > > > > > up the keypress and processes it.  This isn't the intended behavior as it
> > > > > > > > > causes a suspended system to wake up and then potentially turn off if
> > > > > > > > > userspace is configured to turn off on power button presses.
> > > > > > > > > 
> > > > > > > > > Instead send a PM wakeup event for the PM core to handle waking the system.
> > > > > > > > > 
> > > > > > > > > Cc: Hans de Goede <hansg@kernel.org>
> > > > > > > > > Fixes: 0f107573da417 ("Input: gpio_keys - handle the missing key press event in resume phase")
> > > > > > > > > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> > > > > > > > > ---
> > > > > > > > >      drivers/input/keyboard/gpio_keys.c | 7 +------
> > > > > > > > >      1 file changed, 1 insertion(+), 6 deletions(-)
> > > > > > > > > 
> > > > > > > > > diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
> > > > > > > > > index 773aa5294d269..4c6876b099c43 100644
> > > > > > > > > --- a/drivers/input/keyboard/gpio_keys.c
> > > > > > > > > +++ b/drivers/input/keyboard/gpio_keys.c
> > > > > > > > > @@ -420,12 +420,7 @@ static irqreturn_t gpio_keys_gpio_isr(int irq, void *dev_id)
> > > > > > > > >      		pm_stay_awake(bdata->input->dev.parent);
> > > > > > > > >      		if (bdata->suspended  &&
> > > > > > > > >      		    (button->type == 0 || button->type == EV_KEY)) {
> > > > > > > > > -			/*
> > > > > > > > > -			 * Simulate wakeup key press in case the key has
> > > > > > > > > -			 * already released by the time we got interrupt
> > > > > > > > > -			 * handler to run.
> > > > > > > > > -			 */
> > > > > > > > > -			input_report_key(bdata->input, button->code, 1);
> > > > > > > > > +			pm_wakeup_event(bdata->input->dev.parent, 0);
> > > > > > 
> > > > > > There is already pm_stay_awake() above.
> > > > > 
> > > > > But that doesn't help with the fact that userspace gets KEY_POWER from this
> > > > > and reacts to it.
> > > > > 
> > > > > > 
> > > > > > > > >      		}
> > > > > > > > >      	}
> > > > > > > > 
> > > > > > > > Hmm, we have the same problem on many Bay Trail / Cherry Trail
> > > > > > > > windows 8 / win10 tablets, so  this has been discussed before and e.g.
> > > > > > > > Android userspace actually needs the button-press (evdev) event to not
> > > > > > > > immediately go back to sleep, so a similar patch has been nacked in
> > > > > > > > the past.
> > > > > > > > 
> > > > > > > > At least for GNOME this has been fixed in userspace by ignoring
> > > > > > > > power-button events the first few seconds after a resume from suspend.
> > > > > > > > 
> > > > > > > 
> > > > > > > The default behavior for logind is:
> > > > > > > 
> > > > > > > HandlePowerKey=poweroff
> > > > > > > 
> > > > > > > Can you share more about what version of GNOME has a workaround?
> > > > > > > This was actually GNOME (on Ubuntu 24.04) that I found this issue.
> > > > > > > 
> > > > > > > Nonetheless if this is dependent on an Android userspace problem could we
> > > > > > > perhaps conditionalize it on CONFIG_ANDROID_BINDER_DEVICES?
> > > > > > 
> > > > > > No it is not only Android, other userspace may want to distinguish
> > > > > > between normal and "dark" resume based on keyboard or other user
> > > > > > activity.
> > > > > > 
> > > > > > Thanks.
> > > > > > 
> > > > > In this specific case does the key passed up to satisfy this userspace
> > > > > requirement and keep it awake need to specifically be a fabricated
> > > > > KEY_POWER?
> > > > > 
> > > > > Or could we find a key that doesn't require some userspace to ignore
> > > > > KEY_POWER?
> > > > > 
> > > > > Maybe something like KEY_RESERVED, KEY_FN, or KEY_POWER2?
> > > > 
> > > > The code makes no distinction between KEY_POWER and KEY_A or KEY_B, etc.
> > > > It simply passes event to userspace for processing.
> > > 
> > > Right.  I don't expect a problem with most keys, but my proposal is to
> > > special case KEY_POWER while suspended.  If a key press event must be sent
> > > to keep Android and other userspace happy I suggest sending something
> > > different just for that situation.
> > 
> > I do not know if userspace specifically looks for KEY_POWER or if it
> > looks for user input in general, and I'd rather be on safe side and not
> > mangle user input.
> > 
> > As Hans mentioned, at least some userspace already prepared to deal with
> > this issue. And again, this only works if by the time ISR/debounce
> > runs the key is already released. What if it is still pressed? You still
> > going to observe KEY_POWER and need to suppress turning off the screen.
> > 
> > > 
> > > Like this:
> > > 
> > > diff --git a/drivers/input/keyboard/gpio_keys.c
> > > b/drivers/input/keyboard/gpio_keys.c
> > > index 773aa5294d269..66e788d381956 100644
> > > --- a/drivers/input/keyboard/gpio_keys.c
> > > +++ b/drivers/input/keyboard/gpio_keys.c
> > > @@ -425,7 +425,10 @@ static irqreturn_t gpio_keys_gpio_isr(int irq, void
> > > *dev_id)
> > >                           * already released by the time we got interrupt
> > >                           * handler to run.
> > >                           */
> > > -                       input_report_key(bdata->input, button->code, 1);
> > > +                       if (button->code == KEY_POWER)
> > > +                               input_report_key(bdata->input, KEY_WAKEUP,
> > > 1);
> > 
> > Just FYI: Here your KEY_WAKEUP is stuck forever.
> 
> Thanks.
> 
> > 
> > > +                       else
> > > +                               input_report_key(bdata->input, button->code,
> > > 1);
> > >                  }
> > >          }
> > > 
> > > 
> > > 
> > > > 
> > > > You need to fix your userspace. Even with your tweak it is possible for
> > > > userspace to get a normal key event "too early" and turn off the screen
> > > > again, so you still need to handle this situation.
> > > > 
> > > > Thanks.
> > > > 
> > > 
> > > I want to note this driver works quite differently than how ACPI power
> > > button does.
> > > 
_> > > You can see in acpi_button_notify() that the "keypress" is only forwarded
> > > when not suspended [1].  Otherwise it's just wakeup event (which is what my
> > > patch was modeling).
> > > 
> > > https://github.com/torvalds/linux/blob/v6.16-rc3/drivers/acpi/button.c#L461
> > > [1]
> > 
> > If you check acpi_button_resume() you will see that the events are sent
> > from there. Except that for some reason they chose to use KEY_WAKEUP and
> > not KEY_POWER, oh well. Unlike acpi button driver gpio_keys is used on
> > multiple other platforms.
> > 
> > Thanks.
> > 
> 
> Well that would explain the difference, and git blame gives the history [1].
> 
> It's from enablement for Android with ACPI power button.  That commit also
> mentions that Android can handle both POWER and WAKEUP from input device to
> wakeup the system.  Non-Android userspace doesn't do anything with
> KEY_WAKEUP today.

*All* non-Android userspace?

> 
> So this has me thinking the proposal I had above to special case KEY_POWER
> and translate to KEY_WAKEUP is the right way forward, just making sure to
> release the key as you rightfully pointed out.

You keep ignoring the fact that it does not solve your issue when the
key/button is pressed just a tad longer.

There are a ton of drivers that report KEY_POWER and do not convert it
to anything else on resume. I will not accept patches that mangle input
events in the gpio_keys driver, sorry.

Thanks.

-- 
Dmitry

