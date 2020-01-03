Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB7012F3EE
	for <lists+linux-acpi@lfdr.de>; Fri,  3 Jan 2020 05:55:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725972AbgACEzx convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Thu, 2 Jan 2020 23:55:53 -0500
Received: from m4a0072g.houston.softwaregrp.com ([15.124.2.130]:52085 "EHLO
        m4a0072g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725890AbgACEzx (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 2 Jan 2020 23:55:53 -0500
Received: FROM m4a0072g.houston.softwaregrp.com (15.120.17.147) BY m4a0072g.houston.softwaregrp.com WITH ESMTP;
 Fri,  3 Jan 2020 04:54:45 +0000
Received: from M4W0334.microfocus.com (2002:f78:1192::f78:1192) by
 M4W0335.microfocus.com (2002:f78:1193::f78:1193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Fri, 3 Jan 2020 04:40:10 +0000
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (15.124.8.13) by
 M4W0334.microfocus.com (15.120.17.146) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Fri, 3 Jan 2020 04:40:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=grkpgnK7R3Dfn2RhbDKW7Lwbi9uU3s9d1rfMGF6uDWhnucYSsbmeSw/n9teoniXP/AYJWJM50LK0Sju4wkIgqmowmKQtPCVj2lUlvUNMYHt/XI0Y1JULzEbnDW9kuGDbc1BVrk/i9UHRNtn6eZbFgdVO8qd9s1LP/FNSGCzlcMtb5m1+iYs1g/RkkPc+woPpKuSsvH1cmCzldrbgR1DWBNRXq7ZqR9CKlddzOXKBVN6mptkDua9c9YxPEgfLGH3N0iddZVc52DW2u617KdUnkyQJVuih0QRR6qtgSLOkQRd7Ugnviy4FqnxAnSf2hvJEUEnkyC/Dvi/sV7XsI6SMmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ny8+gvzhQ4lumsfR2z13MxijGjvKb2LuM2J65A/A0Is=;
 b=au94aa805zfgjf1naXDhBfS0VISionoM8E5VSe8vVD3BQjkdwZQeaRGeQk2Fp9szCVpQk15+nokrQcioRltb+xDnT1fyrArQ4jqk4J02K/AKGo7Dmj655G6VX3Qj6p5vFg6t92nc73w1UWKVESyLe0Cyj7ybYB7njtyPR2xjzKnnrlLS25OR7VaZS3MfiPguQPi3iFBiEZ319Io5SkwrPpQ+J2DLFhlhfqaz7USOseOynrqkLWt9lfVKLRXdrDG02Z5ecfJaGBdjIo98h7S3aCY4VrdokaXeZIwfhO+h4uITVdorpnuGyzgdiRdiXrwVQUXx3+B3YUtB1StKR+bNzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Received: from SN1PR18MB2126.namprd18.prod.outlook.com (52.132.196.157) by
 SN1PR18MB2205.namprd18.prod.outlook.com (52.132.193.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.12; Fri, 3 Jan 2020 04:40:09 +0000
Received: from SN1PR18MB2126.namprd18.prod.outlook.com
 ([fe80::68a8:34cd:7c1c:f49d]) by SN1PR18MB2126.namprd18.prod.outlook.com
 ([fe80::68a8:34cd:7c1c:f49d%3]) with mapi id 15.20.2602.012; Fri, 3 Jan 2020
 04:40:09 +0000
Received: from localhost.localdomain (60.251.47.115) by HK2P15301CA0007.APCP153.PROD.OUTLOOK.COM (2603:1096:202:1::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.1 via Frontend Transport; Fri, 3 Jan 2020 04:40:06 +0000
From:   Chester Lin <clin@suse.com>
To:     "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "robert.moore@intel.com" <robert.moore@intel.com>,
        "erik.schmauss@intel.com" <erik.schmauss@intel.com>
CC:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Joey Lee <JLee@suse.com>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        Chester Lin <clin@suse.com>
Subject: [RFC PATCH v2 1/3] ACPI / hotplug: Send change events for
 offline/online requests when eject is triggered
Thread-Topic: [RFC PATCH v2 1/3] ACPI / hotplug: Send change events for
 offline/online requests when eject is triggered
Thread-Index: AQHVwe/hAOkY07ZXREeHshC+epqLLA==
Date:   Fri, 3 Jan 2020 04:40:09 +0000
Message-ID: <20200103043926.31507-2-clin@suse.com>
References: <20200103043926.31507-1-clin@suse.com>
In-Reply-To: <20200103043926.31507-1-clin@suse.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK2P15301CA0007.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::17) To SN1PR18MB2126.namprd18.prod.outlook.com
 (2603:10b6:802:29::29)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=clin@suse.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.24.0
x-originating-ip: [60.251.47.115]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 017314d0-8049-4792-356a-08d79007036f
x-ms-traffictypediagnostic: SN1PR18MB2205:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN1PR18MB22059C7E3126B8EB1C7B4F61AD230@SN1PR18MB2205.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0271483E06
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(366004)(396003)(346002)(136003)(376002)(199004)(189003)(66556008)(66446008)(16526019)(64756008)(2616005)(8676002)(956004)(186003)(52116002)(66476007)(55236004)(36756003)(8936002)(478600001)(54906003)(81166006)(110136005)(6486002)(71200400001)(6506007)(69590400006)(107886003)(2906002)(1076003)(4326008)(5660300002)(66946007)(6512007)(26005)(316002)(86362001)(81156014);DIR:OUT;SFP:1102;SCL:1;SRVR:SN1PR18MB2205;H:SN1PR18MB2126.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4+MpW7B2hy99ecvkRPF20Fo86XhUCK0l0bnFPg8MKQOOsRJ2KjWTVI6c0kOMddPXG895NCrnqdlvqcgHR+OmUE9fwCNviHNpf0UANmYGRyVc0hhU+gPf0YCtbaK6PzlnKu+R8SfrWJQfA7M4agGvxopXpmW/OJ0p8d244/ryC0jLAlPCANH49zWFrrMB4vaq3cxFLr8oOl6vZ5lBQruaLbH0NCqSOiRRyTzUaBn30xz16yDYDnKkFJhZarcj9uuXOPAUSeLr743TXYOyzpqenGQYYQ724MDE0tui0jVatpJsRtdV3M6uK86p+fU4MOdgdF42WXNQUrQHpTa1MZUPBtct6NTdwdj99lEbBoOYNjQOanUehTtdHip7iOe4PZ1WIF8N5Su0MwCYnYrw+anmqU18zBgLCb17n4GiywFTOlX3xTKQT4S65/rwb4hrEZNMx6kOuvKWe0NQxKL5rXmeBrDSW0LtYlAfs3vA0khbNPUqYqwG5rUA8FI3rd1pIRMn
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 017314d0-8049-4792-356a-08d79007036f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2020 04:40:09.4894
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PYJhqgKWENHEA6ueIO8uf6TLcFNd+6N9URy30qhf3RUzrJOZua6JHDlMuIE4QV2A
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR18MB2205
X-OriginatorOrg: suse.com
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Here we change offline/online handling in device hotplug by sending change
events to userland as notification so that userland can have control and
determine when will be a good time to put them offline/online based on
current workload. In this approach the real offline/online opertions are
handed over to userland so that userland can have more time to prepare
before any device change actually happens.

All child devices under the ejection target are traversed and notified
hierarchically based on ACPI namespace in ascending order when an eject
event happens.

Signed-off-by: Chester Lin <clin@suse.com>
---
 drivers/acpi/container.c |   2 +-
 drivers/acpi/internal.h  |   2 +-
 drivers/acpi/scan.c      | 140 +++++++++++++++++----------------------
 include/acpi/acpi_bus.h  |   2 +-
 4 files changed, 65 insertions(+), 81 deletions(-)

diff --git a/drivers/acpi/container.c b/drivers/acpi/container.c
index 9ea5f55d97e3..53ca9b1ae1bf 100644
--- a/drivers/acpi/container.c
+++ b/drivers/acpi/container.c
@@ -33,7 +33,7 @@ static int acpi_container_offline(struct container_dev *cdev)
 
 	/* Check all of the dependent devices' physical companions. */
 	list_for_each_entry(child, &adev->children, node)
-		if (!acpi_scan_is_offline(child, false))
+		if (!acpi_scan_is_offline(child))
 			return -EBUSY;
 
 	return 0;
diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
index f6157d4d637a..656d237b073d 100644
--- a/drivers/acpi/internal.h
+++ b/drivers/acpi/internal.h
@@ -83,7 +83,7 @@ void acpi_apd_init(void);
 acpi_status acpi_hotplug_schedule(struct acpi_device *adev, u32 src);
 bool acpi_queue_hotplug_work(struct work_struct *work);
 void acpi_device_hotplug(struct acpi_device *adev, u32 src);
-bool acpi_scan_is_offline(struct acpi_device *adev, bool uevent);
+bool acpi_scan_is_offline(struct acpi_device *adev);
 
 acpi_status acpi_sysfs_table_handler(u32 event, void *table, void *context);
 void acpi_scan_table_handler(u32 event, void *table, void *context);
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 0e28270b0fd8..d7628146eb5f 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -113,11 +113,10 @@ int acpi_scan_add_handler_with_hotplug(struct acpi_scan_handler *handler,
 	return 0;
 }
 
-bool acpi_scan_is_offline(struct acpi_device *adev, bool uevent)
+bool acpi_scan_is_offline(struct acpi_device *adev)
 {
 	struct acpi_device_physical_node *pn;
 	bool offline = true;
-	char *envp[] = { "EVENT=offline", NULL };
 
 	/*
 	 * acpi_container_offline() calls this for all of the container's
@@ -127,9 +126,6 @@ bool acpi_scan_is_offline(struct acpi_device *adev, bool uevent)
 
 	list_for_each_entry(pn, &adev->physical_node_list, node)
 		if (device_supports_offline(pn->dev) && !pn->dev->offline) {
-			if (uevent)
-				kobject_uevent_env(&pn->dev->kobj, KOBJ_CHANGE, envp);
-
 			offline = false;
 			break;
 		}
@@ -138,13 +134,12 @@ bool acpi_scan_is_offline(struct acpi_device *adev, bool uevent)
 	return offline;
 }
 
-static acpi_status acpi_bus_offline(acpi_handle handle, u32 lvl, void *data,
-				    void **ret_p)
+static acpi_status acpi_bus_offline_notify(acpi_handle handle, u32 lvl,
+					void *data, void **ret_p)
 {
 	struct acpi_device *device = NULL;
 	struct acpi_device_physical_node *pn;
-	bool second_pass = (bool)data;
-	acpi_status status = AE_OK;
+	char *envp[] = { "EVENT=offline", NULL };
 
 	if (acpi_bus_get_device(handle, &device))
 		return AE_OK;
@@ -155,100 +150,93 @@ static acpi_status acpi_bus_offline(acpi_handle handle, u32 lvl, void *data,
 	}
 
 	mutex_lock(&device->physical_node_lock);
-
 	list_for_each_entry(pn, &device->physical_node_list, node) {
-		int ret;
-
-		if (second_pass) {
-			/* Skip devices offlined by the first pass. */
-			if (pn->put_online)
-				continue;
-		} else {
-			pn->put_online = false;
-		}
-		ret = device_offline(pn->dev);
-		if (ret >= 0) {
-			pn->put_online = !ret;
-		} else {
-			*ret_p = pn->dev;
-			if (second_pass) {
-				status = AE_ERROR;
-				break;
-			}
+		if (device_supports_offline(pn->dev) && !(pn->dev->offline)) {
+			kobject_uevent_env(&pn->dev->kobj, KOBJ_CHANGE, envp);
+			pn->changed_offline = true;
 		}
 	}
-
 	mutex_unlock(&device->physical_node_lock);
 
-	return status;
+	return AE_OK;
 }
 
-static acpi_status acpi_bus_online(acpi_handle handle, u32 lvl, void *data,
-				   void **ret_p)
+static acpi_status acpi_bus_online_notify(acpi_handle handle, u32 lvl,
+						void *data, void **ret_p)
 {
 	struct acpi_device *device = NULL;
 	struct acpi_device_physical_node *pn;
+	char *envp[] = { "EVENT=online", NULL };
 
 	if (acpi_bus_get_device(handle, &device))
 		return AE_OK;
 
 	mutex_lock(&device->physical_node_lock);
 
-	list_for_each_entry(pn, &device->physical_node_list, node)
-		if (pn->put_online) {
-			device_online(pn->dev);
-			pn->put_online = false;
+	list_for_each_entry(pn, &device->physical_node_list, node) {
+		if (pn->changed_offline) {
+			kobject_uevent_env(&pn->dev->kobj, KOBJ_CHANGE, envp);
+			pn->changed_offline = false;
 		}
+	}
 
 	mutex_unlock(&device->physical_node_lock);
-
 	return AE_OK;
 }
 
-static int acpi_scan_try_to_offline(struct acpi_device *device)
+static void acpi_scan_notify_online(struct acpi_device *device)
+{
+	acpi_handle handle = device->handle;
+
+	acpi_bus_online_notify(handle, 0, NULL, NULL);
+	acpi_walk_namespace(ACPI_TYPE_ANY, handle, ACPI_UINT32_MAX,
+				acpi_bus_online_notify, NULL, NULL, NULL);
+}
+
+static int acpi_scan_notify_offline(struct acpi_device *device)
 {
 	acpi_handle handle = device->handle;
 	struct device *errdev = NULL;
 	acpi_status status;
 
-	/*
-	 * Carry out two passes here and ignore errors in the first pass,
-	 * because if the devices in question are memory blocks and
-	 * CONFIG_MEMCG is set, one of the blocks may hold data structures
-	 * that the other blocks depend on, but it is not known in advance which
-	 * block holds them.
-	 *
-	 * If the first pass is successful, the second one isn't needed, though.
-	 */
 	status = acpi_walk_namespace(ACPI_TYPE_ANY, handle, ACPI_UINT32_MAX,
-				     NULL, acpi_bus_offline, (void *)false,
-				     (void **)&errdev);
-	if (status == AE_SUPPORT) {
+			NULL, acpi_bus_offline_notify,
+			NULL, (void **)&errdev);
+	if (errdev)
+		goto notify_error;
+
+	status = acpi_bus_offline_notify(handle, 0, NULL,
+				(void **)&errdev);
+
+	if (errdev)
+		goto notify_error;
+
+	return 0;
+
+notify_error:
+	acpi_scan_notify_online(device);
+
+	switch (status) {
+	case AE_SUPPORT:
 		dev_warn(errdev, "Offline disabled.\n");
-		acpi_walk_namespace(ACPI_TYPE_ANY, handle, ACPI_UINT32_MAX,
-				    acpi_bus_online, NULL, NULL, NULL);
 		return -EPERM;
+	default:
+		dev_warn(errdev, "Offline failed. (status:%#x)\n", status);
+		return -EBUSY;
 	}
-	acpi_bus_offline(handle, 0, (void *)false, (void **)&errdev);
-	if (errdev) {
-		errdev = NULL;
-		acpi_walk_namespace(ACPI_TYPE_ANY, handle, ACPI_UINT32_MAX,
-				    NULL, acpi_bus_offline, (void *)true,
-				    (void **)&errdev);
-		if (!errdev)
-			acpi_bus_offline(handle, 0, (void *)true,
-					 (void **)&errdev);
-
-		if (errdev) {
-			dev_warn(errdev, "Offline failed.\n");
-			acpi_bus_online(handle, 0, NULL, NULL);
-			acpi_walk_namespace(ACPI_TYPE_ANY, handle,
-					    ACPI_UINT32_MAX, acpi_bus_online,
-					    NULL, NULL, NULL);
+}
+
+static int acpi_scan_offline_check(struct acpi_device *device)
+{
+	int ret = 0;
+	/* Send offline request to userland if the container is not offline */
+	if (!acpi_scan_is_offline(device)) {
+		ret = acpi_scan_notify_offline(device);
+		if (!ret)
 			return -EBUSY;
-		}
 	}
-	return 0;
+
+	return ret;
 }
 
 static int acpi_scan_hot_remove(struct acpi_device *device)
@@ -256,15 +244,11 @@ static int acpi_scan_hot_remove(struct acpi_device *device)
 	acpi_handle handle = device->handle;
 	unsigned long long sta;
 	acpi_status status;
+	int ret;
 
-	if (device->handler && device->handler->hotplug.demand_offline) {
-		if (!acpi_scan_is_offline(device, true))
-			return -EBUSY;
-	} else {
-		int error = acpi_scan_try_to_offline(device);
-		if (error)
-			return error;
-	}
+	ret = acpi_scan_offline_check(device);
+	if (ret)
+		return ret;
 
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO,
 		"Hot-removing device %s...\n", dev_name(&device->dev)));
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 4752ff0a9d9b..57e4ad0483ca 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -330,7 +330,7 @@ struct acpi_device_physical_node {
 	unsigned int node_id;
 	struct list_head node;
 	struct device *dev;
-	bool put_online:1;
+	bool changed_offline:1;
 };
 
 struct acpi_device_properties {
-- 
2.20.1

