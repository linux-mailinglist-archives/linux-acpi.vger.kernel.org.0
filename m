Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A007749BA1
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Jul 2023 14:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbjGFMXk (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 6 Jul 2023 08:23:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjGFMXk (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 6 Jul 2023 08:23:40 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B45C8F;
        Thu,  6 Jul 2023 05:23:39 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="427267995"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="scan'208";a="427267995"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2023 05:23:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="719563001"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="scan'208";a="719563001"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP; 06 Jul 2023 05:23:35 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andy@kernel.org>)
        id 1qHO1F-000W9s-28;
        Thu, 06 Jul 2023 15:23:33 +0300
Date:   Thu, 6 Jul 2023 15:23:33 +0300
From:   Andy Shevchenko <andy@kernel.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Daniel Scally <dan.scally@ideasonboard.com>,
        linux-acpi@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Kate Hsuan <hpa@redhat.com>, Hao Yao <hao.yao@intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>, linux-media@vger.kernel.org
Subject: Re: [PATCH v3 17/18] media: atomisp: csi2-bridge: Add dev_name() to
 acpi_handle_info() logging
Message-ID: <ZKayRcm83vMImkte@smile.fi.intel.com>
References: <20230705213010.390849-1-hdegoede@redhat.com>
 <20230705213010.390849-18-hdegoede@redhat.com>
 <ZKaS2UbkbkbfYqAe@smile.fi.intel.com>
 <20230706111224.GA20921@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230706111224.GA20921@pendragon.ideasonboard.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Jul 06, 2023 at 02:12:24PM +0300, Laurent Pinchart wrote:
> On Thu, Jul 06, 2023 at 01:09:29PM +0300, Andy Shevchenko wrote:
> > On Wed, Jul 05, 2023 at 11:30:09PM +0200, Hans de Goede wrote:

...

> > > -			acpi_handle_info(adev->handle, "Using DSM entry %s=%s\n", key, val);
> > > +			acpi_handle_info(adev->handle, "%s: Using DSM entry %s=%s\n",
> > > +					 dev_name(&adev->dev), key, val);
> > 
> > Maybe (maybe!) it's a candidate to have something like
> > 
> > v4l2_acpi_log_info(adev, ...) which combines both and unloads the code from
> > thinking about it?
> 
> Or acpi_dev_info() that would take an acpi_device pointer.

(which is an equivalent to the below)

> Or just just dev_info(&adev->dev) ?

The point is to print ACPI handle *and* device name. There are no existing
helpers for that.


-- 
With Best Regards,
Andy Shevchenko


