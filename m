Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8989E66E220
	for <lists+linux-acpi@lfdr.de>; Tue, 17 Jan 2023 16:28:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232850AbjAQP2A (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 17 Jan 2023 10:28:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232997AbjAQP1g (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 17 Jan 2023 10:27:36 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 626BF10419;
        Tue, 17 Jan 2023 07:27:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673969254; x=1705505254;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MzeUEbcOgPh7O9+bZQLv8SXpzHEpErBVeiwVj6I+yXU=;
  b=hQvmfB9nh1WohfPxZ+nJ3zv5JLlKtBY3/VgbSSrfGfAZ6fq/mJZWZ5xc
   SdR/Ixq0s2zonpDbLgr5LSNuDHE1ja84XLntQuEhNhsKdFGVzs1j+Wrot
   ttpXdSMg00kApgMPTJwUF+WZehCK+Mynp/4kxnuTQvkzSFQF2wLR06PPh
   u/+LI6ePN+A+jDiYfgGrb1HmmtWbnIEqJF8u5WSu8E7NS0XFiEgcT8yDu
   aqXz2ItTXU3HGjvwn2dMkG5T/LyTl9FgZYXhEtolEVWtnF75a6cHjC85P
   QlQMY9xgDnor1cKDJAGM++G0V3+HVyuutxe3vxihgODerDRGFr+x1kXV4
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="387067563"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="387067563"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 07:27:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="661325760"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="661325760"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007.fm.intel.com with ESMTP; 17 Jan 2023 07:27:14 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pHnrl-00AdSk-1g;
        Tue, 17 Jan 2023 17:27:13 +0200
Date:   Tue, 17 Jan 2023 17:27:13 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, rafael@kernel.org,
        linux-media@vger.kernel.org, heikki.krogerus@linux.intel.com
Subject: Re: [PATCH 6/8] ACPI: property: Rename parsed MIPI DisCo for Imaging
 properties
Message-ID: <Y8a+USbrWoCw/EFG@smile.fi.intel.com>
References: <20230117122244.2546597-1-sakari.ailus@linux.intel.com>
 <20230117122244.2546597-7-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230117122244.2546597-7-sakari.ailus@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Jan 17, 2023 at 02:22:42PM +0200, Sakari Ailus wrote:
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

> +static const struct mipi_disco_prop {
> +	const char *mipi_prop;
> +	const char *dt_prop;
> +} mipi_disco_props[] = {
> +	{ "mipi-img-lens-focus", "lens-focus" },
> +	{ "mipi-img-flash-leds", "flash-leds" },
> +	{ "mipi-img-clock-frequency", "clock-frequency" },
> +	{ "mipi-img-led-max-current", "led-max-microamp" },
> +	{ "mipi-img-flash-max-current", "flash-max-microamp" },
> +	{ "mipi-img-flash-max-timeout", "flash-max-timeout-us" },
> +};

If we split this to 2 arrays (with static_assert() against their sizes)...

...

> +void acpi_properties_prepare_mipi(union acpi_object *elements)
> +{
> +	unsigned int i;
> +
> +	/* Replace MIPI DisCo for Imaging property names with DT equivalents. */
> +	for (i = 0; i < ARRAY_SIZE(mipi_disco_props); i++) {
> +		if (!strcmp(mipi_disco_props[i].mipi_prop,
> +			    elements[0].string.pointer)) {

...we can utilise match_string() here.

> +			WARN_ON(strscpy(elements[0].string.pointer,
> +					mipi_disco_props[i].dt_prop,
> +					elements[0].string.length) < 0);
> +			break;
> +		}
> +	}
> +}

...

>  	for (i = 0; i < properties->package.count; i++) {
> -		const union acpi_object *property;
> +		union acpi_object *property = &properties->package.elements[i];
> +		union acpi_object *elements = property->package.elements;
>  
> -		property = &properties->package.elements[i];
>  		/*
>  		 * Only two elements allowed, the first one must be a string and
>  		 * the second one has to satisfy certain conditions.
>  		 */
>  		if (property->package.count != 2
> -		    || property->package.elements[0].type != ACPI_TYPE_STRING
> -		    || !acpi_property_value_ok(&property->package.elements[1]))
> +		    || elements[0].type != ACPI_TYPE_STRING
> +		    || !acpi_property_value_ok(&elements[1]))

While at it you can mode ||:s on the respective previous lines.

>  			return false;
> +
> +		acpi_properties_prepare_mipi(elements);
>  	}

-- 
With Best Regards,
Andy Shevchenko


