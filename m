Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5A53749C0D
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Jul 2023 14:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229654AbjGFMmY (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 6 Jul 2023 08:42:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231213AbjGFMmY (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 6 Jul 2023 08:42:24 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2C1A171A;
        Thu,  6 Jul 2023 05:42:23 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="366168468"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="scan'208";a="366168468"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2023 05:42:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="843676752"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="scan'208";a="843676752"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004.jf.intel.com with ESMTP; 06 Jul 2023 05:42:20 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andy@kernel.org>)
        id 1qHOJO-000WOU-1r;
        Thu, 06 Jul 2023 15:42:18 +0300
Date:   Thu, 6 Jul 2023 15:42:18 +0300
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
Subject: Re: [PATCH v3 18/18] media: atomisp: csi2-bridge: Add support for
 VCM I2C-client instantiation
Message-ID: <ZKa2qnreaCfb2Lgc@smile.fi.intel.com>
References: <20230705213010.390849-1-hdegoede@redhat.com>
 <20230705213010.390849-19-hdegoede@redhat.com>
 <ZKaUWAAf586ZIRMF@smile.fi.intel.com>
 <500c0f9a-7b81-3c13-6da8-39245282fe46@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <500c0f9a-7b81-3c13-6da8-39245282fe46@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Jul 06, 2023 at 02:31:14PM +0200, Hans de Goede wrote:
> On 7/6/23 12:15, Andy Shevchenko wrote:
> > On Wed, Jul 05, 2023 at 11:30:10PM +0200, Hans de Goede wrote:

> >> +	vcm_type = kstrdup(obj->string.pointer, GFP_KERNEL);
> > 
> > Where is the counterpart kfree()?
> 
> The vcm-type is stored in one of the generated sw-nodes and the ipu-bridge
> code only creates those once and them leaves them in memory, even on
> a rmmod. So this is deliberately leaked just like that the ipu_bridge
> struct which contains all the swnode-s is deliberately leaked by
> ipu-bridge.c

Should we worry about those leakages?

-- 
With Best Regards,
Andy Shevchenko


