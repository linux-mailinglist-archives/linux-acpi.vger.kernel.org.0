Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC1D3424B9
	for <lists+linux-acpi@lfdr.de>; Fri, 19 Mar 2021 19:34:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbhCSSde (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 19 Mar 2021 14:33:34 -0400
Received: from mga06.intel.com ([134.134.136.31]:48421 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230393AbhCSSdR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 19 Mar 2021 14:33:17 -0400
IronPort-SDR: MnUSvntjm//hzxOaMAEuBofW79owcEW17ZS2jM6+WO5qwmGJh/9Yf4vXGs4knV9hvQ73KBZQJm
 8C5ltfyxfVyg==
X-IronPort-AV: E=McAfee;i="6000,8403,9928"; a="251297262"
X-IronPort-AV: E=Sophos;i="5.81,262,1610438400"; 
   d="scan'208";a="251297262"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2021 11:33:16 -0700
IronPort-SDR: Nd23J8p0IS4rhosGPFrYVzUt6m4vQfTKxrx9A82I5qijRQuGL8BMNULqWpv9lixPAbWaK3Njq0
 acYaMsJDmq3g==
X-IronPort-AV: E=Sophos;i="5.81,262,1610438400"; 
   d="scan'208";a="373153098"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2021 11:33:15 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lNJvs-00DwTh-7d; Fri, 19 Mar 2021 20:33:12 +0200
Date:   Fri, 19 Mar 2021 20:33:12 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Subject: Re: [PATCH v1 1/1] ACPI: scan: Use unique number for instance_no
Message-ID: <YFTuaK9pJm/ZZzMk@smile.fi.intel.com>
References: <20210312160137.19463-1-andriy.shevchenko@linux.intel.com>
 <CAJZ5v0jHXQC+P1_FTq6TkMKAb=FsBH=cw3mUkp9rJUC7R1B-5A@mail.gmail.com>
 <YFToGiFbGkJDDaMF@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFToGiFbGkJDDaMF@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Mar 19, 2021 at 08:06:18PM +0200, Andy Shevchenko wrote:
> On Fri, Mar 19, 2021 at 06:00:38PM +0100, Rafael J. Wysocki wrote:
> > On Fri, Mar 12, 2021 at 5:02 PM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:

> > This is a slightly convoluted way of stating that there is a bug in
> > acpi_device_del().
> 
> Any suggestion how to massage the above?
> But in the dry end, yes, decrementing is a bug.

Okay, v2 has been sent. I tried to simplify the message.


-- 
With Best Regards,
Andy Shevchenko


