Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3E812F4606
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Jan 2021 09:14:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbhAMILY (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 13 Jan 2021 03:11:24 -0500
Received: from mga14.intel.com ([192.55.52.115]:25041 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727330AbhAMILW (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 13 Jan 2021 03:11:22 -0500
IronPort-SDR: 6esYZqRLBAerzgg+alTJuYbrBCPXpEqAQ8dFM/f5i0ektHV36IQG7cfyhutPJEtWjKCFmBqHlA
 YdD6MzpcYsGQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9862"; a="177391960"
X-IronPort-AV: E=Sophos;i="5.79,343,1602572400"; 
   d="scan'208";a="177391960"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2021 00:10:40 -0800
IronPort-SDR: Lb2hRura7Oj3miuGrk2s27VCCD9ncATz5Ea1ds/d1iSnLyDYyazYe9JpTfA89CNvN5INj+5UQK
 Zwx8x4HbQKVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,343,1602572400"; 
   d="scan'208";a="348734968"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by orsmga003.jf.intel.com with ESMTP; 13 Jan 2021 00:10:40 -0800
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 13 Jan 2021 00:10:39 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 13 Jan 2021 00:10:39 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 13 Jan 2021 00:10:39 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.106)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Wed, 13 Jan 2021 00:10:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z87YWOReU8DPtR++8PSVMwCnuhdtD/Cj0sTWPn0FqMxEk/b5PoDxpSEl8bj6wGagBnny4Kf5WoK9ObwMvvVny9+VUbM5s38rRoeYBJv5Xc2YqY/P1UjbS9DxYphUEmI1hpXZYcJPNew0nnRpY3/0F4uxK+d5F3zTZjpbRwxhsbEtXxcup2wdfLCH8upYdV0YpvyqLjjaFE4/YvMmTJEDAcOoGBnuHJp+muvghEd4xG/F2ESkKbY3LyTPclZVd9jAUon2VSfHd2LwGCN+rLbDd7v7n6OXVb2GUouG26rdApsJMkwgvICYBy3ycjgPUFmf6Oas55NZVwHkfaFb9nTp0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/UdMkz+ipXZpfwWCz4B05O/eqtEyRbsgp1hu9VygwaM=;
 b=e8K2pRZX24arD64tTViXzDrOqNISXwMuckJ5KbZgG+Q/+hzIme4L+1rqGN/5kaKzKBSjtkNiEsLS2g0g4T/jUPHPqzpIrYG92nWqddnrNpnobI7DTGvxspRPFgDjwAjYQ/X4rzyS9fIPUwrgITj3fwhbiaRiA3V9Ht5R+u+D+p7WXnN0rpGo8OK9VwrBt/en6th8gHVtyC7OXQyBoU5mn0lODQunOxTXbcGnHk6idP8hY03XyAXoMxVc+kJ7VaiHpv0NBZ6AH3P5dCr3aZTLNNv2x/q6RTQclMA9UmaiOtcZZ/0SeuxhfeeQqR8gREF3iyKgsAckN7jOAsm4IZi6+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/UdMkz+ipXZpfwWCz4B05O/eqtEyRbsgp1hu9VygwaM=;
 b=y8Wgfww4LlkD1qyD6vW6adVFPWLPj/RisTV+r/930Wu6rE+CUqaSo5pTDlhS0Bamv56YHCN2ohQ+xEM237SKd9eWEBeqCgjz2WPHV4uyuBL7SP+QJcZlfSwq9PdsCjfqkbb23Luk3SCbmGqDJHfaJtiRnjnAHraKcYEER+aMco4=
Received: from MWHPR11MB1886.namprd11.prod.outlook.com (2603:10b6:300:110::9)
 by MW3PR11MB4652.namprd11.prod.outlook.com (2603:10b6:303:5a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.10; Wed, 13 Jan
 2021 08:10:29 +0000
Received: from MWHPR11MB1886.namprd11.prod.outlook.com
 ([fe80::1d96:5d95:3a17:2419]) by MWHPR11MB1886.namprd11.prod.outlook.com
 ([fe80::1d96:5d95:3a17:2419%4]) with mapi id 15.20.3763.010; Wed, 13 Jan 2021
 08:10:29 +0000
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
Thread-Index: AQHW5c9iGKyAtZrVV0Gy0IAW1dQ6Vqoja/GAgABPqoCAASY+gIAASexg
Date:   Wed, 13 Jan 2021 08:10:28 +0000
Message-ID: <MWHPR11MB18868F53E5A9E0CF9975042B8CA90@MWHPR11MB1886.namprd11.prod.outlook.com>
References: <20210108145217.2254447-1-jean-philippe@linaro.org>
 <20210108145217.2254447-4-jean-philippe@linaro.org>
 <4de8ef03-a2ed-316e-d3e3-6b8474e20113@linux.intel.com>
 <X/1o72DTmzdCMhDz@myrica>
 <c88e5d74-098d-7f1d-a7bb-a89e40fb8fa4@linux.intel.com>
In-Reply-To: <c88e5d74-098d-7f1d-a7bb-a89e40fb8fa4@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.193]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ee93cc91-b290-44cb-1e28-08d8b79ab0c4
x-ms-traffictypediagnostic: MW3PR11MB4652:
x-microsoft-antispam-prvs: <MW3PR11MB46523395BA74D8D189C7772C8CA90@MW3PR11MB4652.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: I6YtU3vPJ11qovs+2lSx8VmIGAo2DRcr+3dfXUnlIxnyrzjqWsT3DwUkONzgOuKMXhyhbrwEcPhm+1YTDPgQoa3CvUE4rhgiao/vOHKlHMsqgb/Guixwq4WZBvPLwjjfPl+BGcp7WRBG+twUBydBiXekiex6zo9NIlOFnNmxRvoSwe58L8TEfD9I3HLALPu6c3QlkvJVZBZiE9WDeADuSOwsEocgqA5sfnjdWJqgPAISrsoyPcCEn61jVdGkzIM3x75ncpVDBdToJTtWsUM0EvL0OME3jHQYpaRq/BhXk94lZ/XGMMRgP+pL1iiSifhqZxtHXtbyg+/Y/joGjbbCXDzCxrhBn1rjfTDZxt0MF61sI0u7pslVlHvXdKXmCxE2uzvUMlUaYK8HbeVwtXM8ng==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1886.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(396003)(39860400002)(136003)(346002)(6506007)(7416002)(8676002)(83380400001)(4326008)(53546011)(26005)(2906002)(86362001)(186003)(7696005)(52536014)(5660300002)(54906003)(110136005)(33656002)(71200400001)(316002)(9686003)(55016002)(66946007)(66556008)(66446008)(64756008)(76116006)(66476007)(478600001)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?YS8yVndZQS9hNlpVTHJaaVNZMXVFQW9kWWdLL0UzTjI3dzNvcSs3WCs2VHBi?=
 =?utf-8?B?NW9hT2J5TXZUYS96cEFTRlhYaXYzMUVjVzZ2LzIrNDdSVVJ4VmMrbFhJalkr?=
 =?utf-8?B?UEVYdlFxZW5VeGtkbnBIeVE1aE13djRadkx6YzE1QTJpNlpid2YvTGFpRnVw?=
 =?utf-8?B?S2NVbzFBQlhkbGNId2hESjlrT3NKZFJVM0JnMEtiWGpGd1h2MVpMTU5VMFlo?=
 =?utf-8?B?bVhCVEF4TWYwZWFsN1A4TlNFbEg5OFJSOHRMWEhtTk9URUh4amtraWpIbGNt?=
 =?utf-8?B?bERobWw2dEVETVVrWWJxcmZQZ3h0eVh3Q1E3clBvRzlDbWJrTEEyK1hmRDZD?=
 =?utf-8?B?ZXVXM3B6YkVxNSt4T0pGK0lXdHJWSEhSVXRjVUQ1NDNzVjByQkNiWUlWamRR?=
 =?utf-8?B?S0gxVUxVV2FVNys2RDQyaFY3c3p6dDYyUW1tWS9aSDN4MFhrRHNkZWJQbGtZ?=
 =?utf-8?B?UmhjeGlvZkVtcFpQVXc2UzZ6MVJweXpNdlY5MXZvY0YyTzJXdG85T052MFBW?=
 =?utf-8?B?NURNNklRaExyKzI5UmcxNEFTbXMxT3RYaUJTbzhKS05OeWVsaGE2bDk3ZTE0?=
 =?utf-8?B?akJQM010OWVTRmZBT1RDbDJkNWMyY3UvVk9vR2ZUU2ZVQ21pYU5kcHBVcUx3?=
 =?utf-8?B?VDVhRUNGZXc5OUhNWmRnLzFsdkdvMjdYb0VGdDlGcGlVUUJMZ2JNQ1VwS2NL?=
 =?utf-8?B?QU9SNDFxWHFZdGtOV2kvSko0c3owa3R1VjhtRXhMd0dEanhoVUkwdkFRaGRR?=
 =?utf-8?B?Y1VybEMyTk5KWHFKUmk4M2tPREs5U2ljR1F4OGY0MVRRSUVJUFB2R0N5aURu?=
 =?utf-8?B?R3pzLzNHUm1VS09ZWVRyenFaV1BPdGV1SHo3bTV6cUxxODJPcFM2OFFuRDVQ?=
 =?utf-8?B?cXNVS2lNYVZEclkyZ2Jpd0pYSVAvS3B5dmZpL2RxcTMvdWg4VlMvQk93cDl5?=
 =?utf-8?B?QTd4SUU0MCs1c2JjS0VQZHIzQmR6MUZsbGpUOXlPTzI1RDZKdHJJN0xhaCtu?=
 =?utf-8?B?NEJEZ2dWeVRtR3p2WVJVYjRQb29HWWpHREFRcTFjUHExQjBueFRZQU1Bc3V5?=
 =?utf-8?B?MnJvRzdOd3liaEVuVlNiNUFYMnRUYlpVdHN2Rk95aTdWV1RBVnhZTW12VHRr?=
 =?utf-8?B?S05EdkoyR05mUG5VSWpXbzM3ZEdjb2ZMaW5KUHhVdDcwNjlvK1pFZnVDc09a?=
 =?utf-8?B?bXVuakoyUVNpZ3A1RnhRM1RmZ1RkNEx5VU1JVytyUWFFaGJ1aDZLZ25MNEd6?=
 =?utf-8?B?d3htNVN5My9TMVFDZWM2bWkwSTFRblBBOHFRdlF4OVRKV2tadUpYK3JBcUpr?=
 =?utf-8?Q?+Xxxq9wrRil7o=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1886.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee93cc91-b290-44cb-1e28-08d8b79ab0c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2021 08:10:28.9775
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gCGeK+ryDIhTnMQlX3IuotpruNvOQyKCGwdGo1xMGrAyswx4lcJFWjE0JPEAT083DabX6SkXZhbsPiQS7ckHOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4652
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

PiBGcm9tOiBMdSBCYW9sdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBXZWRu
ZXNkYXksIEphbnVhcnkgMTMsIDIwMjEgMTA6NTAgQU0NCj4gDQo+IEhpIEplYW4sDQo+IA0KPiBP
biAxLzEyLzIxIDU6MTYgUE0sIEplYW4tUGhpbGlwcGUgQnJ1Y2tlciB3cm90ZToNCj4gPiBIaSBC
YW9sdSwNCj4gPg0KPiA+IE9uIFR1ZSwgSmFuIDEyLCAyMDIxIGF0IDEyOjMxOjIzUE0gKzA4MDAs
IEx1IEJhb2x1IHdyb3RlOg0KPiA+PiBIaSBKZWFuLA0KPiA+Pg0KPiA+PiBPbiAxLzgvMjEgMTA6
NTIgUE0sIEplYW4tUGhpbGlwcGUgQnJ1Y2tlciB3cm90ZToNCj4gPj4+IFNvbWUgZGV2aWNlcyBt
YW5hZ2UgSS9PIFBhZ2UgRmF1bHRzIChJT1BGKSB0aGVtc2VsdmVzIGluc3RlYWQgb2YNCj4gcmVs
eWluZw0KPiA+Pj4gb24gUENJZSBQUkkgb3IgQXJtIFNNTVUgc3RhbGwuIEFsbG93IHRoZWlyIGRy
aXZlcnMgdG8gZW5hYmxlIFNWQSB3aXRob3V0DQo+ID4+PiBtYW5kYXRpbmcgSU9NTVUtbWFuYWdl
ZCBJT1BGLiBUaGUgb3RoZXIgZGV2aWNlIGRyaXZlcnMgbm93IG5lZWQgdG8NCj4gZmlyc3QNCj4g
Pj4+IGVuYWJsZSBJT01NVV9ERVZfRkVBVF9JT1BGIGJlZm9yZSBlbmFibGluZw0KPiBJT01NVV9E
RVZfRkVBVF9TVkEuDQo+ID4+Pg0KPiA+Pj4gU2lnbmVkLW9mZi1ieTogSmVhbi1QaGlsaXBwZSBC
cnVja2VyIDxqZWFuLXBoaWxpcHBlQGxpbmFyby5vcmc+DQo+ID4+PiAtLS0NCj4gPj4+IENjOiBB
cm5kIEJlcmdtYW5uIDxhcm5kQGFybmRiLmRlPg0KPiA+Pj4gQ2M6IERhdmlkIFdvb2Rob3VzZSA8
ZHdtdzJAaW5mcmFkZWFkLm9yZz4NCj4gPj4+IENjOiBHcmVnIEtyb2FoLUhhcnRtYW4gPGdyZWdr
aEBsaW51eGZvdW5kYXRpb24ub3JnPg0KPiA+Pj4gQ2M6IEpvZXJnIFJvZWRlbCA8am9yb0A4Ynl0
ZXMub3JnPg0KPiA+Pj4gQ2M6IEx1IEJhb2x1IDxiYW9sdS5sdUBsaW51eC5pbnRlbC5jb20+DQo+
ID4+PiBDYzogV2lsbCBEZWFjb24gPHdpbGxAa2VybmVsLm9yZz4NCj4gPj4+IENjOiBaaGFuZ2Zl
aSBHYW8gPHpoYW5nZmVpLmdhb0BsaW5hcm8ub3JnPg0KPiA+Pj4gQ2M6IFpob3UgV2FuZyA8d2Fu
Z3pob3UxQGhpc2lsaWNvbi5jb20+DQo+ID4+PiAtLS0NCj4gPj4+ICAgIGluY2x1ZGUvbGludXgv
aW9tbXUuaCB8IDIwICsrKysrKysrKysrKysrKysrLS0tDQo+ID4+PiAgICAxIGZpbGUgY2hhbmdl
ZCwgMTcgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4gPj4+DQo+ID4+PiBkaWZmIC0t
Z2l0IGEvaW5jbHVkZS9saW51eC9pb21tdS5oIGIvaW5jbHVkZS9saW51eC9pb21tdS5oDQo+ID4+
PiBpbmRleCA1ODNjNzM0YjJlODcuLjcwMWIyZWViMGRjNSAxMDA2NDQNCj4gPj4+IC0tLSBhL2lu
Y2x1ZGUvbGludXgvaW9tbXUuaA0KPiA+Pj4gKysrIGIvaW5jbHVkZS9saW51eC9pb21tdS5oDQo+
ID4+PiBAQCAtMTU2LDEwICsxNTYsMjQgQEAgc3RydWN0IGlvbW11X3Jlc3ZfcmVnaW9uIHsNCj4g
Pj4+ICAgIAllbnVtIGlvbW11X3Jlc3ZfdHlwZQl0eXBlOw0KPiA+Pj4gICAgfTsNCj4gPj4+IC0v
KiBQZXIgZGV2aWNlIElPTU1VIGZlYXR1cmVzICovDQo+ID4+PiArLyoqDQo+ID4+PiArICogZW51
bSBpb21tdV9kZXZfZmVhdHVyZXMgLSBQZXIgZGV2aWNlIElPTU1VIGZlYXR1cmVzDQo+ID4+PiAr
ICogQElPTU1VX0RFVl9GRUFUX0FVWDogQXV4aWxpYXJ5IGRvbWFpbiBmZWF0dXJlDQo+ID4+PiAr
ICogQElPTU1VX0RFVl9GRUFUX1NWQTogU2hhcmVkIFZpcnR1YWwgQWRkcmVzc2VzDQo+ID4+PiAr
ICogQElPTU1VX0RFVl9GRUFUX0lPUEY6IEkvTyBQYWdlIEZhdWx0cyBzdWNoIGFzIFBSSSBvciBT
dGFsbC4NCj4gR2VuZXJhbGx5IHVzaW5nDQo+ID4+PiArICoJCQkgJUlPTU1VX0RFVl9GRUFUX1NW
QQ0KPiByZXF1aXJlcyAlSU9NTVVfREVWX0ZFQVRfSU9QRiwgYnV0DQo+ID4+PiArICoJCQkgc29t
ZSBkZXZpY2VzIG1hbmFnZSBJL08gUGFnZSBGYXVsdHMgdGhlbXNlbHZlcw0KPiBpbnN0ZWFkDQo+
ID4+PiArICoJCQkgb2YgcmVseWluZyBvbiB0aGUgSU9NTVUuIFdoZW4gc3VwcG9ydGVkLCB0aGlz
DQo+IGZlYXR1cmUNCj4gPj4+ICsgKgkJCSBtdXN0IGJlIGVuYWJsZWQgYmVmb3JlIGFuZCBkaXNh
YmxlZCBhZnRlcg0KPiA+Pj4gKyAqCQkJICVJT01NVV9ERVZfRkVBVF9TVkEuDQo+ID4+DQo+ID4+
IElzIHRoaXMgb25seSBmb3IgU1ZBPyBXZSBtYXkgc2VlIG1vcmUgc2NlbmFyaW9zIG9mIHVzaW5n
IElPUEYuIEZvcg0KPiA+PiBleGFtcGxlLCB3aGVuIHBhc3NpbmcgdGhyb3VnaCBkZXZpY2VzIHRv
IHVzZXIgbGV2ZWwsIHRoZSB1c2VyJ3MgcGFnZXMNCj4gPj4gY291bGQgYmUgbWFuYWdlZCBkeW5h
bWljYWxseSBpbnN0ZWFkIG9mIGJlaW5nIGFsbG9jYXRlZCBhbmQgcGlubmVkDQo+ID4+IHN0YXRp
Y2FsbHkuDQo+ID4NCj4gPiBIbSwgaXNuJ3QgdGhhdCBwcmVjaXNlbHkgd2hhdCBTVkEgZG9lcz8g
IEkgZG9uJ3QgdW5kZXJzdGFuZCB0aGUNCj4gPiBkaWZmZXJlbmNlLiBUaGF0IHNhaWQgRkVBVF9J
T1BGIGRvZXNuJ3QgaGF2ZSB0byBiZSBvbmx5IGZvciBTVkEuIEl0IGNvdWxkDQo+ID4gbGF0ZXIg
YmUgdXNlZCBhcyBhIHByZXJlcXVpc2l0ZSBzb21lIGFub3RoZXIgZmVhdHVyZS4gRm9yIHNwZWNp
YWwgY2FzZXMNCj4gPiBkZXZpY2UgZHJpdmVycyBjYW4gYWx3YXlzIHVzZSB0aGUgaW9tbXVfcmVn
aXN0ZXJfZGV2aWNlX2ZhdWx0X2hhbmRsZXIoKQ0KPiA+IEFQSSBhbmQgaGFuZGxlIGZhdWx0cyB0
aGVtc2VsdmVzLg0KPiANCj4gIEZyb20gdGhlIHBlcnNwZWN0aXZlIG9mIElPTU1VLCB0aGVyZSBp
cyBhIGxpdHRsZSBkaWZmZXJlbmNlIGJldHdlZW4NCj4gdGhlc2UgdHdvLiBGb3IgU1ZBLCB0aGUg
cGFnZSB0YWJsZSBpcyBmcm9tIENQVSBzaWRlLCBzbyBJT01NVSBvbmx5IG5lZWRzDQo+IHRvIGNh
bGwgaGFuZGxlX21tX2ZhdWx0KCk7IEZvciBhYm92ZSBwYXNzLXRocm91Z2ggY2FzZSwgdGhlIHBh
Z2UgdGFibGUNCj4gaXMgZnJvbSBJT01NVSBzaWRlLCBzbyB0aGUgZGV2aWNlIGRyaXZlciAocHJv
YmFibHkgVkZJTykgbmVlZHMgdG8NCj4gcmVnaXN0ZXIgYSBmYXVsdCBoYW5kbGVyIGFuZCBjYWxs
IGlvbW11X21hcC91bm1hcCgpIHRvIHNlcnZlIHRoZSBwYWdlDQo+IGZhdWx0cy4NCj4gDQo+IElm
IHdlIHRoaW5rIGFib3V0IHRoZSBuZXN0ZWQgbW9kZSAob3IgZHVhbC1zdGFnZSB0cmFuc2xhdGlv
biksIGl0J3MgbW9yZQ0KPiBjb21wbGljYXRlZCBzaW5jZSB0aGUga2VybmVsIChwcm9iYWJseSBW
RklPKSBoYW5kbGVzIHRoZSBzZWNvbmQgbGV2ZWwNCj4gcGFnZSBmYXVsdHMsIHdoaWxlIHRoZSBm
aXJzdCBsZXZlbCBwYWdlIGZhdWx0cyBuZWVkIHRvIGJlIGRlbGl2ZXJlZCB0bw0KPiB1c2VyLWxl
dmVsIGd1ZXN0LiBPYnZpb3VzbHksIHRoaXMgaGFzbid0IGJlZW4gZnVsbHkgaW1wbGVtZW50ZWQg
aW4gYW55DQo+IElPTU1VIGRyaXZlci4NCj4gDQoNClRoaW5raW5nIG1vcmUgdGhlIGNvbmZ1c2lv
biBtaWdodCBjb21lIGZyb20gdGhlIGZhY3QgdGhhdCB3ZSBtaXhlZA0KaGFyZHdhcmUgY2FwYWJp
bGl0eSB3aXRoIHNvZnR3YXJlIGNhcGFiaWxpdHkuIElPTU1VX0ZFQVQgZGVzY3JpYmVzDQp0aGUg
aGFyZHdhcmUgY2FwYWJpbGl0eS4gV2hlbiBGRUFUX0lPUEYgaXMgc2V0LCBpdCBwdXJlbHkgbWVh
bnMgd2hhdGV2ZXINCnBhZ2UgZmF1bHRzIHRoYXQgYXJlIGVuYWJsZWQgYnkgdGhlIHNvZnR3YXJl
IGFyZSByb3V0ZWQgdGhyb3VnaCB0aGUgSU9NTVUuDQpOb3RoaW5nIG1vcmUuIFRoZW4gdGhlIHNv
ZnR3YXJlIChJT01NVSBkcml2ZXJzKSBtYXkgY2hvb3NlIHRvIHN1cHBvcnQNCm9ubHkgbGltaXRl
ZCBmYXVsdGluZyBzY2VuYXJpb3MgYW5kIHRoZW4gZXZvbHZlIHRvIHN1cHBvcnQgbW9yZSBjb21w
bGV4IA0KdXNhZ2VzIGdyYWR1YWxseS4gRm9yIGV4YW1wbGUsIHRoZSBpbnRlbC1pb21tdSBkcml2
ZXIgb25seSBzdXBwb3J0cyAxc3QtbGV2ZWwNCmZhdWx0ICh0aHVzIFNWQSkgZm9yIG5vdywgd2hp
bGUgRkVBVF9JT1BGIGFzIGEgc2VwYXJhdGUgZmVhdHVyZSBtYXkgZ2l2ZSB0aGUNCmltcHJlc3Np
b24gdGhhdCAybmQtbGV2ZWwgZmF1bHRzIGFyZSBhbHNvIGFsbG93ZWQuIEZyb20gdGhpcyBhbmds
ZSBvbmNlIHdlIA0Kc3RhcnQgdG8gc2VwYXJhdGUgcGFnZSBmYXVsdCBmcm9tIFNWQSwgd2UgbWF5
IGFsc28gbmVlZCBhIHdheSB0byByZXBvcnQgDQp0aGUgc29mdHdhcmUgY2FwYWJpbGl0eSAoZS5n
LiBhIHNldCBvZiBmYXVsdGluZyBjYXRlZ29yaWVzKSBhbmQgYWxzbyBleHRlbmQNCmlvbW11X3Jl
Z2lzdGVyX2RldmljZV9mYXVsdF9oYW5kbGVyIHRvIGFsbG93IHNwZWNpZnlpbmcgd2hpY2ggDQpj
YXRlZ29yeSBpcyBlbmFibGVkIHJlc3BlY3RpdmVseS4gVGhlIGV4YW1wbGUgY2F0ZWdvcmllcyBj
b3VsZCBiZToNCg0KLSBJT1BGX0JJTkQsIGZvciBwYWdlIHRhYmxlcyB3aGljaCBhcmUgYm91bmQv
bGlua2VkIHRvIHRoZSBJT01NVS4gDQpBcHBseSB0byBiYXJlIG1ldGFsIFNWQSBhbmQgZ3Vlc3Qg
U1ZBIGNhc2U7DQotIElPUEZfTUFQLCBmb3IgcGFnZSB0YWJsZXMgd2hpY2ggYXJlIG1hbmFnZWQg
dGhyb3VnaCBleHBsaWNpdCBJT01NVQ0KbWFwIGludGVyZmFjZXMuIEFwcGx5IHRvIHJlbW92aW5n
IFZGSU8gcGlubmluZyByZXN0cmljdGlvbjsNCg0KQm90aCBjYXRlZ29yaWVzIGNhbiBiZSBlbmFi
bGVkIHRvZ2V0aGVyIGluIG5lc3RlZCB0cmFuc2xhdGlvbiwgd2l0aCANCmFkZGl0aW9uYWwgaW5m
b3JtYXRpb24gcHJvdmlkZWQgdG8gZGlmZmVyZW50aWF0ZSB0aGVtIGluIGZhdWx0IGluZm9ybWF0
aW9uLg0KVXNpbmcgcGFnaW5nL3N0YWdpbmcgbGV2ZWwgZG9lc24ndCBtYWtlIG11Y2ggc2Vuc2Ug
YXMgaXQncyBJT01NVSBkcml2ZXIncyANCmludGVybmFsIGtub3dsZWRnZSwgZS5nLiBWVC1kIGRy
aXZlciBwbGFucyB0byB1c2UgMXN0IGxldmVsIGZvciBHUEEgaWYgbm8gDQpuZXN0aW5nIGFuZCB0
aGVuIHR1cm4gdG8gMm5kIGxldmVsIHdoZW4gbmVzdGluZyBpcyBlbmFibGVkLg0KDQpUaGFua3MN
CktldmluDQo=
