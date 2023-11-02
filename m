Return-Path: <linux-acpi+bounces-1166-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A627F7DF7CE
	for <lists+linux-acpi@lfdr.de>; Thu,  2 Nov 2023 17:36:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D64AF1C20F5F
	for <lists+linux-acpi@lfdr.de>; Thu,  2 Nov 2023 16:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 423591DDC6
	for <lists+linux-acpi@lfdr.de>; Thu,  2 Nov 2023 16:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="09E3HOS+"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F311D53C
	for <linux-acpi@vger.kernel.org>; Thu,  2 Nov 2023 15:58:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 319BCC433C7;
	Thu,  2 Nov 2023 15:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1698940737;
	bh=TZxJFL5OibED8+/9pa412vgNlmClfWKXxC9WGoztNWY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=09E3HOS+W4nL+5nkvv9jyfGBRlFy+24B88zNuHEqR0IJZpeYbhhwHhLi8PkyEQuhp
	 JuEMlTj2za4RQvRx13msamnOU497gjP3BWlyQ9NENFROLoQSNH2yHvKS48al+oNKQA
	 xfko74CFww1olV7l7vIBj/k8lpJRKHqlxm51juQM=
Date: Thu, 2 Nov 2023 16:58:53 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v1 1/3] device property: Implement device_is_big_endian()
Message-ID: <2023110235-viewless-postage-9832@gregkh>
References: <20231025184259.250588-1-andriy.shevchenko@linux.intel.com>
 <20231025184259.250588-2-andriy.shevchenko@linux.intel.com>
 <2023102624-moonshine-duller-3043@gregkh>
 <ZTpbMVSdKlOgLbwv@smile.fi.intel.com>
 <ZUPBVMdi3hcTyW2n@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZUPBVMdi3hcTyW2n@smile.fi.intel.com>

On Thu, Nov 02, 2023 at 05:33:40PM +0200, Andy Shevchenko wrote:
> On Thu, Oct 26, 2023 at 03:27:30PM +0300, Andy Shevchenko wrote:
> > On Thu, Oct 26, 2023 at 07:25:35AM +0200, Greg Kroah-Hartman wrote:
> > > On Wed, Oct 25, 2023 at 09:42:57PM +0300, Andy Shevchenko wrote:
> > > > Some users want to use the struct device pointer to see if the
> > > > device is big endian in terms of Open Firmware specifications,
> > > > i.e. if it has a "big-endian" property, or if the kernel was
> > > > compiled for BE *and* the device has a "native-endian" property.
> > > > 
> > > > Provide inline helper for the users.
> > > 
> > > Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > 
> > Thank you, Greg.
> > 
> > Bart, would it be still possible to take this into next?
> > I would like to have at least this patch applied (with the first user)
> > to allow conversion of others (I have some more users of new API).
> 
> Okay, seems we missed v6.7 with this, can you then prepare an immutable
> branch / tag with this, so other maintainers can pull in case it's needed?
> (I have something against tty already and perhaps something else, let's
>  see.)

After -rc1 is out, I'll look into it, can't do anything until then,
sorry...

greg k-h

