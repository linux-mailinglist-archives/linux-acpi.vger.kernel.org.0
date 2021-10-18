Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9B32431679
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Oct 2021 12:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbhJRKxM (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 18 Oct 2021 06:53:12 -0400
Received: from mga12.intel.com ([192.55.52.136]:3537 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229473AbhJRKxM (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 18 Oct 2021 06:53:12 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10140"; a="208325560"
X-IronPort-AV: E=Sophos;i="5.85,381,1624345200"; 
   d="scan'208";a="208325560"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2021 03:51:00 -0700
X-IronPort-AV: E=Sophos;i="5.85,381,1624345200"; 
   d="scan'208";a="593765811"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.159])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2021 03:50:58 -0700
Received: from andy by smile with local (Exim 4.95)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1mcQE4-0001tj-8l;
        Mon, 18 Oct 2021 13:50:40 +0300
Date:   Mon, 18 Oct 2021 13:50:40 +0300
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Tsuchiya Yuto <kitakar@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Andy Shevchenko <andy@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 1/1] ACPI / PMIC: Add i2c address to
 intel_pmic_bytcrc driver
Message-ID: <YW1RgNMWGg8PW9ia@smile.fi.intel.com>
References: <20211017161523.43801-1-kitakar@gmail.com>
 <20211017161523.43801-2-kitakar@gmail.com>
 <3e6428f1-9411-fac6-9172-1dfe6de58c28@redhat.com>
 <CAHp75VcA+=OsmX7o2WTvYgf8TNpE64qEHq=MVm5vVP-4RBk+ng@mail.gmail.com>
 <3c9d4f9b-26c2-a135-eb2e-67963aa0bc0b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c9d4f9b-26c2-a135-eb2e-67963aa0bc0b@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Oct 18, 2021 at 12:38:51PM +0200, Hans de Goede wrote:
> On 10/18/21 12:31, Andy Shevchenko wrote:

...

> We already have helpers for this defined in:
> 
> sound/soc/intel/common/soc-intel-quirks.h
> 
> We could move those to some header under include, maybe:
> 
> include/linux/platform_data/x86/atom.h
> 
> And add #ifdef-ery there so that things will also build on
> non x86 ?

But it seems the above mentioned header has the stubs!


-- 
With Best Regards,
Andy Shevchenko


