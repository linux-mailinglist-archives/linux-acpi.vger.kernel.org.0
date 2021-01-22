Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53F1030038A
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Jan 2021 13:55:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727497AbhAVMyL (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 22 Jan 2021 07:54:11 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:41018 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbhAVMyI (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 22 Jan 2021 07:54:08 -0500
Received: from 1.general.khfeng.us.vpn ([10.172.68.174] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1l2vw8-0005pv-5u; Fri, 22 Jan 2021 12:53:13 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     rjw@rjwysocki.net
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        AceLan Kao <acelan.kao@canonical.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org (open list:ACPI),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] ACPI / device_sysfs: Prefer "compatible" modalias
Date:   Fri, 22 Jan 2021 20:53:02 +0800
Message-Id: <20210122125302.991591-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Commit 8765c5ba1949 ("ACPI / scan: Rework modalias creation when
"compatible" is present") may create two "MODALIAS=" in uevent file if
conditions are met.

This breaks systemd-udevd, which assumes each "key" in uevent file is
unique. The internal implementation of systemd-udevd overwrites the
first MODALIAS with the second one, so its kmod rule doesn't load driver
for the first MODALIAS.

So if both ACPI modalias and OF modalias are present, use the latter
one to ensure there's only one MODALIAS.

Reference: https://github.com/systemd/systemd/pull/18163
Cc: AceLan Kao <acelan.kao@canonical.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Suggested-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Fixes: 8765c5ba1949 ("ACPI / scan: Rework modalias creation when "compatible" is present")
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/acpi/device_sysfs.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/drivers/acpi/device_sysfs.c b/drivers/acpi/device_sysfs.c
index 96869f1538b9..bfca116482b8 100644
--- a/drivers/acpi/device_sysfs.c
+++ b/drivers/acpi/device_sysfs.c
@@ -251,20 +251,12 @@ int __acpi_device_uevent_modalias(struct acpi_device *adev,
 	if (add_uevent_var(env, "MODALIAS="))
 		return -ENOMEM;
 
-	len = create_pnp_modalias(adev, &env->buf[env->buflen - 1],
-				  sizeof(env->buf) - env->buflen);
-	if (len < 0)
-		return len;
-
-	env->buflen += len;
-	if (!adev->data.of_compatible)
-		return 0;
-
-	if (len > 0 && add_uevent_var(env, "MODALIAS="))
-		return -ENOMEM;
-
-	len = create_of_modalias(adev, &env->buf[env->buflen - 1],
-				 sizeof(env->buf) - env->buflen);
+	if (adev->data.of_compatible)
+		len = create_of_modalias(adev, &env->buf[env->buflen - 1],
+					 sizeof(env->buf) - env->buflen);
+	else
+		len = create_pnp_modalias(adev, &env->buf[env->buflen - 1],
+					  sizeof(env->buf) - env->buflen);
 	if (len < 0)
 		return len;
 
-- 
2.29.2

