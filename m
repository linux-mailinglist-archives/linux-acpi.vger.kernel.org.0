Return-Path: <linux-acpi+bounces-5792-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E62858C447B
	for <lists+linux-acpi@lfdr.de>; Mon, 13 May 2024 17:43:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 075611C20AF2
	for <lists+linux-acpi@lfdr.de>; Mon, 13 May 2024 15:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF578153BF5;
	Mon, 13 May 2024 15:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nMKbzLPP"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31DA5695;
	Mon, 13 May 2024 15:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715615022; cv=none; b=gG/gC62CJOrs5urX3JGjb8GxLhdoZfiIFRgC3Kfqvup3zX7Hz79s+Da4h7GPUYBi0epC20riu1GsLbbyMfbAYP91IfMXsEceKXQLhhNEbqr0Ntd9Gv24x8mAjt7guuJp1WeyMig8N6qjz/lpAcFT5EVCVHTyfT9YzlGZ2CvMJHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715615022; c=relaxed/simple;
	bh=J5hQzjcurJJsGoxq8banr21Pa9wy7hpwCT+lAe7WOE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cs7a9rN+DKEjlb0COyBiIYjOQUw80SrFuZiWKsxptnYCxHcaNa/RzmgQ+8RyZoEk0wIwv3h6oMjD6itmJW5zPv46IAQi1/11zfYmGsKk7o5x2/DzO5LcV0t7Jaugb8jXsTK4lT3YqmsH68P4UhumGO4Sz+XSJUFhyIp9L8yS9Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nMKbzLPP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFFD3C113CC;
	Mon, 13 May 2024 15:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715615022;
	bh=J5hQzjcurJJsGoxq8banr21Pa9wy7hpwCT+lAe7WOE0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nMKbzLPPNsLi0Y8bkFTPWjaohdSK+zjR/LvuOiBHGWooKmEZhkO8GY5CGqx69n9SY
	 gmUfcQnR/qlVBTtISjVkp1GIAEX62k9Xhy5MvfgYGpx738kE98QnYt6L4lh8D2UVvY
	 njDTH1JHN7TLogXHGHglAmaOi+2EL6Fl7HL1evq0sj1Eg+m7KOniXC77KHE++f/xFr
	 EmNYfasW0x5ush8kPti6vIYX2O0GXuxKaSCHTN+PV8z0wYb/ez5LtN0E7GW6dvX6vQ
	 KVTiEDh+VA2pizGwAWFZY3iKFc66KeeAMxfYxtyR/K2OgZ5jAila5ho3auBdQSii6o
	 H1+Y30X1MN4Uw==
Date: Mon, 13 May 2024 17:43:37 +0200
From: Benjamin Tissoires <bentiss@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Devyn Liu <liudingyuan@huawei.com>, linus.walleij@linaro.org, 
	brgl@bgdev.pl, f.fangjian@huawei.com, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mika.westerberg@linux.intel.com, linux-acpi@vger.kernel.org, 
	jonathan.cameron@huawei.com, yangyicong@huawei.com, yisen.zhuang@huawei.com, 
	kong.kongxinwei@hisilicon.com
Subject: Re: [PATCH] gpiolib: acpi: Fix failed in acpi_gpiochip_find() by
 adding parent node match
Message-ID: <crpbtmccglgf4mpyt4ogdiqztophoadx34llx6z6lmnbneufju@pwm5j3fwusle>
References: <20240513075901.2030293-1-liudingyuan@huawei.com>
 <ZkHcniqCiLPEPN9o@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZkHcniqCiLPEPN9o@smile.fi.intel.com>

On May 13 2024, Andy Shevchenko wrote:
> On Mon, May 13, 2024 at 03:59:01PM +0800, Devyn Liu wrote:
> > Previous patch modified the standard used by acpi_gpiochip_find()
> > to match device nodes. Using the device node set in gc->gpiodev->d-
> > ev instead of gc->parent.
> > 
> > However, there is a situation in gpio-dwapb where the GPIO device
> > driver will set gc->fwnode for each port corresponding to a child
> > node under a GPIO device, so gc->gpiodev->dev will be assigned the
> > value of each child node in gpiochip_add_data().
> > 
> > gpio-dwapb.c:
> > 128,31 static int dwapb_gpio_add_port(struct dwapb_gpio *gpio,
> > 			       struct dwapb_port_property *pp,
> > 			       unsigned int offs);
> > port->gc.fwnode = pp->fwnode;
> > 
> > 693,39 static int dwapb_gpio_probe;
> > err = dwapb_gpio_add_port(gpio, &pdata->properties[i], i);
> > 
> > When other drivers request GPIO pin resources through the GPIO device
> > node provided by ACPI (corresponding to the parent node), the change
> > of the matching object to gc->gpiodev->dev in acpi_gpiochip_find()
> > only allows finding the value of each port (child node), resulting
> > in a failed request.
> > 
> > Reapply the condition of using gc->parent for match in acpi_gpio-
> > chip_find() in the code can compatible with the problem of gpio-dwapb,
> > and will not affect the two cases mentioned in the patch:
> > 1. There is no setting for gc->fwnode.
> > 2. The case that depends on using gc->fwnode for match.
> 
> Thanks for the report, analysis, and patch.
> 
> ...
> 
> >  static int acpi_gpiochip_find(struct gpio_chip *gc, const void *data)
> >  {
> > -	return device_match_acpi_handle(&gc->gpiodev->dev, data);
> > +	return device_match_acpi_handle(&gc->gpiodev->dev, data) ||
> > +		(gc->parent && device_match_acpi_handle(gc->parent, data));
> >  }

The original patch (from Devyn) is:
Tested-by: Benjamin Tissoires <bentiss@kernel.org>

For reference, a successful run can be seen at:
https://gitlab.freedesktop.org/bentiss/hid/-/jobs/58661693

> 
> I'm wondering if the below approach will work for all:
> 
> static int acpi_gpiochip_find(struct gpio_chip *gc, const void *data)
> {
> 	struct device *dev = acpi_get_first_physical_node(ACPI_COMPANION(&gc->gpiodev->dev));
> 
> 	return device_match_acpi_handle(dev, data);
> }

Looks like I get a bad dev pointer in this situation:
https://gitlab.freedesktop.org/bentiss/hid/-/jobs/58662689#L704

Not sure if this is because the not-yet-upstream patches I have in
hid-cp2112 are doing something wrong or if there is a good reason for
it...

The patch that adds fwnode to hid-cp2112 are:
https://gitlab.freedesktop.org/bentiss/gitlab-kernel-ci/-/blob/master/VM/0002-HID-usbhid-Share-USB-device-firmware-node-with-child.patch
https://gitlab.freedesktop.org/bentiss/gitlab-kernel-ci/-/blob/master/VM/0003-HID-cp2112-Fwnode-Support.patch

both of those patches are applied before compilation in the CI run from
above.

> 
> Cc'ing to Benjamin for testing and commenting.

TL;DR: initial patch is fine, yours will probably need a check on the
dev return value, so not sure if we gain a lot...

Cheers,
Benjamin

