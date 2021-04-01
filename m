Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87C2635212A
	for <lists+linux-acpi@lfdr.de>; Thu,  1 Apr 2021 22:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233744AbhDAU4i (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 1 Apr 2021 16:56:38 -0400
Received: from mga05.intel.com ([192.55.52.43]:9621 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233677AbhDAU4h (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 1 Apr 2021 16:56:37 -0400
IronPort-SDR: so6XNmIw+LXXRskNdhLIJl4FvG0BgF4xwLcbSi3YQGVRKnCw8YuszdKms4WpCkK4ABUICjJNyr
 Cdw+8j/mkAhg==
X-IronPort-AV: E=McAfee;i="6000,8403,9941"; a="277515541"
X-IronPort-AV: E=Sophos;i="5.81,296,1610438400"; 
   d="scan'208";a="277515541"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2021 13:56:36 -0700
IronPort-SDR: l2G45vT3KsP+Tg4vZG9N9PnREK9DL4Or50kcxpmIdZ1KqB3PyS7SZnZ5238WpoGRK9qGojFRfE
 Wr6Cnn15NK7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,296,1610438400"; 
   d="scan'208";a="419361306"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by orsmga008.jf.intel.com with ESMTP; 01 Apr 2021 13:56:35 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 1 Apr 2021 13:56:35 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Thu, 1 Apr 2021 13:56:35 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.102)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Thu, 1 Apr 2021 13:56:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eQ/tL5o8bTSvsPkkQkKtmSfvfci1tYDadPLPF3PBxOOVQOODeRSsLkxGOqoxT3dQYOMp43yBWkJhV8R6dFAXftWqBEhWMnq9zEuutCUve7gMZPsnk2bM4hTjKwyoToKUuTxOxfGdP1UjQs07ZCy7/XWmE22Fd7sdtwTLvOh7ejwb6AuXfz5Na3TJ8sTVP0lhN9XHAETDg6abvnbNtxMoxOG9DQ0bMtjOpJ1/09GqSak4b4GTYEwPIMyorE5cpRFz7mQpiaalSNCbpbpsG02PTPWkexooTOz+YSvc1Jl96HRaofBKqnSAP9hiuWRAj8Hu5piOTKXRwJkPs83jzkngfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xyi0xbbzEk3E7aD3Y7CCveexZmipzdksoERN5RFzsR0=;
 b=isQjGbu7Xc3wEh79k7oR0Tek3rWEJorbcMh0Wg5FcXMU4x0IA1gKjykznz1Ew/Toc9C5mDnddZa8jlddUqy1i9tJLUlbNzdNQtDqD2jO6ivx2xcH6JJskaCMuh+SJDrVbq4Im100JWvQaIWX7CfbG5aMAoYds3YnNxJ8R+31VoHqq7DvGNuUBBueb19vJYcBaY6/bkgx3R0xX832yq3Pfc0gh4Or6q5vwZT5nxhH2nbfoRJPEWt0bf8Td/2MAQVIQrRrUSeeysSKA+LOp57C+4Y+tA56DbrVX2+4V5sLPsf0M8Fi3yEpf3T6Fi+p6KLHLuF43/VJDgVAE9jhCGEinQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xyi0xbbzEk3E7aD3Y7CCveexZmipzdksoERN5RFzsR0=;
 b=Juf4IB2dKFiyuUk764w8GfaMtfnd/MvTz9wra+ynbEbbLvHpj1sgHTedxBjthHemH+yo+WLYjDhWPSbWPSr5yeUX4b3V8m7YME4HDz11L7eqdmuwhaaKUi8kzhC5LI3Q/go1uAKLpqugENu5DASiUhj4hcCVC9xkqr7rolAxbxY=
Received: from BYAPR11MB3256.namprd11.prod.outlook.com (2603:10b6:a03:76::19)
 by BY5PR11MB3910.namprd11.prod.outlook.com (2603:10b6:a03:185::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27; Thu, 1 Apr
 2021 20:56:32 +0000
Received: from BYAPR11MB3256.namprd11.prod.outlook.com
 ([fe80::41e6:b61:67ef:2712]) by BYAPR11MB3256.namprd11.prod.outlook.com
 ([fe80::41e6:b61:67ef:2712%5]) with mapi id 15.20.3977.033; Thu, 1 Apr 2021
 20:56:32 +0000
From:   "Moore, Robert" <robert.moore@intel.com>
To:     Jianmin Lv <lvjianmin@loongson.cn>,
        "Kaneda, Erik" <erik.kaneda@intel.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>
CC:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] ACPICA: Events: support fixed pcie wake event
Thread-Topic: [PATCH] ACPICA: Events: support fixed pcie wake event
Thread-Index: AQHXJu9jxEF7iGMf1Ea4RLAMgiSl4qqgJNvg
Date:   Thu, 1 Apr 2021 20:56:32 +0000
Message-ID: <BYAPR11MB3256C7F3C17D14C1DF544430877B9@BYAPR11MB3256.namprd11.prod.outlook.com>
References: <1617278736-7400-1-git-send-email-lvjianmin@loongson.cn>
In-Reply-To: <1617278736-7400-1-git-send-email-lvjianmin@loongson.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: loongson.cn; dkim=none (message not signed)
 header.d=none;loongson.cn; dmarc=none action=none header.from=intel.com;
x-originating-ip: [134.134.136.194]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 76556335-91db-4e16-9dfc-08d8f550a11f
x-ms-traffictypediagnostic: BY5PR11MB3910:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR11MB391074CFD7431124DFAF371C877B9@BY5PR11MB3910.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9VSKmVPKZ4VRHVHwWblbKB+23WNWUfxzz0qfoJBxzBtsQAc0U4S6ruUo5kypXRrqrdF7Nv/YIw1DLgaTlNh8CW+9iwhSKAt26p0QMuCJymIQ07fpiiBo3MzGlrkgWotiOAMNSsOAw9hSrJpZcDhdZB9JFZ8PEJ/6QuEGc8Z0BJ+P+2fcsfQR/t+lshFVxrP/+n6yCjjIN+dMiRehgkbFXwV34HbSuGXyTfDhVcCeSVwbmuaj86xwXRPC6wt8FsucOek0A548uCi7//Z8thWuVke3+kDjfkMf8+f+3Cbgcvdofhy3ApzYdfe3HXc7lkmDcKpWecbJfzmqcB4qcpoorcNK1re7dP07GTmkNmYlPHk8ok7B+0BXVMpj7lvSMLAbGNDiPfFHVpBZwBHFqQWbWyVyYAWAPb8lvmdS9AjMpoqCEwX8CAjXp/j5lyngC/YKQlj85Gc4zQfSJlRh67rHjDjBDueuugTFUsaZdgM02MugeaYxUqaMU2vSBlQ0g8IsQaA3tFmRKtU8BfwudVL7eS4hDCeoGDz2ZpFAVO1RrFw6e6ytpEDLXJX/3EbbbsLcT0M8DshlHzz3UDc+VjoqRC5fhVJqFNR3NGXgKZ3jba9PTnxIJEWYw2yavk49TveEZaxBDXx/AREdJJ0zuyT/xNhR5BzKhtPdBKvpeLOeV7Y=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3256.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39860400002)(396003)(346002)(136003)(376002)(66446008)(66556008)(64756008)(26005)(8936002)(53546011)(66946007)(4326008)(2906002)(71200400001)(186003)(55016002)(9686003)(38100700001)(5660300002)(6506007)(66476007)(478600001)(7696005)(110136005)(8676002)(54906003)(52536014)(76116006)(33656002)(86362001)(83380400001)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?pbEUt54ZQFtTROM9j/UdIp+8VvXS7Q6ZV9FfQWARG6We8DYn/zkgFDy3gHLZ?=
 =?us-ascii?Q?vb9f3FvY8TWebEtQhv8/FOE+6iE40lbw/M1fJqzou5glvHTQ8Wi/W64hXXij?=
 =?us-ascii?Q?ROEoGt1gbZoppZPjbLosilIWt4z6Av2OD+igrqEm918Z/bLSvP8HLjKIqQ55?=
 =?us-ascii?Q?FepxkqmeLlbUe52SxOSAC6ExJn5U9THxOTGOBRt0cZPoLv2KKKGaX+iMFCbt?=
 =?us-ascii?Q?4r97qhlW6/2+at3cAHAfKCUqn/UYADWm2Y8omWyvKKfVPfYRbU/kIPzXyLTF?=
 =?us-ascii?Q?gYWmjW61ltE2ncZT0pZa8M7Tv0T/WQOJche6JXTDMzDdU6MekBYW4uFW5I/n?=
 =?us-ascii?Q?VWJgf++IoYTzSgvuKeO3bfaJUdqYFAjF6DVAFAqj6EyV32X2RFGwIzgK+W/l?=
 =?us-ascii?Q?nUZXqq6W6G3KyoDoBx/ivqzCji1KemzeXzrDd2xk4SDtl7K4K+siFw/ZEJIU?=
 =?us-ascii?Q?R8EQ+YtWtQNRzy72YnOkuOewJvG4Fs6fw59P0hdeTJb9DVX0PifOqClZiLPC?=
 =?us-ascii?Q?cIfWpc7yzFJ9X+XY31+4YHlzb3o8vcavW76LlXbbkc2xjgY+LpoTNH4T8x28?=
 =?us-ascii?Q?C7QSW/36O7kaDo0VKhlu/mkn9F71Ff6K0JAsBSISuLspBPpgskE34HWXNUuj?=
 =?us-ascii?Q?325jluuuC0OssjdsSbxsqfuTtd7+cB88t+2K4PD0DHrisXIZOswySLgbn7TE?=
 =?us-ascii?Q?SJDtxYjcII6fnz6OlQaQgJz9PzgasOEsjwhOpDty/ai114M628Butlhir9jo?=
 =?us-ascii?Q?Kmv4vBKbDaUchw4uzvXsh/kcOltWuISbJOFYWKYF2EkuW1Smcqn8q9S/OYsO?=
 =?us-ascii?Q?j+4p9N3hxw9p31JXsWIskZ0WD48ZOOcX/9kaWlh2+7lOFImfLe2meZ86WWsb?=
 =?us-ascii?Q?cLRs15bIxvulIOetMO1hpPW9dV4Z62wb2zF+VIcMVrnbGnCfkiGHS9FH6IrM?=
 =?us-ascii?Q?iYAeRMKdpf36wXRBoDgZfqygkdVOSTsQylkQYemfCbYX7kow/kQWIuXKSNO3?=
 =?us-ascii?Q?SJ/b9vb12VaCjzOu4Zp3v7rcfUitSZPxJbq2JfELXKrMJ3BLxuYDgreg2oum?=
 =?us-ascii?Q?sWcjAKqwyiXmU3cUR6Yck3zY2VDHPvqU+YzyqM6wOi4T2AA7Y9KFQR8p38Ag?=
 =?us-ascii?Q?axM35hVFljk5seujku0GxVyec2wAUl+i7SVfyN0tONlpxrY6OMOtCWv08s8a?=
 =?us-ascii?Q?XyRGMNwkdS0QNwfTXgJn8oiMBa8/P0X79EzxH7FKpL2Tvt56pFoR7//Gks4w?=
 =?us-ascii?Q?8g+HiaMTZ7TPiCcC35H2ev1vW+/KlCK+ITOuiKPl7VzK3pl1AwsrIs9G8DaZ?=
 =?us-ascii?Q?j6iXYDJEKO5WdKi90uj6okea?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3256.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76556335-91db-4e16-9dfc-08d8f550a11f
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2021 20:56:32.1148
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HQgT7mpRanI/RtFeFrXtbpG3uMp7ujI1DoLjwhIh9OhHYTZcIDa1Y1Fg1upzQKksL/NnLNA6atGs7FKiHiyDzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB3910
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Can you send/point us to the spec that this change is based upon?
Thanks,
Bob


-----Original Message-----
From: Jianmin Lv <lvjianmin@loongson.cn>=20
Sent: Thursday, April 01, 2021 5:06 AM
To: Moore, Robert <robert.moore@intel.com>; Kaneda, Erik <erik.kaneda@intel=
.com>; Wysocki, Rafael J <rafael.j.wysocki@intel.com>; Len Brown <lenb@kern=
el.org>
Cc: linux-acpi@vger.kernel.org; devel@acpica.org; linux-kernel@vger.kernel.=
org; lvjianmin <lvjianmin@loongson.cn>
Subject: [PATCH] ACPICA: Events: support fixed pcie wake event

From: lvjianmin <lvjianmin@loongson.cn>

Some chipsets support fixed pcie wake event which is defined in the PM1 blo=
ck, such as LS7A1000 of Loongson company, so we add code to handle it.

Signed-off-by: lvjianmin <lvjianmin@loongson.cn>

diff --git a/drivers/acpi/acpica/evevent.c b/drivers/acpi/acpica/evevent.c =
index 35385148fedb..08ba368beb2d 100644
--- a/drivers/acpi/acpica/evevent.c
+++ b/drivers/acpi/acpica/evevent.c
@@ -185,6 +185,10 @@ u32 acpi_ev_fixed_event_detect(void)
 		return (int_status);
 	}
=20
+	if (fixed_enable & ACPI_BITMASK_PCIEXP_WAKE_DISABLE)
+		fixed_enable &=3D ~ACPI_BITMASK_PCIEXP_WAKE_DISABLE;
+	else
+		fixed_enable |=3D ACPI_BITMASK_PCIEXP_WAKE_DISABLE;
 	ACPI_DEBUG_PRINT((ACPI_DB_INTERRUPTS,
 			  "Fixed Event Block: Enable %08X Status %08X\n",
 			  fixed_enable, fixed_status));
@@ -250,8 +254,8 @@ static u32 acpi_ev_fixed_event_dispatch(u32 event)
 	if (!acpi_gbl_fixed_event_handlers[event].handler) {
 		(void)acpi_write_bit_register(acpi_gbl_fixed_event_info[event].
 					      enable_register_id,
-					      ACPI_DISABLE_EVENT);
-
+						event =3D=3D ACPI_EVENT_PCIE_WAKE ?
+						ACPI_ENABLE_EVENT : ACPI_DISABLE_EVENT);
 		ACPI_ERROR((AE_INFO,
 			    "No installed handler for fixed event - %s (%u), disabling",
 			    acpi_ut_get_event_name(event), event)); diff --git a/drivers/acpi/a=
cpica/hwsleep.c b/drivers/acpi/acpica/hwsleep.c index 14baa13bf848..7e7ea4c=
2e914 100644
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
c index 59a48371a7bc..68baf16d8a02 100644
--- a/drivers/acpi/acpica/utglobal.c
+++ b/drivers/acpi/acpica/utglobal.c
@@ -186,6 +186,10 @@ struct acpi_fixed_event_info acpi_gbl_fixed_event_info=
[ACPI_NUM_FIXED_EVENTS] =3D
 					ACPI_BITREG_RT_CLOCK_ENABLE,
 					ACPI_BITMASK_RT_CLOCK_STATUS,
 					ACPI_BITMASK_RT_CLOCK_ENABLE},
+	/* ACPI_EVENT_PCIE_WAKE		*/ {ACPI_BITREG_PCIEXP_WAKE_STATUS,
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

