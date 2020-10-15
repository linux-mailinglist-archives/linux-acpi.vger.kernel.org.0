Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3202D28F9AC
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Oct 2020 21:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391855AbgJOTqO (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 15 Oct 2020 15:46:14 -0400
Received: from mga11.intel.com ([192.55.52.93]:38341 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391854AbgJOTqO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 15 Oct 2020 15:46:14 -0400
IronPort-SDR: s+hi2SqqKEQU4IkuYooKx2VJGN/dum//EDdeBLAqPsdBC3bYgkyT8EquYG/yguTPjmI1CP4sn+
 veFZod+TLVbA==
X-IronPort-AV: E=McAfee;i="6000,8403,9775"; a="162973519"
X-IronPort-AV: E=Sophos;i="5.77,380,1596524400"; 
   d="scan'208";a="162973519"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2020 12:46:13 -0700
IronPort-SDR: 1FNf/2Jt9eaIreCkupbrPpcxokjRoPlJPhb1fitGpc8/1ucG/gImZjH+wr1Y18zoyTbG3BelDh
 6QqovO61rssg==
X-IronPort-AV: E=Sophos;i="5.77,380,1596524400"; 
   d="scan'208";a="357110343"
Received: from emcmulli-mobl1.amr.corp.intel.com ([10.212.199.190])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2020 12:46:12 -0700
Message-ID: <3e4ca631b8fb85de570bf490e71dd71219c5a2c2.camel@linux.intel.com>
Subject: Re: [PATCH 2/2] ACPI: DPTF: Add ACPI_DPTF Kconfig menu
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Borislav Petkov <bp@suse.de>
Date:   Thu, 15 Oct 2020 12:46:10 -0700
In-Reply-To: <35637045.pmxlVluP8t@kreacher>
References: <2206290.MayQypTng0@kreacher> <35637045.pmxlVluP8t@kreacher>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, 2020-10-15 at 18:59 +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Add a Kconfig menu for Intel DPTF (Dynamic Platform and Thermal
> Framework), put both the existing participant drivers in it and set
> them to be built as modules by default.
> 
> While at it, do a few assorted cleanups for a good measure.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

> ---
>  drivers/acpi/dptf/Kconfig |   29 ++++++++++++++++++++++++-----
>  1 file changed, 24 insertions(+), 5 deletions(-)
> 
> Index: linux-pm/drivers/acpi/dptf/Kconfig
> ===================================================================
> --- linux-pm.orig/drivers/acpi/dptf/Kconfig
> +++ linux-pm/drivers/acpi/dptf/Kconfig
> @@ -1,8 +1,25 @@
>  # SPDX-License-Identifier: GPL-2.0
> -config DPTF_POWER
> -	tristate "DPTF Platform Power Participant"
> +
> +menuconfig ACPI_DPTF
> +	bool "Intel DPTF (Dynamic Platform and Thermal Framework)
> Support"
>  	depends on X86
>  	help
> +	  Intel Dynamic Platform and Thermal Framework (DPTF) is a
> platform
> +	  level hardware/software solution for power and thermal
> management.
> +
> +	  As a container for multiple power/thermal technologies, DPTF
> provides
> +	  a coordinated approach for different policies to effect the
> hardware
> +	  state of a system.
> +
> +	  For more information see:
> +	  <
> https://01.org/intel%C2%AE-dynamic-platform-and-thermal-framework-dptf-chromium-os/overview
> >
> +
> +if ACPI_DPTF
> +
> +config DPTF_POWER
> +	tristate "Platform Power DPTF Participant"
> +	default m
> +	help
>  	  This driver adds support for Dynamic Platform and Thermal
> Framework
>  	  (DPTF) Platform Power Participant device (INT3407) support.
>  	  This participant is responsible for exposing platform
> telemetry:
> @@ -16,15 +33,17 @@ config DPTF_POWER
>  	  the module will be called dptf_power.
>  
>  config DPTF_PCH_FIVR
> -	tristate "DPTF PCH FIVR Participant"
> -	depends on X86
> +	tristate "PCH FIVR DPTF Participant"
> +	default m
>  	help
>  	  This driver adds support for Dynamic Platform and Thermal
> Framework
>  	  (DPTF) PCH FIVR Participant device support. This driver
> allows to
> -	  switch PCH FIVR (Fully Integrated Voltage Regulator)
> frequency.
> +	  switch the PCH FIVR (Fully Integrated Voltage Regulator)
> frequency.
>  	  This participant is responsible for exposing:
>  		freq_mhz_low_clock
>  		freq_mhz_high_clock
>  
>  	  To compile this driver as a module, choose M here:
>  	  the module will be called dptf_pch_fivr.
> +
> +endif
> 
> 
> 

