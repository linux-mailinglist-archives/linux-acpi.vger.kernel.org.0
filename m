Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA522FB3D6
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Jan 2021 09:17:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730106AbhASIQ3 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 19 Jan 2021 03:16:29 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:49843 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731266AbhASIQK (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 19 Jan 2021 03:16:10 -0500
Received: from 1-171-232-235.dynamic-ip.hinet.net ([1.171.232.235] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1l1mAe-00018m-Aq; Tue, 19 Jan 2021 08:15:25 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     rjw@rjwysocki.net
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        AceLan Kao <acelan.kao@canonical.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org (open list:ACPI),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] ACPI / device_sysfs: Use OF_MODALIAS for "compatible" modalias
Date:   Tue, 19 Jan 2021 16:15:13 +0800
Message-Id: <20210119081513.300938-1-kai.heng.feng@canonical.com>
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

Right now it doesn't seem to have any user relies on the second
MODALIAS, so change it to OF_MODALIAS to workaround the issue.

Reference: https://github.com/systemd/systemd/pull/18163
Fixes: 8765c5ba1949 ("ACPI / scan: Rework modalias creation when "compatible" is present")
Cc: AceLan Kao <acelan.kao@canonical.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/acpi/device_sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/device_sysfs.c b/drivers/acpi/device_sysfs.c
index 96869f1538b9..c92b671cb816 100644
--- a/drivers/acpi/device_sysfs.c
+++ b/drivers/acpi/device_sysfs.c
@@ -260,7 +260,7 @@ int __acpi_device_uevent_modalias(struct acpi_device *adev,
 	if (!adev->data.of_compatible)
 		return 0;
 
-	if (len > 0 && add_uevent_var(env, "MODALIAS="))
+	if (len > 0 && add_uevent_var(env, "OF_MODALIAS="))
 		return -ENOMEM;
 
 	len = create_of_modalias(adev, &env->buf[env->buflen - 1],
-- 
2.29.2

