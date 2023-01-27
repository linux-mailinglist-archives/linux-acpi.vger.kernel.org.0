Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9EE267E1BD
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Jan 2023 11:36:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231812AbjA0Kf7 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 27 Jan 2023 05:35:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbjA0Kf6 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 27 Jan 2023 05:35:58 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6C85783DC;
        Fri, 27 Jan 2023 02:35:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674815757; x=1706351757;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2nqetq3vJKJM622GOnM78TVf/U4BZ1Q3/ZCi5He7WMo=;
  b=edW5cLl/FgD1rF5n9T4CnbjYtOb3jgQTc4nPwNpPX3o07DNfhKPL51JW
   LuxNE2zWLD0DP3F6F0JiUBgDjr+klhy6OZfYAx67RrMYrTKy69JukCZug
   FmKihWIK1RWMTp7h7uToD/3O42y0hlLPlyaSYwMTs71jfhy1OhLUTPwv3
   gqfDbFysHMR7FUVOWJD01hWO1yE+NyFy6P1shvhCYNu54sPjwZeH7+Wni
   ii3OFJOhsRmDMcJAeSSxdio0U8TUp8Zhuu+MjHbQhcUz2PgMvrlkru7O9
   WUOfpsTXvN+Sp8TMIBagqhyobYnV+X7ate7nfVnAtM3x/h0GujbGDd1L8
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="328347118"
X-IronPort-AV: E=Sophos;i="5.97,250,1669104000"; 
   d="scan'208";a="328347118"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2023 02:35:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="695473462"
X-IronPort-AV: E=Sophos;i="5.97,250,1669104000"; 
   d="scan'208";a="695473462"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP; 27 Jan 2023 02:35:56 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pLM5K-00Fuw5-1s;
        Fri, 27 Jan 2023 12:35:54 +0200
Date:   Fri, 27 Jan 2023 12:35:54 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, linux-media@vger.kernel.org,
        rafael@kernel.org, heikki.krogerus@linux.intel.com
Subject: Re: [PATCH v3 4/8] ACPI: property: Generate camera swnodes for ACPI
 and DisCo for Imaging
Message-ID: <Y9OpCllepuR9puz/@smile.fi.intel.com>
References: <20230125224101.401285-1-sakari.ailus@linux.intel.com>
 <20230125224101.401285-5-sakari.ailus@linux.intel.com>
 <Y9Oo4L0ToRTZye2Z@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9Oo4L0ToRTZye2Z@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Jan 27, 2023 at 12:35:13PM +0200, Andy Shevchenko wrote:
> On Thu, Jan 26, 2023 at 12:40:57AM +0200, Sakari Ailus wrote:

...

> Please, address all in v3.

I meant v4.

-- 
With Best Regards,
Andy Shevchenko


