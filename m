Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDEAF76E793
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Aug 2023 14:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235690AbjHCMAd (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 3 Aug 2023 08:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232363AbjHCMA3 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 3 Aug 2023 08:00:29 -0400
Received: from mgamail.intel.com (unknown [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28DCB2D49;
        Thu,  3 Aug 2023 05:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691064029; x=1722600029;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dGbqmWZzU2YPc7Hkyy/t9t4FJfPFRa0qJv3MSC/rqP0=;
  b=n/qtXqWwvjD8IUzeML/T05SRqe1Jr9Vdq6THr3qL7JkdZ5bM6HRyHBZQ
   muPBriSoU2Rdyq9Fu6TJoAcGTBkEXmybFP4OQL5eiUDLzxHQ2teM6hfLs
   DylLlftMrZKjdei9WzNJWjsWm9IDl2OlLRgfvhtRYpCOHijguNN9UF9cd
   iovZ770Ht/9knGpl/Wi8z52h/f2O/ftRl/p+Hq6lZ+t/ZZNE4fXxKyk9O
   8fFpBgZ1sLi4MR+ku6Kp1PO8a5B4VK7SQYvMYf01WU+82dbTnMpOmZjv7
   GnfHFECB+6qBvYSmVJ2UVWjSAEwmdxh2nh/laoLjnu56wcpgzKinFXm+G
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="350147350"
X-IronPort-AV: E=Sophos;i="6.01,252,1684825200"; 
   d="scan'208";a="350147350"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2023 05:00:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="706510209"
X-IronPort-AV: E=Sophos;i="6.01,252,1684825200"; 
   d="scan'208";a="706510209"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga006.jf.intel.com with ESMTP; 03 Aug 2023 05:00:25 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qRX0C-00BFxp-0X;
        Thu, 03 Aug 2023 15:00:24 +0300
Date:   Thu, 3 Aug 2023 15:00:23 +0300
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
Subject: Re: [PATCH v5 RESEND 1/4] drivers: fwnode: Extend
 device_get_match_data() to struct bus_type
Message-ID: <ZMuW18rgUBd0mY4i@smile.fi.intel.com>
References: <20230803103102.323987-1-biju.das.jz@bp.renesas.com>
 <20230803103102.323987-2-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230803103102.323987-2-biju.das.jz@bp.renesas.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Aug 03, 2023 at 11:30:59AM +0100, Biju Das wrote:
> Extend device_get_match_data() to buses (for eg: I2C) by adding a
> callback device_get_match_data() to struct bus_type() and call this method
> as a fallback for generic fwnode based device_get_match_data().

With this resend you were too fast to forgot Sakari's tag...

-- 
With Best Regards,
Andy Shevchenko


