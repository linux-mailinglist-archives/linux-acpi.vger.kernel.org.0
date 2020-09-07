Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A77425F88E
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Sep 2020 12:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728622AbgIGKiA (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 7 Sep 2020 06:38:00 -0400
Received: from mga06.intel.com ([134.134.136.31]:32889 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728186AbgIGKhx (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 7 Sep 2020 06:37:53 -0400
IronPort-SDR: 09bksG7Z3RBtgOqWPvEtqphTPo12Vmu1Q+c82sdfwtRBpGcOa7hKIrDU8z6/ATvGdXnAikK3XK
 fwGOa9NbIm3w==
X-IronPort-AV: E=McAfee;i="6000,8403,9736"; a="219541980"
X-IronPort-AV: E=Sophos;i="5.76,401,1592895600"; 
   d="scan'208";a="219541980"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2020 03:37:53 -0700
IronPort-SDR: gqEFw/IScZNOpQn3uPfiRWGFDH4jnCo5lf5rM9nWOg8QZWMtlasGCVKpXxXaRkNi7D5srr8Mse
 zmuL4cvaa2aw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,401,1592895600"; 
   d="scan'208";a="406801316"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 07 Sep 2020 03:37:51 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: [PATCH 0/2] Move fwnode_connection_find_match() under drivers/base/property.c
Date:   Mon,  7 Sep 2020 13:37:48 +0300
Message-Id: <20200907103750.9093-1-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

This was the last patch in my series that removed struct
device_connection [1]. It's now split into two separate patches.

[1] https://lore.kernel.org/lkml/20200904125123.83725-1-heikki.krogerus@linux.intel.com/

thanks,

Heikki Krogerus (2):
  device property: Move fwnode_connection_find_match() under
    drivers/base/property.c
  Documentation: Remove device connection documentation

 .../driver-api/device_connection.rst          |  43 --------
 drivers/base/Makefile                         |   2 +-
 drivers/base/devcon.c                         | 101 ------------------
 drivers/base/property.c                       |  73 +++++++++++++
 include/linux/device.h                        |   9 --
 include/linux/property.h                      |  14 +++
 6 files changed, 88 insertions(+), 154 deletions(-)
 delete mode 100644 Documentation/driver-api/device_connection.rst
 delete mode 100644 drivers/base/devcon.c

-- 
2.28.0

