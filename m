Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB8504DBF0A
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Mar 2022 07:12:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbiCQGNw (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 17 Mar 2022 02:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbiCQGNR (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 17 Mar 2022 02:13:17 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC912221BA2;
        Wed, 16 Mar 2022 22:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647496262; x=1679032262;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=+viz+QYgxuzou9aIPC1dlzdY5c64yzm42y59YRpTAU8=;
  b=fdyucc4JEA5DTZAf6jp90v7puzuVp8P7BSyEKEA/hXp6zWZdUxP1Ngx+
   WGv0lWyn7IeL2QAtAiIiBjqU21OuPzN/VWiGCwenrlz+jDcelytDCe+ZQ
   hRN8y/aKM5s6eqDrt+SJuLFme2eCqfXBJCORiPK7s1xvBx+gnOp0KSpmi
   V7NY+Te3CFViLo+8nWB7GrzcwDqR1inuITP3uaT3ELSX4ISP83tu1mrnz
   ePQfjduESBpU0tcQ4YKz+Puw1THKlKveW32QP2puZJ8gNQL0b3Hs6BXKl
   ZhQUUH6VKDP5Qmq4Oh8n4kN+gDtG1K7MQl6NjXFq7LdZKrV09tl9kPuVR
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10288"; a="254331571"
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="254331571"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 20:49:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="646904373"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga004.jf.intel.com with ESMTP; 16 Mar 2022 20:49:51 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 16 Mar 2022 20:49:51 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Wed, 16 Mar 2022 20:49:51 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Wed, 16 Mar 2022 20:49:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bbA+dct3KMTHG070TyTmqAS2KHxsrA3J0y/m/9QIpCXacq8se1m4ZMUHZra4y43Y09sSKpBGlYOnEpgWT3NieoJnqBMqlur39jscqKccOeKiezPowuy+JE3HsySygKbfqAek/AI87g0+sj1zbSZJWWchXqQKY5cQiZWIYs/Bh+6BT30mKB1t83ub1Tiabp29RXMJYb5al4IiZAlnZLxyQ3HNiw5h7ZDtK+gfyAueZoDtK3es8i065l4yQU3Vb+/9lnKKt/a42muivZNYOA3vQo6MZOD77mabauSXvp2OvoXVsQJnYOvh6JlFuDYbrCoXqQXe8lOr3Ll6nkhMQQBFKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+viz+QYgxuzou9aIPC1dlzdY5c64yzm42y59YRpTAU8=;
 b=aujLmoPGep3x0ey6lWboZCMT3956OSDJBn0vOgHvKuh/gCkCYafiv2H41d1bjmfUbaGOAYear2VYB4FcIr+GX9XpHGiXRRRrDrLv63At96PqpBuz+3jTQs6S1NPq+xeZjhKQJ0hVEBhgUWaNKScQPkGDyqwPskGq7eew2aF0hVxnW4ybunq57ZaQk13R0gtlHZypLHx2KUPvyylKH9h1ej3I6Zw1ssS8kKvrR7QS2/Ootf9n5hZtbwop0RHpCvtyLeSLsvPwLtuBZdjBlUNSffe3IIXkAx5UgNaPn1aDHqnApLflW6k4nQKmRPFdr5M+ptM7XZ0bDP4fMMmaTLtSBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB3999.namprd11.prod.outlook.com (2603:10b6:208:154::32)
 by MWHPR11MB1679.namprd11.prod.outlook.com (2603:10b6:301:f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Thu, 17 Mar
 2022 03:49:48 +0000
Received: from MN2PR11MB3999.namprd11.prod.outlook.com
 ([fe80::d898:84ee:d6a:4eb1]) by MN2PR11MB3999.namprd11.prod.outlook.com
 ([fe80::d898:84ee:d6a:4eb1%6]) with mapi id 15.20.5081.015; Thu, 17 Mar 2022
 03:49:48 +0000
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "Williams, Dan J" <dan.j.williams@intel.com>
CC:     "rafael@kernel.org" <rafael@kernel.org>,
        "Moore, Robert" <robert.moore@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: Re: [RFC PATCH 2/2] acpi/pci_root: negotiate CXL _OSC
Thread-Topic: [RFC PATCH 2/2] acpi/pci_root: negotiate CXL _OSC
Thread-Index: AQHYOZXEX0UItFxD/USR0kvjsLOzz6zC6HmAgAAIcoA=
Date:   Thu, 17 Mar 2022 03:49:48 +0000
Message-ID: <7c577fd6c824890144b698a9e7164ab334b14016.camel@intel.com>
References: <20220317002704.1835870-1-vishal.l.verma@intel.com>
         <20220317002704.1835870-3-vishal.l.verma@intel.com>
         <CAPcyv4iOOrefEF5QOrZyvPYJ9_5GuhpMKPeSbvVXci=qGevmBw@mail.gmail.com>
In-Reply-To: <CAPcyv4iOOrefEF5QOrZyvPYJ9_5GuhpMKPeSbvVXci=qGevmBw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.42.4 (3.42.4-1.fc35) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 224b48fe-7ae6-4a27-b13a-08da07c92f2f
x-ms-traffictypediagnostic: MWHPR11MB1679:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-microsoft-antispam-prvs: <MWHPR11MB16791FC154519CE2D6AD8D17C7129@MWHPR11MB1679.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dyMFolb75HfBesdbJUrNxayfl1lqCLycTgoVHRk+XSN0WDB+1PR7+5uFzLownaGpfAf6qvwX9GF9a4/1ysDe03/2U7UExNaq5vrBtX8ZuUdMu4jDRYuzKLoPfUCLIlGtpW0hrjXNbxwOMFzuist7SPumhDi/EhKK+MI4Eh1z24zKFIc6ZuR9M00OGtt4rOQGSLXTyKk0i1FJB7vBwPhwGB4Dgi+DtjWzYUXqWmpo3uS4oXSyzCAa/+zebBXUSdI1KQXlLUp3SmGnrdoevGq3eW1b5pqKVFGp++O2EVnTlT9npo5OXbdLXISOssYzqhQATh9iGdywbHJK9FGGcFpJUfWy+Eu/EypVQ8eq/rGv/c9Z/P2Q3iRlKcxvPtiVrCipoXbY7PVKhjAt0OHlK0+wblhtqmpjcbuFIhXB56cifNPHHWAAopSCO2PI946QmqKHgIeeTkn0IkofkwGj8do4xzBYJvAlUeEJ3OnSiDc4VMXddHUXnnk0zEC0Hj1x8MQZd+GxokhPDdnIs3BarjAj7BrkGlP/JkiRnbkw20IiaPyOdoXTiDNVVhK95q2TS0yHJbmUuYY2PmzhFIaQZ8R6ywu+eQOrG8dVi8ek3Xq9WpymuuX2M2ubS4ve2pJsq8XrMmmWq28Qfb0DRZYQpkMpFeQipFz2rFJQ3BD8x96ax+uCZ6I0KIh39mJjJJYa4LYD1jueveZaXPYxvKWS2ug6qi1h/KYydY/MzoqP4EpEf/LtNxFZdlPw+//2C51OT3GQwZ7uAKmmb5LancMprED5dTU8HginZ7CAuClrBBTZCV8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3999.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(54906003)(83380400001)(37006003)(6636002)(316002)(91956017)(6506007)(76116006)(6862004)(8676002)(4326008)(66556008)(66476007)(66446008)(64756008)(66946007)(2906002)(186003)(26005)(53546011)(86362001)(71200400001)(2616005)(36756003)(966005)(6486002)(5660300002)(508600001)(82960400001)(122000001)(6512007)(8936002)(38100700002)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UlhMYlp1OFlCN01jelRTZXNKemYvRjJnamVNMVFUeEw3VW9PRDE2cUpFQ1Nm?=
 =?utf-8?B?dmpYdS9CbytJZ28xZWdlQ1VxYkk2bFRaa01ML3VUSEhWVG9LK1N4YWVrdHRJ?=
 =?utf-8?B?VnV1VmVQajBqRzQ3WHJNUXg0MVNaV1hkWitQSk53a1VlZHhjWWVMaHN4VmZk?=
 =?utf-8?B?UUNMWWJjT0pjeGJVVjNMYUM0QjJ5SFFZam5tT3dmTlRuK04wZ1lXalVueVpo?=
 =?utf-8?B?YzJJL2EwaDhHYjJuSHl1b0lSQzJYTTdGa0djejVocWhTM00xYXNoMmk5bEIy?=
 =?utf-8?B?WWVDazdTRHErb2F1RWlVYnh2bE1wT0t3NHMzcEo2N2FpdG5oSU9XYXpQays5?=
 =?utf-8?B?VjIxVDJpRThZVTVScTQzWDNVdlJTZkZGUnpSbFlndHhSbUduTmJrUHRLN0M0?=
 =?utf-8?B?NXhjVG81YlhtVzJMRFNyZ0tUeXJFUzlMK2kvWTJFRU01TmRoR3VyZVdqMkJk?=
 =?utf-8?B?U2ZiTWdleFlxVGRvT1AvTzFLQ2wyU3gwN2MwMjUzZFpGdEp2Ynl1aXhhbGM5?=
 =?utf-8?B?UjZBV01GNHN5bGFNTzJCaTYxa3pZM1VPd29vL2EzUzA2MHBoeVNSSGcrTXps?=
 =?utf-8?B?UkQ1bXdCbGtDTGw2U3dzNEJqVnJHUStRQ285YWtiUzRNb3JaNzhLMkRUNW95?=
 =?utf-8?B?b0c5ek1lWk5QTUM0YWFNSGU5WnZ2NmUya28rNm1rRGE4elJudElWNktTVGxL?=
 =?utf-8?B?bWI5c0lheVRZMlAvOUFFNUpSVUVWM2pnZUxoQzJKeWc1TStieFZXcCtudWRC?=
 =?utf-8?B?ZFcySzBtSVYyUEpFbDc2eFRSMExpZXJQT3Z3eGJ4UnBwZGE4Wk5aQUkxR0hJ?=
 =?utf-8?B?eWU0M3dXZlJObEg0bDdUUE82Q3dORmpVNWlsYUkvYTVIYjBUREp6ajlUVVpl?=
 =?utf-8?B?a1dydTYxWjB0K2tmRUlzWE4vWkJHMzJMTmRYWXlmYkM5QTRYSFBiRTJCVjZh?=
 =?utf-8?B?SzhFK01EWnZRK0NPZWxsZUNpZWpKTEtIbFVrbzZVWHZRL3F2TytpYUFZbjhH?=
 =?utf-8?B?djlxODVpK3EvWlcwdTRtL1hkWjlHenRFbVFESGpXWnJlUHVPSVJxVld3Mk5H?=
 =?utf-8?B?eFYyRnhVRkZ4QTZUTlZmUGJOOFNXdkh1dEszeU9zc2RQTXYzR1ZNUjRaMlRP?=
 =?utf-8?B?NkJjNndjZittSkFTdGRBTmdKbWp0ZWo5U0FkYm82L1ZPZXh6dG1GSDhaWTkz?=
 =?utf-8?B?aEVQR2NnWjQ5cHBTcDFRY0dEeDhaaklScG9YcEtYMlIzMmJvVDMxNTl4Q3ND?=
 =?utf-8?B?dG9TUURrcmxZQzdNdlI0QmQwS3FGZTFieEYxWkh0RGE0WFpheEphakJCVW9z?=
 =?utf-8?B?Vko4RW1lSTVuMnNKbzAxNjVMemQ0UzJvdklaZ0p0S0E3VVhXc2ZFTm1TMW9Y?=
 =?utf-8?B?RG9HbjhSa1BrbnJKZSt6TmhGRlRPakF3ZjBDSkpManh2ektMazZYWmlCdnVz?=
 =?utf-8?B?aDVsYXZaNzJ0Mm1KN1NOdGI1bkwwQnJWbENyWTNKbTh6dGUzYnZPSlFkTlZs?=
 =?utf-8?B?eG5PeVo1NVc0NzV6aUxKUlBraDNJU3pTdm14ZlZhLzhWK0paTEliNUl0RlpD?=
 =?utf-8?B?c1BvR0xKbk8wdk1Rb2FOdXdkWkh3K3pqSVZVRDNFUjZJeWF2c3ZTbWd6SFZt?=
 =?utf-8?B?Wnh4WkxUNG1pS0ZoclJuR3RFK0V4RlFEK1QxWTg4TW5tQjlsaVA2K3dZZHYz?=
 =?utf-8?B?eWF1Q2xJTlNjT0pJWWdwOWJvYStkWGo4bHJYc0FsNTd2bi8vaDFWNVFrYVJk?=
 =?utf-8?B?UmJqZDkzMFdhUkF5S3BKM3ZtdWxYZ2pHQXNKS055RHJad21rN2t0bUsvV0FH?=
 =?utf-8?B?YWtleUxnUlNaN29pYUxPV093TnFaSnNpUVF1d0pQKzE0Um96OW51Q3VGVFlU?=
 =?utf-8?B?Z2VHTHJNRnJDUkZLMXBsZlY1TUsvQVpBTjl0cXZGbFNHeWphaHdGcUhqZERh?=
 =?utf-8?B?WG56MlVxSEVSSG4xbFEzSmpCM2ZndnIyanljOW0wYzdMMXh2aWtrT0tGSUNH?=
 =?utf-8?B?aWFXb2dVU1NRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B078C08CECD4FD45B2498E7480659D10@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3999.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 224b48fe-7ae6-4a27-b13a-08da07c92f2f
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2022 03:49:48.6415
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xKxHYjsJGkkWz2wUhxO2VNSYoU5kS4z1919a11Q0Mrk2B5rN2n+KwBpGsSyDnbepPLE5MvFviJwzybXtB8Ds8R+zvYVMFa+d6ma50BHx8Lc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1679
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

T24gV2VkLCAyMDIyLTAzLTE2IGF0IDIwOjE5IC0wNzAwLCBEYW4gV2lsbGlhbXMgd3JvdGU6DQo+
IE9uIFdlZCwgTWFyIDE2LCAyMDIyIGF0IDU6MjcgUE0gVmlzaGFsIFZlcm1hIDx2aXNoYWwubC52
ZXJtYUBpbnRlbC5jb20+IHdyb3RlOg0KPiA+IA0KPiA+IEFkZCBmdWxsIHN1cHBvcnQgZm9yIG5l
Z290aWF0aW5nIF9PU0MgYXMgZGVmaW5lZCBpbiB0aGUgQ1hMIDIuMCBzcGVjLCBhcw0KPiA+IGFw
cGxpY2FibGUgdG8gQ1hMLWVuYWJsZWQgcGxhdGZvcm1zLiBBZHZlcnRpc2Ugc3VwcG9ydCBmb3Ig
dGhlIENYTA0KPiA+IGZlYXR1cmVzIHdlIHN1cHBvcnQgLSAnQ1hMIDIuMCBwb3J0L2RldmljZSBy
ZWdpc3RlciBhY2Nlc3MnLCAnUHJvdG9jb2wNCj4gPiBFcnJvciBSZXBvcnRpbmcnLCBhbmQgJ0NM
IE5hdGl2ZSBIb3QgUGx1ZycuIFJlcXVlc3QgY29udHJvbCBmb3IgJ0NYTA0KPiA+IE1lbW9yeSBF
cnJvciBSZXBvcnRpbmcnLiBUaGUgcmVxdWVzdHMgYXJlIGRlcGVuZGVudCBvbiBDT05GSUdfKiBi
YXNlZA0KPiA+IHByZS1yZXF1aXNpdGVzLCBhbmQgcHJpb3IgUENJIGVuYWJsaW5nLCBzaW1pbGFy
IHRvIGhvdyB0aGUgc3RhbmRhcmQgUENJDQo+ID4gX09TQyBiaXRzIGFyZSBkZXRlcm1pbmVkLg0K
PiANCj4gTWlnaHQgd2FudCB0byBhZGQgYSBjbGFyaWZpY2F0aW9uIGhlcmUgb2Ygd2h5IHRoaXMg
anVzdCByZWZsZWN0cyB0aGUNCj4gUENJZSBzdXBwb3J0IGludG8gdGhlIHNpbWlsYXIgQ1hMIGZp
ZWxkcy4gRm9yIGV4YW1wbGU6DQo+IA0KPiBUaGUgQ1hMIHNwZWNpZmljYXRpb24gZG9lcyBub3Qg
ZGVmaW5lIGFueSBhZGRpdGlvbmFsIGNvbnN0cmFpbnRzIG9uDQo+IHRoZSBob3RwbHVnIGZsb3cg
YmV5b25kIFBDSWUgbmF0aXZlIGhvdHBsdWcsIHNvIGEga2VybmVsIHRoYXQgc3VwcG9ydHMNCj4g
bmF0aXZlIFBDSWUgaG90cGx1Zywgc3VwcG9ydHMgQ1hMIGhvdHBsdWcuIEZvciBlcnJvciBoYW5k
bGluZyBwcm90b2NvbA0KPiBhbmQgbGluayBlcnJvcnMganVzdCB1c2UgUENJZSBBRVIuIFRoZXJl
IGlzIG5hc2NlbnQgc3VwcG9ydCBmb3INCj4gYW1lbmRpbmcgQUVSIGV2ZW50cyB3aXRoIENYTCBz
cGVjaWZpYyBzdGF0dXMgWzFdLCBidXQgdGhlcmUncw0KPiBvdGhlcndpc2Ugbm8gYWRkaXRpb25h
bCBPUyByZXNwb25zaWJpbGl0eSBmb3IgQ1hMIGVycm9ycyBiZXlvbmQgUENJZQ0KPiBBRVIuIENY
TCBNZW1vcnkgRXJyb3JzIGJlaGF2ZSB0aGUgc2FtZSBhcyB0eXBpY2FsIG1lbW9yeSBlcnJvcnMg
c28NCj4gQ09ORklHX01FTU9SWV9GQUlMVVJFIGlzIHN1ZmZpY2llbnQgdG8gaW5kaWNhdGUgc3Vw
cG9ydCB0byBwbGF0Zm9ybQ0KPiBmaXJtd2FyZS4NCj4gDQo+IFsxXTogaHR0cHM6Ly9sb3JlLmtl
cm5lbC5vcmcvbGludXgtY3hsLzE2NDc0MDQwMjI0Mi4zOTEyMDU2LjgzMDM2MjUzOTI4NzEzMTM4
NjAuc3RnaXRAZHdpbGxpYTItZGVzazMuYW1yLmNvcnAuaW50ZWwuY29tLw0KDQpZZXMgdGhhdCBz
b3VuZHMgZ29vZCwgd2lsbCBhZGQuDQoNCj4gPiANCg0KWy4uXQ0KDQo+ID4gQEAgLTQ0MCw2ICs1
MTEsMTggQEAgc3RhdGljIHUzMiBjYWxjdWxhdGVfc3VwcG9ydCh2b2lkKQ0KPiA+IMKgwqDCoMKg
wqDCoMKgIHJldHVybiBzdXBwb3J0Ow0KPiA+IMKgfQ0KPiA+IA0KPiA+ICtzdGF0aWMgdTMyIGNh
bGN1bGF0ZV9jeGxfc3VwcG9ydCh2b2lkKQ0KPiA+ICt7DQo+ID4gK8KgwqDCoMKgwqDCoCB1MzIg
c3VwcG9ydDsNCj4gPiArDQo+ID4gK8KgwqDCoMKgwqDCoCBzdXBwb3J0ID0gT1NDX0NYTF8yXzBf
UE9SVF9ERVZfUkVHX0FDQ0VTU19TVVBQT1JUOw0KPiA+ICvCoMKgwqDCoMKgwqAgc3VwcG9ydCB8
PSBPU0NfQ1hMX1BFUl9TVVBQT1JUOw0KPiANCj4gSSB3b3VsZCBleHBlY3QgdGhpcyBvbmUgdG8g
YmUgZ2F0ZWQgYnkgcGNpX2Flcl9hdmFpbGFibGUoKSBzaW5jZSB0aGVzZQ0KPiBlcnJvcnMgYXJl
IHJlcG9ydGVkIGJ5IFBDSWUgQUVSLg0KPiANCj4gUGVyaGFwcyBhbHNvIHMvUEVSL1BPUlRfRVJS
T1IvPyBJIGtlZXAgcmVhZGluZyBQRVIgbGlrZSAncGVyJyBhcyBpbiAncGVyLWNwdScuDQoNCkV4
cGFuZGluZyB0aGUgYWNyb255bSBzb3VuZHMgZ29vZCwgdGhvdWdoIGl0IGlzIFByb3RvY29sIEVy
cm9yDQpSZXBvcnRpbmcsIG5vdCBQb3J0Lg0KDQo+IA0KPiA+ICvCoMKgwqDCoMKgwqAgaWYgKElT
X0VOQUJMRUQoQ09ORklHX0hPVFBMVUdfUENJX1BDSUUpKQ0KPiA+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHN1cHBvcnQgfD0gT1NDX0NYTF9OQVRJVkVfSFBfU1VQUE9SVDsNCj4gPiAr
DQo+ID4gK8KgwqDCoMKgwqDCoCByZXR1cm4gc3VwcG9ydDsNCj4gPiArfQ0KPiA+ICsNCj4gPiDC
oHN0YXRpYyB1MzIgY2FsY3VsYXRlX2NvbnRyb2wodm9pZCkNCj4gPiDCoHsNCj4gPiDCoMKgwqDC
oMKgwqDCoCB1MzIgY29udHJvbDsNCj4gPiBAQCAtNDcxLDYgKzU1NCwxNiBAQCBzdGF0aWMgdTMy
IGNhbGN1bGF0ZV9jb250cm9sKHZvaWQpDQo+ID4gwqDCoMKgwqDCoMKgwqAgcmV0dXJuIGNvbnRy
b2w7DQo+ID4gwqB9DQo+ID4gDQo+ID4gK3N0YXRpYyB1MzIgY2FsY3VsYXRlX2N4bF9jb250cm9s
KHZvaWQpDQo+ID4gK3sNCj4gPiArwqDCoMKgwqDCoMKgIHUzMiBjb250cm9sOw0KPiA+ICsNCj4g
PiArwqDCoMKgwqDCoMKgIGlmIChwY2lfYWVyX2F2YWlsYWJsZSgpKQ0KPiA+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIGNvbnRyb2wgfD0gT1NDX0NYTF9FUlJPUl9SRVBPUlRJTkdfQ09O
VFJPTDsNCj4gDQo+IEluIHRoaXMgY2FzZSB0aGUgZXJyb3IgaGFuZGxpbmcgaXMgZm9yIG1lbW9y
eSBlcnJvcnMsIHNvIHRoaXMgb25lIHNob3VsZCBiZToNCj4gDQo+IGlmIChJU19FTkFCTEVEKENP
TkZJR19NRU1PUllfRkFJTFVSRSkpDQo+IMKgwqDCoMKgwqDCoMKgIGNvbnRyb2wgfD0gT1NDX0NY
TF9FUlJPUl9SRVBPUlRJTkdfQ09OVFJPTDsNCg0KTWFrZXMgc2Vuc2UsIEknbGwgY2hhbmdlIHRv
IHRoaXMuDQoNCj4gDQo+IC4uLm90aGVyIHRoYW4gdGhhdCBsb29rcyBnb29kIHRvIG1lLg0KDQpU
aGFua3MgZm9yIHRoZSByZXZpZXchDQoNCj4gDQo=
