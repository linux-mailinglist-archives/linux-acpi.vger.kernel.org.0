Return-Path: <linux-acpi+bounces-14724-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B4064AEA580
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Jun 2025 20:37:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 848FD7A2541
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Jun 2025 18:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 205622DAFB8;
	Thu, 26 Jun 2025 18:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V8X/1Kqz"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52C520D4F2;
	Thu, 26 Jun 2025 18:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750963048; cv=none; b=H1PSHIKG45UHfEGmXExNE7ice00FQAmcYtVspQStK1NE8V09sc/OOKWmlrQiYB1Q+mBhM/hN/PmQaLlEPzxx9N5DzwRxm3ip9y7fSe0mTKCgWiB4vhSaH222aRshqQuvaOZVwvs+wZRxvArCeRCT9zFs3I9daHovSX1pHqgljQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750963048; c=relaxed/simple;
	bh=9PoCOhvIaxvujPwX+nQ0TjvLMD8o8zko0GXYn1ABNU0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=DAGcuSHQzxP+yYTaANuNBZ5AChM7HAIziMY215q4KN+7/zspdPuiUW5mTzEdZ4wPLzIXbKRWc0wz6llkogtwbNU6L6etv1gE22Wl8dD4lAPZuDyAvmdGYgMr5KD5ai8CYUQJZc16Wt35LOtLcTu1CRk4QpuGQT9INeWEdXvgKWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V8X/1Kqz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE33FC4CEEB;
	Thu, 26 Jun 2025 18:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750963047;
	bh=9PoCOhvIaxvujPwX+nQ0TjvLMD8o8zko0GXYn1ABNU0=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=V8X/1Kqz45tGCt1FSAbnn4+kUQywAXX71sE92LX34LvXRmi6rhPIjMYsLkccVdOs3
	 mkw0d7CxXNMPaoqTVxjb8Pr2fX9/Zs8V0rnT+EhbpKe+tp+UXXeKBqYQiQfnCxEI9n
	 jz3UgClJtwY22DeCVoiZCp+HON9vbLN8il2jc+2sclckxTHV8W8wFuapP21+liGp2E
	 6s0+If/SZx/rGPEgF+0aTq6VLJus+IUEm4jjZU252Z0XnRjT4x2H3Czs5wWsMNS8Qx
	 ADow49j6ndjkaAeLTozxdPtS8i9gLesQK1TGvRHgUMX/l5lpe73pDyGvMZmYIycbCj
	 5cShCzTqARknQ==
Message-ID: <67224531-ad15-4fb6-b230-03c2d64206ad@kernel.org>
Date: Thu, 26 Jun 2025 20:37:22 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Hans de Goede <hansg@kernel.org>
Subject: Re: [PATCH v3 4/4] Input: Don't send fake button presses to wake
 system
To: Mario Limonciello <superm1@kernel.org>
Cc: Mika Westerberg <westeri@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski
 <brgl@bgdev.pl>, "open list:GPIO ACPI SUPPORT" <linux-gpio@vger.kernel.org>,
 "open list:GPIO ACPI SUPPORT" <linux-acpi@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:INPUT (KEYBOARD, MOUSE, JOYSTICK, TOUCHSCREEN)..."
 <linux-input@vger.kernel.org>, Mario Limonciello
 <mario.limonciello@amd.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
References: <20250625215813.3477840-1-superm1@kernel.org>
 <20250625215813.3477840-5-superm1@kernel.org>
 <710f7c04-0099-4611-b2ea-4dd4219ad5e2@kernel.org>
 <23f30094-68cc-47fe-86e0-5289cb41e940@kernel.org>
Content-Language: en-US, nl
In-Reply-To: <23f30094-68cc-47fe-86e0-5289cb41e940@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Mario,

On Thu, Jun 26, 2025 at 06:33:08AM -0500, Mario Limonciello wrote:
> 
> 
> On 6/26/25 3:35 AM, Hans de Goede wrote:
> > Hi Mario,
> > 
> > On 25-Jun-25 23:58, Mario Limonciello wrote:
> > > From: Mario Limonciello <mario.limonciello@amd.com>
> > > 
> > > Sending an input event to wake a system does wake it, but userspace picks
> > > up the keypress and processes it.  This isn't the intended behavior as it
> > > causes a suspended system to wake up and then potentially turn off if
> > > userspace is configured to turn off on power button presses.
> > > 
> > > Instead send a PM wakeup event for the PM core to handle waking the system.
> > > 
> > > Cc: Hans de Goede <hansg@kernel.org>
> > > Fixes: 0f107573da417 ("Input: gpio_keys - handle the missing key press event in resume phase")
> > > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> > > ---
> > >   drivers/input/keyboard/gpio_keys.c | 7 +------
> > >   1 file changed, 1 insertion(+), 6 deletions(-)
> > > 
> > > diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
> > > index 773aa5294d269..4c6876b099c43 100644
> > > --- a/drivers/input/keyboard/gpio_keys.c
> > > +++ b/drivers/input/keyboard/gpio_keys.c
> > > @@ -420,12 +420,7 @@ static irqreturn_t gpio_keys_gpio_isr(int irq, void *dev_id)
> > >   		pm_stay_awake(bdata->input->dev.parent);
> > >   		if (bdata->suspended  &&
> > >   		    (button->type == 0 || button->type == EV_KEY)) {
> > > -			/*
> > > -			 * Simulate wakeup key press in case the key has
> > > -			 * already released by the time we got interrupt
> > > -			 * handler to run.
> > > -			 */
> > > -			input_report_key(bdata->input, button->code, 1);
> > > +			pm_wakeup_event(bdata->input->dev.parent, 0);
> > >   		}
> > >   	}
> > 
> > Hmm, we have the same problem on many Bay Trail / Cherry Trail
> > windows 8 / win10 tablets, so  this has been discussed before and e.g.
> > Android userspace actually needs the button-press (evdev) event to not
> > immediately go back to sleep, so a similar patch has been nacked in
> > the past.
> > 
> > At least for GNOME this has been fixed in userspace by ignoring
> > power-button events the first few seconds after a resume from suspend.
> > 
> 
> The default behavior for logind is:
> 
> HandlePowerKey=poweroff

Right note poweroff not suspend, GNOME inhibits logind's power-button
handling and substitutes its own handling which is done by gsd-media-keys.

> Can you share more about what version of GNOME has a workaround?
> This was actually GNOME (on Ubuntu 24.04) that I found this issue.

See:

https://gitlab.gnome.org/GNOME/gnome-settings-daemon/-/blob/main/plugins/media-keys/gsd-media-keys-manager.c?ref_type=heads#L94

and the code in that file using that define.

Regards,

Hans


