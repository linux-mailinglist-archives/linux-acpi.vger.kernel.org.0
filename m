Return-Path: <linux-acpi+bounces-14773-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 687CDAEBA2B
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Jun 2025 16:44:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F4AE5637A0
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Jun 2025 14:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2143A2E8882;
	Fri, 27 Jun 2025 14:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BIhV8TO0"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64AE62E2EF4;
	Fri, 27 Jun 2025 14:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751035452; cv=none; b=hdELwRekALTsGFOFYAKGxd1Z11ivH4ZZDzMP2s807fh2cG+75FcpPfM8WUcK+VBHD2sQcWO3zXJUAd8P6bkG7c1U1oPxu75sbn7KmWxVAHcOZn+d0BWXhxUuCaxB7YY73VS5FRabf0nDHgVsq2HiALeJDf7gKp+Mu6l1nnR7vU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751035452; c=relaxed/simple;
	bh=xbgJ+4omV63C1qF0YHplAoYe4qeN72zvGM0+85bnND4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QhPWDiHjcEkzvL2RN0Hj4q5gQYeTII489pzuub2uTtUmNR3Ny3iZIoK+Le3faguqUoNFlvCas0aBS9yuLb8WZ6PZkXddXVQJfHp3Oi2y3r8MJbqrcdr7d3UDAsnItoxggyyQvjU5JfhkgM8zUR/fjE/EdjORe8RuW3HNPB9dhHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BIhV8TO0; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-74ad4533ac5so2623358b3a.0;
        Fri, 27 Jun 2025 07:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751035450; x=1751640250; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=c7muZe041KCotlZJyu2Y6b6NKraUhJfPR+s7w30z5pk=;
        b=BIhV8TO0e3Ooj2iqMB52vMZ9Oxw6R8GWu69TFAr3IOJloKBIUmZfnseq5zCRRd6atg
         zE8TH1wLCLRk3nKUrscVTGhHmaBddE3t7GYSKDSZGu4lhsA1nnfgDxsbkiEH1MRfQY/k
         oQqmY3uysFmUsr2+xQxrd1XLF0rt8YbAcZw1cV6FIxIXmag2Ks2JleCeWI3r7qI2soIu
         cu87Atru00+3FcQIl/2jdav8hRDl8oJyPkSS6tAoc06igFiDciugLYkZ3RmNEGRiqhZ8
         c7h5trGXQEdMSWeoFMMa3RgXCoNd42baRgjGvK4ic1I+l0WDs6rtA1NARkPxnBQrGIlI
         A/UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751035450; x=1751640250;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c7muZe041KCotlZJyu2Y6b6NKraUhJfPR+s7w30z5pk=;
        b=cz3mfMVNOuQVIhK7q2pRpX+S7kKaj4UAeBUnHI6l+tfCx2T42o2S6egrJsYDPe1Wlh
         4uSwRVz8hTnnk1TybtNnAlRKf1eqVPHKjMID1LSQ2mnbwkW7Uu3ffgQtGMnurc8YdRhB
         VyZDSARc+CcfWveUKrdMUkq3+OscYz91nXgPYbpQSAq690ZIi7OfidsQW3EkppUpKgPx
         qr9DPGYepr0ipwXm8PXZ9AKR3uaWjkUdEVXhq0ClhS+Z8B/LlkZmWrs+xKygdz6MEqXD
         kSlhy3frdVrkqDoHjZq2CqHwYR8IX8KNeiZkJQCEcbPm2HOeelhmwdRHCrgo9+3Ryj4u
         UcNA==
X-Forwarded-Encrypted: i=1; AJvYcCUMUfbIAphn9GWAq8r/mYzMiwrfKp+q+no2eQWhgimIr2nxGWdQeBZGVNeyxsNPRZQgOOaowl/6ELxkyumi@vger.kernel.org, AJvYcCUusfN/KzLgoVdEyeAG01/YMajlGRPKzQAwxm44hdFcc4XO0Xe+1anFnuyJKDHlgWXVsphqzNAZG4xaCPo=@vger.kernel.org, AJvYcCWgcDNro6fl0lxJg5FXjZrPnXshp64+c1XDi/2QKoQ7ce/ItDPzUFxXlY4JLPjuuTPr1rwyAvRfaKEr@vger.kernel.org, AJvYcCWqh6WK5fTorvzMwfTPYG4mQSAtwmteAfRQMF0ETJ7uU7OoSy4oWiorXBFO6aLiNzHs7ROKrcXc3kHTKg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzqedesRysgiLto3ck9QdNPS2af6JdxIWcnYtdggPG/SjHwy/D+
	mXIMyzIg5o32gLDDGdkXukUlMAQuSlLKtCGoggsaX9nQUK7Ns6ruL066
