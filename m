Return-Path: <linux-acpi+bounces-14785-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17979AEBF1B
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Jun 2025 20:37:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7935D3BFDA6
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Jun 2025 18:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87B242EB5D9;
	Fri, 27 Jun 2025 18:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DMIvfO2t"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD281E22FC;
	Fri, 27 Jun 2025 18:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751049419; cv=none; b=LQFbSjJiBwPUnQR+QlKe7SyVog9IgRh6dECVLt7qvrn5vlXbSXZoX87DmgvMYgV3SHK05ovqtoKeRh04e6qzGjcyMSe5Oe+G6pwaYxW/SyemdSqEVMRsHFzst1InE43our1NqPHrmtm/VHIiCprtp0Ko5owwBxRqFsr06vWF/3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751049419; c=relaxed/simple;
	bh=Fvy1WEudqm6/UJJBAWKDnNo7pavlYM7GfJuu90g8tZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WBdXhRBvqEqX8IDfxXl2AvGQOtY2N6xdXRft8ddFN/B3a/Q1G0VNdzhUtktDH7iDsmxpAAAxj/zAcZnjxWSC69kWiaV1dDowrWT5wrRolWDQGDEkJNNSifi53daB67q6ExZ/q9AK4TenM4QDWE3HjAJ71hUUXQ/BFuwTPDwEhdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DMIvfO2t; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-74801bc6dc5so2668752b3a.1;
        Fri, 27 Jun 2025 11:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751049417; x=1751654217; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=apOr7JSI9f4opcb9AywATNGom6AWCknlgss5zj3GYnw=;
        b=DMIvfO2tQqU+3NpXEReItNQM1wfFtNzoNoc1TqdWtmra3ruuD7Xipy5Yf6uoUPMGV5
         pma7uB5el28q9Aqv0tmUYn5UuUCrcAO6aLKphm4nx5RMKunwg3hKNZcFDfBnVHb2Szpw
         qv6+OZDc27wKXOWte4YAAL5njwh30OY0zr+VdImmyVqGyzDr7pE0MTWT/+cSOx9AIZnf
         GAmN0pfdUfPXXhc+/r3chrdcH/17q0Gn58SWRyYiB3y7Q5P2db+k6ELMmuyMaKMBikp+
         k0As/4b3sDvsfx7qef8Xx30Q1I09otPs1V+UZZMBtxPSlJJewi9gvumw06H3PKJ7r5R0
         X1rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751049417; x=1751654217;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=apOr7JSI9f4opcb9AywATNGom6AWCknlgss5zj3GYnw=;
        b=vy1UkQehBhcMQZtw5WUUGAm5J7aPG/AYDM6saVuMHgAI7vy4kEc8FHZuJA+pMLsCvO
         CiusLtxjITUE/f4ud9eYvXh3Oczo0gqG6Inq56QZ9dhPzYCRGiX9+934SqvurS6Lj1ur
         o9jOeMi91qVctm6b/5iWQYWbBE0DNqpDH066wCqLkkix1o6pzbIV1gSkxlMS2DPGyE4L
         Pz9YxzhwbkDvOo3zGZtrT1rdEEVzAYKX/aNLWlXpLF4qbsk8uk8sWlVAJaXjSPSYL6Xf
         NDZD8od4TFDbqc1ufQdaJL3nhNMtRf4Bnqgus/evsSvkl7mGB/Y1YMiuR1AKfl4XnGub
         cl5w==
X-Forwarded-Encrypted: i=1; AJvYcCWHynxSt1JMUeM9+kIU/o24v3wlI5mo1yyo0LRyEy5Cn/OrEzkEfeQPANb+jWGc7Nyw9CJ03xlrOI3xrAA=@vger.kernel.org, AJvYcCXShIp2eoTcVI0s+uPODiwz2Ew91AVio+8yYxSaRw5yCzyMp8BjU46xgvNtY0XytYdThq6ISK4O5Pyu@vger.kernel.org, AJvYcCXdMQLPn5WS4oNWrWv9eRMyg2ooTZfnBCVc7/mUy18YO6VdfJKy5BqSCpTuFjtUfL6dSmKiuiDhhnv4UQ==@vger.kernel.org, AJvYcCXhhpFW2hnWVx1EbVkow1TOzbmP2T408V1hOMaKivD9UBLCVv9OcldOfr4+RRkuzRTbx1WY+isg+OCEoU5L@vger.kernel.org
X-Gm-Message-State: AOJu0YxwAcx+gGpGWWWbUma3F/yZdReOHFCyuL6ahHF96+1MS/hbIxQ6
	zeJbcOPEMH1keONd4Zq0nrlbJQz7/VNC2Z5tB/VUkQL0djJLl7XJb8AS
