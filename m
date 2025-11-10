Return-Path: <linux-acpi+bounces-18720-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DB7AEC453BB
	for <lists+linux-acpi@lfdr.de>; Mon, 10 Nov 2025 08:38:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 93D504E8578
	for <lists+linux-acpi@lfdr.de>; Mon, 10 Nov 2025 07:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ED392EC09F;
	Mon, 10 Nov 2025 07:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="PGGycnjH"
X-Original-To: linux-acpi@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011004.outbound.protection.outlook.com [40.107.74.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DECE12EBDF4;
	Mon, 10 Nov 2025 07:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762760303; cv=fail; b=a6betHkj9Ps6BVgrwSejCC7EPaBlE2u4OfHZnt+i7S4WLncdnWslZT8+k+5GiXMt0UQU+eJGrfk+bh9aBW10SBpExDgSvgSI2ppva+KPEe+wndjOpLrm1Ts1lvsWIa5lpKs89ti0ZFGAvn7Ztnhk8OUzbuUZdzD5lNZ0tRUWL+Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762760303; c=relaxed/simple;
	bh=fCSUorvdrP2aa5I183BYtAurQ3Qfe+z/g+pB21ZkbKw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=K0Yyg6OydLw/bX31/m2keaJNW08D47mZrRTeZEbovX9EdrkcyZdDmf8Hpd55GTuZIgOEX2G2XYbQ6+ew7v8koXHSnUkFVdnYoQfHW0m1eZ9Zv2PsoJWM+chRbxQ5Mz3Bd32Ko5bot1otVxRMvxpBxyK+jmNN/tTXK5oM7rpLIv0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=PGGycnjH; arc=fail smtp.client-ip=40.107.74.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s8tMbFz118uAT/+NraDCcBAlggrIrEOuWkcBPT2Ph6cEs0w9ln2OqZl+vDlWevTkpr4UOGX96OBPI61lN8+IC7l8H8UjqAjzjGUDanF3vSBdFmD0iXC/1WCqF3OGrj1dgdROj181LruC83EdSZfMXOfXFkpC3oHsZkvN9YXbBjaOJ5GYAScOR7z5Jb68jKxc/Z2AjG2kvZThJ5DRaU2nlLz3Gw2oHvX/x+8kMY7UevLoSHPPu5zgWsP1SvtjAwE0NE38n5HUBkTmg1pifPO/ytqPRnvwj8Q2kA36lgoGx4HTGlsowJDbdg0reuT+vtN5mMz2O2aoFB5+qUkv5/TcGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vgDqmlhBLTtvGkKBTgY0LVeo9DtOV9sTc8ay+genkvs=;
 b=JGNlpYBa0KRR5/dTuWeqsKAjiuFS4bZvjDVShsQzckFO9REl9Vpax2PPvx6RgAggI+QYFYvQaRsjAIAT/G/r+KxAYzXT92DB1qsPNi7ev+eWKwow3L7okHH/tiCyl6AGjNnCrxb+Im+LNiXdi5pW2tIEth9Mf5keHv39/auN2xcNAzlYsI/SCgrPCGCTcOe1f7Od32jtvHMtYFkZYPyTwnzcgMBTK/W515/2ZISHGDoac9nUTfFfbqzc/trpYUfiK+P8r25JQeHrWjYU5WR7CfqJYusO+0qS9SFmpi0Z5z+dx/oXcqpU1yfH7KJj72tx4KsIxjbRB6i3npwWah365A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vgDqmlhBLTtvGkKBTgY0LVeo9DtOV9sTc8ay+genkvs=;
 b=PGGycnjHwA4mSkrmLPFntLGCRMtmkz7iDl11a20kOl/Wr5ncyrWKNM/5H9auHPI1jfBwKhe30QefO/hRKmBOmmsv/QoqRblGKPgxh9yl9QAUIKkHjjleFeJFoG4MuN/Ek4t9WpKBofyr1OlUAs4O8Zqf0TWe+zo6ilbhvNIWazPki9GwswfPwxitX2nWlw3z8OhzT9zk7RCnJxRHKXV/iIFCzXv1GzS5TuVyTUE0XtauAFscK1iOK3j8aOqj1LJGSfm7YHmmgj8Vpj2F7xe5npOeLj5omwFOUWY4Ia1wva9dZRCOW2Wvn2BcZTAbACx7+usCIg0UT9I+pyN04RDJmQ==
Received: from OSAPR01MB7669.jpnprd01.prod.outlook.com (2603:1096:604:142::8)
 by OS3PR01MB6676.jpnprd01.prod.outlook.com (2603:1096:604:10e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.11; Mon, 10 Nov
 2025 07:38:19 +0000
Received: from OSAPR01MB7669.jpnprd01.prod.outlook.com
 ([fe80::2b44:88c5:b2fe:5b4a]) by OSAPR01MB7669.jpnprd01.prod.outlook.com
 ([fe80::2b44:88c5:b2fe:5b4a%4]) with mapi id 15.20.9320.013; Mon, 10 Nov 2025
 07:38:18 +0000
From: "Kazuhiro Abe (Fujitsu)" <fj1078ii@fujitsu.com>
To: 'Will Deacon' <will@kernel.org>, Hanjun Guo <guohanjun@huawei.com>
CC: Lorenzo Pieralisi <lpieralisi@kernel.org>, Sudeep Holla
	<sudeep.holla@arm.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown
	<lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Ilkka Koskinen
	<ilkka@os.amperecomputing.com>, Catalin Marinas <catalin.marinas@arm.com>,
	"Koichi Okuno (Fujitsu)" <fj2767dz@fujitsu.com>
Subject: RE: [PATCH v4] ACPI: AGDI: Add interrupt signaling mode support
Thread-Topic: [PATCH v4] ACPI: AGDI: Add interrupt signaling mode support
Thread-Index: AQHcPzk5+UU2j3z+uUO7itsPcFLu87TLCuOAgBfAiwCAAiHCgIAGvGIw
Date: Mon, 10 Nov 2025 07:38:17 +0000
Message-ID:
 <OSAPR01MB7669F9B9E145A50B38819E13D5CEA@OSAPR01MB7669.jpnprd01.prod.outlook.com>
References: <20251017073935.1746365-1-fj1078ii@aa.jp.fujitsu.com>
 <a93e845a-b084-a680-7158-68363c492b75@huawei.com>
 <aQokdBkjFqw9ZGRt@willie-the-truck>
 <OSAPR01MB766951191ACB95ABCD7DD319D5C2A@OSAPR01MB7669.jpnprd01.prod.outlook.com>
In-Reply-To:
 <OSAPR01MB766951191ACB95ABCD7DD319D5C2A@OSAPR01MB7669.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ActionId=9d23579d-4314-443f-9efa-68a78df3a4c7;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ContentBits=0;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Enabled=true;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Method=Privileged;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Name=FUJITSU-PUBLIC?;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SetDate=2025-11-06T00:39:51Z;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Tag=10,
 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSAPR01MB7669:EE_|OS3PR01MB6676:EE_
x-ms-office365-filtering-correlation-id: ed416030-ecad-4643-c419-08de202c1d93
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007|1580799027|38070700021;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?NHJXODUwOWI5QUg1eGx1cThFbkgwbkw3bnp4VVcyRU9yYUNuS2NLYlRk?=
 =?iso-2022-jp?B?S1h3RHJscGJadlhheHB4YitzOC9mNWxHdzVvSzR2OWJCL2cyaVh0UENi?=
 =?iso-2022-jp?B?UVE0RXduWW4yS2c5SFpsdWhtcUNYK2Q0L09QYTkrZ09FbDdVSzBHM052?=
 =?iso-2022-jp?B?WlN5Vkl0dU5EUVlEVVZDTVBkcWM3SDRiRkRWclNPVjlkMEZOaVNzYlVM?=
 =?iso-2022-jp?B?SmlWbmpyZk5yakVzN2tCaDJDZ2trSmJxK1F2UFhOcU8zMDI2ZEJSMGU5?=
 =?iso-2022-jp?B?MjUzYVRVcDducXE0YzZ0NnNvOWV3eUpKVFRPT2M1K2JEQWtxK0JJNW0y?=
 =?iso-2022-jp?B?Z3V4RU5TbUdmQzZGWFZVaC9jbHdNTEIxS1lBS2FlTVVHZnZYdlUwaHlQ?=
 =?iso-2022-jp?B?NS8yMEpJUDB5RTFYQktMR2luUXZiZHVOY2lQOWZBVkVlWU92azNrVjg2?=
 =?iso-2022-jp?B?VkczYys4SFhteGVZdGRIUXZLMDNoZEQ5cE9MTUpFblBVa1VzcnZqanhq?=
 =?iso-2022-jp?B?Z2FJS3lhcG0vSDBtSm1BUUt0L1RBaTk3cHpIWVBXUHUrUGI0VmYxRzBs?=
 =?iso-2022-jp?B?a2xYZ05qMHo3d0ZZZTEyenE5QTZkNFJFR2N6R2c2aHl1R1BKSzQ0L0Jm?=
 =?iso-2022-jp?B?OW9aMnF0M3gyclpuR2JrMGJsbFJMc0tNRjg3aDA2N1R1UUJyVmdhdWVP?=
 =?iso-2022-jp?B?djhaZi9kZHlDNWtBRXhiblJSN0doOFhtSDhpUjZZbFRTNllhdDd6UC94?=
 =?iso-2022-jp?B?dWZmbXBvaFBnMWtrZ2tDWWt3VkYydG55c2l5M2NLbXVHOElKb2FzVjJ0?=
 =?iso-2022-jp?B?cHIzSkZyQ3F5OUNrWHlKNjlES2t5NFJKdkxwYWdFd1cydzI3WlFPaGZQ?=
 =?iso-2022-jp?B?VTZiRjc0bC9kdHJQczJDRVlDWml0NHVZbnp6R3VGQUhzbXhCRThSVGls?=
 =?iso-2022-jp?B?UGFIek1zMGlYY3cwVi84ZU43ck03N1NPYU41cVFhajdjZmhwc243N0JG?=
 =?iso-2022-jp?B?Qm9SRmJseW9KT3dKZHVNYnc1SVhheW9pUzdhQlNkb3NFaEJmcWpDUkRL?=
 =?iso-2022-jp?B?V0pUeWZDL3BzblhhVFQ1cnBaMEhQNGQ4ZXJ4ZmxuaXozS2p5QTNiQjVS?=
 =?iso-2022-jp?B?WTNwMEJaaldLVkl1SkRPZ1hDdCtqeGNMbmpVUHBwTXREdVErNCs4WXFV?=
 =?iso-2022-jp?B?dDkyYWRWZVpBNUQyYmlLRlhuNnRaUi9GQS9tZEFGNzdWUEczMmd5SFVi?=
 =?iso-2022-jp?B?UFJWbmRVM3dvcFZTT3NUbWx3S053eitNTzYzRFdFamlJM21hRkpOQVVa?=
 =?iso-2022-jp?B?Sk9iZGg1VmVPR256ZjJzTHdZdWpSdUdsa1FPWVRBdFUzdWRYOUlsV1Vm?=
 =?iso-2022-jp?B?SHBjakJBQ1l2NlJ5Y0JwNzhDTDhneTZwZStOZnlXWjNCcWtmUEpIR0wx?=
 =?iso-2022-jp?B?aE8xcEFLbGtmRCtpWUdWTWVIM3g3Z2g0dzdJMXNjbUdNenV4c1VqbTdt?=
 =?iso-2022-jp?B?TUJqTHlxU2hQWDJzMEpUS2xseXdPUHBZSjFqUTAwNTJUcFZabXpPUDVn?=
 =?iso-2022-jp?B?bC96MFZyelFVUGV4N2hvQ21Samo5Q3Z1ZkxsMU1PQmN3d2ZUV3hCaERV?=
 =?iso-2022-jp?B?aTAxMCtON1ZXeHFxTjIvSFlhTXEyMlJJL212ZVpKU2xXZGMzZWIxRkVC?=
 =?iso-2022-jp?B?RENSOGZ6MnRFNEQ0WnVZU3phR1VhSk1vOFZpZUJUQkQxQm9ScHhadmU2?=
 =?iso-2022-jp?B?RGVwMll4RnFka256bHQvdjlEMjRPR05BbjlhRkdraUdYdWVvWWp1RVFV?=
 =?iso-2022-jp?B?OFhWU01jb1Bub0lBVG1sOWhONXZLLzNoUWdYc2thU3p2c1RoSnJkTW13?=
 =?iso-2022-jp?B?WVY5VzUwNC9Db21SUTVlUC9YUHIwTjRqQzRVZVdhcG1QWStJUGc1YjhN?=
 =?iso-2022-jp?B?UFZ6eGR3dWVlRGVyR3FYcWZ5RnZ2OThsSmx1REM5K1IzNEphUytRVzJO?=
 =?iso-2022-jp?B?WEVhVmtLYkxqU2E1TXlwZUNkakhrNlN0a29zV2R4a3RYT2luem9tL1VQ?=
 =?iso-2022-jp?B?OVhNdWkzWWNNcHQ1ZnB2MGdlTHRmYTNqT0YvbVdNVnNUMktkeGNiT1JP?=
 =?iso-2022-jp?B?cjhsNWs1SjZyWHR1UzZJOWJWcDVwOTUrMjlFaTNxUS9rbnEzRnJzS0lQ?=
 =?iso-2022-jp?B?U3kwVUd3R1BFaEMxbklUcmRFbS9VTnRXQkMrNzJ6WWVEK2hZQllSVFNm?=
 =?iso-2022-jp?B?ZzI4dz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSAPR01MB7669.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007)(1580799027)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?SUtGcno3dGtXdllUMXlaQjE2b2tFbk9zVThLR1NTVXJtZHhsMWFFUkw3?=
 =?iso-2022-jp?B?b2ZYTnRnbDBiU2o3b0huSnZFME8rOW5aOTMxRHNES084ZzhnK2J0NlRx?=
 =?iso-2022-jp?B?dWFvU2M4ZW9CM25mMDI3VlRWaS9hd01odDV3Q3hJQ0ttNU5XdWJEWkU4?=
 =?iso-2022-jp?B?bVpvS2FFY1ZwMVgvTU80YmpqaTVqOWh2cldUMVNpdWxsVDNsNE41dFZP?=
 =?iso-2022-jp?B?NjdxNVZkTWlidkFuekFITjBKNG1tcFJaYWRMSlpFTWpsb2srYWV5RGVP?=
 =?iso-2022-jp?B?NmFIUU1oUDFxdUNreXAxYW5QZ3dpd0xwTkU3OVdYc1JTNGFSQ0NPay9L?=
 =?iso-2022-jp?B?cFRRME9KUVZuYkp1SjJRSGJ1d1ZDOFFrRnpyeHZaQ2doVU9hM1U1aHJ1?=
 =?iso-2022-jp?B?STRqV3pvZ2NpRlNOVldKZGJtbURUek9jb00vaTBpN3ZuSEpka3RvUEI0?=
 =?iso-2022-jp?B?b21QVDA5NWVMbHNwMFN0WXNLZUlCZWlzeG1XWWI0SmxKSlhkTGozWVNQ?=
 =?iso-2022-jp?B?Z0hQbmp1bkxJa1c3b1VDb3pFV1c5MGZXRjVOOXJlN0RiWFM1ejhLWU1B?=
 =?iso-2022-jp?B?dHlyUEZ4YjNRYVByNG9ZY1d1bysxRUM5YlAyVzEzc09SelY0Vnk2Wklk?=
 =?iso-2022-jp?B?SEFvSW11YjIySWVYQTdJYjhtN3V2ci9qQzRUNjVKbTVwYmdXQ3JveEZO?=
 =?iso-2022-jp?B?MXZOaFFhMjZBY1JNNVlSZy9KZm1EUllUVjFSZXZHa1dvM0ROOU9BSEpB?=
 =?iso-2022-jp?B?ZzFpTmhVYzFQZURUT0xOZGluNmdRc1ZyUmtuWmllM2gxWTJCaGVNSlpt?=
 =?iso-2022-jp?B?Z3BLR29uNWk0clZDamVuQXpFRWF4T0FTRjhjbUJNM0wyNlhNcUlTem9k?=
 =?iso-2022-jp?B?bnJUdDMvMkIrQVM5SHljMUllcWVIRnEwOWdteVFrQ25GVGdQbjVMY21I?=
 =?iso-2022-jp?B?cDRtMTZtb0hQSWVqQ051TWYwQk5ueGU0dWFWZW53Z2c0REk3YnlKbXkr?=
 =?iso-2022-jp?B?eWFuczRMdVJMWnBuUmc2REpMS01jRFZDd3dUb1hyTlhDZjNCNmRNNFV3?=
 =?iso-2022-jp?B?OGVVblYvNTUxVEJjSWZhcUdxOG1kblA1N1htMjdxR01xUHRWdXhBY2li?=
 =?iso-2022-jp?B?MU03VUtjekVtaVV5WUkvTE9NellYRUViaUZIcnUzemFOV3BwS0dtUkVY?=
 =?iso-2022-jp?B?aHRlTHM0Ym9QcU0rcklka1F1cDdTYm5ER1pRb2JPZXMvSW5WTlNoaU44?=
 =?iso-2022-jp?B?a0ZGRkF5dDFrWGhSQTMxVE5vN1MyeE85OUo1N3RZWjNRcy9lZFJhUzMv?=
 =?iso-2022-jp?B?NnFWY2U4WGtUVDNnSmZSQ0tGYjVUSWlTZVRPMVZjMlJEODEwb3N5K09I?=
 =?iso-2022-jp?B?ZUdaRThBcFZTeXVVdWFQTjhsb25VQ3pNK0lYNXFUODB6NDczejgvS1Ey?=
 =?iso-2022-jp?B?MUI5dkVIMGxoMUlHMUtSaEM2SXgzV3lWdmhpdjlKbzlJaFBCaHAwc1V0?=
 =?iso-2022-jp?B?aGREK1ZQZkJFYnVaSjRkWjlmK2FMY1daK0l3UEkwKzZ4L1o1eW55NVRD?=
 =?iso-2022-jp?B?QmFWSEJsWTJ6N2ZydWJWSi81bFpRVVhmYkhkWnpNdnVwNjBHM2NncGpB?=
 =?iso-2022-jp?B?QXZOQnljcndrcTdPWk90blVSRi91cGRJN0l4ZzlidVFsMkc3NVFzNHRF?=
 =?iso-2022-jp?B?QWZzdjhkdXprWHpCRVdmMllYd0NNb0IrV3I3dnB6UFY0c2c2aDRjK24z?=
 =?iso-2022-jp?B?Tk43MTNqaDZSWjdiZ2FqZ2huWmYyVmJwclV2NEl6NDhXUFd2MjV2bHN3?=
 =?iso-2022-jp?B?TWlZMC8zUGJUNW5PZlA2SVdLcGJDb3RGYkVOYTFTdWdFOHBvaHBiVURa?=
 =?iso-2022-jp?B?cCtlaGZqUTl6NVZlN0ZkOGd1Z0VqaUVGZEt0Um93Z3ZhWml6TmE0NExh?=
 =?iso-2022-jp?B?NUprQ2RhOGhSS0h3TDM1Tjdwa1JiSlF3aTlaek1PdjNrMDVxTWtxdk5a?=
 =?iso-2022-jp?B?OWFVTjdkYy96MExrUlBvODJUMC9hMVQ0SVl2UnBZMERQYTgwekZZTlV3?=
 =?iso-2022-jp?B?b0o3MjVjRi9kbGNZajZZc2lyRGVxOVFQOTNpRVlzV0xUUEhSSjlFeGla?=
 =?iso-2022-jp?B?eDFRZ3Ewa3JaaXFWYWNpSG10YjVYK2U5djIvSWc1a01GZ0VDZEVjcytS?=
 =?iso-2022-jp?B?dWNCYm9tY0k2aENVWVk2MENPTDlPbGhWNDBPem1FL1hGMHNiYmUyYndh?=
 =?iso-2022-jp?B?YTc1ZjJoOEFDdjhlcnQwZzVmOU5OUjV0OFgvcXZ3VEQzdFBmZllHYzlG?=
 =?iso-2022-jp?B?d2p6MTVkMDBic2ljVWNXSkFkaHZ3NnBxM3c9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB7669.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed416030-ecad-4643-c419-08de202c1d93
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2025 07:38:17.9102
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kvLV8RVDQqfsLGRw861c3mOxQJJ/xBE1hSnGkSf+2uK8QCrsISBAw3HnGbzqlVCxPJ//eTB3X+zR/jwAIz+6ntTumwFMbR7lhHlBPkPCWLY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB6676

Hi Will,

> Hi Will,
>=20
> > [You don't often get email from will@kernel.org. Learn why this is
> > important at https://aka.ms/LearnAboutSenderIdentification ]
> >
> > On Mon, Oct 20, 2025 at 09:23:05PM +0800, Hanjun Guo wrote:
> > > On 2025/10/17 15:39, Kazuhiro Abe wrote:
> > > > AGDI has two types of signaling modes: SDEI and interrupt.
> > > > Currently, the AGDI driver only supports SDEI.
> > > > Therefore, add support for interrupt signaling mode The interrupt
> > > > vector is retrieved from the AGDI table, and call panic function
> > > > when an interrupt occurs.
> > > >
> > > > Reviewed-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
> > > > Signed-off-by: Kazuhiro Abe <fj1078ii@aa.jp.fujitsu.com>
> > > > ---
> > > > Hanjun, I have addressed all your comments.
> > > > Please review them.
> > > >
> > > > v3->v4
> > > >   - Add a comment to the flags member.
> > > >   - Fix agdi_interrupt_probe.
> > > >   - Fix agdi_interrupt_remove.
> > > >   - Add space in struct initializsation.
> > > >   - Delete curly braces.
> > >
> > > Looks good to me,
> > >
> > > Acked-by: Hanjun Guo <guohanjun@huawei.com>
> >
> > I wasn't cc'd on the original patch but I couldn't figure out why it
> > uses IRQF_NO_AUTOEN when requesting the irq given that the first thing
> > it does is enable it.
>=20
> I misunderstood the usage of request_irq and enable_irq.
> Since there's no need to separate them, I will remove IRQF_NO_AUTOEN and =
the
> enable_irq call, and send v5.

I found out when calling request_nmi, removing IRQF_NO_AUTOEN results in an=
 error (-EINVAL).
Therefore, I would like to keep IRQF_NO_AUTOEN specified.
If you have any comments on this version, please let me know.

Best Regards,
Kazuhiro Abe

>=20
> Best Regards,
> Kazuhiro Abe
>=20
> >
> > Will

