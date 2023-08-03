Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 814C076E708
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Aug 2023 13:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235054AbjHCLgl (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 3 Aug 2023 07:36:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235080AbjHCLgh (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 3 Aug 2023 07:36:37 -0400
Received: from mgamail.intel.com (unknown [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2449F273B;
        Thu,  3 Aug 2023 04:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691062592; x=1722598592;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6WCU+NtSCttsp3Q4/55mjryD6pxafR2MjmMkTYVJBtI=;
  b=GFkAlGVkCJu9UKK6wK1MecNIjJ8rLFUCjqWQcoE3ivw/pYaR1uoSU44A
   xlVDvPXn0uw9NP58kHZSksacOCiOKsFuQIvPInp4yRumwnB0/hG0rKi6g
   o6aXnBJE1z2Dp0qNcrxGqF7nQDVba8QSgkGm1YzMV92mGccrgZppnssX4
   6xdTEAIM5eaAiGj2abta11JXyfu0+AknJOmMp+hIMz+lyTddWXR2R2DZX
   AtV2vjHXjJY+Z16q7hzoVzz+CvEzWi7sIGUjQLFYKQZ4CtUGtEXEhw02U
   q7r5dsjaMsaRs7LlQ3ob1Q36n8WThlna1eIFPbc1iw1bxz2w5l5US3ys0
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="369842827"
X-IronPort-AV: E=Sophos;i="6.01,252,1684825200"; 
   d="scan'208";a="369842827"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2023 04:36:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="794969198"
X-IronPort-AV: E=Sophos;i="6.01,252,1684825200"; 
   d="scan'208";a="794969198"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2023 04:36:29 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
        by kekkonen.fi.intel.com (Postfix) with SMTP id A9905120BBA;
        Thu,  3 Aug 2023 14:36:26 +0300 (EEST)
Date:   Thu, 3 Aug 2023 11:36:26 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-acpi@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Wolfram Sang <wsa@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v5 1/4] drivers: fwnode: Extend device_get_match_data()
 to struct bus_type
Message-ID: <ZMuROu7IyJyf0KtL@kekkonen.localdomain>
References: <20230803101611.323342-1-biju.das.jz@bp.renesas.com>
 <20230803101611.323342-2-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230803101611.323342-2-biju.das.jz@bp.renesas.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Biju,

On Thu, Aug 03, 2023 at 11:16:08AM +0100, Biju Das wrote:
> Extend device_get_match_data() to buses (for eg: I2C) by adding a
> callback device_get_match_data() to struct bus_type() and call this method
> as a fallback for generic fwnode based device_get_match_data().
> 
> Suggested-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>

-- 
Sakari Ailus
