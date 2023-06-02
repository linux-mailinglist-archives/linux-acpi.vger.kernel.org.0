Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3E9F72032A
	for <lists+linux-acpi@lfdr.de>; Fri,  2 Jun 2023 15:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235849AbjFBNYT (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 2 Jun 2023 09:24:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjFBNYS (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 2 Jun 2023 09:24:18 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62759132;
        Fri,  2 Jun 2023 06:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685712257; x=1717248257;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=TyXqR6ZIoRmRprJC+N68bB64lrIfKV4lkG4PlRqKKa0=;
  b=fgHPhYGZUsTXsqHC8pC7Z2rk4mo7l8iNigiW+x6WsQoYJ8XIfcLTchSi
   QRFzBrIR8bznCkEWpfmMTbxFn9fURx5qmV/e/BLbF0PQfRvGa5NrM3bpL
   jS06o8HxZNr/wDTsch+IZZLB5+MgN4Lg0QNETY5aiY8fup4l6Y0l3AB4x
   j3CC6HwJiqiAGb/dTxXTFFU0tytlWWTUotV4RvBnjLjzqOJvCNnwr5Q3Z
   QqniC3Az+wEOi6LNafg2iJx++MjBp2Vk0nfMq6tkV7DzMkbLUw62O965I
   dX4gTWo3ghnSJttLf4w47RwYtHWsVBVeoIUKQzx4fPHn/Wvx+lgo+z/tx
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10729"; a="335479161"
X-IronPort-AV: E=Sophos;i="6.00,213,1681196400"; 
   d="scan'208";a="335479161"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2023 06:24:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10729"; a="772883460"
X-IronPort-AV: E=Sophos;i="6.00,213,1681196400"; 
   d="scan'208";a="772883460"
Received: from rspatil-mobl3.gar.corp.intel.com ([10.251.208.112])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2023 06:24:14 -0700
Date:   Fri, 2 Jun 2023 16:24:12 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Michal Wilczynski <michal.wilczynski@intel.com>
cc:     Corentin Chary <corentin.chary@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org,
        rafael@kernel.org
Subject: Re: [PATCH v4 20/35] platform/x86/eeepc-laptop: Move handler installing
 logic to driver
In-Reply-To: <20230601131739.300760-21-michal.wilczynski@intel.com>
Message-ID: <546abebd-deee-dc5b-a96d-51f1dc7b49cf@linux.intel.com>
References: <20230601131739.300760-3-michal.wilczynski@intel.com> <20230601131739.300760-21-michal.wilczynski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, 1 Jun 2023, Michal Wilczynski wrote:

> Currently logic for installing notifications from ACPI devices is
> implemented using notify callback in struct acpi_driver. Preparations
> are being made to replace acpi_driver with more generic struct
> platform_driver, which doesn't contain notify callback. Furthermore
> as of now handlers are being called indirectly through
> acpi_notify_device(), which decreases performance.
> 
> Call acpi_device_install_event_handler() at the end of .add() callback.
> Call acpi_device_remove_event_handler() at the beginning of .remove()
> callback. Change arguments passed to the notify callback to match with
> what's required by acpi_device_install_event_handler().
> 
> Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
> ---
>  drivers/platform/x86/eeepc-laptop.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/platform/x86/eeepc-laptop.c b/drivers/platform/x86/eeepc-laptop.c
> index 62b71e8e3567..bd6ada963d88 100644
> --- a/drivers/platform/x86/eeepc-laptop.c
> +++ b/drivers/platform/x86/eeepc-laptop.c
> @@ -1204,12 +1204,15 @@ static void eeepc_input_notify(struct eeepc_laptop *eeepc, int event)
>  		pr_info("Unknown key %x pressed\n", event);
>  }
>  
> -static void eeepc_acpi_notify(struct acpi_device *device, u32 event)
> +static void eeepc_acpi_notify(acpi_handle handle, u32 event, void *data)
>  {
> -	struct eeepc_laptop *eeepc = acpi_driver_data(device);
>  	int old_brightness, new_brightness;
> +	struct acpi_device *device = data;
> +	struct eeepc_laptop *eeepc;
>  	u16 count;
>  
> +	eeepc = acpi_driver_data(device);
> +
>  	if (event > ACPI_MAX_SYS_NOTIFY)
>  		return;
>  	count = eeepc->event_count[event % 128]++;
> @@ -1423,6 +1426,11 @@ static int eeepc_acpi_add(struct acpi_device *device)
>  		goto fail_rfkill;
>  
>  	eeepc_device_present = true;
> +	result = acpi_device_install_event_handler(device, ACPI_ALL_NOTIFY,
> +						   eeepc_acpi_notify);
> +	if (result)
> +		goto fail_rfkill;

This too is incorrectly rolled back. You shouldn't just copy the previous 
goto label like this but think what _more_ should be rolled back if that 
preceeding call succeeded. Usually, the remove function gives you good 
hint on what additional things should be rolled back. In here it looks 
like eeepc_rfkill_exit() would be needed too.

> +
>  	return 0;
>  
>  fail_rfkill:
> @@ -1444,6 +1452,8 @@ static void eeepc_acpi_remove(struct acpi_device *device)
>  {
>  	struct eeepc_laptop *eeepc = acpi_driver_data(device);
>  
> +	acpi_device_remove_event_handler(device, ACPI_ALL_NOTIFY,
> +					 eeepc_acpi_notify);
>  	eeepc_backlight_exit(eeepc);
>  	eeepc_rfkill_exit(eeepc);
>  	eeepc_input_exit(eeepc);


-- 
 i.

