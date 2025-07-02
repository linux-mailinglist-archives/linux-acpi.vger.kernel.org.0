Return-Path: <linux-acpi+bounces-14937-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D9A2AF4D0B
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Jul 2025 15:09:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09B22174D13
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Jul 2025 13:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BECD326658A;
	Wed,  2 Jul 2025 13:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LLsV31Nn"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB77C1C5D62;
	Wed,  2 Jul 2025 13:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751461713; cv=none; b=cdn3w6DyL7UfthZRe7dCAemsAY9+R2qaaJ4lVfXKhVbQNQX4k/hRuIr/VlPuoyYQD4gbvQrsW4AeKVM6C3Ue9Utw72Am29w2XcMS5ekQRa/ILilfrVMFmm/Jcy1keAiTskZfcMsIVYSyKLuiAYCKxAZF4dqWpbfv94GmMU9CAxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751461713; c=relaxed/simple;
	bh=OiNoLYPohzS6O6OmHodoyDxPsEF4t/bkOwQkU4sWqc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tlXnRTMftWige+LawKqho8FFHkKbxSkqsH3lUPqaeqsP1NA2ObYl9mb1Cj9jQZnEigTINtCgCjD1MDLNHymEwxNVgBzKwptVsRebJLxz3mHy2Z/ntw/SH9dlWuBtUR2L1OKOVJ6kYX3wCadSPCwsHjbSri1HUiEKk9u0h88lbMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LLsV31Nn; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751461712; x=1782997712;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OiNoLYPohzS6O6OmHodoyDxPsEF4t/bkOwQkU4sWqc0=;
  b=LLsV31Nno3+2IxWfKF3b30yhacr5Hhnb52vN0GZKt/O2ghtQ0vOML3Jc
   1z+FGe/QwMaeBFQSan1W/3Q16eYtUgKIQDpdE8Kedxm+hfrUrvD9gG5pV
   o5s4Se2lzsYliD3Ifz3LpdufiRYlUa61Wk99TC2K7/hxegNnh0tLL1zq9
   3Sh8KrDlWDOjXUGOwCduZLLHphIOAqdBGp+xEGX/RKfEY3W7HC6janDcb
   TldqAZD+uGxQtKAdSh58rmcmCMNyfqN267kP/pr3EQsgUg2ucCdriTEwX
   Yc8uO3I9hAjrUBjFxGDuPlI5Bq6sKegOEfNmtszkgYSAdX2MAnIBsNihX
   A==;
X-CSE-ConnectionGUID: 91gHU4C9SiiKJWTyw/Bvqg==
X-CSE-MsgGUID: KkfpCz9/Q0aP58BofifAAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11482"; a="64448818"
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; 
   d="scan'208";a="64448818"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2025 06:08:20 -0700
X-CSE-ConnectionGUID: /OlEb6b5TiuRhsJx8CCehg==
X-CSE-MsgGUID: D+4XGKXZTUG7f6nocLrJWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; 
   d="scan'208";a="159771935"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2025 06:08:14 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uWxC4-0000000BvT0-2jDn;
	Wed, 02 Jul 2025 16:08:08 +0300
Date: Wed, 2 Jul 2025 16:08:08 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Anup Patel <apatel@ventanamicro.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Alexandre Ghiti <alex@ghiti.fr>, Len Brown <lenb@kernel.org>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Rahul Pathak <rpathak@ventanamicro.com>,
	Leyfoon Tan <leyfoon.tan@starfivetech.com>,
	Atish Patra <atish.patra@linux.dev>,
	Andrew Jones <ajones@ventanamicro.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Anup Patel <anup@brainfault.org>, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 10/24] clk: Add clock driver for the RISC-V RPMI clock
 service group
Message-ID: <aGUvOLXXwF8c_czJ@smile.fi.intel.com>
References: <20250702051345.1460497-1-apatel@ventanamicro.com>
 <20250702051345.1460497-11-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250702051345.1460497-11-apatel@ventanamicro.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jul 02, 2025 at 10:43:31AM +0530, Anup Patel wrote:
> 
> The RPMI specification defines a clock service group which can be
> accessed via SBI MPXY extension or dedicated S-mode RPMI transport.
> 
> Add mailbox client based clock driver for the RISC-V RPMI clock
> service group.

Now it looks much better!

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
One nit-pick below.

...

> +/*
> + * rpmi_clk_rates represents the rates format
> + * as specified by the RPMI specification.
> + * No other format conversion(eg. linear_range) is
> + * required to avoid to and fro conversion.

conversion appears twice. I would suggest use this:

 * No other data format (e.g., struct linear_range) is
 * required to avoid to and from conversion.

> + */

-- 
With Best Regards,
Andy Shevchenko



