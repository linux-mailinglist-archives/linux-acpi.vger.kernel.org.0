Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56BBDE389
	for <lists+linux-acpi@lfdr.de>; Mon, 29 Apr 2019 15:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbfD2NTF (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 29 Apr 2019 09:19:05 -0400
Received: from mga17.intel.com ([192.55.52.151]:40169 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725838AbfD2NTF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 29 Apr 2019 09:19:05 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Apr 2019 06:19:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,409,1549958400"; 
   d="scan'208";a="139772786"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga006.jf.intel.com with ESMTP; 29 Apr 2019 06:19:02 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1hL6BR-0008ET-05; Mon, 29 Apr 2019 16:19:01 +0300
Date:   Mon, 29 Apr 2019 16:19:00 +0300
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
Message-ID: <20190429131900.GD9224@smile.fi.intel.com>
References: <046793ee-ba51-6a1b-1aa5-14560d849df7@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <046793ee-ba51-6a1b-1aa5-14560d849df7@siemens.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Apr 29, 2019 at 07:55:52AM +0200, Jan Kiszka wrote:
> Validated on the Quark platform, this adds interrupt support on rising
> and/or falling edges.

Can we split it to two:
- Add IRQ support on edge
- Add ACPI handler (with explanation in the commit message why we do like this,
  based on the thread from v1)

?


-- 
With Best Regards,
Andy Shevchenko


