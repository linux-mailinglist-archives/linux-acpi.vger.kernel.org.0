Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 852F92C0EE1
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Nov 2020 16:33:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389525AbgKWPbw (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 23 Nov 2020 10:31:52 -0500
Received: from mga07.intel.com ([134.134.136.100]:39961 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389471AbgKWPbw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 23 Nov 2020 10:31:52 -0500
IronPort-SDR: nkQIZP/DQyl+p2kp4ble5bwqVuNbeqKwbXnu5uiVz3Spj/nGnRqWbKI7AVzg58W7StV4D7qtZx
 HchInOuNDvtw==
X-IronPort-AV: E=McAfee;i="6000,8403,9813"; a="235925210"
X-IronPort-AV: E=Sophos;i="5.78,363,1599548400"; 
   d="scan'208";a="235925210"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2020 07:31:51 -0800
IronPort-SDR: y6nWeVl4m4UVqESadhHSTDcORQMh8SptHJkJe6/M/NyTr28IzDZBEaOCfI+3+X21DpILdudASV
 yLtX5u5c1QBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,363,1599548400"; 
   d="scan'208";a="432321594"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 23 Nov 2020 07:31:49 -0800
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Felipe Balbi <balbi@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: [PATCH 0/2] Remove one more platform_device_add_properties() call
Date:   Mon, 23 Nov 2020 18:31:46 +0300
Message-Id: <20201123153148.52647-1-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

I originally introduced these as part of my series where I was
proposing PM ops for software nodes [1], but since that still needs
work, I'm sending these two separately.

So basically I'm only modifying dwc3-pci.c so it registers a software
node directly at this point. That will remove one more user of
platform_device_add_properties().

[1] https://lore.kernel.org/lkml/20201029105941.63410-1-heikki.krogerus@linux.intel.com/

thanks,

Heikki Krogerus (2):
  software node: Introduce device_add_software_node()
  usb: dwc3: pci: Register a software node for the dwc3 platform device

 drivers/base/swnode.c       | 69 ++++++++++++++++++++++++++++++++-----
 drivers/usb/dwc3/dwc3-pci.c | 61 +++++++++++++++++++-------------
 include/linux/property.h    |  3 ++
 3 files changed, 100 insertions(+), 33 deletions(-)

-- 
2.29.2

