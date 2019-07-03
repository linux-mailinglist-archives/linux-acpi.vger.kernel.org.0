Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B93D65E212
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Jul 2019 12:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725820AbfGCKcS convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Wed, 3 Jul 2019 06:32:18 -0400
Received: from m4a0039g.houston.softwaregrp.com ([15.124.2.85]:47858 "EHLO
        m4a0039g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725796AbfGCKcS (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 3 Jul 2019 06:32:18 -0400
Received: FROM m4a0039g.houston.softwaregrp.com (15.120.17.147) BY m4a0039g.houston.softwaregrp.com WITH ESMTP;
 Wed,  3 Jul 2019 10:28:40 +0000
Received: from M4W0335.microfocus.com (2002:f78:1193::f78:1193) by
 M4W0335.microfocus.com (2002:f78:1193::f78:1193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Wed, 3 Jul 2019 10:14:54 +0000
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (15.124.8.10) by
 M4W0335.microfocus.com (15.120.17.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Wed, 3 Jul 2019 10:14:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=testarcselector01; d=microsoft.com; cv=none;
 b=NYv7kCBgzjCtZmdTFRVfRgLUhyNMaxgkZVgaTZJmQQXQcSXuv4brFer7r/vKJgCUPk1crdHaDZtzXRypc/5+0BQX1lHarluJX1Fc7/xLX4TcuBew1JhIFkRW2SCsWWXVlRWjMeXIYpuaZm74LSqgHuaSVyFjGI7N1BI0K37ylsY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=testarcselector01;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mlXfEF+o/d2k3VEM5d8gA6YhDBpQdvSzpf89c0OfH8Q=;
 b=fsIfVCOzRJNW6iJYGpnvMYyozxzBwpQuTQhODj/Nf+R/fAEGsB2/HjnYR72TAsiP8ta7H3PWSPsip1FyETWfK0P87ucX7zT5C6vha51Fn7uARqaPwUgfvE+brtpKe8Ot3GsF5Wt2HP6NKlGMkzUjDhZGBLp1khRhLZ/Brt2Hd+s=
ARC-Authentication-Results: i=1; test.office365.com
 1;spf=none;dmarc=none;dkim=none;arc=none
Received: from BY5PR18MB3283.namprd18.prod.outlook.com (10.255.139.203) by
 BY5PR18MB3156.namprd18.prod.outlook.com (10.255.136.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Wed, 3 Jul 2019 10:14:53 +0000
Received: from BY5PR18MB3283.namprd18.prod.outlook.com
 ([fe80::b587:8197:fcb2:bcd8]) by BY5PR18MB3283.namprd18.prod.outlook.com
 ([fe80::b587:8197:fcb2:bcd8%6]) with mapi id 15.20.2032.019; Wed, 3 Jul 2019
 10:14:53 +0000
From:   Chester Lin <chester.lin@suse.com>
To:     "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     Joey Lee <JLee@suse.com>, Michal Hocko <MHocko@suse.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Chester Lin <chester.lin@suse.com>
Subject: [PATCH v2 2/3] ACPI / hotplug: Eject status trace and auto-remove
 approach
Thread-Topic: [PATCH v2 2/3] ACPI / hotplug: Eject status trace and
 auto-remove approach
Thread-Index: AQHVMYgn/B6wKTiqgUmL24YWyHHuVA==
Date:   Wed, 3 Jul 2019 10:14:53 +0000
Message-ID: <20190703101348.3506-3-clin@suse.com>
References: <20190703101348.3506-1-clin@suse.com>
In-Reply-To: <20190703101348.3506-1-clin@suse.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: DB7PR02CA0035.eurprd02.prod.outlook.com
 (2603:10a6:10:52::48) To BY5PR18MB3283.namprd18.prod.outlook.com
 (2603:10b6:a03:196::11)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=chester.lin@suse.com; 
x-mailer: git-send-email 2.20.1
x-originating-ip: [202.47.205.198]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 90a263bd-fe22-471a-67b1-08d6ff9f49ed
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BY5PR18MB3156;
x-ms-traffictypediagnostic: BY5PR18MB3156:
x-microsoft-antispam-prvs: <BY5PR18MB3156981CA9FD4FA9F664A8029EFB0@BY5PR18MB3156.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1417;
x-forefront-prvs: 00872B689F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(346002)(376002)(136003)(366004)(39860400002)(189003)(199004)(64756008)(478600001)(14444005)(66446008)(186003)(66556008)(73956011)(3846002)(66946007)(476003)(53936002)(26005)(11346002)(2616005)(66476007)(256004)(316002)(7736002)(1076003)(2201001)(86362001)(6116002)(30864003)(50226002)(5660300002)(71190400001)(99286004)(71200400001)(76176011)(54906003)(110136005)(36756003)(107886003)(44832011)(6506007)(386003)(6512007)(2501003)(14454004)(2906002)(8936002)(68736007)(6436002)(486006)(25786009)(446003)(81156014)(305945005)(102836004)(4326008)(66066001)(81166006)(8676002)(52116002)(6486002);DIR:OUT;SFP:1102;SCL:1;SRVR:BY5PR18MB3156;H:BY5PR18MB3283.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: YFSh3t481D2NScid0xVSdmg7OnCojdSZHhAO2jksvivuDYV/138g4U5c9HGBzjiD+kX40Es4YSGm7d81BYdB9oxVMIr9/uCF+i4nXfnWI2gCHHMmpEAxD5Ge6s5dKY3QDkbbdkwqjjsKjkQI7Ha1bFPmAyvirdxfKVOz8OCxfKcSU8kDkxB+7cSaOeAklOAKPduxSdUWOmjAMxtxM2klsjwu653x+xmGUSvjOOBzeo2KZdbbnuIHp+HukD4YQCirJZnV97QeT4PWIsF48T5W/O2EeMTwPaR33YdEKS1KJArBBbM8mF5XNl5CXz09NU7RI3QaW+xShq3SWD/eSGA7bjzMs3mOJKmWcu2R1uZEqBeL9fqaPtATR7lAZm7/C5jDkIyrUiQ73QkTV4MGw1Zt3Jznsfzhd//FdFJb9XRfFsU=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 90a263bd-fe22-471a-67b1-08d6ff9f49ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2019 10:14:53.0148
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: chester.lin@suse.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR18MB3156
X-OriginatorOrg: suse.com
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

This is an eject-status trace mechanism which helps to count current online
devices under the ejection target, and it can automatically reschedules an
eject event when all related devices are offline. The number of online
nodes can be updated when any node has been put offline successfully.
Any online event or offline failure within the whole device tree during
ejection will stop the whole process and devices who have been put offline
will need be online again as recovery.

Signed-off-by: Chester Lin <clin@suse.com>
---
 drivers/acpi/glue.c     | 146 ++++++++++++++++++++++++++++++++++++++
 drivers/acpi/internal.h |  30 ++++++++
 drivers/acpi/scan.c     | 152 +++++++++++++++++++++++++++++++++++++++-
 drivers/base/core.c     |   4 ++
 include/acpi/acpi_bus.h |   1 +
 include/linux/acpi.h    |   6 ++
 6 files changed, 336 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/glue.c b/drivers/acpi/glue.c
index 36b24b0658cb..e1c419335128 100644
--- a/drivers/acpi/glue.c
+++ b/drivers/acpi/glue.c
@@ -360,6 +360,82 @@ static int acpi_device_notify_remove(struct device *dev)
 	return 0;
 }
 
+static void acpi_device_eject_tracer(struct device *dev,
+				enum kobject_action action)
+{
+	struct acpi_device *adev = ACPI_COMPANION(dev);
+	struct acpi_device *adev_root = NULL;
+	struct eject_data *eject_node = NULL;
+	struct eject_data *eject_root = NULL;
+
+	if (!adev)
+		return;
+
+	acpi_scan_lock_acquire();
+
+	eject_node = (struct eject_data *)adev->eject_stat;
+
+	if (!eject_node)
+		goto tracer_end;
+
+	if (eject_node->base.root_handle)
+		adev_root =
+		    acpi_bus_get_acpi_device(eject_node->base.root_handle);
+
+	if (adev_root)
+		eject_root = (struct eject_data *)adev_root->eject_stat;
+
+	if (action == KOBJ_OFFLINE) {
+		eject_node->online_nodes--;
+
+		if (eject_node->online_nodes == 0)
+			eject_node->status = ACPI_EJECT_STATUS_READY_REMOVE;
+
+		/*
+		 * If the offline device is child, update its eject_root's
+		 * number of online nodes.
+		 */
+		if (eject_root) {
+			eject_root->online_nodes--;
+
+			goto tracer_end;
+		}
+		/*
+		 * Adjust number of online nodes when any physical node under
+		 * eject_root is offline. Trigger acpi_eject_try() once all
+		 * nodes are offline.
+		 */
+		if (eject_node->online_nodes == 0)
+			acpi_eject_retry(adev);
+
+	} else if (action == KOBJ_ONLINE) {
+		/* !eject_root means now eject_node is root. */
+		if (!eject_root)
+			eject_root = eject_node;
+
+		if (eject_root->status == ACPI_EJECT_STATUS_GOING_OFFLINE ||
+		    eject_root->status == ACPI_EJECT_STATUS_READY_REMOVE) {
+			eject_root->status = ACPI_EJECT_STATUS_FAIL;
+			acpi_eject_retry(adev_root);
+		}
+	}
+tracer_end:
+	if (adev_root)
+		acpi_bus_put_acpi_device(adev_root);
+
+	acpi_scan_lock_release();
+}
+
+static inline void acpi_device_check_eject_status(struct device *dev)
+{
+	acpi_device_eject_tracer(dev, KOBJ_OFFLINE);
+}
+
+static inline void acpi_device_check_eject_recover(struct device *dev)
+{
+	acpi_device_eject_tracer(dev, KOBJ_ONLINE);
+}
+
 int acpi_platform_notify(struct device *dev, enum kobject_action action)
 {
 	switch (action) {
@@ -369,8 +445,78 @@ int acpi_platform_notify(struct device *dev, enum kobject_action action)
 	case KOBJ_REMOVE:
 		acpi_device_notify_remove(dev);
 		break;
+	case KOBJ_OFFLINE:
+		acpi_device_check_eject_status(dev);
+		break;
+	case KOBJ_ONLINE:
+		acpi_device_check_eject_recover(dev);
+		break;
 	default:
 		break;
 	}
 	return 0;
 }
+
+static void acpi_device_check_offline_fail(struct device *dev)
+{
+	struct acpi_device *adev = ACPI_COMPANION(dev);
+	struct acpi_device *adev_root = NULL;
+	struct acpi_device *adev_child = NULL;
+	struct eject_data *eject_node = NULL;
+	bool has_online_child = false;
+	char *envp[] = { "EVENT=offline", NULL };
+
+	if (!adev)
+		return;
+
+	acpi_scan_lock_acquire();
+
+	eject_node = (struct eject_data *)adev->eject_stat;
+
+	if (!eject_node ||
+	    eject_node->status != ACPI_EJECT_STATUS_GOING_OFFLINE)
+		goto check_end;
+
+	if (!eject_node->retry) {
+		/* Check if the device contains any online child. */
+		list_for_each_entry(adev_child, &adev->children, node)
+			if (!acpi_scan_is_offline(adev_child)) {
+				has_online_child = true;
+				break;
+			}
+
+		if (!has_online_child)
+			eject_node->retry = true;
+
+		/* Sent change event again. */
+		kobject_uevent_env(&dev->kobj, KOBJ_CHANGE, envp);
+
+	} else {
+		/* Treat as failure if it still fails after retry. */
+		if (eject_node->base.root_handle) {
+			adev_root = acpi_bus_get_acpi_device(
+				eject_node->base.root_handle);
+
+			if (!adev_root || !adev_root->eject_stat)
+				goto check_end;
+
+			adev = adev_root;
+			eject_node = (struct eject_data *)adev_root->eject_stat;
+		}
+
+		eject_node->status = ACPI_EJECT_STATUS_FAIL;
+		acpi_eject_retry(adev);
+	}
+
+check_end:
+	if (adev_root)
+		acpi_bus_put_acpi_device(adev_root);
+
+	acpi_scan_lock_release();
+}
+
+void acpi_action_fail_notify(struct device *dev, enum kobject_action action)
+{
+	if (action == KOBJ_OFFLINE)
+		acpi_device_check_offline_fail(dev);
+}
diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
index 656d237b073d..8154690b872b 100644
--- a/drivers/acpi/internal.h
+++ b/drivers/acpi/internal.h
@@ -257,4 +257,34 @@ void acpi_init_lpit(void);
 static inline void acpi_init_lpit(void) { }
 #endif
 
+/* --------------------------------------------------------------------------
+ *				Eject Status
+ * --------------------------------------------------------------------------
+ */
+enum acpi_eject_status {
+	ACPI_EJECT_STATUS_NONE = 0,
+	ACPI_EJECT_STATUS_GOING_OFFLINE,
+	ACPI_EJECT_STATUS_READY_REMOVE,
+	ACPI_EJECT_STATUS_FAIL
+};
+
+enum acpi_eject_node_type {
+	ACPI_EJECT_CHILD_NODE = 0,
+	ACPI_EJECT_ROOT_NODE
+};
+
+struct eject_data_base {
+	enum acpi_eject_node_type type;
+	acpi_handle root_handle;
+};
+
+struct eject_data {
+	struct eject_data_base base;
+	enum acpi_eject_status status;
+	u32 online_nodes;
+	bool retry;
+};
+
+void acpi_eject_retry(struct acpi_device *adev);
+
 #endif /* _ACPI_INTERNAL_H_ */
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index d7628146eb5f..13f16b6ad7a2 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -134,11 +134,116 @@ bool acpi_scan_is_offline(struct acpi_device *adev)
 	return offline;
 }
 
+void acpi_eject_retry(struct acpi_device *adev)
+{
+	acpi_status status;
+
+	get_device(&adev->dev);
+
+	status = acpi_hotplug_schedule(adev, ACPI_OST_EC_OSPM_EJECT);
+	if (ACPI_FAILURE(status)) {
+		pr_debug("Failed to reschedule an eject event\n");
+		put_device(&adev->dev);
+		acpi_evaluate_ost(adev->handle, ACPI_OST_EC_OSPM_EJECT,
+				ACPI_OST_SC_NON_SPECIFIC_FAILURE, NULL);
+		return;
+	}
+	pr_debug("Rescheduled an eject event\n");
+}
+
+static acpi_status acpi_init_eject_stat(struct acpi_device *adev,
+					enum acpi_eject_node_type type)
+{
+	struct eject_data *eject_node = (struct eject_data *) adev->eject_stat;
+
+	if (!eject_node) {
+		eject_node = kzalloc(sizeof(*eject_node), GFP_KERNEL);
+		if (!eject_node)
+			return AE_NO_MEMORY;
+		adev->eject_stat = eject_node;
+	}
+
+	eject_node->base.type = type;
+	eject_node->online_nodes = 0;
+
+	return AE_OK;
+}
+
+static void acpi_enable_eject_stat(struct acpi_device *adev,
+				struct acpi_device *root_adev, u32 online_nodes)
+{
+	struct eject_data *eject_node = NULL;
+	struct eject_data *eject_root = NULL;
+
+	if (adev)
+		eject_node = (struct eject_data *)adev->eject_stat;
+	if (root_adev)
+		eject_root = (struct eject_data *)root_adev->eject_stat;
+
+	if (!eject_node || !eject_root) {
+		pr_debug("No eject data\n");
+		return;
+	}
+
+	if (eject_node != eject_root)
+		eject_node->base.root_handle = root_adev->handle;
+	else
+		eject_node->base.root_handle = 0;
+
+	/* Update node status and online_nodes of root device */
+	if (online_nodes) {
+		eject_root->online_nodes += online_nodes;
+
+		if (eject_node->base.root_handle)
+			eject_node->online_nodes = online_nodes;
+
+		pr_debug("Online nodes:%u, Total:%u\n",
+			 eject_node->online_nodes, eject_root->online_nodes);
+
+		eject_node->status = ACPI_EJECT_STATUS_GOING_OFFLINE;
+
+	} else {
+		eject_node->status = ACPI_EJECT_STATUS_READY_REMOVE;
+	}
+}
+
+static void acpi_free_eject_stat(struct acpi_device *adev)
+{
+	kfree(adev->eject_stat);
+	adev->eject_stat = NULL;
+}
+
+static acpi_status acpi_bus_offline_prepare(acpi_handle handle, u32 lvl,
+					void *data, void **ret_p)
+{
+	struct acpi_device *device = NULL;
+	struct eject_data_base *eject_obj = (struct eject_data_base *)data;
+	acpi_status status = AE_OK;
+
+	if (acpi_bus_get_device(handle, &device))
+		return AE_OK;
+
+	if (device->handler && !device->handler->hotplug.enabled) {
+		*ret_p = &device->dev;
+		return AE_SUPPORT;
+	}
+
+	status = acpi_init_eject_stat(device, eject_obj->type);
+	if (ACPI_FAILURE(status))
+		*ret_p = &device->dev;
+
+	return status;
+}
+
+
 static acpi_status acpi_bus_offline_notify(acpi_handle handle, u32 lvl,
 					void *data, void **ret_p)
 {
 	struct acpi_device *device = NULL;
+	struct acpi_device *root_device = NULL;
 	struct acpi_device_physical_node *pn;
+	struct eject_data_base *eject_obj = (struct eject_data_base *)data;
+	u32 online_nodes = 0;
 	char *envp[] = { "EVENT=offline", NULL };
 
 	if (acpi_bus_get_device(handle, &device))
@@ -149,13 +254,22 @@ static acpi_status acpi_bus_offline_notify(acpi_handle handle, u32 lvl,
 		return AE_SUPPORT;
 	}
 
+	if (eject_obj->root_handle == device->handle) {
+		root_device = device;
+	} else if (acpi_bus_get_device(eject_obj->root_handle, &root_device)) {
+		*ret_p = &device->dev;
+		return AE_NULL_OBJECT;
+	}
+
 	mutex_lock(&device->physical_node_lock);
 	list_for_each_entry(pn, &device->physical_node_list, node) {
 		if (device_supports_offline(pn->dev) && !(pn->dev->offline)) {
 			kobject_uevent_env(&pn->dev->kobj, KOBJ_CHANGE, envp);
+			online_nodes++;
 			pn->changed_offline = true;
 		}
 	}
+	acpi_enable_eject_stat(device, root_device, online_nodes);
 	mutex_unlock(&device->physical_node_lock);
 
 	return AE_OK;
@@ -171,6 +285,8 @@ static acpi_status acpi_bus_online_notify(acpi_handle handle, u32 lvl,
 	if (acpi_bus_get_device(handle, &device))
 		return AE_OK;
 
+	acpi_free_eject_stat(device);
+
 	mutex_lock(&device->physical_node_lock);
 
 	list_for_each_entry(pn, &device->physical_node_list, node) {
@@ -197,15 +313,23 @@ static int acpi_scan_notify_offline(struct acpi_device *device)
 {
 	acpi_handle handle = device->handle;
 	struct device *errdev = NULL;
+	struct eject_data_base base_data = {ACPI_EJECT_ROOT_NODE, handle};
 	acpi_status status;
 
+	status = acpi_bus_offline_prepare(handle, 0, (void *)&base_data,
+					(void **)&errdev);
+	if (errdev)
+		goto notify_error;
+
+	base_data.type = ACPI_EJECT_CHILD_NODE;
 	status = acpi_walk_namespace(ACPI_TYPE_ANY, handle, ACPI_UINT32_MAX,
-			NULL, acpi_bus_offline_notify,
-			NULL, (void **)&errdev);
+			acpi_bus_offline_prepare, acpi_bus_offline_notify,
+			(void *)&base_data, (void **)&errdev);
 	if (errdev)
 		goto notify_error;
 
-	status = acpi_bus_offline_notify(handle, 0, NULL,
+	base_data.type = ACPI_EJECT_ROOT_NODE;
+	status = acpi_bus_offline_notify(handle, 0, (void *)&base_data,
 				(void **)&errdev);
 
 	if (errdev)
@@ -217,6 +341,10 @@ static int acpi_scan_notify_offline(struct acpi_device *device)
 	acpi_scan_notify_online(device);
 
 	switch (status) {
+	case AE_NO_MEMORY:
+		return -ENOMEM;
+	case AE_NULL_OBJECT:
+		return -EINVAL;
 	case AE_SUPPORT:
 		dev_warn(errdev, "Offline disabled.\n");
 		return -EPERM;
@@ -229,6 +357,22 @@ static int acpi_scan_notify_offline(struct acpi_device *device)
 static int acpi_scan_offline_check(struct acpi_device *device)
 {
 	int ret = 0;
+	struct eject_data *eject_obj = (struct eject_data *) device->eject_stat;
+
+	/* Send recovery events to userland if any failure occur */
+	if (eject_obj) {
+		if (eject_obj->base.type != ACPI_EJECT_ROOT_NODE) {
+			dev_warn(&device->dev, "The node is under ejection.\n");
+			return -EBUSY;
+		}
+
+		if (eject_obj->status == ACPI_EJECT_STATUS_FAIL) {
+			dev_warn(&device->dev, "Eject failed. Recover all.\n");
+			acpi_scan_notify_online(device);
+			return -EAGAIN;
+		}
+	}
+
 	/* Send offline request to userland if the container is not offline */
 	if (!acpi_scan_is_offline(device)) {
 		ret = acpi_scan_notify_offline(device);
@@ -2060,6 +2204,8 @@ void acpi_bus_trim(struct acpi_device *adev)
 	list_for_each_entry_reverse(child, &adev->children, node)
 		acpi_bus_trim(child);
 
+	acpi_free_eject_stat(adev);
+
 	adev->flags.match_driver = false;
 	if (handler) {
 		if (handler->detach)
diff --git a/drivers/base/core.c b/drivers/base/core.c
index b4c64528f13c..2a85fbf0c666 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -2570,6 +2570,9 @@ int device_offline(struct device *dev)
 			if (!ret) {
 				kobject_uevent(&dev->kobj, KOBJ_OFFLINE);
 				dev->offline = true;
+				device_platform_notify(dev, KOBJ_OFFLINE);
+			} else {
+				acpi_action_fail_notify(dev, KOBJ_OFFLINE);
 			}
 		}
 	}
@@ -2599,6 +2602,7 @@ int device_online(struct device *dev)
 			if (!ret) {
 				kobject_uevent(&dev->kobj, KOBJ_ONLINE);
 				dev->offline = false;
+				device_platform_notify(dev, KOBJ_ONLINE);
 			}
 		} else {
 			ret = 1;
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 57e4ad0483ca..29004b3fad87 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -378,6 +378,7 @@ struct acpi_device {
 	struct list_head physical_node_list;
 	struct mutex physical_node_lock;
 	void (*remove)(struct acpi_device *);
+	void *eject_stat;
 };
 
 /* Non-device subnode */
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index d315d86844e4..91ba75914ac7 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -1321,12 +1321,18 @@ static inline int find_acpi_cpu_cache_topology(unsigned int cpu, int level)
 
 #ifdef CONFIG_ACPI
 extern int acpi_platform_notify(struct device *dev, enum kobject_action action);
+extern void acpi_action_fail_notify(struct device *dev,
+					enum kobject_action action);
 #else
 static inline int
 acpi_platform_notify(struct device *dev, enum kobject_action action)
 {
 	return 0;
 }
+static inline void
+void acpi_action_fail_notify(struct device *dev, enum kobject_action action)
+{
+}
 #endif
 
 #endif	/*_LINUX_ACPI_H*/
-- 
2.20.1

