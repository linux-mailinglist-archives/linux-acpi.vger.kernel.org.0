Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42E7D76E79D
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Aug 2023 14:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234168AbjHCMDF (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 3 Aug 2023 08:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbjHCMDE (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 3 Aug 2023 08:03:04 -0400
Received: from mgamail.intel.com (unknown [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0FA1134;
        Thu,  3 Aug 2023 05:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691064184; x=1722600184;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RKljP55SwzyDRy6TKI83pKsNvrkaShZZBnYyCD8JK2M=;
  b=C7rIVnPGbEwpbTova3cUWESgj18jtyQZ1eksK9xD/NrbqHmPQZhZWzIL
   51092Soru3yY8loiF0t26dDYvHMi66UmrXFFnGJdz7zba/AIWhREF+t8C
   0AvlUaFI/eCdSC3htJqlaEKoLZyf2A+VqL0HJhR3slFZxtq1v0QPSyhs5
   XV5tWq1qacGvujSsjcwADKxgKCVgUmx/nS/G+RtfzLG6WZt8FB+Q+/f8e
   RhnOxUQLKjhQZZKuEr0qmeT7gQZM0+nwJjQ2BWEHuLgjlWX1RMsMYXXaJ
   RPXNJmEECNh0KRcgSt+XXebYUBJ2At2nkhJ+YLqLyUHwjk7xdmJR3n6ni
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="354771673"
X-IronPort-AV: E=Sophos;i="6.01,252,1684825200"; 
   d="scan'208";a="354771673"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2023 05:03:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="843571932"
X-IronPort-AV: E=Sophos;i="6.01,252,1684825200"; 
   d="scan'208";a="843571932"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2023 05:02:59 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
        by kekkonen.fi.intel.com (Postfix) with SMTP id 0A7D3120AB8;
        Thu,  3 Aug 2023 15:02:57 +0300 (EEST)
Date:   Thu, 3 Aug 2023 12:02:56 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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
Message-ID: <ZMuXcABGfDCjbaVJ@kekkonen.localdomain>
References: <20230803103102.323987-1-biju.das.jz@bp.renesas.com>
 <20230803103102.323987-2-biju.das.jz@bp.renesas.com>
 <ZMuW18rgUBd0mY4i@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZMuW18rgUBd0mY4i@smile.fi.intel.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Aug 03, 2023 at 03:00:23PM +0300, Andy Shevchenko wrote:
> On Thu, Aug 03, 2023 at 11:30:59AM +0100, Biju Das wrote:
> > Extend device_get_match_data() to buses (for eg: I2C) by adding a
> > callback device_get_match_data() to struct bus_type() and call this method
> > as a fallback for generic fwnode based device_get_match_data().
> 
> With this resend you were too fast to forgot Sakari's tag...

I guess it arrived after the patches were resent?

-- 
Sakari Ailus
