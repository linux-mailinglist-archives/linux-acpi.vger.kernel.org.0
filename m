Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C25F167E0E5
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Jan 2023 10:57:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbjA0J5z (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 27 Jan 2023 04:57:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232494AbjA0J5y (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 27 Jan 2023 04:57:54 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6D5611147;
        Fri, 27 Jan 2023 01:57:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674813473; x=1706349473;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=k0+sy6y1SsnDMDZP39L7AXZkPt4MgxRgZuU7uiXtT4Y=;
  b=X1O4ccpiB/BN3NZTExy8W9+f/HTGf4sbd9pkEdhn/DNuMFUL1TMuzoGF
   6bipKLZiOG6C+aFuLiUlJgFiVjeEJPI7D2zZeQbFdevz8m/i8HnAZx5Jp
   3a8T41YciZlsKGu7aN90L80HLO+YB0w/eQaIR+5lIKEQwzVC8ume0Kwy0
   OekEEFxAyfLyfl0QMbwgsernfjmmRGm/1e0cOcHie/SDzaHwYdwbG2Jar
   Tcp0KlNyt14jEa3X8EvAvkFiBFx3UcndUUhRccyK6dJoFU3e0IxvVymgc
   +FmaglybEENC4CPgScTXRsTmjbUQZc/yj36XHrGS5pirOV3iWLP3blYQ9
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="329181562"
X-IronPort-AV: E=Sophos;i="5.97,250,1669104000"; 
   d="scan'208";a="329181562"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2023 01:57:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="908617169"
X-IronPort-AV: E=Sophos;i="5.97,250,1669104000"; 
   d="scan'208";a="908617169"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP; 27 Jan 2023 01:57:51 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pLLUU-00FuAU-0L;
        Fri, 27 Jan 2023 11:57:50 +0200
Date:   Fri, 27 Jan 2023 11:57:49 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, linux-media@vger.kernel.org,
        rafael@kernel.org, heikki.krogerus@linux.intel.com
Subject: Re: [PATCH v3 1/8] ACPI: property: Parse data node string references
 in properties
Message-ID: <Y9OgHT6OaTrMFAk4@smile.fi.intel.com>
References: <20230125224101.401285-1-sakari.ailus@linux.intel.com>
 <20230125224101.401285-2-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230125224101.401285-2-sakari.ailus@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Jan 26, 2023 at 12:40:54AM +0200, Sakari Ailus wrote:
> Add support for parsing property references using strings, besides
> reference objects that were previously supported. This allows also
> referencing data nodes which was not possible with reference objects.
> 
> Also add pr_fmt() macro to prefix printouts.
> 
> While at it, update copyright.

...

> - * Copyright (C) 2014, Intel Corporation
> + * Copyright (C) 2014--2023, Intel Corporation

As I pointed out this is non-traditional way on how you provide range of the
years in the Copyright line.

-- 
With Best Regards,
Andy Shevchenko


