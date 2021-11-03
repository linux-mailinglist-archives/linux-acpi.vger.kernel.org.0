Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00B8F444741
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Nov 2021 18:35:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231130AbhKCRhq (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 3 Nov 2021 13:37:46 -0400
Received: from mga01.intel.com ([192.55.52.88]:37033 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231166AbhKCRhp (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 3 Nov 2021 13:37:45 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10157"; a="255187858"
X-IronPort-AV: E=Sophos;i="5.87,206,1631602800"; 
   d="scan'208";a="255187858"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2021 10:35:07 -0700
X-IronPort-AV: E=Sophos;i="5.87,206,1631602800"; 
   d="scan'208";a="501182924"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2021 10:35:04 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1miK9x-003KL5-G1;
        Wed, 03 Nov 2021 19:34:49 +0200
Date:   Wed, 3 Nov 2021 19:34:49 +0200
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     linux-acpi@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>, Len Brown <lenb@kernel.org>,
        Ashok Raj <ashok.raj@intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        Aubrey Li <aubrey.li@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 4/4] tools: Introduce power/acpi/pfru/pfru
Message-ID: <YYLIOX2ZQ4dZHRUb@smile.fi.intel.com>
References: <cover.1635953446.git.yu.c.chen@intel.com>
 <98d1be8efa8c717f7e303e7b4d21d8c269ce4317.1635953446.git.yu.c.chen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <98d1be8efa8c717f7e303e7b4d21d8c269ce4317.1635953446.git.yu.c.chen@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Nov 03, 2021 at 11:44:14PM +0800, Chen Yu wrote:
> Introduce a user space tool to make use of the interface exposed by
> Platform Firmware Runtime Update and Telemetry drivers. The users
> can use this tool to do firmware code injection, driver update and
> to retrieve the telemetry data.

>  tools/power/acpi/pfru/Makefile |  25 ++
>  tools/power/acpi/pfru/pfru.8   | 137 +++++++++++
>  tools/power/acpi/pfru/pfru.c   | 417 +++++++++++++++++++++++++++++++++

Use Build infrastructure (see, for example, tools/gpio/).

-- 
With Best Regards,
Andy Shevchenko


