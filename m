Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D60FA2ED0CC
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Jan 2021 14:31:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728635AbhAGNa3 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 7 Jan 2021 08:30:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728642AbhAGNaV (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Jan 2021 08:30:21 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8872C061290;
        Thu,  7 Jan 2021 05:29:12 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id k10so5174835wmi.3;
        Thu, 07 Jan 2021 05:29:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6Le4zT3Fvpu6jC0cQUY4eirqzD42KUANZUESAszTPTg=;
        b=HtFPlwNQuwXeaXYVP5hW0BjqCDbNoiZ6QLsp2B3fIhxEgKbZk7lYAacvLabRP089xb
         2J+KLQ8RK1DoCZ37RlfwZOxG8FkraiPiJXabQSPWIBQS0zVW2mktLD/3JvKfZA0miyGN
         MFfdvbPGypqeixq+zkdFnXL80nhVfFDSGY0Ia5MI3VzhE4NDJIK19KCqxE7uvBjLaXau
         xyPe37HjFdwEAmWXpOYOeECYLnoDxY9SO6sPZvBEVheEx6hcbGhu/ySxYAJJeTsE1xqM
         d66TRphF5A4ht0RBu/xa9n/H934s2Sti+5QGbD6yx5FE9QzUbvNco7v0FY7jeiQfVEJH
         xUKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6Le4zT3Fvpu6jC0cQUY4eirqzD42KUANZUESAszTPTg=;
        b=dYpK46xss4q3raL/o6KbeuJO0oVOdmWVt+L2ybYRgURdbQG8PVGmL+5scBrN82WOu3
         HrdK5DArofCMQL46zIeKMvsvz2c4Wh8Lefyuiu5EBGJU2WVzn5/u2ts0q/zT00fydx4S
         y+wMURfn+8HGEtwzZZd2JwHfg79a+dDKdUV7rpPnTRPgMHXaIZXAILQJeuXVRMkt/amQ
         GYzVTyjQ1HUc0cZiKdLha5p3lvbmD5TWrLuJa4/OzibnVvkwSaUhQYjGlIypRU+/MGOI
         n52Gsv+8vb/J14MDZGM+UGds44wrL6DTfnV9G2KOGf2GpgNQppHA4S4/cJaJaJpOV/1F
         +vTA==
X-Gm-Message-State: AOAM531lS7Q/drVDWCa/+Qx/rkPkeZVViOXk/vCfXIq6QL0TW2kyQdZk
        BPB5Kjs8fNjEe6Chybpb3RYBm3txPEFvjsH7
X-Google-Smtp-Source: ABdhPJzpphvQaYUCv7zu7KbvBeIE/lsrkpM4p/nQAIOPeAVuizqNkgO1M3PLRHLuu+yfq/fmtvmnDg==
X-Received: by 2002:a7b:ce96:: with SMTP id q22mr8049722wmj.164.1610026151613;
        Thu, 07 Jan 2021 05:29:11 -0800 (PST)
Received: from valhalla.home ([2.29.208.120])
        by smtp.gmail.com with ESMTPSA id o83sm7660125wme.21.2021.01.07.05.29.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 05:29:11 -0800 (PST)
From:   Daniel Scally <djrscally@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-media@vger.kernel.org, devel@acpica.org, rjw@rjwysocki.net,
        lenb@kernel.org, gregkh@linuxfoundation.org, mchehab@kernel.org,
        sergey.senozhatsky@gmail.com
Cc:     yong.zhi@intel.com, sakari.ailus@linux.intel.com,
        bingbu.cao@intel.com, tian.shu.qiu@intel.com,
        robert.moore@intel.com, erik.kaneda@intel.com, pmladek@suse.com,
        rostedt@goodmis.org, andriy.shevchenko@linux.intel.com,
        linux@rasmusvillemoes.dk,
        laurent.pinchart+renesas@ideasonboard.com,
        jacopo+renesas@jmondi.org, kieran.bingham+renesas@ideasonboard.com,
        hverkuil-cisco@xs4all.nl, m.felsch@pengutronix.de,
        niklas.soderlund+renesas@ragnatech.se,
        prabhakar.mahadev-lad.rj@bp.renesas.com, slongerbeam@gmail.com,
        heikki.krogerus@linux.intel.com
Subject: [PATCH v5 13/15] ACPI / bus: Add acpi_dev_get_next_match_dev() and helper macro
Date:   Thu,  7 Jan 2021 13:28:36 +0000
Message-Id: <20210107132838.396641-14-djrscally@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210107132838.396641-1-djrscally@gmail.com>
References: <20210107132838.396641-1-djrscally@gmail.com>
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
Changes in v5:

	- Changed commit subject

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
index 6d1879bf9440..02a716a0af5d 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -683,9 +683,16 @@ static inline bool acpi_device_can_poweroff(struct acpi_device *adev)
 
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

