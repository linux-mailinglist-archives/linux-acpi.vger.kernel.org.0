Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC04275C860
	for <lists+linux-acpi@lfdr.de>; Fri, 21 Jul 2023 15:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbjGUNxR (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 21 Jul 2023 09:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231636AbjGUNxD (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 21 Jul 2023 09:53:03 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFA76273C
        for <linux-acpi@vger.kernel.org>; Fri, 21 Jul 2023 06:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689947564; x=1721483564;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jsA717zX3j2bcH6zZLqOBOFc81Z+G4iHVU4J8wc3OP0=;
  b=gI1/uh95+xLgKhbzx29lX5QZ0duzj/zdHsaYhVPxKD1geElZEA4gUXw3
   AUJa8WW8mVe5R0A0JbN6IpJBjwR2bedgbDf0KA8t9H9ddv8dMFN6l2fcT
   O6NNK9Rk2wnseOjjQ47TWZ2Su1isGEm98ybDMUknBXX+vdJzjbrKgbjvw
   7m+3OciDYxCeisWyWPba28KhbMvUFK1ovroJSDvJKov6yarAyEoJhZ6oN
   xDvUT66mwAYzP15mf7q/n3Y7lmHpVD18ZOz4lFlUuvfFB5LB1cD77gRH9
   XAyUn66NnoOCw6QK1Ih0AcmaySpV3Rh2xESCJc3oFAL/9jRETIJ34OdvO
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10778"; a="365919695"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="365919695"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 06:52:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10778"; a="898721223"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="898721223"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP; 21 Jul 2023 06:52:34 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qMqYb-0075Ed-21;
        Fri, 21 Jul 2023 16:52:33 +0300
Date:   Fri, 21 Jul 2023 16:52:33 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Cezary Rojewski <cezary.rojewski@intel.com>
Cc:     rafael@kernel.org, robert.moore@intel.com,
        linux-acpi@vger.kernel.org, amadeuszx.slawinski@linux.intel.com,
        pierre-louis.bossart@linux.intel.com
Subject: Re: [PATCH v3 2/4] ACPI: NHLT: Introduce acpi_gbl_nhlt
Message-ID: <ZLqNoURJVG47xtjy@smile.fi.intel.com>
References: <20230721094722.300586-1-cezary.rojewski@intel.com>
 <20230721094722.300586-3-cezary.rojewski@intel.com>
 <ZLpigtZ0ptwhhWEi@smile.fi.intel.com>
 <95930a64-d7eb-7d88-d7ee-13a319674d77@intel.com>
 <ZLqAMf2eakwSfBgs@smile.fi.intel.com>
 <668566f3-c545-f10a-f2bd-37419f60b91c@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <668566f3-c545-f10a-f2bd-37419f60b91c@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Jul 21, 2023 at 03:18:11PM +0200, Cezary Rojewski wrote:
> On 2023-07-21 2:55 PM, Andy Shevchenko wrote:
> > On Fri, Jul 21, 2023 at 02:44:42PM +0200, Cezary Rojewski wrote:
> > > On 2023-07-21 12:48 PM, Andy Shevchenko wrote:
> > > > On Fri, Jul 21, 2023 at 11:47:20AM +0200, Cezary Rojewski wrote:

...

> > > > > @@ -594,6 +594,9 @@ config ACPI_PRMT
> > > > 
> > > > > +config ACPI_NHLT
> > > > 
> > > > Wouldn't be better to squeeze it to the most ordered piece of the file, so
> > > > the list of the table support code files will be kinda ordered?
> > > 
> > > I may be wrong about this, but it seems that the driver/acpi/Kconfig file
> > > does not list tables supported in any kind of ordered fashion. I'd refrain
> > > from reordering the Kconfig in this very patch and rather have such job done
> > > in a separate series instead.
> > 
> > Yes, but my point to make this job easier to whoever will do it.
> 
> Hmm.. I see that the most occurrences of word "Table" is around
> ACPI_SPCR_TABLE/_FPDT/LPIT area. Should I put it after ACPI_LPIT perhaps?

Works for me!
As I wrote "most ordered place" and "kinda ordered" above.

> > > > Otherwise looks good to me, FWIW,
> > > > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


