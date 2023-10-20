Return-Path: <linux-acpi+bounces-790-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13FC57D0FBB
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Oct 2023 14:36:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C392D28019B
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Oct 2023 12:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C00A1A5BD
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Oct 2023 12:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="STaAb8g5"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9D217996
	for <linux-acpi@vger.kernel.org>; Fri, 20 Oct 2023 10:38:22 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFA2F114;
	Fri, 20 Oct 2023 03:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697798300; x=1729334300;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=n2cOUeXLOnt7d3XcD9ICk5Zxiu/d4trpmElUizd98rw=;
  b=STaAb8g5ilcT8fvVlFWc4iTwGzvZh/dPiITmbiXzh7xCiRq+08FNpXdF
   YzaXrGD79YaWDI/UJgZOst7iMXm5sEqvDe5V53haSoRu9MPGiBa2lRG/J
   xQgaHW/I6SIsixV8MbLkP9BUBqLTwGM+XBSo4HG/Yfuvnqr6rj6DjzamI
   yLxgFyopfDXSuuZG+14/3YEj+FrDoGPICwkF1Wdb3ZVpJ+/4v4yliA8Fx
   ReNolGSuZS9t12gcX/5LYaVo306JDl4OdY7bAdGgTqNIcdz3uPYWTos6I
   uOjOR8VIdZSprje0X8TRwaNGpYTcb4cBK0uNPMXRT8KApe1Q1IwDA2rDU
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="365811457"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="365811457"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 03:38:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="750877602"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="750877602"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 03:37:57 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1qtmt8-000000077fK-2AQo;
	Fri, 20 Oct 2023 13:37:54 +0300
Date: Fri, 20 Oct 2023 13:37:54 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Raag Jadav <raag.jadav@intel.com>
Cc: rafael@kernel.org, len.brown@intel.com, robert.moore@intel.com,
	mika.westerberg@linux.intel.com, mark.rutland@arm.com,
	will@kernel.org, linux@roeck-us.net, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	acpica-devel@lists.linuxfoundation.org, linux-gpio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-hwmon@vger.kernel.org,
	mallikarjunappa.sangannavar@intel.com, bala.senthil@intel.com
Subject: Re: [PATCH v1 5/8] ACPI: x86: use acpi_dev_uid_match() for matching
 _UID
Message-ID: <ZTJYgnugWHwBhtxv@smile.fi.intel.com>
References: <20231020084732.17130-1-raag.jadav@intel.com>
 <20231020084732.17130-6-raag.jadav@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231020084732.17130-6-raag.jadav@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Oct 20, 2023 at 02:17:29PM +0530, Raag Jadav wrote:
> Convert manual _UID references to use standard ACPI helpers.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

...

> -			if (!adev->pnp.unique_id ||
> -			    strcmp(adev->pnp.unique_id, override_status_ids[i].uid))
> +			if (!acpi_dev_uid_match(adev, override_status_ids[i].uid))

The check for NULL argument inside that API does not affect the behaviour as
otherwise it will be a crash with the current implementation.

>  				continue;


-- 
With Best Regards,
Andy Shevchenko



