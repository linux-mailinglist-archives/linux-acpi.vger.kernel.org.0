Return-Path: <linux-acpi+bounces-14729-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8253AEA5BB
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Jun 2025 20:49:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1209C3B6FA4
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Jun 2025 18:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A7502EE988;
	Thu, 26 Jun 2025 18:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nlf5WGJK"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15BC2EE60A;
	Thu, 26 Jun 2025 18:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750963731; cv=none; b=t0Am8GR4rtBmh54a0Ec7+0Yz6osAta/MXHHHfUTRNhuqh9fuBmS5brlKB5/xT+0Wl7Pl+m+0rMLXhPSpnjWKvyCMO0ioNftSXgGLihxS6vgFpbYKrYC6jqrwcn5sbSgRSQygYhRZy0W+kMGf1vyNvBGxYByt3FRmRptYqW5oevs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750963731; c=relaxed/simple;
	bh=8JnaB0rfLbBXBkMhNJJQ5vAg0PVGnPbCYHgb3DK5wXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YdqEl3glQI3ZOLBBArrlJDLvVztoxSRCjZkjPDumj3myTFk9TPB9+bCkWGgud6Attk72VNsNzRK+FJX12JJ3xSzBVquxW1f1LZElngeblPmetv5gfbwdiWSLsajX9aHM982HKd7L+yKSgYGVxaKzvAL4udsbXagUVTlRb9yrSnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nlf5WGJK; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-235ef62066eso17866245ad.3;
        Thu, 26 Jun 2025 11:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750963729; x=1751568529; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jeqaBHn7aHDNdEDuhpEe0nw9AeD4qrwgeY8YNWwNdQM=;
        b=nlf5WGJKvVW/Q6087rL47vg1hrqC4xCgwc6Nr5tksV598rgCGx7Ztls3V3A4Zq/D0K
         wYGRTxMh1hK86iYSNsI9OMYH8ChRzmSX2iidbP8bU/jr6K+U0LVzaystUr9AqEB65XpU
         dqHnnO70T0P7bmuzxNW4vTXfXap5inOoqP/78vfnBtptlkLwF/TrJ7RyJADzeNFNSgJk
         SPLU8oQ2aNNhg9IwLv4mW2aqNqVJBLEuwTV4lqPxU0VofEZVG8sQww0U8XdQilCO0t5X
         YO8JfbLvyAtnXCuKOwCu7/ES2cAFfbZb6G31EM7EheXnpVPaWDqPejbAb15mguzTRvAw
         3e3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750963729; x=1751568529;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jeqaBHn7aHDNdEDuhpEe0nw9AeD4qrwgeY8YNWwNdQM=;
        b=YxyFP+PafjCrZ4OHwvx81Z4mGpq8JVLuxq8c44R1oZ1UeQibpy2tMmrCRMdO/IWC8F
         OhBeg6wNyhrtxy8gPDMnMKtghKjH5urAtX3Vea9Hc28XOogmcnTCxX8XhMvozkeN+CS1
         iFuh+2iqZX9pRFyYumECLNuiLLYXoAZ4DUpO18XTOxDX5Oxzu/YS8C2cfTDMPq6sm4Rx
         E7Q5SmjVHzSxtBE/snVgtlQoDFZtFw1shIskzznCKAlZ1dFoSOtrqlGw2Ps3CWFaqDuK
         7jDZ5DVrDuMJkZ2ZBR9YQNQTi0gu9yS8Zf378zwTlhq7NgHl42OxZCaKRoURPcKzAYuJ
         GuKA==
X-Forwarded-Encrypted: i=1; AJvYcCVlAldvEUKAGnOfTTPdaQFc9e+WySCz6ln00Y0aYuRaPzDyQpHPhKAnbICMgM4KyLmXPNp+M2YtaXm7@vger.kernel.org, AJvYcCW4QFSErfh36fVhAB85kMcHyLpBEy8JjimdzoFbCMAh6iXx/HZLcww5MD2KAqL+rL1dkaC7LNyr2UUTdw==@vger.kernel.org, AJvYcCWsZSVD9d+7fPKRMuqs5ofJpQoOkflg/TLXjxC0xh6JglmW+pqnsyBXivAOB3ZoyK3PwNJyxF9C6/twTRo=@vger.kernel.org, AJvYcCXeOATJHaMJs4x9rydUXV3qMdYEXaAZ7TUdu0St2dCoWj39G9oX9zA36/3ptenrV3FrzXSQEQlOxWH5rQEb@vger.kernel.org
X-Gm-Message-State: AOJu0YxHCIv2PpzMVb8HRz86sj3dsAEdCNAsuuSN9rWbw8GyIPTiSElI
	ECla05fCLE6djTEnkWzmqOjjkhCkc2VhS30o3aalJwFU6ABKX8NV6CHU
