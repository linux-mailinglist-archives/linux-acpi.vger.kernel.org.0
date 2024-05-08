Return-Path: <linux-acpi+bounces-5654-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57ACF8BF9B8
	for <lists+linux-acpi@lfdr.de>; Wed,  8 May 2024 11:44:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D7631C2166C
	for <lists+linux-acpi@lfdr.de>; Wed,  8 May 2024 09:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97CA77B3F3;
	Wed,  8 May 2024 09:43:56 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2315F763EE
	for <linux-acpi@vger.kernel.org>; Wed,  8 May 2024 09:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715161436; cv=none; b=fo15GivJkVSZN9fI3ncUPNLi0gIwbFwIcSFZJQB3nD6eYCOdVJ+Iewm90lr6PP0CHlBVeoSP/vTuwoJCBFpZ5m3BxfIEkyKEDD2dgIweqiySAJqtRaiuMFvUGsOW95HXv8lzzZmSPd4S4JmEgyxr0yPC/ZwWOuXg77wf1Wnc4qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715161436; c=relaxed/simple;
	bh=Ik4juSJPP8I5eSQh6vO6XlGDWGLzp8rHEWMnoMKOT7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QM4+2cRjUf8kLbF+km9XvMMDhg7E77/eQPHsOyccYjsWLqWS8y+4eaM3/voPMyDgfUyZBWARNK4tWCAYkiEwhActJvqA6vOY4TWwSF6zIVjq63bY7cPLvZegqboIgTLH4t+blqbgtAHqVp6fwLHMN7kI8UHNFtcLdLB8yYUrvP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: NG47kxW9SCOYNVmMQHBVJQ==
X-CSE-MsgGUID: vR2VR7v4TX+4AtLXh5fFSw==
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="33517473"
X-IronPort-AV: E=Sophos;i="6.08,144,1712646000"; 
   d="scan'208";a="33517473"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 02:43:54 -0700
X-CSE-ConnectionGUID: q1l2JDPuRz+gSBlcrUunaA==
X-CSE-MsgGUID: 6xbV7Gk9Q/G8eHLLT62seQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,144,1712646000"; 
   d="scan'208";a="59690254"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 02:43:53 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andy@kernel.org>)
	id 1s4dq2-00000005Neo-2Tuu;
	Wed, 08 May 2024 12:43:50 +0300
Date: Wed, 8 May 2024 12:43:50 +0300
From: Andy Shevchenko <andy@kernel.org>
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: Hans de Goede <hdegoede@redhat.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	linux-acpi@vger.kernel.org, AceLan Kao <acelan.kao@canonical.com>
Subject: Re: [RFC 0/2] ACPI: Adding new acpi_driver type drivers ?
Message-ID: <ZjtJVpWvNuusC_O9@smile.fi.intel.com>
References: <20240218151533.5720-1-hdegoede@redhat.com>
 <CAAd53p6h3G-eHO=va11_YEODtmnpfxqhXpQ1xw3ZAKa3X5-ayQ@mail.gmail.com>
 <98f6e530-1f1b-4c4e-9f70-2f8dff74575b@redhat.com>
 <CAAd53p4r=+fUkmUm9dQWDm4uYhm7rgMESTtv=zZer5RB5oiHRw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAd53p4r=+fUkmUm9dQWDm4uYhm7rgMESTtv=zZer5RB5oiHRw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, May 08, 2024 at 12:42:05PM +0800, Kai-Heng Feng wrote:
> [+Cc AceLan]
> On Wed, Apr 24, 2024 at 5:58 PM Hans de Goede <hdegoede@redhat.com> wrote:
> > On 4/24/24 10:04 AM, Kai-Heng Feng wrote:
> > > On Sun, Feb 18, 2024 at 11:15 PM Hans de Goede <hdegoede@redhat.com> wrote:
> > >>
> > >> Hi Rafael,
> > >>
> > >> I recently learned that some Dell AIOs (1) use a backlight controller board
> > >> connected to an UART. Canonical even submitted a driver for this in 2017:
> > >> https://lkml.org/lkml/2017/10/26/78
> > >>
> > >> This UART has a DELL0501 HID with CID set to PNP0501 so that the UART is
> > >> still handled by 8250_pnp.c. Unfortunately there is no separate ACPI device
> > >> with an UartSerialBusV2() resource to model the backlight-controller.
> > >>
> > >> The RFC patch 2/2 in this series uses acpi_quirk_skip_serdev_enumeration()
> > >> to still create a serdev for this for a backlight driver to bind to
> > >> instead of creating a /dev/ttyS0.
> > >>
> > >> Like other cases where the UartSerialBusV2() resource is missing or broken
> > >> this will only create the serdev-controller device and the serdev-device
> > >> itself will need to be instantiated by the consumer (the backlight driver).
> > >>
> > >> Unlike existing other cases which use DMI modaliases to load on a specific
> > >> board to work around brokeness of that board's specific ACPI tables, the
> > >> intend here is to have a single driver for all Dell AIOs using the DELL0501
> > >> HID for their UART, without needing to maintain a list of DMI matches.
> > >>
> > >> This means that the dell-uart-backlight driver will need something to bind
> > >> to. The original driver from 2017 used an acpi_driver for this matching on
> > >> and binding to the DELL0501 acpi_device.
> > >>
> > >> AFAIK you are trying to get rid of having drivers bind directly to
> > >> acpi_device-s so I assume that you don't want me to introduce a new one.
> > >> So to get a device to bind to without introducing a new acpi_driver
> > >> patch 2/2 if this series creates a platform_device for this.
> > >>
> > >> The creation of this platform_device is why this is marked as RFC,
> > >> if you are ok with this solution I guess you can merge this series
> > >> already as is. With the caveat that the matching dell-uart-backlight
> > >> driver is still under development (its progressing nicely and the
> > >> serdev-device instantation + binding a serdev driver to it already
> > >> works).
> > >
> > > I was about to work on this and found you're already working on it.
> > >
> > > Please add me to Cc list when the driver is ready to be tested, thanks!
> >
> > I hope you have access to actual hw with such a backlight device ?
> >
> > The driver actually has been ready for testing for quite a while now,
> > but the person who reported this backlight controller not being
> > supported to me has been testing this on a AIO of a friend of theirs
> > and this has been going pretty slow.
> >
> > So if you can test the driver (attached) then that would be great :)
> >
> > I even wrote an emulator to test it locally and that works, so
> > assuming I got the protocol right from the original posting of
> > the driver for this years ago then things should work.
> >
> > Note this depends on the kernel also having the patches from this
> > RFC (which Rafael has already merged) applied.
> 
> There are newer AIO have UID other than 0, like "SIOBUAR2".
> 
> Once change the "0" to NULL in 'get_serdev_controller("DELL0501", "0",
> 0, "serial0");', everything works perfectly.
> 
> With that change,
> Tested-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

Do we have tables with _UID set to 0?
If so, we would need more complex approach.

-- 
With Best Regards,
Andy Shevchenko



