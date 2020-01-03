Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8BB612F3DE
	for <lists+linux-acpi@lfdr.de>; Fri,  3 Jan 2020 05:45:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725890AbgACEot convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Thu, 2 Jan 2020 23:44:49 -0500
Received: from m4a0072g.houston.softwaregrp.com ([15.124.2.130]:54296 "EHLO
        m4a0072g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727183AbgACEos (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 2 Jan 2020 23:44:48 -0500
Received: FROM m4a0072g.houston.softwaregrp.com (15.120.17.146) BY m4a0072g.houston.softwaregrp.com WITH ESMTP;
 Fri,  3 Jan 2020 04:43:41 +0000
Received: from M4W0334.microfocus.com (2002:f78:1192::f78:1192) by
 M4W0334.microfocus.com (2002:f78:1192::f78:1192) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Fri, 3 Jan 2020 04:40:18 +0000
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (15.124.8.11) by
 M4W0334.microfocus.com (15.120.17.146) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Fri, 3 Jan 2020 04:40:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MgnY18nSOP1gn7UsaakRdqLSMQHR4Wt5zdISSGUIfLE+HHWGDPNXb0EAWb4FB6VH2YCbY4TzbZBTAxBEdmLCy4124CZhxDPARCtd2MQw4uxgJS6dGOA/QzUc4f+fT4dWtOxQedn3R6liijHpwIRzjSnb2BlcAI9oNkdCXNRgZBEnKxiLLUL5c3x5D0aquUVpDkudxHa6ormUTqKce4kZFW9kpcRW2RYXEC3QDzTs9tjibhkbsIXy3lDvHjEDdNz/Nj9kiOMrtZzXMqbBLOoCCc1h/PLiUhGntrsHrpzDV00ujEIf8t+tfArsr+h9WAbzZt1ak+ASkWlXZaNYKKRPVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QgIgL3eCZpwxWibsuR57EMRmxu6dbAEyUxKweM3xpiY=;
 b=O81626seqYF8rfqhwsbH9wevnpr13sAy9ZsdjQl5/AXorBks494md6yEthplyoYpVWEmvm75j5K6W6U75FNExEFrJRIDKQA4BzVpSFKJIJ9unnNt3QcCL7NSmSeFglZ+XFNT9wgIszaRVS7U6+ebyktVCDzFpH6cSI5JFydRKQNnrg9uF14w7dp/LT7jDC1V/GIHKu64UFbIYFajpA82iPAxLcIS5zOBWKrHnNEwKQGRV7r9mShQHrFxwiwwYICv2XgH1TxBwxxagIt90jt9OPNlX1A7AYReX0ZMGkYdH/qTWOHvOWh6gr4FLTeCyhv5WIN7P62a78Did1pw5vrVHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Received: from SN1PR18MB2126.namprd18.prod.outlook.com (52.132.196.157) by
 SN1PR18MB2205.namprd18.prod.outlook.com (52.132.193.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.12; Fri, 3 Jan 2020 04:40:17 +0000
Received: from SN1PR18MB2126.namprd18.prod.outlook.com
 ([fe80::68a8:34cd:7c1c:f49d]) by SN1PR18MB2126.namprd18.prod.outlook.com
 ([fe80::68a8:34cd:7c1c:f49d%3]) with mapi id 15.20.2602.012; Fri, 3 Jan 2020
 04:40:17 +0000
Received: from localhost.localdomain (60.251.47.115) by HK2P15301CA0007.APCP153.PROD.OUTLOOK.COM (2603:1096:202:1::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.1 via Frontend Transport; Fri, 3 Jan 2020 04:40:14 +0000
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
Subject: [RFC PATCH v2 3/3] ACPI / device_sysfs: Add eject_show and add a
 cancel option in eject_store
Thread-Topic: [RFC PATCH v2 3/3] ACPI / device_sysfs: Add eject_show and add a
 cancel option in eject_store
Thread-Index: AQHVwe/laTkHKyiaX0KG+ALRD+NasA==
Date:   Fri, 3 Jan 2020 04:40:17 +0000
Message-ID: <20200103043926.31507-4-clin@suse.com>
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
x-ms-office365-filtering-correlation-id: 878d4c72-9630-4b94-840e-08d790070808
x-ms-traffictypediagnostic: SN1PR18MB2205:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN1PR18MB2205FA9C02914655C74AF1C6AD230@SN1PR18MB2205.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0271483E06
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(366004)(396003)(346002)(136003)(376002)(45074003)(199004)(189003)(66556008)(66446008)(16526019)(64756008)(2616005)(8676002)(956004)(186003)(52116002)(66476007)(55236004)(36756003)(8936002)(478600001)(54906003)(81166006)(110136005)(6486002)(71200400001)(6506007)(69590400006)(107886003)(2906002)(1076003)(4326008)(5660300002)(66946007)(6512007)(26005)(316002)(86362001)(81156014);DIR:OUT;SFP:1102;SCL:1;SRVR:SN1PR18MB2205;H:SN1PR18MB2126.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: f5XXxcKAlQyHDhy9EMSHleSnHghK3Zgdc5flhPaYtbtVxXrzICbIztKoVJUgGbfmhoZXG7EbOdUNV/36KQ7BZD/ST+aaCEQb1n6VOOwysw6k3Lq25/kt3E/uTguooxDy/4ZxJFg/VvY9w+aJeSaBH8/sqTIKaSxfbdewTURqXrnqirer9o3nWD+u8yEcHonpaNZas5VyQ/e3vZvW0sFLZ3UsQL2zmLKk0LJfyZP/KtqAEMx3WHrijkZjLzjK/1qr/hWe9aXt9EZHAudP6+AB/9udlAiuRzIAxbNbJYC49L7SmIZ97ndOHbHod9n3o7oycy762yZry3MYvPayW4cLNrBa8AKzv9gcJi6EJydi9qoTJ/M4o8qUXXyOmNzx2Jir8RPW/aCSyq+4fsKpieznCYFBN1EtiQlM9yIaPMCyGoYerIdJ6Z5j9YXBhOYMY4yo7FggTAN7nJAIcxfszjY2XrmdLCRVOAUqtpVDGZayCFkJVUOPRK7mrax7hzkXnKof3EL7PEPPTIHjuX2HxKKwMQ==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 878d4c72-9630-4b94-840e-08d790070808
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2020 04:40:17.2050
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y1NkA8hfGHVNgw3ejeDDUwx8D/pRZyK3zCqV1BT7y4KG6pdTjxlkNDR1kgvianH1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR18MB2205
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

