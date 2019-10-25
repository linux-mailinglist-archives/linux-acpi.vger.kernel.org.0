Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19089E44D5
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Oct 2019 09:48:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437249AbfJYHsN (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 25 Oct 2019 03:48:13 -0400
Received: from mga04.intel.com ([192.55.52.120]:42380 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727275AbfJYHsN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 25 Oct 2019 03:48:13 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Oct 2019 00:48:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,227,1569308400"; 
   d="scan'208";a="349954678"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga004.jf.intel.com with ESMTP; 25 Oct 2019 00:48:09 -0700
Received: from andy by smile with local (Exim 4.92.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1iNuKP-0001e9-Ew; Fri, 25 Oct 2019 10:48:09 +0300
Date:   Fri, 25 Oct 2019 10:48:09 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Lee Jones <lee.jones@linaro.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] ACPI / PMIC: Add byt prefix to Crystal Cove PMIC
 OpRegion driver
Message-ID: <20191025074809.GB32742@smile.fi.intel.com>
References: <20191024213827.144974-1-hdegoede@redhat.com>
 <20191024213827.144974-3-hdegoede@redhat.com>
 <20191025074154.GX32742@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191025074154.GX32742@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Oct 25, 2019 at 10:41:54AM +0300, Andy Shevchenko wrote:
> On Thu, Oct 24, 2019 at 11:38:25PM +0200, Hans de Goede wrote:
> > Our current Crystal Cove OpRegion driver is only valid for the
> > Crystal Cove PMIC variant found on Bay Trail (BYT) boards,
> > Cherry Trail (CHT) based boards use another variant.
> > 
> > At least the regulator registers are different on CHT and these registers
> > are one of the things controlled by the custom PMIC OpRegion.
> > 
> > Commit 4d9ed62ab142 ("mfd: intel_soc_pmic: Export separate mfd-cell
> > configs for BYT and CHT") has disabled the intel_pmic_crc.c code for CHT
> > devices by removing the "crystal_cove_pmic" MFD cell on CHT devices.
> > 
> > This commit renames the intel_pmic_crc.c driver and the cell to be
> > prefixed with "byt" to indicate that this code is for BYT devices only.
> > 
> > This is a preparation patch for adding a separate PMIC OpRegion
> > driver for the CHT variant of the Crystal Cove PMIC (sometimes called
> > Crystal Cove Plus in Android kernel sources).
> 
> >  .../acpi/pmic/{intel_pmic_crc.c => intel_pmic_bytcrc.c}    | 4 ++--
> >  drivers/mfd/intel_soc_pmic_crc.c                           | 2 +-
> 
> I would go with previously established pattern, i.e. intel_pmic_bytcc.c.

That said you may use mine
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> 
> > +++ b/drivers/mfd/intel_soc_pmic_crc.c
> > @@ -75,7 +75,7 @@ static struct mfd_cell crystal_cove_byt_dev[] = {
> >  		.resources = gpio_resources,
> >  	},
> >  	{
> > -		.name = "crystal_cove_pmic",
> > +		.name = "byt_crystal_cove_pmic",
> >  	},
> >  	{
> >  		.name = "crystal_cove_pwm",
> 
> I'm wondering shouldn't we rename the PWM and GPIO for the sake of consistency?
> Yes, if a driver is used on both CHT and BYT, let it provide two names.
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

-- 
With Best Regards,
Andy Shevchenko


