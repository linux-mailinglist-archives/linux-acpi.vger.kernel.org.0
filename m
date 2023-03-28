Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86A816CC717
	for <lists+linux-acpi@lfdr.de>; Tue, 28 Mar 2023 17:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233038AbjC1Pvf (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 28 Mar 2023 11:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbjC1Pve (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 28 Mar 2023 11:51:34 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6F9312B;
        Tue, 28 Mar 2023 08:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680018693; x=1711554693;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0nSoSNXiaFDFfSdf6u5PpJmJLoPPXYLu7h/jJYM39go=;
  b=BSZfwXBH/yZCou7vrkYhUfxtKfmNq2TOzIbNy3Ym533okekTkOEiVtkK
   0ZNYIbEdDXeXon19iLJOO2Tc3oLUY723pOgXuljTg2JdbipBDNYnERZKw
   3jwGjxN8M1RPeoo9x/jWNarA3cfQ6mEnbJYLFA2BrQCqWjWKWRHgaWKSn
   Y2fH/jI9yxdgeI+Ko/kcVANfV50YHvBAPQrE3ioECcVpvZYKhD8oR8cVL
   PtOeGKywgNUqmhOtM8IxNKdlc7Vnvmqs9MmNXa23F/dGJbsQpON1/LhqA
   PcIuIYVIN+lVFYdMtdfVW5nuzRBIA18vM9/hJQKkxYHtXQuf3FjQwR0rb
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="426879013"
X-IronPort-AV: E=Sophos;i="5.98,297,1673942400"; 
   d="scan'208";a="426879013"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 08:51:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="714295226"
X-IronPort-AV: E=Sophos;i="5.98,297,1673942400"; 
   d="scan'208";a="714295226"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008.jf.intel.com with ESMTP; 28 Mar 2023 08:51:30 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1phBbd-009gMH-2h;
        Tue, 28 Mar 2023 18:51:29 +0300
Date:   Tue, 28 Mar 2023 18:51:29 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, linux-media@vger.kernel.org,
        rafael@kernel.org, heikki.krogerus@linux.intel.com
Subject: Re: [PATCH v7 06/10] ACPI: scan: Generate software nodes based on
 MIPI DisCo for Imaging
Message-ID: <ZCMNAR3VJAzOZww3@smile.fi.intel.com>
References: <20230328101303.1458570-1-sakari.ailus@linux.intel.com>
 <20230328101303.1458570-7-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230328101303.1458570-7-sakari.ailus@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Mar 28, 2023 at 01:12:59PM +0300, Sakari Ailus wrote:
> Generate software nodes for driver use, based on MIPI DisCo for Imaging
> definitions.
> 
> During the (sub-)namespace walk, ACPI device nodes are created but the
> drivers aren't probed for the devices yet. A convenient way to determine
> which ACPI devices this applies to is to find a hierarchical data node that
> begins with "mipi-img-port-". These devices need software nodes that need
> to be present before probing, and can only be constructed once the related
> _CRS CSI2 records have been parsed.

...

> -	static const char mipi_port_prefix[] = "mipi-img-port-";
> -	char mipi_port_name[sizeof(mipi_port_prefix) + 2];
> +	char mipi_port_name[sizeof(MIPI_IMG_PORT_PREFIX) + 2];
>  
>  	if (snprintf(mipi_port_name, sizeof(mipi_port_name), "%s%u",
> -		     mipi_port_prefix, port) >= sizeof(mipi_port_name)) {
> +		     MIPI_IMG_PORT_PREFIX, port) >= sizeof(mipi_port_name)) {

You are modifying lines you just brought by the previous patch. Why this mess?

...

> -static void acpi_bus_handle_postpone(acpi_handle handle,
> -				     struct list_head *head)
> +static void acpi_bus_handle_postpone(acpi_handle handle, struct list_head *head)

Unrelated change?

...

> +/**
> + * acpi_bus_device_postpone - Add an ACPI device to a given postponed list
> + * @device: The ACPI device
> + * @head: Postponed list head
> + *
> + * Add a given ACPI device to a list of ACPI objects for which the creation
> + * of the device objects is to be postponed.
> + */
> +void acpi_bus_device_postpone(struct acpi_device *device,
> +			      struct list_head *head)

Taking into account above indentation, why not to have them on one line to
begin with?

-- 
With Best Regards,
Andy Shevchenko


