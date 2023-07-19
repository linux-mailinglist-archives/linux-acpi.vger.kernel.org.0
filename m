Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8239E7599E9
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Jul 2023 17:37:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbjGSPhD (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 19 Jul 2023 11:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbjGSPhC (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 19 Jul 2023 11:37:02 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89151C1
        for <linux-acpi@vger.kernel.org>; Wed, 19 Jul 2023 08:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689781021; x=1721317021;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=w5oZ3yTWCtw/BC1LENiUVpDCssX4Anb1DbShgHLXQA8=;
  b=Lb0LxPGFz2qiaL8zgwqsKwUEnrL8ZntQ5J3XjC2PrlpzRw2Z/WfEtaI+
   Ajwjl/IOTcc1Efio+iu2BRO0uDP34a40bUt/Tyqn3IRbGJd4/O4Q3L7IR
   LHD0ecDQF+Q9PFiwiv1ooAITtWNtaIc2yQjBnXl6WYlpeU3gVM+ygE9af
   S10lbfy/ocbDP/IJ8The7LOFjHsK6cLztmqS0cT+tvXnua/8pIVj+DBXh
   r9m59mvW2Qr7T6Cj8uHrV3ADR0l8XGBtVtKTAK5qe9GHsC6W8K5TgX89D
   WucrhQW1k/m0ZSiVjW8RMUujWKuAVK5GdaM8dKpD7bB8hpfHs4H2Lrksx
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="452873863"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="452873863"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2023 08:36:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="718020924"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="718020924"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP; 19 Jul 2023 08:36:46 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qM9EK-00GTqo-30;
        Wed, 19 Jul 2023 18:36:44 +0300
Date:   Wed, 19 Jul 2023 18:36:44 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Cezary Rojewski <cezary.rojewski@intel.com>
Cc:     rafael@kernel.org, linux-acpi@vger.kernel.org,
        robert.moore@intel.com, pierre-louis.bossart@linux.intel.com,
        amadeuszx.slawinski@linux.intel.com
Subject: Re: [PATCH v2 2/4] ACPI: NHLT: Introduce acpi_gbl_NHLT
Message-ID: <ZLgDDB7vH/4FaI06@smile.fi.intel.com>
References: <20230717150047.15196-1-cezary.rojewski@intel.com>
 <20230717150047.15196-3-cezary.rojewski@intel.com>
 <4af468ff-6b87-962d-8629-52bb7d9ee340@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4af468ff-6b87-962d-8629-52bb7d9ee340@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Jul 19, 2023 at 04:47:31PM +0200, Cezary Rojewski wrote:
> On 2023-07-17 5:00 PM, Cezary Rojewski wrote:

...

> > +++ b/drivers/acpi/nhlt.c
> > @@ -0,0 +1,13 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +//
> > +// Copyright(c) 2023 Intel Corporation. All rights reserved.
> > +//
> > +// Authors: Cezary Rojewski <cezary.rojewski@intel.com>
> > +//          Amadeusz Slawinski <amadeuszx.slawinski@linux.intel.com>
> > +//
> > +
> > +#include <linux/export.h>
> > +#include <acpi/nhlt.h>
> > +
> > +struct acpi_table_nhlt *acpi_gbl_NHLT;
> > +EXPORT_SYMBOL_GPL(acpi_gbl_NHLT);
> 
> This approach generates a problem with undefined symbol "acpi_gbl_NHLT" when
> ACPI_NHLT is disabled. As nhlt.c is not built when said kconfig is disabled,
> symbol is never defined.
> 
> Proposed solution - modify drivers/acpi/tables.c with:
> 
> +#include <acpi/nhlt.h>
> +
> +struct acpi_table_nhlt *acpi_gbl_NHLT;
> +EXPORT_SYMBOL_GPL(acpi_gbl_NHLT);
> 
> as tables.c is always built the symbol is always there.
> The only other option I see is:
> 
> -obj-$(CONFIG_ACPI_NHLT)	+= nhlt.o
> +obj-y				+= nhlt.o
> 
> and modifying nhlt.c so it's essentially split in half with:
> #if IS_ENABLED(CONFIG_ACPI_NHLT)
> 
> but such solutions stinks. I prefer the first approach.
> What to you find guys?

I leave this to Rafael as it's his territory.

-- 
With Best Regards,
Andy Shevchenko