X-Gm-Gg: ASbGnct0M+VJXqhIC7MNydBkP7HeKlzFE4A1SgiWFvqDTOWBbKKmbCFwPeqcGklP+dS
	g0JXifKpUBoFI/6uEXrE1JrOL8+/lPGX6/JZ0mID8aViDtd3kZmRxp9PK1OojG1FgdUFlzhL0wH
	ggLs6jdZdttoVclxkS/CXSFuYHHNC+vgkxUnkAlIWVypNKs6J8xWJLKVEbyCsPhRfSe+7T7ozJQ
	yFuiyg6f6/Zlwc6e/p5X8cuuJ4F/nNfXbh8TB3LVDMZPYyWaAZa1W0PnYP46/pg+uQNdVaJzTmb
	UxxjIrmUzqKtpeohfuf9Mqr0qZPig5lsgoKCAxIYFjJCoK5Q7Q8LAJs09NpwkTE=
X-Google-Smtp-Source: AGHT+IH19pgfYZHrnfg5h1FUlWuYD+Rh58wv4yiuNmbvc9Kyq7TEpgHKBn33CfxyyQiHy88nU/Hm+w==
X-Received: by 2002:a17:903:17c7:b0:235:c9ef:c9e1 with SMTP id d9443c01a7336-23ac3bffdb2mr6579285ad.5.1750963728715;
        Thu, 26 Jun 2025 11:48:48 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:9c8f:acd3:efcb:bc3d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23abe3daf4csm3944385ad.112.2025.06.26.11.48.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 11:48:48 -0700 (PDT)
Date: Thu, 26 Jun 2025 11:48:45 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Mario Limonciello <superm1@kernel.org>
Cc: Hans de Goede <hansg@kernel.org>, Mika Westerberg <westeri@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Linus Walleij <linus.walleij@linaro.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, "open list:GPIO ACPI SUPPORT" <linux-gpio@vger.kernel.org>, 
	"open list:GPIO ACPI SUPPORT" <linux-acpi@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:INPUT (KEYBOARD, MOUSE, JOYSTICK, TOUCHSCREEN)..." <linux-input@vger.kernel.org>, Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH v3 4/4] Input: Don't send fake button presses to wake
 system
Message-ID: <obpakvzyludc4jskqzyxf65dhqds7ie3jkbfsqdve32ouuaili@xvogkmwvbmbf>
References: <20250625215813.3477840-1-superm1@kernel.org>
 <20250625215813.3477840-5-superm1@kernel.org>
 <710f7c04-0099-4611-b2ea-4dd4219ad5e2@kernel.org>
 <23f30094-68cc-47fe-86e0-5289cb41e940@kernel.org>
 <rn2kp5tog2agvswva2ipqq2ytiqdcgccnocudsg6ckwfh4roei@provk2g6dita>
 <363c2b92-4bfc-4537-9fca-025eef09526f@kernel.org>
 <nxticocp26r5mmpkttritw76h5igw7bdpus6zaf5krkso2h5xy@wna6m2quekfi>
 <cbbf0caf-82ce-4427-9844-b11e0f5cacdb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cbbf0caf-82ce-4427-9844-b11e0f5cacdb@kernel.org>

