Return-Path: <linux-acpi+bounces-12396-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20452A6B974
	for <lists+linux-acpi@lfdr.de>; Fri, 21 Mar 2025 12:05:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1A12167008
	for <lists+linux-acpi@lfdr.de>; Fri, 21 Mar 2025 11:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0056221569;
	Fri, 21 Mar 2025 11:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DcbIOsiH"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B96921B8F6;
	Fri, 21 Mar 2025 11:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742555002; cv=none; b=D5V7XsHM8WYVrWu9C6ox1jdV9J5fgwXNhEY+LavMf7uKhJycSrDz+YRbNwukfb/xnvYv1XyyNbV6eDv8G7vcDn7ka7qErI95sNoqNAXfIEmIH8tuKE7WsuExegn14vmfEDFjydyJ7StvJymJEIacgV8Or6VQdQAW6BXltzB95IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742555002; c=relaxed/simple;
	bh=dnGJFip3baBzMZ60dxk3ll/ELydDcUMKz9tdidQK0e0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g/LIqyF5KM4ECJkDoG0IwKvGKGIvQpjIBOsMSAfCSomHY4oC8jwjSSSB0qKUrrytAI17gliT07Sph4GNso8B6Kyd9UYgxddRYvBtFzF6epy1ogsVLrJIAJBJH0chEdCe0mCPE0Zs6XO6nhPWZcQHrmNCuQ+LsS+aNkQRWTMoaYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DcbIOsiH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C0E9C4CEE3;
	Fri, 21 Mar 2025 11:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742555001;
	bh=dnGJFip3baBzMZ60dxk3ll/ELydDcUMKz9tdidQK0e0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DcbIOsiHKVUcIwiMJC7jOgFvkGQITxiWdt+RNBLbkOzYwoZ6a5P/q9bItvrC/A/50
	 KCfEHXqCiipeCHQHwwnggU3D8k+TnCM54NLemAmkDtJSUQeHOb0zT2E8/P60XAdaN5
	 izJR68KM6pi6TSfLad+Bj+NFp/tVZqQUZIobflECwJW+A7FKzAaQVJgyvqaVMdAZcS
	 IpqY4w/lYqOHspKEROqo6lmtjtJn98niRdKc28YAygY0KYyH4IaP+ru8SWUbUhtm48
	 7Rc7vVg3TNtS8UvwQ4uJhc9MRGzxPuH1WVqjvcbVeGLSWIEzwHB7mwjjURpw3KXZ3S
	 ft0NkNEwC0ZXg==
Date: Fri, 21 Mar 2025 11:03:15 +0000
From: Lee Jones <lee@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rob Herring (Arm)" <robh@kernel.org>,
	Markus Elfring <elfring@users.sourceforge.net>,
	Jakob Riepler <jakob+lkml@paranoidlabs.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-leds@vger.kernel.org, linux-usb@vger.kernel.org,
	Daniel Scally <djrscally@gmail.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, Pavel Machek <pavel@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v1 0/4] leds: Introduce and use
 fwnode_get_child_node_count()
Message-ID: <20250321110315.GH1750245@google.com>
References: <20250310150835.3139322-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250310150835.3139322-1-andriy.shevchenko@linux.intel.com>

On Mon, 10 Mar 2025, Andy Shevchenko wrote:

> This series was inspired during review of "Support ROHM BD79124 ADC" [1].
> The three conversion patches are the examples of the new API in use.
> 
> Since the first two examples of LEDS, in case of posotove response it may
> be routed via that tree and immutable branch/tag shared with others, e.g.,
> IIO which Matti's series is targeting and might be dependent on. The USB
> patch can be applied later separately, up to the respective maintainers.
> 
> Link: https://lore.kernel.org/r/cover.1741610847.git.mazziesaccount@gmail.com> [1]
> 
> Andy Shevchenko (4):
>   device property: Split fwnode_get_child_node_count()
>   leds: pwm-multicolor: Use fwnode_get_child_node_count()
>   leds: ncp5623: Use fwnode_get_child_node_count()
>   usb: typec: tcpm: Use fwnode_get_child_node_count()
> 
>  drivers/base/property.c                | 12 ++++++------
>  drivers/leds/rgb/leds-ncp5623.c        |  5 ++---
>  drivers/leds/rgb/leds-pwm-multicolor.c |  7 +++----
>  drivers/usb/typec/tcpm/tcpm.c          |  6 ++----
>  include/linux/property.h               |  7 ++++++-
>  5 files changed, 19 insertions(+), 18 deletions(-)

Note to self: This has everything we need.  Merge it for v6.16.

-- 
Lee Jones [李琼斯]

