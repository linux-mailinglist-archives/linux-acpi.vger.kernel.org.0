Return-Path: <linux-acpi+bounces-18895-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D097BC5BF82
	for <lists+linux-acpi@lfdr.de>; Fri, 14 Nov 2025 09:22:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 34B824E4593
	for <lists+linux-acpi@lfdr.de>; Fri, 14 Nov 2025 08:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 086892F6598;
	Fri, 14 Nov 2025 08:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="Jenw6sgT"
X-Original-To: linux-acpi@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011028.outbound.protection.outlook.com [52.101.125.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40602E0902;
	Fri, 14 Nov 2025 08:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763108482; cv=fail; b=NTLtoAXxkCcojJnROVrSxQgJ8bqsZTDlxjuy9qZLw9dNK54UJ8o6HYe+WQrRa89ygB2y6DkYO6skDBMU4rXPYEMHcGaK7egrzFdvZCzUQiL72qkaaCVFZ2/wZRVJ9ToikGV7f5e73Z+UTYG7FwmkTVsNPV1rTGrcUQJ3LN71a1A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763108482; c=relaxed/simple;
	bh=pAv0lsSdiMwI4SVvkxwKS2OENHaex0zfOL3Fn2mtngI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LgLiqPmY/hDCctfW7BmOs5rJCQ3+4vtTstUJYCvstyIbUxVxV8Y+ONDMzVmX36tcsRceX029ZoAQjbSIVxLMfniNBHgE0fIyxPMr8n/8Z2aNGbLzKLv7FnXxfHkVRYRixOyNnjlD1D4k+28UkqsNmYCjrGWkixg8EH4YRE1Wc60=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=Jenw6sgT; arc=fail smtp.client-ip=52.101.125.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YZemSL3tu8IQbBuNjA3NcRDJSIJv/FdRJmlQcab2KxRIr5JSIvAvLiTr5a0P/3ygyIJIBgLFw+wuMXwnZdcN08gaL8vDPy5cInu4E2jXIpVF/Ky/HEBRfyWe9PI3XaBz/nPMY35shdIWvJlDO1BcqDjIzcKjsSYofB59x/huC7bat5K6dpSdddVK4rh2vgyIONs1eTw2XMnT9H+ckJQ115Du9xttnUCRlLHCOE7o2sZQOTB+6jtlbOBiZftZl8OjSycfUgVRXQZodwdtwdK1Zn15vkhhSw4AlckKgEjNWRrt2Z4H7pus/9IlOg1KYCsQaJpb0/nDaxEQPMhIacaABA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pAv0lsSdiMwI4SVvkxwKS2OENHaex0zfOL3Fn2mtngI=;
 b=Ch+I1O2NwbxulNK9O7NArgWgmytxjX2izqJkWFOX5MxB32/h1kd1s8X0QTiGZnJCa7FrZmHG8SZOUloouIEnSldUQbKeHrCLBaQdCd4xgaQF6cocsN6eYBgNIuWMNIYedBXe8dVxxhuTFxe9+K/aajHHGuk3rQYf1Adzl/rQgy6hCKRF6BgWbFaMx2SW3uzNh+CJzGk6JKR/QHRL2a4EM+O7V98V6G6VN3GuF/F9SmPrkft2T6GsDIhj02j6dsd4aviC+I7ZrAienVkJbOEoY2C5wAljFtxDO9mA1hUg+52OzZaQeDFhkTEEVJzy89uDlKZRsGDd24qZN6fB8FzP7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pAv0lsSdiMwI4SVvkxwKS2OENHaex0zfOL3Fn2mtngI=;
 b=Jenw6sgTAws56cF+qSEp9esDK1k4Y3RKvBoTRrLIa/sq0QjvlFFI0t9DK4nBjtg6GGMQVPeKImtl+MAd4MXUGrcAWrgVzflBTEXSbpjyGo2+lvAKkrFAND9NqRSLqFYFVpBju/sGbE0p/u/s9Q08SFKOMRZ/4YsiuqgqPexWolgxVY9E3eOo+jk+gBFZzDt43Y5Ih4tz0IPmdd87g5i40J4EevJax6OQIL3p25px6dzAEwLF8TurBEI1sN1aDWiZhmy77zm78nnmvQWCfMrpVvuWVTM+NkG2jUue8odO4BhRKlqs8uYi6qDRuPQd4Ahbxhgxh1ielakMTQCCOREkdQ==
Received: from OSCPR01MB16310.jpnprd01.prod.outlook.com (2603:1096:604:3f2::7)
 by TYWPR01MB11235.jpnprd01.prod.outlook.com (2603:1096:400:3f5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Fri, 14 Nov
 2025 08:21:18 +0000
Received: from OSCPR01MB16310.jpnprd01.prod.outlook.com
 ([fe80::e24:9479:a7d0:366a]) by OSCPR01MB16310.jpnprd01.prod.outlook.com
 ([fe80::e24:9479:a7d0:366a%5]) with mapi id 15.20.9320.013; Fri, 14 Nov 2025
 08:21:18 +0000
From: "Kazuhiro Abe (Fujitsu)" <fj1078ii@fujitsu.com>
To: 'Charles Mirabile' <cmirabil@redhat.com>
CC: "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "Koichi Okuno
 (Fujitsu)" <fj2767dz@fujitsu.com>, "guohanjun@huawei.com"
	<guohanjun@huawei.com>, "ilkka@os.amperecomputing.com"
	<ilkka@os.amperecomputing.com>, "lenb@kernel.org" <lenb@kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>, "rafael@kernel.org" <rafael@kernel.org>,
	"sudeep.holla@arm.com" <sudeep.holla@arm.com>, "will@kernel.org"
	<will@kernel.org>
Subject: RE: [PATCH v4] ACPI: AGDI: Add interrupt signaling mode support
Thread-Topic: [PATCH v4] ACPI: AGDI: Add interrupt signaling mode support
Thread-Index:
 AQHcPzk5+UU2j3z+uUO7itsPcFLu87TLCuOAgBfAiwCAAiHCgIAGvGIwgAL1hYCAA1oxoA==
Date: Fri, 14 Nov 2025 08:21:17 +0000
Message-ID:
 <OSCPR01MB16310F566905156A462CE3727D5CAA@OSCPR01MB16310.jpnprd01.prod.outlook.com>
References:
 <OSAPR01MB7669F9B9E145A50B38819E13D5CEA@OSAPR01MB7669.jpnprd01.prod.outlook.com>
 <20251112044239.4049011-1-cmirabil@redhat.com>
In-Reply-To: <20251112044239.4049011-1-cmirabil@redhat.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 =?utf-8?B?TVNJUF9MYWJlbF8xZTkyZWY3My0wYWQxLTQwYzUtYWQ1NS00NmRlMzM5Njgw?=
 =?utf-8?B?MmZfQWN0aW9uSWQ9ZDUxYzhkMzctYzc2Yi00N2Y4LTkxOGEtZDk5YzhjNGY4?=
 =?utf-8?B?OTY3O01TSVBfTGFiZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFkNTUtNDZkZTMz?=
 =?utf-8?B?OTY4MDJmX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF8xZTkyZWY3My0wYWQx?=
 =?utf-8?B?LTQwYzUtYWQ1NS00NmRlMzM5NjgwMmZfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFkNTUtNDZkZTMzOTY4MDJmX01ldGhv?=
 =?utf-8?B?ZD1Qcml2aWxlZ2VkO01TSVBfTGFiZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFk?=
 =?utf-8?B?NTUtNDZkZTMzOTY4MDJmX05hbWU9RlVKSVRTVS1QVUJMSUPigIs7TVNJUF9M?=
 =?utf-8?B?YWJlbF8xZTkyZWY3My0wYWQxLTQwYzUtYWQ1NS00NmRlMzM5NjgwMmZfU2V0?=
 =?utf-8?B?RGF0ZT0yMDI1LTExLTE0VDA3OjU0OjMwWjtNU0lQX0xhYmVsXzFlOTJlZjcz?=
 =?utf-8?B?LTBhZDEtNDBjNS1hZDU1LTQ2ZGUzMzk2ODAyZl9TaXRlSWQ9YTE5ZjEyMWQt?=
 =?utf-8?B?ODFlMS00ODU4LWE5ZDgtNzM2ZTI2N2ZkNGM3O01TSVBfTGFiZWxfMWU5MmVm?=
 =?utf-8?B?NzMtMGFkMS00MGM1LWFkNTUtNDZkZTMzOTY4MDJmX1RhZz0xMCwgMCwgMSwg?=
 =?utf-8?Q?1;?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSCPR01MB16310:EE_|TYWPR01MB11235:EE_
x-ms-office365-filtering-correlation-id: 529beb25-d4d4-46e7-ebb5-08de2356c900
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|7416014|1580799027|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?L3hUV3JXMTBXWU1GdndpZ2V1L2h5MjY2ZWx1cjMxS1RzbXhpNzd6azEyWG5w?=
 =?utf-8?B?YUlMN2lRb2R0R3lYaURFYTJpb0pDZld6cFZpSUxUK1Vib1pmZG9xZmQwZjIz?=
 =?utf-8?B?TlpZV2FFN2VTQ2NiUEt4Q2RKVkp5Q0ZIMTdSMk1DU3NJeHJqZUliRmlNNGRO?=
 =?utf-8?B?Wk5oUU1Yc09lVTk4c29YU2dXVWM5QUhXejhmc3lJa0o3N1dyUXQwYzNKS3dX?=
 =?utf-8?B?NHFwVlpLdEx1YnRSbGo5U1BuSGlBYzdLWjNvNWEwVEIwMkNldDlhTGtNalFQ?=
 =?utf-8?B?akc4cWt0RlhYV0xKWDVrMVlIZVcvVmMvR1pjckVVayswUXNhNzlISlEyVmIv?=
 =?utf-8?B?RXZsUlBHKzgrTUhwOXVNOFMySjVNeFBHSE11VDFXZVhCNlJYbWdqYkhuK1VX?=
 =?utf-8?B?b29TVTluUVZ0MEJMMy9IbEEzelNZblVscDBpMjZoUHYwSEFwUG9JM0F4eWNH?=
 =?utf-8?B?eGpRc2Z1LzRvZkU1VVhxY2VmSTVsSyttQVUwRXNmNG1JZ2NSV0MzVk1ORmFO?=
 =?utf-8?B?MVB2OHJQS1FYM0thUEIyU2w2cUhZSHBhUXd5cG9acTJjZ2JvdTRuMGcvRWp2?=
 =?utf-8?B?QjEzR25oQmY4OGRpUUNjdGs0SXNUMVg0enJKOWNiM2E2ZG1Ock5OT2ZRdzEr?=
 =?utf-8?B?RkVPZW53R1ZRcVBUWXhjbTJ2dVRpN1RXQ0RtT2RVL3l3LzRDd05PL0VDVnJL?=
 =?utf-8?B?bGRubG1OOTNSQmZtd1QzakN3NTJ3TWtXczZVSVVaeGowV1psRk5ieHBha01O?=
 =?utf-8?B?elRNQWlxVHFuTEgwNzMrNXVqWk1ULzNXeDhOOWl3d25nVDdRYnRMbFhyaTZl?=
 =?utf-8?B?TS9nYk0xVjFVdGFlcXdSVEFNQlpVeElhWS9EWlovbGVKZ1lWODBDckh0cis3?=
 =?utf-8?B?ZUw1OWZ4TndSMTJSaEZZZUNMRzNIaitSTlQ3bjdrdVl0YlR1eUpMMk5WMHZO?=
 =?utf-8?B?M2wrdGlYd0k0b01nckcrSkttdFViMmpRWEZtQ1dqZ1J2dU9DMlYxNm1ZVzZl?=
 =?utf-8?B?aU9lanQvakhJRVljczJ2ZndPbWNKcG1VbDF0N1JZRHI1eUJFekt0Z2lIZ2g5?=
 =?utf-8?B?QUxtRUEzaUZZaU96M1UvK29KMVpQNGppbEN0MFk0Q3R5YzRVVHNUZFFVdVpD?=
 =?utf-8?B?UkNKbWxjUXRnZ3h2V0pXeGpNNnhlR0tNSEVqOUE0NTFESXVuWHhHd0JEbTRS?=
 =?utf-8?B?M1pKcmhWVGtOaFVnV084NEhBWVFyb01FNmxxOXZMK3l1aDJydGNPbDFhT25H?=
 =?utf-8?B?anVLVnlnSC9vTjZmQWNXZEVVREFRUFV5MnMwaFZLeUdoajViU2p0WENISmlY?=
 =?utf-8?B?UTByOXRBTUdDM1NKL0NPNjQ4d3pwak4wS0dVYkNsL0VhVWlaTUNtZURBSkVk?=
 =?utf-8?B?VkFtTGpqTWdFZVc3Qk96V3pEY1dVc2Q0RWdseksvZXZKTjdFZWI0S1BNN3Nj?=
 =?utf-8?B?L1c1cmJ5VmhROFVmc2p1ZmJEaW5tejJpWkxmMEdlSmN4ai8wdkd3dVBnL3BQ?=
 =?utf-8?B?NlhteUtncUVnUkhtSkhZMTRzKy9XN0x6VWY0dERJNlF3a0lvVktUZW1Qa0NO?=
 =?utf-8?B?VXFWd2NWQUl2MkRwV1Fha1grUi9wQ0VjbytmdWFpOVdDNGN2L3ZCZnZhUkpu?=
 =?utf-8?B?a3E0eDFVSDBWQ3A3R1lubExmWDJldUo2MlNFc0o3aFVpc2F3M083SHRqUlIz?=
 =?utf-8?B?cG4yWFl6SE1EK0Q1R0pONDBEdWdNeHFFRHVITWNSMjNZUGE3WFN0eTI1U1Bn?=
 =?utf-8?B?VVYreXhnKzk0Q2NsaG5aRlA4bjNEd2MwbmtwZnNWTU41V2ZNR20yM0VOUXhQ?=
 =?utf-8?B?aGtSNzRxYURUcURScDVhbzk5OHhORzdXQkJNZE1GcVJHNDRPYXhjbmJRN3Zq?=
 =?utf-8?B?dklCQit6YVdhTWhnbGtwSml4WHp5NC9lL2NjTlR1UEw5SVVwdmF2SXprRno0?=
 =?utf-8?B?eGwvcjJoKzlaVnhWNmZIS2FXQ2RpN2JUeDgxbDhPSzdJWGZzV2w1a1lwQkJQ?=
 =?utf-8?B?OXZwbzZLZ1lQcGFCSWRKWm1mcVlycHEzOHVTaFRuTXNjbnFHR0VCY21ML0ll?=
 =?utf-8?B?djFTTnQ3LzlnZk9SVncxNXJQdkNadDFYYmVyQT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSCPR01MB16310.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014)(1580799027)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WGY4enlscUVCZnRqcUQ3NVBHTE5wUVVocWpwSHlBd1lHbHg4ZlFOb3hNOEdk?=
 =?utf-8?B?ZDd4YzlkelVjV2Jncm5raHhGYkdyVXVnVGdaeis4anZRVGkzK1hVSllyMyto?=
 =?utf-8?B?WmRiaXJBU0dobDFCYXBGcE1wUjdqTUdnTVBhZUMxWWR5VmovMURLdlFVYXNB?=
 =?utf-8?B?ZlN1MC94TjRqRzNoTDVwb0lpazZkMnhzQnlDdDhsYUZRaXI4QUwzeE1yckZR?=
 =?utf-8?B?dTI4RUo2RkF5TVk1dDZwRVdOb1Z5VjhndFFnbDc5ZThxcGtiR1BGd2tMM1U0?=
 =?utf-8?B?WDArbENyUjFnbUFtTWI4REF1UDZjMmQ5RXRWV2NsTEl6ZjF1TU9JYWlPRDdU?=
 =?utf-8?B?c2ErbUkyVUQzWDFpQktYakRwTExUekRvcFMybkdjUS92ZWtuM216cTRzMXUy?=
 =?utf-8?B?Sy9VU1NCVjlwZWx0aWNHMDc0YjYxNDdwTm9TdGU1bS84VFVvNkVzZ0hucm1C?=
 =?utf-8?B?c012eXB3RWs3Z1hSZU9rWFp3cDhJL3NteEQ3aU1Sa1owRFlMQTF5NGVHRkpl?=
 =?utf-8?B?M0Nvc09GbGZ1QncvVUdyUEF5MkJJOGdoSGdXR1d1T3pQYUlaeUswblBZNVlW?=
 =?utf-8?B?QTF1K2QvVy80YWFZZ2N5R1NDTWZ6S0Y4dENka1FVdlMwODg0ZGlRZXFhZUlO?=
 =?utf-8?B?aElUaU9ZTXZXeXBEa1YxL3ZKN3BOdzZITTBRMTBBOFY1b2dXTTg4RkJJY051?=
 =?utf-8?B?TjgxUEhrWFdZenJybEM1NGdUeGZUV28vWlZyb0FhRUVQNnlvSEFUeml2c3Vs?=
 =?utf-8?B?bHJ0RGRhbDBrYU95OEhsNmdZa0FJbkdvVlpCeklQWFlVeWNKL01LSDNpblpJ?=
 =?utf-8?B?ODcva0pJei9wZXRlUUtRRFRtM2YrQ3Q2UE13QUJnV3htYTI1dzhLV2pQQmd3?=
 =?utf-8?B?S0JnS3JxNzE1RUMrT0xGR2sxRGxvS2VvZWdRdlNrM0V1NEJGdGp4WlVjN241?=
 =?utf-8?B?WVBaVmsxNmwvcm5nRFpmc2R5S0xiL1ZkbmRiRHBGemxob3RPeFQ5MjVmemdk?=
 =?utf-8?B?VzZVejlxRjdjMTcrekdZRkRTQlZkRzlUWHcvR3V6YndTYzJRbTg1dzV3c20z?=
 =?utf-8?B?aHBkMGVBcjAwYmR4a1pVeDJqcDUySzI2SVFIS09icks0ZkVqcUJ5dE5SdzZr?=
 =?utf-8?B?a0kvUHJna3Y5a0tPVWlmaG9SemV2cFpBZDcyWS8vZmZpSGs1M0N0dTNSZk8x?=
 =?utf-8?B?WkUyVG1KbWczWExWYTdleXJKVXlrY09uMWFrV0JaY0o3S1NsR0c2VmxmcUVk?=
 =?utf-8?B?bHpOVlJvcVFwSG9SOWVndTZFZzgwRDVWQlkyKy9lQ0YyckEzWGd0YWFoWTJk?=
 =?utf-8?B?SzlLclNyaHRmbEt0U1ljZmlTcDNLcllJQWgySDNFYjl6T0VvdjFWT2ZCbXps?=
 =?utf-8?B?OVRCNFlrSWRwQk4wNFFoVkNTaHRjcjV0RkR4Tks1NUNyNldKdnpIZUg4WmM5?=
 =?utf-8?B?SklYcWFKZTBFMmhncjFTRldOdHB0ZkY3eUdkSHgwTWFzZHRGZVJXK045eEk3?=
 =?utf-8?B?ZGhEV3VEd3NFSkcxQnJUdmZmS0s1bUNSSERZWWc5RVlVNVlkT0R6VWlRN1Fy?=
 =?utf-8?B?c2QrdFVQaVh1L2JBaXdsLzhkTHdlR2ZZN2w3RGNETXhJTGlkWjlwcmxuQUVv?=
 =?utf-8?B?Smc0MTRWby9EdWRacVpVbmcxSU9HcGpkNmpqcUNEcDk2VHBSdWtvanhSSXEx?=
 =?utf-8?B?Zyt4L3pvdFBCQWRYNTRPRFgzNVAwdkUvYUtua0NjM0hkbmh6MytEOHFlV0Zl?=
 =?utf-8?B?dm1GcnBoYU5RSnVOTDJ5cjhwRjBqemZrQXFpTytmcVZzSUYvc0lTWnQ3aTda?=
 =?utf-8?B?eE1jb01rNlRTb2dNTktsbFNCUUd3ZGJrV1FRZ1JWVXhMcDJxSWlhSnN3Ylcv?=
 =?utf-8?B?UWtybGtmMTBJSzlnRzZpc21qRVBrYTNzVUllb216M1FoSTVPaElTenJMcS9O?=
 =?utf-8?B?d0k3M0VTR01zMzl4Sk4rR1d6akVKM0hBWms1WmkyL2dsSDltK3JOOGZjVzNn?=
 =?utf-8?B?NVEwbmNBNnNjS0lITndmbnVyZEJaZTlWM1BMb0NRNDRkbVRKcm5pNyt1UFEr?=
 =?utf-8?B?SStRdHNTTjYwRjg0QVVYRjR3dmhhcDdQc0Mwa055SWIwU2tGMkNQZWU4UHNQ?=
 =?utf-8?B?NGs4LzZWVGNzUEZDWGhiaVFOVk5ZeTZDZVNyZWNmMFlqZGxDNzRrc0FtZjRv?=
 =?utf-8?B?VGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSCPR01MB16310.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 529beb25-d4d4-46e7-ebb5-08de2356c900
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2025 08:21:17.9585
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EnOq4f6mpRnlSoY4Xa0P2u1JmTGuelEZua7XW396i2I4zTS6MWkzuJ8GwSQB9TrwFR22Jjv7LvP1njBVBPCnhI/slpsobHAn9u5ny5+MkcE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB11235

SGkgQ2hhcmxpZSwNCg0KPiBIaSBBbGzigJQNCj4gDQo+IE9uIE1vbiwgTm92IDEwLCAyMDI1IGF0
IDA3OjM4OjE3QU0gKzAwMDAsIEthenVoaXJvIEFiZSAoRnVqaXRzdSkgd3JvdGU6DQo+ID4gSGkg
V2lsbCwNCj4gPg0KPiA+ID4gSGkgV2lsbCwNCj4gPiA+DQo+ID4gPiA+IFtZb3UgZG9uJ3Qgb2Z0
ZW4gZ2V0IGVtYWlsIGZyb20gd2lsbEBrZXJuZWwub3JnLiBMZWFybiB3aHkgdGhpcyBpcw0KPiA+
ID4gPiBpbXBvcnRhbnQgYXQgaHR0cHM6Ly9ha2EubXMvTGVhcm5BYm91dFNlbmRlcklkZW50aWZp
Y2F0aW9uIF0NCj4gPiA+ID4NCj4gPiA+ID4gT24gTW9uLCBPY3QgMjAsIDIwMjUgYXQgMDk6MjM6
MDVQTSArMDgwMCwgSGFuanVuIEd1byB3cm90ZToNCj4gPiA+ID4gPiBPbiAyMDI1LzEwLzE3IDE1
OjM5LCBLYXp1aGlybyBBYmUgd3JvdGU6DQo+ID4gPiA+ID4gPiBBR0RJIGhhcyB0d28gdHlwZXMg
b2Ygc2lnbmFsaW5nIG1vZGVzOiBTREVJIGFuZCBpbnRlcnJ1cHQuDQo+ID4gPiA+ID4gPiBDdXJy
ZW50bHksIHRoZSBBR0RJIGRyaXZlciBvbmx5IHN1cHBvcnRzIFNERUkuDQo+ID4gPiA+ID4gPiBU
aGVyZWZvcmUsIGFkZCBzdXBwb3J0IGZvciBpbnRlcnJ1cHQgc2lnbmFsaW5nIG1vZGUgVGhlDQo+
ID4gPiA+ID4gPiBpbnRlcnJ1cHQgdmVjdG9yIGlzIHJldHJpZXZlZCBmcm9tIHRoZSBBR0RJIHRh
YmxlLCBhbmQgY2FsbA0KPiA+ID4gPiA+ID4gcGFuaWMgZnVuY3Rpb24gd2hlbiBhbiBpbnRlcnJ1
cHQgb2NjdXJzLg0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IFJldmlld2VkLWJ5OiBJbGtrYSBL
b3NraW5lbiA8aWxra2FAb3MuYW1wZXJlY29tcHV0aW5nLmNvbT4NCj4gPiA+ID4gPiA+IFNpZ25l
ZC1vZmYtYnk6IEthenVoaXJvIEFiZSA8ZmoxMDc4aWlAYWEuanAuZnVqaXRzdS5jb20+DQo+ID4g
PiA+ID4gPiAtLS0NCj4gPiA+ID4gPiA+IEhhbmp1biwgSSBoYXZlIGFkZHJlc3NlZCBhbGwgeW91
ciBjb21tZW50cy4NCj4gPiA+ID4gPiA+IFBsZWFzZSByZXZpZXcgdGhlbS4NCj4gPiA+ID4gPiA+
DQo+ID4gPiA+ID4gPiB2My0+djQNCj4gPiA+ID4gPiA+ICAgLSBBZGQgYSBjb21tZW50IHRvIHRo
ZSBmbGFncyBtZW1iZXIuDQo+ID4gPiA+ID4gPiAgIC0gRml4IGFnZGlfaW50ZXJydXB0X3Byb2Jl
Lg0KPiA+ID4gPiA+ID4gICAtIEZpeCBhZ2RpX2ludGVycnVwdF9yZW1vdmUuDQo+ID4gPiA+ID4g
PiAgIC0gQWRkIHNwYWNlIGluIHN0cnVjdCBpbml0aWFsaXpzYXRpb24uDQo+ID4gPiA+ID4gPiAg
IC0gRGVsZXRlIGN1cmx5IGJyYWNlcy4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IExvb2tzIGdvb2Qg
dG8gbWUsDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBBY2tlZC1ieTogSGFuanVuIEd1byA8Z3VvaGFu
anVuQGh1YXdlaS5jb20+DQo+ID4gPiA+DQo+ID4gPiA+IEkgd2Fzbid0IGNjJ2Qgb24gdGhlIG9y
aWdpbmFsIHBhdGNoIGJ1dCBJIGNvdWxkbid0IGZpZ3VyZSBvdXQgd2h5DQo+ID4gPiA+IGl0IHVz
ZXMgSVJRRl9OT19BVVRPRU4gd2hlbiByZXF1ZXN0aW5nIHRoZSBpcnEgZ2l2ZW4gdGhhdCB0aGUN
Cj4gPiA+ID4gZmlyc3QgdGhpbmcgaXQgZG9lcyBpcyBlbmFibGUgaXQuDQo+ID4gPg0KPiA+ID4g
SSBtaXN1bmRlcnN0b29kIHRoZSB1c2FnZSBvZiByZXF1ZXN0X2lycSBhbmQgZW5hYmxlX2lycS4N
Cj4gPiA+IFNpbmNlIHRoZXJlJ3Mgbm8gbmVlZCB0byBzZXBhcmF0ZSB0aGVtLCBJIHdpbGwgcmVt
b3ZlIElSUUZfTk9fQVVUT0VODQo+ID4gPiBhbmQgdGhlIGVuYWJsZV9pcnEgY2FsbCwgYW5kIHNl
bmQgdjUuDQo+ID4NCj4gPiBJIGZvdW5kIG91dCB3aGVuIGNhbGxpbmcgcmVxdWVzdF9ubWksIHJl
bW92aW5nIElSUUZfTk9fQVVUT0VOIHJlc3VsdHMgaW4gYW4NCj4gZXJyb3IgKC1FSU5WQUwpLg0K
PiA+IFRoZXJlZm9yZSwgSSB3b3VsZCBsaWtlIHRvIGtlZXAgSVJRRl9OT19BVVRPRU4gc3BlY2lm
aWVkLg0KPiA+IElmIHlvdSBoYXZlIGFueSBjb21tZW50cyBvbiB0aGlzIHZlcnNpb24sIHBsZWFz
ZSBsZXQgbWUga25vdy4NCj4gDQo+IENvdWxkIGl0IGJlIHRoYXQgdGhpcyBpcyBqdXN0IGEgYnVn
IGluIGByZXF1ZXN0X25taWA/IEkgc2VlIHRoZSBmb2xsb3dpbmc6DQo+IA0KPiBpZiAoIWRlc2Mg
fHwgKGlycV9zZXR0aW5nc19jYW5fYXV0b2VuYWJsZShkZXNjKSAmJg0KPiAgICAgIShpcnFmbGFn
cyAmIElSUUZfTk9fQVVUT0VOKSkgfHwNCj4gICAgICFpcnFfc2V0dGluZ3NfY2FuX3JlcXVlc3Qo
ZGVzYykgfHwNCj4gICAgIFdBUk5fT04oaXJxX3NldHRpbmdzX2lzX3Blcl9jcHVfZGV2aWQoZGVz
YykpIHx8DQo+ICAgICAhaXJxX3N1cHBvcnRzX25taShkZXNjKSkNCj4gICAgICAgICByZXR1cm4g
LUVJTlZBTDsNCj4gDQo+IFBlcmhhcHMgdGhlcmUgaXMganVzdCBhIG1pc3NpbmcgYCFgIGJlZm9y
ZSBgaXJxX3NldHRpbmdzX2Nhbl9hdXRvZW5hYmxlYC4NCg0KSSB0cmllZCB0aGlzIGNoYW5nZSB3
aXRob3V0IHNwZWNpZnlpbmcgTk9fQVVUT0VOLCBidXQgaXQgcmVzdWx0ZWQgaW4gYW4gZXJyb3Iu
DQpfX3NldHVwX2lycSBzdWNjZWVkZWQsIGJ1dCBpcnFfbm1pX3NldHVwIGZhaWxlZCB3aXRoIC1F
SU5WQUwuDQpJIGhhdmVuJ3QgaW52ZXN0aWdhdGVkIGZ1cnRoZXIgYmV5b25kIHRoYXQgcG9pbnQg
eWV0Lg0KDQpCZXN0IFJlZ2FyZHMsDQpLYXp1aGlybyBBYmUNCg0KPiANCj4gQXMgZmFyIGFzIEkg
Y2FuIHRlbGwgaXQgaGFzIGFsd2F5cyBiZWVuIHdyb25nIC0gZ2l0IGJsYW1lIHBvaW50cyBtZSB0
byB0aGUgb3JpZ2luYWwNCj4gY29tbWl0IHdoZXJlIHRoYXQgY29kZSB3YXMgaW50cm9kdWNlZDoN
Cj4gDQo+IGI1MjU5MDNjMjU0ZGEgKCJnZW5pcnE6IFByb3ZpZGUgYmFzaWMgTk1JIG1hbmFnZW1l
bnQgZm9yIGludGVycnVwdCBsaW5lcyIpDQo+IA0KPiBJIGxvb2tlZCBhbmQgdGhlIG9ubHkgdHdv
IGNhbGxlcnMgYXJlIHVzaW5nIGBJUlFGX05PX0FVVE9FTmAgc28gSSBndWVzcyBpdCBqdXN0DQo+
IGhhc24ndCBiZWVuIG5vdGljZWQgeWV0Lg0KPiANCj4gSGFwcHkgdG8gc2VuZCBhIHBhdGNoIHRv
IGZpeCBpdC4NCj4gDQo+ID4NCj4gPiBCZXN0IFJlZ2FyZHMsDQo+ID4gS2F6dWhpcm8gQWJlDQo+
ID4NCj4gPiA+DQo+ID4gPiBCZXN0IFJlZ2FyZHMsDQo+ID4gPiBLYXp1aGlybyBBYmUNCj4gPiA+
DQo+ID4gPiA+DQo+ID4gPiA+IFdpbGwNCj4gDQo+IEJlc3TigJRDaGFybGllDQoNCg==

