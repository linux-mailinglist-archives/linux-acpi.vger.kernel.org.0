Return-Path: <linux-acpi+bounces-14787-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD2DAAEBF41
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Jun 2025 20:48:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38A4164647A
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Jun 2025 18:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BD871E1E04;
	Fri, 27 Jun 2025 18:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L+ab90v6"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913012F1FE2;
	Fri, 27 Jun 2025 18:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751050081; cv=none; b=VF5zrzl543LeQ65U/oLjNHdQljQezibwpFyPwST9C/iBa58RFdsAtkH5/XvS/qQIkh1LNfwp+oBG9hnA0LLhpQvd8TtxT01yXQQsvZpP1rp75dLUJmXM0IeLO0ATnJm572MbqoVXy6M1TWaSSvUimupFJLoMIi1SofOD3HiZl+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751050081; c=relaxed/simple;
	bh=s9qEDsh86qD4g8AL5xCaIyZTaxrDYkEqACMpPez1vFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E2merqdStgKATEcvyoWZ851vt9FsmjbX1Dt1eAHRQUi/BrZdB2xvhlpS/9Q26X06TFb0HmKcP4psGBCA/Z64kdDrjX2pCz++kMeDNznf6mOFazJNjBCrBlzDszFPK31y7O7o4XhnvX/5odHG6glYizphD1q2bGW8nowbl2vhNlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L+ab90v6; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-749068b9b63so2076766b3a.0;
        Fri, 27 Jun 2025 11:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751050079; x=1751654879; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jv5PtQlZ4FR3ERxm2+Q+8MjORgyggq2ntbMLNgfe2MQ=;
        b=L+ab90v6L8ZkotNGc3ArJZFoECy1FAnpYHoaiYDdogHUbiwEERDNM7Va+MzHt3VJrL
         cgEJ+BcGj07CmXCQxWzrbEFsn+LTlU1vIeedU4NVRq5flejfCyZEXM2sMWGqyycs5MXZ
         XLneHqczXo/FZOEzSqcTBqgl5V/FRhx/qxXT+KSQgIvJLgLr4lSqKJx/anQi1HGEOpV1
         JW9V172OEAmdyyUuyRaWHioZ14ndEVNt/pFvt7oDMJ/3kUpAJE7m38jnoP4Wor7mk0ik
         OW1JxzWqpmyU9jmLU4Ig8+aM3Cus8pyuFOuWHm5s6XttaNyP1Gb/C1wgM1xiF0+k6Ox1
         X/jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751050079; x=1751654879;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jv5PtQlZ4FR3ERxm2+Q+8MjORgyggq2ntbMLNgfe2MQ=;
        b=Cg5+DhqKUKuc9EXBhlGEZd7OYzmlb7uV5Um3+tNNZDN2dUP8wHgRB4u3L5lekd2m5F
         xHhwWPO/X4RmMlUM2cKgP5su/AxPzl6wi9e3QtgMwx4iVBYgrLNMJxqcW3ht44HV+YqD
         J3zAZaKcC6815aN4rG8dBIGdDxexEgNOkdBS5W+NJB3pyASFKg/b15eDXrZ1nRxl5yXg
         +EgYuJKfKbfzSD3TlWyYlkPgzdq2qNt21gNjvM6xcDuA5Aqmlr9B1o5atQlYrei2rH+E
         R/avlkXLsSs9vQMomA6fkeMX+rAQ05jD77HpWm4kz8StqTo0KlQzFcpOK3eJIdkbGaI6
         VbWw==
