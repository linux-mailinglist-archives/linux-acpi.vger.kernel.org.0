Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92727102850
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Nov 2019 16:43:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728171AbfKSPnQ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 19 Nov 2019 10:43:16 -0500
Received: from mga17.intel.com ([192.55.52.151]:55414 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727682AbfKSPnP (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 19 Nov 2019 10:43:15 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Nov 2019 07:43:15 -0800
X-IronPort-AV: E=Sophos;i="5.68,324,1569308400"; 
   d="scan'208";a="200388766"
Received: from jnikula-mobl3.fi.intel.com (HELO localhost) ([10.237.66.161])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Nov 2019 07:43:09 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Lee Jones <lee.jones@linaro.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] drm/i915 / LPSS / mfd: Select correct PWM controller to use based on VBT
In-Reply-To: <20191119151818.67531-1-hdegoede@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20191119151818.67531-1-hdegoede@redhat.com>
Date:   Tue, 19 Nov 2019 17:43:07 +0200
Message-ID: <87pnhnyir8.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, 19 Nov 2019, Hans de Goede <hdegoede@redhat.com> wrote:
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

Hans, thanks for your continued efforts in digging into the bottom of
this!

I'm sure there are a number of related bugs still open at fdo bugzilla.

It all makes sense,

Acked-by: Jani Nikula <jani.nikula@intel.com>

for merging through whichever tree.


Thanks,
Jani.


-- 
Jani Nikula, Intel Open Source Graphics Center
