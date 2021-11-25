Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E65645D225
	for <lists+linux-acpi@lfdr.de>; Thu, 25 Nov 2021 01:35:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344723AbhKYAiP (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 24 Nov 2021 19:38:15 -0500
Received: from esa16.fujitsucc.c3s2.iphmx.com ([216.71.158.33]:52025 "EHLO
        esa16.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344453AbhKYAgO (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 24 Nov 2021 19:36:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1637800385; x=1669336385;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=V7AKw6eL7rVWrpemUdFkDaC7e+ucREXLa6Zx3WXhpGk=;
  b=OskunbjSgEezLa6desZFmEBOW/IwY+K1uVAVVQRi8NeNxJaGytzaUIzS
   hbEZqawBmyUmmcs7XbUuWbGG0MgxbMvr6gNo55KeyT4zXDkQcDSikB5g7
   iOwvo0fpVv2Gvbao3uKxHh4Ld4rGcEbby6bNs6+TBtrjqMyW0ITySXPHO
   B+n+nXjHB9+caIoTgm1UnObZB1ET8naMQAOLwbCP68oZ3PNmKhX9ZSnYC
   YDIPYdwOUTRVyJU1OgzNrVNIhnzJBMlzush79kAuq2ohRbC8k7gBCJ8wI
   rwRWY2TtsAHDDCXVmEnkngr4WorMd0tsGi6IOXqKzfEZuPPiEr/dN/MEr
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10178"; a="44466618"
X-IronPort-AV: E=Sophos;i="5.87,261,1631545200"; 
   d="scan'208";a="44466618"
Received: from mail-tycjpn01lp2176.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.176])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2021 09:33:01 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NEb0r6OKXZIOK5K2kD1APN0Vzp7s2Opp2gh6c8QxTsftSxxhSvQ218brfTeN8Dq1z2GMEk8wg0hHBq9JLVqe7ad6i5NDh1eQVD/SakN/mI/oLjl7t0Z6eofyifD/70SwKkSmfUA1Jv23fAKF+06HCv5/3ctByg6kekAdiqvIaJ8inORSDaLy907O0FBVDz1+MIebRoJUMBQCDMhBeIh9oJcjeueIX4XyrL61mYG74nd44P++uzfyxxky2X6ynXVlPUMu/yAa1r02pTIajvrbtrRLhlV3DuJ6rWkzU+/bmz9hLCDY3j+BJDcuTjYVASVnVFtsic1vfL0J9kfdG7ptvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V7AKw6eL7rVWrpemUdFkDaC7e+ucREXLa6Zx3WXhpGk=;
 b=eVUfjEmI41yyQAha81nF7ky+5SgGM9X3/rAiFOUx8nMZuG/Nf7apKNzIDy9wxZIwMqHdPklcLchyOFYguJEbkWYr037dUwjUEmsniBzUfdkJoiNvMTlO7W0oxOKS2gQqo/9wT0QRBQlKKYCLtqh7vNnb6F9pDPzHZeG4rbEzPaRPPK1Pcdc1tSALZq2oXIKeSSkybYZiA557E83sRlLSlLNv2MjhlhlsqoYeTFniYLD1N2k4Z40w+a5QbPanRH5LPeDLWI2nKubT28cVD9VgFvWFnmuNN5xbGK4NqXvsDy9jSIB7doTsDXCeNaUI3jYARNrLkdDdTVW5kbYe1cbkMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V7AKw6eL7rVWrpemUdFkDaC7e+ucREXLa6Zx3WXhpGk=;
 b=NfJx5FlgC4YDqGgwNztRsGduR1c3QpnsJMEBTb/cHRYjWmTd2wssNdtQFFN60GkTiT7/6PBE79n2JBthjJ4/SZfxQ5G4y14CvZLGPigUp6ESrGcIOFZs4ZLNrbh7D6wl1WU50ePYhURWwe8Bma5nKmVkWiMJRRty3HD6PDH90qI=
Received: from TYCPR01MB6160.jpnprd01.prod.outlook.com (2603:1096:400:4f::8)
 by TY1PR01MB1771.jpnprd01.prod.outlook.com (2603:1096:403:7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.20; Thu, 25 Nov
 2021 00:32:57 +0000
Received: from TYCPR01MB6160.jpnprd01.prod.outlook.com
 ([fe80::9097:d9f3:3ce8:c65f]) by TYCPR01MB6160.jpnprd01.prod.outlook.com
 ([fe80::9097:d9f3:3ce8:c65f%2]) with mapi id 15.20.4713.026; Thu, 25 Nov 2021
 00:32:57 +0000
From:   "ishii.shuuichir@fujitsu.com" <ishii.shuuichir@fujitsu.com>
To:     'Hanjun Guo' <guohanjun@huawei.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH] acpi/tables: Add AEST in ACPI Table Definition
Thread-Topic: [PATCH] acpi/tables: Add AEST in ACPI Table Definition
Thread-Index: AQHX0fwdbkefXsM8TESWclCf3iAcSKwKlHGAgAdhQzCAAGs6gIABIpTA
Date:   Thu, 25 Nov 2021 00:32:57 +0000
Message-ID: <TYCPR01MB61604F59E2F85B1111C8A736E9629@TYCPR01MB6160.jpnprd01.prod.outlook.com>
References: <20211105041635.1481738-1-ishii.shuuichir@fujitsu.com>
 <a71761c6-5b8a-a4d5-c65a-7d3b3cd0d92f@huawei.com>
 <TYCPR01MB6160ABE0B422073A35F3A58EE9619@TYCPR01MB6160.jpnprd01.prod.outlook.com>
 <9f2dfba4-4802-27d3-bc14-071f84a4824a@huawei.com>
In-Reply-To: <9f2dfba4-4802-27d3-bc14-071f84a4824a@huawei.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?utf-8?B?NTBfQWN0aW9uSWQ9ZjVjMzYxMTItMmZjYS00MjhmLThiZDctNDU3ZWY3MTdl?=
 =?utf-8?B?ODhiO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5?=
 =?utf-8?B?LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX01ldGhv?=
 =?utf-8?B?ZD1TdGFuZGFyZDtNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?utf-8?B?LTNiMGY0ZmVjZTA1MF9OYW1lPUZVSklUU1UtUkVTVFJJQ1RFRO+/ou++gA==?=
 =?utf-8?B?776LO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX1NldERhdGU9MjAyMS0xMS0yNVQwMDozMTowOFo7TVNJUF9MYWJl?=
 =?utf-8?B?bF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfU2l0ZUlk?=
 =?utf-8?Q?=3Da19f121d-81e1-4858-a9d8-736e267fd4c7;?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fd6afe58-bc4e-4ab8-6375-08d9afab2118
x-ms-traffictypediagnostic: TY1PR01MB1771:
x-microsoft-antispam-prvs: <TY1PR01MB1771841C61F2FCA3E5B250DAE9629@TY1PR01MB1771.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2Wst2PlVH0eg1CVvci/7p4xo0zLwijJJUg0QJHgJ5MxziK56oWzv0xHYg4rHV/8i6K/yFZGw7RIsQ62kAwlQaj3lGSwas84J2s1bSkzjUpqDsRCOiwEsk3NC0ihsINUlhDvXDPlzwZvWecOwCyLr5ZrUozvoglz0507G7p09fnkHx6rDbNTWrZuoe7I2e2WMw5g79jaPeo4m0QPIDCcNBX4HWZ7r7Nm0+pfWDdcNdtY+0TGj92qJ9y0uC07K4VoCUoJrYBRlVAwnuEyRwzcmYVOH/s+i15zGJq/Fj1r3b5TWts2Ton/arLp9u4gt7IrBGcJMakYUVCt4KdPk12WaBwNG9YXxyzq9ckeR+sQ/QCyRIF5G8fYEASxvS8qwzFNWqioonAqx3BRqZScxdyEYiTkVI0HkNsYtdBDPsX/ChGbKA/xxEaH08jH5c6vzLIcZP40r8xpQRCNXGr0c83XZPcJUMcmozIBFt1fNv8jGnKOdBB3xL92Jv/1/XKIya6NSnPHWDhnnNw0S4eCpiEnFpazi6JgECpv6EHSAczslT1X6JzSynS0tNosTgdPfaBmDY8SLK5vfWZa4yG6T6QGBItv/N3cvsZuceXsUJfFhnKc5Eedfc5se41y7H1Ap5yxqoB3SigWzMZkj6fn8aU9IyZ25JbPTV/GFi4prxBuiFpnxSdfUmEpCzBUZXrbDHUnTpnDJ7WT+l247HegaoP8eHw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB6160.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(85182001)(53546011)(38070700005)(8676002)(316002)(9686003)(33656002)(6506007)(38100700002)(83380400001)(7696005)(508600001)(76116006)(66476007)(110136005)(66556008)(66446008)(55016003)(26005)(122000001)(4326008)(5660300002)(71200400001)(186003)(86362001)(2906002)(64756008)(8936002)(52536014)(82960400001)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SEZnanJwaC9reHlvTlhoMGtZSFBQalMzeFRITFkvSFNNZGNsK2VyNmxoTkti?=
 =?utf-8?B?eVVaK1p0UXpSbGtTVTZPV3U4allkNk1kTThRQUJCRUhQUHdyUEpBL2ZGOGs0?=
 =?utf-8?B?SlZDdDh4dGxpREhvR0RKNWkvL2lKa3JlVkxDSGQ0TDVLR0N2anVwUDE3emhi?=
 =?utf-8?B?SE9RZEpsV3p2aUVsNjBSUHd6WUgxWDlIUC8wZjBRbi91SGNYZUdEaUs5Y2Zt?=
 =?utf-8?B?eE9Jc0I4bGxVNkRrcEtlVWs2UU4wRE42bDlXMHI5VHIwQlFsZnR6WkZ5V05I?=
 =?utf-8?B?UnVpK0R2MElRQTVyZjd2aWlVL0gzK2VHUnhSUlBZVzdObVJBbGp6T1F5ZVJY?=
 =?utf-8?B?ZnhTanB4SHFmdDgyNEV3UnRpSnZ4K0pwZW5jaUhQTlBiMmh1ZlVLa0c4OXYx?=
 =?utf-8?B?Z1VzYU5pVXpHd0pjVjNaaVoyMElZRTBGK09pbmxHV1hldnVKbGtmOVo5b3FX?=
 =?utf-8?B?aVlnTGtjR2Rjc2NLbEFCbUFRTjRoOFJPUUY5eWJiZmpMWGNUbzBrUkJ6U2VU?=
 =?utf-8?B?Q1EzcFZwSEsraTBXZUY2cUJ3eWprL3l4ZUJTV0Rsa1I3VUZvSkJyUGltdlJH?=
 =?utf-8?B?eFhvYnhXV0YrNEdaU3RUaXdEaWd4dDVQOHpDVWs5R3A4QkpUVkhXSzZBRFcv?=
 =?utf-8?B?QWJlQlJxNTg4R1pwb2crUVhRVmh6QmpPNmFrRk1QKzRWU01WVXZycGZmemd3?=
 =?utf-8?B?alVqeTNKaXYrQVAxTjFVRklBTGtuTlFWWHJ5R0xSL3U2dGw4NGtDU0NIZllo?=
 =?utf-8?B?TnF4NW0rT2JtNk1HMFJ3Zzc5ZkNBVjV3clhja2FYaWtUZ0txYmMydURWSDFY?=
 =?utf-8?B?YUt5S1RZNS91bGxhRWxUenNaTzE0R2w3RFU4UThDN0JGV1FucjZOd0xmaGx4?=
 =?utf-8?B?RzAxaHZ0MDlKMms2bWRhVDhBdW1jQmlqTzkybFh2bmlVZWZuQllkWDBERURX?=
 =?utf-8?B?ZTBidjlMcHZRZzhlS1ZWdjhRNzlFQk9jTVVNUG5HODRuYTRUTGs1andFdkI0?=
 =?utf-8?B?WCtDcnJrNUVGdnJZbEVLUGV1L2lBVUhPN1o3RFltbktINVJVUEtkb05ZUGtO?=
 =?utf-8?B?NTV0M3N6RTQ5MUtEd0ZSUUhxY1ByV01NRmJYdWZBeDhCZGIwTU9qb2NKQVdv?=
 =?utf-8?B?S216bjh1WUxqWVoycnl4N3BMV0tTb1R6cUdkZktBU1lCMUpqLzl1RW9rdEdI?=
 =?utf-8?B?b25aUDB6b1F3TEhFN3JFVUUvNlgweW5ZNDY2UE91a0ZrZzNFUEZDRUhCR3Yw?=
 =?utf-8?B?by9ySUI4S1pmWFo5M1hrMkh3S1Z5azh0UjQ3bWozL1hsN2sreWlCSFI4YmZB?=
 =?utf-8?B?M0VTeVN3L0kvYmdLTHpxaCtuTXk0VTM2V3pZUHhrMWR2dkF5Vy9kTERkZnhj?=
 =?utf-8?B?YTY4VVMxcDl2STJhcUhLWDViNVdnNFRXc0FnUDM5SzlLQ2NIQW1KSThKc21Q?=
 =?utf-8?B?K21qY1hta2pCV2RrT2VRT0tib0xodno3a0RXck9uQTJRUzJEeHlybHE5VTlt?=
 =?utf-8?B?VUQ2cmhqaXJCdFdjSFN5YVJabkFsT1A5bzFlbmpjQWw3cm5ZN3JpRk1yY3NE?=
 =?utf-8?B?L1FiblE2M1FyT3Z3VmF6NzBBazBUUUdWVFhPRXJ1aEVSdWowYVVmcXRpeThN?=
 =?utf-8?B?LzRWZjZJNjdKR0pCL1c1bGN3TGlnd2pQVUVobnhDZCtPaWxFNE8yOHVQa3lm?=
 =?utf-8?B?VUFhdE5WK2krNndscWM2aFBHL084QjhZSlMrMFZhQUZZU3o5VE4zb0NRMzV0?=
 =?utf-8?B?TTlLY2haV3R5b1UvakRiZ3pXK2dRd2NwSFFpcDdVaDFPL096U2lFSEtCcDR5?=
 =?utf-8?B?T1Y4QUJIWFhzSWZJcmN4RHM3VXY3c3I2SGYxK3M0eHB1SnVqKzZXVFQ3U1RE?=
 =?utf-8?B?NlByZE9QWFFJYnF6N1gwK2VieFhjblVSTWhEQXU0R0VLN1BqMG9jL1VRbE5C?=
 =?utf-8?B?aGQ5bHVubjJXdXdaQ00vOTdpeUZRZWhsT0NCb2tMdEdSdG81aW5vWFlxT04v?=
 =?utf-8?B?c21UQkk0QnBUaHdHY3h6MGhlL21wQ1A2V3lnQjEvUWNtOVNPRXZIWklTa2xy?=
 =?utf-8?B?NEg4SXpTaDBPWkNocFFMK24yRnhPS3JncVB1S3JhRVJEeEdUYlY2cFJSWHU2?=
 =?utf-8?B?UDJSWkxWNzNvREV2Ujh1dXFDZG9BUE1qMVhuTi8xMENaRnc4YmNOeEQzTnBw?=
 =?utf-8?B?ZTVoenZyUXRMWDFPcXVNOXVncGw2WFl4Sys1ZHVhcE5wQzJOMGoyNG16WWtN?=
 =?utf-8?B?T1J6K0tJWEhFS1Yzck1nazhsUmRRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB6160.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd6afe58-bc4e-4ab8-6375-08d9afab2118
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2021 00:32:57.7726
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zxoS/IKGMuWduAb2kPNZF9v8UgTrh5kOV0n3J50SkkUH3AVHrF3FLoOfUrjFBakdZ0QQnAKoFbGwFPxbKm+SJdQ5tnc6rv7gDSjTMldHCQY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1771
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

VGhhbmtzIGZvciB0aGUgcmV2aWV3Lg0KV2UnZCBsaWtlIHRvIGZpeCBpdCBhbmQgcmVwb3N0IHRo
ZSB2MiBwYXRjaC4NCg0KQmVzdCByZWdhcmRzLA0KU2h1dWljaGlyb3UNCg0KPiAtLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBIYW5qdW4gR3VvIDxndW9oYW5qdW5AaHVhd2VpLmNv
bT4NCj4gU2VudDogV2VkbmVzZGF5LCBOb3ZlbWJlciAyNCwgMjAyMSA0OjExIFBNDQo+IFRvOiBJ
c2hpaSwgU2h1dWljaGlyb3Uv55+z5LqVIOWRqOS4gOmDjiA8aXNoaWkuc2h1dWljaGlyQGZ1aml0
c3UuY29tPjsNCj4gcmFmYWVsQGtlcm5lbC5vcmc7IGxlbmJAa2VybmVsLm9yZzsgbGludXgtYWNw
aUB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6
IGxvcmVuem8ucGllcmFsaXNpQGFybS5jb207IHN1ZGVlcC5ob2xsYUBhcm0uY29tOw0KPiBsaW51
eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSF0g
YWNwaS90YWJsZXM6IEFkZCBBRVNUIGluIEFDUEkgVGFibGUgRGVmaW5pdGlvbg0KPiANCj4gT24g
MjAyMS8xMS8yNCA4OjUyLCBpc2hpaS5zaHV1aWNoaXJAZnVqaXRzdS5jb20gd3JvdGU6DQo+ID4g
SGksIEhhbmp1bi4NCj4gPg0KPiA+IFRoYW5rcyBmb3IgdGhlIGNvbW1lbnQuDQo+ID4gV2UgYXBv
bG9naXplIGZvciB0aGUgZGVsYXkgaW4gcmVwbHlpbmcgZHVlIHRvIG15IHZhY2F0aW9uLg0KPiA+
DQo+ID4gV2UgdW5kZXJzdG9vZCB0aGlzIHRvIGJlIGEgcG9pbnQgaW4gcmVzcG9uc2UgdG8gdGhl
IGRlc2NyaXB0aW9uIG9mIHRoZSBwYXRjaA0KPiBjb21tZW50Lg0KPiA+IFdoYXQgZG8geW91IHRo
aW5rIG9mIHRoZSBmb2xsb3dpbmcgZGVzY3JpcHRpb24/DQo+ID4NCj4gPiBXaGVuIFdlIGFkZGVk
IEFFU1QgdXNpbmcgdGhlIFVwZ3JhZGluZyBBQ1BJIHRhYmxlcyB2aWEgaW5pdHJkDQo+ID4gZnVu
Y3Rpb24sIHRoZSBrZXJuZWwgY291bGQgbm90IHJlY29nbml6ZSB0aGUgQUVTVCwgc28gYWRkZWQg
dGhlIEFFU1QNCj4gPiB0YWJsZSB0byB0aGUgbGlzdCB0byBlbmFibGUgdGhlIHRhYmxlIHVwZ3Jh
ZGUgZnVuY3Rpb24uDQo+IA0KPiBMb29rcyBnb29kIHRvIG1lLg0KPiANCj4gVGhhbmtzDQo+IEhh
bmp1bg0K
