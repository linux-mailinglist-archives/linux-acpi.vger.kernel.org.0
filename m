Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 068FD4C7255
	for <lists+linux-acpi@lfdr.de>; Mon, 28 Feb 2022 18:14:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbiB1RPR (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 28 Feb 2022 12:15:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiB1RPQ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 28 Feb 2022 12:15:16 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACC6840E76
        for <linux-acpi@vger.kernel.org>; Mon, 28 Feb 2022 09:14:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646068476; x=1677604476;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=q7OzNQlJEsKhKsDXUecBuVlOTNvVG5PsRzj0U8KGU5k=;
  b=Uw+36wuptRAza2n6bep0x6LIs8HUYu23qkhWKBVAvksIwwGmAY0kbxOX
   s38wQeTjberzIrEpOFmEGuU91TyUqL+rVHZyZlqV688WGGICIftjzboCQ
   sVwFGf13ZUtUgqkfEZKQ2qpTTl8df5if5GKNJcJwuPEJuBTOr1HKHoONd
   F+HvaEB9ouHykkBm5T0c86/BXi2MRBZa1Oa/Jme9q5vfI/JSfZBAF76hk
   2vcq2s9dfq07agTRydV/mwffKy7QQJPPhjweMcu4Dqjdtqn6b+nTa58N9
   DOhdWTFTZ3Ei3q7snlozA29+/16GngV1UQpAdSzLV4OvvnyYJl2JW2DER
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10272"; a="250519257"
X-IronPort-AV: E=Sophos;i="5.90,142,1643702400"; 
   d="scan'208";a="250519257"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2022 09:12:34 -0800
X-IronPort-AV: E=Sophos;i="5.90,142,1643702400"; 
   d="scan'208";a="640949564"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2022 09:12:31 -0800
Received: by lahna (sSMTP sendmail emulation); Mon, 28 Feb 2022 19:11:18 +0200
Date:   Mon, 28 Feb 2022 19:11:18 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        linux-acpi@vger.kernel.org, Xiaomeng.Hou@amd.com,
        Aaron.Liu@amd.com, Ray.Huang@amd.com, hdegoede@redhat.com
Subject: Re: [PATCH v2 3/3] ACPI: bus: For platform OSC negotiate capabilities
Message-ID: <Yh0CNnwgfCxQwpWv@lahna>
References: <20220225055224.190669-1-mario.limonciello@amd.com>
 <20220225055224.190669-3-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220225055224.190669-3-mario.limonciello@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Feb 24, 2022 at 11:52:24PM -0600, Mario Limonciello wrote:
> According to the ACPI 6.4 spec:
> It is strongly recommended that the OS evaluate _OSC with the Query
> Support Flag set until _OSC returns the Capabilities Masked bit clear,
> to negotiate the set of features to be granted to the OS for native
> support; a platform may require a specific combination of features
> to be supported natively by an OS before granting native control
> of a given feature. After negotiation with the query flag set,
> the OS should evaluate without it so that any negotiated values
> can be made effective to hardware.
> 
> Currently the code sends the exact same values in both executions of the
> OSC and this leads to some problems on some AMD platforms in certain

_OSC

> configurations.
> 
> The following notable capabilities are set by OSPM when query is enabled:
> * OSC_SB_PR3_SUPPORT
> * OSC_SB_PCLPI_SUPPORT
> * OSC_SB_NATIVE_USB4_SUPPORT
> 
> The first call to the platform OSC returns back a masked capabilities
> error because the firmware did not acknolwedge OSC_SB_PCLPI_SUPPORT but

acknowledge

> it acknolwedged the others.
> 
> The second call to the platform OSC without the query flag set then

_OSC

> fails because the OSPM still sent the exact same values.  This leads
> to not acknowledging OSC_SB_NATIVE_USB4_SUPPORT and later USB4 PCIe
> tunnels can't be authorized.
> 
> This problem was first introduced by commit 159d8c274fd9 ("ACPI: Pass the
> same capabilities to the _OSC regardless of the query flag") which subtly
> adjusted the behavior from 719e1f5 ("ACPI: Execute platform _OSC also
> with query bit clear").
> 
> The OSC was called exactly 2 times:
>  * Once to query and request from firmware
>  * Once to commit to firmware without query
> 
> To fix this problem, continue to call the OSC until the firmware has

_OSC

> indicated that capabilities are no longer masked or after an arbitrary
> number of negotiation attempts.
> 
> Furthermore, to avoid the problem that commit 159d8c274fd9 ("ACPI: Pass
> the same capabilities to the _OSC regardless of the query flag")
> introduced, explicitly mark support for CPC and CPPCv2 even if they
> were masked by the series of query calls due to table loading order on
> some systems.
> 
> Fixes: 159d8c274fd9 ("ACPI: Pass the same capabilities to the _OSC regardless of the query flag")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> changes from v1->v2:
> * Fix a NULL pointer dereference caught by 0day CI
>  drivers/acpi/bus.c | 30 ++++++++++++++++++++++++++++--
>  1 file changed, 28 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> index f0f9e0934c10..489cc4f6b6e6 100644
> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -297,6 +297,8 @@ static void acpi_bus_osc_negotiate_platform_control(void)
>  		.cap.pointer = capbuf,
>  	};
>  	acpi_handle handle;
> +	acpi_status status;
> +	int i;
>  
>  	capbuf[OSC_QUERY_DWORD] = OSC_QUERY_ENABLE;
>  	capbuf[OSC_SUPPORT_DWORD] = OSC_SB_PR3_SUPPORT; /* _PR3 is in use */
> @@ -332,10 +334,34 @@ static void acpi_bus_osc_negotiate_platform_control(void)
>  	if (ACPI_FAILURE(acpi_get_handle(NULL, "\\_SB", &handle)))
>  		return;
>  
> -	if (ACPI_FAILURE(acpi_run_osc(handle, &context)))
> +	/*
> +	 * check if bits were masked, we need to negotiate
> +	 * prevent potential endless loop by limited number of
> +	 * negotiation cycles

Start with capital letter and end with '.' a multiline comment.

/*
 * Check if ...
 * ...
 * negotiation cycles.
 */

> +	 */
> +	for (i = 0; i < 5; i++) {
> +		status = acpi_run_osc(handle, &context);
> +		if (ACPI_SUCCESS(status) || status == AE_SUPPORT) {
> +			capbuf_ret = context.ret.pointer;
> +			capbuf[OSC_SUPPORT_DWORD] = capbuf_ret[OSC_SUPPORT_DWORD];
> +			kfree(context.ret.pointer);

I wonder if it makes sense to document the acpi_run_osc() to tell in
which return codes you actually need to kfree() the result. Here it is
hard to tell IMHO.

> +		}
> +		if (status != AE_SUPPORT)
> +			break;
> +	}
> +	if (ACPI_FAILURE(status))
>  		return;
>  
> -	kfree(context.ret.pointer);
> +	/*
> +	 * avoid problems with BIOS dynamically loading tables by indicating
> +	 * support for CPPC even if it was masked

Ditto for the comment.

> +	 */
> +#ifdef CONFIG_X86
> +	if (boot_cpu_has(X86_FEATURE_HWP)) {
> +		capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_CPC_SUPPORT;
> +		capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_CPCV2_SUPPORT;
> +	}
> +#endif
>  
>  	/* Now run _OSC again with query flag clear */
>  	capbuf[OSC_QUERY_DWORD] = 0;
> -- 
> 2.34.1
