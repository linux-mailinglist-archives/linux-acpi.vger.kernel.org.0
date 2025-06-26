Return-Path: <linux-acpi+bounces-14740-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C10CAAEA62B
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Jun 2025 21:14:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 621781898177
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Jun 2025 19:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 210D52EF66C;
	Thu, 26 Jun 2025 19:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ISyGmlhv"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63EBF239E85;
	Thu, 26 Jun 2025 19:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750965268; cv=none; b=KpTZLQd2JO6Fy8b2Zx4VYnevh3hMK88aDeZsGoeS6sjIJjX7GcacULX6Lv8FkbBAolgKhemVJU73SCX2+aqbbrO+MjheMOryPFY6/AcV8mpzBEhaa3ffXozbpg2hX2eCmTURbxhrishXg/F3obxN2BLQWbmP6yERwn3GFxRlWms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750965268; c=relaxed/simple;
	bh=9x6pG9RLbZPKBIPsSMJ/WL0a6V/B+OWalfScaCNzwPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HoDPsZRShXvMiMrmsUwDfiDrA44KmhLv6GfZA14Xa/mIE/7cDUoy5lNuv435K8pK9VazA/Ij2y4GfIz2dFkQV0Cwl1JLbIewMiIMWU8FTT/Tdmv7qjt0rE6ZT9QJsyYzRRHKueqYm7AIZESexEHmAGFlrxgBIkt1TNmm5rstl/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ISyGmlhv; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-749248d06faso1379839b3a.2;
        Thu, 26 Jun 2025 12:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750965265; x=1751570065; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XdcjSssGECtbWg9PecOIL+vj1xixDzeAUtUeVZdIGgY=;
        b=ISyGmlhvtIPFuOiLFIxSGDJrSf3lcaO0NJgANlN/s39Gy7EyAceWt+SXV86VJSZQ2l
         3t9RJScsAjVK6B4M6QO3zSPNzijfdNwxVsH2pqmQtjZMWccS1N5asgKCcAkuXFYJ7fzu
         eWayelVH7vVzTWTzur9BAqfwwodvzbBGOrl7enX3dYUBHC7Xn0sIEFtfp4RHcIejoq35
         MbyC3UQo5hR/j+R0TSDyRFyYjKSPRwvk2M6xu0DegEQp1/+AFyrhTgv9aeqq0wUqcqja
         9NW9HVIQkHsJ8aYc0Ow1p67O8S/BMxkRxEpymNg+PeJJu5O7VadCno6FtxDNS3tvxBcJ
         p77Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750965265; x=1751570065;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XdcjSssGECtbWg9PecOIL+vj1xixDzeAUtUeVZdIGgY=;
        b=OJ3WoBc1Nblh3GP5Kbrawf4YDuhO8FkMVp4tMUp2huqAOA4D62YDFp7vak9d9XsOSh
         VCGyTQ61bAeJ7H5Vqd1KIL8qJPWSDYC+F4pjO0rxPf5NvUa9NdZ3Z3GTFPCJYgyJdGuJ
         ci5jTR325IzaY0QcXMCyb14NnNmbzRPjD8Jos+JZMnrYkL8YdfQMRiKHikqPI43iooOb
         a75yJ0hPllA3BNDLHj0fs29Y12An3KrmuCX2CZzXgoc5TKcOa7T2r8DRRdjA5RstzZZy
         itXDWPG3mc3IGO2Nl/oHcFtCiPEV0+ndYfetAmI5tcJ95/GwHxPIQQmBB2EepyhpwADG
         MpxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYoyQVYuIEGf/ZEW4RQHzITqW1fw4hbbAHjGHdL5qL07M6sO8n27ZoR1C5tIOmaW24ArGD/48tUfyNQ1A=@vger.kernel.org, AJvYcCVkRpv+c12JyQo5VZVLSvaDcULoMsUEiTeSSolriRr7XyR8yJyca0Ocm2vq2q3r9GKxJaHx7wMoJ41F@vger.kernel.org, AJvYcCWIVRf2IzNZWfXnwK1A1xfSqG2NnvgWMMqwS08fddqtBPr0FaZksDF6cwBX0llua696+6DLDPDM1WaJzA==@vger.kernel.org, AJvYcCXt6NbTiZqez+eBkHIZZe1XvAxcUtX+FaRsqkCyPNzbqBNsSXMlk5ScY6ME05QRUARQTC/EKtWW110KjJsb@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz9mOD4rR+EhyJVj3qAb1T/5wdDxONttAlIThvjj9c6TE6FIiq
	qptTav3PBmbtqXHgaIAufuEQLLCv3t5idyXcgA6jXDD0g/JnGhNXDdHg
