Return-Path: <linux-acpi+bounces-18307-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EAEB7C188DC
	for <lists+linux-acpi@lfdr.de>; Wed, 29 Oct 2025 07:57:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4B8D1352238
	for <lists+linux-acpi@lfdr.de>; Wed, 29 Oct 2025 06:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E082630E83E;
	Wed, 29 Oct 2025 06:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="CIf3L/wL";
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="PcXxrfGR"
X-Original-To: linux-acpi@vger.kernel.org
Received: from esa14.fujitsucc.c3s2.iphmx.com (esa14.fujitsucc.c3s2.iphmx.com [68.232.156.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150D530C60F;
	Wed, 29 Oct 2025 06:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.156.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761720902; cv=fail; b=kA25oyttIRawfvCYKU9C6rJJBUEfb2J8wIXMiCb+3ipzNqD+qw4e4PC24P3Z8RDPSHhAigPECEFPWVGr/PCWIeOOIhyjVDAkjKtE1n4iM/dzyizfX1lsadBlVwvHKoW7IL6DHWFHo35YkQxUsGbdkZMe6Z+MFqcfeyf0ABOVNGg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761720902; c=relaxed/simple;
	bh=pRSge27cV4FvJsVaDN+iiKt8llAAZFV0QK+zgTAIYdw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XIUcFCrOrvPuNbjm6/2YkkHTorp9CS0HSK22RN2lIc8k7taO/PALEImeIYNo1oUGHerN+npPeWdMTyMSu0fW/t91MXEWetMiUnjbHhMWlz79wnhHC3smnsYnHrkdOe9rUJ6csxzfXaJxQJFTY3kG8QUMN0dpA9iANibVkR13aQM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=CIf3L/wL; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=PcXxrfGR; arc=fail smtp.client-ip=68.232.156.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1761720900; x=1793256900;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pRSge27cV4FvJsVaDN+iiKt8llAAZFV0QK+zgTAIYdw=;
  b=CIf3L/wLXXh1OupZOEalJh+YypYyclLCvx52VvcxKRhWl6lwZjTSa33e
   QWDE5MOLxVkmxQZ75OHVHFbmC1/xPjIshMv3uG0ZvL4zCVuxfikypadGc
   YxqvZ6eNxg4L7KDDfqI0f76QVLenLkPUeELaA44ZeZOUcHGHfpxasO6eu
   a+qQHiKe9GGuoiobxYC6ZuCXk90umCzABqbQJnecffdDXkEyW3VcZeSw6
   h8Q6V2BgcUohq/gxMIO8S2QzySUW6T6nFpr3ca3UcZjhm+9LTjycq3qtd
   cUQPctPgbmqAWaU53e1Be1eea0Ud5+3weV3aj68Anp/Ogu55e3yLppr7t
   A==;
X-CSE-ConnectionGUID: pLjTaFR8Q8a6IHScSToukw==
X-CSE-MsgGUID: IGirdZniSyGKlIsJwNBfIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="171971169"
X-IronPort-AV: E=Sophos;i="6.19,263,1754924400"; 
   d="scan'208";a="171971169"
Received: from mail-japaneastazon11010015.outbound.protection.outlook.com (HELO TY3P286CU002.outbound.protection.outlook.com) ([52.101.229.15])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 15:53:40 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kg38csqfZW4/wf4r/IKIrIn21pYSkj34565TT3ps2pS94J1nRBCnHVhpvcLm6ezCeTPpMIcVwKn7/h35XvpWayt9RUwVuJ00G6/WY7YwE1isRILthiDKyxwUlmYDfNiyO/oNVrA4Z7sH0f1yBH/LXBkCq3Rw5SQAe4l0KKX1fYdrpLmJBzf6FpaBATqQxsJj6duv93qBoOC5odRvqT1vdhbUKue9SHG0oaYNE8yuwlyOL1YeoxX6RQVDUyfPOnxmY8AvCXxDxXxlaUXhypggzKPjMHlLiLNjn6Ds7/syKjLEAVsqSKHh+jSfwhGEKQlOTAk7Q2p8xWYOmJOQApXhiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pRSge27cV4FvJsVaDN+iiKt8llAAZFV0QK+zgTAIYdw=;
 b=cEqXax4fh42Q3EOnbzM9b6hd36h5wK+mVCTpK9TF7JXm1Eo1vu3IrZ0g+SdIh4mS9ECPTk5/CdVMkHtmwwH4/HBwXr5wEMUCPlJFs4KVDYdwbZr60NXgGDyx0gAzZg3SeqMB1QzegMhrLLDce2hI9kGAYfTfo3FBFh9KKWjuwqHF5L/svlwa+8SqKHSDMqw+QMLMzawkOQVtrGv/urz6zHiGH/uHzSZw/7uE0C3GtDa4JzVxqiE7eFLM4IkJqVxjuR1rtSMfs//z1c7apsvB/4/OUIcsR8TewNXKlIartrf7LKv50telstbEWiRm/gYnXSqN/+Cc2wqLTgYriUhLSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pRSge27cV4FvJsVaDN+iiKt8llAAZFV0QK+zgTAIYdw=;
 b=PcXxrfGRxXwrn2PHhUV9RPFpTtY3iMDx//fgxOIvjntshHsRjAZCrqrMSR+0RsDWx0OndqFnwtt1PDnSxUmHYCSzaYP5OGqtGttYHkp5IfCGDVBuy/y4Mk+SGrQBSfED89oaW3beSOFrRkGKGoLnT9Nz4iN5pgjTty+JC90GnXf8PsmK1CENj2UPb9hzxUSU6dT/obWIVMP5eeufj0kqWrTKRjFCEN1D0JeEKoULfT4yz3RdfVLMfIVpxW5OJ3LuMRGFyqFZ74ysjREUOgKmCoYPNWmUTTEy9EYO6MvrxGII1/3YKIkbHPO8bLkGrciCwm1cw1my85jW+Gm4RWQgtg==
Received: from OSZPR01MB8798.jpnprd01.prod.outlook.com (2603:1096:604:15f::6)
 by TYCPR01MB11069.jpnprd01.prod.outlook.com (2603:1096:400:3ac::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Wed, 29 Oct
 2025 06:53:37 +0000
Received: from OSZPR01MB8798.jpnprd01.prod.outlook.com
 ([fe80::e366:d390:4474:8cfa]) by OSZPR01MB8798.jpnprd01.prod.outlook.com
 ([fe80::e366:d390:4474:8cfa%6]) with mapi id 15.20.9275.013; Wed, 29 Oct 2025
 06:53:37 +0000
From: "Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>
To: 'James Morse' <james.morse@arm.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>
CC: D Scott Phillips OS <scott@os.amperecomputing.com>,
	"carl@os.amperecomputing.com" <carl@os.amperecomputing.com>,
	"lcherian@marvell.com" <lcherian@marvell.com>, "bobo.shaobowang@huawei.com"
	<bobo.shaobowang@huawei.com>, "baolin.wang@linux.alibaba.com"
	<baolin.wang@linux.alibaba.com>, Jamie Iles <quic_jiles@quicinc.com>, Xin Hao
	<xhao@linux.alibaba.com>, "peternewman@google.com" <peternewman@google.com>,
	"dfustini@baylibre.com" <dfustini@baylibre.com>, "amitsinght@marvell.com"
	<amitsinght@marvell.com>, David Hildenbrand <david@redhat.com>, Dave Martin
	<dave.martin@arm.com>, Koba Ko <kobak@nvidia.com>, Shanker Donthineni
	<sdonthineni@nvidia.com>, "fenghuay@nvidia.com" <fenghuay@nvidia.com>,
	"baisheng.gao@unisoc.com" <baisheng.gao@unisoc.com>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Rob Herring <robh@kernel.org>, Rohit Mathew
	<rohit.mathew@arm.com>, Rafael Wysocki <rafael@kernel.org>, Len Brown
	<lenb@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, Hanjun Guo
	<guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>, Catalin Marinas
	<catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, Jeremy
 Linton <jeremy.linton@arm.com>, Gavin Shan <gshan@redhat.com>, Rohit Mathew
	<Rohit.Mathew@arm.com>
Subject: RE: [PATCH v3 15/29] arm_mpam: Reset MSC controls from cpuhp
 callbacks
Thread-Topic: [PATCH v3 15/29] arm_mpam: Reset MSC controls from cpuhp
 callbacks
Thread-Index: AQHcP5gJxNlR2hUQP0GH9e5axTQbTbTYwhKw
Date: Wed, 29 Oct 2025 06:53:37 +0000
Message-ID:
 <OSZPR01MB879824B522CCDDE98F30972E8BFAA@OSZPR01MB8798.jpnprd01.prod.outlook.com>
References: <20251017185645.26604-1-james.morse@arm.com>
 <20251017185645.26604-16-james.morse@arm.com>
In-Reply-To: <20251017185645.26604-16-james.morse@arm.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ActionId=203738a3-f7b7-400a-b517-c0ad00bc7062;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=true;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED?;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2025-10-29T06:52:45Z;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB8798:EE_|TYCPR01MB11069:EE_
x-ms-office365-filtering-correlation-id: d04aa85b-0b02-4061-dc5a-08de16b7e2cc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|1580799027|38070700021;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?MXg3QmdOck9iWXdnVjRRNjdTTGJIaXB1UEZSVEdta0FZUVBOZzk2MGha?=
 =?iso-2022-jp?B?blJyb2k0bHh1cXRaSk1vWXpxa2d4bmpVczdHSkhZaW13bzRpYy9WZmlw?=
 =?iso-2022-jp?B?NDl6R2xIS21oaElnR3pJYlFzMVEvck5wOEN5Y2ExRzQyem1WQnIwOHpM?=
 =?iso-2022-jp?B?YnMzWTNFY3QwTVZRaXNmU296TzVicTR0aExjR1djQTFBTlE2WWpCQmsw?=
 =?iso-2022-jp?B?ZVVGSDE4MTZMcG9nRVVBaVA2cjE1NVdoYnB1NDBKTlV1R3lZNG5sYjB4?=
 =?iso-2022-jp?B?NDlSbjdwVGM3bXE0UWw1cUxORjdGRUZ4UlFYR1NaMzB5TTNUcStXUGRS?=
 =?iso-2022-jp?B?KzRWMlhGZjZWOWpwaDR1a2ord0tCTFpLcWVJektVd0hDaVFTRjhJWEt1?=
 =?iso-2022-jp?B?ZUQ2dTVET0d4d09IRWJjUW9jamEvZjNsaHA5WGtjVUhjbXFTeVdTM21Y?=
 =?iso-2022-jp?B?SWZFZTB2bUZRVnR6eFYwaTg3L2t0SWZPWUV3TUg0b2F6UmMycEVDQndE?=
 =?iso-2022-jp?B?SEpTc0tUUnR5cERzQjd5WXJzMW5FaVFJTEo1MHk1MFNxZDN1V0pPbGhI?=
 =?iso-2022-jp?B?aWE2NEVJc3A4MTE4eDNxemF6eTZSMFMzcUdGbGZqWVplM1kwN3pCRzFk?=
 =?iso-2022-jp?B?V0QwaXBSazlvUkpad0Y2TjdteUgzUEovblBvQlByYWF2dVFVS2MwL2pV?=
 =?iso-2022-jp?B?bGFjRkl1WE1iM29HTjJqSWhvTGNpNHVvcmkwY0EwWlZJd1BGVjJTaXFM?=
 =?iso-2022-jp?B?UVE1OUlLakpaYkFoYm9lOGUzS01VTkV6c0JmazdhZWtHR3FpT094VTR4?=
 =?iso-2022-jp?B?aG9aYmhGSHFpUFk1Q2paNjBOKzY1T2tidjk5RVpLeVlPbzdScUN6Q25i?=
 =?iso-2022-jp?B?UThWQTNTRkFUaVYvRGt5S0JmSjRsZXE3Y3JHUStEZjc1QlhUQ0JJdnA4?=
 =?iso-2022-jp?B?SU1PQXNLbS83aGlxQm1PNWg4Tnlia2F1ei9oZk5tZEdxclZDODJ4NkhP?=
 =?iso-2022-jp?B?V21SakE5TGc2Qktoc3RpYkhOc01xTTJDMUVLT1FFR09BVXJ0TFQwMXRl?=
 =?iso-2022-jp?B?SmNVdnFTdVg1ejB4YUJEeVVqWnNSTWNKMCtNTHpBMG5acWk4c0lFWFNJ?=
 =?iso-2022-jp?B?YnQyV1dzdzlYM3Z2MGdCOHMzZy9tcHdwYlhvZHdsM2dVUWdlM1g3ZXBK?=
 =?iso-2022-jp?B?Q2hNSEk1RGdPSmV1OUJXSzhOeXhLYlJsSDF2NHg4MnFicVFRTjl4Vklj?=
 =?iso-2022-jp?B?dWF0cmx5R3JubWVyWStzOWVLT2p6WS9ITjlvRmhnQnJlK3BKL1Z2OGZY?=
 =?iso-2022-jp?B?VjNEY0hvbmIvY01tMS9RcGZXcHB0cTlKQnNRMWdsUXlKY0hmakd1S2Jx?=
 =?iso-2022-jp?B?TllweE1DVjBBSWZ1NnREVXhENWxlVTVFN3MrNkZKeVRWS2psWG5iZmhy?=
 =?iso-2022-jp?B?UnIwcmhpeXBMMmI5d2pNU1R5eWFyN3RsTmk1eXE5VXpkdmU1L1I5NVI2?=
 =?iso-2022-jp?B?TEVXcVpsaWt1RUp6RWVTZUlNNW1BTC85NllKYVJkQitzVWRzeXoxNURL?=
 =?iso-2022-jp?B?Y1VSVEVpWDczRUdCQWU4YWd2RnZOY0JpcE1DdG95YzNQRkRpQmhyd2pU?=
 =?iso-2022-jp?B?WDlJOEh1dk4wYjk2T3JmNHV0czZHMTBHM0owZ3RUOGVvMlpQQ2JIeS8v?=
 =?iso-2022-jp?B?OTRKQkFLS0lLVVAwWFh5cEQyUzUyQ3VENlVnbWljazdqUm5zYlVsQTRq?=
 =?iso-2022-jp?B?MEEvNFRwcHc2c0dRZUlKSC9uMS9UdlZMMVRxSzRYOXRuZUV0cm1iQmpo?=
 =?iso-2022-jp?B?bVlPRjhJWTRLUDFOa3RqOURtNUNFNWVZWEljSytzTmZiU3hWQWVvbXUv?=
 =?iso-2022-jp?B?a3MvN1lGVUF2bnMraFJ5MlU0VEFFTU5WY2c0TGh3c0lRT0UrWnBrWkoy?=
 =?iso-2022-jp?B?Q2tIR0U2UWV5RnRaWFJ2M05xdkVOWU85b0pZNmVaQkJ2Z1BDT1c2QWh3?=
 =?iso-2022-jp?B?MFpFdXR0c2RRcUR1Q1JoOEFDeUVEWWZaSEwzZm9QdEVMNGFvMkdZOHda?=
 =?iso-2022-jp?B?cGROa1J0WkRRdDRJcXB0RVhXMFFrSE5QZEFzUFZpUE9idDBLOE8vR09W?=
 =?iso-2022-jp?B?eGJXQ3ZuWWIvOERvdzhnZ2F5SHpWbjIvUWZFcHV3MnkyMjR6S0xNWHJP?=
 =?iso-2022-jp?B?WlE4SW85R1dKeDgrQTFXS0J6TzFITTY5eThhUkR6Q3daOCtRQmFBK3Fo?=
 =?iso-2022-jp?B?SEVmUT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB8798.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(1580799027)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?L2dCM0d1bGx5dEtFbHJTbVR0NGRtUWhLT0xKdHpPYlF6R25kYmxqU0d4?=
 =?iso-2022-jp?B?UWtIcy9qUHFaNDNYUlE5VUZTZGV3WFRXbU8yOXBHL20xOTBzd0ZaaHM1?=
 =?iso-2022-jp?B?UklrcEFWTEE3STM2VEpFNkFSazkwWkZpc1NBSTJMazBzYkVZclptZ0wy?=
 =?iso-2022-jp?B?ZmdMRm8rTmxrWE42VmkzSENpSDVJNGNiZmxSQ2M0ZmU5R1JqeTFma0VN?=
 =?iso-2022-jp?B?YlY5UGVwclVtUmRhUFRDYzlQU0JUL0I3ZmkvWlpHeFVPbDJ5dFJxUEhq?=
 =?iso-2022-jp?B?R05xVEJXOTV4c3NwYXNjY0VZYU1oTzdPdUV5YmVUR25yWGZKeGZud2tN?=
 =?iso-2022-jp?B?MHFnVnAzUkY4VGZZc2c4Q3NHSTFuTEV2cC95di9OZHc1MTZEUEFDMnV4?=
 =?iso-2022-jp?B?VnNZcnhUSVkxelo5STdrOVlyWWU1aUs5OHZzelFzSG0rOFB3T0RGQTUr?=
 =?iso-2022-jp?B?RHJHU2VqcG1ZQmxFbE91bWFrOUZJcmcxWWRPSGpzKytqNVVxREovcFVF?=
 =?iso-2022-jp?B?N3ovODlDNlZxZTYxdTJFa3c1Qi93UjVnczFiNTZKT2IzeXFWcHhFVld4?=
 =?iso-2022-jp?B?aVpqM1U2OE1ZMUQxN0c1R3lsZnhZWkxEcTkwZ0RFVVRtSFJvR1NMY3Iz?=
 =?iso-2022-jp?B?QzNnTlovWENmUzQvb1ZDOFJzRGxDYktLYjhQQ0lKZlBUTW9LR3g3OWw4?=
 =?iso-2022-jp?B?RE9BR2l4TmFnZTN5cGljT2VtdkNzeHQrS3A4K0dXRkJaOVcrQnN5ejJo?=
 =?iso-2022-jp?B?YlNwa1ppQWZhRW5FMXRhLzlLZCtveXAvZzUyQlJQYjBENEZFekZhdU12?=
 =?iso-2022-jp?B?UGpvODN3SEtYcnFCdE5NVFlYTUJWT1RVcEh3ZDlyd25CeDArRE1zVmdl?=
 =?iso-2022-jp?B?K29EZHQ2WFF4ZlM0NXNEZkk1bmNIaUJ3OHVzNGM1ckRucE1ncHFxVmxv?=
 =?iso-2022-jp?B?Rm1UZVhPNkU1WHVwdVlDeC96Q1M5R1BvdlhCOFFpVVdwY2plcFJJKy9M?=
 =?iso-2022-jp?B?UTlyb3RBYlFmTkgzaHMyUWtISjludUFJWXRhZllyQ09HZmk3RVpTazBG?=
 =?iso-2022-jp?B?R3FKaGtRRklaYkMzQjZlMkRMVmFLRDJMU2lVN2pJL2RBRzJUZU50T2lR?=
 =?iso-2022-jp?B?N1lCR3BCNDcraHFKK2JkZ05oVndTcVhBdUdNa29yWTVtMEp6MVFwcVN0?=
 =?iso-2022-jp?B?eFJ5eWEyR2NHTlp1SFo1QjhuakpCaXNGTHBKeGxjRTN5WHNtazBQQzhs?=
 =?iso-2022-jp?B?bUFsa2xXb0V4bVRNMVVFSEJ6UHhYSldVbFNONmJjeXJWZ3F2S0Q0U3hW?=
 =?iso-2022-jp?B?Uk5VRWZtelI3clFIYytZZ2ZDV3dOb0NpMTVnNC9vTjFvZTB6WlEydzdt?=
 =?iso-2022-jp?B?b053RzFza0NmeGhtK0tnZzFqbVlYK0J1SmpqbGh4K2prRXJyQS94SHFB?=
 =?iso-2022-jp?B?Zmdmc3ZIYjlwNU0zVHIvVFd1NWVYVzlHTFlFbkZ5NkNVWHFOaXoycm9y?=
 =?iso-2022-jp?B?Nnd2azQyQnpRZXhsd3RWU0dSeTROMFpmR09nSHp3RGl6RGY5bTJEcENG?=
 =?iso-2022-jp?B?QlBhR2NjUmZibW1NV1lKeUFoSDV2Q1BJZllMYzNrTHpNN0k1Z2hhSXU4?=
 =?iso-2022-jp?B?NE5oeHY4M3lGSTdpOWNlUlc2ZXA1azVMUU95WFI1TnVQMWZZMjd2ZnFK?=
 =?iso-2022-jp?B?eGk5cUNBVVBtNXdKSVZqc2NrMVg3WTg4bzZZblpMbC94bmNwbll3SS93?=
 =?iso-2022-jp?B?SVg2R3NUeFMrZTVGVHVZREU0d292ZlpqbWJCaktPYlZ4NlpNd0JhUW9u?=
 =?iso-2022-jp?B?bGR2Ti91bmZIUU91L3ZhSElscXFvbWwwb0pqZGE5MmxzTEdmWkgvVWNT?=
 =?iso-2022-jp?B?Mzh6WHh0VXVSN1dwNnFWQVJsd0s4SlFKaWZsWGxoT2d5UVJFTnM1UkRp?=
 =?iso-2022-jp?B?dGREbmUrWTlWOFdmeWo0QjI1bnRYOEVHU3hnQWk1bnJJdG93OStKTHU4?=
 =?iso-2022-jp?B?aEJoSFdvWTc2UTArdVZFZ0JjY3UvNnhVSmwybk9tVFdMUm5HL2laS2Vr?=
 =?iso-2022-jp?B?ZmFlcTJ6M1FJdThVTzVheE10bDNhanRGU08wU1haMi9pZTBweHEwbTUy?=
 =?iso-2022-jp?B?WHNrd2I1MXQySGNyUUhmS3l6RGF0Q1c1WEZDdk92cjZSSGdKbVA4KzFG?=
 =?iso-2022-jp?B?UGc0REFtNzJaMFFMY1RCNTB3dmRvN1NmRDZ5R2tVMDI1ZW9NdW1SRlFv?=
 =?iso-2022-jp?B?MzQ1YVBzZVZOYm9zSjZMM1VxbDN6SUp3YnhzcGlEOThMSytycTl5MnZB?=
 =?iso-2022-jp?B?WnhtSVQvQTh3dG1XRWJSdnQ5ek42azkwN0E9PQ==?=
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
	+OjBRr00IXzUQZUu2PzeMTWWcm54BvkEcSosTn985k8IBgTTxOC1XRIi8BbOVWxNQ7yCjcKE15pZJP7P6MK+aJyvvZbyeoLwMp5fAtjC71/X8XSECnA1kL/HHGerthNWhrLrgmXXHI8ITtpJxyQuPjlitsyZL+nCx9m/ZAqNVbDhmuks2M+Xv02kI7DHMvg02S0vYFhSiweoKp/xcUAagPVa3OGm0yq2WMGiatqu2VVSC6PuycneoSu/6ONsFwTaSiyh/sXcHnFuXY7YT6S72cuG1ZgPPm1a2kHDim3td4Ibrl9pbnIYrDWfi2AVCKouVvgQCpAABq4ZOUYvu8GTzS8pKTIk3MfmaBhJikLKN2mFCAV8+Jb+A81E1pnrmY06/aobOcZoE9Y9QVUxDRc8siU8cVbYKLcXX3MYyH4YX0GJqZCsY/pN0Ihs+Sb4jkpl53DpKdBVtGqV27eHPhdFjPZ4OoyUxXTTNUaQmi46JcOx0noR9UJlH7jYsuSsYl+hPvlJG8/X01o99b6AK85ZOg5X7Cc+t6Q+zE4FbOZqcW7dBg7qWFlXL3paOhXQMHA4Aitbfx7wGaH1mfa9gD3I7IR7LbOrYujGIs/1HeF5IkC3M4NlgRA426tb7nngQnDU
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB8798.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d04aa85b-0b02-4061-dc5a-08de16b7e2cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2025 06:53:37.1981
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jjU/dCseQPZPT5gFQQCM35uSeJRJ09YQcEU6ZL59HZQMtZ4/GsTLSNlt/XzUadjYhTi/KuXv3dF4f5gNLKJDU1oh7c02d9jC9WGoBceWJE0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB11069

=20
> When a CPU comes online, it may bring a newly accessible MSC with it. Onl=
y
> the default partid has its value reset by hardware, and even then the MSC=
 might
> not have been reset since its config was previously dirtied. e.g. Kexec.
>=20
> Any in-use partid must have its configuration restored, or reset.
> In-use partids may be held in caches and evicted later.
>=20
> MSC are also reset when CPUs are taken offline to cover cases where firmw=
are
> doesn't reset the MSC over reboot using UEFI, or kexec where there is no
> firmware involvement.
>=20
> If the configuration for a RIS has not been touched since it was brought =
online,
> it does not need resetting again.
>=20
> To reset, write the maximum values for all discovered controls.
>=20
> CC: Rohit Mathew <Rohit.Mathew@arm.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>
> Tested-by: Fenghua Yu <fenghuay@nvidia.com>


Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>