On Thu, Jun 26, 2025 at 01:20:54PM -0500, Mario Limonciello wrote:
> On 6/26/2025 1:07 PM, Dmitry Torokhov wrote:
> > On Thu, Jun 26, 2025 at 12:53:02PM -0500, Mario Limonciello wrote:
> > > 
> > > 
> > > On 6/26/25 12:44 PM, Dmitry Torokhov wrote:
> > > > Hi Mario,
> > > > 
> > > > On Thu, Jun 26, 2025 at 06:33:08AM -0500, Mario Limonciello wrote:
> > > > > 
> > > > > 
> > > > > On 6/26/25 3:35 AM, Hans de Goede wrote:
> > > > > > Hi Mario,
> > > > > > 
> > > > > > On 25-Jun-25 23:58, Mario Limonciello wrote:
> > > > > > > From: Mario Limonciello <mario.limonciello@amd.com>
> > > > > > > 
> > > > > > > Sending an input event to wake a system does wake it, but userspace picks
> > > > > > > up the keypress and processes it.  This isn't the intended behavior as it
> > > > > > > causes a suspended system to wake up and then potentially turn off if
> > > > > > > userspace is configured to turn off on power button presses.
> > > > > > > 
> > > > > > > Instead send a PM wakeup event for the PM core to handle waking the system.
> > > > > > > 
> > > > > > > Cc: Hans de Goede <hansg@kernel.org>
> > > > > > > Fixes: 0f107573da417 ("Input: gpio_keys - handle the missing key press event in resume phase")
> > > > > > > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> > > > > > > ---
> > > > > > >     drivers/input/keyboard/gpio_keys.c | 7 +------
> > > > > > >     1 file changed, 1 insertion(+), 6 deletions(-)
> > > > > > > 
> > > > > > > diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
> > > > > > > index 773aa5294d269..4c6876b099c43 100644
> > > > > > > --- a/drivers/input/keyboard/gpio_keys.c
> > > > > > > +++ b/drivers/input/keyboard/gpio_keys.c
> > > > > > > @@ -420,12 +420,7 @@ static irqreturn_t gpio_keys_gpio_isr(int irq, void *dev_id)
> > > > > > >     		pm_stay_awake(bdata->input->dev.parent);
> > > > > > >     		if (bdata->suspended  &&
> > > > > > >     		    (button->type == 0 || button->type == EV_KEY)) {
> > > > > > > -			/*
> > > > > > > -			 * Simulate wakeup key press in case the key has
> > > > > > > -			 * already released by the time we got interrupt
> > > > > > > -			 * handler to run.
> > > > > > > -			 */
> > > > > > > -			input_report_key(bdata->input, button->code, 1);
> > > > > > > +			pm_wakeup_event(bdata->input->dev.parent, 0);
> > > > 
> > > > There is already pm_stay_awake() above.
> > > 
> > > But that doesn't help with the fact that userspace gets KEY_POWER from this
> > > and reacts to it.
> > > 
> > > > 
> > > > > > >     		}
> > > > > > >     	}
> > > > > > 
> > > > > > Hmm, we have the same problem on many Bay Trail / Cherry Trail
> > > > > > windows 8 / win10 tablets, so  this has been discussed before and e.g.
> > > > > > Android userspace actually needs the button-press (evdev) event to not
> > > > > > immediately go back to sleep, so a similar patch has been nacked in
> > > > > > the past.
> > > > > > 
> > > > > > At least for GNOME this has been fixed in userspace by ignoring
> > > > > > power-button events the first few seconds after a resume from suspend.
> > > > > > 
> > > > > 
> > > > > The default behavior for logind is:
> > > > > 
> > > > > HandlePowerKey=poweroff
> > > > > 
> > > > > Can you share more about what version of GNOME has a workaround?
> > > > > This was actually GNOME (on Ubuntu 24.04) that I found this issue.
> > > > > 
> > > > > Nonetheless if this is dependent on an Android userspace problem could we
> > > > > perhaps conditionalize it on CONFIG_ANDROID_BINDER_DEVICES?
> > > > 
> > > > No it is not only Android, other userspace may want to distinguish
> > > > between normal and "dark" resume based on keyboard or other user
> > > > activity.
> > > > 
> > > > Thanks.
> > > > 
> > > In this specific case does the key passed up to satisfy this userspace
> > > requirement and keep it awake need to specifically be a fabricated
> > > KEY_POWER?
> > > 
> > > Or could we find a key that doesn't require some userspace to ignore
> > > KEY_POWER?
> > > 
> > > Maybe something like KEY_RESERVED, KEY_FN, or KEY_POWER2?
> > 
> > The code makes no distinction between KEY_POWER and KEY_A or KEY_B, etc.
> > It simply passes event to userspace for processing.
> 
> Right.  I don't expect a problem with most keys, but my proposal is to
> special case KEY_POWER while suspended.  If a key press event must be sent
> to keep Android and other userspace happy I suggest sending something
> different just for that situation.

I do not know if userspace specifically looks for KEY_POWER or if it
looks for user input in general, and I'd rather be on safe side and not
mangle user input.

As Hans mentioned, at least some userspace already prepared to deal with
this issue. And again, this only works if by the time ISR/debounce
runs the key is already released. What if it is still pressed? You still
going to observe KEY_POWER and need to suppress turning off the screen.

> 
> Like this:
> 
> diff --git a/drivers/input/keyboard/gpio_keys.c
> b/drivers/input/keyboard/gpio_keys.c
> index 773aa5294d269..66e788d381956 100644
> --- a/drivers/input/keyboard/gpio_keys.c
> +++ b/drivers/input/keyboard/gpio_keys.c
> @@ -425,7 +425,10 @@ static irqreturn_t gpio_keys_gpio_isr(int irq, void
> *dev_id)
>                          * already released by the time we got interrupt
>                          * handler to run.
>                          */
> -                       input_report_key(bdata->input, button->code, 1);
> +                       if (button->code == KEY_POWER)
> +                               input_report_key(bdata->input, KEY_WAKEUP,
> 1);

Just FYI: Here your KEY_WAKEUP is stuck forever.

> +                       else
> +                               input_report_key(bdata->input, button->code,
> 1);
>                 }
>         }
> 
> 
> 
> > 
> > You need to fix your userspace. Even with your tweak it is possible for
> > userspace to get a normal key event "too early" and turn off the screen
> > again, so you still need to handle this situation.
> > 
> > Thanks.
> > 
> 
> I want to note this driver works quite differently than how ACPI power
> button does.
> 
> You can see in acpi_button_notify() that the "keypress" is only forwarded
> when not suspended [1].  Otherwise it's just wakeup event (which is what my
> patch was modeling).
> 
> https://github.com/torvalds/linux/blob/v6.16-rc3/drivers/acpi/button.c#L461
> [1]

If you check acpi_button_resume() you will see that the events are sent
from there. Except that for some reason they chose to use KEY_WAKEUP and
not KEY_POWER, oh well. Unlike acpi button driver gpio_keys is used on
multiple other platforms.

Thanks.

-- 
Dmitry