X-Gm-Gg: ASbGncu25R2dYwyjNJqU1xICYLxLoOhyWJJ3QKDYi74EvRAt5RIhExMqfmcljPkBCLF
	hGDfBPHANEgPUu3Dh6SkSiFePfShoDOX8fQmKVmI7jCTKjLeeWkpZnHotnwGc+c0etzPleCs2tZ
	mzpVmZQ2VVG20YiUmw6RzQbHdf4tLenzhKLyh6eFKC0fgxWrNlXHkbWO1HTx8u+lJKc4cMjpEnc
	fpqv7yvtTPpaNrB6mHjrpBbSY6mFp6O5N6ywHG1EKN8WYNaelZMznQ0xE5TOknQBbAfBGeO+vqm
	QmlNMS6YtQARD/g/AKJP/EgYcz1svizhw/6P5xB5E27EA9xvq0Xh4PtumDXYQ+I=
X-Google-Smtp-Source: AGHT+IEBVqZ9rQVrL0FrzRM5+UWzt+PVHFTZTDFNOqdAa5LGMpWRWM3WpjAFFERJyrlSJbtmmEq7mQ==
X-Received: by 2002:a05:6a00:1955:b0:748:e772:f952 with SMTP id d2e1a72fcca58-74af6f6dc19mr401174b3a.17.1750965265388;
        Thu, 26 Jun 2025 12:14:25 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:9c8f:acd3:efcb:bc3d])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b34c4446092sm2262908a12.39.2025.06.26.12.14.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 12:14:25 -0700 (PDT)
Date: Thu, 26 Jun 2025 12:14:22 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Hans de Goede <hansg@kernel.org>
Cc: Mario Limonciello <superm1@kernel.org>, 
	Mika Westerberg <westeri@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	"open list:GPIO ACPI SUPPORT" <linux-gpio@vger.kernel.org>, "open list:GPIO ACPI SUPPORT" <linux-acpi@vger.kernel.org>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:INPUT (KEYBOARD, MOUSE, JOYSTICK, TOUCHSCREEN)..." <linux-input@vger.kernel.org>, Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH v3 4/4] Input: Don't send fake button presses to wake
 system
Message-ID: <vkau25ybcx3bcoa2jmxlukumunzii5h6em43anh6mmzk2kyiv7@kyych4kxc4zo>
References: <20250625215813.3477840-1-superm1@kernel.org>
 <20250625215813.3477840-5-superm1@kernel.org>
 <710f7c04-0099-4611-b2ea-4dd4219ad5e2@kernel.org>
 <23f30094-68cc-47fe-86e0-5289cb41e940@kernel.org>
 <rn2kp5tog2agvswva2ipqq2ytiqdcgccnocudsg6ckwfh4roei@provk2g6dita>
 <363c2b92-4bfc-4537-9fca-025eef09526f@kernel.org>
 <nxticocp26r5mmpkttritw76h5igw7bdpus6zaf5krkso2h5xy@wna6m2quekfi>
 <cbbf0caf-82ce-4427-9844-b11e0f5cacdb@kernel.org>
 <obpakvzyludc4jskqzyxf65dhqds7ie3jkbfsqdve32ouuaili@xvogkmwvbmbf>
 <284ea5c0-dca5-4e9e-a3e7-705eca794010@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <284ea5c0-dca5-4e9e-a3e7-705eca794010@kernel.org>

