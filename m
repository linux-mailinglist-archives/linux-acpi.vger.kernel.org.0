Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 508731004B5
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Nov 2019 12:50:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbfKRLuX (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 18 Nov 2019 06:50:23 -0500
Received: from mga18.intel.com ([134.134.136.126]:17761 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726506AbfKRLuX (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 18 Nov 2019 06:50:23 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Nov 2019 03:50:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,320,1569308400"; 
   d="scan'208";a="204047463"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga008.fm.intel.com with ESMTP; 18 Nov 2019 03:50:20 -0800
Received: from andy by smile with local (Exim 4.93-RC1)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1iWfXv-00012e-PD; Mon, 18 Nov 2019 13:50:19 +0200
Date:   Mon, 18 Nov 2019 13:50:19 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jan Kiszka <jan.kiszka@siemens.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-gpio@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Rafael J., Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH v2] gpio: sch: Add interrupt support
Message-ID: <20191118115019.GW32742@smile.fi.intel.com>
References: <046793ee-ba51-6a1b-1aa5-14560d849df7@siemens.com>
 <20190429131900.GD9224@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190429131900.GD9224@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Apr 29, 2019 at 04:19:00PM +0300, Andy Shevchenko wrote:
> On Mon, Apr 29, 2019 at 07:55:52AM +0200, Jan Kiszka wrote:
> > Validated on the Quark platform, this adds interrupt support on rising
> > and/or falling edges.
> 
> Can we split it to two:
> - Add IRQ support on edge
> - Add ACPI handler (with explanation in the commit message why we do like this,
>   based on the thread from v1)
> 
> ?

Jan, anything you would like to do with this or is it abandoned?

-- 
With Best Regards,
Andy Shevchenko


