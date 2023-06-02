Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3C1A7202A9
	for <lists+linux-acpi@lfdr.de>; Fri,  2 Jun 2023 15:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235965AbjFBNJ7 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 2 Jun 2023 09:09:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235963AbjFBNJ6 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 2 Jun 2023 09:09:58 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67E8D1AB;
        Fri,  2 Jun 2023 06:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685711397; x=1717247397;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=0bLFxmXhUWhrp2vU5VeAk9naT3tLznJtVEOx3Bbgzf0=;
  b=ArEFUs2LDaTfdZWt8Chluy0eW124jvWQVUW5oJb3/6fy2E9edapYLijU
   PKo/rS18nHicSvwP1qToFcIKqdAxykL0o77sG2XQ3g5qtNQ6dPvR1seeR
   JpumwNH+6druoV6d8OfD2mBQYasl6482tcKkbYmZNBeaP7BlldSp5Bciz
   8+IfLr8jbIIiP1wtccUEWpDXGJhiz6Ffe3MGLNqezkgc19lQSanA2bVGz
   VFvKWVBbwdGkZAHFZxbI+8JELsDvR78bcOmOEEe6MRkldy+C7y2xMA8dw
   hc9zQGixKh1Y1oitoZIa3or14dYGO2glFJBxb8Q+j4MGKRnKpLK+pwzF6
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10729"; a="359164110"
X-IronPort-AV: E=Sophos;i="6.00,213,1681196400"; 
   d="scan'208";a="359164110"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2023 06:09:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10729"; a="882069405"
X-IronPort-AV: E=Sophos;i="6.00,213,1681196400"; 
   d="scan'208";a="882069405"
Received: from rspatil-mobl3.gar.corp.intel.com ([10.251.208.112])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2023 06:09:53 -0700
Date:   Fri, 2 Jun 2023 16:09:51 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Michal Wilczynski <michal.wilczynski@intel.com>
cc:     Corentin Chary <corentin.chary@gmail.com>,
        =?ISO-8859-15?Q?Jo=E3o_Paulo_Rechi_Vita?= <jprvita@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org,
        acpi4asus-user@lists.sourceforge.net, linux-acpi@vger.kernel.org,
        rafael@kernel.org
Subject: Re: [PATCH v4 17/35] platform/x86/asus-wireless: Move handler
 installing logic to driver
In-Reply-To: <20230601131739.300760-18-michal.wilczynski@intel.com>
Message-ID: <de33f84-8774-9d8-5d6c-ea6a31343fab@linux.intel.com>
References: <20230601131739.300760-3-michal.wilczynski@intel.com> <20230601131739.300760-18-michal.wilczynski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
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
>  drivers/platform/x86/asus-wireless.c | 24 +++++++++++++++---------
>  1 file changed, 15 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/platform/x86/asus-wireless.c b/drivers/platform/x86/asus-wireless.c
> index abf01e00b799..6544e3419ae4 100644
> --- a/drivers/platform/x86/asus-wireless.c
> +++ b/drivers/platform/x86/asus-wireless.c
> @@ -108,19 +108,22 @@ static void led_state_set(struct led_classdev *led, enum led_brightness value)
>  	queue_work(data->wq, &data->led_work);
>  }
>  
> -static void asus_wireless_notify(struct acpi_device *adev, u32 event)
> +static void asus_wireless_notify(acpi_handle handle, u32 event, void *data)
>  {
> -	struct asus_wireless_data *data = acpi_driver_data(adev);
> +	struct asus_wireless_data *w_data;
> +	struct acpi_device *adev = data;
> +
> +	w_data = acpi_driver_data(adev);
>  
>  	dev_dbg(&adev->dev, "event=%#x\n", event);
>  	if (event != 0x88) {
>  		dev_notice(&adev->dev, "Unknown ASHS event: %#x\n", event);
>  		return;
>  	}
> -	input_report_key(data->idev, KEY_RFKILL, 1);
> -	input_sync(data->idev);
> -	input_report_key(data->idev, KEY_RFKILL, 0);
> -	input_sync(data->idev);
> +	input_report_key(w_data->idev, KEY_RFKILL, 1);
> +	input_sync(w_data->idev);
> +	input_report_key(w_data->idev, KEY_RFKILL, 0);
> +	input_sync(w_data->idev);
>  }
>  
>  static int asus_wireless_add(struct acpi_device *adev)
> @@ -169,16 +172,20 @@ static int asus_wireless_add(struct acpi_device *adev)
>  	data->led.max_brightness = 1;
>  	data->led.default_trigger = "rfkill-none";
>  	err = devm_led_classdev_register(&adev->dev, &data->led);
> -	if (err)
> +	if (err) {
>  		destroy_workqueue(data->wq);
> +		return err;
> +	}
>  
> -	return err;
> +	return acpi_device_install_event_handler(adev, ACPI_DEVICE_NOTIFY, asus_wireless_notify);

So if acpi_device_install_event_handler() returns error, should you 
rollback something here like the error branch above? If that's the case, 
use goto to rollback as you'll have two places calling destroy_workqueue() 
already.

-- 
 i.


>  }
>  
>  static void asus_wireless_remove(struct acpi_device *adev)
>  {
>  	struct asus_wireless_data *data = acpi_driver_data(adev);
>  
> +	acpi_device_remove_event_handler(adev, ACPI_DEVICE_NOTIFY, asus_wireless_notify);
> +
>  	if (data->wq) {
>  		devm_led_classdev_unregister(&adev->dev, &data->led);
>  		destroy_workqueue(data->wq);
> @@ -192,7 +199,6 @@ static struct acpi_driver asus_wireless_driver = {
>  	.ops = {
>  		.add = asus_wireless_add,
>  		.remove = asus_wireless_remove,
> -		.notify = asus_wireless_notify,
>  	},
>  };
>  module_acpi_driver(asus_wireless_driver);
> 