On Thu, Jun 26, 2025 at 08:57:30PM +0200, Hans de Goede wrote:
> Hi,
> 
> On 26-Jun-25 20:48, Dmitry Torokhov wrote:
> > On Thu, Jun 26, 2025 at 01:20:54PM -0500, Mario Limonciello wrote:
> >> On 6/26/2025 1:07 PM, Dmitry Torokhov wrote:
> >>> On Thu, Jun 26, 2025 at 12:53:02PM -0500, Mario Limonciello wrote:
> >>>>
> >>>>
> >>>> On 6/26/25 12:44 PM, Dmitry Torokhov wrote:
> >>>>> Hi Mario,
> >>>>>
> >>>>> On Thu, Jun 26, 2025 at 06:33:08AM -0500, Mario Limonciello wrote:
> >>>>>>
> >>>>>>
> >>>>>> On 6/26/25 3:35 AM, Hans de Goede wrote:
> >>>>>>> Hi Mario,
> >>>>>>>
> >>>>>>> On 25-Jun-25 23:58, Mario Limonciello wrote:
> >>>>>>>> From: Mario Limonciello <mario.limonciello@amd.com>
> >>>>>>>>
> >>>>>>>> Sending an input event to wake a system does wake it, but userspace picks
> >>>>>>>> up the keypress and processes it.  This isn't the intended behavior as it
> >>>>>>>> causes a suspended system to wake up and then potentially turn off if
> >>>>>>>> userspace is configured to turn off on power button presses.
> >>>>>>>>
> >>>>>>>> Instead send a PM wakeup event for the PM core to handle waking the system.
> >>>>>>>>
> >>>>>>>> Cc: Hans de Goede <hansg@kernel.org>
> >>>>>>>> Fixes: 0f107573da417 ("Input: gpio_keys - handle the missing key press event in resume phase")
> >>>>>>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> >>>>>>>> ---
> >>>>>>>>     drivers/input/keyboard/gpio_keys.c | 7 +------
> >>>>>>>>     1 file changed, 1 insertion(+), 6 deletions(-)
> >>>>>>>>
> >>>>>>>> diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
> >>>>>>>> index 773aa5294d269..4c6876b099c43 100644
> >>>>>>>> --- a/drivers/input/keyboard/gpio_keys.c
> >>>>>>>> +++ b/drivers/input/keyboard/gpio_keys.c
> >>>>>>>> @@ -420,12 +420,7 @@ static irqreturn_t gpio_keys_gpio_isr(int irq, void *dev_id)
> >>>>>>>>     		pm_stay_awake(bdata->input->dev.parent);
> >>>>>>>>     		if (bdata->suspended  &&
> >>>>>>>>     		    (button->type == 0 || button->type == EV_KEY)) {
> >>>>>>>> -			/*
> >>>>>>>> -			 * Simulate wakeup key press in case the key has
> >>>>>>>> -			 * already released by the time we got interrupt
> >>>>>>>> -			 * handler to run.
> >>>>>>>> -			 */
> >>>>>>>> -			input_report_key(bdata->input, button->code, 1);
> >>>>>>>> +			pm_wakeup_event(bdata->input->dev.parent, 0);
> >>>>>
> >>>>> There is already pm_stay_awake() above.
> >>>>
> >>>> But that doesn't help with the fact that userspace gets KEY_POWER from this
> >>>> and reacts to it.
> >>>>
> >>>>>
> >>>>>>>>     		}
> >>>>>>>>     	}
> >>>>>>>
> >>>>>>> Hmm, we have the same problem on many Bay Trail / Cherry Trail
> >>>>>>> windows 8 / win10 tablets, so  this has been discussed before and e.g.
> >>>>>>> Android userspace actually needs the button-press (evdev) event to not
> >>>>>>> immediately go back to sleep, so a similar patch has been nacked in
> >>>>>>> the past.
> >>>>>>>
> >>>>>>> At least for GNOME this has been fixed in userspace by ignoring
> >>>>>>> power-button events the first few seconds after a resume from suspend.
> >>>>>>>
> >>>>>>
> >>>>>> The default behavior for logind is:
> >>>>>>
> >>>>>> HandlePowerKey=poweroff
> >>>>>>
> >>>>>> Can you share more about what version of GNOME has a workaround?
> >>>>>> This was actually GNOME (on Ubuntu 24.04) that I found this issue.
> >>>>>>
> >>>>>> Nonetheless if this is dependent on an Android userspace problem could we
> >>>>>> perhaps conditionalize it on CONFIG_ANDROID_BINDER_DEVICES?
> >>>>>
> >>>>> No it is not only Android, other userspace may want to distinguish
> >>>>> between normal and "dark" resume based on keyboard or other user
> >>>>> activity.
> >>>>>
> >>>>> Thanks.
> >>>>>
> >>>> In this specific case does the key passed up to satisfy this userspace
> >>>> requirement and keep it awake need to specifically be a fabricated
> >>>> KEY_POWER?
> >>>>
> >>>> Or could we find a key that doesn't require some userspace to ignore
> >>>> KEY_POWER?
> >>>>
> >>>> Maybe something like KEY_RESERVED, KEY_FN, or KEY_POWER2?
> >>>
> >>> The code makes no distinction between KEY_POWER and KEY_A or KEY_B, etc.
> >>> It simply passes event to userspace for processing.
> >>
> >> Right.  I don't expect a problem with most keys, but my proposal is to
> >> special case KEY_POWER while suspended.  If a key press event must be sent
> >> to keep Android and other userspace happy I suggest sending something
> >> different just for that situation.
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
> >>
> >> Like this:
> >>
> >> diff --git a/drivers/input/keyboard/gpio_keys.c
> >> b/drivers/input/keyboard/gpio_keys.c
> >> index 773aa5294d269..66e788d381956 100644
> >> --- a/drivers/input/keyboard/gpio_keys.c
> >> +++ b/drivers/input/keyboard/gpio_keys.c
> >> @@ -425,7 +425,10 @@ static irqreturn_t gpio_keys_gpio_isr(int irq, void
> >> *dev_id)
> >>                          * already released by the time we got interrupt
> >>                          * handler to run.
> >>                          */
> >> -                       input_report_key(bdata->input, button->code, 1);
> >> +                       if (button->code == KEY_POWER)
> >> +                               input_report_key(bdata->input, KEY_WAKEUP,
> >> 1);
> > 
> > Just FYI: Here your KEY_WAKEUP is stuck forever.
> > 
> >> +                       else
> >> +                               input_report_key(bdata->input, button->code,
> >> 1);
> >>                 }
> >>         }
> >>
> >>
> >>
> >>>
> >>> You need to fix your userspace. Even with your tweak it is possible for
> >>> userspace to get a normal key event "too early" and turn off the screen
> >>> again, so you still need to handle this situation.
> >>>
> >>> Thanks.
> >>>
> >>
> >> I want to note this driver works quite differently than how ACPI power
> >> button does.
> >>
> >> You can see in acpi_button_notify() that the "keypress" is only forwarded
> >> when not suspended [1].  Otherwise it's just wakeup event (which is what my
> >> patch was modeling).
> >>
> >> https://github.com/torvalds/linux/blob/v6.16-rc3/drivers/acpi/button.c#L461
> >> [1]
> > 
> > If you check acpi_button_resume() you will see that the events are sent
> > from there. Except that for some reason they chose to use KEY_WAKEUP and
> > not KEY_POWER, oh well. Unlike acpi button driver gpio_keys is used on
> > multiple other platforms.
> 
> Interesting, but the ACPI button code presumably only does this on resume
> for a normal press while the system is awake it does use KEY_POWER, right ?

Yes. It is unclear to me why they chose to mangle the event on wakeup,
it does not seem to be captured in the email discussions or in the patch
description.

Thanks.

-- 
Dmitry

