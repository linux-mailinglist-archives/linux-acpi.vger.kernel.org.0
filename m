Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6FC13D4179
	for <lists+linux-acpi@lfdr.de>; Fri, 23 Jul 2021 22:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbhGWTov (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 23 Jul 2021 15:44:51 -0400
Received: from mga11.intel.com ([192.55.52.93]:61244 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229655AbhGWTov (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 23 Jul 2021 15:44:51 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10054"; a="208833212"
X-IronPort-AV: E=Sophos;i="5.84,265,1620716400"; 
   d="scan'208";a="208833212"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2021 13:25:22 -0700
X-IronPort-AV: E=Sophos;i="5.84,265,1620716400"; 
   d="scan'208";a="471644941"
Received: from otcpl-devbox.jf.intel.com ([10.54.39.31])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2021 13:25:18 -0700
From:   Michael Bottini <michael.a.bottini@linux.intel.com>
To:     rjw@rjwysocki.net, lenb@kernel.org, irenic.rajneesh@gmail.com,
        david.e.box@linux.intel.com, hdegoede@redhat.com,
        mgross@linux.intel.com
Cc:     Michael Bottini <michael.a.bottini@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH 1/2] acpi: Add acpi_init_properties to ACPI driver code
Date:   Fri, 23 Jul 2021 13:21:56 -0700
Message-Id: <20210723202157.2425-1-michael.a.bottini@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Some products in the field, like Intel Rocket Lake systems, contain
AML code that can modify _DSD properties after they have been
evaluated by ACPI init code. Therefore, there is a need for drivers
to be able to reevaluate _DSDs so that the updated property values can
be read. Export acpi_init_properties() for this purpose.

Signed-off-by: Michael Bottini <michael.a.bottini@linux.intel.com>
---
 drivers/acpi/property.c | 1 +
 include/linux/acpi.h    | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index e312ebaed8db..2c1f8cf1a8f0 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -432,6 +432,7 @@ void acpi_init_properties(struct acpi_device *adev)
 	if (!adev->data.pointer)
 		acpi_extract_apple_properties(adev);
 }
+EXPORT_SYMBOL(acpi_init_properties);
 
 static void acpi_destroy_nondev_subnodes(struct list_head *list)
 {
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 72e4f7fd268c..57defc3bc9b9 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -716,6 +716,8 @@ static inline u64 acpi_arch_get_root_pointer(void)
 
 int acpi_get_local_address(acpi_handle handle, u32 *addr);
 
+void acpi_init_properties(struct acpi_device *adev);
+
 #else	/* !CONFIG_ACPI */
 
 #define acpi_disabled 1
@@ -976,6 +978,10 @@ static inline int acpi_get_local_address(acpi_handle handle, u32 *addr)
 	return -ENODEV;
 }
 
+static inline void acpi_init_properties(struct acpi_device *adev)
+{
+}
+
 #endif	/* !CONFIG_ACPI */
 
 #ifdef CONFIG_ACPI_HOTPLUG_IOAPIC
-- 
2.25.1

