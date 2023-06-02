Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B84C72031C
	for <lists+linux-acpi@lfdr.de>; Fri,  2 Jun 2023 15:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235055AbjFBNUo (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 2 Jun 2023 09:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234248AbjFBNUo (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 2 Jun 2023 09:20:44 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CAB799;
        Fri,  2 Jun 2023 06:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685712043; x=1717248043;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=V7NI5YY5Azao4XE/ZY/N7UDHe240rHc5lq+QOO8qyTg=;
  b=KrQ9hGxKrFbDbv3I8IbRx/8rtRhazxhp6K/BnKXs2didkjI+i5E/Zr96
   4Hh53tRmXAT8FKCEBe/g0FQ7Cl3fQFw4qHTHklEu7VwKOuUVH/yZOPBMl
   C66IGyOHVdxdetQ/TVKqU3+XJpSsj4tuBVQZwj2Hhu8iesajBfakFpBJy
   nc/Q1jgVd7fxRPumtM6PoyMCiUh7QGyHw66kvnwSQjvOLHZ/SmT8NsLv3
   rN+orFZM42ZIsfK9N9y/tplNYXmV8Z0fvKL584AnJtIKt4/eevmPxTKn4
   ipDAeOZm3H3q6G13OW9iFu/f3uXHDWSzqlw3Xn8Dt6lsuEos39vSwa6xK
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10729"; a="384148105"
X-IronPort-AV: E=Sophos;i="6.00,213,1681196400"; 
   d="scan'208";a="384148105"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2023 06:20:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10729"; a="737536883"
X-IronPort-AV: E=Sophos;i="6.00,213,1681196400"; 
   d="scan'208";a="737536883"
Received: from rspatil-mobl3.gar.corp.intel.com ([10.251.208.112])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2023 06:20:40 -0700
Date:   Fri, 2 Jun 2023 16:20:37 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Michal Wilczynski <michal.wilczynski@intel.com>
cc:     =?ISO-8859-15?Q?Pali_Roh=E1r?= <pali@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org,
        rafael@kernel.org
Subject: Re: [PATCH v4 19/35] platform/x86/dell/dell-rbtn: Move handler
 installing logic to driver
In-Reply-To: <20230601131739.300760-20-michal.wilczynski@intel.com>
Message-ID: <ba90f648-6f29-57f3-b1cc-91b929fda393@linux.intel.com>
References: <20230601131739.300760-3-michal.wilczynski@intel.com> <20230601131739.300760-20-michal.wilczynski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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
>  drivers/platform/x86/dell/dell-rbtn.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/platform/x86/dell/dell-rbtn.c b/drivers/platform/x86/dell/dell-rbtn.c
> index aa0e6c907494..4dcad59eb035 100644
> --- a/drivers/platform/x86/dell/dell-rbtn.c
> +++ b/drivers/platform/x86/dell/dell-rbtn.c
> @@ -207,7 +207,7 @@ static void rbtn_input_event(struct rbtn_data *rbtn_data)
>  
>  static int rbtn_add(struct acpi_device *device);
>  static void rbtn_remove(struct acpi_device *device);
> -static void rbtn_notify(struct acpi_device *device, u32 event);
> +static void rbtn_notify(acpi_handle handle, u32 event, void *data);
>  
>  static const struct acpi_device_id rbtn_ids[] = {
>  	{ "DELRBTN", 0 },
> @@ -293,7 +293,6 @@ static struct acpi_driver rbtn_driver = {
>  	.ops = {
>  		.add = rbtn_add,
>  		.remove = rbtn_remove,
> -		.notify = rbtn_notify,
>  	},
>  	.owner = THIS_MODULE,
>  };
> @@ -422,7 +421,10 @@ static int rbtn_add(struct acpi_device *device)
>  		ret = -EINVAL;
>  	}
>  
> -	return ret;
> +	if (ret)
> +		return ret;
> +
> +	return acpi_device_install_event_handler(device, ACPI_DEVICE_NOTIFY, rbtn_notify);

What about the other things that are done in rbtn_remove(), should you 
rollback more?

I suspect there's a pre-existing lack of rbtn_acquire(device, false); 
here to begin with.

-- 
 i.

