Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD3E68F3CF
	for <lists+linux-acpi@lfdr.de>; Wed,  8 Feb 2023 17:56:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbjBHQ4d (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 8 Feb 2023 11:56:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjBHQ4c (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 8 Feb 2023 11:56:32 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BECF124;
        Wed,  8 Feb 2023 08:56:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675875392; x=1707411392;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bxFg0pWxsxRELvZPlRbJgJ77eEY7G6+IZ2bFcw/sTpU=;
  b=nOZGmcFj/1u2wA9lrnzlNq54iPmyP4Ujm9TyeFD5V1QWcRcJYZLtX2fA
   FUdS5174oU1gDUSeOHw5Cz9lsGsOdZAFvtf7XvwV0hOtaK7P9udWTeakR
   mJZXRfNr7qd5359jb41sdKTWkB5avgk1dcXzKNfeatUDUPXzO8Cc+XwCJ
   5CFg5qvRvg6ws7SkqtdM3450qajSkuazR5jKissM1MJWONlEzW80VMwmc
   xQGQStittpjogiWTXKfZuOKX+kWo2G+k8jwS99JN0j/o0QLZAcIsS+vs0
   QstmdcqLhTid1zucPyr2QNuX8BOyRXnv1QFEFVeEyn33OSaBlNGq07ULF
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="313491813"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="313491813"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 08:56:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="669252601"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="669252601"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007.fm.intel.com with ESMTP; 08 Feb 2023 08:56:29 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pPnkB-004DX8-1V;
        Wed, 08 Feb 2023 18:56:27 +0200
Date:   Wed, 8 Feb 2023 18:56:27 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, linux-media@vger.kernel.org,
        rafael@kernel.org, heikki.krogerus@linux.intel.com
Subject: Re: [PATCH v4 6/8] ACPI: property: Rename parsed MIPI DisCo for
 Imaging properties
Message-ID: <Y+PUO3a8ZOq0Haa2@smile.fi.intel.com>
References: <20230208152807.3064242-1-sakari.ailus@linux.intel.com>
 <20230208152807.3064242-7-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230208152807.3064242-7-sakari.ailus@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Feb 08, 2023 at 05:28:05PM +0200, Sakari Ailus wrote:
> MIPI DisCo for Imaging defines properties for sensor-adjacent devices such
> as EEPROM, LED flash or lens VCM as either device or sub-node references.
> This is compliant with existing DT definitions apart from property names.
> 
> Rename parsed MIPI-defined properties so drivers will have a unified view
> of them as defined in DT and already parsed by drivers. This can be done
> in-place as the MIPI-defined property strings are always longer than the
> DT one. This also results in loss of constness in parser function
> arguments.
> 
> Individual bindings to devices could define the references differently
> between MIPI DisCo for Imaging and DT, in terms of device or sub-node
> references. This will still need to be handled in the drivers themselves.

...

> +void acpi_properties_prepare_mipi(union acpi_object *elements)
> +{
> +	unsigned int i;
> +
> +	/* Replace MIPI DisCo for Imaging property names with DT equivalents. */
> +	for (i = 0; i < ARRAY_SIZE(mipi_disco_props); i++) {
> +		if (!strcmp(mipi_disco_props[i].mipi_prop,
> +			    elements[0].string.pointer)) {

	/* const ? */ char *e0 = elements[0].string.pointer;
	...

		if (!strcmp(mipi_disco_props[i].mipi_prop, e0)) {

> +			WARN_ON(strscpy(elements[0].string.pointer,
> +					mipi_disco_props[i].dt_prop,
> +					elements[0].string.length) < 0);

			WARN_ON(strscpy(e0, mipi_disco_props[i].dt_prop,
					elements[0].string.pointer) < 0);
?

> +			break;
> +		}
> +	}
> +}

-- 
With Best Regards,
Andy Shevchenko


