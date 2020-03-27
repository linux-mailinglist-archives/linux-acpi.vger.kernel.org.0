Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8437195656
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Mar 2020 12:28:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbgC0L27 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Fri, 27 Mar 2020 07:28:59 -0400
Received: from m4a0072g.houston.softwaregrp.com ([15.124.2.130]:54574 "EHLO
        m4a0072g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726165AbgC0L26 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 27 Mar 2020 07:28:58 -0400
Received: FROM m4a0072g.houston.softwaregrp.com (15.120.17.147) BY m4a0072g.houston.softwaregrp.com WITH ESMTP;
 Fri, 27 Mar 2020 11:27:38 +0000
Received: from M9W0067.microfocus.com (2002:f79:be::f79:be) by
 M4W0335.microfocus.com (2002:f78:1193::f78:1193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Fri, 27 Mar 2020 11:23:26 +0000
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (15.124.72.13) by
 M9W0067.microfocus.com (15.121.0.190) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Fri, 27 Mar 2020 11:23:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SzP8DjEP1LJJbqLzDE+bAXS1+vGJly+u1YZaUFisb5EDjGqHaHINV1UUJMhLYWxLgdhU/MRGIvjxGKMxLIy0kpCRVJNxlHuZQX80LMbHXPBjrbVSWQ0tEyYJsHvfC+JNXcNWabNCrKotaY6qRYTniq8xxCeRFWYv/C60pSn05FHyR0u1JVpxbejmPZ+xYI1AVsYDwi2NDI77l190T/t8rT1wHSp/TsS8CTDL4nWSQcG1xGbKvDvqMFFdn/ip2IN5ke4wrppcR6eySjtltmmA6aNim4hDDgVpLFZ4RW12pYdzlY9oulCW9Bf3qXB4ABAQvuNGvHzN0Qda1rtga2254A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hg+q0WMUHJaIOMSWvsGUQvyt7vR1IpHDMPzHmTNHpOo=;
 b=byCZkXAE0k5L4rFlYR2yuq6RIOTaKTZVlIbxqVMmS1E2UErLxGlqxUoIMdKhVneXtJch5HUPQbyHPBWo64FffKu4DGU1TYZ2JRzUtGbYDphTam6C05UkXcmeCqSq2ESHzEM3ftcXG6HauLUttXbuSAb/LY/mhn2M7cdthHOyxzjLB+JYwc+qh+PtU3uOjOxFyI7EOsBYV2p83WF0r+1e7/nHLG99W9UoI+HDCyqIstvNKSioH4DJwuONoBGc0W9xkEjSyhqdleIULOJw6tFFK9mO1dSX9hxJzGexeAWIRRms4QoMD/n1SCkMQ/rDNFpn4fy8AX+FZqxZqI5Wc0/CQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: spf=none (sender IP is ) smtp.mailfrom=clin@suse.com; 
Received: from SN1PR18MB2126.namprd18.prod.outlook.com (2603:10b6:802:29::29)
 by SN1PR18MB2095.namprd18.prod.outlook.com (2603:10b6:802:31::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.22; Fri, 27 Mar
 2020 11:23:23 +0000
Received: from SN1PR18MB2126.namprd18.prod.outlook.com
 ([fe80::1b1:6ada:da24:d1e9]) by SN1PR18MB2126.namprd18.prod.outlook.com
 ([fe80::1b1:6ada:da24:d1e9%5]) with mapi id 15.20.2856.019; Fri, 27 Mar 2020
 11:23:22 +0000
From:   Chester Lin <clin@suse.com>
To:     <rjw@rjwysocki.net>, <lenb@kernel.org>, <robert.moore@intel.com>,
        <erik.kaneda@intel.com>, <gregkh@linuxfoundation.org>
CC:     <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devel@acpica.org>, <jlee@suse.com>, <mhocko@suse.com>,
        Chester Lin <clin@suse.com>
Subject: [RFC PATCH 2/3] ACPI: scan: add cancel_eject and auto_eject attributes
Date:   Fri, 27 Mar 2020 19:22:46 +0800
Message-ID: <20200327112247.17691-3-clin@suse.com>
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
Received: from localhost.localdomain (220.141.80.97) by HK2PR02CA0162.apcprd02.prod.outlook.com (2603:1096:201:1f::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.19 via Frontend Transport; Fri, 27 Mar 2020 11:23:19 +0000
X-Mailer: git-send-email 2.24.0
X-Originating-IP: [220.141.80.97]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f27d2771-5983-454d-9991-08d7d2414220
X-MS-TrafficTypeDiagnostic: SN1PR18MB2095:
X-LD-Processed: 856b813c-16e5-49a5-85ec-6f081e13b527,ExtFwd
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR18MB20956A7E17635417BFA0D107ADCC0@SN1PR18MB2095.namprd18.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 0355F3A3AE
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(39860400002)(136003)(376002)(366004)(396003)(6666004)(66556008)(6512007)(66946007)(69590400007)(66476007)(30864003)(316002)(1076003)(6486002)(107886003)(52116002)(6506007)(5660300002)(81166006)(81156014)(16526019)(186003)(8676002)(8936002)(4326008)(956004)(2616005)(2906002)(86362001)(478600001)(26005)(36756003);DIR:OUT;SFP:1102;SCL:1;SRVR:SN1PR18MB2095;H:SN1PR18MB2126.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;
Received-SPF: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r56qN7yCboGLXXsZZHK6/tVBAK7t3j08fyge0ZP2GGKISxhV3US53pnneTEETmClooBX7wO9tckS6or/QtMdhjSzr7Wf2sWc9cMqwy17MZl3AlViJv5iQ0fA4GVY9wUIRRUAJLyGrj+5TToo9bqFNuyXoxUD6oQwBLmg+8OuguLDUAZTWbWqadOxrNuoEZEU5ph8Ez91Tu0ifdteAU8+dj/2HUMvALJX6fJwqnrg86YTP1aRUHuEuR/6x7EEDSiY48wYdqU+g3Osj/zTYp8vuyWBRkL7JNAPsQ4kwTjqlEUY1cCkXfYrXcqufUPKvzvzP6StJlVQ/8NAxesKylewtn6T2aUjGfm6C08jUpq5T93cw18QvgLRS1TCj/JrCErKDMFYoMqHAuE4gy8fqUbcQXUZp2df2ygTcfZHmD05+PZC63dpjKwW+lWFYQGKHPTbIfNeH4MFf9ngq0aMle88GvcnOoBusDnfRXJC+FkIr5oYhHlTZrcCmJJfdcNSdXbe
X-MS-Exchange-AntiSpam-MessageData: 3hqZ9rGlHfXx84iRXpcqEzsAOJOzKejzh5ZKwfauJcdb/ZGbmcqaNoor7DYmsFPeqVz3Y+JzgJHnEKljzvwCIoWrekd9bXRSlINa2TufuDfZfOREzkOIaTDJWCscItlwiyThR+nxglTf8vgZQQjsCA==
X-MS-Exchange-CrossTenant-Network-Message-Id: f27d2771-5983-454d-9991-08d7d2414220
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2020 11:23:22.8090
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w98alL2pe3C/lXPgBgsU0qQhqRt9H28LrNi7CAMtuycursce+ucth2N6SvM9EIE/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR18MB2095
X-OriginatorOrg: suse.com
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Add two attributes 'cancel_eject' and 'auto_eject' as auxiliary features of
request_offline, which are only effective when the request_offline is set.
Writing 1 to cancel_eject will remove pending the eject event and then put
the target back to its original online state if it has been changed.
Writing a time interval to auto_eject will periodically schedule an eject
event and will trigger real hot-remove once the target is offline. You can
still keep auto_eject to 0 if the firmware or userpsace caller who raises
the eject request can re-trigger an eject event by itself.

Signed-off-by: Chester Lin <clin@suse.com>
---
 Documentation/ABI/testing/sysfs-bus-acpi | 20 ++++++
 drivers/acpi/device_sysfs.c              | 87 +++++++++++++++++++++++-
 drivers/acpi/internal.h                  |  2 +
 drivers/acpi/osl.c                       | 37 ++++++++--
 drivers/acpi/scan.c                      | 53 +++++++++++++--
 include/acpi/acpi_bus.h                  |  9 ++-
 6 files changed, 193 insertions(+), 15 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-acpi b/Documentation/ABI/testing/sysfs-bus-acpi
index b9c467704889..be00749f00e6 100644
--- a/Documentation/ABI/testing/sysfs-bus-acpi
+++ b/Documentation/ABI/testing/sysfs-bus-acpi
@@ -109,3 +109,23 @@ Description:
 		operations before the target can be ejected. This approach
 		provides flexibility while some applications could need more
 		time to release resources.
+
+What:		/sys/bus/acpi/devices/.../cancel_eject
+Date:		Mar, 2020
+Contact:	Chester Lin <clin@suse.com>
+Description:
+		(WO) Writing 1 to this attribute will cancel the pending
+		ejection when userland is working on a target's offline
+		procedure [e.g. req_offline is set]. Then it will try putting
+		the target device back to its original online state.
+
+What:		/sys/bus/acpi/devices/.../auto_eject
+Date:		Mar, 2020
+Contact:	Chester Lin <clin@suse.com>
+Description:
+		(RW) Allows the userland to periodically schedule an eject
+		event on a target until it can be successfully removed.
+		Userland can write a time interval [unit: second] to this
+		attribute, and write 0 to disable it. This feature is disabled
+		when the request_offline is 0 or no initial eject event
+		is triggered by firmware or an eject attribute in /sys.
diff --git a/drivers/acpi/device_sysfs.c b/drivers/acpi/device_sysfs.c
index 453bd1b9edf5..e40daafa3f85 100644
--- a/drivers/acpi/device_sysfs.c
+++ b/drivers/acpi/device_sysfs.c
@@ -511,7 +511,7 @@ static ssize_t request_offline_show(struct device *dev,
 {
 	struct acpi_device *acpi_dev = to_acpi_device(dev);
 
-	return sprintf(buf, "%u\n", acpi_dev->request_offline?1:0);
+	return sprintf(buf, "%u\n", acpi_dev->eject.request_offline?1:0);
 }
 
 static ssize_t request_offline_store(struct device *dev,
@@ -524,10 +524,10 @@ static ssize_t request_offline_store(struct device *dev,
 
 	switch (buf[0]) {
 	case '0':
-		acpi_dev->request_offline = false;
+		acpi_dev->eject.request_offline = false;
 		break;
 	case '1':
-		acpi_dev->request_offline = true;
+		acpi_dev->eject.request_offline = true;
 		break;
 	default:
 		return -EINVAL;
@@ -537,6 +537,74 @@ static ssize_t request_offline_store(struct device *dev,
 }
 static DEVICE_ATTR_RW(request_offline);
 
+static ssize_t auto_eject_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct acpi_device *acpi_dev = to_acpi_device(dev);
+
+	return sprintf(buf, "%u\n", acpi_dev->eject.poll_time);
+}
+
+static ssize_t auto_eject_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct acpi_device *acpi_dev = to_acpi_device(dev);
+	unsigned int time_interval;
+
+	if (!count)
+		return -EINVAL;
+
+	if (sscanf(buf, "%u\n", &time_interval) == 1)
+		acpi_dev->eject.poll_time = time_interval;
+
+	return count;
+}
+static DEVICE_ATTR_RW(auto_eject);
+
+static ssize_t
+cancel_eject_store(struct device *d, struct device_attribute *attr,
+		const char *buf, size_t count)
+{
+	struct acpi_device *acpi_device = to_acpi_device(d);
+	acpi_object_type not_used;
+	acpi_status status;
+
+	if (!count || buf[0] != '1')
+		return -EINVAL;
+
+	if ((!acpi_device->handler || !acpi_device->handler->hotplug.enabled)
+	    && !acpi_device->driver)
+		return -ENODEV;
+
+	status = acpi_get_type(acpi_device->handle, &not_used);
+	if (ACPI_FAILURE(status) || !acpi_device->flags.ejectable)
+		return -ENODEV;
+
+	if (!acpi_device->eject.in_progress)
+		return count;
+
+	acpi_device->eject.cancel = true;
+
+	if (!acpi_device->eject.poll_time) {
+		get_device(&acpi_device->dev);
+
+		status = acpi_hotplug_schedule(acpi_device,
+					       ACPI_OST_EC_OSPM_EJECT);
+		if (ACPI_SUCCESS(status))
+			return count;
+
+		put_device(&acpi_device->dev);
+
+		acpi_evaluate_ost(acpi_device->handle, ACPI_OST_EC_OSPM_EJECT,
+				  ACPI_OST_SC_NON_SPECIFIC_FAILURE, NULL);
+
+		return status == AE_NO_MEMORY ? -ENOMEM : -EAGAIN;
+	}
+
+	return count;
+}
+static DEVICE_ATTR_WO(cancel_eject);
+
 /**
  * acpi_device_setup_files - Create sysfs attributes of an ACPI device.
  * @dev: ACPI device object.
@@ -616,6 +684,17 @@ int acpi_device_setup_files(struct acpi_device *dev)
 					    &dev_attr_request_offline);
 		if (result)
 			return result;
+
+		result = device_create_file(&dev->dev,
+					    &dev_attr_auto_eject);
+		if (result)
+			return result;
+
+		result = device_create_file(&dev->dev,
+					    &dev_attr_cancel_eject);
+		if (result)
+			return result;
+
 	}
 
 	if (dev->flags.power_manageable) {
@@ -662,6 +741,8 @@ void acpi_device_remove_files(struct acpi_device *dev)
 	if (acpi_has_method(dev->handle, "_EJ0")) {
 		device_remove_file(&dev->dev, &dev_attr_eject);
 		device_remove_file(&dev->dev, &dev_attr_request_offline);
+		device_remove_file(&dev->dev, &dev_attr_auto_eject);
+		device_remove_file(&dev->dev, &dev_attr_cancel_eject);
 	}
 
 	if (acpi_has_method(dev->handle, "_SUN"))
diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
index e387517d3354..45f4ce42a044 100644
--- a/drivers/acpi/internal.h
+++ b/drivers/acpi/internal.h
@@ -81,6 +81,8 @@ static inline void acpi_lpss_init(void) {}
 void acpi_apd_init(void);
 
 acpi_status acpi_hotplug_schedule(struct acpi_device *adev, u32 src);
+acpi_status acpi_hotplug_delayed_schedule(struct acpi_device *adev,
+					  u32 src, unsigned long delay);
 bool acpi_queue_hotplug_work(struct work_struct *work);
 void acpi_device_hotplug(struct acpi_device *adev, u32 src);
 bool acpi_scan_is_offline(struct acpi_device *adev, bool uevent);
diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 762c5d50b8fe..0716c5bbff12 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -1143,33 +1143,44 @@ void acpi_os_wait_events_complete(void)
 EXPORT_SYMBOL(acpi_os_wait_events_complete);
 
 struct acpi_hp_work {
-	struct work_struct work;
+	struct delayed_work work;
 	struct acpi_device *adev;
 	u32 src;
 };
 
 static void acpi_hotplug_work_fn(struct work_struct *work)
 {
-	struct acpi_hp_work *hpw = container_of(work, struct acpi_hp_work, work);
+	struct delayed_work *delay_work;
+	struct acpi_hp_work *hpw;
+
+	delay_work = container_of(work, struct delayed_work, work);
+	hpw = container_of(delay_work, struct acpi_hp_work, work);
+
+	if (!hpw) {
+		pr_debug("Null object of ACPI hotplug work.\n");
+		return;
+	}
 
 	acpi_os_wait_events_complete();
 	acpi_device_hotplug(hpw->adev, hpw->src);
 	kfree(hpw);
 }
 
-acpi_status acpi_hotplug_schedule(struct acpi_device *adev, u32 src)
+static acpi_status acpi_hotplug_schedule_work(struct acpi_device *adev,
+	u32 src, unsigned long delay)
 {
 	struct acpi_hp_work *hpw;
 
 	ACPI_DEBUG_PRINT((ACPI_DB_EXEC,
-		  "Scheduling hotplug event (%p, %u) for deferred execution.\n",
-		  adev, src));
+	  "Scheduling hotplug event (%p, %u, %lu) for deferred execution.\n",
+	  adev, src, delay));
 
 	hpw = kmalloc(sizeof(*hpw), GFP_KERNEL);
 	if (!hpw)
 		return AE_NO_MEMORY;
 
-	INIT_WORK(&hpw->work, acpi_hotplug_work_fn);
+	INIT_DELAYED_WORK(&hpw->work, acpi_hotplug_work_fn);
+
 	hpw->adev = adev;
 	hpw->src = src;
 	/*
@@ -1178,13 +1189,25 @@ acpi_status acpi_hotplug_schedule(struct acpi_device *adev, u32 src)
 	 * invoke flush_scheduled_work()/acpi_os_wait_events_complete() to flush
 	 * these workqueues.
 	 */
-	if (!queue_work(kacpi_hotplug_wq, &hpw->work)) {
+	if (!queue_delayed_work(kacpi_hotplug_wq, &hpw->work, delay)) {
 		kfree(hpw);
 		return AE_ERROR;
 	}
+
 	return AE_OK;
 }
 
+acpi_status acpi_hotplug_schedule(struct acpi_device *adev, u32 src)
+{
+	return acpi_hotplug_schedule_work(adev, src, 0);
+}
+
+acpi_status acpi_hotplug_delayed_schedule(struct acpi_device *adev,
+					  u32 src, unsigned long delay)
+{
+	return acpi_hotplug_schedule_work(adev, src, delay);
+}
+
 bool acpi_queue_hotplug_work(struct work_struct *work)
 {
 	return queue_work(kacpi_hotplug_wq, work);
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 1cb39c5360cf..b4678ed14eed 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -169,7 +169,7 @@ static acpi_status acpi_bus_offline(acpi_handle handle, u32 lvl, void *data,
 		}
 
 		/* Don't offline directly but need to notify userland first */
-		if (device->request_offline) {
+		if (device->eject.request_offline) {
 			if (pn->dev->offline)
 				ret = 0;
 			else
@@ -209,7 +209,7 @@ static acpi_status acpi_bus_online(acpi_handle handle, u32 lvl, void *data,
 
 	list_for_each_entry(pn, &device->physical_node_list, node)
 		if (pn->put_online) {
-			if (device->request_offline)
+			if (device->eject.request_offline)
 				kobject_uevent_env(&pn->dev->kobj,
 						   KOBJ_CHANGE, envp);
 			else
@@ -269,6 +269,41 @@ static int acpi_scan_try_to_offline(struct acpi_device *device)
 	return 0;
 }
 
+static void acpi_scan_cancel_eject(struct acpi_device *device)
+{
+	acpi_handle handle = device->handle;
+
+	/* Get all nodes online again if necessary */
+	acpi_bus_online(handle, 0, NULL, NULL);
+	acpi_walk_namespace(ACPI_TYPE_ANY, handle, ACPI_UINT32_MAX,
+			    acpi_bus_online, NULL, NULL, NULL);
+
+	device->eject.in_progress = false;
+	device->eject.cancel = false;
+}
+
+static inline void acpi_set_eject_status(struct acpi_device *device)
+{
+	unsigned long delay;
+	acpi_status status;
+
+	device->eject.in_progress = true;
+
+	if (!device->eject.poll_time)
+		return;
+
+	delay = device->eject.poll_time * HZ;
+
+	get_device(&device->dev);
+	status = acpi_hotplug_delayed_schedule(device,
+				ACPI_OST_EC_OSPM_EJECT, delay);
+
+	if (ACPI_FAILURE(status)) {
+		pr_err("Failed to schedule a delayed work\n");
+		put_device(&device->dev);
+	}
+}
+
 static int acpi_scan_hot_remove(struct acpi_device *device)
 {
 	acpi_handle handle = device->handle;
@@ -277,8 +312,13 @@ static int acpi_scan_hot_remove(struct acpi_device *device)
 	bool notify_single = false;
 	int error;
 
+	if (device->eject.request_offline && device->eject.cancel) {
+		acpi_scan_cancel_eject(device);
+		return -EBUSY;
+	}
+
 	if (device->handler && device->handler->hotplug.demand_offline)
-		if (!device->request_offline)
+		if (!device->eject.request_offline)
 			notify_single = true;
 
 	if (!acpi_scan_is_offline(device, notify_single)) {
@@ -289,10 +329,15 @@ static int acpi_scan_hot_remove(struct acpi_device *device)
 		if (error)
 			return error;
 
-		if (device->request_offline)
+		if (device->eject.request_offline) {
+			acpi_set_eject_status(device);
 			return -EBUSY;
+		}
 	}
 
+	device->eject.in_progress = false;
+	device->eject.cancel = false;
+
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO,
 		"Hot-removing device %s...\n", dev_name(&device->dev)));
 
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 7a29ea0a7d0e..1fb72e399e0d 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -346,6 +346,13 @@ struct acpi_device_data {
 
 struct acpi_gpio_mapping;
 
+struct acpi_eject_status {
+	bool request_offline;
+	bool in_progress;
+	bool cancel;
+	unsigned int poll_time; /* unit: second */
+};
+
 /* Device */
 struct acpi_device {
 	int device_type;
@@ -375,7 +382,7 @@ struct acpi_device {
 	struct list_head physical_node_list;
 	struct mutex physical_node_lock;
 	void (*remove)(struct acpi_device *);
-	bool request_offline;
+	struct acpi_eject_status eject;
 };
 
 /* Non-device subnode */
-- 
2.24.0

