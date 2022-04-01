Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAC8E4EEEB4
	for <lists+linux-acpi@lfdr.de>; Fri,  1 Apr 2022 15:59:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346620AbiDAOBf (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 1 Apr 2022 10:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346629AbiDAOBd (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 1 Apr 2022 10:01:33 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE4816623A;
        Fri,  1 Apr 2022 06:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648821584; x=1680357584;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TNn0jwiZyy2Bm4qdeuMEH72Uk556e7hle8S7qhOqgZo=;
  b=ku7VbdEwEjvjk8erCmekbdbyJtmzP8CwcovJgu2TycFHOizv6IyKOm/9
   zqRDNC7HwqnLoroAdYw1Fq80uPJgyV7kuIhq4HhdGa3Rckyy5pwwr86sN
   wz7cbRWmdeBD8SBzzbfoLayn37MMqB13Pbu3U3SryafpGfXpsn6QzcjRn
   JoJoeeBUcr/YOR4oCQ0UiUPXE9esu0RHoGcK3xaIIyOFt7UuJ4aY+0iBT
   Ch6YlYKrdHEK7IH8JtcRVSqYqY1+acuolRACH04Yj7Mj0bv1bNNInx91F
   7yDW905JzPq0wPq4G5cHYOTavkl6Qqs7udXKAYIEEOtegB+CS3WPIXLm3
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10304"; a="260127023"
X-IronPort-AV: E=Sophos;i="5.90,227,1643702400"; 
   d="scan'208";a="260127023"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2022 06:59:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,227,1643702400"; 
   d="scan'208";a="695901161"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 01 Apr 2022 06:59:39 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Fri, 01 Apr 2022 16:59:38 +0300
Date:   Fri, 1 Apr 2022 16:59:38 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, andriy.shevchenko@linux.intel.com,
        devicetree@vger.kernel.org, "Rafael J.Wysocki" <rafael@kernel.org>,
        Daniel Scally <djrscally@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Subject: Re: [PATCH v3 0/4] Shovel firmware specific code to appropriate
 locations
Message-ID: <YkcFSgL+j1IvSsby@kuha.fi.intel.com>
References: <20220331125450.218045-1-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220331125450.218045-1-sakari.ailus@linux.intel.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Mar 31, 2022 at 03:54:46PM +0300, Sakari Ailus wrote:
> Hi folks,
> 
> This set moves the implementation of recently added device property API
> functions to OF and ACPI frameworks, where the rest of such functionality
> resides.
> 
> Compile tested.
> 
> The dependencies can be found in Rafael's devprop branch now.
> 
> since v2:
> 
> - Add pre-processor check for CONFIG_OF_ADDRESS in of_fwnode_iomap() (3rd
>   patch).
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
>  drivers/of/property.c   | 34 +++++++++++++++++++++++++++++++++
>  include/linux/fwnode.h  |  5 +++++
>  4 files changed, 77 insertions(+), 40 deletions(-)

These look good to me. FWIW:

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

thanks,

-- 
heikki
