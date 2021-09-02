Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 202A83FEC65
	for <lists+linux-acpi@lfdr.de>; Thu,  2 Sep 2021 12:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245185AbhIBKux (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 2 Sep 2021 06:50:53 -0400
Received: from mga11.intel.com ([192.55.52.93]:28870 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243737AbhIBKuw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 2 Sep 2021 06:50:52 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10094"; a="215932033"
X-IronPort-AV: E=Sophos;i="5.84,372,1620716400"; 
   d="scan'208";a="215932033"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2021 03:49:54 -0700
X-IronPort-AV: E=Sophos;i="5.84,372,1620716400"; 
   d="scan'208";a="521037671"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2021 03:49:52 -0700
Received: from andy by smile with local (Exim 4.95-RC2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mLkI2-00GnO0-3d;
        Thu, 02 Sep 2021 13:49:50 +0300
Date:   Thu, 2 Sep 2021 13:49:50 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jean Delvare <jdelvare@suse.de>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: TPS68470 PMIC config option
Message-ID: <YTCsTvYy+BjttJdX@smile.fi.intel.com>
References: <20210901160234.0e3e24b2@endymion>
 <YS+6xzk9yc8uPetU@smile.fi.intel.com>
 <20210901193251.GZ3@paasikivi.fi.intel.com>
 <20210902115731.2fd22c80@endymion>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210902115731.2fd22c80@endymion>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Sep 02, 2021 at 11:57:31AM +0200, Jean Delvare wrote:
> On Wed, 1 Sep 2021 22:32:51 +0300, Sakari Ailus wrote:
> > On Wed, Sep 01, 2021 at 08:39:19PM +0300, Andy Shevchenko wrote:
> > > On Wed, Sep 01, 2021 at 04:02:34PM +0200, Jean Delvare wrote:  
> > > > Is there a reason why config TPS68470_PMIC_OPREGION is not under "if
> > > > PMIC_OPREGION" where all other *_PMIC_OPREGION driver options are?  
> > > 
> > > It was originally like that.
> > > 
> > > Sakari, do you know?  
> > 
> > The answer can be found in Makefile:
> > 
> > obj-$(CONFIG_PMIC_OPREGION)             += intel_pmic.o
> > 
> > intel_pmic.c seems to contain common functionality for PMICs in Intel SoCs
> > whereas the TPS68470 is an external chip. The two codebases are distinct.
> > 
> > Perhaps it could make sense to either rename this as
> > CONFIG_PMIC_INTEL_OPREGION, or move the TPS68470 driver in and change the
> > Kconfig+Makefile to have the common code compiled if at least one of the
> > drivers is enabled.
> 
> OK, thanks for the explanation I get it now. Yes, the fact that the
> menu looks vendor-neutral while it is about Intel drivers only is
> confusing. Renaming it would help. I'm not sure about your alternative
> proposal as I can't actually see any common code or dependency between
> intel_pmic and tps68470_pmic.
> 
> What about the following?

LGTM,
Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>


-- 
With Best Regards,
Andy Shevchenko


