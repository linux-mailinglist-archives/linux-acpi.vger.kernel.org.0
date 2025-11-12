Return-Path: <linux-acpi+bounces-18798-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C5F18C5115B
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Nov 2025 09:22:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E08764F60CB
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Nov 2025 08:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F6862BEFEB;
	Wed, 12 Nov 2025 08:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="Qj4FAeba"
X-Original-To: linux-acpi@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011052.outbound.protection.outlook.com [40.107.74.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2715A186294;
	Wed, 12 Nov 2025 08:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762935453; cv=fail; b=T4RLM3eBVSeKrBnSekt84Abuc4EOosxet5V5W+YJRaES0/k8Zjb7dkP3/xc62/cM2zeAkyNFjmo3NXGytn6j4A7rWDJyT2KvmtmvH1qa7NDd/E1XtrWwPhd9vtwUR3MwBMuZ0gq13ErnZEq5o3ZI7xarStO+2Gq4Iw7v9LVdoHg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762935453; c=relaxed/simple;
	bh=XwHKT9RuhU9gwQp1S/NjkPluc+vkdi3A0OZHk/g55EY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DVhKgQOs/ld6zVgDXSIfUOvpPAqF94sn9mV/YCOHClJ7ygPX/1utp5M5kfxr0TDyUdzGB+8dOpI3nr0EjN08/6afHBC8AwWmThiGUwkDZK/PHIDvSnw0VLx0y2zfDH4IJ6tzgdGKLtexaSVlsrMkZdXqZTrFRd2I24gylQvo1OQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=Qj4FAeba; arc=fail smtp.client-ip=40.107.74.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lpbc0agodlp9f9XWmxOysNxadk+Y9/ZRm4wp+lbmYKSp3F+CCqfLbgu5bnmaaMXWd9FKhcZYwwq/KawcCG9CFiaZrDC8thOqLFNBzp2lnG8GTOVpPGB7E9SsFZKAxcfzoRnEVfaECsWVumgngU0pHGUQmfmuou402QoBD94e9Z4EWot3Rzmnc5LdG7gg+MJKqNG6BeZllrWnjrXrAXjKCAD97YIhqpLcfUa/YDCZBuhkYfjL+MYqdcuLFMNriTLaC27dkkXzsnaMoBBm+GmUvQLY9oVy72u0JYFZA3Rck+Ydgx0oIKJbpSEzqMSN2lSkI08crvDhCDATKM0pH3zV0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XwHKT9RuhU9gwQp1S/NjkPluc+vkdi3A0OZHk/g55EY=;
 b=Gi+sqEA7bEB7f2Wuuu9FH19DxPuOI3y2eZtI3JuDrXnrWPF9JQbzTZl5pcwg8rDT3JDiMB2/qBEGWHzFZ4sl+HCkT9Q133m72BmQjON4JU8J7aN1VGFzMyR9/pRD8T/R9rYRpcGT0Y0G7KmHX5ZIbpTux5PVoNhwWkC6LZwB+toBnCd/58zEFu2wvCkvntWC0xvbXukBOa2DW/YtuMbFUeD5IjJbXoHPo0lyoBf+bP4dSMmXyfTOqNDDQBQg5Td3Srp1KBfS/HU75LFaO35y+qo7I2kJoCZvDQcvyXVwRS07QsQNMV1U13oBK/IQjC8bFwBD+5taJZGJ+PDdHUYgIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XwHKT9RuhU9gwQp1S/NjkPluc+vkdi3A0OZHk/g55EY=;
 b=Qj4FAebad7Ue1gMexcRSFeH3dgjJF6+fE41PrO6RY3PlqIwhjCE4MxW29Dqm1fy31JndqEwANwzFL8XlB9VQxvUvhi3cTfkR73ZxRVEAeY86D7s+wXjjkCatVM30dqc07pZTpVV0lLH30rXXAnMvmrKby24r1bw+d/2eZCokrOysJKbHhXG71dB0Gu3agT3w2L6TDVyMsKy72rcq3xqBAR9SF5Y5ylM7XgnfvtET0y3rARlwbkfstHyFNoBAI9XeQXqVcRqSz7Py4YqF6GjdFy/vMAlCeyZPhknrYU10QNY2hR5UHEEeFxNxOSSSAWpxPW98+k8xYGvvrPbT1Zadyg==
Received: from OSZPR01MB8798.jpnprd01.prod.outlook.com (2603:1096:604:15f::6)
 by TYYPR01MB15134.jpnprd01.prod.outlook.com (2603:1096:405:1a3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Wed, 12 Nov
 2025 08:17:28 +0000
Received: from OSZPR01MB8798.jpnprd01.prod.outlook.com
 ([fe80::e366:d390:4474:8cfa]) by OSZPR01MB8798.jpnprd01.prod.outlook.com
 ([fe80::e366:d390:4474:8cfa%6]) with mapi id 15.20.9320.013; Wed, 12 Nov 2025
 08:17:27 +0000
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
	<xhao@linux.alibaba.com>, Dave Martin <Dave.Martin@arm.com>
Subject: RE: [PATCH 16/33] arm_mpam: Probe the hardware features resctrl
 supports
Thread-Topic: [PATCH 16/33] arm_mpam: Probe the hardware features resctrl
 supports
Thread-Index: AQHcT+M0gRCHbjUqWU6I/WrXktg/6LTuuZEg
Date: Wed, 12 Nov 2025 08:17:27 +0000
Message-ID:
 <OSZPR01MB8798C1FB9EA4C2155C88FFC88BCCA@OSZPR01MB8798.jpnprd01.prod.outlook.com>
References: <20251107123450.664001-1-ben.horgan@arm.com>
 <20251107123450.664001-17-ben.horgan@arm.com>
In-Reply-To: <20251107123450.664001-17-ben.horgan@arm.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ActionId=de353708-718b-47b6-be4b-d52b9bef2da8;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=true;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED?;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2025-11-12T08:16:40Z;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB8798:EE_|TYYPR01MB15134:EE_
x-ms-office365-filtering-correlation-id: 5ab86ac2-361a-495c-b222-08de21c3eb0b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|1580799027|38070700021;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?Z1ZnRHZ2TStVcXUvRHowQ3lGVldTVExXbW51bERDbzNSeGlxWjZPN0Fr?=
 =?iso-2022-jp?B?OEpzMFhsL1FzSm1lUXVXOS84d3J2Nyt5TnhIcFVPSFhRMUVNWURuS1RU?=
 =?iso-2022-jp?B?TW9aNGFkNk5ocWt3SUtlSXNqYUZOY2VDeTNsOGZPbm1sdDFoNk0vWUo5?=
 =?iso-2022-jp?B?MUo4dWx6K0x4SDkwdGR6eDZHQnFXWjcrd1Y2UXZ6cjUxVWsvMmErNG1t?=
 =?iso-2022-jp?B?S2JCblhNTGNJWVJqUUQ0bEtMWnNvWjBYYlhmTEZ3WkN3VTl6YkovUHc2?=
 =?iso-2022-jp?B?RGdJaWxtZnVMTzBwamg4TEdld3VKRGVGVG5md25wQ1hOQ1Q5RnJnYWRj?=
 =?iso-2022-jp?B?WDFmUXFzWmRjZGFJcWN0ckJwQWE2aWozaElVc0hja25SNHpqb09haWJ3?=
 =?iso-2022-jp?B?ZytOZnNKeE5sQy9tY0pMVkpxb0FzVkRnVFMxektJYy9wbmdnMmRtSUxK?=
 =?iso-2022-jp?B?a3pnd3NaTnJFeFJwUkpvNjlJcFJwcEtTdWlZL28wSFdqOHFpYXFQSnkw?=
 =?iso-2022-jp?B?bDVXVjM5RWhlVmszbnFLMkptSDdhdW5FNnVCNVk4MFdDQnhqcEYzYmxo?=
 =?iso-2022-jp?B?QnNLcjMxWDRlczlmb05aKzNjUEJ4ajlkZFBDZ0RXajRSOGZnSko2SUdY?=
 =?iso-2022-jp?B?dU1QSmVZekxqdFY1cG8weU93VWVOL0g2YmRTYUxLS1ZUMEFPMXM4QnA4?=
 =?iso-2022-jp?B?RTU5VUlrNmJGeTB2MHJBMmpWd2pMOGRZK3VDMmdrN1VEVmNhbEU4QzZX?=
 =?iso-2022-jp?B?Y3pYMzZzd2ttcVJEVFFGNUJzZUFXM2RiZndxWmQ4TEYrdy9JVjQ5ZkZ1?=
 =?iso-2022-jp?B?bWx2dmdRUnBiNVlwbUJvY0hRdXBEVGdKdlljK3FqWGZ5aTI0S2JOSkdy?=
 =?iso-2022-jp?B?bEZjbnpQa0FQY015bmZoUWh4VDhvYmtDNXU2S2x0cWhUY3BsY0l2VUkv?=
 =?iso-2022-jp?B?L2xrSXd3UlplSlNmT1pCdVIzOXR3K0xyQ3RRQnpmMTFFNnlrVXdjNnBJ?=
 =?iso-2022-jp?B?NVdwZE1CQWM0S2pMblJKenRBbFQvc2EvaWRxcDJVa0tDRkU4c0VjeWpa?=
 =?iso-2022-jp?B?RTR6Vm1neGxyMmUya3VaMVhYTGRTNHZ4VUdFdkIvUENGc3BnV0xreGhV?=
 =?iso-2022-jp?B?bTE2ZDJBMnErYUFBL3M4bU9BYVZQZ05rZnN3ZUxDc3RBUU9hMERaV3dJ?=
 =?iso-2022-jp?B?S3U0bkhzUGRYbnM3V01MZXJnT0F5bi90SGZJU3NMRFdDQXlacFFPTlFH?=
 =?iso-2022-jp?B?UXN4NWRHMCtKeFZ5elFoQkcyWkx6cUt4NFgvWXM2amJiME9Bblo0VFF2?=
 =?iso-2022-jp?B?NE5iVzU0SmdIcWxOc3kySE1sZ1dKUTRiNWlYYWEyTG04T1doa2RMbmlT?=
 =?iso-2022-jp?B?T2tJeVRxV1dCaFJKeDAyR2J6c1pmT1VuZmo4bmliZmF4dk9xT0lTdEVC?=
 =?iso-2022-jp?B?TG5mWjVNVTJzZ2ZTR1N1OXQ0eiszeUJJNTZmbmxmeG01V2FGeEs4K3po?=
 =?iso-2022-jp?B?K0xDd2l4dWZucWM4cGtmUHBaSkxCcDJXa2dScy9KYy9Qc3dBRTNOcjRv?=
 =?iso-2022-jp?B?eE9FMFlsVWZyV2NJa3RhTmJnZk5KcWNPSkVQWVMwZDA2T1ZqUFp4dU5H?=
 =?iso-2022-jp?B?dDBaS2tML2RGbGovb3hBQUswRjRlTVg5MXdRNGFjL0ZzUHZoaHBEVEJD?=
 =?iso-2022-jp?B?MUJDa21Ec1Jzc00vYkRxN1h1bm8vKy9LZkRXcnV0cUlVU1JhbEk2OUxP?=
 =?iso-2022-jp?B?b0dCUTI4clRuM0ZLM1NSOVFEeG1rQzI3UklJU3JsVC9DM2paMWlaa1Jn?=
 =?iso-2022-jp?B?QmdPcHBYNWZUUVdVbjU3d1VHd0kwbXVsQVQzNm0zZjNyYjIvT0U5WHZL?=
 =?iso-2022-jp?B?YklvZHNhZGpLRXdiaGk4RFNHWU1oRlRLTG40Y1ZrVDJ2enBTUW9GWWVP?=
 =?iso-2022-jp?B?b1NSYjVxd3Bja0cxVzlzMTNpd1R1SXgrbDFwMzVRNkc5eHNUTVdtTjhZ?=
 =?iso-2022-jp?B?Z0VaL0lRTDAyQXpwcmxTR3JwMlNlMVBiQXJuVTlCTy9RS1pNNkZWOXJx?=
 =?iso-2022-jp?B?TklJRU1hUnlkd3g4blRWUjJiNXY3WVA1SzRZdGlZRHhpb29wbEwyL0oz?=
 =?iso-2022-jp?B?cWs1L2d6QURzKzBvbUQrQ0kyWHBmOU12ZWxrM1M2ZEZLaHd0bFVENXEz?=
 =?iso-2022-jp?B?QkhZQWdrYzB5dERBQVFmTFZoN2VRaWkvRlZQNXhMbjlnZk1KeE9Ib00x?=
 =?iso-2022-jp?B?WWNmQT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB8798.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(1580799027)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?SXVFTE9DTEltT3hFWjQ0SXJCYXZmTGhISlhkeGNKOWtzL05TS3R5Rzc2?=
 =?iso-2022-jp?B?WFRPSkQ0YWJ5M0xpZW5MaTRxWmNHZytEaDlmQyt3Vlh0ZkVBMnBjSkRH?=
 =?iso-2022-jp?B?Y1JPNVV2L2RmV2p5Qmthc3ByWStPTEsxVmdVdWFNWW1tTHNTMUtWL01l?=
 =?iso-2022-jp?B?QVduelBtWkhabWk2a3dTbmgwME8wM2oranRZUjZXRVh0QXFjcm5jOGxG?=
 =?iso-2022-jp?B?c2dBK1Rpc2QzWGNtYmtHdXZOZnFwS0UwdzMzVnV5U0VyVHhDeW5idEQ5?=
 =?iso-2022-jp?B?TktWREhKVmwrNEMrRCtUNU10YkVRN2d6M2x2Q2hiUUNsQjB6MFE0OUFY?=
 =?iso-2022-jp?B?OGM4U0FKeFUvUEV1ZjYwNUdiV2g2djh0aGZOdTdRTkpOeTh4YlI1azkr?=
 =?iso-2022-jp?B?eWdqSnhFWnNTNDVHNHBHZW4rZlRqL2dhY0wybTF2Q2xPdWZ4czdtSUlx?=
 =?iso-2022-jp?B?UWJ3eTY4OXlKcHpwcjBrSXAwMGN6L1FOTFp1WlpEa2R0UWx3KzZEOUtP?=
 =?iso-2022-jp?B?QUFkVmV4QWM0WGZjMlB1L2lZdUc5OGJjcWZkWEg3TUNhWTQxYVR5VFlm?=
 =?iso-2022-jp?B?TnBUL1lxNFBjT1hrWjJpb1Q2M3NkclI1MHZ0SXQvNWNad1J3YVE4bWxS?=
 =?iso-2022-jp?B?bXdBRzZpK28zRDNvYUp6cnQ0WCtBRnZZZXYwSkNlOGJVQ0pwQjdKSS9E?=
 =?iso-2022-jp?B?ZWdLWnZGL0tjdHRxdlE4V2lWYW9hTHovWEI4MG5hVndLaVhOd2tnSzk0?=
 =?iso-2022-jp?B?amV1N3A2YWlldlptRW5xSkJORlcrSFB2a3N4Mjg3ZXRJTzBjS3ZwV1Qv?=
 =?iso-2022-jp?B?K0tJOVRLYjRDYzU1RUV6b29aeGZNS3dneXgxdEhDQXZjZWllelN4cVFM?=
 =?iso-2022-jp?B?NFc1WEorOFkzKzkwalRSS1pVL1paVmZxazMyeHhidEgrbU9oM3UxZ3J0?=
 =?iso-2022-jp?B?aUpiU1picXNudGRESzl3OTVGQ1J0a2VQY1YyQnVpMHhVQ3duQVFtTWpL?=
 =?iso-2022-jp?B?MWRzdzlMbytWdFFpOTFJVzh3T2JKK3FyWDNaNC9QdjZZTzB1Zk9SNTMx?=
 =?iso-2022-jp?B?VTlYMFZITHdxTDVudldVTW4yMU9LaUdMVHgycGlWVDFzdjVrMmZWZmRE?=
 =?iso-2022-jp?B?b3NWNnFUcU5tdnRUZ3dJU3NQRVVBUlc0VUZEWGRBOWs2WERRL21RZzQw?=
 =?iso-2022-jp?B?MWZNN1ptRWJYNnFxbmJoYitTcnBsUnVWbkZjZTljTkc5WGVYRVo5VTNL?=
 =?iso-2022-jp?B?dDRTNHJYZGhEWlZvNm5hK1RPaC9na0lOWTY4Zzg4VFBkY3I5K1NHUnc3?=
 =?iso-2022-jp?B?MS9HSFN5YXAzWnVtL3l6Y0kzdE8yd25vM3VaeUEvckRHQThBMFpheXdz?=
 =?iso-2022-jp?B?S1hKUEJnMFBkRGNSU3B4Q3dTeVlNQzZtRXJFZk4wejE1b0hKczhUWXR4?=
 =?iso-2022-jp?B?cXRNbk9pV1hSZ3ZYTHBzTHVxa1QvaUhtUlFSc1FWQVJpQWx3bWtkNWo2?=
 =?iso-2022-jp?B?SXg0aXNjODBLTUFiVXF4akc2MFE2RVJrdjZoSkZneEpRSHZUMzA5Z3RZ?=
 =?iso-2022-jp?B?RzloQ2pZRWtDcmNuMXF2SDUyODUrSXF6Z2pQRmxYU1RHcWUySUc1Z2xH?=
 =?iso-2022-jp?B?OHBtd252anhLekEvKzJNYVdXdlNNUUNud3lvNXY2cVQ2cVJHbWRHN20x?=
 =?iso-2022-jp?B?aSt2QjFXUXJmV1ZjVU8waUhtTUZJMzNhdTdTZWZ2V2RIM2lLL3Y2N1FX?=
 =?iso-2022-jp?B?QXZmWjBaenZlcUJYQWJhdkVzdytQNkJ5a2VtbkJLOGpza2g2RWlQUm9J?=
 =?iso-2022-jp?B?VkIwVCt1RjE1QXdIMVJEeVNVSmUxaHVpZ3dweGc1NERRMUFRUXFuNlNL?=
 =?iso-2022-jp?B?M0RRazVEZVROWmZ6L21PdFZ3VVZiSC9vaWdWaUxTTHIySnRKaExjM25O?=
 =?iso-2022-jp?B?cmhpZ2FwVkg5K3YvQmc3bXltYmhkRUhzN3l4YXpwanFna1BwZGdRYkYr?=
 =?iso-2022-jp?B?Q3VLZnk5clArQUtNTTJmNGxoNXhQVEVOZGwxVmkzZTlzY2dWdXVRVVdC?=
 =?iso-2022-jp?B?VzF0bGx0N2ttd0pBUDMvRGcvOXJkZi94ZkJYLzlqKzNNTlZNZVlMVmJV?=
 =?iso-2022-jp?B?N2R6VlJIZ08vUmEwMzIzenBnVGp3Q2pkUExYNW9rLzZnRmhFWnFWbC9i?=
 =?iso-2022-jp?B?MiszZHVkWnRWa3phcytkRXNUUUNYZ0Z2Szk3ejA4TmpTWVllaDFpWWpR?=
 =?iso-2022-jp?B?ZEkzc3dnU2gzL01velU0N3QyVWNCZlFwSlFVKzl0eHFGM0Y2WGxqaFlX?=
 =?iso-2022-jp?B?YS9EOFl6bSt1ZVhpeExZcGdFVUNmRTczQnc9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ab86ac2-361a-495c-b222-08de21c3eb0b
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2025 08:17:27.8564
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: irM0hum0u+h5XvaRqD7x/VY6j1zYDAuT8X/quO0VYnuv2w1Cx1nOozmCwnTpJu8kJkE6BCr8NfpbYzfjykZqes+IgjbZoI6NRVWIxKL1BiE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB15134


> From: James Morse <james.morse@arm.com>
>=20
> Expand the probing support with the control and monitor types we can use =
with
> resctrl.
>=20
> CC: Dave Martin <Dave.Martin@arm.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>
> Tested-by: Fenghua Yu <fenghuay@nvidia.com>
> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Tested-by: Peter Newman <peternewman@google.com>
> Signed-off-by: Ben Horgan <ben.horgan@arm.com>

Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>

