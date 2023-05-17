Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B7F87061E8
	for <lists+linux-acpi@lfdr.de>; Wed, 17 May 2023 09:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbjEQH6f (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 17 May 2023 03:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjEQH6V (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 17 May 2023 03:58:21 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 745F34EDB
        for <linux-acpi@vger.kernel.org>; Wed, 17 May 2023 00:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684310290; x=1715846290;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3wqDl5boGzzyuYSDKObEjo7w69fYiF5i9EhJdxRpjEk=;
  b=D01XKQ90HVRCHzTBPPUXu0Er9I8JGXJbP7aNVQz7h4UwC8HBVRFBSAzQ
   TvG+Vu5oSaRhGHt3uZANQb4cxYvPVaHR8JYL7RpN5CxvD9rn+GZETGIhL
   wdcZHekghkN5ybV5qcYLFgluVrebSg0bXgFYRd6tVljKuDHW0wMM5UHgm
   E7f+9f+O2WcXFxvcSYEfGRoVedBIs+mtTJBa/7PXd4yVQRPnmNDxBLSza
   Age6xqtXrd5SVnhRjhjXh8A41RbXZp82XMcnxibS7cXOYA/ozlDiHtTF3
   QUhMxUhnMUjYKfjXqRTVG+kkVq++8wrlfeWlKfYYscWt58jdGYq6UKV/j
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="415105353"
X-IronPort-AV: E=Sophos;i="5.99,281,1677571200"; 
   d="scan'208";a="415105353"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2023 00:57:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="825877246"
X-IronPort-AV: E=Sophos;i="5.99,281,1677571200"; 
   d="scan'208";a="825877246"
Received: from hextor.igk.intel.com ([10.123.220.6])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2023 00:57:57 -0700
From:   Michal Wilczynski <michal.wilczynski@intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     rafael@kernel.org, srinivas.pandruvada@linux.intel.com,
        Michal Wilczynski <michal.wilczynski@intel.com>
Subject: [PATCH v3 00/34] Remove .notify callback in acpi_device_ops
Date:   Wed, 17 May 2023 09:56:50 +0200
Message-Id: <20230517075724.153992-1-michal.wilczynski@intel.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Currently drivers support ACPI event handlers by defining .notify
callback in acpi_device_ops. This solution is suboptimal as event
handler installer installs intermediary function acpi_notify_device as a
handler in every driver. Also this approach requires extra variable
'flags' for specifying event types that the driver want to subscribe to.
Additionally this is a pre-work required to align acpi_driver with
platform_driver and eventually replace acpi_driver with platform_driver.

Remove .notify callback from the acpi_device_ops. Replace it with each
driver installing and removing it's event handlers.

v3:
 - lkp still reported some failures for eeepc, fujitsu and
   toshiba_bluetooth, fix those
v2:
 - fix compilation errors for drivers

Michal Wilczynski (34):
  acpi: Adjust functions installing bus event handlers
  acpi/ac: Move handler installing logic to driver
  acpi/video: Move handler installing logic to driver
  acpi/battery: Move handler installing logic to driver
  acpi/button: Move handler installing logic to driver
  acpi/hed: Move handler installing logic to driver
  acpi/nfit: Move handler installing logic to driver
  acpi/thermal: Move handler installing logic to driver
  acpi/tiny-power-button: Move handler installing logic to driver
  hwmon: Move handler installing logic to driver
  iio/acpi-als: Move handler installing logic to driver
  platform/chromeos_tbmc: Move handler installing logic to driver
  platform/wilco_ec: Move handler installing logic to driver
  platform/surface/button: Move handler installing logic to driver
  platform/x86/acer-wireless: Move handler installing logic to driver
  platform/x86/asus-laptop: Move handler installing logic to driver
  platform/x86/asus-wireless: Move handler installing logic to driver
  platform/x86/classmate-laptop: Move handler installing logic to driver
  platform/x86/dell/dell-rbtn: Move handler installing logic to driver
  platform/x86/eeepc-laptop: Move handler installing logic to driver
  platform/x86/fujitsu-laptop: Move handler installing logic to driver
  platform/x86/lg-laptop: Move handler installing logic to driver
  platform/x86/panasonic-laptop: Move handler installing logic to driver
  platform/x86/system76_acpi: Move handler installing logic to driver
  platform/x86/topstar-laptop: Move handler installing logic to driver
  platform/x86/toshiba_acpi: Move handler installing logic to driver
  platform/x86/toshiba_bluetooth: Move handler installing logic to
    driver
  platform/x86/toshiba_haps: Move handler installing logic to driver
  platform/x86/wireless-hotkey: Move handler installing logic to driver
  platform/x86/xo15-ebook: Move handler installing logic to driver
  virt/vmgenid: Move handler installing logic to driver
  acpi/bus: Remove installing/removing notify handlers from probe/remove
  acpi/bus: Remove redundant functions
  acpi/bus: Remove notify callback and flags

 drivers/acpi/ac.c                             |  14 +-
 drivers/acpi/acpi_video.c                     |  18 ++-
 drivers/acpi/battery.c                        |  14 +-
 drivers/acpi/bus.c                            |  53 ++-----
 drivers/acpi/button.c                         |  18 ++-
 drivers/acpi/hed.c                            |   6 +-
 drivers/acpi/nfit/core.c                      |  25 ++--
 drivers/acpi/thermal.c                        |  20 ++-
 drivers/acpi/tiny-power-button.c              |  18 +--
 drivers/hwmon/acpi_power_meter.c              |  15 +-
 drivers/iio/light/acpi-als.c                  |  23 ++-
 drivers/platform/chrome/chromeos_tbmc.c       |  14 +-
 drivers/platform/chrome/wilco_ec/event.c      |  19 ++-
 drivers/platform/surface/surfacepro3_button.c |  19 ++-
 drivers/platform/x86/acer-wireless.c          |  22 ++-
 drivers/platform/x86/asus-laptop.c            |  16 ++-
 drivers/platform/x86/asus-wireless.c          |  24 ++--
 drivers/platform/x86/classmate-laptop.c       |  12 +-
 drivers/platform/x86/dell/dell-rbtn.c         |  15 +-
 drivers/platform/x86/eeepc-laptop.c           |  18 ++-
 drivers/platform/x86/fujitsu-laptop.c         |  19 ++-
 drivers/platform/x86/lg-laptop.c              |  12 +-
 drivers/platform/x86/panasonic-laptop.c       |  17 ++-
 drivers/platform/x86/system76_acpi.c          |  28 ++--
 drivers/platform/x86/topstar-laptop.c         |  16 ++-
 drivers/platform/x86/toshiba_acpi.c           | 131 +++++++++---------
 drivers/platform/x86/toshiba_bluetooth.c      |  30 ++--
 drivers/platform/x86/toshiba_haps.c           |   9 +-
 drivers/platform/x86/wireless-hotkey.c        |  23 ++-
 drivers/platform/x86/xo15-ebook.c             |  11 +-
 drivers/virt/vmgenid.c                        |  30 ++--
 include/acpi/acpi_bus.h                       |  10 +-
 32 files changed, 457 insertions(+), 262 deletions(-)

-- 
2.40.1

