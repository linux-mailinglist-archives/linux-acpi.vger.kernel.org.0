Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6B96673DB5
	for <lists+linux-acpi@lfdr.de>; Thu, 19 Jan 2023 16:40:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbjASPkM (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 19 Jan 2023 10:40:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbjASPkH (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 19 Jan 2023 10:40:07 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17C4584552;
        Thu, 19 Jan 2023 07:40:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674142807; x=1705678807;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=730LdLhnNfo6EK+2NxpYWLFuRtcUP9jY5aiSMZa7SDk=;
  b=d4NC26sE2tN9A6Hc0qctFCZLsLhYYcrXOGlY4ArYkejXAJArL+2x5apr
   22F5e1JelZE7Fe4/C/tximICpFJCTJcBfO8lt3bURLU9lEeyCwjd4IX2r
   p/qha4STKseNzh3k4joM17GLg5hP9BMtRYOTIQD1YwuZEE5TTKsZXuPDn
   AOHl39lo7gyPAr1+p8YE3wppx0oIjoxC2HTzqfseCe03k4XCDIFQacv4+
   g59PZlcfaq7ynT8+6lug1TqDofEJ0N4cza7TAridkd65HP5b4dGoDU097
   fjLB6slZDoNXbIaI6bszHQ7G/Za18sFcBaDLo73mb3Tg9j6AAhhDDEQ3H
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="324004632"
X-IronPort-AV: E=Sophos;i="5.97,229,1669104000"; 
   d="scan'208";a="324004632"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 07:40:06 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="748968274"
X-IronPort-AV: E=Sophos;i="5.97,229,1669104000"; 
   d="scan'208";a="748968274"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 07:40:05 -0800
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id E402720497;
        Thu, 19 Jan 2023 17:40:02 +0200 (EET)
Date:   Thu, 19 Jan 2023 15:40:02 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, rafael@kernel.org,
        linux-media@vger.kernel.org, heikki.krogerus@linux.intel.com
Subject: Re: [PATCH 5/8] ACPI: property: Dig "rotation" property for devices
 with CSI2 _CRS
Message-ID: <Y8lkUgU0tZQbsn/5@paasikivi.fi.intel.com>
References: <20230117122244.2546597-1-sakari.ailus@linux.intel.com>
 <20230117122244.2546597-6-sakari.ailus@linux.intel.com>
 <Y8a9Iy2xzmHh7crA@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8a9Iy2xzmHh7crA@smile.fi.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Andy,

On Tue, Jan 17, 2023 at 05:22:11PM +0200, Andy Shevchenko wrote:
> On Tue, Jan 17, 2023 at 02:22:41PM +0200, Sakari Ailus wrote:
> > Dig "rotation" property value for devices with _CRS CSI2 resource
> > descriptor. The value comes from _PLD (physical location of device)
> > object, if it exists for the device.
> > 
> > This way camera sensor drivers that know the "rotation" property do not
> > need to care about _PLD on ACPI.
> 
> ...
> 
> > +	if (fwnode_property_read_u32(fwnode, "rotation", &val) &&
> > +	    acpi_get_physical_device_location(acpi_device_handle(device),
> > +					      &pld) == AE_OK) {
> 
> ACPI_SUCCESS() ?

Yes.

> 
> ...
> 
> > +		ads->dev_props[NEXT_PROPERTY(prop_index, DEV_ROTATION)] =
> > +			PROPERTY_ENTRY_U32("rotation",
> > +					   (u32)pld->rotation * 45U);
> 
> Why do you need casting?

I think it's actually not needed.

-- 
Sakari Ailus
