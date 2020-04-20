Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92D701B102B
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Apr 2020 17:30:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbgDTPaw (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 20 Apr 2020 11:30:52 -0400
Received: from mga11.intel.com ([192.55.52.93]:11719 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725989AbgDTPaw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 20 Apr 2020 11:30:52 -0400
IronPort-SDR: Y0tAWSlyHjjJTXN+YkgPqloQQ/hUm1+SaMqaiR33aJLogNsHfv2MtaFxh9S5oHVGE18iy5u5PH
 nwdEoq4884NA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2020 08:30:52 -0700
IronPort-SDR: xnX/m/bf2QchUzLAIJB0BnkLLrc/W6WBmNOTtXG0YOxQfxbc0uKBt82oDL6ufh2zTNFlnYKl6S
 GTXDAQE+gy2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,406,1580803200"; 
   d="scan'208";a="290130187"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga002.fm.intel.com with ESMTP; 20 Apr 2020 08:30:50 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jQYNp-00243U-DL; Mon, 20 Apr 2020 18:30:53 +0300
Date:   Mon, 20 Apr 2020 18:30:53 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org,
        Andy Shevchenko <andy@infradead.org>
Subject: [GIT PULL] immutable branch for properties
Message-ID: <20200420153053.GA492228@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi guys,

Please, pull immutable branch between platform-drivers-x86 and your subsystem.

Thanks,

With Best Regards,
Andy Shevchenko

The following changes since commit ae83d0b416db002fe95601e7f97f64b59514d936:

  Linux 5.7-rc2 (2020-04-19 14:35:30 -0700)

are available in the Git repository at:

  git://git.infradead.org/linux-platform-drivers-x86.git ib-pdx86-properties

for you to fetch changes up to c7582ff7ed388b803d083166514a4c8acd4ef57d:

  platform/x86: intel_cht_int33fe: Fix spelling issues (2020-04-20 14:47:45 +0300)

----------------------------------------------------------------
Andy Shevchenko (6):
      device property: export set_secondary_fwnode() to modules
      software node: Allow register and unregister software node groups
      platform/x86: intel_cht_int33fe: Convert software node array to group
      platform/x86: intel_cht_int33fe: Convert to use set_secondary_fwnode()
      platform/x86: intel_cht_int33fe: Switch to use acpi_dev_hid_uid_match()
      platform/x86: intel_cht_int33fe: Fix spelling issues

 drivers/base/core.c                            |   1 +
 drivers/base/swnode.c                          |  48 +++++++++++
 drivers/platform/x86/intel_cht_int33fe_typec.c | 106 +++++++++++++------------
 include/linux/property.h                       |   3 +
 4 files changed, 108 insertions(+), 50 deletions(-)

-- 
With Best Regards,
Andy Shevchenko


