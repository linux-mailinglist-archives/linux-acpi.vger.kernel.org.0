Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81831246496
	for <lists+linux-acpi@lfdr.de>; Mon, 17 Aug 2020 12:35:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726458AbgHQKfD (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 17 Aug 2020 06:35:03 -0400
Received: from mga07.intel.com ([134.134.136.100]:53308 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726151AbgHQKfC (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 17 Aug 2020 06:35:02 -0400
IronPort-SDR: qZixnyjZeG0hixiY1pzR0E71U/nWdv3hPE+rnhcM6fgg3OqmiUlOAoQ3feEBWiYeSZul1VLEKX
 +6Oi2600G6jw==
X-IronPort-AV: E=McAfee;i="6000,8403,9715"; a="218998889"
X-IronPort-AV: E=Sophos;i="5.76,322,1592895600"; 
   d="scan'208";a="218998889"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2020 03:35:01 -0700
IronPort-SDR: WhfZU8M9eMLr+F3CkctRSAX6svfNLnCaYjdMvj3qjC91uq1os+rULAACxJaXHrtKpy3gLzVz6p
 LLkSUT5JJ4mA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,322,1592895600"; 
   d="scan'208";a="400152985"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 17 Aug 2020 03:34:58 -0700
Received: by lahna (sSMTP sendmail emulation); Mon, 17 Aug 2020 13:34:58 +0300
Date:   Mon, 17 Aug 2020 13:34:58 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v2 1/2] ACPI / PMIC: Split out Kconfig and Makefile
 specific for ACPI PMIC
Message-ID: <20200817103458.GC1375436@lahna.fi.intel.com>
References: <20200814132726.11456-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200814132726.11456-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Aug 14, 2020 at 04:27:25PM +0300, Andy Shevchenko wrote:
> It's a bit better to maintain and allows to avoid mistakes in the future
> with PMIC OpRegion drivers, if we split out Kconfig and Makefile
> for ACPI PMIC to its own folder.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
