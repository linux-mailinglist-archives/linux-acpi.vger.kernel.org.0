Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7573D2DDC1B
	for <lists+linux-acpi@lfdr.de>; Fri, 18 Dec 2020 00:50:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732472AbgLQXp2 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 17 Dec 2020 18:45:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732423AbgLQXpS (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 17 Dec 2020 18:45:18 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE244C0611CC;
        Thu, 17 Dec 2020 15:44:07 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id r4so551955wmh.5;
        Thu, 17 Dec 2020 15:44:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oGCJxAGqtJJ26HP8mxtKtxXBUimDrY8TQdEbrQWGOTg=;
        b=SFKd7hJPiwwsi9WxaJalVzeYPdp+dyQu0SMIC1mFQ+rt/VYCT+mMRcT9mq9jklkUan
         Y2XxG4ie+mZEI6InRkZ52Sle2uCPIj067Tm0L7ITq67+DgaZyiu32VgZ2pYAXaomH/m9
         4pBDx6hSho5NuOmutzoKS5jw3UPNem+/ci0QCUJ7Gmh7hozSkuJE6kySOndrvGcR5IDb
         Ri7nC5iBd/vtcj/XzcJt/eyRXRwR+qNywYwXKvYArjY4F7oTKp+oKOFMkTmJ8HsLVB03
         1MfBIxTwZDixSQlIeler7NOI2Xfdfs2XsI9wbH/XJ95znl6ei4We3cUH7wSbRili9Cov
         Mqew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oGCJxAGqtJJ26HP8mxtKtxXBUimDrY8TQdEbrQWGOTg=;
        b=jRI/9e1KfvUqhGgq2K9FxQxZ02qkaieWRs1g3H5iJf30Qc3eB9cBwmuPcDlbuVsFAq
         R4gZkVFlZ8YL0JlSWAXGl6sA/SGUJji7fcj19eTH9lOQ2WZYbCVQwtXxPpwAwBHx6sp6
         VqlEO65TJIy9gfdl3xPdg16KJ5wxahEuYe/WCMrnVdLtccSZkHpUOv/PnhQmco9krOkh
         CEvwSZALJVz6euIbsiec0baflvprWo/tzrni8eU1veUp3s7zBhe5Z5SZp2IrI5EWIcwu
         vsBu92h2Rzx3nRxukcFRelqxfQ+0IzQIZ2EBUeB1lN4B78zF5cwF/MSx3sYmvxSm/EkI
         cgfw==
X-Gm-Message-State: AOAM53139wW9Hflh9nR2RuX90aup4i1lZpymG0J2d0XystEt9vnPKU84
        IVHIBJ/4AVYlo9Fy1M0+N6nHPwdniHkIwURl
X-Google-Smtp-Source: ABdhPJw8hXsE5DE2NHFLgnTB0R2jFYnUCfoREgxu17Q/Mason9sp6mst0v0EUFDx0fr9CB2mheLXZQ==
X-Received: by 2002:a1c:220a:: with SMTP id i10mr1533796wmi.93.1608248646708;
        Thu, 17 Dec 2020 15:44:06 -0800 (PST)
Received: from valhalla.home ([2.29.208.56])
        by smtp.gmail.com with ESMTPSA id o3sm1873575wrc.93.2020.12.17.15.44.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Dec 2020 15:44:06 -0800 (PST)
From:   Daniel Scally <djrscally@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-media@vger.kernel.org, devel@acpica.org
Cc:     rjw@rjwysocki.net, lenb@kernel.org, gregkh@linuxfoundation.org,
        yong.zhi@intel.com, sakari.ailus@linux.intel.com,
        bingbu.cao@intel.com, tian.shu.qiu@intel.com, mchehab@kernel.org,
        robert.moore@intel.com, erik.kaneda@intel.com, pmladek@suse.com,
        rostedt@goodmis.org, sergey.senozhatsky@gmail.com,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        laurent.pinchart+renesas@ideasonboard.com,
        jacopo+renesas@jmondi.org, kieran.bingham+renesas@ideasonboard.com,
        linus.walleij@linaro.org, heikki.krogerus@linux.intel.com,
        kitakar@gmail.com, jorhand@linux.microsoft.com
Subject: [PATCH v2 11/12] acpi: Add acpi_dev_get_next_match_dev() and helper macro
Date:   Thu, 17 Dec 2020 23:43:36 +0000
Message-Id: <20201217234337.1983732-12-djrscally@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201217234337.1983732-1-djrscally@gmail.com>
References: <20201217234337.1983732-1-djrscally@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

To ensure we handle situations in which multiple sensors of the same
model (and therefore _HID) are present in a system, we need to be able
to iterate over devices matching a known _HID but unknown _UID and _HRV
 - add acpi_dev_get_next_match_dev() to accommodate that possibility and
change acpi_dev_get_first_match_dev() to simply call the new function
with a NULL starting point. Add an iterator macro for convenience.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Daniel Scally <djrscally@gmail.com>
---
Changes in v2:

	- None

 drivers/acpi/utils.c    | 30 ++++++++++++++++++++++++++----
 include/acpi/acpi_bus.h |  7 +++++++
 2 files changed, 33 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
index d5411a166685..c177165c8db2 100644
--- a/drivers/acpi/utils.c
+++ b/drivers/acpi/utils.c
@@ -843,12 +843,13 @@ bool acpi_dev_present(const char *hid, const char *uid, s64 hrv)
 EXPORT_SYMBOL(acpi_dev_present);
 
 /**
- * acpi_dev_get_first_match_dev - Return the first match of ACPI device
+ * acpi_dev_get_next_match_dev - Return the next match of ACPI device
+ * @adev: Pointer to the previous acpi_device matching this hid, uid and hrv
  * @hid: Hardware ID of the device.
  * @uid: Unique ID of the device, pass NULL to not check _UID
  * @hrv: Hardware Revision of the device, pass -1 to not check _HRV
  *
- * Return the first match of ACPI device if a matching device was present
+ * Return the next match of ACPI device if another matching device was present
  * at the moment of invocation, or NULL otherwise.
  *
  * The caller is responsible to call put_device() on the returned device.
@@ -856,8 +857,9 @@ EXPORT_SYMBOL(acpi_dev_present);
  * See additional information in acpi_dev_present() as well.
  */
 struct acpi_device *
-acpi_dev_get_first_match_dev(const char *hid, const char *uid, s64 hrv)
+acpi_dev_get_next_match_dev(struct acpi_device *adev, const char *hid, const char *uid, s64 hrv)
 {
+	struct device *start = adev ? &adev->dev : NULL;
 	struct acpi_dev_match_info match = {};
 	struct device *dev;
 
@@ -865,9 +867,29 @@ acpi_dev_get_first_match_dev(const char *hid, const char *uid, s64 hrv)
 	match.uid = uid;
 	match.hrv = hrv;
 
-	dev = bus_find_device(&acpi_bus_type, NULL, &match, acpi_dev_match_cb);
+	dev = bus_find_device(&acpi_bus_type, start, &match, acpi_dev_match_cb);
 	return dev ? to_acpi_device(dev) : NULL;
 }
+EXPORT_SYMBOL(acpi_dev_get_next_match_dev);
+
+/**
+ * acpi_dev_get_first_match_dev - Return the first match of ACPI device
+ * @hid: Hardware ID of the device.
+ * @uid: Unique ID of the device, pass NULL to not check _UID
+ * @hrv: Hardware Revision of the device, pass -1 to not check _HRV
+ *
+ * Return the first match of ACPI device if a matching device was present
+ * at the moment of invocation, or NULL otherwise.
+ *
+ * The caller is responsible to call put_device() on the returned device.
+ *
+ * See additional information in acpi_dev_present() as well.
+ */
+struct acpi_device *
+acpi_dev_get_first_match_dev(const char *hid, const char *uid, s64 hrv)
+{
+	return acpi_dev_get_next_match_dev(NULL, hid, uid, hrv);
+}
 EXPORT_SYMBOL(acpi_dev_get_first_match_dev);
 
 /*
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index a3abcc4b7d9f..0a028ba967d3 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -688,9 +688,16 @@ static inline bool acpi_device_can_poweroff(struct acpi_device *adev)
 
 bool acpi_dev_hid_uid_match(struct acpi_device *adev, const char *hid2, const char *uid2);
 
+struct acpi_device *
+acpi_dev_get_next_match_dev(struct acpi_device *adev, const char *hid, const char *uid, s64 hrv);
 struct acpi_device *
 acpi_dev_get_first_match_dev(const char *hid, const char *uid, s64 hrv);
 
+#define for_each_acpi_dev_match(adev, hid, uid, hrv)			\
+	for (adev = acpi_dev_get_first_match_dev(hid, uid, hrv);	\
+	     adev;							\
+	     adev = acpi_dev_get_next_match_dev(adev, hid, uid, hrv))
+
 static inline void acpi_dev_put(struct acpi_device *adev)
 {
 	put_device(&adev->dev);
-- 
2.25.1

