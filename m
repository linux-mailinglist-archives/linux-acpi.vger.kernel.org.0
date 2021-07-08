Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE3EA3C1B11
	for <lists+linux-acpi@lfdr.de>; Thu,  8 Jul 2021 23:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbhGHViS (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 8 Jul 2021 17:38:18 -0400
Received: from mga07.intel.com ([134.134.136.100]:32816 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231357AbhGHViR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 8 Jul 2021 17:38:17 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10039"; a="273438415"
X-IronPort-AV: E=Sophos;i="5.84,225,1620716400"; 
   d="scan'208";a="273438415"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2021 14:35:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,225,1620716400"; 
   d="scan'208";a="458048302"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga008.jf.intel.com with ESMTP; 08 Jul 2021 14:35:31 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Thu, 8 Jul 2021 14:35:30 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Thu, 8 Jul 2021 14:35:30 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Thu, 8 Jul 2021 14:35:30 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.175)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.4; Thu, 8 Jul 2021 14:35:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S1E1AzghEr5AjLSymhuFjBYb8fQtAS7NLVD3BbidmivnYEZBIRPsfPSvfLltp1G0v4q7XLcKw7e8xV57Kpeb/bvdOPP8k1uOIpwvI+afklbmU3Dn1cfBVJE5CRe5YJow1EEtmyXGphRVGvU/eksuvuuEijBsthv4yv3sX0z618AOtC9T291yWVVOJL079/cvi/di/JtqMzBYpVRUr9xQPoPaX/KaSR/Il2lPWGSa09OFVzqfgNl78B94NmfttzEXjQD7QxvdVpETvTJLfbVQVKyLKuUr5o8k0XiaU94SrtcQFWu6z0dkd23ujyP+Xe9fV1ZocaBGScLFInDBzVZ+Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gv0i3V4OQQs7xuIYe7y4iDWN7CPxQ5usNIRYyPZok78=;
 b=Zvv4despS41SzbLRSP9l35RjMRIcuiQNQGV9K45bWqn5Guxp66bTFSwIOcMiAZcX1/EQ49NzM7z7sO0eVTCOryZS8lyQh9qzYSa3huhooaed283Xba8ENa5rc2n12ZK5yqD+w1hDEgiNUehFiGeUsuid0yBaeul0mqVnc4KwVe5B8nn5nwsSu7AVjgv9I7WusUUmOKVl+/1galzcH235wHpkorl7rrnhcPRD78KgE/Q1iDQfFJ/s+wspe2qZOHyfNm64h677e0YCwpWZuIHCKXj6gBJ25cow+svAA5apLwhDkxNxo6RxSlcHTh4c31TkNr/wgksxGKQjR5aAJkaJRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gv0i3V4OQQs7xuIYe7y4iDWN7CPxQ5usNIRYyPZok78=;
 b=oVtmoqHxUOwkA6VCzYgNtQTegxqOhzBJcR7MtC/OniZ8gN4cvZ7DvQDdsNQpwO4zTuJZTZUhsC4MUBVBoJs+xAshuAt2qJ4ttXpU7KOvTUwhTUNpxkto6HH2n1sV2LUgIqWub1NMOcfFxQnzwCP1w2FAGVDBGPWdhJyAI/m8wCQ=
Received: from BYAPR11MB3256.namprd11.prod.outlook.com (2603:10b6:a03:76::19)
 by SJ0PR11MB5069.namprd11.prod.outlook.com (2603:10b6:a03:2ad::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.21; Thu, 8 Jul
 2021 21:35:28 +0000
Received: from BYAPR11MB3256.namprd11.prod.outlook.com
 ([fe80::f1f3:ba46:dd24:f466]) by BYAPR11MB3256.namprd11.prod.outlook.com
 ([fe80::f1f3:ba46:dd24:f466%7]) with mapi id 15.20.4287.035; Thu, 8 Jul 2021
 21:35:28 +0000
From:   "Moore, Robert" <robert.moore@intel.com>
To:     Huacai Chen <chenhuacai@loongson.cn>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Erik Kaneda <erik.kaneda@intel.com>
CC:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Jianmin Lv <lvjianmin@loongson.cn>
Subject: RE: [PATCH 2/3] ACPICA: MADT: Add LoongArch APICs support
Thread-Topic: [PATCH 2/3] ACPICA: MADT: Add LoongArch APICs support
Thread-Index: AQHXcZtKDJ5NIaum80mIdx2iRldsxqs5nrNA
Date:   Thu, 8 Jul 2021 21:35:28 +0000
Message-ID: <BYAPR11MB3256468A574CA349AB8D1F0087199@BYAPR11MB3256.namprd11.prod.outlook.com>
References: <20210705124206.1228958-1-chenhuacai@loongson.cn>
 <20210705124206.1228958-3-chenhuacai@loongson.cn>
In-Reply-To: <20210705124206.1228958-3-chenhuacai@loongson.cn>
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
x-ms-office365-filtering-correlation-id: 7fa46329-30d5-43b6-30ac-08d942584e59
x-ms-traffictypediagnostic: SJ0PR11MB5069:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR11MB50697431182D43B79179390187199@SJ0PR11MB5069.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1332;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 50TQgIqy/UJzJa194Xq4wY+jqIZjzO42gtZcZSNU7+cZ4Q/t2dC/mhQ5xTcW+0zENTKwqSLXtfj/eh3uk0FLQIa7Re5lOr8BSqGupofup4446MT/LYpjMU/33Do6JfDeIKVYPINMcoXi16H1A0lorZ4sAs+trKbpxhh5CAIqFtBczacc4WvCgSTydV6wwB2h7XYGRsO+fZVHPp0hlad0WoxMfWvusLsxAszlBYbawL/imPRxs1yAlGbcQxFClVdHZhSqQPu7+qetqDxrY3q+wk3NJnXjCLkfQmdWWjfBjdRjF3VcrniVhaBuM8wV0xmipi/vGnW6oiL/VlPPZhMnU8UjZvbvSJtg1NxCRNT053UtCYGQq/M8XXHcRPX8x7PLdLjOrI6MM3IB/QR5DwN7iVNt5QCL0oZesKB6rNWiAA2DkxHBv4PLXIQW5exj5IroUy2ylGqmQHRaAnl1HleNAbFPE2MUl7F4wlBnaotb4ruZvpOuLWl5ki8VKIbPcVUBBNNJXI0RhzZEK1XAYxrRJ6Vr87k0OI9fgnqkQPqdAqfL8Yz+7G4t7sBX6QRwAPwKgWlwGIsc6+Rgjk1mftj19tMF8wN8eneJ0BzuYWnRqrZ8AFJFqdBgJNMPyYFsLsIQ7o6q0I2CCEIT1ynRkFeeXUJ52amXmgU8UaqP5d74WSRlvLRVwkrCqtbkZC/s0NhRoru6fIv85tdi0bknoaFUZJtbmfpnyBBIC+5wDnGLnYY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3256.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(376002)(39860400002)(396003)(136003)(83380400001)(71200400001)(478600001)(54906003)(186003)(316002)(16799955002)(4326008)(122000001)(966005)(110136005)(6636002)(86362001)(66556008)(2906002)(66446008)(38100700002)(53546011)(33656002)(6506007)(55016002)(9686003)(64756008)(8676002)(5660300002)(8936002)(7696005)(52536014)(66946007)(26005)(76116006)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zBOESd8deWw+6GoBxv6TjXmqAJMRvITcq9XDcoANlI+ViuA166oxK21iV8Un?=
 =?us-ascii?Q?jIFOXuWuIBHYG/F6lQFSVCTuO+NAnIw2vvBQeaCQ+f95xaH/SHS4jGB2bKYP?=
 =?us-ascii?Q?uMcvXz3c0GZxPSLN1n2RXaGP9D8Le89/ciDwvWhMNub4Ta1Rb6bLJ0QzTe03?=
 =?us-ascii?Q?kk5+vXgRLASEjLe8adb9EqAaTcVvcRSBZivNopkPVEL7hfHMKZUpm94lobx8?=
 =?us-ascii?Q?2hwE1FHt50CK21413RUPDh/oMy3T/KvacFwPH1Pi0cz7VEyzDUgwEQ+gccvA?=
 =?us-ascii?Q?gKSpKEWQHl4rdA+JkI5lMQXVYNSoUTS2Efqio7nbvqTIaQ5GkbbcUFDAkd28?=
 =?us-ascii?Q?5+MwDxHFIpjVNTeUT/k59gBaGPtaLQ+UzWEcqpOl+E4QH4H10pxRopK3GK+R?=
 =?us-ascii?Q?GRp2jfhVHAgYuPHINhbzdUYKfKCSQw4i9BJfDn26smisK+bCbzu1j9uBtQV4?=
 =?us-ascii?Q?FyqimgRUy9MIEEM6PwQk+yyJsXGh3DD26Eqy+7HkAKqcRK0pYtCtvwSZ+7uA?=
 =?us-ascii?Q?vkgTitQSe3fd4aPG8VRTkvoC2JDDjcTZuhpcJMoGTpwvuAYLSzb0Lop2vsHZ?=
 =?us-ascii?Q?vPhPWtbBiM/jpu6SVS1PuoW3I0ms48mDZGxq9ObWZWUPX5UEv0ZZn5jEafye?=
 =?us-ascii?Q?U7uWIZN5PaEg9C91bSWPzyTW+8S7JtdBCgZfAI59aZdGXq+IMMqxUtM3RWtm?=
 =?us-ascii?Q?Qhw8zvcxZyrTK7LE330jE/qFXF+dVeR+V+4FBXco9ZkUfJaWk3aOFoVX6jmQ?=
 =?us-ascii?Q?yk2UQ6mcZan2BWLeSya3NZkpoFPOGcpRBaSjV86ERQt1hol2FCgkiWyDuUYU?=
 =?us-ascii?Q?+fOs37+g1ojw0YZMf3RTn9FyrQ27lz3cuiNz+LvIop9RNdK11NBGKP+Itlpu?=
 =?us-ascii?Q?0er7v8B8Gq03kL56e6Y0iqawHjNeRg8v6rYfcxOESC6OjaiFJETnnA0VHxzJ?=
 =?us-ascii?Q?IKymmcGy147l1Dke9VkuQ48V6j9aN9XGnUH3czXcUimIl6uLoNWgr5gvZO2j?=
 =?us-ascii?Q?/+irVXQTxGCr4FRkJujxAgs5u7U5P1S5yLDf4tP9ecQ4jOiEz+TnaZl/ABvF?=
 =?us-ascii?Q?767O6pEKi2Irj62o8KXMgO98er8HG4rsDYaWriavUQ5QwW2YJ1M3EAJ41tmo?=
 =?us-ascii?Q?fEkXyZFP3NfqXvi2Jq/ksXoI56Mnr2tgUrBYoPpMRd0gwGsCcQ8OMCspf13r?=
 =?us-ascii?Q?NxqHcI7YAaHpYDNo1P3M6nC3D8QdbsNELfECAF9MMSpZTI5zU9j/3IkjBYN0?=
 =?us-ascii?Q?LXi8mAuLwEsfb0NkAsKlCRlDZiUif4e13smVCnDtJgy4WyIwprHAx25lTbIS?=
 =?us-ascii?Q?wW3HpX6mhBPKzSv89rk9JcyP?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3256.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fa46329-30d5-43b6-30ac-08d942584e59
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2021 21:35:28.7619
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7vbul8rozMCm43mR0o2ObHS36F4x+NhM46gDex2xTZ54RxrLlASltu+2XpnTsqmwm+eE50SDNKQxLRH+XhstQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5069
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

For legal reasons, we can't pre-release any upcoming ACPI spec changes in A=
CPICA.

-----Original Message-----
From: Huacai Chen <chenhuacai@loongson.cn>=20
Sent: Monday, July 05, 2021 5:42 AM
To: Rafael J . Wysocki <rjw@rjwysocki.net>; Len Brown <lenb@kernel.org>; Mo=
ore, Robert <robert.moore@intel.com>; Erik Kaneda <erik.kaneda@intel.com>
Cc: linux-acpi@vger.kernel.org; devel@acpica.org; Xuefeng Li <lixuefeng@loo=
ngson.cn>; Jiaxun Yang <jiaxun.yang@flygoat.com>; Huacai Chen <chenhuacai@l=
oongson.cn>; Jianmin Lv <lvjianmin@loongson.cn>
Subject: [PATCH 2/3] ACPICA: MADT: Add LoongArch APICs support

LoongArch-specific interrupt controllers (similar to APIC) are added in the=
 next revision of ACPI Specification (current revision is 6.4), which inclu=
ding CORE_PIC (CPUINTC), LIO_PIC (LIOINTC), EIO_PIC (EIOINTC), HT_PIC (HTVE=
CINTC), BIO_PIC (PCHINTC), LPC_PIC (PCHLPC) and MSI_PIC (PCHMSI). This patc=
h add their definition and handlings.

Reference: https://mantis.uefi.org/mantis/view.php?id=3D2203
Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 drivers/acpi/tables.c |  10 ++++
 include/acpi/actbl2.h | 123 +++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 132 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c index a37a1532a5=
75..5943ae4f76bb 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -208,6 +208,16 @@ void acpi_table_print_madt_entry(struct acpi_subtable_=
header *header)
 		}
 		break;
=20
+	case ACPI_MADT_TYPE_CORE_PIC:
+		{
+			struct acpi_madt_core_pic *p =3D
+			    (struct acpi_madt_core_pic *)header;
+			pr_debug("CORE PIC (processor_id[0x%02x] core_id[0x%02x] %s)\n",
+				 p->processor_id, p->core_id,
+				 (p->flags & ACPI_MADT_ENABLED) ? "enabled" : "disabled");
+		}
+		break;
+
 	default:
 		pr_warn("Found unsupported MADT entry (type =3D 0x%x)\n",
 			header->type);
diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h index 2069ac38a4=
e2..fd6d0b440c4b 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -571,7 +571,14 @@ enum acpi_madt_type {
 	ACPI_MADT_TYPE_GENERIC_REDISTRIBUTOR =3D 14,
 	ACPI_MADT_TYPE_GENERIC_TRANSLATOR =3D 15,
 	ACPI_MADT_TYPE_MULTIPROC_WAKEUP =3D 16,
-	ACPI_MADT_TYPE_RESERVED =3D 17	/* 17 and greater are reserved */
+	ACPI_MADT_TYPE_CORE_PIC =3D 17,
+	ACPI_MADT_TYPE_LIO_PIC =3D 18,
+	ACPI_MADT_TYPE_HT_PIC =3D 19,
+	ACPI_MADT_TYPE_EIO_PIC =3D 20,
+	ACPI_MADT_TYPE_MSI_PIC =3D 21,
+	ACPI_MADT_TYPE_BIO_PIC =3D 22,
+	ACPI_MADT_TYPE_LPC_PIC =3D 23,
+	ACPI_MADT_TYPE_RESERVED =3D 24	/* 24 and greater are reserved */
 };
=20
 /*
@@ -801,6 +808,120 @@ struct acpi_madt_multiproc_wakeup_mailbox {
=20
 #define ACPI_MP_WAKE_COMMAND_WAKEUP    1
=20
+/* Values for Version field above */
+
+enum acpi_madt_core_pic_version {
+	ACPI_MADT_CORE_PIC_VERSION_NONE =3D 0,
+	ACPI_MADT_CORE_PIC_VERSION_V1 =3D 1,
+	ACPI_MADT_CORE_PIC_VERSION_RESERVED =3D 2	/* 2 and greater are reserved *=
/
+};
+
+enum acpi_madt_lio_pic_version {
+	ACPI_MADT_LIO_PIC_VERSION_NONE =3D 0,
+	ACPI_MADT_LIO_PIC_VERSION_V1 =3D 1,
+	ACPI_MADT_LIO_PIC_VERSION_RESERVED =3D 2	/* 2 and greater are reserved */
+};
+
+enum acpi_madt_eio_pic_version {
+	ACPI_MADT_EIO_PIC_VERSION_NONE =3D 0,
+	ACPI_MADT_EIO_PIC_VERSION_V1 =3D 1,
+	ACPI_MADT_EIO_PIC_VERSION_RESERVED =3D 2	/* 2 and greater are reserved */
+};
+
+enum acpi_madt_ht_pic_version {
+	ACPI_MADT_HT_PIC_VERSION_NONE =3D 0,
+	ACPI_MADT_HT_PIC_VERSION_V1 =3D 1,
+	ACPI_MADT_HT_PIC_VERSION_RESERVED =3D 2	/* 2 and greater are reserved */
+};
+
+enum acpi_madt_bio_pic_version {
+	ACPI_MADT_BIO_PIC_VERSION_NONE =3D 0,
+	ACPI_MADT_BIO_PIC_VERSION_V1 =3D 1,
+	ACPI_MADT_BIO_PIC_VERSION_RESERVED =3D 2	/* 2 and greater are reserved */
+};
+
+enum acpi_madt_msi_pic_version {
+	ACPI_MADT_MSI_PIC_VERSION_NONE =3D 0,
+	ACPI_MADT_MSI_PIC_VERSION_V1 =3D 1,
+	ACPI_MADT_MSI_PIC_VERSION_RESERVED =3D 2	/* 2 and greater are reserved */
+};
+
+enum acpi_madt_lpc_pic_version {
+	ACPI_MADT_LPC_PIC_VERSION_NONE =3D 0,
+	ACPI_MADT_LPC_PIC_VERSION_V1 =3D 1,
+	ACPI_MADT_LPC_PIC_VERSION_RESERVED =3D 2	/* 2 and greater are reserved */
+};
+
+/* Core Interrupt Controller */
+
+struct acpi_madt_core_pic {
+	struct acpi_subtable_header header;
+	u32 processor_id;
+	u32 core_id;
+	u32 flags;
+	u8 version;
+};
+
+/* Legacy I/O Interrupt Controller */
+
+struct acpi_madt_lio_pic {
+	struct acpi_subtable_header header;
+	u64 address;
+	u16 size;
+	u8 cascade[2];
+	u32 cascade_map[2];
+	u8 version;
+};
+
+/* Extend I/O Interrupt Controller */
+
+struct acpi_madt_eio_pic {
+	struct acpi_subtable_header header;
+	u8 cascade;
+	u8 version;
+};
+
+/* HT Interrupt Controller */
+
+struct acpi_madt_ht_pic {
+	struct acpi_subtable_header header;
+	u64 address;
+	u16 size;
+	u8 cascade[8];
+	u8 version;
+};
+
+/* Bridge I/O Interrupt Controller */
+
+struct acpi_madt_bio_pic {
+	struct acpi_subtable_header header;
+	u64 address;
+	u16 size;
+	u16 id;
+	u16 gsi_base;
+	u8 version;
+};
+
+/* MSI Interrupt Controller */
+
+struct acpi_madt_msi_pic {
+	struct acpi_subtable_header header;
+	u64 msg_address;
+	u32 start;
+	u32 count;
+	u8 version;
+};
+
+/* LPC Interrupt Controller */
+
+struct acpi_madt_lpc_pic {
+	struct acpi_subtable_header header;
+	u64 address;
+	u16 size;
+	u8 cascade;
+	u8 version;
+};
+
 /*
  * Common flags fields for MADT subtables
  */
--
2.27.0

