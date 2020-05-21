Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BE191DCA5A
	for <lists+linux-acpi@lfdr.de>; Thu, 21 May 2020 11:43:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728875AbgEUJnb (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 21 May 2020 05:43:31 -0400
Received: from mga01.intel.com ([192.55.52.88]:43923 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728804AbgEUJn3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 21 May 2020 05:43:29 -0400
IronPort-SDR: nRiMJxSnwDZqOXdBpHaOYiaprGxXGvRv9p41uIl6pgxrAMLhC+soIpJ7r/dYYYmUTvTWqt+HWi
 KecdfNO+8AZg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2020 02:43:29 -0700
IronPort-SDR: 7KHtRKni+re75Ld6GQPilabEWKTjtgIzS0uDO7trer9Khd0nFbOosDCXT77jMzeWICzMlbWJ1+
 QsjSM4veqFgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,417,1583222400"; 
   d="scan'208";a="300735970"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008.jf.intel.com with ESMTP; 21 May 2020 02:43:27 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jbhje-0080d2-P0; Thu, 21 May 2020 12:43:30 +0300
Date:   Thu, 21 May 2020 12:43:30 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v1 3/3] irqdomain: Allow software node to be correct one
 for IRQ domain
Message-ID: <20200521094330.GH1634618@smile.fi.intel.com>
References: <20200520164927.39090-1-andriy.shevchenko@linux.intel.com>
 <20200520164927.39090-3-andriy.shevchenko@linux.intel.com>
 <c7432ac8e2564c1c2177ef6e71f252ac@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c7432ac8e2564c1c2177ef6e71f252ac@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, May 21, 2020 at 09:59:57AM +0100, Marc Zyngier wrote:
> On 2020-05-20 17:49, Andy Shevchenko wrote:

> Thanks for this. I've applied it to irqchip-next.

Thank you, Marc!

> In the future,
> please consider adding a cover letter describing the overall
> goal of the series.

I will keep in mind and follow.

-- 
With Best Regards,
Andy Shevchenko


