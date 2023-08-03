Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B874476E7F5
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Aug 2023 14:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235692AbjHCMMN (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 3 Aug 2023 08:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234728AbjHCMMM (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 3 Aug 2023 08:12:12 -0400
Received: from mgamail.intel.com (unknown [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77B262D49;
        Thu,  3 Aug 2023 05:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691064731; x=1722600731;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uQun1mBvD+IAx1pdw1Iw1bXruihqbiWG5cwmzUD2IXc=;
  b=YJPbbULhryDl4+ZrlWcpUtEIyDGL5YsLkXdEx8VUeUGfbbYTm18MzrYZ
   uJCPRJJWgFoD/zbtQRLwqf9rlmvVn7xXUWzKZUk7cnteXuOqsrzN8UdBV
   gl3m+P0m3gGT+u33DlptUkT2+vHQkze01PZrih+Yo6omnGzkbPPwh13FJ
   bNC5NgegGml6FI6HsKE6QEyO/69AtKKV/9nahc60LVxf2Fk062osCRymn
   k42hDHEgIK+LFSn2QPT1O5Jpj1xa7Nal/fiSIeTjLAuHBxccdi15g/Pwa
   X6o4X2gRUXTV+18K8Y52i08fMEKvB89MlT50CRSPtonf9pCVCDooU7b3a
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="436162509"
X-IronPort-AV: E=Sophos;i="6.01,252,1684825200"; 
   d="scan'208";a="436162509"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2023 05:12:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="723197901"
X-IronPort-AV: E=Sophos;i="6.01,252,1684825200"; 
   d="scan'208";a="723197901"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP; 03 Aug 2023 05:12:08 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qRXBW-00BeSD-1c;
        Thu, 03 Aug 2023 15:12:06 +0300
Date:   Thu, 3 Aug 2023 15:12:06 +0300
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
Subject: Re: [PATCH v5 RESEND 1/4] drivers: fwnode: Extend
 device_get_match_data() to struct bus_type
Message-ID: <ZMuZlu5W/22ZDKBw@smile.fi.intel.com>
References: <20230803103102.323987-1-biju.das.jz@bp.renesas.com>
 <20230803103102.323987-2-biju.das.jz@bp.renesas.com>
 <ZMuW18rgUBd0mY4i@smile.fi.intel.com>
 <TYCPR01MB593382D6915A0D4297483B6F8608A@TYCPR01MB5933.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYCPR01MB593382D6915A0D4297483B6F8608A@TYCPR01MB5933.jpnprd01.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Aug 03, 2023 at 12:05:58PM +0000, Biju Das wrote:
> > Subject: Re: [PATCH v5 RESEND 1/4] drivers: fwnode: Extend
> > device_get_match_data() to struct bus_type
> > 
> > On Thu, Aug 03, 2023 at 11:30:59AM +0100, Biju Das wrote:
> > > Extend device_get_match_data() to buses (for eg: I2C) by adding a
> > > callback device_get_match_data() to struct bus_type() and call this
> > > method as a fallback for generic fwnode based device_get_match_data().
> > 
> > With this resend you were too fast to forgot Sakari's tag...
> 
> In my mailbox, I received Sakari's tag after sending RESEND patch series.
> It may be some race situation with mailboxes.

Right. My point is, give some time before resend even if something is wrong.
Jest reply to your own message to inform people that "the vX is wrong and
I am going to resend it soon",

-- 
With Best Regards,
Andy Shevchenko


