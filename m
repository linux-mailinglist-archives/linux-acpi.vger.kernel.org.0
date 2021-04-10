Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 160D735AD96
	for <lists+linux-acpi@lfdr.de>; Sat, 10 Apr 2021 15:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234733AbhDJN3i (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 10 Apr 2021 09:29:38 -0400
Received: from fgw23-7.mail.saunalahti.fi ([62.142.5.84]:32971 "EHLO
        fgw23-7.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234091AbhDJN3h (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Sat, 10 Apr 2021 09:29:37 -0400
X-Greylist: delayed 963 seconds by postgrey-1.27 at vger.kernel.org; Sat, 10 Apr 2021 09:29:37 EDT
Received: from localhost (88-115-248-186.elisa-laajakaista.fi [88.115.248.186])
        by fgw23.mail.saunalahti.fi (Halon) with ESMTP
        id 83156157-99fe-11eb-8ccd-005056bdfda7;
        Sat, 10 Apr 2021 16:13:16 +0300 (EEST)
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        devel@acpica.org
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Daniel Scally <djrscally@gmail.com>
Subject: [PATCH v1 1/1] ACPI: utils: Document for_each_acpi_dev_match() macro
Date:   Sat, 10 Apr 2021 16:13:04 +0300
Message-Id: <20210410131304.1858623-1-andy.shevchenko@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The macro requires to call acpi_dev_put() on each iteration.
Due to this it doesn't tolerate sudden disappearence of the devices.

Document all these nuances to prevent users blindly call it without
understanding the possible issues.

While at it, add the note to the acpi_dev_get_next_match_dev() and
advertise acpi_dev_put() instead of put_device() in the whole family
of the helper functions.

Fixes: bf263f64e804 ("media: ACPI / bus: Add acpi_dev_get_next_match_dev() and helper macro")
Cc: Daniel Scally <djrscally@gmail.com>
Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/acpi/utils.c    | 12 ++++++++----
 include/acpi/acpi_bus.h | 13 +++++++++++++
 2 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
index f1aff4dab476..3f3171e9aef5 100644
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
@@ -846,7 +846,11 @@ EXPORT_SYMBOL(acpi_dev_present);
  * Return the next match of ACPI device if another matching device was present
  * at the moment of invocation, or NULL otherwise.
  *
- * The caller is responsible to call put_device() on the returned device.
+ * Note, the function does not tolerate the sudden disappearance of @adev, e.g.
+ * in the case of hotplug event. That said, caller should ensure that this will
+ * never happen.
+ *
+ * The caller is responsible to call acpi_dev_put() on the returned device.
  *
  * See additional information in acpi_dev_present() as well.
  */
@@ -875,7 +879,7 @@ EXPORT_SYMBOL(acpi_dev_get_next_match_dev);
  * Return the first match of ACPI device if a matching device was present
  * at the moment of invocation, or NULL otherwise.
  *
- * The caller is responsible to call put_device() on the returned device.
+ * The caller is responsible to call acpi_dev_put() on the returned device.
  *
  * See additional information in acpi_dev_present() as well.
  */
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index f28b097c658f..834b7a1f7405 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -689,6 +689,19 @@ acpi_dev_get_next_match_dev(struct acpi_device *adev, const char *hid, const cha
 struct acpi_device *
 acpi_dev_get_first_match_dev(const char *hid, const char *uid, s64 hrv);
 
+/**
+ * for_each_acpi_dev_match - iterate over ACPI devices that matching the criteria
+ * @adev: pointer to the matching ACPI device, NULL at the end of the loop
+ * @hid: Hardware ID of the device.
+ * @uid: Unique ID of the device, pass NULL to not check _UID
+ * @hrv: Hardware Revision of the device, pass -1 to not check _HRV
+ *
+ * The caller is responsible to call acpi_dev_put() on the returned device.
+ *
+ * Due to above requirement there is a window that may invalidate @adev and
+ * next iteration will use a dangling pointer, e.g. in the case of hotplug
+ * event. That said, caller should ensure that this will never happen.
+ */
 #define for_each_acpi_dev_match(adev, hid, uid, hrv)			\
 	for (adev = acpi_dev_get_first_match_dev(hid, uid, hrv);	\
 	     adev;							\
-- 
2.31.1

