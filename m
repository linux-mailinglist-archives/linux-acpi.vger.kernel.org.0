Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DD764E564F
	for <lists+linux-acpi@lfdr.de>; Wed, 23 Mar 2022 17:27:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238564AbiCWQ2g (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 23 Mar 2022 12:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239650AbiCWQ2f (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 23 Mar 2022 12:28:35 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DA3617A82;
        Wed, 23 Mar 2022 09:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648052826; x=1679588826;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PSwOYGMNforfQR+WoxKFhheJUlLrBbUwxRMosTEqx44=;
  b=Akd3HyMI3Pwb0dUhpq+jwo6RC5iAr53m3VO5hpAz4mp0oESl7COG1dVF
   SldskjwYKiIRqQwcDyfXKJwmk1LlYQTACU3GxI6niUnfLfBYPIPsY1ZNP
   FDyQyZZadyIq3TSY7Gz8Su57lvI5S1wdb1aauuoaTyDjIV2si84WQGhWq
   knuVUluI0CqQdaWmlO2IJB6oz/jfUjgi2cif8KDsr5wJzwQI+p/pP2u42
   +DFHCo4LCaQygEbSplsW60nib/7T9fdvHhWZFTAnTY6CTVhTZOKjiP1Eh
   4ty70QKOicBfBNcdrFl1bK/wqwegTqqn9/+nsG1bX503iA96s82rz+imS
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10295"; a="240320471"
X-IronPort-AV: E=Sophos;i="5.90,204,1643702400"; 
   d="scan'208";a="240320471"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 09:21:22 -0700
X-IronPort-AV: E=Sophos;i="5.90,204,1643702400"; 
   d="scan'208";a="649495814"
Received: from smile.fi.intel.com ([10.237.72.59])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 09:21:20 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nX3j1-005IPs-KU;
        Wed, 23 Mar 2022 18:20:43 +0200
Date:   Wed, 23 Mar 2022 18:20:43 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
        "Rafael J.Wysocki" <rafael@kernel.org>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Subject: Re: [PATCH v2 0/4] Shovel firmware specific code to appropriate
 locations
Message-ID: <YjtI22BnRjfNOVhG@smile.fi.intel.com>
References: <20220323154737.169483-1-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220323154737.169483-1-sakari.ailus@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Mar 23, 2022 at 05:47:33PM +0200, Sakari Ailus wrote:
> Hi folks,
> 
> This set moves the implementation of recently added device property API
> functions to OF and ACPI frameworks, where the rest of such functionality
> resides.
> 
> Compile tested.

Thanks!

It would be nice to use --base when creating a cover letter.
Because it has been sent during merge window, I'm not sure
what base you have chosen for it (v5.17 or latest Linus'
master or ...).

> The dependencies can be found in Rafael's devprop branch now.
> 
> changes since v1:
> 
> - Drop wrongly placed Depends-on: tag from the first patch.
> 
> - Drop IS_ENABLED(CONFIG_OF_ADDRESS) && is_of_node(fwnode) check (3rd
>   patch).
> 
> Sakari Ailus (4):
>   device property: Convert device_{dma_supported,get_dma_attr} to fwnode
>   ACPI: property: Move acpi_fwnode_device_get_match_data() up
>   device property: Add iomap to fwnode operations
>   device property: Add irq_get to fwnode operation
> 
>  drivers/acpi/property.c | 36 +++++++++++++++++++++++++++++++----
>  drivers/base/property.c | 42 ++++++-----------------------------------
>  drivers/of/property.c   | 30 +++++++++++++++++++++++++++++
>  include/linux/fwnode.h  |  5 +++++
>  4 files changed, 73 insertions(+), 40 deletions(-)

-- 
With Best Regards,
Andy Shevchenko


