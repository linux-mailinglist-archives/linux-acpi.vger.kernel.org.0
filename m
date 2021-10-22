Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C857A437F1F
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Oct 2021 22:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232291AbhJVULb (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 22 Oct 2021 16:11:31 -0400
Received: from mga04.intel.com ([192.55.52.120]:28634 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232089AbhJVULa (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 22 Oct 2021 16:11:30 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10145"; a="228144290"
X-IronPort-AV: E=Sophos;i="5.87,173,1631602800"; 
   d="scan'208";a="228144290"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2021 13:08:51 -0700
X-IronPort-AV: E=Sophos;i="5.87,173,1631602800"; 
   d="scan'208";a="663304095"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2021 13:08:48 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1me0q2-000Edf-58;
        Fri, 22 Oct 2021 23:08:26 +0300
Date:   Fri, 22 Oct 2021 23:08:25 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     linux-acpi@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>, Len Brown <lenb@kernel.org>,
        Ashok Raj <ashok.raj@intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        Aubrey Li <aubrey.li@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/4] drivers/acpi: Introduce Platform Firmware Runtime
 Update Telemetry
Message-ID: <YXMaOayzFFWPf+qP@smile.fi.intel.com>
References: <cover.1634899519.git.yu.c.chen@intel.com>
 <066c428ef56f6c268d1180eb7e51643f21416f70.1634899519.git.yu.c.chen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <066c428ef56f6c268d1180eb7e51643f21416f70.1634899519.git.yu.c.chen@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sat, Oct 23, 2021 at 01:10:19AM +0800, Chen Yu wrote:
> Platform Firmware Runtime Update(PFRU) Telemetry Service is part of RoT
> (Root of Trust), which allows PFRU handler and other PFRU drivers to
> produce telemetry data to upper layer OS consumer at runtime.
> 
> The linux provides interfaces for the user to query the parameters of
> telemetry data, and the user could read out the telemetry data
> accordingly.
> 
> The corresponding userspace tool and man page will be introduced at
> tools/power/acpi/pfru.

Some of the comments from previous patch are applicable here. Hence, I'm not
going to give a full review.

-- 
With Best Regards,
Andy Shevchenko


