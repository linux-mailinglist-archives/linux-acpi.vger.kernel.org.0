Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0CE02DE8E9
	for <lists+linux-acpi@lfdr.de>; Fri, 18 Dec 2020 19:30:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725910AbgLRSaI (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 18 Dec 2020 13:30:08 -0500
Received: from mail-dm6nam08on2094.outbound.protection.outlook.com ([40.107.102.94]:65504
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725836AbgLRSaH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 18 Dec 2020 13:30:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X2ecec/HJlTQikMc5dyhAuZk9trnDiGf5mrZn6Cvb+PAHREmOFbtq3ZcDVBZzumLRMBnymN2i4/lv6H/b5PTpeZTQfdpSFoyC7m8Zg0ARSIMVK6c6DweXnFTPTTNOBlcmhsEoOSmvJ5HK3vx6mDtpnDGm3cjmQMZ8jCmKzR0gd54HFJmhfO32obRo3bdajy+luF0bEGavdysJOlQ4SVJ4Vs/rNrWSxzUPlSGxEcmRf1zcGl4LWgxGvaKwj9T/p5EXlBRGNDFouvD8qxXtcHUlxPyz8zfcE9H11lXTMvQ1H7f4Y+kpORdoZVWORdj8/J9+ksJU4HgELfqW23j/5+ytw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t+gDElGC8glpYusx73yIXOJimiUqCAWNyxA956LB8+o=;
 b=b0vOfDVFrN8V+cgRQmQ4BSiCFQp6PJrXIytK4y6cnChe+zX4sz07OdQXY6iuTWaNEDwB108s/G3YfdsuvF4A1KINXGvB7hvZeLRKO4JC7x8VAdyC5PCcqMyX9CK1p6HMac5HISpXMeaLgpBB879ifDHr2wJyCyQGhRuKH9zv29U3P4dDMEfo2NxxP/b8+y1NTL2DCJ4oOXN5r6raEXejIYU29mrNDN7N4b+hNf662BuUIjDe9LGtXqvsu0wlS4K1yio0s7Wa10qTAOjZ7iAeBXNBHFc3itUcXffzrMBuJeqJAIIVHE78pbil3Wo/WdmOrZ4IenGzg4A8z5DqQ4EWOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t+gDElGC8glpYusx73yIXOJimiUqCAWNyxA956LB8+o=;
 b=gi6TRVjtV18TOjKN64mAGSrJixZe6QWvZX8M6lsHeckbUEbFNHMwX2OFpW/iEKgzDCGfRqvUrJsHuRKWFTlcWy6kLSm4d3/4C/AaGrg9enScbq8IK+Jt1cX8dEUzgoiUouglPAzipSQSoDlKv2GGajN5yoMUpnaOfWP4RZOUu+A=
Received: from (2603:10b6:303:74::12) by
 MW2PR2101MB0891.namprd21.prod.outlook.com (2603:10b6:302:10::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3700.6; Fri, 18 Dec
 2020 18:29:18 +0000
Received: from MW4PR21MB1857.namprd21.prod.outlook.com
 ([fe80::f133:55b5:4633:c485]) by MW4PR21MB1857.namprd21.prod.outlook.com
 ([fe80::f133:55b5:4633:c485%5]) with mapi id 15.20.3700.021; Fri, 18 Dec 2020
 18:29:18 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Dexuan Cui <decui@microsoft.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "len.brown@intel.com" <len.brown@intel.com>,
        Michael Kelley <mikelley@microsoft.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>
Subject: RE: [PATCH] ACPI: scan: Fix a Hyper-V Linux VM panic caused by buffer
 overflow
Thread-Topic: [PATCH] ACPI: scan: Fix a Hyper-V Linux VM panic caused by
 buffer overflow
Thread-Index: AQHW1POBQzlfi5P1IkaRrU4aFB3Ylqn9K8XQ
Date:   Fri, 18 Dec 2020 18:29:18 +0000
Message-ID: <MW4PR21MB18576BF8341EEA3717E984FBBFC39@MW4PR21MB1857.namprd21.prod.outlook.com>
References: <20201218040826.57203-1-decui@microsoft.com>
In-Reply-To: <20201218040826.57203-1-decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=a0f13c4a-9fe1-4f4c-8d7f-553219d00aa7;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-12-18T18:23:09Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: microsoft.com; dkim=none (message not signed)
 header.d=none;microsoft.com; dmarc=none action=none
 header.from=microsoft.com;
x-originating-ip: [2601:600:a280:7f70:7425:1cd:ee08:eb5a]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f173672a-b21a-4fd7-acc3-08d8a382d4d5
x-ms-traffictypediagnostic: MW2PR2101MB0891:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW2PR2101MB0891466840247E908D960997BFC39@MW2PR2101MB0891.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sdYfKL1z5SORyC9roSywdvy6wP0M7tA0DWoDyopFMx/3BPcgB0K9wxjO5vYhNl/iT4wFZyLrQaURwMxX413PdpBUAYctPIzfijEr+Z8WvY41lwHCmgMx/IJOOx1EprmXCTsKFKH7UezBCp0HvZ5PUT4nXS7gLjQzqn1Ow9UJ8T7rMHqav7alSVhvmwb3nhqV0VI5uF3/ZyXMbwAxgxWergoGpuG8GVM4bJhldgxpGQXf4vVC3dyjIK3uvV8FLJW1dDFfQezA+E4Qx4teHjzDRgFVsvNvb0Vc8wGD447tT9whggEiRM5LeUFGuX50mf1SqVJvzmwEHlYEMA42F0GUAWmIkUepkelahw+iOpls5EeN7rfMBJsKCfrd5eLUJbFr18jP+yF+KDtPfW3Y15jBew==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR21MB1857.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(366004)(39860400002)(346002)(136003)(83380400001)(107886003)(8676002)(64756008)(10290500003)(478600001)(76116006)(2906002)(7696005)(8990500004)(316002)(66946007)(71200400001)(110136005)(86362001)(82950400001)(9686003)(186003)(33656002)(55016002)(6506007)(4326008)(52536014)(8936002)(54906003)(66556008)(82960400001)(66446008)(6636002)(66476007)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?MRixq7HPkszq0fP2jbC2BNR9ijMhQpwj0W+c2P9Uv0r9+4WDUsUm3iUm4eSi?=
 =?us-ascii?Q?IIAahQbmjB/fbtuvx+FoDExxAzIuCRBVLlVNkP3heyGkPoQEfPV+ycHML0Tb?=
 =?us-ascii?Q?/QMhqgR2wr40R5OHEDVv5GyPwfFjjd+pWOkn1pNR6GcSmcwYVmhIRgX1BU9i?=
 =?us-ascii?Q?Yt67i12hDyg8WCJfjNn2fpV4aUf36oEIFYEdHdkU45zlOjTkyFevuGScmlzr?=
 =?us-ascii?Q?Ygm5anAYB5n6yloVHDtETiVSb5fXeL4hzECjSWIbITEFNklCER+s/h1vLb1v?=
 =?us-ascii?Q?du3UV+L6ZN2a/tZPTt+K/tF19Rb3v8IOoyZcqIGvIZzwajmdilRUiKF19DPN?=
 =?us-ascii?Q?HAGHcKRWleGGqnWuX8LarXtJ2Egb/mz3Dkk2r0dVR7Btx6w2XChSvtGIEiRw?=
 =?us-ascii?Q?Wlv99Lwyxd3EvBOcnHceVura1w7egBT71AjYa9lAGDz6/EwCY8IupQMIITHA?=
 =?us-ascii?Q?8qdEMUgJdgUmIOs6D4ee1+TlIdCuazQROnNErFhSitmW6bKLkt/Au7TZFAcD?=
 =?us-ascii?Q?JRM4SizvopoZgNAUWW20HWfMWYSYL03MRZneUXjT9OcARPlFuT0LCd44tZox?=
 =?us-ascii?Q?NcG3KMmowd1jfXo4LdS+z93i1WKC2mU/ylhLfh8hjUIV+yB+qWMLmJ7t6xBs?=
 =?us-ascii?Q?d/W2SduRqX62B1FKNrs+T6v7z3uNb8ffSzch6bz4gE7Ftd7qBBMpNWfFOsJq?=
 =?us-ascii?Q?0xQ6nVe1GvZazXrC52UnJgzQ+TjAkK+A92D1zau73Ouz4hjGnZTBsCvn9Gok?=
 =?us-ascii?Q?DfUxoiIcC0nAaw/mXT5Bd7ZyFo+jZ3CppiEXZ1e0Aqx9rRP1zcbd8aXYSD5x?=
 =?us-ascii?Q?pGFumY4IiNUiR1KFVegH5TIA7hrOc/QzHiFgyodUFBFLsddZrJT1b8SwTBJY?=
 =?us-ascii?Q?IhwV3K24MjZJulcd8CNeMD1/e2o0O1mWdWub13I4qmrjAgWvF/6LMJvqn5tN?=
 =?us-ascii?Q?SJaQ0IaI37FdF5AB+IQQjXAtbcDCKZGeCf9o4SQuN6TRata7n8L6Tc51UJvk?=
 =?us-ascii?Q?l8UCtPSpK5G787X0z9EbU1e6EhRHazH6gmB9SnfnCBFfPks=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR21MB1857.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f173672a-b21a-4fd7-acc3-08d8a382d4d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2020 18:29:18.3091
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8w0etaB2yZzWd9NaO1uSMYSSw1gIVQuRRqWH9HITbqOHLm1PfhjMGZwTQWxzD/ZG+PjxH+Hi4xTYuwcbK0ObfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0891
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

> From: Dexuan Cui <decui@microsoft.com>
> Sent: Thursday, December 17, 2020 8:08 PM
>=20
> Linux VM on Hyper-V crashes with the latest mainline:
>  ...
> This is because of the recent buffer overflow detection in the
> commit 6a39e62abbaf ("lib: string.h: detect intra-object overflow in fort=
ified
> string functions")
>=20
> Here acpi_device_bus_id->bus_id can only hold 14 characters, while the
> the acpi_device_hid(device) returns a 22-char string
> "HYPER_V_GEN_COUNTER_V1".
>=20
> Per ACPI Spec v6.2, Section 6.1.5 _HID (Hardware ID), if the ID is a
> string, it must be of the form AAA#### or NNNN####, i.e. 7 chars or 8
> chars.
>=20
> The field bus_id in struct acpi_device_bus_id was originally defined as
> char bus_id[9], and later was enlarged to char bus_id[15] in 2007 in the
> commit bb0958544f3c ("ACPI: use more understandable bus_id for ACPI
> devices")
>=20
> It looks like so far an ID string of >=3D15 chars is only seen in the gue=
st
> BIOS/firmware by Hyper-V, and AFAIK the ID string
> "HYPER_V_GEN_COUNTER_V1"
> is never used by Linux VM on Hyper-V, so let's just truncate the string t=
o
> fix the panic.
>=20
> Signed-off-by: Dexuan Cui <decui@microsoft.com>

IMO this patch should also go to the stable trees, so please add
Cc: <stable@vger.kernel.org>

Thanks,
-- Dexuan
