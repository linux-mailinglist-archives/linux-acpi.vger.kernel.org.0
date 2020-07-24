Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0260022CB09
	for <lists+linux-acpi@lfdr.de>; Fri, 24 Jul 2020 18:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726326AbgGXQ3S (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 24 Jul 2020 12:29:18 -0400
Received: from mga11.intel.com ([192.55.52.93]:31756 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726317AbgGXQ3R (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 24 Jul 2020 12:29:17 -0400
IronPort-SDR: i93LXEcdtGDm6jSNOEMjFUfClQ9BaMiEk0tMAOjNw5rr91hGEBCfpo4YyVpm7uTptsitQoNj+f
 6MXhB7gfvzwg==
X-IronPort-AV: E=McAfee;i="6000,8403,9692"; a="148650198"
X-IronPort-AV: E=Sophos;i="5.75,391,1589266800"; 
   d="scan'208";a="148650198"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2020 09:29:17 -0700
IronPort-SDR: sG3HMKz/l6nrh9NiKBfR312kXkYWAcAZ6ZBVO+mmyAMbvAXjw50akAX0tspA3Y+T4oSpKu5abS
 FG0KcxAPSpGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,391,1589266800"; 
   d="scan'208";a="272622695"
Received: from orsmsx109.amr.corp.intel.com ([10.22.240.7])
  by fmsmga008.fm.intel.com with ESMTP; 24 Jul 2020 09:29:17 -0700
Received: from orsmsx154.amr.corp.intel.com (10.22.226.12) by
 ORSMSX109.amr.corp.intel.com (10.22.240.7) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 24 Jul 2020 09:29:16 -0700
Received: from ORSEDG002.ED.cps.intel.com (10.7.248.5) by
 ORSMSX154.amr.corp.intel.com (10.22.226.12) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 24 Jul 2020 09:29:16 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.175)
 by edgegateway.intel.com (134.134.137.101) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 24 Jul 2020 09:29:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C5u+8b7525iYNuIRb2o9MMsRkVVp8R1O0cFRRBi1caH5+iZMa+GzB8frAblBcRjtWGtDBBO1TjqO/BRhe4tq1X5LEa0diRqk85StEr9Y92LRWVGQCzo219BgrdLbJIcELHq2Bjxptnbi+URzsMoi+q5+Mdr8mA0vF3svdYpPxGEhfyWt7RKoSsYF6ilTLGS4Or6/l/kfNCZWnXZa5OPcxodMT92S9VFqB5/tSHSybNGYrZMoz3m6ZgGzwar9VwdsGPzrntixQjBAW75ldOvF/ZM9pa6ZTQAk+h1+GPkM4Zt5PSwEu5TEQBqxfLBH4+fBBXWKeH+g9/OEJXtDREsz9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ClhGZQfzEknTY3Xz+gWQcA4qmiN1qINZPZ3Vou3qNCw=;
 b=EBcp9DkGub1BdYRPWSbD9/0A0C3yod2yeh0KG35hjpQOW+Rrt/foroLiC9wju0qd13Yz5HdGrShJlIw5BbtyUb5wONfSjKjw440mLjRTKhbAh3FxZlb10hcKYxEVpZv8Dc/UjPN76GaaRw7s+T0jcbpemNJS+sURgK70deQtyHCDlxPUmrPzYE0CcVFX2E8GcJja/vlhHLI/LOs3d2DCckety2Ct0BkUnkcTCYWlXosXyI0TAjwTy5mVdUfmw2dPqa6c75XghstK/OQDRUHgGcb3+48Kvgnc0et8SxR0VLgiYiNvq0rnU6i6vhFzLEwn2AnJhFIZyDaCunE/3Myhmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ClhGZQfzEknTY3Xz+gWQcA4qmiN1qINZPZ3Vou3qNCw=;
 b=sHFiNN9qdwuTLtKY4+KP0z8kWtFd2r49s5dMFWpO2DNoxVi04hWRBn9vYnmyuaXW8yosYqVqRJ/7tLDqUHRtIlkZZB+CYnmiW/eiIMMPfyjiFazcWx9pJPP+YXmL/ZRAkN8cXlXMax4V7wbWiWIEdX1pybjlLvvuEIi2IwmUUa0=
Received: from BYAPR11MB3256.namprd11.prod.outlook.com (2603:10b6:a03:76::19)
 by BYAPR11MB3400.namprd11.prod.outlook.com (2603:10b6:a03:1a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Fri, 24 Jul
 2020 16:29:14 +0000
Received: from BYAPR11MB3256.namprd11.prod.outlook.com
 ([fe80::4ca7:fbfa:78bf:173c]) by BYAPR11MB3256.namprd11.prod.outlook.com
 ([fe80::4ca7:fbfa:78bf:173c%4]) with mapi id 15.20.3216.023; Fri, 24 Jul 2020
 16:29:14 +0000
From:   "Moore, Robert" <robert.moore@intel.com>
To:     Garrit Franke <garritfranke@gmail.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "trivial@kernel.org" <trivial@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: RE: [PATCH] trivial: acpi: replace some bitshifts with BIT macro
Thread-Topic: [PATCH] trivial: acpi: replace some bitshifts with BIT macro
Thread-Index: AQHWYdZ+JdA88oPRJEuxGV8RX7TGgakW62Cg
Date:   Fri, 24 Jul 2020 16:29:14 +0000
Message-ID: <BYAPR11MB325604ACC5F3BCCEB89A58AA87770@BYAPR11MB3256.namprd11.prod.outlook.com>
References: <alpine.DEB.2.21.2007241814450.2834@hadrien>
 <20200724162050.18077-2-garritfranke@gmail.com>
In-Reply-To: <20200724162050.18077-2-garritfranke@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [134.134.136.194]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dfcd87c2-ab38-4d5b-cb53-08d82feeb442
x-ms-traffictypediagnostic: BYAPR11MB3400:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB3400021A147BC7733C51556C87770@BYAPR11MB3400.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: M8mP7bQA3D6NT246BLHrPyHUJoKE8g2EIRjn+ECodpC8G05cBBzwTJ0r4AVKJ+yN6Fk0kq0ZbkHW2lhcYk1cJy0RlLp/OddseYmKomodX4urwpo1v7DLhVwN6kh6swcbITw1iGk4g0Ylk/iPMYIKS52rN+ssBHSlsbI198T3nJyJ8sC8FugDTVDqKThE2c4ax2piJj/eBOfT9PWl2QAl8qy2Z/Kmji8DJh3LHvIcPsCzXGs3/najkkDUvSn+J/4bYdjBgoVztfb9ohgmJ7CHHorgWzsPu77kAfIZM0IAalzIO89JN/k8mfk1K9bI9aEU
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3256.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(366004)(346002)(396003)(136003)(39860400002)(186003)(26005)(83380400001)(7696005)(110136005)(53546011)(6506007)(478600001)(2906002)(52536014)(316002)(5660300002)(8936002)(66556008)(66476007)(64756008)(66946007)(66446008)(76116006)(8676002)(33656002)(71200400001)(86362001)(55016002)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: m6MDckNa0heibQ3It+twfjHhjjFZGdoVVvhPztUAns2BDpJus/R1/NNDOK+InooAAyB8wkUpNeRsbe6p1cLr4jPH9AY7w3seZLQNFdz5/FOi3hy27XgOQy3lzn2PU/C0AshoD3s5yzAbMPCxFi/JpOMZz+2nWBAhun99PIjpk0liYTs8aJVAh/I2oASxPlr0j9kiK8GWoAHWVn89jJVqhYx3kuZZ2tpaVIPJr/PFVd0PSmWIZxQMqjCuaHybuTXBEdN0PNh/89fl6CtdQ7EwJjnYS9yIX4bJkAPeq0MMaQ4cBSAVFOGQuWWqknvmXVQlVUUD4z2xkpmdEtRXVlNUJHhHWKLU82XDfGPA8WBh9bZdKGsswp2TFEFifk9j/Ilsudy1y3a+EQV0s5ov7/CdZbdOXeXOFZyNJcy+Sds54Yrkpzc9yS4I9KlZLJP8ju0CuM0fvIC1NIrCVIErwKHTsbIJ7mtB+PXHQerX2Tk1KTBrO06hrfR76Ovihn0swvky
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3256.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfcd87c2-ab38-4d5b-cb53-08d82feeb442
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2020 16:29:14.5203
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7bx0Ot9Gnmanv3ybJBGO5sspUn+Lm72d1kGVXtcDLuAgbc5OpsPDLenM3HqCb1eISKMlY2sJMqcopNalg8KmlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3400
X-OriginatorOrg: intel.com
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Where is "BIT" defined?


-----Original Message-----
From: Garrit Franke <garritfranke@gmail.com>=20
Sent: Friday, July 24, 2020 9:21 AM
To: Moore, Robert <robert.moore@intel.com>; Wysocki, Rafael J <rafael.j.wys=
ocki@intel.com>; lenb@kernel.org; trivial@kernel.org; linux-acpi@vger.kerne=
l.org; devel@acpica.org; kernel-janitors@vger.kernel.org
Cc: Garrit Franke <garritfranke@gmail.com>
Subject: [PATCH] trivial: acpi: replace some bitshifts with BIT macro

Signed-off-by: Garrit Franke <garritfranke@gmail.com>
---
 drivers/acpi/acpica/exfldio.c   | 2 +-
 drivers/acpi/acpica/utownerid.c | 6 +++---
 drivers/acpi/bus.c              | 2 +-
 drivers/acpi/sleep.c            | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/acpica/exfldio.c b/drivers/acpi/acpica/exfldio.c =
index ade35ff1c7..92fc702456 100644
--- a/drivers/acpi/acpica/exfldio.c
+++ b/drivers/acpi/acpica/exfldio.c
@@ -298,7 +298,7 @@ acpi_ex_register_overflow(union acpi_operand_object *ob=
j_desc, u64 value)
 		return (FALSE);
 	}
=20
-	if (value >=3D ((u64) 1 << obj_desc->common_field.bit_length)) {
+	if (value >=3D ((u64) BIT(obj_desc->common_field.bit_length))) {
 		/*
 		 * The Value is larger than the maximum value that can fit into
 		 * the register.
diff --git a/drivers/acpi/acpica/utownerid.c b/drivers/acpi/acpica/utowneri=
d.c index d3525ef8ed..c4e2db2f54 100644
--- a/drivers/acpi/acpica/utownerid.c
+++ b/drivers/acpi/acpica/utownerid.c
@@ -74,13 +74,13 @@ acpi_status acpi_ut_allocate_owner_id(acpi_owner_id *ow=
ner_id)
 			 * int. Some compilers or runtime error detection may flag this as
 			 * an error.
 			 */
-			if (!(acpi_gbl_owner_id_mask[j] & ((u32)1 << k))) {
+			if (!(acpi_gbl_owner_id_mask[j] & (u32)BIT(k))) {
 				/*
 				 * Found a free ID. The actual ID is the bit index plus one,
 				 * making zero an invalid Owner ID. Save this as the last ID
 				 * allocated and update the global ID mask.
 				 */
-				acpi_gbl_owner_id_mask[j] |=3D ((u32)1 << k);
+				acpi_gbl_owner_id_mask[j] |=3D (u32)BIT(k);
=20
 				acpi_gbl_last_owner_id_index =3D (u8)j;
 				acpi_gbl_next_owner_id_offset =3D (u8)(k + 1); @@ -171,7 +171,7 @@ voi=
d acpi_ut_release_owner_id(acpi_owner_id *owner_id_ptr)
 	/* Decode ID to index/offset pair */
=20
 	index =3D ACPI_DIV_32(owner_id);
-	bit =3D (u32)1 << ACPI_MOD_32(owner_id);
+	bit =3D (u32)BIT(ACPI_MOD_32(owner_id));
=20
 	/* Free the owner ID only if it is valid */
=20
diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c index 54002670cb..39ea=
d80c45 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -233,7 +233,7 @@ acpi_status acpi_run_osc(acpi_handle handle, struct acp=
i_osc_context *context)
 		goto out_kfree;
 	}
 	/* Need to ignore the bit0 in result code */
-	errors =3D *((u32 *)out_obj->buffer.pointer) & ~(1 << 0);
+	errors =3D *((u32 *)out_obj->buffer.pointer) & BIT(0);
 	if (errors) {
 		if (errors & OSC_REQUEST_ERROR)
 			acpi_print_osc_error(handle, context, diff --git a/drivers/acpi/sleep.c=
 b/drivers/acpi/sleep.c index aff13bf4d9..38f5210313 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -880,7 +880,7 @@ static void acpi_sleep_run_lps0_dsm(unsigned int func) =
 {
 	union acpi_object *out_obj;
=20
-	if (!(lps0_dsm_func_mask & (1 << func)))
+	if (!(lps0_dsm_func_mask & BIT(func)))
 		return;
=20
 	out_obj =3D acpi_evaluate_dsm(lps0_device_handle, &lps0_dsm_guid, 1, func=
, NULL);
--
2.25.1

