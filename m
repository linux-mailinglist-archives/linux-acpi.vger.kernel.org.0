Return-Path: <linux-acpi+bounces-14697-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 967CEAEA108
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Jun 2025 16:44:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20A1C17FE67
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Jun 2025 14:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F12C2EE61F;
	Thu, 26 Jun 2025 14:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TrFQVPbR"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9EC02ECD2C;
	Thu, 26 Jun 2025 14:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750948643; cv=none; b=Ql+VfrXcHfQo20CoLXhXlK2OIXA+9sT5WVMungK1ubwRoviSY1tnTmZDsEjma/NI8Pil9QNuif3XcV/KybH+hlhx3UrxEEBge/Kr9hyrDirFPOGnR8N40bR2w6iuG6z9RZ/1Q4zPKOi5boH6sL43ymfQO5rDQtofTD6Y0R76Sm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750948643; c=relaxed/simple;
	bh=NxspAoNyokDJVuVkJA3OkEjJxiU2hmlP1GfVPqK6t08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q11F1tF1ZKsUTAe52Ly725uKI0PUFPU0sZJI1Dqu/QKSwM1gH+Ljfya29XgSG9hfWIMuhMT4xCPXb1dDoYcKRIYeJekoL57mP6zQCKoZzDBndBcT3jJvW7tpJYvdC5Nbgc+sbHTNi7ATf0DyQJKL5c+F2TtUEytXaZ33kxK/Y6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TrFQVPbR; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750948642; x=1782484642;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NxspAoNyokDJVuVkJA3OkEjJxiU2hmlP1GfVPqK6t08=;
  b=TrFQVPbRmG1+zOv4oTKGy9h6WkfDBr8FKkAX6MVCGrowgBlTSsNEx7AU
   9qldsC943dtYASzF9y5zx2jEgm2xld/4YyZjEm+voQ+RdH7STK3KNWoTS
   VBlEaqqQ4JGzVAh/BLuvsp0fzM3AAb3nuB8ThTGj01sacHygZ6KWWLR7a
   QTDLCS8WL6C9HqJbRJ3rvpLabaIz6J0IDH2TSsHDsjwvRmj9aDarOTXj7
   A5jY2n3fONNOMYW24j4VfDWf0EcUly8l+TjPGaKLYpllLNI621wsEDaqy
   jhrVBVjpFfHZe3BUk+tXwdRmO/xHmrdihKyVNsR24nN3ZT3ONRzfDlq28
   A==;
X-CSE-ConnectionGUID: bm7Na1hMSvS7tWOd5kowwA==
X-CSE-MsgGUID: +M2mkHwmQtOr/Df7XgxIJA==
X-IronPort-AV: E=McAfee;i="6800,10657,11475"; a="78683810"
X-IronPort-AV: E=Sophos;i="6.16,267,1744095600"; 
   d="scan'208";a="78683810"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2025 07:37:21 -0700
X-CSE-ConnectionGUID: 9Oryxw0GSdmVgxDaM5Fquw==
X-CSE-MsgGUID: IlPyYfhbTHeNVMymZroxrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,267,1744095600"; 
   d="scan'208";a="153274867"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2025 07:37:18 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uUnj1-0000000ACZ6-3RbH;
	Thu, 26 Jun 2025 17:37:15 +0300
Date: Thu, 26 Jun 2025 17:37:15 +0300
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
Subject: Re: [PATCH v3 4/4] Input: Don't send fake button presses to wake
 system
Message-ID: <aF1bG_iCMpYUhQj0@smile.fi.intel.com>
References: <20250625215813.3477840-1-superm1@kernel.org>
 <20250625215813.3477840-5-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250625215813.3477840-5-superm1@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jun 25, 2025 at 04:58:13PM -0500, Mario Limonciello wrote:
> 
> Sending an input event to wake a system does wake it, but userspace picks
> up the keypress and processes it.  This isn't the intended behavior as it
> causes a suspended system to wake up and then potentially turn off if
> userspace is configured to turn off on power button presses.
> 
> Instead send a PM wakeup event for the PM core to handle waking the system.

It seems the Subject is incorrect WRT the pattern used in input subsystem
(in this and in the previous patches).

Should be something like: Input: $driver - $summary

where $driver and $summary the exact driver name and summary you want to put.

-- 
With Best Regards,
Andy Shevchenko



