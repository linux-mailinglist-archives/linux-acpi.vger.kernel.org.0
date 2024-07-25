Return-Path: <linux-acpi+bounces-7054-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 821E193C6C4
	for <lists+linux-acpi@lfdr.de>; Thu, 25 Jul 2024 17:48:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CAA91F25F69
	for <lists+linux-acpi@lfdr.de>; Thu, 25 Jul 2024 15:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 493CA19D89C;
	Thu, 25 Jul 2024 15:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DCA3QYTE"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1168F18028;
	Thu, 25 Jul 2024 15:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721922502; cv=none; b=Qm6RUUJJOBYmZ1ezJi4or741sJnfSqOG/m4qypUJKYnheT+t9ZwPepb2Fyg56Obs9kceMJCfQWEKcrvJpDF7oCulqW5yyL2CSVw0zbAbMfYqHSCgrkp17i9r3StRaBVTG0NpiecRb4HcXX2O1ByzKtWcAU9W3tYu10fE1zCoh7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721922502; c=relaxed/simple;
	bh=FLTJ7x08G9e+q6Iydwv973CWTvKTcuWdEIk3gHa7gXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PYm/TN83rVuZJva8iTTtF8c1e66/7xclS/CQ3R+lOPheq4dRkLO+sA1VZc2aySlmHKR2PPVpxIFncdnZtpESey6ac5OMNo4lZg2sfPOGYHUehRslH11jYSnK/xAiHcNPUulSdx2llHRrX1B4fha2sjcWtRn0F8YdDm5ZNFUVfuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DCA3QYTE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB77CC116B1;
	Thu, 25 Jul 2024 15:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721922501;
	bh=FLTJ7x08G9e+q6Iydwv973CWTvKTcuWdEIk3gHa7gXc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DCA3QYTEwh31gVhDB+a/iAG0lmZiwqo1s2DpqJPvihGjKrs1NHXpI/EYqfsq0df1B
	 qKJ/Dvk1OSL/tGK9P3WaR8rGLYHtnDNSGEdZv+PvAYukRRVlDgitqPQuewcBa1d9Ll
	 uuea7a5aRox86ofp7pCfY3uvgcTLprGeINO0YweIQ1Fi2+kz3VLR11hR6hQC1tdBPl
	 LHwFmOKg8hFYNnyDWj+o7ZgpHcgw3ncuKjrgO9wvcZt2V4ylsXm1p5HwJ2e2Yqkyji
	 5Nx83IC9IBy1SHY+RIMC0EyInmyZoYOoie7zcxV45wlQDzKx4Jr3Dj/j9t5q011Np7
	 8doYYw8IEX8JQ==
Date: Thu, 25 Jul 2024 16:48:13 +0100
From: Lee Jones <lee@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>, Pavel Machek <pavel@ucw.cz>,
	Marcin Wojtas <marcin.s.wojtas@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andreas Kemnade <andreas@kemnade.info>, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
	linux-leds@vger.kernel.org, netdev@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 0/6] use device_for_each_child_node() to access device
 child nodes
Message-ID: <20240725154813.GI501857@google.com>
References: <20240721-device_for_each_child_node-available-v2-0-f33748fd8b2d@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240721-device_for_each_child_node-available-v2-0-f33748fd8b2d@gmail.com>

On Sun, 21 Jul 2024, Javier Carrasco wrote:

> This series aims to clarify the use cases of:
> 
> - device_for_each_child_node[_scoped]()
> - fwnode_for_each_available_child_node[_scoped]()
> 
> to access firmware nodes.
> 
> There have been multiple discussions [1][2] about what the first macro
> implies in the sense of availability, and a number of users have opted
> for the second macro in cases where the first one should have been
> preferred.
> 
> The second macro is intended to be used over child nodes of a firmware
> node, not direct child nodes of the device node. Instead, those users
> retrieve the fwnode member from the device struct just to have access to
> a macro that explicitly indicates node availability.
> 
> That workaround is not necessary because `device_for_each_child_node()`
> implies availability for the existing backends (ACPI, DT, swnode).
> 
> This series does not cover other points discussed in [2] like addressing
> uses of `fwnode_for_each_child_node()` where `device_*` should have been
> used, using the `_avaialble_` variant of the fwnode loop whenever
> possible, or adding new `_scoped` macros. Such points will be covered by
> subsequent series to keep focus on the "availability" issue.
> 
> The conversion has been validated with an LTC2992 hwmon sensor, which is
> one of the affected drivers. The rest of the drivers could only be
> compiled and checked with static-analysis tools.
> 
> Link: https://lore.kernel.org/all/20211205190101.26de4a57@jic23-huawei/ [1]
> Link: https://lore.kernel.org/all/20240523-fwnode_for_each_available_child_node_scoped-v2-0-701f3a03f2fb@gmail.com/ [2]
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---
> Changes in v2:
> - [1/6] property.h: drop "if found" from the description of
>   device_for_each_child_node()
> - [3/6] bd2607mvv.c: fix child node usage.
> - Link to v1: https://lore.kernel.org/r/20240706-device_for_each_child_node-available-v1-0-8a3f7615e41c@gmail.com
> 
> ---
> Javier Carrasco (6):
>       device property: document device_for_each_child_node macro
>       hwmon: (ltc2992) use device_for_each_child_node_scoped() to access child nodes
>       leds: bd2606mvv: fix device child node usage in bd2606mvv_probe()
>       leds: is31fl319x: use device_for_each_child_node_scoped() to access child nodes
>       leds: pca995x: use device_for_each_child_node() to access device child nodes
>       net: mvpp2: use device_for_each_child_node() to access device child nodes
> 
>  drivers/hwmon/ltc2992.c                         | 19 ++++----------
>  drivers/leds/leds-bd2606mvv.c                   | 23 ++++++++---------
>  drivers/leds/leds-is31fl319x.c                  | 34 ++++++++-----------------
>  drivers/leds/leds-pca995x.c                     | 15 ++++-------
>  drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 13 +++-------
>  include/linux/property.h                        | 10 ++++++++
>  6 files changed, 45 insertions(+), 69 deletions(-)
> ---
> base-commit: 41c196e567fb1ea97f68a2ffb7faab451cd90854
> change-id: 20240701-device_for_each_child_node-available-1c1eca4b6495

fatal: bad object 41c196e567fb1ea97f68a2ffb7faab451cd90854

And the LED patches do not apply to LED.

Please rebase onto -next.

-- 
Lee Jones [李琼斯]

