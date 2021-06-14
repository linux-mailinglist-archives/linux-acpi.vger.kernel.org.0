Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C9033A69A1
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Jun 2021 17:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233080AbhFNPKi (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 14 Jun 2021 11:10:38 -0400
Received: from mga04.intel.com ([192.55.52.120]:44388 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233171AbhFNPKh (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 14 Jun 2021 11:10:37 -0400
IronPort-SDR: 4vC0FRzoENk7tcGWuHzbjaWjZV/kQu5xqcdIf2sLs3lc+ZX6m0Zb1rTBDGbz19jeWQDhLwTXA0
 fQ+AN1vONSMg==
X-IronPort-AV: E=McAfee;i="6200,9189,10015"; a="203994839"
X-IronPort-AV: E=Sophos;i="5.83,273,1616482800"; 
   d="scan'208";a="203994839"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2021 08:08:33 -0700
IronPort-SDR: 6GB43enzBJUiLPUEDuF9iAWxKMmGqREy2uUktLwtgqLshifAMqYLLavj9TpY557CYXpiuPEDxn
 33bTtLCIVfig==
X-IronPort-AV: E=Sophos;i="5.83,273,1616482800"; 
   d="scan'208";a="553392379"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2021 08:08:31 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lsoCP-002GHP-EU; Mon, 14 Jun 2021 18:08:25 +0300
Date:   Mon, 14 Jun 2021 18:08:25 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linux GPIO <linux-gpio@vger.kernel.org>,
        linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Daniel Scally <djrscally@gmail.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Hans de Goede <hdegoede@redhat.com>
Subject: Re: [GIT PULL] intel-gpio for 5.14-1
Message-ID: <YMdw6WdEQdGATBNJ@smile.fi.intel.com>
References: <YL43SrZ8N8H+ZHE9@black.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YL43SrZ8N8H+ZHE9@black.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Jun 07, 2021 at 06:12:10PM +0300, Andy Shevchenko wrote:
> Hi Linux GPIO and TWIMC maintainers,
> 
> This is GPIO material for v5.14 cycle. It contains some stuff that other
> subsystems may take due to dependencies. Consider this tag immutable.

Bart, any comments on this? Can you, please, pull?

-- 
With Best Regards,
Andy Shevchenko


