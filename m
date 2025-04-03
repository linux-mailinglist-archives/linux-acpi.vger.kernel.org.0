Return-Path: <linux-acpi+bounces-12683-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35AC0A7A2FB
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Apr 2025 14:38:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F16851745D4
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Apr 2025 12:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4050824C08A;
	Thu,  3 Apr 2025 12:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m4oI2S6b"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F04935942;
	Thu,  3 Apr 2025 12:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743683887; cv=none; b=JmkrrE5wzNSCrYtIGPYzkWZVSTunbIp46/G1MM/WmSOonkKciIXqCaKz4lglkCKyP+8QAwYDBPl/KM/vRRKLADtWBzqHf4y4OjuC+Dl7J/6xnDe1C4nXdAuaFwFJlEW6Q9XQtnxDI3wsRRI5kT3iNWbvN0OUetGk1hOEiRLtkVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743683887; c=relaxed/simple;
	bh=NLRMsVF3jqOlHjm4CeTwwI0Q/SdgdU8V4yGDILCONBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KuWOdQK0zgjW7FT0pdoi0oTb3QcATgAlECBZx1L7tsjnap0pdydI5wwAINY4JrzNrtGOf3UUIs5dmbeNDRbBCtugV5OVJa8vz1B4XmXOJkSgjKZB5Fkk2yBMub7/UhrPQViF4qUuDdSvaAAskrUxj/5X9S76vpqtiaNopuNUL9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m4oI2S6b; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743683886; x=1775219886;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NLRMsVF3jqOlHjm4CeTwwI0Q/SdgdU8V4yGDILCONBU=;
  b=m4oI2S6bKC5bIJTn2uEu2hPJ+4ckMfZAi0PjbUmSR8blR6MRUHhYZyFs
   xjB+4L04fW2lSqO2SM0Vlt4h519UDQ5QQzG3PpU0fWsjjLMWEwCGkkGuv
   5DVvLXiu2V0MmOqDnqbWBZMAlJ6U4l25KBpDeakyZSQucUNS6iYbDHobV
   qSFOWo8wI3lbI63Sae/fIyeBQYir1dsONGqzgjAvjCDDqsVrqxbBeS4lP
   4LnWkkKEeFX4m/jrhvMBVkL4wLFtDXfYw2U+nsKGHmo6g2VFoBdmSg8yu
   necl/bXwVsPVkgqn20NirTmD8fkzCckxGoWq3/rv+EMzoewMrkbFSNtRq
   Q==;
X-CSE-ConnectionGUID: 09iZ9wUjTgao//Gjae3V2Q==
X-CSE-MsgGUID: aRfcC/LcTZiY+JOtuYIcEw==
X-IronPort-AV: E=McAfee;i="6700,10204,11393"; a="70457422"
X-IronPort-AV: E=Sophos;i="6.15,184,1739865600"; 
   d="scan'208";a="70457422"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2025 05:38:05 -0700
X-CSE-ConnectionGUID: LVx2I6BTSnKfcHKcWm5Wrw==
X-CSE-MsgGUID: DXUb3WQKTHSHnRrIg+WGXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,184,1739865600"; 
   d="scan'208";a="132205912"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa005.jf.intel.com with ESMTP; 03 Apr 2025 05:38:03 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id 468CAEC; Thu, 03 Apr 2025 15:38:00 +0300 (EEST)
Date: Thu, 3 Apr 2025 15:38:00 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, Mika Westerberg <westeri@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH v1 4/5] gpiolib: acpi: Reuse struct acpi_gpio_params in
 struct acpi_gpio_lookup
Message-ID: <20250403123800.GK3152277@black.fi.intel.com>
References: <20250402122301.1517463-1-andriy.shevchenko@linux.intel.com>
 <20250402122301.1517463-5-andriy.shevchenko@linux.intel.com>
 <20250403103506.GJ3152277@black.fi.intel.com>
 <Z-5rJDWaSJd58lTa@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z-5rJDWaSJd58lTa@smile.fi.intel.com>

On Thu, Apr 03, 2025 at 02:04:04PM +0300, Andy Shevchenko wrote:
> On Thu, Apr 03, 2025 at 01:35:06PM +0300, Mika Westerberg wrote:
> > On Wed, Apr 02, 2025 at 03:21:19PM +0300, Andy Shevchenko wrote:
> > > Some of the contents of struct acpi_gpio_lookup repeats what we have
> > > in the struct acpi_gpio_params. Reuse the latter in the former.
> 
> > > +	struct acpi_gpio_params par;
> > 
> > params is better name
> 
> It's been already used elsewhere in the code. Do you want renaming there as
> well for consistency's sake?

If there is no problem confusing these then no need to rename anything
else.

> 
> ...
> 
> > >  	struct acpi_gpio_lookup *lookup = data;
> > > +	struct acpi_gpio_params *par = &lookup->par;
> > 
> > These are not changed I guess so can this be const?
> 
> They are, see below. So the answer, it can't.

Okay then nevermind.

