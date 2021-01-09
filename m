Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED1422EFECC
	for <lists+linux-acpi@lfdr.de>; Sat,  9 Jan 2021 10:38:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbhAIJia (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 9 Jan 2021 04:38:30 -0500
Received: from mail-co1nam11on2104.outbound.protection.outlook.com ([40.107.220.104]:60257
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726661AbhAIJia (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sat, 9 Jan 2021 04:38:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n1pDiH49MKajliwd2B+xRYn07is4Xjxz1TB1x4Y1ytPGg2v/xpsFL8WEU6FRX47sHjhPw7XmXfrVCcmQJpd3KfWKVLX0JX8bkOChJE5NgO1xz+lEddYFsmAoNg+HO+/D+uBSmqQ69d9S2YRA9CNGCO4Wp6TzBEjoyd+5k94OJrcDhhpkZBobOciOX1hneVZWCV0iRVerr4XcA8WjGI1YAFpXescEBnKxcdT6VwluL7YjNcvmNXkJaNbEgD8xt6MHJqSQGaWMFapafsNDv4ecag77hcVDWdGnJPyS/oX4l0ty2yZDCkatRZSdxTXsFiRBZEyuUJvr1l6h40A8mUGHOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NzUhl2qBjjefEApuCTjSg5mZomXZMUoAH5UbfwXr58U=;
 b=CA5l+LteBzh0CvBZ/h7XbiwgxAPgAOyw1wGuVRu64MR7bVvw8JlkAqmN/iyZK7CikANuqsypRgcebjrHCZ0Sr/v7LkC7I4njgcwHLDZIs/FHgYMsG8NIf0USoQ9WFOJfuS3iiUToq52hXSNsPrrlpTqIx0e3LhKb3aCxZqRzh3pytLsBVBoNn5nUskiVLxDTEfETSdhNfwkLtkKjEpiF52ZwNYHA+H1VPkQPsMJzfBY8nfnFti8pHuuu/mKQw2wksdYfN/vJKQ2ppA1zyXT7/XeESrDP43UnmlwypREMB1LK8LEpdz46EL8TpKxBXMZnOHr9DgxyZ5LIZI3E8Ztraw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NzUhl2qBjjefEApuCTjSg5mZomXZMUoAH5UbfwXr58U=;
 b=CpBqV/H+He+7HCYm/zrkjLB+Gv7P1pLKp7Pigje1xXW3dEcHdLDthOm6TppLIbO7gl2/DZDMNGV/nCzZE/mihU9kdqWbnGOLD/FuzMizGOZLUvQJQLeUWT+IeF5gVn7Voa7aGFdyDl8KqaI2agtqxEZo4XRXPyHZJM9cZWr5gow=
Received: from (2603:10b6:300:128::18) by
 MWHPR21MB0512.namprd21.prod.outlook.com (2603:10b6:300:df::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3763.0; Sat, 9 Jan 2021 09:37:41 +0000
Received: from MWHPR21MB0798.namprd21.prod.outlook.com
 ([fe80::74c5:1aa5:e46f:8cb4]) by MWHPR21MB0798.namprd21.prod.outlook.com
 ([fe80::74c5:1aa5:e46f:8cb4%14]) with mapi id 15.20.3763.007; Sat, 9 Jan 2021
 09:37:41 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     "rafael@kernel.org" <rafael@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "len.brown@intel.com" <len.brown@intel.com>,
        Michael Kelley <mikelley@microsoft.com>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        "dwaipayanray1@gmail.com" <dwaipayanray1@gmail.com>
Subject: RE: [PATCH] ACPI: scan: Fix a Hyper-V Linux VM panic caused by buffer
 overflow
Thread-Topic: [PATCH] ACPI: scan: Fix a Hyper-V Linux VM panic caused by
 buffer overflow
Thread-Index: AQHW5msTvOtVmGN0LkKiF72uk6T6VQ==
Date:   Sat, 9 Jan 2021 09:37:41 +0000
Message-ID: <MWHPR21MB0798C62978C2E6F23FAB953EBFAD9@MWHPR21MB0798.namprd21.prod.outlook.com>
References: <20210108072348.34091-1-decui@microsoft.com>
 <MWHPR21MB0798B23AD969666FCDAD5095BFAD9@MWHPR21MB0798.namprd21.prod.outlook.com>
 <CAHp75VfPsMNZxN-hA3Cytjpm0K9xGoQpcGY_FZR4hUrtyqMj=w@mail.gmail.com>
In-Reply-To: <CAHp75VfPsMNZxN-hA3Cytjpm0K9xGoQpcGY_FZR4hUrtyqMj=w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=1d08c07d-780a-4e7e-b7aa-36d737930967;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-01-09T09:15:15Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [73.140.237.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ccd3669c-ade4-44dc-4d59-08d8b48235fa
x-ms-traffictypediagnostic: MWHPR21MB0512:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR21MB0512AE73186D45910F604708BFAD9@MWHPR21MB0512.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4T1IBK0C+4i+t2ihKm51txQ3PFWfqjBLqkSIZVHLcLOOegaW+twrOAUiagvqtjsrCIw0WoU2jXZw41IwUvWz10P6NkPXUebj9aqFnUd8GqzbfmyghAnn/yoWByOMH1dDtX+VX7lttZAODBngdE4e3EMyDtkO0+5bu1/iwoUTLizKbWvNJ2pJRmFe4D/MYVjqymmkXeAwHhjZGfS0TFnVBSnFwUTyC1M8w5k6TMLGaTLWpzEbh0b7a9+LZigWHo7neGNIID6MEMGmHN38k8UyqWrzkq6JWxQBLwi9KnExN4dK6vk45qirDTplfDur4CoXWzqDul0MGW7/nP+nl6mhjFWZxCq/dzQocYkKY4QCV2BFrx13JLsUZ/s3WWlsI3UQs0Kd+ZGvyrMkpibGCkDvw5sTjcv1Z9w1dXhm+vcBmi4795sC5IjePDOxGdQlFoj/oNoxrPzY9TyHr5xVT3ue6A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB0798.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(376002)(346002)(39860400002)(366004)(186003)(4326008)(5660300002)(6916009)(9686003)(55016002)(83380400001)(8990500004)(82960400001)(82950400001)(478600001)(6506007)(10290500003)(7696005)(71200400001)(54906003)(66476007)(8936002)(64756008)(66946007)(66446008)(26005)(76116006)(316002)(33656002)(8676002)(66556008)(52536014)(86362001)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Dh9Uo3EWBapEaSgXwoXCuJack4/pSC1pexK4udshm6p+uT8ycL67DJpUhqwa?=
 =?us-ascii?Q?+HPDSQqiuF9gWFMkPJqNk3h0IVr6G8usNwHTH7e5L5NPymLM0nK1Ms/G2/zP?=
 =?us-ascii?Q?2Q9iZAxWqtQOcLh5BTi+sMMYLDOCAOwgiYaXEcZlNIBd8SFBFP1BFrzIsG1v?=
 =?us-ascii?Q?htYvr63tPUxAfO+nCo2rl5HgqmoUbUL9gcfu9sti6Oyrcvn0gdYt4uHuwE0Q?=
 =?us-ascii?Q?rLaFdxZCCyJz7mRZUGurScVx4QUOXIsIjiV0JJ0a6/GhZkmLFoQQ7C2GWQqr?=
 =?us-ascii?Q?p/o5NhAVJ5r4Ve299fw9t+VhtCgdbCPf1Vz+YSCA7Arof3l4bLLz9A7byQiD?=
 =?us-ascii?Q?6QQG/4BfpmV6KPNysUFPIPRJc28hjZSdJv6ypT+pCCUn1w8JuYpWlbvzuBWN?=
 =?us-ascii?Q?WgUSSAqCh1MtFFjAI2KBzJPuAKORRibh3Pa7JurwtJLs9uLFWJqrioi6p3ry?=
 =?us-ascii?Q?EGbfzYZZ0NQEef5llQoG1+y6R1lL9eeQxxC2K+1kRykk1Ds75dkYaQC75tVT?=
 =?us-ascii?Q?31JVRb1OqayY8LIAdPn+2K04Sn3akvWKx+Vckv4myuQ/xVtxzDA7ktLH611O?=
 =?us-ascii?Q?rwhztTtMMEb0gZXYlDDRVrx7Zz7CEk3UQdfNXOb9vf5v8pAC1zThD4p5Q/Fp?=
 =?us-ascii?Q?fRSLb26a9Dyv/R8/1aGg9hTflhcMS0IOAO+EMB2BhMektnq2uJNt4jSA4Dm+?=
 =?us-ascii?Q?asAAfuxNQSI1DfILS6vYXMatBjqfrl7bCagg9ykuNH0uacofz5bBNH+xPVTn?=
 =?us-ascii?Q?TULc4c4WHUVZqnpT3wRABcZqzZXbl+uzYZBaKi+4/7eHCAkQAhi2EmFPu4L0?=
 =?us-ascii?Q?sYm/RhlpGb8C3K8JK4MQ1KpUwwIpJsyIesS6MGi/EFUqp9pcL4KYGcquCNiB?=
 =?us-ascii?Q?FSWVG3t3h+DLEks9ZF34aZaHDMDK7g3AIOCvCVdAUVPnGqa+abeezjEBEyAt?=
 =?us-ascii?Q?bfsdKvdLr14F+6tSS69VuRUkhaSpkNKrJH+BoewKBk0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB0798.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccd3669c-ade4-44dc-4d59-08d8b48235fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2021 09:37:41.5570
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6NDPnrixMqiJoEcJj0Bxp58F/Uj7KeGXMiCxWQ1iDjL0JeG/VhWXaPV+b7inRSoCBuWJC99x6Rgyjlr4TWwLvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR21MB0512
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

> From: Andy Shevchenko <andy.shevchenko@gmail.com>=20
> Sent: Saturday, January 9, 2021 12:52 AM
>>=20
>> Hi Rafael, Len, and all,
>> Can you please take a look at the v2 patch?
>>=20
>> The Linux mainline has been broken for several weeks when it
>> runs as a guest on Hyper-V, so we'd like this to be fixed ASAP,
>> as more people are being affected
>=20
> I would like to see a warning printed when the dupped
> string violates the spec.

Hi Andy,
Do you want a simple strlen() check like the below, or a full
check of the AAA#### or NNNN#### format?

Can we have the v2 (https://lkml.org/lkml/2021/1/8/53) merged=20
first, and then we can add another patch for the format checking?

I'm trying to do one thing in one patch so the patch is small enough
for easy reviewing.

diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
index cb229e24c563..e6a5d997241c 100644
--- a/drivers/acpi/internal.h
+++ b/drivers/acpi/internal.h
@@ -97,7 +97,7 @@ void acpi_scan_table_handler(u32 event, void *table, void=
 *context);
 extern struct list_head acpi_bus_id_list;
=20
 struct acpi_device_bus_id {
-	char bus_id[15];
+	const char *bus_id;
 	unsigned int instance_no;
 	struct list_head node;
 };
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index a1b226eb2ce2..3b9902e5d965 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -486,6 +486,7 @@ static void acpi_device_del(struct acpi_device *device)
 				acpi_device_bus_id->instance_no--;
 			else {
 				list_del(&acpi_device_bus_id->node);
+				kfree_const(acpi_device_bus_id->bus_id);
 				kfree(acpi_device_bus_id);
 			}
 			break;
@@ -674,7 +675,23 @@ int acpi_device_add(struct acpi_device *device,
 	}
 	if (!found) {
 		acpi_device_bus_id =3D new_bus_id;
-		strcpy(acpi_device_bus_id->bus_id, acpi_device_hid(device));
+		acpi_device_bus_id->bus_id =3D
+			kstrdup_const(acpi_device_hid(device), GFP_KERNEL);
+		if (!acpi_device_bus_id->bus_id) {
+			pr_err(PREFIX "Memory allocation error for bus id\n");
+			result =3D -ENOMEM;
+			goto err_free_new_bus_id;
+		}
+
+		/*
+		 *  ACPI Spec v6.2, Section 6.1.5 _HID (Hardware ID): if the
+		 * ID is a string, it must be of the form AAA#### or NNNN####,
+		 * i.e. 7 chars or 8 characters.
+		 */
+		if (strlen(acpi_device_bus_id->bus_id) > 8)
+			pr_warn(PREFIX "too long HID name: %s\n",
+				acpi_device_bus_id->bus_id);
+
 		acpi_device_bus_id->instance_no =3D 0;
 		list_add_tail(&acpi_device_bus_id->node, &acpi_bus_id_list);
 	}
@@ -709,6 +726,10 @@ int acpi_device_add(struct acpi_device *device,
 	if (device->parent)
 		list_del(&device->node);
 	list_del(&device->wakeup_list);
+
+ err_free_new_bus_id:
+	if (!found)
+		kfree(new_bus_id);
 	mutex_unlock(&acpi_device_lock);
=20
  err_detach:



