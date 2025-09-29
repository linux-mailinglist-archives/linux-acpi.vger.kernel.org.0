Return-Path: <linux-acpi+bounces-17385-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E555BA83B7
	for <lists+linux-acpi@lfdr.de>; Mon, 29 Sep 2025 09:24:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2818171E73
	for <lists+linux-acpi@lfdr.de>; Mon, 29 Sep 2025 07:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8226C24E4A8;
	Mon, 29 Sep 2025 07:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="AaplTkQa";
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="IpBwaDxi"
X-Original-To: linux-acpi@vger.kernel.org
Received: from esa13.fujitsucc.c3s2.iphmx.com (esa13.fujitsucc.c3s2.iphmx.com [68.232.156.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E8017597;
	Mon, 29 Sep 2025 07:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.156.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759130665; cv=fail; b=Eihx+fOOUTPuHjBDQvm32mZnSYCTZcaCdlogLRPo1JtrQ2cMVY+6tZywGfjYS3RdJp1VuMeTn1OeYLgxjLKnDUq9buX8C55fVOo98OLMUjpWWOUSaRgvXF4D6LCiPygA7ngB5J21lhz+VkJD3jGtMKnpoLUIsU9qlq8I9yS+o24=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759130665; c=relaxed/simple;
	bh=RrlnF9D9yizAfJorvJa0F0j8Slln9Fj6lXmMiYhdAZw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kPevCFSBXdkbZj1An/iXA6dQxO52OICL1h4FLkm/BuTEA0C0KYKWZ/PqIyQt85CSkiualDpH02tlGW76uBnEmsLrI5f4HDhgAYBmDxhFn5x2WOy6R+WVzHKsMmOdxSDr87/2MULSJRWCka9E96/Um6dpD7ultF8dA+yX6ylfjm8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=AaplTkQa; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=IpBwaDxi; arc=fail smtp.client-ip=68.232.156.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1759130664; x=1790666664;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RrlnF9D9yizAfJorvJa0F0j8Slln9Fj6lXmMiYhdAZw=;
  b=AaplTkQaIXtVg3VFmR3wY5xBa0EjGRk1j5sqdQNEkQtAOXvMWlEqzCYx
   Xc6sk04UWQs0zggVdjn62u4gOG7W5cMEw61BFrmIrxP0cb7C58d/ru3M6
   xXEO5Mwkm0BhKB1tmWDlOLqkMZuMnVtkdtV/ywNrcmFCKWNO4D4OLKpyL
   ORVm8iaQb/nt/iOXv2VdBaDIyHzjhQJcy4cKom3WV016M8XL5daWgX8Em
   CMi7XS1O2CUVpX0fYEVxAnH9OmC0jPKoYS41ofwJbwFQ5/y1xIw5C7DuT
   KeSo6FjWR0jO5ED7UmC+QLKpsJeA2Vrn+Y1vhZRcW9wFfa0XIdddIlnv5
   A==;
X-CSE-ConnectionGUID: Dzci7F9tSMG4X3HM/SnFxQ==
X-CSE-MsgGUID: L4k+wfcmTQuxU2X624TG5w==
X-IronPort-AV: E=McAfee;i="6800,10657,11567"; a="168812098"
X-IronPort-AV: E=Sophos;i="6.18,301,1751209200"; 
   d="scan'208";a="168812098"
Received: from mail-japanwestazon11010058.outbound.protection.outlook.com (HELO OS0P286CU011.outbound.protection.outlook.com) ([52.101.228.58])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2025 16:23:08 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gmJtU5zAE7k4AU00v9NiY7oJP2o6pmoePvBKAopf0Ru0aGjr1H+kx/PwqvKS+K20EWXczWuwSzyU8rBOBuu0mGU9YXp+RwwleOaUCPfFP+diaMavR0JhIbQ7yhSPJsifu9OyeiRtTLMMXPZckxHk9nYziNRAONGCY1hb2Wg5DEMbYeXx7eA/jeeL8TC37uf57OKC8aoZwPwlNOBFIBk2KVmOgNC4IxgNqqu2JVTcDlruPT41ZrHLi5s9hRaVAOEtzLDdf0dHYTwUYhY2xUGmrLUzfdGd1VdUV3zZsWBXV6Ymz0VDO+lAE0rb/odN/Mr2OWnV8wu+R7BbZpnH94Z4JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RrlnF9D9yizAfJorvJa0F0j8Slln9Fj6lXmMiYhdAZw=;
 b=CKgiUtBLyfXZI4G27WE0g7OXsFSmJs5XYKqfW7OpjsYlADBGF41auXQdGpFne/eQAW95xpe+ELb6UPLMJXF1ak5MiIN5rm8NNJsidt6TG4Q0FzFpYCrofoq4C/KIdmUrPb0UYJyDxIuhliEYvMxFC+ZTksrtGbwU5bT6DeOb4SenabVwW20e8rSlXPBMDtLTpY4cqBDfsTOaRMjX5vk5HXbRgrHzR1a+iE3+UQ0W/Ewqss9D1uEZI7ntWPMGlQTrO4r2m57kQVimHDIk9nI5v9nSzmdFdSUZK3f5o/HvpktY3/ykj1V4liD2uL2m+F5udt2YJewMKOCLFsAKCZUeJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RrlnF9D9yizAfJorvJa0F0j8Slln9Fj6lXmMiYhdAZw=;
 b=IpBwaDxikpPgVgPOOO03w2LcpEHVgcEbAartYyaT3fQ8uWgIhKpOLHEVO14/JBFxkL8TxIf3o005I+YJIqNtDhHgLDzaslawIpHtQ2ebjWL2LapGo8lSF23U8T9Hyb2kWpsxyoNgfee7Jpx2KqWCScXL/+bfENEhVYt0sqhbgVEV2K3EG8j6UfFzI+w7ynne+hykNBwzjVt4lwjNf5vN3PyeU/M8V9dUQKAr0qJUxbJwSNAHVxLF5k0SundApCZK5M2RK5X8Sv9ANmhZHS0QmRGSwY0JD6/oO5nZu5mWHWEioG7Lnq+trF2r1KUZS5I2tNu7pJJDKTFVZDv0DDFU9A==
Received: from TY3PR01MB9983.jpnprd01.prod.outlook.com (2603:1096:400:1dc::6)
 by OSCPR01MB12721.jpnprd01.prod.outlook.com (2603:1096:604:33a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Mon, 29 Sep
 2025 07:23:04 +0000
Received: from TY3PR01MB9983.jpnprd01.prod.outlook.com
 ([fe80::f8a:4f35:cc76:bdc1]) by TY3PR01MB9983.jpnprd01.prod.outlook.com
 ([fe80::f8a:4f35:cc76:bdc1%6]) with mapi id 15.20.9160.011; Mon, 29 Sep 2025
 07:23:04 +0000
From: "Kazuhiro Abe (Fujitsu)" <fj1078ii@fujitsu.com>
To: 'Hanjun Guo' <guohanjun@huawei.com>, Lorenzo Pieralisi
	<lpieralisi@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: Ilkka Koskinen <ilkka@os.amperecomputing.com>
Subject: RE: [PATCH v3] ACPI: AGDI: Add interrupt signaling mode support
Thread-Topic: [PATCH v3] ACPI: AGDI: Add interrupt signaling mode support
Thread-Index: AQHcHh171tqf09K4SkK1ciG0VLTs/LSmdW6AgANveaA=
Date: Mon, 29 Sep 2025 07:23:04 +0000
Message-ID:
 <TY3PR01MB998368496A0A51E1C81FA47FD51BA@TY3PR01MB9983.jpnprd01.prod.outlook.com>
References: <20250905042751.945616-1-fj1078ii@aa.jp.fujitsu.com>
 <b7c5709f-ee69-3f55-4c37-60ca466e94c8@huawei.com>
In-Reply-To: <b7c5709f-ee69-3f55-4c37-60ca466e94c8@huawei.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 =?utf-8?B?TVNJUF9MYWJlbF8xZTkyZWY3My0wYWQxLTQwYzUtYWQ1NS00NmRlMzM5Njgw?=
 =?utf-8?B?MmZfQWN0aW9uSWQ9MTM0YmQ1MzItNTI1ZS00YmZlLWJkODktZGQ2N2ZjMGFm?=
 =?utf-8?B?ZWU0O01TSVBfTGFiZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFkNTUtNDZkZTMz?=
 =?utf-8?B?OTY4MDJmX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF8xZTkyZWY3My0wYWQx?=
 =?utf-8?B?LTQwYzUtYWQ1NS00NmRlMzM5NjgwMmZfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFkNTUtNDZkZTMzOTY4MDJmX01ldGhv?=
 =?utf-8?B?ZD1Qcml2aWxlZ2VkO01TSVBfTGFiZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFk?=
 =?utf-8?B?NTUtNDZkZTMzOTY4MDJmX05hbWU9RlVKSVRTVS1QVUJMSUPigIs7TVNJUF9M?=
 =?utf-8?B?YWJlbF8xZTkyZWY3My0wYWQxLTQwYzUtYWQ1NS00NmRlMzM5NjgwMmZfU2V0?=
 =?utf-8?B?RGF0ZT0yMDI1LTA5LTI5VDA3OjEzOjQxWjtNU0lQX0xhYmVsXzFlOTJlZjcz?=
 =?utf-8?B?LTBhZDEtNDBjNS1hZDU1LTQ2ZGUzMzk2ODAyZl9TaXRlSWQ9YTE5ZjEyMWQt?=
 =?utf-8?B?ODFlMS00ODU4LWE5ZDgtNzM2ZTI2N2ZkNGM3O01TSVBfTGFiZWxfMWU5MmVm?=
 =?utf-8?B?NzMtMGFkMS00MGM1LWFkNTUtNDZkZTMzOTY4MDJmX1RhZz0xMCwgMCwgMSwg?=
 =?utf-8?Q?1;?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB9983:EE_|OSCPR01MB12721:EE_
x-ms-office365-filtering-correlation-id: 60da548a-df03-4213-72fb-08ddff2907d3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|1580799027|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?Yzh0SGUvUzZVSjhCcjB5UjhzVzNBNjBJNmd0VUhteFZkcjNhcVN5bmxON0JL?=
 =?utf-8?B?anlqYXM5WjgreElGaXhkemVnM0FxcnpqRGcyK01mUFl5YWZSMlVqYkF4eDND?=
 =?utf-8?B?K0ZmL1VDRHhzYVdLTXk2YUJ5WEVxU2ZkeXR5cmxIM1RhZm1mUEV0MDRDY3Nt?=
 =?utf-8?B?dXNnWCtqSzU2cWNoKzRmVlZYb0Z4Y29rU1BraGx3NEk2c1J3aFEvTlhYbE85?=
 =?utf-8?B?QzkxTEhTcVRpY0hJSHdYaU8xNFNZN2Yra2d2QzYzalhUU1NGUG1Id0dOa09F?=
 =?utf-8?B?TEYydEt5K1FGYzVFOCtzWWNhRkFtNXFDUTI0S1VybThUR21FcTZvQ0lHeWFE?=
 =?utf-8?B?RmpyMERvVWVZSGRldW1WUENaTVJrYnBOZlFyQUlGalFiaTNyZ0tPQ3pjOXFO?=
 =?utf-8?B?bmNXQ0VCQUxzRGFPcTBYUDQ3V1dUM2JPWFFOWldXRXVMUHhnNzVrYmNLS2Uw?=
 =?utf-8?B?SFhuMThBcTQ5OTBMc2NVek1INm84dWJBWUdUTWhSMEFLTU9qRWtNblI1d3Ay?=
 =?utf-8?B?RGFWM21VeVpLZjFiK0c3WGRoWUVLeml4QVdIQVc2WVhNWlpXMDhUWmQ3Z2dW?=
 =?utf-8?B?ZUwxQklMT3A1WEJnSitkdmVtRERmUjBCN295SVl0alhsRm9kaXZKRWpLWk1s?=
 =?utf-8?B?aElOWENuTmRFcDRCTjkzNk5pdHQrdlM1TXJONFFMSTVWMUhNejZ2VEpHU0ZT?=
 =?utf-8?B?UStrMVNSK0dFS0ZtUnVxRUVOMHFuR0I3RHlIMWhSN2dwV2RHalZJQytUUzVz?=
 =?utf-8?B?cG9QZHRkUWg0U3NscStqNDJPWEFIdCs5VkxGb1lpWlpBUEpPelRnWk9QNDVr?=
 =?utf-8?B?aXQ0SG5FbHJGaktlUk1ON2NOUUFRZitYRUI5N0t4MlF4dm5abXl5WGk3bzdY?=
 =?utf-8?B?YUxXeEswdmNQSjlSQjlhOUh6dXNpV05JZkxkeGgwUXM2UkFMd2N3VW1PK0tB?=
 =?utf-8?B?aERVcjZzUGU2dDdlZWoxMkhQaTVBRXd5RU40ZFZDa2RobjlCYjUvcWdKdXJM?=
 =?utf-8?B?SmdNTzVGbHJSRHZxZTNRZUszdEdRbThMWXlrbnR2UHhTbTJRclBXdHJGaHlW?=
 =?utf-8?B?Qm9YVDlaVUZxVXBKR1MrT0hrRVpaVSszT0ZwaG5FczZXKy9FRG4zY0R4SXhF?=
 =?utf-8?B?MGh0QXVBUWNFVEVzTHk3d29ZZGdWbFlzb2xlVXhtdXlMUWJOK2RobUR6QlRG?=
 =?utf-8?B?SGdhZDNkcWdOS2VJell2SUNxb3EzYnV5MkUyWiswTGhBQk5WSm1rbUszOUxT?=
 =?utf-8?B?YzR5K09uTVlqMC9sTjRMbGxlTFFhRjU1QldYeThuaGs1ci8rWk9RdFZLV1Za?=
 =?utf-8?B?eW5NM01KZHR6Q0luN1VVS3NPZU5UcXd5M3pHYUVaM3ljR0xyc3huaTRSS3Bn?=
 =?utf-8?B?bkRrSWdxZitsYnE1OFR4VjBqcEIxc1FLamFqRzlJQUpuQnYrMFYrbHc0V25C?=
 =?utf-8?B?Z0VRNkM2TUlUY2F5NmVGK2hyTmJabU9IcFlOZDFWNXMxbmVaZHZqcW9jV3Iy?=
 =?utf-8?B?T3BFSXpDNWJmVVY5NXcrQ0FqQ0JISXdseGJQQmlIVWhCSmdtZ29lRUkvbWRS?=
 =?utf-8?B?UUdlOU5vRXphbS81eDdqdFFKS1ZwaWFxdk40d0RVd3p5anNOVWhEcTlyMDhF?=
 =?utf-8?B?NW9PZjVXOGZRUCtxdjBkN2VMc0Nkc05GdHd6R0YrQTBNcVp1anF3WnhQbDlD?=
 =?utf-8?B?bDZtZDkxck5VTWJtdFdmV3ozLyt2M2dsUDF3SmQzakpGc3B3cTJJNUJqNWRB?=
 =?utf-8?B?aGtTMVppN0VmVVo1NUlOY1JSYmJiK2NWU2hDOCtrdm1tcUQ0TVBocncxaXhP?=
 =?utf-8?B?OFh2N1RyZC9YZTNwTkhaUGFjVS8vbVRMV0N1T1BMalgycVBobWJpSGFZd3Fw?=
 =?utf-8?B?dXpsdUQ5SURVZVRCN2hZSkd4anJGN2cxL1FoWW53TWdvMDdKWURqOFBsTCtl?=
 =?utf-8?B?MGtPMWQ5R1RsZmxzVHprTEhPZndEcU1hV21iUHJocVhUUjFIdzdNSUlxQ2xh?=
 =?utf-8?B?WUV2ZlJkRmlBQUNFamkzN2VBTzZ6V3JUb2o1cEtJVlI3QmdXT1MxU2lrZUVl?=
 =?utf-8?B?aE8vYkc1L3JCblNZMi8rRzExWm0zUjRMVUYzMExBVE9vQTdoNXFneXZSUGFY?=
 =?utf-8?Q?lo8M=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB9983.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(1580799027)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bzBPT1NDbFBhdmEyTkhEZGJsSzR5UWRvbk9QMm9xNUVMZjVUK2JYVTFWbGN3?=
 =?utf-8?B?cXZ1czVmNEt2MFNiWE1EemhOa2VDSWNmZlZabDBaQU5FQUJHUk5rMHh3VkN1?=
 =?utf-8?B?S3krN2V2dGJJSXV0SUxkTitNVVg4cXBiZ1ZNNEF0SVJST2JPa090OG81OFBP?=
 =?utf-8?B?MkFaQjB5dG44MHdUWmtOOFoybVlzeEFKMnBOQ2ZYenVhbEpCMXg2NEdTRXBY?=
 =?utf-8?B?Z254SWVlcXZnYXZZRmNibTdGeE45dVBxMkZscjJ2TDZXQUwvelc1ZFNiRnBn?=
 =?utf-8?B?M0RITzU1c0dsRzFwcWpHYTd6MVUxQldYZUR6aHpKUzNDOFQxY04rMEtGT0ho?=
 =?utf-8?B?dTNxZkJVZmhvRlhPTDlTc0NUOVhreWs0Snp2cmJ5V3ZPZ1J6TzdMYkxzMkhy?=
 =?utf-8?B?ZzYzdkMxM1hDUjhZd2JCdFlYQWw5QytFdlRmdTdxbEwvZFRRZlRxYkFCaWpa?=
 =?utf-8?B?YzJkNXJxNzRFa0NGallzRDBnUk00dlFXbGdMTGpyaHVNZjdzdWdkSk9QM2NT?=
 =?utf-8?B?ekJHS1VWSUV1RzlqcDhRd2F3Y2ZMV0w2ci9GV3IwTmp6V2tsc2VXTC9XN3l5?=
 =?utf-8?B?c1c3R1BQOUc3YWR3ay9UbW5kWFFGb1pJK1k3QTBUZEJMcnZVeGVHQ0pwUGZo?=
 =?utf-8?B?dGpEYlN2NEZQc3lmSnhVYWxERzc1dTJYYjRRSlZBNnpvOHlYb2lEdy9yYzl0?=
 =?utf-8?B?OUt3K29KeVdKRURUUGsxanlXalcrS1VXUGhJVDZ6Y3ZZRXhrNEpmZWdJaXVo?=
 =?utf-8?B?MWhldEt6a281WGwwenF3NWlwZGxVamZQdXJGRWtjYldNaHNndjFjVU55ZEhD?=
 =?utf-8?B?eDMvNDN3SG9sVGJJN0g5Nng2Y2dlaUtQM2JVc3hWL1RJSWRDQlJCcjBoL0NF?=
 =?utf-8?B?VXV2L0pWZWtreGRoOVA2ZzNvdXlHYkxpRE5WSWQwMG1HMnJZS3g2YlpkRFQ2?=
 =?utf-8?B?Sm54bGtvRHN3dkVqL2JWaStldlRVUkRwRHhWMHg1M0wrU3IxdHlickJoQ0VJ?=
 =?utf-8?B?ZkhGMjBkL2RUbDRGVUZXdVlmTm01NmVuMlgrODA4RUk3UHJ2QkpZSVFkemJN?=
 =?utf-8?B?MmZ1WkRIbVFXMHhZZ2FTVks1S3ZHa0ZrS0lXbWdpUWlUYWcxUFZVa1VldVk2?=
 =?utf-8?B?K0VyQU5sZ0dDbVNaVnRMbXRNUlhJbmtvNzJLaGpmRG43dEtiRG5IU2NjNXpB?=
 =?utf-8?B?SW5GNFZzZXJ5cHlQSEdSTDlwY0o2NVBUUWllU0JqRVh6ZU9GQWpYZUdSMGcv?=
 =?utf-8?B?YXNBck9BTWgwRm5raEZjR2t4QlJENFB2aXVycFlUM0daYzFIRTdJald6Zk10?=
 =?utf-8?B?WnNSOC9QNnUxSzFOTTZWdWdCTFJIVFRpdEh6MERZQlMzME9XcWV5TlhMYWpJ?=
 =?utf-8?B?QXFYVEZQRUh1UXozcnUwMjdQZ3NISi8zUE9zK3VldlNCTTBLRU9RRUJxRXhD?=
 =?utf-8?B?OVkvZ0d1S2Q2WFNaczE4d1J0NmVzRENuLys2eGtGRzZlR3NIODNZV1VNQk5T?=
 =?utf-8?B?VUVaaWdKNDRLckIxYzBqSXR5a0pIc3lGQXJ4dFB3d3hHT1gxY2ZYNnJEOVAv?=
 =?utf-8?B?eitwZG5rNUZ4MDNNR0ZCOHc4dEZLZm9uSzFGZ0RsQXI5YWFkd3hQUyt1WEx6?=
 =?utf-8?B?cGY2ZmwrS0t1SE9BMVMxWldrL21TcjJ2Q1dlNE4yL2FTV29QRUVGSEdIaC91?=
 =?utf-8?B?ZTVUUmxOdVZ4ckFBa1Qvb2dPRkJkY2w5RlVoK0ZweXB4d3hIbDZBTWZMazVG?=
 =?utf-8?B?bThLNWwvWUoyZ3ZCODI2U09PQVZtT1B3THMyUFlHTG42elFOK3VVUlFuVVVq?=
 =?utf-8?B?NVd6VG14MkNDVjlUVlNlSHphN0Z4RUFmbzdHc2RNZm9raEd2V2RrVWZWV1py?=
 =?utf-8?B?ZTMrRWJCakh4VW9Cb2FRSnVtdktyY3k4clFlYmNhL29pd3k1VE5sU3U0T3Bt?=
 =?utf-8?B?TVRSL0VhZUVPYVFsWmsyekxUMmw0d1pMc0xjYnhzNkpnd21KSW9FYmhNQUhq?=
 =?utf-8?B?dzdPQ2RZbXAvK3dLZ0YwakU3WkRMRWZ2K2ovMXQ1MFpvT3VJMHE4OExDMTBa?=
 =?utf-8?B?dFlWVXByQ2w0ZWppS2RYcDhPMlhwd2VCbjNhWjRSdnJucWFiVXdXeE91K1pm?=
 =?utf-8?B?NW13SGQvLzc0aURTTEZyeVprNmJTK0crV2UvUmFLTWFKM29NZFFyalBaYnJO?=
 =?utf-8?B?dmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	W/dK6Rq39x3Gerqin3dR+WnyHegYPG8/wjd+rfMCYlOZF3SmKPkE49EhvNamHVuAgVm1ZJ7AEiOOQ6Zss82aHw+wEAScVISn1CPkRLita4uDlhP6n8Ilg+YR3CH3FwkY8BYj5hO1lIrJoOkOvf2I1eQCoCMk335KYKNXkqhZNhVAPNkhsTF8hOHlhAmOsvmtLxyg/pMHCzycNqRW/hmYqcFWsAN3HKAwyYmDKvyXHTI8pNwlS6nLp17AenIuIBPSPC3Je3Y9TKBZdc6CDtGi+h88nGoHWP5QUzc7zdIcEHmJVBsOcL+hv6knxFIcMMf1MRJ4D3s+UV46jnAqv1k71tdFcOvKDOguNqEkYQMxwW1oWoQCsBPZDzx6zOrvAkt2c1PsgmEe8dawP2xeFqKYCGNdj1hWSR23GifKptIiGnaC39+AEDH77wmnwaiaUfgE/9tAWh1xhtnxjmJlZHrKthKpul+vfiC2hzEpJIIAlTZ4cEbxFz1zePmnTx0/apjFJKYs0F8f9SCNZPrwVLShIDNfIdYNDG4G73WdFMHzC5dMw4uxQGrNaZ1BTo8ogNZgpWj/aY4iJj/zK2W2FgY1Y3Jd0X2l5+2E51hjRw89CPX6pK3Ew+7XishvIpbefsy6
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB9983.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60da548a-df03-4213-72fb-08ddff2907d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2025 07:23:04.6356
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kQoCeJi+xVhvQmfIORuGlzOWrOdyGY3ECHIR8tocu9dgBUWeKebPLNuGAkbIFt41xWnGEeKXCAAtjkDAyuXsX12WREmETH945OoOohwA7ug=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB12721

SGkgSGFuanVuLA0KDQpUaGFuayB5b3UgZm9yIHlvdXIgcmV2aWV3Lg0KDQo+IEhpIEthenVoaXJv
LA0KPiANCj4gU29ycnkgZm9yIHRoZSBsYXRlIHJlcGx5LCBzb21lIGNvbW1lbnRzIGJlbG93Lg0K
PiANCj4gT24gMjAyNS85LzUgMTI6MjcsIEthenVoaXJvIEFiZSB3cm90ZToNCj4gPiBBR0RJIGhh
cyB0d28gdHlwZXMgb2Ygc2lnbmFsaW5nIG1vZGVzOiBTREVJIGFuZCBpbnRlcnJ1cHQuDQo+ID4g
Q3VycmVudGx5LCB0aGUgQUdESSBkcml2ZXIgb25seSBzdXBwb3J0cyBTREVJLg0KPiA+IFRoZXJl
Zm9yZSwgYWRkIHN1cHBvcnQgZm9yIGludGVycnVwdCBzaWduYWxpbmcgbW9kZSBUaGUgaW50ZXJy
dXB0DQo+ID4gdmVjdG9yIGlzIHJldHJpZXZlZCBmcm9tIHRoZSBBR0RJIHRhYmxlLCBhbmQgY2Fs
bCBwYW5pYyBmdW5jdGlvbiB3aGVuDQo+ID4gYW4gaW50ZXJydXB0IG9jY3Vycy4NCj4gPg0KPiA+
IFNpZ25lZC1vZmYtYnk6IEthenVoaXJvIEFiZSA8ZmoxMDc4aWlAYWEuanAuZnVqaXRzdS5jb20+
DQo+ID4gLS0tDQo+ID4gSSBrZWVwIG5vcm1hbCBJUlEgY29kZSB3aGVuIE5NSSBjYW5ub3QgYmUg
dXNlZC4NCj4gPiBJZiB0aGVyZSBpcyBhbnkgY29uY2VybiwgcGxlYXNlIGxldCBtZSBrbm93Lg0K
PiA+DQo+ID4gdjItPnYzDQo+ID4gICAtIEZpeCBidWcgaW4gdGhlIHJldHVybiB2YWx1ZSBvZiBh
Z2RpX3Byb2JlIGZ1bmN0aW9uLg0KPiA+ICAgLSBSZW1vdmUgdW5uZWNlc3NhcnkgY3VybHkgYnJh
Y2VzIGluIHRoZSBhZ2RpX3JlbW92ZSBmdW5jdGlvbi4NCj4gPg0KPiA+IHYyOg0KPiA+IGh0dHBz
Oi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDI1MDgyOTEwMTE1NC4yMzc3ODAwLTEtZmoxMDc4aWlA
YWEuanAuZnUNCj4gPiBqaXRzdS5jb20vDQo+ID4gdjEtPnYyDQo+ID4gICAtIFJlbW92ZSBhY3Bp
Y2EgdXBkYXRlIHNpbmNlIHRoZXJlIGlzIG5vIG5lZWQgdG8gdXBkYXRlIGRlZmluZSB2YWx1ZQ0K
PiA+ICAgICBmb3IgdGhpcyBwYXRjaC4NCj4gPiAtLS0NCj4gPiAgIGRyaXZlcnMvYWNwaS9hcm02
NC9hZ2RpLmMgfCA5NQ0KPiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0N
Cj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCA4OCBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQ0K
PiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvYWNwaS9hcm02NC9hZ2RpLmMgYi9kcml2ZXJz
L2FjcGkvYXJtNjQvYWdkaS5jDQo+ID4gaW5kZXggZTBkZjNkYWE0YWJmLi4yMzEzYTQ2ZjAxY2Qg
MTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9hY3BpL2FybTY0L2FnZGkuYw0KPiA+ICsrKyBiL2Ry
aXZlcnMvYWNwaS9hcm02NC9hZ2RpLmMNCj4gPiBAQCAtMTYsNyArMTYsMTEgQEANCj4gPiAgICNp
bmNsdWRlICJpbml0LmgiDQo+ID4NCj4gPiAgIHN0cnVjdCBhZ2RpX2RhdGEgew0KPiA+ICsJdW5z
aWduZWQgY2hhciBmbGFnczsNCj4gDQo+IEFkZGluZyBhIGNvbW1lbnQgaGVyZSBmb3Igd2hhdCdz
IHRoZSBmYWxncyB1c2VkIGZvciwgbXVsdGkgZmxhZ3MgaW4gdGhpcyBmaWxlIHN1Y2ggYXMNCj4g
aXJxX2ZsYWdzLCBqdXN0IG1ha2UgdGhlIGNvZGUgZWFzeSB0byB1bmRlcnN0YW5kLg0KDQpVbmRl
cnN0b29kLg0KSSB3aWxsIGFkZCB0aGUgZm9sbG93aW5nIGNvbW1lbnQ6DQp1bnNpZ25lZCBjaGFy
IGZsYWdzOyAvKiBBR0RJIFNpZ25hbGluZyBNb2RlICgwPVNERUktYmFzZWQsIDE9SW50ZXJydXB0
LWJhc2VkKSAqLw0KDQo+IA0KPiA+ICAgCWludCBzZGVpX2V2ZW50Ow0KPiA+ICsJdW5zaWduZWQg
aW50IGdzaXY7DQo+ID4gKwlib29sIHVzZV9ubWk7DQo+ID4gKwlpbnQgaXJxOw0KPiA+ICAgfTsN
Cj4gPg0KPiA+ICAgc3RhdGljIGludCBhZ2RpX3NkZWlfaGFuZGxlcih1MzIgc2RlaV9ldmVudCwg
c3RydWN0IHB0X3JlZ3MgKnJlZ3MsDQo+ID4gdm9pZCAqYXJnKSBAQCAtNDgsNiArNTIsNTUgQEAg
c3RhdGljIGludCBhZ2RpX3NkZWlfcHJvYmUoc3RydWN0DQo+IHBsYXRmb3JtX2RldmljZSAqcGRl
diwNCj4gPiAgIAlyZXR1cm4gMDsNCj4gPiAgIH0NCj4gPg0KPiA+ICtzdGF0aWMgaXJxcmV0dXJu
X3QgYWdkaV9pbnRlcnJ1cHRfaGFuZGxlcl9ubWkoaW50IGlycSwgdm9pZCAqZGV2X2lkKQ0KPiA+
ICt7DQo+ID4gKwlubWlfcGFuaWMoTlVMTCwgIkFybSBHZW5lcmljIERpYWdub3N0aWMgRHVtcCBh
bmQgUmVzZXQgTk1JDQo+IEludGVycnVwdCBldmVudCBpc3N1ZWRcbiIpOw0KPiA+ICsJcmV0dXJu
IElSUV9IQU5ETEVEOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICtzdGF0aWMgaXJxcmV0dXJuX3QgYWdk
aV9pbnRlcnJ1cHRfaGFuZGxlcl9pcnEoaW50IGlycSwgdm9pZCAqZGV2X2lkKQ0KPiA+ICt7DQo+
ID4gKwlwYW5pYygiQXJtIEdlbmVyaWMgRGlhZ25vc3RpYyBEdW1wIGFuZCBSZXNldCBJbnRlcnJ1
cHQgZXZlbnQNCj4gaXNzdWVkXG4iKTsNCj4gPiArCXJldHVybiBJUlFfSEFORExFRDsNCj4gPiAr
fQ0KPiA+ICsNCj4gPiArc3RhdGljIGludCBhZ2RpX2ludGVycnVwdF9wcm9iZShzdHJ1Y3QgcGxh
dGZvcm1fZGV2aWNlICpwZGV2LA0KPiA+ICsJCQkJc3RydWN0IGFnZGlfZGF0YSAqYWRhdGEpDQo+
ID4gK3sNCj4gPiArCXVuc2lnbmVkIGxvbmcgaXJxX2ZsYWdzOw0KPiA+ICsJaW50IHJldDsNCj4g
PiArCWludCBpcnE7DQo+ID4gKw0KPiA+ICsJaXJxID0gYWNwaV9yZWdpc3Rlcl9nc2koTlVMTCwg
YWRhdGEtPmdzaXYsIEFDUElfRURHRV9TRU5TSVRJVkUsDQo+IEFDUElfQUNUSVZFX0hJR0gpOw0K
PiA+ICsJaWYgKGlycSA8IDApIHsNCj4gPiArCQlkZXZfZXJyKCZwZGV2LT5kZXYsICJjYW5ub3Qg
cmVnaXN0ZXIgR1NJIyVkICglZClcbiIsDQo+IGFkYXRhLT5nc2l2LCBpcnEpOw0KPiA+ICsJCXJl
dHVybiBpcnE7DQo+ID4gKwl9DQo+ID4gKw0KPiA+ICsJaXJxX2ZsYWdzID0gSVJRRl9QRVJDUFUg
fCBJUlFGX05PQkFMQU5DSU5HIHwgSVJRRl9OT19BVVRPRU4gfA0KPiA+ICsJCSAgICBJUlFGX05P
X1RIUkVBRDsNCj4gPiArCS8qIHRyeSBOTUkgZmlyc3QgKi8NCj4gPiArCXJldCA9IHJlcXVlc3Rf
bm1pKGlycSwgJmFnZGlfaW50ZXJydXB0X2hhbmRsZXJfbm1pLCBpcnFfZmxhZ3MsDQo+ID4gKwkJ
CSAgImFnZGlfaW50ZXJydXB0X25taSIsIE5VTEwpOw0KPiA+ICsJaWYgKHJldCkgew0KPiA+ICsJ
CXJldCA9IHJlcXVlc3RfaXJxKGlycSwgJmFnZGlfaW50ZXJydXB0X2hhbmRsZXJfaXJxLA0KPiA+
ICsJCQkJICBpcnFfZmxhZ3MsICJhZ2RpX2ludGVycnVwdF9pcnEiLCBOVUxMKTsNCj4gPiArCQlp
ZiAocmV0KSB7DQo+ID4gKwkJCWRldl9lcnIoJnBkZXYtPmRldiwgImNhbm5vdCByZWdpc3RlciBJ
UlEgJWRcbiIsIHJldCk7DQo+ID4gKwkJCWFjcGlfdW5yZWdpc3Rlcl9nc2koYWRhdGEtPmdzaXYp
Ow0KPiA+ICsJCQlyZXR1cm4gcmV0Ow0KPiA+ICsJCX0NCj4gPiArCQllbmFibGVfaXJxKGlycSk7
DQo+ID4gKwkJYWRhdGEtPmlycSA9IGlycTsNCj4gPiArCX0gZWxzZSB7DQo+ID4gKwkJZW5hYmxl
X25taShpcnEpOw0KPiA+ICsJCWFkYXRhLT5pcnEgPSBpcnE7DQo+ID4gKwkJYWRhdGEtPnVzZV9u
bWkgPSB0cnVlOw0KPiA+ICsJfQ0KPiANCj4gaWYgKCFyZXQpIHsNCj4gCS8qIE5NSSBoYW5kbGlu
ZyBjb2RlICovDQo+IH0NCj4gDQo+IC8qIFRoZW4gdHJ5IG5vcm1hbCBpbnRlcnJ1cHQgKi8NCj4g
cmV0ID0gcmVxdWVzdF9pcnEoKTsNCj4gLi4uDQo+IA0KPiBUaGlzIG1ha2VzIGNvZGUgYmV0dGVy
IG9yZ2FuaXplZC4NCg0KVW5kZXJzdG9vZC4gSSB3aWxsIGZpeCBpdCBmb3IgYmV0dGVyIG9yZ2Fu
aXphdGlvbiBhcyB5b3Ugc3VnZ2VzdGVkLg0KDQoNCj4gDQo+ID4gKw0KPiA+ICsJcmV0dXJuIDA7
DQo+ID4gK30NCj4gPiArDQo+ID4gICBzdGF0aWMgaW50IGFnZGlfcHJvYmUoc3RydWN0IHBsYXRm
b3JtX2RldmljZSAqcGRldikNCj4gPiAgIHsNCj4gPiAgIAlzdHJ1Y3QgYWdkaV9kYXRhICphZGF0
YSA9IGRldl9nZXRfcGxhdGRhdGEoJnBkZXYtPmRldik7IEBAIC01NSwxMg0KPiA+ICsxMDgsMTUg
QEAgc3RhdGljIGludCBhZ2RpX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+
ID4gICAJaWYgKCFhZGF0YSkNCj4gPiAgIAkJcmV0dXJuIC1FSU5WQUw7DQo+ID4NCj4gPiAtCXJl
dHVybiBhZ2RpX3NkZWlfcHJvYmUocGRldiwgYWRhdGEpOw0KPiA+ICsJaWYgKGFkYXRhLT5mbGFn
cyAmIEFDUElfQUdESV9TSUdOQUxJTkdfTU9ERSkNCj4gPiArCQlyZXR1cm4gYWdkaV9pbnRlcnJ1
cHRfcHJvYmUocGRldiwgYWRhdGEpOw0KPiA+ICsJZWxzZQ0KPiA+ICsJCXJldHVybiBhZ2RpX3Nk
ZWlfcHJvYmUocGRldiwgYWRhdGEpOw0KPiA+ICAgfQ0KPiA+DQo+ID4gLXN0YXRpYyB2b2lkIGFn
ZGlfcmVtb3ZlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ID4gK3N0YXRpYyB2b2lk
IGFnZGlfc2RlaV9yZW1vdmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldiwNCj4gPiArCQkJ
ICAgICBzdHJ1Y3QgYWdkaV9kYXRhICphZGF0YSkNCj4gPiAgIHsNCj4gPiAtCXN0cnVjdCBhZ2Rp
X2RhdGEgKmFkYXRhID0gZGV2X2dldF9wbGF0ZGF0YSgmcGRldi0+ZGV2KTsNCj4gPiAgIAlpbnQg
ZXJyLCBpOw0KPiA+DQo+ID4gICAJZXJyID0gc2RlaV9ldmVudF9kaXNhYmxlKGFkYXRhLT5zZGVp
X2V2ZW50KTsNCj4gPiBAQCAtODMsNiArMTM5LDI5IEBAIHN0YXRpYyB2b2lkIGFnZGlfcmVtb3Zl
KHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ID4gICAJCQlhZGF0YS0+c2RlaV9ldmVu
dCwgRVJSX1BUUihlcnIpKTsNCj4gPiAgIH0NCj4gPg0KPiA+ICtzdGF0aWMgdm9pZCBhZ2RpX2lu
dGVycnVwdF9yZW1vdmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldiwNCj4gPiArCQkJCSAg
c3RydWN0IGFnZGlfZGF0YSAqYWRhdGEpDQo+ID4gK3sNCj4gPiArCWlmIChhZGF0YS0+aXJxICE9
IC0xKSB7DQo+ID4gKwkJaWYgKGFkYXRhLT51c2Vfbm1pKQ0KPiA+ICsJCQlmcmVlX25taShhZGF0
YS0+aXJxLCBOVUxMKTsNCj4gPiArCQllbHNlDQo+ID4gKwkJCWZyZWVfaXJxKGFkYXRhLT5pcnEs
IE5VTEwpOw0KPiA+ICsNCj4gPiArCQlhY3BpX3VucmVnaXN0ZXJfZ3NpKGFkYXRhLT5nc2l2KTsN
Cj4gPiArCX0NCj4gDQo+IGlmIChhZGF0YS0+aXJxID09IC0xKQ0KPiAJcmV0dXJuOw0KPiANCj4g
Li4uDQo+IA0KPiBUbyBzYXZlIGV4dHJhIHsgfS4NCg0KVW5kZXJzdG9vZC4gSSB3aWxsIGZpeCBp
dCBhcyBzdWdnZXN0ZWQuDQoNCg0KPiANCj4gPiArfQ0KPiA+ICsNCj4gPiArc3RhdGljIHZvaWQg
YWdkaV9yZW1vdmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikgew0KPiA+ICsJc3RydWN0
IGFnZGlfZGF0YSAqYWRhdGEgPSBkZXZfZ2V0X3BsYXRkYXRhKCZwZGV2LT5kZXYpOw0KPiA+ICsN
Cj4gPiArCWlmIChhZGF0YS0+ZmxhZ3MgJiBBQ1BJX0FHRElfU0lHTkFMSU5HX01PREUpDQo+ID4g
KwkJYWdkaV9pbnRlcnJ1cHRfcmVtb3ZlKHBkZXYsIGFkYXRhKTsNCj4gPiArCWVsc2UNCj4gPiAr
CQlhZ2RpX3NkZWlfcmVtb3ZlKHBkZXYsIGFkYXRhKTsNCj4gPiArfQ0KPiA+ICsNCj4gPiAgIHN0
YXRpYyBzdHJ1Y3QgcGxhdGZvcm1fZHJpdmVyIGFnZGlfZHJpdmVyID0gew0KPiA+ICAgCS5kcml2
ZXIgPSB7DQo+ID4gICAJCS5uYW1lID0gImFnZGkiLA0KPiA+IEBAIC05NCw3ICsxNzMsNyBAQCBz
dGF0aWMgc3RydWN0IHBsYXRmb3JtX2RyaXZlciBhZ2RpX2RyaXZlciA9IHsNCj4gPiAgIHZvaWQg
X19pbml0IGFjcGlfYWdkaV9pbml0KHZvaWQpDQo+ID4gICB7DQo+ID4gICAJc3RydWN0IGFjcGlf
dGFibGVfYWdkaSAqYWdkaV90YWJsZTsNCj4gPiAtCXN0cnVjdCBhZ2RpX2RhdGEgcGRhdGE7DQo+
ID4gKwlzdHJ1Y3QgYWdkaV9kYXRhIHBkYXRhID0gezB9Ow0KPiANCj4gc3RydWN0IGFnZGlfZGF0
YSBwZGF0YSA9IHsgMCB9Ow0KDQpVbmRlcnN0b29kLCBJJ2xsIGRvIHRoYXQuDQoNCg0KQmVzdCBS
ZWdhcmRzLA0KS2F6dWhpcm8gQWJlDQoNCj4gDQo+IFRoYW5rcw0KPiBIYW5qdW4NCg==

