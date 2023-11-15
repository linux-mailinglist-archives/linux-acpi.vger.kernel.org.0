Return-Path: <linux-acpi+bounces-1544-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28EE57ED259
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Nov 2023 21:36:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59F021C208CE
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Nov 2023 20:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE7E3446B8
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Nov 2023 20:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UdL+QufB"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336D0433BA;
	Wed, 15 Nov 2023 20:23:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50021C433C8;
	Wed, 15 Nov 2023 20:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700079809;
	bh=gabJ5os+xjeNpC+/5fAtNZcqD3iV33NQ/cAdC59SDeQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UdL+QufB/iE97IKDDSJZF2KstB/Lpihw4KL0t2gZlNHJ+b2qANVNv2SCKm2esd5z1
	 E20NuEUjVbyvsn2OeGfXqvN0KkC5nErJW6Q+G/fGULJPWJQc4xn1F02D23nDlEQvZU
	 Cz2z7YoFN3r58FYxQ5JHOSWLkUHWGUQoafT8ohEU=
Date: Wed, 15 Nov 2023 15:21:29 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	Linus Walleij <linus.walleij@linaro.org>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v1 1/3] device property: Implement device_is_big_endian()
Message-ID: <2023111513-stinky-doorframe-8cd1@gregkh>
References: <20231025184259.250588-1-andriy.shevchenko@linux.intel.com>
 <20231025184259.250588-2-andriy.shevchenko@linux.intel.com>
 <2023102624-moonshine-duller-3043@gregkh>
 <ZTpbMVSdKlOgLbwv@smile.fi.intel.com>
 <ZUPBVMdi3hcTyW2n@smile.fi.intel.com>
 <CAMRc=MeV9ZyOzuQFEE_duPTHYgfmr6UZU6bpjDPhrczZX4PHpg@mail.gmail.com>
 <CAMRc=MdSpk_OszeDCyA5_Sp-w=sL9DHB2gGCOFP+FCiobm2cbA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MdSpk_OszeDCyA5_Sp-w=sL9DHB2gGCOFP+FCiobm2cbA@mail.gmail.com>

On Wed, Nov 15, 2023 at 03:58:54PM +0100, Bartosz Golaszewski wrote:
> On Fri, Nov 3, 2023 at 10:08 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> >
> > On Thu, Nov 2, 2023 at 4:33 PM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > >
> > > On Thu, Oct 26, 2023 at 03:27:30PM +0300, Andy Shevchenko wrote:
> > > > On Thu, Oct 26, 2023 at 07:25:35AM +0200, Greg Kroah-Hartman wrote:
> > > > > On Wed, Oct 25, 2023 at 09:42:57PM +0300, Andy Shevchenko wrote:
> > > > > > Some users want to use the struct device pointer to see if the
> > > > > > device is big endian in terms of Open Firmware specifications,
> > > > > > i.e. if it has a "big-endian" property, or if the kernel was
> > > > > > compiled for BE *and* the device has a "native-endian" property.
> > > > > >
> > > > > > Provide inline helper for the users.
> > > > >
> > > > > Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > >
> > > > Thank you, Greg.
> > > >
> > > > Bart, would it be still possible to take this into next?
> > > > I would like to have at least this patch applied (with the first user)
> > > > to allow conversion of others (I have some more users of new API).
> > >
> > > Okay, seems we missed v6.7 with this, can you then prepare an immutable
> > > branch / tag with this, so other maintainers can pull in case it's needed?
> > > (I have something against tty already and perhaps something else, let's
> > >  see.)
> > >
> >
> > It arrived too late in the cycle, I needed to send my PR earlier this
> > time as I was OoO this week.
> >
> > Bart
> 
> Greg, will you take this patch through your tree and provide me with
> an immutable tag for this cycle?

Sure, let me catch up with patches after I return from Plumbers next
week.

greg k-h