X-Gm-Gg: ASbGncveHsjiRjKkXlks3+fASl2hWsXbRqV4yXfW5N+hDHh4W8AQ3wzpsiZR4yRa8Pi
	UcFTLulEWJ47NTB5STcylK9/nxTFLiIolk79UL/JqAr5ALs/E/J5j0fS1i3JCWkrjLltveJYY0c
	GaKS3TLcrnvNpwMy2kyDcRPyEtyDOmMBq9PayLMyOFdsbZs09cEem2QIAzrx4CWY4poIE5u9S6Q
	6upylMH03+PFQBxdVOH5nbEiJSJXT80L7r8hcCsYhZUWwxBax5pWg6sfoMLtFkC8g9EgyUp+Hjh
	EIjnXHFhdcp2hB0xS3+9W8FA7/QioY5GUSuqNFblatQedJbfjPZU1BgPj2QrRA==
X-Google-Smtp-Source: AGHT+IFPvQoXmqkwKork+hteiedCgYMOlOCjR6dXd0N/boeMQetfTbFp0MPLxjBjnBSFA15ZeiHz1g==
X-Received: by 2002:a05:6a00:8ca:b0:749:1e60:bdd with SMTP id d2e1a72fcca58-74af7893218mr5911973b3a.2.1751049416491;
        Fri, 27 Jun 2025 11:36:56 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:d0c7:d92:6a17:eb62])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af5409a58sm2684888b3a.6.2025.06.27.11.36.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 11:36:56 -0700 (PDT)
Date: Fri, 27 Jun 2025 11:36:52 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Hans de Goede <hansg@kernel.org>
Cc: Mario Limonciello <superm1@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Mika Westerberg <westeri@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Linus Walleij <linus.walleij@linaro.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, "open list:GPIO ACPI SUPPORT" <linux-gpio@vger.kernel.org>, 
	"open list:GPIO ACPI SUPPORT" <linux-acpi@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:INPUT (KEYBOARD, MOUSE, JOYSTICK, TOUCHSCREEN)..." <linux-input@vger.kernel.org>, Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH v3 4/4] Input: Don't send fake button presses to wake
 system
Message-ID: <eaf7bva2skjz6oo2s2f4agooplthvuztyr6tssa7rux764qw35@kscd3rtejfvn>
References: <CAJZ5v0gKUN1OdqAHnXNcFUAOfhpdRfa_o=L6TA2GZTpe1bMaNQ@mail.gmail.com>
 <exmgckzoakt2ncsdphqvymcadon7k6tl36a3zvrj2pv23dffps@znq23v3qbcm2>
 <CAJZ5v0j3ZyuEqSKQ+3K8M3BwPCxn5Z6KOwjyjt4cJW6HfxjPDw@mail.gmail.com>
 <hyvpl4gvxc6h2r3itfofjduwb3vpobyo7a7z6g3zapzscqtafh@ixsd4amyljva>
 <de548b27-4c43-4f30-af9d-b060101e6fd8@kernel.org>
 <75fixx6rgwsgsw6e765oxdcivcg2nkzx2fp2qywgx4vi3ihywh@ot7gdecsnttw>
 <1b0d2349-dbf7-47aa-95c9-1974e63d111a@kernel.org>
 <13025910-7639-400b-878a-cd0780c6534c@kernel.org>
 <4ajmcrl3bqeikki2etek5bafzszelgevr322tvuubx4pxxyju2@qqxz6lzcb6e5>
 <fdd635ce-5e8e-4123-8e8e-241a57b4d7fe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fdd635ce-5e8e-4123-8e8e-241a57b4d7fe@kernel.org>

