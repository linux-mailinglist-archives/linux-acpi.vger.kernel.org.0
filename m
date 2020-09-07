Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B135F26039A
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Sep 2020 19:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729187AbgIGRv1 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 7 Sep 2020 13:51:27 -0400
Received: from mga17.intel.com ([192.55.52.151]:8872 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729214AbgIGMFg (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 7 Sep 2020 08:05:36 -0400
IronPort-SDR: vYDYrzkPl2EqgtZoYm3GDTySrgOqY2oturlWiBq7Bx/6EpxCp+ExnQW9TiP+TEO0Rlc0WHsCs/
 lgDd3KmnPMzg==
X-IronPort-AV: E=McAfee;i="6000,8403,9736"; a="138043146"
X-IronPort-AV: E=Sophos;i="5.76,401,1592895600"; 
   d="scan'208";a="138043146"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2020 05:05:35 -0700
IronPort-SDR: 2CBlObCO96DDrKtRle/9/mG0KaS4vvXMxVvOVT/BzpwxDNLDMD4HSCzkDvUGfy45+IIZP+ASZ8
 Ct81pGEywADg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,401,1592895600"; 
   d="scan'208";a="406818222"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 07 Sep 2020 05:05:33 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: [PATCH v2 0/2] Move fwnode_connection_find_match() under drivers/base/property.c
Date:   Mon,  7 Sep 2020 15:05:30 +0300
Message-Id: <20200907120532.37611-1-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

This is second version of this series. I forgot to remove the file
from Documentation/driver-api/index.rst. Hopefully these are now OK.

The original cover letter:

Hi,

This was the last patch in my series that removed struct
device_connection [1]. It's now split into two separate patches.

[1] https://lore.kernel.org/lkml/20200904125123.83725-1-heikki.krogerus@linux.intel.com/

thanks,

*** BLURB HERE ***

Heikki Krogerus (2):
  device property: Move fwnode_connection_find_match() under
    drivers/base/property.c
  Documentation: Remove device connection documentation

 .../driver-api/device_connection.rst          |  43 --------
 Documentation/driver-api/index.rst            |   1 -
 drivers/base/Makefile                         |   2 +-
 drivers/base/devcon.c                         | 101 ------------------
 drivers/base/property.c                       |  73 +++++++++++++
 include/linux/device.h                        |   9 --
 include/linux/property.h                      |  14 +++
 7 files changed, 88 insertions(+), 155 deletions(-)
 delete mode 100644 Documentation/driver-api/device_connection.rst
 delete mode 100644 drivers/base/devcon.c

-- 
2.28.0

