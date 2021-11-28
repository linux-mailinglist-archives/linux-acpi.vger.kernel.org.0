Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB2F460B48
	for <lists+linux-acpi@lfdr.de>; Mon, 29 Nov 2021 00:56:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359639AbhK1X7d (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 28 Nov 2021 18:59:33 -0500
Received: from esa8.fujitsucc.c3s2.iphmx.com ([68.232.159.88]:50183 "EHLO
        esa8.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239202AbhK1X5d (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 28 Nov 2021 18:57:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1638143657; x=1669679657;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qZMZ3DMIk7b1GzRYWiawZlGPrwzVxqYS/IgMjS5saho=;
  b=ikD+mbtW3aexN1nwOdgkViU6eTx07zLDae7bl8XfrL27WOQSZQl2bplF
   wig+XNHKgIFTCsT5ylI7pH7L7FXZB9PNA+7lHAs90ilrVZ3z9ejk3Hshw
   iIQblVAavH7+Pamdyj422ZnJQOgOGMirRDjVYZeAaE1caP03rB2WSbzIj
   7ahCYCp17K859mCuKf60KvWe7H8IwM4WXLu3fZee3Rbh3j7RIGGsYqkB0
   rPcRS2P44lyi8Yip28z2vr0KU5waUbUXU9oLcMjfIMb4CZvkdeiiWa8Qe
   JaVZim/S/QAhWxcGx4nEWkZWBoO1dSvnbWlJ3pbGehMaAmB0NjHJ8ZUpm
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10182"; a="44667247"
X-IronPort-AV: E=Sophos;i="5.87,272,1631545200"; 
   d="scan'208";a="44667247"
Received: from mail-os0jpn01lp2110.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.110])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2021 08:54:13 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bhsQfLtgR/TWnpoZFQprKiGKlN3WKvj9CwY6t0wPTBrABgvOmO2O+z4oDHihJfR70Yrg1GZhlq7yUoQyIxOl2xjBwymRkAmfBW79JlK/A+Cd1Vt7EswwXAXRhZBWg4PcMcNVwr3I+eQok6qsts5/lNUYiNfcAfdUeS3ahqHA8y9VYaN4NcH8UBxsRo70ukrroqBIxat1E4tgWfNIaEcsxojGtX/XffTSEe0zY3XXgQ4FnWqjyTNyEdl5uzvczDQdVwar+uDNQLpvEBbTIe4UflsrE3Ex+zvyekJtLeniEAUntcCmueN6sWqpEEEZkTFQhxdm34+Izaa+eVishOmeQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qZMZ3DMIk7b1GzRYWiawZlGPrwzVxqYS/IgMjS5saho=;
 b=dIbgPu9iVF1Ko20fvQ2aK8lpmpG1GLmp496oG6yXa5Zjzj3ki4pgQxp09hZzLMK5NDZs9vuuexDbspHVQWGr3Re01EBJxwQBx3J/RSOVzLZin83odwDm/8i2CU9GDdE4GAVzt8hXUElHMfymVHXjklf3l5jNEeGU2JXTRJm1QCB6XnR/h5r2I4rJkPfyvpN9Xsh/SuDAFYuaYedKzBpV4qTO/pD7PxMtqpLDSTJFNi8iJv+KLXjlY6x8j+pGQeYwKH+3Jl1d1F3RbAddHgEBbtSGqbw8xKtvWTHKbChTVXTHwZ5r6lJwaMfizzIGWWYfk+6SYF8BjIM6dMlIqbIUTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qZMZ3DMIk7b1GzRYWiawZlGPrwzVxqYS/IgMjS5saho=;
 b=d3rQaHB/EMtKyt6SkQ4XScMF0hzL2l/Zl2vstdNYEpb2yj5Q8EZ4uloiY0K7LhYy2l6HFpQXV6VBnyOb4iIhafJbYvabYnb5XuN6TP8Y3Q10L1S8bFnEvyU9EPmduOgEKx9HAyr43Btlm3U88aKaJ+5Vh1tplUo0TWSxy0qxFhw=
Received: from TYCPR01MB6160.jpnprd01.prod.outlook.com (2603:1096:400:4f::8)
 by TYAPR01MB2605.jpnprd01.prod.outlook.com (2603:1096:404:88::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.20; Sun, 28 Nov
 2021 23:54:09 +0000
Received: from TYCPR01MB6160.jpnprd01.prod.outlook.com
 ([fe80::9097:d9f3:3ce8:c65f]) by TYCPR01MB6160.jpnprd01.prod.outlook.com
 ([fe80::9097:d9f3:3ce8:c65f%2]) with mapi id 15.20.4734.024; Sun, 28 Nov 2021
 23:54:09 +0000
From:   "ishii.shuuichir@fujitsu.com" <ishii.shuuichir@fujitsu.com>
To:     'Hanjun Guo' <guohanjun@huawei.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "ishii.shuuichir@fujitsu.com" <ishii.shuuichir@fujitsu.com>
Subject: RE: [PATCH v2] acpi/tables: Add AEST in ACPI Table Definition
Thread-Topic: [PATCH v2] acpi/tables: Add AEST in ACPI Table Definition
Thread-Index: AQHX4dcm2JuG1AW8kUqF41G/yqh75KwWsneAgALvUdA=
Date:   Sun, 28 Nov 2021 23:54:09 +0000
Message-ID: <TYCPR01MB6160526A9B559655FAEE2DEFE9659@TYCPR01MB6160.jpnprd01.prod.outlook.com>
References: <20211125083240.123131-1-ishii.shuuichir@fujitsu.com>
 <ae3dc745-13b0-7f9c-4929-527de4b92d97@huawei.com>
In-Reply-To: <ae3dc745-13b0-7f9c-4929-527de4b92d97@huawei.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?utf-8?B?NTBfQWN0aW9uSWQ9ZTdmMGMzYzgtNDU1MC00YmI1LTlhNTItYjFmM2E1NmZh?=
 =?utf-8?B?MWFmO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5?=
 =?utf-8?B?LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX01ldGhv?=
 =?utf-8?B?ZD1TdGFuZGFyZDtNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?utf-8?B?LTNiMGY0ZmVjZTA1MF9OYW1lPUZVSklUU1UtUkVTVFJJQ1RFRO+/ou++gA==?=
 =?utf-8?B?776LO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX1NldERhdGU9MjAyMS0xMS0yOFQyMzo1MDozM1o7TVNJUF9MYWJl?=
 =?utf-8?B?bF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfU2l0ZUlk?=
 =?utf-8?Q?=3Da19f121d-81e1-4858-a9d8-736e267fd4c7;?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d4ada589-4213-47e7-daf9-08d9b2ca5f08
x-ms-traffictypediagnostic: TYAPR01MB2605:
x-microsoft-antispam-prvs: <TYAPR01MB26058728FEAF5C0D632AB250E9659@TYAPR01MB2605.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QePmeYY5l8rHnVQZ/aTsEMpcUqkNTHgP5z/yzCLuquc1DF/zgwBv80kqgysksSiSJjiK9ff9yyfuczya03dDT81FYuE9p0d3/aj8zr+eYyh1LmyG81UdDQ8SSVCVnzOQB1ARjVNHf6OcJqtdEteS3aA2UJA6uml4mYjeAC8UQQb4u58IKtQgEjRJCwkFfliRSQZrLz6ac3gH4OklmxymmcD3IGlM7wxcDKwqV5xRvZLbD3FPckZea2p4ON5zZtERcytl3vyIP//S41bhVbn+w75y5ysEOvbWeovsoKi26OhIyfmNlWVrAqJ2AZKmRwcgI7wgM2hCQdUBYVwlaGVr1VQRubd74qpkAne0TnWUyVtE7hUh8iB/td6AE+PDOWQPVlPHgXK7v53zpfUgbJxeIoHJgMbthnQrj07TBjLXV4a8ObxOLRPJuXB0O6nrP08SBUnPHfK16Iv/iQr+NvEpWatO+VNRjxQtb4EC+kRIbX30lDJQOppbQc/HdbQfT/iaPtgwJXLJqiNixdcnrvglJ+A2+Sq6a6FTjvWtjGzrMLG5xPAwXCQSdCSbvq2VVbijhx/b7PQAhV9/B/X14pd1524HLo/2LMwTxSJMBUEOz9GqPfZXRykNcI0WN5PdW1lejvZLFJXyjCAF5b+DW8IEFBFDmYEovKuHup1MIFtNnN/bWX0basL7tfuFiLqhAYqqhxGUG9d/zZz1kUjkmxxZNA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB6160.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(82960400001)(54906003)(110136005)(38070700005)(2906002)(66556008)(66946007)(52536014)(33656002)(86362001)(66446008)(64756008)(66476007)(316002)(5660300002)(122000001)(85182001)(71200400001)(76116006)(83380400001)(9686003)(26005)(8676002)(7696005)(107886003)(53546011)(38100700002)(8936002)(6506007)(4326008)(55016003)(508600001)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ejVBc0VjUFRDL01TQklSTi9UNHFyTEZ0cHBCdm9ySEl2bytPMUVrMVZkVWJ1?=
 =?utf-8?B?eUhhaU43NXp0RmZCbWNBZ21KN0wyZWhjL3lQRHMvTXhFcHkyaWp4enloYjVv?=
 =?utf-8?B?L01RWlpNTnExM3N4UGdtbE9ZS0pEbXRmRW1BZ1lHRHNLcm1EcWRiVnZZT3Uz?=
 =?utf-8?B?blRERFhNa291R1V4cFlwelorWFVueld5bnhzVTd2SHBnK3FydXp5cXVJcWxo?=
 =?utf-8?B?bTVsVE5RNjZ5cGc2OGh5ZHFmRVdHb1k0Q053ZXYwYW9CaSszeWlCQ21DY3ZP?=
 =?utf-8?B?MitzazYwNThUUTIwR2JMZHJrR0o2UXJEZkZIS2xMM3NZS2dIT3o5ZmpPVEda?=
 =?utf-8?B?dlFzK08wZWwwN3VDdzZtdHdDWHRxZ29vamJIbGFqa0k0SG5lU21BelNiNW5D?=
 =?utf-8?B?Tk9RRzF0L0NmWWRyWmNyeHdEQ010a2VVc2h1VDI3azZCd1VLdldzTVdxbHRa?=
 =?utf-8?B?bWM3MEtubGo2TlRBVElLR0MrNWtwbmhqWHdIK3lSamxrblFOUzYrbm1EY2RJ?=
 =?utf-8?B?YU5iU3VTRSthUytXYmg1cDV6dDA4NFhxcWpERUk3cWdFVCtSNE1RR2ZYWnZU?=
 =?utf-8?B?K0Z4bW9VRHRrK1RKREErQzBabVo2b21PN05jTTJkK00xcDUzNVdIV0JOK1FR?=
 =?utf-8?B?djd6bTB3dFhaWWE2N2ZRU2dSc0tNbnI5Ris0dm5zZkNndEZ6blFyQkYrNUZP?=
 =?utf-8?B?T1l4SmxGQVROYVloYjJ3NVlUTnpNUDh1T0VQa2FoVUlEU3FqUHNWblY0aVdi?=
 =?utf-8?B?L3VCWGpUN3lFQzJ1SEIyclhVS2pTL2NjQkYxaHdNUi94cGg0QVlBRnZUcWU4?=
 =?utf-8?B?Y0N1U0dBZUNqaGs4VVlCLzRMS1R2KzJmSWRyRjNocTEwc1Rzc2JrR2psYU1S?=
 =?utf-8?B?d1FRU28zQzlMd0U3QXNOaGZiUW1OVXhVWFdYdXQyc2JlbkxmenY3SGtmcFgr?=
 =?utf-8?B?dlVJaTdpRkNaRHh3b0xYM3BDLzEyeHpOc2RwZkRoNFlZbGR2YStJc1Q3TU9z?=
 =?utf-8?B?U2sxNUhTbERsZFlOR1lKd09qbmxxMGZRSlY2ODhlRzJiREErRXB1cllLY0pn?=
 =?utf-8?B?WjNVeGdaemZ3c2RjMWIvMSt0eHlCS0dZRjFpaU5HcGFrc3htNTExTFFOaFU3?=
 =?utf-8?B?WG9ZNVlINDJBM2owSHQ4NXNMQlA3dE5pZ3BKaGlrejllOXVTZDU2T29OZnpo?=
 =?utf-8?B?ZE1iYzltc1UxWFkwdnJnUkFCNVovN1hQOEtJOGZSY0lDYnlabVBWOUFEZHdK?=
 =?utf-8?B?OGtvemV5TVlQSjMvbTlCV0wzOVFLZ2VVbHM1UEhmTG9qZllmaGlpazRpY0Jn?=
 =?utf-8?B?N3lEdUVwTVpkTXNvNVVjQWtURUNEcXA2T0NLUFo5a2dxWGg5WTZ5K3cyeW1Y?=
 =?utf-8?B?cFdhdHpCdFArTEFLMWtvbTV1aXc0cUxVZEVkLy9mQlorMnM5dENvajBHUnNF?=
 =?utf-8?B?TnVtbzNyZStHS29vZFRDdlpqU3pjaWgrVXB5d3VSaExIc0IwYlZFbktxQlUw?=
 =?utf-8?B?OUdRVm5PK1ExZW1KNDY2c1hhYWFmZURRZ21CZzJzdlVEOVdLMnNpcGF4Y2Fa?=
 =?utf-8?B?c2gzeGJ6bEN0bmlXY3VJNXNCQ25SM0w0aldPZmYvb2pRd1R3ZkhxNVkrcit6?=
 =?utf-8?B?REtBZ0ZleXdLNEpuMm81R01Oc0d1M0JmREoycGhDOG1JSmg5azhiT2VPVTVB?=
 =?utf-8?B?MEp1MVFhWU9LM3VLZ2RJMncwL0NPc29IY1NVbEZ6UUt4aU1JV3N1OXlzYXNv?=
 =?utf-8?B?dXFLQ0JpR1ZEVUM5VFlSdGhoSXR4V3N2djdrQnYyR2ZxbkhtQTBHRHVhdmdT?=
 =?utf-8?B?cGlVOTRBZjl3WTVhUnRlellsL1RvWURVQ0RPN25MakxJZm5JdmJNelBKcndi?=
 =?utf-8?B?R01ZZm5tOGExY0V2Ukp0SzVYSzZmcW0wMzRac0NFTEU1b292RHJTQmNudXNS?=
 =?utf-8?B?RHU4T0hUYVNRNG10S0kwb1hpQ3VBRFZLa0c0UHYzQVFROE9rSDhzOWdnWmYy?=
 =?utf-8?B?SGYvbW9oREkwQjJZWEZXWkVJaXp1TWZPK1VESE5URDhKRWZ1TW9aMkpsSHJB?=
 =?utf-8?B?T2NYbmtXKys2MkQxS0FoTC9FTTJJNnNDQ1pIYUViNE5jdXAxT3BWK2xhdi85?=
 =?utf-8?B?eTZwYjA4YnUyeWMvL01FSHRSeTkyMktDYnU2WDAySzBqcFJ2UlRBMjNjQ3JV?=
 =?utf-8?B?cWpNbm0vcEZHK1JjcVNLVytmbVJMMTB3YmpQY2RNVFo4VWZJeG91b1o0dE40?=
 =?utf-8?B?UkRpM3NDSnVFSFk1SThtOGtaRXB3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB6160.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4ada589-4213-47e7-daf9-08d9b2ca5f08
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2021 23:54:09.6164
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pMM6lrHknRBZFNBoUuTE9m7ZElFgujY82pGEa8m1fKW9WQ71b7bnn/i6CTdZP8Nbek2kdVnCrEEXe4o2tiBKxzRHBqaf38Xt1yoZac+R6/k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB2605
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

SGksIEhhbmp1bi4NCg0KVGhhbmsgeW91IGZvciB5b3VyIGNvbW1lbnQuDQpXZSBhcG9sb2dpemUg
Zm9yIHRoZSBiYXNpYyBtaXN0YWtlLg0KDQpXZSB3aWxsIHRyeSB0byBmaXggaXQgYXMgZm9sbG93
cywgaXMgaXQgT0s/DQoNCi0tLQ0KU3ViamVjdDogW1BBVENIIHYzXSBhY3BpL3RhYmxlczogQWRk
IEFFU1QgaW4gQUNQSSBUYWJsZSBEZWZpbml0aW9uDQoNCldoZW4gV2UgYWRkZWQgQUVTVCB1c2lu
ZyB0aGUgVXBncmFkaW5nIEFDUEkgdGFibGVzIHZpYSBpbml0cmQgZnVuY3Rpb24sDQp0aGUga2Vy
bmVsIGNvdWxkIG5vdCByZWNvZ25pemUgdGhlIEFFU1QsIHNvIGFkZGVkIHRoZSBBRVNUIHRhYmxl
IHRvDQp0aGUgbGlzdCB0byBlbmFibGUgdGhlIHRhYmxlIHVwZ3JhZGUgZnVuY3Rpb24uDQoNClNp
Z25lZC1vZmYtYnk6IFNodXVpY2hpcm91IElzaGlpIDxpc2hpaS5zaHV1aWNoaXJAZnVqaXRzdS5j
b20+DQotLS0NCnYzIDogQ2hhbmdlZCB0aGUgbG9jYXRpb24gb2YgdGhlIGNoYW5nZSBsb2cgc28g
dGhhdCBpdCBkb2VzIG5vdA0KICAgICBkaXNhcHBlYXIgd2hlbiB0aGUgcGF0Y2ggaXMgYXBwbGll
ZC4NCg0KdjIgOiBUaGUgcmVhc29uIGZvciBjb21taXR0aW5nIGluIHRoZSBjb21taXQgbG9nIHdh
cyBub3QgY2xlYXIsDQogICAgIHNvIGl0IHdhcyBwb2ludGVkIG91dCBhbmQgY29ycmVjdGVkLg0K
DQogZHJpdmVycy9hY3BpL3RhYmxlcy5jIHwgMiArLQ0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2Vy
dGlvbigrKSwgMSBkZWxldGlvbigtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9hY3BpL3RhYmxl
cy5jIGIvZHJpdmVycy9hY3BpL3RhYmxlcy5jDQppbmRleCA3MTQxOWViMTZlMDkuLjI2OTliZjdl
MjFhYiAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvYWNwaS90YWJsZXMuYw0KKysrIGIvZHJpdmVycy9h
Y3BpL3RhYmxlcy5jDQpAQCAtNTAwLDcgKzUwMCw3IEBAIHN0YXRpYyBjb25zdCBjaGFyIHRhYmxl
X3NpZ3NbXVtBQ1BJX05BTUVTRUdfU0laRV0gX19pbml0Y29uc3QgPSB7DQogICAgQUNQSV9TSUdf
V0REVCwgQUNQSV9TSUdfV0RSVCwgQUNQSV9TSUdfRFNEVCwgQUNQSV9TSUdfRkFEVCwNCiAgICBB
Q1BJX1NJR19QU0RULCBBQ1BJX1NJR19SU0RULCBBQ1BJX1NJR19YU0RULCBBQ1BJX1NJR19TU0RU
LA0KICAgIEFDUElfU0lHX0lPUlQsIEFDUElfU0lHX05GSVQsIEFDUElfU0lHX0hNQVQsIEFDUElf
U0lHX1BQVFQsDQotICAgQUNQSV9TSUdfTkhMVCB9Ow0KKyAgIEFDUElfU0lHX05ITFQsIEFDUElf
U0lHX0FFU1QgfTsNCg0KICNkZWZpbmUgQUNQSV9IRUFERVJfU0laRSBzaXplb2Yoc3RydWN0IGFj
cGlfdGFibGVfaGVhZGVyKQ0KDQotLQ0KDQpCZXN0IHJlZ2FyZHMsDQpTaHV1aWNocm91Lg0KDQo+
IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEhhbmp1biBHdW8gPGd1b2hhbmp1
bkBodWF3ZWkuY29tPg0KPiBTZW50OiBTYXR1cmRheSwgTm92ZW1iZXIgMjcsIDIwMjEgMTI6MDEg
UE0NCj4gVG86IElzaGlpLCBTaHV1aWNoaXJvdS/nn7PkupUg5ZGo5LiA6YOOIDxpc2hpaS5zaHV1
aWNoaXJAZnVqaXRzdS5jb20+Ow0KPiByYWZhZWxAa2VybmVsLm9yZzsgbGVuYkBrZXJuZWwub3Jn
OyBsaW51eC1hY3BpQHZnZXIua2VybmVsLm9yZzsNCj4gbGludXgta2VybmVsQHZnZXIua2VybmVs
Lm9yZzsgbG9yZW56by5waWVyYWxpc2lAYXJtLmNvbTsNCj4gc3VkZWVwLmhvbGxhQGFybS5jb20N
Cj4gQ2M6IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZw0KPiBTdWJqZWN0OiBS
ZTogW1BBVENIIHYyXSBhY3BpL3RhYmxlczogQWRkIEFFU1QgaW4gQUNQSSBUYWJsZSBEZWZpbml0
aW9uDQo+IA0KPiBPbiAyMDIxLzExLzI1IDE2OjMyLCBTaHV1aWNoaXJvdSBJc2hpaSB3cm90ZToN
Cj4gPiBXaGVuIFdlIGFkZGVkIEFFU1QgdXNpbmcgdGhlIFVwZ3JhZGluZyBBQ1BJIHRhYmxlcyB2
aWEgaW5pdHJkDQo+ID4gZnVuY3Rpb24sIHRoZSBrZXJuZWwgY291bGQgbm90IHJlY29nbml6ZSB0
aGUgQUVTVCwgc28gYWRkZWQgdGhlIEFFU1QNCj4gPiB0YWJsZSB0byB0aGUgbGlzdCB0byBlbmFi
bGUgdGhlIHRhYmxlIHVwZ3JhZGUgZnVuY3Rpb24uDQo+ID4NCj4gPiBDaGFuZ2UgbG9nOg0KPiA+
IHYyIDogVGhlIHJlYXNvbiBmb3IgY29tbWl0dGluZyBpbiB0aGUgY29tbWl0IGxvZyB3YXMgbm90
IGNsZWFyLA0KPiA+ICAgICAgIHNvIGl0IHdhcyBwb2ludGVkIG91dCBhbmQgY29ycmVjdGVkLg0K
PiANCj4gUGxlYXNlIHJlbW92ZSB0aGUgY2hhbmdlIGxvZyBpbiB0aGUgY29tbWl0IG1lc3NhZ2Uu
DQo+IA0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogU2h1dWljaGlyb3UgSXNoaWkgPGlzaGlpLnNo
dXVpY2hpckBmdWppdHN1LmNvbT4NCj4gPiAtLS0NCj4gDQo+IFlvdSBjYW4gcHV0IHRoZSBjaGFu
Z2UgbG9nIGhlcmUgdGhlbiBpdCB3aWxsIGJlIHJlbW92ZWQgd2hlbiBhcHBseWluZyB0aGlzIHBh
dGNoLg0KPiANCj4gVGhhbmtzDQo+IEhhbmp1bg0K
