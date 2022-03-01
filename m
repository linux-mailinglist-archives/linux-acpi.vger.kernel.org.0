Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BEFF4C84AB
	for <lists+linux-acpi@lfdr.de>; Tue,  1 Mar 2022 08:08:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232768AbiCAHJV (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 1 Mar 2022 02:09:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232777AbiCAHJU (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 1 Mar 2022 02:09:20 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0DF1DFD2
        for <linux-acpi@vger.kernel.org>; Mon, 28 Feb 2022 23:08:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646118520; x=1677654520;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dWKHu4Nx3C8imo60m+H/A8aqhGgS2o3EQ0Q6nlaNX4U=;
  b=X5+RVHWDnmYU35bDwWkVkHfWIr4bkp+jScE7q4PL0WCBEooO5b7QuWFH
   uRt4bIYo0s2V6VDyXRPhgPT/7yme07bi/6/z5wJRGbPFfTn8tOqhCy1oG
   4mFDKA7a958co3I1MEY7wDt9uRIT7l+g7PImIU/zpyDRgTrhRWtFa6n0r
   m+xFwzcjTLHHD+UVy1+6hU5NmBfZaNSsw9Tkmqr/Uu6X3YJct+fi+mQLm
   Yq2hbEA9RY46bCjqT8Fj97sG4H+ZcfP2HS86hZZX9/dnE5yK3NBiksJtB
   MB7rYoDK27eOJ81aP95y7tG84om9nga014P/wg7wuxrxnhyyH8didwLuC
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10272"; a="339507482"
X-IronPort-AV: E=Sophos;i="5.90,145,1643702400"; 
   d="scan'208";a="339507482"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2022 23:08:40 -0800
X-IronPort-AV: E=Sophos;i="5.90,145,1643702400"; 
   d="scan'208";a="641157873"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2022 23:08:37 -0800
Received: by lahna (sSMTP sendmail emulation); Tue, 01 Mar 2022 09:08:34 +0200
Date:   Tue, 1 Mar 2022 09:08:34 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        linux-acpi@vger.kernel.org, Xiaomeng.Hou@amd.com,
        Aaron.Liu@amd.com, Ray.Huang@amd.com, hdegoede@redhat.com
Subject: Re: [PATCH v3 3/3] ACPI: bus: For platform OSC negotiate capabilities
Message-ID: <Yh3GchbsdO0hy/+W@lahna>
References: <20220228181446.1975420-1-mario.limonciello@amd.com>
 <20220228181446.1975420-3-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220228181446.1975420-3-mario.limonciello@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On Mon, Feb 28, 2022 at 12:14:46PM -0600, Mario Limonciello wrote:
> @@ -343,10 +345,34 @@ static void acpi_bus_osc_negotiate_platform_control(void)
>  	if (ACPI_FAILURE(acpi_get_handle(NULL, "\\_SB", &handle)))
>  		return;
>  
> -	if (ACPI_FAILURE(acpi_run_osc(handle, &context)))
> +	/*
> +	 * Check if bits were masked, we need to negotiate
> +	 * prevent potential endless loop by limited number of
> +	 * negotiation cycles.
> +	 */
> +	for (i = 0; i < 5; i++) {
> +		status = acpi_run_osc(handle, &context);
> +		if (ACPI_SUCCESS(status) || status == AE_SUPPORT) {

The previous patch says that AE_OK or AE_SUCCESS you need to free the
result but here we get AE_SUPPORT and you still do the kfree(). Is that
intented?

> +			capbuf_ret = context.ret.pointer;
> +			capbuf[OSC_SUPPORT_DWORD] = capbuf_ret[OSC_SUPPORT_DWORD];
> +			kfree(context.ret.pointer);
> +		}
