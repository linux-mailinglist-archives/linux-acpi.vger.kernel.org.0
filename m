Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 235A62F1E26
	for <lists+linux-acpi@lfdr.de>; Mon, 11 Jan 2021 19:39:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389746AbhAKSjq (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 11 Jan 2021 13:39:46 -0500
Received: from mga09.intel.com ([134.134.136.24]:44339 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389451AbhAKSjq (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 11 Jan 2021 13:39:46 -0500
IronPort-SDR: JfjMCX9UWCPqOOUZxTyNvd0rdxN9B0EG5vH3om5AAfEJ6YgcWL8pQh0uhCZGzEt9gI/uVg1TGV
 zseXRK6K3xBg==
X-IronPort-AV: E=McAfee;i="6000,8403,9861"; a="178063321"
X-IronPort-AV: E=Sophos;i="5.79,339,1602572400"; 
   d="scan'208";a="178063321"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2021 10:39:04 -0800
IronPort-SDR: OdtC6AGIN3ENBECTmrNI/F7fDXob8+enoc78ovLQzg9uWZEZ78UBbZwjFYEe4Fcbdm/VjbQ0VC
 l0HPJqUO5O0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,339,1602572400"; 
   d="scan'208";a="567259228"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by orsmga005.jf.intel.com with ESMTP; 11 Jan 2021 10:39:04 -0800
Received: from orsmsx605.amr.corp.intel.com (10.22.229.18) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 11 Jan 2021 10:39:04 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 11 Jan 2021 10:39:04 -0800
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (104.47.38.51) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Mon, 11 Jan 2021 10:39:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=THp6+sePc0IA2naiSk4U3H4zrsA84cc/G9srT1LWjEtbf9mQIkcHD/XoNRsgeqtRxPo6XwH7EIe+vzOwKqglxTEjJ++D95+Bf66LHHzzzzIjEnc5ot//MihP6iWqQraa6/IxQKD5eRr5laY7egsQh06l3u9wnDuPCV6iG7hB1BEllCfCW5H9/NOM4XIg8btFCMp6CBKvGiLaO2bT1HLqt9fDcal5NQ3iFUyYnBwnmJPt1IB7hgPIJrVmq3Zw0kaYYMgtm4gJSHqt2nQc0yEj2Q2W2htXqtmVrnZCqX6e30yklg/4VKD3NYwpTTRkg2DqqTyogWVnqrhjVqGO5sB+Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ONtH3RHuFJuOwyc05bdiQxTq7qlSP9wvTF/qrMG8a0g=;
 b=GO5jlX83+nNoi1a4Cv5Eh9bY+SNOf5aydsYpeQyrqDgzhOn3LHMbLTiFOKok+kVL1KgHXsaMNMwhhNaiJIOqqzoj9UxGtWLrix9aHe6VbRxzqFuV4nJ5iu/ApO40jV+ZrbmqGF4Rh/JfLWobQGqm5azbJc2vhmkfpGPmY/xKTmsH5lMpkBHCHboeXWXAQJhT2cH4jHlQUbEwCd51iF/6Rb+vqbxNbq+70o8sixrXjgPqTnKSLnw3E0O+SFV1pTdtlOfWDt0YjQ7TOGmW0tPc0fxmjEiNBXpAnd5YaM7J+hVNCRxmwT4Lx5BnOL1AqkTUGgkxqnoAIIfBdVbROxKynQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ONtH3RHuFJuOwyc05bdiQxTq7qlSP9wvTF/qrMG8a0g=;
 b=HdDfHrhXUsZRKK8XRRP7CGGr42b/Y1CAe0JFYFjwke0KHDVnHyL6n+5Ui3I8IapjR2BryZtSJaaBng3uN77x40AnQnu/p3H8TTajrMBS/nwa7T5FjQvYXKjDFE6o7k7cCWji3OT5wAarnFfY0w0kuzOWM5DJ3JqtCuAzbLYyr60=
Received: from MWHPR11MB1599.namprd11.prod.outlook.com (2603:10b6:301:e::16)
 by MWHPR11MB1806.namprd11.prod.outlook.com (2603:10b6:300:10e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Mon, 11 Jan
 2021 18:39:02 +0000
Received: from MWHPR11MB1599.namprd11.prod.outlook.com
 ([fe80::4878:159c:ca1e:f430]) by MWHPR11MB1599.namprd11.prod.outlook.com
 ([fe80::4878:159c:ca1e:f430%10]) with mapi id 15.20.3742.012; Mon, 11 Jan
 2021 18:39:02 +0000
From:   "Kaneda, Erik" <erik.kaneda@intel.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        "Moore, Robert" <robert.moore@intel.com>
CC:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>
Subject: RE: [PATCH 0/2] ACPICA: Fix a race in GenericSerialBus (I2C) and GPIO
 handling
Thread-Topic: [PATCH 0/2] ACPICA: Fix a race in GenericSerialBus (I2C) and
 GPIO handling
Thread-Index: AQHW25NtL5sxFFdArESBZvzbqOOr7aoi2rlA
Date:   Mon, 11 Jan 2021 18:39:01 +0000
Message-ID: <MWHPR11MB159999DD0D8F383288CF8CDEF0AB0@MWHPR11MB1599.namprd11.prod.outlook.com>
References: <20201226142830.48818-1-hdegoede@redhat.com>
In-Reply-To: <20201226142830.48818-1-hdegoede@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [174.25.99.223]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 970c4238-0f0a-4316-568a-08d8b6602aaa
x-ms-traffictypediagnostic: MWHPR11MB1806:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB1806BFAE387E9252788E2E17F0AB0@MWHPR11MB1806.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6S0lPLUOIITi69YIi/0g/vaAln5c0gcpHZCZC99JRY/nIPsDWXOUP9NZ7HaW9yg/BkrAQVBvuUboix2MmqMcGxAu5Ov51lIW61CTra/coR0gy3HFCdQx2NnbpRUZkV7hGLGkPXo++W6TrdqhHJnI2PoBUlGDBe3nYU30zf0UtP/4QAnszVDu/vOrqAD5S/Dj6rXT7qz8sxo7LGNW8u7ES8J2h6qNrSxXRp9jhBa5ftw0Upy0ekg6CAy9Q9Z2aoVhn8Py8AoM9UEeG2Mgk8DLIuXDzywecOwBWa5gARbGSY4ro61fP4rVLtm5I+uoouYEL4FRJymRJEgKu0nCH5uP/On+BE8dT91IQ9RRElhrLkojl7en2Bur0S0M7lkPgtLjaS/S01GiWzyjfrpF6qD3uQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1599.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(376002)(39860400002)(136003)(366004)(71200400001)(33656002)(2906002)(53546011)(6506007)(66476007)(76116006)(86362001)(55016002)(66556008)(54906003)(52536014)(6636002)(4326008)(9686003)(478600001)(66946007)(5660300002)(8936002)(186003)(26005)(110136005)(66446008)(8676002)(7696005)(64756008)(83380400001)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?idXERRuIVKxjz7ZD3cqBzJnhgqRnleY5HiBE7Ztp9Vn4GVDoDj1YqRrbkC8h?=
 =?us-ascii?Q?mPWbI8jplWQwq2GH7Luc8Q7QkmdZY5teWVbjr6Qp3q+Jv90/pOZT2wajGTfE?=
 =?us-ascii?Q?2LFBupVsYBd2+Ga7GEqY53W4athzKQKmjGUJHwB/zjUmgazp7f1wPDse4iw/?=
 =?us-ascii?Q?LD4VAj78nkfihSlPB9bJvuRfwA2jWnPG7hLtrd0OAfWT73LEuaAfNTvqCYda?=
 =?us-ascii?Q?BKgiCJCzOzCth9wH0GxyECVrFeipudVGYRFkMke/N3n6IQ83npgy2diq4oOd?=
 =?us-ascii?Q?V53knw9gEL5EFF0YEORMs/0ACoF2MPDRs4lgGWuKMCOpXLnk0fAFx7zZxsDp?=
 =?us-ascii?Q?6kjaBq7UGX3KmELs2D4KB57+O9wKPXhdeFG0GDeoA8ZBxRNFdKH5ei1NLJvJ?=
 =?us-ascii?Q?cFKjcU+XactNK1wnSTP7b5gPlJP4gNx0Z1nZFRzDGPGxICEcXSBrtZWDIoY8?=
 =?us-ascii?Q?asJPhGyXx8y8/O4Tie8YfaWHP0RCimsWqnO3LKAtCUVew+3VbO8QNTnBNbey?=
 =?us-ascii?Q?fJe1ec63+1GJcoPyvXWFuAa7N7+yIKFof2/LTphMHmUVQdVYqZZJVCLMMl7J?=
 =?us-ascii?Q?I2LCbtV59YcCCkkUf/Tngfx1d3I/VKC1Oe+IHsNPdwj7UwEKghVrE632SL2l?=
 =?us-ascii?Q?dg47U0gk96Gx56Gd5hvPTFanefjcI0NzWDpYQKp3++2ZJxilHgYzap/gQq/x?=
 =?us-ascii?Q?NsYunvHG9QS7vPCwREVRns+qddsAUGwZark6ogenzdQ8pdkhprB8cpC6Taib?=
 =?us-ascii?Q?JnqHTnbpnx7+JeS5y4V3xnLQuhUPv8zzO3batE/GzLABAqQCS8MVaz2kMz4D?=
 =?us-ascii?Q?meKhH8VERCvWUW0xD2ULcWwhsF1xf2VYzor/LmYacUOt9K9wXSmGNtctQPgs?=
 =?us-ascii?Q?5LdTs4oMCTOIn3LwRm9HqgeQ/zA2yox8zNj+3uPF3Xv5PYcy2iJSrxv9yEwg?=
 =?us-ascii?Q?/ZbqvxgztVt1idMThYnGET1l5cqrFKehSnvcn7Ab0QU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1599.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 970c4238-0f0a-4316-568a-08d8b6602aaa
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2021 18:39:02.0117
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WmO5pt90Bxt4rHtsAo2bh2fEdvO0i9dD0wBgADMrLNGRnEMmhhQrYyJEzE38LGUHOeMPnUnee6lkB+tubIE9pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1806
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



> -----Original Message-----
> From: Hans de Goede <hdegoede@redhat.com>
> Sent: Saturday, December 26, 2020 6:28 AM
> To: Rafael J . Wysocki <rjw@rjwysocki.net>; Len Brown <lenb@kernel.org>;
> Moore, Robert <robert.moore@intel.com>; Kaneda, Erik
> <erik.kaneda@intel.com>
> Cc: Hans de Goede <hdegoede@redhat.com>; linux-acpi@vger.kernel.org;
> devel@acpica.org
> Subject: [PATCH 0/2] ACPICA: Fix a race in GenericSerialBus (I2C) and GPI=
O
> handling
>=20
> Hi All,
>=20
> On one of my machines I noticed the following errors being logged:
>=20
> [   52.892807] i2c i2c-0: adapter quirk: no zero length (addr 0x0078, siz=
e 0,
> read)
> [   52.893037] i2c i2c-0: i2c read 0 bytes from client@0x78 starting at r=
eg 0x0
> failed, error: -95
>=20
> The second line is coming from the Linux I2C ACPI OpRegion handling and
> after a bunch of debugging I've found out that there is a rather obvious
> (once you see it) and nasty race condition in the handling of I2C and GPI=
O
> opregions in acpi_ev_address_space_dispatch(). See the first patch in thi=
s
> series (the second patch is a follow-up cleanup patch removing some code
> duplication).
>=20
> TBH I'm surprised that this issue has gone unnoticed as long as it has,
> but I guess that it mostly leads to unreproducable sporadic problems
> making it hard to debug and I got lucky that I had a machine where the
> race seems to trigger about once every 20 seconds.
>=20
> I know that ACPICA patches are normally merged through the ACPICA
> upstream
> but given that this is a serious bug, I believe that in this case it migh=
t
> be best to add the fix directly to Linux and then port it to ACPICA from
> there.

Thanks for this changeset! I'm taking a look right now

Erik
>=20
> Regards,
>=20
> Hans

