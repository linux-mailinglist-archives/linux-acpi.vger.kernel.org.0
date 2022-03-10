Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48BA84D4F41
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Mar 2022 17:29:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234586AbiCJQ30 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 10 Mar 2022 11:29:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242292AbiCJQ1y (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 10 Mar 2022 11:27:54 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A5142BB3F;
        Thu, 10 Mar 2022 08:26:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646929613; x=1678465613;
  h=message-id:subject:from:reply-to:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cIo9ep1OpS0fZBg6Xw4Pk5douYIJ5a+EYRIxTPF/OrA=;
  b=KqahoZYcBMTFSTgEgdXtRXeFNDhFxUCVA1TfDj3+tcvsfGdSrjjAnQtz
   2zYmuk0++0UzqTuTga2R+6j/WNa8msutUWHwSzsQnZdm/Ng4hNEptpqt4
   2io1sWiIN9Kys4IzhKPTfwxOBnxreVOyI88Nnfzrl4sCGDiRsjJtZO8c4
   QZMYNzKyq3NMOVibxzVaFuoezKiQ2/42EIzFWFn6toNwTrPeTX08GDXdX
   e4D/t7pMz0k8ryaLO2IgxQaAf6wRtF3/23pOQ1K6tYbx7yRFB9/Lz6aPa
   /d66ZsykVsiXEUGMsovGEnto9IZRu+jtNJNnH4EK/HWVyn/uHuNf6e0T/
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10282"; a="242738728"
X-IronPort-AV: E=Sophos;i="5.90,171,1643702400"; 
   d="scan'208";a="242738728"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 08:26:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,171,1643702400"; 
   d="scan'208";a="496313293"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga003.jf.intel.com with ESMTP; 10 Mar 2022 08:26:29 -0800
Received: from ngpereir-MOBL.amr.corp.intel.com (unknown [10.212.217.28])
        by linux.intel.com (Postfix) with ESMTP id BC2AF58090C;
        Thu, 10 Mar 2022 08:26:29 -0800 (PST)
Message-ID: <493159542d69de10383595ed018cb086a455e1b7.camel@linux.intel.com>
Subject: Re: [PATCH 2/4] ACPI / x86: Pass the constraints checking result to
 LPS0 callback
From:   "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To:     Mario Limonciello <mario.limonciello@amd.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc:     "open list:X86 PLATFORM DRIVERS" 
        <platform-driver-x86@vger.kernel.org>, linux-acpi@vger.kernel.org
Date:   Thu, 10 Mar 2022 08:26:29 -0800
In-Reply-To: <20220310151705.577442-2-mario.limonciello@amd.com>
References: <20220310151705.577442-1-mario.limonciello@amd.com>
         <20220310151705.577442-2-mario.limonciello@amd.com>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, 2022-03-10 at 09:17 -0600, Mario Limonciello wrote:
> If constraints checking has been enabled by the LPS0 code, it may
> also be useful for drivers using the callback to make a decision what
> to do.
> 
> For example this may in the future allow a failing constraints check
> preventing another driver from notifying firmware that all required
> devices have entered the deepest state.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/acpi/x86/s2idle.c | 17 ++++++++++-------
>  include/linux/acpi.h      |  4 ++--
>  2 files changed, 12 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
> index 652dc2d75458..c737a8e5d5a5 100644
> --- a/drivers/acpi/x86/s2idle.c
> +++ b/drivers/acpi/x86/s2idle.c
> @@ -88,7 +88,7 @@ struct lpi_device_constraint_amd {
>  
>  struct lps0_callback_handler {
>  	struct list_head list_node;
> -	int (*prepare_late_callback)(void *context);
> +	int (*prepare_late_callback)(void *context, bool constraints);
>  	void (*restore_early_callback)(void *context);
>  	void *context;
>  };
> @@ -297,7 +297,7 @@ static void lpi_device_get_constraints(void)
>  	ACPI_FREE(out_obj);
>  }
>  
> -static void lpi_check_constraints(void)
> +static void lpi_check_constraints(bool *met)
>  {
>  	int i;
>  
> @@ -319,11 +319,13 @@ static void lpi_check_constraints(void)
>  			continue;
>  		}
>  
> -		if (adev->power.state < lpi_constraints_table[i].min_dstate)
> +		if (adev->power.state < lpi_constraints_table[i].min_dstate) {
>  			acpi_handle_info(handle,
>  				"LPI: Constraint not met; min power state:%s
> current power state:%s\n",
>  				acpi_power_state_string(lpi_constraints_table[i]
> .min_dstate),
>  				acpi_power_state_string(adev->power.state));
> +			*met = false;
> +		}
>  	}
>  }
>  
> @@ -455,13 +457,14 @@ static struct acpi_scan_handler lps0_handler = {
>  int acpi_s2idle_prepare_late(void)
>  {
>  	struct lps0_callback_handler *handler;
> +	bool constraints_met = true;
>  	int rc = 0;
>  
>  	if (!lps0_device_handle || sleep_no_lps0)
>  		return 0;
>  
>  	if (pm_debug_messages_on)
> -		lpi_check_constraints();
> +		lpi_check_constraints(&constraints_met);

lpi_check_constraints() was only used for dumping information to dmesg. If you
want to make a decision based on whether a constraint was met then you probably
want to run it all the time. You could use pm_debug_messages_on inside of
lpi_check_contraints() to decide whether to print to the log.

>  
>  	/* Screen off */
>  	if (lps0_dsm_func_mask > 0)
> @@ -490,7 +493,7 @@ int acpi_s2idle_prepare_late(void)
>  
>  	mutex_lock(&lps0_callback_handler_mutex);
>  	list_for_each_entry(handler, &lps0_callback_handler_head, list_node) {
> -		rc = handler->prepare_late_callback(handler->context);
> +		rc = handler->prepare_late_callback(handler->context,
> constraints_met);

Otherwise, is it okay that constraints_met will always be true if
pm_debug_messages_on isn't?

David

>  		if (rc)
>  			goto out;
>  	}
> @@ -554,7 +557,7 @@ void acpi_s2idle_setup(void)
>  	s2idle_set_ops(&acpi_s2idle_ops_lps0);
>  }
>  
> -int acpi_register_lps0_callbacks(int (*prepare_late)(void *context),
> +int acpi_register_lps0_callbacks(int (*prepare_late)(void *context, bool
> constraints),
>  				 void (*restore_early)(void *context),
>  				 void *context)
>  {
> @@ -578,7 +581,7 @@ int acpi_register_lps0_callbacks(int (*prepare_late)(void
> *context),
>  }
>  EXPORT_SYMBOL_GPL(acpi_register_lps0_callbacks);
>  
> -void acpi_unregister_lps0_callbacks(int (*prepare_late)(void *context),
> +void acpi_unregister_lps0_callbacks(int (*prepare_late)(void *context, bool
> constraints),
>  				    void (*restore_early)(void *context),
>  				    void *context)
>  {
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index cae0fde309f2..5aae774670dc 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -1024,10 +1024,10 @@ void acpi_os_set_prepare_extended_sleep(int (*func)(u8
> sleep_state,
>  acpi_status acpi_os_prepare_extended_sleep(u8 sleep_state,
>  					   u32 val_a, u32 val_b);
>  #ifdef CONFIG_X86
> -int acpi_register_lps0_callbacks(int (*prepare_late)(void *context),
> +int acpi_register_lps0_callbacks(int (*prepare_late)(void *context, bool
> constraints),
>  				 void (*restore_early)(void *context),
>  				 void *context);
> -void acpi_unregister_lps0_callbacks(int (*prepare_late)(void *context),
> +void acpi_unregister_lps0_callbacks(int (*prepare_late)(void *context, bool
> constraints),
>  				    void (*restore_early)(void *context),
>  				    void *context);
>  #endif /* CONFIG_X86 */

