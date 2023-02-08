Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC5EA68F9AA
	for <lists+linux-acpi@lfdr.de>; Wed,  8 Feb 2023 22:27:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231500AbjBHV1g (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 8 Feb 2023 16:27:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231489AbjBHV1f (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 8 Feb 2023 16:27:35 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 310D71E5D7;
        Wed,  8 Feb 2023 13:27:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675891654; x=1707427654;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zY/5QQL5G7M2ItNNs5xB/kWxPlChJgQ3KM+vywG553k=;
  b=EF8Rh5KTulqFvawvwnqeU8dyEvqhi4HH/9ba4DyzCXnm50lm+OkaHD1n
   QGAp+YSsAWCPwtw6PlOxo3t1MSJdylLqi4l8i2l2RD0WvwcK7y83ZHOcm
   6XxwLcUTPawmI0A/QCAv3mLIVcO7rdOrkPpuGfiigOMEGs0NxxS2KXmM3
   +rblHyc+o43EecP0rDwllS8Wgo/EOv1OsySnWJ2OvbH7K5Wm0JoAgF4BV
   YasDMs/XfbwaNtInPYclaPCyUS2Iw1Ei+HHfnX190nPJ7NlxJkoSWqQid
   elTMC2eLpzrMqLjjO/8dUAYUqOt3DiV9OCNYXMTW2pCMGBnoJDheXHgpk
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="313566121"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="313566121"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 13:27:33 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="756180407"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="756180407"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 13:27:32 -0800
Received: from kekkonen.localdomain (localhost [IPv6:::1])
        by kekkonen.fi.intel.com (Postfix) with SMTP id 5ADCB120D20;
        Wed,  8 Feb 2023 23:27:29 +0200 (EET)
Date:   Wed, 8 Feb 2023 23:27:29 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, linux-media@vger.kernel.org,
        rafael@kernel.org, heikki.krogerus@linux.intel.com
Subject: Re: [PATCH v4 6/8] ACPI: property: Rename parsed MIPI DisCo for
 Imaging properties
Message-ID: <Y+QTwQq07XvRLQt/@kekkonen.localdomain>
References: <20230208152807.3064242-1-sakari.ailus@linux.intel.com>
 <20230208152807.3064242-7-sakari.ailus@linux.intel.com>
 <Y+PUO3a8ZOq0Haa2@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+PUO3a8ZOq0Haa2@smile.fi.intel.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Feb 08, 2023 at 06:56:27PM +0200, Andy Shevchenko wrote:
> On Wed, Feb 08, 2023 at 05:28:05PM +0200, Sakari Ailus wrote:
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
> > +void acpi_properties_prepare_mipi(union acpi_object *elements)
> > +{
> > +	unsigned int i;
> > +
> > +	/* Replace MIPI DisCo for Imaging property names with DT equivalents. */
> > +	for (i = 0; i < ARRAY_SIZE(mipi_disco_props); i++) {
> > +		if (!strcmp(mipi_disco_props[i].mipi_prop,
> > +			    elements[0].string.pointer)) {
> 
> 	/* const ? */ char *e0 = elements[0].string.pointer;

Yes, and can be placed outside the loop.

> 	...
> 
> 		if (!strcmp(mipi_disco_props[i].mipi_prop, e0)) {
> 
> > +			WARN_ON(strscpy(elements[0].string.pointer,
> > +					mipi_disco_props[i].dt_prop,
> > +					elements[0].string.length) < 0);
> 
> 			WARN_ON(strscpy(e0, mipi_disco_props[i].dt_prop,
> 					elements[0].string.pointer) < 0);
> ?
> 
> > +			break;
> > +		}
> > +	}
> > +}
> 

-- 
Sakari Ailus
