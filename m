Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0E122EB51D
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Jan 2021 23:03:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729893AbhAEWCh (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 5 Jan 2021 17:02:37 -0500
Received: from mail-dm6nam11on2092.outbound.protection.outlook.com ([40.107.223.92]:7474
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729795AbhAEWCg (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 5 Jan 2021 17:02:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VazxdpeHERdY9IsSdvqpr8flY/jixVET9uCMUtMDggl56KvnDYW8McygubgOJtQyk95deil5I4m4V4HIuYOPosldEM2S1ittGFq9Pu/0VtrZ2HVShNshGo8dS6wZ5chnwF8td9BujPzWO3o1RNkOvxvCDPfWIl7kt+63YENecMioWAOy6jA2ZM6a3Q7PqIGVHYurNs9Kl4FgtWO07o6qPtwG1yIkqdt91AbiERJBOY17oA+HrTkxS/++W2XJ8HbAs1ByCehQQHjMJGzXb/oTffCLCICcaTWknueyfEbSHyp1UF5fRwvhW64StqwZeK6u8P7EYge0XL8byWqjIuk3Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=61x15f0xkvY2xVvUrxp1JkcDClvJSWlVrV5OH5i45es=;
 b=Ydf5Y/J1aWxdgH8Btmqu/JEmdb9To267WrRKsSHUhZ3E8VN+JVtJFYzSGChJbMBAv8gjiUr3+0YyKAzoFnRMlmaIWK6x4jFLIGD66CsmD2A+WHrbw6Ssb+Rrzd5aR3Ak6uXesYI3BlKEyu/JjtfKFBea2blEUNzoimqpSnSarZ119OA+8sZBIuO5jYQnHe6tvYVyO4tvpImbsMPvjllowoUNU5u6ilclr4HTLgO9ofpGpg0/C+susUlea9Vkhfu1vJ9qPjKGJuFCKyh6VFuVShV3xWZbz7XiYFv7RUFJATsnaDF7y05egWeWK8akFrTKxFjNHXQqpBgCUx9gcLS9kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=61x15f0xkvY2xVvUrxp1JkcDClvJSWlVrV5OH5i45es=;
 b=JbaFJ3lO48SCT+fAxHlXrCOS+hIvNdrWrIFaaz3MPLTvA9iHivwUgQIhgw0/UtBpXZrmnBEm4qbV04dbxRCsFPKLhdYE/W+OQRpTrYmdGiPHO6kTHaJcZ4EmsFFBEHCXiQaaMfhZ3h/XYuFEHbywJjCuySXOULOwnBe76KQBeUQ=
Received: from (2603:10b6:302:8::19) by
 MW2PR2101MB1772.namprd21.prod.outlook.com (2603:10b6:302:c::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.2; Tue, 5 Jan
 2021 22:01:47 +0000
Received: from MW2PR2101MB1819.namprd21.prod.outlook.com
 ([fe80::5868:f11c:ae6e:8a31]) by MW2PR2101MB1819.namprd21.prod.outlook.com
 ([fe80::5868:f11c:ae6e:8a31%8]) with mapi id 15.20.3763.002; Tue, 5 Jan 2021
 22:01:47 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Michael Kelley <mikelley@microsoft.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "len.brown@intel.com" <len.brown@intel.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>
Subject: RE: [PATCH] ACPI: scan: Fix a Hyper-V Linux VM panic caused by buffer
 overflow
Thread-Topic: [PATCH] ACPI: scan: Fix a Hyper-V Linux VM panic caused by
 buffer overflow
Thread-Index: AQHW2GokQzlfi5P1IkaRrU4aFB3YlqoZpozA
Date:   Tue, 5 Jan 2021 22:01:47 +0000
Message-ID: <MW2PR2101MB181943C255A86A11E5402E50BFD19@MW2PR2101MB1819.namprd21.prod.outlook.com>
References: <20201218040826.57203-1-decui@microsoft.com>
 <MW2PR2101MB1052E61BEB80F14896EEFA79D7DF9@MW2PR2101MB1052.namprd21.prod.outlook.com>
In-Reply-To: <MW2PR2101MB1052E61BEB80F14896EEFA79D7DF9@MW2PR2101MB1052.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-12-22T13:55:42Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=86b9b0ba-9f0e-4826-8f90-1a3393d863df;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: microsoft.com; dkim=none (message not signed)
 header.d=none;microsoft.com; dmarc=none action=none
 header.from=microsoft.com;
x-originating-ip: [73.140.237.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d075fb6f-e541-4207-5590-08d8b1c57f48
x-ms-traffictypediagnostic: MW2PR2101MB1772:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW2PR2101MB1772E72F6970BFC5A349C8E2BFD19@MW2PR2101MB1772.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xwd1NslBl6hOE13IOwl8jXP4BZuEtSu+08RYwXAXySfVAOKmIhffFgtGHHI5JVuKne4g+Hla2nVkS5Z0E7Hb/dS0mPXnxdI7MA/nqACWOH3gqXhqZkwf1giL+/SAsHHU10Zy0gZz7WXbVWvrVm5Mj9giBH8TqBkdK1ie6mI2wxFP1yJB+/O4I/IkrNRVu/WsDMvTHwkt2silQOzVFxYIs0tbwTwD2AlDlywfpKgMhU6WwKs311qDXMmOP1GL3LnPnyAp3ZKBMr7ru/mGCh1KuU75e9ZOmQRqmEFQ6UKVMoDMG7ZFOfUTlhYGa9ILi/AzOshji2HNHpZ7H43Fk/xL1PEPFT40PDTB8B0ie5CKcEfqxk364GKPBsSZpLOUZHJ/VXK4sNb1T75u58YqqM3RGZ9MdM4KpFXctl3AGo0QbW73gIRCteFBFA4xnZ5Zice9lHt5HObhUSnVAU6yQPWYtQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR2101MB1819.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(376002)(396003)(136003)(366004)(55016002)(9686003)(26005)(66476007)(8936002)(6506007)(186003)(7696005)(66946007)(316002)(8676002)(2906002)(4326008)(82950400001)(66446008)(966005)(82960400001)(33656002)(86362001)(64756008)(5660300002)(8990500004)(478600001)(71200400001)(107886003)(110136005)(54906003)(52536014)(76116006)(66556008)(10290500003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?aqscgcZd62KUO/XgLhEDz6WfTZfu3jiKPJ63gH2IcuIK3kPeWAI0zySle28O?=
 =?us-ascii?Q?mWt112sFfQavq6Bfbrz7olBI/1e81fWUg7cDRmx3T3MGTZEEj0O4Z+qvJfjN?=
 =?us-ascii?Q?0M/WOJ/iw00125PAeu0mKS0n3z5zxPzy8LCs1iOYlVz0k0hhpL9O7h01esie?=
 =?us-ascii?Q?SaZ238XfKf0YpqDBZRZ5fToIiB1navqyd52RSfmzyF4dcGW16UQh+J/HXyQw?=
 =?us-ascii?Q?CGUus2SmD96wIs15UxzjDs/JSzpxZTNaDWS6EJWcXVwnNPXjlz7zD+i+sm3G?=
 =?us-ascii?Q?75w/Dsi8H3Nm+X+yyf+8SiUFFAabF3l+tZTLAWwx+Wc5cqyIBdxU1c1EjPn1?=
 =?us-ascii?Q?5M22X9lvBbagPK+pbQCc6tD1PZ4GMBiJrbAcJbQZx3PWaNksQvw8seNACgeW?=
 =?us-ascii?Q?BlrJywW0iehe0toFrcqvqQHe/udcWMUE6BY4Oc/n1SLP/B/IGHGiWPx3MrO0?=
 =?us-ascii?Q?+XNLoA49+36mTb7LOGvPIp84CLQoVU08FWcEyDr2CZbzSedxqE2PrctBY0hd?=
 =?us-ascii?Q?f64t0XLwTx+XYjJM0tiKjXK4Hw2hWPL/2abQO8K3+yOJ6uAXGr4stAvEvTLY?=
 =?us-ascii?Q?VpiFZT9SpWr+8o1Ed+8asWdEaKMichVSEVlWldxIPeVuUHHBEu06nE+S7Y1v?=
 =?us-ascii?Q?334MAsxcRgoVPRN/+qC15zycfl8jcIUL/327cDg0yUELinFJ+pMqq7r3m1OP?=
 =?us-ascii?Q?7kXQiJxz4fTV2KfGNaK0lwiY79aGBdl6KXSGIwuBbrML99/sYXPY6ms6RYI7?=
 =?us-ascii?Q?gTL1B8uIzfl+r60tPVxdr6+F9TQvbIfyl1DohSdyEG/7SEw2BzRc3qQvTG5o?=
 =?us-ascii?Q?fQJK9eTSYOI0D5ojUfuFSjeSt3NcZs9lV/VK44bHFCI5CLitDt7ED62aGKMP?=
 =?us-ascii?Q?L0dhESkRPc38H0O1NTfM5OtIEJf0sHynKbq7dXAGfVzaLKhRxydgRMt0TXu4?=
 =?us-ascii?Q?ABbpSfczmHh7uV+M9IMcxnee+rcyqoKf+u6zchoSj9Y=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR2101MB1819.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d075fb6f-e541-4207-5590-08d8b1c57f48
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2021 22:01:47.3076
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Cmah6JDyzO+9O5dn75OsdCBEVmM941ceBaqcgql1tx2Ng/rDxRaFXnyd+xc3qqc+YxT1BbnbHVfKnG6tdHNFiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1772
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

> From: Michael Kelley <mikelley@microsoft.com>
> Sent: Tuesday, December 22, 2020 5:56 AM
> From: Dexuan Cui=20
> Sent: Thursday, December 17, 2020
> 8:08 PM
> >
> > Linux VM on Hyper-V crashes with the latest mainline:
> > ...
> > --- a/drivers/acpi/scan.c
> > +++ b/drivers/acpi/scan.c
> > @@ -674,7 +674,8 @@ int acpi_device_add(struct acpi_device *device,
> >  	}
> >  	if (!found) {
> >  		acpi_device_bus_id =3D new_bus_id;
> > -		strcpy(acpi_device_bus_id->bus_id, acpi_device_hid(device));
> > +		strlcpy(acpi_device_bus_id->bus_id, acpi_device_hid(device),
> > +			sizeof(acpi_device_bus_id->bus_id));
> >  		acpi_device_bus_id->instance_no =3D 0;
> >  		list_add_tail(&acpi_device_bus_id->node, &acpi_bus_id_list);
> >  	}
>=20
> Reviewed-by: Michael Kelley <mikelley@microsoft.com>

Hi, ACPI maintainers,
Would you please take a look at the small fix? Currently the mainline Linux
kernel, running in a VM on Hyper-V, has been broken for almost 3 weeks,
i.e. the VM always panics when it boots.

The patch has already had Michael's Reviewed-by.

BTW, the patch should have a stable tag:
Cc: <stable@vger.kernel.org>

Or, do you want the patch to go through the Hyper-V tree?
https://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git/log/?h=3Dh=
yperv-fixes

The small patch is unlikely to cause a merge conflict, and it only affects
Linux VMs on Hyper-V so far.

Thanks,
-- Dexuan
