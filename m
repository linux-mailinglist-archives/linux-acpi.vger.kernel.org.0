Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85CA62E8EEE
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Jan 2021 00:18:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728020AbhACXOl (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 3 Jan 2021 18:14:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727810AbhACXOV (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 3 Jan 2021 18:14:21 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 316BFC0617A4;
        Sun,  3 Jan 2021 15:13:12 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id c5so30002993wrp.6;
        Sun, 03 Jan 2021 15:13:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nSHC5UlNieNu4bBk+m3lt5nuTpfGzGP8mOOMr3doLJI=;
        b=Ob2LJ9EdnGe0X+oxGKg6JeYQkREZJXye94UyBY9EFxE8ZsTFlTUecP9PKdytQsackQ
         U9sfwx39clBffLr9fe/P/2CHNBHZIPWid8O2TORLoFvkT5SHRLVknGARbzHgjXLT4pst
         cKTigEFkV0zmdwR8j1bS8OSuTLzwuUQj1npmbSMROSbbOZSQ53tZ2LLd2owXII1ZZbPZ
         1aB0sihVdelw9ebXBKMmDXY/W4VRf6KmAxmYCDNq0F4uR7AdUx6OMb1txRYEpxyJO+Re
         40l9jvBC5c2aO3xm7UsIshuIRaXDI+976TLAFVrWi4G4Y7bIR5WzRnFkrgwpl3JmmQoN
         Ln9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nSHC5UlNieNu4bBk+m3lt5nuTpfGzGP8mOOMr3doLJI=;
        b=q5H1lFDPHJnohtoV6umnXCxiYG+DgTpZOVuv7Qh308QSvcRmW+U/i7Zr7tTzYSUNY1
         JFtuZOQIQInwRzRzODbK4WGY+97Muwaw5POpmLRsZoAerz0TQBcIVd0LuCkUpvF6AWcw
         aBEYzWOsy/pQOMVuJykbse/dh3/SOoFnf3KbELKr9M1Xlzse0yJ7zFvzOOlxHNyGOVaq
         sWJg+f/7CsO4Fg5ZBw4vg29ICo6tkZcLVinFwVNfhlSn7H76cmaC4XvXtejoervDFluU
         v5Xwrny+z996QT8gvQPCSd4XoNApNQ1Tk1ndJkPIa2Pgk2eUJUi4tIoHEQrAmhVQ/05p
         u6dA==
X-Gm-Message-State: AOAM531vWvrGKRku/RmNp2+gXrJXdvrtXVP9U80e+Y/z+UPgToVBjFXE
        qrysEvjbJkv5qILpS9O/X0R/Pio4Lfn+dA/f
X-Google-Smtp-Source: ABdhPJylvUHwvNw1GTFQZk3COBCwhu7vEaDlWE9kFH+F4X4KxOypc7agxDrNfeiJi15KNAtu1+FmjA==
X-Received: by 2002:adf:94e1:: with SMTP id 88mr51584053wrr.341.1609715590980;
        Sun, 03 Jan 2021 15:13:10 -0800 (PST)
Received: from valhalla.home ([2.29.208.120])
        by smtp.gmail.com with ESMTPSA id h9sm32571018wme.11.2021.01.03.15.13.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jan 2021 15:13:10 -0800 (PST)
From:   Daniel Scally <djrscally@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-media@vger.kernel.org, devel@acpica.org,
        gregkh@linuxfoundation.org, rjw@rjwysocki.net,
        sergey.senozhatsky@gmail.com, mchehab@kernel.org
Cc:     lenb@kernel.org, yong.zhi@intel.com, sakari.ailus@linux.intel.com,
        bingbu.cao@intel.com, tian.shu.qiu@intel.com,
        robert.moore@intel.com, erik.kaneda@intel.com, pmladek@suse.com,
        rostedt@goodmis.org, andriy.shevchenko@linux.intel.com,
        linux@rasmusvillemoes.dk,
        laurent.pinchart+renesas@ideasonboard.com,
        jacopo+renesas@jmondi.org, kieran.bingham+renesas@ideasonboard.com,
        hverkuil-cisco@xs4all.nl, m.felsch@pengutronix.de,
        niklas.soderlund+renesas@ragnatech.se, slongerbeam@gmail.com,
        heikki.krogerus@linux.intel.com, linus.walleij@linaro.org
Subject: [PATCH v4 13/15] acpi: Add acpi_dev_get_next_match_dev() and helper macro
Date:   Sun,  3 Jan 2021 23:12:33 +0000
Message-Id: <20210103231235.792999-14-djrscally@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210103231235.792999-1-djrscally@gmail.com>
References: <20210103231235.792999-1-djrscally@gmail.com>
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
Changes in v4:

	- None

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

