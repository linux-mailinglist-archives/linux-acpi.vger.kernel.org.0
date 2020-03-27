Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62C7719564E
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Mar 2020 12:25:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbgC0LZb convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Fri, 27 Mar 2020 07:25:31 -0400
Received: from m9a0013g.houston.softwaregrp.com ([15.124.64.91]:46818 "EHLO
        m9a0013g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726515AbgC0LZb (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 27 Mar 2020 07:25:31 -0400
Received: FROM m9a0013g.houston.softwaregrp.com (15.121.0.190) BY m9a0013g.houston.softwaregrp.com WITH ESMTP;
 Fri, 27 Mar 2020 11:24:36 +0000
Received: from M4W0334.microfocus.com (2002:f78:1192::f78:1192) by
 M9W0067.microfocus.com (2002:f79:be::f79:be) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Fri, 27 Mar 2020 11:23:29 +0000
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (15.124.8.13) by
 M4W0334.microfocus.com (15.120.17.146) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Fri, 27 Mar 2020 11:23:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FGD13t8dd2JrREGoVBHtNhtgcrypKI8WOLwGa1JkCNhuRWrjfaG57xbeRvBywiny5j4pDLVIJdfVAdTWHTdNAGCMVVOBWlvzsbHeVQznk30RIEwYKP115ENP48Y5Hw7dHjNEKYFaOLEFDzEuYDFlgQSD6NabkYM8h/oWNUN0vQhq8W5vHX5rt1oOlNwk2LOA1kHZ490Lj06WyFDEkjgnlzitCn801qXUoVSdxPD1U8XM//E/wJVw/VBFPc2pmblW4H9qwyjMM2F9drP8cnDZWkyRgXcTQeRkiTS86HZ6FWKqNY3AzVnMlSEuaU3jNiepZrzdPhYdZ3UcSddnvUH1Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ClHvdxppNKa4LOYTupncdHfy1rov4e5BDsTA92U6mfo=;
 b=m6MikbGtt17Q2WNyVrX53Q3gDX1vi0eXprgfeo9RyvG6PUnh82a9z3H/jhwRlL7a70Gql/5//qke3EoAzF/gkb4MhruwWoDxZ1C+wGHwZGNT4e/7K30x6NLLowARGVy7KSbm59aiCM300XQ7oHhsHJ3HeMr841fZlRRA2OFUrdegy7/WSs57gHBbDk5JTD8fSGybvxzlbd4HFlxDdaz7zl4bet17a8bNftdGnlc0J68tyzLVdQNpFAsGaIyvPuToJbNqpWyc7cSdS1mcKw+GIr6rHZkyrH30XFOv+qQt4x/CKIIlldgHLxLCfsmTgdkMoBbFx2g03CUyFxQtMy1MOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: spf=none (sender IP is ) smtp.mailfrom=clin@suse.com; 
Received: from SN1PR18MB2126.namprd18.prod.outlook.com (2603:10b6:802:29::29)
 by SN1PR18MB2095.namprd18.prod.outlook.com (2603:10b6:802:31::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.22; Fri, 27 Mar
 2020 11:23:26 +0000
Received: from SN1PR18MB2126.namprd18.prod.outlook.com
 ([fe80::1b1:6ada:da24:d1e9]) by SN1PR18MB2126.namprd18.prod.outlook.com
 ([fe80::1b1:6ada:da24:d1e9%5]) with mapi id 15.20.2856.019; Fri, 27 Mar 2020
 11:23:26 +0000
From:   Chester Lin <clin@suse.com>
To:     <rjw@rjwysocki.net>, <lenb@kernel.org>, <robert.moore@intel.com>,
        <erik.kaneda@intel.com>, <gregkh@linuxfoundation.org>
CC:     <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devel@acpica.org>, <jlee@suse.com>, <mhocko@suse.com>,
        Chester Lin <clin@suse.com>
Subject: [RFC PATCH 3/3] ACPI: scan: add a request_offline_recursive attribute
Date:   Fri, 27 Mar 2020 19:22:47 +0800
Message-ID: <20200327112247.17691-4-clin@suse.com>
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
Received: from localhost.localdomain (220.141.80.97) by HK2PR02CA0162.apcprd02.prod.outlook.com (2603:1096:201:1f::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.19 via Frontend Transport; Fri, 27 Mar 2020 11:23:23 +0000
X-Mailer: git-send-email 2.24.0
X-Originating-IP: [220.141.80.97]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 71e6190c-8c86-446f-0998-08d7d2414463
X-MS-TrafficTypeDiagnostic: SN1PR18MB2095:
X-LD-Processed: 856b813c-16e5-49a5-85ec-6f081e13b527,ExtFwd
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR18MB209545A4F9040270C2121FFEADCC0@SN1PR18MB2095.namprd18.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 0355F3A3AE
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(39860400002)(136003)(376002)(366004)(396003)(6666004)(66556008)(6512007)(66946007)(69590400007)(66476007)(316002)(1076003)(6486002)(107886003)(52116002)(6506007)(5660300002)(81166006)(81156014)(16526019)(186003)(8676002)(8936002)(4326008)(956004)(2616005)(2906002)(86362001)(478600001)(26005)(36756003);DIR:OUT;SFP:1102;SCL:1;SRVR:SN1PR18MB2095;H:SN1PR18MB2126.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;
Received-SPF: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mwhnS1s+XyBuhMAgLCbsaGtwyFGyVCdhPdHhACMRQV2AyJcxcxivSHPcsqBS/CurmBDk6bUD7KcvpcxAvVO466efz0oQfhfPye7RkHqdQbwFmM6MBmFnGDJvaRZXH/HWdBHJCJw1LxRQmKbmZMm+3XhUmaUL6DrXQVT8BLtuS7VzLvLIAm7JaF7E32t27ARtOeg9ZAle0m46RmO7j+yeBXV/Pq4cQvq0XYv2qreXFpl7jMzqLgo8yPPZQTVOCzodEoE5b0rrFtOrWuLNL4QAGZFLnHY1Vg7g2ycdMTo3lNXRuoGGwTIqMbdCsDzN8/q7HPtqOgSgkzErc1eMcuNJoIks6lMLmjau3KX+21Cr9o14aPmBwQhpCJW1Hn0KIgNZALSrlr7pAD1zXni03To/HqyOn9zfWVCf6+QwP4GvyUu2dqIo/M/2y5umvDdOeEkCVNB2lMYefWCEEzPkBZuq3tnpGjTSN1yyLjqoeTKhh00BJOugJYfOYQTQ94ewrC8O
X-MS-Exchange-AntiSpam-MessageData: zZKBPHESuoLItPo7nuXH/nVEIDHvkWbqYJcOhptszhelN0L34lX2tLNWCdSYpGXZEb9hEw6iFqDjJqWR/Gpwpwzo8Hk1xHU25s6bu/Xc5ZmYNCmITW4LksbfMZjaOLskzaadJDPu39Auurj9fRy6+w==
X-MS-Exchange-CrossTenant-Network-Message-Id: 71e6190c-8c86-446f-0998-08d7d2414463
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2020 11:23:26.0241
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hH6EtypFrVyJME+Y+yTVKfTgNopTRaiie+gbt4EiedRCccVZD2O3XI/kzc0e61AF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR18MB2095
X-OriginatorOrg: suse.com
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Add a request_offline_recursive attribute for userland to change
request_offline settings of the target and its child nodes at once.

Signed-off-by: Chester Lin <clin@suse.com>
---
 Documentation/ABI/testing/sysfs-bus-acpi |  7 +++++
 drivers/acpi/device_sysfs.c              | 33 ++++++++++++++++++++++++
 drivers/acpi/internal.h                  |  2 +-
 drivers/acpi/scan.c                      | 24 +++++++++++++++++
 4 files changed, 65 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-acpi b/Documentation/ABI/testing/sysfs-bus-acpi
index be00749f00e6..eb2fd9752b66 100644
--- a/Documentation/ABI/testing/sysfs-bus-acpi
+++ b/Documentation/ABI/testing/sysfs-bus-acpi
@@ -110,6 +110,13 @@ Description:
 		provides flexibility while some applications could need more
 		time to release resources.
 
+What:		/sys/bus/acpi/devices/.../request_offline_recursive
+Date:		Mar, 2020
+Contact:	Chester Lin <clin@suse.com>
+Description:
+		(RW) Same as request_offline but the writing will also apply
+		to all child ndoes under the target.
+
 What:		/sys/bus/acpi/devices/.../cancel_eject
 Date:		Mar, 2020
 Contact:	Chester Lin <clin@suse.com>
diff --git a/drivers/acpi/device_sysfs.c b/drivers/acpi/device_sysfs.c
index e40daafa3f85..d4fdb6846c78 100644
--- a/drivers/acpi/device_sysfs.c
+++ b/drivers/acpi/device_sysfs.c
@@ -537,6 +537,32 @@ static ssize_t request_offline_store(struct device *dev,
 }
 static DEVICE_ATTR_RW(request_offline);
 
+static ssize_t request_offline_recursive_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct acpi_device *acpi_dev = to_acpi_device(dev);
+	bool value;
+
+	if (!count)
+		return -EINVAL;
+
+	switch (buf[0]) {
+	case '0':
+		value = false;
+		break;
+	case '1':
+		value = true;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	acpi_request_offline_recursive(acpi_dev, value);
+
+	return count;
+}
+static DEVICE_ATTR_WO(request_offline_recursive);
+
 static ssize_t auto_eject_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
@@ -685,6 +711,11 @@ int acpi_device_setup_files(struct acpi_device *dev)
 		if (result)
 			return result;
 
+		result = device_create_file(&dev->dev,
+					&dev_attr_request_offline_recursive);
+		if (result)
+			return result;
+
 		result = device_create_file(&dev->dev,
 					    &dev_attr_auto_eject);
 		if (result)
@@ -741,6 +772,8 @@ void acpi_device_remove_files(struct acpi_device *dev)
 	if (acpi_has_method(dev->handle, "_EJ0")) {
 		device_remove_file(&dev->dev, &dev_attr_eject);
 		device_remove_file(&dev->dev, &dev_attr_request_offline);
+		device_remove_file(&dev->dev,
+				   &dev_attr_request_offline_recursive);
 		device_remove_file(&dev->dev, &dev_attr_auto_eject);
 		device_remove_file(&dev->dev, &dev_attr_cancel_eject);
 	}
diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
index 45f4ce42a044..3a2f66eac639 100644
--- a/drivers/acpi/internal.h
+++ b/drivers/acpi/internal.h
@@ -89,7 +89,7 @@ bool acpi_scan_is_offline(struct acpi_device *adev, bool uevent);
 
 acpi_status acpi_sysfs_table_handler(u32 event, void *table, void *context);
 void acpi_scan_table_handler(u32 event, void *table, void *context);
-
+void acpi_request_offline_recursive(struct acpi_device *device, bool value);
 /* --------------------------------------------------------------------------
                      Device Node Initialization / Removal
    -------------------------------------------------------------------------- */
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index b4678ed14eed..db6f0551ca94 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -269,6 +269,30 @@ static int acpi_scan_try_to_offline(struct acpi_device *device)
 	return 0;
 }
 
+static acpi_status acpi_bus_request_offline(acpi_handle handle, u32 lvl,
+					    void *data, void **ret_p)
+{
+	struct acpi_device *device = NULL;
+
+	if (!acpi_bus_get_device(handle, &device))
+		device->eject.request_offline = (bool)data;
+
+	return AE_OK;
+}
+
+void acpi_request_offline_recursive(struct acpi_device *device, bool value)
+{
+	acpi_handle handle = device->handle;
+	acpi_status status;
+
+	mutex_lock(&acpi_scan_lock);
+	device->eject.request_offline = value;
+	status = acpi_walk_namespace(ACPI_TYPE_ANY, handle, ACPI_UINT32_MAX,
+				     acpi_bus_request_offline, NULL,
+				     (void *)value, NULL);
+	mutex_unlock(&acpi_scan_lock);
+}
+
 static void acpi_scan_cancel_eject(struct acpi_device *device)
 {
 	acpi_handle handle = device->handle;
-- 
2.24.0

