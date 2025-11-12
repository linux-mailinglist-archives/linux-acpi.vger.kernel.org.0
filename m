Return-Path: <linux-acpi+bounces-18801-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 241FCC51561
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Nov 2025 10:25:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BDD444F3631
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Nov 2025 09:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7543C2EBBA9;
	Wed, 12 Nov 2025 09:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="WKbdO5hr"
X-Original-To: linux-acpi@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010011.outbound.protection.outlook.com [52.101.229.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72EFA2D663B;
	Wed, 12 Nov 2025 09:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762939103; cv=fail; b=rmywo7PQj/GkFe8t+YBNuI24a3airaHLhMGGUcGYUPC5MBwi6ict2YrrNq3Aj9fWf2mHywInXWW0v4gNfkNQxs1ceyZMsgGGH2B1oQ6p8PHiKM5HDS4ji8/iywF8FGSEDfmFXynM8EXkxXgznfxDsYcDQ9PCqEstwnqGKuilQgA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762939103; c=relaxed/simple;
	bh=S/FKmo2H88iRf1QkHiF0Bngu0nOd8FTDe7RHgQ3rR/s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=r+uxMlyecRBwAEdrkWgWnmOig33eqNa8tAszA7HX75jzK+jBz564JVwD7HAUCuTNtdfHyG6NEerhIjEWTWts8sy3vONbplC6/ZqSxhLn4fuMmPT/Rn8u0o+Jah0+wvPZ7WKlmqipI/sClHxVNMnurNWJLQGmy+xzIZSODUmE3kY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=WKbdO5hr; arc=fail smtp.client-ip=52.101.229.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cszc2gT/vphhVHc+pWMX0RqhX1BhHlYs1QEvOcfa4vDRHA3MdHzKPy/EO3TIIqCUFgw7Y4YsOlYH8+1KxTMyoyPY/OuwvHJyNG7W2+iLRw3EZDHRrdCIDWe1UAq/jXK3EMaKUX9eYJtsdgnZiYw3dSuFr659Wqc7svx64IUMBcpMKQU3mQtqVqReE4uKAF4Xa/yR7Rr5rdEfHbikhk3vblZnhqt2gbe1MnMZR2TgOuO104XrDys0Om0+wghe3ybAwhY/i0kj35t7fkLUJONS8QSqqF4Q/kZWlrttxtFpot4izhoh79okuuhhlo9b48jUmvuNITNtZbwkbP7wi7O6GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S/FKmo2H88iRf1QkHiF0Bngu0nOd8FTDe7RHgQ3rR/s=;
 b=MUS5DTRh9xTnvpf8l8BKYI1U5toDs625s46IMY4wWP0zmlQuAKTVGqRgi8dMdjiYF36EoDmm1br1FMWPXFmrXeeoaNXcplD82NHEuGo24joJQhxm2hgPiAisoaklsWbeyIS4q/s8YL9PTguftKUXd4hrxQiK9uTrFLcJlvxZxXHyDiPCbpmRwcwL3/fPZSDNoaPVM2v6UUprwXOR2jFqAjU7g2uHq3IjgrJBQ94pcBXc9LYBZ8TvdgpIyPnN1TW0FcqwUek8hiOB248jYoLOknU9AD3BobuwnD6h9eNCtYiQTfA1cx+qXdniFkBCiVUV3cnTqlzxlglCr53/g8NWvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S/FKmo2H88iRf1QkHiF0Bngu0nOd8FTDe7RHgQ3rR/s=;
 b=WKbdO5hrh2IyEiA70/f9OhRSs/wuKN5bOYXK43geCHK8vbARy2yuhmP2YMNC6AOXRi1EHD1jvrQD7DSPkIoGNWkXWaRXKar2KSfujrjwxmnR5fviKa1Os5kDHdGShUPU3OVIUuufOc3kMBtSwxxOaMkvRVpI87M6fgNPOE5CZUq1tKP/67MV+fZfNpiJBsN38amNL82yWDAySkRUri0UzvcapzLdR4kk9/owrWXoR1x1mrVVpAYGHaHWZxxTLdSrra2rvGNtvwaY8izSgFIRQ1kazpbb3n+yqBmjZ4SM+kU+c0KO+hEoTp7dNeMNcd25gN9KHGlUoMpqKI9L6s1q8Q==
Received: from OSAPR01MB7669.jpnprd01.prod.outlook.com (2603:1096:604:142::8)
 by OS9PR01MB16185.jpnprd01.prod.outlook.com (2603:1096:604:3de::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Wed, 12 Nov
 2025 09:18:18 +0000
Received: from OSAPR01MB7669.jpnprd01.prod.outlook.com
 ([fe80::2b44:88c5:b2fe:5b4a]) by OSAPR01MB7669.jpnprd01.prod.outlook.com
 ([fe80::2b44:88c5:b2fe:5b4a%4]) with mapi id 15.20.9320.013; Wed, 12 Nov 2025
 09:18:18 +0000
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
 AQHcPzk5+UU2j3z+uUO7itsPcFLu87TLCuOAgBfAiwCAAiHCgIAGvGIwgAL1hYCAAEmYsA==
Date: Wed, 12 Nov 2025 09:18:18 +0000
Message-ID:
 <OSAPR01MB766981DB17DEF8F3161321E0D5CCA@OSAPR01MB7669.jpnprd01.prod.outlook.com>
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
 =?utf-8?B?MmZfQWN0aW9uSWQ9ZjAwNTQ0NTEtMDAxOC00NWMxLThiODAtZWJiMDljZjlh?=
 =?utf-8?B?YzUwO01TSVBfTGFiZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFkNTUtNDZkZTMz?=
 =?utf-8?B?OTY4MDJmX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF8xZTkyZWY3My0wYWQx?=
 =?utf-8?B?LTQwYzUtYWQ1NS00NmRlMzM5NjgwMmZfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFkNTUtNDZkZTMzOTY4MDJmX01ldGhv?=
 =?utf-8?B?ZD1Qcml2aWxlZ2VkO01TSVBfTGFiZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFk?=
 =?utf-8?B?NTUtNDZkZTMzOTY4MDJmX05hbWU9RlVKSVRTVS1QVUJMSUPigIs7TVNJUF9M?=
 =?utf-8?B?YWJlbF8xZTkyZWY3My0wYWQxLTQwYzUtYWQ1NS00NmRlMzM5NjgwMmZfU2V0?=
 =?utf-8?B?RGF0ZT0yMDI1LTExLTEyVDA5OjA2OjA5WjtNU0lQX0xhYmVsXzFlOTJlZjcz?=
 =?utf-8?B?LTBhZDEtNDBjNS1hZDU1LTQ2ZGUzMzk2ODAyZl9TaXRlSWQ9YTE5ZjEyMWQt?=
 =?utf-8?B?ODFlMS00ODU4LWE5ZDgtNzM2ZTI2N2ZkNGM3O01TSVBfTGFiZWxfMWU5MmVm?=
 =?utf-8?B?NzMtMGFkMS00MGM1LWFkNTUtNDZkZTMzOTY4MDJmX1RhZz0xMCwgMCwgMSwg?=
 =?utf-8?Q?1;?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSAPR01MB7669:EE_|OS9PR01MB16185:EE_
x-ms-office365-filtering-correlation-id: 2c1561dc-8006-47eb-d26f-08de21cc6ab3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|366016|376014|1800799024|38070700021|1580799027;
x-microsoft-antispam-message-info:
 =?utf-8?B?ekVSSjg5Q3hJQWdHd0RzeHFabVNKOTNjNlk3QlErMklWenVVT2kyTVQ2aUpH?=
 =?utf-8?B?MTdtcE9WUVRxbmtudHQ5MnpYVTZudUlqSWZDRXpJdUUydTdpTWhNTlYvREg5?=
 =?utf-8?B?bElNZmVxNGxFWmVJMUFWS0R6eW1IUUZjMksrcUtRUnREaTdhOEszSkFiU3BJ?=
 =?utf-8?B?MVY1ODAzZnZ6Y1p2U0hlTXFpSXFPRSs5SGlOYVZwb0JJSmxvU1BnTUd3bEdI?=
 =?utf-8?B?M2ZMdi81VE9VY3Z6cGc4VVA0cUZQWUo4U2xHY0RmaDd4UC81Z2E0eEpHc3BV?=
 =?utf-8?B?Q2dKSjZqQTJzTnBEcGRKVldZU2dIbjl5Z013emhGL3R2Y3Vjc2p3TFArYTF1?=
 =?utf-8?B?eGhoVlJndmVBNHo1Y1M0dzF2WW0ybE94ZkkwNXhRZklSbVo1TG1VSHE3TWRQ?=
 =?utf-8?B?NW5yMjBjSUFIczRjdGt3K0JJd2RCT2QvcWxrdlVpTlJjcDB3SFBsNjNkTC9k?=
 =?utf-8?B?L2lGcjFKSERUQkVDN3Iydnl1b3IyZzdEUDRnTHpkSEVVOWZ1MWdqckpRUzlu?=
 =?utf-8?B?MnYvYW1CQmVXQVZzVThpQzU3cFFUbW5PSStMUCs0dUJkT21aTlQzZ2diTWJN?=
 =?utf-8?B?bHBQSGlPTk1iR2lxU1QzbWp4bGVreEcybVFDTWFkTkp5RUpXSGxVRlNhQlox?=
 =?utf-8?B?ZktnOEZzcC90bkNPRWJ0YkxqMnZlbnhuNWFJM0twUFdtWGpxVTZ6ZUF6M014?=
 =?utf-8?B?aFBTeFZJZkRuVnRjUHFsT2FSSWpWQWpGQXBmSVZkcllKVjNGNWR6SGFjZ1VP?=
 =?utf-8?B?STAzRDdWcVhaS1dTN1UybzlXZDdGNDlZN2xkUGVZenN5ZUJJenF5d1ArRDlz?=
 =?utf-8?B?TXRrbDR0Y3Rud1hLNWtVbGlHcUQ1ck8vQnBPd2tjaHRxWkR3eFN5a2t1ZmN4?=
 =?utf-8?B?TERVQmRTcVlCWEZJdGJidC91a2djWm9rRHJRa0Z1R2NldG01TEFaS0dNZXhU?=
 =?utf-8?B?dUMycGxtZGxYRE5QbU56dDRISmNuMmFjNmt2akxzODhwUGdLYmswdG9oTkxi?=
 =?utf-8?B?Tkk2V1AyMzdmZDZ4TUlBQTRCamo0U2dTdHdtanpidlQ3dFVNRlRZZlBiNVNr?=
 =?utf-8?B?d0dpc01iS3NqL1I2UDhFZjBiaWQ0bVpDb0w3TU9JZG9BVjl1d0RRNnNLM3E1?=
 =?utf-8?B?VW5PcFRRRVhPVGJ5aHVrYlRiUWlhbmllMU1CWDZ6OUFISzlKd3pRRjFaaFVw?=
 =?utf-8?B?Zm8ydGhtQUtKeHkxL3cyejVaMUFTbVBtbU9TcVkyUzM2NzNNR083NTVHYWJl?=
 =?utf-8?B?OER0cHA3ak1GWUtaYmhmdTFyVlFpTGhST3dpM29RaXA5UDRaUDd5ZytKd3pL?=
 =?utf-8?B?M2MzZUhwOFJsc1hHYzdXRGI1ajZ0Z3U5aVFxVlNWbUgzcklaNGpGNFVQZXdx?=
 =?utf-8?B?ZnZPYUZQbXdNY1NJQmRpTVlucmlhalB6S0pjSGIxbktIWVpydUVEQ284R3Yy?=
 =?utf-8?B?ditxbzluUUlaK1VSMEszMWFpR1pUQW5pdTUxNTdZOS8vN2NDQW9ITXQ5UjQr?=
 =?utf-8?B?QXBUcDBtNW9ldTNvVUcrSmY0QXRwRTQrQnVFN2RTUm03ZXVReGtRNWxJSzFz?=
 =?utf-8?B?NnZDU3FoUHRPQ1VaejdHZlVHdU05bGFpdEpzUFl6b21ock5Vb3lYcnV1Mlkw?=
 =?utf-8?B?Tk9GazR1SkMyUkw1MC9XRC9XaVVRdWZVUnF0WTJCdk9nZXdrUDduRGlCK29I?=
 =?utf-8?B?WnFjZFVZQkhjcUpiWXFFWjRROFBuNnhOazZTdU1WSTJvL3NKdlMwaWw2WEpJ?=
 =?utf-8?B?aTZVcFJFVmdkekdiaXhZSmtVRlY1YnE0WmVGYlRYSS9RUG1qRjYzaElHVzFM?=
 =?utf-8?B?S1o5c1lKU0tQbDdRc0k5TGVUZmFnbVZucXdqUm8yU1JFdjREdHluL0M1WExL?=
 =?utf-8?B?dXpPU2VJWlJaUURxMUNQV1FBQ1BmcDE4MGdlREFMdXVCdTBDZDMyVFNBcEla?=
 =?utf-8?B?ekErUXdUTUpFYU5XVHBOQTlwRmZmOGRRU2VaVXU2OUJyNWtvaXd1WGdwc0Jw?=
 =?utf-8?B?SmtKR1JWM28zdkVhdU9NKzF3bGxpemJXVkllSExFakVnYmZyelp0dDRsSml5?=
 =?utf-8?B?cDBYVjZpK1BHZFJmekU4Q252TzBwOEZ2UmpmUT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSAPR01MB7669.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(38070700021)(1580799027);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QzdmUjR4RGpxUVgxNEg5MVN0Q2dDejQvcVdISThRdkpERjdWam1wR2dsdmln?=
 =?utf-8?B?a1JSbk5aUHduOVphSUY5c0Q0STVmTHlYVktudnRXWjRFeVRoS295czN1VXUw?=
 =?utf-8?B?V2dYaGJyOUFRQWEvVnJOeW1oQ29LNVJFNm84NS9VQzF1dXBYM2RsVUwwR0dx?=
 =?utf-8?B?aC9aeW5LUWhGSnJLUVVkbGlxZXp1YmZPOFZHQk1FOUNLSUZYWnJBK3BPVUZR?=
 =?utf-8?B?M3NhUXBBczRzeWR6UDQ4UGNreVZwZE05cjB6S1dpMjE4a1R6VmxiVmxVcHVu?=
 =?utf-8?B?bVNySXpOaHJoYVVQUW45eVp3QnF1S2cxeFhxeFhWbUZoc3Y3aUpwcHQwZHRv?=
 =?utf-8?B?TVVXYVMvdmQ5VHNwaDBlZThiRHpEM215TGU0V1lYS04yWlVjZnVmc3R2eVhC?=
 =?utf-8?B?QU5mbkk5RDRQbU1Lc2VpWHJiY2RWS0RkN1F5VUNIc2R5VjFtb0hhOHFUYjhs?=
 =?utf-8?B?NFRLWGtFeUZQdERMVE5NODMzanByRDFkWVh5aUk4c0NMbkF4ODFuek9lek84?=
 =?utf-8?B?Slp5YXNpL1dhWHEwM1d2VE5Zb1ZWYUI3bzloUldJNGV6R2NSSFR3Z1JPK1BR?=
 =?utf-8?B?TVo2Mm5admJsbDhrVWpsYVphMjRmdkVWbis0bHVzWG5JNVRsMFdVT2c0VkdC?=
 =?utf-8?B?WTFucnFQa09teE9hYW5PemNjZkxTT25UQkMrYktyVU96eitxY0hRVXZGY0sr?=
 =?utf-8?B?RTJHTUI4V2RPaDI4SWtaR0JjU3JXWHRMRHpUcDBudllCUGE1ZkE1V2RJd0Va?=
 =?utf-8?B?WGFZU3pJcWZKYlIvS3FHbmYxb2EwL0d1S1RLTlhvWXlsa1MxQ09pY055bk9n?=
 =?utf-8?B?b0syelF5UGUxcWtJdUFhV3h6RGx1blZ1VU93SVl6VjhMcVQ4MnBZQndUT2xm?=
 =?utf-8?B?eXhhNFdDbmNtWEVrT2FJQTF6ZXhnQ25aMlhSUXFLWmNOMk9tTDJpU0x4L0pz?=
 =?utf-8?B?bUIvRDRFZ2l6TklHTFlISFl3MWljR0VWem9Qays4eW1zbGpOK3pSTDY4dlF0?=
 =?utf-8?B?WHF4em1POXNTT3JjQSs4MGVXaTZaMGJLTld4RVlleEpaRmplaUYvdEswUWE5?=
 =?utf-8?B?b0k2Q0RsQnAxWjR1UE8rL1ZudkpJcElzeG9jUS8rK3BuNGo1cUd1YnRuNHNQ?=
 =?utf-8?B?d01TOW96Ty9EYWI4UHBFVE1lbE1YQ1FzU3BjeWhxczdseFBEV1ZweTBwQUtN?=
 =?utf-8?B?SENGWEt0TTZrYzRWSStEK2U5STNXL0ZGbG9QSXkyekFPdVhEYlpXdWhkNVF1?=
 =?utf-8?B?ODZzaDJPemwxYVdZN29zUjI5eVQ3SWhMd04rcVVQRXgrTmhMQ3UydWlWdm9R?=
 =?utf-8?B?RjZWTUdWUDJlZWVnRU1laFhGN2NUUFhwUkNaVEVzOW1SVlBPYzVyU2hEQktM?=
 =?utf-8?B?bFhBYjRGOVhhbVVnR1ROVExEb1g2Nk5JcWhXNkl0TUZ3UXVBSnV1TS9tKzZ1?=
 =?utf-8?B?NHB0dlg4NkVUbjU1QytEYlhzdGVGVzBxYmw0U0NPdkI1ZkExUXZQVVZ0TFJW?=
 =?utf-8?B?bk9Xa2N2NGpWZ1J4enJRWmYrNGRBZnhHRGlnTUdoa3FzU3ZzNzFadU04QVR1?=
 =?utf-8?B?Ty91SnhqemRkSDhzZDhpZEVYMHlQa2lmZ21oZC90SEUvOGVUVjJvMHJWVmNK?=
 =?utf-8?B?YVZKckxJRXRyYjFZUmxkbDVoT2xFRFlVU1VvQnhYclpUYTk1Ny9OTWZUa3pz?=
 =?utf-8?B?VzJxdkxSTDNXVFdiTDA0N3llK0lTQ3NFNjZBOWdoTTcvWTRGdTcyK3FTdEc4?=
 =?utf-8?B?dExYczBtUUlZc1VITitVT3BqQmtoVnc1bVNnK0crQzA4b1VRZUhIMkRobkp1?=
 =?utf-8?B?NGhWVWNpT1FFblBoeDR2UGtnNE9JdXlRTU5iS040Y0QyL2NLRGtLWG4wTlBm?=
 =?utf-8?B?ZitmRkpLTUNVMHFYbWs0QnErYnh5VW1rY00yTnBLQlJOTHdwVmNBVDlmVzkz?=
 =?utf-8?B?N0tCR0I5OWk3SUNGcEVLYzFCMUFZTGU5OVE4d2ZReEE3cHlrTzlaY3NkU2h5?=
 =?utf-8?B?V3g5Vm1BSVBDc2NYOGIvRGVMNkFITTBnYjVKMENpaWhHNFQ2SFpoVnZRbG52?=
 =?utf-8?B?Wk9HbjRUc3J6dEQ4aXNjUkQ1UHFxaUJqcHRRbDIxQkhZbXdiWHlYNzJLbzVK?=
 =?utf-8?B?dUVocCtEd1Bwbkw0NGJIaTM3QXpCVVM0SGV2T2wxTk1FMXcwVUtnWFFNN0hB?=
 =?utf-8?B?bUE9PQ==?=
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
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB7669.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c1561dc-8006-47eb-d26f-08de21cc6ab3
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2025 09:18:18.0213
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4P35jKgBmeX5fRRkps8Q3oMoy5E7+qZHB7K88YE4hto5WUvhsJ6n39XCJb1WlpggsfjhtB5FS2sFO7eK7FhRt2GJLILQ6KrBLBRFAjPO2hQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB16185

SGkgQ2hhcmxpZSwNClRoYW5rIHlvdSBmb3IgeW91ciBjb21tZW50cy4NCg0KPiBIaSBBbGzigJQN
Cj4gDQo+IE9uIE1vbiwgTm92IDEwLCAyMDI1IGF0IDA3OjM4OjE3QU0gKzAwMDAsIEthenVoaXJv
IEFiZSAoRnVqaXRzdSkgd3JvdGU6DQo+ID4gSGkgV2lsbCwNCj4gPg0KPiA+ID4gSGkgV2lsbCwN
Cj4gPiA+DQo+ID4gPiA+IFtZb3UgZG9uJ3Qgb2Z0ZW4gZ2V0IGVtYWlsIGZyb20gd2lsbEBrZXJu
ZWwub3JnLiBMZWFybiB3aHkgdGhpcyBpcw0KPiA+ID4gPiBpbXBvcnRhbnQgYXQgaHR0cHM6Ly9h
a2EubXMvTGVhcm5BYm91dFNlbmRlcklkZW50aWZpY2F0aW9uIF0NCj4gPiA+ID4NCj4gPiA+ID4g
T24gTW9uLCBPY3QgMjAsIDIwMjUgYXQgMDk6MjM6MDVQTSArMDgwMCwgSGFuanVuIEd1byB3cm90
ZToNCj4gPiA+ID4gPiBPbiAyMDI1LzEwLzE3IDE1OjM5LCBLYXp1aGlybyBBYmUgd3JvdGU6DQo+
ID4gPiA+ID4gPiBBR0RJIGhhcyB0d28gdHlwZXMgb2Ygc2lnbmFsaW5nIG1vZGVzOiBTREVJIGFu
ZCBpbnRlcnJ1cHQuDQo+ID4gPiA+ID4gPiBDdXJyZW50bHksIHRoZSBBR0RJIGRyaXZlciBvbmx5
IHN1cHBvcnRzIFNERUkuDQo+ID4gPiA+ID4gPiBUaGVyZWZvcmUsIGFkZCBzdXBwb3J0IGZvciBp
bnRlcnJ1cHQgc2lnbmFsaW5nIG1vZGUgVGhlDQo+ID4gPiA+ID4gPiBpbnRlcnJ1cHQgdmVjdG9y
IGlzIHJldHJpZXZlZCBmcm9tIHRoZSBBR0RJIHRhYmxlLCBhbmQgY2FsbA0KPiA+ID4gPiA+ID4g
cGFuaWMgZnVuY3Rpb24gd2hlbiBhbiBpbnRlcnJ1cHQgb2NjdXJzLg0KPiA+ID4gPiA+ID4NCj4g
PiA+ID4gPiA+IFJldmlld2VkLWJ5OiBJbGtrYSBLb3NraW5lbiA8aWxra2FAb3MuYW1wZXJlY29t
cHV0aW5nLmNvbT4NCj4gPiA+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IEthenVoaXJvIEFiZSA8Zmox
MDc4aWlAYWEuanAuZnVqaXRzdS5jb20+DQo+ID4gPiA+ID4gPiAtLS0NCj4gPiA+ID4gPiA+IEhh
bmp1biwgSSBoYXZlIGFkZHJlc3NlZCBhbGwgeW91ciBjb21tZW50cy4NCj4gPiA+ID4gPiA+IFBs
ZWFzZSByZXZpZXcgdGhlbS4NCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiB2My0+djQNCj4gPiA+
ID4gPiA+ICAgLSBBZGQgYSBjb21tZW50IHRvIHRoZSBmbGFncyBtZW1iZXIuDQo+ID4gPiA+ID4g
PiAgIC0gRml4IGFnZGlfaW50ZXJydXB0X3Byb2JlLg0KPiA+ID4gPiA+ID4gICAtIEZpeCBhZ2Rp
X2ludGVycnVwdF9yZW1vdmUuDQo+ID4gPiA+ID4gPiAgIC0gQWRkIHNwYWNlIGluIHN0cnVjdCBp
bml0aWFsaXpzYXRpb24uDQo+ID4gPiA+ID4gPiAgIC0gRGVsZXRlIGN1cmx5IGJyYWNlcy4NCj4g
PiA+ID4gPg0KPiA+ID4gPiA+IExvb2tzIGdvb2QgdG8gbWUsDQo+ID4gPiA+ID4NCj4gPiA+ID4g
PiBBY2tlZC1ieTogSGFuanVuIEd1byA8Z3VvaGFuanVuQGh1YXdlaS5jb20+DQo+ID4gPiA+DQo+
ID4gPiA+IEkgd2Fzbid0IGNjJ2Qgb24gdGhlIG9yaWdpbmFsIHBhdGNoIGJ1dCBJIGNvdWxkbid0
IGZpZ3VyZSBvdXQgd2h5DQo+ID4gPiA+IGl0IHVzZXMgSVJRRl9OT19BVVRPRU4gd2hlbiByZXF1
ZXN0aW5nIHRoZSBpcnEgZ2l2ZW4gdGhhdCB0aGUNCj4gPiA+ID4gZmlyc3QgdGhpbmcgaXQgZG9l
cyBpcyBlbmFibGUgaXQuDQo+ID4gPg0KPiA+ID4gSSBtaXN1bmRlcnN0b29kIHRoZSB1c2FnZSBv
ZiByZXF1ZXN0X2lycSBhbmQgZW5hYmxlX2lycS4NCj4gPiA+IFNpbmNlIHRoZXJlJ3Mgbm8gbmVl
ZCB0byBzZXBhcmF0ZSB0aGVtLCBJIHdpbGwgcmVtb3ZlIElSUUZfTk9fQVVUT0VODQo+ID4gPiBh
bmQgdGhlIGVuYWJsZV9pcnEgY2FsbCwgYW5kIHNlbmQgdjUuDQo+ID4NCj4gPiBJIGZvdW5kIG91
dCB3aGVuIGNhbGxpbmcgcmVxdWVzdF9ubWksIHJlbW92aW5nIElSUUZfTk9fQVVUT0VOIHJlc3Vs
dHMNCj4gaW4gYW4gZXJyb3IgKC1FSU5WQUwpLg0KPiA+IFRoZXJlZm9yZSwgSSB3b3VsZCBsaWtl
IHRvIGtlZXAgSVJRRl9OT19BVVRPRU4gc3BlY2lmaWVkLg0KPiA+IElmIHlvdSBoYXZlIGFueSBj
b21tZW50cyBvbiB0aGlzIHZlcnNpb24sIHBsZWFzZSBsZXQgbWUga25vdy4NCj4gDQo+IENvdWxk
IGl0IGJlIHRoYXQgdGhpcyBpcyBqdXN0IGEgYnVnIGluIGByZXF1ZXN0X25taWA/IEkgc2VlIHRo
ZSBmb2xsb3dpbmc6DQo+IA0KPiBpZiAoIWRlc2MgfHwgKGlycV9zZXR0aW5nc19jYW5fYXV0b2Vu
YWJsZShkZXNjKSAmJg0KPiAgICAgIShpcnFmbGFncyAmIElSUUZfTk9fQVVUT0VOKSkgfHwNCj4g
ICAgICFpcnFfc2V0dGluZ3NfY2FuX3JlcXVlc3QoZGVzYykgfHwNCj4gICAgIFdBUk5fT04oaXJx
X3NldHRpbmdzX2lzX3Blcl9jcHVfZGV2aWQoZGVzYykpIHx8DQo+ICAgICAhaXJxX3N1cHBvcnRz
X25taShkZXNjKSkNCj4gICAgICAgICByZXR1cm4gLUVJTlZBTDsNCj4gDQo+IFBlcmhhcHMgdGhl
cmUgaXMganVzdCBhIG1pc3NpbmcgYCFgIGJlZm9yZSBgaXJxX3NldHRpbmdzX2Nhbl9hdXRvZW5h
YmxlYC4NCj4gDQo+IEFzIGZhciBhcyBJIGNhbiB0ZWxsIGl0IGhhcyBhbHdheXMgYmVlbiB3cm9u
ZyAtIGdpdCBibGFtZSBwb2ludHMgbWUgdG8gdGhlIG9yaWdpbmFsDQo+IGNvbW1pdCB3aGVyZSB0
aGF0IGNvZGUgd2FzIGludHJvZHVjZWQ6DQo+IA0KPiBiNTI1OTAzYzI1NGRhICgiZ2VuaXJxOiBQ
cm92aWRlIGJhc2ljIE5NSSBtYW5hZ2VtZW50IGZvciBpbnRlcnJ1cHQgbGluZXMiKQ0KPiANCj4g
SSBsb29rZWQgYW5kIHRoZSBvbmx5IHR3byBjYWxsZXJzIGFyZSB1c2luZyBgSVJRRl9OT19BVVRP
RU5gIHNvIEkgZ3Vlc3MgaXQNCj4ganVzdCBoYXNuJ3QgYmVlbiBub3RpY2VkIHlldC4NCj4gDQo+
IEhhcHB5IHRvIHNlbmQgYSBwYXRjaCB0byBmaXggaXQuDQoNCkkgbm90aWNlZCB0aGF0IGNvbW1p
dCAoYjUyNTkwM2MyNTRkYSkgbG9nIHNheXM6DQo+ICBJbnRlcnJ1cHQgbGluZXMgYWxsb2NhdGVk
IGZvciBOTUkgZGVsaXZlcnkgbXVzdCBiZSBlbmFibGVkL2Rpc2FibGVkIHRocm91Z2gNCj4gIGVu
YWJsZV9ubWkvZGlzYWJsZV9ubWlfbm9zeW5jIHRvIGtlZXAgdGhlaXIgc3RhdGUgY29uc2lzdGVu
dC4NCg0KU2ltaWxhciBjb21tZW50cyBhbHNvIGV4aXN0IGluIHRoZSBmdW5jdGlvbiBjb21tZW50
cyBvZiByZXF1ZXN0X25taSgpLg0KU28sIEkgd29uZGVyIGlmIGRpc2FibGluZyBhdXRvLWVuYWJs
aW5nIGZvciByZXF1ZXN0X25taSgpIGlzIGEgZGVzaWduIGNob2ljZS4NCg0KQXMgZmFyIGFzIEkg
Y2FuIHNlZSwgdGhlcmUgaXMgbm8gZnVuZGFtZW50YWwgcmVhc29uIHRvIHJlc3RyaWN0IHRoZSBm
bGFnLg0KSWYgd2UgYWdyZWUgdG8gcmVtb3ZlIHRoZSByZXN0cmljdGlvbiBmb3IgcmVxdWVzdF9u
bWkoKSwgIEknbSB3aWxsaW5nIHRvIHVwZGF0ZSB0aGlzIHBhdGNoLg0KSSdkIGxpa2UgdG8ga25v
dyBvdGhlcnMnIG9waW5pb25zLg0KDQpCZXN0IFJlZ2FyZHMsDQpLYXp1aGlybyBBYmUNCj4gDQo+
ID4NCj4gPiBCZXN0IFJlZ2FyZHMsDQo+ID4gS2F6dWhpcm8gQWJlDQo+ID4NCj4gPiA+DQo+ID4g
PiBCZXN0IFJlZ2FyZHMsDQo+ID4gPiBLYXp1aGlybyBBYmUNCj4gPiA+DQo+ID4gPiA+DQo+ID4g
PiA+IFdpbGwNCj4gDQo+IEJlc3TigJRDaGFybGllDQoNCg==

