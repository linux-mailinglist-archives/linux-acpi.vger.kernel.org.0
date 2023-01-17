Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23EFD66E230
	for <lists+linux-acpi@lfdr.de>; Tue, 17 Jan 2023 16:32:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbjAQPcH (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 17 Jan 2023 10:32:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbjAQPcG (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 17 Jan 2023 10:32:06 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26E4E3FF39;
        Tue, 17 Jan 2023 07:32:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673969526; x=1705505526;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=w7aaBkY6MNp7sQab/fhF239zMUAKOfh0eKz8mwW82Ms=;
  b=c8Hc24IT1ISAOmAZzDNfZ6WzOI+DqM6mADZhsbshjrJBL+2wk+Ht7HvL
   +dQQP/pr8EWV5u1TDdjy1kCKcTFl2qOWsYmqrtUlrK7bZBqkyrjogQIym
   a/mfUobudGNbf7ZXTENTU1JAijUhJIVgeyWhqmyjGaLt3h2aWMS2I3zpk
   aJLMq69pjzI1De55sEshqhqwACiBwg6ZLj/OvdBvrIacqSDQPL8qMtF3f
   sGHjahdH9PWCcqNsMUxPSlhpwRS44YxUAlqo26FzrGDBsP8lkqKpFG6uF
   a+FyNqkn0QZnFQ/pKPpVh76CAfR3Zy1BIR/h26TgIjZFYsEa/Uvgl/Blp
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="322410658"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="322410658"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 07:32:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="659423609"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="659423609"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP; 17 Jan 2023 07:32:01 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pHnwO-00AdZc-1N;
        Tue, 17 Jan 2023 17:32:00 +0200
Date:   Tue, 17 Jan 2023 17:32:00 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, rafael@kernel.org,
        linux-media@vger.kernel.org, heikki.krogerus@linux.intel.com
Subject: Re: [PATCH 8/8] ACPI: property: Document _CRS CSI-2 and DisCo for
 Imaging support
Message-ID: <Y8a/cIk3tw1BOrPY@smile.fi.intel.com>
References: <20230117122244.2546597-1-sakari.ailus@linux.intel.com>
 <20230117122244.2546597-9-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230117122244.2546597-9-sakari.ailus@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Jan 17, 2023 at 02:22:44PM +0200, Sakari Ailus wrote:
> Document how ACPI _CRS CSI-2 and DisCo for Imaging works. It's non-trivial
> so such documentation can be useful.

...

>   * Copyright (C) 2022 Intel Corporation

2022,2023 ?

-- 
With Best Regards,
Andy Shevchenko


