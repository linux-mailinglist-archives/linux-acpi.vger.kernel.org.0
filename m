Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D203D29E9CD
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Oct 2020 11:59:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726696AbgJ2K7p (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 29 Oct 2020 06:59:45 -0400
Received: from mga01.intel.com ([192.55.52.88]:56275 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725923AbgJ2K7o (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 29 Oct 2020 06:59:44 -0400
IronPort-SDR: E4xt9Ni6ptl6/Fw52KmLDLE7MSrQ0ZrGuQqTmYrnTwuO7yB3oDA/JP1x28c1ogJhGsdYCsLR3Y
 32ty1PVroXAw==
X-IronPort-AV: E=McAfee;i="6000,8403,9788"; a="186197266"
X-IronPort-AV: E=Sophos;i="5.77,429,1596524400"; 
   d="scan'208";a="186197266"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2020 03:59:44 -0700
IronPort-SDR: NRImXo4hSiLjvt8xW/L3jxcYhKoweIkjxk7WTeZQjhVrvlCGTu25TbFGlDu9SeWxgt6rm5B6vC
 iaTeFFZSb7RA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,429,1596524400"; 
   d="scan'208";a="425017585"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 29 Oct 2020 03:59:42 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: [PATCHv2 0/3] PM operations for software nodes
Date:   Thu, 29 Oct 2020 13:59:38 +0300
Message-Id: <20201029105941.63410-1-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

This is the second version of this series. Rafael pointed out in v1
that I was not handling bus PM ops correctly. He also requested that I
put a comment to the code explaining things a little.

The original v1 series:
https://lore.kernel.org/linux-acpi/20200825135951.53340-1-heikki.krogerus@linux.intel.com/

Heikki Krogerus (3):
  software node: Power management operations for software nodes
  software node: Introduce device_add_software_node()
  usb: dwc3: pci: Register a software node for the dwc3 platform device

 drivers/base/power/common.c |   8 +-
 drivers/base/swnode.c       | 738 +++++++++++++++++++++++++++++++++++-
 drivers/usb/dwc3/dwc3-pci.c | 175 +++++----
 include/linux/property.h    |  13 +
 4 files changed, 835 insertions(+), 99 deletions(-)

-- 
2.28.0

