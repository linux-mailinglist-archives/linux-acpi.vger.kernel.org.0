Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52D097009C3
	for <lists+linux-acpi@lfdr.de>; Fri, 12 May 2023 16:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241363AbjELOCz (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 12 May 2023 10:02:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241353AbjELOCy (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 12 May 2023 10:02:54 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75397E55
        for <linux-acpi@vger.kernel.org>; Fri, 12 May 2023 07:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683900173; x=1715436173;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=VJgY+ZX+QQwO6hn5T2yShs67QLwuf6Q1BaaQTrnnUBo=;
  b=Mv2hQ2HcSXKZ+nCc9H5RLLZXK+Qfq2n/IrXtUsueXwOmRC7NlaSu+jKP
   0DNPvUgUgBdD/fV9SQhtPJOFHWsOhzVtFl3tiVehXKqeLU3/i4n2ijqju
   VHmXhhsJcB4DRb3ayTO64amDHzU/A+JcwYsbN0M8sOQiCfxm61WNCAwv2
   KM6i2m+qGnMpT+CWoobMbqapOd93gawLR3Adme/PjulCs1ulrNGdgKPHY
   cFSGtc4yrK83fTwHWoR23bLMVWUGxkKt3gBe70oJF5xO1ICJA2NJQG4NN
   KwfK5Xt42W/njXIthTGtvuiZecYJPcb8YBvp/vms5Vj+rNUjfvND4I5o4
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10708"; a="378930954"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="378930954"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2023 07:02:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10708"; a="650648887"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="650648887"
Received: from hextor.igk.intel.com ([10.123.220.6])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2023 07:02:38 -0700
From:   Michal Wilczynski <michal.wilczynski@intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     rafael@kernel.org, Michal Wilczynski <michal.wilczynski@intel.com>
Subject: [PATCH v1 00/34] Remove .notify callback in acpi_device_ops
Date:   Fri, 12 May 2023 16:01:48 +0200
Message-Id: <20230512140222.124868-1-michal.wilczynski@intel.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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

 drivers/acpi/ac.c                             | 14 +++--
 drivers/acpi/acpi_video.c                     | 18 +++++--
 drivers/acpi/battery.c                        | 14 +++--
 drivers/acpi/bus.c                            | 53 ++++++-------------
 drivers/acpi/button.c                         | 18 +++++--
 drivers/acpi/hed.c                            |  6 +--
 drivers/acpi/nfit/core.c                      | 11 ++--
 drivers/acpi/thermal.c                        | 20 ++++---
 drivers/acpi/tiny-power-button.c              | 16 +++---
 drivers/hwmon/acpi_power_meter.c              | 15 +++---
 drivers/iio/light/acpi-als.c                  | 21 ++++++--
 drivers/platform/chrome/chromeos_tbmc.c       | 14 +++--
 drivers/platform/chrome/wilco_ec/event.c      | 21 ++++----
 drivers/platform/surface/surfacepro3_button.c | 19 +++++--
 drivers/platform/x86/acer-wireless.c          | 22 ++++++--
 drivers/platform/x86/asus-laptop.c            | 16 ++++--
 drivers/platform/x86/asus-wireless.c          | 24 +++++----
 drivers/platform/x86/classmate-laptop.c       | 12 +++--
 drivers/platform/x86/dell/dell-rbtn.c         | 15 ++++--
 drivers/platform/x86/eeepc-laptop.c           | 18 +++++--
 drivers/platform/x86/fujitsu-laptop.c         | 17 ++++--
 drivers/platform/x86/lg-laptop.c              | 12 +++--
 drivers/platform/x86/panasonic-laptop.c       | 17 ++++--
 drivers/platform/x86/system76_acpi.c          | 28 ++++++----
 drivers/platform/x86/topstar-laptop.c         | 16 ++++--
 drivers/platform/x86/toshiba_acpi.c           | 17 ++++--
 drivers/platform/x86/toshiba_bluetooth.c      | 27 +++++++---
 drivers/platform/x86/toshiba_haps.c           |  9 ++--
 drivers/platform/x86/wireless-hotkey.c        | 23 +++++---
 drivers/platform/x86/xo15-ebook.c             | 11 ++--
 drivers/virt/vmgenid.c                        | 16 ++++--
 include/acpi/acpi_bus.h                       | 10 ++--
 32 files changed, 380 insertions(+), 190 deletions(-)

-- 
2.38.1

