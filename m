Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1866928E612
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Oct 2020 20:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387627AbgJNSMY (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 14 Oct 2020 14:12:24 -0400
Received: from mx0b-00154904.pphosted.com ([148.163.137.20]:44808 "EHLO
        mx0b-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727369AbgJNSMY (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 14 Oct 2020 14:12:24 -0400
Received: from pps.filterd (m0170396.ppops.net [127.0.0.1])
        by mx0b-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09EI8JKP022729;
        Wed, 14 Oct 2020 14:11:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=Htk0EO368NZziO/oPPGxiyyq0FlnD/L+I2kkNidW3W4=;
 b=Z8kIVvVNHakcDWJpnVC51pXPX+nLYVC9sxzvWDKb/ez+Nd66Zzj5F+GhyeN/CuT7nmLy
 vPngPEY5qDdjwtp2HDeS49MOn0Ewihe7+TD5rR6PbU6Z+geEYttQkCTmq1pLQeS4p/Qr
 gDC7b5ThQ6IFxp76lAaUdkCp9SLG7aYlboZqJ+2Um/4moUfEKwHUYGr07wwfxSUL8loa
 7ehwcUTXEk+gsexJJaXYN66nUyeZ9qUEwcMfDjVVAO2EoaASnzctQHYgvkUglyGYfjFS
 Io7XADSjxYc4ewMkr5QsiXAWxfca6+9Jw0CAbeTHTdq8sGaGwUVz2ZaVY038IV+/g7qj dg== 
Received: from mx0a-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
        by mx0b-00154904.pphosted.com with ESMTP id 3438sxf0np-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Oct 2020 14:11:05 -0400
Received: from pps.filterd (m0089484.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09EIAdb4040940;
        Wed, 14 Oct 2020 14:11:04 -0400
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2174.outbound.protection.outlook.com [104.47.58.174])
        by mx0b-00154901.pphosted.com with ESMTP id 3465e8ry18-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Oct 2020 14:11:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FDK4YkhOmYbl2IuokHnHU3getJrRmohr9S1kEcoQrvfO6fPO+I+d93wAzTX0kQ/512adENd2TE1FG1S2Ar8aFymPcokIL/0CmMXBkwaPUmdZZkOPOYi3sFjDy6NKRqy2YMQI817jYGkzorRIVZelgrS2XoZTg0Zs95GR5oFJL1eAjDjmrqP4g/rOEgQOylv+T9Q8J/yXICznl/ozUyKTq39TXHLC4gYMXbrOhtpeqilVibRHAJPa0bUHG5q+5KQAaYKWQG2AWXYEDXdBlNd4ozsyIboiUOzGNOdF82snOvDIpq/vx/NL16bWvK66tVgdxk5npEX4hcRcGvHFGlKSjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Htk0EO368NZziO/oPPGxiyyq0FlnD/L+I2kkNidW3W4=;
 b=gKlAME9wwJRXnDe2J6+dGZhOJGdMmzW8N2W/XHbwL4UquQ8B7UfWSdI9z0j74SmiolfTLiofJKsaJxjUHUTDmXaRx33m+5an+QhexdYN8rOZFaQPx7tEq8f4XFBx1+8NP9Ckqf6t2hpvdkono9OHI9a75ufPlhfPVm/GCd1g/14dCzfn/dB3c/CO2sNRm1sDmNH+DnZNKqD9TbKQnFnRhqNrS9DH3WPYX/bN5xAlf/2hFoOX9brTDQIFEkkYTMG6uhIBs/DADz4ML0LvM/BmFW0WRftoiw+ys1779etmlz+iMzuPKCJkm7uiqPV4GnvRwVpjO1Vk+Ov3C9YUtP4wRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Dell.onmicrosoft.com;
 s=selector1-Dell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Htk0EO368NZziO/oPPGxiyyq0FlnD/L+I2kkNidW3W4=;
 b=BXq1aNpb6rcAetJShWz3cITrUoecFUl35GyaDrWnDzUo4unjWqW+QYIRArNZjNQ1p1VJ6KcLkVv7MPvT46J39rsM7HwFYmk2v54RvWR/OhUaFhWhhJvyzY95IMqhajOg4jwFNlBSDp8LA6wtY9sNXWY5EYvpHqRDU5+371EatEA=
Received: from DM6PR19MB2636.namprd19.prod.outlook.com (2603:10b6:5:15f::15)
 by DM5PR19MB1097.namprd19.prod.outlook.com (2603:10b6:3:27::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.26; Wed, 14 Oct
 2020 18:11:03 +0000
Received: from DM6PR19MB2636.namprd19.prod.outlook.com
 ([fe80::a4b8:d5c9:29da:39b2]) by DM6PR19MB2636.namprd19.prod.outlook.com
 ([fe80::a4b8:d5c9:29da:39b2%4]) with mapi id 15.20.3455.031; Wed, 14 Oct 2020
 18:11:03 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@dell.com>
To:     Elia Devito <eliadevito@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
CC:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Bastien Nocera <hadess@hadess.net>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Mark Gross <mgross@linux.intel.com>,
        Mark Pearson <mpearson@lenovo.com>,
        Benjamin Berg <bberg@redhat.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Pearson <markpearson@lenovo.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: RE: [RFC] Documentation: Add documentation for new
 performance_profile sysfs class
Thread-Topic: [RFC] Documentation: Add documentation for new
 performance_profile sysfs class
Thread-Index: AQHWmYfgDjG0YI7kc0C9HQeldGcjC6mI+DtAgAMVLYCAAEOvcIAAC2yAgAAeRRCAB7+MgIABVsSAgAGfNoCAAAXmAIAAGSmAgAAg74CAAAHycA==
Date:   Wed, 14 Oct 2020 18:11:03 +0000
Message-ID: <DM6PR19MB2636A52C92BCD63B2A5A42AAFA050@DM6PR19MB2636.namprd19.prod.outlook.com>
References: <20201003131938.9426-1-hdegoede@redhat.com>
 <fec6eaeb-cc40-a2d2-87cb-bcae338bbe80@redhat.com>
 <CAJZ5v0gbQ=4bp22p3oM22zY+_1h-asYja1+CBbvtySzAY1p_+Q@mail.gmail.com>
 <1834022.taCxCBeP46@pce>
In-Reply-To: <1834022.taCxCBeP46@pce>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Mario_Limonciello@Dell.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2020-10-14T17:54:13.0621922Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=8b50ec2b-d3fd-4515-b844-530e324c8a4b;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=Dell.com;
x-originating-ip: [76.251.167.31]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ecd3bf3f-470b-4cc3-6927-08d8706c8330
x-ms-traffictypediagnostic: DM5PR19MB1097:
x-microsoft-antispam-prvs: <DM5PR19MB10973BFC474DC326C4BDE10CFA050@DM5PR19MB1097.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iOV+Qj5D4glV4moGNcfUwZk8xxU/r6MbOMDuEi2rbuYkG5NfBb0/DeWJeZCGxhupsAm/UyVugsW3+SkFSCvv8Pzh+YSXLkcRSkwEEXy/2gPcSxyKpegAIST0vxE0vLxbXBrxDa2eqDf9rxU3zY1LT4lG32nNL8oEx/rmpDZK4Ce2M7sfoxRsOe1UBvnz+rpaVG33Y4a13xunQ5jLbf5LQQRRq6+urF01G/0+NiNSaihlc2/0H1m1ZWaz2jj69sRGnDfL7z+BEJQ/vkkRndn/BeZF/jIR0pbT8vi4i6LAaFKI644cOiXtS056/BxS3fhr1ihpDqraZxgRznlgQjEfL7X5aXVWqRATu5hzuam2Di6qSpHn1c49TccvNUzVqWMIadf4NzI/DzLCq0W95vOAZA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR19MB2636.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(396003)(136003)(366004)(39860400002)(7696005)(66556008)(66476007)(6506007)(83380400001)(8936002)(26005)(4326008)(2906002)(83080400001)(8676002)(7416002)(186003)(64756008)(478600001)(9686003)(54906003)(966005)(33656002)(316002)(86362001)(66946007)(66446008)(5660300002)(76116006)(786003)(52536014)(110136005)(71200400001)(55016002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: XyEIfL5tJAUPcyZI3YLXAHT/awMBIRMWMRDLcVLtEynX5cab81B/3yU9FGrl1MXW2tb0APXq28egCVPaaEj3tklt1AzYmiK9m+nacKM6/kk90yJehcmETsGJ+AUbOHwsAFIPVVD8yTEhmjdQuwHGBSlj2CKDqjyloD1xBwTAz0wQN9bBAjOlFXZwxbcTCAionWPj3T78/XBnJgjcIvDfrdHU3IS4dpbWiBj3zpb+Yl58iAnljCfI25CynC4OunK2C6eOiX+/v0rjk3A2BbBZMZRgGeLGQV2XUt/sinyOE2YiFRUsbcYUeAp6OHMao+1iWxApxL24mnElWRv7LGsasJtMuJsWVsonpCBOeKLRevo65ztb+lmcc5xQkmjjS9if1I/abbXbLjHiVmgwVvraXjF1vvTSPSCxJhNmWpPYS5bvZ/ce6cVCTtyqLCrH3Dx6773Sfa+BuQclB9OtszK/vSx9sTXTlazb+dgOR4MjagFJZvEFHU+CthQI6w7CrUpteMwmvZ5gWo+aa5AYuIZzYsWEGUXQHJrfuGIgLdBik8PWRMY77dYF7Akx2Cks7XMAEWzlN4celhExj3crM4pBqQ+SoO47QFG8goD5Y40Le2bLCPCH98pPMDptbFKwlZVGBi4wvnq4lRdUYesHwbemLg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR19MB2636.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecd3bf3f-470b-4cc3-6927-08d8706c8330
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2020 18:11:03.1412
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wTr64FxElI+kBXNCf8hvuN3k3XvSeEoNRlMV6sHQOkX17J0W9b9+4WWVZMqbQe7D/8DQd/gDd9sgQKraLJZ5rqCUusRm5gzkK9PqjPGoDls=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR19MB1097
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-14_11:2020-10-14,2020-10-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 impostorscore=0 priorityscore=1501 clxscore=1011 mlxscore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010140129
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 spamscore=0
 adultscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010140130
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

> As far as I know, the profiles affect  the thermal behavior like "how lon=
g to
> wait before starting the fan and at what temperature" or "how fast to run=
 the
> fan with the current cpu load and temperature".
>=20
> The only way that firmware uses to "control" performance should be the od=
vp0
> DPTF variable.
>=20
> On Windows HP expose  both "Cool" and "Quiet" profile respectively as "Id=
eal
> for when the computer feels warm to the touch" and "Ideal for quiet
> environments".
>=20
> more detail: https://support.hp.com/in-en/document/c06063108
>=20
> To be precise "Quiet" profile should be available only on platform withou=
t
> dedicate GPU (I'm investigating if there is other case), instead the othe=
r 3
> profiles ("HP Recommended", "Performance" and "Cool") are available on al=
l
> platform that support thermal profile.
>=20
> reading here seems that Dell offer identical profiles:
> https://www.dell.com/support/manuals/it/it/itbsdt1/dell-command-power-man=
ager-
> v2.2/userguide_dell/thermal-management?guid=3Dguid-c05d2582-fc07-4e3e-918=
a-
> 965836d20752&lang=3Den-us
>=20

The Dell profiles here I don't think should be conflated with DTT/DPTF thou=
gh.
These won't affect anything in the DTT vault.

Those profiles are already accessible from Linux userland, there is already=
 a
command line tool in libsmbios that can do it.

$ sudo smbios-thermal-ctl -i
Libsmbios version : 2.4.3
smbios-thermal-ctl version : 2.4.3

 Print all the Available Thermal Information of your system:
-------------------------------------------------------------------

Supported Thermal Modes:
         Balanced
         Cool Bottom
         Quiet
         Performance

Supported Active Acoustic Controller (AAC) modes:

Supported AAC Configuration type:
        Global (AAC enable/disable applies to all supported USTT modes)\

$ sudo smbios-thermal-ctl -g
Helper function to Get current Thermal Mode settings

 Print Current Status of Thermal Information:
-------------------------------------------------------------------

Current Thermal Modes:
         Balanced

Current Active Acoustic Controller (AAC) Mode:
         AAC mode Disabled

Current Active Acoustic Controller (AAC) Mode:
        Global (AAC enable/disable applies to all supported USTT modes)

---
*If* we choose to export them for Dell from the kernel, we should probably =
also
filter from kernel side and modify the existing userspace tool to use the k=
ernel
API when possible.

I'm not convinced that Dell would want to tie into this proposed knob with =
those
settings because I expect that existing software like thermald will not wor=
k as
efficiently.

