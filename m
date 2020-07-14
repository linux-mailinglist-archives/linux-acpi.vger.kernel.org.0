Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A63D321E53A
	for <lists+linux-acpi@lfdr.de>; Tue, 14 Jul 2020 03:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbgGNBhH (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 13 Jul 2020 21:37:07 -0400
Received: from mail-eopbgr70058.outbound.protection.outlook.com ([40.107.7.58]:25198
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726149AbgGNBhG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 13 Jul 2020 21:37:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O/WSMU2g0VkFsBPzrxl/9ox5ccfnsOB8ACBkoWl5wnU=;
 b=t4FEVpx4zzCLCMx1tJz6THdTq3OApahzwYZglNduEiIbktT2A1bHDyOiv3F6cGtWu8fBKx6EaIwCelDMpLToiZn4hIclkQSmll8AE8DaKbbasq+9JdpRfeIox2KRhSr6Wq/zgjNQ+zvNsm5xr8jQvGNkTc/nnR33b3n5X0Hs2aw=
Received: from AM7PR04CA0006.eurprd04.prod.outlook.com (2603:10a6:20b:110::16)
 by VI1PR08MB3263.eurprd08.prod.outlook.com (2603:10a6:803:3d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21; Tue, 14 Jul
 2020 01:36:59 +0000
Received: from VE1EUR03FT059.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:110:cafe::fa) by AM7PR04CA0006.outlook.office365.com
 (2603:10a6:20b:110::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21 via Frontend
 Transport; Tue, 14 Jul 2020 01:36:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT059.mail.protection.outlook.com (10.152.19.60) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.21 via Frontend Transport; Tue, 14 Jul 2020 01:36:59 +0000
Received: ("Tessian outbound 2ae7cfbcc26c:v62"); Tue, 14 Jul 2020 01:36:58 +0000
X-CR-MTA-TID: 64aa7808
Received: from ca130ad8f15c.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 6FA8DA73-022F-492F-B18B-FEB1D08E0DD8.1;
        Tue, 14 Jul 2020 01:36:53 +0000
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id ca130ad8f15c.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 14 Jul 2020 01:36:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a5yZdDDHxtPgLSZ/KRI5qIhsaoWaC4EkiVkWyCN3CYriwB60sFXzgrksvp2bzb4/Rr+fh9kN4S9Ucg1UZ0uKWGgofPeei7S95c3rftetYu1LnEld+tMuD9nBZ+alr/+qlbg70ucYS7rPZtXAq+Kef7fv8CwffBcH9YJuKK3b/l0r6A+RkDGNWpTm+g5nmMTDFVWxcfh7lUD8TXc+FDf3zMrPLL5tUk5HA06MiJeiEqDrxqm8rUsRBt3GSj74q6wyrKGZqjnfo7dqgN+Qivz6VmgfTcI7vcnHG59+OY7Fvop1BRI147NF329ivBD2ATMFlDLBHimwc1FkOMmadYiEWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O/WSMU2g0VkFsBPzrxl/9ox5ccfnsOB8ACBkoWl5wnU=;
 b=DsaQ88U9jrcDWsWZit9y70JaXHjQqndrfuQNP9Oo6ulTnJq6ubbA8OqnBNayh5Sp5qKTir9w9pcCBU0pczSZXoXFUyn92jG492tGbHKa9nL1dJcYau/N22qjPX0wZNFQW5xVMzduwvIYKL33GO+BxMQYIjzvP8FL8cGn2d2ybTB5xl1CpYlK9LqKh/v6X9L3SeT3R2J1G3UX8jBgsCvpTHaAOjPmABIyg+gZ44dk9G7LzehPmZOby0T1T3UChHAiE3iIqOhZ7immmEdAd1W6DeTiyNvAbLO8IZSt1wI2NWqobYikRYapPtjVmDWZVhqDcPRnvooDmmuKQQGjUcU1Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O/WSMU2g0VkFsBPzrxl/9ox5ccfnsOB8ACBkoWl5wnU=;
 b=t4FEVpx4zzCLCMx1tJz6THdTq3OApahzwYZglNduEiIbktT2A1bHDyOiv3F6cGtWu8fBKx6EaIwCelDMpLToiZn4hIclkQSmll8AE8DaKbbasq+9JdpRfeIox2KRhSr6Wq/zgjNQ+zvNsm5xr8jQvGNkTc/nnR33b3n5X0Hs2aw=
Received: from AM6PR08MB4069.eurprd08.prod.outlook.com (2603:10a6:20b:af::32)
 by AM5PR0801MB2036.eurprd08.prod.outlook.com (2603:10a6:203:42::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22; Tue, 14 Jul
 2020 01:36:51 +0000
Received: from AM6PR08MB4069.eurprd08.prod.outlook.com
 ([fe80::8c97:9695:2f8d:3ae0]) by AM6PR08MB4069.eurprd08.prod.outlook.com
 ([fe80::8c97:9695:2f8d:3ae0%5]) with mapi id 15.20.3174.025; Tue, 14 Jul 2020
 01:36:50 +0000
From:   Justin He <Justin.He@arm.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Mike Rapoport <rppt@linux.ibm.com>
CC:     linux-nvdimm <linux-nvdimm@lists.01.org>,
        Will Deacon <will@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Joao Martins <joao.m.martins@oracle.com>
Subject: RE: [PATCH v2 08/22] memblock: Introduce a generic
 phys_addr_to_target_node()
Thread-Topic: [PATCH v2 08/22] memblock: Introduce a generic
 phys_addr_to_target_node()
Thread-Index: AQHWWGuOcFj5TNUeTUqDwmGk0yhYtqkFFncAgACSyoCAAKQkQA==
Date:   Tue, 14 Jul 2020 01:36:50 +0000
Message-ID: <AM6PR08MB40694ADECAF34D4A099A4E70F7610@AM6PR08MB4069.eurprd08.prod.outlook.com>
References: <159457116473.754248.7879464730875147365.stgit@dwillia2-desk3.amr.corp.intel.com>
 <159457120893.754248.7783260004248722175.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20200713070304.GC11000@linux.ibm.com>
 <CAPcyv4iRJRz==VRgq=M_FYz0TfNKqKASOD1+NRfMLcHzEOBApQ@mail.gmail.com>
In-Reply-To: <CAPcyv4iRJRz==VRgq=M_FYz0TfNKqKASOD1+NRfMLcHzEOBApQ@mail.gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: 962950f5-2977-4d3b-a37e-314e12ddcb36.0
x-checkrecipientchecked: true
Authentication-Results-Original: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=arm.com;
x-originating-ip: [203.126.0.111]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 73ebab1f-c6ca-4f4a-94f1-08d8279666ab
x-ms-traffictypediagnostic: AM5PR0801MB2036:|VI1PR08MB3263:
X-Microsoft-Antispam-PRVS: <VI1PR08MB3263C7C1CB19A152987D0E2BF7610@VI1PR08MB3263.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-oob-tlc-oobclassifiers: OLM:7219;OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: MbeGyrVDWUPQ8wkHPmOe3oLoQLzxPwOWfgI+dUj58pPQ56xvl4nnOY2XM822PvRTyNB+sdc92e/S9HXv7qcd7rM06XcXkkNUwLZ6C4OUS8ULAJCLVOcqm+456OMxjWzzCUTbj0Gub+68RfLR+sEcSP60cCLoP8XtC5SpIjlHkcH+LxFAYLiXbJZF3IgAvhjipH43UHMRHbqM8wRsj5riq+jJEQV5i59tsedCcofZxFx8GjTiS7PCwxRFOdxccNdYuEMyMrrxysSFi0uYJcOuRQgZO92JTL1Mb4+UzObLRn8GwpAytofdV31mJ5MD/jX8vu+j5YDLL2KJQJCpiVdfVXQGpn9h4p59aTVsveITvVnzL1+V6a7T3Va9mb8qS+0A
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB4069.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(346002)(136003)(396003)(39860400002)(366004)(7696005)(4326008)(8936002)(7416002)(66446008)(66476007)(53546011)(6506007)(76116006)(66946007)(64756008)(52536014)(9686003)(33656002)(8676002)(55016002)(2906002)(5660300002)(478600001)(83380400001)(316002)(26005)(66556008)(110136005)(54906003)(71200400001)(186003)(86362001)(41533002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 8gDbWTHhVqRfOmP8XSySh7Br8OH8I9IjDM8597NYfG9cfrcxiujQC5aZ4irqDpfg1QXsYfLnCWkEGf+vQEnlK3Z8crpF2V1IyeugquwrqkelgDyDRT3S0GR0XQCz/f8fhCc/8dI4Hzg5ZB9cjITgHnpHTfsGdtaOYWhvkT0mfkJnoU8hQi0pbUqThdSrMl5v2NI9BCW2trhtTDBw3tOJjvwovpT15VkeR2MIhj3zxtUZ8fwyswaoh2Xexh9wmiM7WG9zP981NqVtc4kI/VJSlBUyQtrqpq7K833cE+lDaMUqDdtAiKTpZ6YA7M3JsNdSu+GPOG971bAyd7yl8ZbhH5QxZbz7MxsUHtwFnqaFfjCFAmfDniriPLResUr6jlY5yW33sYqDwMyb6wUtMjF14Sb7U8VzmZ+W7amR92H3UfZRuYUY65Q0Hvn0lsB4ijU0W9Z89+HHCRaVn7sCo9l58Yu8yk0r4DFS3qgR1tzPXs0=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB2036
Original-Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT059.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFTY:;SFS:(4636009)(396003)(136003)(346002)(376002)(39860400002)(46966005)(82740400003)(8676002)(7696005)(5660300002)(52536014)(55016002)(316002)(82310400002)(33656002)(336012)(8936002)(47076004)(356005)(450100002)(4326008)(81166007)(83380400001)(70586007)(478600001)(54906003)(107886003)(86362001)(9686003)(26005)(70206006)(186003)(2906002)(36906005)(6506007)(53546011)(110136005)(41533002);DIR:OUT;SFP:1101;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 20a3a66e-d28e-4dbd-a40e-08d827966190
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H85mqx8AcSW2OCR+a4+DJQ9QGEjioVQ8LgZunjuZGeuxrb+vao3FeI26vmyIym6gSj048Jl+iab6oImQI4RbSGfCR5Q/sSM1cMDWlOS6ciIuDQZb6X1UeAxgZRlxePrBcU4smDPZIFozlugdevDRYkPoWNC1TANO51BnRIbgSoNfEaVX7YYow+SEPNzbEkuKQsbJzhJLijpBNhuIl3xP/m75P6nHDYROXtYLLQWVvbC0+/XxE8lbYnMpfW1VwvCmpXP6ocXSoiOGMX9ap1WiN9xDOw7hh0n8rUE9HSmM9Lhg5exurAIEYQCiMzLqTiyusjNV+BNpgK9mL+cYhhbwCR5PxoIrmrLvQyA1A2Zhz1RR/ax/WLgEifwGcGeRJnCVJWfO9hYHf50aixKUG/OMoRn659wil8y0sVTa2wN6syo=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2020 01:36:59.2544
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73ebab1f-c6ca-4f4a-94f1-08d8279666ab
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR03FT059.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3263
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

SGkgRGFuDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRGFuIFdpbGxp
YW1zIDxkYW4uai53aWxsaWFtc0BpbnRlbC5jb20+DQo+IFNlbnQ6IE1vbmRheSwgSnVseSAxMywg
MjAyMCAxMTo0OCBQTQ0KPiBUbzogTWlrZSBSYXBvcG9ydCA8cnBwdEBsaW51eC5pYm0uY29tPg0K
PiBDYzogbGludXgtbnZkaW1tIDxsaW51eC1udmRpbW1AbGlzdHMuMDEub3JnPjsgSnVzdGluIEhl
DQo+IDxKdXN0aW4uSGVAYXJtLmNvbT47IFdpbGwgRGVhY29uIDx3aWxsQGtlcm5lbC5vcmc+OyBE
YXZpZCBIaWxkZW5icmFuZA0KPiA8ZGF2aWRAcmVkaGF0LmNvbT47IEFuZHJldyBNb3J0b24gPGFr
cG1AbGludXgtZm91bmRhdGlvbi5vcmc+OyBQZXRlcg0KPiBaaWpsc3RyYSA8cGV0ZXJ6QGluZnJh
ZGVhZC5vcmc+OyBWaXNoYWwgTCBWZXJtYSA8dmlzaGFsLmwudmVybWFAaW50ZWwuY29tPjsNCj4g
RGF2ZSBIYW5zZW4gPGRhdmUuaGFuc2VuQGxpbnV4LmludGVsLmNvbT47IEFyZCBCaWVzaGV1dmVs
DQo+IDxhcmQuYmllc2hldXZlbEBsaW5hcm8ub3JnPjsgTGludXggTU0gPGxpbnV4LW1tQGt2YWNr
Lm9yZz47IExpbnV4IEtlcm5lbA0KPiBNYWlsaW5nIExpc3QgPGxpbnV4LWtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmc+OyBMaW51eCBBQ1BJIDxsaW51eC0NCj4gYWNwaUB2Z2VyLmtlcm5lbC5vcmc+OyBD
aHJpc3RvcGggSGVsbHdpZyA8aGNoQGxzdC5kZT47IEpvYW8gTWFydGlucw0KPiA8am9hby5tLm1h
cnRpbnNAb3JhY2xlLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiAwOC8yMl0gbWVtYmxv
Y2s6IEludHJvZHVjZSBhIGdlbmVyaWMNCj4gcGh5c19hZGRyX3RvX3RhcmdldF9ub2RlKCkNCj4N
Cj4gT24gTW9uLCBKdWwgMTMsIDIwMjAgYXQgMTI6MDQgQU0gTWlrZSBSYXBvcG9ydCA8cnBwdEBs
aW51eC5pYm0uY29tPiB3cm90ZToNCj4gPg0KPiA+IEhpIERhbiwNCj4gPg0KPiA+IE9uIFN1biwg
SnVsIDEyLCAyMDIwIGF0IDA5OjI2OjQ4QU0gLTA3MDAsIERhbiBXaWxsaWFtcyB3cm90ZToNCj4g
PiA+IFNpbWlsYXIgdG8gaG93IGdlbmVyaWMgbWVtb3J5X2FkZF9waHlzYWRkcl90b19uaWQoKSBp
bnRlcnJvZ2F0ZXMNCj4gPiA+IG1lbWJsb2NrIGRhdGEgZm9yIG51bWEgaW5mb3JtYXRpb24sIGlu
dHJvZHVjZQ0KPiA+ID4gZ2V0X3Jlc2VydmVkX3Bmbl9yYW5nZV9mcm9tX25pZCgpIHRvIGVuYWJs
ZSB0aGUgc2FtZSBvcGVyYXRpb24gZm9yDQo+ID4gPiByZXNlcnZlZCBtZW1vcnkgcmFuZ2VzLiBF
eGFtcGxlIG1lbW9yeSByYW5nZXMgdGhhdCBhcmUgcmVzZXJ2ZWQsIGJ1dA0KPiA+ID4gc3RpbGwg
aGF2ZSBhc3NvY2lhdGVkIG51bWEtaW5mbyBhcmUgcGVyc2lzdGVudCBtZW1vcnkgb3IgU29mdCBS
ZXNlcnZlZA0KPiA+ID4gKEVGSV9NRU1PUllfU1ApIG1lbW9yeS4NCj4gPg0KPiA+IEhlcmUgYWdh
aW4sIEkgd291bGQgcHJlZmVyIHRvIGFkZCBhIHdlYWsgZGVmYXVsdCBmb3INCj4gPiBwaHlzX3Rv
X3RhcmdldF9ub2RlKCkgYmVjYXVzZSB0aGUgImdlbmVyaWMiIGltcGxlbWVudGF0aW9uIGlzIG5v
dCByZWFsbHkNCj4gPiBnZW5lcmljLg0KPiA+DQo+ID4gVGhlIGZhbGxiYWNrIHRvIHJlc2VydmVk
IHJhbmdlcyBpcyB4ODYgc3BlY2ZpYyBiZWNhdXNlIG9uIHg4NiBtb3N0IG9mDQo+IHRoZQ0KPiA+
IHJlc2VydmVkIGFyZWFzIGlzIG5vdCBpbiBtZW1ibG9jay5tZW1vcnkuIEFGQUlLLCBubyBvdGhl
ciBhcmNoaXRlY3R1cmUNCj4gPiBkb2VzIHRoaXMuDQo+DQo+IFRydWUsIEkgd2FzIHByZS1mZXRj
aGluZyBBUk0gdXNpbmcgdGhlIG5ldyBFRkkgIlNwZWNpYWwgUHVycG9zZSINCj4gbWVtb3J5IGF0
dHJpYnV0ZS4gSG93ZXZlciwgdW50aWwgdGhhdCBiZWNvbWVzIHNvbWV0aGluZyB0aGF0IHBsYXRm
b3Jtcw0KPiBkZXBsb3kgaW4gcHJhY3RpY2UgSSdtIG9rIHdpdGggbm90IHNvbHZpbmcgdGhhdCBw
cm9ibGVtIGZvciBub3cuDQo+DQo+ID4gQW5kIHg4NiBhbnl3YXkgaGFzIGltcGxlbWVudGF0aW9u
IG9mIHBoeXNfdG9fdGFyZ2V0X25vZGUoKS4NCj4NCj4gU3VyZSwgbGV0J3MgZ28gd2l0aCB0aGUg
ZGVmYXVsdCBzdHViIGZvciBub24teDg2Lg0KPg0KPiBKdXN0aW4sIGRvIHlvdSB0aGluayBpdCB3
b3VsZCBtYWtlIHNlbnNlIHRvIGZvbGQgeW91ciBkYXhfa21lbQ0KPiBlbmFibGluZyBmb3IgYXJt
NjQgc2VyaWVzIGludG8gbXkgZW5hYmxpbmcgb2YgZGF4X2htZW0gZm9yIGFsbA0KPiBtZW1vcnkt
aG90cGx1ZyBhcmNocz8NCg0KSXQgaXMgb2sgd2l0aCBtZSwgdGhhbmtzIGZvciB0aGUgZm9sZGlu
ZyDwn5iKDQoNCi0tDQpDaGVlcnMsDQpKdXN0aW4gKEppYSBIZSkNCg0KDQoNCklNUE9SVEFOVCBO
T1RJQ0U6IFRoZSBjb250ZW50cyBvZiB0aGlzIGVtYWlsIGFuZCBhbnkgYXR0YWNobWVudHMgYXJl
IGNvbmZpZGVudGlhbCBhbmQgbWF5IGFsc28gYmUgcHJpdmlsZWdlZC4gSWYgeW91IGFyZSBub3Qg
dGhlIGludGVuZGVkIHJlY2lwaWVudCwgcGxlYXNlIG5vdGlmeSB0aGUgc2VuZGVyIGltbWVkaWF0
ZWx5IGFuZCBkbyBub3QgZGlzY2xvc2UgdGhlIGNvbnRlbnRzIHRvIGFueSBvdGhlciBwZXJzb24s
IHVzZSBpdCBmb3IgYW55IHB1cnBvc2UsIG9yIHN0b3JlIG9yIGNvcHkgdGhlIGluZm9ybWF0aW9u
IGluIGFueSBtZWRpdW0uIFRoYW5rIHlvdS4NCg==
