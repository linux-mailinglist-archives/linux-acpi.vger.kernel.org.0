Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0685E216
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Jul 2019 12:33:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbfGCKdR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Wed, 3 Jul 2019 06:33:17 -0400
Received: from m4a0039g.houston.softwaregrp.com ([15.124.2.85]:49191 "EHLO
        m4a0039g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725796AbfGCKdR (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 3 Jul 2019 06:33:17 -0400
Received: FROM m4a0039g.houston.softwaregrp.com (15.120.17.147) BY m4a0039g.houston.softwaregrp.com WITH ESMTP;
 Wed,  3 Jul 2019 10:29:39 +0000
Received: from M4W0335.microfocus.com (2002:f78:1193::f78:1193) by
 M4W0335.microfocus.com (2002:f78:1193::f78:1193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Wed, 3 Jul 2019 10:14:59 +0000
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (15.124.8.10) by
 M4W0335.microfocus.com (15.120.17.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Wed, 3 Jul 2019 10:14:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=testarcselector01; d=microsoft.com; cv=none;
 b=ikfVbU99kIjiU/eVJZax7bG9eV3dqhliO0G/8JUNDiADzW8/1IcLwiqejNADEJ/9TgQpENCD83p+FxiMtounAsWHuaLj5OQ5Cu12aByRIYsb0czM8tv2MCdyWNoDI6wLghGJAY63ZofK5FwSFyccWygpotIwNUj19HW4yiELMgI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=testarcselector01;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QgIgL3eCZpwxWibsuR57EMRmxu6dbAEyUxKweM3xpiY=;
 b=RcBkD09vixZP+Q8lMrutg7R7J/vtS4+rqJTv4svEJYf1KavUX20EDMalklYcctL7iYQeVKczJpJfaHleMHgvGQm7+KFKSPKB0Y7VYA5SNT/Gy8rj8VhaQ8oSWMvgIeqHkk/T0bzmapcpYq38azh2TycG4jkm/7laW2dNzlj9NrE=
ARC-Authentication-Results: i=1; test.office365.com
 1;spf=none;dmarc=none;dkim=none;arc=none
Received: from BY5PR18MB3283.namprd18.prod.outlook.com (10.255.139.203) by
 BY5PR18MB3156.namprd18.prod.outlook.com (10.255.136.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Wed, 3 Jul 2019 10:14:58 +0000
Received: from BY5PR18MB3283.namprd18.prod.outlook.com
 ([fe80::b587:8197:fcb2:bcd8]) by BY5PR18MB3283.namprd18.prod.outlook.com
 ([fe80::b587:8197:fcb2:bcd8%6]) with mapi id 15.20.2032.019; Wed, 3 Jul 2019
 10:14:58 +0000
From:   Chester Lin <chester.lin@suse.com>
To:     "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     Joey Lee <JLee@suse.com>, Michal Hocko <MHocko@suse.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Chester Lin <chester.lin@suse.com>
Subject: [PATCH v2 3/3] ACPI / device_sysfs: Add eject_show and add a cancel
 option in eject_store
Thread-Topic: [PATCH v2 3/3] ACPI / device_sysfs: Add eject_show and add a
 cancel option in eject_store
Thread-Index: AQHVMYgqioq4FwssCEqt326bf5D2bw==
Date:   Wed, 3 Jul 2019 10:14:58 +0000
Message-ID: <20190703101348.3506-4-clin@suse.com>
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
x-ms-office365-filtering-correlation-id: 859e96ee-02c7-41ec-a6c8-08d6ff9f4d03
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BY5PR18MB3156;
x-ms-traffictypediagnostic: BY5PR18MB3156:
x-microsoft-antispam-prvs: <BY5PR18MB3156CA401E6ACBFDD14518CD9EFB0@BY5PR18MB3156.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 00872B689F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(346002)(376002)(136003)(366004)(39860400002)(45074003)(189003)(199004)(64756008)(478600001)(14444005)(66446008)(186003)(66556008)(73956011)(3846002)(66946007)(476003)(53936002)(26005)(11346002)(2616005)(66476007)(256004)(316002)(7736002)(1076003)(2201001)(86362001)(6116002)(50226002)(5660300002)(71190400001)(99286004)(71200400001)(76176011)(54906003)(110136005)(36756003)(107886003)(44832011)(6506007)(386003)(6512007)(2501003)(14454004)(2906002)(8936002)(68736007)(6436002)(486006)(25786009)(446003)(81156014)(305945005)(102836004)(4326008)(66066001)(81166006)(8676002)(52116002)(6486002);DIR:OUT;SFP:1102;SCL:1;SRVR:BY5PR18MB3156;H:BY5PR18MB3283.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 99/ua12/Nn456QLtXx9tPEz+LU8+pG8DTxQEorrgJGwbljlEquRyUkFHUobusu6np0ZcmeQsXXbx//xSH+DXNOjrlsqA+8eo+VTjvWSu1BGh3Fne3OUXW8pMxEr9CkQOMcBYuxtVUnn6ir2YQ8O6JSwlrmqLtp0231nQyj1VlzusNsNIRVgKD13MQWQ/Ab8CDar4k3XRyD+lSCkeLIFPUK2Kw1bzwYtoNZG+bQBAcHd00f3AYxL/BGNY2XGRVVXLdFaOvkjv7uFDKm1B1Xu19jqoipsSRGoomj45V6amYrHHnqtbLNuFDVYKgQL9PNYksEfDV6HkUtfWzBJmhBjEDit+s4PiKdyIM71Za97A+cibAQdNwrQmniGaZe7aAACyjX6kTz0qt9f+thOLWt+AGskAp18nHA+PawQ3OZssexU=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 859e96ee-02c7-41ec-a6c8-08d6ff9f4d03
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2019 10:14:58.1358
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

Add an eject_show attribute for users to monitor current status because
sometimes it could take time to finish an ejection so we need to know
whether it is still in progress or not. For userspace who might need to
cancel an onging ejection, we also offer an option in eject_store.

Signed-off-by: Chester Lin <clin@suse.com>
---
 Documentation/ABI/testing/sysfs-bus-acpi |  9 ++-
 drivers/acpi/device_sysfs.c              | 94 +++++++++++++++++++++---
 drivers/acpi/internal.h                  |  4 +-
 drivers/acpi/scan.c                      | 38 +++++++++-
 4 files changed, 129 insertions(+), 16 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-acpi b/Documentation/ABI/testing/sysfs-bus-acpi
index e7898cfe5fb1..32fdf4af962e 100644
--- a/Documentation/ABI/testing/sysfs-bus-acpi
+++ b/Documentation/ABI/testing/sysfs-bus-acpi
@@ -53,9 +53,12 @@ What:		/sys/bus/acpi/devices/.../eject
 Date:		December 2006
 Contact:	Rafael J. Wysocki <rjw@rjwysocki.net>
 Description:
-		Writing 1 to this attribute will trigger hot removal of
-		this device object.  This file exists for every device
-		object that has _EJ0 method.
+		(R) Allows users to read eject status of the device object.
+		(W) Writing 1 to this attribute will trigger hot removal of
+		this device object. Writing 2 to this attribute will cancel hot
+		removal work if it's still in offline process and the original
+		state of this device object will be recovered. This file exists
+		for every device object that has _EJ0 method.
 
 What:		/sys/bus/acpi/devices/.../status
 Date:		Jan, 2014
diff --git a/drivers/acpi/device_sysfs.c b/drivers/acpi/device_sysfs.c
index 96869f1538b9..6801b268fe9d 100644
--- a/drivers/acpi/device_sysfs.c
+++ b/drivers/acpi/device_sysfs.c
@@ -365,17 +365,13 @@ static ssize_t power_state_show(struct device *dev,
 
 static DEVICE_ATTR_RO(power_state);
 
-static ssize_t
-acpi_eject_store(struct device *d, struct device_attribute *attr,
-		const char *buf, size_t count)
+static ssize_t eject_show(struct device *d,
+				struct device_attribute *attr, char *buf)
 {
 	struct acpi_device *acpi_device = to_acpi_device(d);
 	acpi_object_type not_used;
 	acpi_status status;
 
-	if (!count || buf[0] != '1')
-		return -EINVAL;
-
 	if ((!acpi_device->handler || !acpi_device->handler->hotplug.enabled)
 	    && !acpi_device->driver)
 		return -ENODEV;
@@ -384,18 +380,96 @@ acpi_eject_store(struct device *d, struct device_attribute *attr,
 	if (ACPI_FAILURE(status) || !acpi_device->flags.ejectable)
 		return -ENODEV;
 
+	return sprintf(buf, "%s\n", acpi_eject_status_string(acpi_device));
+}
+
+static ssize_t
+eject_store(struct device *d, struct device_attribute *attr,
+		const char *buf, size_t count)
+{
+	struct acpi_device *acpi_device = to_acpi_device(d);
+	struct eject_data *eject_node = NULL;
+	acpi_object_type not_used;
+	acpi_status status;
+	bool cancel_eject = false;
+	ssize_t ret;
+
+	if (!count)
+		return -EINVAL;
+
+	switch (buf[0]) {
+	case '1':
+		break;
+	case '2':
+		acpi_scan_lock_acquire();
+		eject_node = (struct eject_data *)acpi_device->eject_stat;
+
+		if (!eject_node) {
+			acpi_scan_lock_release();
+			ret = -EINVAL;
+			goto eject_end;
+		}
+
+		/*
+		 * Find a root to start cancellation from the top
+		 */
+		if (eject_node->base.root_handle) {
+			acpi_device = acpi_bus_get_acpi_device(
+					eject_node->base.root_handle);
+
+			if (acpi_device)
+				eject_node =
+				   (struct eject_data *)acpi_device->eject_stat;
+			else
+				eject_node = NULL;
+
+		}
+
+		if (eject_node &&
+		   (eject_node->status == ACPI_EJECT_STATUS_GOING_OFFLINE ||
+		    eject_node->status == ACPI_EJECT_STATUS_READY_REMOVE)) {
+			eject_node->status = ACPI_EJECT_STATUS_CANCEL;
+			cancel_eject = true;
+		}
+
+		acpi_scan_lock_release();
+		if (cancel_eject)
+			break;
+	default:
+		ret = -EINVAL;
+		goto eject_end;
+	};
+
+	if ((!acpi_device->handler || !acpi_device->handler->hotplug.enabled)
+	    && !acpi_device->driver) {
+		ret = -ENODEV;
+		goto eject_end;
+	}
+
+	status = acpi_get_type(acpi_device->handle, &not_used);
+	if (ACPI_FAILURE(status) || !acpi_device->flags.ejectable) {
+		ret = -ENODEV;
+		goto eject_end;
+	}
+
 	get_device(&acpi_device->dev);
 	status = acpi_hotplug_schedule(acpi_device, ACPI_OST_EC_OSPM_EJECT);
-	if (ACPI_SUCCESS(status))
-		return count;
+	if (ACPI_SUCCESS(status)) {
+		ret = count;
+		goto eject_end;
+	}
 
 	put_device(&acpi_device->dev);
 	acpi_evaluate_ost(acpi_device->handle, ACPI_OST_EC_OSPM_EJECT,
 			  ACPI_OST_SC_NON_SPECIFIC_FAILURE, NULL);
-	return status == AE_NO_MEMORY ? -ENOMEM : -EAGAIN;
+	ret = (status == AE_NO_MEMORY) ? -ENOMEM : -EAGAIN;
+
+eject_end:
+	return ret;
+
 }
 
-static DEVICE_ATTR(eject, 0200, NULL, acpi_eject_store);
+static DEVICE_ATTR_RW(eject);
 
 static ssize_t
 acpi_device_hid_show(struct device *dev, struct device_attribute *attr, char *buf)
diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
index 8154690b872b..e5d526402188 100644
--- a/drivers/acpi/internal.h
+++ b/drivers/acpi/internal.h
@@ -265,7 +265,8 @@ enum acpi_eject_status {
 	ACPI_EJECT_STATUS_NONE = 0,
 	ACPI_EJECT_STATUS_GOING_OFFLINE,
 	ACPI_EJECT_STATUS_READY_REMOVE,
-	ACPI_EJECT_STATUS_FAIL
+	ACPI_EJECT_STATUS_FAIL,
+	ACPI_EJECT_STATUS_CANCEL
 };
 
 enum acpi_eject_node_type {
@@ -286,5 +287,6 @@ struct eject_data {
 };
 
 void acpi_eject_retry(struct acpi_device *adev);
+char *acpi_eject_status_string(struct acpi_device *adev);
 
 #endif /* _ACPI_INTERNAL_H_ */
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 13f16b6ad7a2..90983c067410 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -366,8 +366,9 @@ static int acpi_scan_offline_check(struct acpi_device *device)
 			return -EBUSY;
 		}
 
-		if (eject_obj->status == ACPI_EJECT_STATUS_FAIL) {
-			dev_warn(&device->dev, "Eject failed. Recover all.\n");
+		if (eject_obj->status == ACPI_EJECT_STATUS_FAIL ||
+		    eject_obj->status == ACPI_EJECT_STATUS_CANCEL) {
+			dev_warn(&device->dev, "Eject stopped. Recover all.\n");
 			acpi_scan_notify_online(device);
 			return -EAGAIN;
 		}
@@ -383,6 +384,39 @@ static int acpi_scan_offline_check(struct acpi_device *device)
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
+		case ACPI_EJECT_STATUS_READY_REMOVE:
+			status_string = "ready to remove";
+			break;
+		case ACPI_EJECT_STATUS_FAIL:
+			status_string = "failure";
+			break;
+		case ACPI_EJECT_STATUS_CANCEL:
+			status_string = "cancel";
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

