Return-Path: <linux-acpi+bounces-17529-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAD30BB5EE1
	for <lists+linux-acpi@lfdr.de>; Fri, 03 Oct 2025 06:54:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24A7D3C6B55
	for <lists+linux-acpi@lfdr.de>; Fri,  3 Oct 2025 04:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 580581E834F;
	Fri,  3 Oct 2025 04:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AzLBbP1A"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320161547EE;
	Fri,  3 Oct 2025 04:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759467278; cv=none; b=V0WrE8m0kjDgl+P/EafzDImaTcgbMQMyH9B49iRYuV0SVS+6bRA/GyioxqT5I3mFkMjddRz7mse8BrXGhXKfK/K3cd5ue9jWIeBWvbZXbJ+5hkaFuWxalLG8wmZXN5zx3hgGF0A8g7Lmh2MZHTcoKPMlq8dd+L0tzeq32O8gR+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759467278; c=relaxed/simple;
	bh=fVzDhdiuZ0I8KofZ1ITv4SgXW0yFAeLo9kX/WXd7/ZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yl0+uIYc0W1O1lBkjgy8XUfuBqKf9jHZXP9kDW+WtPpEXR/fSlNxV4+3xTb5Xe3UPoJ92ahMVP1wFbYJrmQUIUnlQTKQy154X7JOJ665y/FQ1Qbc578CSMtiThAXWHWt8MvNMHD+Aj1UpbzVWAin8mmU5Ys7ToEwlvf2LEx315s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AzLBbP1A; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759467276; x=1791003276;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fVzDhdiuZ0I8KofZ1ITv4SgXW0yFAeLo9kX/WXd7/ZI=;
  b=AzLBbP1AMvYBQYMaQYnL3QhGQXsOuNXF/OL3lKdlDsLnizFpZHs92aFj
   NrVNYSHMyDofMXDweKLKUITCP2G33/bdJW4Mma+5wY3ucYB1B27EsdSd5
   aLNObmv7qFtvGanKCeNqvdqFR5ZoDyu7BT9Oe68bKEN4gFFYw8dns/f3q
   GY6FdHUkn9Zk9P43V5l+2tm7aXgtfTHgV3ciEwDKJ99UFmD5XFKggLGxO
   tqEjeHB05Px3HlYaW+KNQFwc/l2eOvC7wh7qFj34gdq83BTJaMddXXCCq
   rGBSOmrGAVzC0o1Bz4tbjO8X9RF5xu2/Wf+dWgBESo01Xbxi6ICebgyj5
   Q==;
X-CSE-ConnectionGUID: JkUeY+C/QIaKwzmPhq6Pfg==
X-CSE-MsgGUID: HTfCcecOTLe8ZEtcjKMIkg==
X-IronPort-AV: E=McAfee;i="6800,10657,11570"; a="64367267"
X-IronPort-AV: E=Sophos;i="6.18,311,1751266800"; 
   d="scan'208";a="64367267"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2025 21:54:35 -0700
X-CSE-ConnectionGUID: onFewDEASoqT3LdBmm/MCg==
X-CSE-MsgGUID: 356vVtU/QwipN43w7XVtcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,311,1751266800"; 
   d="scan'208";a="209886780"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa002.jf.intel.com with ESMTP; 02 Oct 2025 21:54:33 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id E2AAC95; Fri, 03 Oct 2025 06:54:31 +0200 (CEST)
Date: Fri, 3 Oct 2025 06:54:31 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Markus Probst <markus.probst@posteo.de>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Mika Westerberg <westeri@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpio: of: make it possible to reference gpios probed in
 acpi in device tree
Message-ID: <20251003045431.GA2912318@black.igk.intel.com>
References: <20251002215759.1836706-1-markus.probst@posteo.de>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251002215759.1836706-1-markus.probst@posteo.de>

Hi,

On Thu, Oct 02, 2025 at 09:58:05PM +0000, Markus Probst wrote:
> sometimes it is necessary to use both acpi and device tree to declare
> devices. Not every gpio device driver which has an acpi_match_table has
> an of_match table (e.g. amd-pinctrl). Furthermore gpio is an device which
> can't be easily disabled in acpi and then redeclared in device tree, as
> it often gets used by other devices declared in acpi (e.g. via GpioInt or
> GpioIo). Thus a disable of acpi and migration to device tree is not always
> possible or very time consuming, while acpi by itself is very limited and
> not always sufficient. This won't affect most configurations, as most of
> the time either CONFIG_ACPI or CONFIG_OF gets enabled, not both.

Can you provide a real example where this kind of mixup can happen? The
ACPI ID PRP0001 specifically was added to allow using DT bindings in ACPI
based systems.

Regarding the patch, please spell gpio -> GPIO, acpi ACPI and so on.

> Signed-off-by: Markus Probst <markus.probst@posteo.de>
> ---
>  drivers/gpio/gpiolib-of.c | 241 +++++++++++++++++++++++---------------
>  1 file changed, 145 insertions(+), 96 deletions(-)
> 
> diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
> index 37ab78243fab..c472b86148b3 100644
> --- a/drivers/gpio/gpiolib-of.c
> +++ b/drivers/gpio/gpiolib-of.c
> @@ -18,6 +18,7 @@
>  #include <linux/pinctrl/pinctrl.h>
>  #include <linux/slab.h>
>  #include <linux/string.h>
> +#include <linux/acpi.h>

I'm not really sure if this is good idea to be honest.

