Return-Path: <linux-acpi+bounces-14780-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40533AEBCE1
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Jun 2025 18:12:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 059061C60A29
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Jun 2025 16:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95F1B2E9ED7;
	Fri, 27 Jun 2025 16:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="da/fyb7J"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4CB2E973C;
	Fri, 27 Jun 2025 16:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751040729; cv=none; b=TQBeHlHlzkj4JW7o2coIAC61Sb+q44kfLsqlnt06YBot5aoMFFecGgoPd7T/PRLIeXbZE8977ifl3hzJnXVRmzb0LCbIxeDQo7j58MKdBR4thu4oAyt6ir2yzm6Nauc66LA/Bw5yRbQwhzykKFE6FKAf0danyGxtCFSZJtGRY1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751040729; c=relaxed/simple;
	bh=LK6QY4UU3h9fKPWEGu4Bo9w7QBVoPO0VsOonrKWs6Zw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pegE/WU399NzMDDf3DEGJLoOHgFyiF9yfGYlA7FnZnBR1GswgPOjxVH7XRnVBSv663t4KzCUnut79NiqXdeocEI8pad4SERSo57kGll72r1oT+eYJxiWlIjhwrllsKsMSZlEyF4bq8EeQ3sIyNIf/qifBDvpkgnYxU2Hgg23y3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=da/fyb7J; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751040728; x=1782576728;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=LK6QY4UU3h9fKPWEGu4Bo9w7QBVoPO0VsOonrKWs6Zw=;
  b=da/fyb7Joao/zJBzRMpyCnEUA/YFUtDi10/l2GFLxpsaiKTw6Ue+IA4c
   srWChAkOcPsnNQqT6HwIt4vUwtpojvHsQ3tJuRyur6Wl2234JqSMXoHfx
   UPtOZKvc0bJntN5qVm1uJWujoQ/s7BZO+mmijTRDR3SmQhkh5nOURIB7y
   MoonWrrNj7SXj9Mg9FrWwpHx39SXr93dGe7YwLxeOKOK1bHzVWgh1K3x8
   l82IfaHQBT/SIJyAgelZElGA/dsaX2nfOOncC+HJg7+o2/e5n0HBM+IJG
   +sN3CEOHPGOPoda3UIJoT5Ovo8TXAEYSB95iM42UXen9b9V+BydtdYxlZ
   g==;
X-CSE-ConnectionGUID: SzVTDHwORbao+UOWY1akZQ==
X-CSE-MsgGUID: BCjxxpiLTWq9ZdORyvmV6Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11477"; a="53300162"
X-IronPort-AV: E=Sophos;i="6.16,270,1744095600"; 
   d="scan'208";a="53300162"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2025 09:12:07 -0700
X-CSE-ConnectionGUID: 3vZf4p7YShCaX9YgHIgV4g==
X-CSE-MsgGUID: kFOld4pyTzmSLJZqhgzLiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,270,1744095600"; 
   d="scan'208";a="183880396"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2025 09:12:04 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uVBgG-0000000AX0g-3lpA;
	Fri, 27 Jun 2025 19:12:00 +0300
Date: Fri, 27 Jun 2025 19:12:00 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Hans de Goede <hansg@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Mario Limonciello <superm1@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Mika Westerberg <westeri@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	"open list:GPIO ACPI SUPPORT" <linux-gpio@vger.kernel.org>,
	"open list:GPIO ACPI SUPPORT" <linux-acpi@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:INPUT (KEYBOARD, MOUSE, JOYSTICK, TOUCHSCREEN)..." <linux-input@vger.kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH v3 4/4] Input: Don't send fake button presses to wake
 system
Message-ID: <aF7C0B038Qi-CUSk@smile.fi.intel.com>
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
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fdd635ce-5e8e-4123-8e8e-241a57b4d7fe@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Jun 27, 2025 at 05:56:05PM +0200, Hans de Goede wrote:
> On 27-Jun-25 4:44 PM, Dmitry Torokhov wrote:
> > On Fri, Jun 27, 2025 at 04:14:38PM +0200, Hans de Goede wrote:
> >> On 27-Jun-25 4:06 PM, Mario Limonciello wrote:
> >>> On 6/26/2025 11:56 PM, Dmitry Torokhov wrote:

...

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
> 
> Note that this gpio_keys KEY_POWER evdev event generation
> on resume issue goes way back until the last time we had
> this conversation and it still has not really been fixed.
> 
> And I've not seen any bug-reports about the same problem
> with any other drivers.
> 
> > What about acpi button behavior when using S0ix?
> 
> AFAIK it is the same as with S3, at least it is not
> causing any issues. I've never seen the ACPI button code
> cause re-suspend immediately on wakeup by what for all
> intends and purposes is a spurious KEY_POWER event.
> 
> Last time we discussed this I wasn't really happy with
> the outcome of the discussion but I just went for it
> because of Android's reliance on the event and we
> lacked a better plan.
> 
> Now that we've a fix for this in the form of KEY_WAKEUP
> it is time to properly fix this instead of doing userspace
> kludges.
> 
> > What about
> > holding power button for too long so that normal reporting "catches" the
> > pressed state?
> 
> The key-down event is send as KEY_WAKEUP instead,
> so userspace sees KEY_WAKEUP pressed not KEY_POWER.
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
> 
> So the suggested change actually makes the kernel
> do its job of reporting hw-events better by making
> the reporting more accurate.
> 
> ATM if I resume say a tablet with GNOME and then
> change my mind and press the power button within
> 3 seconds of resume to suspend it again the second
> power-button press will outright be ignored
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

My take away from this discussion that in a sleep state the power button
(or actually any wakeup source) should tell userspace "hey, we want to wake
up". It doesn't tell "hey, we want to wake to power off".
This sounds good to me as a user. Yes, if laptop is sleeping we need to wake
it up to continue, the power off is just a next step of this flow.
The  expected hot topic here is the longer presses of power button, but I think
if we have a timer and tell after say 3 second that the K_WUP was up and K_PW
is down is not a solution, it will be always flaky.

Just my 2c.

-- 
With Best Regards,
Andy Shevchenko



