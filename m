Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE5C2AC490
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Nov 2020 20:04:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729243AbgKITEx (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 9 Nov 2020 14:04:53 -0500
Received: from mga02.intel.com ([134.134.136.20]:52335 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727303AbgKITEx (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 9 Nov 2020 14:04:53 -0500
IronPort-SDR: /pSjdoLMzsG2w7VKPNtrYKPqtdwG7cppLCTR+ECWZi1/k6Tu4uIb5SPkm10K2VeHZFz5fD8vnc
 V7SYvYg3RXDw==
X-IronPort-AV: E=McAfee;i="6000,8403,9800"; a="156861081"
X-IronPort-AV: E=Sophos;i="5.77,464,1596524400"; 
   d="scan'208";a="156861081"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2020 11:04:52 -0800
IronPort-SDR: Rk3STFSe5DucMHYxhmzIrz1cumrQZFQfyn5ZuechVLDS+8+TRdyw2H7E1bteEI0eB5kiSlRMGN
 f/qVD75N6lXA==
X-IronPort-AV: E=Sophos;i="5.77,464,1596524400"; 
   d="scan'208";a="327372369"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2020 11:04:49 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kcCUB-005GqF-82; Mon, 09 Nov 2020 21:05:51 +0200
Date:   Mon, 9 Nov 2020 21:05:51 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Lukasz Stelmach <l.stelmach@samsung.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH v8 3/6] software node: implement reference properties
Message-ID: <20201109190551.GM4077@smile.fi.intel.com>
References: <20201109172435.GJ4077@smile.fi.intel.com>
 <CGME20201109181851eucas1p241de8938e399c0b603c764593b057c41@eucas1p2.samsung.com>
 <dleftj4klypf5u.fsf%l.stelmach@samsung.com>
 <20201109185305.GT1003057@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201109185305.GT1003057@dtor-ws>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Nov 09, 2020 at 10:53:05AM -0800, Dmitry Torokhov wrote:
> On Mon, Nov 09, 2020 at 07:18:37PM +0100, Lukasz Stelmach wrote:
> > It was <2020-11-09 pon 19:24>, when Andy Shevchenko wrote:

...

> > Probably I have missed something and I will be greatful, if you tell me
> > where I can find more information about software nodes. There are few
> > users in the kernel and it isn't obvious for me how to use software
> > nodes properly.
> 
> Yeah, I disagree with Andy here. The lookup tables are a crutch that we
> have until GPIO and PWM a taught to support software nodes (I need to
> resurrect my patch series for GPIO, if you have time to test that would
> be awesome).

We don't have support for list of fwnodes, this will probably break things
where swnode is already exist.

I think Heikki may send a documentation patch to clarify when swnodes can and
can't be used. Maybe I'm mistaken and above is a good use case by design.

-- 
With Best Regards,
Andy Shevchenko


