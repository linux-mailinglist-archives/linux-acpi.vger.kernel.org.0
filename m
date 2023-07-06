Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F6D1749FBC
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Jul 2023 16:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231570AbjGFOug (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 6 Jul 2023 10:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231280AbjGFOuN (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 6 Jul 2023 10:50:13 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D72A1FC3;
        Thu,  6 Jul 2023 07:49:45 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="427299346"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="scan'208";a="427299346"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2023 07:47:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="789565941"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="scan'208";a="789565941"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP; 06 Jul 2023 07:47:50 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andy@kernel.org>)
        id 1qHQGq-000YpO-2Q;
        Thu, 06 Jul 2023 17:47:48 +0300
Date:   Thu, 6 Jul 2023 17:47:48 +0300
From:   Andy Shevchenko <andy@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Daniel Scally <dan.scally@ideasonboard.com>,
        linux-acpi@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Kate Hsuan <hpa@redhat.com>, Hao Yao <hao.yao@intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>, linux-media@vger.kernel.org,
        Daniel Scally <djrscally@gmail.com>
Subject: Re: [PATCH v3 14/18] media: i2c: Add driver for DW9719 VCM
Message-ID: <ZKbUFNA58b/7Sxlk@smile.fi.intel.com>
References: <20230705213010.390849-1-hdegoede@redhat.com>
 <20230705213010.390849-15-hdegoede@redhat.com>
 <ZKaSD0CHRBd+zu/T@smile.fi.intel.com>
 <a841fb53-16a2-aad8-1354-a2772a3a1249@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a841fb53-16a2-aad8-1354-a2772a3a1249@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Jul 06, 2023 at 04:34:41PM +0200, Hans de Goede wrote:
> On 7/6/23 12:06, Andy Shevchenko wrote:
> > On Wed, Jul 05, 2023 at 11:30:06PM +0200, Hans de Goede wrote:

...

> >> +		usleep_range(DW9719_CTRL_DELAY_US, DW9719_CTRL_DELAY_US + 10);
> > 
> > fsleep() ?
> 
> fsleep would expand to:
> 
> 		usleep_range(DW9719_CTRL_DELAY_US,  2 * DW9719_CTRL_DELAY_US);
> 
> making the loop take up to twice as long.

Is it a problem here? If so, perhaps one line to explain that?

> >> +	}

-- 
With Best Regards,
Andy Shevchenko


