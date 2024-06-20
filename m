Return-Path: <linux-acpi+bounces-6559-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7EEA911347
	for <lists+linux-acpi@lfdr.de>; Thu, 20 Jun 2024 22:34:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 629F5283B17
	for <lists+linux-acpi@lfdr.de>; Thu, 20 Jun 2024 20:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE92D4AEE6;
	Thu, 20 Jun 2024 20:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="Bg8yPHsV"
X-Original-To: linux-acpi@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0EFC3C6AC;
	Thu, 20 Jun 2024 20:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718915674; cv=none; b=p36Fpaywoqzw8NtxCAn0Hk2tTE5sSRFKPSzwi4kbAvtGTvVojSKOONR3TCs6oMLf+a06A2XpyvTNgMZOMSCyvWK0rFh/ug1TBgT+lvhcl9MJBaXfK0bhdf7Dcf27FVyzyGt5N9hJ78vWBFZhZrZeVUOuQt+DFRzDc5mWF6bRAEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718915674; c=relaxed/simple;
	bh=Qjgls1+fDHoSlp8kty5p8JufKc02nlgR5ecC7mawsk4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fl7Lqm8QwF/NhPfZAckoyHOEQOKylt0O0SmTCCxySJViBR/BQM09OeB7pSAKWpDp9a/UgrMyuLh4ygNzjTzopc/g8vaJ9xbqCu4BhPkosTYPEZk4LbSUPbF+lDU0uFPvwR6umwanW5VBhi+djJ+eRPrr7MjuLJ2AdqIOL7OZKLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=Bg8yPHsV; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1718915668;
	bh=Qjgls1+fDHoSlp8kty5p8JufKc02nlgR5ecC7mawsk4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Bg8yPHsVg7YcnTXyQtCFTUNvWfpV80lMIWHE6HVlp//JgZpLevL+72yjpW16OMiea
	 9wfF5ort/6xXLv+beVTMts562W1f+KV7s4t12JykJNG0rb2MbJ6QgowAxk1QZmCbPK
	 BSJ178aUs5djvWTBHYV9DIwT0yqtgki9kKvNtf3E=
Date: Thu, 20 Jun 2024 22:34:28 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Benson Leung <bleung@chromium.org>, 
	Guenter Roeck <groeck@chromium.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>, 
	Tzung-Bi Shih <tzungbi@kernel.org>, chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, Mario Limonciello <mario.limonciello@amd.com>, 
	Dustin Howett <dustin@howett.net>, Stephen Horvath <s.horvath@outlook.com.au>, 
	Rajas Paranjpe <paranjperajas@gmail.com>, linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev, 
	Matt Hartley <matt.hartley@gmail.com>
Subject: Re: [PATCH v4 4/5] power: supply: add ChromeOS EC based charge
 control driver
Message-ID: <933f6510-2496-4ff9-af50-dd3ff35ddffd@t-8ch.de>
References: <20240616-cros_ec-charge-control-v4-0-74d649a9117d@weissschuh.net>
 <20240616-cros_ec-charge-control-v4-4-74d649a9117d@weissschuh.net>
 <syoaiwmmxuz4ai6jomu42kvwocwozpzfbnjhvndlfqi6zkio4x@vrg6hle2httr>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <syoaiwmmxuz4ai6jomu42kvwocwozpzfbnjhvndlfqi6zkio4x@vrg6hle2httr>

Hi Sebastian,

On 2024-06-20 00:24:23+0000, Sebastian Reichel wrote:
> On Sun, Jun 16, 2024 at 09:03:32PM GMT, Thomas Weißschuh wrote:
> > The ChromeOS Embedded Controller implements a command to control charge
> > thresholds and behaviour.
> > 
> > Use it to implement the standard Linux charge_control_start_threshold,
> > charge_control_end_threshold and charge_behaviour sysfs UAPIs.
> > 
> > The driver is designed to be probed via the cros_ec mfd device.
> > 
> > Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> > ---
> 
> Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Thanks!

<snip>

Would you also take a look at patch 5,
"power: supply: cros_charge-control: don't load if Framework control is present"?

I'm still wondering what the best solution for the two different EC APIs
would be. Maybe you have an idea?

In short:

Framework laptops have a downstream charge control API in their EC.
This drivers binds to the upstream CrOS EC APIs, which does work on
Framework laptops.
If the downstream API is used, it overrides the functionality of the
upstream API.

Choices I see:
* Ignore the incompatibility and just load the driver (maybe log something)
* Detect if the downstream API is actively used during probing
  (If enabled by UEFI) and either
  * don't load the driver
  * disable the current downstream API configuration, so the driver works
  * disable the downstream API and take over its configuration into the
    upstream driver
* Detect if the downstream API is present at all and don't load the
  driver (currently implemented)

The problem is that the downstream API is still usable and its usage
would break this driver.
On the other hand, disabling the driver forces users to manually specify
a kernel commandline, preventing most users from actually making use of it.

(For the future I plan on adapting the Framework EC firmware to avoid
this issue, but there is no telling how long it will take and if it is
accepted at all)

Thanks for any ideas,
Thomas

