Return-Path: <linux-acpi+bounces-14706-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1FCDAEA4AD
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Jun 2025 19:44:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D8C918853DE
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Jun 2025 17:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 740AE2EAD1A;
	Thu, 26 Jun 2025 17:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NPoTIyio"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0329A202C50;
	Thu, 26 Jun 2025 17:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750959862; cv=none; b=LU7PzPVMELlfabuxNc0LjrpwQohZfnorGGtZ0dV9IYOU5BiPguFLsJDaHbmG8VFuDETuhFpg0BAuQBANh0ncCMF15apam6BcEB+OlVo4+KRVqcLHz8ndn7vg99xD5dMRlDM1mwg9Kwl9F37BvRb/bZ1vbAUgF95/MU/kycEegwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750959862; c=relaxed/simple;
	bh=ebZvQEOJOdrHVeM5gSV7fQQB052guVx3TdrknM+JY+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vBoA8vK/kHZytuo1XOcPrrajZpNl6sR4VcQ2jdnpLn33J+b24uO9G7OKRrNAZwfVEdh2ywnwHG1Z1LXdLU6yuyZLEC6COl6tLwjLFUg5mds6dRgW6BYhg5N1bJiaHjzCMuIRR3lQb30oK0FD/PdjBBIEx0X4DhQ88L06AiuTHFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NPoTIyio; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2350fc2591dso13488005ad.1;
        Thu, 26 Jun 2025 10:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750959860; x=1751564660; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XOqApDlDtKek45u/dybzXv0bCsKoiI2y3znxRwW87ck=;
        b=NPoTIyiou6NRJ4Hfy5BF8zGazNLl8drR0TSC7XoQgOl0JXVXfBkSjX+b4eCUrLl6sl
         sFsGsu48bwrQcFWj+k7RWpfRys6eb8yvfVJOTy5yhPl+rCjLFuYN3/vgcVFTkj/41Q8o
         zSUONSY1Z7gQHWhb/Q3VsTxCRj/mF/PQTweFEyA/XxjfV/U5TPRuHzW9XVrv61NSLLh6
         VcvXaaJVMpexrl2zZung/zoLxfm3cZwiawKRkqSpekoAySfGK4yCNQdb6KLz0sA4Hj0U
         Yi0jDlzb19RbH6A4+d0k6u+pC8dtp5BVXLX16pBMWh+myvRnKGpq71UDzIW93HNzIkOS
         XjsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750959860; x=1751564660;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XOqApDlDtKek45u/dybzXv0bCsKoiI2y3znxRwW87ck=;
        b=UPAs9idXlB7BpoVs3fOR0IRecLjdURLhxElSVEYXu3WPjOxw8438tAUUa2LbSoBE6W
         q2CkolYWIE6ZTipxFBZETlkD8kU2xwKbutV585s8WTdRHVwtjjEyvhBiArO9Zq5Kb3Mp
         NtgjaB4yebQIrX2dwwWUK7JnNBo0izSwVn8rstF8h0ZmPnLhCc9o5KBee/ctsBg0k1eh
         01tfYEPtkzEXm8MCAmQx9snlayGY7mzbXdzK10SfH0ylm5JnFN+1TWpPjljFR0z4B3C5
         xUZC28eQUYpyuUS/fi7yJk/JVk5iyaWbFaUMnpnBzjqGSe59Q6TXPhWGBXlmNk+pe6dY
         teJw==
