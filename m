Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85A7B2F9A3B
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Jan 2021 07:56:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731989AbhARGze (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 18 Jan 2021 01:55:34 -0500
Received: from mga12.intel.com ([192.55.52.136]:10918 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732889AbhARGzQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 18 Jan 2021 01:55:16 -0500
IronPort-SDR: r/dvdQbM6go5elUOLHnCgmOOBroj2l+S1fucAOcEYPGtEYEox+yDlGuGnE6Dh+HDf19y5gateM
 er74zfvBrdfQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9867"; a="157946669"
X-IronPort-AV: E=Sophos;i="5.79,355,1602572400"; 
   d="scan'208";a="157946669"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2021 22:54:33 -0800
IronPort-SDR: zHGkh5AjAYAUd73KrhM6Qw12EDbyjk6WiIVADpBHxQmFj2VJg4r+ZNDJ2B+LUjqHqZgCz7OqoH
 3Dm6+QJv1xaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,355,1602572400"; 
   d="scan'208";a="401951293"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by fmsmga002.fm.intel.com with ESMTP; 17 Jan 2021 22:54:33 -0800
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sun, 17 Jan 2021 22:54:32 -0800
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sun, 17 Jan 2021 22:54:32 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Sun, 17 Jan 2021 22:54:32 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Sun, 17 Jan 2021 22:54:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i/O7Zaomfk5Lt15I4VmUl/XIp2ETJ8u+s6ORWkGTEd+vpbkcwUbsz1+uXW1vCZud9wYQfypq8ngV0R3Pe5MNWXlGVxg4HNLaknshEaw0i0SARYKi73y6IKEuXpHCkDCruXtAB8wBAyhb1gkHXG+DuYLT0R7TL/0fn1uUxhnVL9U5ORePoe/FXDVn01KCY4A4IEdRo1NbT74AQIt6Ydo+ZUs+f7joDl/AYLDiRgNkv9id+854wgayjfuYfq6pSmHh2ePui07CGIQgF9yyhIMNvKO+tPHtbdKlNdilfEVesJzx17znbUb+Mt8D4yZdgAab2aM6KgFxcE4m1+ttxuTMVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0K3A4JUpJnGP+RDPIgCeC53azZNCLeFvpbJlWeD1pkA=;
 b=JA6Mi3rlkTWAw0j+ETqCyv8L/VEr8PLJFcwWt6VqrUjHrUT0nQQ9/SC4MsBnu8lIkcv/K04BDqRaIgCExrx6iRu0BBqzdOvDm223Lgv1veYY4PQ81Ilf/xIkyw1OOcWkQLsJkP1baVg9dManwNI4rQOnTyWzhTf6c/oQKuHMUWd0qMCpyZx/69dVbehLAKiTODOVtps5/+TfGebwX71mM0lh4lXgMPq/tyrNAVIO+V4mzpChHscP9vKpfB1ag1ja0J41PdaeuISZVWISHhsie2RY+BBSC88nPzmBPn+6Tl3rJdV8kARKxFSUJX7GDEVMzM+aQmGnjnqyPPkb7x147Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0K3A4JUpJnGP+RDPIgCeC53azZNCLeFvpbJlWeD1pkA=;
 b=lhcxA2hSsTrqR0qBP6dQIsly3BgOW9xCTsHyjPBJSBJFlUkvHyq3jXDJG/h0D8Q8JU9VUc1Spdu0j5dJOhQaO2RUGrOGjtbjHkbCCcwJcKaVBXUyQLs17StPbwYCc4FW/b6+HHZfAIsgbrHUHbJPB96FYQ9khc5caTnrx6lM3ME=
Received: from MWHPR11MB1886.namprd11.prod.outlook.com (2603:10b6:300:110::9)
 by MWHPR11MB1278.namprd11.prod.outlook.com (2603:10b6:300:1d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.13; Mon, 18 Jan
 2021 06:54:28 +0000
Received: from MWHPR11MB1886.namprd11.prod.outlook.com
 ([fe80::f1b4:bace:1e44:4a46]) by MWHPR11MB1886.namprd11.prod.outlook.com
 ([fe80::f1b4:bace:1e44:4a46%6]) with mapi id 15.20.3763.014; Mon, 18 Jan 2021
 06:54:28 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
CC:     "joro@8bytes.org" <joro@8bytes.org>,
        "will@kernel.org" <will@kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "guohanjun@huawei.com" <guohanjun@huawei.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-accelerators@lists.ozlabs.org" 
        <linux-accelerators@lists.ozlabs.org>,
        "vdumpa@nvidia.com" <vdumpa@nvidia.com>,
        "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
        "shameerali.kolothum.thodi@huawei.com" 
        <shameerali.kolothum.thodi@huawei.com>,
        "vivek.gautam@arm.com" <vivek.gautam@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        David Woodhouse <dwmw2@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Zhou Wang" <wangzhou1@hisilicon.com>
Subject: RE: [PATCH v9 03/10] iommu: Separate IOMMU_DEV_FEAT_IOPF from
 IOMMU_DEV_FEAT_SVA
Thread-Topic: [PATCH v9 03/10] iommu: Separate IOMMU_DEV_FEAT_IOPF from
 IOMMU_DEV_FEAT_SVA
Thread-Index: AQHW5c9iGKyAtZrVV0Gy0IAW1dQ6Vqoja/GAgABPqoCAASY+gIAASexggAIw5ACAAk4qAIADP7Fg
Date:   Mon, 18 Jan 2021 06:54:28 +0000
Message-ID: <MWHPR11MB188653AF6EFA0E55DE17815F8CA40@MWHPR11MB1886.namprd11.prod.outlook.com>
References: <20210108145217.2254447-1-jean-philippe@linaro.org>
 <20210108145217.2254447-4-jean-philippe@linaro.org>
 <4de8ef03-a2ed-316e-d3e3-6b8474e20113@linux.intel.com>
 <X/1o72DTmzdCMhDz@myrica>
 <c88e5d74-098d-7f1d-a7bb-a89e40fb8fa4@linux.intel.com>
 <MWHPR11MB18868F53E5A9E0CF9975042B8CA90@MWHPR11MB1886.namprd11.prod.outlook.com>
 <YAB0SHyUZbxprkL3@larix.localdomain>
 <636814a9-7dea-06f6-03ec-6a98dd30b7e3@linux.intel.com>
In-Reply-To: <636814a9-7dea-06f6-03ec-6a98dd30b7e3@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.206]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 18a35dfb-c468-4356-13dc-08d8bb7de64e
x-ms-traffictypediagnostic: MWHPR11MB1278:
x-microsoft-antispam-prvs: <MWHPR11MB12784227342DF8C89D1114FE8CA40@MWHPR11MB1278.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xGDdFLZ6q6L5Zv3bbEy/O0YU+9MINQn08Vj3E7fmm5dJ620x/9ZXz7KPIH76kb8ekm5kk1SWcDNBW6DGfYCQ5yOFDdMgD0QbfQc+8pbI6BmFU36wieq0ptH7uAOxa2ADtK0M6XMvyLf59MoI1K6yzUSS1hEZHOE8ftN+jqe4O0ZTowRNipfJawwtinLyIt3VQo+Hg3ljWuqVsM7OPKfCWtROyWSU4U226xWc0z6+hTwMLkOLQMoqNJEmzdAIn/lvTmfpEm7ZnVjq4eEi/G86o+t404UYdtvNlXHZaL6xI+/PoydakpHrCW6aSlRlAbMLogMCWYROm52LD5nlCSDxU8ATvGLXQo464wFjnqjB5EoUcrzOEx+G+OWD2KGdSo1lXHSi3bh14Gglxbpdmy4zlA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1886.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(39860400002)(376002)(366004)(396003)(478600001)(76116006)(86362001)(66946007)(52536014)(8676002)(33656002)(7416002)(83380400001)(8936002)(71200400001)(110136005)(54906003)(53546011)(26005)(4326008)(2906002)(9686003)(6506007)(55016002)(7696005)(66476007)(66446008)(64756008)(66556008)(5660300002)(186003)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?Z0tQQ0s0RU5VYmNGSUZvdGxRRUcvSXptWWRIRjBXWE1YbGFWZHZraytoc2t1?=
 =?utf-8?B?dm5OUXBBNkRFTitHdFo5ZVpBczg5b0UxM1NhZXNxaHNFTTVySTY3dDhvaUFH?=
 =?utf-8?B?ZGhxQ0diSkJXZUFYRWdWQXFpc3lEa1h5alRpcVp3dTY2OGw4dkNmQXdOVnVH?=
 =?utf-8?B?b1JvNlBneUFTOVREdmhySnRXUHBycmtwK3VZT3FSNVVzd1dPM1JZOE9Pa2U1?=
 =?utf-8?B?bGRzd3ZyOEVlOUtOYkhFZXVJSlFmT09OOVV4dFVYN29yRWpiMmc0T0lyeVZv?=
 =?utf-8?B?YUVTNXRCSndyRHQxeXdIckRzd3lRUitVekYvaVNLVDBYQXJsaW40R1JWWTVS?=
 =?utf-8?B?OTNDcEZtVlZ2VFZLbEZ6ZWsxUGJVRHhwWUtpbDRiWW9BemdjLzFDd2piQWdK?=
 =?utf-8?B?U2ViY2R0Y3Q4WDVKTnVtNVVvUmJXSWg0R0xyclNYQUtkbldRMmJnRW4vMEtV?=
 =?utf-8?B?TnZyWEJrZC9rNjZNWng2aG5wSDlubXF2Zm84VU4xOHBYNnpRbS92T3BUc1Z4?=
 =?utf-8?B?YjltcnpKekZkcUtmUjVST05TemxoL24yK0VzeUExZFV3bUc2VDl6RW9JMkNI?=
 =?utf-8?B?M3gwMEw3KzRCNXh0N2hlNVRaQ1hCOUpwM2RBeXBveXU4OUVydlBSWnRpZXZp?=
 =?utf-8?B?U0YxWDA3M0hFSmRHTU91Q3ROWlZwNHZKZHlDcUc5cEhDT0dESEtIZWZlbnVi?=
 =?utf-8?B?T210eFBuL2xFNFF1ZlJldnk1UXVKZWRWMytpdzhzbERka01IeVZxS1NLc1V3?=
 =?utf-8?B?ZGFpL0NGd3AraU9sVjFDL0xqYnRYWjc4ZThBL2UxQUNxbkZqUEw1YlZVckx4?=
 =?utf-8?B?RlJPbXVodVU1Y1FoZnd3R2NJMTVLOXQ5NmNTcmFkYTA2dklIKzNqTndZWnZ6?=
 =?utf-8?B?WmxLaFJVNjhxWWVlTHVLSzgvYXlERGdnZVFsN2ptL0FuK1gvNnhEdk1iRzFZ?=
 =?utf-8?B?Q3dTT0RaZU5uZTdldUxmRVoxRS9qci9aYzJ1eFBhN0Jzb3BaakVPYUVsNGVN?=
 =?utf-8?B?WnNMcUZYTjlrc0VhN0twYkdveStGNkZsV015eGZueExyWG91ay8welhlM0xE?=
 =?utf-8?B?Zy9wZmFhMmZ2L3VrQmpxTDE5MEVRdkhRUFBoSFFTbmJjWEh1dmlqVUFoU0Rw?=
 =?utf-8?B?OVBRR1ZucWxNN3VlcXRTdUx4ellMU3lYQjdNN3UzZS91ZG5DcDAwL1grdTNO?=
 =?utf-8?B?eFFDRU1VM0xXOTM4dEN2emc4clpKN0VGWDdCN3VKUjhES1dmKzhMT0V3Tk0x?=
 =?utf-8?B?Y2RzUjFqNkd1QWFwOE5YWVAvSmpOczVIcXFsckx1L2VyVU5pY0wva1F2cmNp?=
 =?utf-8?Q?Q+VMQIWQH+AIc=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1886.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18a35dfb-c468-4356-13dc-08d8bb7de64e
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2021 06:54:28.1553
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6rs/lgxqF0a+jt67qaLBQ1f1uVaWZZ1OGyZGlVXJYiQInO4sZn6Nak2B8lhhEGL3rAqwo85Z/ibUwdr8/3wSkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1278
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

PiBGcm9tOiBMdSBCYW9sdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBTYXR1
cmRheSwgSmFudWFyeSAxNiwgMjAyMSAxMTo1NCBBTQ0KPiANCj4gSGkgSmVhbiwNCj4gDQo+IE9u
IDIwMjEvMS8xNSAwOjQxLCBKZWFuLVBoaWxpcHBlIEJydWNrZXIgd3JvdGU6DQo+ID4gSSBndWVz
cyBkZXRhaWxpbmcgd2hhdCdzIG5lZWRlZCBmb3IgbmVzdGVkIElPUEYgY2FuIGhlbHAgdGhlIGRp
c2N1c3Npb24sDQo+ID4gYWx0aG91Z2ggSSBoYXZlbid0IHNlZW4gYW55IGNvbmNyZXRlIHBsYW4g
YWJvdXQgaW1wbGVtZW50aW5nIGl0LCBhbmQgaXQNCj4gPiBzdGlsbCBzZWVtcyBhIGNvdXBsZSBv
ZiB5ZWFycyBhd2F5LiBUaGVyZSBhcmUgdHdvIGltcG9ydGFudCBzdGVwcyB3aXRoDQo+ID4gbmVz
dGVkIElPUEY6DQo+ID4NCj4gPiAoMSkgRmlndXJpbmcgb3V0IHdoZXRoZXIgYSBmYXVsdCBjb21l
cyBmcm9tIEwxIG9yIEwyLiBBIFNNTVUgc3RhbGwgZXZlbnQNCj4gPiAgICAgIGNvbWVzIHdpdGgg
dGhpcyBpbmZvcm1hdGlvbiwgYnV0IGEgUFJJIHBhZ2UgcmVxdWVzdCBkb2Vzbid0LiBUaGUNCj4g
SU9NTVUNCj4gPiAgICAgIGRyaXZlciBoYXMgdG8gZmlyc3QgdHJhbnNsYXRlIHRoZSBJT1ZBIHRv
IGEgR1BBLCBpbmplY3RpbmcgdGhlIGZhdWx0DQo+ID4gICAgICBpbnRvIHRoZSBndWVzdCBpZiB0
aGlzIHRyYW5zbGF0aW9uIGZhaWxzIGJ5IHVzaW5nIHRoZSB1c3VhbA0KPiA+ICAgICAgaW9tbXVf
cmVwb3J0X2RldmljZV9mYXVsdCgpLg0KDQpUaGUgSU9NTVUgZHJpdmVyIGNhbiB3YWxrIHRoZSBw
YWdlIHRhYmxlcyB0byBmaW5kIG91dCB0aGUgbGV2ZWwgaW5mb3JtYXRpb24uDQpJZiB0aGUgd2Fs
ayB0ZXJtaW5hdGVzIGF0IHRoZSAxc3QgbGV2ZWwsIGluamVjdCB0byB0aGUgZ3Vlc3QuIE90aGVy
d2lzZSBmaXggdGhlIA0KbW0gZmF1bHQgYXQgMm5kIGxldmVsLiBJdCdzIG5vdCBlZmZpY2llbnQg
Y29tcGFyZWQgdG8gaGFyZHdhcmUtcHJvdmlkZWQgaW5mbywNCmJ1dCBpdCdzIGRvYWJsZSBhbmQg
YWN0dWFsIG92ZXJoZWFkIG5lZWRzIHRvIGJlIG1lYXN1cmVkIChvcHRpbWl6YXRpb24gZXhpc3Rz
DQplLmcuIGhhdmluZyBmYXVsdCBjbGllbnQgdG8gaGludCBubyAybmQgbGV2ZWwgZmF1bHQgZXhw
ZWN0ZWQgd2hlbiByZWdpc3RlcmluZyBmYXVsdA0KaGFuZGxlciBpbiBwaW5uZWQgY2FzZSkuDQoN
Cj4gPg0KPiA+ICgyKSBUcmFuc2xhdGluZyB0aGUgZmF1bHRpbmcgR1BBIHRvIGEgSFZBIHRoYXQg
Y2FuIGJlIGZlZCB0bw0KPiA+ICAgICAgaGFuZGxlX21tX2ZhdWx0KCkuIFRoYXQgcmVxdWlyZXMg
aGVscCBmcm9tIEtWTSwgc28gYW5vdGhlciBpbnRlcmZhY2UgLQ0KPiA+ICAgICAgZWl0aGVyIEtW
TSByZWdpc3RlcmluZyBHUEEtPkhWQSB0cmFuc2xhdGlvbiB0YWJsZXMgb3IgSU9NTVUgZHJpdmVy
DQo+ID4gICAgICBxdWVyeWluZyBlYWNoIHRyYW5zbGF0aW9uLiBFaXRoZXIgd2F5IGl0IHNob3Vs
ZCBiZSByZXVzYWJsZSBieSBkZXZpY2UNCj4gPiAgICAgIGRyaXZlcnMgdGhhdCBpbXBsZW1lbnQg
SU9QRiB0aGVtc2VsdmVzLg0KDQpPciBqdXN0IGxlYXZlIHRvIHRoZSBmYXVsdCBjbGllbnQgKHNh
eSBWRklPIGhlcmUpIHRvIGZpZ3VyZSBpdCBvdXQuIFZGSU8gaGFzIHRoZQ0KaW5mb3JtYXRpb24g
YWJvdXQgR1BBLT5IUEEgYW5kIGNhbiB0aGVuIGNhbGwgaGFuZGxlX21tX2ZhdWx0IHRvIGZpeCB0
aGUNCnJlY2VpdmVkIGZhdWx0LiBUaGUgSU9NTVUgZHJpdmVyIGp1c3QgZXhwb3J0cyBhbiBpbnRl
cmZhY2UgZm9yIHRoZSBkZXZpY2UgZHJpdmVycyANCndoaWNoIGltcGxlbWVudCBJT1BGIHRoZW1z
ZWx2ZXMgdG8gcmVwb3J0IGEgZmF1bHQgd2hpY2ggaXMgdGhlbiBoYW5kbGVkIGJ5DQp0aGUgSU9N
TVUgY29yZSBieSByZXVzaW5nIHRoZSBzYW1lIGZhdWx0aW5nIHBhdGguDQoNCj4gPg0KPiA+ICgx
KSBjb3VsZCBiZSBlbmFibGVkIHdpdGggaW9tbXVfZGV2X2VuYWJsZV9mZWF0dXJlKCkuICgyKSBy
ZXF1aXJlcyBhDQo+IG1vcmUNCj4gPiBjb21wbGV4IGludGVyZmFjZS4gKDIpIGFsb25lIG1pZ2h0
IGFsc28gYmUgZGVzaXJhYmxlIC0gZGVtYW5kLXBhZ2luZyBmb3INCj4gPiBsZXZlbCAyIG9ubHks
IG5vIFNWQSBmb3IgbGV2ZWwgMS4NCg0KWWVzLCB0aGlzIGlzIHdoYXQgd2Ugd2FudCB0byBwb2lu
dCBvdXQuIEEgZ2VuZXJhbCBGRUFUX0lPUEYgaW1wbGllcyBtb3JlIHRoYW4NCndoYXQgdGhpcyBw
YXRjaCBpbnRlbmRlZCB0byBhZGRyZXNzLg0KDQo+ID4NCj4gPiBBbnl3YXksIGJhY2sgdG8gdGhp
cyBwYXRjaC4gV2hhdCBJJ20gdHJ5aW5nIHRvIGNvbnZleSBpcyAiY2FuIHRoZSBJT01NVQ0KPiA+
IHJlY2VpdmUgaW5jb21pbmcgSS9PIHBhZ2UgZmF1bHRzIGZvciB0aGlzIGRldmljZSBhbmQsIHdo
ZW4gU1ZBIGlzIGVuYWJsZWQsDQo+ID4gZmVlZCB0aGVtIHRvIHRoZSBtbSBzdWJzeXN0ZW0/ICBF
bmFibGUgdGhhdCBvciByZXR1cm4gYW4gZXJyb3IuIiBJJ20gc3R1Y2sNCj4gPiBvbiB0aGUgbmFt
ZS4gSU9QRiBhbG9uZSBpcyB0b28gdmFndWUuIE5vdCBJT1BGX0wxIGFzIEtldmluIG5vdGVkLCBz
aW5jZSBMMQ0KPiA+IGlzIGFsc28gdXNlZCBpbiB2aXJ0dWFsaXphdGlvbi4gSU9QRl9CSU5EIGFu
ZCBJT1BGX1NWQSBjb3VsZCBhbHNvIG1lYW4gKDIpDQo+ID4gYWJvdmUuIElPTU1VX0RFVl9GRUFU
X0lPUEZfRkxBVD8NCj4gPg0KPiA+IFRoYXQgbGVhdmVzIHNwYWNlIGZvciB0aGUgbmVzdGVkIGV4
dGVuc2lvbnMuICgxKSBhYm92ZSBjb3VsZCBiZQ0KPiA+IElPTU1VX0ZFQVRfSU9QRl9ORVNURUQs
IGFuZCAoMikgcmVxdWlyZXMgc29tZSBuZXcgaW50ZXJmYWNpbmcgd2l0aA0KPiBLVk0gKG9yDQo+
ID4ganVzdCBhbiBleHRlcm5hbCBmYXVsdCBoYW5kbGVyKSBhbmQgY291bGQgYmUgdXNlZCB3aXRo
IGVpdGhlciBJT1BGX0ZMQVQgb3INCj4gPiBJT1BGX05FU1RFRC4gV2UgY2FuIGZpZ3VyZSBvdXQg
dGhlIGRldGFpbHMgbGF0ZXIuIFdoYXQgZG8geW91IHRoaW5rPw0KPiANCj4gSSBhZ3JlZSB0aGF0
IHdlIGNhbiBkZWZpbmUgSU9QRl8gZm9yIGN1cnJlbnQgdXNhZ2UgYW5kIGxlYXZlIHNwYWNlIGZv
cg0KPiBmdXR1cmUgZXh0ZW5zaW9ucy4NCj4gDQo+IElPUEZfRkxBVCByZXByZXNlbnRzIElPUEYg
b24gZmlyc3QtbGV2ZWwgdHJhbnNsYXRpb24sIGN1cnJlbnRseSBmaXJzdA0KPiBsZXZlbCB0cmFu
c2xhdGlvbiBjb3VsZCBiZSB1c2VkIGluIGJlbG93IGNhc2VzLg0KPiANCj4gMSkgRkwgdy8gaW50
ZXJuYWwgUGFnZSBUYWJsZTogS2VybmVsIElPVkE7DQo+IDIpIEZMIHcvIGV4dGVybmFsIFBhZ2Ug
VGFibGU6IFZGSU8gcGFzc3Rocm91Z2g7DQo+IDMpIEZMIHcvIHNoYXJlZCBDUFUgcGFnZSB0YWJs
ZTogU1ZBDQo+IA0KPiBXZSBkb24ndCBuZWVkIHRvIHN1cHBvcnQgSU9QRiBmb3IgY2FzZSAxKS4g
TGV0J3MgcHV0IGl0IGFzaWRlLg0KPiANCj4gSU9QRiBoYW5kbGluZyBvZiAyKSBhbmQgMykgYXJl
IGRpZmZlcmVudC4gRG8gd2UgbmVlZCB0byBkZWZpbmUgZGlmZmVyZW50DQo+IG5hbWVzIHRvIGRp
c3Rpbmd1aXNoIHRoZXNlIHR3byBjYXNlcz8NCj4gDQoNCkRlZmluaW5nIGZlYXR1cmUgbmFtZXMg
YWNjb3JkaW5nIHRvIHZhcmlvdXMgdXNlIGNhc2VzIGRvZXMgbm90IHNvdW5kIGENCmNsZWFuIHdh
eS4gSW4gYW4gaWRlYWwgd2F5IHdlIHNob3VsZCBoYXZlIGp1c3QgYSBnZW5lcmFsIEZFQVRfSU9Q
RiBzaW5jZQ0KdGhlIGhhcmR3YXJlIChhdCBsZWFzdCBWVC1kKSBkb2VzIHN1cHBvcnQgZmF1bHQg
aW4gZWl0aGVyIDFzdC1sZXZlbCwgMm5kLQ0KbGV2ZWwgb3IgbmVzdGVkIGNvbmZpZ3VyYXRpb25z
LiBXZSBhcmUgZW50ZXJpbmcgdGhpcyB0cm91YmxlIGp1c3QgYmVjYXVzZQ0KdGhlcmUgaXMgZGlm
ZmljdWx0eSBmb3IgdGhlIHNvZnR3YXJlIGV2b2x2aW5nIHRvIGVuYWJsZSBmdWxsIGhhcmR3YXJl
IGNhcA0KaW4gb25lIGJhdGNoLiBNeSBsYXN0IHByb3Bvc2FsIHdhcyBzb3J0IG9mIGtlZXBpbmcg
RkVBVF9JT1BGIGFzIGEgZ2VuZXJhbA0KY2FwYWJpbGl0eSBmb3Igd2hldGhlciBkZWxpdmVyaW5n
IGZhdWx0IHRocm91Z2ggdGhlIElPTU1VIG9yIHRoZSBhZC1ob2MNCmRldmljZSwgYW5kIHRoZW4g
aGF2aW5nIGEgc2VwYXJhdGUgaW50ZXJmYWNlIGZvciB3aGV0aGVyIElPUEYgcmVwb3J0aW5nDQpp
cyBhdmFpbGFibGUgdW5kZXIgYSBzcGVjaWZpYyBjb25maWd1cmF0aW9uLiBUaGUgZm9ybWVyIGlz
IGFib3V0IHRoZSBwYXRoDQpiZXR3ZWVuIHRoZSBJT01NVSBhbmQgdGhlIGRldmljZSwgd2hpbGUg
dGhlIGxhdHRlciBpcyBhYm91dCB0aGUgaW50ZXJmYWNlDQpiZXR3ZWVuIHRoZSBJT01NVSBkcml2
ZXIgYW5kIGl0cyBmYXVsdGluZyBjbGllbnQuDQoNClRoZSByZXBvcnRpbmcgY2FwYWJpbGl0eSBj
YW4gYmUgY2hlY2tlZCB3aGVuIHRoZSBmYXVsdCBjbGllbnQgaXMgcmVnaXN0ZXJpbmcgDQppdHMg
ZmF1bHQgaGFuZGxlciwgYW5kIGF0IHRoaXMgdGltZSB0aGUgSU9NTVUgZHJpdmVyIGtub3dzIGhv
dyB0aGUgcmVsYXRlZCANCm1hcHBpbmcgaXMgY29uZmlndXJlZCAoMXN0LCAybmQsIG9yIG5lc3Rl
ZCkgYW5kIHdoZXRoZXIgZmF1bHQgcmVwb3J0aW5nIGlzIA0Kc3VwcG9ydGVkIGluIHN1Y2ggY29u
ZmlndXJhdGlvbi4gV2UgbWF5IGludHJvZHVjZSBJT1BGX1JFUE9SVF9GTEFUIGFuZCANCklPUEZf
UkVQT1JUX05FU1RFRCByZXNwZWN0aXZlbHkuIHdoaWxlIElPUEZfUkVQT1JUX0ZMQVQgZGV0ZWN0
aW9uIGlzIA0Kc3RyYWlnaHRmb3J3YXJkICgyIGFuZCAzIGNhbiBiZSBkaWZmZXJlbnRpYXRlZCBp
bnRlcm5hbGx5IGJhc2VkIG9uIGNvbmZpZ3VyZWQgDQpsZXZlbCksIElPUEZfUkVQT1JUX05FU1RF
RCBuZWVkcyBhZGRpdGlvbmFsIGluZm8gdG8gaW5kaWNhdGUgd2hpY2ggbGV2ZWwgaXMgDQpjb25j
ZXJuZWQgc2luY2UgdGhlIHZlbmRvciBkcml2ZXIgbWF5IG5vdCBzdXBwb3J0IGZhdWx0IHJlcG9y
dGluZyBpbiBib3RoIA0KbGV2ZWxzIG9yIHRoZSBmYXVsdCBjbGllbnQgbWF5IGJlIGludGVyZXN0
ZWQgaW4gb25seSBvbmUgbGV2ZWwgKGUuZy4gd2l0aCAybmQNCmxldmVsIHBpbm5lZCkuDQoNClRo
YW5rcw0KS2V2aW4NCg==
