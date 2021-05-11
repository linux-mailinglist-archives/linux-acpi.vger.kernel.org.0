Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4737379B1C
	for <lists+linux-acpi@lfdr.de>; Tue, 11 May 2021 02:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbhEKAS2 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 10 May 2021 20:18:28 -0400
Received: from mga12.intel.com ([192.55.52.136]:38600 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229807AbhEKAS2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 10 May 2021 20:18:28 -0400
IronPort-SDR: JE6gTYRwkag+Vsrgusc2j+WzJL/kpVeZg1xf1mX+a+53ZbstXV6cFyEoo9DzGHDSCvpAcMsF/9
 d4J5y92yclLQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9980"; a="178909893"
X-IronPort-AV: E=Sophos;i="5.82,288,1613462400"; 
   d="scan'208";a="178909893"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2021 17:17:22 -0700
IronPort-SDR: BMO1OR6gTA3KtteB+LZO0b1NCDkQMtHyy/pVmKa3dDgDjyaiDqwzOHc9YDLGe6xbaYUjPfAfLI
 g1jfe57C7uag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,288,1613462400"; 
   d="scan'208";a="434039348"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga008.fm.intel.com with ESMTP; 10 May 2021 17:17:22 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 10 May 2021 17:17:22 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 10 May 2021 17:17:21 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Mon, 10 May 2021 17:17:21 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.107)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Mon, 10 May 2021 17:17:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L1ISa87GmD6WAdDEShQrNLOIQG3oxrVcR+cOaluVsXnz0sIfgn1nZdSUvjWbk9l2wQmJAljznz/usyjnhItW+339ERcytUdxeUGz0B7tYU9I9r/AbZmDmx+tN1Pmzqx24TJQvAtzw0Q/CwznJv7ln0qbOmOutwBz7j1xuipk6EVburZsasYuSfJ+8vPkUozZabPmF+v89oHzGTebWc6gsV5jkDEbPkGMV0RDLwhn4dSMEXiNyBia2RYdxQXsPy2nPEBOZN5thH+nvK6l6J2r/wR9BG2BQiVeE5a6pyz2o47KmV4RmbbuFM/pPk16NpeHfW4TmpGm3LBh3b+EXOH3OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/AMXIIxVqdP9QnCNIpwJaw04u/NPHlqN7PDYvE6NBDg=;
 b=cNfsuKKOco4ttbGwXyj7TgkLzb5KkUhRqtHOZbPm46k//9dfSSOdOaldusqnygsTaMd2lUnAZbHnBHzw9wgTwXjfDNTuN4PyFklaCc/b+sL2mc6A/p1b3vdtC3srjN32XoNJZz+urL0221BYNyu1Dv0XQY+uXzj8l6A20ubUa7GAN3c2qk6y+QPYNjD5sSGclSrjWRP8GbjTTU7jj0eZ0ttkr0ztkCMJw8ZX4/bunYBIpaKH+rf4XxOWwI8rtZxpV5CyV/Z8rikIDPCBSB5TVO991hXvLU2YJgfgLJra0mlwN1QlJ5hrvHxbz1LqgyUZOkMEtHYiBUU95tpVLco9cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/AMXIIxVqdP9QnCNIpwJaw04u/NPHlqN7PDYvE6NBDg=;
 b=J4slKTk6XElYoRMLjFKR7qmpmwdKmT0MWPEuHEQKu+eWAoU+fFHwUSGC9Y0+zHZAzEAIg2mciyj2wcjoJZzbtPZkmTmnWK39dX8Ls9VhdfUz/DbkrGwcgTpJ/rYhWp1BITh8/G7NyhFe+M54qu3j1lxK4SXAcNq0whnxnJBpnPw=
