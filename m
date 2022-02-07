Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBFCB4ABF8A
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Feb 2022 14:26:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbiBGNZt (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 7 Feb 2022 08:25:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383148AbiBGMdI (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 7 Feb 2022 07:33:08 -0500
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 07 Feb 2022 04:22:30 PST
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93BB9C03E968
        for <linux-acpi@vger.kernel.org>; Mon,  7 Feb 2022 04:22:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644236550; x=1675772550;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XIr1jQmej3mUpHViSNV/dPoYzfzHAkjh3hWMNXgfwP0=;
  b=ZZhZrAXWbCpATXkLBevkk05gqLlq9A1Dcd/dgvl/V6yJ8Hh+i9lEM4ZE
   twmkV2Nn3Ks3yV3mhWf3lsokfE+qzONUkpGDnhzWREqiV+iykALybbUJq
   /iVSBeTTsYAQE8aFUJrGhN/IFBrfs7BNqeSGm4rtgpsxn4VTJJD9f5CCy
   qKFR1DjTlYiAQRR+6ggQdpRWAPqBlY0d3CRsxV59AVmYT6F+TYM2no3e6
   3RZUDDfMLJVSnhBtUCH+ZVlntzBpcnn7y+4tGqxvYu6H07YMgffklAeM1
   dbGJ5qdSiT5sowJd+yT31OU+Us+7uRnoXoa+oVsx7Db8bFyXJ69lGS7Sf
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10250"; a="247537511"
X-IronPort-AV: E=Sophos;i="5.88,349,1635231600"; 
   d="scan'208";a="247537511"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 04:21:27 -0800
X-IronPort-AV: E=Sophos;i="5.88,349,1635231600"; 
   d="scan'208";a="621531878"
Received: from smile.fi.intel.com ([10.237.72.61])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 04:21:25 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nH30M-001tau-Q7;
        Mon, 07 Feb 2022 14:20:26 +0200
Date:   Mon, 7 Feb 2022 14:20:26 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Subject: Re: [PATCH 1/4] device property: Convert
 device_{dma_supported,get_dma_attr} to fwnode
Message-ID: <YgEOitBPZ6kTtJeX@smile.fi.intel.com>
References: <20220206091643.276833-1-sakari.ailus@linux.intel.com>
 <20220206091643.276833-2-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220206091643.276833-2-sakari.ailus@linux.intel.com>
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

On Sun, Feb 06, 2022 at 11:16:40AM +0200, Sakari Ailus wrote:
> Make the device_dma_supported and device_get_dma_attr functions to use the
> fwnode ops, and move the implementation to ACPI and OF frameworks.
> 
> Depends-on: ("device property: Don't split fwnode_get_irq*() APIs in the code")

As of today: ffa743d3f33b, but might be changed in case of rebase happens in
the future.

-- 
With Best Regards,
Andy Shevchenko