X-Forwarded-Encrypted: i=1; AJvYcCU9bW+bvreJ/4sZIjN7pkQt2rDfJyoKMruMFxw03c3WrGbMDixY4Z8yyzrD6AkYLmmc7bcfAGpnJ6I5@vger.kernel.org, AJvYcCVvgwE/K+UlXBz7FlH+rmAHt5Zi7pB9e4KvPiCYDMEwxmjeA9RmAGV0qNgJjqXjvraV9yjG4RpQyni91i+1@vger.kernel.org, AJvYcCWUUKFi7C1kIH3a5tHSmmQFTQnYT2PRT3Zz8DmnxkXPQ7Z4fu5IrVARS/VYtQydtJkg6hvhBpLfhjlmQg==@vger.kernel.org, AJvYcCX4TdoMy2l8ojhhH3jDL+j6eFzfQfswZ1cTiVuIu3+fZaRcHsZSTMyilBrhf6yEgBm/+q+4PGygBDrO/WA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1Pip7bHS59SASiYWzfgZYAx+m90X+9l+ZQUn/PsYSIZPI7BmP
	WiVaibwXeMq48gVuZSEfZye/T9urPl7fG6C6GxJTh/kIqWFvWh2GWDYv
X-Gm-Gg: ASbGncstpLi/2LayXPo9Xl39Pf2Q0HiXEw/xCCj/ErlpQWOESLCASqZYIzCAWB2B4iz
	5jzt3ohNPkagU9HNudQGicFJEDPdbAcJQJkI+QHlz+rpL9EuULsCk0bFrVAh9CZOlRfutwsOarP
	1sVQkiMbCWpKm9ner3sRUtiNKuVJHlLDmTxKuQ7TrSot6BHHq38DniLuSCGQswXf150xCpSUC2N
	kv+iWBiasJhlFblpPBCl8ZSZZLOH3Otdj/7rsE1DR996yhIqDmVbUiVGg6SXZwN9UdKX/jgKCOj
	BGvZM7h3QLwNGdkZpMjiMO09q9amSB0+vi/hUfUEqmNmbvbT9J7ZbDB8reQPIQ==
X-Google-Smtp-Source: AGHT+IH4pnB7rSHJF5XYTEnFBTQ8uGERJPj/gz8HjPQxbXT61dfAKimUlUTbvE63MCbMKlz8D4i0sw==
X-Received: by 2002:a17:903:ac5:b0:234:a139:1206 with SMTP id d9443c01a7336-23ac4608d6emr73796895ad.40.1751050078640;
        Fri, 27 Jun 2025 11:47:58 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:d0c7:d92:6a17:eb62])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb2e400fsm21475615ad.34.2025.06.27.11.47.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 11:47:58 -0700 (PDT)
Date: Fri, 27 Jun 2025 11:47:55 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Hans de Goede <hansg@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Mario Limonciello <superm1@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Mika Westerberg <westeri@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, "open list:GPIO ACPI SUPPORT" <linux-gpio@vger.kernel.org>, 
	"open list:GPIO ACPI SUPPORT" <linux-acpi@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:INPUT (KEYBOARD, MOUSE, JOYSTICK, TOUCHSCREEN)..." <linux-input@vger.kernel.org>, Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH v3 4/4] Input: Don't send fake button presses to wake
 system
Message-ID: <bnivc2kt4klb3krkyltafnp3i4ivu5permgm4fgysnmjlukspe@gjvhufpciz3m>
References: <CAJZ5v0j3ZyuEqSKQ+3K8M3BwPCxn5Z6KOwjyjt4cJW6HfxjPDw@mail.gmail.com>
 <hyvpl4gvxc6h2r3itfofjduwb3vpobyo7a7z6g3zapzscqtafh@ixsd4amyljva>
 <de548b27-4c43-4f30-af9d-b060101e6fd8@kernel.org>
 <75fixx6rgwsgsw6e765oxdcivcg2nkzx2fp2qywgx4vi3ihywh@ot7gdecsnttw>
 <1b0d2349-dbf7-47aa-95c9-1974e63d111a@kernel.org>
 <13025910-7639-400b-878a-cd0780c6534c@kernel.org>
 <4ajmcrl3bqeikki2etek5bafzszelgevr322tvuubx4pxxyju2@qqxz6lzcb6e5>
 <fdd635ce-5e8e-4123-8e8e-241a57b4d7fe@kernel.org>
 <aF7C0B038Qi-CUSk@smile.fi.intel.com>
 <d967b0ed-da33-4cc1-9ec3-7dc1ab209d84@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d967b0ed-da33-4cc1-9ec3-7dc1ab209d84@kernel.org>

