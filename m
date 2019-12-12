Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9096911D98C
	for <lists+linux-acpi@lfdr.de>; Thu, 12 Dec 2019 23:39:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731042AbfLLWjK (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 12 Dec 2019 17:39:10 -0500
Received: from mga04.intel.com ([192.55.52.120]:35642 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730707AbfLLWjK (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 12 Dec 2019 17:39:10 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Dec 2019 14:39:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,307,1571727600"; 
   d="scan'208";a="220787450"
Received: from gayuk-dev-mach.sc.intel.com ([10.3.79.172])
  by fmsmga001.fm.intel.com with ESMTP; 12 Dec 2019 14:39:09 -0800
From:   Gayatri Kammela <gayatri.kammela@intel.com>
To:     linux-pm@vger.kernel.org
Cc:     platform-driver-x86@vger.kernel.org, alex.hung@canonical.com,
        linux-acpi@vger.kernel.org, lenb@kernel.org, rjw@rjwysocki.net,
        linux-kernel@vger.kernel.org, daniel.lezcano@linaro.org,
        amit.kucheria@verdurent.com, charles.d.prestopine@intel.com,
        dvhart@infradead.org, Gayatri Kammela <gayatri.kammela@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@intel.com>
Subject: [PATCH v1 0/4] drivers: Add Tiger Lake hardware IDs to support acpi,
Date:   Thu, 12 Dec 2019 14:37:16 -0800
Message-Id: <cover.1576189376.git.gayatri.kammela@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

Tiger Lake supports devices whose hardware IDs are changed for various
drivers. Hence, add the new hardware IDs.

Patch 1: Add Tiger Lake support to DPTF driver
Patch 2: Add Tiger Lake support to fan driver
Patch 3: Add Tiger Lake support to Intel's HID driver
Patch 4: Add Tiger Lake support to thermal driver

Gayatri Kammela (4):
  acpi: dptf: Add new Tiger Lake hardware IDs to support DPTF drivers in
    acpi
  acpi: fan: Add new Tiger Lake hardware ID to support fan driver in
    acpi
  platform/x86: intel-hid: Add new Tiger Lake hardware ID to support HID
    driver
  thermal: int340x_thermal: Add new Tiger Lake hardware IDs to support
    thermal driver

 drivers/acpi/dptf/dptf_power.c                          | 1 +
 drivers/acpi/dptf/int340x_thermal.c                     | 4 ++++
 drivers/acpi/fan.c                                      | 1 +
 drivers/platform/x86/intel-hid.c                        | 1 +
 drivers/thermal/intel/int340x_thermal/int3400_thermal.c | 1 +
 drivers/thermal/intel/int340x_thermal/int3403_thermal.c | 1 +
 6 files changed, 9 insertions(+)

Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@intel.com>
-- 
2.17.1

