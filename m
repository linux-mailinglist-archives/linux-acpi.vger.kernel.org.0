Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2D344ABF88
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Feb 2022 14:25:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344014AbiBGNYE (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 7 Feb 2022 08:24:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244800AbiBGMiw (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 7 Feb 2022 07:38:52 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E4A1E01D521;
        Mon,  7 Feb 2022 04:29:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644236945; x=1675772945;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OIJmupebT95r0SLBp7LFbS4wwcb9tS97pZJIgwxCG2s=;
  b=Sj6IvvYztqmTTcZXxBq7NdmWTOKOT3IEveB125JRY1HIOZ0ZPNwAT3uN
   sqtoEFtYkdhbDWZG5weXeonCPjFGKUvrnpDJhJ5Hc/ZlexKKzeBuvkAPF
   E7s5CYoTYZd3s61IBMdQrxMZnDcwntxQlqQjo+Wt256qL0pulWc8vFOX1
   QRykeeOw51QOT/WJaTqeoYYfYHPfDe1yAI6MObcmG+pjzWGOjfn6SO8A8
   YQT+Wc9wvW/9wdMMNN7a7LikSVDYclCIz7xlRwVVYI1As6kd9ONfAGMaC
   cueh8sUzBy/fKqq+rNM03waXxeWSUoiCQcGhy8Ca8WFqV5HcwCtfwkSMg
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10250"; a="335108095"
X-IronPort-AV: E=Sophos;i="5.88,349,1635231600"; 
   d="scan'208";a="335108095"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 04:28:44 -0800
X-IronPort-AV: E=Sophos;i="5.88,349,1635231600"; 
   d="scan'208";a="484405267"
Received: from smile.fi.intel.com ([10.237.72.61])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 04:28:42 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nH37P-001tmr-LQ;
        Mon, 07 Feb 2022 14:27:43 +0200
Date:   Mon, 7 Feb 2022 14:27:43 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Subject: Re: [PATCH 0/4] Shovel firmware specific code to appropriate
 locations
Message-ID: <YgEQP3QGtqre+nCL@smile.fi.intel.com>
References: <20220206091643.276833-1-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220206091643.276833-1-sakari.ailus@linux.intel.com>
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

On Sun, Feb 06, 2022 at 11:16:39AM +0200, Sakari Ailus wrote:
> Hi folks,
> 
> This set moves the implementation of recently added device property API
> functions to OF and ACPI frameworks, where the rest of such functionality
> resides.
> 
> Compile tested.

All look good to me,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Note that after some initial confusion, this set actually does depend on
> Andy's patch "device property: Don't split fwnode_get_irq*() APIs in the
> code" to appear in the linux-acpi tree.

Perhaps than you can add to your series the conversion of
fwnode_irq_get_byname()?

> Sakari Ailus (4):
>   device property: Convert device_{dma_supported,get_dma_attr} to fwnode
>   ACPI: property: Move acpi_fwnode_device_get_match_data() up
>   device property: Add iomap to fwnode operations
>   device property: Add irq_get to fwnode operation
> 
>  drivers/acpi/property.c | 36 +++++++++++++++++++++++++++++++----
>  drivers/base/property.c | 42 ++++++-----------------------------------
>  drivers/of/property.c   | 31 ++++++++++++++++++++++++++++++
>  include/linux/fwnode.h  |  5 +++++
>  4 files changed, 74 insertions(+), 40 deletions(-)
> 
> -- 
> 2.30.2
> 
> 

-- 
With Best Regards,
Andy Shevchenko