X-Gm-Gg: ASbGncuInE1y2f1niqw3KtRHJ2LBcK18XIz2+ITfuAIshl4kPtVMRDFO5LD7BkP8vJc
	TYU27aDmDGS0CZkuqEBDsepOA9BMnOTaCeDjEONev49S0Mf93LGZC95eNCoaxxTQPvXs5aP0p4b
	GYKIm0LmrMbtUWZc/eTrcUfBH4QSVGZckJlTNoltJGwlJ2b5T5JRp371P+zr6I53Du59H1jEZxx
	LXC2Vp/ZcsDMFpo8mAgPwNETrZx3OCkLeLz12HCL7evKyTFT2yFwnGAHFVr9ior9cms/uBQDGmH
	BsyAKJm1ubBoFt1Pt0TBMVu4K2VdGDlEMSdGYYu6Pp0yr70PYNHKRKWnhlkKAw==
X-Google-Smtp-Source: AGHT+IGHaOP0N7qnRtc2EfE/Ivsum+RS71n53+h08m3TcJaMi3+jWOmFFV/IlDiOXawk0fJRrbRiLA==
X-Received: by 2002:a17:903:f8d:b0:221:1497:7b08 with SMTP id d9443c01a7336-2390a54c778mr129378615ad.23.1751035449529;
        Fri, 27 Jun 2025 07:44:09 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:d0c7:d92:6a17:eb62])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb2e1a8asm18852565ad.47.2025.06.27.07.44.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 07:44:09 -0700 (PDT)
Date: Fri, 27 Jun 2025 07:44:05 -0700
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
Message-ID: <4ajmcrl3bqeikki2etek5bafzszelgevr322tvuubx4pxxyju2@qqxz6lzcb6e5>
References: <vkau25ybcx3bcoa2jmxlukumunzii5h6em43anh6mmzk2kyiv7@kyych4kxc4zo>
 <0d71a686-da67-4686-8976-a17d0d1ca923@kernel.org>
 <CAJZ5v0gKUN1OdqAHnXNcFUAOfhpdRfa_o=L6TA2GZTpe1bMaNQ@mail.gmail.com>
 <exmgckzoakt2ncsdphqvymcadon7k6tl36a3zvrj2pv23dffps@znq23v3qbcm2>
 <CAJZ5v0j3ZyuEqSKQ+3K8M3BwPCxn5Z6KOwjyjt4cJW6HfxjPDw@mail.gmail.com>
 <hyvpl4gvxc6h2r3itfofjduwb3vpobyo7a7z6g3zapzscqtafh@ixsd4amyljva>
 <de548b27-4c43-4f30-af9d-b060101e6fd8@kernel.org>
 <75fixx6rgwsgsw6e765oxdcivcg2nkzx2fp2qywgx4vi3ihywh@ot7gdecsnttw>
 <1b0d2349-dbf7-47aa-95c9-1974e63d111a@kernel.org>
 <13025910-7639-400b-878a-cd0780c6534c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <13025910-7639-400b-878a-cd0780c6534c@kernel.org>

