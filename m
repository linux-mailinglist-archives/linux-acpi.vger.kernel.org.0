Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2F8F76D06E
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Aug 2023 16:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbjHBOq1 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 2 Aug 2023 10:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231688AbjHBOq0 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 2 Aug 2023 10:46:26 -0400
Received: from mgamail.intel.com (unknown [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAEAD1FCB;
        Wed,  2 Aug 2023 07:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690987585; x=1722523585;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Bx06kqb1Xm2I20w1+rZ1+epKaG7EZjZ1yMRMm6Jp5Ck=;
  b=b4pEH5g6k4PdLOmSb6CWzjGV7gNLCdEzTsmpuCzQjJd38k4vCzvHZD3a
   zBfWvmiUYssakdvuIFtAcaScIM+W/4iTw9CeoiHuaL7TcaPVNkCqe9eHC
   SngyaZ82JsCAgoiUJLSy2CkUPmeu8jqZz1KQaAZs3B+pKRHYQrRQeg4gt
   NaC/GK2cTr2VoqWaOIKlr3TxpY5vJTCc8KtRq1yr08TTAYTN4ziRmR2px
   HO6QuvDKpU74ouE6Sax92cMQkF2oZx0UDuiNCnxNs0zvM/ZQ0/CpcriSa
   tK389P4tMnTgL+XaTHa32NZkj/TywkBJ7ypYoNlArC8BEe6qQ33Ru4qzJ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="368507766"
X-IronPort-AV: E=Sophos;i="6.01,249,1684825200"; 
   d="scan'208";a="368507766"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2023 07:46:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="1059861757"
X-IronPort-AV: E=Sophos;i="6.01,249,1684825200"; 
   d="scan'208";a="1059861757"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP; 02 Aug 2023 07:46:22 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qRD7E-0037id-2G;
        Wed, 02 Aug 2023 17:46:20 +0300
Date:   Wed, 2 Aug 2023 17:46:20 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Wolfram Sang <wsa@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] drivers: fwnode: Extend device_get_match_data()
 to struct bus_type
Message-ID: <ZMpsPMazqlQFERaM@smile.fi.intel.com>
References: <20230801170318.82682-1-biju.das.jz@bp.renesas.com>
 <20230801170318.82682-2-biju.das.jz@bp.renesas.com>
 <ZMlfYU3rOQle0VuH@smile.fi.intel.com>
 <OS0PR01MB592219C8BEF733C6A75DDD5C860BA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OS0PR01MB592219C8BEF733C6A75DDD5C860BA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Aug 02, 2023 at 06:32:18AM +0000, Biju Das wrote:
> > On Tue, Aug 01, 2023 at 06:03:17PM +0100, Biju Das wrote:

...

> >  *
> >  * Besides the fact that some drivers abuse the device ID driver_data
> > type
> >  * and claim it to be integer, for the bus specific ID tables the
> > driver_data
> >  * may be defined as kernel_ulong_t. For these tables 0 is a valid
> > response,
> >  * but not for this function. It's recommended to covert those either to
> 
> Will fix the typo covert->convert

Thank you!

> > avoid
> >  * 0 or use a real pointer to the predefined driver data.

-- 
With Best Regards,
Andy Shevchenko


