Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 889A8244C3B
	for <lists+linux-acpi@lfdr.de>; Fri, 14 Aug 2020 17:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726745AbgHNPjZ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 14 Aug 2020 11:39:25 -0400
Received: from mga14.intel.com ([192.55.52.115]:44094 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726596AbgHNPjY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 14 Aug 2020 11:39:24 -0400
IronPort-SDR: w3Fm7uUW3qYoDrGeFt/spNQ9P2w4CKSuYX6Tn15lO8hN0TEWuzOpBuAiizAffdPCsGOb8Ugy/L
 bNIwcWVVxAfw==
X-IronPort-AV: E=McAfee;i="6000,8403,9713"; a="153667526"
X-IronPort-AV: E=Sophos;i="5.76,312,1592895600"; 
   d="scan'208";a="153667526"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2020 08:39:23 -0700
IronPort-SDR: H/WLMhXf8+TVaikCN5jokFNI7+wY1Aa+3sgpEkkNvwGWfPPwNEpkF1dXTXp9w7yjVRsAAUcG05
 mePWHfTBNIjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,312,1592895600"; 
   d="scan'208";a="325755107"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008.jf.intel.com with ESMTP; 14 Aug 2020 08:39:22 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1k6bnd-008g88-FT; Fri, 14 Aug 2020 18:39:21 +0300
Date:   Fri, 14 Aug 2020 18:39:21 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v1 1/7] resource: Simplify region_intersects() by
 reducing conditionals
Message-ID: <20200814153921.GT1891694@smile.fi.intel.com>
References: <20200813175729.15088-1-andriy.shevchenko@linux.intel.com>
 <CAJZ5v0hF7CJYQJsvGbPCr+1Rfi_QqeMkT4z3MrGfmB00CdQvyA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hF7CJYQJsvGbPCr+1Rfi_QqeMkT4z3MrGfmB00CdQvyA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Aug 14, 2020 at 05:17:22PM +0200, Rafael J. Wysocki wrote:
> On Thu, Aug 13, 2020 at 7:57 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > Now we have for 'other' and 'type' variables
> >
> > other   type    return
> >   0       0     REGION_DISJOINT
> >   0       x     REGION_INTERSECTS
> >   x       0     REGION_DISJOINT
> >   x       x     REGION_MIXED
> >
> > Obviously it's easier to check 'type' for 0 first instead of
> > currently checked 'other'.

...

> > +       return (other == 0) ? REGION_INTERSECTS : REGION_MIXED;
> 
> The parens are not needed here.

Right.

> Also I would do
> 
> if (other == 0)
>        REGION_INTERSECTS;
> 
> return REGION_MIXED;

Works for me, I'll update in v2.

-- 
With Best Regards,
Andy Shevchenko