On Fri, Jun 27, 2025 at 04:14:38PM +0200, Hans de Goede wrote:
> Hi,
> 
> On 27-Jun-25 4:06 PM, Mario Limonciello wrote:
> > On 6/26/2025 11:56 PM, Dmitry Torokhov wrote:
> >> On Thu, Jun 26, 2025 at 05:21:35PM -0500, Mario Limonciello wrote:
> >>> On 6/26/2025 2:40 PM, Dmitry Torokhov wrote:
> >>>> On Thu, Jun 26, 2025 at 09:31:12PM +0200, Rafael J. Wysocki wrote:
> >>>>> On Thu, Jun 26, 2025 at 9:28 PM Dmitry Torokhov
> >>>>> <dmitry.torokhov@gmail.com> wrote:
> >>>>>>
> >>>>>> On Thu, Jun 26, 2025 at 09:18:56PM +0200, Rafael J. Wysocki wrote:
> >>>>>>> On Thu, Jun 26, 2025 at 9:16 PM Hans de Goede <hansg@kernel.org> wrote:
> >>>>>>>>
> >>>>>>>> Hi,
> >>>>>>>>
> >>>>>>>> On 26-Jun-25 21:14, Dmitry Torokhov wrote:
> >>>>>>>>> On Thu, Jun 26, 2025 at 08:57:30PM +0200, Hans de Goede wrote:
> >>>>>>>>>> Hi,
> >>>>>>>>>>
> >>>>>>>>>> On 26-Jun-25 20:48, Dmitry Torokhov wrote:
> >>>>>>>>>>> On Thu, Jun 26, 2025 at 01:20:54PM -0500, Mario Limonciello wrote:
> >>>>>> [...]
> >>>>>>>>>>>> I want to note this driver works quite differently than how ACPI power
> >>>>>>>>>>>> button does.
> >>>>>>>>>>>>
> >>>>>>>>>>>> You can see in acpi_button_notify() that the "keypress" is only forwarded
> >>>>>>>>>>>> when not suspended [1].  Otherwise it's just wakeup event (which is what my
> >>>>>>>>>>>> patch was modeling).
> >>>>>>>>>>>>
> >>>>>>>>>>>> https://github.com/torvalds/linux/blob/v6.16-rc3/drivers/acpi/button.c#L461
> >>>>>>>>>>>> [1]
> >>>>>>>>>>>
> >>>>>>>>>>> If you check acpi_button_resume() you will see that the events are sent
> >>>>>>>>>>> from there. Except that for some reason they chose to use KEY_WAKEUP and
> >>>>>>>>>>> not KEY_POWER, oh well. Unlike acpi button driver gpio_keys is used on
> >>>>>>>>>>> multiple other platforms.
> >>>>>>>>>>
> >>>>>>>>>> Interesting, but the ACPI button code presumably only does this on resume
> >>>>>>>>>> for a normal press while the system is awake it does use KEY_POWER, right ?
> >>>>>>>>>
> >>>>>>>>> Yes. It is unclear to me why they chose to mangle the event on wakeup,
> >>>>>>>>> it does not seem to be captured in the email discussions or in the patch
> >>>>>>>>> description.
> >>>>>>>>
> >>>>>>>> I assume they did this to avoid the immediate re-suspend on wakeup by
> >>>>>>>> power-button issue. GNOME has a workaround for this, but I assume that
> >>>>>>>> some userspace desktop environments are still going to have a problem
> >>>>>>>> with this.
> >>>>>>>
> >>>>>>> It was done for this reason IIRC, but it should have been documented
> >>>>>>> more thoroughly.
> >>>>>>
> >>>>>> I assert that it should not have been done and instead dealt with in
> >>>>>> userspace. There are numerous drivers in the kernel emitting
> >>>>>> KEY_POWER. Let userspace decide how to handle this, what keys to ignore,
> >>>>>> what keys to process and when.
> >>>>>
> >>>>> Please see my last message in this thread (just sent) and see the
> >>>>> changelog of commit 16f70feaabe9 ("ACPI: button: trigger wakeup key
> >>>>> events").
> >>>>>
> >>>>> This appears to be about cases when no event would be signaled to user
> >>>>> space at all (power button wakeup from ACPI S3).
> >>>>
> >>>> Ahh, in S3 we do not know if we've been woken up with Sleep or Power
> >>>> button, right? So we can not send the "right" event code and use
> >>>> "neutral" KEY_WAKEUP for both. Is this right?
> >>>>
> >>>> Thanks.
> >>>>
> >>>
> >>> I did some more experiments with this affected system that started this
> >>> thread (which uses s2idle).
> >>>
> >>> I only applied patch 3 in this series to help the debounce behavior and
> >>> figure out impacts from patch 4 with existing Linux userspace.
> >>>
> >>> If suspended using systemd in GNOME (click the GUI button) on Ubuntu 24.04
> >>> the GNOME workaround mitigates this problem and no visible impact.
> >>>
> >>> If I suspend by hand using the kernel interface and then press power button
> >>> to wake:
> >>>
> >>> # echo mem | sudo tee /sys/power/state:
> >>>
> >>> * When GNOME is running:
> >>> I get the shutdown popup and it eventually shuts down.
> >>>
> >>> * When GNOME isn't running (just on a VT):
> >>> System shuts down.
> >>
> >> For the latter you may want to raise an issue with systemd, and for the
> >> former I guess it is being too clever and does not activate the
> >> workaround if suspend was not initiated by it? I think Gnome is being
> >> too careful.
> >>
> >> Thanks.
> >>
> > 
> > Sure I could file bugs with both the projects.
> > 
> > But before I do if all userspace needs to account for this with a series of workarounds at resume time, you still think that is that really the best way forward?
> > 
> > Hans, you have a lot of experience in the GNOME community.  Your thoughts?
> 
> I guess it would be good to fix this in the kernel, sending
> KEY_WAKEUP from gpio_key when the event is KEY_POWER and
> we are going through the special wakeup path in gpio_keys.
> 
> When this was discussed quite a while ago the ACPI button
> driver simply did not send any event at all on wkaeup
> by ACPI power-button. Know that it does send an event
> it would be good to mimic this, at least when the gpio_key
> devices where instantiated by soc_button_array.
> 
> So maybe add a new field to struct gpio_keys_button
> called wakeup_code and when that is not 0 use that
> instead of the plain "code" member on wakeups ?
> 
> That would keep the gpio_keys code generic while
> allowing to mimic the ACPI button behavior.
> 
> And then set wakeup_code to KEY_WAKEUP for
> the power-button in soc_button_array.
> 
> To me this sounds better then trying to fix all userspace
> code which does something on KEY_POWER of which there
> is quite a lot.
> 
> The special GNOME power-button handling was always
> a workaround because last time a kernel fix was
> nacked. But now with the KEY_WAKEUP done by the ACPI
> button code it looks like we do have a good way
> to fix this in the kernel, so that would be better
> IMHO.
> 
> Dmitry, what do you think of adding a wakeup_code
> field to struct gpio_keys_button and let the code
> creating the gpio_keys_button decide if a different
> code should be used on wakeup or not ?

And what is the plan on dealing with all other drivers that emit
KEY_POWER? What about acpi button behavior when using S0ix? What about
holding power button for too long so that normal reporting "catches" the
pressed state?

Kernel reports hardware events, interpreting them and applying certain
policies is task for userspace.

Thanks.

-- 
Dmitry

