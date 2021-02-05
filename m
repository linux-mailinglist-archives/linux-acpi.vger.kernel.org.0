Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6D673119D1
	for <lists+linux-acpi@lfdr.de>; Sat,  6 Feb 2021 04:22:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231171AbhBFDUl (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 5 Feb 2021 22:20:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231596AbhBFCuo (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 5 Feb 2021 21:50:44 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C19FC03C04F
        for <linux-acpi@vger.kernel.org>; Fri,  5 Feb 2021 14:26:57 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 134so8728569ybd.3
        for <linux-acpi@vger.kernel.org>; Fri, 05 Feb 2021 14:26:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=b4KyYLVrTLECRx+jmWSgUnKVrTsTSqPSowT6HXuVPvs=;
        b=OHW6wSTP29Ue99rfiI7cWlnG+iIdDrF/RFLn7uoMGaydP+0SO7iq4Wq4d3/eqO21ya
         KLmXP2JX5TSvNzDYoK5EV6DL9JdJSYMFn/F1Hp7y6d44BhceOCszy5fv7mkcI/x3YxAh
         xifCY/lhRuqpYU9xhi89Nys/lnLzdiyzix5IWrtJ/UWGBQrClmZRfFVt91VbD8X7eoQI
         2Png0NqhsXQZ7vz6M4N1fZn/vcqGhrLWGbEWE5mv2GRT3g9PI82H9hTXw4D2uizG5j9B
         ZxcCTRk1HSgG6v0SC8Wo+iqzvg2U5sjEO1EbK7JZfh6t3yDpITS6bKeEhMEzd8jVwfLv
         0Egg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=b4KyYLVrTLECRx+jmWSgUnKVrTsTSqPSowT6HXuVPvs=;
        b=f3NbrrDsnPIrW40GHfusojFmkQnmYx7yKcZ1LwR5cM2d/bjERinY25O6fPciHEd6Ky
         HlUbg+wydXxcR8FbyfS9T5PeyuBv590awb+LTMfg261wHc/vK8USW2pDCZIHvfuJQW0V
         KuJikq8C1fQsijTUMCaBH9nDADUDfT2I8fRgZSFKCFsaTUlI2gI6yClxT5hazgO5sY7t
         V0Y0wiRV3GbwVb+61gpaPF2Ncme8g5bGjsSskkndtly2fMqOUId9gDNlqi8PfDKpjFs2
         ubP9Vc5TbonbjV7WkAEn7MgWKxTPx8RYK/XaXDO1FC9Vix+6RimxR5D6NV3Qo4T+f0YG
         C66A==
X-Gm-Message-State: AOAM533Dp5NoI2Pqxn6iI9beQuA8gcze+ImXvBLdjnJm2r4kqMg5fRoz
        LMKo7liYOHhcXRPsDIUMVkKcWXZEZTBxcU0=
X-Google-Smtp-Source: ABdhPJw60eK9Ayb2Dfnm6izl3OAD/ZSexeT7MabEdfxzu+ks3+x2ogPf1BgHRmP6XVGyEvP6jtupQy7fiaM7V/g=
Sender: "saravanak via sendgmr" <saravanak@saravanak.san.corp.google.com>
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:6d36:b798:55d7:f5c5])
 (user=saravanak job=sendgmr) by 2002:a25:1188:: with SMTP id
 130mr9154088ybr.138.1612564016624; Fri, 05 Feb 2021 14:26:56 -0800 (PST)
Date:   Fri,  5 Feb 2021 14:26:39 -0800
In-Reply-To: <20210205222644.2357303-1-saravanak@google.com>
Message-Id: <20210205222644.2357303-4-saravanak@google.com>
Mime-Version: 1.0
References: <20210205222644.2357303-1-saravanak@google.com>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
Subject: [PATCH v4 3/8] driver core: Add fw_devlink.strict kernel param
From:   Saravana Kannan <saravanak@google.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Len Brown <len.brown@intel.com>, Len Brown <lenb@kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Saravana Kannan <saravanak@google.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

This param allows forcing all dependencies to be treated as mandatory.
This will be useful for boards in which all optional dependencies like
IOMMUs and DMAs need to be treated as mandatory dependencies.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 Documentation/admin-guide/kernel-parameters.txt |  5 +++++
 drivers/base/core.c                             | 12 ++++++++++++
 include/linux/fwnode.h                          |  1 +
 3 files changed, 18 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index a10b545c2070..692b63644133 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1433,6 +1433,11 @@
 				to enforce probe and suspend/resume ordering.
 			rpm --	Like "on", but also use to order runtime PM.
 
+	fw_devlink.strict=<bool>
+			[KNL] Treat all inferred dependencies as mandatory
+			dependencies. This only applies for fw_devlink=on|rpm.
+			Format: <bool>
+
 	gamecon.map[2|3]=
 			[HW,JOY] Multisystem joystick and NES/SNES/PSX pad
 			support via parallel port (up to 5 devices per port)
diff --git a/drivers/base/core.c b/drivers/base/core.c
index c95b1daabac7..f466ab4f1c35 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -1521,6 +1521,13 @@ static int __init fw_devlink_setup(char *arg)
 }
 early_param("fw_devlink", fw_devlink_setup);
 
+static bool fw_devlink_strict;
+static int __init fw_devlink_strict_setup(char *arg)
+{
+	return strtobool(arg, &fw_devlink_strict);
+}
+early_param("fw_devlink.strict", fw_devlink_strict_setup);
+
 u32 fw_devlink_get_flags(void)
 {
 	return fw_devlink_flags;
@@ -1531,6 +1538,11 @@ static bool fw_devlink_is_permissive(void)
 	return fw_devlink_flags == FW_DEVLINK_FLAGS_PERMISSIVE;
 }
 
+bool fw_devlink_is_strict(void)
+{
+	return fw_devlink_strict && !fw_devlink_is_permissive();
+}
+
 static void fw_devlink_parse_fwnode(struct fwnode_handle *fwnode)
 {
 	if (fwnode->flags & FWNODE_FLAG_LINKS_ADDED)
diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
index 21082f11473f..d5caefe39d93 100644
--- a/include/linux/fwnode.h
+++ b/include/linux/fwnode.h
@@ -162,6 +162,7 @@ static inline void fwnode_init(struct fwnode_handle *fwnode,
 }
 
 extern u32 fw_devlink_get_flags(void);
+extern bool fw_devlink_is_strict(void);
 int fwnode_link_add(struct fwnode_handle *con, struct fwnode_handle *sup);
 void fwnode_links_purge(struct fwnode_handle *fwnode);
 
-- 
2.30.0.478.g8a0d178c01-goog

