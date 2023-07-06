Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1F967498B4
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Jul 2023 11:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232227AbjGFJr4 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 6 Jul 2023 05:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232202AbjGFJrv (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 6 Jul 2023 05:47:51 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39F441727;
        Thu,  6 Jul 2023 02:47:50 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="363590817"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="scan'208";a="363590817"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2023 02:47:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="784876845"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="scan'208";a="784876845"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008.fm.intel.com with ESMTP; 06 Jul 2023 02:47:46 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andy@kernel.org>)
        id 1qHLaT-000UCk-13;
        Thu, 06 Jul 2023 12:47:45 +0300
Date:   Thu, 6 Jul 2023 12:47:45 +0300
From:   Andy Shevchenko <andy@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Daniel Scally <dan.scally@ideasonboard.com>,
        linux-acpi@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Kate Hsuan <hpa@redhat.com>, Hao Yao <hao.yao@intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>, linux-media@vger.kernel.org
Subject: Re: [PATCH v3 04/18] media: ipu-bridge: Allow building as module
Message-ID: <ZKaNwcwCk81kuV4D@smile.fi.intel.com>
References: <20230705213010.390849-1-hdegoede@redhat.com>
 <20230705213010.390849-5-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230705213010.390849-5-hdegoede@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Jul 05, 2023 at 11:29:56PM +0200, Hans de Goede wrote:
> After commit f54eb0ac7c1a ("media: ipu3-cio2: rename cio2 bridge to ipu
> bridge and move out of ipu3") the ipu-bridge code is always built in
> even if all consumers are build as module.
> 
> Fix this by turning "config IPU_BRIDGE" into a pure library Kconfig
> option (not user selectable, must be selected by consumers) and
> re-introducing the CIO2_BRIDGE Kconfig bits in .../pci/intel/ipu3/Kconfig
> which were dropped to still allow building ipu3-cio2 without ipu-bridge
> support.

Reviewed-by: Andy Shevchenko <andy@kernel.org>

> Fixes: f54eb0ac7c1a ("media: ipu3-cio2: rename cio2 bridge to ipu bridge and move out of ipu3")
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/media/pci/intel/Kconfig      | 18 ++----------------
>  drivers/media/pci/intel/ipu-bridge.c |  4 ++++
>  drivers/media/pci/intel/ipu3/Kconfig | 20 ++++++++++++++++++++
>  3 files changed, 26 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/media/pci/intel/Kconfig b/drivers/media/pci/intel/Kconfig
> index 64a29b0b7033..3179184d7616 100644
> --- a/drivers/media/pci/intel/Kconfig
> +++ b/drivers/media/pci/intel/Kconfig
> @@ -1,21 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  config IPU_BRIDGE
> -	bool "Intel IPU Sensors Bridge"
> -	depends on VIDEO_IPU3_CIO2 && ACPI
> +	tristate
> +	depends on ACPI
>  	depends on I2C
> -	help
> -	  This extension provides an API for the Intel IPU driver to create
> -	  connections to cameras that are hidden in the SSDB buffer in ACPI.
> -	  It can be used to enable support for cameras in detachable / hybrid
> -	  devices that ship with Windows.
> -
> -	  Say Y here if your device is a detachable / hybrid laptop that comes
> -	  with Windows installed by the OEM, for example:
> -
> -		- Microsoft Surface models (except Surface Pro 3)
> -		- The Lenovo Miix line (for example the 510, 520, 710 and 720)
> -		- Dell 7285
> -
> -	  If in doubt, say N here.
>  
>  source "drivers/media/pci/intel/ipu3/Kconfig"
> diff --git a/drivers/media/pci/intel/ipu-bridge.c b/drivers/media/pci/intel/ipu-bridge.c
> index 1c88fd925a8b..97b544736af2 100644
> --- a/drivers/media/pci/intel/ipu-bridge.c
> +++ b/drivers/media/pci/intel/ipu-bridge.c
> @@ -497,3 +497,7 @@ int ipu_bridge_init(struct pci_dev *ipu)
>  	return ret;
>  }
>  EXPORT_SYMBOL_NS_GPL(ipu_bridge_init, INTEL_IPU_BRIDGE);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Dan Scally <djrscally@gmail.com>");
> +MODULE_DESCRIPTION("Intel IPU ACPI Sensors Bridge");
> diff --git a/drivers/media/pci/intel/ipu3/Kconfig b/drivers/media/pci/intel/ipu3/Kconfig
> index 9be06ee81ff0..0951545eab21 100644
> --- a/drivers/media/pci/intel/ipu3/Kconfig
> +++ b/drivers/media/pci/intel/ipu3/Kconfig
> @@ -8,6 +8,7 @@ config VIDEO_IPU3_CIO2
>  	select VIDEO_V4L2_SUBDEV_API
>  	select V4L2_FWNODE
>  	select VIDEOBUF2_DMA_SG
> +	select IPU_BRIDGE if CIO2_BRIDGE
>  
>  	help
>  	  This is the Intel IPU3 CIO2 CSI-2 receiver unit, found in Intel
> @@ -17,3 +18,22 @@ config VIDEO_IPU3_CIO2
>  	  Say Y or M here if you have a Skylake/Kaby Lake SoC with MIPI CSI-2
>  	  connected camera.
>  	  The module will be called ipu3-cio2.
> +
> +config CIO2_BRIDGE
> +	bool "IPU3 CIO2 Sensors Bridge"
> +	depends on VIDEO_IPU3_CIO2 && ACPI
> +	depends on I2C
> +	help
> +	  This extension provides an API for the ipu3-cio2 driver to create
> +	  connections to cameras that are hidden in the SSDB buffer in ACPI.
> +	  It can be used to enable support for cameras in detachable / hybrid
> +	  devices that ship with Windows.
> +
> +	  Say Y here if your device is a detachable / hybrid laptop that comes
> +	  with Windows installed by the OEM, for example:
> +
> +		- Microsoft Surface models (except Surface Pro 3)
> +		- The Lenovo Miix line (for example the 510, 520, 710 and 720)
> +		- Dell 7285
> +
> +	  If in doubt, say N here.
> -- 
> 2.41.0
> 

-- 
With Best Regards,
Andy Shevchenko