X-Forwarded-Encrypted: i=1; AJvYcCUEvn0JQJCODs+afInVizC0E4s8JxQqWlCTUoXpQTcK8RPpNfyBjFEEG3djmEq3b8sJvVY+NpduOZ+MjHzH@vger.kernel.org, AJvYcCUF2+sjUuN0pQCTqH2mfMkI8t4IwTf7iWSQmO+CbIyjhqz4h193UBIZqEOWw9stBUbuUh0FfkECfSa5@vger.kernel.org, AJvYcCVAOg7HiApxodEKJ7auOA4tJFZvXl6qUS9QOzFDizyx0emQujtCzsQ4H4eCFXq0aWVOInq2qtFTABNgdA==@vger.kernel.org, AJvYcCWjd4fRJanqIXM35chXubrPkapCAaAyQiNhTnSYyFfL19Z1zxIvvcU2zSHY44wRmZFl9KGb+qxyDz/Y3mk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPH99cBq3vQjtqFftgb08IDzJmZ1WR4745PeLebNWtC+km7U1B
	KfUQ/aCanGU4LFStwZTohUOjSk2mhoHeWQSyJZq/XSMm+RYWXrj2r+Fe+i4+qQ==
X-Gm-Gg: ASbGnctxLls2UF57DBHwGL3azOfDtwjM6GJ7B5KsKlQ9/AexIk4nvd5ZHiHu/boMUjg
	dDa+WQ0n0tb4yok3+E+ZXpKuITN+XEh2gNqjLqkTpLYgdkIcP2zrnD6lRZxyX70QWCrfeY8EqWY
	/e9hj76PgdoUQO97tdOwe3y3JmUbkFvkSWaEzZo4J/hbpC21wUxKu9Ah16rq48oEZ2XzBy0OHvU
	cTV9jiWlCl/AE78JrhmBHfz6vhFFL3FN8iP+xeYomD7GWMWFSlLJfhbVAlnpRjPsX/BQs2jkDCc
	aplI7AQCTkpjxVXpHhHM9nt4eLlU39PZhPMHybX5bjLJzliZ/F1ekcBMLVRhxh0payz5DMsVVQ=
	=
X-Google-Smtp-Source: AGHT+IERpA/42F7+ID3nTxnW60mmdpQabBUjkL6LiXoHhp6te1jwac5vSBt8lZPIf3XYVILMRgCeJw==
X-Received: by 2002:a17:903:584:b0:234:325:500b with SMTP id d9443c01a7336-2390a51a598mr46561055ad.22.1750959860234;
        Thu, 26 Jun 2025 10:44:20 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:9c8f:acd3:efcb:bc3d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23abe3f4551sm3139535ad.144.2025.06.26.10.44.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 10:44:19 -0700 (PDT)
Date: Thu, 26 Jun 2025 10:44:16 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Mario Limonciello <superm1@kernel.org>
Cc: Hans de Goede <hansg@kernel.org>, Mika Westerberg <westeri@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Linus Walleij <linus.walleij@linaro.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, "open list:GPIO ACPI SUPPORT" <linux-gpio@vger.kernel.org>, 
	"open list:GPIO ACPI SUPPORT" <linux-acpi@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:INPUT (KEYBOARD, MOUSE, JOYSTICK, TOUCHSCREEN)..." <linux-input@vger.kernel.org>, Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH v3 4/4] Input: Don't send fake button presses to wake
 system
Message-ID: <rn2kp5tog2agvswva2ipqq2ytiqdcgccnocudsg6ckwfh4roei@provk2g6dita>
References: <20250625215813.3477840-1-superm1@kernel.org>
 <20250625215813.3477840-5-superm1@kernel.org>
 <710f7c04-0099-4611-b2ea-4dd4219ad5e2@kernel.org>
 <23f30094-68cc-47fe-86e0-5289cb41e940@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23f30094-68cc-47fe-86e0-5289cb41e940@kernel.org>

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

There is already pm_stay_awake() above.

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
> 
> Can you share more about what version of GNOME has a workaround?
> This was actually GNOME (on Ubuntu 24.04) that I found this issue.
> 
> Nonetheless if this is dependent on an Android userspace problem could we
> perhaps conditionalize it on CONFIG_ANDROID_BINDER_DEVICES?

No it is not only Android, other userspace may want to distinguish
between normal and "dark" resume based on keyboard or other user
activity.

Thanks.

-- 
Dmitry

