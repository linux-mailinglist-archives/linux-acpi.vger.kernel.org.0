Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9853468F91C
	for <lists+linux-acpi@lfdr.de>; Wed,  8 Feb 2023 21:56:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbjBHU4r (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 8 Feb 2023 15:56:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjBHU4o (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 8 Feb 2023 15:56:44 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34D9D233E0;
        Wed,  8 Feb 2023 12:56:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675889803; x=1707425803;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ttHCY+rnMI9yuSbyC36BeQ+z08izujDEifq6i9K8O70=;
  b=cxGjMvEWRqn2Rj0d3mRoIZZQgZibyWRRFfyWFHCLVx/n1XSjS8Ru899I
   e1HfkQy2Z+JzGHP7Hw57/B8UF45nQ8Dpk0vIJwh5/Zr8+f7RaT67zipos
   TpAtjD3dvI4LlElhyRtH+FNFOEXxnrt7LY5lNKOtQ4DEyEPmmvZtN+wBm
   R63nB+EMv/GPMHrZPBtgnWrPzhuL4ZRYHY9Y+h72brJinHmz1gcKNTZEZ
   8LD2B++gvSt/835Bcg5JMW+LEM1KWzF1y1qWJ6AqKrpp279+pViosHLDY
   NVdLHn+BAtzfU+fOr5dpWZMKdRsYeSzzzdtHh6yN+ofecXjprRerMclo7
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="309571088"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="309571088"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 12:56:42 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="756167022"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="756167022"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 12:56:41 -0800
Received: from kekkonen.localdomain (localhost [IPv6:::1])
        by kekkonen.fi.intel.com (Postfix) with SMTP id 66618120D20;
        Wed,  8 Feb 2023 22:56:38 +0200 (EET)
Date:   Wed, 8 Feb 2023 22:56:38 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, linux-media@vger.kernel.org,
        rafael@kernel.org, heikki.krogerus@linux.intel.com
Subject: Re: [PATCH v4 5/8] ACPI: property: Dig "rotation" property for
 devices with CSI2 _CRS
Message-ID: <Y+QMhkdnzwXx7Z6d@kekkonen.localdomain>
References: <20230208152807.3064242-1-sakari.ailus@linux.intel.com>
 <20230208152807.3064242-6-sakari.ailus@linux.intel.com>
 <Y+PTBdEPZoRLG4Hw@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+PTBdEPZoRLG4Hw@smile.fi.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Andy,

On Wed, Feb 08, 2023 at 06:51:17PM +0200, Andy Shevchenko wrote:
> On Wed, Feb 08, 2023 at 05:28:04PM +0200, Sakari Ailus wrote:
> > Dig "rotation" property value for devices with _CRS CSI2 resource
> > descriptor. The value comes from _PLD (physical location of device)
> > object, if it exists for the device.
> > 
> > This way camera sensor drivers that know the "rotation" property do not
> > need to care about _PLD on ACPI.
> 
> ...
> 
> > +	/*
> > +	 * Check if "rotation" property exists and if it doesn't but there's a
> > +	 * _PLD object, then get the rotation value from there.
> > +	 */
> > +	if (fwnode_property_read_u32(fwnode, "rotation", &val) &&
> > +	    ACPI_SUCCESS(acpi_get_physical_device_location(acpi_device_handle(device),
> > +							   &pld))) {
> 
> > +	if (fwnode_property_read_u32(fwnode, "rotation", &val) &&
> > +	    ACPI_SUCCESS(acpi_get_physical_device_location(acpi_device_handle(device),
> > +							   &pld))) {
> 
> Wouldn't be a bit better to use temporary variables for this?
> 
> 	ret = fwnode_property_read_u32(fwnode, "rotation", &val);
> 	if (ret) {
> 		acpi_handle handle = acpi_device_handle(device);
> 		acpi_status status;
> 
> 		status = acpi_get_physical_device_location(handle, &pld);
> 		if (ACPI_SUCCESS(status)) {
> 			...
> 		}
> 	}
> 
> ?

It seems that val isn't used. So I'll use fwnode_property_present() which
I think is fine to test in if () directly.

-- 
Sakari Ailus
