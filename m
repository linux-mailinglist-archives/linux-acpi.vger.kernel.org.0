Return-Path: <linux-acpi+bounces-11091-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28CE2A323CB
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Feb 2025 11:46:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0129165188
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Feb 2025 10:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F9741FCFF2;
	Wed, 12 Feb 2025 10:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZC7aKLme"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF802AF19;
	Wed, 12 Feb 2025 10:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739357197; cv=none; b=HSsf3axcwsI/r4AVqBmOoMyX08sQ/66daB7xM/jyCOa8Tl2s+KZjsy/5LJ9udBjebzS///tgyJjI0eBmlZHy9afeVwJ38GGgpSrvIwYm6j5e94Pvckq0Xc5XmJh1Yed34n2AW/tYcVk8mA5sqJBzQv/FNqqo/gSS4xF1aqwZhZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739357197; c=relaxed/simple;
	bh=ODbnclSY3LR9KpwCFhYSaDBnzqSzIyKsMqRNqOXAPjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GcS3/09vFKQ40b0YGxsSR5MFzuqS7SfLJBojNEUjNjHRtMFSspXjyWgIaq9I0TV6XlM/XF5T5I4WohS8YOakZjhuX0TWmEcSRsOw6Hf+i6XWFcKaANugm+63aL8STSsLpN6WPw/YaKc/CR1f6IZ83J6GcIWyYg/070NOxqqjJGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZC7aKLme; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739357196; x=1770893196;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ODbnclSY3LR9KpwCFhYSaDBnzqSzIyKsMqRNqOXAPjM=;
  b=ZC7aKLmeQjobrF9DqtKspFGmLOiSGP7HIu9vluhUI67F0cN0Y4LQMnR5
   XdxZmv2MtFD/l5aS1iE+9nhZN+lpomR37d4NK0I2WCBw3/Q4ax4mDAI1V
   dLu65/Ud9DOMydgaEpyTa4J+HgwqBVm/aNwajafF4f3X+O9LgclDAnIF7
   Kepbw2Qk+WFBsjupCYLcOw+AqcexPfSJecfV92qBybnUqjGTVWAfFdT7O
   d5eMZXgx5gZECvN9htmFoza+aweSB2PJTEy+HaXMusaYBm6+vtAso6SOI
   FyfeWq8IMI6CWPSN4Hy2ieEHdHtd820HrFJ33AQJSzRqARmHAPxe+6TG6
   Q==;
X-CSE-ConnectionGUID: zfQu473BT9Gm5RYqHBg8aw==
X-CSE-MsgGUID: nSq2VWytQQSehHcwFIG5uQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="39710583"
X-IronPort-AV: E=Sophos;i="6.13,279,1732608000"; 
   d="scan'208";a="39710583"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 02:46:36 -0800
X-CSE-ConnectionGUID: TGg3wbbkQgaVoMSQBy5hgg==
X-CSE-MsgGUID: h5/nJTE6SNOAWC3yBz6oFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="113282741"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 02:46:33 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tiAGE-0000000Ao7P-3MqD;
	Wed, 12 Feb 2025 12:46:30 +0200
Date: Wed, 12 Feb 2025 12:46:30 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mario Limonciello <superm1@kernel.org>
Cc: mario.limonciello@amd.com, westeri@kernel.org, linus.walleij@linaro.org,
	brgl@bgdev.pl, stable@vger.kernel.org, Delgan <delgan.py@gmail.com>,
	linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH] gpiolib: acpi: Add a quirk for Acer Nitro ANV14
Message-ID: <Z6x8BvavGHz8qMP3@smile.fi.intel.com>
References: <20250211203222.761206-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250211203222.761206-1-superm1@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Feb 11, 2025 at 02:32:01PM -0600, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> Spurious immediate wake up events are reported on Acer Nitro ANV14. GPIO 11 is
> specified as an edge triggered input and also a wake source but this pin is
> supposed to be an output pin for an LED, so it's effectively floating.
> 
> Block the interrupt from getting set up for this GPIO on this device.
> 
> Cc: stable@vger.kernel.org
> Reported-and-tested-by: Delgan <delgan.py@gmail.com>
> Close: https://gitlab.freedesktop.org/drm/amd/-/issues/3954

Closes:

Otherwise,
Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