Received: from MWHPR11MB1599.namprd11.prod.outlook.com (2603:10b6:301:e::16)
 by CO1PR11MB4770.namprd11.prod.outlook.com (2603:10b6:303:92::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Tue, 11 May
 2021 00:17:16 +0000
Received: from MWHPR11MB1599.namprd11.prod.outlook.com
 ([fe80::48df:6af5:afe:ea7e]) by MWHPR11MB1599.namprd11.prod.outlook.com
 ([fe80::48df:6af5:afe:ea7e%7]) with mapi id 15.20.4108.031; Tue, 11 May 2021
 00:17:16 +0000
From:   "Kaneda, Erik" <erik.kaneda@intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
CC:     Rafael J Wysocki <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>,
        "Moore, Robert" <robert.moore@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>
Subject: RE: [PATCH 1/1] ACPICA: Add SVKL table headers
Thread-Topic: [PATCH 1/1] ACPICA: Add SVKL table headers
Thread-Index: AQHXN63idIu90F18RkG2L61zsRhHDqrdC/6AgAB5OFA=
Date:   Tue, 11 May 2021 00:17:15 +0000
Message-ID: <MWHPR11MB1599AD69C50EE40EF625C837F0539@MWHPR11MB1599.namprd11.prod.outlook.com>
References: <20210422192937.707500-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <CAJZ5v0hbAaFtRxuyR2B6YBUfV6eGWmDrZnTisd9j5H0UNurqrg@mail.gmail.com>
In-Reply-To: <CAJZ5v0hbAaFtRxuyR2B6YBUfV6eGWmDrZnTisd9j5H0UNurqrg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [2600:6c55:4c7f:e63f:1d7d:df99:244d:2776]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 48281c6f-e42c-4b8d-8a6c-08d9141221ef
x-ms-traffictypediagnostic: CO1PR11MB4770:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR11MB4770D4430836ABE017D6077AF0539@CO1PR11MB4770.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:331;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bAWNSahB/trcp4wY4tl741ywL/KfHs4G6IJeuIq/YsGfq2z40pTxg29Fj4fwiDur3F9LyZzo+bH+kNsTPou7oWD2IKlsztkWBC+/FWCgvAFyCZRkhXORvkjajUzKE0PZ3YxJlLrNm1xYBY4hBksXia2mAyrqnAFqhvbionoQ1uegefOcxmDpVf1TYnUrfjQVlDmY0EmqoHIuqxS4wRBaPpPS0CSgVdaQrzx4Py2tNQYgAjR161E/QJrLuFcZTJ64Yrw7jlkfwtOTzSXGxJAQuaVlht5LkaQNAK2gfbQ/zWjdhgy2YX2iTQURTAcKQXtURnH4KOY/9NpxNyiCBlg9o4EV8tGzJjAdhCqiKjEaiHdCfR1Rk5iE/Of+D+nlE24E+XUU0MopDmShr3cYT6BMVg91CKaBBEHEQkBSLQU7ydViRivKk5X0Ch67XhPtQKIne2YHyr7e7GdorOB+2VCrhi81SXsGVHL9NaGI8vSpHTAyRF/EUku9wbzfc0E574QwLoA2CmTuosI0vPYXsgdUtnE5HD/qmjJ89mOvU+OrPPYGP4PcrEBjh1xxHm5xVE4igEXi4SZEUyNM6pUlgrKRtd17L9Nnk8/SxjBuKrSytXnCU+j4F25or0XIQ6Z/EHZ/KczjwHdlPOYT08pSOvgJ3l1hPv7WAhzeuoCQ1JqGLjo/o3Ph2nSZ3sTgF/DOo2e5XNSlEa9R/27IdnENKuNCyK6kL8XzA1qONiSPEuCA2yQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1599.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(39860400002)(396003)(366004)(136003)(76116006)(66476007)(66946007)(66556008)(110136005)(54906003)(66446008)(64756008)(186003)(55016002)(83380400001)(52536014)(33656002)(9686003)(316002)(38100700002)(6506007)(4326008)(966005)(86362001)(53546011)(7696005)(8936002)(478600001)(122000001)(2906002)(8676002)(5660300002)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?Qy81SzFtall4T1dsVW9vRGxvTjJBUHlQeHpWeCtqUVNtNXF1aUlMUDRKZ0I4?=
 =?utf-8?B?Tk52S0JPUDhsUjZ3U2o2LzdPdWFFeTJ1WFBxejNkK1grTmYrbjJsMWtPR1o4?=
 =?utf-8?B?QWxZMlVYODVCa1ZvS1JiKzlFTGw2WURkY2pPTzA3WCtaVk0zZGJSZitZMzIr?=
 =?utf-8?B?amNXb3lBWDRud0lZalovdUhNTkgrYnJsaCtqa05YRmxiYkhlWmFZZjNFSzA2?=
 =?utf-8?B?S0JGMFA0Q1Q2Yzk0Y3I5bVJPUnIrVkpNd2kwazh2NnJtM1JHSlBrNWlUSnd1?=
 =?utf-8?B?YTlIWGRpWFJJZFRRUWxiVlgvTEExeFZ5ZUlHcWxhZUZIMmFmOXZxM0IxUDFy?=
 =?utf-8?B?cnh4OHVDYlNFR0NLaVhEajc0b28vb2thOFdpYUEvSUdJaWc1R1oxNzRCeURs?=
 =?utf-8?B?ZlpDN24wbk55T3ZqUGE0NmxuRUk2cTlEZEZ4UldSM1dmS3VqTTVDYlFMU0Fo?=
 =?utf-8?B?U2hrN095TXV2bTRPaTNFcnpCZ3hoZnRkUGFqeXAxRGlkc0FITUV4cnJuU0ky?=
 =?utf-8?B?T3YzQ3Q4dHBJZWRnRTIrM0dxR0pYYkRDeHMzRXRCby9UYktLMWFXNXZDVlBZ?=
 =?utf-8?B?MTBLYXc5TVYwWGJlaW1zazlXRlYwb3FWb0VNZ3o5N3RvVGtJVnlTdDFidFJ1?=
 =?utf-8?B?Y05ONGgzSmNKVmYzQTNySnpVN3RxVW1CNng0bWNZOFp3Mm5qSnR5UnVNZFlT?=
 =?utf-8?B?dHI1ZTFXMDgzcjJra3dDaFZ2Umx1cFc3OC9FeUFveGpvVVl0eFcyNzVNSExV?=
 =?utf-8?B?dFg2cWlhd1pYbWJ1a1pBZ2VMWDZWQ2dGK3lySmJGVlkvTmJsUmg5YzVUdGl1?=
 =?utf-8?B?RzljdG5jV2pYcTRiOEhVN2lzVlFDNEdWbEpCbURScDRxL2VLdFZ2a2JGMlVP?=
 =?utf-8?B?WjZJTnhLZGRhUlB0bExOMlpOQmdQNmpBcFhWbk1OTXU0QXhZaTBlV1lwMmRq?=
 =?utf-8?B?cjRWVEZYM0toZ2lSWGdZVERZdVhPV1ZUMVAybjFTMmU3Y21TNGtHY1FQK2V5?=
 =?utf-8?B?eGNMbWh3SUhQU1FudkdudDRtZzFUZTdoNVRVdE9LazhFZXZYYzN6ZVVmZXJa?=
 =?utf-8?B?Z3hYZXZlTms5Y0FqZkIzKzdnTFNwWUMvaVdrdFNBK09vNHFqR1VVWWFkTk5B?=
 =?utf-8?B?YkhoeVNwOG9Db1N0OVZBM0V6dENRQ0tWYXZzMlN5ZUtFbkRCNW11NEttT0tz?=
 =?utf-8?B?aWdaNDNxb3pYbEZyeGF1Vjd6cUZmKzNPM3NIemZTb2hCRFFvcHhZQW8zcTI2?=
 =?utf-8?B?cjFKZS9WR1NVZ2xJdGFaN3NwdkR4Z3JjOU9FTGdlbFpJdjVjMUlkRXhuZTNT?=
 =?utf-8?B?UkUzeHhQTTVrWk9USTRPR09vbzRxSjJjVDI0R25LSmtTRnEyZStNaWJZY1li?=
 =?utf-8?B?Tk5kKzIvT1BzbS9jb1JFa0hxZ1p0cC93YWlGQ0EvKytVaDBZUS9UNk1NYkJz?=
 =?utf-8?B?VVY5WjNQVGZDcEptZXVVT1BYd0xGVVJGOGdWT3BXeWxrRm1mZW1vT0wzRys4?=
 =?utf-8?B?U0hDSW9TR0dhdVlMYUs5Ti8wUFZZU2dJRm4zODdudlMyOWoyYmdpYndQclE0?=
 =?utf-8?B?S2p6WVlZK2xhWjByMXljZWd6TWk3MGJzYUVlU1JwTUl5WG91NXBieS9iZTMy?=
 =?utf-8?B?VGJ4bndMbFgwbmM3Zkcwa0FhQmNEVjVmdzhrMmJaV2ZpR1pXSDZYTllsT3dX?=
 =?utf-8?B?OUhIT0dVR0ovQWpmLzFDamxPcjNHT0ZidS9PY1lUTzk0V3FaeHFzV0FLeHRY?=
 =?utf-8?B?ZWJ2cU1kOHZhR0NNNFBHTk1KdEx1THRCWC92RlpOU05uZDdpSGdhSGNTbEFY?=
 =?utf-8?B?Ry9yWmpJd3BUM1l0c3JZZy9XVFBKQ2ZIWFRrQ1BoTzFibm8yQlBGK2kxdDBT?=
 =?utf-8?Q?0NtG7CP8Ve1Qx?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1599.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48281c6f-e42c-4b8d-8a6c-08d9141221ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2021 00:17:15.9849
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsQA4QE6PxUe0+FaftwbhnsQOC3sWF7CyyfmXiZLkv1CR5qt5aDmo72iqzTS6BezKVla2CDL/7kMipd1JiOm/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4770
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUmFmYWVsIEouIFd5c29j
a2kgPHJhZmFlbEBrZXJuZWwub3JnPg0KPiBTZW50OiBNb25kYXksIE1heSAxMCwgMjAyMSA5OjU4
IEFNDQo+IFRvOiBLdXBwdXN3YW15IFNhdGh5YW5hcmF5YW5hbg0KPiA8c2F0aHlhbmFyYXlhbmFu
Lmt1cHB1c3dhbXlAbGludXguaW50ZWwuY29tPjsgS2FuZWRhLCBFcmlrDQo+IDxlcmlrLmthbmVk
YUBpbnRlbC5jb20+DQo+IENjOiBSYWZhZWwgSiBXeXNvY2tpIDxyandAcmp3eXNvY2tpLm5ldD47
IExlbiBCcm93biA8bGVuYkBrZXJuZWwub3JnPjsNCj4gTW9vcmUsIFJvYmVydCA8cm9iZXJ0Lm1v
b3JlQGludGVsLmNvbT47IEFDUEkgRGV2ZWwgTWFsaW5nIExpc3QgPGxpbnV4LQ0KPiBhY3BpQHZn
ZXIua2VybmVsLm9yZz47IG9wZW4gbGlzdDpBQ1BJIENPTVBPTkVOVCBBUkNISVRFQ1RVUkUNCj4g
KEFDUElDQSkgPGRldmVsQGFjcGljYS5vcmc+OyBMaW51eCBLZXJuZWwgTWFpbGluZyBMaXN0IDxs
aW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZz47IFd5c29ja2ksIFJhZmFlbCBKIDxyYWZh
ZWwuai53eXNvY2tpQGludGVsLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCAxLzFdIEFDUElD
QTogQWRkIFNWS0wgdGFibGUgaGVhZGVycw0KPiANCj4gT24gVGh1LCBBcHIgMjIsIDIwMjEgYXQg
OToyOSBQTSBLdXBwdXN3YW15IFNhdGh5YW5hcmF5YW5hbg0KPiA8c2F0aHlhbmFyYXlhbmFuLmt1
cHB1c3dhbXlAbGludXguaW50ZWwuY29tPiB3cm90ZToNCj4gPg0KPiA+IEFDUElDQSBjb21taXQg
YjVlNmJjZjY5ZGJiOTg3NzQ4MTk5MmQ1Y2U4NjAwOGNmYjk0ZjViOA0KPiA+DQo+ID4gU1ZLTCAo
U3RvcmFnZSBWb2x1bWUgS2V5IExvY2F0aW9uIFRhYmxlKSBpcyB1c2VkIGJ5IEJJT1MvRmlybXdh
cmUNCj4gPiB0byBzaGFyZSBzdG9yYWdlIHZvbHVtZSBlbmNyeXB0aW9uIGtleSdzIHdpdGggT1Mu
IEl0IHdpbGwgYmUgdXNlZA0KPiA+IGJ5IHVzZXJzcGFjZSB0byBkZWNyeXB0IGFuZCBtb3VudCBl
bmNyeXB0ZWQgZHJpdmVzLg0KPiA+DQo+ID4gU28gYWRkIFNWS0wgdGFibGUgc2lnbmF0dXJlIGFu
ZCBhZGQgaXQgdG8ga25vd24gc2lnbmF0dXJlcyBhcnJheQ0KPiA+IHN1cHBvcnQgU1ZLTC4NCj4g
Pg0KPiA+IFlvdSBjYW4gZmluZCBkZXRhaWxzIGFib3V0IHRoZSBTVktMIHRhYmxlIGluIFREWCBz
cGVjZmljYXRpb24NCj4gPiB0aXRsZWQgIkd1ZXN0LUhvc3QtQ29tbXVuaWNhdGlvbiBJbnRlcmZh
Y2UgKEdIQ0kpIGZvciBJbnRlbA0KPiA+IFRydXN0IERvbWFpbiBFeHRlbnNpb25zIChJbnRlbMKu
IFREWCkiLCBzZWMgNC40IGFuZCBpbiBBQ1BJDQo+ID4gc3BlY2lmaWNhdGlvbiByNi40LCBzZWMg
NS4yLjYuDQo+ID4NCj4gPg0KPiBodHRwczovL3NvZnR3YXJlLmludGVsLmNvbS9jb250ZW50L2Rh
bS9kZXZlbG9wL2V4dGVybmFsL3VzL2VuL2RvY3VtZW4NCj4gdHMvaW50ZWwtdGR4LWd1ZXN0LWh5
cGVydmlzb3ItY29tbXVuaWNhdGlvbi1pbnRlcmZhY2UucGRmDQo+ID4NCj4gPiBDYzogUm9iZXJ0
IE1vb3JlIDxyb2JlcnQubW9vcmVAaW50ZWwuY29tPg0KPiA+IENjOiBFcmlrIEthbmVkYSA8ZXJp
ay5rYW5lZGFAaW50ZWwuY29tPg0KPiA+IENjOiBSYWZhZWwgSi4gV3lzb2NraSA8cmFmYWVsLmou
d3lzb2NraUBpbnRlbC5jb20+DQo+ID4NCj4gPiBMaW5rOiBodHRwczovL2dpdGh1Yi5jb20vYWNw
aWNhL2FjcGljYS9jb21taXQvYjVlNmJjZjYNCj4gPiBTaWduZWQtb2ZmLWJ5OiBLdXBwdXN3YW15
IFNhdGh5YW5hcmF5YW5hbg0KPiA8c2F0aHlhbmFyYXlhbmFuLmt1cHB1c3dhbXlAbGludXguaW50
ZWwuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEJvYiBNb29yZSA8cm9iZXJ0Lm1vb3JlQGludGVs
LmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBFcmlrIEthbmVkYSA8ZXJpay5rYW5lZGFAaW50ZWwu
Y29tPg0KPiANCj4gRXJpaywgd2hhdCdzIHRoZSBwbGFuIHJlZ2FyZGluZyB0aGlzIHBhdGNoIGFu
ZCB0aGUgb3RoZXIgQUNQSUNBIGNoYW5nZQ0KPiByZXF1aXNpdGUgZm9yIHRoaXMgc2VyaWVzPw0K
PiANCj4gQXJlIHRoZXkgZ29pbmcgdG8gYmUgcGFydCBvZiB0aGUgbmV4dCBBQ1BJQ0EgcmVsZWFz
ZSBhbmQgYW0gSSBnb2luZyB0bw0KPiByZWNlaXZlIHRoZW0gdGhlIHVzdWFsIHdheT8NCg0KWWVz
LCB3ZSdsbCBkbyB0aGlzIHRoZSB1c3VhbCB3YXkNCg0KRXJpaw0KDQo+IA0KPiA+IC0tLQ0KPiA+
ICBpbmNsdWRlL2FjcGkvYWN0YmwyLmggfCAzMCArKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDMwIGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYg
LS1naXQgYS9pbmNsdWRlL2FjcGkvYWN0YmwyLmggYi9pbmNsdWRlL2FjcGkvYWN0YmwyLmgNCj4g
PiBpbmRleCBkNjQ3OGM0MzBjOTkuLjgzYTlkOGI2OGUzYSAxMDA2NDQNCj4gPiAtLS0gYS9pbmNs
dWRlL2FjcGkvYWN0YmwyLmgNCj4gPiArKysgYi9pbmNsdWRlL2FjcGkvYWN0YmwyLmgNCj4gPiBA
QCAtNDMsNiArNDMsNyBAQA0KPiA+ICAjZGVmaW5lIEFDUElfU0lHX1NERUkgICAgICAgICAgICJT
REVJIiAvKiBTb2Z0d2FyZSBEZWxlZ2F0ZWQgRXhjZXB0aW9uDQo+IEludGVyZmFjZSBUYWJsZSAq
Lw0KPiA+ICAjZGVmaW5lIEFDUElfU0lHX1NERVYgICAgICAgICAgICJTREVWIiAvKiBTZWN1cmUg
RGV2aWNlcyB0YWJsZSAqLw0KPiA+ICAjZGVmaW5lIEFDUElfU0lHX05ITFQgICAgICAgICAgICJO
SExUIiAvKiBOb24tSERBdWRpbyBMaW5rIFRhYmxlICovDQo+ID4gKyNkZWZpbmUgQUNQSV9TSUdf
U1ZLTCAgICAgICAgICAgIlNWS0wiIC8qIFN0b3JhZ2UgVm9sdW1lIEtleSBMb2NhdGlvbg0KPiBU
YWJsZSAqLw0KPiA+DQo+ID4gIC8qDQo+ID4gICAqIEFsbCB0YWJsZXMgbXVzdCBiZSBieXRlLXBh
Y2tlZCB0byBtYXRjaCB0aGUgQUNQSSBzcGVjaWZpY2F0aW9uLCBzaW5jZQ0KPiA+IEBAIC0xNzEz
LDYgKzE3MTQsMzUgQEAgc3RydWN0IGFjcGlfc2Rldl9wY2llX3BhdGggew0KPiA+ICAgICAgICAg
dTggZnVuY3Rpb247DQo+ID4gIH07DQo+ID4NCj4gPg0KPiArLyoqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKg0KPiAqKioqKioqKioqKioqKioq
KioqKioqDQo+ID4gKyAqDQo+ID4gKyAqIFNWS0wgLSBTdG9yYWdlIFZvbHVtZSBLZXkgTG9jYXRp
b24gVGFibGUgKEFDUEkgNi40KQ0KPiA+ICsgKiAgICAgICAgVmVyc2lvbiAxDQo+ID4gKyAqDQo+
ID4gKw0KPiAqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqDQo+ICoqKioqKioqKioqKioqKioqKioqLw0KPiA+ICsNCj4gPiArc3RydWN0IGFj
cGlfdGFibGVfc3ZrbCB7DQo+ID4gKyAgICAgICBzdHJ1Y3QgYWNwaV90YWJsZV9oZWFkZXIgaGVh
ZGVyOyAgICAgICAgLyogQ29tbW9uIEFDUEkgdGFibGUgaGVhZGVyDQo+ICovDQo+ID4gKyAgICAg
ICB1MzIgY291bnQ7DQo+ID4gK307DQo+ID4gKw0KPiA+ICtzdHJ1Y3QgYWNwaV9zdmtsX2hlYWRl
ciB7DQo+ID4gKyAgICAgICB1MTYgdHlwZTsNCj4gPiArICAgICAgIHUxNiBmb3JtYXQ7DQo+ID4g
KyAgICAgICB1MzIgc2l6ZTsNCj4gPiArICAgICAgIHU2NCBhZGRyZXNzOw0KPiA+ICt9Ow0KPiA+
ICsNCj4gPiArZW51bSBhY3BpX3N2a2xfdHlwZSB7DQo+ID4gKyAgICAgICBBQ1BJX1NWS0xfVFlQ
RV9NQUlOX1NUT1JBR0UgPSAwLA0KPiA+ICsgICAgICAgQUNQSV9TVktMX1RZUEVfUkVTRVJWRUQg
PSAxICAgICAvKiAxIGFuZCBncmVhdGVyIGFyZSByZXNlcnZlZCAqLw0KPiA+ICt9Ow0KPiA+ICsN
Cj4gPiArZW51bSBhY3BpX3N2a2xfZm9ybWF0IHsNCj4gPiArICAgICAgIEFDUElfU1ZLTF9GT1JN
QVRfUkFXX0JJTkFSWSA9IDAsDQo+ID4gKyAgICAgICBBQ1BJX1NWS0xfRk9STUFUX1JFU0VSVkVE
ID0gMSAgIC8qIDEgYW5kIGdyZWF0ZXIgYXJlIHJlc2VydmVkICovDQo+ID4gK307DQo+ID4gKw0K
PiA+ICAvKiBSZXNldCB0byBkZWZhdWx0IHBhY2tpbmcgKi8NCj4gPg0KPiA+ICAjcHJhZ21hIHBh
Y2soKQ0KPiA+IC0tDQo+ID4gMi4yNS4xDQo+ID4NCg==
