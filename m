Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1459E79CBCD
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Sep 2023 11:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233704AbjILJar (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 12 Sep 2023 05:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbjILJaq (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 12 Sep 2023 05:30:46 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10CE0123
        for <linux-acpi@vger.kernel.org>; Tue, 12 Sep 2023 02:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694511043; x=1726047043;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZZsMX87ZBA2LSNsBXxrcaHlzB7WnuqbevwSrDLDgc/k=;
  b=FWbHFI9hDt/GXTR1LMvmhTicqJiBHK05mFEsZmMeJvqslj9/43yc8JhA
   fMDcn2LVQUQoMYunuu7+P+l4W5iEZKv64Yi16l3p+1qMXyweCQ+sNM7JH
   YSjqX7D3p5SsczDURQ80En2c6tWJLjcsRL2acICvC48JQjEcsqxEcixDF
   ypHHvbmc70JcQqnMzrv+7+7O/dAZXUqOpMBb6ouyZ1duqclEXDMYMBPqM
   A4E2TAibQYwT5lYJNwgQcQ3qkaJ+ctdfniKt6wz9pDtAIaHCf/7fDLrxm
   dw5xowEBNh+Fe/1cq86vewaoa3K77nW4JG58PHJ8hOSs1FiTX55bvu3Q+
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="381025440"
X-IronPort-AV: E=Sophos;i="6.02,245,1688454000"; 
   d="scan'208";a="381025440"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 02:30:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="990440198"
X-IronPort-AV: E=Sophos;i="6.02,245,1688454000"; 
   d="scan'208";a="990440198"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 02:30:18 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qfzin-008Y4U-0a;
        Tue, 12 Sep 2023 12:30:13 +0300
Date:   Tue, 12 Sep 2023 12:30:12 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Ken Xue <Ken.Xue@amd.com>
Cc:     linux-acpi@vger.kernel.org, oe-kbuild-all@lists.linux.dev,
        rafael@kernel.org, kernel test robot <lkp@intel.com>,
        cwhuang@linux.org.tw
Subject: Re: [PATCH] acpi: trigger wakeup key event from power button
Message-ID: <ZQAvpIKqmLeWbh0v@smile.fi.intel.com>
References: <20230908095747.446389-1-Ken.Xue@amd.com>
 <ZP7hH9i6ZQgINbcB@smile.fi.intel.com>
 <2bfaa431-ca9f-c879-9967-f13d18dd4cd3@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2bfaa431-ca9f-c879-9967-f13d18dd4cd3@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Sep 12, 2023 at 01:32:02PM +0800, Ken Xue wrote:
> On 2023/9/11 17:42, Andy Shevchenko wrote:
> > On Fri, Sep 08, 2023 at 05:57:49PM +0800, Ken Xue wrote:

...

> > > Reported-by: kernel test robot <lkp@intel.com>
> > Are you sure?
> 
> Thanks for review. Sorry for confusion.

> 2) test robot reported some compile warnings and errors detected by test
> robot which is fixed in V2.

Yes and that's what I'm asking about. You are not supposed to add it as the
initial problem, the patch is trying to solve, has _not_ been reported by LKP,
hasn't it?

...

> > > Closes: https://lore.kernel.org/oe-kbuild-all/202309080315.txQUEyHQ-lkp@intel.com/
> > > Closes: https://lore.kernel.org/oe-kbuild-all/202309080239.IiC7uLpW-lkp@intel.com/
> > > Closes: https://lore.kernel.org/oe-kbuild-all/202309080351.xHt2qhP2-lkp@intel.com/
> > Are you sure?
> 
> Just some errors/warnings from the v1 patch.

Same as above.

...

> > > +#include <linux/acpi.h>
> > There are no users of this header.
> > 
> > Check how forward declaration can be used (as it's done in many other headers).
> > 
> Yes, "struct acpi_device" is defined in "include/acpi/acpi_bus.h", but
> include acpi_bus.h alone will lead to more compile issues.
> 
> Regarding "forward declaration", how about
> 
> typedef struct acpi_device *acpi_device;

Is it a forward declaration?

-- 
With Best Regards,
Andy Shevchenko


