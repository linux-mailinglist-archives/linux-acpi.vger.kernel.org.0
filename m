Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 732C511E9FE
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Dec 2019 19:17:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728659AbfLMSQR (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 13 Dec 2019 13:16:17 -0500
Received: from mga17.intel.com ([192.55.52.151]:51794 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728626AbfLMSQR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 13 Dec 2019 13:16:17 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Dec 2019 10:16:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,309,1571727600"; 
   d="scan'208";a="208536315"
Received: from gayuk-dev-mach.sc.intel.com ([10.3.79.172])
  by orsmga008.jf.intel.com with ESMTP; 13 Dec 2019 10:16:11 -0800
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
Subject: [PATCH v2 0/4] drivers: Add Tiger Lake hardware IDs to support acpi,
Date:   Fri, 13 Dec 2019 10:14:19 -0800
Message-Id: <cover.1576260216.git.gayatri.kammela@intel.com>
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

Changes since v1:
1) Maintain the readability by adding hardware IDs in a sorted order

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

