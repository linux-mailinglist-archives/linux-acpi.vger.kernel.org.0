Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C35A576C75
	for <lists+linux-acpi@lfdr.de>; Sat, 16 Jul 2022 10:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbiGPIAU (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 16 Jul 2022 04:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiGPIAT (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 16 Jul 2022 04:00:19 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D73127B00
        for <linux-acpi@vger.kernel.org>; Sat, 16 Jul 2022 01:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657958419; x=1689494419;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CFHaSggwCfHZZKMh1YI0Zx1sZScANLI2HKAp3uiWt4k=;
  b=lSsuwsSA3I8vhuNbnti5ddnFTrN4I7rrRf/FWaZyVwd9E6kgFU00xdEv
   ZOP7MvbA2nlYAtdtkr5CSS2alJkf1SN/1GaVc5Mi8OwsSydrFFZc3NmDS
   Mge/zsFwuE71piJ/M9/UVdIOLDseyUy0ln1vKVKgFg3/ArokA0EGFYlbG
   Obp+ZuYMb381WWnqe2pCMz6X88VRAfiETjYKO7d499p5N3V5CQeeg903O
   iYtcbSnzEVBOzJ0MIDYlhJLLd1ka5q+AseAuq75m/739CFzaCYM6aOKdn
   x7s0G7LDL1eXpTtj1hXzlsmqNB5utBJNux4vcmmwpH0jYKw0eTIem/Dxt
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10409"; a="372271606"
X-IronPort-AV: E=Sophos;i="5.92,276,1650956400"; 
   d="scan'208";a="372271606"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2022 01:00:18 -0700
X-IronPort-AV: E=Sophos;i="5.92,276,1650956400"; 
   d="scan'208";a="624140078"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2022 01:00:17 -0700
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id 0F240202EA;
        Sat, 16 Jul 2022 11:00:15 +0300 (EEST)
Date:   Sat, 16 Jul 2022 08:00:15 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Shevchenko, Andriy" <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v4 7/8] ACPI: property: Add support for parsing buffer
 property UUID
Message-ID: <YtJwD/BspZxoJySJ@paasikivi.fi.intel.com>
References: <20220711112606.3050368-1-sakari.ailus@linux.intel.com>
 <20220711112606.3050368-8-sakari.ailus@linux.intel.com>
 <CAJZ5v0gQuGYjH=twZKcy0FmsK6vVyboN0ubOXZqHVVNfyuP1PQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gQuGYjH=twZKcy0FmsK6vVyboN0ubOXZqHVVNfyuP1PQ@mail.gmail.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Rafael,

Thanks for the review.

On Fri, Jul 15, 2022 at 07:59:21PM +0200, Rafael J. Wysocki wrote:
> On Mon, Jul 11, 2022 at 1:24 PM Sakari Ailus
> <sakari.ailus@linux.intel.com> wrote:
> >
> > Add support for newly added buffer property UUID, as defined in the DSD
> > guide.
> 
> A link to the DSD guide and a more specific reference to the relevant
> part of it (eg. section number) would be handy.

That would be 3.3
<URL:https://github.com/UEFI/DSD-Guide/blob/main/src/dsd-guide.adoc#buffer-data-extension-uuid>.

I'll add that for v5.

-- 
Sakari Ailus
