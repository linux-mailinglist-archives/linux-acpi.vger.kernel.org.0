Return-Path: <linux-acpi+bounces-15863-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70F52B2DE56
	for <lists+linux-acpi@lfdr.de>; Wed, 20 Aug 2025 15:51:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99A0D3B2CEA
	for <lists+linux-acpi@lfdr.de>; Wed, 20 Aug 2025 13:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0026C1F419B;
	Wed, 20 Aug 2025 13:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gxZRn8eh"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7073A1F3FE9;
	Wed, 20 Aug 2025 13:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755697548; cv=none; b=KJPOe20bTS0R2sT1frOeO8q6lSupJ6lDgwfOtDuFMC3CsWvs0qoRS488AvBNOFk4Ikt9vFo8daN68lEVwMESJ+ocbsypP7IPP2OMZMU4GqsDB4k/sQ1UNttAjSZ3u9cFla+kntnZ2DWR5eT/f04XMkixcBL8pYSKqzUz8zdY2wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755697548; c=relaxed/simple;
	bh=KB389P5zGZixe5hfLj+DpXfe0Qy5zYKDG0TlJN07gjg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J6JjPCnexBz91MeKBfQXqlsFg30DU48EYRLGXJI33gC+fBP5WSkxR+VHEslx2+uc9tK4BR8hNd9/K439rxzlXQjyqfLjuaydvK0NUFrXQklIUvRzGUWma5Iljv4SRbiiMn+q9fcbyZ82urjJIzOTBP+B7qQzl3uUX3U8tigbjIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gxZRn8eh; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755697547; x=1787233547;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KB389P5zGZixe5hfLj+DpXfe0Qy5zYKDG0TlJN07gjg=;
  b=gxZRn8ehVUW8r4heRLrlBfTHp4MMPmI8mTXf2ikC2Cf+l+tZjRN4rFky
   D63ytA3fOgmIgQDF6TcxZ/OHt0tf0DQGeaB1+A7i38pg5aYlXzC5vaej9
   2edRZJ7Rz2DXl6Vvyz+/NSizGQHvLmxYgfyu+UsUymFjXyn91ESyB0Pfm
   micwD8EDXRr2zy6OjmU/tGFsjIRVvoN5/dUbdElVB53vNZKD87E+NoPBH
   ckIKIlNv8wJ/r+yGjMBuspDmBd+Emxv7dcBW1AnYtoIbl5OY9XdCKDpwm
   QIdfvqlxxEkuKPViG+OpB9ItF1nKq5xHx1WO0N0vUNHQ2E9TLGD87WXlk
   w==;
X-CSE-ConnectionGUID: /yL9mUFXQ76yube3BTZsfw==
X-CSE-MsgGUID: d3pBlengQHCph4ynG4RdEg==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="68669822"
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="68669822"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2025 06:45:47 -0700
X-CSE-ConnectionGUID: K3jXF4fcSJON5mGJl9S7lg==
X-CSE-MsgGUID: /Y6YfdDNSmGHZ7moZsE4iA==
X-ExtLoop1: 1
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2025 06:45:45 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uoj8I-00000006wnv-2dxz;
	Wed, 20 Aug 2025 16:45:42 +0300
Date: Wed, 20 Aug 2025 16:45:42 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Mario Limonciello (AMD)" <superm1@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Mika Westerberg <westeri@kernel.org>,
	"open list:GPIO ACPI SUPPORT" <linux-gpio@vger.kernel.org>,
	"open list:GPIO ACPI SUPPORT" <linux-acpi@vger.kernel.org>,
	"open list:INPUT (KEYBOARD, MOUSE, JOYSTICK, TOUCHSCREEN)..." <linux-input@vger.kernel.org>
Subject: Re: [PATCH 2/2] pinctrl: amd: Add PM debugging message for turning
 on/off wakes
Message-ID: <aKXRhvJK1NoETu_L@smile.fi.intel.com>
References: <20250814183430.3887973-1-superm1@kernel.org>
 <20250814183430.3887973-2-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814183430.3887973-2-superm1@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Aug 14, 2025 at 01:34:30PM -0500, Mario Limonciello (AMD) wrote:
> The GPIOs for devices not in _AEI/_EVT such as touchpad or touchscreen
> won't have wakeup turned on until the suspend sequence starts.
> 
> Due to code in amd_gpio_suspend_hibernate_common() masking the interrupt
> can make this difficult to follow what's going on.  Add an explicit
> debugging message to tell when that was turned on/off.

...

> +	pm_pr_dbg("Setting wake for GPIO %lu to %s\n",
> +		   d->hwirq, str_enable_disable(on));

Can you send a follow up to move from dereference to an API for hwirq?


-- 
With Best Regards,
Andy Shevchenko