On Fri, Jun 27, 2025 at 07:59:56PM +0200, Hans de Goede wrote:
> Hi,
> 
> On 27-Jun-25 6:12 PM, Andy Shevchenko wrote:
> > On Fri, Jun 27, 2025 at 05:56:05PM +0200, Hans de Goede wrote:
> >> On 27-Jun-25 4:44 PM, Dmitry Torokhov wrote:
> >>> On Fri, Jun 27, 2025 at 04:14:38PM +0200, Hans de Goede wrote:
> >>>> On 27-Jun-25 4:06 PM, Mario Limonciello wrote:
> >>>>> On 6/26/2025 11:56 PM, Dmitry Torokhov wrote:
> > 
> > ...
> > 
> >>>>> Hans, you have a lot of experience in the GNOME community.  Your thoughts?
> >>>>
> >>>> I guess it would be good to fix this in the kernel, sending
> >>>> KEY_WAKEUP from gpio_key when the event is KEY_POWER and
> >>>> we are going through the special wakeup path in gpio_keys.
> >>>>
> >>>> When this was discussed quite a while ago the ACPI button
> >>>> driver simply did not send any event at all on wkaeup
> >>>> by ACPI power-button. Know that it does send an event
> >>>> it would be good to mimic this, at least when the gpio_key
> >>>> devices where instantiated by soc_button_array.
> >>>>
> >>>> So maybe add a new field to struct gpio_keys_button
> >>>> called wakeup_code and when that is not 0 use that
> >>>> instead of the plain "code" member on wakeups ?
> >>>>
> >>>> That would keep the gpio_keys code generic while
> >>>> allowing to mimic the ACPI button behavior.
> >>>>
> >>>> And then set wakeup_code to KEY_WAKEUP for
> >>>> the power-button in soc_button_array.
> >>>>
> >>>> To me this sounds better then trying to fix all userspace
> >>>> code which does something on KEY_POWER of which there
> >>>> is quite a lot.
> >>>>
> >>>> The special GNOME power-button handling was always
> >>>> a workaround because last time a kernel fix was
> >>>> nacked. But now with the KEY_WAKEUP done by the ACPI
> >>>> button code it looks like we do have a good way
> >>>> to fix this in the kernel, so that would be better
> >>>> IMHO.
> >>>>
> >>>> Dmitry, what do you think of adding a wakeup_code
> >>>> field to struct gpio_keys_button and let the code
> >>>> creating the gpio_keys_button decide if a different
> >>>> code should be used on wakeup or not ?
> >>>
> >>> And what is the plan on dealing with all other drivers that emit
> >>> KEY_POWER?
> >>
> >> There actually aren't that many that I'm aware of.
> >>
> >> Note that this gpio_keys KEY_POWER evdev event generation
> >> on resume issue goes way back until the last time we had
> >> this conversation and it still has not really been fixed.
> >>
> >> And I've not seen any bug-reports about the same problem
> >> with any other drivers.
> >>
> >>> What about acpi button behavior when using S0ix?
> >>
> >> AFAIK it is the same as with S3, at least it is not
> >> causing any issues. I've never seen the ACPI button code
> >> cause re-suspend immediately on wakeup by what for all
> >> intends and purposes is a spurious KEY_POWER event.
> >>
> >> Last time we discussed this I wasn't really happy with
> >> the outcome of the discussion but I just went for it
> >> because of Android's reliance on the event and we
> >> lacked a better plan.
> >>
> >> Now that we've a fix for this in the form of KEY_WAKEUP
> >> it is time to properly fix this instead of doing userspace
> >> kludges.
> >>
> >>> What about
> >>> holding power button for too long so that normal reporting "catches" the
> >>> pressed state?
> >>
> >> The key-down event is send as KEY_WAKEUP instead,
> >> so userspace sees KEY_WAKEUP pressed not KEY_POWER.
> >>
> >>> Kernel reports hardware events, interpreting them and applying certain
> >>> policies is task for userspace.
> >>
> >> And atm it is actually doing a shitty job of reporting
> >> hwevents because there is no way for userspace to be able
> >> to differentiate between:
> >>
> >> 1. User pressed power-button to wakeup system
> >> 2. User pressed power-button after resume to do
> >>    power-button-action (e.g. suspend system)
> >>
> >> Even though *the kernel* does *know* the difference.
> >>
> >> So the suggested change actually makes the kernel
> >> do its job of reporting hw-events better by making
> >> the reporting more accurate.
> >>
> >> ATM if I resume say a tablet with GNOME and then
> >> change my mind and press the power button within
> >> 3 seconds of resume to suspend it again the second
> >> power-button press will outright be ignored
> >>
> >> The current userspace workaround is racy like this,
> >> again the whole workaround in GNOME is just an ugly
> >> kludge which I did back then because we couldn't
> >> agree on a better way to deal with this in the kernel /
> >> because just suppressing sending KEY_POWER would break
> >> Android.
> >>
> >> The suggested use of KEY_WAKEUP is lightyears better
> >> then doing ignore KEY_POWER events for xx seconds
> >> after resume which is simply always going to be racy
> >> and always was just an ugly hack / never was
> >> a great solution.
> > 
> > My take away from this discussion that in a sleep state the power button
> > (or actually any wakeup source) should tell userspace "hey, we want to wake
> > up". It doesn't tell "hey, we want to wake to power off".
> > This sounds good to me as a user. Yes, if laptop is sleeping we need to wake
> > it up to continue, the power off is just a next step of this flow.
> 
> Exactly.
> 
> These are really 2 different events and the problem
> is that atm the kernel reports this as one and
> the same event type. It really is as simple as this.
> 
> Note that I'm not proposing on making this change
> something which all gpio_keys drivers will get
> automatically.
> 
> My idea of adding a wakeup_code field to
> struct gpio_keys_button allows individual gpio_keys
> users to opt-in to the behavior of
> sending KEY_SOMETHINGELSE on wakeup-by-gpio-button-press.
> 
> Since soc_button_array is only used on x86/ACPI platforms
> and since by far the most x86/ACPI platforms use
> the ACPI button code for the power-button, which already
> behaves this way I do not expect any userspace problems
> from doing such a change in soc_button_array because
> if that were a problem then we would already have bug
> reports because of the ACPI button code's behavior.

ACPI/x86 system does not necessarily mean something running generic
Linux distribution, and it may have different set of devices and
drivers. Or it may even use soc_button_array and still not want this
behavior.

> 
> > The  expected hot topic here is the longer presses of power button, but I think
> > if we have a timer and tell after say 3 second that the K_WUP was up and K_PW
> > is down is not a solution, it will be always flaky.
> 
> If users do a long power-button press on x86 they are
> *always* trying to do a forced power-off and after 4s
> (or longer in some special cases) the hw itself will
> do such a forced poweroff. So I do not believe that
> we need to worry about long presses since those
> have a very specific meaning on x86/ACPI platforms.

You only consider one environment: Gnome. There are other alternatives.
For example on Chrome OS pressing power button for longish time (but
shorter that forced power off) will result in orderly system shutdown.

> 
> Also if there is a long press userspace will simply
> see KEY_WAKEUP never getting released, which is
> actually an accurate representation of things,
> the user woke up the system through the power-button
> and never released ir.

Yeah, it will break everyone who is monitoring user activity.

Thanks.

-- 
Dmitry

