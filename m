Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6455A704CBF
	for <lists+linux-acpi@lfdr.de>; Tue, 16 May 2023 13:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233057AbjEPLqz (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 16 May 2023 07:46:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233061AbjEPLqn (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 16 May 2023 07:46:43 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29E5C6A58
        for <linux-acpi@vger.kernel.org>; Tue, 16 May 2023 04:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684237593; x=1715773593;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=XYspxCqO5D4kWJBWip8vWqmnjagezUV8ah+tJqm3twA=;
  b=Kk4l27rmuSK/JJAHIQoSZ2yS1TPAeguCCe4k4jOVvWRn/XS5CsMR2uTZ
   bxsBiEmX8xYol69/uvIB9YU46dpK5DJgdOhVrjbRv1p52lYyh/a8Wmma3
   7BmQ0Nk4cXF3GYI7SsZfMvWER2wDu5CZ7DBfIXvruMEasj2whol3JYQUw
   SpNYG2SOMGzGdrw8o809/cw70s8WVZPO6uC2zCSd6RL2ysNuihnX2Azd1
   J64TIzz80lN2nmnE7ScsBzmq3j0HPHB0/hWuVcNvZ95rECO7DLtWo71XK
   5IYJofjyFsEcGAi3Ffx19JLe526g5HHNxbk6ocKUhEhxikCdWJnfKg4K6
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="417111584"
X-IronPort-AV: E=Sophos;i="5.99,278,1677571200"; 
   d="scan'208";a="417111584"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2023 04:46:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="731961773"
X-IronPort-AV: E=Sophos;i="5.99,278,1677571200"; 
   d="scan'208";a="731961773"
Received: from hextor.igk.intel.com ([10.123.220.6])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2023 04:46:31 -0700
From:   Michal Wilczynski <michal.wilczynski@intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     rafael@kernel.org, Michal Wilczynski <michal.wilczynski@intel.com>
Subject: [PATCH v2 00/34] Remove .notify callback in acpi_device_ops
Date:   Tue, 16 May 2023 13:45:43 +0200
Message-Id: <20230516114617.148963-1-michal.wilczynski@intel.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/platform/x86/fujitsu-laptop.c         | 103 +++++++-------
 drivers/platform/x86/lg-laptop.c              |  12 +-
 drivers/platform/x86/panasonic-laptop.c       |  17 ++-
 drivers/platform/x86/system76_acpi.c          |  28 ++--
 drivers/platform/x86/topstar-laptop.c         |  16 ++-
 drivers/platform/x86/toshiba_acpi.c           | 131 +++++++++---------
 drivers/platform/x86/toshiba_bluetooth.c      |  28 +++-
 drivers/platform/x86/toshiba_haps.c           |   9 +-
 drivers/platform/x86/wireless-hotkey.c        |  23 ++-
 drivers/platform/x86/xo15-ebook.c             |  11 +-
 drivers/virt/vmgenid.c                        |  30 ++--
 include/acpi/acpi_bus.h                       |  10 +-
 32 files changed, 497 insertions(+), 304 deletions(-)

-- 
2.40.1

