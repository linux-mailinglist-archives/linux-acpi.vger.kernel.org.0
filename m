Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF0019564A
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Mar 2020 12:25:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbgC0LZS convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Fri, 27 Mar 2020 07:25:18 -0400
Received: from m4a0073g.houston.softwaregrp.com ([15.124.2.131]:45029 "EHLO
        m4a0073g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727254AbgC0LZR (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 27 Mar 2020 07:25:17 -0400
Received: FROM m4a0073g.houston.softwaregrp.com (15.120.17.147) BY m4a0073g.houston.softwaregrp.com WITH ESMTP;
 Fri, 27 Mar 2020 11:22:44 +0000
Received: from M9W0067.microfocus.com (2002:f79:be::f79:be) by
 M4W0335.microfocus.com (2002:f78:1193::f78:1193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Fri, 27 Mar 2020 11:23:20 +0000
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (15.124.72.11) by
 M9W0067.microfocus.com (15.121.0.190) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Fri, 27 Mar 2020 11:23:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ghu8jzo5bpPgDkLxwzBuvd/3VXLq7KISkWo1YUDCzIOPE/oKjyAurhOAPdt9V1yWfCIGAC/muxC/sASZW1DsBddIQX+Y17E+z0EqZS2LinRvRY8rWLrWLY7RX8bThJxgcEdFWvNexrwzaScCDtHzv9nnlTaWPGj1+9G3B0Wo4Yue/rxBh6VRvKs3wF7lsZUIofP/Fln/6tK7G8hUFfD2UQkxePfUxmP+4zZVCbI8Il+CigMZ83KT/Spj8TUpHLww3VwanGu2ZjXKXJmpgHM3k+GdsLL9q839oOmzafK2L3Ogl8TeINDYvK+Ph+wHbcduXjkneJT/u68iKldSLm7TMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5C1izI03Kdap6Bj+CEK2rEn6r/SqgjASTF/nli3PDbw=;
 b=Lw21wtV5HXppzZxadewUkApobrUu8uULIRcXOA20bT4bGzrUj6HlETo1mw32l34CQwBU7Gf1AKb4v83XMdi8oBqPFeHrEDork7HQVWLwL8lBm4TIZBcme3NpUcR/b0Mm6iuSKHBi0G3dRxnGJJtRmApDtdAw/RlxvdK9PJvjrrmUkd8oNWNMUYS3F1W7rYvcZiGgtA8s+BsJ6sFpoFU7812Z1SwcvBdhDh8oFf4rUIRkxRv/qXcddMNhMqLrhQJKgqTO3lfelzcC70TLXqAq2hoqPqfRsf7Ef3Q3pMhnoYFPyr3Gk1nv9TFxWe9AIN2BRPR341rrDFlWzKA20EiqWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: spf=none (sender IP is ) smtp.mailfrom=clin@suse.com; 
Received: from SN1PR18MB2126.namprd18.prod.outlook.com (2603:10b6:802:29::29)
 by SN1PR18MB2095.namprd18.prod.outlook.com (2603:10b6:802:31::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.22; Fri, 27 Mar
 2020 11:23:19 +0000
Received: from SN1PR18MB2126.namprd18.prod.outlook.com
 ([fe80::1b1:6ada:da24:d1e9]) by SN1PR18MB2126.namprd18.prod.outlook.com
 ([fe80::1b1:6ada:da24:d1e9%5]) with mapi id 15.20.2856.019; Fri, 27 Mar 2020
 11:23:19 +0000
From:   Chester Lin <clin@suse.com>
To:     <rjw@rjwysocki.net>, <lenb@kernel.org>, <robert.moore@intel.com>,
        <erik.kaneda@intel.com>, <gregkh@linuxfoundation.org>
CC:     <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devel@acpica.org>, <jlee@suse.com>, <mhocko@suse.com>,
        Chester Lin <clin@suse.com>
Subject: [RFC PATCH 1/3] ACPI: scan: add userland notification while handling eject events
Date:   Fri, 27 Mar 2020 19:22:45 +0800
Message-ID: <20200327112247.17691-2-clin@suse.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200327112247.17691-1-clin@suse.com>
References: <20200327112247.17691-1-clin@suse.com>
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0162.apcprd02.prod.outlook.com
 (2603:1096:201:1f::22) To SN1PR18MB2126.namprd18.prod.outlook.com
 (2603:10b6:802:29::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (220.141.80.97) by HK2PR02CA0162.apcprd02.prod.outlook.com (2603:1096:201:1f::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.19 via Frontend Transport; Fri, 27 Mar 2020 11:23:16 +0000
X-Mailer: git-send-email 2.24.0
X-Originating-IP: [220.141.80.97]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1a9b88e8-817a-4376-aaf3-08d7d2414027
X-MS-TrafficTypeDiagnostic: SN1PR18MB2095:
X-LD-Processed: 856b813c-16e5-49a5-85ec-6f081e13b527,ExtFwd
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR18MB2095FE9654D624D29738C4EEADCC0@SN1PR18MB2095.namprd18.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 0355F3A3AE
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(39860400002)(136003)(376002)(366004)(396003)(6666004)(66556008)(6512007)(66946007)(69590400007)(66476007)(316002)(1076003)(6486002)(107886003)(52116002)(6506007)(5660300002)(81166006)(81156014)(16526019)(186003)(8676002)(8936002)(4326008)(956004)(2616005)(2906002)(86362001)(478600001)(15650500001)(26005)(36756003);DIR:OUT;SFP:1102;SCL:1;SRVR:SN1PR18MB2095;H:SN1PR18MB2126.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;
Received-SPF: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N4IQeZZWLybWnHSFXuu0f8uVGh5em9MtPLwmec4Pa0ZWalOXsIvfR+MjaiTDKpefBCSIV+E51Rfp+2P0LbM14gxi8h8uwhoX1XKgkRi65MRiN6uKFWgDMVeefotl5lsj0ZZVAwHPu8niaHClFF9soi600F/usb5Oh9TkkRX8mFt8FcDMpijCLyj5ojcNdSo3/KHNcEXKIsBlE9zfW1wWTTzjif3UetQP/Bgy+CJIO9fExN5RMRHWe+4LDQalOt/vAaBzpEZtmjfkZ7goppyYIe0T+U1XUz8slRf5ZGuukZdjUnqUBjn6WvcZAcAZADyh4rfT+k2cTm1ow340MPDyYkWZVCQEsIbo7teIyuC51GJu+DZj9lt6ZvzhKGQLrw1ZKOWMzjogjh5IW7PbOT7auD/nNre1uxR5SDKoezdWm6+nfUdA6RuYnKMnGiBGGwbFpzqWtiPvgBUmzn+0zimbmyKhPRjXtaQl1+u0/LRmFCYjz6KI6Xe8yg08XTY1wdim
X-MS-Exchange-AntiSpam-MessageData: 8DYhMLpAdsjzrtnoKaPh/QdwrAVSL5Dsq0QB1cll5bPpe/RcDmMSZcknPXecKd1yWD9EtNsYt3/JcWEXRUSw4hU7aOsoLOs2Malh2eDC4yKakapmkzS18DQTF5HH1laSekf8nA+/TTuzgcyrcFk/mw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a9b88e8-817a-4376-aaf3-08d7d2414027
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2020 11:23:18.9332
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GhyxLpPPk/W8BR+bqP/wJ6LC8MgpZqYyK54woevq7jI81SrixexLTOtiD+zRZSDi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR18MB2095
X-OriginatorOrg: suse.com
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Add a request_offline attribute in order to tell the kernel if it's
required to send notifications to userland first while handling an eject
event. Userland will have to put the target device offline when this
attribute is set.

Signed-off-by: Chester Lin <clin@suse.com>
---
 Documentation/ABI/testing/sysfs-bus-acpi | 16 ++++++++++
 drivers/acpi/device_sysfs.c              | 40 +++++++++++++++++++++++-
 drivers/acpi/scan.c                      | 39 +++++++++++++++++++----
 include/acpi/acpi_bus.h                  |  1 +
 4 files changed, 89 insertions(+), 7 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-acpi b/Documentation/ABI/testing/sysfs-bus-acpi
index e7898cfe5fb1..b9c467704889 100644
--- a/Documentation/ABI/testing/sysfs-bus-acpi
+++ b/Documentation/ABI/testing/sysfs-bus-acpi
@@ -93,3 +93,19 @@ Description:
 		hardware, if the _HRV control method is present.  It is mostly
 		useful for non-PCI devices because lspci can list the hardware
 		version for PCI devices.
+
+What:		/sys/bus/acpi/devices/.../request_offline
+Date:		Mar, 2020
+Contact:	Chester Lin <clin@suse.com>
+Description:
+		(RW) Allows the userland to receive offline requests when
+		devices are planning to be ejected.
+
+		If bit [0] is clear, the kernel will automatically try putting
+		the target offline before the target can be ejected.
+
+		If bit [0] is set, a uevent will be sent to userland as an
+		offline request and userland is responsible for handling offline
+		operations before the target can be ejected. This approach
+		provides flexibility while some applications could need more
+		time to release resources.
diff --git a/drivers/acpi/device_sysfs.c b/drivers/acpi/device_sysfs.c
index 96869f1538b9..453bd1b9edf5 100644
--- a/drivers/acpi/device_sysfs.c
+++ b/drivers/acpi/device_sysfs.c
@@ -506,6 +506,37 @@ static ssize_t status_show(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RO(status);
 
+static ssize_t request_offline_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct acpi_device *acpi_dev = to_acpi_device(dev);
+
+	return sprintf(buf, "%u\n", acpi_dev->request_offline?1:0);
+}
+
+static ssize_t request_offline_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct acpi_device *acpi_dev = to_acpi_device(dev);
+
+	if (!count)
+		return -EINVAL;
+
+	switch (buf[0]) {
+	case '0':
+		acpi_dev->request_offline = false;
+		break;
+	case '1':
+		acpi_dev->request_offline = true;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return count;
+}
+static DEVICE_ATTR_RW(request_offline);
+
 /**
  * acpi_device_setup_files - Create sysfs attributes of an ACPI device.
  * @dev: ACPI device object.
@@ -580,6 +611,11 @@ int acpi_device_setup_files(struct acpi_device *dev)
 		result = device_create_file(&dev->dev, &dev_attr_eject);
 		if (result)
 			return result;
+
+		result = device_create_file(&dev->dev,
+					    &dev_attr_request_offline);
+		if (result)
+			return result;
 	}
 
 	if (dev->flags.power_manageable) {
@@ -623,8 +659,10 @@ void acpi_device_remove_files(struct acpi_device *dev)
 	/*
 	 * If device has _EJ0, remove 'eject' file.
 	 */
-	if (acpi_has_method(dev->handle, "_EJ0"))
+	if (acpi_has_method(dev->handle, "_EJ0")) {
 		device_remove_file(&dev->dev, &dev_attr_eject);
+		device_remove_file(&dev->dev, &dev_attr_request_offline);
+	}
 
 	if (acpi_has_method(dev->handle, "_SUN"))
 		device_remove_file(&dev->dev, &dev_attr_sun);
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 6d3448895382..1cb39c5360cf 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -145,6 +145,7 @@ static acpi_status acpi_bus_offline(acpi_handle handle, u32 lvl, void *data,
 	struct acpi_device_physical_node *pn;
 	bool second_pass = (bool)data;
 	acpi_status status = AE_OK;
+	char *envp[] = { "EVENT=offline", NULL };
 
 	if (acpi_bus_get_device(handle, &device))
 		return AE_OK;
@@ -166,7 +167,18 @@ static acpi_status acpi_bus_offline(acpi_handle handle, u32 lvl, void *data,
 		} else {
 			pn->put_online = false;
 		}
-		ret = device_offline(pn->dev);
+
+		/* Don't offline directly but need to notify userland first */
+		if (device->request_offline) {
+			if (pn->dev->offline)
+				ret = 0;
+			else
+				ret = kobject_uevent_env(&pn->dev->kobj,
+							KOBJ_CHANGE, envp);
+		} else {
+			ret = device_offline(pn->dev);
+		}
+
 		if (ret >= 0) {
 			pn->put_online = !ret;
 		} else {
@@ -188,6 +200,7 @@ static acpi_status acpi_bus_online(acpi_handle handle, u32 lvl, void *data,
 {
 	struct acpi_device *device = NULL;
 	struct acpi_device_physical_node *pn;
+	char *envp[] = { "EVENT=online", NULL };
 
 	if (acpi_bus_get_device(handle, &device))
 		return AE_OK;
@@ -196,7 +209,12 @@ static acpi_status acpi_bus_online(acpi_handle handle, u32 lvl, void *data,
 
 	list_for_each_entry(pn, &device->physical_node_list, node)
 		if (pn->put_online) {
-			device_online(pn->dev);
+			if (device->request_offline)
+				kobject_uevent_env(&pn->dev->kobj,
+						   KOBJ_CHANGE, envp);
+			else
+				device_online(pn->dev);
+
 			pn->put_online = false;
 		}
 
@@ -256,14 +274,23 @@ static int acpi_scan_hot_remove(struct acpi_device *device)
 	acpi_handle handle = device->handle;
 	unsigned long long sta;
 	acpi_status status;
+	bool notify_single = false;
+	int error;
 
-	if (device->handler && device->handler->hotplug.demand_offline) {
-		if (!acpi_scan_is_offline(device, true))
+	if (device->handler && device->handler->hotplug.demand_offline)
+		if (!device->request_offline)
+			notify_single = true;
+
+	if (!acpi_scan_is_offline(device, notify_single)) {
+		if (notify_single)
 			return -EBUSY;
-	} else {
-		int error = acpi_scan_try_to_offline(device);
+
+		error = acpi_scan_try_to_offline(device);
 		if (error)
 			return error;
+
+		if (device->request_offline)
+			return -EBUSY;
 	}
 
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO,
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 0c23fd0548d1..7a29ea0a7d0e 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -375,6 +375,7 @@ struct acpi_device {
 	struct list_head physical_node_list;
 	struct mutex physical_node_lock;
 	void (*remove)(struct acpi_device *);
+	bool request_offline;
 };
 
 /* Non-device subnode */
-- 
2.24.0

