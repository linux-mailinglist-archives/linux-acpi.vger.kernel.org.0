Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AD0059EAD2
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Aug 2022 20:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbiHWSVE (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 23 Aug 2022 14:21:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234478AbiHWSUk (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 23 Aug 2022 14:20:40 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E554DDAB5
        for <linux-acpi@vger.kernel.org>; Tue, 23 Aug 2022 09:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661272645; x=1692808645;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=q5tZ2EuP1+FWSSB8M/9YCHRlTm6wkUbl0wLP1NtdyTo=;
  b=IXOI4KSxjVyLkmQ1p2x1yqfO4/o0AvhCYJPCpLGwMrFz+gSIwkPq3vzG
   8gP7oAyPst/DgTUf7JQDHieqTwEfqnbMAHFexzF+njR65nupGznmID3Ch
   n7nOCh/SJHjAibATxP2an0PPN4WMsVFkCEwwWq06Q+Vr/vXicuwZKkGGY
   Km9bnS6uHOU0+dAuBhyCUiSaBMwvRWTc/VeuL+SClXolA2Q83fxCr9us+
   h3kbuAx1QLzGhcJ/tfMG3CpP4Grc/sIIsm0/92Z9GsWC1+A7JDsFLgJ7U
   pUkYdl3oSPqZMhE1DrWQRoSzYmK0g6uxes6eVg/ihFcjieRxT2Q3OK6OD
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10448"; a="276764884"
X-IronPort-AV: E=Sophos;i="5.93,258,1654585200"; 
   d="scan'208";a="276764884"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2022 09:37:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,258,1654585200"; 
   d="scan'208";a="712674771"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga002.fm.intel.com with ESMTP; 23 Aug 2022 09:37:24 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 23 Aug 2022 09:37:23 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 23 Aug 2022 09:37:23 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 23 Aug 2022 09:37:23 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 23 Aug 2022 09:37:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Da1xIinrz0ccOGAqiAkeiRP45/NgyKxYbJm1w9SMBZuNZ8S8Gva3+0lDb7o0NV/RaJIGNl5qmrz/e7CrJWncRj27ZBs9kUvPWZa1tqw/J5P0Xz1z37wakdMxYusXzsID3qpnQK9T0iFgktJ5YCGJVasp3LyDxydnkvLFLwFyB/bQaDrB9sAE5eVvIoclA3xFvwTnl6oE3bb7Qv2oO1aUnRT2wg9XAinKyLhnG+VNHZz8Ka7BCBE4huD8e8vl9ZG7ZLQf5i1Jse3OvmUToAE/i5dpLvvWe15q08aGW6E++oCiDn/o1E/uDO/7BIKk75p0SgK2s3pcnsmSu6oGEshesA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q5tZ2EuP1+FWSSB8M/9YCHRlTm6wkUbl0wLP1NtdyTo=;
 b=RwDBrUABp1CjnqKMSElPSkfmzgqLEo1SwDIRYu/VDuA836ILwzVSxC6zVEtNDOVOsg1xTZraPtWYZUHB3oUbzPNH3J5BZ5sAVPTkRPDWVW1X7+QRsCuAMx59HZg1zmnVHMETuRD1PFYy6Jg5CPC6ogqYErloCmucfd4/B/VJ9Dcg/8tXMsnxGn3GI9TfeEQZxow2Cv+5WdSy1ObozejhO3xWO6U5OGOIq6cDZMuWdxZN2dgEHel57KhHY7LmpBMXnGRcNwXFXFB7g0wk96dSnHDA6vYaeC5uewuySpvoRhAxGgy/uIusBPic6K8pyz/TZaWRd7MJ2srYAl4sAeV4tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by DM6PR11MB3019.namprd11.prod.outlook.com (2603:10b6:5:67::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.16; Tue, 23 Aug
 2022 16:37:21 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::8daf:550d:185b:6d5b]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::8daf:550d:185b:6d5b%6]) with mapi id 15.20.5504.024; Tue, 23 Aug 2022
 16:37:20 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
CC:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Subject: RE: [PATCH] ACPI: APEI: Add bert error log footer
Thread-Topic: [PATCH] ACPI: APEI: Add bert error log footer
Thread-Index: AQHYtw2bqZwT/FaOZEKtO5qjig43Sq28rrJA
Date:   Tue, 23 Aug 2022 16:37:20 +0000
Message-ID: <SJ1PR11MB6083F1978718F475E0F5C9C6FC709@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <1660554889-174857-1-git-send-email-dmtrmonakhov@yandex-team.ru>
 <CAJZ5v0hi8jRukb26Th6QX60a9pd9CAZ6wuKYV8zGqtYt4iFKzg@mail.gmail.com>
