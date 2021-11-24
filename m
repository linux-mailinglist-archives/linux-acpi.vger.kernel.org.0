Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4B3345B0EB
	for <lists+linux-acpi@lfdr.de>; Wed, 24 Nov 2021 01:53:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232268AbhKXA4O (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 23 Nov 2021 19:56:14 -0500
Received: from esa14.fujitsucc.c3s2.iphmx.com ([68.232.156.101]:51102 "EHLO
        esa14.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232252AbhKXA4N (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 23 Nov 2021 19:56:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1637715185; x=1669251185;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UIEZXgO+RMJLd7Z9pKnKMiAEYi80CBSQGsRNvDIxA0U=;
  b=vDOJEP1+U6xjipetq+7V8Lu8uRAsjs+FMmY7nCj3fugYlixkI5NQiRiC
   s4yMWT7G9U8FCeA/gSw52eYuZwFFxw14r+Q+1OmZb1cnuB0bIE0LorxaA
   lmv0zR5+l7WSaAUupwKvNaxbl1CQpEGgjHTGBI0s1Bibtu2mL87IKsSU3
   DMLE6k50RtQrJ72Inl6tWMxNwR3Kvc5NG3RYX7w5icVPcXlRxRnkaMjiV
   WT3q+t0a09OV/bs7KFnHeZQViR+4Drw4WXQPb728KmkrL2SzZpg1FLE/P
   wOJqSQFp7CKoiYMY9WhOGb01cSkXRi3hGbGaVFbTft5HY/heeJw5fXCic
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10177"; a="44275465"
X-IronPort-AV: E=Sophos;i="5.87,258,1631545200"; 
   d="scan'208";a="44275465"
Received: from mail-os0jpn01lp2111.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.111])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2021 09:53:00 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PENmCQId4IrNHSWJx8fmJm6H7LSNUNCD4JNJeS+ok3qBBQSbPDKH+txb4RqiihBuFI7oflse/PCtp8y2j8oWRflhr5OuxzR6ojOGy2Um0Hpk6+gHFrlSMtomhaAfVSi0DQdLOKhDG1077rNOYUyooMgo1x8z2V1OJTpt2lTCaOih11Ng+4yU5Wg1T3wsRTeLjfx1EVGMffzKsWd3bX9e6g4awdabPQn68FTBN9Z5h3mJi+cwgRwFm50y2WEQTEZygndxkuIhTJF4mYqQDtva77vS2pETWXXKI7+aCY2CAvHDO6To10osL39dec7vibjC2u3YC3y0t1N56efSgMkCRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UIEZXgO+RMJLd7Z9pKnKMiAEYi80CBSQGsRNvDIxA0U=;
 b=bFOIyXuyvrDI6U43OVy+zwqvSIcFDoyskJzDHUGgS0XpJsNmRIHRLJy94kogh3QAHMo6ETZAy8YJsJVgbhOn7r5jMLlLQiE3iZ68ml+wqbDHMY4jAQJTDoWv4hhy6m/Qj/kzjYdiHjB7nZV00Mene5znt5rDw/laKlJd07Sdbmqfw4H+NpqDJOpOQBx11ZVRv8AG+Y5JVxY4acThZx6BMjZ1lbczqQh0kBLp1IAPi9p9OMY5OoyrW+MYGgL1Boea1S75sexnHc5wDacF1LkJaCHX+NT2bZkUVxMOW0A5oIwDgcgvltU/95ShsuX2vXsX4auTccU4vmqvT/bOt9yt1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UIEZXgO+RMJLd7Z9pKnKMiAEYi80CBSQGsRNvDIxA0U=;
 b=idMZGSw+g24lbaeBaIcKk3mBbARVvC0GBrBUOt69tNtyytu2/H3Tg3RoTEdqDn7QdGpZv80cUSn6PALjj5KIzxALfQto7T7cuVKSgej3GuhOQIdxScT9kXnERvLJD/keXpnaChJtEurthcsJGEc9ctaeCECVDdlU/li0ISdDg9k=
Received: from TYCPR01MB6160.jpnprd01.prod.outlook.com (2603:1096:400:4f::8)
 by TYCPR01MB6287.jpnprd01.prod.outlook.com (2603:1096:400:79::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.21; Wed, 24 Nov
 2021 00:52:57 +0000
Received: from TYCPR01MB6160.jpnprd01.prod.outlook.com
 ([fe80::9097:d9f3:3ce8:c65f]) by TYCPR01MB6160.jpnprd01.prod.outlook.com
 ([fe80::9097:d9f3:3ce8:c65f%2]) with mapi id 15.20.4713.026; Wed, 24 Nov 2021
 00:52:57 +0000
From:   "ishii.shuuichir@fujitsu.com" <ishii.shuuichir@fujitsu.com>
To:     'Hanjun Guo' <guohanjun@huawei.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "ishii.shuuichir@fujitsu.com" <ishii.shuuichir@fujitsu.com>
Subject: RE: [PATCH] acpi/tables: Add AEST in ACPI Table Definition
Thread-Topic: [PATCH] acpi/tables: Add AEST in ACPI Table Definition
Thread-Index: AQHX0fwdbkefXsM8TESWclCf3iAcSKwKlHGAgAdhQzA=
Date:   Wed, 24 Nov 2021 00:52:57 +0000
Message-ID: <TYCPR01MB6160ABE0B422073A35F3A58EE9619@TYCPR01MB6160.jpnprd01.prod.outlook.com>
References: <20211105041635.1481738-1-ishii.shuuichir@fujitsu.com>
 <a71761c6-5b8a-a4d5-c65a-7d3b3cd0d92f@huawei.com>
In-Reply-To: <a71761c6-5b8a-a4d5-c65a-7d3b3cd0d92f@huawei.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?utf-8?B?NTBfQWN0aW9uSWQ9OWFmY2QzMzQtMjEwOS00ZDBlLTkyMDgtZGI2MjAzMjJh?=
 =?utf-8?B?NGI2O01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5?=
 =?utf-8?B?LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX01ldGhv?=
 =?utf-8?B?ZD1TdGFuZGFyZDtNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?utf-8?B?LTNiMGY0ZmVjZTA1MF9OYW1lPUZVSklUU1UtUkVTVFJJQ1RFRO+/ou++gA==?=
 =?utf-8?B?776LO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX1NldERhdGU9MjAyMS0xMS0yNFQwMDo0NzoyMFo7TVNJUF9MYWJl?=
 =?utf-8?B?bF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfU2l0ZUlk?=
 =?utf-8?Q?=3Da19f121d-81e1-4858-a9d8-736e267fd4c7;?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d7b38a8e-c4c6-472d-7a43-08d9aee4c1e9
x-ms-traffictypediagnostic: TYCPR01MB6287:
x-microsoft-antispam-prvs: <TYCPR01MB6287DEA637F406854CE7C24DE9619@TYCPR01MB6287.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FVwfa+TlBtoVCO8pMx+ZrKLbW9J8AbAtTLV+Ln0tDswO2/kDDtcoR4RqJHnjvy2K0uz8C26rSQoBz0sSfgjRgrAcV4KVKLRaCPW0Imal26hwMT2WslAum1TPJn0VWgKLSXsjgTVu2IoAJAAlFp1nnfPF0nIanUDz2XfCJ/dYA6Pw9W78wm2wqGg+DHjDtONSFUmCPekxDlDeXwwrFFSEjB5OezU/WXty0yBSODRwnLqXnGZc0BslZuj/Yxd9TrKSILmXqN5+XsR5DR0QBbFcFJUDa2e/1tsxIVlnDef8ZDkx2YRTeniHvj5n4hxA9HW6iAYaogixwMDJo+tI91VmEr3XEcoRzqxxaUJikQiCWzAKe5fw9D4LqMrIPwzWh/Zy4LpMqqr+u0AmhJ7UOHFPYWTDP4eBvzBBsctd9t07w+x9JN8Zs012wl2g5KsA77ZTvKKSDf+csUErDP/maYredJIA1VxMNwxX7nKL/Ep8+sFs53915MLR+v/+bYmSMpnWL+QQzkxLh4Am3l32agXbKooZ9cxs2pk5oiXjCmBEJ9y+XyyCK2/Pz/2Vo4om9CEed+xoNtcx+mqLDq/8hwsYAlph1bZ2dGMLH5mH8m0r5VDnKpIRyMluEIkTf74lfenVKpeODYHVHWeyZ2pO3ROusQ9u+ARvVKqPTgmHfk5l7FGdvMvp+mE1IyKmUhwQDPy4UAMZW0DmC15aVzcBP9ILuA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB6160.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(508600001)(66946007)(66446008)(26005)(9686003)(76116006)(66556008)(6506007)(33656002)(53546011)(64756008)(66476007)(52536014)(7696005)(55016003)(186003)(107886003)(85182001)(71200400001)(86362001)(54906003)(110136005)(82960400001)(122000001)(2906002)(38100700002)(316002)(8676002)(83380400001)(5660300002)(38070700005)(4326008)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UEhuSjBuQkVQYmNuVVlyWHlsNWxkYlA4NHpKYWIrMlUrNDkyM0RsQkl4bVEr?=
 =?utf-8?B?MW1rekdXcGlmVE56aXM0dUxyaWJJdVZxc1ZCRHhTWXpzelNtZXBWRyswMDNi?=
 =?utf-8?B?cnA2RS80U1k0WlFIb3p6aGVPZVRyemZ2WnR1SmNxdFhmeE1aMXAxZmg1Q2ww?=
 =?utf-8?B?aDlaUU1Ca2ljbnVPK0tjeE5TZHg1NWJ6WXpmZUplRDZnYWp4R1FUODNITjFD?=
 =?utf-8?B?T2VWL0szMFY1Wmt6bko3UkJ1WEpFQ3hib1FOTHJ2TzQxR3Z4TVdGOGlvdjZM?=
 =?utf-8?B?dTZzdmZNUGd0NVA3eHdEY00wZ1BJRkhnV29HOHpOSTUzYXQ3cXZlbS96Q0ZF?=
 =?utf-8?B?M0p5UEEwWG5HK3VXMDBrNXFuUWc2WllXMGphY0xIZy8rbTVaR0poeFZUbTdK?=
 =?utf-8?B?aEJGTWViSTFvWDA1THU4WXF5N0JuSkg5R01LaGNxR283Q1J4TGdlaTV1a253?=
 =?utf-8?B?cVltbHMvamdXS29pRWFjWXZoUXkya29RS1NKVERaT1ZSUGtkbGhrVHhlQndl?=
 =?utf-8?B?RVFUbWxBeFFtNkluellkWmFZNHJ6ZnZtMmJ5UkY4OTBJdkZkN2ovMTM0MzVK?=
 =?utf-8?B?SW9Tbk11TTlWQ0MzUmQ2akx5YW44SmxnLy9IaERydjdBY0RqMHpvOUpESDI0?=
 =?utf-8?B?WmkxeENiWURvdkltNmIweFZZSTVYOW1vMWRNb1hpSUNsUDNJdUFMTWNxYmtF?=
 =?utf-8?B?RmFjeXpVRnpueENhWTVGVEVGQTdld1ZIdmNxOTJ3S3V2QlM1ZmpEbUticzRi?=
 =?utf-8?B?U0JXdmNoVjI2bk43OExoVG8vUlhCSVpxSjNlNjRRelVic3J0djRmRzZRZ0NC?=
 =?utf-8?B?WVdnVUxKamhxdnJ3UGxlQ2g0enExSVlEclgycldzVFBlZytGSmZjTFNlZ1Z6?=
 =?utf-8?B?SlNhMXRocjRlakV1b3J4ekw5OUYxY3lHVkpXbmhZTm1hY1R2dmx2cGo3UzZW?=
 =?utf-8?B?QTR5bVBqSHZ3TDE3UjVoYXVuS3J0ZUw4aVQxZUo5OTN1TzRhS2ZpS0RUY2xn?=
 =?utf-8?B?VUVMQ29TR0ZobzFPSFRhTzF2T3dpZDBtUC9rMTRjM0pORDdVK1hwVUQ3ajV1?=
 =?utf-8?B?N0toSkdlUExSY2FwYWRkeXpDQW81RkFWdEFNdFFqRXAzc1B4cXJ1aCtCRDI4?=
 =?utf-8?B?MEpnQkFLQ0xkMUhiYzJOQmZTakdjN3EvU0V1RE95NHFtYWtBU1dHbzM4TERq?=
 =?utf-8?B?YlZWVE51OUIxcDZiYnFTS2FXR3A5aXhkL1VtWHVDaFpNa1Z5RFB6QkdxUkZT?=
 =?utf-8?B?RG5mY3dwNDN3NTJmU2J5V0VYY05kVGFVK21JSHdqMlFCamhoMFE1WVYrVWtH?=
 =?utf-8?B?RGJRUUxMQTVGUDNuRWYxTmVsc3IyMm9XbmN5d3NpczIrSWJNL0xZTW9sd2sr?=
 =?utf-8?B?SVF2WEFsM21sblNUdkIxTUpwdEdFN0RranJER0pmWlR1anFMc1dkeGNYbnpL?=
 =?utf-8?B?RGdDczkxc3AyS1A2Vjh1MUQwWkswQkhtRm9FREdTY2YraWdkWGVTQ0w0WkVo?=
 =?utf-8?B?VzIvcitZRGpPandoYVVFOVBZMWJFcGFWN1dxZS9iMSt2RmhJZ0lDS3F6eXFS?=
 =?utf-8?B?bGYrUFo4azFiZnU3SDVYd0tRaStvQXJyZXpZeFF3YnA5Y2kxQW9rM2JaYVRL?=
 =?utf-8?B?ZEx2V3pBaDloMTBCNmFmbmFNZFpEakd6dUh4RFN6K3RMbGZUbHlIYWllaUJC?=
 =?utf-8?B?Ny9RUzhsMU9yWitqcTh5WExHclZEWTBSd2lxek9oUE5scEtTdnpCSk1iV3NV?=
 =?utf-8?B?ZldoOXNsZUhmSHhwdENMREllSWRxRFhLL01veFV3MkhHL2tQTittZldrOTk1?=
 =?utf-8?B?eFUya0d3YXlsL05uQUpWMGYzcmkydlJ0Q2hhTTNlTDJubXJIdVZaNW14bnBZ?=
 =?utf-8?B?Q1NFQlp4aE9HV3JPMUU2UTRwZktDRGduejI1c1lEVEl4REg1N1VDRUlvNEh4?=
 =?utf-8?B?L2JYT08ydk5nZURxODhIV01rcFNlYWtzVTdrazcwK2k2aGxXWXVoLzlxVmRR?=
 =?utf-8?B?eFpjcGhxTm8wVjNacXZOaHVuWFo5bmNQMFhFdW1mN3ZlcGRuTHBDc3VlU1Z6?=
 =?utf-8?B?STBjTSthSnJ6Tng5YTc1RWtNTUsycmlUNWVBN1dVSHJjWk1KMmxXUDg4NXFl?=
 =?utf-8?B?OWtCL2ZSTmNXVE9wNzFBNEU4SWhNaWp5Vk9zRVo0Y082WnRoYVBUcU80Y1cz?=
 =?utf-8?B?bnR5V253SkxUdmd0UldFaTBqdUhJTjdSY053Q1UyNTVqcDJPL0RQSlh5QTZH?=
 =?utf-8?B?V0tjM2M4ckw1WlVxMU5EdklIVkV3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB6160.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7b38a8e-c4c6-472d-7a43-08d9aee4c1e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2021 00:52:57.8298
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +Gp7Sehik5N3RK0Y+WAuvaN6t4A7nibcHAb5E9TShX5+OP9ur7iK4lYj1Pf12RrUjYO1jUb0TLjrkQBbF/XrLGI33TjCCfCTTffbFVQjfeI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB6287
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

SGksIEhhbmp1bi4NCg0KVGhhbmtzIGZvciB0aGUgY29tbWVudC4NCldlIGFwb2xvZ2l6ZSBmb3Ig
dGhlIGRlbGF5IGluIHJlcGx5aW5nIGR1ZSB0byBteSB2YWNhdGlvbi4NCg0KV2UgdW5kZXJzdG9v
ZCB0aGlzIHRvIGJlIGEgcG9pbnQgaW4gcmVzcG9uc2UgdG8gdGhlIGRlc2NyaXB0aW9uIG9mIHRo
ZSBwYXRjaCBjb21tZW50Lg0KV2hhdCBkbyB5b3UgdGhpbmsgb2YgdGhlIGZvbGxvd2luZyBkZXNj
cmlwdGlvbj8NCg0KV2hlbiBXZSBhZGRlZCBBRVNUIHVzaW5nIHRoZSBVcGdyYWRpbmcgQUNQSSB0
YWJsZXMgdmlhIGluaXRyZCBmdW5jdGlvbiwNCnRoZSBrZXJuZWwgY291bGQgbm90IHJlY29nbml6
ZSB0aGUgQUVTVCwgDQpzbyBhZGRlZCB0aGUgQUVTVCB0YWJsZSB0byB0aGUgbGlzdCB0byBlbmFi
bGUgdGhlIHRhYmxlIHVwZ3JhZGUgZnVuY3Rpb24uDQoNCkJlc3QgcmVnYXJkcywNClNodXVpY2hp
cm91Lg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEhhbmp1biBHdW8g
PGd1b2hhbmp1bkBodWF3ZWkuY29tPg0KPiBTZW50OiBGcmlkYXksIE5vdmVtYmVyIDE5LCAyMDIx
IDU6MDUgUE0NCj4gVG86IElzaGlpLCBTaHV1aWNoaXJvdS/nn7PkupUg5ZGo5LiA6YOOIDxpc2hp
aS5zaHV1aWNoaXJAZnVqaXRzdS5jb20+Ow0KPiByYWZhZWxAa2VybmVsLm9yZzsgbGVuYkBrZXJu
ZWwub3JnOyBsaW51eC1hY3BpQHZnZXIua2VybmVsLm9yZzsNCj4gbGludXgta2VybmVsQHZnZXIu
a2VybmVsLm9yZw0KPiBDYzogbG9yZW56by5waWVyYWxpc2lAYXJtLmNvbTsgc3VkZWVwLmhvbGxh
QGFybS5jb207DQo+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZw0KPiBTdWJq
ZWN0OiBSZTogW1BBVENIXSBhY3BpL3RhYmxlczogQWRkIEFFU1QgaW4gQUNQSSBUYWJsZSBEZWZp
bml0aW9uDQo+IA0KPiBPbiAyMDIxLzExLzUgMTI6MTYsIFNodXVpY2hpcm91IElzaGlpIHdyb3Rl
Og0KPiA+IFdoZW4gV2UgYWRkZWQgQUVTVCB1c2luZyB0aGUgVXBncmFkaW5nIEFDUEkgdGFibGVz
IHZpYSBpbml0cmQNCj4gPiBmdW5jdGlvbiwgdGhlIGtlcm5lbCBjb3VsZCBub3QgcmVjb2duaXpl
IHRoZSBBRVNULCBzbyBXZSBhZGRlZCBBRVNUDQo+ID4gdGhlIEFDUEkgdGFibGUgZGVmaW5pdGlv
bi4NCj4gDQo+IE1heWJlICJzbyBhZGQgdGhlIEFFU1QgdGFibGUgdG8gdGhlIGxpc3QgdG8gZW5h
YmxlIHRoZSB0YWJsZSB1cGdyYWRlIGZ1bmN0aW9uLiIgaXMNCj4gYmV0dGVyPw0KPiANCj4gPg0K
PiA+IFNpZ25lZC1vZmYtYnk6IFNodXVpY2hpcm91IElzaGlpIDxpc2hpaS5zaHV1aWNoaXJAZnVq
aXRzdS5jb20+DQo+ID4gLS0tDQo+ID4gICBkcml2ZXJzL2FjcGkvdGFibGVzLmMgfCAyICstDQo+
ID4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gPg0K
PiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2FjcGkvdGFibGVzLmMgYi9kcml2ZXJzL2FjcGkvdGFi
bGVzLmMgaW5kZXgNCj4gPiA3MTQxOWViMTZlMDkuLjI2OTliZjdlMjFhYiAxMDA2NDQNCj4gPiAt
LS0gYS9kcml2ZXJzL2FjcGkvdGFibGVzLmMNCj4gPiArKysgYi9kcml2ZXJzL2FjcGkvdGFibGVz
LmMNCj4gPiBAQCAtNTAwLDcgKzUwMCw3IEBAIHN0YXRpYyBjb25zdCBjaGFyIHRhYmxlX3NpZ3Nb
XVtBQ1BJX05BTUVTRUdfU0laRV0NCj4gX19pbml0Y29uc3QgPSB7DQo+ID4gICAJQUNQSV9TSUdf
V0REVCwgQUNQSV9TSUdfV0RSVCwgQUNQSV9TSUdfRFNEVCwgQUNQSV9TSUdfRkFEVCwNCj4gPiAg
IAlBQ1BJX1NJR19QU0RULCBBQ1BJX1NJR19SU0RULCBBQ1BJX1NJR19YU0RULCBBQ1BJX1NJR19T
U0RULA0KPiA+ICAgCUFDUElfU0lHX0lPUlQsIEFDUElfU0lHX05GSVQsIEFDUElfU0lHX0hNQVQs
IEFDUElfU0lHX1BQVFQsDQo+ID4gLQlBQ1BJX1NJR19OSExUIH07DQo+ID4gKwlBQ1BJX1NJR19O
SExULCBBQ1BJX1NJR19BRVNUIH07DQo+ID4NCj4gPiAgICNkZWZpbmUgQUNQSV9IRUFERVJfU0la
RSBzaXplb2Yoc3RydWN0IGFjcGlfdGFibGVfaGVhZGVyKQ0KPiANCj4gT3RoZXIgdGhhbiB0aGF0
LCBJJ20gZmluZSB3aXRoIHRoaXMgcGF0Y2guDQo+IA0KPiBBY2tlZC1ieTogSGFuanVuIEd1byA8
Z3VvaGFuanVuQGh1YXdlaS5jb20+DQo+IA0KPiBUaGFua3MNCj4gSGFuanVuDQo=
