Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C2002B0605
	for <lists+linux-acpi@lfdr.de>; Thu, 12 Nov 2020 14:09:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728151AbgKLNJT (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 12 Nov 2020 08:09:19 -0500
Received: from mga04.intel.com ([192.55.52.120]:63519 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727819AbgKLNJT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 12 Nov 2020 08:09:19 -0500
IronPort-SDR: JYIXktKWoCjJVZtuVqTNOlpfMXWu1dVPTBMEr6JKZfSYRhKpW5zxrnf85MYbz0JfGvpvbYFze3
 1AkeHV4xgkag==
X-IronPort-AV: E=McAfee;i="6000,8403,9802"; a="167720548"
X-IronPort-AV: E=Sophos;i="5.77,472,1596524400"; 
   d="scan'208";a="167720548"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2020 05:09:19 -0800
IronPort-SDR: 2L4myDVtrvLPaYuIGXcU3x4qD2OHicoq7E7lDBCmcqa/4f5k2/ebrdLlfxD+yeOzEIbEPEH0l1
 WbV1MZn5EDUg==
X-IronPort-AV: E=Sophos;i="5.77,472,1596524400"; 
   d="scan'208";a="542253627"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2020 05:09:16 -0800
Received: by lahna (sSMTP sendmail emulation); Thu, 12 Nov 2020 15:09:13 +0200
Date:   Thu, 12 Nov 2020 15:09:13 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Flavio Suligoi <f.suligoi@asem.it>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-gpio@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] Documentation: ACPI: explain how to use
 gpio-line-names
Message-ID: <20201112130913.GC2495@lahna.fi.intel.com>
References: <20201112125234.60657-1-f.suligoi@asem.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201112125234.60657-1-f.suligoi@asem.it>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Nov 12, 2020 at 01:52:34PM +0100, Flavio Suligoi wrote:
> The "gpio-line-names" declaration is not fully
> documented, so can be useful to add some important
> information and one more example.
> 
> This commit also fixes a trivial spelling mistake.
> 
> Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
