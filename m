Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78D0D431667
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Oct 2021 12:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbhJRKtO (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 18 Oct 2021 06:49:14 -0400
Received: from mga04.intel.com ([192.55.52.120]:41792 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229519AbhJRKtO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 18 Oct 2021 06:49:14 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10140"; a="226990106"
X-IronPort-AV: E=Sophos;i="5.85,381,1624345200"; 
   d="scan'208";a="226990106"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2021 03:47:03 -0700
X-IronPort-AV: E=Sophos;i="5.85,381,1624345200"; 
   d="scan'208";a="444008167"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.159])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2021 03:47:00 -0700
Received: from andy by smile with local (Exim 4.95)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1mcQAE-0001qc-DA;
        Mon, 18 Oct 2021 13:46:42 +0300
Date:   Mon, 18 Oct 2021 13:46:42 +0300
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
Message-ID: <YW1QkidNKa79MCBb@smile.fi.intel.com>
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
> > On Mon, Oct 18, 2021 at 12:16 PM Hans de Goede <hdegoede@redhat.com> wrote:

...

> > Btw, IIRC similar code (i.e. BYT vs CHT by CPU
> > ID) is being used elsewhere. Perhaps we might have some common
> > (library) under arc/x86, PDx86 or so (headers?)?
> 
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
> 
> Then we could do a 2 patch series adding the
> include/linux/platform_data/x86/atom.h
> file + the drivers/mfd/intel_soc_pmic_core.c
> change and Lee can merge both through the MFD tree.
> 
> And then we can do further clean-ups of e.g. sound/soc
> on top (we can ask Lee to provide an immutable branch).
> 
> How does that sound ?

Sounds like a good plan to me!

-- 
With Best Regards,
Andy Shevchenko


