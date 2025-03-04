Return-Path: <linux-acpi+bounces-11782-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23F2BA4E1E5
	for <lists+linux-acpi@lfdr.de>; Tue,  4 Mar 2025 15:56:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C165B17FB76
	for <lists+linux-acpi@lfdr.de>; Tue,  4 Mar 2025 14:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F6A3207E09;
	Tue,  4 Mar 2025 14:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lR0gjoXU"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3CC209F53;
	Tue,  4 Mar 2025 14:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741099700; cv=none; b=ZZoFJzoZ4ntSrYU1RtKLVMZCEyf7Xibl4Eojkw1d1SYMpRGb4tKxJpsTZeBJjCsy6H6iJzVwOdenYwNJ3Ap2bC/eXwaba2bMBkSg76g9yWm28J1TqxgR3XNnTUsOFyF3r0WTuoaBA0tBkC7OD2J732NLlftvY04Qa3go7va/Bbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741099700; c=relaxed/simple;
	bh=k1ckIey+2NlpLqg108DENKYpTY1iX9uvVNFDKYvBX9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HGlNIhLJq5OZSC8i7VAohNqwH+HNz031e7cYjDnTYra4+ckFVtxvYnq+4PUlyDu0zeJ73Es2fj7lZpSGSpz7MK8uX2Yc32ZjZearqEZDn4fy5aZmCaa1wlXVB9gzEMcEcbTJuQTx3x9FiH8gFEoGqbHY8hd/ah6PfRlra9Vos1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lR0gjoXU; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741099699; x=1772635699;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=k1ckIey+2NlpLqg108DENKYpTY1iX9uvVNFDKYvBX9I=;
  b=lR0gjoXU9nEfKhy7ZJXS5x5zRqk1dLrVxwgeuvlYOi0Dd3CTZlul0Lop
   FV7NIGKPaZ/aAkpZvYDhBEMFwXVCjRNtoLAGAxLrXO3QX9rkuWAHd8jsA
   OhO/rTKKVXB6lAITNvko16yH5PRqKo1NZMbD/yGRmIicX782E9OODsBlv
   CyZ8l1l5j7y5SV7XzSTpbgN9TVqo0M9muSMraKfldJytTLUryn0MECHJR
   YBBpEtpZEhCBxhym0UEOiqA4LDZQ/bGcW1HNpsXkEVylUzYa1nkKdc7bF
   UQN1cOSIVvKtmQcY5UiAk2CD1uz+aciS5W7sgo/j4J2+7PwTTOStJ837p
   g==;
X-CSE-ConnectionGUID: GurSrxMJSPa0eqg2uuwB5Q==
X-CSE-MsgGUID: 6aNL9RFkRHCp7COsdis7cw==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="52664057"
X-IronPort-AV: E=Sophos;i="6.14,220,1736841600"; 
   d="scan'208";a="52664057"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 06:48:18 -0800
X-CSE-ConnectionGUID: ZXInoYppSfO/CvZ5qBiBvg==
X-CSE-MsgGUID: XSwBiwRiQbaiq88vmRfJEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,220,1736841600"; 
   d="scan'208";a="118396815"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 06:48:16 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tpTZ7-0000000H9cW-0SYO;
	Tue, 04 Mar 2025 16:48:13 +0200
Date: Tue, 4 Mar 2025 16:48:12 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, Mika Westerberg <westeri@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH v1 1/1] gpiolib-acpi: Drop unneeded ERR_CAST() in
 __acpi_find_gpio()
Message-ID: <Z8cSrHc6bZ3Jqc0A@smile.fi.intel.com>
References: <20250304143119.1816463-1-andriy.shevchenko@linux.intel.com>
 <20250304143648.GN3713119@black.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304143648.GN3713119@black.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Mar 04, 2025 at 04:36:48PM +0200, Mika Westerberg wrote:
> On Tue, Mar 04, 2025 at 04:31:19PM +0200, Andy Shevchenko wrote:
> > The checked type by PTR_ERR() is the same as returned by __acpi_find_gpio().
> > Hence there is no need to cast, drop it.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Acked-by: Mika Westerberg <westeri@kernel.org>

Pushed to my review and testing queue, thanks!

-- 
With Best Regards,
Andy Shevchenko



