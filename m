Return-Path: <linux-acpi+bounces-18794-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39C62C50EC6
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Nov 2025 08:26:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C25E03AD0A4
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Nov 2025 07:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 076E52C11F5;
	Wed, 12 Nov 2025 07:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="pumh/Nih"
X-Original-To: linux-acpi@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010009.outbound.protection.outlook.com [52.101.228.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14A32C0F97;
	Wed, 12 Nov 2025 07:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762932152; cv=fail; b=JFdbiZVCYUZpZpgLtuJCoVXDRRcQGLm0iWrIu2YBPHXqPtzvKbNACyttEFc8AqcLoCbaKYAppzQ/V5vtNwJNO+q3KbNvTr98Og06MY7qboCvB8duKKUmN+6hu5HDfSDEttj0OfaKXM+3s0cD2fW1LczbWUjIxPV0yngDXAw1Vhs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762932152; c=relaxed/simple;
	bh=AX8mteooVZ+CixcOtWj78RMAorrwZXN0Gja+/rkDvD0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NXhoyEV7MS4uEaSdAvBIjXY1CL4OrvFppV2anGbAJKajdPwpM6Utn9m7AO4KCCJZ/XMsfG8uCamsFWFZqQmRC5MoxZxwaMWaVyNJSWh3kTH8iC4tMrb7YSmwQw2WjuouCUvUvgCAyMG7hcm4fSLkXSmzlyweJvFqiArdLxtipUo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=pumh/Nih; arc=fail smtp.client-ip=52.101.228.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YZwKTaBIyP3XCMvpBotBuZQQ3ntpzk2CGUMJsiPZzCiWoqL29HRP4brxL+Je/ge6LoASjGxylfPBok9QVIndEqToKXBvHlVaLD4pJTMS79QnJFezAC2wIMPqv2YoIkCLYu1lF7k0mfwv3LxVy9k1xWJSfSCfRiaiRrMZMnrpwlK/1TuGdAxuCDlcFVG/sp4PPOZah3foso6LJhaMxBoIH6CUoG1OkgM4eRWwO61WTZ09flXRPo6Ivyahpkpffo9m41LpJ9YH+a1lWfCsKV1CF+EDHcLQqhcclGRWaErbiJ2/A+OJtcmwM7HD4U0Av0fc3oGAQiuq/GZAXwyUA94rbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AqGAvkvVCtw3ELJ24hT+zjVfy+dMzJ4LUyC7LaSwBUk=;
 b=XljUT1MtM695KCzHzUADoYrgzJ1InQKXHBV0Rmi6ZhVvWRskoDZp9AUKifUq+dez3evX3yK6eO0tPB/B5HCDs7Eq2xdQlSe93bSHrjcm/W0dSojHDCc1c6cm7RQUWs4CK+5zExD7FAqU6HFzY551zMP8LafjfkyI73xVWpsRyBd0LNWI+5xNNZfLqwWQPaO6WioPuHDyH8mX3Gq9N3dLyiwLapEVDQzuzL9uCY7A6hqD40Sr0Ex6F1Tpi8dXz9H0h9HaujDYBcwhSHfcBU7za2JoTAvwjNZHjUbxHz3i0xbF7F5crXer28CLbn5Y2IzxCQbAd+oB8Pgy+0rwE5RI5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AqGAvkvVCtw3ELJ24hT+zjVfy+dMzJ4LUyC7LaSwBUk=;
 b=pumh/NihP66wt1RlFRwWt8NTWs64KHpRYCAFAD/maDSchQabG0v9ZURp89JYf+v5pErNNkLt2G8nNaczURSU1E8/KK0WziQboORVUrZkTzaIsZh2+Y/h6rUFnadpPniNKJAo96nWpQMutWNz3V3R+Ri2DgClIzKS1IB1W2MGjzNWkRE3kKZyIhudNS8l9HKs0wNKtEg6YwbFORRMbn7Aek3GhKgt46jFA81ovVB5iPvcogI4PeGeDw3SjEP1glVbQMDEJoKzuRaD5DNeeSNilLYZsQMSt+yP/6n4pYn9GQm5vSg+nyTkNHNWYKlDjazx/8xU0hx1IyKGWRgsnsSHvA==
Received: from OSZPR01MB8798.jpnprd01.prod.outlook.com (2603:1096:604:15f::6)
 by OSBPR01MB16291.jpnprd01.prod.outlook.com (2603:1096:604:3f7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Wed, 12 Nov
 2025 07:22:27 +0000
Received: from OSZPR01MB8798.jpnprd01.prod.outlook.com
 ([fe80::e366:d390:4474:8cfa]) by OSZPR01MB8798.jpnprd01.prod.outlook.com
 ([fe80::e366:d390:4474:8cfa%6]) with mapi id 15.20.9320.013; Wed, 12 Nov 2025
 07:22:27 +0000
From: "Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>
To: 'Ben Horgan' <ben.horgan@arm.com>, "james.morse@arm.com"
	<james.morse@arm.com>
CC: "amitsinght@marvell.com" <amitsinght@marvell.com>,
	"baisheng.gao@unisoc.com" <baisheng.gao@unisoc.com>,
	"baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>,
	"bobo.shaobowang@huawei.com" <bobo.shaobowang@huawei.com>,
	"carl@os.amperecomputing.com" <carl@os.amperecomputing.com>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>, "dakr@kernel.org"
	<dakr@kernel.org>, "dave.martin@arm.com" <dave.martin@arm.com>,
	"david@redhat.com" <david@redhat.com>, "dfustini@baylibre.com"
	<dfustini@baylibre.com>, "fenghuay@nvidia.com" <fenghuay@nvidia.com>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "gshan@redhat.com"
	<gshan@redhat.com>, "guohanjun@huawei.com" <guohanjun@huawei.com>,
	"jeremy.linton@arm.com" <jeremy.linton@arm.com>,
	"jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
	"kobak@nvidia.com" <kobak@nvidia.com>, "lcherian@marvell.com"
	<lcherian@marvell.com>, "lenb@kernel.org" <lenb@kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>, "peternewman@google.com" <peternewman@google.com>,
	"quic_jiles@quicinc.com" <quic_jiles@quicinc.com>, "rafael@kernel.org"
	<rafael@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
	"rohit.mathew@arm.com" <rohit.mathew@arm.com>, "scott@os.amperecomputing.com"
	<scott@os.amperecomputing.com>, "sdonthineni@nvidia.com"
	<sdonthineni@nvidia.com>, "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
	"will@kernel.org" <will@kernel.org>, "xhao@linux.alibaba.com"
	<xhao@linux.alibaba.com>
Subject: RE: [PATCH 10/33] arm_mpam: Add probe/remove for mpam msc driver and
 kbuild boiler plate
Thread-Topic: [PATCH 10/33] arm_mpam: Add probe/remove for mpam msc driver and
 kbuild boiler plate
Thread-Index: AQHcT+MjJGnJzuHoRkq4C2sKwzbbcbTuqI/Q
Date: Wed, 12 Nov 2025 07:22:27 +0000
Message-ID:
 <OSZPR01MB879857F2126672D1EADA04668BCCA@OSZPR01MB8798.jpnprd01.prod.outlook.com>
References: <20251107123450.664001-1-ben.horgan@arm.com>
 <20251107123450.664001-11-ben.horgan@arm.com>
In-Reply-To: <20251107123450.664001-11-ben.horgan@arm.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ActionId=17982a8e-4265-41dd-b89b-ebe3fb70d42f;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=true;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED?;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2025-11-12T07:15:47Z;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB8798:EE_|OSBPR01MB16291:EE_
x-ms-office365-filtering-correlation-id: 66f59537-30b5-4368-e496-08de21bc3bac
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|1580799027|38070700021;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?TG9rbkhtNHBaUlRFSlJ6cmlFRWNhNTlzSVhXUk83Uy9McVViWVdmQ1BW?=
 =?iso-2022-jp?B?R3RSMnZ3TThpUWRkTDlzamV3OEIvcXMzMkJ0S2k5VzNNY1VlakpvV2h5?=
 =?iso-2022-jp?B?Qm5ON1d1R3hpSFJGUElzV3JXcFJ3MHVTdS8vR1N6dGdvZjhRR2dQKy85?=
 =?iso-2022-jp?B?YytMTEZPTm9ZYzRzS3NzUlpDaTB0UFZVejlhN2h0blJXaEFMUlQ2aEhS?=
 =?iso-2022-jp?B?OVhxSTZoL2ZadWtzK2tVQVNoRjFjWGc3MVRtQURna2p0bGNIc3dQZ256?=
 =?iso-2022-jp?B?azdERUFKZ0FraW0rY0d3Q3ZMR2hTZ3p2bDRLYUQ5UnZTLysrRlZsWDFT?=
 =?iso-2022-jp?B?cWdHU2JEVXVOWWxsNmFRT3d2a0Vxd3l6VnRiZEowWTFJYmJDb0RRaUVl?=
 =?iso-2022-jp?B?MU9id0wwS1BML3lSRHlSZVRoNlBnakw4WDVNV3pkbjRaVFZvYTR6dFlS?=
 =?iso-2022-jp?B?cE5ncE5ZVHgxZ291clBqWWtQUlZYanVpRmVXMERkZ21nN3JYWmVYcDR6?=
 =?iso-2022-jp?B?bG9mSDErbjlGNVFCL1RNL3B4ZUgrS1lGK2p3YURacVFZdUVpREZTSkcw?=
 =?iso-2022-jp?B?R2F6cXpiUkRzd3lpcFUvazRDMDQ3MFAwTlducGlOQnNRSVlFdUZkR3pQ?=
 =?iso-2022-jp?B?SzZiR3Q0WHZxaFp2WEl6STJycDBDNDJHT1hMNGttajcwWXlMaEtIL0Ri?=
 =?iso-2022-jp?B?NWo3QmZvNFJva1N1T241Uk9iRzF0UW40TFlwUStUeVN4bWVwYVpQcEJs?=
 =?iso-2022-jp?B?RnJ4YUsyejM0RmMxV2gweHpLMnpIN0VDS3kwL1gvTmtnaVA0ZUZ0L0Uz?=
 =?iso-2022-jp?B?UEF5SURYeUpGa3VkUiszNTVqQ2xmWnU2TGRBMUNiNjVZSDB0b3FNMlZK?=
 =?iso-2022-jp?B?aHVWTFZmb242SE5YbTBWWjVoMkxJamRkNE03aEFmZWhSZjlxYmVvUHZo?=
 =?iso-2022-jp?B?aUxUc0RtU2tIYjJJVklNVFBDSzhob1ZISGRoRmtjem1PNjltTmdtdmFq?=
 =?iso-2022-jp?B?ZmxreUJmR1VNd3MwSG9NbEd6d01jd0VWY2EwOVB4TWZvRXA4MjdwZUt1?=
 =?iso-2022-jp?B?elNSUWVlczlGVlRZQThCOXJqK0M5M3lXVjA1VGlUSmZPRWpjRk1tbmJS?=
 =?iso-2022-jp?B?YnNxTjhvZnB2NW9uOTAzUk1mbmxxY2h2ek5EazVlTXBQbDdqZ1NOeElw?=
 =?iso-2022-jp?B?cU5JN04vSEoydUdQbWw2ZG83ZkJLSVVCc0F6U3ZVbVo4V0JPNzdudG1m?=
 =?iso-2022-jp?B?WHhieFhVMU1iKzV0dWwvRTh1MXZVemNYYmVrRGxTZ0Z5bitSdDkyR0R6?=
 =?iso-2022-jp?B?elpJYWlSTE9PSWlMUWVaZzFxTHBzQnZrc0hxb0VSdGpWREM2K2tzaXBD?=
 =?iso-2022-jp?B?bm5QUWRSYllHZjF4TmZrUlQ1TFdLMkE2WkthTElMNENPdnFRSG9NYmR5?=
 =?iso-2022-jp?B?c1VmanNKeDQ2ZDliNGFzODB5SlJCUW9FK0RnUmtMWnJOM2lZYmg1SjZR?=
 =?iso-2022-jp?B?N2tNZ3ZWYkxQZklYUWw2L2wrTVhoT3lqMnR0eGw2b0V5N1Nxcm9YemE4?=
 =?iso-2022-jp?B?d0FqUGNtQlFKYnk2VVRTVWExSS9aWThBMVpUVjFkUE9HNUE4UnRkYlRs?=
 =?iso-2022-jp?B?UGRlMmcvWXM2YVVUNFU3enJCOHFLYXZpNm05KzlyYUw3VzVDVTVTSm5m?=
 =?iso-2022-jp?B?TnFGVUJ5OGo5dEtuVUhDOUI1UExBL2ZVOVNpRFZGQjZJL3RSZzFTM2tP?=
 =?iso-2022-jp?B?ZGtoVnZnVTFWTkRRMXJOTS9ON3dQaGZiUzdyYlNhbC9CTkd6QXhjZUF0?=
 =?iso-2022-jp?B?NHc3T0E1b3JVNy9teWEwbmRqa2FlVWZJcThERWpjV0RtU3d3ellhazhJ?=
 =?iso-2022-jp?B?a291RXNJQ2NHcWVwMUdLeUxCblAyeW5yYXNIUThTOTVISG40R1ZOc01O?=
 =?iso-2022-jp?B?Wnl3cW1Sa3NpZktqTXRhVDFJbHVYOEMrd3JObkFZaTdqU0htcnpwVVFl?=
 =?iso-2022-jp?B?SDRkcmFGcUJwOWpSVUZKT2lOa0RXMzYzOHgxNURjcTZXazlON1FKaFk2?=
 =?iso-2022-jp?B?anYzWnJqYVRzSWE2RnI2dk5veENVY0VlaDdreEZCeldZaUZyU3ZQSXFT?=
 =?iso-2022-jp?B?UlRncDZMNVhGWlIrZkt6SUI5MTRGRXhPc2h3MFNIL3RoMmhKK09FY2Js?=
 =?iso-2022-jp?B?bml0MEE1TVlvalhBOW80aTNWT25Hc2lXeGV5N2ZqcDI2RXlCbTk1MlF4?=
 =?iso-2022-jp?B?cmlrZz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB8798.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(1580799027)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?STI3TmdYYUVyVTQrcVBMZTY2TkxpNG1iN0JPQmFndTkvdEcwaDYrQlJm?=
 =?iso-2022-jp?B?clcxaTFENHEyNHJpMWlXQythTW41UkZqLytWUnhSZ05UVlpzS2hCN1Js?=
 =?iso-2022-jp?B?MVd1WWlsV1dscklyMisvbzR0Umw3U0htM00yU2l1MzBJbmd6Tzdmb3Vh?=
 =?iso-2022-jp?B?RXovTmhiWXRCVDM4KzNMNnNreEpudHBLYytJSUlkMEc3cDBuKzJTa1FH?=
 =?iso-2022-jp?B?OGVvV3ppTldLTzVzKzI0WVl0TCs5bUNRbTdOUHBmK01CU0V6NnRpRUFB?=
 =?iso-2022-jp?B?R1ZPcTMzdjFrTDBoT1pDOGFWNUNJUVJHS3BlZ0lSVVVaVFFQaVY5cE1S?=
 =?iso-2022-jp?B?bkJ3ZkhMTDMrdGpzaWpMbE1ObDdKY3JVc1BpblJHM3hIUEdGc25tbWox?=
 =?iso-2022-jp?B?Ui9DZ05UVUpIUDRBYmtnaFNYL2U2a3lyVDlwVUVPQlBiMU9tSHhuOHpJ?=
 =?iso-2022-jp?B?Q1o4MWR5VDFSM1hSOXhQV3NmUGZuWFRYY1lRY3Vic3Z3dk9SL215Q1JW?=
 =?iso-2022-jp?B?MXpFamt5cFA2R0dmNU83aDVhTTVEb0V2RjMrZE02OXliSnlFYzlnd1pV?=
 =?iso-2022-jp?B?WUx6d3Z0TzlsbVJYaU1xVTNwMjEyOFhFZUN4aGVZUVdIY1hiaFIzQUc1?=
 =?iso-2022-jp?B?T21NK3loYnNpd2NsR29tamlUWHJSMktjd1kwSUtGN1N0SVJ6MnZPYkU3?=
 =?iso-2022-jp?B?NWM2RUNjMG1LcUJwajNOWnJVV1NiL1pnS3piMVFJRS9Vd2tPNjJIR3My?=
 =?iso-2022-jp?B?VDc3Vm9YMkgxSXNWdUpzLzQyQVJBbGhzQWhkbmh6TDFWWStCaEpHUjFV?=
 =?iso-2022-jp?B?dGhpdzlYRVkvdE5sSzZOdXRMUmpkVUlMaDlROElmUlU1WDg4N3d6MmRl?=
 =?iso-2022-jp?B?ZEFtd1VyYVdpQkRmbzlnTkVzTFk0QjBBTWwrUlBGYy8wYnFTSHFNeWdX?=
 =?iso-2022-jp?B?bTg4aFliRWNudXVvZG5zWnd1cnFOaWVUaTN6RzBGazFoMVphdytCVnZz?=
 =?iso-2022-jp?B?TFhmWnRqT3JUQXNmejlRNFVFSnRiY0RGckhVVkVBMERYNEMzWitrUFhO?=
 =?iso-2022-jp?B?UmpVbXV1U0FtNXE1VFFLQUtXVmU2eE1kWmEya1VzeUVUbXJFQWJPb0lt?=
 =?iso-2022-jp?B?eFZPQjhIL0FDM3o2Wkx6QStnbHY0VVg0RHBiaHVsbElYaXFTYVNMWEY1?=
 =?iso-2022-jp?B?THRFakFOUkRnUGdVR3B5a0h1S3BqWGt4WDI1Y1owVWxSNzdYMXdxYmJ0?=
 =?iso-2022-jp?B?VG1pTWxPSHlZclJ4Q1I3YWJXRU9sN1ZKZ0xYTzl5TzdjZFZaY2pVNTM3?=
 =?iso-2022-jp?B?VmE1ZXRwRHRIMHhrOWRJOGZRZ1hnU0txT0NsU3dYQ21GNkhsaGdEMVVT?=
 =?iso-2022-jp?B?SHh1TlZLcEttWGVRKzFERHYxTk51Wis0eTIrZlJzbm01ZzUyTlQ0SDJr?=
 =?iso-2022-jp?B?cGVLWmluQlpYNkxKK2JKRmxORUZIRmVQdy9KNnUwaXMvZ1N0YzVPQldQ?=
 =?iso-2022-jp?B?c1dlYkFLcUg2ZnZadVA4UithNTMvekxtbTFSZXk2bVBQbGxjYXpSRjB3?=
 =?iso-2022-jp?B?dUtLaXZDck1Vei82bWxUS0lMb2huaXlmSDd2NG1hTHVLUUd6UEFTdjh6?=
 =?iso-2022-jp?B?alVvOTVJSG53RUxhaEtPbHRVdEZTekNRTFp2WkR0YThrcmUwTnBPa3FL?=
 =?iso-2022-jp?B?VFNxK0llNE9rMU8wVVY0WDBxbFMwbk45T091WngxQWRIaHlZcHliVmp2?=
 =?iso-2022-jp?B?QjZiRE0zOTYwZ3pTNWdsMEp2dW5NazJjbi9FSkgzZnVYeHVaTGJNQkl4?=
 =?iso-2022-jp?B?NmhVNUozZkxxYUdMN21XLzMwNWRaVnRTbUFraGc5d3YxenhXczJDeFBk?=
 =?iso-2022-jp?B?Y0dHVEh2UU5Uelo0TWlOdXliYUxtWEZNMVRxVVA2b2R3MlpydmFDUVRF?=
 =?iso-2022-jp?B?cG81anNtVSt4Rmk2YmxtNHJyKzhsZW5uRFhzSXkraE1oTEZ5V0xnaFFP?=
 =?iso-2022-jp?B?bkZSVHBjSER0eTloQlNNQW10eGRFQXhBdnIzVG13bXJXVnZBUDRPZUkw?=
 =?iso-2022-jp?B?c0dIZXM0dUc2UHE5N1lWbXNDZG9laWxqMG45bnEvRGx3MVBLcVl5cDI1?=
 =?iso-2022-jp?B?czFXa29iVUlLcURxeHhnbmlBL3ozNG80Rmpwc3VSaUpwVDA2UE1oNmNv?=
 =?iso-2022-jp?B?b29OeThlcWQzeEJNSzRadXBQbjNscUF4Qk1sWUdCSURzYWIzYy8yTys5?=
 =?iso-2022-jp?B?cVBzcm9zVS96bUVkK0hieFUrRml6UmVzQkhrYk1PSFVzdGhnWERMNHRD?=
 =?iso-2022-jp?B?TnhrOHM4VWZBVGhqWTBnU0R5NEV4ZFV4UHc9PQ==?=
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
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB8798.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66f59537-30b5-4368-e496-08de21bc3bac
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2025 07:22:27.0790
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B3KiSfomXHis7eSjk9AgzKgPIOChcxr8uEBK6GGq9md16igrOIC7lZ6DZuCZir7IGIC1dZBEkqIxscb8aE6B8vJrDlsEIO9H6s8zJzj4onA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB16291

Hello Ben,

> From: James Morse <james.morse@arm.com>
>=20
> Probing MPAM is convoluted. MSCs that are integrated with a CPU may only =
be
> accessible from those CPUs, and they may not be online.
> Touching the hardware early is pointless as MPAM can't be used until the
> system-wide common values for num_partid and num_pmg have been
> discovered.
>=20
> Start with driver probe/remove and mapping the MSC.
>=20
> CC: Carl Worth <carl@os.amperecomputing.com>
> Tested-by: Fenghua Yu <fenghuay@nvidia.com>
> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Tested-by: Peter Newman <peternewman@google.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> Signed-off-by: Ben Horgan <ben.horgan@arm.com>
> ---
> Changes since v3:
> From Jonathan:
> Include cleanup
> Use devm_mutex_init()
> Add an ERR_CAST()
> Fenghua:
> Return zero from update_msc_accessibility()
> Additional:
> Fail probe if MSC doesn't have an MMIO interface
> ---
>  arch/arm64/Kconfig              |   1 +
>  drivers/Kconfig                 |   2 +
>  drivers/Makefile                |   1 +
>  drivers/resctrl/Kconfig         |  15 +++
>  drivers/resctrl/Makefile        |   4 +
>  drivers/resctrl/mpam_devices.c  | 194
> ++++++++++++++++++++++++++++++++
> drivers/resctrl/mpam_internal.h |  49 ++++++++
>  7 files changed, 266 insertions(+)
>  create mode 100644 drivers/resctrl/Kconfig  create mode 100644
> drivers/resctrl/Makefile  create mode 100644 drivers/resctrl/mpam_devices=
.c
> create mode 100644 drivers/resctrl/mpam_internal.h
>=20
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig index
> c5e66d5d72cd..004d58cfbff8 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -2025,6 +2025,7 @@ config ARM64_TLB_RANGE
>=20
>  config ARM64_MPAM
>  	bool "Enable support for MPAM"
> +	select ARM64_MPAM_DRIVER if EXPERT	# does nothing yet
>  	select ACPI_MPAM if ACPI
>  	help
>  	  Memory System Resource Partitioning and Monitoring (MPAM) is an
> diff --git a/drivers/Kconfig b/drivers/Kconfig index
> 4915a63866b0..3054b50a2f4c 100644
> --- a/drivers/Kconfig
> +++ b/drivers/Kconfig
> @@ -251,4 +251,6 @@ source "drivers/hte/Kconfig"
>=20
>  source "drivers/cdx/Kconfig"
>=20
> +source "drivers/resctrl/Kconfig"
> +
>  endmenu
> diff --git a/drivers/Makefile b/drivers/Makefile index
> 8e1ffa4358d5..20eb17596b89 100644
> --- a/drivers/Makefile
> +++ b/drivers/Makefile
> @@ -194,6 +194,7 @@ obj-$(CONFIG_HTE)		+=3D hte/
>  obj-$(CONFIG_DRM_ACCEL)		+=3D accel/
>  obj-$(CONFIG_CDX_BUS)		+=3D cdx/
>  obj-$(CONFIG_DPLL)		+=3D dpll/
> +obj-y				+=3D resctrl/
>=20
>  obj-$(CONFIG_DIBS)		+=3D dibs/
>  obj-$(CONFIG_S390)		+=3D s390/
> diff --git a/drivers/resctrl/Kconfig b/drivers/resctrl/Kconfig new file m=
ode
> 100644 index 000000000000..ef2f3adf64a9
> --- /dev/null
> +++ b/drivers/resctrl/Kconfig
> @@ -0,0 +1,15 @@
> +menuconfig ARM64_MPAM_DRIVER
> +	bool "MPAM driver"
> +	depends on ARM64 && ARM64_MPAM && EXPERT
> +	help
> +	  Memory System Resource Partitioning and Monitoring (MPAM)
> driver for
> +	  System IP, e,g. caches and memory controllers.
> +
> +if ARM64_MPAM_DRIVER
> +
> +config ARM64_MPAM_DRIVER_DEBUG
> +	bool "Enable debug messages from the MPAM driver"
> +	help
> +	  Say yes here to enable debug messages from the MPAM driver.
> +
> +endif
> diff --git a/drivers/resctrl/Makefile b/drivers/resctrl/Makefile new file=
 mode
> 100644 index 000000000000..898199dcf80d
> --- /dev/null
> +++ b/drivers/resctrl/Makefile
> @@ -0,0 +1,4 @@
> +obj-$(CONFIG_ARM64_MPAM_DRIVER)			+=3D mpam.o
> +mpam-y						+=3D
> mpam_devices.o
> +
> +ccflags-$(CONFIG_ARM64_MPAM_DRIVER_DEBUG)	+=3D -DDEBUG
> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_device=
s.c
> new file mode 100644 index 000000000000..6c6be133d73a
> --- /dev/null
> +++ b/drivers/resctrl/mpam_devices.c
> @@ -0,0 +1,194 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (C) 2025 Arm Ltd.
> +
> +#define pr_fmt(fmt) "%s:%s: " fmt, KBUILD_MODNAME, __func__
> +
> +#include <linux/acpi.h>
> +#include <linux/arm_mpam.h>
> +#include <linux/cacheinfo.h>
> +#include <linux/cpumask.h>
> +#include <linux/device.h>
> +#include <linux/errno.h>
> +#include <linux/gfp.h>
> +#include <linux/list.h>
> +#include <linux/lockdep.h>
> +#include <linux/mutex.h>
> +#include <linux/platform_device.h>
> +#include <linux/printk.h>
> +#include <linux/srcu.h>
> +#include <linux/types.h>
> +
> +#include "mpam_internal.h"
> +
> +/*
> + * mpam_list_lock protects the SRCU lists when writing. Once the
> + * mpam_enabled key is enabled these lists are read-only,
> + * unless the error interrupt disables the driver.
> + */
> +static DEFINE_MUTEX(mpam_list_lock);
> +static LIST_HEAD(mpam_all_msc);
> +
> +struct srcu_struct mpam_srcu;
> +
> +/*
> + * Number of MSCs that have been probed. Once all MSC have been probed
> +MPAM
> + * can be enabled.
> + */
> +static atomic_t mpam_num_msc;
> +
> +/*
> + * An MSC can control traffic from a set of CPUs, but may only be
> +accessible
> + * from a (hopefully wider) set of CPUs. The common reason for this is
> +power
> + * management. If all the CPUs in a cluster are in PSCI:CPU_SUSPEND,
> +the
> + * corresponding cache may also be powered off. By making accesses from
> + * one of those CPUs, we ensure this isn't the case.
> + */
> +static int update_msc_accessibility(struct mpam_msc *msc) {
> +	u32 affinity_id;
> +	int err;
> +
> +	err =3D device_property_read_u32(&msc->pdev->dev, "cpu_affinity",
> +				       &affinity_id);
> +	if (err)
> +		cpumask_copy(&msc->accessibility, cpu_possible_mask);
> +	else
> +		acpi_pptt_get_cpus_from_container(affinity_id,
> +						  &msc->accessibility);
> +	return 0;
> +}
> +
> +static int fw_num_msc;
> +
> +static void mpam_msc_destroy(struct mpam_msc *msc) {
> +	struct platform_device *pdev =3D msc->pdev;
> +
> +	lockdep_assert_held(&mpam_list_lock);
> +
> +	list_del_rcu(&msc->all_msc_list);
> +	platform_set_drvdata(pdev, NULL);
> +}
> +
> +static void mpam_msc_drv_remove(struct platform_device *pdev) {
> +	struct mpam_msc *msc =3D platform_get_drvdata(pdev);
> +
> +	if (!msc)
> +		return;
> +
> +	mutex_lock(&mpam_list_lock);
> +	mpam_msc_destroy(msc);
> +	mutex_unlock(&mpam_list_lock);
> +
> +	synchronize_srcu(&mpam_srcu);
> +}
> +
> +static struct mpam_msc *do_mpam_msc_drv_probe(struct platform_device
> +*pdev) {
> +	int err;
> +	u32 tmp;
> +	struct mpam_msc *msc;
> +	struct resource *msc_res;
> +	struct device *dev =3D &pdev->dev;
> +
> +	lockdep_assert_held(&mpam_list_lock);
> +
> +	msc =3D devm_kzalloc(&pdev->dev, sizeof(*msc), GFP_KERNEL);
> +	if (!msc)
> +		return ERR_PTR(-ENOMEM);
> +
> +	err =3D devm_mutex_init(dev, &msc->probe_lock);
> +	if (err)
> +		return ERR_PTR(err);
> +	err =3D devm_mutex_init(dev, &msc->part_sel_lock);
> +	if (err)
> +		return ERR_PTR(err);
> +	msc->id =3D pdev->id;
> +	msc->pdev =3D pdev;
> +	INIT_LIST_HEAD_RCU(&msc->all_msc_list);
> +	INIT_LIST_HEAD_RCU(&msc->ris);
> +
> +	err =3D update_msc_accessibility(msc);
> +	if (err)
> +		return ERR_PTR(err);

Since the return value of update_msc_accessibility(msc) is always 0,
this check is unnecessary.=20

Best regards,
Shaopeng TAN

> +	if (cpumask_empty(&msc->accessibility)) {
> +		dev_err_once(dev, "MSC is not accessible from any CPU!");
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	if (device_property_read_u32(&pdev->dev, "pcc-channel", &tmp))
> +		msc->iface =3D MPAM_IFACE_MMIO;
> +	else
> +		msc->iface =3D MPAM_IFACE_PCC;
> +
> +	if (msc->iface =3D=3D MPAM_IFACE_MMIO) {
> +		void __iomem *io;
> +
> +		io =3D devm_platform_get_and_ioremap_resource(pdev, 0,
> +							    &msc_res);
> +		if (IS_ERR(io)) {
> +			dev_err_once(dev, "Failed to map MSC base
> address\n");
> +			return ERR_CAST(io);
> +		}
> +		msc->mapped_hwpage_sz =3D msc_res->end -
> msc_res->start;
> +		msc->mapped_hwpage =3D io;
> +	} else {
> +		return ERR_PTR(-ENOENT);
> +	}
> +
> +	list_add_rcu(&msc->all_msc_list, &mpam_all_msc);
> +	platform_set_drvdata(pdev, msc);
> +
> +	return msc;
> +}
> +
> +static int mpam_msc_drv_probe(struct platform_device *pdev) {
> +	int err;
> +	struct mpam_msc *msc =3D NULL;
> +	void *plat_data =3D pdev->dev.platform_data;
> +
> +	mutex_lock(&mpam_list_lock);
> +	msc =3D do_mpam_msc_drv_probe(pdev);
> +	mutex_unlock(&mpam_list_lock);
> +	if (!IS_ERR(msc)) {
> +		/* Create RIS entries described by firmware */
> +		err =3D acpi_mpam_parse_resources(msc, plat_data);
> +		if (err)
> +			mpam_msc_drv_remove(pdev);
> +	} else {
> +		err =3D PTR_ERR(msc);
> +	}
> +
> +	if (!err && atomic_add_return(1, &mpam_num_msc) =3D=3D
> fw_num_msc)
> +		pr_info("Discovered all MSC\n");
> +
> +	return err;
> +}
> +
> +static struct platform_driver mpam_msc_driver =3D {
> +	.driver =3D {
> +		.name =3D "mpam_msc",
> +	},
> +	.probe =3D mpam_msc_drv_probe,
> +	.remove =3D mpam_msc_drv_remove,
> +};
> +
> +static int __init mpam_msc_driver_init(void) {
> +	if (!system_supports_mpam())
> +		return -EOPNOTSUPP;
> +
> +	init_srcu_struct(&mpam_srcu);
> +
> +	fw_num_msc =3D acpi_mpam_count_msc();
> +
> +	if (fw_num_msc <=3D 0) {
> +		pr_err("No MSC devices found in firmware\n");
> +		return -EINVAL;
> +	}
> +
> +	return platform_driver_register(&mpam_msc_driver);
> +}
> +subsys_initcall(mpam_msc_driver_init);
> diff --git a/drivers/resctrl/mpam_internal.h
> b/drivers/resctrl/mpam_internal.h new file mode 100644 index
> 000000000000..540066903eca
> --- /dev/null
> +++ b/drivers/resctrl/mpam_internal.h
> @@ -0,0 +1,49 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +// Copyright (C) 2025 Arm Ltd.
> +
> +#ifndef MPAM_INTERNAL_H
> +#define MPAM_INTERNAL_H
> +
> +#include <linux/arm_mpam.h>
> +#include <linux/cpumask.h>
> +#include <linux/io.h>
> +#include <linux/mutex.h>
> +#include <linux/types.h>
> +
> +struct platform_device;
> +
> +struct mpam_msc {
> +	/* member of mpam_all_msc */
> +	struct list_head	all_msc_list;
> +
> +	int			id;
> +	struct platform_device	*pdev;
> +
> +	/* Not modified after mpam_is_enabled() becomes true */
> +	enum mpam_msc_iface	iface;
> +	u32			nrdy_usec;
> +	cpumask_t		accessibility;
> +
> +	/*
> +	 * probe_lock is only taken during discovery. After discovery these
> +	 * properties become read-only and the lists are protected by SRCU.
> +	 */
> +	struct mutex		probe_lock;
> +	unsigned long		ris_idxs;
> +	u32			ris_max;
> +
> +	/* mpam_msc_ris of this component */
> +	struct list_head	ris;
> +
> +	/*
> +	 * part_sel_lock protects access to the MSC hardware registers that
> are
> +	 * affected by MPAMCFG_PART_SEL. (including the ID registers that
> vary
> +	 * by RIS).
> +	 * If needed, take msc->probe_lock first.
> +	 */
> +	struct mutex		part_sel_lock;
> +
> +	void __iomem		*mapped_hwpage;
> +	size_t			mapped_hwpage_sz;
> +};
> +#endif /* MPAM_INTERNAL_H */
> --
> 2.43.0


