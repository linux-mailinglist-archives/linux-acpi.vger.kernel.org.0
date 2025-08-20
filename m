Return-Path: <linux-acpi+bounces-15864-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A2F25B2DE40
	for <lists+linux-acpi@lfdr.de>; Wed, 20 Aug 2025 15:48:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 671844E5537
	for <lists+linux-acpi@lfdr.de>; Wed, 20 Aug 2025 13:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70BC417A309;
	Wed, 20 Aug 2025 13:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SlkxVxQX"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95313AC1C;
	Wed, 20 Aug 2025 13:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755697608; cv=none; b=TWjgyj2PxkhffKnN6PJtK8HDJJUt2glDaXUBvO8HAzDfIVgTScBFBh5e0MI5JzMabL+eElEGpfpcMwOyHYTHtiX1/bl/cwTIDzjpFv+92YY0vkTdkYzDNZ0HwMzH5zv8sAJEsO3/BvHJOmCRajUFPPJHhWsOgnHekOs3TZwoVq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755697608; c=relaxed/simple;
	bh=eL6OmjUfcEblm9jH5gM1guK7rt+rufzeVM6JcMHixQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FOzDAxU6RcYNdrOZA0VM3C6diZQZlLpExVhfxeCBf+XstfERRbldA0KSUZ6JLHDrYqexayvmmxb7WdgYkLd1m8HNexkW4mPjCwEDzw8rXGpcapabaZGF53PH8yIl4kpf42aj9Q2Cq8g38kwQ7m5qbZnR1nZyCMtIa8xTjBUl8gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SlkxVxQX; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755697607; x=1787233607;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=eL6OmjUfcEblm9jH5gM1guK7rt+rufzeVM6JcMHixQE=;
  b=SlkxVxQXsKSSw7Ch3LrellylHMS4ecvg+QSebN3NeABJVCk/EpnSBGEt
   pBc8tSiFxnZPVJh8KuLy2uFH901oQCOzoo28CRsUFdWvxS69hsdkQFv23
   Kn6hu0mli9RO/hrj7AiRVy/EnpZkJqFlDpbpDGjGzS8QW1E3sGn5Yor7E
   iKqSxxoCh/MCKW8A/4kctMq/wyH364JAemrHcwbSJJaJmz5ta7q2y4y1C
   E6v16ElpDFgVyCzqmhtvXLeYAjo7tc+MKLwss/6QPFkw+vGlxq0UT+Lyq
   UFaK62kz9MKJ37HNcf9niwNXHwQ7oF9es6qgsrzk3xZDohyRZtdgrq517
   g==;
X-CSE-ConnectionGUID: 6O9OFjRvRVmXhe2cC+RJ8A==
X-CSE-MsgGUID: a01x5E7qRLuQ7PFBWe41bA==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="61791966"
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="61791966"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2025 06:46:44 -0700
X-CSE-ConnectionGUID: QTAel4swTlqBwgC7IBaZrQ==
X-CSE-MsgGUID: wCBv+13xSjKB8AAPAD4/lw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="168081449"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2025 06:46:42 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uoj9D-00000006woZ-37qk;
	Wed, 20 Aug 2025 16:46:39 +0300
Date: Wed, 20 Aug 2025 16:46:39 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: "Mario Limonciello (AMD)" <superm1@kernel.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Mika Westerberg <westeri@kernel.org>,
	"open list:GPIO ACPI SUPPORT" <linux-gpio@vger.kernel.org>,
	"open list:GPIO ACPI SUPPORT" <linux-acpi@vger.kernel.org>,
	"open list:INPUT (KEYBOARD, MOUSE, JOYSTICK, TOUCHSCREEN)..." <linux-input@vger.kernel.org>,
	Amit Chaudhari <amitchaudhari@mac.com>
Subject: Re: [PATCH 1/2] gpiolib: acpi: Add quirk for ASUS ProArt PX13
Message-ID: <aKXRvzPdeKnM2RTS@smile.fi.intel.com>
References: <20250814183430.3887973-1-superm1@kernel.org>
 <CACRpkdba9c9FdJoAufRVEKxXRP-kk5QZusiqxmWoY6D-gK9tYA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdba9c9FdJoAufRVEKxXRP-kk5QZusiqxmWoY6D-gK9tYA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Aug 19, 2025 at 02:16:28PM +0200, Linus Walleij wrote:
> On Thu, Aug 14, 2025 at 8:34 PM Mario Limonciello (AMD)
> <superm1@kernel.org> wrote:
> 
> > The ASUS ProArt PX13 has a spurious wakeup event from the touchpad
> > a few moments after entering hardware sleep.  This can be avoided
> > by preventing the touchpad from being a wake source.
> >
> > Add to the wakeup ignore list.
> >
> > Reported-by: Amit Chaudhari <amitchaudhari@mac.com>
> > Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4482
> > Tested-by: Amit Chaudhari <amitchaudhari@mac.com>
> > Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
> 
> Bartosz is on vacation and this patch series is half-pinctrl so I applied this
> and patch 2/2 for pin control fixes.

I also was on vacation and become to full speed next week. But series is fine,
just one nit-pick I commented on, it can be addressed in a separate followup.

-- 
With Best Regards,
Andy Shevchenko