On Fri, Jun 27, 2025 at 05:56:05PM +0200, Hans de Goede wrote:
> Hi Dmitry,
> 
> On 27-Jun-25 4:44 PM, Dmitry Torokhov wrote:
> > On Fri, Jun 27, 2025 at 04:14:38PM +0200, Hans de Goede wrote:
> >> Hi,
> >>
> >> On 27-Jun-25 4:06 PM, Mario Limonciello wrote:
> >>> On 6/26/2025 11:56 PM, Dmitry Torokhov wrote:
> >>>> On Thu, Jun 26, 2025 at 05:21:35PM -0500, Mario Limonciello wrote:
> >>>>> On 6/26/2025 2:40 PM, Dmitry Torokhov wrote:
> >>>>>> On Thu, Jun 26, 2025 at 09:31:12PM +0200, Rafael J. Wysocki wrote:
> >>>>>>> On Thu, Jun 26, 2025 at 9:28 PM Dmitry Torokhov
> >>>>>>> <dmitry.torokhov@gmail.com> wrote:
> >>>>>>>>
> >>>>>>>> On Thu, Jun 26, 2025 at 09:18:56PM +0200, Rafael J. Wysocki wrote:
> >>>>>>>>> On Thu, Jun 26, 2025 at 9:16 PM Hans de Goede <hansg@kernel.org> wrote:
> >>>>>>>>>>
> >>>>>>>>>> Hi,
> >>>>>>>>>>
> >>>>>>>>>> On 26-Jun-25 21:14, Dmitry Torokhov wrote:
> >>>>>>>>>>> On Thu, Jun 26, 2025 at 08:57:30PM +0200, Hans de Goede wrote:
> >>>>>>>>>>>> Hi,
> >>>>>>>>>>>>
> >>>>>>>>>>>> On 26-Jun-25 20:48, Dmitry Torokhov wrote:
> >>>>>>>>>>>>> On Thu, Jun 26, 2025 at 01:20:54PM -0500, Mario Limonciello wrote:
> >>>>>>>> [...]
> >>>>>>>>>>>>>> I want to note this driver works quite differently than how ACPI power
> >>>>>>>>>>>>>> button does.
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> You can see in acpi_button_notify() that the "keypress" is only forwarded
> >>>>>>>>>>>>>> when not suspended [1].  Otherwise it's just wakeup event (which is what my
> >>>>>>>>>>>>>> patch was modeling).
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> https://github.com/torvalds/linux/blob/v6.16-rc3/drivers/acpi/button.c#L461
> >>>>>>>>>>>>>> [1]
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> If you check acpi_button_resume() you will see that the events are sent
> >>>>>>>>>>>>> from there. Except that for some reason they chose to use KEY_WAKEUP and
> >>>>>>>>>>>>> not KEY_POWER, oh well. Unlike acpi button driver gpio_keys is used on
> >>>>>>>>>>>>> multiple other platforms.
> >>>>>>>>>>>>
> >>>>>>>>>>>> Interesting, but the ACPI button code presumably only does this on resume
> >>>>>>>>>>>> for a normal press while the system is awake it does use KEY_POWER, right ?
> >>>>>>>>>>>
> >>>>>>>>>>> Yes. It is unclear to me why they chose to mangle the event on wakeup,
> >>>>>>>>>>> it does not seem to be captured in the email discussions or in the patch
> >>>>>>>>>>> description.
> >>>>>>>>>>
> >>>>>>>>>> I assume they did this to avoid the immediate re-suspend on wakeup by
> >>>>>>>>>> power-button issue. GNOME has a workaround for this, but I assume that
> >>>>>>>>>> some userspace desktop environments are still going to have a problem
> >>>>>>>>>> with this.
> >>>>>>>>>
> >>>>>>>>> It was done for this reason IIRC, but it should have been documented
> >>>>>>>>> more thoroughly.
> >>>>>>>>
> >>>>>>>> I assert that it should not have been done and instead dealt with in
> >>>>>>>> userspace. There are numerous drivers in the kernel emitting
> >>>>>>>> KEY_POWER. Let userspace decide how to handle this, what keys to ignore,
> >>>>>>>> what keys to process and when.
> >>>>>>>
> >>>>>>> Please see my last message in this thread (just sent) and see the
> >>>>>>> changelog of commit 16f70feaabe9 ("ACPI: button: trigger wakeup key
> >>>>>>> events").
> >>>>>>>
> >>>>>>> This appears to be about cases when no event would be signaled to user
> >>>>>>> space at all (power button wakeup from ACPI S3).
> >>>>>>
> >>>>>> Ahh, in S3 we do not know if we've been woken up with Sleep or Power
> >>>>>> button, right? So we can not send the "right" event code and use
> >>>>>> "neutral" KEY_WAKEUP for both. Is this right?
> >>>>>>
> >>>>>> Thanks.
> >>>>>>
> >>>>>
> >>>>> I did some more experiments with this affected system that started this
> >>>>> thread (which uses s2idle).
> >>>>>
> >>>>> I only applied patch 3 in this series to help the debounce behavior and
> >>>>> figure out impacts from patch 4 with existing Linux userspace.
> >>>>>
> >>>>> If suspended using systemd in GNOME (click the GUI button) on Ubuntu 24.04
> >>>>> the GNOME workaround mitigates this problem and no visible impact.
> >>>>>
> >>>>> If I suspend by hand using the kernel interface and then press power button
> >>>>> to wake:
> >>>>>
> >>>>> # echo mem | sudo tee /sys/power/state:
> >>>>>
> >>>>> * When GNOME is running:
> >>>>> I get the shutdown popup and it eventually shuts down.
> >>>>>
> >>>>> * When GNOME isn't running (just on a VT):
> >>>>> System shuts down.
> >>>>
> >>>> For the latter you may want to raise an issue with systemd, and for the
> >>>> former I guess it is being too clever and does not activate the
> >>>> workaround if suspend was not initiated by it? I think Gnome is being
> >>>> too careful.
> >>>>
> >>>> Thanks.
> >>>>
> >>>
> >>> Sure I could file bugs with both the projects.
> >>>
> >>> But before I do if all userspace needs to account for this with a series of workarounds at resume time, you still think that is that really the best way forward?
> >>>
> >>> Hans, you have a lot of experience in the GNOME community.  Your thoughts?
> >>
> >> I guess it would be good to fix this in the kernel, sending
> >> KEY_WAKEUP from gpio_key when the event is KEY_POWER and
> >> we are going through the special wakeup path in gpio_keys.
> >>
> >> When this was discussed quite a while ago the ACPI button
> >> driver simply did not send any event at all on wkaeup
> >> by ACPI power-button. Know that it does send an event
> >> it would be good to mimic this, at least when the gpio_key
> >> devices where instantiated by soc_button_array.
> >>
> >> So maybe add a new field to struct gpio_keys_button
> >> called wakeup_code and when that is not 0 use that
> >> instead of the plain "code" member on wakeups ?
> >>
> >> That would keep the gpio_keys code generic while
> >> allowing to mimic the ACPI button behavior.
> >>
> >> And then set wakeup_code to KEY_WAKEUP for
> >> the power-button in soc_button_array.
> >>
> >> To me this sounds better then trying to fix all userspace
> >> code which does something on KEY_POWER of which there
> >> is quite a lot.
> >>
> >> The special GNOME power-button handling was always
> >> a workaround because last time a kernel fix was
> >> nacked. But now with the KEY_WAKEUP done by the ACPI
> >> button code it looks like we do have a good way
> >> to fix this in the kernel, so that would be better
> >> IMHO.
> >>
> >> Dmitry, what do you think of adding a wakeup_code
> >> field to struct gpio_keys_button and let the code
> >> creating the gpio_keys_button decide if a different
> >> code should be used on wakeup or not ?
> > 
> > And what is the plan on dealing with all other drivers that emit
> > KEY_POWER?
> 
> There actually aren't that many that I'm aware of.

dtor@dtor-ws:~/kernel/work $ git grep -l KEY_POWER -- drivers/{input,hid,platform}/ | wc -l
51

Additionally:

dtor@dtor-ws:~/kernel/work $ git grep -l KEY_POWER -- arch/arm*/boot/dts | wc -l
254

> 
> Note that this gpio_keys KEY_POWER evdev event generation
> on resume issue goes way back until the last time we had
> this conversation and it still has not really been fixed.

I am sorry to hear that. I am not involved in Gnome so I am not sure why
it takes so long, I guess not tablets or detachables are a minority of
deployments so it is not prioritized? Android seems to have a handle on
this as does Chrome OS...

> 
> And I've not seen any bug-reports about the same problem
> with any other drivers.

I guess you will next want to patch cros_ec_keyb in case someone uses
generic distro with x86 Chromebooks, and then matrix keypad, and then
all drivers that are used outside of x86.

> 
> > What about acpi button behavior when using S0ix?
> 
> AFAIK it is the same as with S3, at least it is not
> causing any issues. I've never seen the ACPI button code
> cause re-suspend immediately on wakeup by what for all
> intends and purposes is a spurious KEY_POWER event.

Rafael has made assertion that in S3 it is impossible to differentiate
whether the button is power button or not. But looking at this I do not
think it is correct assertion. "Notify Wake" is sent for a given
button. Or maybe I misunderstood and he meant that the *state* if button
is not available in "Notify Wake"?

In fact, I think login in the ACPI button is pretty broken and needs to
be undone/reverted:

1. The driver sends KEY_WAKEUP events on every resume. It does not
matter if wakeup is done by pressing power button, wake or lan packet,
or an act of God, it will send KEY_WAKEUP as part of the button *device*
resume.

2. There is a patch from Mario (a8605b0ed187) suppressing sending
KEY_POWER as part of "normal" wakeup handling, pretty much the same as
what he and you are proposing to do in gpio-keys (and eventually in
every driver keyboard or button driver in the kernel). This means we no
longer can tell if wakeup is done by power button or sleep button (on
systems with dual-button models, see ACPI 4.8.3.1).

To me it seems we are piling workarounds on top of workarounds. We
should report either KEY_POWER or KEY_SLEEP in the notify event for both
"Notify Wake" and "Notify State", and let userspace make decision on how
to handle this best.

> 
> Last time we discussed this I wasn't really happy with
> the outcome of the discussion but I just went for it
> because of Android's reliance on the event and we
> lacked a better plan.
> 
> Now that we've a fix for this in the form of KEY_WAKEUP
> it is time to properly fix this instead of doing userspace
> kludges.

I do not understand why you call KEY_WAKEUP being "proper". Especially
with gpio-keys you do not know if wakeup is really due to this
particular button being pressed, or the system woke up for some other
reason and user also happened to have the button pressed. ACPI button is
really an outlier here because firmware interface defines a dedicated
event for waking up.

> 
> > What about
> > holding power button for too long so that normal reporting "catches" the
> > pressed state?
> 
> The key-down event is send as KEY_WAKEUP instead,
> so userspace sees KEY_WAKEUP pressed not KEY_POWER.

This assumes the driver does not report state between press and release,
which is not guaranteed. Or we now require drivers to keep track whether
release for KEY_WAKEUP has been done and that it can return to reporting
KEY_POWER.

> 
> > Kernel reports hardware events, interpreting them and applying certain
> > policies is task for userspace.
> 
> And atm it is actually doing a shitty job of reporting
> hwevents because there is no way for userspace to be able
> to differentiate between:
> 
> 1. User pressed power-button to wakeup system
> 2. User pressed power-button after resume to do
>    power-button-action (e.g. suspend system)
> 
> Even though *the kernel* does *know* the difference.

Does it really? Aside of ACPI button you have no idea if button press
coincided with some other event waking up the system. You can guess, but
that is it, a guess.

> 
> So the suggested change actually makes the kernel
> do its job of reporting hw-events better by making
> the reporting more accurate.

No, you are making assumptions, but instead of doing it in userspace
where you can give user choice to adjust the behavior you are
hard-coding it.

> 
> ATM if I resume say a tablet with GNOME and then
> change my mind and press the power button within
> 3 seconds of resume to suspend it again the second
> power-button press will outright be ignored

Please fix Gnome. It is possible to handle rapid power button presses
(because other OSed/environments do that).

> 
> The current userspace workaround is racy like this,
> again the whole workaround in GNOME is just an ugly
> kludge which I did back then because we couldn't
> agree on a better way to deal with this in the kernel /
> because just suppressing sending KEY_POWER would break
> Android.
> 
> The suggested use of KEY_WAKEUP is lightyears better
> then doing ignore KEY_POWER events for xx seconds
> after resume which is simply always going to be racy
> and always was just an ugly hack / never was
> a great solution.

My opinion is that KEY_WAKEUP is not much better and we are actually
losing information if we try to implement that (again, because you do
not know if button press was the real cause of wakeup or it simply
coincided with something else).

Thanks.

-- 
Dmitry

