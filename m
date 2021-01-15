Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 793722F75DC
	for <lists+linux-acpi@lfdr.de>; Fri, 15 Jan 2021 10:52:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729116AbhAOJuz (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 15 Jan 2021 04:50:55 -0500
Received: from mga18.intel.com ([134.134.136.126]:51113 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726829AbhAOJuz (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 15 Jan 2021 04:50:55 -0500
IronPort-SDR: WcKDESq7H4ynFERcAiuFJDutXHrOgSR8bdXsDVoPCUJQpMhFsa8h4ZzzVe6XbSTsE9zaba2fE0
 9DHx4/LDSPng==
X-IronPort-AV: E=McAfee;i="6000,8403,9864"; a="166195715"
X-IronPort-AV: E=Sophos;i="5.79,349,1602572400"; 
   d="scan'208";a="166195715"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2021 01:49:17 -0800
IronPort-SDR: ogNTLClcTE7XycGsagNh8CZ8d+3nIpa8dtTrJhgV+fBOcf75Yt0rJ05O8A2nv8KbMmNHmn3h0S
 J/oi4N1lmU/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,349,1602572400"; 
   d="scan'208";a="465538723"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 15 Jan 2021 01:49:15 -0800
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Greg KH <greg@kroah.com>
Cc:     Felipe Balbi <balbi@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: [PATCH v3 0/4] Remove one more platform_device_add_properties() call
Date:   Fri, 15 Jan 2021 12:49:10 +0300
Message-Id: <20210115094914.88401-1-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

I'm now clearing the dev_fwnode(dev)->secondary pointer in
device_remove_software_node() as requested by Daniel and Andy. Thanks
guys, it's much better now. I also took the liberty of including one
more PCI ID patch where I add PCI ID for the Alder Lake-P variant. I
hope that is OK.

Andy, I dropped your Tested-by tag because of the change I made to the
first patch. If you have time to retest these, I would much appreciate.


v2 cover letter:

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

Heikki Krogerus (4):
  software node: Introduce device_add_software_node()
  usb: dwc3: pci: Register a software node for the dwc3 platform device
  usb: dwc3: pci: ID for Tiger Lake CPU
  usb: dwc3: pci: add support for the Intel Alder Lake-P

 drivers/base/swnode.c       | 71 ++++++++++++++++++++++++++++++++-----
 drivers/usb/dwc3/dwc3-pci.c | 69 ++++++++++++++++++++++-------------
 include/linux/property.h    |  3 ++
 3 files changed, 110 insertions(+), 33 deletions(-)

-- 
2.29.2

