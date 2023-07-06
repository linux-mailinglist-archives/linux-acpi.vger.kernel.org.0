Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 646F5749C05
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Jul 2023 14:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231721AbjGFMku (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 6 Jul 2023 08:40:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231835AbjGFMkr (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 6 Jul 2023 08:40:47 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 367911BD9;
        Thu,  6 Jul 2023 05:40:45 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="367081720"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="scan'208";a="367081720"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2023 05:40:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="893535515"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="scan'208";a="893535515"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP; 06 Jul 2023 05:40:41 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andy@kernel.org>)
        id 1qHOHn-000WMP-2E;
        Thu, 06 Jul 2023 15:40:39 +0300
Date:   Thu, 6 Jul 2023 15:40:39 +0300
From:   Andy Shevchenko <andy@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Daniel Scally <dan.scally@ideasonboard.com>,
        linux-acpi@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Kate Hsuan <hpa@redhat.com>, Hao Yao <hao.yao@intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>, linux-media@vger.kernel.org
Subject: Re: [PATCH v3 15/18] ACPI: bus: Introduce acpi_match_acpi_device()
 function
Message-ID: <ZKa2RznXUg68M1Ng@smile.fi.intel.com>
References: <20230705213010.390849-1-hdegoede@redhat.com>
 <20230705213010.390849-16-hdegoede@redhat.com>
 <ZKaHErGZOVXXDn9c@smile.fi.intel.com>
 <08825217-ff29-1f58-220d-617570836542@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08825217-ff29-1f58-220d-617570836542@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Jul 06, 2023 at 02:29:35PM +0200, Hans de Goede wrote:
> On 7/6/23 11:19, Andy Shevchenko wrote:
> > On Wed, Jul 05, 2023 at 11:30:07PM +0200, Hans de Goede wrote:

...

> > Looks like it's v1 of my original patch, anyway this is now in Linux Next as
> > 2b5ae9604949 ("ACPI: bus: Introduce acpi_match_acpi_device() helper").
> 
> Ah interesting, it does indeed look a lot like your version.
> but it was developed independently.

Very interesting! It's a second patch of me that collides with someone's else
work.

> Unfortunately it seems that this is headed for 6.6-rc1 and the atomisp
> changes in this series which rely on this are intended for 6.6-rc1 too.
> 
> So we still need to figure out how to merge this.

Standard way? I.e. ask Rafael for immutable tag/branch?

-- 
With Best Regards,
Andy Shevchenko


