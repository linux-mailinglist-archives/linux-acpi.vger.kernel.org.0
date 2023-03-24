Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAC8D6C848D
	for <lists+linux-acpi@lfdr.de>; Fri, 24 Mar 2023 19:13:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231668AbjCXSNB (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 24 Mar 2023 14:13:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231288AbjCXSNA (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 24 Mar 2023 14:13:00 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D3F6558A
        for <linux-acpi@vger.kernel.org>; Fri, 24 Mar 2023 11:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679681579; x=1711217579;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nRuwYJeJ4kRwwuAiu08wCsYxi9cgNDEp2G9kwUujkrk=;
  b=cxlRxB0TrNrd9Rlhp9reGTVuk6xBqL3z2cDW/BeIQfbpgyuKi06l2s44
   RuEHApD5EvNvGYnePIap9qlBY8v/265sT/t5Cc6+NhZUq0diB1BHlHkXG
   OxqaDkSd1A3vveflJzrZp84Fx/thmtNP/JHev58W0hRoWcnfJev8tmfWe
   A1QkbU7ijfWpD/ksRlZzTJ/bDrYLZwFfgfAwsjMael8nXf08uPRyuPWFO
   kymJ+lHSiaJYSaXM7pWecf5bW4TcwoY6IFAtULjMJBr0CDnBIc5HkvAHo
   h3PN6p/m+zrB/zhA/gKlh36lxY9s5rdEajy0OV48hlX23W+JLjn9fbLRG
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10659"; a="402444096"
X-IronPort-AV: E=Sophos;i="5.98,288,1673942400"; 
   d="scan'208";a="402444096"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2023 11:12:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10659"; a="751986907"
X-IronPort-AV: E=Sophos;i="5.98,288,1673942400"; 
   d="scan'208";a="751986907"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2023 11:12:53 -0700
Received: from kekkonen.localdomain (localhost [IPv6:::1])
        by kekkonen.fi.intel.com (Postfix) with SMTP id 90BF01207CD;
        Fri, 24 Mar 2023 20:12:50 +0200 (EET)
Date:   Fri, 24 Mar 2023 20:12:50 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-acpi@vger.kernel.org
Subject: Re: [PATCH] device property: constify fwnode_get_phy_mode() argument
Message-ID: <ZB3oImRhktttwx98@kekkonen.localdomain>
References: <E1pfdh9-00EQ8t-HB@rmk-PC.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1pfdh9-00EQ8t-HB@rmk-PC.armlinux.org.uk>
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Mar 24, 2023 at 09:26:47AM +0000, Russell King (Oracle) wrote:
> fwnode_get_phy_mode() does not modify the fwnode argument, merely
> using it to obtain the phy-mode property value. Therefore, it can
> be made const.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>

-- 
Sakari Ailus
