Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B4052BB49E
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Nov 2020 20:00:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732167AbgKTSzP (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 20 Nov 2020 13:55:15 -0500
Received: from mga12.intel.com ([192.55.52.136]:60653 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732139AbgKTSzO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 20 Nov 2020 13:55:14 -0500
IronPort-SDR: vGt8cgmLjUqOy0p5FYfXowlxAybwHIXrPXypSIw2h3+Hfr4uscJbJ2mC+rNpD4BLxks5RPw3WU
 eSTXLsBhWCig==
X-IronPort-AV: E=McAfee;i="6000,8403,9811"; a="150788420"
X-IronPort-AV: E=Sophos;i="5.78,357,1599548400"; 
   d="scan'208";a="150788420"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2020 10:55:14 -0800
IronPort-SDR: AWmO/6KsI/Qp62TUx1W3PMnoqTT2mxLQjlGsttyki7oiQoZNyZopGqWcwpPtVsuwKdGFzhvQ6E
 oMhH1SLTHwXQ==
X-IronPort-AV: E=Sophos;i="5.78,357,1599548400"; 
   d="scan'208";a="331416503"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2020 10:55:11 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kgBZt-008LwO-8M; Fri, 20 Nov 2020 20:56:13 +0200
Date:   Fri, 20 Nov 2020 20:56:13 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Alban Bedel <albeu@free.fr>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 007/141] gpio: Fix fall-through warnings for Clang
Message-ID: <20201120185613.GT4077@smile.fi.intel.com>
References: <cover.1605896059.git.gustavoars@kernel.org>
 <9611e213448b27f3f08a010c683d566c712bdbbb.1605896059.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9611e213448b27f3f08a010c683d566c712bdbbb.1605896059.git.gustavoars@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Nov 20, 2020 at 12:25:16PM -0600, Gustavo A. R. Silva wrote:
> In preparation to enable -Wimplicit-fallthrough for Clang, fix multiple
> warnings by explicitly adding a break and a fallthrough statements
> instead of just letting the code fall through to the next case.

Shouldn't this go via GPIO tree?

-- 
With Best Regards,
Andy Shevchenko


