Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 157C076E7E3
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Aug 2023 14:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235858AbjHCMH2 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 3 Aug 2023 08:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235826AbjHCMHK (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 3 Aug 2023 08:07:10 -0400
Received: from mgamail.intel.com (unknown [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C29E530DD;
        Thu,  3 Aug 2023 05:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691064427; x=1722600427;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RJZmWNRblVp8kLvus8B0+VpplR9hsFYfNTcFk43APqg=;
  b=UUD9+AFfIoqy+id6tQ9Z4QBibY0uoyEihDS1ETZUZj/T4ROTtZStQuzG
   E8wfI7z5/uWOR284SoWEdKw/NmOIaVgFRUeVBh101elIWQ4yxzZSNE9my
   8WuvhpGok8gZUYYws8S8aj/8U6Qy22xN0ZAueHhdRB14C3ZYtl8dy0KX7
   khDAXnNvsAnz5fjtipyyY8VrdUV747RJJ+ZmRskhLPDbGCbvie/t3tucE
   CyHpoxulGDLOHv2bLIuKQw6sfZKK3xJw55Kdo7yphmQy3iueOCEoJCR/F
   Yu0uSOeE/181zyfRxLlFri8ECycVz3mGlxss/kEuDgF6cS2Og9a60sAAq
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="368752288"
X-IronPort-AV: E=Sophos;i="6.01,252,1684825200"; 
   d="scan'208";a="368752288"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2023 05:07:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="976041812"
X-IronPort-AV: E=Sophos;i="6.01,252,1684825200"; 
   d="scan'208";a="976041812"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP; 03 Aug 2023 05:07:03 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qRX6b-00BTs4-0v;
        Thu, 03 Aug 2023 15:07:01 +0300
Date:   Thu, 3 Aug 2023 15:07:01 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-acpi@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Wolfram Sang <wsa@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v5 RESEND 1/4] drivers: fwnode: Extend
 device_get_match_data() to struct bus_type
Message-ID: <ZMuYZbYdLqBnylrc@smile.fi.intel.com>
References: <20230803103102.323987-1-biju.das.jz@bp.renesas.com>
 <20230803103102.323987-2-biju.das.jz@bp.renesas.com>
 <ZMuW18rgUBd0mY4i@smile.fi.intel.com>
 <ZMuXcABGfDCjbaVJ@kekkonen.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZMuXcABGfDCjbaVJ@kekkonen.localdomain>
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

On Thu, Aug 03, 2023 at 12:02:56PM +0000, Sakari Ailus wrote:
> On Thu, Aug 03, 2023 at 03:00:23PM +0300, Andy Shevchenko wrote:
> > On Thu, Aug 03, 2023 at 11:30:59AM +0100, Biju Das wrote:
> > > Extend device_get_match_data() to buses (for eg: I2C) by adding a
> > > callback device_get_match_data() to struct bus_type() and call this method
> > > as a fallback for generic fwnode based device_get_match_data().
> > 
> > With this resend you were too fast to forgot Sakari's tag...
> 
> I guess it arrived after the patches were resent?

Yes, and this is my point, too fast to resend :-)

-- 
With Best Regards,
Andy Shevchenko


