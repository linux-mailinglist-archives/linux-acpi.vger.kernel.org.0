Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CADEE30E34A
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Feb 2021 20:31:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbhBCTap (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 3 Feb 2021 14:30:45 -0500
Received: from mga18.intel.com ([134.134.136.126]:30692 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229786AbhBCTan (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 3 Feb 2021 14:30:43 -0500
IronPort-SDR: CNw7G5hJFnGzUVH4rmO9d5UzyOkX4Sm1bUN3PJazDMd3jbox54D2VtQyJBxfPJokHSZPD9iCYI
 hGIDomCS8+pw==
X-IronPort-AV: E=McAfee;i="6000,8403,9884"; a="168784355"
X-IronPort-AV: E=Sophos;i="5.79,399,1602572400"; 
   d="scan'208";a="168784355"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2021 11:28:36 -0800
IronPort-SDR: od/aZTTHZ9FaVq7O9SUj0+tIh5pwUZAfqJ4P2WeFNLVVAIGpYDYzY/G5ZtVmePZmyHE7+R7n+5
 KVe0NDq9umHQ==
X-IronPort-AV: E=Sophos;i="5.79,399,1602572400"; 
   d="scan'208";a="480462331"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2021 11:28:32 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1l7NpF-001iAN-Az; Wed, 03 Feb 2021 21:28:29 +0200
Date:   Wed, 3 Feb 2021 21:28:29 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v1 00/10] mfd, x86: remove msic driver and leftovers
Message-ID: <YBr5Xdwy5lhfJpsD@smile.fi.intel.com>
References: <20210125193948.56760-1-andriy.shevchenko@linux.intel.com>
 <20210126082101.GD4903@dell>
 <YA/xfxcwCabETug6@smile.fi.intel.com>
 <YBhLuNZ7xmHdhurU@smile.fi.intel.com>
 <CAJZ5v0jQLZ7hEn7nDN8AADy7djnrQRrC4jtXKY-YqZiO609_2A@mail.gmail.com>
 <20210202081519.GY4774@dell>
 <CAJZ5v0hJ94YM_bjOQ=bB7esLaxJjErSfGeYk+y3HOybBEEDOWw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hJ94YM_bjOQ=bB7esLaxJjErSfGeYk+y3HOybBEEDOWw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Feb 03, 2021 at 08:05:55PM +0100, Rafael J. Wysocki wrote:
> On Tue, Feb 2, 2021 at 9:15 AM Lee Jones <lee.jones@linaro.org> wrote:

...

> This series has been applied as 5.12 material and will show up in
> linux-next on Friday if all goes well.
> 
> I can export an immutable branch with these commits if need be, in
> which case please let me know.

I guess it makes sense just in case of a formal pinning, but if SFI will go
through your tree, the only potential consumer will be that tree.

> Andy, please proceed with the SFI support removal submission.

Will do, thanks all!

-- 
With Best Regards,
Andy Shevchenko


