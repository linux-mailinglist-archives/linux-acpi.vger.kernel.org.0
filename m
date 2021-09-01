Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D3133FE313
	for <lists+linux-acpi@lfdr.de>; Wed,  1 Sep 2021 21:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244637AbhIATdx (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 1 Sep 2021 15:33:53 -0400
Received: from mga14.intel.com ([192.55.52.115]:23516 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244465AbhIATdw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 1 Sep 2021 15:33:52 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10094"; a="218562979"
X-IronPort-AV: E=Sophos;i="5.84,370,1620716400"; 
   d="scan'208";a="218562979"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2021 12:32:55 -0700
X-IronPort-AV: E=Sophos;i="5.84,370,1620716400"; 
   d="scan'208";a="645910084"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2021 12:32:53 -0700
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id C60882028E;
        Wed,  1 Sep 2021 22:32:51 +0300 (EEST)
Date:   Wed, 1 Sep 2021 22:32:51 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jean Delvare <jdelvare@suse.de>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Subject: Re: TPS68470 PMIC config option
Message-ID: <20210901193251.GZ3@paasikivi.fi.intel.com>
References: <20210901160234.0e3e24b2@endymion>
 <YS+6xzk9yc8uPetU@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YS+6xzk9yc8uPetU@smile.fi.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Andy, Jean,

On Wed, Sep 01, 2021 at 08:39:19PM +0300, Andy Shevchenko wrote:
> +Cc: Sakari.
> 
> On Wed, Sep 01, 2021 at 04:02:34PM +0200, Jean Delvare wrote:
> > Hi Andy,
> > 
> > Is there a reason why config TPS68470_PMIC_OPREGION is not under "if
> > PMIC_OPREGION" where all other *_PMIC_OPREGION driver options are?
> 
> It was originally like that.
> 
> Sakari, do you know?

The answer can be found in Makefile:

obj-$(CONFIG_PMIC_OPREGION)             += intel_pmic.o

intel_pmic.c seems to contain common functionality for PMICs in Intel SoCs
whereas the TPS68470 is an external chip. The two codebases are distinct.

Perhaps it could make sense to either rename this as
CONFIG_PMIC_INTEL_OPREGION, or move the TPS68470 driver in and change the
Kconfig+Makefile to have the common code compiled if at least one of the
drivers is enabled.

-- 
Regards,

Sakari Ailus
