Return-Path: <linux-acpi+bounces-1347-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 409EC7E5200
	for <lists+linux-acpi@lfdr.de>; Wed,  8 Nov 2023 09:32:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A0D81C209E0
	for <lists+linux-acpi@lfdr.de>; Wed,  8 Nov 2023 08:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCB4CDDBA
	for <lists+linux-acpi@lfdr.de>; Wed,  8 Nov 2023 08:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T3iJ9P68"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EECED28B
	for <linux-acpi@vger.kernel.org>; Wed,  8 Nov 2023 07:36:17 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7588EAF
	for <linux-acpi@vger.kernel.org>; Tue,  7 Nov 2023 23:36:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699428977; x=1730964977;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vI303wEM4VL0q5j8BrE4LwrH2ubZOaysvrb+ifz5lKA=;
  b=T3iJ9P68YGDLJGGs6R8P9/Eq8uh8ozbIDSgHGLIU8BKQGebXSL//oTU/
   Ckn/UIWIZyR+eO7J8vY75IEW1wLm1T6/Fl76kt0c/ur17/h9gM4LW42DP
   xRotNM/K8ihkJpRihGRS0D+wGg4MLrIjZek49q3cnOV9ir1WYK9wm1zHm
   Ro1CuLCmxldfM/QiaENxBzBIssO2Ats/wV+hIu5NyZU36s9jMK8ljqVMM
   G8TkfOe9zXdHjZw8/Ci8tf+UPthNekJkKW2MiDZJeRek+DJ5tEX2027oF
   G7SVvo0FeiBDrL1442XDW6GPB4oL9RX4J3L9h69Xtzmk/RG8ajaygudhT
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10887"; a="456205388"
X-IronPort-AV: E=Sophos;i="6.03,285,1694761200"; 
   d="scan'208";a="456205388"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2023 23:36:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10887"; a="828876707"
X-IronPort-AV: E=Sophos;i="6.03,285,1694761200"; 
   d="scan'208";a="828876707"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga008.fm.intel.com with SMTP; 07 Nov 2023 23:36:14 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 08 Nov 2023 09:36:13 +0200
Date: Wed, 8 Nov 2023 09:36:13 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, andriy.shevchenko@linux.intel.com,
	Daniel Scally <djrscally@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v4 1/3] acpi: property: Let args be NULL in
 __acpi_node_get_property_reference
Message-ID: <ZUs6bcL1Fkt15PUv@kuha.fi.intel.com>
References: <20231103083625.1229008-1-sakari.ailus@linux.intel.com>
 <20231103083625.1229008-2-sakari.ailus@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231103083625.1229008-2-sakari.ailus@linux.intel.com>

On Fri, Nov 03, 2023 at 10:36:23AM +0200, Sakari Ailus wrote:
> fwnode_get_property_reference_args() may not be called with args argument
> NULL on ACPI, OF already supports this. Add the missing NULL checks and
> document this.
> 
> The purpose is to be able to count the references.
> 
> Fixes: 977d5ad39f3e ("ACPI: Convert ACPI reference args to generic fwnode reference args")
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/acpi/property.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
> index 413e4fcadcaf..93608714b652 100644
> --- a/drivers/acpi/property.c
> +++ b/drivers/acpi/property.c
> @@ -851,6 +851,7 @@ static int acpi_get_ref_args(struct fwnode_reference_args *args,
>   * @index: Index of the reference to return
>   * @num_args: Maximum number of arguments after each reference
>   * @args: Location to store the returned reference with optional arguments
> + *	  (may be NULL)
>   *
>   * Find property with @name, verifify that it is a package containing at least
>   * one object reference and if so, store the ACPI device object pointer to the
> @@ -907,6 +908,9 @@ int __acpi_node_get_property_reference(const struct fwnode_handle *fwnode,
>  		if (!device)
>  			return -EINVAL;
>  
> +		if (!args)
> +			return 0;
> +
>  		args->fwnode = acpi_fwnode_handle(device);
>  		args->nargs = 0;
>  		return 0;
> -- 
> 2.39.2

-- 
heikki

