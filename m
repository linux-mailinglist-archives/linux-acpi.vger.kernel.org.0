Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E104E456B22
	for <lists+linux-acpi@lfdr.de>; Fri, 19 Nov 2021 08:50:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232404AbhKSHxC (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 19 Nov 2021 02:53:02 -0500
Received: from esa5.fujitsucc.c3s2.iphmx.com ([68.232.159.76]:14627 "EHLO
        esa5.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232397AbhKSHxC (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 19 Nov 2021 02:53:02 -0500
X-Greylist: delayed 428 seconds by postgrey-1.27 at vger.kernel.org; Fri, 19 Nov 2021 02:53:01 EST
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1637308202; x=1668844202;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DED2Gpt5jA3cTBvgBdR1TfvvrEEyfd/VbnAmqvPgczg=;
  b=XFYfzAYe7USvc5jzyuuVEGVNKFJpjxlXDxVz1KFsf3AD+WZ1/ebPt4yb
   LqQzodEfpt9chH9glIxWCjwpY+ByNoLeVz2Fbrlz0vH6lQWqYyUKibjg0
   sUMGM4TdRpEJeEpwY+Qb5lKLNkJ2iXJ2QB4cs8QElCFbIjHQxy9Hp5y4/
   m4edEjXUWjzWO/9qd1B/037q3jj6AkY9zZF4LFuGY3ExoRPDBNm16QpSI
   Scp6Hx7PuIA1JgPeRmrNj3dGwxCAojIjX9WgvbGubwfA4YcdzYZVRNxzt
   Q0H9TDZuYp2eydk0zcpC6COBqd1yFl8EOKGDTlD34/jbsudekKvc+FTMn
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10172"; a="44185932"
X-IronPort-AV: E=Sophos;i="5.87,246,1631545200"; 
   d="scan'208";a="44185932"
Received: from mail-os0jpn01lp2106.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.106])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2021 16:42:50 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=me+GFjvnurNYA95GWGqOK49cD+p2fqePF1R+oJe/63gTlP5xYqxjXdvSe8ZJWlv6AP4O559ceiM7qSST2/B7IhMGB0EE+WrtN4R9Rv+oNc2kyKNB3lUFkw4tV5a3u5h63IZJXw2nav8B+wznnBJKXanMrnndkmSczs0Vr2YP31Oli0PZmtKkl5gNKifQGi4r/yfdf/jlJe3H+jNryLF5w5bUA0ca97FqCNzewDvJEtAQS1WUNgVChqr2qbIr6Xx4BTY1tIP2cfFyJEjQ923cIIanXo3phxGNXLA5mBfuOn+m61z5ojjPt6FeNYO/rRdq6j5k97QyxGrg6kxUKLr01g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6GZcd12wFOaCHs0PsvNP03Qya7qUTiT6xxkT9rtD4PQ=;
 b=cxBUQaCmIFdcaI03gH3jKatBCR2Et4lzjtwD6dWcNGQgdTdnusO7G6GnEhvSnWqM94l26UOFn+8PetWUX8myr9iK7VtO9CpPNAMV6gYCP+M6ejy5M4oc1CoT4/qYS+f8RBys5cjmLuIJ4/ficbOzS1kdFKX17BCXo7ZPlkZ+/UFQ2+QFixh8QRNHhkflDlEttwDUUbAVduqmY7gQA+TZDC75eUFei1vFwgk4GKOvrKi/m4bL5W1AMKQKboqQeuMn1VrILxzdYKyjG4s3Vlh5/j257+HQOMiZVqWVgBihpezOHkW4IxAd/xlHMQtnHkajC4iDg5KDzCtp3TmPE8MCeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6GZcd12wFOaCHs0PsvNP03Qya7qUTiT6xxkT9rtD4PQ=;
 b=HI+g5cr23nHviIkAjBI3RnhFgZc6C5LpJI1dj53Wef0rket/zuaxKn9C/Ywc0YfW8jYFpGpNP3/AHhe1Zef6qm7OX6+yWAqGwhA9oVqySmWYjIW4BXyZ4jeNpsuEKDPaoC9cKjLvNdv3TDYQR7rEjyq1jUomSQUxzHQ19ctVxhI=
Received: from TYCPR01MB6160.jpnprd01.prod.outlook.com (2603:1096:400:4f::8)
 by TYAPR01MB2606.jpnprd01.prod.outlook.com (2603:1096:404:8d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.26; Fri, 19 Nov
 2021 07:42:46 +0000
Received: from TYCPR01MB6160.jpnprd01.prod.outlook.com
 ([fe80::9097:d9f3:3ce8:c65f]) by TYCPR01MB6160.jpnprd01.prod.outlook.com
 ([fe80::9097:d9f3:3ce8:c65f%2]) with mapi id 15.20.4713.022; Fri, 19 Nov 2021
 07:42:46 +0000
From:   "ishii.shuuichir@fujitsu.com" <ishii.shuuichir@fujitsu.com>
To:     "rafael@kernel.org" <rafael@kernel.org>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "guohanjun@huawei.com" <guohanjun@huawei.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "ishii.shuuichir@fujitsu.com" <ishii.shuuichir@fujitsu.com>
Subject: RE: [PATCH] acpi/tables: Add AEST in ACPI Table Definition
Thread-Topic: [PATCH] acpi/tables: Add AEST in ACPI Table Definition
Thread-Index: AQHX0fwdbkefXsM8TESWclCf3iAcSKwKje3w
Date:   Fri, 19 Nov 2021 07:42:46 +0000
Message-ID: <TYCPR01MB6160D24642F184E35B6A062DE99C9@TYCPR01MB6160.jpnprd01.prod.outlook.com>
References: <20211105041635.1481738-1-ishii.shuuichir@fujitsu.com>
In-Reply-To: <20211105041635.1481738-1-ishii.shuuichir@fujitsu.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?iso-2022-jp?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZl?=
 =?iso-2022-jp?B?Y2UwNTBfQWN0aW9uSWQ9OTE5MDcwYjQtNmM3Yy00YzJkLWFlNzEtMmYy?=
 =?iso-2022-jp?B?NDQ0MmNjZjcyO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFi?=
 =?iso-2022-jp?B?NGQtM2IwZjRmZWNlMDUwX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF9h?=
 =?iso-2022-jp?B?NzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfRW5hYmxl?=
 =?iso-2022-jp?B?ZD10cnVlO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQt?=
 =?iso-2022-jp?B?M2IwZjRmZWNlMDUwX01ldGhvZD1TdGFuZGFyZDtNU0lQX0xhYmVsX2E3?=
 =?iso-2022-jp?B?Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0ZmVjZTA1MF9OYW1lPUZV?=
 =?iso-2022-jp?B?SklUU1UtUkVTVFJJQ1RFRBskQiJMJT8lUhsoQjtNU0lQX0xhYmVsX2E3?=
 =?iso-2022-jp?B?Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0ZmVjZTA1MF9TZXREYXRl?=
 =?iso-2022-jp?B?PTIwMjEtMTEtMTlUMDc6NDI6MDVaO01TSVBfTGFiZWxfYTcyOTVjYzEt?=
 =?iso-2022-jp?B?ZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX1NpdGVJZD1hMTlmMTIx?=
 =?iso-2022-jp?B?ZC04MWUxLTQ4NTgtYTlkOC03MzZlMjY3ZmQ0Yzc7?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3577fa11-5a8a-48be-b546-08d9ab302db5
x-ms-traffictypediagnostic: TYAPR01MB2606:
x-microsoft-antispam-prvs: <TYAPR01MB2606D8ED7C9503817201B37AE99C9@TYAPR01MB2606.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VdPfBWWLhTwVsKUQYei+QObHGS05sSIex19Da+XXNGopC0M5YiWGu036hX6K5NIIm3loNmiIgX+VvTibilhi9GojDEAKgUXvwyFiHWOzZp1agkbN3elqdjOa5Sbl+qAD2ZdxTwc8qbhWEKf8ZsnAx5N6UkqToMN/UsljCfDi4j9Vxfrxuvd4qieaKz69zCaR5FpUiT5fgeLg7NEveuupTv6ZyG5CzGMO8VOVQHlAW2TTZ3c268oBmKo/Oe66CMT6s0tSMpIXENxyt4PicUZYz46ucHknOR30rn7SIsFLxY05NdhMv0ZDm4SyN5RKbkTcCE362xeMoUVAShywyg8xuLV9MjfPyGrDvJr98FzAihN86PEQQWSBbGlfuDv654eQleXloKzRUp5fW9jcp8E6xLUsFzEyrFskJXqCOUgkLQta+2H7fW7KGM/Tywo4ifXy/qSfF9kusgf5xgxjdJcI/P3AV1fWThJxFEfho6znXacHiyYEzs3qyPR3XMwsFl6ee7fo3QCBJW0fd4CG3/9Jt645KNXXC/fOYMiO+jaq1FzSsDurxI13jFnEvk8TRBSG9ap5gBeyJRM65kwpaKcnLATcCWd3cukP8yJz0ddOtgeCA61MVvqhl1yV2eXlsrKQXTCkwcp5hpcRuovNTp54pAIxKtwFNUNwtGj5gYBoiELEM1Bz3u+bwH4imZoxPIB93uUtSdrbrErWryFaLDWLXw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB6160.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(85182001)(122000001)(26005)(38070700005)(7696005)(9686003)(508600001)(4326008)(71200400001)(52536014)(8676002)(86362001)(83380400001)(2906002)(82960400001)(5660300002)(33656002)(66446008)(8936002)(66476007)(316002)(66556008)(64756008)(107886003)(110136005)(54906003)(53546011)(76116006)(6506007)(55016002)(186003)(66946007)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?YTVKSUIvNGN3TmptNUxEMVpNZXUrb0M0dEJCWEVuNDhsSTgwU3liT3lv?=
 =?iso-2022-jp?B?bnR3cjZWbXEvU0x6dUtReXdteUZhOEE5Q2dIWlQvZnY2c3R2SXJrRWdJ?=
 =?iso-2022-jp?B?TE5CanFSYXllYzhBd0lEelVVOE9iZm9qR2Y1bUJVcVhaT0x1SEFEVUV6?=
 =?iso-2022-jp?B?bjRkT20xVGFHUlA2S0d3U0FML0tINHVseDRRYVpUS0h6bkEyWGZUK3FB?=
 =?iso-2022-jp?B?YUxRNnlLb1RyMmpaKzBuVENVQmY4YmszV2xjb05PVDlJTlN5RjhUbDA2?=
 =?iso-2022-jp?B?eG9FVjg4bDRzakhpNmR1eDZHcFEvOVg0dlFXZnVLR05EelFLY2hTUHlJ?=
 =?iso-2022-jp?B?NHdSc0VDZEs4cDdSODkzbFRuUnBCNnpKOGRaeDY5djFLV1pQeDczWWU2?=
 =?iso-2022-jp?B?RkIxZHp2T3FFWkUxN0lBRkJGVmM2TXF3em13UUJmenZqSllqQVlGZnQz?=
 =?iso-2022-jp?B?anlZZkpqSlRJQjZtWERBY2dWT2pRNEZWTVZaeUUwR2c5bDhXYkVMSyty?=
 =?iso-2022-jp?B?R2NjYXhqaXdxWE1acHBGUGhubVFlZ0RTWFRRbi9KYVNUYTR1ZG1DY0xB?=
 =?iso-2022-jp?B?VUJzU1gzVWdFV2F1SnNTV2lvY2hQd2pYbEhZdjFkWHIrYnpiekR5NHJG?=
 =?iso-2022-jp?B?Vkxvdkg0K09KSkd1R2hTRnpEeUo3VDV4V01MSlJ0ZU1URzVtOHQ1MlJU?=
 =?iso-2022-jp?B?RGVOQUlQcmhUdFlWK1cwZzN2THppbUdzUndDb2c0dmlRUWsyOG50L0la?=
 =?iso-2022-jp?B?UXViT3Jsc0JQalBrcGkwaGVGdXBJeWE5QVJ0SnFpckkvek83ak92N01l?=
 =?iso-2022-jp?B?RzdmZTB3SWdCcVhxa0RhbG9oYjJKMFNoQklkZGIrM08yWTl2d0RKTVFp?=
 =?iso-2022-jp?B?L0NjSVNsdnJabG1Sc1RXa2NZRmpGRnNFUzIzMzZVNFUvVnJiTHpibjFM?=
 =?iso-2022-jp?B?SUIwZ1o2V1ZyUmszVFRzdHY0YnFBUXJXNTVxQlZvKytMaG5ieCtrL1M5?=
 =?iso-2022-jp?B?YUc2UWFpMzJqbXc2cmlXeG5JUDBCV01pK0lUVExMUDRqUUswLzVZK21m?=
 =?iso-2022-jp?B?T3RHVFA2eEJQUVlkOWk2SHM3ZHVJYUt1NDF4ZXhjQ2FERTlSWCt6enN2?=
 =?iso-2022-jp?B?bmRTSFZ0TWdPTm5OWlFaeGUrczJ1UmVQbTU3TFBRWEJNUlVwQWI3S29y?=
 =?iso-2022-jp?B?c09qTG5oV3JZSGVvZ2E0clFTeE1yOERvNm41N1RyVDJrWnNQYnJIY0Rs?=
 =?iso-2022-jp?B?dktXL0xPK0VKcnp6dGpxWmhjN3lpVG1raVNDdWlUelJ1dUV0TW1HaDJO?=
 =?iso-2022-jp?B?UXEraE9IK0l4NEloeWRsUEFmY205K1ZVTDViRlpwMWVUUzdqdHdnenNa?=
 =?iso-2022-jp?B?MklPSVJ4ZnhPOEplbzUrZlJleFVOQTJLdzB4SzZEQlhOZDhYOUpaZ0hV?=
 =?iso-2022-jp?B?blVGMzFOd0doUGJnMlViYU4zOG13dTlvOGRRK0hXdnFFQWxtVGV0R09v?=
 =?iso-2022-jp?B?WVhVNEpyTnJ3ZjJDWGE3dHZjN0ZBYVJ3OHVoYzJhVm1DSkphaXgvam5V?=
 =?iso-2022-jp?B?eFBwUS93V0drYlF4NXZoTFBTT1h2S2pkbzJJaWdFNWVKbE9RUGhldEtx?=
 =?iso-2022-jp?B?ZFdiUTZnL0x0Wk1jdXNpVkV1a1dEVS9jRy9LWjlQSkFxY1ZuL29uY3F6?=
 =?iso-2022-jp?B?TDBhS256UFBxQ09GQzhuc203WU0yemo3QVFEMVF6YWN4Qk5xZG1xYXJn?=
 =?iso-2022-jp?B?UnNsYmhrUWlEbXF3VWdLNzB1SEl4bmxpejAwQ3l1aE5DREE3LzFPOFRk?=
 =?iso-2022-jp?B?SFZleGk4SnRlNWRvRmx5MUVPbFVDOWpkUUdxRTB2L09OVFEyRnhITWky?=
 =?iso-2022-jp?B?MWUzV1pNbk5uby8zbzVka1hDZDZFMHFjNlJkbmlEcG5udnVCMWNQNDVi?=
 =?iso-2022-jp?B?bGlqK1k5aXJCVGhYeE1jWWdweXFIUExOTTRoMWttYTZUMEppMTBzYzFC?=
 =?iso-2022-jp?B?bFFSS1lRVVZES0xnZk1YWk9JY09SSnhhMk4yWDRvYnVaN1lkcHB1dWZq?=
 =?iso-2022-jp?B?N0FyVjRranN6eDk1OG11NmJFckVJT0RkcFNUb3dmQWRRQmhpSTNQdWZW?=
 =?iso-2022-jp?B?RmdUSWFNYjZJUVhzSWhoVjUxbjVyYUcyOUZiRXZNNzNJTXpmeGxsRCs4?=
 =?iso-2022-jp?B?bk1UeHhrTFlScXFiUUtQNWZ3UjIvUTR6VzltR29sWHZQVW1JQVgrRW1R?=
 =?iso-2022-jp?B?RjFMY2ZXcHg1aUx2SUhWVzBiaDNCeHNvR0VwdTlNOUF3MStJSmttYlpq?=
 =?iso-2022-jp?B?SHB4NHNFd3FXRUo5Sldqak9iS3JONWRCMC9rWDZpWEkrT2JHc3VxKzFY?=
 =?iso-2022-jp?B?S2tVWXhld2dZTGdzajE0eDZmTUJqWllVbWgxN1NXZGRHUTJKSmxjTVBH?=
 =?iso-2022-jp?B?Y0dlRkpnPT0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB6160.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3577fa11-5a8a-48be-b546-08d9ab302db5
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2021 07:42:46.2283
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3FsX4yH1zqUn9AolHF79Z7w68t5NYthPM+stOyCjbGN0LCMrfaS1JxBt99uYXhm0OmH+Evr9goQVht5E9g3MVnEF8KXeJ8s+wXfz4qtsY/g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB2606
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Ping?

> -----Original Message-----
> From: Shuuichirou Ishii <ishii.shuuichir@fujitsu.com>
> Sent: Friday, November 5, 2021 1:17 PM
> To: rafael@kernel.org; lenb@kernel.org; linux-acpi@vger.kernel.org;
> linux-kernel@vger.kernel.org
> Cc: lorenzo.pieralisi@arm.com; guohanjun@huawei.com; sudeep.holla@arm.com=
;
> linux-arm-kernel@lists.infradead.org; Ishii, Shuuichirou/=1B$B@P0f=1B(B =
=1B$B<~0lO:=1B(B
> <ishii.shuuichir@fujitsu.com>
> Subject: [PATCH] acpi/tables: Add AEST in ACPI Table Definition
>=20
> When We added AEST using the Upgrading ACPI tables via initrd function,
> the kernel could not recognize the AEST, so We added AEST the ACPI table
> definition.
>=20
> Signed-off-by: Shuuichirou Ishii <ishii.shuuichir@fujitsu.com>
> ---
>  drivers/acpi/tables.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
> index 71419eb16e09..2699bf7e21ab 100644
> --- a/drivers/acpi/tables.c
> +++ b/drivers/acpi/tables.c
> @@ -500,7 +500,7 @@ static const char table_sigs[][ACPI_NAMESEG_SIZE]
> __initconst =3D {
>  	ACPI_SIG_WDDT, ACPI_SIG_WDRT, ACPI_SIG_DSDT, ACPI_SIG_FADT,
>  	ACPI_SIG_PSDT, ACPI_SIG_RSDT, ACPI_SIG_XSDT, ACPI_SIG_SSDT,
>  	ACPI_SIG_IORT, ACPI_SIG_NFIT, ACPI_SIG_HMAT, ACPI_SIG_PPTT,
> -	ACPI_SIG_NHLT };
> +	ACPI_SIG_NHLT, ACPI_SIG_AEST };
>=20
>  #define ACPI_HEADER_SIZE sizeof(struct acpi_table_header)
>=20
> --
> 2.27.0

