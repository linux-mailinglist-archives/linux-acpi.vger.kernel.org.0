Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 926B4441A9D
	for <lists+linux-acpi@lfdr.de>; Mon,  1 Nov 2021 12:23:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231271AbhKAL0Q (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 1 Nov 2021 07:26:16 -0400
Received: from mga18.intel.com ([134.134.136.126]:33939 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230520AbhKAL0P (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 1 Nov 2021 07:26:15 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10154"; a="217907045"
X-IronPort-AV: E=Sophos;i="5.87,199,1631602800"; 
   d="scan'208";a="217907045"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2021 04:23:42 -0700
X-IronPort-AV: E=Sophos;i="5.87,199,1631602800"; 
   d="scan'208";a="467274191"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2021 04:23:39 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1mhVPP-002eAm-4K;
        Mon, 01 Nov 2021 13:23:23 +0200
Date:   Mon, 1 Nov 2021 13:23:22 +0200
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     linux-acpi@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>, Len Brown <lenb@kernel.org>,
        Ashok Raj <ashok.raj@intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        Aubrey Li <aubrey.li@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 3/4] drivers/acpi: Introduce Platform Firmware Runtime
 Update Telemetry
Message-ID: <YX/OKs8j1weqwomr@smile.fi.intel.com>
References: <cover.1635317102.git.yu.c.chen@intel.com>
 <b37584e515c36882990295097386e783da29110e.1635317102.git.yu.c.chen@intel.com>
 <YXktrG1LhK5tj2uF@smile.fi.intel.com>
 <20211101101641.GA20219@chenyu5-mobl1>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211101101641.GA20219@chenyu5-mobl1>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Nov 01, 2021 at 06:16:41PM +0800, Chen Yu wrote:
> On Wed, Oct 27, 2021 at 01:45:00PM +0300, Andy Shevchenko wrote:
> > On Wed, Oct 27, 2021 at 03:08:05PM +0800, Chen Yu wrote:

...

> > Looking into the code I have feelings of déjà-vu. Has it really had
> > nothing in common with the previous patch?
> > 
> They both invokes _DSM to trigger the low level actions. However the input
> parameters and return ACPI package as well as the functions are different
> and hard to extract the common code between them.

So, please amend commit message(s) to elaborate this.

-- 
With Best Regards,
Andy Shevchenko


