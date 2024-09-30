Return-Path: <linux-acpi+bounces-8491-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66EEA98A0AB
	for <lists+linux-acpi@lfdr.de>; Mon, 30 Sep 2024 13:31:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07A7DB2867D
	for <lists+linux-acpi@lfdr.de>; Mon, 30 Sep 2024 11:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0851718E75B;
	Mon, 30 Sep 2024 11:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eVgAyiAu"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5653518D65B;
	Mon, 30 Sep 2024 11:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727695378; cv=none; b=qmsHpKxjHIDRyhcgtQYuZQIe21/MhEc+c+p1VrhKlF0pO1Sryqhp7LuBQhjH8dsbotW/gnomROjZ1cYSXLpcj+BiR3Ki3HwyLapJ2YPpvMH5EMWNiBZcJ8eybaKDjcAz+Ay31YWkrb+It5sFQ+DU0lEXRrNua7LeQsx/DpHs3UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727695378; c=relaxed/simple;
	bh=B1UEG2bIHGnCoalpBF45lEDeh25ik81KyCRpEnkQIDM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lfL3xd/p9OZTj3rIVjY70BDBUNIoTaGNnCzO25XJSy+BaTbg1XKP1zvN4Z9zayOTecdyZMCM+m3xG7XMlu6tSo9kO/0kNeetibvnXkNcTCt8Uy/ylp10dOse2v5LJuHBBW7jx1RdID35jcivJu1jxEceGVf4Sew9j/HhRe0PyhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eVgAyiAu; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727695377; x=1759231377;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=B1UEG2bIHGnCoalpBF45lEDeh25ik81KyCRpEnkQIDM=;
  b=eVgAyiAulq80eNQKnbwY4MpIOWNyw3pp17v/mavnrgYC7xZZee0jB8nT
   Gle291ISM3olNvftF7xzHd9YSaxt15iTkikXO33Tn4qLwhHyIDA+twzLO
   PP0E+WvmBgVn1T/iCekcy+Tj0vLByy3sP9+Sh8jCxPzPnvm/G70t+4q/m
   3InQxkPpIB0j7H2FEK2XtP6Iezp9RpAvkuOYYaPRiMs6lfl3LlVOtvDtY
   vgcFz0/AXU6x24Ym8xqRfoCzy7am01iazlk14159obko9Vq1VFed6geM8
   CshvZy96aciAYeRy9+CxataxJCDn644QXc+5MjAEkTZOsPws1oeAg1t5L
   w==;
X-CSE-ConnectionGUID: Vxw7boAaREW8uzROBpLtuQ==
X-CSE-MsgGUID: PvHMB0N7TECQEQoTTiyuAw==
X-IronPort-AV: E=McAfee;i="6700,10204,11210"; a="26874675"
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="26874675"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 04:22:57 -0700
X-CSE-ConnectionGUID: CDffiT0YR22PwAq5DpXiaw==
X-CSE-MsgGUID: np1WDrtGS4SgVHSnNYvgbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="72869507"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 04:22:55 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1svEUO-0000000Edb1-0auZ;
	Mon, 30 Sep 2024 14:22:52 +0300
Date: Mon, 30 Sep 2024 14:22:51 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Hoan Tran <hoan@os.amperecomputing.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: Re: [PATCH 2/3] gpio: sim: switch to
 device_for_each_child_node_scoped()
Message-ID: <ZvqKC1OBl4B2vkpf@smile.fi.intel.com>
References: <20240928-gpio_device_for_each_child_node_scoped-v1-0-c20eff315f4f@gmail.com>
 <20240928-gpio_device_for_each_child_node_scoped-v1-2-c20eff315f4f@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240928-gpio_device_for_each_child_node_scoped-v1-2-c20eff315f4f@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sat, Sep 28, 2024 at 09:47:36PM +0200, Javier Carrasco wrote:
> Switch to device_for_each_child_node_scoped() to simplify the code by
> removing the need for a call to fwnode_handle_put() in the error path.
> 
> This also prevents possible memory leaks if new error paths are added
> without the required call to fwnode_handle_put().

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



