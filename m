Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B83F13090C
	for <lists+linux-acpi@lfdr.de>; Fri, 31 May 2019 08:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726002AbfEaG5u (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 31 May 2019 02:57:50 -0400
Received: from smtp2.provo.novell.com ([137.65.250.81]:47235 "EHLO
        smtp2.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbfEaG5t (ORCPT
        <rfc822;groupwise-linux-acpi@vger.kernel.org:0:0>);
        Fri, 31 May 2019 02:57:49 -0400
Received: from linux-8mug.suse.de (prva10-snat226-1.provo.novell.com [137.65.226.35])
        by smtp2.provo.novell.com with ESMTP (TLS encrypted); Fri, 31 May 2019 00:57:40 -0600
From:   Chester Lin <clin@suse.com>
To:     rjw@rjwysocki.net, lenb@kernel.org, gregkh@linuxfoundation.org
Cc:     jlee@suse.com, mhocko@suse.com, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chester Lin <clin@suse.com>
Subject: [PATCH 3/3] ACPI / device_sysfs: Add eject show attr to monitor eject status
Date:   Fri, 31 May 2019 14:56:42 +0800
Message-Id: <20190531065642.13254-4-clin@suse.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190531065642.13254-1-clin@suse.com>
References: <20190531065642.13254-1-clin@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

An acpi_eject_show attribute for users to monitor current status because
sometimes it might take time to finish an ejection so we need to know
whether it is still in progress or not.

Signed-off-by: Chester Lin <clin@suse.com>
---
 drivers/acpi/device_sysfs.c | 20 +++++++++++++++++++-
 drivers/acpi/internal.h     |  1 +
 drivers/acpi/scan.c         | 27 +++++++++++++++++++++++++++
 3 files changed, 47 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/device_sysfs.c b/drivers/acpi/device_sysfs.c
index 78c2653bf020..70b22eec6bbc 100644
--- a/drivers/acpi/device_sysfs.c
+++ b/drivers/acpi/device_sysfs.c
@@ -403,7 +403,25 @@ acpi_eject_store(struct device *d, struct device_attribute *attr,
 	return status == AE_NO_MEMORY ? -ENOMEM : -EAGAIN;
 }
 
-static DEVICE_ATTR(eject, 0200, NULL, acpi_eject_store);
+static ssize_t acpi_eject_show(struct device *d,
+				struct device_attribute *attr, char *buf)
+{
+	struct acpi_device *acpi_device = to_acpi_device(d);
+	acpi_object_type not_used;
+	acpi_status status;
+
+	if ((!acpi_device->handler || !acpi_device->handler->hotplug.enabled)
+	    && !acpi_device->driver)
+		return -ENODEV;
+
+	status = acpi_get_type(acpi_device->handle, &not_used);
+	if (ACPI_FAILURE(status) || !acpi_device->flags.ejectable)
+		return -ENODEV;
+
+	return sprintf(buf, "%s\n", acpi_eject_status_string(acpi_device));
+}
+
+static DEVICE_ATTR(eject, 0644, acpi_eject_show, acpi_eject_store);
 
 static ssize_t
 acpi_device_hid_show(struct device *dev, struct device_attribute *attr, char *buf)
diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
index 0dcec4243b23..e7037d68c3d9 100644
--- a/drivers/acpi/internal.h
+++ b/drivers/acpi/internal.h
@@ -293,5 +293,6 @@ struct eject_data {
 };
 
 void acpi_eject_retry(struct acpi_device *adev);
+char *acpi_eject_status_string(struct acpi_device *adev);
 
 #endif /* _ACPI_INTERNAL_H_ */
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index c60110db1cd6..27c4c1148879 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -370,6 +370,33 @@ static int acpi_scan_offline_check(struct acpi_device *device)
 	return ret;
 }
 
+char *acpi_eject_status_string(struct acpi_device *adev)
+{
+	struct eject_data *eject_obj;
+	char *status_string = "none";
+
+	mutex_lock(&acpi_scan_lock);
+	eject_obj = (struct eject_data *) adev->eject_stat;
+
+	if (eject_obj) {
+		switch (eject_obj->status) {
+		case ACPI_EJECT_STATUS_NONE:
+			break;
+		case ACPI_EJECT_STATUS_GOING_OFFLINE:
+			status_string = "going offline";
+			break;
+		case ACPI_EJECT_STATUS_FAIL:
+			status_string = "failure";
+			break;
+		default:
+			status_string = "(unknown)";
+		}
+	}
+
+	mutex_unlock(&acpi_scan_lock);
+	return status_string;
+}
+
 static int acpi_scan_hot_remove(struct acpi_device *device)
 {
 	acpi_handle handle = device->handle;
-- 
2.20.1

