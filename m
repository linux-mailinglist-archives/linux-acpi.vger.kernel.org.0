Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FB0D3FE146
	for <lists+linux-acpi@lfdr.de>; Wed,  1 Sep 2021 19:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344671AbhIARk2 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 1 Sep 2021 13:40:28 -0400
Received: from mga09.intel.com ([134.134.136.24]:22410 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344905AbhIARkY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 1 Sep 2021 13:40:24 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10094"; a="218829206"
X-IronPort-AV: E=Sophos;i="5.84,370,1620716400"; 
   d="scan'208";a="218829206"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2021 10:39:25 -0700
X-IronPort-AV: E=Sophos;i="5.84,370,1620716400"; 
   d="scan'208";a="688467610"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2021 10:39:22 -0700
Received: from andy by smile with local (Exim 4.95-RC2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mLUCl-00GUqP-Q8;
        Wed, 01 Sep 2021 20:39:19 +0300
Date:   Wed, 1 Sep 2021 20:39:19 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jean Delvare <jdelvare@suse.de>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Subject: Re: TPS68470 PMIC config option
Message-ID: <YS+6xzk9yc8uPetU@smile.fi.intel.com>
References: <20210901160234.0e3e24b2@endymion>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210901160234.0e3e24b2@endymion>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

+Cc: Sakari.

On Wed, Sep 01, 2021 at 04:02:34PM +0200, Jean Delvare wrote:
> Hi Andy,
> 
> Is there a reason why config TPS68470_PMIC_OPREGION is not under "if
> PMIC_OPREGION" where all other *_PMIC_OPREGION driver options are?

It was originally like that.

Sakari, do you know?

-- 
With Best Regards,
Andy Shevchenko


