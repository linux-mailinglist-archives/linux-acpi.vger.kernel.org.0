Return-Path: <linux-acpi+bounces-14695-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 626B9AEA0F8
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Jun 2025 16:42:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF1CB5A4EB5
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Jun 2025 14:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 006D02ED87D;
	Thu, 26 Jun 2025 14:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rxqy48p1"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3442EB5B4;
	Thu, 26 Jun 2025 14:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750948442; cv=none; b=FBIv7OuRLKiPTfv9ATAXS0SyRdfTXkIC7C/pKjExM2KrGVGJ20Sf0jKfGxFedkiagu5WRpCl4AiQn9zLNcv+RhzBFde5n0N0jnbMyZIUMoE7EJ6ntfxjeZLEEs+EBwarqmrxAzXrsMpS8lOWzUw0vNIvSzqHysmO5Ty1NY1FIMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750948442; c=relaxed/simple;
	bh=xej6AQs5tkI/jQAFxSeQKq+f2GY61NJLaNlLTM9NbVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pO6PzgTqfwJ0pMRFliu9a2J1HQWq2dVWptUYL8gy1LFF2RwKphwx21pNqnfzwGoPS6z0d8qQDoWBhcV5UD0HnudVJfeqPKL+sdqNfvKmNCPhSwMAXxe3OeLhVtl8BfyEvsMsy0gkrT9CRkJSFvpiJWgV54ibY7HXSN3FApHuO9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rxqy48p1; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750948438; x=1782484438;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xej6AQs5tkI/jQAFxSeQKq+f2GY61NJLaNlLTM9NbVw=;
  b=Rxqy48p1yGnEzhysYicVNB+dyrki4/qopCOHqZBRi3rdlrKJj/d4Pye5
   sX0ZWoh2zcTuT8saEczyJkv81ejXCyC+YjkKNx7ElB4ZFWyjioxbwIKGI
   gIbYcRPMhPvgcrksIKn578wn11RPcmrNqO0FVPbQnmrI2NpcBDq1FdKWD
   HKtg0PHiVG4ePPj9B9hnV+YKt7LY04EDbkkY6sj9KX6f2n6jhFtN4OW7e
   wSgocsZZmXRl9neFI+es6G3EW+O7nGXmNXr3Q6LR3Ex/u1sudbPUx5Ysz
   Q28qiCRVj7Cm9KhaCphW+mmdsaAPrlc7ukaCEoRBnThqD700+V6LevzZp
   A==;
X-CSE-ConnectionGUID: QLD26Q+aS5qjHUGs5DV/Iw==
X-CSE-MsgGUID: NT4hwiMjReGuV1VkSLtuvg==
X-IronPort-AV: E=McAfee;i="6800,10657,11475"; a="53119200"
X-IronPort-AV: E=Sophos;i="6.16,267,1744095600"; 
   d="scan'208";a="53119200"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2025 07:33:57 -0700
X-CSE-ConnectionGUID: +1QKEstmTVuOGFn0EnpavA==
X-CSE-MsgGUID: /8qtWYBtQrGuIeO1r3TJEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,267,1744095600"; 
   d="scan'208";a="183561957"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2025 07:33:53 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uUnfj-0000000ACX3-0ebO;
	Thu, 26 Jun 2025 17:33:51 +0300
Date: Thu, 26 Jun 2025 17:33:50 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mario Limonciello <superm1@kernel.org>
Cc: Hans de Goede <hansg@kernel.org>, Mika Westerberg <westeri@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	"open list:GPIO ACPI SUPPORT" <linux-gpio@vger.kernel.org>,
	"open list:GPIO ACPI SUPPORT" <linux-acpi@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:INPUT (KEYBOARD, MOUSE, JOYSTICK, TOUCHSCREEN)..." <linux-input@vger.kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH v3 3/4] Input: Don't program hw debounce for
 soc_button_array devices
Message-ID: <aF1aThiXUFhHxlZO@smile.fi.intel.com>
References: <20250625215813.3477840-1-superm1@kernel.org>
 <20250625215813.3477840-4-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250625215813.3477840-4-superm1@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jun 25, 2025 at 04:58:12PM -0500, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> Programming a hardware debounce of 50ms causes problems where a button
> doesn't work properly anymore on some systems.  This debounce is intended
> for compatibility with systems with a mechanical switch so soc_button_array
> devices should only be using a sofware debounce.
> 
> Add support for indicating that a driver is only requesting gpio_keys
> to use software debounce support and mark that in soc_button_array
> accordingly.

...

> +	gpio_keys_pdata->no_hw_debounce = TRUE;

true

-- 
With Best Regards,
Andy Shevchenko



