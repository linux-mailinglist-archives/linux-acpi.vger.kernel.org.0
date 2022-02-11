Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 571E14B2A1B
	for <lists+linux-acpi@lfdr.de>; Fri, 11 Feb 2022 17:19:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349753AbiBKQTw (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 11 Feb 2022 11:19:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351446AbiBKQTv (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 11 Feb 2022 11:19:51 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEA282E5;
        Fri, 11 Feb 2022 08:19:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644596388; x=1676132388;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=u5EZ7Okh2QOgfrHgVQterP66NUjwmxi1AucbWUVZfMI=;
  b=CgrQ1VSf2S2AYeqLlaaJMfmaJjk90quSonPgw4uA/IXHfN8Pp2LRDUQv
   YbeA9ZCCgeW040ct0T6BX68HiifdW1vAxjSLyRRNU4V0KX0yWMn951eSF
   W81v7EWkSE6nqJdLdxeV2x8M2eU3paSxOL4ulAZwSIYmIlbFq1baMgDlJ
   L+pTshk3mP8A8PmBwBxrWTzoCpVs08bchNeG0pX0SRxeSH2juBEyffxJ6
   OePJ8Prk6wDfWOZFQlYBddUiIBM/tDyBXH7zPxDmYEtQx8RYef6u44GLy
   I3NrCNYwpKvw/Tm6KpGSaPkZqHq9ysqUe+Cnxih2jd7vkKmBo9S5B8c1X
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10254"; a="336181782"
X-IronPort-AV: E=Sophos;i="5.88,361,1635231600"; 
   d="scan'208";a="336181782"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2022 08:19:48 -0800
X-IronPort-AV: E=Sophos;i="5.88,361,1635231600"; 
   d="scan'208";a="702161137"
Received: from smile.fi.intel.com ([10.237.72.61])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2022 08:19:46 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nIYdF-003VD7-9L;
        Fri, 11 Feb 2022 18:18:49 +0200
Date:   Fri, 11 Feb 2022 18:18:49 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Frank Rowand <frowand.list@gmail.com>
Subject: Re: [PATCH 1/4] device property: Convert
 device_{dma_supported,get_dma_attr} to fwnode
Message-ID: <YgaMaYeC8q7IZlcW@smile.fi.intel.com>
References: <20220206091643.276833-1-sakari.ailus@linux.intel.com>
 <20220206091643.276833-2-sakari.ailus@linux.intel.com>
 <YgaG6sQjKs+ZxNm6@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YgaG6sQjKs+ZxNm6@robh.at.kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Feb 11, 2022 at 09:55:22AM -0600, Rob Herring wrote:
> On Sun, Feb 06, 2022 at 11:16:40AM +0200, Sakari Ailus wrote:
> > Make the device_dma_supported and device_get_dma_attr functions to use the
> > fwnode ops, and move the implementation to ACPI and OF frameworks.
> > 
> > Depends-on: ("device property: Don't split fwnode_get_irq*() APIs in the code")
> 
> Is this some new convention?

% git log --oneline --no-merges --grep Depends-on | wc -l
83

Or I misunderstood your question?

> What's wrong with 'base-commit' and 
> shouldn't it be below the '---'?

There is no guarantee with the SHA to be the same in either cases, it can be
filled later with a proper one.

-- 
With Best Regards,
Andy Shevchenko