In-Reply-To: <CAJZ5v0hi8jRukb26Th6QX60a9pd9CAZ6wuKYV8zGqtYt4iFKzg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.500.17
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9057149b-919f-48e4-ed7f-08da8525c00e
x-ms-traffictypediagnostic: DM6PR11MB3019:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hw+Fi3/wcjACWY8h1ozIFwQT6c67HgBEYSR3zI9g/IWwzGazvIK9i5l7JVvPzqIbbGamGBrvNIjomB5a+QatjoeJ6hFVa1wWr3cmDn8zUQwB1Pwf8SaJUgcx9eqaDQVaD08G1S7nxTk3u1yo+5e8c4ATwFxvXvj+SA63oiQQxkBCcqjCh16CXAY9G8pmiVvPjmrWdbnCVQV+NH9jNijEYkjyRs552dWEusaYM2XFhb4DExMpPiMSYQPTx/ciQCjXLP25Oaq/r2dXhCGYBRt7WactYtp7RvTYKu/o5uj6diAUNj3aINd9UQj8FVPWYvx+PX5+SXas/po2G9+1H0wFUBuEWswPXXunYMLfij6Gm7GRhJNcK58rMC5X45b4wgGFPHk7quGnTR102txGQceMBhVvPINtUtZvEa18HeMJBMqMe3T+gVaTDHVtUXHzoipM/6eG9p79LBTSuyvPTRBwiV0V04N3X3vqftKMuEtG+fZ7CePzQqv5xXxN/wSG3TA9UEuDeCLmhgiDv/N6HISbIzEwGtwWmGl9Ke/qzmwtwkOiHx5ogPdUqY3f12pxYp4fHdYVwg04NASopaw1Z44UcuLfZ5YkFADYX5J03rVUiRnlu8B/cy7z4Y6rXLbjtowhbH4o6nwnC1P609rpJ+fR0tqrTOHhHrrDJFCnEMvhyBefjrun5ZAEm5CK4X7vd4ABVlv9JecjO3UXjHJV3x6DjnbWlIy0cK7lbxpTsJUztHQbbGs9H74lcpw3rUFswWD/YR3Vbq0dFh9a/9ZZsXTKiA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(346002)(39860400002)(136003)(366004)(396003)(2906002)(6506007)(5660300002)(55016003)(76116006)(8676002)(4326008)(66446008)(66476007)(66556008)(66946007)(64756008)(558084003)(9686003)(110136005)(26005)(316002)(71200400001)(478600001)(41300700001)(33656002)(7696005)(38100700002)(82960400001)(38070700005)(186003)(86362001)(52536014)(122000001)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Ukd3c1hOTEJVTGtvbk9HNUxrSEJSZnlZVnRMUDJiVmd5MlBrYUo5TCtoYldC?=
 =?utf-8?B?Mk1FTkJWUElXNTM2enYwQmphOUlJTlVTOGxBTzhxcnpYbkdKckVFdjdrS0FK?=
 =?utf-8?B?R0dwZGpnZ01zLzQzd21lL2M0Zm5nTTF3U1FRZ0liNnBnbmFibElmdzZ5TVc4?=
 =?utf-8?B?UDFTRmRvalI1TmpFa0N4cENPOGw5OHlTalUzaDhXa3JQbFZjcGEvMEhKQ1NY?=
 =?utf-8?B?TWZYTkxHc2FDTDdQWFdTekJIMWNSajRvZkRkMnR2Nm43aVBTMkRKQXB2Q2JC?=
 =?utf-8?B?S2cydWRZTDVOdTd6bmRiN2Roa2d5TmNIWElSd3VyeS90QnVoU0QxeFc5Z0tj?=
 =?utf-8?B?Ym84Mk5udzRQVnM3Ui9NSUpMa1RsQnh6K1RwbFVCRWdIM251REJwVVJodUVw?=
 =?utf-8?B?QnR5WDJGNG5WU2hlR0lwVk03N2Rpbm5KRk9rU2QzZVdOYmxpV3lHQlVMRVJV?=
 =?utf-8?B?OFBSaVFyaFUrNUJZSnhjUmg5dkhmbVVFSm50bTZmWjNjR3BZSW5nWlVIMTlx?=
 =?utf-8?B?cm16aDc2NmE3dzFFdG1sQ284QlFPYTdVNitvMWF6M2pmS1A4cEE2NU1LYjJv?=
 =?utf-8?B?ZVFSNjhvKzNKbjJRTERSRlBkTWlmQ2ExNzNYeEhpd0pETFhLSDN3a3NwUVNz?=
 =?utf-8?B?dHJwRU9kS1kyUjdmcW5GcGh3N2lJNnFoaCtydWVtRVlIZkkwTmh4cWxIa1dq?=
 =?utf-8?B?emt4d1F3djFRUjg4U2x4SVdaT0toSEMvMUluRTZ1TEt1NWdseisrc2hvMEJP?=
 =?utf-8?B?VUZCTVkrWmllVTFPNTBGUWpKb1hNK2ZuOFlZYm9JaENmTnVITmlLUGhHMVF0?=
 =?utf-8?B?c2JDekJ3d0Z3NWlHekhWVk12b1VjV1QyQks2STlobE14cUd2aEpzTUtjNjVp?=
 =?utf-8?B?K2thUU1udVl3ZzJRbnlnbzk3eG0razdVazVJMVA1STlBUWh3VzMwclVod0wy?=
 =?utf-8?B?RzF5WHY3MTdEdGV6TWthNEVuWU14VzA1bXQrNEVHSjhIK1l5WlFlbjBRWFNp?=
 =?utf-8?B?N2I1TGxSN1JFd0dZQ3V2WnRuUWkvV0wxWUIwTEdRK2xVUnQ4NC9pbDRuNE4x?=
 =?utf-8?B?UmFzMjExUWo3eFo3Z2JBT0FzRWxVUVNQZTlvR2FTRjB0NE13ZTE5VXJlMmFj?=
 =?utf-8?B?YkZUcWpOajhiMnJmVEIzZ3RpT2drTS8veEhwQWNFL1JTcHA3a1hudk0wdXhL?=
 =?utf-8?B?Z1NGNHdCckt1VHNrWTl4cHlUWVpVNktGTnY2ME9UcnN0YStWY0FvQ2lJV2N5?=
 =?utf-8?B?Z2grNU5IVWluUU9Gc3hjRzRxVmtKT3NkaWFlVG0wVnA4RXRxU2U2ZkM4NXc0?=
 =?utf-8?B?U3d5aUt1dHNoVEN0NXorUm1VYWxJQmZMVzF1MDNJRmNyRUJ3OHg2d2pBekNt?=
 =?utf-8?B?YzEyalZROEVIeFZRREw0QzNYKy8zYU40ZXQxbGtpMmNvaGJCcTRpdnVTTEty?=
 =?utf-8?B?Mll1a2pSaG81RzJjL1BpbVlMVTdncUZUUG5Fdm0zVnM1TEhmVlcvU2V0eHRZ?=
 =?utf-8?B?Z1Y0bkJoemNDYk5hTGtHNmNhUC9vNVQ5Qzl2T21GekloVnZRR0FucVBuYlJN?=
 =?utf-8?B?RC9VcHBYZnpLV0ZWSGhvOTM0dm1xanJwRUlNd2srZHIwbnYwdXZJUnpkSkQ4?=
 =?utf-8?B?Y1RKOXRmN2NjZVZOTTVBOU9kaUlNK1ZneDFXNUdiMk01azVaV0x1dFFhOHBr?=
 =?utf-8?B?aG1QUVpWM01mdnFsUTIwZGxnYnpNWTFRT2ZqeDc1TnkzeGVkVTZmSDU5Nmlu?=
 =?utf-8?B?Y3dqK20vVXlrd3drSkRyTHRxc3Jod1hjWjRFU1dxUDNIbExUdG9pWUdVZEp2?=
 =?utf-8?B?WUdTMi9PZDl4R0JPcmlxd2JxTFd1dVdNZk41NU00NmN5YVdaWHcvRTNHNDlx?=
 =?utf-8?B?akFwckZPS3BQaVNNdy9iK1dKR1ZsamFPTlRuSlBIMXlrRzkyaFM1T1Z0Tytw?=
 =?utf-8?B?SUpUTG1kQllKbmhJOS9Sbll1c25CSitEU2VvVkxCTHl3MkQ5YldmMUxYS0dM?=
 =?utf-8?B?cmVPNWNWY004RGMrZG4xMGFlNmY2a3lqOStoWEFWRzdlL1VWZDZpeGs2VU83?=
 =?utf-8?B?bFRXOXpONnNlWTZpb0loenJTZ2swWWROb3lJVWxuOWdUbmJ2TlRXSDdNNC9n?=
 =?utf-8?Q?QNApNb2GqzasiNmN24IHqr9o2?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9057149b-919f-48e4-ed7f-08da8525c00e
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2022 16:37:20.8365
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N+QquEql6VyyS2LFMrbnSVyEUVNKLZ08xKdSUNdvMQ3xXSDoFeWdXHeU7do2MXwnQaVGSuMZ+IqFZcMVtublfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3019
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

PiArICAgICAgIGlmIChwcmludGVkICsgc2tpcHBlZCkNCj4gKyAgICAgICAgICAgICAgIHByX2lu
Zm8oIlRvdGFsIHJlY29yZHMgZm91bmQ6ICVkXG4iLCBwcmludGVkICsgc2tpcHBlZCk7DQoNCkNv
bmNlcHQgc2VlbXMgZmluZS4gU28gd2l0aCB0aGUgcy9iZXJ0L0JFUlQvIGNoYW5nZXMgaW4gc3Vi
amVjdCBhbmQgYm9keS4NCg0KQWNrZWQtYnk6IFRvbnkgTHVjayA8dG9ueS5sdWNrQGludGVsLmNv
bT4NCg0KLVRvbnkNCg==
