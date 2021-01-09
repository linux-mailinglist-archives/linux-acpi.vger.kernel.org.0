Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA8602EFCEB
	for <lists+linux-acpi@lfdr.de>; Sat,  9 Jan 2021 02:55:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725916AbhAIBzY (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 8 Jan 2021 20:55:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbhAIBzY (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 8 Jan 2021 20:55:24 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2E58C061574;
        Fri,  8 Jan 2021 17:54:43 -0800 (PST)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 9C0AADA;
        Sat,  9 Jan 2021 02:54:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1610157280;
        bh=jsCR+yhrfK8nH0oAXFTJMNv1U8hDPr9PYMtoSLMCqCU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QuFp3hwFlh1bR873Wb239tIxK237bWOasYBz2H5bAeksp62LpNcVH+8G6NacmW6cq
         bJN2H1zcG1F4zSsubHyV/cCXzXVn1J8SSj2pqcgBPpoQ6QkippKDB7Vl4Nbp+NJWQ9
         b0PFNQg93LxV3SCUTolKPh2qP7j6cC9Qo8nYs908=
Date:   Sat, 9 Jan 2021 03:54:27 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Daniel Scally <djrscally@gmail.com>, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-media@vger.kernel.org,
        devel@acpica.org, lenb@kernel.org, gregkh@linuxfoundation.org,
        mchehab@kernel.org, sergey.senozhatsky@gmail.com,
        yong.zhi@intel.com, sakari.ailus@linux.intel.com,
        bingbu.cao@intel.com, tian.shu.qiu@intel.com,
        robert.moore@intel.com, erik.kaneda@intel.com, pmladek@suse.com,
        rostedt@goodmis.org, andriy.shevchenko@linux.intel.com,
        linux@rasmusvillemoes.dk,
        laurent.pinchart+renesas@ideasonboard.com,
        jacopo+renesas@jmondi.org, kieran.bingham+renesas@ideasonboard.com,
        hverkuil-cisco@xs4all.nl, m.felsch@pengutronix.de,
        niklas.soderlund+renesas@ragnatech.se,
        prabhakar.mahadev-lad.rj@bp.renesas.com, slongerbeam@gmail.com,
        heikki.krogerus@linux.intel.com
Subject: Re: [PATCH v5 13/15] ACPI / bus: Add acpi_dev_get_next_match_dev()
 and helper macro
Message-ID: <X/kM0wWEInPhz3mz@pendragon.ideasonboard.com>
References: <20210107132838.396641-1-djrscally@gmail.com>
 <20210107132838.396641-14-djrscally@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210107132838.396641-14-djrscally@gmail.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Rafael,

Could you please review this patch, and let us know (see question in the
cover letter) if it can be merged through the linux-media tree for v5.12
?

On Thu, Jan 07, 2021 at 01:28:36PM +0000, Daniel Scally wrote:
> To ensure we handle situations in which multiple sensors of the same
> model (and therefore _HID) are present in a system, we need to be able
> to iterate over devices matching a known _HID but unknown _UID and _HRV
>  - add acpi_dev_get_next_match_dev() to accommodate that possibility and
> change acpi_dev_get_first_match_dev() to simply call the new function
> with a NULL starting point. Add an iterator macro for convenience.
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Daniel Scally <djrscally@gmail.com>
> ---
> Changes in v5:
> 
> 	- Changed commit subject
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
> index 6d1879bf9440..02a716a0af5d 100644
> --- a/include/acpi/acpi_bus.h
> +++ b/include/acpi/acpi_bus.h
> @@ -683,9 +683,16 @@ static inline bool acpi_device_can_poweroff(struct acpi_device *adev)
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

-- 
Regards,

Laurent Pinchart
