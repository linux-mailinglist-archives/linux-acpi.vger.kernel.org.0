Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E84C92F17C9
	for <lists+linux-acpi@lfdr.de>; Mon, 11 Jan 2021 15:15:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729120AbhAKOOa (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 11 Jan 2021 09:14:30 -0500
Received: from mga17.intel.com ([192.55.52.151]:16819 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727729AbhAKOOa (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 11 Jan 2021 09:14:30 -0500
IronPort-SDR: 2Bc25o2MjjvkXojzrho1B5AdZtdCNISIqhr42ONm9VZ4kR4cy5Rf57FRV3qQjRaIW8cFUgiAuH
 VTLXL5yfJWLw==
X-IronPort-AV: E=McAfee;i="6000,8403,9860"; a="157645639"
X-IronPort-AV: E=Sophos;i="5.79,338,1602572400"; 
   d="scan'208";a="157645639"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2021 06:10:49 -0800
IronPort-SDR: MF2WUMTefHbLY7GYlVcbJw2hXRiTZ24sWwHdmNcdiXSLthgwEUxdoWYIvc/xWxbOQzDkxqoOBb
 IXiLkr5yYiwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,338,1602572400"; 
   d="scan'208";a="464171555"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 11 Jan 2021 06:10:46 -0800
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Felipe Balbi <balbi@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: [PATCH v2 0/3] Remove one more platform_device_add_properties() call
Date:   Mon, 11 Jan 2021 17:10:42 +0300
Message-Id: <20210111141045.14027-1-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Felipe, Rafael,

This is the second version of this series. There are no real changes,
but I added the Tiger Lake ID patch to this series in hope that it
will make your life a bit easier, assuming that Rafael will still pick
these.


The original over letter:

I originally introduced these as part of my series where I was
proposing PM ops for software nodes [1], but since that still needs
work, I'm sending these two separately.

So basically I'm only modifying dwc3-pci.c so it registers a software
node directly at this point. That will remove one more user of
platform_device_add_properties().

[1] https://lore.kernel.org/lkml/20201029105941.63410-1-heikki.krogerus@linux.intel.com/

thanks,

Heikki Krogerus (3):
  software node: Introduce device_add_software_node()
  usb: dwc3: pci: Register a software node for the dwc3 platform device
  usb: dwc3: pci: ID for Tiger Lake CPU

 drivers/base/swnode.c       | 69 ++++++++++++++++++++++++++++++++-----
 drivers/usb/dwc3/dwc3-pci.c | 65 +++++++++++++++++++++-------------
 include/linux/property.h    |  3 ++
 3 files changed, 104 insertions(+), 33 deletions(-)

-- 
2.29.2

