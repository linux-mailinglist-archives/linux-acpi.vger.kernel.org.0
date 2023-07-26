Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7E29763C97
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Jul 2023 18:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbjGZQgN (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 26 Jul 2023 12:36:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231151AbjGZQgL (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 26 Jul 2023 12:36:11 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 038E326B7;
        Wed, 26 Jul 2023 09:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690389370; x=1721925370;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rj48WouSf5V3lF9yCoZBdK5NwBsjH4wrmcj8xp2Tog0=;
  b=GFFSJrS0TnymzxukrNH8GIA4iVaBwN7aX2V4fDpwFALN1Gb2+ltW+0KU
   jvCEB5xKGn5rl8+wZd4AO22qrzg4yL4FSxd05i7ontY6byEeYHOAoCAuO
   prpQUyCApnHnjAcX9I/QwADA9jC6/Cuf9BZGXKosFWYdFjoEH89zHAB8s
   y4RclQhhEZKZtJOKryTiNU1SxMW62l58w2b/IlQv/Hcn1ZJuhGKtn/5HU
   lQ4AkWCpER5+zdHdHW4lsBJYmF8/mjhCOByTJp+UIXqaFwjFewyUqY3LC
   RYh6WlM6D+YZ7fbt09tyrg2VLodvOgSDWchznpGOkSf+LDw9rHkeu+hSY
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="370745650"
X-IronPort-AV: E=Sophos;i="6.01,232,1684825200"; 
   d="scan'208";a="370745650"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2023 09:36:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="900509108"
X-IronPort-AV: E=Sophos;i="6.01,232,1684825200"; 
   d="scan'208";a="900509108"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP; 26 Jul 2023 09:36:02 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qOhUV-00FI2D-2C;
        Wed, 26 Jul 2023 19:35:59 +0300
Date:   Wed, 26 Jul 2023 19:35:59 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-acpi@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Wolfram Sang <wsa@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v2 1/2] drivers: fwnode: Extend device_get_match_data()
 to struct bus_type
Message-ID: <ZMFLb5qFE2zkQEYG@smile.fi.intel.com>
References: <20230726130804.186313-1-biju.das.jz@bp.renesas.com>
 <20230726130804.186313-2-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230726130804.186313-2-biju.das.jz@bp.renesas.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Jul 26, 2023 at 02:08:03PM +0100, Biju Das wrote:
> Extend device_get_match_data() to buses (for eg: I2C) by adding a
> callback device_get_match_data() to struct bus_type() and call this method
> as a fallback for generic fwnode based device_get_match_data().

For firmware node changes:
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


