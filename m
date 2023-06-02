Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C45E37203D0
	for <lists+linux-acpi@lfdr.de>; Fri,  2 Jun 2023 15:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234451AbjFBN5a (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 2 Jun 2023 09:57:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234217AbjFBN53 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 2 Jun 2023 09:57:29 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2792813E;
        Fri,  2 Jun 2023 06:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685714248; x=1717250248;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=N6fMTAMXn7+yVg6nXYvk7Y7Olo6bjer2KoX7a4b1534=;
  b=FEfTMvTj+nCOaAyUj8W5+RXzgkXkWxHg+PE30UC8afExNypTBHJtyB4+
   +fWFIuHpvR1tkPbG5FDaFyJ7VdUARor8baPzCQNJlzZI929gv9HsbbAna
   iBAnjuZ4HOAa3AXn/cEvWNyGDbUu5ivHkXktkFYeaa8agnLpRYAF2pQ/+
   qDlSYgi/jEQD2M04rr9flArWFmrEVJXZNP98mM6SfjecxJ+w4CLjsWbnG
   bDr6kvK/qnBYbkhPtltbM9CLaHJe5d+kEQKiaDg3FSJuutaeJvEx2t4E/
   BkXgXZlmRHiECRXUpXD4A7mQzlHKoblH5tAgI1SmmZoM00wEw4T4WfTKR
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10729"; a="359172586"
X-IronPort-AV: E=Sophos;i="6.00,213,1681196400"; 
   d="scan'208";a="359172586"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2023 06:55:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10729"; a="707858812"
X-IronPort-AV: E=Sophos;i="6.00,213,1681196400"; 
   d="scan'208";a="707858812"
Received: from rspatil-mobl3.gar.corp.intel.com ([10.251.208.112])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2023 06:55:33 -0700
Date:   Fri, 2 Jun 2023 16:55:30 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     "Wilczynski, Michal" <michal.wilczynski@intel.com>
cc:     Jonathan Woithe <jwoithe@just42.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org,
        rafael@kernel.org
Subject: Re: [PATCH v4 21/35] platform/x86/fujitsu-laptop: Move handler
 installing logic to driver
In-Reply-To: <7fcb9041-9a78-ac9e-6a23-47bbccdfd30a@intel.com>
Message-ID: <e0f67199-9feb-432c-f0cb-7bdbdaf9ff63@linux.intel.com>
References: <20230601131739.300760-3-michal.wilczynski@intel.com> <20230601131739.300760-22-michal.wilczynski@intel.com> <f0e58bde-c1e6-872e-3879-ab3c2dadfd7@linux.intel.com> <7fcb9041-9a78-ac9e-6a23-47bbccdfd30a@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1537714147-1685714135=:1742"
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1537714147-1685714135=:1742
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Fri, 2 Jun 2023, Wilczynski, Michal wrote:
> On 6/2/2023 3:30 PM, Ilpo Järvinen wrote:
> > On Thu, 1 Jun 2023, Michal Wilczynski wrote:
> >
> >> Currently logic for installing notifications from ACPI devices is
> >> implemented using notify callback in struct acpi_driver. Preparations
> >> are being made to replace acpi_driver with more generic struct
> >> platform_driver, which doesn't contain notify callback. Furthermore
> >> as of now handlers are being called indirectly through
> >> acpi_notify_device(), which decreases performance.
> >>
> >> Call acpi_device_install_event_handler() at the end of .add() callback.
> >> Call acpi_device_remove_event_handler() at the beginning of .remove()
> >> callback. Change arguments passed to the notify callback to match with
> >> what's required by acpi_device_install_event_handler().
> >>
> >> Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
> >> ---
> >>  drivers/platform/x86/fujitsu-laptop.c | 86 +++++++++++++++++----------
> >>  1 file changed, 54 insertions(+), 32 deletions(-)
> >>
> >> diff --git a/drivers/platform/x86/fujitsu-laptop.c b/drivers/platform/x86/fujitsu-laptop.c
> >> index 085e044e888e..001333edba9f 100644
> >> --- a/drivers/platform/x86/fujitsu-laptop.c
> >> +++ b/drivers/platform/x86/fujitsu-laptop.c
> >> @@ -136,6 +136,8 @@ struct fujitsu_laptop {
> >>  
> >>  static struct acpi_device *fext;
> >>  
> >> +static void acpi_fujitsu_laptop_notify(acpi_handle handle, u32 event, void *data);
> >> +
> >>  /* Fujitsu ACPI interface function */
> >>  
> >>  static int call_fext_func(struct acpi_device *device,
> >> @@ -382,6 +384,37 @@ static int fujitsu_backlight_register(struct acpi_device *device)
> >>  	return 0;
> >>  }
> >>  
> >> +static void acpi_fujitsu_bl_notify(acpi_handle handle, u32 event, void *data)
> >> +{
> >> +	struct acpi_device *device = data;
> >> +	struct fujitsu_bl *priv;
> >> +	int oldb, newb;
> >> +
> >> +	priv = acpi_driver_data(device);
> >> +
> >> +	if (event != ACPI_FUJITSU_NOTIFY_CODE) {
> >> +		acpi_handle_info(device->handle, "unsupported event [0x%x]\n",
> >> +				 event);
> >> +		sparse_keymap_report_event(priv->input, -1, 1, true);
> >> +		return;
> >> +	}
> >> +
> >> +	oldb = priv->brightness_level;
> >> +	get_lcd_level(device);
> >> +	newb = priv->brightness_level;
> >> +
> >> +	acpi_handle_debug(device->handle,
> >> +			  "brightness button event [%i -> %i]\n", oldb, newb);
> >> +
> >> +	if (oldb == newb)
> >> +		return;
> >> +
> >> +	if (!disable_brightness_adjust)
> >> +		set_lcd_level(device, newb);
> >> +
> >> +	sparse_keymap_report_event(priv->input, oldb < newb, 1, true);
> >> +}
> >> +
> >>  static int acpi_fujitsu_bl_add(struct acpi_device *device)
> >>  {
> >>  	struct fujitsu_bl *priv;
> >> @@ -410,37 +443,17 @@ static int acpi_fujitsu_bl_add(struct acpi_device *device)
> >>  	if (ret)
> >>  		return ret;
> >>  
> >> -	return fujitsu_backlight_register(device);
> >> -}
> >> +	ret = fujitsu_backlight_register(device);
> >> +	if (ret)
> >> +		return ret;
> >>  
> >> -/* Brightness notify */
> >> +	return acpi_device_install_event_handler(device, ACPI_DEVICE_NOTIFY,
> >> +						 acpi_fujitsu_bl_notify);
> >> +}
> >>  
> >> -static void acpi_fujitsu_bl_notify(struct acpi_device *device, u32 event)
> >> +static void acpi_fujitsu_bl_remove(struct acpi_device *device)
> >>  {
> >> -	struct fujitsu_bl *priv = acpi_driver_data(device);
> >> -	int oldb, newb;
> >> -
> >> -	if (event != ACPI_FUJITSU_NOTIFY_CODE) {
> >> -		acpi_handle_info(device->handle, "unsupported event [0x%x]\n",
> >> -				 event);
> >> -		sparse_keymap_report_event(priv->input, -1, 1, true);
> >> -		return;
> >> -	}
> >> -
> >> -	oldb = priv->brightness_level;
> >> -	get_lcd_level(device);
> >> -	newb = priv->brightness_level;
> >> -
> >> -	acpi_handle_debug(device->handle,
> >> -			  "brightness button event [%i -> %i]\n", oldb, newb);
> >> -
> >> -	if (oldb == newb)
> >> -		return;
> >> -
> >> -	if (!disable_brightness_adjust)
> >> -		set_lcd_level(device, newb);
> >> -
> >> -	sparse_keymap_report_event(priv->input, oldb < newb, 1, true);
> >> +	acpi_device_remove_event_handler(device, ACPI_DEVICE_NOTIFY, acpi_fujitsu_bl_notify);
> > Please move the function in a separate (no function changes intended) 
> > patch to keep this patch on point.
> 
> Sure I can do that, however this moving around make sense in context of this patch as
> it's necessary to compile with the new event installation method.

You move the function in one patch without changing anything else. And 
then in another change that is this notify change you make the necessary 
adjustments to the moved function.

It makes both patches easier to review because one is a trivial copy and 
notify related changes are no longer mixed up with the copy.

-- 
 i.

--8323329-1537714147-1685714135=:1742--
