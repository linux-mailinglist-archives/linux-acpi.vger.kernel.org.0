Return-Path: <linux-acpi+bounces-12239-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBA6DA61196
	for <lists+linux-acpi@lfdr.de>; Fri, 14 Mar 2025 13:40:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6FC3882ABF
	for <lists+linux-acpi@lfdr.de>; Fri, 14 Mar 2025 12:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D46B61FF1DB;
	Fri, 14 Mar 2025 12:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UXdFeT/U"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5ADB1FF1D7;
	Fri, 14 Mar 2025 12:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741955924; cv=none; b=mdc77gIpigRACTNtvPhvfx1ea5hM3x83d7EEmRUrLzf89nQMw9Bc2Q29K+I/E/9AKEi7EjQcxW3dgPUoED77UzsXQu068g4L2EmnFaG1Z0yuxNTgPUIJz774mpE0cXyzR4FodN0kvgRsL7kU9D8GewSbKY5JWU6xwrXzhfxRlGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741955924; c=relaxed/simple;
	bh=DJufqgG1qpP+BO+nmANaDfx563WohqASVbzA0uYrDAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BcAaEnDkDsJYpF9BZQi97cMAu7NuJ6/YQ0FNv4Xkd4SbOiJ1fY4ztkhbg2J4vt5A5nULl5COyBEI4u3wxDs+P6dmVqAKCsYEdvQO1feDLLqAyXeXrNrU9RACbHcAwnAE/x6Xe0klEZnk8SUbgsiOFaV3vYNRTdx85hI+FQSc3wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UXdFeT/U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEBD2C4CEF0;
	Fri, 14 Mar 2025 12:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741955924;
	bh=DJufqgG1qpP+BO+nmANaDfx563WohqASVbzA0uYrDAo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UXdFeT/UMJut3kEQPKrGWf9dZUlrk5GrB61hyJQUZHH6CGRIA1qYeOLkF62QOiI8s
	 2DEHcqHSBlHiUp6QJGjVmw3zOkvHdY8GTAOjEnDq5LWazyRFpD9aSq2i7Xok4thlhx
	 dTk90YNyANpW3EtO6uq06caZux8hGc3Zxgb/LQ/h0FfwsSJbn7O9tn9WhjWvjx62dI
	 pc2QvUKo5J00p3SfoKAhcosrE/qyJWU8OKqJGqmdWs0AzPD9UgAHSQIme+ymiQm5UM
	 GoOtEAwxZaNvwbCLzOesc+TdlygDMed5wKMibTOfh+61K/yHe85pivYPJdNF01xMdJ
	 AJSjkQ4CgeWiQ==
Date: Fri, 14 Mar 2025 12:38:38 +0000
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
Message-ID: <20250314123838.GN3890718@google.com>
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

What's the proposed merge strategy here Andy?

-- 
Lee Jones [李琼斯]

