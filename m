Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39F393F218A
	for <lists+linux-acpi@lfdr.de>; Thu, 19 Aug 2021 22:26:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234942AbhHSU1E (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 19 Aug 2021 16:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235017AbhHSU1D (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 19 Aug 2021 16:27:03 -0400
Received: from hillosipuli.retiisi.eu (hillosipuli.retiisi.eu [IPv6:2a01:4f9:c010:4572::81:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E827AC061757
        for <linux-acpi@vger.kernel.org>; Thu, 19 Aug 2021 13:26:23 -0700 (PDT)
Received: from lanttu.localdomain (unknown [192.168.2.193])
        by hillosipuli.retiisi.eu (Postfix) with ESMTP id 2EBED634C91;
        Thu, 19 Aug 2021 23:19:36 +0300 (EEST)
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-acpi@vger.kernel.org, linux-media@vger.kernel.org
Cc:     andriy.shevchenko@linux.intel.com, rafael@kernel.org
Subject: [RFC 0/3] ACPI, PMICs and probing cameras
Date:   Thu, 19 Aug 2021 23:19:33 +0300
Message-Id: <20210819201936.7390-1-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi all,

The intel_skl_int3472 driver is required for some of the ACPI power state
transitions to function. This driver may be compiled as a module and thus
may probe after a sensor driver that depends on it (e.g. imx258).

Make the sensor driver return -EPROBE_DEFER if the sensor cannot be found.
This way the sensor driver will be probed when both the intel_skl_int3472
and the gpio-tps68470 drivers have successfully probed while also the
gpio-tps68470 driver may be built as a module.

The drawback of the approach is needless probing of the imx258 driver but
everything can be built as modules.

I'm posting this as RFC since the approach would require effectively all
ACPI based sensor drivers to have the same check. This would be a
non-issue to add. I wouldn't mind but...

Is there a way to figure out whether the PMIC opregion callbacks actually
succeed? At least the imx258 driver is happily probed even if the driver
implementing the opregion callback is not there, and thus the device
remains powered off --- and probe fails.

Sakari Ailus (3):
  imx258: Defer probing on ident register read fail (on ACPI)
  gpio-tps68470: Allow building as module
  gpio-tps68470: Add modalias

 drivers/gpio/Kconfig         | 2 +-
 drivers/gpio/gpio-tps68470.c | 5 ++++-
 drivers/media/i2c/imx258.c   | 8 ++++++++
 3 files changed, 13 insertions(+), 2 deletions(-)

-- 
2.30.2

