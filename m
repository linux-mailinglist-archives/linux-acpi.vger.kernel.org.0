Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0539BE475A
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Oct 2019 11:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729906AbfJYJd3 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 25 Oct 2019 05:33:29 -0400
Received: from mga17.intel.com ([192.55.52.151]:41157 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729612AbfJYJd3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 25 Oct 2019 05:33:29 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Oct 2019 02:33:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,228,1569308400"; 
   d="scan'208";a="400055610"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga006.fm.intel.com with ESMTP; 25 Oct 2019 02:33:26 -0700
Received: from andy by smile with local (Exim 4.92.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1iNvyH-00030l-QX; Fri, 25 Oct 2019 12:33:25 +0300
Date:   Fri, 25 Oct 2019 12:33:25 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Lee Jones <lee.jones@linaro.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] ACPI / PMIC: Add byt prefix to Crystal Cove PMIC
 OpRegion driver
Message-ID: <20191025093325.GK32742@smile.fi.intel.com>
References: <20191024213827.144974-1-hdegoede@redhat.com>
 <20191024213827.144974-3-hdegoede@redhat.com>
 <20191025074154.GX32742@smile.fi.intel.com>
 <49aa39b7-d457-1140-afdb-2a154278b29f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49aa39b7-d457-1140-afdb-2a154278b29f@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Oct 25, 2019 at 10:59:06AM +0200, Hans de Goede wrote:
> On 25-10-2019 09:41, Andy Shevchenko wrote:
> > On Thu, Oct 24, 2019 at 11:38:25PM +0200, Hans de Goede wrote:

> > I would go with previously established pattern, i.e. intel_pmic_bytcc.c.

> Well that would be consistent with the chtwc for the Whiskey Cove, but
> Crystal Cove related files are shortened to crc in many places already:
> 
> Filenames before this patch:
> drivers/acpi/pmic/intel_pmic_crc.c
> drivers/pwm/pwm-crc.c
> drivers/mfd/intel_soc_pmic_crc.c
> 
> And to me "cc" stands for the Type-C cc lines, or for Cc: from email,
> so IMHO it is best to stick with crc here.

Okay, let's do an exception here due to the fact the code and name already
exists and spreads enough thru sources.

It means you may use mine tags.

> > I'm wondering shouldn't we rename the PWM and GPIO for the sake of consistency?
> > Yes, if a driver is used on both CHT and BYT, let it provide two names.
> 
> I believe it is fine to keep the blocks which are identical between
> the 2 versions as just "crystal_cove_foo", but renaming them is fine with me
> too, but that follows outside the scope of this series and should be
> done in a follow-up series IMHO.

True.

-- 
With Best Regards,
Andy Shevchenko


