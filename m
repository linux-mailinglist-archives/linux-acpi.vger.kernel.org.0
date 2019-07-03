Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13F2F5E210
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Jul 2019 12:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbfGCKcI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Wed, 3 Jul 2019 06:32:08 -0400
Received: from m4a0039g.houston.softwaregrp.com ([15.124.2.85]:46365 "EHLO
        m4a0039g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725820AbfGCKcH (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 3 Jul 2019 06:32:07 -0400
X-Greylist: delayed 951 seconds by postgrey-1.27 at vger.kernel.org; Wed, 03 Jul 2019 06:32:06 EDT
Received: FROM m4a0039g.houston.softwaregrp.com (15.120.17.147) BY m4a0039g.houston.softwaregrp.com WITH ESMTP;
 Wed,  3 Jul 2019 10:28:30 +0000
Received: from M4W0335.microfocus.com (2002:f78:1193::f78:1193) by
 M4W0335.microfocus.com (2002:f78:1193::f78:1193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Wed, 3 Jul 2019 10:14:49 +0000
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (15.124.8.12) by
 M4W0335.microfocus.com (15.120.17.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Wed, 3 Jul 2019 10:14:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=testarcselector01; d=microsoft.com; cv=none;
 b=F4Knfr9X5LIEILWp54OJrdyv89aCsIi72C9QSbf35eeJ1JkMhdkld8ao9d6NstGUSKdBBgem4sCMgd3gkZKgJjQuHmzrgwGNETdUv2StfW1q/2HnWK1zZdyKYJl2jkjnTOwRpirTBcdnPS9m9yTAclo4u66ApqSp3ADzGpywppE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=testarcselector01;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ny8+gvzhQ4lumsfR2z13MxijGjvKb2LuM2J65A/A0Is=;
 b=mJarlW5oJvPuSGlG8Sr8Hd9gm+TP5s4/o2ZAhLqocg1prA5G+/JYA24qtQs2QipNm8qZuo/6ca0Mqty9v7YrLZM9fhkcBvyJsa7HmgbBgdXSRL3N1n6uS8Fpv9jLKdGrificpmNXPnv3CCzS3uENUHYsULzS5DRX4GOPLyUr49M=
ARC-Authentication-Results: i=1; test.office365.com
 1;spf=none;dmarc=none;dkim=none;arc=none
Received: from BY5PR18MB3283.namprd18.prod.outlook.com (10.255.139.203) by
 BY5PR18MB3156.namprd18.prod.outlook.com (10.255.136.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Wed, 3 Jul 2019 10:14:48 +0000
Received: from BY5PR18MB3283.namprd18.prod.outlook.com
 ([fe80::b587:8197:fcb2:bcd8]) by BY5PR18MB3283.namprd18.prod.outlook.com
 ([fe80::b587:8197:fcb2:bcd8%6]) with mapi id 15.20.2032.019; Wed, 3 Jul 2019
 10:14:48 +0000
From:   Chester Lin <chester.lin@suse.com>
To:     "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     Joey Lee <JLee@suse.com>, Michal Hocko <MHocko@suse.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Chester Lin <chester.lin@suse.com>
Subject: [PATCH v2 1/3] ACPI / hotplug: Send change events for offline/online
 requests when eject is triggered
Thread-Topic: [PATCH v2 1/3] ACPI / hotplug: Send change events for
 offline/online requests when eject is triggered
Thread-Index: AQHVMYgkYEDjLFB9BkO4mVo6aJwPIw==
Date:   Wed, 3 Jul 2019 10:14:47 +0000
Message-ID: <20190703101348.3506-2-clin@suse.com>
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
x-ms-office365-filtering-correlation-id: 63c313c2-d9c7-45c8-34c8-08d6ff9f46e3
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BY5PR18MB3156;
x-ms-traffictypediagnostic: BY5PR18MB3156:
x-microsoft-antispam-prvs: <BY5PR18MB31562C13B500FCFD1C61DDCD9EFB0@BY5PR18MB3156.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 00872B689F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(346002)(376002)(136003)(366004)(39860400002)(189003)(199004)(64756008)(478600001)(14444005)(66446008)(186003)(66556008)(73956011)(3846002)(66946007)(476003)(53936002)(26005)(11346002)(2616005)(66476007)(256004)(316002)(7736002)(1076003)(2201001)(86362001)(6116002)(50226002)(5660300002)(71190400001)(99286004)(71200400001)(76176011)(54906003)(110136005)(36756003)(107886003)(44832011)(6506007)(386003)(6512007)(2501003)(14454004)(2906002)(8936002)(68736007)(6436002)(486006)(25786009)(446003)(81156014)(305945005)(102836004)(4326008)(66066001)(81166006)(8676002)(52116002)(6486002);DIR:OUT;SFP:1102;SCL:1;SRVR:BY5PR18MB3156;H:BY5PR18MB3283.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: zYW9hkcprmGcZrL9XyCwdurZ/+Xo3R93amP4SEt3OFR7K8f3Lh/Ij6Oyht79PFEy8Xa1zjOfdEXbN6MjdDYcAzYow7AhIxczPuJav85MlOak9cZ/sZDnfA/Nt24dqlSY1+bmHBpGfIZjk7g+xDomyMsSP89TnxIfWginxj2Wf6aBgtTV2x2J29ceiLyfz/oFUGmi/cOtqZaOh5iJTHexlQ7PByocUtcsW924ev2D0Dmy43BPnFbxbL6FJ2+xLUrd7VfSxk/rUU7dZNOblJK61ah38+M+gLE7uS59I1egsJzu6I9y01Flby+rLjYRNbsJmdhzg4HJNC8+TidQkJ1dpTeoi97rxuZSeNcLbiPdqU7ollv+SvmJBoIxlhLitR4jkbwguL1Um8An5c+LWIq+FC68TqeAsbj5t/Y/SMLcmgo=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 63c313c2-d9c7-45c8-34c8-08d6ff9f46e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2019 10:14:47.9008
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

