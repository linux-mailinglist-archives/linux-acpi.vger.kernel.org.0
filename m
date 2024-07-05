Return-Path: <linux-acpi+bounces-6773-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B22009286BC
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Jul 2024 12:25:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62B7C2815CE
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Jul 2024 10:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C3361487DC;
	Fri,  5 Jul 2024 10:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nec.com header.i=@nec.com header.b="OZ/uKcKw"
X-Original-To: linux-acpi@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010055.outbound.protection.outlook.com [52.101.229.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5107014831D;
	Fri,  5 Jul 2024 10:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720175126; cv=fail; b=imQAQ06bubklLZRubJRSOga8py4/BIkhcXXIHcZjvyDVM1JNDt9eb2gmqDTVimxdI/mQxYDPcykmUGOUFqBjvv3g2pSCx7OlpZA8QHpCYSklgeifokv2Y3rJuKfLbvXNeK+oOUX89aXtIfi9ybKVxNmMJiLuXoBrdOPIpe+Pcrg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720175126; c=relaxed/simple;
	bh=HElkWa+8HWmbFpAUkDQCF+kaAijXM6HdMxW0fcmiByI=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=PnEJltVVBKHWqEWX9hsGAJHda4G7avLnryEnbE+GIb4BKnloHQmuppXFFhoIQ8TO4qKJ8SFkI+gCR1sa23AYMwxiV6kgpliz9L+XqHqBRAuMjEdfpkdjuLtyR2kRSZiwXLnJBifTy65kLiK5KaH5bHMOKtBP/dVNC0S1nxcZYXg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nec.com; spf=pass smtp.mailfrom=nec.com; dkim=pass (2048-bit key) header.d=nec.com header.i=@nec.com header.b=OZ/uKcKw; arc=fail smtp.client-ip=52.101.229.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nec.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dfwKRSnk/q3ROyaFmYrt9QQr4ytUTUdE8tgf08M/lNlNKe+SleihDx18pXVWUBvSpj3q5e/IoZ45U/UKGwAQiIjT5LAx9URxJ99i9WHmJA4lNvq5IbahhZuZwm6ArxHy60LR2h8sIiQOSNX98SCT0tL8TTfbgP9N1WF0qQBvMh8dgkjPXIOELVRV/EnF0bYew28AwNDOM1N9xF7kxgoKfKHKge/rdi/XE8DwCuW/8UTfCoN6QNZtkjJxZjBWWeAtc/An57qiM/CAZUtglBnrkpJ5iUESbaT+gd5RCg/DE4UV6GaWMPQxT1l9rgvms2KeVzKICklW8LW33N2FS7bBJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MuXf34PFJm/Um2clVlGKPtPU9DTUWMjdONesDuGY6lE=;
 b=eBLTxRp19N0jgWGhC3nHcLLnfFQBMjuKGfaJtcdDpGythwrAlOjLWzFIQzNIorNmye/kdU3CuMEVuBasKwXsYldorHqVrGURy6KmWHDCrSFtscfNHY0woKFYbUbgHk8IqkNe4V4qxAPDCsRF801o+mC4E7CC07t7D/hpAF6l3wUQk/TUiSOlQ4jvqCPMnFy7KsCWIB3QE0rbNhf0g3qhx7IgauWN3WmJpQ0iXgI7b4v9b2Tf3dTF6D5duRWnmkbh22mX1eOuVd9VPQP03iKgmTvR2Y+BqiG2+tLEPI5XTM6a3HVA4G3nckDUzsptmI0Wg4oWEdangFEUG/lLldnbPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MuXf34PFJm/Um2clVlGKPtPU9DTUWMjdONesDuGY6lE=;
 b=OZ/uKcKwnsj0nf0aOTVugT2poDg9Vnql4snFFhMKdKiQUHXa6+8bS+KKZHWt/uBIVBVPSx+23K7L67/5DWPByemDB7vaNHz6m2mRakFSvMi4fYJmbe68GmWgtXp3wAE5kDUGqvkyNS2g1eCNa1IsWHxNjBKBUpyQ+eug/dCfR7C+k+vfKigScAEI0mLEKjeiN7boTNa/6fuxOvCjY4T1548Lh3lkPrbFjUhWh9K/GxHDIrBSzQhhseTu13Uv0l0BO3AnrsGPzKT2mj9nkyfEL2+1JvPoD2gp2U7UHA3OyADyrFYc1MFcnR66RL6V25IqU9tgE3Bxbtv3iEagvBnk6A==
Received: from TYCPR01MB8389.jpnprd01.prod.outlook.com (2603:1096:400:15f::5)
 by TYWPR01MB10806.jpnprd01.prod.outlook.com (2603:1096:400:2a6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.25; Fri, 5 Jul
 2024 10:25:20 +0000
Received: from TYCPR01MB8389.jpnprd01.prod.outlook.com
 ([fe80::29dd:6d4f:b2de:f254]) by TYCPR01MB8389.jpnprd01.prod.outlook.com
 ([fe80::29dd:6d4f:b2de:f254%6]) with mapi id 15.20.7741.029; Fri, 5 Jul 2024
 10:25:20 +0000
From: =?iso-2022-jp?B?Tk9NVVJBIEpVTklDSEkoGyRCTG5CPCEhPV8wbBsoQik=?=
	<junichi.nomura@nec.com>
To: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
CC: "rafael@kernel.org" <rafael@kernel.org>, "lenb@kernel.org"
	<lenb@kernel.org>, "james.morse@arm.com" <james.morse@arm.com>,
	"bp@alien8.de" <bp@alien8.de>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
	=?iso-2022-jp?B?Tk9NVVJBIEpVTklDSEkoGyRCTG5CPCEhPV8wbBsoQik=?=
	<junichi.nomura@nec.com>
Subject: ACPI: APEI: ERST: Don't retry read when "Record Store Empty"
Thread-Topic: ACPI: APEI: ERST: Don't retry read when "Record Store Empty"
Thread-Index: AQHazsWjaDTSYuFPoEWjsVW52y1RuQ==
Date: Fri, 5 Jul 2024 10:25:20 +0000
Message-ID: <20240705102517.79689-1-junichi.nomura@nec.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: git-send-email 2.45.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB8389:EE_|TYWPR01MB10806:EE_
x-ms-office365-filtering-correlation-id: cbaa7bbf-aa7f-41ee-bf23-08dc9cdcc5e2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?TmZqRFQzeGMvZWNYajFoR05uNWZRMGFtQnBtZFBPaTVQWERtTFdaVUM3?=
 =?iso-2022-jp?B?V1RQOEpXMEk2WFU1eUpiMlVPREh4OXNCYmNvM3NxVndjWlMvQ25ydUZZ?=
 =?iso-2022-jp?B?TkRYMVZ5MEFKS3BzQndmNGZraHlnMzZId2lwYldialowQWZ5QlRFQUkv?=
 =?iso-2022-jp?B?OEw3ODVSK2JuWis5WXJWR2Q4Z05pUWZPM3lxQ1BrMEh0WGdCeWJTK1Za?=
 =?iso-2022-jp?B?Wk5VMUJLRTlxdXBGVGFQNEhDZXpZU0M0K1Q3MzlJRTJXZlZoei9HaW02?=
 =?iso-2022-jp?B?endUUmZSYmhWLzBlVlhsM1V2aGJhQ2lmcDJzbjZQWFhHenlldHEyTjhX?=
 =?iso-2022-jp?B?bmMwTjF2eHdlcnhZMjgwaEpUQ0tBN1cwdE1PUUJHa0VGa0dwc0tiK1Vm?=
 =?iso-2022-jp?B?WGUzWGhqeVhMSXdlT0poeUZ2c1BrNEg0dThzVzU4NTJRUTR0UjRuTlhE?=
 =?iso-2022-jp?B?b1IzU3pJU0VmNWhSU0NJc0NkSGNSaTd0SG16bFYzVU91Y3B3eWtGQmhi?=
 =?iso-2022-jp?B?Rld0YWNTV284NWdsVzh0NFdNbUdhTE9CWGlvWE5xSW1xemFSenBpVHl3?=
 =?iso-2022-jp?B?ZGVWQk1CYmthUGJUMVB4TGYxdFI5MWlVL2c3a2trMEc1Z2F0elNzRW1D?=
 =?iso-2022-jp?B?VE5BeXVSd2dheDNJY1NBaHlYa0pmWUllb05PWjlxc2tLSnVza1R5OEpy?=
 =?iso-2022-jp?B?VlVSRTJONXRjZ2RrRlQ4L3V4L3J3WlZYNktrMGFqR05LM1JVZDVqUzlW?=
 =?iso-2022-jp?B?VHdpWWoySmdreTBORWR6cG4xcFBURWIzQ1ZxbmZ5Q3Y3REZFQWRPYllW?=
 =?iso-2022-jp?B?cXFNRGozMTgrQVpHYWxzSlk4YUk1N2xLS1NiLzhxMlY5VlBwc3gwVkd3?=
 =?iso-2022-jp?B?RHJCN2VRVEV2ZFQ1Uk9LR0V3NDc4VnZqUzViMGNVcHMwOGpobEhFZUMx?=
 =?iso-2022-jp?B?WjRmUUoyWVI5Z2p1MmxIVG15T2laOUF6K2NNdXZ5aDNqdm00aHBLeXkw?=
 =?iso-2022-jp?B?UlNLdlpQY1pNM294ZFBJVTdXMXdSK0wzc3BCQ0lpT2s2ZmVBRVMwM3px?=
 =?iso-2022-jp?B?ZUttZVphWjBsMzNEVmEzaXJrL3RzVzBpcFoyUDRoOTZDTGhxMFRKai9K?=
 =?iso-2022-jp?B?VzlIbXRDWEs5dDdmQ1JBcTV3aGJDL3RYbHhXTWMwRTdMd1UzZk1mZkJi?=
 =?iso-2022-jp?B?Z2ZNOXloVXBxR0lOTGlUTFQ1UEtvenZjUit0NVYwS1Z2NTJXdkpBUjZW?=
 =?iso-2022-jp?B?VTRQOUtQdDB6UVFJTDJad3lzV0Nzb1krNXM2emQ4Wnk4NWpoV3pBQTJu?=
 =?iso-2022-jp?B?RWNPWTU2WkJyc0N0Z1BmZlBxUlcrV0JRalgxeEljRkcwdTFhcGlsZkg1?=
 =?iso-2022-jp?B?dVBTcHFwT2ZBRE40ejZRRDlFd3lvTDZvMFBoTXFScTE0dk1UQXpoRVhB?=
 =?iso-2022-jp?B?ZTd5ZGR2bDRTMFhhK2FLWThKbUtUanU4ekN0akxuaUI5WVA0UUZPRGN2?=
 =?iso-2022-jp?B?aVdLOHVJc0t1ZnJHcXBTQ0p4aCt3aHZMcThrMWpPak1mVUp1S253Tnhq?=
 =?iso-2022-jp?B?cm5OS0t0SDRONVBtSVJ0MjFRSE1yZ0tVbU1UN1FzMU0xakxUK0hwMkxO?=
 =?iso-2022-jp?B?eE03ZzBPTDRpQWpDVEdFcVBXNG5NTVJnQ0xzZjJJTG1mMFp1ZmovSy9i?=
 =?iso-2022-jp?B?Nkk1bVRZTUF3TnRCdzlFUEdtVWRwVXFXeXB1OTVGNVliYzBPYTc2cWc4?=
 =?iso-2022-jp?B?T01YSmlTVW1KRkl5TFd3MHArTVN3ZjJKQ3VScTdwckg3eGlrTkZSV045?=
 =?iso-2022-jp?B?ZEQ2cERvb3F5NllscEZMSnpZemdxZnVjUk5XWUZQaS9pNjMvK1RMOUgr?=
 =?iso-2022-jp?B?QWJVY1ZMdndSWDZZaThnQWdsNzRvVFh1U2pKdnU1Y09KODFBeDdNbHk0?=
 =?iso-2022-jp?B?bHV5ZTdpQ0pIWUYxQnRQcVhKZHJISmo2blp4Y2h4Qk1KRmNjcDNBd1hu?=
 =?iso-2022-jp?B?TS9BUFp3STc2MHdkRnNmb21aTldJMkxpekVhVmhKNUl0UExOZFlIY2c1?=
 =?iso-2022-jp?B?V3c9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB8389.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?NHVWRjIvK1FaU0xxK3dCa1NHLzN4MjgybFEvbzRrdndPSFJmc3dpdlFX?=
 =?iso-2022-jp?B?YXJxS3YrRlU1R1JiYkloanB4WEFwNDFTR1phem1sc0c2cGw4TGlsMHAz?=
 =?iso-2022-jp?B?bzVrZ0R5a2xIKzVncnZBVEhMbTdiYWQ2Nk9BRjBLckRMSzl2b3hKWnVM?=
 =?iso-2022-jp?B?bVVTWW9QY0lCQjJXdWdQcmRZK3czNzh1QmRvVyszZ29JS09PV1ZPb3d1?=
 =?iso-2022-jp?B?Vm1pQTUvNmZ5SE14WkdUM2tSTDBFcFA3ZEFXOGRSNWtuKzczWTVCdXJm?=
 =?iso-2022-jp?B?MWhQOHViMDhYUElGR3hHZCtCY21EZnZhS0QzVWxkNDV1d3BaRlJRZnBC?=
 =?iso-2022-jp?B?cTViUUd4SHQ2NnRyNFVNZlNoUHRMeXliL2tYbE9hdkxvdXdiSGk1dGhp?=
 =?iso-2022-jp?B?TC92NlZtdW9QOGhMUm4vdUdmK1kzMzBlU3V2VDJQQ2Q2TmNEb25aYlhx?=
 =?iso-2022-jp?B?VldtTHdqN1E1ZzZHemNOK0lqV05yTElVK05rUzdQS3ZKK3hRa3NBV25j?=
 =?iso-2022-jp?B?eUlpcXZjaGRDeERBcmRabThvMFBSUXA5WFlIbzhVTG9kQW03QnhqSHdm?=
 =?iso-2022-jp?B?QWlWTEhES3prRjZFUWczb2pKUWV4RU5wMVZ3cW5TU1Z1d3FLa0s5Nkt5?=
 =?iso-2022-jp?B?eUNabStERDRjYzA0ditWZFNUM09jQW1PM0QzK3E2QVVrNXJ6V21EQjlO?=
 =?iso-2022-jp?B?RUJSSWYxUVNGdkhPamNJb3E5S0E3RVE2eWF1dHVHeDk0RTBJMnR4M2lj?=
 =?iso-2022-jp?B?WkZWM0dSMlBTTUhrc3NpMkZBS1ZPWGFmeUpEMC9pZTV0UHBlVWVOWExZ?=
 =?iso-2022-jp?B?VDhHWVMwTGI2SlJZOXdIQUREZDZKTUVYV3Y5cktnekUzRjhlWFF1dllD?=
 =?iso-2022-jp?B?eCtlRkNpZlIzS0psTGE5VU5nVjlBU0ZQMTBUbDdBT0xBWUpjQ1FadXBl?=
 =?iso-2022-jp?B?cklDNU9xVHNNamo4bTg4eE1vaTJuZnU4SWYxVzFLZGZhNVdkRndaOG40?=
 =?iso-2022-jp?B?UjM1N1B1UGszcjhibGg4OEF5T1VCTlVlaS9ESHpzQ2p3Z3VCTWNVejhC?=
 =?iso-2022-jp?B?NUJzSWRZOENiaWYxblhzVEZaTnI5aEVGeG8wenNrWTg5NktrSTNMK1hL?=
 =?iso-2022-jp?B?cmtPVlVreFUwN290NHBRd1dwVTRsdUN3QU1YbEFFeGpoajliSnlTVXUz?=
 =?iso-2022-jp?B?cmJjejVKcVFoNldWQUZTUTlUQmwzWWN1T3ZibHp1aUpsNmMrb09IOHZJ?=
 =?iso-2022-jp?B?QXEydUxEUkc4cWpUWGdYajhBRm9HVHVvNEw0TDZ5V0MzcXJQZ0FnTnFI?=
 =?iso-2022-jp?B?R0wwblZoL1FXVkRTT0xqUnh4c3EvUW5DSFBZR2JRUWlraUI0NGhTNy9Q?=
 =?iso-2022-jp?B?NVRKclNPbmk5c2xLM3pIRzJZYmZCK0RCRWdKbW9mZTVSRXREaFBNU2li?=
 =?iso-2022-jp?B?b1FpWFpXNHdVSEg1cmg1VHBORSsxSXp6S0JrUnZCVTNBckdNNGdUaTFI?=
 =?iso-2022-jp?B?a1R3WitXK09kbXNkVlNmT3JBdms2eDBhYjkxb0N0L1N3WE44L3F0UGV0?=
 =?iso-2022-jp?B?ZnVoM0ZNZFBOR1hVWjJXVmZRZWptQnlEY0RGbFdsemZod1BDWDdkZWZG?=
 =?iso-2022-jp?B?VVppUHhycUV5SlQzK3l4UVhQS01Ebk5kTm1keHZDdFd2WWc3aUZvek9F?=
 =?iso-2022-jp?B?M0Q5M3BOdjQ5bHA4YTZwRzd1NkFHMm9nYVRHdk1jNGMvWGZXcDBDTzB3?=
 =?iso-2022-jp?B?TWpXSmFoYm1qcVQzbkJHR083cVFwZFZLZ2llWi8zV2NRTGNJYUU2bmlE?=
 =?iso-2022-jp?B?aGVxYlhySFM1YWxveERkYjZ3Kzc4QkczTml5a3E2YWtOSnNqMERiZGtD?=
 =?iso-2022-jp?B?VVlzc1R0YW1VMFVUN3VRbmZhWE9vYm03WHpwMjZIMk5jVEtsYzNoMzNz?=
 =?iso-2022-jp?B?NWEyR0FCWEx3RlJCVlhxNGtmSTVxcWg3cXpxbkNGdEVpT1F4Z05PeUZw?=
 =?iso-2022-jp?B?WERKbmJKKzMydjJROURVRFF4Y3dUREZqQk9jNHdhNm5aUE1paGhEVGYy?=
 =?iso-2022-jp?B?K3FlYWJUZ21KZHgrSzFPZks1RkxBUWlOckRBTUFFaWdNbjRMN0JkSE9K?=
 =?iso-2022-jp?B?b2tEOWMvanQ1RU1mNllYUi9nRk1rYm1nS0duNk9sUlV0OWtTZkFpNXFY?=
 =?iso-2022-jp?B?M0gyeWlBb2wwajQxZWlheEtydSsyRFhRNjd6M0x1cllRZnF1Q1lZcUIz?=
 =?iso-2022-jp?B?Zk40K25sSVVHRHRUaGpFSGp1Nnh5d1FLNmVDRGo3Z3YzR1NzYldQMjBz?=
 =?iso-2022-jp?B?NWpHNFp6dzFHRVlYdm0xMEh5T3hzRGNxZlE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB8389.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbaa7bbf-aa7f-41ee-bf23-08dc9cdcc5e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2024 10:25:20.6055
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R7Ds/VbqW6ao5Uy4V4BUQ9QRFnwvJoN5dvxwXYOwATE/1TEMwOQ4dsD57HjAKj1wmP5mAFvPDI9wE00ZoN6Pqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10806

"ERST: [Firmware Warn]: too many record IDs!" is logged on some platforms
when there is no record.  That happens because erst_reader() retries read
when erst_get_record_id_next() returns valid ID and erst_read_record()
fails with -ENOENT.  On those platforms, ACPI_ERST_GET_RECORD_ID returns
ID 0x0 even if record store is empty.  Reading record ID 0x0 on
empty store fails with status code 0x4 (Record Store Empty).  However, both
"Record Store Empty" and "Record Not Found" are translated to -ENOENT,
the reader cannot distinguish between them and tries to read the next id,
which is again 0x0, and repeat that until it fills up the record cache with
invalid entries.

While such firmware might be buggy, we could make the reading loop more
robust by returning different error codes for "Record Not Found" and
"Record Store Empty".

Signed-off-by: Jun'ichi Nomura <junichi.nomura@nec.com>

diff --git a/drivers/acpi/apei/erst.c b/drivers/acpi/apei/erst.c
index bf65e3461531..ce186f8d7a15 100644
--- a/drivers/acpi/apei/erst.c
+++ b/drivers/acpi/apei/erst.c
@@ -95,6 +95,7 @@ static inline int erst_errno(int command_status)
 	case ERST_STATUS_NOT_ENOUGH_SPACE:
 		return -ENOSPC;
 	case ERST_STATUS_RECORD_STORE_EMPTY:
+		return -ENODATA;
 	case ERST_STATUS_RECORD_NOT_FOUND:
 		return -ENOENT;
 	default:=

