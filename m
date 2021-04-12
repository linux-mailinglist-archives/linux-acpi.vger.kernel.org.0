Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C88B35D3DF
	for <lists+linux-acpi@lfdr.de>; Tue, 13 Apr 2021 01:23:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242154AbhDLXVV (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 12 Apr 2021 19:21:21 -0400
Received: from fgw22-7.mail.saunalahti.fi ([62.142.5.83]:36692 "EHLO
        fgw22-7.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344065AbhDLXVU (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 12 Apr 2021 19:21:20 -0400
Received: from localhost (88-115-248-186.elisa-laajakaista.fi [88.115.248.186])
        by fgw22.mail.saunalahti.fi (Halon) with ESMTP
        id be0ecccb-9be5-11eb-88cb-005056bdf889;
        Tue, 13 Apr 2021 02:21:00 +0300 (EEST)
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        devel@acpica.org
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v2 2/2] ACPI: utils: Capitalize abbreviations in the comments
Date:   Tue, 13 Apr 2021 02:20:52 +0300
Message-Id: <20210412232052.2162107-2-andy.shevchenko@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210412232052.2162107-1-andy.shevchenko@gmail.com>
References: <20210412232052.2162107-1-andy.shevchenko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The DSDT and ACPI should be capitalized.

Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
v2: split from patch 1 as per Rafael's request
 drivers/acpi/utils.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
index 60e46efc1bc8..3b54b8fd7396 100644
--- a/drivers/acpi/utils.c
+++ b/drivers/acpi/utils.c
@@ -811,7 +811,7 @@ static int acpi_dev_match_cb(struct device *dev, const void *data)
  * Note that if the device is pluggable, it may since have disappeared.
  *
  * Note that unlike acpi_dev_found() this function checks the status
- * of the device. So for devices which are present in the dsdt, but
+ * of the device. So for devices which are present in the DSDT, but
  * which are disabled (their _STA callback returns 0) this function
  * will return false.
  *
@@ -838,7 +838,7 @@ EXPORT_SYMBOL(acpi_dev_present);
 
 /**
  * acpi_dev_get_next_match_dev - Return the next match of ACPI device
- * @adev: Pointer to the previous acpi_device matching this @hid, @uid and @hrv
+ * @adev: Pointer to the previous ACPI device matching this @hid, @uid and @hrv
  * @hid: Hardware ID of the device.
  * @uid: Unique ID of the device, pass NULL to not check _UID
  * @hrv: Hardware Revision of the device, pass -1 to not check _HRV
-- 
2.31.1

