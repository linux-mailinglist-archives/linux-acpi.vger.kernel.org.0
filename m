Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61C762E2340
	for <lists+linux-acpi@lfdr.de>; Thu, 24 Dec 2020 02:13:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728867AbgLXBKs (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 23 Dec 2020 20:10:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728849AbgLXBKr (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 23 Dec 2020 20:10:47 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EA62C0611CD;
        Wed, 23 Dec 2020 17:09:39 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id 3so382647wmg.4;
        Wed, 23 Dec 2020 17:09:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pXfvbEbd97X9tgUcpgJXDMXX4T6+llrDk7Gc/FGg//Y=;
        b=pdkhJoVdBdsTNCQLRAjaKojDdYEwaTCipf3GHM8oSUxBocoHcjjT3geseMKBbCjvHG
         YG8/OU89/eMjiG3BDmEBuzf4EHpHjpl2YRpMweoz4hWowzXPT29rgpkjfL75kFb26cqv
         4a6yBtGbROTA/7Pm202chdMDPUEtjSPw1fcwbPtyP/9CuiHXEzWh4Vnb7cpyZfYZORpV
         MGcGK87qDxzGfp0ZTRdXX1d6bofRWV98yvW5NecTfrCgrYKtyTfyJi+9Vrt4Pi7lRpoa
         ASDz0sllD9BK4OZoAI9ciZXnNvsmD+bcl2+SKk29gu0S+YywFXeTZvEM/bNKRSe3kfZY
         ThrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pXfvbEbd97X9tgUcpgJXDMXX4T6+llrDk7Gc/FGg//Y=;
        b=K9xNNgXjvhE19I5Axwni+/EfBVf8qGEzHOjwQ8VTup07Ob6GSEtk4HB9dUzDTJ/wqD
         9ePl2Lxzk6kcOW6mebafapxNpNMaoV+YLeNa5QW7jiZq4QsQ5ujxdo6bKWlS+hKsQyUh
         H9Ym9CsAlm6oUoDNJmX6/KgNKRKUzkK+pOndQCjQjBg4sXw0nZMvDVj9ZgTqklWT0vTC
         dD58tSMXR9FzXA3Dx+RK+XHtJMmYVv5rwf7gyz5MKUwziDUPRbfuxtiIz5loBhmhjMUU
         56xfJ1h8DSojnphpI4wlWsMwdgWZnpxl5A+ql9/NRdkfoEjnkyQgHH9tRgcl8+5jrwLP
         gdgQ==
X-Gm-Message-State: AOAM532Jkcyd40uqJgMI+wNdNUh+GbxsJLT/P4DygdEI4eNnFtTikdWq
        G3nyQki87MHN92N//NAomrcgS9DJLBcoCDWr
X-Google-Smtp-Source: ABdhPJyn73S6Pxf3bJIidrjYtZpWabGA2Hoxk8EqIvh689uAsC2qIHypCJ8GD1MGWNQICEM4/qpIfg==
X-Received: by 2002:a1c:6506:: with SMTP id z6mr1949588wmb.55.1608772177883;
        Wed, 23 Dec 2020 17:09:37 -0800 (PST)
Received: from valhalla.home ([2.31.224.116])
        by smtp.gmail.com with ESMTPSA id b200sm1598653wmb.10.2020.12.23.17.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Dec 2020 17:09:37 -0800 (PST)
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
        hverkuil-cisco@xs4all.nl, m.felsch@pengutronix.de,
        niklas.soderlund+renesas@ragnatech.se, slongerbeam@gmail.com,
        heikki.krogerus@linux.intel.com, linus.walleij@linaro.org
Subject: [PATCH v3 12/14] acpi: Add acpi_dev_get_next_match_dev() and helper macro
Date:   Thu, 24 Dec 2020 01:09:05 +0000
Message-Id: <20201224010907.263125-13-djrscally@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201224010907.263125-1-djrscally@gmail.com>
References: <20201224010907.263125-1-djrscally@gmail.com>
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
Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Daniel Scally <djrscally@gmail.com>
---
Changes in v3
	- prefixed referenced to the arguments with "@" in comment

 drivers/acpi/utils.c    | 30 ++++++++++++++++++++++++++----
 include/acpi/acpi_bus.h |  7 +++++++
 2 files changed, 33 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
index d5411a166685..ddca1550cce6 100644
--- a/drivers/acpi/utils.c
+++ b/drivers/acpi/utils.c
@@ -843,12 +843,13 @@ bool acpi_dev_present(const char *hid, const char *uid, s64 hrv)
 EXPORT_SYMBOL(acpi_dev_present);
 
 /**
- * acpi_dev_get_first_match_dev - Return the first match of ACPI device
+ * acpi_dev_get_next_match_dev - Return the next match of ACPI device
+ * @adev: Pointer to the previous acpi_device matching this @hid, @uid and @hrv
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

