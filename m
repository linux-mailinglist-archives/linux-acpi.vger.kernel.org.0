Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 422113FED9B
	for <lists+linux-acpi@lfdr.de>; Thu,  2 Sep 2021 14:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344210AbhIBMQd (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 2 Sep 2021 08:16:33 -0400
Received: from mga05.intel.com ([192.55.52.43]:52921 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343984AbhIBMQd (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 2 Sep 2021 08:16:33 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10094"; a="304658213"
X-IronPort-AV: E=Sophos;i="5.84,372,1620716400"; 
   d="scan'208";a="304658213"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2021 05:15:34 -0700
X-IronPort-AV: E=Sophos;i="5.84,372,1620716400"; 
   d="scan'208";a="578148214"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2021 05:15:31 -0700
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id 6913E2031C;
        Thu,  2 Sep 2021 15:15:29 +0300 (EEST)
Date:   Thu, 2 Sep 2021 15:15:29 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Jean Delvare <jdelvare@suse.de>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Ville =?iso-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>
Subject: Re: TPS68470 PMIC config option
Message-ID: <20210902121529.GC3@paasikivi.fi.intel.com>
References: <20210901160234.0e3e24b2@endymion>
 <YS+6xzk9yc8uPetU@smile.fi.intel.com>
 <20210901193251.GZ3@paasikivi.fi.intel.com>
 <20210902115731.2fd22c80@endymion>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210902115731.2fd22c80@endymion>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Jean,

On Thu, Sep 02, 2021 at 11:57:31AM +0200, Jean Delvare wrote:
> Hi Sakari,
> 
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

There isn't. I was thinking whether all PMIC opregion drivers would be
behind a menu entry. If you have any sort of a generic kernel then you'd
probably want all of these in anyway. I don't really have an opinion
at this point though.

> 
> What about the following?
> 
> From: Jean Delvare <jdelvare@suse.de>
> Subject: ACPI / PMIC: Rename CONFIG_PMIC_OPREGION
> 
> Rename the intel_pmic driver's Kconfig option to make it clear it's
> about the Intel chipset family.
> 
> Signed-off-by: Jean Delvare <jdelvare@suse.de>
> Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Len Brown <lenb@kernel.org>
> Cc: Andy Shevchenko <andy@kernel.org>
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
>  drivers/acpi/pmic/Kconfig                    |   10 +++++-----
>  drivers/acpi/pmic/Makefile                   |    2 +-
>  drivers/gpu/drm/i915/display/intel_dsi_vbt.c |    4 ++--
>  drivers/staging/media/atomisp/Kconfig        |    2 +-
>  4 files changed, 9 insertions(+), 9 deletions(-)
> 
> --- linux-5.14.orig/drivers/acpi/pmic/Kconfig	2021-08-30 00:04:50.000000000 +0200
> +++ linux-5.14/drivers/acpi/pmic/Kconfig	2021-09-02 11:51:14.146662112 +0200
> @@ -1,14 +1,14 @@
>  # SPDX-License-Identifier: GPL-2.0
>  
> -menuconfig PMIC_OPREGION
> -	bool "PMIC (Power Management Integrated Circuit) operation region support"
> +menuconfig INTEL_PMIC_OPREGION
> +	bool "Intel PMIC (Power Management Integrated Circuit) operation region support"
>  	help
>  	  Select this option to enable support for ACPI operation
> -	  region of the PMIC chip. The operation region can be used
> +	  region of the Intel PMIC chip. The operation region can be used
>  	  to control power rails and sensor reading/writing on the
>  	  PMIC chip.
>  
> -if PMIC_OPREGION
> +if INTEL_PMIC_OPREGION
>  
>  config BYTCRC_PMIC_OPREGION
>  	bool "ACPI operation region support for Bay Trail Crystal Cove PMIC"
> @@ -48,7 +48,7 @@ config CHT_DC_TI_PMIC_OPREGION
>  	help
>  	  This config adds ACPI operation region support for Dollar Cove TI PMIC.
>  
> -endif	# PMIC_OPREGION
> +endif	# INTEL_PMIC_OPREGION
>  
>  config TPS68470_PMIC_OPREGION
>  	bool "ACPI operation region support for TPS68470 PMIC"
> --- linux-5.14.orig/drivers/acpi/pmic/Makefile	2021-08-30 00:04:50.000000000 +0200
> +++ linux-5.14/drivers/acpi/pmic/Makefile	2021-09-02 11:21:34.527694178 +0200
> @@ -1,6 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>  
> -obj-$(CONFIG_PMIC_OPREGION)		+= intel_pmic.o
> +obj-$(CONFIG_INTEL_PMIC_OPREGION)	+= intel_pmic.o
>  obj-$(CONFIG_BYTCRC_PMIC_OPREGION)	+= intel_pmic_bytcrc.o
>  obj-$(CONFIG_CHTCRC_PMIC_OPREGION)	+= intel_pmic_chtcrc.o
>  obj-$(CONFIG_XPOWER_PMIC_OPREGION)	+= intel_pmic_xpower.o
> --- linux-5.14.orig/drivers/staging/media/atomisp/Kconfig	2021-08-30 00:04:50.000000000 +0200
> +++ linux-5.14/drivers/staging/media/atomisp/Kconfig	2021-09-02 11:51:39.792007892 +0200
> @@ -12,7 +12,7 @@ menuconfig INTEL_ATOMISP
>  config VIDEO_ATOMISP
>  	tristate "Intel Atom Image Signal Processor Driver"
>  	depends on VIDEO_V4L2 && INTEL_ATOMISP
> -	depends on PMIC_OPREGION
> +	depends on INTEL_PMIC_OPREGION
>  	select IOSF_MBI
>  	select VIDEOBUF_VMALLOC
>  	select VIDEO_V4L2_SUBDEV_API
> --- linux-5.14.orig/drivers/gpu/drm/i915/display/intel_dsi_vbt.c	2021-08-30 00:04:50.000000000 +0200
> +++ linux-5.14/drivers/gpu/drm/i915/display/intel_dsi_vbt.c	2021-09-02 11:52:38.230795493 +0200
> @@ -511,7 +511,7 @@ static const u8 *mipi_exec_spi(struct in
>  static const u8 *mipi_exec_pmic(struct intel_dsi *intel_dsi, const u8 *data)
>  {
>  	struct drm_i915_private *i915 = to_i915(intel_dsi->base.base.dev);
> -#ifdef CONFIG_PMIC_OPREGION
> +#ifdef CONFIG_INTEL_PMIC_OPREGION
>  	u32 value, mask, reg_address;
>  	u16 i2c_address;
>  	int ret;
> @@ -529,7 +529,7 @@ static const u8 *mipi_exec_pmic(struct i
>  		drm_err(&i915->drm, "%s failed, error: %d\n", __func__, ret);
>  #else
>  	drm_err(&i915->drm,
> -		"Your hardware requires CONFIG_PMIC_OPREGION and it is not set\n");
> +		"Your hardware requires CONFIG_INTEL_PMIC_OPREGION and it is not set\n");

I wonder if this is just an Intel PMIC or whether it could be any PMIC.

Well, the dependency seems rather machine specific but could in principle
appear anywhere.

Cc Hans and Ville.

>  #endif
>  
>  	return data + 15;
> 

-- 
Kind regards,

Sakari Ailus
