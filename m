Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69B5D3C865B
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Jul 2021 16:51:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232273AbhGNOyf (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 14 Jul 2021 10:54:35 -0400
Received: from mga14.intel.com ([192.55.52.115]:36498 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231797AbhGNOye (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 14 Jul 2021 10:54:34 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10044"; a="210176049"
X-IronPort-AV: E=Sophos;i="5.84,239,1620716400"; 
   d="scan'208";a="210176049"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2021 07:51:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,239,1620716400"; 
   d="scan'208";a="654765741"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by fmsmga005.fm.intel.com with ESMTP; 14 Jul 2021 07:51:42 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Wed, 14 Jul 2021 07:51:42 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Wed, 14 Jul 2021 07:51:42 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Wed, 14 Jul 2021 07:51:42 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.47) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Wed, 14 Jul 2021 07:51:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lacjpd1HwUH4EoS6x4XgWRMUsX1G/8xjjQCF0R4qjzv34SbeCFINea1UC59pMrJP/aisUtMt+xcf2cwDivjoh3dCGW+G76zivz8eqINKKZKXOLNzN4J4wd1WB83egpLetPDiD61E6Qs8NWKGsY8gwoNrLsKIfkdQrbNPSF3cIW31l//ELjo8IGYP4Qse9U956MtSKj+ZhykC6Yh4Jd2849SsPwzhChXRMsG2hFnzIVP7dHRt8AvhEj1k+OOqQzriIToBpnfDHqB3AO/vPIDNtw9yGA1EVnN2IwvbndhwFUTjI1qvxdyPEER+IVJGIkTYBq96C4PS02wdSKBKRnE2VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g+IEHuMfJk7VRzjm0hTecZz9G/JAJJnli3254WhFhNs=;
 b=Dxv9oD362UeSoh6NGkBL/C8W7+gwQ5pdBt87eUIfKRgpJ7q+4+/Nsy1wVmCvGcW2KrdD/jAw+kVOU5Rl/znRQYmePPXa03vfm719UjkSSgcohbqfd0BMQRpxORuxFeRsbOKdSIChJE1Pf6tRlzUd46V69khqdokLdvEnjlHnx+wYkDUKZa353V5ytmgGDSyTGSL7SDVAIGe2zZJzxkS4Y3QvAcE7+oi+1RZZ5RfcbYI5wh7gK8V9gVMFbwBGKmstceCdeUYfEkWAaUQgxJKvlHWTWNGe6B86vTBZo/v8vaPbLKqe63nj+OqmA9F7HrhJ6Y89HkuBmXbgKtU+8eK8qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g+IEHuMfJk7VRzjm0hTecZz9G/JAJJnli3254WhFhNs=;
 b=ut7468Jh2r1fFqrw2AVyPsB2LqiYAQFkPCs06PtN67HRSGarKVvSDn8oq4qcg3dSXWL1d4pzSW+m17Rgz6rm+XBh98N9CvwPvZup7S3oGmJj5Y2d9ANoI95Xp9malK1Yozb9Q0nYqjrmf35YJgHZHi7jXCsLORGQ2TZLhN1I0F4=
Received: from BYAPR11MB3256.namprd11.prod.outlook.com (2603:10b6:a03:76::19)
 by BY5PR11MB4258.namprd11.prod.outlook.com (2603:10b6:a03:1c2::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.21; Wed, 14 Jul
 2021 14:51:40 +0000
Received: from BYAPR11MB3256.namprd11.prod.outlook.com
 ([fe80::f1f3:ba46:dd24:f466]) by BYAPR11MB3256.namprd11.prod.outlook.com
 ([fe80::f1f3:ba46:dd24:f466%7]) with mapi id 15.20.4308.027; Wed, 14 Jul 2021
 14:51:40 +0000
From:   "Moore, Robert" <robert.moore@intel.com>
To:     Huacai Chen <chenhuacai@loongson.cn>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
CC:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Jianmin Lv <lvjianmin@loongson.cn>
Subject: RE: [PATCH 3/3] ACPICA: Events: Support fixed pcie wake event
Thread-Topic: [PATCH 3/3] ACPICA: Events: Support fixed pcie wake event
Thread-Index: AQHXcZ7IejOoouO5j0mYh1/2xjuGC6tCnBjg
Date:   Wed, 14 Jul 2021 14:51:40 +0000
Message-ID: <BYAPR11MB3256FDB80037FF91B35B2A2587139@BYAPR11MB3256.namprd11.prod.outlook.com>
References: <20210705124206.1228958-1-chenhuacai@loongson.cn>
 <20210705130549.1232418-1-chenhuacai@loongson.cn>
In-Reply-To: <20210705130549.1232418-1-chenhuacai@loongson.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: loongson.cn; dkim=none (message not signed)
 header.d=none;loongson.cn; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7382b69a-d5d3-4313-4b03-08d946d6e3b6
x-ms-traffictypediagnostic: BY5PR11MB4258:
x-microsoft-antispam-prvs: <BY5PR11MB4258C5B5D2EC568EB8DABBD487139@BY5PR11MB4258.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3ZtCDZQQKeUjNN61hSVnu9D725KkX220k9z3+lJLaw1DKfePaWUjPspyty3Y6UKmAzoa4MZxCv7VRn2IfH/fR5YVhXyR3ZgiH1e2QluQzzePaXay50vzuXVJvf+w3evlmxzDzMdUBuzRzOJw1LBthruPqMIf7bT/630xc6pCA/Hb9xDE1hFzmjdAy8uf2ibuC9TZ3MqUe0kg65CO2HTb+822ljVxAnSyVWM+BmXyHq0CDQkyb9ny0tSUAEATaQsHXQJ1tEg5Prpo4JYsoNfQXGOcWPOIXDZhY7rn70dOPNjHBHBdbMZMZ5jQiszLFJasDFb3l9IloDYX8fmxRm4ydy07WfpskwO0Fg5WyaN8Yjhg00zCw5FrjSiLEqZZFkuUOZnppgwcnsVnm/c5PldmU48c3ykB+fM00oMJNZ9MSukQZSvZQPbO1MJzQSYueHjWesPvaO7/BJC8XeXBwa29ksOdznxNlVTV99k4vpyrv1LprurExv7JZ0YC6ylakUwQhEmVbjYGM8Jarf+1U9hTyHDCouRQ1UR/RwN1TDT71kf41jKa3Xj2pgvXvij4eTARjUqGQis+EJIC0uT6PO8TE/z4FWi6JojwfW02/U1mn06zKBR69y9NBKoN5dqFy5kptxPS2aoj4gORm52ecj4vsHiTbIZAVsbmyOm4YZZYqz8i0tlaoEfx6k7jXdJo9smyXQnZzuatnXSRZ+2PFdt/Mrl8HQWdH1Tp8xE8UGLjPc9Riloc6AjIac2o/+10SP4vEqtB/lcQqu8kuDPvhI6J7lGYBzC3JhmqQwVI5kDtaV4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3256.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(39860400002)(366004)(136003)(346002)(110136005)(4326008)(8676002)(55016002)(5660300002)(66476007)(52536014)(83380400001)(86362001)(66556008)(33656002)(316002)(76116006)(66946007)(53546011)(9686003)(478600001)(7696005)(186003)(66446008)(26005)(966005)(64756008)(6506007)(71200400001)(122000001)(2906002)(8936002)(38100700002)(54906003)(38070700004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cBiW1GfKRca6+rg86C5LsMQkH6jKJqzA/vldAlzzr6dnNXr1H/Rov0LgbhaS?=
 =?us-ascii?Q?7+CpCnsqsYDp6fMhAp5ptFrkaa6KLrpHVa4OXtx/I9Ty8J012EMcxU9I8mnD?=
 =?us-ascii?Q?57cO42ZSpVxxvkAfHh/9LoSy+2MvUCGaGNsmoWT7afhqpThd2/GRElD1knoo?=
 =?us-ascii?Q?FstJgmyX1fUnK+RuSTr7j02G2CkrS5+0IBrXz5sW+roKHcKUSo+WVjUtB+4x?=
 =?us-ascii?Q?M/vh6ZjL0FrhDOBlVGOgnbpoiQwA460DjRcwsAkjhPnyuDKiQeUEszBmAqxB?=
 =?us-ascii?Q?BuYjABX5nLHfTNMxIIVgWX/1RLwd3L1+BL6fHaLod8v6Wk8zxiD6biKaBmek?=
 =?us-ascii?Q?8IwnINWBkUCX6yoVfxC2RyRoJPXQFUSiCilh6qSD/S7T5VpFqmVt12LCADsx?=
 =?us-ascii?Q?lUACy/H4k1ywkhIqbYokQH5BTnl6A3awfD9OsOX9WC+2kjLd7PDQklwrztQy?=
 =?us-ascii?Q?fcjLdOAywZHtdIyfMXz+QzNFKY9rOCdy1qzbCKWyagynaql9f5PvpYuO21an?=
 =?us-ascii?Q?b1d9kHGAOAH6NZUi9Wz3p6Fz2DlINCUxXh1Dt0+MLc9owp25y00QdrCGfar0?=
 =?us-ascii?Q?gVxStmjEA0R3LrAKx3hkwxz1NpTeykAL8FP0yW8CXizdHMu4l2CCD+prt6D0?=
 =?us-ascii?Q?UPAbjM9jmHYltn9TX6icXZ5CunJsJr4kC1OAtwoK6jjXX8wHSBdwqThexI7r?=
 =?us-ascii?Q?6xKKQOArNbQuggNCVpOhOubjEoQUcCIIaEsjEgyFrDKZ6JFckXhVVw9+p8/a?=
 =?us-ascii?Q?86x/1LL+LNZKfNJdmQZYUpjbpXsrdNX7hcaWRAzG9HzWI5U3zKSSSuDjGqy+?=
 =?us-ascii?Q?IMmEzzOmM6e/p4rVHg17AupfafCbcktUiJkifeUHtn5VBOnAj7rfvmhqMXy+?=
 =?us-ascii?Q?A0Y3Iap6LjJiHuc5JfL1C+OtBE2Vq+1v/OO4bfdVnc9/BtfYtQGS5BOIR78+?=
 =?us-ascii?Q?aWms9tdBYu6YS928oefNjWoCkt4Ns8BQ7wrBFHstaJpDBowFdZ3wQogMuAlV?=
 =?us-ascii?Q?VSJZGNx98LDNKotWdKGJ8oI/kGdbP5IRNPmg2t7q3jZ4wTi9WbtP5DTdpKP/?=
 =?us-ascii?Q?14+Kcn3PCAL/aKmykGk6nUMBqnHnGj+BGt8IWJ0idE2/jjUt29hDRBvRyhb3?=
 =?us-ascii?Q?QYe1JZNjCp+SAvhxZ7hwMki1dsdThwWJYBcn730xkFYpRAd5st+ImMnH0JOM?=
 =?us-ascii?Q?9xhZvyH0qJYYzRgHKqs660Ffnpc+vzrw1JlZkWaLhTqQEp7HyzeT9yHUX7nO?=
 =?us-ascii?Q?7ByGjZp8iL35YNhlNsBbm1FDqpTDD6+0P4MXzHnBBw0vew//rDtISHAX/xSY?=
 =?us-ascii?Q?0A8i8Ndv1s95aGFGlsewuPpv?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3256.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7382b69a-d5d3-4313-4b03-08d946d6e3b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2021 14:51:40.6076
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mxBnGY13fs9lXVrHfNVQodu4fjEQwjt72O1s+Zq2ep5CsysdXIUdGyixRPiFiDyY2UXkFc0YRzJs6+Ud3NpW8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4258
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

We'll probably take this patch.

Rafael, does this look OK?
thanks,
Bob


-----Original Message-----
From: Huacai Chen <chenhuacai@loongson.cn>=20
Sent: Monday, July 05, 2021 6:06 AM
To: Rafael J . Wysocki <rjw@rjwysocki.net>; Len Brown <lenb@kernel.org>; Mo=
ore, Robert <robert.moore@intel.com>; Erik Kaneda <erik.kaneda@intel.com>
Cc: linux-acpi@vger.kernel.org; devel@acpica.org; Xuefeng Li <lixuefeng@loo=
ngson.cn>; Jiaxun Yang <jiaxun.yang@flygoat.com>; Huacai Chen <chenhuacai@l=
oongson.cn>; Jianmin Lv <lvjianmin@loongson.cn>
Subject: [PATCH 3/3] ACPICA: Events: Support fixed pcie wake event

Some chipsets (such as Loongson's LS7A) support fixed pcie wake event which=
 is defined in the PM1 block(related description can be found in
4.8.4.1.1 PM1 Status Registers, 4.8.4.2.1 PM1 Control Registers and
5.2.9 Fixed ACPI Description Table (FADT)), so we add code to handle it.

ACPI Spec 6.4 link:
https://uefi.org/specifications/ACPI/6.4/

Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 drivers/acpi/acpica/evevent.c  | 17 +++++++++++------  drivers/acpi/acpica=
/hwsleep.c  | 12 ++++++++++++  drivers/acpi/acpica/utglobal.c |  4 ++++
 include/acpi/actypes.h         |  3 ++-
 4 files changed, 29 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/acpica/evevent.c b/drivers/acpi/acpica/evevent.c =
index 35385148fedb..2340986de37b 100644
--- a/drivers/acpi/acpica/evevent.c
+++ b/drivers/acpi/acpica/evevent.c
@@ -140,9 +140,9 @@ static acpi_status acpi_ev_fixed_event_initialize(void)
=20
 		if (acpi_gbl_fixed_event_info[i].enable_register_id !=3D 0xFF) {
 			status =3D
-			    acpi_write_bit_register(acpi_gbl_fixed_event_info
-						    [i].enable_register_id,
-						    ACPI_DISABLE_EVENT);
+			    acpi_write_bit_register(acpi_gbl_fixed_event_info[i].enable_registe=
r_id,
+						    (i =3D=3D ACPI_EVENT_PCIE_WAKE) ?
+						    ACPI_ENABLE_EVENT : ACPI_DISABLE_EVENT);
 			if (ACPI_FAILURE(status)) {
 				return (status);
 			}
@@ -185,6 +185,11 @@ u32 acpi_ev_fixed_event_detect(void)
 		return (int_status);
 	}
=20
+	if (fixed_enable & ACPI_BITMASK_PCIEXP_WAKE_DISABLE)
+		fixed_enable &=3D ~ACPI_BITMASK_PCIEXP_WAKE_DISABLE;
+	else
+		fixed_enable |=3D ACPI_BITMASK_PCIEXP_WAKE_DISABLE;
+
 	ACPI_DEBUG_PRINT((ACPI_DB_INTERRUPTS,
 			  "Fixed Event Block: Enable %08X Status %08X\n",
 			  fixed_enable, fixed_status));
@@ -248,9 +253,9 @@ static u32 acpi_ev_fixed_event_dispatch(u32 event)
 	 * and disable the event to prevent further interrupts.
 	 */
 	if (!acpi_gbl_fixed_event_handlers[event].handler) {
-		(void)acpi_write_bit_register(acpi_gbl_fixed_event_info[event].
-					      enable_register_id,
-					      ACPI_DISABLE_EVENT);
+		(void)acpi_write_bit_register(acpi_gbl_fixed_event_info[event].enable_re=
gister_id,
+					      event =3D=3D ACPI_EVENT_PCIE_WAKE ?
+					      ACPI_ENABLE_EVENT : ACPI_DISABLE_EVENT);
=20
 		ACPI_ERROR((AE_INFO,
 			    "No installed handler for fixed event - %s (%u), disabling", diff -=
-git a/drivers/acpi/acpica/hwsleep.c b/drivers/acpi/acpica/hwsleep.c index =
14baa13bf848..7e7ea4c2e914 100644
--- a/drivers/acpi/acpica/hwsleep.c
+++ b/drivers/acpi/acpica/hwsleep.c
@@ -312,6 +312,18 @@ acpi_status acpi_hw_legacy_wake(u8 sleep_state)
 				    [ACPI_EVENT_SLEEP_BUTTON].
 				    status_register_id, ACPI_CLEAR_STATUS);
=20
+	/* Enable pcie wake event if support */
+	if ((acpi_gbl_FADT.flags & ACPI_FADT_PCI_EXPRESS_WAKE)) {
+		(void)
+		acpi_write_bit_register(acpi_gbl_fixed_event_info
+				[ACPI_EVENT_PCIE_WAKE].
+				enable_register_id, ACPI_DISABLE_EVENT);
+		(void)
+		acpi_write_bit_register(acpi_gbl_fixed_event_info
+				[ACPI_EVENT_PCIE_WAKE].
+				status_register_id, ACPI_CLEAR_STATUS);
+	}
+
 	acpi_hw_execute_sleep_method(METHOD_PATHNAME__SST, ACPI_SST_WORKING);
 	return_ACPI_STATUS(status);
 }
diff --git a/drivers/acpi/acpica/utglobal.c b/drivers/acpi/acpica/utglobal.=
c index 59a48371a7bc..16f7a206fc6d 100644
--- a/drivers/acpi/acpica/utglobal.c
+++ b/drivers/acpi/acpica/utglobal.c
@@ -186,6 +186,10 @@ struct acpi_fixed_event_info acpi_gbl_fixed_event_info=
[ACPI_NUM_FIXED_EVENTS] =3D
 					ACPI_BITREG_RT_CLOCK_ENABLE,
 					ACPI_BITMASK_RT_CLOCK_STATUS,
 					ACPI_BITMASK_RT_CLOCK_ENABLE},
+	/* ACPI_EVENT_PCIE_WAKE	    */ {ACPI_BITREG_PCIEXP_WAKE_STATUS,
+					ACPI_BITREG_PCIEXP_WAKE_DISABLE,
+					ACPI_BITMASK_PCIEXP_WAKE_STATUS,
+					ACPI_BITMASK_PCIEXP_WAKE_DISABLE},
 };
 #endif				/* !ACPI_REDUCED_HARDWARE */
=20
diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h index 92c71dfc=
e0d5..0b6c72033487 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -714,7 +714,8 @@ typedef u32 acpi_event_type;
 #define ACPI_EVENT_POWER_BUTTON         2
 #define ACPI_EVENT_SLEEP_BUTTON         3
 #define ACPI_EVENT_RTC                  4
-#define ACPI_EVENT_MAX                  4
+#define ACPI_EVENT_PCIE_WAKE            5
+#define ACPI_EVENT_MAX                  5
 #define ACPI_NUM_FIXED_EVENTS           ACPI_EVENT_MAX + 1
=20
 /*
--
2.27.0

