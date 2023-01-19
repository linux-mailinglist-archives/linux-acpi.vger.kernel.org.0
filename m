Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82DC0673DCE
	for <lists+linux-acpi@lfdr.de>; Thu, 19 Jan 2023 16:45:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231294AbjASPpq (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 19 Jan 2023 10:45:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231292AbjASPpo (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 19 Jan 2023 10:45:44 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FE3C86EFF;
        Thu, 19 Jan 2023 07:45:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674143139; x=1705679139;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1pTH3nv+H6gyIQDKESVBTwVHB2XRwTQDjWoAtcGBsNw=;
  b=DD9VfrD36PvTKRyxGjZH/JjuhydMI1KiN2EMSrlPdwzA3daxRsToEF5z
   7LXOcb1f1FKgZ29AB45lZTC2c5NRno55slpVgCJjksOJv2cGoDGkg35CE
   AagCLcVRlX2HSA9QC3jgELp53cobmcT73djy/9jd6PMApPpGbS/AJiwBs
   5eB4S40aMLRvH+LzpXHjM4rA//RTrNG5Z5hBkix80vonRL2reHmCtV1N0
   AOaUweUVLGGP9zyu+AqeeSgMPFxq8mgwKIX5HpdRhc7tfmjs0+g/6o+ED
   nyH0bs5Tm488lKEaeqCtc+Mhs39fJDpfXyXGaiKchESdCrQOCexJa9Sae
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="324007071"
X-IronPort-AV: E=Sophos;i="5.97,229,1669104000"; 
   d="scan'208";a="324007071"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 07:45:39 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="662149992"
X-IronPort-AV: E=Sophos;i="5.97,229,1669104000"; 
   d="scan'208";a="662149992"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 07:45:37 -0800
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id 6682920497;
        Thu, 19 Jan 2023 17:45:35 +0200 (EET)
Date:   Thu, 19 Jan 2023 15:45:35 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, rafael@kernel.org,
        linux-media@vger.kernel.org, heikki.krogerus@linux.intel.com
Subject: Re: [PATCH 6/8] ACPI: property: Rename parsed MIPI DisCo for Imaging
 properties
Message-ID: <Y8llnyz6yvfGsaBt@paasikivi.fi.intel.com>
References: <20230117122244.2546597-1-sakari.ailus@linux.intel.com>
 <20230117122244.2546597-7-sakari.ailus@linux.intel.com>
 <Y8a+USbrWoCw/EFG@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8a+USbrWoCw/EFG@smile.fi.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Andy,

On Tue, Jan 17, 2023 at 05:27:13PM +0200, Andy Shevchenko wrote:
> On Tue, Jan 17, 2023 at 02:22:42PM +0200, Sakari Ailus wrote:
> > MIPI DisCo for Imaging defines properties for sensor-adjacent devices such
> > as EEPROM, LED flash or lens VCM as either device or sub-node references.
> > This is compliant with existing DT definitions apart from property names.
> > 
> > Rename parsed MIPI-defined properties so drivers will have a unified view
> > of them as defined in DT and already parsed by drivers. This can be done
> > in-place as the MIPI-defined property strings are always longer than the
> > DT one. This also results in loss of constness in parser function
> > arguments.
> > 
> > Individual bindings to devices could define the references differently
> > between MIPI DisCo for Imaging and DT, in terms of device or sub-node
> > references. This will still need to be handled in the drivers themselves.
> 
> ...
> 
> > +static const struct mipi_disco_prop {
> > +	const char *mipi_prop;
> > +	const char *dt_prop;
> > +} mipi_disco_props[] = {
> > +	{ "mipi-img-lens-focus", "lens-focus" },
> > +	{ "mipi-img-flash-leds", "flash-leds" },
> > +	{ "mipi-img-clock-frequency", "clock-frequency" },
> > +	{ "mipi-img-led-max-current", "led-max-microamp" },
> > +	{ "mipi-img-flash-max-current", "flash-max-microamp" },
> > +	{ "mipi-img-flash-max-timeout", "flash-max-timeout-us" },
> > +};
> 
> If we split this to 2 arrays (with static_assert() against their sizes)...
> 
> ...
> 
> > +void acpi_properties_prepare_mipi(union acpi_object *elements)
> > +{
> > +	unsigned int i;
> > +
> > +	/* Replace MIPI DisCo for Imaging property names with DT equivalents. */
> > +	for (i = 0; i < ARRAY_SIZE(mipi_disco_props); i++) {
> > +		if (!strcmp(mipi_disco_props[i].mipi_prop,
> > +			    elements[0].string.pointer)) {
> 
> ...we can utilise match_string() here.

We could, yes.

I'd prefer to keep them separate still, the table is easier to maintain
that way. And I'd say it's the table above that matters more than this
function.

The current spec does not use more than these properties but I'd expect to
be added more of these in the future.

> 
> > +			WARN_ON(strscpy(elements[0].string.pointer,
> > +					mipi_disco_props[i].dt_prop,
> > +					elements[0].string.length) < 0);
> > +			break;
> > +		}
> > +	}
> > +}
> 
> ...
> 
> >  	for (i = 0; i < properties->package.count; i++) {
> > -		const union acpi_object *property;
> > +		union acpi_object *property = &properties->package.elements[i];
> > +		union acpi_object *elements = property->package.elements;
> >  
> > -		property = &properties->package.elements[i];
> >  		/*
> >  		 * Only two elements allowed, the first one must be a string and
> >  		 * the second one has to satisfy certain conditions.
> >  		 */
> >  		if (property->package.count != 2
> > -		    || property->package.elements[0].type != ACPI_TYPE_STRING
> > -		    || !acpi_property_value_ok(&property->package.elements[1]))
> > +		    || elements[0].type != ACPI_TYPE_STRING
> > +		    || !acpi_property_value_ok(&elements[1]))
> 
> While at it you can mode ||:s on the respective previous lines.

Yes, I'll fix that.

> 
> >  			return false;
> > +
> > +		acpi_properties_prepare_mipi(elements);
> >  	}

-- 
Kind regards,

Sakari Ailus
