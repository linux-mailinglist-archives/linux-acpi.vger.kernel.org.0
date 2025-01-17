Return-Path: <linux-acpi+bounces-10737-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98E5DA14DFE
	for <lists+linux-acpi@lfdr.de>; Fri, 17 Jan 2025 11:51:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F29E188AD0D
	for <lists+linux-acpi@lfdr.de>; Fri, 17 Jan 2025 10:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9072B1FE450;
	Fri, 17 Jan 2025 10:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="FeF3BbB3"
X-Original-To: linux-acpi@vger.kernel.org
Received: from esa10.fujitsucc.c3s2.iphmx.com (esa10.fujitsucc.c3s2.iphmx.com [68.232.159.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EED51FDE20;
	Fri, 17 Jan 2025 10:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.159.247
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737111066; cv=fail; b=sSY9cSHmL/aJzcOkT7anoe6r5b8XLLOWon8aTnb4i01WbB5Z018VF8HvE1xJGfHlIoxF/pbp4WWFhekfScCulOLYnITHs9KuhmW8xJgQnwug2ARygQC4IPNND8bIfqU1m7qqFva7Id958SKC5+RnNhruOKhWNEqUnzM+wDQ1F8c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737111066; c=relaxed/simple;
	bh=BWLPA2ppsXGwBiJn/41nyMUPAQKLRQaBqcwiHW8rArg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lSnZqOEoEdThBQB+E/UdIi0tA2sPh/QdOToW2NyjUvUFWG/tFykxNkhLHZf3xHAp6afQbM2mBl/QJziHcMPvZizobW8KyQVX+05tBDwRqvk0j11pXgosQth6D7+8As4uT+IA+Ko7DXh/XBS3M9oXVi9QqNYegiPCg11iq4LXza0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=FeF3BbB3; arc=fail smtp.client-ip=68.232.159.247
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1737111061; x=1768647061;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BWLPA2ppsXGwBiJn/41nyMUPAQKLRQaBqcwiHW8rArg=;
  b=FeF3BbB3pB9mspEwhrXgHtjHM33MgV8SPEyocMo9Yzr3enVv0/LzvkN5
   YJ2GjgKzl5ul+3CQln2CEv9dvHrtdcI1fE6/rmDEzHlIyJD+IMwxW4w+N
   gS5TzX9UgXKE7OkjeXO84Bh5ErwfneqawPe2s+XG/SZkN9PBrbmMc5fzJ
   cEJ+ujFQMbAtqO5f4sGYHemB6qAYfjLfMllTIpDdcjEV53ls2Rv/eZtev
   yquC3YGGkCiylzEbvfAYUkDlAK+OPBhFjH6ceP2Hy07E3ohvTOFx6ZO09
   DYEg5WGNb5eotJuaHZpzcEu84n/HJf122jI0ya5vtXxSUH4sAmgqqJUc2
   A==;
X-CSE-ConnectionGUID: 3C6RBXKNS6q2no1gaBejpw==
X-CSE-MsgGUID: 9qz4C6y0Qm+/u/YupvNLYg==
X-IronPort-AV: E=McAfee;i="6700,10204,11317"; a="143342011"
X-IronPort-AV: E=Sophos;i="6.13,211,1732546800"; 
   d="scan'208";a="143342011"
Received: from mail-japanwestazlp17010000.outbound.protection.outlook.com (HELO OS0P286CU011.outbound.protection.outlook.com) ([40.93.130.0])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2025 19:50:48 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rG2ZMK7/5AagIx+z4PTzBd+phVzXq3miOw2B2qUnSr4WqOucRVLD7/oyt9yoHh7/iF1erGM2ryn9zQREc9lPmpIiwCxkiuhkY3EXlG+zScaWXCFy96XcjmBx2XCYnLXI6u++XQcZOWJTa5dB6X8BQaE+G5dfqIk4admbKDL+8P6+6VW7RqE1BbCUFCTT5yDq64V1L/PHM23EtmOoHDea8V01nXPEk8EGE5B8cvlktcVTEjzX8F+4QWPBUnvGqOj5AMcdlabWi/Lpupu0y8yKA22z7LWnByM1q7EhbpAzBvwdgnLf3x2CLbEbN8/Ei0ytmvPJtWTgGtJnyELWZqif8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o0+UpAWJYmC6KqcWIv43oBbaBL2FMy9NLGP/tsZE26U=;
 b=Nf8MRcfzrqEgnkKGUsehzGfWX5HTG2xW/advFUwn+1ts4jXS6X8a4nb7OtjbE+nCFKMW8dd/ZN9aAf4jRui/xc8SH7RQM6IqG5JWA+GyPoYOPc0bDN4TI1mHWst0m/8uqoIcB6h7EGDy4GOaquyNOVEXnEmMqzuHqRA655BeIC52gFNTWcd00jbDwzqdWFmG7dW+vaWgDHnAow120F4+dFhSFr4Hp6+U+FIwb75uYXRAQXCBr7LgjKhN4FesqAXiifsFoJbZoaz0yOV08YzfTOLLdkafJ0lPEfHYkHofI5n56VqyJT9YSwCY9fvWcy7S4J7LoX7TqpGz7sMh1XocwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYCPR01MB9617.jpnprd01.prod.outlook.com (2603:1096:400:194::9)
 by OSAPR01MB7280.jpnprd01.prod.outlook.com (2603:1096:604:142::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.16; Fri, 17 Jan
 2025 10:50:45 +0000
Received: from TYCPR01MB9617.jpnprd01.prod.outlook.com
 ([fe80::9aa4:6568:4bc3:9477]) by TYCPR01MB9617.jpnprd01.prod.outlook.com
 ([fe80::9aa4:6568:4bc3:9477%3]) with mapi id 15.20.8356.014; Fri, 17 Jan 2025
 10:50:45 +0000
From: "Tomohiro Misono (Fujitsu)" <misono.tomohiro@fujitsu.com>
To: 'Ruidong Tian' <tianruidong@linux.alibaba.com>, "catalin.marinas@arm.com"
	<catalin.marinas@arm.com>, "will@kernel.org" <will@kernel.org>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>, "guohanjun@huawei.com"
	<guohanjun@huawei.com>, "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
	"xueshuai@linux.alibaba.com" <xueshuai@linux.alibaba.com>,
	"baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "rafael@kernel.org"
	<rafael@kernel.org>, "lenb@kernel.org" <lenb@kernel.org>,
	"tony.luck@intel.com" <tony.luck@intel.com>, "bp@alien8.de" <bp@alien8.de>,
	"yazen.ghannam@amd.com" <yazen.ghannam@amd.com>
CC: Tyler Baicar <baicar@os.amperecomputing.com>
Subject: RE: [PATCH v3 1/5] ACPI/RAS/AEST: Initial AEST driver
Thread-Topic: [PATCH v3 1/5] ACPI/RAS/AEST: Initial AEST driver
Thread-Index: AQHbZyoYg5R+jtSKtUuo6eNisznjObMaqc0A
Date: Fri, 17 Jan 2025 10:50:16 +0000
Deferred-Delivery: Fri, 17 Jan 2025 10:50:16 +0000
Message-ID:
 <TYCPR01MB9617ACDCBA0A2D306789A314E51B2@TYCPR01MB9617.jpnprd01.prod.outlook.com>
References: <20250115084228.107573-1-tianruidong@linux.alibaba.com>
 <20250115084228.107573-2-tianruidong@linux.alibaba.com>
In-Reply-To: <20250115084228.107573-2-tianruidong@linux.alibaba.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ActionId=db087b0f-8322-4244-9977-d8d3163e0821;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ContentBits=0;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Enabled=true;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Method=Privileged;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Name=FUJITSU-PUBLIC?;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SetDate=2025-01-17T08:44:55Z;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB9617:EE_|OSAPR01MB7280:EE_
x-ms-office365-filtering-correlation-id: 4b53a93d-8948-40c9-eeff-08dd36e4cbcc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020|1580799027|38070700018;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?YjhUaVhBeVIvcGJVT1dqMlNydGdQdklVenUyNW5MTkE4R2svdUtoNlZT?=
 =?iso-2022-jp?B?QWdkZ3U3RzBEc2J5T29OUTNQWXZ6NGtQR0lvWDd2SkludUpvTG9NbUpT?=
 =?iso-2022-jp?B?NGlnWnY1SmNPb1lUcGplZjdobjFURzZTTHdhNEpXNklMTDEvcGlHaDMv?=
 =?iso-2022-jp?B?Vm42Ym96aFJ6b2xBMExKQWY2RDB1cTJrS3lRNzNMaHI0anhqTkxHeWt4?=
 =?iso-2022-jp?B?MEtvdkhDMS9nNVJRK2lla25rZmVndVhWbElUaWJYOXJ1a2lmK3lPd2kz?=
 =?iso-2022-jp?B?WHFRR05SUFRwT3hqMVQ4c01PalN4Zkkva0tndFZZZ0N3WGIyZGM5bDVQ?=
 =?iso-2022-jp?B?N203ektGN005TzF3TGZMWUlHbSs4M0JiVk1yZ2VUai9TVEFvaEFzM0cx?=
 =?iso-2022-jp?B?d1dLbnplaXlsbTZGOUdpMXVVSUVzNmMrRmVtem0weG5jb04xNVlLcGlP?=
 =?iso-2022-jp?B?ZVY3dnU2aHBLQW9zMCtQZktmOXBCZlB4SGE4OGlHZnZHSU1tYW1teXB2?=
 =?iso-2022-jp?B?YmtxNmUreXpuQWtFMWFZVmY0aDVsVHA5QTZrcDdQNXNXZSsrejRKWHRo?=
 =?iso-2022-jp?B?QTFIcGM1SDFySUcxeEhyZWRSdk9oY096cnQ1eXJVUHBoejc1UkJUZEFV?=
 =?iso-2022-jp?B?RURJR3FTVitGUFpiRm1UQzNHT3hRK2FLQlFuK2tmWTJzOVlxLzdDcG9S?=
 =?iso-2022-jp?B?S0RZdzBkdWdwUTl1dmNKbVBUK1pMOStZOW1Xem9NRmpmV3NtMVVVRVVl?=
 =?iso-2022-jp?B?ZkswOGpiY0JaVW1lTW9kMFdwUUV2WkdhRGc2cmJvNUsxT3RWU2xHSHJr?=
 =?iso-2022-jp?B?TnE4MWVaSEJLbUE0bUxqSC9tZHRaQjZ3MzYvN29zUG9sL0d6Sm5CYXUx?=
 =?iso-2022-jp?B?ZDY5VTZwaW9tUHdUWEpNVER0a3NORlNuNlVHN080THBqaXZsZ2J0S2pj?=
 =?iso-2022-jp?B?TjFqZTArWEsyZE0zeWJ4ZlVqcTcwZmtCbGJRMjNxYlc3bG92VUNJVXhs?=
 =?iso-2022-jp?B?K2ZyMjhkSmU2c2Q5NTFsN2FEei9jdTZ1UlFTcElBU2VtUU1TVTMwa0xH?=
 =?iso-2022-jp?B?MFVyMlpNSEJjNGI2a0d4bHNsRG1CYXZ1OENLQ2RJeDh2Y0pKQmJoVG5J?=
 =?iso-2022-jp?B?UW5PZzh1Z3orZG9VNC8vTTRWRXpIOFBYaWl5VzNLU3RjVkJpaldnU3hy?=
 =?iso-2022-jp?B?TEg3UjRWOU1IUU9YZHJLMWdDUm10ZXFmaHVXdGIvbHQranpUL25reXQy?=
 =?iso-2022-jp?B?akhtb21oeHJiRi9yVW44QXNsbHdnRG1udzBGTzBlV29VMXU1KzIySTVU?=
 =?iso-2022-jp?B?Z1cvMTFkblRKSnVxK1djMDZYRnR1eXFWL2E3MWtSeXQrQ2pqK0Jna2Vp?=
 =?iso-2022-jp?B?QjBCWlpoUE5MYzhMTnFZSFRlUWRCRWkrVGFrSTFQeGRYWTZwcEVzc3Bu?=
 =?iso-2022-jp?B?THBieElyWGw5T3FlcjhsR2wrOTJOUWV5T2xJVXFINE5PTGN2RE1NcTU4?=
 =?iso-2022-jp?B?d0laem9ONlVPUnd2WnRHcmlSbjNxRVZvVDdRQlc1ZkFnWm9XY0pSc3E2?=
 =?iso-2022-jp?B?TE1YNGJJcDhQdXR3YkhTWTlHQnh3RmhUTFIyZTREcGoraWhsS25rakZx?=
 =?iso-2022-jp?B?cStwbzA0cDhhTGJtbDJLZC9wc1lZUDJkTnZDYWM5N0lIeDFBYTVHcHpQ?=
 =?iso-2022-jp?B?TVpjVW5LeThobGV2UGtkd01GeGFQQWFWSm8xZTRLTG44ZE9GaVhrQWtH?=
 =?iso-2022-jp?B?MERaZ0JHK2hMVjl2U09EVk5DZmMxS21kanI2UGlNWk1QNFFNVW9lYllC?=
 =?iso-2022-jp?B?Y3ZreEFxS2VvbVFhVUdlOWY5VSs3WGhwMDNwMnR6T0ZSWWN2NjF3Z2Uw?=
 =?iso-2022-jp?B?M0VkSTFKQVFQMVVPMktrZVBvMFB5U0VqK2dJZG1ucjhmTmx4WFZaU0hS?=
 =?iso-2022-jp?B?WnZaNy8xalhhaytjTnhLSHdlaTl5bm95eEpwbnJYYlhwL3MySzRHelNo?=
 =?iso-2022-jp?B?RDk2UUZpWkJSdHQ2K0NWNjYyOXdiWDZBTW03ZXp0ZFplZHY3cHRrbnph?=
 =?iso-2022-jp?B?VHZLZUNCUWx5TVgvb01BaWwwYlVTNFp2NjBla0dwNkgrR3M5ZE1RUHhk?=
 =?iso-2022-jp?B?RTI=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB9617.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020)(1580799027)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?eG10YURBM0pHT2pTWFVpbWJwUWN5SjRrcExVa0xTVllYdHJ1NWl6d0d1?=
 =?iso-2022-jp?B?R0RqdXBBNmt5M1dHMHYvZzZ3WlRTOXJGS2p5b3dZSCtneTBYVjVvK3Fj?=
 =?iso-2022-jp?B?cklZZHBUSU9HVXh5TC8xcDBqaEI1VWZZaTdidjlCRjQ1U0hEdzJGc1lT?=
 =?iso-2022-jp?B?YjFSNXdidnR4eGJrR0xFSWo2STc2YXVwZGtUY052Y2wyV3FHakluUHNn?=
 =?iso-2022-jp?B?THFvMlRIeW9KbkVEbmNhdDZBbDAxanJJcnlHdDdCQmg2V0hvdEVOdmg2?=
 =?iso-2022-jp?B?NXd3U0VCMGw4elFaNkVWdy9MNjlXRGh3QWp6dHZMZUdVSG9qemJUdGJp?=
 =?iso-2022-jp?B?dTc1U3Q5OHlOZTRGRUo1QkF1SHJaOWJEeXc0cmxmalZpamprMDN1b0t1?=
 =?iso-2022-jp?B?UFAyZnR3RWZWd1JvblVoeUgreS96a0xxdm9rdGI4MzdLdDNZcUFibUdm?=
 =?iso-2022-jp?B?bHl6TXlmdzVMWjFjRzBRZlFkcnJncEZ4d1U3YW56WU5tZXloUms0djhp?=
 =?iso-2022-jp?B?U05wWDNVajdtV2JTUGZEeFlZQ0xaeU9OVWRCQWRodkdsSFVHL3puN2hY?=
 =?iso-2022-jp?B?V042bE5SbERiQmRrdTc5eGdMTGYzdTZ5b2p4SDBuU2FNL2o4UVhIMmN6?=
 =?iso-2022-jp?B?d0ZpMWZ0eEY3MWtiTFdqb05HL0l0andCS1ZLaTNLRWNHR2dXYlBiSW1w?=
 =?iso-2022-jp?B?M1dIWmUycXVCNFlGYTBhVEdhd2RCYjd3eklkcTBjbWFkSGhWV21wZC9v?=
 =?iso-2022-jp?B?cG1VOUhyTkhrY0hCTlVvZEZOdFFBYS8vNW1mQlMwaEJBZGh6R3pzMk9u?=
 =?iso-2022-jp?B?bFJpL0svT3dJNDd2U2RiY212NEJkUm9xR1RpMWk2eUlLVm02YWk4MmRF?=
 =?iso-2022-jp?B?V1c5N2EwRGVCVkI2czYxeHVqUVpIYXdVZWE0eTh0N29nTlJ4SHhnU29Z?=
 =?iso-2022-jp?B?TUhjOVVGNVFreW9BTTU5aGpUUFAwYmprZDFoTkpVa0xUZ2FzS2Q2NTRZ?=
 =?iso-2022-jp?B?WWpaZFJXN3pPQVpSRWkwYlEvQk54b25nckNJUFlzOFk2STlkYXR5NjF1?=
 =?iso-2022-jp?B?alNvTDdVQ201aHFyT3R0b0R0NEdvMUtQVFpSc2czMDZFbnNsUW1oM2xw?=
 =?iso-2022-jp?B?R3JQRmFpYThNY3dWSml1T0Q0ZFNBRzAwUFQ2eXJ5TkZucGxocDVsQThw?=
 =?iso-2022-jp?B?Zjk1dWc4K1lSNTNDczlMdVdxYzdDdlJCRWF5eW1QanB0bFVHTm9kaW96?=
 =?iso-2022-jp?B?bjdMZ0ZGV21FTlhZK21JZ3NjUkNJdG5TUnd3TDlmcDJNSGpoSGEzeWxO?=
 =?iso-2022-jp?B?RzJPRGlWK1hzR0I2ZFRBRG9zeU9GS1ZDK2dYbEtiTHlOckNyZUdVVmsr?=
 =?iso-2022-jp?B?RFNJSjExTEZTbUphcmExaGhhSGJ3ZmhDV04zbjhpVldvMVIvMzQxbHpP?=
 =?iso-2022-jp?B?RUVUL3RhK2JmTGVka2x2c3dHU0J3MTNxOVZqWlZ6TXpqaXlzKzVhWFZW?=
 =?iso-2022-jp?B?TW52dDdBMDl0ZXJqRm5jVit0dE5YRU8zc0s5aTNIdW4yWjF3S29yeDBJ?=
 =?iso-2022-jp?B?Y1lnL3BaQW1USS9UWk9QNWh5U0pBdFFRZnFVZC9iMEVlUlNFdFgzQ3JQ?=
 =?iso-2022-jp?B?TXpseUVGTWIwbmRWMmVuc3h1MEdSd25hQm1Hb29wWUxmTDZxaUtsUEs0?=
 =?iso-2022-jp?B?ei9qUWZyMTRQekRGbjNEVGR0T1VxblQxOVJkK3pySndxbTlwR09xdVJG?=
 =?iso-2022-jp?B?ZXYrSk9CVE9rcTJXOUZCV2FLZGxiYnVNQkFEOHJjQ3hzMmNSbXNwc21U?=
 =?iso-2022-jp?B?c0tJSUhIWWFraHJJZlRWaUdHTlkrRmdOZXU5UDNIcEw4MUs0NGhrV3Vl?=
 =?iso-2022-jp?B?eWorUFdIK2MvSDNFZDZub2QrV3JhU25McWNndmxRVjFkb0dTRFpRQm1V?=
 =?iso-2022-jp?B?Zm5xYXAxM0wyVW81eWVjS2s2Nmx5aHU5MjNxSWZpczh6TXNJN1JWSlVI?=
 =?iso-2022-jp?B?TjBkWFlBQWhvNWVMalEvbWRRVGRmMXMwWEhHVGNFTDBtVGt4c2V5STg0?=
 =?iso-2022-jp?B?Mi9jMkpmd0JoczdxNWtRbGNLWnhXeHpUWGMvM2pxSkRJUXBBVkNMem5V?=
 =?iso-2022-jp?B?SEVEekN1MkRSYThOd0VNdHBlM1VnMzI4NTdLeFVoS0dBRXU0WDFYY3Ru?=
 =?iso-2022-jp?B?dlE0UWZiblErazgwUC9kT3Q1b2xndHVZdWlIcStaaWFYbi9UVDFXbE91?=
 =?iso-2022-jp?B?QldXOWdvUG10RTFld2VMUXdkY1pNamQ4SDV0eWE0SEpkZVhyTm5zV3JM?=
 =?iso-2022-jp?B?aHNacUkvRDlTUUhDWkVXVE9LVkE5SWRYR1E9PQ==?=
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
	sQhbWV5DLNVHpwQi1nMGj3/KFG3sEWwfmMTVrX7LOIMzPAPOl4fbY6TsXHe723mF/PZW5WHUJqjRse9+pnWQEhTlUWdvp1nrcgUbAp+q8ZhzOM3eG9AFiYHhtWv/qwWxsmtRL/7cIz/+2CU95ecyDyHYPakkHGmQVX50tyBKsX+niP+E1HH0KVrAMse1mYQH3lq4engBSyeCjR3Qnh3k+PRrX7sqYVvf8LhZMatdnIfRZdWMBPRiXysC1rNxK9Ko9/5tyYWnCOn80aMjmNBfsVA+BGz6Ad6mGCv81+MEfnn25lgRtCbADxYmrKFnYCAIiiOKQGx0bVK85Ndb2L8qnVodnovDzaDF65R/7XrHFqfTPl8afJtSlPIcxQQl1HjFZ4R99p9ircPIzHRxHfSffuVWRp78mHp7rRq4cvo/sREknaEvjE4U81xbXiHkJ6GpNmVPKpuB1c1SJaHOTgi5d7QwTZzgQw6rjaJmRj6pmPg5kS9xoEueSMhEZlvKAPq+Av7zdMMl7J4Kg0zJ+AFdsURJOTyu9hwUSD6Ebk4+NkhHhUgMsKsftLZkmwpi0qjgwNfkiGikApaDzHwIXgkVzGFxQcmsJfzOnjwhOPkcSMWbvxY8F1NVzCFhNDxyA7or
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB9617.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b53a93d-8948-40c9-eeff-08dd36e4cbcc
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2025 10:50:45.5970
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BTZ4nbPc/npDEF0sW4zltMhr2PFYJYGDnHWhFlf+QFzKXNpPh010uZ/ISJNJog7Klhpyvi2PdYHQJJVmFBgPogXRWIhIpTxNiGJGlF62ubQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB7280

Hello, some comments below.

> Subject: [PATCH v3 1/5] ACPI/RAS/AEST: Initial AEST driver
>=20
> Add support for parsing the ARM Error Source Table and basic handling of
> errors reported through both memory mapped and system register interfaces=
.
>=20
> Assume system register interfaces are only registered with private
> peripheral interrupts (PPIs); otherwise there is no guarantee the
> core handling the error is the core which took the error and has the
> syndrome info in its system registers.
>=20
> In kernel-first mode, all configuration is controlled by kernel, include
> CE ce_threshold and interrupt enable/disable.
>=20
> All detected errors will be processed as follow:
>   - CE, DE: use a workqueue to log this hare errors.
>   - UER, UEO: log it and call memory_failun workquee.
>   - UC, UEU: panic in irq context.
>=20
> Signed-off-by: Tyler Baicar <baicar@os.amperecomputing.com>
> Signed-off-by: Ruidong Tian <tianruidong@linux.alibaba.com>
> ---
>  MAINTAINERS                  |  10 +
>  arch/arm64/include/asm/ras.h |  95 ++++
>  drivers/acpi/arm64/Kconfig   |  11 +
>  drivers/acpi/arm64/Makefile  |   1 +
>  drivers/acpi/arm64/aest.c    | 335 ++++++++++++
>  drivers/acpi/arm64/init.c    |   2 +
>  drivers/acpi/arm64/init.h    |   1 +
>  drivers/ras/Kconfig          |   1 +
>  drivers/ras/Makefile         |   1 +
>  drivers/ras/aest/Kconfig     |  17 +
>  drivers/ras/aest/Makefile    |   5 +
>  drivers/ras/aest/aest-core.c | 976 +++++++++++++++++++++++++++++++++++
>  drivers/ras/aest/aest.h      | 323 ++++++++++++
>  include/linux/acpi_aest.h    |  68 +++
>  include/linux/cpuhotplug.h   |   1 +
>  include/linux/ras.h          |   8 +
>  16 files changed, 1855 insertions(+)
>  create mode 100644 arch/arm64/include/asm/ras.h
>  create mode 100644 drivers/acpi/arm64/aest.c
>  create mode 100644 drivers/ras/aest/Kconfig
>  create mode 100644 drivers/ras/aest/Makefile
>  create mode 100644 drivers/ras/aest/aest-core.c
>  create mode 100644 drivers/ras/aest/aest.h
>  create mode 100644 include/linux/acpi_aest.h
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 637ddd44245f..d757f9339627 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -330,6 +330,16 @@ S:	Maintained
>  F:	drivers/acpi/arm64
>  F:	include/linux/acpi_iort.h
>=20
> +ACPI AEST
> +M:	Ruidong Tian <tianruidond@linux.alibaba.com>
> +L:	linux-acpi@vger.kernel.org
> +L:	linux-arm-kernel@lists.infradead.org
> +S:	Supported
> +F:	arch/arm64/include/asm/ras.h
> +F:	drivers/acpi/arm64/aest.c
> +F:	drivers/ras/aest/
> +F:	include/linux/acpi_aest.h
> +
>  ACPI FOR RISC-V (ACPI/riscv)
>  M:	Sunil V L <sunilvl@ventanamicro.com>
>  L:	linux-acpi@vger.kernel.org
> diff --git a/arch/arm64/include/asm/ras.h b/arch/arm64/include/asm/ras.h
> new file mode 100644
> index 000000000000..7676add8a0ed
> --- /dev/null
> +++ b/arch/arm64/include/asm/ras.h
> @@ -0,0 +1,95 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __ASM_RAS_H
> +#define __ASM_RAS_H
> +
> +#include <linux/types.h>
> +#include <linux/bits.h>
> +
> +/* ERR<n>FR */
> +#define ERR_FR_CE                      GENMASK_ULL(54, 53)
> +#define ERR_FR_RP                      BIT(15)
> +#define ERR_FR_CEC                     GENMASK_ULL(14, 12)
> +
> +#define ERR_FR_RP_SINGLE_COUNTER       0
> +#define ERR_FR_RP_DOUBLE_COUNTER       1
> +
> +#define ERR_FR_CEC_0B_COUNTER          0
> +#define ERR_FR_CEC_8B_COUNTER          BIT(1)
> +#define ERR_FR_CEC_16B_COUNTER         BIT(2)
> +
> +/* ERR<n>STATUS */
> +#define ERR_STATUS_AV		BIT(31)
> +#define ERR_STATUS_V		BIT(30)
> +#define ERR_STATUS_UE		BIT(29)
> +#define ERR_STATUS_ER		BIT(28)
> +#define ERR_STATUS_OF		BIT(27)
> +#define ERR_STATUS_MV		BIT(26)
> +#define ERR_STATUS_CE		(BIT(25) | BIT(24))
> +#define ERR_STATUS_DE		BIT(23)
> +#define ERR_STATUS_PN		BIT(22)
> +#define ERR_STATUS_UET		(BIT(21) | BIT(20))
> +#define ERR_STATUS_CI		BIT(19)
> +#define ERR_STATUS_IERR		GENMASK_ULL(15, 8)
> +#define ERR_STATUS_SERR		GENMASK_ULL(7, 0)
> +
> +/* Theses bits are	 write-one-to-clear */
> +#define ERR_STATUS_W1TC		(ERR_STATUS_AV | ERR_STATUS_V | ERR_STATUS_UE |=
 \
> +				ERR_STATUS_ER | ERR_STATUS_OF | ERR_STATUS_MV | \
> +				ERR_STATUS_CE | ERR_STATUS_DE | ERR_STATUS_PN | \
> +				ERR_STATUS_UET | ERR_STATUS_CI)
> +
> +#define ERR_STATUS_UET_UC	0
> +#define ERR_STATUS_UET_UEU	1
> +#define ERR_STATUS_UET_UEO	2
> +#define ERR_STATUS_UET_UER	3
> +
> +/* ERR<n>CTLR */
> +#define ERR_CTLR_CFI		BIT(8)
> +#define ERR_CTLR_FI		BIT(3)
> +#define ERR_CTLR_UI		BIT(2)
> +
> +/* ERR<n>ADDR */
> +#define ERR_ADDR_AI		BIT(61)
> +#define ERR_ADDR_PADDR		GENMASK_ULL(55, 0)
> +
> +/* ERR<n>MISC0 */
> +
> +/* ERR<n>FR.CEC =3D=3D 0b010, ERR<n>FR.RP =3D=3D 0  */
> +#define ERR_MISC0_8B_OF		BIT(39)
> +#define ERR_MISC0_8B_CEC	GENMASK_ULL(38, 32)
> +
> +/* ERR<n>FR.CEC =3D=3D 0b100, ERR<n>FR.RP =3D=3D 0  */
> +#define ERR_MISC0_16B_OF	BIT(47)
> +#define ERR_MISC0_16B_CEC	GENMASK_ULL(46, 32)
> +
> +#define ERR_MISC0_CEC_SHIFT	31
> +
> +#define ERR_8B_CEC_MAX		(ERR_MISC0_8B_CEC >> ERR_MISC0_CEC_SHIFT)
> +#define ERR_16B_CEC_MAX		(ERR_MISC0_16B_CEC >> ERR_MISC0_CEC_SHIFT)
> +
> +/* ERR<n>FR.CEC =3D=3D 0b100, ERR<n>FR.RP =3D=3D 1  */
> +#define ERR_MISC0_16B_OFO	BIT(63)
> +#define ERR_MISC0_16B_CECO	GENMASK_ULL(62, 48)
> +#define ERR_MISC0_16B_OFR	BIT(47)
> +#define ERR_MISC0_16B_CECR	GENMASK_ULL(46, 32)
> +
> +/* ERRDEVARCH */
> +#define ERRDEVARCH_REV		GENMASK(19, 16)
> +
> +enum ras_ce_threshold {
> +	RAS_CE_THRESHOLD_0B,
> +	RAS_CE_THRESHOLD_8B,
> +	RAS_CE_THRESHOLD_16B,
> +	RAS_CE_THRESHOLD_32B,
> +	UNKNOWN,
> +};
> +
> +struct ras_ext_regs {
> +	u64 err_fr;
> +	u64 err_ctlr;
> +	u64 err_status;
> +	u64 err_addr;
> +	u64 err_misc[4];
> +};
> +
> +#endif	/* __ASM_RAS_H */
> diff --git a/drivers/acpi/arm64/Kconfig b/drivers/acpi/arm64/Kconfig
> index b3ed6212244c..c8eb6de95733 100644
> --- a/drivers/acpi/arm64/Kconfig
> +++ b/drivers/acpi/arm64/Kconfig
> @@ -21,3 +21,14 @@ config ACPI_AGDI
>=20
>  config ACPI_APMT
>  	bool
> +
> +config ACPI_AEST
> +	bool "ARM Error Source Table Support"
> +	depends on ARM64_RAS_EXTN
> +
> +	help
> +	  The Arm Error Source Table (AEST) provides details on ACPI
> +	  extensions that enable kernel-first handling of errors in a
> +	  system that supports the Armv8 RAS extensions.
> +
> +	  If set, the kernel will report and log hardware errors.
> diff --git a/drivers/acpi/arm64/Makefile b/drivers/acpi/arm64/Makefile
> index 05ecde9eaabe..8e240b281fd1 100644
> --- a/drivers/acpi/arm64/Makefile
> +++ b/drivers/acpi/arm64/Makefile
> @@ -6,5 +6,6 @@ obj-$(CONFIG_ACPI_GTDT) 	+=3D gtdt.o
>  obj-$(CONFIG_ACPI_IORT) 	+=3D iort.o
>  obj-$(CONFIG_ACPI_PROCESSOR_IDLE) +=3D cpuidle.o
>  obj-$(CONFIG_ARM_AMBA)		+=3D amba.o
> +obj-$(CONFIG_ACPI_AEST) 	+=3D aest.o
>  obj-y				+=3D dma.o init.o
>  obj-y				+=3D thermal_cpufreq.o
> diff --git a/drivers/acpi/arm64/aest.c b/drivers/acpi/arm64/aest.c
> new file mode 100644
> index 000000000000..6dba9c23e04e
> --- /dev/null
> +++ b/drivers/acpi/arm64/aest.c
> @@ -0,0 +1,335 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * ARM Error Source Table Support
> + *
> + * Copyright (c) 2024, Alibaba Group.
> + */
> +
> +#include <linux/xarray.h>
> +#include <linux/platform_device.h>
> +#include <linux/acpi_aest.h>
> +
> +#include "init.h"
> +
> +#undef pr_fmt
> +#define pr_fmt(fmt) "ACPI AEST: " fmt
> +
> +static struct xarray *aest_array;
> +
> +static void __init aest_init_interface(struct acpi_aest_hdr *hdr,
> +				       struct acpi_aest_node *node)
> +{
> +	struct acpi_aest_node_interface_header *interface;
> +
> +	interface =3D ACPI_ADD_PTR(struct acpi_aest_node_interface_header, hdr,
> +				 hdr->node_interface_offset);
> +
> +	node->type =3D hdr->type;
> +	node->interface_hdr =3D interface;
> +
> +	switch (interface->group_format) {
> +	case ACPI_AEST_NODE_GROUP_FORMAT_4K: {
> +		struct acpi_aest_node_interface_4k *interface_4k =3D
> +			(struct acpi_aest_node_interface_4k *)(interface + 1);
> +
> +		node->common =3D &interface_4k->common;
> +		node->record_implemented =3D
> +			(unsigned long *)&interface_4k->error_record_implemented;
> +		node->status_reporting =3D
> +			(unsigned long *)&interface_4k->error_status_reporting;
> +		node->addressing_mode =3D
> +			(unsigned long *)&interface_4k->addressing_mode;
> +		break;
> +	}
> +	case ACPI_AEST_NODE_GROUP_FORMAT_16K: {
> +		struct acpi_aest_node_interface_16k *interface_16k =3D
> +			(struct acpi_aest_node_interface_16k *)(interface + 1);
> +
> +		node->common =3D &interface_16k->common;
> +		node->record_implemented =3D
> +			(unsigned long *)interface_16k->error_record_implemented;
> +		node->status_reporting =3D
> +			(unsigned long *)interface_16k->error_status_reporting;
> +		node->addressing_mode =3D
> +			(unsigned long *)interface_16k->addressing_mode;
> +		break;
> +	}
> +	case ACPI_AEST_NODE_GROUP_FORMAT_64K: {
> +		struct acpi_aest_node_interface_64k *interface_64k =3D
> +			(struct acpi_aest_node_interface_64k *)(interface + 1);
> +
> +		node->common =3D &interface_64k->common;
> +		node->record_implemented =3D
> +			(unsigned long *)interface_64k->error_record_implemented;
> +		node->status_reporting =3D
> +			(unsigned long *)interface_64k->error_status_reporting;
> +		node->addressing_mode =3D
> +			(unsigned long *)interface_64k->addressing_mode;
> +		break;
> +	}
> +	default:
> +		pr_err("invalid group format: %d\n", interface->group_format);
> +	}
> +
> +	node->interrupt =3D ACPI_ADD_PTR(struct acpi_aest_node_interrupt_v2,
> +					hdr, hdr->node_interrupt_offset);
> +
> +	node->interrupt_count =3D hdr->node_interrupt_count;
> +}
> +
> +static int __init acpi_aest_init_node_common(struct acpi_aest_hdr *aest_=
hdr,
> +					struct acpi_aest_node *node)
> +{
> +	int ret;
> +	struct aest_hnode *hnode;
> +	u64 error_device_id;
> +
> +	aest_init_interface(aest_hdr, node);
> +
> +	error_device_id =3D node->common->error_node_device;

I think I see a problem with this.
From the spec[1], I understand that error node device is optional and
error node device field is only valid when error node device valid flag is =
set.

[1] https://developer.arm.com/documentation/den0085/latest/

Previous versions work well for the system without error node device (i.e. =
system=20
without ARMHE000 definition in DSDT) but this version doesn't.
Do we need to rely on information from error node device here when
a system has them? I thought AEST table has necessary information in all ca=
se and
want to know why this version use different approach from v2.

Also, I wonder if there will be a system that only some nodes have valid fl=
ag.

> +
> +	hnode =3D xa_load(aest_array, error_device_id);
> +	if (!hnode) {
> +		hnode =3D kmalloc(sizeof(*hnode), GFP_KERNEL);
> +		if (!hnode) {
> +			ret =3D -ENOMEM;
> +			goto free;
> +		}
> +		INIT_LIST_HEAD(&hnode->list);
> +		hnode->uid =3D error_device_id;
> +		hnode->count =3D 0;
> +		hnode->type =3D node->type;
> +		xa_store(aest_array, error_device_id, hnode, GFP_KERNEL);
> +	}
> +
> +	list_add_tail(&node->list, &hnode->list);
> +	hnode->count++;
> +
> +	return 0;
> +
> +free:
> +	kfree(node);
> +	return ret;
> +}
> +
> +static int __init
> +acpi_aest_init_node_default(struct acpi_aest_hdr *aest_hdr)
> +{
> +	struct acpi_aest_node *node;
> +
> +	node =3D kzalloc(sizeof(*node), GFP_KERNEL);
> +	if (!node)
> +		return -ENOMEM;
> +
> +	node->spec_pointer =3D ACPI_ADD_PTR(void, aest_hdr,
> +					aest_hdr->node_specific_offset);
> +
> +	return acpi_aest_init_node_common(aest_hdr, node);
> +}
> +
> +static int __init
> +acpi_aest_init_processor_node(struct acpi_aest_hdr *aest_hdr)
> +{
> +	struct acpi_aest_node *node;
> +
> +	node =3D kzalloc(sizeof(*node), GFP_KERNEL);
> +	if (!node)
> +		return -ENOMEM;
> +
> +	node->spec_pointer =3D ACPI_ADD_PTR(void, aest_hdr,
> +					aest_hdr->node_specific_offset);
> +
> +	node->processor_spec_pointer =3D ACPI_ADD_PTR(void, node->spec_pointer,
> +					sizeof(struct acpi_aest_processor));
> +
> +	return acpi_aest_init_node_common(aest_hdr, node);
> +}
> +
> +static int __init acpi_aest_init_node(struct acpi_aest_hdr *header)
> +{
> +	switch (header->type) {
> +	case ACPI_AEST_PROCESSOR_ERROR_NODE:
> +		return acpi_aest_init_processor_node(header);
> +	case ACPI_AEST_VENDOR_ERROR_NODE:
> +	case ACPI_AEST_SMMU_ERROR_NODE:
> +	case ACPI_AEST_GIC_ERROR_NODE:
> +	case ACPI_AEST_PCIE_ERROR_NODE:
> +	case ACPI_AEST_PROXY_ERROR_NODE:
> +	case ACPI_AEST_MEMORY_ERROR_NODE:
> +		return acpi_aest_init_node_default(header);
> +	default:
> +		pr_err("acpi table header type is invalid: %d\n", header->type);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int __init acpi_aest_init_nodes(struct acpi_table_header *aest_ta=
ble)
> +{
> +	struct acpi_aest_hdr *aest_node, *aest_end;
> +	struct acpi_table_aest *aest;
> +	int rc;
> +
> +	aest =3D (struct acpi_table_aest *)aest_table;
> +	aest_node =3D ACPI_ADD_PTR(struct acpi_aest_hdr, aest,
> +				 sizeof(struct acpi_table_header));
> +	aest_end =3D ACPI_ADD_PTR(struct acpi_aest_hdr, aest,
> +				aest_table->length);
> +
> +	while (aest_node < aest_end) {
> +		if (((u64)aest_node + aest_node->length) > (u64)aest_end) {
> +			pr_warn(FW_WARN "AEST node pointer overflow, bad table.\n");
> +			return -EINVAL;
> +		}
> +
> +		rc =3D acpi_aest_init_node(aest_node);
> +		if (rc)
> +			return rc;
> +
> +		aest_node =3D ACPI_ADD_PTR(struct acpi_aest_hdr, aest_node,
> +					 aest_node->length);
> +	}
> +
> +	return 0;
> +}
> +
> +static int
> +acpi_aest_parse_irqs(struct platform_device *pdev, struct acpi_aest_node=
 *anode,
> +				struct resource *res, int *res_idx, int irqs[2])
> +{
> +	int i;
> +	struct acpi_aest_node_interrupt_v2 *interrupt;
> +	int trigger, irq;
> +
> +	for (i =3D 0; i < anode->interrupt_count; i++) {
> +		interrupt =3D &anode->interrupt[i];
> +		if (irqs[interrupt->type])
> +			continue;
> +
> +		trigger =3D (interrupt->flags & AEST_INTERRUPT_MODE) ?
> +			ACPI_LEVEL_SENSITIVE : ACPI_EDGE_SENSITIVE;
> +
> +		irq =3D acpi_register_gsi(&pdev->dev, interrupt->gsiv, trigger,
> +						ACPI_ACTIVE_HIGH);
> +		if (irq <=3D 0) {
> +			pr_err("failed to map AEST GSI %d\n", interrupt->gsiv);
> +			return irq;
> +		}
> +
> +		res[*res_idx].start =3D irq;
> +		res[*res_idx].end =3D irq;
> +		res[*res_idx].flags =3D IORESOURCE_IRQ;
> +		res[*res_idx].name =3D interrupt->type ? "eri" : "fhi";
> +
> +		(*res_idx)++;
> +
> +		irqs[interrupt->type] =3D irq;
> +	}
> +
> +	return 0;
> +}
> +
> +static int __init acpi_aest_alloc_pdev(void)
> +{
> +	int ret, j, size;
> +	struct aest_hnode *ahnode =3D NULL;
> +	unsigned long i;
> +	struct platform_device *pdev;
> +	struct acpi_device *companion;
> +	struct acpi_aest_node *anode;
> +	char uid[16];
> +	struct resource *res;
> +
> +	xa_for_each(aest_array, i, ahnode) {
> +		int irq[2] =3D { 0 };
> +
> +		res =3D kcalloc(ahnode->count + 2, sizeof(*res), GFP_KERNEL);

Why is +2 needed?

> +		if (!res) {
> +			ret =3D -ENOMEM;
> +			break;
> +		}
> +
> +		pdev =3D platform_device_alloc("AEST", i);
> +		if (IS_ERR(pdev)) {
> +			ret =3D PTR_ERR(pdev);
> +			break;
> +		}
> +
> +		ret =3D snprintf(uid, sizeof(uid), "%u", (u32)i);
> +		companion =3D acpi_dev_get_first_match_dev("ARMHE000", uid, -1);
> +		if (companion)
> +			ACPI_COMPANION_SET(&pdev->dev, companion);
> +
> +		j =3D 0;
> +		list_for_each_entry(anode, &ahnode->list, list) {
> +			if (anode->interface_hdr->type !=3D
> +					ACPI_AEST_NODE_SYSTEM_REGISTER) {
> +				res[j].name =3D "AEST:RECORD";
> +				res[j].start =3D anode->interface_hdr->address;
> +				size =3D anode->interface_hdr->error_record_count *
> +						sizeof(struct ras_ext_regs);
> +				res[j].end =3D res[j].start + size;
> +				res[j].flags =3D IORESOURCE_MEM;

Will these fields be overwritten in below acpi_aest_parse_irqs()?

> +			}
> +
> +			ret =3D acpi_aest_parse_irqs(pdev, anode, res, &j, irq);
> +			if (ret) {
> +				platform_device_put(pdev);
> +				break;
> +			}
> +		}
> +
> +		ret =3D platform_device_add_resources(pdev, res, j);
> +		if (ret)
> +			break;
> +
> +		ret =3D platform_device_add_data(pdev, &ahnode, sizeof(ahnode));
> +		if (ret)
> +			break;
> +
> +		ret =3D platform_device_add(pdev);
> +		if (ret)
> +			break;
> +	}
> +
> +	kfree(res);
> +	if (ret)
> +		platform_device_put(pdev);
> +
> +	return ret;
> +}
> +
> +void __init acpi_aest_init(void)
> +{
> +	acpi_status status;
> +	int ret;
> +	struct acpi_table_header *aest_table;
> +
> +	status =3D acpi_get_table(ACPI_SIG_AEST, 0, &aest_table);
> +	if (ACPI_FAILURE(status)) {
> +		if (status !=3D AE_NOT_FOUND) {
> +			const char *msg =3D acpi_format_exception(status);
> +
> +			pr_err("Failed to get table, %s\n", msg);
> +		}
> +
> +		return;
> +	}
> +
> +	aest_array =3D kzalloc(sizeof(struct xarray), GFP_KERNEL);
> +	xa_init(aest_array);
> +
> +	ret =3D acpi_aest_init_nodes(aest_table);
> +	if (ret) {
> +		pr_err("Failed init aest node %d\n", ret);
> +		goto out;
> +	}
> +
> +	ret =3D acpi_aest_alloc_pdev();
> +	if (ret)
> +		pr_err("Failed alloc pdev %d\n", ret);
> +
> +out:
> +	acpi_put_table(aest_table);
> +}
> diff --git a/drivers/acpi/arm64/init.c b/drivers/acpi/arm64/init.c
> index 7a47d8095a7d..b0c768923831 100644
> --- a/drivers/acpi/arm64/init.c
> +++ b/drivers/acpi/arm64/init.c
> @@ -12,4 +12,6 @@ void __init acpi_arch_init(void)
>  		acpi_iort_init();
>  	if (IS_ENABLED(CONFIG_ARM_AMBA))
>  		acpi_amba_init();
> +	if (IS_ENABLED(CONFIG_ACPI_AEST))
> +		acpi_aest_init();
>  }
> diff --git a/drivers/acpi/arm64/init.h b/drivers/acpi/arm64/init.h
> index dcc277977194..3902d1676068 100644
> --- a/drivers/acpi/arm64/init.h
> +++ b/drivers/acpi/arm64/init.h
> @@ -5,3 +5,4 @@ void __init acpi_agdi_init(void);
>  void __init acpi_apmt_init(void);
>  void __init acpi_iort_init(void);
>  void __init acpi_amba_init(void);
> +void __init acpi_aest_init(void);
> diff --git a/drivers/ras/Kconfig b/drivers/ras/Kconfig
> index fc4f4bb94a4c..61a2a05d9c94 100644
> --- a/drivers/ras/Kconfig
> +++ b/drivers/ras/Kconfig
> @@ -33,6 +33,7 @@ if RAS
>=20
>  source "arch/x86/ras/Kconfig"
>  source "drivers/ras/amd/atl/Kconfig"
> +source "drivers/ras/aest/Kconfig"
>=20
>  config RAS_FMPM
>  	tristate "FRU Memory Poison Manager"
> diff --git a/drivers/ras/Makefile b/drivers/ras/Makefile
> index 11f95d59d397..72411ee9deaf 100644
> --- a/drivers/ras/Makefile
> +++ b/drivers/ras/Makefile
> @@ -5,3 +5,4 @@ obj-$(CONFIG_RAS_CEC)	+=3D cec.o
>=20
>  obj-$(CONFIG_RAS_FMPM)	+=3D amd/fmpm.o
>  obj-y			+=3D amd/atl/
> +obj-y 			+=3D aest/
> diff --git a/drivers/ras/aest/Kconfig b/drivers/ras/aest/Kconfig
> new file mode 100644
> index 000000000000..6d436d911bea
> --- /dev/null
> +++ b/drivers/ras/aest/Kconfig
> @@ -0,0 +1,17 @@
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# ARM Error Source Table Support
> +#
> +# Copyright (c) 2024, Alibaba Group.
> +#
> +
> +config AEST
> +	tristate "ARM AEST Driver"
> +	depends on ACPI_AEST && RAS
> +
> +	help
> +	  The Arm Error Source Table (AEST) provides details on ACPI
> +	  extensions that enable kernel-first handling of errors in a
> +	  system that supports the Armv8 RAS extensions.
> +
> +	  If set, the kernel will report and log hardware errors.
> diff --git a/drivers/ras/aest/Makefile b/drivers/ras/aest/Makefile
> new file mode 100644
> index 000000000000..a6ba7e36fb43
> --- /dev/null
> +++ b/drivers/ras/aest/Makefile
> @@ -0,0 +1,5 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +
> +obj-$(CONFIG_AEST) 	+=3D aest.o
> +
> +aest-y		:=3D aest-core.o
> diff --git a/drivers/ras/aest/aest-core.c b/drivers/ras/aest/aest-core.c
> new file mode 100644
> index 000000000000..060a1eedee0a
> --- /dev/null
> +++ b/drivers/ras/aest/aest-core.c
> @@ -0,0 +1,976 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * ARM Error Source Table Support
> + *
> + * Copyright (c) 2021-2024, Alibaba Group.
> + */
> +
> +#include <linux/interrupt.h>
> +#include <linux/panic.h>
> +#include <linux/platform_device.h>
> +#include <linux/xarray.h>
> +#include <linux/cpuhotplug.h>
> +#include <linux/genalloc.h>
> +#include <linux/ras.h>
> +
> +#include "aest.h"
> +
> +DEFINE_PER_CPU(struct aest_device, percpu_adev);
> +
> +#undef pr_fmt
> +#define pr_fmt(fmt) "AEST: " fmt
> +
> +/*
> + * This memory pool is only to be used to save AEST node in AEST irq con=
text.
> + * There can be 500 AEST node at most.
> + */
> +#define AEST_NODE_ALLOCED_MAX	500
> +
> +#define AEST_LOG_PREFIX_BUFFER	64
> +
> +BLOCKING_NOTIFIER_HEAD(aest_decoder_chain);
> +
> +static void aest_print(struct aest_event *event)
> +{
> +	static atomic_t seqno =3D { 0 };
> +	unsigned int curr_seqno;
> +	char pfx_seq[AEST_LOG_PREFIX_BUFFER];
> +	int index;
> +	struct ras_ext_regs *regs;
> +
> +	curr_seqno =3D atomic_inc_return(&seqno);
> +	snprintf(pfx_seq, sizeof(pfx_seq), "{%u}" HW_ERR, curr_seqno);
> +	pr_info("%sHardware error from AEST %s\n", pfx_seq, event->node_name);
> +
> +	switch (event->type) {
> +	case ACPI_AEST_PROCESSOR_ERROR_NODE:
> +		pr_err("%s Error from CPU%d\n", pfx_seq, event->id0);
> +		break;
> +	case ACPI_AEST_MEMORY_ERROR_NODE:
> +		pr_err("%s Error from memory at SRAT proximity domain %#x\n",
> +			pfx_seq, event->id0);
> +		break;
> +	case ACPI_AEST_SMMU_ERROR_NODE:
> +		pr_err("%s Error from SMMU IORT node %#x subcomponent %#x\n",
> +			pfx_seq, event->id0, event->id1);
> +		break;
> +	case ACPI_AEST_VENDOR_ERROR_NODE:
> +		pr_err("%s Error from vendor hid %8.8s uid %#x\n",
> +			pfx_seq, event->hid, event->id1);
> +		break;
> +	case ACPI_AEST_GIC_ERROR_NODE:
> +		pr_err("%s Error from GIC type %#x instance %#x\n",
> +			pfx_seq, event->id0, event->id1);
> +		break;
> +	default:
> +		pr_err("%s Unknown AEST node type\n", pfx_seq);
> +		return;
> +	}
> +
> +	index =3D event->index;
> +	regs =3D &event->regs;
> +
> +	pr_err("%s  ERR%dFR: 0x%llx\n", pfx_seq, index, regs->err_fr);
> +	pr_err("%s  ERR%dCTRL: 0x%llx\n", pfx_seq, index, regs->err_ctlr);
> +	pr_err("%s  ERR%dSTATUS: 0x%llx\n", pfx_seq, index, regs->err_status);
> +	if (regs->err_status & ERR_STATUS_AV)
> +		pr_err("%s  ERR%dADDR: 0x%llx\n", pfx_seq, index,
> +						regs->err_addr);
> +
> +	if (regs->err_status & ERR_STATUS_MV) {
> +		pr_err("%s  ERR%dMISC0: 0x%llx\n", pfx_seq, index,
> +						regs->err_misc[0]);
> +		pr_err("%s  ERR%dMISC1: 0x%llx\n", pfx_seq, index,
> +						regs->err_misc[1]);
> +		pr_err("%s  ERR%dMISC2: 0x%llx\n", pfx_seq, index,
> +						regs->err_misc[2]);
> +		pr_err("%s  ERR%dMISC3: 0x%llx\n", pfx_seq, index,
> +						regs->err_misc[3]);
> +	}
> +}
> +
> +static void aest_handle_memory_failure(u64 addr)
> +{
> +	unsigned long pfn;
> +
> +	pfn =3D PHYS_PFN(addr);
> +
> +	if (!pfn_valid(pfn)) {
> +		pr_warn(HW_ERR "Invalid physical address: %#llx\n", addr);
> +		return;
> +	}
> +
> +#ifdef CONFIG_MEMORY_FAILURE
> +	memory_failure(pfn, 0);
> +#endif
> +}
> +
> +static void init_aest_event(struct aest_event *event, struct aest_record=
 *record,
> +					struct ras_ext_regs *regs)
> +{
> +	struct aest_node *node =3D record->node;
> +	struct acpi_aest_node *info =3D node->info;
> +
> +	event->type =3D node->type;
> +	event->node_name =3D node->name;
> +	switch (node->type) {
> +	case ACPI_AEST_PROCESSOR_ERROR_NODE:
> +		if (info->processor->flags & (ACPI_AEST_PROC_FLAG_SHARED |
> +						ACPI_AEST_PROC_FLAG_GLOBAL))
> +			event->id0 =3D smp_processor_id();

In "else" case, acpi processor id will be set for id0. So, how about use
get_acpi_id_for_cpu(smp_processor_id()) here for consistency?

> +		else
> +			event->id0 =3D info->processor->processor_id;
> +
> +		event->id1 =3D info->processor->resource_type;
> +		break;
> +	case ACPI_AEST_MEMORY_ERROR_NODE:
> +		event->id0 =3D info->memory->srat_proximity_domain;
> +		break;
> +	case ACPI_AEST_SMMU_ERROR_NODE:
> +		event->id0 =3D info->smmu->iort_node_reference;
> +		event->id1 =3D info->smmu->subcomponent_reference;
> +		break;
> +	case ACPI_AEST_VENDOR_ERROR_NODE:
> +		event->id0 =3D 0;
> +		event->id1 =3D info->vendor->acpi_uid;
> +		event->hid =3D info->vendor->acpi_hid;
> +		break;
> +	case ACPI_AEST_GIC_ERROR_NODE:
> +		event->id0 =3D info->gic->interface_type;
> +		event->id1 =3D info->gic->instance_id;
> +		break;
> +	default:
> +		event->id0 =3D 0;
> +		event->id1 =3D 0;
> +	}
> +
> +	memcpy(&event->regs, regs, sizeof(*regs));
> +	event->index =3D record->index;
> +	event->addressing_mode =3D record->addressing_mode;
> +}
> +
> +static int
> +aest_node_gen_pool_add(struct aest_device *adev, struct aest_record *rec=
ord,
> +					struct ras_ext_regs *regs)
> +{
> +	struct aest_event *event;
> +
> +	if (!adev->pool)
> +		return -EINVAL;
> +
> +	event =3D (void *)gen_pool_alloc(adev->pool, sizeof(*event));
> +	if (!event)
> +		return -ENOMEM;
> +
> +	init_aest_event(event, record, regs);
> +	llist_add(&event->llnode, &adev->event_list);
> +
> +	return 0;
> +}
> +
> +static void aest_log(struct aest_record *record, struct ras_ext_regs *re=
gs)
> +{
> +	struct aest_device *adev =3D record->node->adev;
> +
> +	if (!aest_node_gen_pool_add(adev, record, regs))
> +		schedule_work(&adev->aest_work);
> +}
> +
> +void aest_register_decode_chain(struct notifier_block *nb)
> +{
> +	blocking_notifier_chain_register(&aest_decoder_chain, nb);
> +}
> +EXPORT_SYMBOL_GPL(aest_register_decode_chain);
> +
> +void aest_unregister_decode_chain(struct notifier_block *nb)
> +{
> +	blocking_notifier_chain_unregister(&aest_decoder_chain, nb);
> +}
> +EXPORT_SYMBOL_GPL(aest_unregister_decode_chain);
> +
> +static void aest_node_pool_process(struct work_struct *work)
> +{
> +	struct llist_node *head;
> +	struct aest_event *event;
> +	struct aest_device *adev =3D container_of(work, struct aest_device,
> +							aest_work);
> +	u64 status, addr;
> +
> +	head =3D llist_del_all(&adev->event_list);
> +	if (!head)
> +		return;
> +
> +	head =3D llist_reverse_order(head);
> +	llist_for_each_entry(event, head, llnode) {
> +		aest_print(event);
> +
> +		/* TODO: translate Logical Addresses to System Physical Addresses */
> +		if (event->addressing_mode =3D=3D AEST_ADDREESS_LA ||
> +			(event->regs.err_addr & ERR_ADDR_AI)) {
> +			pr_notice("Can not translate LA to SPA\n");
> +			addr =3D 0;
> +		} else
> +			addr =3D event->regs.err_addr & (1UL << CONFIG_ARM64_PA_BITS);
> +
> +		status =3D event->regs.err_status;
> +		if (addr && ((status & ERR_STATUS_UE) || (status & ERR_STATUS_DE)))
> +			aest_handle_memory_failure(addr);
> +
> +		blocking_notifier_call_chain(&aest_decoder_chain, 0, event);
> +		gen_pool_free(adev->pool, (unsigned long)event,
> +				sizeof(*event));
> +	}
> +}
> +
> +static int aest_node_pool_init(struct aest_device *adev)
> +{
> +	unsigned long addr, size;
> +
> +	size =3D ilog2(sizeof(struct aest_event));
> +	adev->pool =3D devm_gen_pool_create(adev->dev, size, -1,
> +						dev_name(adev->dev));
> +	if (!adev->pool)
> +		return -ENOMEM;
> +
> +	size =3D PAGE_ALIGN(size * AEST_NODE_ALLOCED_MAX);
> +	addr =3D (unsigned long)devm_kzalloc(adev->dev, size, GFP_KERNEL);
> +	if (!addr)
> +		return -ENOMEM;
> +
> +	return gen_pool_add(adev->pool, addr, size, -1);
> +
> +	return 0;
> +}
> +
> +static void aest_panic(struct aest_record *record, struct ras_ext_regs *=
regs, char *msg)
> +{
> +	struct aest_event event =3D { 0 };
> +
> +	init_aest_event(&event, record, regs);
> +
> +	aest_print(&event);
> +
> +	panic(msg);
> +}
> +
> +static void aest_proc_record(struct aest_record *record, void *data)
> +{
> +	struct ras_ext_regs regs =3D {0};
> +	int *count =3D data;
> +
> +	regs.err_status =3D record_read(record, ERXSTATUS);
> +	if (!(regs.err_status & ERR_STATUS_V))
> +		return;
> +
> +	(*count)++;
> +
> +	if (regs.err_status & ERR_STATUS_AV)
> +		regs.err_addr =3D record_read(record, ERXADDR);
> +
> +	regs.err_fr =3D record->fr;
> +	regs.err_ctlr =3D record_read(record, ERXCTLR);
> +
> +	if (regs.err_status & ERR_STATUS_MV) {
> +		regs.err_misc[0] =3D record_read(record, ERXMISC0);
> +		regs.err_misc[1] =3D record_read(record, ERXMISC1);
> +		if (record->node->version >=3D ID_AA64PFR0_EL1_RAS_V1P1) {
> +			regs.err_misc[2] =3D record_read(record, ERXMISC2);
> +			regs.err_misc[3] =3D record_read(record, ERXMISC3);
> +		}
> +
> +		if (record->node->info->interface_hdr->flags &
> +			AEST_XFACE_FLAG_CLEAR_MISC) {
> +			record_write(record, ERXMISC0, 0);
> +			record_write(record, ERXMISC1, 0);
> +			if (record->node->version >=3D ID_AA64PFR0_EL1_RAS_V1P1) {
> +				record_write(record, ERXMISC2, 0);
> +				record_write(record, ERXMISC3, 0);
> +			}
> +		/* ce count is 0 if record do not support ce */
> +		} else if (record->ce.count > 0)
> +			record_write(record, ERXMISC0, record->ce.reg_val);
> +	}
> +
> +	/* panic if unrecoverable and uncontainable error encountered */
> +	if ((regs.err_status & ERR_STATUS_UE) &&
> +		(regs.err_status & ERR_STATUS_UET) > ERR_STATUS_UET_UEU)
> +		aest_panic(record, &regs, "AEST: unrecoverable error encountered");

I think we need to use FIELD_GET to get correct value.
	u64 ue =3D FIELD_GET(ERR_STATUS_UET, regs.err_status);
	if ((regs.err_status & ERR_STATUS_UE) &&
 		(ue =3D=3D ERR_STATUS_UET_UC || ue =3D=3D ERR_STATUS_UET_UEU))

> +
> +	aest_log(record, &regs);
> +
> +	/* Write-one-to-clear the bits we've seen */
> +	regs.err_status &=3D ERR_STATUS_W1TC;
> +
> +	/* Multi bit filed need to write all-ones to clear. */
> +	if (regs.err_status & ERR_STATUS_CE)
> +		regs.err_status |=3D ERR_STATUS_CE;
> +
> +	/* Multi bit filed need to write all-ones to clear. */
> +	if (regs.err_status & ERR_STATUS_UET)
> +		regs.err_status |=3D ERR_STATUS_UET;
> +
> +	record_write(record, ERXSTATUS, regs.err_status);
> +}
> +
> +static void
> +aest_node_foreach_record(void (*func)(struct aest_record *, void *),
> +				struct aest_node *node, void *data,
> +				unsigned long *bitmap)
> +{
> +	int i;
> +
> +	for_each_clear_bit(i, bitmap, node->record_count) {
> +		aest_select_record(node, i);
> +
> +		func(&node->records[i], data);
> +
> +		aest_sync(node);
> +	}
> +}
> +
> +static int aest_proc(struct aest_node *node)
> +{
> +	int count =3D 0, i, j, size =3D node->record_count;
> +	u64 err_group =3D 0;
> +
> +	aest_node_dbg(node, "Poll bit %*pb\n", size, node->record_implemented);
> +	aest_node_foreach_record(aest_proc_record, node, &count,
> +						node->record_implemented);
> +
> +	if (!node->errgsr)
> +		return count;
> +
> +	aest_node_dbg(node, "Report bit %*pb\n", size, node->status_reporting);
> +	for (i =3D 0; i < BITS_TO_U64(size); i++) {
> +		err_group =3D readq_relaxed((void *)node->errgsr + i * 8);
> +		aest_node_dbg(node, "errgsr[%d]: 0x%llx\n", i, err_group);
> +
> +		for_each_set_bit(j, (unsigned long *)&err_group,
> +						BITS_PER_TYPE(u64)) {
> +			/*
> +			 * Error group base is only valid in Memory Map node,
> +			 * so driver do not need to write select register and
> +			 * sync.
> +			 */
> +			if (test_bit(i * BITS_PER_TYPE(u64) + j, node->status_reporting))
> +				continue;
> +			aest_proc_record(&node->records[j], &count);
> +		}
> +	}
> +
> +	return count;
> +}
> +
> +static irqreturn_t aest_irq_func(int irq, void *input)
> +{
> +	struct aest_device *adev =3D input;
> +	int i;
> +
> +	for (i =3D 0; i < adev->node_cnt; i++)
> +		aest_proc(&adev->nodes[i]);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static void aest_enable_irq(struct aest_record *record)
> +{
> +	u64 err_ctlr;
> +	struct aest_device *adev =3D record->node->adev;
> +
> +	err_ctlr =3D record_read(record, ERXCTLR);
> +
> +	if (adev->irq[ACPI_AEST_NODE_FAULT_HANDLING])
> +		err_ctlr |=3D (ERR_CTLR_FI | ERR_CTLR_CFI);
> +	if (adev->irq[ACPI_AEST_NODE_ERROR_RECOVERY])
> +		err_ctlr |=3D ERR_CTLR_UI;
> +
> +	record_write(record, ERXCTLR, err_ctlr);
> +}
> +
> +static void aest_config_irq(struct aest_node *node)
> +{
> +	int i;
> +	struct acpi_aest_node_interrupt_v2 *interrupt;
> +
> +	if (!node->irq_config)
> +		return;
> +
> +	for (i =3D 0; i < node->info->interrupt_count; i++) {
> +		interrupt =3D &node->info->interrupt[i];
> +
> +		if (interrupt->type =3D=3D ACPI_AEST_NODE_FAULT_HANDLING)
> +			writeq_relaxed(interrupt->gsiv, node->irq_config);
> +
> +		if (interrupt->type =3D=3D ACPI_AEST_NODE_ERROR_RECOVERY)
> +			writeq_relaxed(interrupt->gsiv, node->irq_config + 8);
> +
> +		aest_node_dbg(node, "config irq type %d gsiv %d at %llx",
> +				interrupt->type, interrupt->gsiv,
> +				(u64)node->irq_config);
> +	}
> +}
> +
> +static enum ras_ce_threshold aest_get_ce_threshold(struct aest_record *r=
ecord)
> +{
> +	u64 err_fr, err_fr_cec, err_fr_rp =3D -1;
> +
> +	err_fr =3D record->fr;
> +	err_fr_cec =3D FIELD_GET(ERR_FR_CEC, err_fr);
> +	err_fr_rp =3D FIELD_GET(ERR_FR_RP, err_fr);
> +
> +	if (err_fr_cec =3D=3D ERR_FR_CEC_0B_COUNTER)
> +		return RAS_CE_THRESHOLD_0B;
> +	else if (err_fr_rp =3D=3D ERR_FR_RP_DOUBLE_COUNTER)
> +		return RAS_CE_THRESHOLD_32B;
> +	else if (err_fr_cec =3D=3D ERR_FR_CEC_8B_COUNTER)
> +		return RAS_CE_THRESHOLD_8B;
> +	else if (err_fr_cec =3D=3D ERR_FR_CEC_16B_COUNTER)
> +		return RAS_CE_THRESHOLD_16B;
> +	else
> +		return UNKNOWN;
> +
> +}
> +
> +static const struct ce_threshold_info ce_info[] =3D {
> +	[RAS_CE_THRESHOLD_0B] =3D { 0 },
> +	[RAS_CE_THRESHOLD_8B] =3D {
> +		.max_count =3D ERR_8B_CEC_MAX,
> +		.mask =3D ERR_MISC0_8B_CEC,
> +		.shift =3D ERR_MISC0_CEC_SHIFT,
> +	},
> +	[RAS_CE_THRESHOLD_16B] =3D {
> +		.max_count =3D ERR_16B_CEC_MAX,
> +		.mask =3D ERR_MISC0_16B_CEC,
> +		.shift =3D ERR_MISC0_CEC_SHIFT,
> +	},
> +	//TODO: Support 32B CEC threshold.
> +	[RAS_CE_THRESHOLD_32B] =3D { 0 },
> +};
> +
> +static void aest_set_ce_threshold(struct aest_record *record)
> +{
> +	u64 err_misc0, ce_count;
> +	struct ce_threshold *ce =3D &record->ce;
> +	const struct ce_threshold_info *info;
> +
> +	record->threshold_type  =3D aest_get_ce_threshold(record);
> +
> +	switch (record->threshold_type) {
> +	case RAS_CE_THRESHOLD_0B:
> +		aest_record_dbg(record, "do not support CE threshold!\n");
> +		return;
> +	case RAS_CE_THRESHOLD_8B:
> +		aest_record_dbg(record, "support 8 bit CE threshold!\n");
> +		break;
> +	case RAS_CE_THRESHOLD_16B:
> +		aest_record_dbg(record, "support 16 bit CE threshold!\n");
> +		break;
> +	case RAS_CE_THRESHOLD_32B:
> +		aest_record_dbg(record, "not support 32 bit CE threshold!\n");
> +		break;
> +	default:
> +		aest_record_dbg(record, "Unknown misc0 ce threshold!\n");
> +	}
> +
> +	err_misc0 =3D record_read(record, ERXMISC0);
> +	info =3D &ce_info[record->threshold_type];
> +	ce->info =3D info;
> +	ce_count =3D (err_misc0 & info->mask) >> info->shift;
> +	if (ce_count) {
> +		ce->count =3D ce_count;
> +		ce->threshold =3D info->max_count - ce_count + 1;
> +		ce->reg_val =3D err_misc0;
> +		aest_record_dbg(record, "CE threshold is %llx, controlled by FW",
> +							ce->threshold);
> +		return;
> +	}
> +
> +	// Default CE threshold is 1.
> +	ce->count =3D info->max_count;
> +	ce->threshold =3D DEFAULT_CE_THRESHOLD;
> +	ce->reg_val =3D err_misc0 | info->mask;
> +
> +	record_write(record, ERXMISC0, ce->reg_val);
> +	aest_record_dbg(record, "CE threshold is %llx, controlled by Kernel",
> +							ce->threshold);
> +}
> +
> +static int aest_register_irq(struct aest_device *adev)
> +{
> +	int i, irq, ret;
> +	char *irq_desc;
> +
> +	irq_desc =3D devm_kasprintf(adev->dev, GFP_KERNEL, "%s.%s.",
> +				  dev_driver_string(adev->dev),
> +				  dev_name(adev->dev));
> +	if (!irq_desc)
> +		return -ENOMEM;
> +
> +	for (i =3D 0; i < MAX_GSI_PER_NODE; i++) {
> +		irq =3D adev->irq[i];
> +
> +		if (!irq)
> +			continue;
> +
> +		if (irq_is_percpu_devid(irq)) {
> +			ret =3D request_percpu_irq(irq, aest_irq_func,
> +							irq_desc,
> +							adev->adev_oncore);
> +			if (ret)
> +				goto free;
> +		} else {
> +			ret =3D devm_request_irq(adev->dev, irq, aest_irq_func,
> +					0, irq_desc, adev);
> +			if (ret)
> +				return ret;
> +		}
> +	}
> +	return 0;
> +
> +free:
> +	for (; i >=3D 0; i--) {
> +		irq =3D adev->irq[i];
> +
> +		if (irq_is_percpu_devid(irq))
> +			free_percpu_irq(irq, adev->adev_oncore);
> +	}
> +
> +	return ret;
> +}
> +
> +static int
> +aest_init_record(struct aest_record *record, int i, struct aest_node *no=
de)
> +{
> +	struct device *dev =3D node->adev->dev;
> +
> +	record->name =3D devm_kasprintf(dev, GFP_KERNEL, "record%d", i);
> +	if (!record->name)
> +		return -ENOMEM;
> +
> +	if (node->base)
> +		record->regs_base =3D node->base + sizeof(struct ras_ext_regs) * i;
> +
> +	record->access =3D &aest_access[node->info->interface_hdr->type];
> +	record->addressing_mode =3D test_bit(i, node->info->addressing_mode);
> +	record->index =3D i;
> +	record->node =3D node;
> +	record->fr =3D record_read(record, ERXFR);
> +
> +	return 0;
> +}
> +
> +static void aest_online_record(struct aest_record *record, void *data)
> +{
> +	if (record->fr & ERR_FR_CE)
> +		aest_set_ce_threshold(record);
> +
> +	aest_enable_irq(record);
> +}
> +
> +static void aest_online_oncore_node(struct aest_node *node)
> +{
> +	int count;
> +
> +	count =3D aest_proc(node);
> +	aest_node_dbg(node, "Find %d error on CPU%d before AEST probe\n",
> +						count, smp_processor_id());
> +
> +	aest_node_foreach_record(aest_online_record, node, NULL,
> +						node->record_implemented);
> +
> +	aest_node_foreach_record(aest_online_record, node, NULL,
> +						node->status_reporting);
> +}
> +
> +static void aest_online_oncore_dev(void *data)
> +{
> +	int fhi_irq, eri_irq, i;
> +	struct aest_device *adev =3D this_cpu_ptr(data);
> +
> +	for (i =3D 0; i < adev->node_cnt; i++)
> +		aest_online_oncore_node(&adev->nodes[i]);
> +
> +	fhi_irq =3D adev->irq[ACPI_AEST_NODE_FAULT_HANDLING];
> +	if (fhi_irq > 0)
> +		enable_percpu_irq(fhi_irq, IRQ_TYPE_NONE);
> +	eri_irq =3D adev->irq[ACPI_AEST_NODE_ERROR_RECOVERY];
> +	if (eri_irq > 0)
> +		enable_percpu_irq(eri_irq, IRQ_TYPE_NONE);
> +}
> +
> +static void aest_offline_oncore_dev(void *data)
> +{
> +	int fhi_irq, eri_irq;
> +	struct aest_device *adev =3D this_cpu_ptr(data);
> +
> +	fhi_irq =3D adev->irq[ACPI_AEST_NODE_FAULT_HANDLING];
> +	if (fhi_irq > 0)
> +		disable_percpu_irq(fhi_irq);
> +	eri_irq =3D adev->irq[ACPI_AEST_NODE_ERROR_RECOVERY];
> +	if (eri_irq > 0)
> +		disable_percpu_irq(eri_irq);
> +}
> +
> +static void aest_online_dev(struct aest_device *adev)
> +{
> +	int count, i;
> +	struct aest_node *node;
> +
> +	for (i =3D 0; i < adev->node_cnt; i++) {
> +		node =3D &adev->nodes[i];
> +
> +		if (!node->name)
> +			continue;
> +
> +		count =3D aest_proc(node);
> +		aest_node_dbg(node, "Find %d error before AEST probe\n", count);
> +
> +		aest_config_irq(node);
> +
> +		aest_node_foreach_record(aest_online_record, node, NULL,
> +						node->record_implemented);
> +		aest_node_foreach_record(aest_online_record, node, NULL,
> +						node->status_reporting);
> +	}
> +}
> +
> +static int aest_starting_cpu(unsigned int cpu)
> +{
> +	pr_debug("CPU%d starting\n", cpu);
> +	aest_online_oncore_dev(&percpu_adev);
> +
> +	return 0;
> +}
> +
> +static int aest_dying_cpu(unsigned int cpu)
> +{
> +	pr_debug("CPU%d dying\n", cpu);
> +	aest_offline_oncore_dev(&percpu_adev);
> +
> +	return 0;
> +}
> +
> +static void aest_device_remove(struct platform_device *pdev)
> +{
> +	struct aest_device *adev =3D platform_get_drvdata(pdev);
> +	int i;
> +
> +	platform_set_drvdata(pdev, NULL);
> +
> +	if (adev->type !=3D ACPI_AEST_PROCESSOR_ERROR_NODE)
> +		return;
> +
> +	on_each_cpu(aest_offline_oncore_dev, adev->adev_oncore, 1);
> +
> +	for (i =3D 0; i < MAX_GSI_PER_NODE; i++) {
> +		if (adev->irq[i])
> +			free_percpu_irq(adev->irq[i], adev->adev_oncore);
> +	}
> +}
> +
> +
> +static int get_aest_node_ver(struct aest_node *node)
> +{
> +	u64 reg;
> +	void *devarch_base;
> +
> +	if (node->type =3D=3D ACPI_AEST_GIC_ERROR_NODE) {
> +		devarch_base =3D ioremap(node->info->interface_hdr->address +
> +						GIC_ERRDEVARCH, PAGE_SIZE);
> +		if (!devarch_base)
> +			return 0;
> +
> +		reg =3D readl_relaxed(devarch_base);
> +		iounmap(devarch_base);
> +
> +		return FIELD_GET(ERRDEVARCH_REV, reg);
> +	}
> +
> +	return FIELD_GET(ID_AA64PFR0_EL1_RAS_MASK, read_cpuid(ID_AA64PFR0_EL1))=
;
> +}
> +
> +static char *alloc_aest_node_name(struct aest_node *node)
> +{
> +	char *name;
> +
> +	switch (node->type) {
> +	case ACPI_AEST_PROCESSOR_ERROR_NODE:
> +		name =3D devm_kasprintf(node->adev->dev, GFP_KERNEL, "%s.%d",
> +			aest_node_name[node->type],
> +			node->info->processor->processor_id);
> +		break;
> +	case ACPI_AEST_MEMORY_ERROR_NODE:
> +	case ACPI_AEST_SMMU_ERROR_NODE:
> +	case ACPI_AEST_VENDOR_ERROR_NODE:
> +	case ACPI_AEST_GIC_ERROR_NODE:
> +	case ACPI_AEST_PCIE_ERROR_NODE:
> +	case ACPI_AEST_PROXY_ERROR_NODE:
> +		name =3D devm_kasprintf(node->adev->dev, GFP_KERNEL, "%s.%llx",
> +			aest_node_name[node->type],
> +			node->info->interface_hdr->address);
> +		break;
> +	default:
> +		name =3D devm_kasprintf(node->adev->dev, GFP_KERNEL, "Unknown");
> +	}
> +
> +	return name;
> +}
> +
> +static int
> +aest_node_set_errgsr(struct aest_device *adev, struct aest_node *node)
> +{
> +	struct acpi_aest_node *anode =3D node->info;
> +	u64 errgsr_base =3D anode->common->error_group_register_base;
> +
> +	if (anode->interface_hdr->type !=3D ACPI_AEST_NODE_MEMORY_MAPPED)
> +		return 0;
> +
> +	if (!node->base)
> +		return 0;
> +
> +	if (!(anode->interface_hdr->flags & AEST_XFACE_FLAG_ERROR_GROUP)) {
> +		node->errgsr =3D node->base + ERXGROUP;
> +		return 0;
> +	}
> +
> +	if (!errgsr_base)
> +		return -EINVAL;
> +
> +	node->errgsr =3D devm_ioremap(adev->dev, errgsr_base, PAGE_SIZE);
> +	if (!node->errgsr)
> +		return -ENOMEM;
> +
> +	return 0;
> +}
> +
> +static int aest_init_node(struct aest_device *adev, struct aest_node *no=
de,
> +					struct acpi_aest_node *anode)
> +{
> +	int i, ret;
> +	u64 address, size, flags;
> +
> +	node->adev =3D adev;
> +	node->info =3D anode;
> +	node->type =3D anode->type;
> +	node->version =3D get_aest_node_ver(node);
> +	node->name =3D alloc_aest_node_name(node);
> +	if (!node->name)
> +		return -ENOMEM;
> +	node->record_implemented =3D anode->record_implemented;
> +	node->status_reporting =3D anode->status_reporting;
> +
> +	address =3D anode->interface_hdr->address;
> +	size =3D anode->interface_hdr->error_record_count *
> +						sizeof(struct ras_ext_regs);
> +	if (address) {
> +		node->base =3D devm_ioremap(adev->dev, address, size);
> +		if (!node->base)
> +			return -ENOMEM;
> +	}
> +
> +	flags =3D anode->interface_hdr->flags;
> +	address =3D node->info->common->fault_inject_register_base;
> +	if ((flags & AEST_XFACE_FLAG_FAULT_INJECT) && address) {
> +		node->inj =3D devm_ioremap(adev->dev, address, PAGE_SIZE);
> +		if (!node->inj)
> +			return -ENOMEM;
> +	}
> +
> +	address =3D node->info->common->interrupt_config_register_base;
> +	if ((flags & AEST_XFACE_FLAG_FAULT_INJECT) && address) {
> +		node->irq_config =3D devm_ioremap(adev->dev, address, PAGE_SIZE);
> +		if (!node->irq_config)
> +			return -ENOMEM;
> +	}
> +
> +	ret =3D aest_node_set_errgsr(adev, node);
> +	if (ret)
> +		return ret;
> +
> +	node->record_count =3D anode->interface_hdr->error_record_count;
> +	node->records =3D devm_kcalloc(adev->dev, node->record_count,
> +				sizeof(struct aest_record), GFP_KERNEL);
> +	if (!node->records)
> +		return -ENOMEM;
> +
> +	for (i =3D 0; i < node->record_count; i++) {
> +		ret =3D aest_init_record(&node->records[i], i, node);
> +		if (ret)
> +			return ret;
> +	}
> +	aest_node_dbg(node, "%d records, base: %llx, errgsr: %llx\n",
> +			node->record_count, (u64)node->base, (u64)node->errgsr);
> +	return 0;
> +}
> +
> +static int
> +aest_init_nodes(struct aest_device *adev, struct aest_hnode *ahnode)
> +{
> +	struct acpi_aest_node *anode;
> +	struct aest_node *node;
> +	int ret, i =3D 0;
> +
> +	adev->node_cnt =3D ahnode->count;
> +	adev->nodes =3D devm_kcalloc(adev->dev, adev->node_cnt,
> +					sizeof(struct aest_node), GFP_KERNEL);
> +	if (!adev->nodes)
> +		return -ENOMEM;
> +
> +	list_for_each_entry(anode, &ahnode->list, list) {
> +		adev->type =3D anode->type;
> +
> +		node =3D &adev->nodes[i++];
> +		ret =3D aest_init_node(adev, node, anode);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int __setup_ppi(struct aest_device *adev)
> +{
> +	int cpu, i;
> +	struct aest_device *oncore_adev;
> +	struct aest_node *oncore_node;
> +	size_t size;
> +
> +	adev->adev_oncore =3D &percpu_adev;
> +	for_each_possible_cpu(cpu) {
> +		oncore_adev =3D per_cpu_ptr(&percpu_adev, cpu);
> +		memcpy(oncore_adev, adev, sizeof(struct aest_device));
> +
> +		oncore_adev->nodes =3D devm_kcalloc(adev->dev,
> +						oncore_adev->node_cnt,
> +						sizeof(struct aest_node),
> +						GFP_KERNEL);
> +		if (!oncore_adev->nodes)
> +			return -ENOMEM;
> +
> +		size =3D adev->node_cnt * sizeof(struct aest_node);
> +		memcpy(oncore_adev->nodes, adev->nodes, size);
> +		for (i =3D 0; i < oncore_adev->node_cnt; i++) {
> +			oncore_node =3D &oncore_adev->nodes[i];
> +			oncore_node->records =3D devm_kcalloc(adev->dev,
> +					oncore_node->record_count,
> +					sizeof(struct aest_record), GFP_KERNEL);
> +			if (!oncore_node->records)
> +				return -ENOMEM;
> +
> +			size =3D oncore_node->record_count *
> +						sizeof(struct aest_record);
> +			memcpy(oncore_node->records, adev->nodes[i].records,
> +									size);
> +		}
> +
> +		aest_dev_dbg(adev, "Init device on CPU%d.\n", cpu);
> +	}
> +
> +	return 0;
> +}
> +
> +static int aest_setup_irq(struct platform_device *pdev, struct aest_devi=
ce *adev)
> +{
> +	int fhi_irq, eri_irq;
> +
> +	fhi_irq =3D platform_get_irq_byname_optional(pdev, "fhi");
> +	if (fhi_irq > 0)
> +		adev->irq[0] =3D fhi_irq;
> +
> +	eri_irq =3D platform_get_irq_byname_optional(pdev, "eri");
> +	if (eri_irq > 0)
> +		adev->irq[1] =3D eri_irq;
> +
> +	/* Allocate and initialise the percpu device pointer for PPI */
> +	if (irq_is_percpu(fhi_irq) || irq_is_percpu(eri_irq))
> +		return __setup_ppi(adev);
> +
> +	return 0;
> +}
> +
> +static int aest_device_probe(struct platform_device *pdev)
> +{
> +	int ret;
> +	struct aest_device *adev;
> +	struct aest_hnode *ahnode;
> +
> +	ahnode =3D *((struct aest_hnode **)pdev->dev.platform_data);
> +	if (!ahnode)
> +		return -ENODEV;
> +
> +	adev =3D devm_kzalloc(&pdev->dev, sizeof(*adev), GFP_KERNEL);
> +	if (!adev)
> +		return -ENOMEM;
> +
> +	adev->dev =3D &pdev->dev;
> +	INIT_WORK(&adev->aest_work, aest_node_pool_process);
> +	ret =3D aest_node_pool_init(adev);
> +	if (ret) {
> +		aest_dev_err(adev, "Failed init aest node pool.\n");
> +		return ret;
> +	}
> +	init_llist_head(&adev->event_list);
> +	adev->uid =3D ahnode->uid;
> +	aest_set_name(adev, ahnode);
> +
> +	ret =3D aest_init_nodes(adev, ahnode);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D aest_setup_irq(pdev, adev);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D aest_register_irq(adev);
> +	if (ret) {
> +		aest_dev_err(adev, "register irq failed\n");
> +		return ret;
> +	}
> +
> +	platform_set_drvdata(pdev, adev);
> +
> +	if (aest_dev_is_oncore(adev))
> +		ret =3D cpuhp_setup_state(CPUHP_AP_ARM_AEST_STARTING,
> +				"drivers/acpi/arm64/aest:starting",
> +				aest_starting_cpu, aest_dying_cpu);
> +	else
> +		aest_online_dev(adev);
> +	if (ret)
> +		return ret;
> +
> +	aest_dev_dbg(adev, "Node cnt: %x, uid: %x, irq: %d, %d\n",
> +			adev->node_cnt, adev->uid, adev->irq[0], adev->irq[1]);
> +
> +	return 0;
> +}
> +
> +static const struct acpi_device_id acpi_aest_ids[] =3D {
> +	{"ARMHE000", 0},
> +	{}
> +};

My understanding is that platform device with name "AEST" is
created in acpi_aest_alloc_pdev and then the name will be used
to bind this driver for the dev. So, do we need ACPI HID definition
here? Using name should work well for both systems with or without
ARMHE000. Or, am I missing something?

I have not yet finish to look all parts and will look them and
other patches too.=20

Best Regards,
Tomohiro Misono

> +
> +static struct platform_driver aest_driver =3D {
> +	.driver	=3D {
> +		.name	=3D "AEST",
> +		.acpi_match_table =3D acpi_aest_ids,
> +	},
> +	.probe	=3D aest_device_probe,
> +	.remove =3D aest_device_remove,
> +};
> +
> +static int __init aest_init(void)
> +{
> +	return platform_driver_register(&aest_driver);
> +}
> +module_init(aest_init);
> +
> +static void __exit aest_exit(void)
> +{
> +	platform_driver_unregister(&aest_driver);
> +}
> +module_exit(aest_exit);
> +
> +MODULE_DESCRIPTION("ARM AEST Driver");
> +MODULE_AUTHOR("Ruidong Tian <tianruidong@linux.alibaba.com>");
> +MODULE_LICENSE("GPL");
> +
> diff --git a/drivers/ras/aest/aest.h b/drivers/ras/aest/aest.h
> new file mode 100644
> index 000000000000..04005aad3617
> --- /dev/null
> +++ b/drivers/ras/aest/aest.h
> @@ -0,0 +1,323 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * ARM Error Source Table Support
> + *
> + * Copyright (c) 2021-2024, Alibaba Group.
> + */
> +
> +#include <linux/acpi_aest.h>
> +#include <asm/ras.h>
> +
> +#define MAX_GSI_PER_NODE 2
> +#define AEST_MAX_PPI 3
> +#define DEFAULT_CE_THRESHOLD 1
> +
> +#define record_read(record, offset) \
> +	record->access->read(record->regs_base, offset)
> +#define record_write(record, offset, val) \
> +	record->access->write(record->regs_base, offset, val)
> +
> +#define aest_dev_err(__adev, format, ...)	\
> +	dev_err((__adev)->dev, format, ##__VA_ARGS__)
> +#define aest_dev_info(__adev, format, ...)	\
> +	dev_info((__adev)->dev, format, ##__VA_ARGS__)
> +#define aest_dev_dbg(__adev, format, ...)	\
> +	dev_dbg((__adev)->dev, format, ##__VA_ARGS__)
> +
> +#define aest_node_err(__node, format, ...)	\
> +	dev_err((__node)->adev->dev, "%s: " format, (__node)->name, ##__VA_ARGS=
__)
> +#define aest_node_info(__node, format, ...)	\
> +	dev_info((__node)->adev->dev, "%s: " format, (__node)->name, ##__VA_ARG=
S__)
> +#define aest_node_dbg(__node, format, ...)	\
> +	dev_dbg((__node)->adev->dev, "%s: " format, (__node)->name, ##__VA_ARGS=
__)
> +
> +#define aest_record_err(__record, format, ...)	\
> +	dev_err((__record)->node->adev->dev, "%s: %s: " format, \
> +		(__record)->node->name, (__record)->name, ##__VA_ARGS__)
> +#define aest_record_info(__record, format, ...)	\
> +	dev_info((__record)->node->adev->dev, "%s: %s: " format, \
> +		(__record)->node->name, (__record)->name, ##__VA_ARGS__)
> +#define aest_record_dbg(__record, format, ...)	\
> +	dev_dbg((__record)->node->adev->dev, "%s: %s: " format, \
> +		(__record)->node->name, (__record)->name, ##__VA_ARGS__)
> +
> +#define ERXFR			0x0
> +#define ERXCTLR			0x8
> +#define ERXSTATUS		0x10
> +#define ERXADDR			0x18
> +#define ERXMISC0		0x20
> +#define ERXMISC1		0x28
> +#define ERXMISC2		0x30
> +#define ERXMISC3		0x38
> +
> +#define ERXGROUP		0xE00
> +#define GIC_ERRDEVARCH		0xFFBC
> +
> +extern struct xarray *aest_array;
> +
> +struct aest_event {
> +	struct llist_node llnode;
> +	char *node_name;
> +	u32 type;
> +	/*
> +	 * Different nodes have different meanings:
> +	 *   - Processor node	: processor number.
> +	 *   - Memory node	: SRAT proximity domain.
> +	 *   - SMMU node	: IORT proximity domain.
> +	 *   - GIC node		: interface type.
> +	 */
> +	u32 id0;
> +	/*
> +	 * Different nodes have different meanings:
> +	 *   - Processor node	: processor resource type.
> +	 *   - Memory node	: Non.
> +	 *   - SMMU node	: subcomponent reference.
> +	 *   - Vendor node	: Unique ID.
> +	 *   - GIC node		: instance identifier.
> +	 */
> +	u32 id1;
> +	char *hid;		// Vendor node	: hardware ID.
> +	u32 index;
> +	u64 ce_threshold;
> +	int addressing_mode;
> +	struct ras_ext_regs regs;
> +
> +	void *vendor_data;
> +	size_t vendor_data_size;
> +};
> +
> +struct aest_access {
> +	u64 (*read)(void *base, u32 offset);
> +	void (*write)(void *base, u32 offset, u64 val);
> +};
> +
> +struct ce_threshold_info {
> +	const u64			max_count;
> +	const u64			mask;
> +	const u64			shift;
> +};
> +
> +struct ce_threshold {
> +	const struct ce_threshold_info	*info;
> +	u64				count;
> +	u64				threshold;
> +	u64				reg_val;
> +};
> +
> +struct aest_record {
> +	char				*name;
> +	int				index;
> +	void __iomem			*regs_base;
> +
> +	/*
> +	 * This bit specifies the addressing mode  to populate the ERR_ADDR
> +	 * register:
> +	 *   0b: Error record reports System Physical Addresses (SPA) in
> +	 *       the ERR_ADDR register.
> +	 *   1b: Error record reports error node-specific Logical Addresses(LA)
> +	 *       in the ERR_ADD register. OS must use other means to translate
> +	 *       the reported LA into SPA
> +	 */
> +	int				addressing_mode;
> +	u64				fr;
> +	struct aest_node		*node;
> +
> +	struct dentry			*debugfs;
> +	struct ce_threshold		ce;
> +	enum ras_ce_threshold		threshold_type;
> +	const struct aest_access	*access;
> +
> +	void				*vendor_data;
> +	size_t				vendor_data_size;
> +};
> +
> +struct aest_node {
> +	char				*name;
> +	u8				type;
> +	void				*errgsr;
> +	void				*inj;
> +	void				*irq_config;
> +	void				*base;
> +
> +	/*
> +	 * This bitmap indicates which of the error records within this error
> +	 * node must be polled for error status.
> +	 * Bit[n] of this field pertains to error record corresponding to
> +	 * index n in this error group.
> +	 * Bit[n] =3D 0b: Error record at index n needs to be polled.
> +	 * Bit[n] =3D 1b: Error record at index n do not needs to be polled.
> +	 */
> +	unsigned long			*record_implemented;
> +	/*
> +	 * This bitmap indicates which of the error records within this error
> +	 * node support error status reporting using ERRGSR register.
> +	 * Bit[n] of this field pertains to error record corresponding to
> +	 * index n in this error group.
> +	 * Bit[n] =3D 0b: Error record at index n supports error status reporti=
ng
> +	 *              through ERRGSR.S.
> +	 * Bit[n] =3D 1b: Error record at index n does not support error report=
ing
> +	 *              through the ERRGSR.S bit If this error record is
> +	 *              implemented, then it must be polled explicitly for
> +	 *              error events.
> +	 */
> +	unsigned long			*status_reporting;
> +	int				version;
> +
> +	struct aest_device		*adev;
> +	struct acpi_aest_node		*info;
> +	struct dentry			*debugfs;
> +
> +	int				record_count;
> +	struct aest_record		*records;
> +
> +	struct aest_node __percpu	*oncore_node;
> +};
> +
> +struct aest_device {
> +	struct device			*dev;
> +	u32				type;
> +	int				node_cnt;
> +	struct aest_node		*nodes;
> +
> +	struct work_struct		aest_work;
> +	struct gen_pool			*pool;
> +	struct llist_head		event_list;
> +
> +	int				irq[MAX_GSI_PER_NODE];
> +	u32				uid;
> +	struct aest_device __percpu	*adev_oncore;
> +
> +	struct dentry			*debugfs;
> +};
> +
> +struct aest_node_context {
> +	struct aest_node		*node;
> +	unsigned long			*bitmap;
> +	void				(*func)(struct aest_record *record,
> +							void *data);
> +	void				*data;
> +	int				ret;
> +};
> +
> +#define CASE_READ(res, x)						\
> +	case (x): {							\
> +		res =3D read_sysreg_s(SYS_##x##_EL1);			\
> +		break;							\
> +	}
> +
> +#define CASE_WRITE(val, x)						\
> +	case (x): {							\
> +		write_sysreg_s((val), SYS_##x##_EL1);			\
> +		break;							\
> +	}
> +
> +static inline u64 aest_sysreg_read(void *__unused, u32 offset)
> +{
> +	u64 res;
> +
> +	switch (offset) {
> +	CASE_READ(res, ERXFR)
> +	CASE_READ(res, ERXCTLR)
> +	CASE_READ(res, ERXSTATUS)
> +	CASE_READ(res, ERXADDR)
> +	CASE_READ(res, ERXMISC0)
> +	CASE_READ(res, ERXMISC1)
> +	CASE_READ(res, ERXMISC2)
> +	CASE_READ(res, ERXMISC3)
> +	default :
> +		res =3D 0;
> +	}
> +	return res;
> +}
> +
> +static inline void aest_sysreg_write(void *base, u32 offset, u64 val)
> +{
> +	switch (offset) {
> +	CASE_WRITE(val, ERXFR)
> +	CASE_WRITE(val, ERXCTLR)
> +	CASE_WRITE(val, ERXSTATUS)
> +	CASE_WRITE(val, ERXADDR)
> +	CASE_WRITE(val, ERXMISC0)
> +	CASE_WRITE(val, ERXMISC1)
> +	CASE_WRITE(val, ERXMISC2)
> +	CASE_WRITE(val, ERXMISC3)
> +	default :
> +		return;
> +	}
> +}
> +
> +static inline u64 aest_iomem_read(void *base, u32 offset)
> +{
> +	return readq_relaxed(base + offset);
> +	return 0;
> +}
> +
> +static inline void aest_iomem_write(void *base, u32 offset, u64 val)
> +{
> +	writeq_relaxed(val, base + offset);
> +}
> +
> +/* access type is decided by AEST interface type. */
> +static const struct aest_access aest_access[] =3D {
> +	[ACPI_AEST_NODE_SYSTEM_REGISTER] =3D {
> +		.read =3D aest_sysreg_read,
> +		.write =3D aest_sysreg_write,
> +	},
> +
> +	[ACPI_AEST_NODE_MEMORY_MAPPED] =3D {
> +		.read =3D aest_iomem_read,
> +		.write =3D aest_iomem_write,
> +	},
> +	[ACPI_AEST_NODE_SINGLE_RECORD_MEMORY_MAPPED] =3D {
> +		.read =3D aest_iomem_read,
> +		.write =3D aest_iomem_write,
> +	},
> +	{ }
> +};
> +
> +static inline bool aest_dev_is_oncore(struct aest_device *adev)
> +{
> +	return adev->type =3D=3D ACPI_AEST_PROCESSOR_ERROR_NODE;
> +}
> +
> +/*
> + * Each PE may has multi error record, you must selects an error
> + * record to be accessed through the Error Record System
> + * registers.
> + */
> +static inline void aest_select_record(struct aest_node *node, int index)
> +{
> +	if (node->type =3D=3D ACPI_AEST_PROCESSOR_ERROR_NODE) {
> +		write_sysreg_s(index, SYS_ERRSELR_EL1);
> +		isb();
> +	}
> +}
> +
> +/* Ensure all writes has taken effect. */
> +static inline void aest_sync(struct aest_node *node)
> +{
> +	if (node->type =3D=3D ACPI_AEST_PROCESSOR_ERROR_NODE)
> +		isb();
> +}
> +
> +static const char * const aest_node_name[] =3D {
> +	[ACPI_AEST_PROCESSOR_ERROR_NODE] =3D "processor",
> +	[ACPI_AEST_MEMORY_ERROR_NODE] =3D "memory",
> +	[ACPI_AEST_SMMU_ERROR_NODE] =3D "smmu",
> +	[ACPI_AEST_VENDOR_ERROR_NODE] =3D "vendor",
> +	[ACPI_AEST_GIC_ERROR_NODE] =3D "gic",
> +	[ACPI_AEST_PCIE_ERROR_NODE] =3D "pcie",
> +	[ACPI_AEST_PROXY_ERROR_NODE] =3D "proxy",
> +};
> +
> +static inline int
> +aest_set_name(struct aest_device *adev, struct aest_hnode *ahnode)
> +{
> +	adev->dev->init_name =3D devm_kasprintf(adev->dev, GFP_KERNEL,
> +					"%s%d", aest_node_name[ahnode->type],
> +						adev->uid);
> +	if (!adev->dev->init_name)
> +		return -ENOMEM;
> +
> +	return 0;
> +}
> diff --git a/include/linux/acpi_aest.h b/include/linux/acpi_aest.h
> new file mode 100644
> index 000000000000..1c2191791504
> --- /dev/null
> +++ b/include/linux/acpi_aest.h
> @@ -0,0 +1,68 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __ACPI_AEST_H__
> +#define __ACPI_AEST_H__
> +
> +#include <linux/acpi.h>
> +#include <asm/ras.h>
> +
> +/* AEST component */
> +#define ACPI_AEST_PROC_FLAG_GLOBAL	(1<<0)
> +#define ACPI_AEST_PROC_FLAG_SHARED	(1<<1)
> +
> +#define AEST_ADDREESS_SPA	0
> +#define AEST_ADDREESS_LA	1
> +
> +/* AEST interrupt */
> +#define AEST_INTERRUPT_MODE		BIT(0)
> +#define AEST_INTERRUPT_FHI_MODE		BIT(1)
> +
> +#define AEST_INTERRUPT_FHI_UE_SUPPORT		BIT(0)
> +#define AEST_INTERRUPT_FHI_UE_NO_SUPPORT		BIT(1)
> +
> +#define AEST_MAX_INTERRUPT_PER_NODE 3
> +
> +/* AEST interface */
> +
> +#define AEST_XFACE_FLAG_SHARED		(1<<0)
> +#define AEST_XFACE_FLAG_CLEAR_MISC	(1<<1)
> +#define AEST_XFACE_FLAG_ERROR_DEVICE	(1<<2)
> +#define AEST_XFACE_FLAG_AFFINITY	(1<<3)
> +#define AEST_XFACE_FLAG_ERROR_GROUP	(1<<4)
> +#define AEST_XFACE_FLAG_FAULT_INJECT	(1<<5)
> +#define AEST_XFACE_FLAG_INT_CONFIG	(1<<6)
> +
> +struct aest_hnode {
> +	struct list_head list;
> +	int count;
> +	u32 uid;
> +	int type;
> +};
> +
> +struct acpi_aest_node {
> +	struct list_head list;
> +	int type;
> +	struct acpi_aest_node_interface_header *interface_hdr;
> +	unsigned long *record_implemented;
> +	unsigned long *status_reporting;
> +	unsigned long *addressing_mode;
> +	struct acpi_aest_node_interface_common *common;
> +	union {
> +		struct acpi_aest_processor *processor;
> +		struct acpi_aest_memory *memory;
> +		struct acpi_aest_smmu *smmu;
> +		struct acpi_aest_vendor_v2 *vendor;
> +		struct acpi_aest_gic *gic;
> +		struct acpi_aest_pcie *pcie;
> +		struct acpi_aest_proxy *proxy;
> +		void *spec_pointer;
> +	};
> +	union {
> +		struct acpi_aest_processor_cache *cache;
> +		struct acpi_aest_processor_tlb *tlb;
> +		struct acpi_aest_processor_generic *generic;
> +		void *processor_spec_pointer;
> +	};
> +	struct acpi_aest_node_interrupt_v2 *interrupt;
> +	int interrupt_count;
> +};
> +#endif /* __ACPI_IORT_H__ */
> diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
> index a04b73c40173..acf0e3957fdd 100644
> --- a/include/linux/cpuhotplug.h
> +++ b/include/linux/cpuhotplug.h
> @@ -179,6 +179,7 @@ enum cpuhp_state {
>  	CPUHP_AP_CSKY_TIMER_STARTING,
>  	CPUHP_AP_TI_GP_TIMER_STARTING,
>  	CPUHP_AP_HYPERV_TIMER_STARTING,
> +	CPUHP_AP_ARM_AEST_STARTING,
>  	/* Must be the last timer callback */
>  	CPUHP_AP_DUMMY_TIMER_STARTING,
>  	CPUHP_AP_ARM_XEN_STARTING,
> diff --git a/include/linux/ras.h b/include/linux/ras.h
> index a64182bc72ad..1c777af6a1af 100644
> --- a/include/linux/ras.h
> +++ b/include/linux/ras.h
> @@ -53,4 +53,12 @@ static inline unsigned long
>  amd_convert_umc_mca_addr_to_sys_addr(struct atl_err *err) { return -EINV=
AL; }
>  #endif /* CONFIG_AMD_ATL */
>=20
> +#if IS_ENABLED(CONFIG_AEST)
> +void aest_register_decode_chain(struct notifier_block *nb);
> +void aest_unregister_decode_chain(struct notifier_block *nb);
> +#else
> +static inline void aest_register_decode_chain(struct notifier_block *nb)=
 {}
> +static inline void aest_unregister_decode_chain(struct notifier_block *n=
b) {}
> +#endif /* CONFIG_AEST */
> +
>  #endif /* __RAS_H__ */
> --
> 2.33.1
>=20


