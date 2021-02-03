Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 006A330D4FF
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Feb 2021 09:16:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232614AbhBCIPm (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 3 Feb 2021 03:15:42 -0500
Received: from mga12.intel.com ([192.55.52.136]:59776 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232561AbhBCIPm (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 3 Feb 2021 03:15:42 -0500
IronPort-SDR: Gd9tu4MAUgC8SGWBI0N4lyaFdcSDAF5rYK51lePd1emA0ULgab1AoG8l4WAZRQ6B6otdzOz3FL
 qemh3ryCBLbA==
X-IronPort-AV: E=McAfee;i="6000,8403,9883"; a="160170433"
X-IronPort-AV: E=Sophos;i="5.79,397,1602572400"; 
   d="scan'208";a="160170433"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2021 00:14:21 -0800
IronPort-SDR: Zz9BsWghIPqPVYqrEjlyGrzbzzZS1dlgETtp7d4ipnswJrLX8SLoV6CuDEgLoVmS2vG2z4itmR
 1UXIGXYFszDw==
X-IronPort-AV: E=Sophos;i="5.79,397,1602572400"; 
   d="scan'208";a="433292573"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2021 00:14:17 -0800
Received: by lahna (sSMTP sendmail emulation); Wed, 03 Feb 2021 10:14:15 +0200
Date:   Wed, 3 Feb 2021 10:14:15 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     linux-usb@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Yehezkel Bernat <YehezkelShB@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        Mario Limonciello <mario.limonciello@dell.com>,
        Christian Kellner <christian@kellner.me>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH v2 3/5] ACPI: Execute platform _OSC also with query bit
 clear
Message-ID: <20210203081415.GR2542@lahna.fi.intel.com>
References: <20210129083241.72497-1-mika.westerberg@linux.intel.com>
 <20210129083241.72497-4-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210129083241.72497-4-mika.westerberg@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Rafael,

I wonder if you are OK with this patch?

Thanks!

On Fri, Jan 29, 2021 at 11:32:39AM +0300, Mika Westerberg wrote:
> From: Mario Limonciello <mario.limonciello@dell.com>
> 
> The platform _OSC can change the hardware state when query bit is not
> set. According to ACPI spec it is recommended that the OS runs _OSC with
> query bit set until the platform does not mask any of the capabilities.
> Then it should run it with query bit clear in order to actually commit
> the changes. Linux has not been doing this for the reasons that there
> has not been anything to commit, until now.
> 
> The ACPI 6.4 introduced _OSC for USB4 to allow the OS to negotiate
> native control over USB4 tunneling. The platform might implement this so
> that it only activates the software connection manager path when the OS
> calls the _OSC with the query bit clear. Otherwise it may default to the
> firmware connection manager, for instance.
> 
> For this reason modify the _OSC support so that we first execute it with
> query bit set, then use the returned value as base of the features we
> want to control and run the _OSC again with query bit clear. This also
> follows what Windows is doing.
> 
> Also rename the function to better match what it does.
> 
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@dell.com>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
>  drivers/acpi/bus.c | 43 +++++++++++++++++++++++++++++++------------
>  1 file changed, 31 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> index 1682f8b454a2..a52cb28c40d8 100644
> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -282,9 +282,9 @@ bool osc_pc_lpi_support_confirmed;
>  EXPORT_SYMBOL_GPL(osc_pc_lpi_support_confirmed);
>  
>  static u8 sb_uuid_str[] = "0811B06E-4A27-44F9-8D60-3CBBC22E7B48";
> -static void acpi_bus_osc_support(void)
> +static void acpi_bus_osc_negotiate_platform_control(void)
>  {
> -	u32 capbuf[2];
> +	u32 capbuf[2], *capbuf_ret;
>  	struct acpi_osc_context context = {
>  		.uuid_str = sb_uuid_str,
>  		.rev = 1,
> @@ -321,17 +321,36 @@ static void acpi_bus_osc_support(void)
>  		capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_APEI_SUPPORT;
>  	if (ACPI_FAILURE(acpi_get_handle(NULL, "\\_SB", &handle)))
>  		return;
> -	if (ACPI_SUCCESS(acpi_run_osc(handle, &context))) {
> -		u32 *capbuf_ret = context.ret.pointer;
> -		if (context.ret.length > OSC_SUPPORT_DWORD) {
> -			osc_sb_apei_support_acked =
> -				capbuf_ret[OSC_SUPPORT_DWORD] & OSC_SB_APEI_SUPPORT;
> -			osc_pc_lpi_support_confirmed =
> -				capbuf_ret[OSC_SUPPORT_DWORD] & OSC_SB_PCLPI_SUPPORT;
> -		}
> +
> +	if (ACPI_FAILURE(acpi_run_osc(handle, &context)))
> +		return;
> +
> +	capbuf_ret = context.ret.pointer;
> +	if (context.ret.length <= OSC_SUPPORT_DWORD) {
>  		kfree(context.ret.pointer);
> +		return;
>  	}
> -	/* do we need to check other returned cap? Sounds no */
> +
> +	/*
> +	 * Now run _OSC again with query flag clear and with the caps
> +	 * supported by both the OS and the platform.
> +	 */
> +	capbuf[OSC_QUERY_DWORD] = 0;
> +	capbuf[OSC_SUPPORT_DWORD] = capbuf_ret[OSC_SUPPORT_DWORD];
> +	kfree(context.ret.pointer);
> +
> +	if (ACPI_FAILURE(acpi_run_osc(handle, &context)))
> +		return;
> +
> +	capbuf_ret = context.ret.pointer;
> +	if (context.ret.length > OSC_SUPPORT_DWORD) {
> +		osc_sb_apei_support_acked =
> +			capbuf_ret[OSC_SUPPORT_DWORD] & OSC_SB_APEI_SUPPORT;
> +		osc_pc_lpi_support_confirmed =
> +			capbuf_ret[OSC_SUPPORT_DWORD] & OSC_SB_PCLPI_SUPPORT;
> +	}
> +
> +	kfree(context.ret.pointer);
>  }
>  
>  /* --------------------------------------------------------------------------
> @@ -1168,7 +1187,7 @@ static int __init acpi_bus_init(void)
>  	 * _OSC method may exist in module level code,
>  	 * so it must be run after ACPI_FULL_INITIALIZATION
>  	 */
> -	acpi_bus_osc_support();
> +	acpi_bus_osc_negotiate_platform_control();
>  
>  	/*
>  	 * _PDC control method may load dynamic SSDT tables,
> -- 
> 2.29.2
