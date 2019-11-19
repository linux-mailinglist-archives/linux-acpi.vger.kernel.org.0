Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F51510296E
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Nov 2019 17:32:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728128AbfKSQcW (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 19 Nov 2019 11:32:22 -0500
Received: from mga12.intel.com ([192.55.52.136]:31364 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727299AbfKSQcW (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 19 Nov 2019 11:32:22 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Nov 2019 08:32:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,218,1571727600"; 
   d="scan'208";a="381065906"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga005.jf.intel.com with ESMTP; 19 Nov 2019 08:32:17 -0800
Received: from andy by smile with local (Exim 4.93-RC1)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1iX6QK-0007p2-7T; Tue, 19 Nov 2019 18:32:16 +0200
Date:   Tue, 19 Nov 2019 18:32:16 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Ville =?iso-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Lee Jones <lee.jones@linaro.org>,
        linux-acpi@vger.kernel.org,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] drm/i915 / LPSS / mfd: Select correct PWM controller
 to use based on VBT
Message-ID: <20191119163216.GI32742@smile.fi.intel.com>
References: <20191119151818.67531-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191119151818.67531-1-hdegoede@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Nov 19, 2019 at 04:18:15PM +0100, Hans de Goede wrote:
> Hi All,
> 
> This series needs to be merged through a single tree, to keep things
> bisectable. I have even considered just squashing all 3 patches into 1,
> but having separate commits seems better, but that does lead to an
> intermediate state where the backlight sysfs interface will be broken
> (and fixed 2 commits later). See below for some background info.
> 
> The changes to drivers/acpi/acpi_lpss.c and drivers/mfd/intel_soc_pmic_core.c
> are quite small and should not lead to any conflicts, so I believe that
> it would be best to merge this entire series through the drm-intel tree.
> 
> Lee, may I have your Acked-by for merging the mfd change through the
> drm-intel tree?
> 
> Rafael, may I have your Acked-by for merging the acpi_lpss change through the
> drm-intel tree?
> 

Entire series (or a single patch) makes sense to me.
Thanks for fixing this old hardware!

FWIW,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Regards,
> 
> Hans
> 
> p.s.
> 
> The promised background info:
> 
> We have this long standing issue where instead of looking in the i915
> VBT (Video BIOS Table) to see if we should use the PWM block of the SoC
> or of the PMIC to control the backlight of a DSI panel, we rely on
> drivers/acpi/acpi_lpss.c and/or drivers/mfd/intel_soc_pmic_core.c
> registering a pwm with the generic name of "pwm_backlight" and then the
> i915 panel code does a pwm_get(dev, "pwm_backlight").
> 
> We have some heuristics in drivers/acpi/acpi_lpss.c to not register the
> lookup if a Crystal Cove PMIC is presend and the mfd/intel_soc_pmic_core.c
> code simply assumes that since there is a PMIC the PMIC PWM block will
> be used. Basically we are winging it.
> 
> Recently I've learned about 2 different BYT devices:
> Point of View MOBII TAB-P800W
> Acer Switch 10 SW5-012
> 
> Which use a Crystal Cove PMIC, yet the LCD is connected to the SoC/LPSS
> PWM controller (and the VBT correctly indicates this), so here our old
> heuristics fail.
> 
> This series renams the PWM lookups registered by the LPSS /
> intel_soc_pmic_core.c code from "pwm_backlight" to "pwm_soc_backlight" resp.
> "pwm_pmic_backlight" and in the LPSS case also dropping the heuristics when
> to register the lookup. This combined with teaching the i915 panel to call
> pwm_get for the right lookup-name depending on the VBT bits resolves this.
> 

-- 
With Best Regards,
Andy Shevchenko


