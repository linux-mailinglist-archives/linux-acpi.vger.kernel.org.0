Return-Path: <linux-acpi+bounces-4239-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AA4B877D36
	for <lists+linux-acpi@lfdr.de>; Mon, 11 Mar 2024 10:49:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C31A1C21211
	for <lists+linux-acpi@lfdr.de>; Mon, 11 Mar 2024 09:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A890022313;
	Mon, 11 Mar 2024 09:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iCrI5jWa"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3CA208C8
	for <linux-acpi@vger.kernel.org>; Mon, 11 Mar 2024 09:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710150531; cv=none; b=rCmw7kGQZRBlXq35EOqMp5swiwzOyjW6aTkEafSEwffpIT1iUp8tY9WG9TwRZiVCfHeptjoKwzgqtUcWMPuY56/Y3kc5pLmvToF4J8HnyMGmmGTD1TQPIV/B1InZRobD0eiWvK4ATmFlBkv+ULYuFR50F78cd/UN0bQ9XSXcFoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710150531; c=relaxed/simple;
	bh=ZVZzb9k/oGOy7V8mIzyWoSmGoCb+BSj/8dDrm/Ju5qU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M701gubYQSdoFo1DrAfWxPxCC6LIOJwbO3pFM380qdseBQo3KZjWe8g2cmqG0N2JOdCNVLkzqPd8e/vHZduoeif51Vlir/jJ1RZvQOZXjug/9gGw79UTZtVqzOn944hB7tBDPROzseYUYtC//7Yo7/YYJ1DqwYiflH+Jin/HWOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iCrI5jWa; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710150530; x=1741686530;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZVZzb9k/oGOy7V8mIzyWoSmGoCb+BSj/8dDrm/Ju5qU=;
  b=iCrI5jWafyCzLjNyWy8DdAoLkMWWDlhH5Yg0TN8eFiQZ0s6sEI7Chqp7
   6p6FBgtMsIm6LxTllWK3C4yHNX9v+zfQz1ol5N4auYH8r5heRT2/DGPzr
   7BcFFf6q4aO+6peRWHrsQ6oAcV6ZbnButRmN3WzroSqOQyHrZ0qcmayug
   MSvXTGcfv7BXHVrIWKFRZzK8Ipb5cbuvQONyTNnmhe52oP/2wbc0Xisef
   mgqVfBBGfS7BXYdvzC6aFWBpzE3WxKizVd0qO623sfTdvPnrK2AvCx+VY
   ELLnPHKfNt8feb677kGn+blDm4HoDBucnTvx6jIzZodtMguRt+/QFCMHk
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11009"; a="8619171"
X-IronPort-AV: E=Sophos;i="6.07,116,1708416000"; 
   d="scan'208";a="8619171"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2024 02:48:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11009"; a="914354233"
X-IronPort-AV: E=Sophos;i="6.07,116,1708416000"; 
   d="scan'208";a="914354233"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2024 02:48:47 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rjcGz-0000000BaFW-1OzV;
	Mon, 11 Mar 2024 11:48:45 +0200
Date: Mon, 11 Mar 2024 11:48:44 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Cezary Rojewski <cezary.rojewski@intel.com>
Cc: rafael@kernel.org, linux-acpi@vger.kernel.org, robert.moore@intel.com,
	amadeuszx.slawinski@linux.intel.com,
	pierre-louis.bossart@linux.intel.com
Subject: Re: [PATCH v6 2/4] ACPI: NHLT: Introduce API for the table
Message-ID: <Ze7TfGVvdEg8rZ1A@smile.fi.intel.com>
References: <20240308073240.2047932-1-cezary.rojewski@intel.com>
 <20240308073240.2047932-3-cezary.rojewski@intel.com>
 <ZesU9QXtM2n2eiZ1@smile.fi.intel.com>
 <dd7b08f4-2513-4b35-8364-2227780632ff@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd7b08f4-2513-4b35-8364-2227780632ff@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sat, Mar 09, 2024 at 11:39:40AM +0100, Cezary Rojewski wrote:
> On 2024-03-08 2:39 PM, Andy Shevchenko wrote:
> > On Fri, Mar 08, 2024 at 08:32:38AM +0100, Cezary Rojewski wrote:

...

> > + acpi.h ?

> > > +#include <linux/export.h>
> > 
> > + errno.h
> > 
> > + minmax.h
> > 
> > + printk.h
> > + types.h
> > 
> > > +#include <acpi/nhlt.h>

...

> > > +#if IS_ENABLED(CONFIG_ACPI_NHLT)
> > 
> > + kconfig.h ?
> > 
> > > +#endif /* CONFIG_ACPI_NHLT */
> 
> Which tool helps you find out these? I want it too!

My brain and my experience.

Actually you can do it yourself much better than me (as the author of
the code). Just read the code and check each constant and function for
the header that provides it.

> While I'll add the headers mentioned here, it feels weird to include
> primitives such as errno.h or minmax.h. Majority of C-files found in the
> kernel utilize such primitives yet the number of includes for these when
> looking at the kernel as a whole is low.

Which does NOT mean they are good examples.

> Is there a "common defs" header in kernel? Looking for an equivalent of
> 'build-essentials' package.

No, there is a mess only.

-- 
With Best Regards,
Andy Shevchenko



