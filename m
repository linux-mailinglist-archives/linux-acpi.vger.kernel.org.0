Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07CB825D8F5
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Sep 2020 14:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730246AbgIDMv3 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 4 Sep 2020 08:51:29 -0400
Received: from mga07.intel.com ([134.134.136.100]:65317 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729297AbgIDMv2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 4 Sep 2020 08:51:28 -0400
IronPort-SDR: QSHB3JDt0UtfbK0/tnsTNmCtanMOz9eMGDk5okYo4jz3Gg70xOpzyECL8jC2X/CsYJNnXJmmMT
 /HWoKdsj3Txg==
X-IronPort-AV: E=McAfee;i="6000,8403,9733"; a="221944951"
X-IronPort-AV: E=Sophos;i="5.76,389,1592895600"; 
   d="scan'208";a="221944951"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2020 05:51:26 -0700
IronPort-SDR: Yr4hdxoLJarZya6pM2FZgUFY6i98z1Pw/Uz5B8Q9GTHUaH0lS7dAOW/ahDUUbbiEarITfc1E5b
 xEELITAwyJpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,389,1592895600"; 
   d="scan'208";a="405834932"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 04 Sep 2020 05:51:24 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: [PATCH 0/4] Remove struct device_connection
Date:   Fri,  4 Sep 2020 15:51:19 +0300
Message-Id: <20200904125123.83725-1-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

The purpose of the struct device_connection was to allow
connections between devices to be described somehow when the
firmware did not do that. Later support for also firmware
described connections, for example walking device graph, was
added to the API. But now software nodes make it possible to
describe for example device graph if needed, so we don't
need a separate method of describing the connections.

All the users of struct device_connection have now been
concerted to use software nodes instead, so we can remove
the data structure, and the list for it.

thanks,

Heikki Krogerus (4):
  device connection: Remove device_connection_find()
  device connection: Remove device_connection_add()
  device connection: Remove struct device_connection
  device property: Move fwnode_connection_find_match() under
    drivers/base/property.c

 .../driver-api/device_connection.rst          |  43 ----
 drivers/base/Makefile                         |   2 +-
 drivers/base/devcon.c                         | 231 ------------------
 drivers/base/property.c                       |  73 ++++++
 drivers/usb/roles/class.c                     |  12 +-
 drivers/usb/typec/mux.c                       |  19 +-
 include/linux/device.h                        |  56 -----
 include/linux/property.h                      |  14 ++
 8 files changed, 102 insertions(+), 348 deletions(-)
 delete mode 100644 Documentation/driver-api/device_connection.rst
 delete mode 100644 drivers/base/devcon.c

-- 
2.28.0

