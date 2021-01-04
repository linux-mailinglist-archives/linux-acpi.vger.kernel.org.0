Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D1902E9524
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Jan 2021 13:44:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbhADMnU (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 4 Jan 2021 07:43:20 -0500
Received: from mga07.intel.com ([134.134.136.100]:18371 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726789AbhADMnU (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 4 Jan 2021 07:43:20 -0500
IronPort-SDR: 5pu6/Y+350I0eB63FcMdgH2pJAXZpYG58KeIk+Xcjr3qiCy+S/OmwiJ7/ozsZK2JYsMw3oNO5R
 651eAV6+RZSw==
X-IronPort-AV: E=McAfee;i="6000,8403,9853"; a="241029868"
X-IronPort-AV: E=Sophos;i="5.78,474,1599548400"; 
   d="scan'208";a="241029868"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2021 04:41:33 -0800
IronPort-SDR: BZJ0vJPCKSGEmCqRobP/9fXL4Hzw8UC6X/HWbkGKiYRna9+20Xa7UNo6F1J6X0Zby9o87oh7Hv
 8AWg9dDfckww==
X-IronPort-AV: E=Sophos;i="5.78,474,1599548400"; 
   d="scan'208";a="401958746"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2021 04:41:27 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kwPBs-001ZNb-71; Mon, 04 Jan 2021 14:42:28 +0200
Date:   Mon, 4 Jan 2021 14:42:28 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Daniel Scally <djrscally@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-media@vger.kernel.org, devel@acpica.org,
        gregkh@linuxfoundation.org, rjw@rjwysocki.net,
        sergey.senozhatsky@gmail.com, mchehab@kernel.org, lenb@kernel.org,
        yong.zhi@intel.com, sakari.ailus@linux.intel.com,
        bingbu.cao@intel.com, tian.shu.qiu@intel.com,
        robert.moore@intel.com, erik.kaneda@intel.com, pmladek@suse.com,
        rostedt@goodmis.org, linux@rasmusvillemoes.dk,
        laurent.pinchart+renesas@ideasonboard.com,
        jacopo+renesas@jmondi.org, kieran.bingham+renesas@ideasonboard.com,
        hverkuil-cisco@xs4all.nl, m.felsch@pengutronix.de,
        niklas.soderlund+renesas@ragnatech.se, slongerbeam@gmail.com,
        heikki.krogerus@linux.intel.com, linus.walleij@linaro.org
Subject: Re: [PATCH v4 13/15] acpi: Add acpi_dev_get_next_match_dev() and
 helper macro
Message-ID: <20210104124228.GU4077@smile.fi.intel.com>
References: <20210103231235.792999-1-djrscally@gmail.com>
 <20210103231235.792999-14-djrscally@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210103231235.792999-14-djrscally@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sun, Jan 03, 2021 at 11:12:33PM +0000, Daniel Scally wrote:
> To ensure we handle situations in which multiple sensors of the same
> model (and therefore _HID) are present in a system, we need to be able
> to iterate over devices matching a known _HID but unknown _UID and _HRV
>  - add acpi_dev_get_next_match_dev() to accommodate that possibility and
> change acpi_dev_get_first_match_dev() to simply call the new function
> with a NULL starting point. Add an iterator macro for convenience.

I guess we need Rafael's blessing on this.

> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Daniel Scally <djrscally@gmail.com>
> ---
> Changes in v4:
> 
> 	- None
> 
>  drivers/acpi/utils.c    | 30 ++++++++++++++++++++++++++----
>  include/acpi/acpi_bus.h |  7 +++++++
>  2 files changed, 33 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
> index d5411a166685..ddca1550cce6 100644
> --- a/drivers/acpi/utils.c
> +++ b/drivers/acpi/utils.c
> @@ -843,12 +843,13 @@ bool acpi_dev_present(const char *hid, const char *uid, s64 hrv)
>  EXPORT_SYMBOL(acpi_dev_present);
>  
>  /**
> - * acpi_dev_get_first_match_dev - Return the first match of ACPI device
> + * acpi_dev_get_next_match_dev - Return the next match of ACPI device
> + * @adev: Pointer to the previous acpi_device matching this @hid, @uid and @hrv
>   * @hid: Hardware ID of the device.
>   * @uid: Unique ID of the device, pass NULL to not check _UID
>   * @hrv: Hardware Revision of the device, pass -1 to not check _HRV
>   *
> - * Return the first match of ACPI device if a matching device was present
> + * Return the next match of ACPI device if another matching device was present
>   * at the moment of invocation, or NULL otherwise.
>   *
>   * The caller is responsible to call put_device() on the returned device.
> @@ -856,8 +857,9 @@ EXPORT_SYMBOL(acpi_dev_present);
>   * See additional information in acpi_dev_present() as well.
>   */
>  struct acpi_device *
> -acpi_dev_get_first_match_dev(const char *hid, const char *uid, s64 hrv)
> +acpi_dev_get_next_match_dev(struct acpi_device *adev, const char *hid, const char *uid, s64 hrv)
>  {
> +	struct device *start = adev ? &adev->dev : NULL;
>  	struct acpi_dev_match_info match = {};
>  	struct device *dev;
>  
> @@ -865,9 +867,29 @@ acpi_dev_get_first_match_dev(const char *hid, const char *uid, s64 hrv)
>  	match.uid = uid;
>  	match.hrv = hrv;
>  
> -	dev = bus_find_device(&acpi_bus_type, NULL, &match, acpi_dev_match_cb);
> +	dev = bus_find_device(&acpi_bus_type, start, &match, acpi_dev_match_cb);
>  	return dev ? to_acpi_device(dev) : NULL;
>  }
> +EXPORT_SYMBOL(acpi_dev_get_next_match_dev);
> +
> +/**
> + * acpi_dev_get_first_match_dev - Return the first match of ACPI device
> + * @hid: Hardware ID of the device.
> + * @uid: Unique ID of the device, pass NULL to not check _UID
> + * @hrv: Hardware Revision of the device, pass -1 to not check _HRV
> + *
> + * Return the first match of ACPI device if a matching device was present
> + * at the moment of invocation, or NULL otherwise.
> + *
> + * The caller is responsible to call put_device() on the returned device.
> + *
> + * See additional information in acpi_dev_present() as well.
> + */
> +struct acpi_device *
> +acpi_dev_get_first_match_dev(const char *hid, const char *uid, s64 hrv)
> +{
> +	return acpi_dev_get_next_match_dev(NULL, hid, uid, hrv);
> +}
>  EXPORT_SYMBOL(acpi_dev_get_first_match_dev);
>  
>  /*
> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> index a3abcc4b7d9f..0a028ba967d3 100644
> --- a/include/acpi/acpi_bus.h
> +++ b/include/acpi/acpi_bus.h
> @@ -688,9 +688,16 @@ static inline bool acpi_device_can_poweroff(struct acpi_device *adev)
>  
>  bool acpi_dev_hid_uid_match(struct acpi_device *adev, const char *hid2, const char *uid2);
>  
> +struct acpi_device *
> +acpi_dev_get_next_match_dev(struct acpi_device *adev, const char *hid, const char *uid, s64 hrv);
>  struct acpi_device *
>  acpi_dev_get_first_match_dev(const char *hid, const char *uid, s64 hrv);
>  
> +#define for_each_acpi_dev_match(adev, hid, uid, hrv)			\
> +	for (adev = acpi_dev_get_first_match_dev(hid, uid, hrv);	\
> +	     adev;							\
> +	     adev = acpi_dev_get_next_match_dev(adev, hid, uid, hrv))
> +
>  static inline void acpi_dev_put(struct acpi_device *adev)
>  {
>  	put_device(&adev->dev);
> -- 
> 2.25.1
> 

-- 
With Best Regards,
Andy Shevchenko


