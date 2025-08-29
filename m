Return-Path: <linux-acpi+bounces-16177-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52FE8B3B89F
	for <lists+linux-acpi@lfdr.de>; Fri, 29 Aug 2025 12:22:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E74033B3A28
	for <lists+linux-acpi@lfdr.de>; Fri, 29 Aug 2025 10:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABC0F29A322;
	Fri, 29 Aug 2025 10:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="SJSUY5li"
X-Original-To: linux-acpi@vger.kernel.org
Received: from esa1.fujitsucc.c3s2.iphmx.com (esa1.fujitsucc.c3s2.iphmx.com [68.232.152.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A3B288C3D;
	Fri, 29 Aug 2025 10:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.152.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756462922; cv=fail; b=SaMiNm6WvCBXKB5Jsmxd0FxSP4wpD5CUnPojAwh+/PZwtGVV5PAfFT/kw45Qr0pcdSOIFKU6CbhY2D/h+ilYbv4vtXed/AjRFvtbbnmFRs8S3GY284Xp9Wel4Uf99Gr7ADb0qStsjSPfwK6WiP1sSDtk7+IFHXWCL/6AWbrVEAs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756462922; c=relaxed/simple;
	bh=WEwn+jPHwYDeKuI4aXX/AB/oa83v7fRaXoZS4Gi5Jf8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=k6JfvHyQHqitEA+uMM+Bq32kbDHpvWID2Qtq1e/nbJK6v0wIpYbbsP0xcGm7z8ptZAa1AguA6QRe+SV3xkjxhwW5KhH1YA539U33XUW43agFEa8B8WniUriSaHs1u+LerQ7m4wZbpjCtxpsn0bYwLWE/HnNbWPzvKh2p7A5aCMM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=SJSUY5li; arc=fail smtp.client-ip=68.232.152.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1756462920; x=1787998920;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WEwn+jPHwYDeKuI4aXX/AB/oa83v7fRaXoZS4Gi5Jf8=;
  b=SJSUY5li9inUN06aEX33Q95a8Dv9zSfyjiNxa9dRQX6/lB2lYOosPDbS
   82YDKSNCsNag1RsoaqjPvzC5h1/+nu7AhTUgwmBj2ZlViCXh5Diaf1BlN
   ZZzElugUzf7OEwVwdLWKDxvmKmMX/beHfRDSBo0JToVNCM7SHkMuaqd7c
   NV0/BNOwG2KiyRGRHJAVHP8yjaPdPgSQRpzF565jG20Jc056G0Kp/M7fd
   iOkplZl4/3EhMPtyISWUmJr6S5jVYjHATXLIb5fhJNNLg81FLWG5pP+rc
   xkFM4SXqjiBwpX96y/3L0Id6VNyGGCIZKzFpOA59KxB4cQTp5e/NzMRj9
   g==;
X-CSE-ConnectionGUID: m6XD61LkSk6rgWFGL2nNvg==
X-CSE-MsgGUID: meE5gO84Qh+M5mwEx4/6gw==
X-IronPort-AV: E=McAfee;i="6800,10657,11536"; a="77106325"
X-IronPort-AV: E=Sophos;i="6.18,221,1751209200"; 
   d="scan'208";a="77106325"
Received: from mail-japanwestazon11010047.outbound.protection.outlook.com (HELO OS0P286CU011.outbound.protection.outlook.com) ([52.101.228.47])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 19:21:49 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bPdW3LyROAF8hVSWBj3UDdGF6m1Pr80HaSF79TwS9Y6gfSOh5O+edp4qHlfqf9kPW2W7QuNfjOOl1/RiYYVSLPxQRrGPxyKyVd2J8QItgTy7IvWB4u8Pjl237GR42GgtZhZdtcisyagQuIpZ3CQ28lrQL309PEM6y4AObFJPKYyqgFRbM/JWqSRtMSCKbBxPdVCFOzUOq+gOKBwy7hAyJEgEfzLAWomKmhA3YjkNJK1etGx5K0DIaKOZT9Ik5AsxHLNIRZHr4rSHa8LPVdmaJhat4aTtNNj2GkPt/x4b6dhcMs6jFJrfCIE7s0Q6ARM3OD/cJNdyXWJrkcDYbsMmzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3+tiR6VTTYd7RmOLUn11FN8fn3iSLNp5MN0XdJUF5O0=;
 b=ccaV/gymxEzqYDFC1K14Enk9DGW/2XVy7iCZ0IETqtIKCGKpuFpQQ2UTBrnRSqYTIxuZMBFglFeOQeMbhYUHqSh/dQ4WKal686ICMTz+iLsPj56viKa5cyTic+X2dPqLK7Z7HpDQ6NW2OVPXePw5chnzAesyz0UXHl1xwc5IUA0fMlStxVwKWaw5Z4rTCpnoehi+hV0gtx0wUvAryMnWh0/ENbjAjL7BJu04J4IBY6XWGViMrK2Lqhgvzfh6+eiaXgfoyFLTVOgoSbKdXC8OnLB9yunsc8+bcBmbdebtz9PbhUUGgJQ2qFydu1aQw4BxxilQsAL1qeFsIo2d/a8Spw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY3PR01MB9983.jpnprd01.prod.outlook.com (2603:1096:400:1dc::6)
 by TY7PR01MB14592.jpnprd01.prod.outlook.com (2603:1096:405:23f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.17; Fri, 29 Aug
 2025 10:21:45 +0000
Received: from TY3PR01MB9983.jpnprd01.prod.outlook.com
 ([fe80::f8a:4f35:cc76:bdc1]) by TY3PR01MB9983.jpnprd01.prod.outlook.com
 ([fe80::f8a:4f35:cc76:bdc1%6]) with mapi id 15.20.9073.010; Fri, 29 Aug 2025
 10:21:45 +0000
From: "Kazuhiro Abe (Fujitsu)" <fj1078ii@fujitsu.com>
To: 'Ilkka Koskinen' <ilkka@os.amperecomputing.com>
CC: 'Lorenzo Pieralisi' <lpieralisi@kernel.org>, 'Hanjun Guo'
	<guohanjun@huawei.com>, 'Sudeep Holla' <sudeep.holla@arm.com>, "'Rafael J.
 Wysocki'" <rafael@kernel.org>, 'Len Brown' <lenb@kernel.org>,
	"'linux-acpi@vger.kernel.org'" <linux-acpi@vger.kernel.org>,
	"'linux-arm-kernel@lists.infradead.org'"
	<linux-arm-kernel@lists.infradead.org>, "'linux-kernel@vger.kernel.org'"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] ACPI: AGDI: Add interrupt signaling mode support
Thread-Topic: [PATCH] ACPI: AGDI: Add interrupt signaling mode support
Thread-Index: AQHcEA0DtJrppafZxEO8iry1iSQK/rRsfZgAgAaRt8CABmzWoA==
Date: Fri, 29 Aug 2025 10:21:45 +0000
Message-ID:
 <TY3PR01MB99838D9B5B7A2E51058378EBD53AA@TY3PR01MB9983.jpnprd01.prod.outlook.com>
References: <20250818065437.85905-1-fj1078ii@aa.jp.fujitsu.com>
 <a6d5d830-b1f2-c14b-7753-82f35baec8b4@os.amperecomputing.com>
 <TY3PR01MB99836E78DE9E1C685A94D504D53EA@TY3PR01MB9983.jpnprd01.prod.outlook.com>
In-Reply-To:
 <TY3PR01MB99836E78DE9E1C685A94D504D53EA@TY3PR01MB9983.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ActionId=2750fbb2-2fc7-4b75-b048-776b60751dbe;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ContentBits=0;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Enabled=true;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Method=Privileged;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Name=FUJITSU-PUBLIC?;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SetDate=2025-08-25T08:13:56Z;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB9983:EE_|TY7PR01MB14592:EE_
x-ms-office365-filtering-correlation-id: 2e5f214a-bbf1-4a3a-60dc-08dde6e5db3c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|38070700018|1580799027;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?dithTkdjZGNVKzV1MEtkUUNmbklOTzdhMmVrS2g1NFcrMlhJclpHNHdi?=
 =?iso-2022-jp?B?Rm80MUlNNzFYcE1YZGdYbzRWQVFHa1dZTy8rbkdJRjJiN1AxT1JuazhW?=
 =?iso-2022-jp?B?cFhxUHNqYThEcS9xbGJ1Nkl0L0xQZFBDV3dLQ3liSkJ3UXVnY01qYklY?=
 =?iso-2022-jp?B?cmhjaDRmSlIrN1VZV21qaEdNQ1JxbHh4aXpTdVRrMzVvZTVJQWIwY1Nr?=
 =?iso-2022-jp?B?ZGpaL2E4N01ZTHZMYkFKOUk2eUFFVzkzT05ueDJMVDdMWWVlQXhKRnp4?=
 =?iso-2022-jp?B?WnhIdzc2bXU3a004eURUZ3NJdUlsdUIvS1V2QTdVbEtpN213Ky9Zbi84?=
 =?iso-2022-jp?B?Tks3dmZ6RGFQYWs2Ykh6OFNKaGUwZ3lybHZaL0VZTjJ0aDhoeG1wbzlE?=
 =?iso-2022-jp?B?Q09nNmppdGdGTVllTGNJMy9RRmxjM2J6NjRyNUgxTWsrQm1MNytDeTlR?=
 =?iso-2022-jp?B?ZVV3ZjVYc2hBbnVtRkcxYlFRd1VNUnc0R3c2d21yTys2cFJOTTdXZWYw?=
 =?iso-2022-jp?B?Q29NZ0V6alRyU2MzeW0vdzRFK1VvdDFVRkVrSVh4bm81QWlyT1AzSVc0?=
 =?iso-2022-jp?B?bUNMV3YzMXJFYldYaGZCN0Zya2VCUmo1S25yanIyM2pZdFdSREhIZzBQ?=
 =?iso-2022-jp?B?WnBoM3FoSGNGbFAxNUlITE9MUFRzSXY4QXdza0RGY0c2M0dOTkZiZzRa?=
 =?iso-2022-jp?B?N3Y2TTVacWdFTnlzazBvcVpBK2Zvb3pPVmlzNlBIbXR6TkhmVVRxUGVU?=
 =?iso-2022-jp?B?YUJiVGxGVlFpc0pzVnpXMUFQc1ZpYjhwOUFBY29XWEJ5RkJMeWdraWV1?=
 =?iso-2022-jp?B?WFNnZmszdkk1ZExoT0ZmL1AzT0wraWlLOU5OditvTFlzSm1QV1JYQ3ly?=
 =?iso-2022-jp?B?M2Z5dGg1Yk5JSzJwOXFnV010Y3dSb3pFWllkSkhCTFdpbVZ6cVAwZ05J?=
 =?iso-2022-jp?B?QXVXL3pVd2FaQXpmQkRuTzFpYnpGZG41cHk3bnlVWjI4djNBelA1V2s2?=
 =?iso-2022-jp?B?bUFUcVAwWmpCNUNrdkc5UzhyNzdyN2VjZVJqbTRUcFFRb3oyVkFvNmRj?=
 =?iso-2022-jp?B?ZlUwL3owTWszaFhaZjBRK0VRRktSTW4veitFdm05a3IrZjcxTjQ5UUNh?=
 =?iso-2022-jp?B?K0p0aTFkMFJsbkNSRFBvaUR3aU5MeWowazB5Ti9aekZkUEVMV2lhZDRZ?=
 =?iso-2022-jp?B?Uk4zUm9aaWRQTjdYZFhvYU9RTVVrMjNqQlV5WTVrMElvSFVvTWRyS0Zw?=
 =?iso-2022-jp?B?NDBOaUNQTExES1JxWDRKL082OFhjYTRCTVR3SEJOdlFaV2pkRm94VDNJ?=
 =?iso-2022-jp?B?QklzS2c0ekk5dE45dTA5RThmUTNJQ24wdTlpZlpZVW9rSGZDc0pIK2wz?=
 =?iso-2022-jp?B?TzJ3UHc0N1RZaEszd21DMTNWZmVYRHkyNElIRGVuanI3SlN5V1hmTWR5?=
 =?iso-2022-jp?B?eXFKTWRsc1Z1RVZlTVk3VEZCWS9UbGY1VFZtU0srMWZRcnd3NjhqVU9j?=
 =?iso-2022-jp?B?bWlHQ2RuWTJTbEtuZDkxdlAyTlVkQXo0Mk1jVzNjTTY5Ti9DNEF0Zlll?=
 =?iso-2022-jp?B?WkM4TThTbEZUL0Yvb042SWpnRnBCaElZTXJBLzd3YWFza2I5NWZXSkk5?=
 =?iso-2022-jp?B?S0NaSkFOeE9QbENSQ1gxVEQycUZ5bnc4SnFyWGJZY0Jsc3dZWnI5aHRh?=
 =?iso-2022-jp?B?eHoxSG9GZzNuK1V2RGZYOU5nT04rV0dET3lmWUh3MHBocWFVUjVXUVhk?=
 =?iso-2022-jp?B?aDZMdmZ3eGxmNE1SL2l1YTlaV081Zndqb015TmZFMmVIandSMDJKUWNY?=
 =?iso-2022-jp?B?blB1UXJqMnV3STY5MEVYS0plQi9kdXFwWDUreXdNd1RHYVloUk5zVTA4?=
 =?iso-2022-jp?B?dHJ3NTRKTzJjQ1h0ZHJpU2s4ZlF6WWdTSWxheXJHQXJJdy9jRzdEbGo5?=
 =?iso-2022-jp?B?WFU2K1ZjcWJhS3c3bk1xTzgwemJjaGlGNUtzZ0tycjR3YWM1MTJ6MWRM?=
 =?iso-2022-jp?B?dENnQXAxS2dpcHBzdWp5RkU5VlpQZWc0N3VXbzhWV0cvVFpaaXZEZS9F?=
 =?iso-2022-jp?B?RGZYYS9zSG5QQW9Jb0ZnUmIyMnB5cnFPZHBJWTZkR0J5YmVadkZzcWpZ?=
 =?iso-2022-jp?B?SUlIY212ampVWENPb29iTGlFYm9wN0o2RHVBMFNISkd2akxmbVd2b3hW?=
 =?iso-2022-jp?B?akw0UFc2YzFBcmtSalpvb0E0RDIyYUU5?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB9983.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018)(1580799027);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?QzFMZ2NwSU1BSnpoZkRZQ0w0ZmVyQ0EweE00ZUQwbEVwTStBNzVrdDFG?=
 =?iso-2022-jp?B?Mlp5ZUVFcks0RW1KQ3dndVR0QmJrVUdJREczU2liTytFMFlENENlY011?=
 =?iso-2022-jp?B?aHUzbTFrclZQT0ltdUhTQ3k4KzBGK1Y3VnB1RTI5UjVJczNSTXVZOTla?=
 =?iso-2022-jp?B?VXhPdFdyM1RKbi9OSkI3RVlCeVBwTUkxRXM2NTJOZzFzSGgxTTRveEk5?=
 =?iso-2022-jp?B?RFlLYWNGU29YRVVuUUx3VnNaTzZ5a2h2bVV5VmREdjBNcmU3Nzc2Vjhv?=
 =?iso-2022-jp?B?OHRmTDNXL0VWQ2ZDRXVqeUtuOFhJZ0dKaVQ3ckwxbVJ2bXVra21lK3VD?=
 =?iso-2022-jp?B?eE5oSVZWNGhJclJCV3ZqMGpKbyt2UVhRdGxhSzlyTDBid0pNZ1ZNQlJo?=
 =?iso-2022-jp?B?SzJDT2ZoK250YzJuVWdHbGd5SThGY29pVkhIbVlTR0w5SE82RVN1Q0xZ?=
 =?iso-2022-jp?B?THc3cTJKNW1rRTlLTENaaDNHMVVYQkJVRHIvdEZVb2FmdE1qekJ2bWtR?=
 =?iso-2022-jp?B?eit2NkpFV0lEVUNQMnNOMkttYjJiR01YeWFacFlJcWs5bjhmY2FFdmdK?=
 =?iso-2022-jp?B?VC9qNGZVWmNIc2VqaEtYdnRqdThySjNKY0didFo3U3daVlVWc3NuWHJU?=
 =?iso-2022-jp?B?WS83OVo1b3BndHNMRWdpVndSSzVJUU1vc2NYMVE0eW1JK2daWlhTbERy?=
 =?iso-2022-jp?B?MVF4bngvTDViM2lZK3drMWQ2WUZDYjhld01YczBDQmViblZQaEV5eWJP?=
 =?iso-2022-jp?B?amM0QmtSaFBRamJjSXRrL3VlQ1M3cUZabE1EeFM4dXl6eDliRy91ZGJ2?=
 =?iso-2022-jp?B?UGFud1RkNHB4bStWRk0wUGU4bmszT1Fwd3pBRFRxbHZUblhQckovOUIv?=
 =?iso-2022-jp?B?a2tObDl5c05ZVGluRk1Ub1NGTU91aTRmK0x6MjdocGQvdHN5bXl1L3Jq?=
 =?iso-2022-jp?B?TmFCNEJVa2lWSTBicTdQKzJtYzRIM1lHMUtUUm90MVU2eEF0RlJtOEVV?=
 =?iso-2022-jp?B?ZkJkWmJLVi9FTy9tTk93bDArOVREdXIxd0VBSVZ3c1hpMTR5cUtBeWhO?=
 =?iso-2022-jp?B?YmlFblRXYjM2cllEY2FXdWFza3lUWkJ3N3ZJdTBoUnFLc09XQjhjdGVZ?=
 =?iso-2022-jp?B?MEZSWXhWVjZuTmJEam5CMGVHNkVEVnYzNlRzVlhyYWp3Qys5QUJHTGhR?=
 =?iso-2022-jp?B?WGJRYU8zT2FFMkdMUGdpV0FNNFhoWDFqVnJ0Q2ROZWhMbkhVNXpHWXY1?=
 =?iso-2022-jp?B?VXZRMDlER0xTWmQ1N3UvS0s3a3BXZ0hSVGdocjFHK3h6cWY4T3IwczhJ?=
 =?iso-2022-jp?B?cWtCaDFyWUplNVRIZUh4c0txS1YyTjdKQkZMNU1tQnRzMHRPaHVnYXU2?=
 =?iso-2022-jp?B?d1c2YjNSeXhuV1pYMDJFaUZvSXFCQ3VJc0xnb25jZmpObXdhaWFZVlJr?=
 =?iso-2022-jp?B?bzd0NXlBNDVacUg5eGFyb3hxK01JR3lmdUNYNHg0WGhKWUc1T2hrVWx6?=
 =?iso-2022-jp?B?WjBzQ0p6N1p3VDRkWDBWeWNoVzZZZW4rUUZSWll5VEN0Nm1GQUl1cHhE?=
 =?iso-2022-jp?B?ZnRwQldFaTUyZmYyRXpCSGlyNVQzWW1zbVExQTdSYkRBRGNMY1kyTEV1?=
 =?iso-2022-jp?B?b1BsRGRHb1g3UUthZEJhZFFyeW9jeUl0NzU0V05hU0FLYXlwdnVTM3lE?=
 =?iso-2022-jp?B?OHVJeDRtUlQ2ZmtwNVN1R0x1dmc3UXg0K3pXYnpob2dpRXNNMHRpbncx?=
 =?iso-2022-jp?B?S2NzYWVKZTlDaEVpL3pSYXZBMVozVll5V2x5eTNyK3JyMWViNVd2N0x5?=
 =?iso-2022-jp?B?MDM5eThDRE9WNTFLUnVGczl2U1puTEhSZHM1d2pRYndaSHNRdWxWcGZY?=
 =?iso-2022-jp?B?WHBzUzExejBFTWp6Y3NySitYL0tBT21zTmNQYlljUHB6dTNCRHdJeS80?=
 =?iso-2022-jp?B?b1JHVnluaGVwdFRMS0lrSTNObTJXNHZGRUVFNzFuMXAveFNHWG93T3ZQ?=
 =?iso-2022-jp?B?VnNlbERNNy9jOURXenAreEFCRDFZb2xQaHB4MFRQUFJ5b3NXWlNORy9k?=
 =?iso-2022-jp?B?amdNbWdIaHIwSXpIa1k3a1RmUE9oU1pvVUlLaERadXBFenRtZWNhS0p1?=
 =?iso-2022-jp?B?SW5LaGw3SjdtS2hHZEpnVmNMYWVBZDRtZzBKb3pSTmw2MGJqUmVFbmlQ?=
 =?iso-2022-jp?B?RW5zTHdENUtqODNJRStPOWtHb0hlaVpBVk9ya2lzZG41cHZLY3RtWkdq?=
 =?iso-2022-jp?B?cVVlM2lzWVg1TVo2SUlOYVZjRHE4R1BYOVBlL3RkbVgwNGNDQTRSSU5M?=
 =?iso-2022-jp?B?T29DdFdRY2NySTlsbUtNYjR2SHYzdjJNZXc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	7M1KaglVW1Wm4E/Ip6BZHPIT4u6ylJq378ZTGLxeiTBrEdkDFAfBkHjabUbPa/snyf0hF9DtcQwAIFbPgvO+n/7aGglxH9pm68m2tKWxvALxSFdQ3G9YKQduDlLOn4U6EU+gQmhnVHK9g8EjZrE/wOMLogbvkyyrLunZ/aTXAIxjqqMuKwE6BF6bhOmmr66Gh4QlsapVA9yNcYtXB0S18OqevOY7tcNZdqauC6W10AU6SVB6esh/a5l36hCH74sw30LRP4oVWOySJJLmyFRtOyXdguWh7tHv5uJYLURYKr63PsqXItC9Vy7HgeedWUw32niQjY17afy68LcInzQO8+xlgmQxl0jQu0vd6rB2LEZn28OgJv9grVN2T/wzWwqOGSw6aqHMOZt8NxyZjiCAW5uW4rMWchuC5RkWSlIE4OY0UNe4V2K0wcDwatrIW/6gvL7MwV/bj8lCtrbGRURjjAnbRvHg9GROYR15dalCmLKfik3ohtxQXl2iO2CCa0d88zbrcPqAuiNP1zE7MZTpX8cQM71U+HTGZw7Na8K8DK9udLjgv3E6KGsKGdJ+KiHJZBx8/YQnfYtYlYbNeKbnvm9bDtsqahX/u863P/L0E0cjuQYZ/mZk9vf1w0Zg7BS/
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB9983.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e5f214a-bbf1-4a3a-60dc-08dde6e5db3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2025 10:21:45.6207
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: egwUEwAAr7IkbKXs6Wbdh6cH48rlcQxpue+OBY6gKBSGf2ZICiv6AncpJ+pqT17/sc+uV4HWE/fAFHJ5ZAkPwi12nXRHvipvg3nLCSWye5E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB14592

Hi, Ilkka

> Hi, Ilkka
>=20
> > Hi Kazuhiro
> >
> > On Mon, 18 Aug 2025, Kazuhiro Abe wrote:
> > > AGDI has two types of signaling modes: SDEI and interrupt.
> > > Currently, the AGDI driver only supports SDEI.
> > > Therefore, add support for interrupt singaling mode The interrupt
> > > vector is retrieved from the AGDI table, and call panic function
> > > when an interrupt occurs.
> > > SDEI & Interrupt mode is not supported.
> > >
> > > Signed-off-by: Kazuhiro Abe <fj1078ii@aa.jp.fujitsu.com>
> > > ---
> > > drivers/acpi/arm64/agdi.c | 114
> > +++++++++++++++++++++++++++++++++++---
> > > include/acpi/actbl2.h     |   4 +-
> > > 2 files changed, 110 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/drivers/acpi/arm64/agdi.c b/drivers/acpi/arm64/agdi.c
> > > index e0df3daa4abf0..c514bb874c5d3 100644
> > > --- a/drivers/acpi/arm64/agdi.c
> > > +++ b/drivers/acpi/arm64/agdi.c
> > > @@ -16,7 +16,11 @@
> > > #include "init.h"
> > >
> > > struct agdi_data {
> > > +	unsigned char flags;
> > > 	int sdei_event;
> > > +	unsigned int gsiv;
> > > +	bool use_nmi;
> > > +	int irq;
> > > };
> > >
> > > static int agdi_sdei_handler(u32 sdei_event, struct pt_regs *regs,
> > > void *arg) @@ -48,6 +52,55 @@ static int agdi_sdei_probe(struct
> > platform_device *pdev,
> > > 	return 0;
> > > }
> > >
> > > +static irqreturn_t agdi_interrupt_handler_nmi(int irq, void
> > > +*dev_id) {
> > > +	nmi_panic(NULL, "Arm Generic Diagnostic Dump and Reset NMI
> > Interrupt event issued\n");
> > > +	return IRQ_HANDLED;
> > > +}
> > > +
> > > +static irqreturn_t agdi_interrupt_handler_irq(int irq, void
> > > +*dev_id) {
> > > +	panic("Arm Generic Diagnostic Dump and Reset Interrupt event
> > issued\n");
> > > +	return IRQ_HANDLED;
> > > +}
> > > +
> > > +static int agdi_interrupt_probe(struct platform_device *pdev,
> > > +				struct agdi_data *adata)
> > > +{
> > > +	unsigned long irq_flags;
> > > +	int ret;
> > > +	int irq;
> > > +
> > > +	irq =3D acpi_register_gsi(NULL, adata->gsiv, ACPI_EDGE_SENSITIVE,
> > ACPI_ACTIVE_HIGH);
> > > +	if (irq < 0) {
> > > +		dev_err(&pdev->dev, "cannot register GSI#%d (%d)\n",
> > adata->gsiv, irq);
> > > +		return irq;
> > > +	}
> > > +
> > > +	irq_flags =3D IRQF_PERCPU | IRQF_NOBALANCING | IRQF_NO_AUTOEN |
> > > +		    IRQF_NO_THREAD;
> > > +	/* try NMI first */
> > > +	ret =3D request_nmi(irq, &agdi_interrupt_handler_nmi, irq_flags,
> > > +			  "agdi_interrupt_nmi", NULL);
> > > +	if (ret) {
> > > +		ret =3D request_irq(irq, &agdi_interrupt_handler_irq,
> > > +				  irq_flags, "agdi_interrupt_irq", NULL);
> > > +		if (ret) {
> > > +			dev_err(&pdev->dev, "cannot register IRQ %d\n", ret);
> > > +			acpi_unregister_gsi(adata->gsiv);
> > > +			return ret;
> > > +		}
> > > +		enable_irq(irq);
> > > +		adata->irq =3D irq;
> > > +	} else {
> > > +		enable_nmi(irq);
> > > +		adata->irq =3D irq;
> > > +		adata->use_nmi =3D true;
> > > +	}
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > static int agdi_probe(struct platform_device *pdev) {
> > > 	struct agdi_data *adata =3D dev_get_platdata(&pdev->dev); @@ -55,12
> > > +108,20 @@ static int agdi_probe(struct platform_device *pdev)
> > > 	if (!adata)
> > > 		return -EINVAL;
> > >
> > > -	return agdi_sdei_probe(pdev, adata);
> > > +	switch (adata->flags & ACPI_AGDI_SIGNALING_MODE_MASK) {
> > > +	case ACPI_AGDI_SIGNALING_MODE_SDEI:
> > > +		return agdi_sdei_probe(pdev, adata);
> > > +
> > > +	case ACPI_AGDI_SIGNALING_MODE_INTERRUPT:
> > > +		return agdi_interrupt_probe(pdev, adata);
> > > +	}
> > > +
> > > +	return 0;
> > > }
> > >
> > > -static void agdi_remove(struct platform_device *pdev)
> > > +static void agdi_sdei_remove(struct platform_device *pdev,
> > > +			     struct agdi_data *adata)
> > > {
> > > -	struct agdi_data *adata =3D dev_get_platdata(&pdev->dev);
> > > 	int err, i;
> > >
> > > 	err =3D sdei_event_disable(adata->sdei_event);
> > > @@ -83,6 +144,34 @@ static void agdi_remove(struct platform_device
> *pdev)
> > > 			adata->sdei_event, ERR_PTR(err)); }
> > >
> > > +static void agdi_interrupt_remove(struct platform_device *pdev,
> > > +				  struct agdi_data *adata)
> > > +{
> > > +	if (adata->irq !=3D -1) {
> > > +		if (adata->use_nmi)
> > > +			free_nmi(adata->irq, NULL);
> > > +		else
> > > +			free_irq(adata->irq, NULL);
> > > +
> > > +		acpi_unregister_gsi(adata->gsiv);
> > > +	}
> > > +}
> > > +
> > > +static void agdi_remove(struct platform_device *pdev) {
> > > +	struct agdi_data *adata =3D dev_get_platdata(&pdev->dev);
> > > +
> > > +	switch (adata->flags & ACPI_AGDI_SIGNALING_MODE_MASK) {
> > > +	case ACPI_AGDI_SIGNALING_MODE_SDEI:
> > > +		agdi_sdei_remove(pdev, adata);
> > > +		break;
> > > +
> > > +	case ACPI_AGDI_SIGNALING_MODE_INTERRUPT:
> > > +		agdi_interrupt_remove(pdev, adata);
> > > +		break;
> > > +	}
> > > +}
> > > +
> > > static struct platform_driver agdi_driver =3D {
> > > 	.driver =3D {
> > > 		.name =3D "agdi",
> > > @@ -94,7 +183,7 @@ static struct platform_driver agdi_driver =3D {
> > > void __init acpi_agdi_init(void) {
> > > 	struct acpi_table_agdi *agdi_table;
> > > -	struct agdi_data pdata;
> > > +	struct agdi_data pdata =3D {0};
> > > 	struct platform_device *pdev;
> > > 	acpi_status status;
> > >
> > > @@ -103,12 +192,23 @@ void __init acpi_agdi_init(void)
> > > 	if (ACPI_FAILURE(status))
> > > 		return;
> > >
> > > -	if (agdi_table->flags & ACPI_AGDI_SIGNALING_MODE) {
> > > -		pr_warn("Interrupt signaling is not supported");
> > > +	switch (agdi_table->flags & ACPI_AGDI_SIGNALING_MODE_MASK) {
> > > +	case ACPI_AGDI_SIGNALING_MODE_SDEI:
> > > +		pdata.sdei_event =3D agdi_table->sdei_event;
> > > +		break;
> > > +
> > > +	case ACPI_AGDI_SIGNALING_MODE_INTERRUPT:
> > > +		pdata.gsiv =3D agdi_table->gsiv;
> > > +		break;
> > > +
> > > +	default:
> > > +		pr_warn("Signaling mode(%d) is not supported",
> > > +			agdi_table->flags &
> > ACPI_AGDI_SIGNALING_MODE_MASK);
> > > 		goto err_put_table;
> > > 	}
> > >
> > > -	pdata.sdei_event =3D agdi_table->sdei_event;
> > > +	pdata.irq =3D -1;
> > > +	pdata.flags =3D agdi_table->flags;
> > >
> > > 	pdev =3D platform_device_register_data(NULL, "agdi", 0, &pdata,
> > sizeof(pdata));
> > > 	if (IS_ERR(pdev))
> > > diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h index
> > > 048f5f47f8b88..9ddbdd772f139 100644
> > > --- a/include/acpi/actbl2.h
> > > +++ b/include/acpi/actbl2.h
> > > @@ -339,7 +339,9 @@ struct acpi_table_agdi {
> > >
> > > /* Mask for Flags field above */
> > >
> > > -#define ACPI_AGDI_SIGNALING_MODE (1)
> > > +#define ACPI_AGDI_SIGNALING_MODE_MASK (3) #define
> > > +ACPI_AGDI_SIGNALING_MODE_SDEI (0) #define
> > > +ACPI_AGDI_SIGNALING_MODE_INTERRUPT (1)
> > >
> > > /*******************************************************************
> > > **
> > > **********
> > >  *
> >
> > Like Hanjun mentioned, these should go through ACPICA project. When
> > you do that could you also add the SDEI flag to the other places,
> > which are needed for iasl to be able to decode AGDI tables. You can
> > find them if you take a look at my patch in ACPICA project.
>=20
> Thanks for your comment. I found your patch.
> I will send a patch to ACPICA first. Once it is merged, I will send v2.

After reconsidering, I decided that the acpica code fix was unnecessary,
so I posted v2 patch without the acpica fix.

Best Regards,
Kazuhiro Abe

>=20
> Best Regards,
> Kazuhiro Abe
>=20
> >
> > Cheers, Ilkka
> >
> > > --
> > > 2.43.0
> > >
> > >
> > >

