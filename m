Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08B71460C54
	for <lists+linux-acpi@lfdr.de>; Mon, 29 Nov 2021 02:35:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376425AbhK2BjE (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 28 Nov 2021 20:39:04 -0500
Received: from esa20.fujitsucc.c3s2.iphmx.com ([216.71.158.65]:43451 "EHLO
        esa20.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1376750AbhK2BhC (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 28 Nov 2021 20:37:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1638149625; x=1669685625;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+3wp8tdvSsL0nPOu/1X0uOo8Ci3RDFZPstQkOjZ8tAY=;
  b=K9mVhPGCg6gEEADPo5fa8tTvy/BsrLG7ibHNd0/U8ieYg0an7gMEUieM
   PJUnNY8QYQ7LpXsKODMUFadw57M7Ah329IcWbWLAhBcRnlBAonN8+wE7I
   9DLElhGcC6LD9G9xa+fQrv4UCZKkeNL8nPb+f15KTr5P9TblXAQzBJsOF
   iZe6wVpDhTztiPKghpsVfNvgXJVR+6G0qYUucSatKk3HJVfrk9H78EIwt
   50EeCYZT8eKDxoR9SQ+dzhusi5EIWKOvecsT9BdNdsV+Vt7AL5fHCXOxH
   97To7Q4BDQt1q+AWg70zYA+oKkPI1R08BOgGroZwQ1MhymXOJJJMJc+q3
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10182"; a="44696226"
X-IronPort-AV: E=Sophos;i="5.87,272,1631545200"; 
   d="scan'208";a="44696226"
Received: from mail-tycjpn01lp2170.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.170])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2021 10:33:42 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EYv46hyVN/59mEPzsYh1S5CuoKChc73pQQywdDE1CfFlIPdr2w8SuGhW6VZvf8DEte1hcDNyLe3Yp+GmcoPinX4yGgsfjDobjTil+wgawwR+eFVuhNYVuOE7c45iFOAr5VWLVBOUTF7hBI6CaT5zeGNRVCASEadtD+ZHc8UMyoXbiSf4Q5NJzIJBQQqHsABvDEAiRMo6mWL0glAplUdvZDbqHg1VFfWTZmffOeb3ThxSRHjbbw7BxBO8rc5MnwH/lLS27EESXw9niCB869fpLshdN+jbwTXaZ3bXACW+dCOztpFDjpsVoBBeGvmdCJm4s0G7yl9UnlfyH6FLYmcUSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+3wp8tdvSsL0nPOu/1X0uOo8Ci3RDFZPstQkOjZ8tAY=;
 b=QCKXPy1Uo0fS3AfZuGduSg1+EDHIMtnbstaOWZpV//lxqqTiqgfmzUBiucGeRkvjh/oQ7MapockK2NvkQ+SXZqFhPQ6EAeZpU6MMNe05FS9ByLiX4enr/GftqJXWMqej1zyUbHL2AFYo/cBAeo3GgRRwyL0bI/uyp/ZDWEwu8VW1QyFCU/GCyWrLcmFZsB8EWiWzLCrBoR8ah7xcUODXRROEXmi6rM0ST1yc6On2XzNZLXPenuH4xVVU16x0mI7jz6W0YeiEMyACLjeFc5GNffIT0IJyLQeBYiUM5LBSCYJF2QkPE5PDkD6w+RaY+UE0kTVML62o9J93ozXRqQF3Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+3wp8tdvSsL0nPOu/1X0uOo8Ci3RDFZPstQkOjZ8tAY=;
 b=L/Fq3iU91e+aS4w0C8c2qLJH0R2zFnBr0qNolnySN0kvztRhW9aqWnMGSrCrSq/V+aQD7U3CdaXeZjgt1fOu66seBRmFEp4GC9LLQLjUfrmwmrG61IO55OUWfCdLN9pAWa9lJ+AvK8n+BVaYN/0VlNWzMBUzGT7G80lIZUynRMM=
Received: from TYCPR01MB6160.jpnprd01.prod.outlook.com (2603:1096:400:4f::8)
 by TYCPR01MB6336.jpnprd01.prod.outlook.com (2603:1096:400:79::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.20; Mon, 29 Nov
 2021 01:33:39 +0000
Received: from TYCPR01MB6160.jpnprd01.prod.outlook.com
 ([fe80::9097:d9f3:3ce8:c65f]) by TYCPR01MB6160.jpnprd01.prod.outlook.com
 ([fe80::9097:d9f3:3ce8:c65f%2]) with mapi id 15.20.4734.024; Mon, 29 Nov 2021
 01:33:39 +0000
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
Thread-Index: AQHX4dcm2JuG1AW8kUqF41G/yqh75KwWsneAgALvUdCAABPPgIAACB3w
Date:   Mon, 29 Nov 2021 01:33:39 +0000
Message-ID: <TYCPR01MB616027B8F697EC35F7C0C0E3E9669@TYCPR01MB6160.jpnprd01.prod.outlook.com>
References: <20211125083240.123131-1-ishii.shuuichir@fujitsu.com>
 <ae3dc745-13b0-7f9c-4929-527de4b92d97@huawei.com>
 <TYCPR01MB6160526A9B559655FAEE2DEFE9659@TYCPR01MB6160.jpnprd01.prod.outlook.com>
 <25725e77-d6ba-aa33-6a1e-075f57e1b309@huawei.com>
In-Reply-To: <25725e77-d6ba-aa33-6a1e-075f57e1b309@huawei.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?utf-8?B?NTBfQWN0aW9uSWQ9NDI3ZDg0YTktYTM4OC00NTdjLTlmYmUtNTU3ZWEzMGFj?=
 =?utf-8?B?YzlhO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5?=
 =?utf-8?B?LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX01ldGhv?=
 =?utf-8?B?ZD1TdGFuZGFyZDtNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?utf-8?B?LTNiMGY0ZmVjZTA1MF9OYW1lPUZVSklUU1UtUkVTVFJJQ1RFRO+/ou++gA==?=
 =?utf-8?B?776LO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX1NldERhdGU9MjAyMS0xMS0yOVQwMTozMDoyOVo7TVNJUF9MYWJl?=
 =?utf-8?B?bF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfU2l0ZUlk?=
 =?utf-8?Q?=3Da19f121d-81e1-4858-a9d8-736e267fd4c7;?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d650ed03-d20c-4e17-1f2a-08d9b2d84522
x-ms-traffictypediagnostic: TYCPR01MB6336:
x-microsoft-antispam-prvs: <TYCPR01MB6336C3374EC01CB9FFCDC99EE9669@TYCPR01MB6336.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:747;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5zsKsoBPdpFvnQQarym/fid3bu4vv2U/42dVkGEY8DI8tTMYTIGBI1jfegXWnIPjb0sulEH0KMXuyu/GhDiZiqhEg3mvRIzLI4JsMPv/GA+oA7jpdO9uab5b2p5I2VOymXZgNMaYP9Vi0rd/OYJ7qaeEmR41XoHqhYG2X8IdfbbI9sLvjwVuhevFyQ0Dydvvmj1ikE6S/CB47nZJKkBH7kouIlRPWQx22YPe5T/kvx9LmBy2tlZ4pM2+FtoAyIx+N94U6AdCnz9IoKCfTxxC00kVMwvxyawXkXvgcxja18fj8TPigPG/6Uzx2i5euPyB75NWXaTuANFlQ3kXMw+TL7oQQWs4PTf9tSEm2EWkv2DUeHlKF62rl/BweduQERjFiCdpyFk/iLxCA6MbQpFJGlv1cG7BcnWQWTREChaZrabXoARYeb7zqHREnV6E+y4m8OfgTeAvQcSPnXYboUakNbrLspcGiUNbVXhLu4kFwgyHRVfYsr8I3pdtV4CollHhDRVlrEEKRtJZ4QJEtERoC064WMUt+awsaDK02kiLMgT1MyQI4Mg6Y0bwMw4tdt2y4oWiAXmbHlFdjK5R8tkNC9yhSHsUww8nrW2I+dWxzjHEtKjVJSK80P6ShMAHaToogCRhAlt0lcjyCL11gLDdMYaMVbL8IGRZbwOt3ujpXvmEZswmy9Wh9Y+c2FJsXIW+zdcmNkNexRnQHlCUou48Xg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB6160.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(508600001)(7696005)(9686003)(38100700002)(122000001)(83380400001)(52536014)(107886003)(86362001)(6506007)(4326008)(110136005)(2906002)(54906003)(5660300002)(53546011)(316002)(33656002)(82960400001)(55016003)(26005)(64756008)(66476007)(66556008)(66946007)(76116006)(186003)(85182001)(38070700005)(8936002)(8676002)(71200400001)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RTZVYmZnU2ExN1ljMlRnWWlob3Y5OHFtdGtRdytlY0pqVkdpM0R0ckVKdEll?=
 =?utf-8?B?cm5zZ0lsQW9LWmpsS0tkY1FsQUVTakVsWTI5SGFRNjNpSi9RNXpoK1RFTUd0?=
 =?utf-8?B?b2xvQk8ySGRKZ3BwSm1RdXd6dnkyY2dhRnpTY3NVTG5EV3NQOGdWZGljbXVR?=
 =?utf-8?B?OXVNa3ZUcWw0ZnlJRGVNczBIY3d2OEorTS9OWE1acmtFSGxrZzZPSFI4K0Nt?=
 =?utf-8?B?Q0FNNjhoa2EwQXVDQW42SURmcnF1NEo5STRGaSsvYnlFanlBVmJiRVQ1Sm9s?=
 =?utf-8?B?b0dyLzFncVlVWUxaa1lXdmR3bzEzRE1Gc2VWLzZvbDdBMGxtZnhxK3IwWmJ6?=
 =?utf-8?B?NmpMOFZLZGFENlQxQVUrTXRTQWZtcVlJcEpwcjV2ck1qYkpFM25YTnZHUXpD?=
 =?utf-8?B?VnExSVh4M05zOXdHUzBITlhGN29YMzA3VWR1bFd2TTEvYmNsK2l3a0xtS05O?=
 =?utf-8?B?MTdvbE5rcFhPak9iMzJlYTVrSHFTWEVjRHVnaFpiQ2JMdXA4VkVBYlUzNE9C?=
 =?utf-8?B?dEp6NEpWZmhqR2FaeUUvVW9MOG9yVXgySS9kbWxpR2ZlVU5VZUVSR09vZEht?=
 =?utf-8?B?OHRQMXJxT2Q2dXBnZW9oRndHVzZia25ESlZsSUplWmJTOVlIRjF3TkdreFRz?=
 =?utf-8?B?ZzIxYlU4VWJPaDc2UVJ6bU45Y3F0WGpXYWNjMW42RVM5eHhuOUxoOUQweXpE?=
 =?utf-8?B?ZituS3d4WnMrQ040cjJRUW8yaWNWdDFTbW55V2NGdnJCQ3RCek5lckYxaG5M?=
 =?utf-8?B?WEJGMGthaWV0cjhudytuNzBPZ09rTnNWQnJMRWRKdjNCOHQrdDdEVGx5V2la?=
 =?utf-8?B?L25oUjVnMmt3ajVrSEE4YUJjUVQvNnNPT29rU2l2a3k4TFZ6dU5EWHc1RldR?=
 =?utf-8?B?NUhLMkJSa1dEeGcrRFJEK082TmpXVlc3TGxWMitWWW83MFBJM3hodTB2TWI2?=
 =?utf-8?B?TWxWS2gzaC9VL2syT250azN4OFVpOFIwWFhHVUp4dmd5c0NlMWlIUlpoZWRp?=
 =?utf-8?B?ZStUWWwvUWRSb2ZjSmJIRU9mZUpuK3VqbFY0NGt6d2RXcXpFcWJ0cTB5aVln?=
 =?utf-8?B?VHlpMXR4VWkxd3kyb0ZWY1Z0ZG1MdlpKdDNscmZVcnh5STJueUNzbXN6a3Ry?=
 =?utf-8?B?eTU0Ris5TThSL2Z6d2hsSlpiSGFYcHhMZ212dllxTXRjdzJMQU0zdk1scmQy?=
 =?utf-8?B?U1JsQVBlWGdFUVVwSkFXQjNpYjI4R1hvSG5jbVB4djJMTXdDdUh5ekhsc0h0?=
 =?utf-8?B?WG1pdVpxMWRYZE5WU21sejNmanlMb0xkZWpjc1ZmVnYyRnI4UzV3NVhDNnVV?=
 =?utf-8?B?QmdMdVJyU29aZ01DclZZcFpoOUtwU0NHaklCbmVtNzZUK1YrQ3A1eHFLM3o0?=
 =?utf-8?B?OHZRaVc1c3BMcGJSVWd1ako2WmdsM05lNmVIU3Z0YjE4SnFUcGtTYklDQ0F0?=
 =?utf-8?B?RlNKUUlZZ29vQTRYa3lXK2JhYi84Zyt5OFpSNDJ4a0diNEVUS2RrQzFuM0lC?=
 =?utf-8?B?dGp4Q2YxRVo1Y0Uwa1U2dU5lNjFPUWZObHRrTDd3LzRQUE1MRXpod1BDNDFK?=
 =?utf-8?B?dVVvbGZOZUJJTFIrZkVkSEVaVHFOYXBxYnJaczZsdHV0Sytvb3FHNENTcDBL?=
 =?utf-8?B?V2Q1RGxpWTY4Q3FjQ09ZZ3c3S2lqRERUaEwwSUN4ZVVsMXNjaldZMUhZd0Mz?=
 =?utf-8?B?VUtPdUJwMWJPb2Q4by9EWW9JV1l6L0hiakE3Q2hVbzE4Ky94L1FKT0VQOHhs?=
 =?utf-8?B?QTZ3d3QrR1o5OS8vcXRWNFhvV1JTTFBSQzU5YUl0c0UvM04ramxtUnJOK0Fj?=
 =?utf-8?B?NzZIamRwdHg4NzZjOFhLUTZOOHhERkxORzF4UEF2SUpUd1FtOEkwT1gyMk9R?=
 =?utf-8?B?Mmo2T0lFcEtaWGt4eGF6TmVpWFY4ckkySTBqekhGZjhJa2gvOHFoaXNMQndh?=
 =?utf-8?B?RHVRdjBTN3U5d0NvV2xCTytPNE9HeDBQS2lTSC9rQmR3SFBYQkZFZ0NCelhl?=
 =?utf-8?B?QVE0NERyT0haTHZSQ0hKUWpQcDljOTBId0FFVk5BSTRtNm13bEk0TDNxN0xm?=
 =?utf-8?B?enJCMExTcndnMWR0clluRzNnS0NQTWVSSUR5dUY3U2FweENwbC9sTHRLcnhZ?=
 =?utf-8?B?SkgzSS9KWEJuc01BRlo4MENEbWJXZ1NYUytwTkFYQ1Y1dGx4ekJreUsvbDV0?=
 =?utf-8?B?SUtmL0pGUjFNaGllYTA0ckpuQkRHUVBvb0dUTjFIWldXaHNTOFptNUJuWmtO?=
 =?utf-8?B?SXhtMGJJOWFYbDBDVUJYR3V1eTVRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB6160.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d650ed03-d20c-4e17-1f2a-08d9b2d84522
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2021 01:33:39.1064
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Mv09kU9NLAtRxRjpN3gMk3IGkNR6JTVfIY/HgyohusS+DAaTaTbqchCmSUR8/A7JJrbjf+Nm4yo23CNj0W15c+No75uUZ8MeD8LmCOt1REo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB6336
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

VGhhbmtzIGZvciB0aGUgcmV2aWV3Lg0KV2Ugd2lsbCByZXBvc3QgdGhlIHBhdGNoIHRvIHJlZmxl
Y3QgdGhlIGNvbnRlbnRzLg0KDQpCZXN0IHJlZ2FyZHMsDQpTaHV1aWNoaXJvdS4NCg0KPiAtLS0t
LU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBIYW5qdW4gR3VvIDxndW9oYW5qdW5AaHVh
d2VpLmNvbT4NCj4gU2VudDogTW9uZGF5LCBOb3ZlbWJlciAyOSwgMjAyMSAxMDowMSBBTQ0KPiBU
bzogSXNoaWksIFNodXVpY2hpcm91L+efs+S6lSDlkajkuIDpg44gPGlzaGlpLnNodXVpY2hpckBm
dWppdHN1LmNvbT47DQo+IHJhZmFlbEBrZXJuZWwub3JnOyBsZW5iQGtlcm5lbC5vcmc7IGxpbnV4
LWFjcGlAdmdlci5rZXJuZWwub3JnOw0KPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBs
b3JlbnpvLnBpZXJhbGlzaUBhcm0uY29tOw0KPiBzdWRlZXAuaG9sbGFAYXJtLmNvbQ0KPiBDYzog
bGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFU
Q0ggdjJdIGFjcGkvdGFibGVzOiBBZGQgQUVTVCBpbiBBQ1BJIFRhYmxlIERlZmluaXRpb24NCj4g
DQo+IE9uIDIwMjEvMTEvMjkgNzo1NCwgaXNoaWkuc2h1dWljaGlyQGZ1aml0c3UuY29tIHdyb3Rl
Og0KPiA+IEhpLCBIYW5qdW4uDQo+ID4NCj4gPiBUaGFuayB5b3UgZm9yIHlvdXIgY29tbWVudC4N
Cj4gPiBXZSBhcG9sb2dpemUgZm9yIHRoZSBiYXNpYyBtaXN0YWtlLg0KPiA+DQo+ID4gV2Ugd2ls
bCB0cnkgdG8gZml4IGl0IGFzIGZvbGxvd3MsIGlzIGl0IE9LPw0KPiA+DQo+ID4gLS0tDQo+ID4g
U3ViamVjdDogW1BBVENIIHYzXSBhY3BpL3RhYmxlczogQWRkIEFFU1QgaW4gQUNQSSBUYWJsZSBE
ZWZpbml0aW9uDQo+ID4NCj4gPiBXaGVuIFdlIGFkZGVkIEFFU1QgdXNpbmcgdGhlIFVwZ3JhZGlu
ZyBBQ1BJIHRhYmxlcyB2aWEgaW5pdHJkDQo+ID4gZnVuY3Rpb24sIHRoZSBrZXJuZWwgY291bGQg
bm90IHJlY29nbml6ZSB0aGUgQUVTVCwgc28gYWRkZWQgdGhlIEFFU1QNCj4gPiB0YWJsZSB0byB0
aGUgbGlzdCB0byBlbmFibGUgdGhlIHRhYmxlIHVwZ3JhZGUgZnVuY3Rpb24uDQo+ID4NCj4gPiBT
aWduZWQtb2ZmLWJ5OiBTaHV1aWNoaXJvdSBJc2hpaSA8aXNoaWkuc2h1dWljaGlyQGZ1aml0c3Uu
Y29tPg0KPiA+IC0tLQ0KPiA+IHYzIDogQ2hhbmdlZCB0aGUgbG9jYXRpb24gb2YgdGhlIGNoYW5n
ZSBsb2cgc28gdGhhdCBpdCBkb2VzIG5vdA0KPiA+ICAgICAgIGRpc2FwcGVhciB3aGVuIHRoZSBw
YXRjaCBpcyBhcHBsaWVkLg0KPiA+DQo+ID4gdjIgOiBUaGUgcmVhc29uIGZvciBjb21taXR0aW5n
IGluIHRoZSBjb21taXQgbG9nIHdhcyBub3QgY2xlYXIsDQo+ID4gICAgICAgc28gaXQgd2FzIHBv
aW50ZWQgb3V0IGFuZCBjb3JyZWN0ZWQuDQo+IA0KPiBMb29rcyBnb29kIHRvIG1lLg0KPiANCj4g
VGhhbmtzDQo+IEhhbmp1bg0K
