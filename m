Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4788F251A75
	for <lists+linux-acpi@lfdr.de>; Tue, 25 Aug 2020 16:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbgHYODc (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 25 Aug 2020 10:03:32 -0400
Received: from mga06.intel.com ([134.134.136.31]:59244 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726222AbgHYN74 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 25 Aug 2020 09:59:56 -0400
IronPort-SDR: BDxlDaRmHKGz4tx5aLvCkE3ForFS1ygc1frhDvW/bWCeac1jFrMrqnztBjDDuGDEa+LSscXpJW
 wtRpSO4m4pDA==
X-IronPort-AV: E=McAfee;i="6000,8403,9723"; a="217659379"
X-IronPort-AV: E=Sophos;i="5.76,352,1592895600"; 
   d="scan'208";a="217659379"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2020 06:59:54 -0700
IronPort-SDR: hIX9GWXNsuutTILIgAn9Fwym76hrvk2/jJ0pmD/1uXZwPpFRLlF7KBUEHRORwv3S3XMjh5sVak
 wUSSnTSChd/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,352,1592895600"; 
   d="scan'208";a="402725549"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 25 Aug 2020 06:59:52 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Felipe Balbi <balbi@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: [PATCH 0/3] PM operations for software nodes
Date:   Tue, 25 Aug 2020 16:59:48 +0300
Message-Id: <20200825135951.53340-1-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi guys,

Unfortunately the last patch depends on this:
https://lore.kernel.org/linux-usb/20200821131101.81915-1-heikki.krogerus@linux.intel.com/

Would it be easiest that Felipe took care of these (assuming they are
acceptable)?

thanks,

Heikki Krogerus (3):
  software node: Power management operations for software nodes
  software node: Introduce device_add_software_node()
  usb: dwc3: pci: Register a software node for the dwc3 platform device

 drivers/base/power/common.c |   8 +-
 drivers/base/swnode.c       | 569 +++++++++++++++++++++++++++++++++++-
 drivers/usb/dwc3/dwc3-pci.c | 175 ++++++-----
 include/linux/property.h    |  13 +
 4 files changed, 666 insertions(+), 99 deletions(-)

-- 
2.28.0

