Return-Path: <linux-acpi+bounces-19355-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01D5DC9267F
	for <lists+linux-acpi@lfdr.de>; Fri, 28 Nov 2025 16:07:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 225313A44A8
	for <lists+linux-acpi@lfdr.de>; Fri, 28 Nov 2025 15:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAEAD329E48;
	Fri, 28 Nov 2025 15:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="SQ4SBYu1";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="SQ4SBYu1"
X-Original-To: linux-acpi@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013023.outbound.protection.outlook.com [52.101.83.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4274832C94E;
	Fri, 28 Nov 2025 15:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.23
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764342406; cv=fail; b=cjf4QBxWcmFXSjoVV31QzmGaMkOrQbLFJpaUz/qhjnk+B1cWEAlls49qFwT9CruIHJpM9z66dhEsLRxjAMAey2c3yJij9WKzHSIJeFpvxkmkQ05qFDCevA9ivMH6lfOU/yqO4Caq8YsXMdqXD2husGCk55fxwzBlINGu3S7720E=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764342406; c=relaxed/simple;
	bh=tdvuV9WwZKWTCn/GJhQ+jJYUmCCaXacwIvmpXjRBacY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pBdCrsj37JbXDFiBcgWSVMWX/QOziv1xDVXW7n8jbohMlePZF6xUu4B+g8r3VdxmZsJBEKwNLDFjvvlVqgPl6jPhGgK/hPV1DN1MQgfdWICWAUcdFx9DeI5ggMyxZD6fN/tAl+vE4UzzgRwxprcq7aSTqVkmdtF90qWTt6wWH6w=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=SQ4SBYu1; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=SQ4SBYu1; arc=fail smtp.client-ip=52.101.83.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=qJJmCe7jNzvtWQiKIGXmn6alj2004KgYB+/NuWB3JL7PWVWphOCuaonLBfkajqSahixoMkarclJ3Eul9OcUrhU+5INY0cOFdTJ2brjpEDx7tn7dCmY1p1tScy//n4Jz+1MAPnac5jq/bjdC+CjOFYSYWJofU4qJcENSqlY3Xm0AEOM+M1dTsu/VMpmDtqMJnlOIvNpGbzD9Wlc/go4uObhBgzR8/SKEY9WGUMMz3ExpDXgVksHnr53KPnqjZTOhkb0AcIKNXeNuxD779En7UHHjSY8A9tMQRIfyhMVHJbuv3mVDN6MXqECDiSA/0mEdQBl3wpWU7OOZ47CtmW2o0xw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gRLpf4Luxs5Pb0AWkUpZAxOqfkSza2ES0ifnCEpXJTE=;
 b=mMoY+EKhpX87U//+R1DC9A2lnG1qiz4ZBYeKjNRTepl1qgbvw0umFh6JI7rU5J2heWW4orp0aGAapdaP/nYqOYkvSUU4Tveoj1xvEDNg7CHVBGb5a98f+rBoEDi+OcnNRFTsdPS+DVNbu8MSEjMTUkYz7ur4dGHIcaehXIMRacbpo8rJcncUbik4M3dtOxs1pfy7v06ZiKTPNQ0SCDu8Ie55LY2ARxoxj2UVriRXnlivIJXhNf/vC2UmeGHxMzlvdSPEAo2M5o2MRaVsx8VgxMtPX8Vr1ERjOgU0q7HlDwm9/jUxq3+K2Ugm1o2fZShdybUo19yHV8qVhogRbFcgUw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=nvidia.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gRLpf4Luxs5Pb0AWkUpZAxOqfkSza2ES0ifnCEpXJTE=;
 b=SQ4SBYu143Nrc3Mpmz2natqoSxuSNSb/YwLe0vYXA3y9nkn3cT0SV5HRSL2PYnpjj4FMyIwuytw5PeOAHt5/BPY18EnN4Bpgf4/kJJyMStdPQC0qUGCAKfjCA27Gf8lJvRc0ritejpy6YxEzFaG/v8sf5MEMaJlCyP4SAWz4BBQ=
Received: from AM0PR02CA0136.eurprd02.prod.outlook.com (2603:10a6:20b:28c::33)
 by MRWPR08MB11236.eurprd08.prod.outlook.com (2603:10a6:501:74::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Fri, 28 Nov
 2025 15:06:39 +0000
Received: from AMS0EPF0000019A.eurprd05.prod.outlook.com
 (2603:10a6:20b:28c:cafe::3a) by AM0PR02CA0136.outlook.office365.com
 (2603:10a6:20b:28c::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.12 via Frontend Transport; Fri,
 28 Nov 2025 15:06:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS0EPF0000019A.mail.protection.outlook.com (10.167.16.246) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.7
 via Frontend Transport; Fri, 28 Nov 2025 15:06:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wMA+QM13RN4AChKpvrb9bH0+RNY/AoLolLmkDmJHzFSgbxXOEnrBSl8xzHUC9Z5uqoAM7Hlv07owQmea3Q2PU/1+mU4JmsoEsd2gsGz5EcGkuttdzen5ANc8oTueczaQTu682evCDT0NjZjElbu4sNbTroYIRoJK8SRneGVCTd01cJ08Ck5i9mg1E/bupKxwek75fAkNNPYZMVfX+1fWwhsdGkEVROWCjatsQ91adiQWS6lwYsKyUOKTCKp/apxNUZi5XwxWz2vbjfFA4KM4wVfraWRWlKpAK5D/SwTGLvmYit+aIKkap2fSiTZlhwy//KmE64Iyj+LUtBSnq/waLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gRLpf4Luxs5Pb0AWkUpZAxOqfkSza2ES0ifnCEpXJTE=;
 b=NmoznoEqSWz3hheyszJKL6OyN3CRA7XKHXUuegB2XwN2Aj2Kif7tuDkL2+Me8O+51BFBHeBEqzhE+Zcj097DQ2hucnQHBBiva6YK59Kvs2PhoI9Guys46hYgkeND3Qss4B6GlAUM1aIGtToR/Ihv1g3cuZDoycFXtgHHEZ8FaXj+eDceOaqcJLudgSbCnYs5ygi7toTouzjaV8kyR6VciLB3UjubbxzRQdjTP2cy3fx9xmYuZZMq1xDiEENPTIArEE4Z/qOUOZ1MaFtRflXkrY3RcF6CKEIBunDZE6NR+1ji985zIixGJjMGG8uuKROtvWvZUjuAbipEe94VbEqxEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gRLpf4Luxs5Pb0AWkUpZAxOqfkSza2ES0ifnCEpXJTE=;
 b=SQ4SBYu143Nrc3Mpmz2natqoSxuSNSb/YwLe0vYXA3y9nkn3cT0SV5HRSL2PYnpjj4FMyIwuytw5PeOAHt5/BPY18EnN4Bpgf4/kJJyMStdPQC0qUGCAKfjCA27Gf8lJvRc0ritejpy6YxEzFaG/v8sf5MEMaJlCyP4SAWz4BBQ=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com (2603:10a6:800:20c::6)
 by AM9PR08MB6193.eurprd08.prod.outlook.com (2603:10a6:20b:282::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.14; Fri, 28 Nov
 2025 15:05:36 +0000
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91]) by VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91%4]) with mapi id 15.20.9366.012; Fri, 28 Nov 2025
 15:05:35 +0000
Message-ID: <0043fa85-f8c3-4024-a341-e1f378f25b97@arm.com>
Date: Fri, 28 Nov 2025 16:05:32 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/8] ACPI: CPPC: Add cppc_get_perf() API to read
 performance controls
To: Sumit Gupta <sumitg@nvidia.com>
Cc: linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
 acpica-devel@lists.linux.dev, linux-doc@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org,
 zhanjie9@hisilicon.com, ionela.voinescu@arm.com, perry.yuan@amd.com,
 mario.limonciello@amd.com, gautham.shenoy@amd.com, ray.huang@amd.com,
 rdunlap@infradead.org, zhenglifeng1@huawei.com, lenb@kernel.org,
 robert.moore@intel.com, rafael@kernel.org, viresh.kumar@linaro.org,
 treding@nvidia.com, jonathanh@nvidia.com, vsethi@nvidia.com,
 ksitaraman@nvidia.com, sanjayc@nvidia.com, nhartman@nvidia.com,
 bbasu@nvidia.com, corbet@lwn.net
References: <20251105113844.4086250-1-sumitg@nvidia.com>
 <20251105113844.4086250-3-sumitg@nvidia.com>
 <011bebf3-ebd4-4245-88ce-5e826faae66f@arm.com>
 <ccd45c1b-2f69-4725-918f-18063f00a864@nvidia.com>
Content-Language: en-US
From: Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <ccd45c1b-2f69-4725-918f-18063f00a864@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO6P123CA0049.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:310::9) To VI0PR08MB10391.eurprd08.prod.outlook.com
 (2603:10a6:800:20c::6)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VI0PR08MB10391:EE_|AM9PR08MB6193:EE_|AMS0EPF0000019A:EE_|MRWPR08MB11236:EE_
X-MS-Office365-Filtering-Correlation-Id: c79d25c1-2f24-4879-1a5d-08de2e8fbb98
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?TmNrVVVTWjdXSHA0MUhXbHF6QUwwbGQwN3dNMTVlaGtNS0lGUEUzdUtoWDFt?=
 =?utf-8?B?eTVmNlZseTBBN0Y3NS9VejNiUGpldWhyVXczOHlKNW45bmxEVFRaZ0NUaVQy?=
 =?utf-8?B?ZU9DNENCeTF2NGd6ejVORUlFYXE1K09KbTNvclZPTHFZdUlXZWJRWmc1cDJJ?=
 =?utf-8?B?OXpKQmpOenlhbGI1amNtY0tSbGgvRUJqT0ZGcFREcExoOWJwSE9ZZUVYem1W?=
 =?utf-8?B?RDFYUFlyOUVnb1BrM01WL1FzeFFmT1ZYU3Z4ZmNhYWNpMjZiM09jSUpvMWtP?=
 =?utf-8?B?bEVVOWVWMTZTcGpqQ2dWS2lpa0g2cGpNbVBaamRqcEVJUU91b1FCTFg0SXZD?=
 =?utf-8?B?LzVBZkpUeldaWU9NWVQweHZrTlVYc0RMTENlSHVVczJTYnBrNVFQMkdYa2Vx?=
 =?utf-8?B?bnBMRUNrYnhTMlZ1ZEY0K3JJTzQxdkdsVzIvRSt0UUtxNkp3MnkzUnpsQUVy?=
 =?utf-8?B?dk9DOUxMZmpwK04rTE44QTcyNmNBb0cybXZNUm02dksvY25nM25abm5hV21S?=
 =?utf-8?B?TjFSVjBIUGxnVlBhTDZZeTNtUE5yWVBUZFZSZVBFNW5Ub3h5R1RXbkJBdlNX?=
 =?utf-8?B?endRSXZ6N1lLZE1MUEN2MHdpa1ptN3BNN3QrdzZOUEU2MUZNM05GeDFHTmJC?=
 =?utf-8?B?VkFxeTQvOHZDcDlQZjIrME5JSXdIVjB3S00yYUJZUjZkNkJ5Vkk2NEJYdWFV?=
 =?utf-8?B?UENwNXk5dEwvNlFKYnROS2Z2V3Vpak0vWFRCUFh2dGJPVFFLWkovN1VyaUlv?=
 =?utf-8?B?WXFQK1JZODVhNmtaVUJXQWRxMDVxM1IrZW9KL0pNSXZJOXYvV0FIRkI2QUNV?=
 =?utf-8?B?WEpkTFhYNndTbUtoWWIybHBTUEdnamkvQVhsRkpTYUJLRGd4VEdIVXZZQjFO?=
 =?utf-8?B?M21YMG5IMnNVZ1NuN0pqWmpFWU1KbVNwcFlXbnFjVm85dUV3aDlsVnNXbWd2?=
 =?utf-8?B?a01kTUZyRGFqVlpIQm1vVnBnWjVIMFVoa1NYalo1TjhzQm9yTkpnbkN0Z1cw?=
 =?utf-8?B?N3orNENNZkZESFhvbG0wVnUvcm4zYWxWM2V3T0djOHFvK0NMSjBYMHZBeUxp?=
 =?utf-8?B?T0t5U1dSVS9nMWwxVXM2VFFqclExVUYzMTE1TVZ3NmpETUJ0V1dSeGtZbTQ0?=
 =?utf-8?B?Q044M2NYaHRXTWsyK084MDZ5aGdlQnM0S0lwY0krZUdrK1JEeCtlSGpBTXp0?=
 =?utf-8?B?TEpLQ0RNTi92MFlZNUx2NkJrZTRTWi9zSlp6Y2F5d0ppMVhhNk84dFl3blhy?=
 =?utf-8?B?dkFyeXNlMGdBNG92M1JrMXczS0MxZnhTRllkZzZxUFMza21keHgyNTNOSHJY?=
 =?utf-8?B?WTRJRGxDZjJUMWEvYWo4YklRdkcwZ2l1SUt1Zkl4SGhXQzlpKzBJT3g4cVZy?=
 =?utf-8?B?OGp0N1V3T1hCUmNnSVZOdTEvY3BYK01ZMFJOVFZCd2VFZGFHaHJ6Zk81WExn?=
 =?utf-8?B?VzJvbm5GVnpDS2prdXpISHExUHVxS2dEeFJRTnJBb05Vd0NpaVRHYXVZRUg2?=
 =?utf-8?B?YmJhazNVdnVnTkkxVCswUTEwZGV0YnJJL3J1L1hqWHpqMWdmS2Q5VG4xZXl5?=
 =?utf-8?B?V0hCY0JDc05HaGxUR2dzaENFN3hPS2d2RTJJcFdsZDhiZFNrTi9nUUtwTjA0?=
 =?utf-8?B?cUtWdHROdlBSTmRRWjJmUXNIeXZoY1pCOGgybCt3Z0F1SE9tandKWTBHd0hZ?=
 =?utf-8?B?aUxYR2dHWVJ3YXROd04yR0w0M2NDSmZlcEczL25qM2EwSFFjLy9JazVmWGZs?=
 =?utf-8?B?Sk40Z1NRNUhoSVRaOW0zamUwbGJ6eE0zWHpKOHBOTHpyYnJkY25kVHRHdGJK?=
 =?utf-8?B?Mmk2RlZnc1laT0tUdWRuZElhYzBIYkFIbTN4ZmpYVGprampJZEQya28rekdD?=
 =?utf-8?B?dDB2bXhCeS8rVjdDbmJoUGlBSTUyQktwWmp0cThLa3J0NEFvV1J2YTJQWFJS?=
 =?utf-8?Q?oyK/mxHHOcdlHnx6WMuewz3lUgnqHlVf?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB10391.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6193
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF0000019A.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	cce49fe3-f030-4398-53d7-08de2e8f9565
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|35042699022|7416014|376014|14060799003|36860700013|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Sk1YcTJDU1hWMS95MFg0ZkxMY1JoUlpUQ2JzQzBjZ3BSYStEREJqd0RhNGhM?=
 =?utf-8?B?QWxVWisyUjdwK0lzMG1pTDFycHdUUXd6Z3JQNWNScW5OYlhmU1JZRHlCZ2Q0?=
 =?utf-8?B?UFJyVTFWOGo0aEJvblhFSCtYcGUzSlR1T0diaVc4UGJKRnFoTDY4ZVFuMjhW?=
 =?utf-8?B?cnRFMWEraHNoeTdJMWFKZjhpV0hrM0FXNUNSRmQ3MkFUWEg1dVk2b3hSR0JN?=
 =?utf-8?B?YXI5S3RsR2VuUEdKWnhLQW55WWZjZEV5amZ6NDNvMWZTSy9Rclp0ZzZTUVpO?=
 =?utf-8?B?OE50WERNQ29KOHhhMW1YbVdsVE9tNElVcHVlNHhDdE1ZTlAzSlpZSmNNMWdE?=
 =?utf-8?B?RU1mWENDZ1FWdExhNXpFVHZ1UDJsaTBOZ1V4NUsvdFM2dGpPaURhUW8zS0RY?=
 =?utf-8?B?bUtrbHpUUFVUMys0MXkwcTJjSDZMQ0lBUjcyOVZWamMxMDN4ZFBlNHAzS3Zp?=
 =?utf-8?B?ZHFlbGx2VVJRcjl2RzV4dEZJNWwyK0Nqd1M0K3czV1VHN3hvZ0J5OTZ0SnZu?=
 =?utf-8?B?NGtUTitmaWFOWERBTjUyRHM3TnJuQ3lmdVJsS2VQNjdXd0NiT3BVOG9tcEpJ?=
 =?utf-8?B?Z2cvSDVOUGxhdExoRUF5RmFKenpISFRhTnduYnZWQWdjZDVtdk9zb21CaUw5?=
 =?utf-8?B?Z1NUaGZqdGZUWXhzUk9oRUU4TUJLNW9GdDlnVVVJRWxYTUJvYWtGaHNXVG0y?=
 =?utf-8?B?cEJtOCtaS1oxQ0IxOS9oeGQ0OUZ2RXJkb0ZaT1dpZU1YTEdIb1BwU0FxR3NM?=
 =?utf-8?B?YkIrQTkvSFdsL3UrRVJIa2h5MDdRSzR1SlYxQVk5dnZwdlRwV1Fnd3pMTThJ?=
 =?utf-8?B?V0R5dHJ4OUltYkE0Q0dXcDdFVHovdmZ2U0R5b0lYWk4xSlpONEZ2Q0JINE5K?=
 =?utf-8?B?elcyUjNVZ09qSXR2RDFuamJnVVR2ajk4cXZZR1F4MGFSV1ZtVERaTGNwMzRQ?=
 =?utf-8?B?TzkxUlhWNms0U05PcVVvVEJZUUNwTkFSdjkxS3NpNjVCeTB3THN6cExoVlRz?=
 =?utf-8?B?QnFwQWJ2T1dHalc4SWx1VmVTRnI4U2pWM0tSMkR1akFyT2hUQ2VjSWhhRWRG?=
 =?utf-8?B?UjRUWXZwdHFrdTFuL0dDQWhUMEhTdmRGTlJSeDEzYm9jaUZEUFRLMW9XL0ts?=
 =?utf-8?B?RjVnWksvbVRqL1ZVUXRsckxwUGw4cGpRdzE2azVIN3ZYRVI5ZW1QZUNYYkxa?=
 =?utf-8?B?SEY5TDNyZFY5THFDUFFMTWN5NzVabFdjVlNtRGpQSEVBSTBBN2RSZ2pLamMr?=
 =?utf-8?B?aEtvblMzalpDWndaRzVLdU15K2hGaEhRUkRaNjZZOXo2eTJMdmNVSDhKQ2pF?=
 =?utf-8?B?bytMeFpHRlVwU0RCWWNMb2hDLzcvMlBobnhnYmw5S2Y4WlRPUWVrZ01YTXNv?=
 =?utf-8?B?YUNaOVpiaXlhemx2QzYwTW9qSkJSRU0vYzk1NHR2ZnFyTzltd3Z5ZHJ5N2ZH?=
 =?utf-8?B?ZmxqajBrVjBlZzdFT2l2SStDZ2tZMUMxYkx0ZGI4azNHQUQrYUprclNVelNH?=
 =?utf-8?B?VTVybjg0TDREZTUrdnhGQmxHaDhZK3F6NzM5cWlrTHI2aHVCMGxZQ0UzUGJp?=
 =?utf-8?B?djNGYmtnSU8wV0JLWW9XQWdTQU92VjZFdlFDRDNnZUt4eUI4MFYyNEZOeURj?=
 =?utf-8?B?NWFJMlhhcWVXMis0bk01N25MZ0h4RnV0MUZwcWxwQ0xtOFl3MWhaRHk0Y3c4?=
 =?utf-8?B?WHVFY3JQNi85bFBXeDl2Y0VPUDY1SUdBYmczamp3UkEwcmRmYlpDbzVQQk1G?=
 =?utf-8?B?K2x3aTBFZkVSQ0FPWWluVExjSUYySHY3V25aMDJVcXphL25BaEhpMlYvMUdh?=
 =?utf-8?B?ZG5ZeE9ZbjRlQVpjb3JqY1RmNHVqbFVMRlAvSXVCYklybGt1dkNxZGdZdEs5?=
 =?utf-8?B?S0RRU1VCa2NMMkMwVzhmSlBHVDA4Tk4vZkZTME90b2NWZlZCamVZR3VJZC9I?=
 =?utf-8?B?YmoxZnhqaVpBUzcxZjZvNkg4VUNSTno1RDlYQjlzQktLVUVpN0tCQy85dEt0?=
 =?utf-8?B?bmtlTWRuNVRQQTB3eGtJWlFFbmJlOTRQakh1RWhUSEl2RVFBUTdNMVNKRVhV?=
 =?utf-8?B?ak5XSHlxN25nNkltRk9lY2IzWmduYjNhdHpjaTdFSzFMRGt0TGF5NEhyVWtt?=
 =?utf-8?Q?8mjI=3D?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(35042699022)(7416014)(376014)(14060799003)(36860700013)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2025 15:06:39.4651
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c79d25c1-2f24-4879-1a5d-08de2e8fbb98
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF0000019A.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRWPR08MB11236

Hello Sumit,

On 11/28/25 15:01, Sumit Gupta wrote:
> Hi Pierre,
>
>
> On 27/11/25 20:23, Pierre Gondois wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> Hello Sumit,
>>
>> Sorry for the late review.
>> I think it would be nice to split the patchset in 2 as handling the
>> auto_sel and
>> min/max_perf values in the cppc_cpufreq driver might lead to more
>> discussion.
>> I.e. the ACPI: CPPC: XXX patches should be straightforward to upstream.
>> This is just a personal opinion, feel free to ignore it.
>>
>
> I think its better to keep the changes in one patchset for better 
> context.
> I agree that the 'ACPI: CPPC: XX' patches can be applied first if ACK'ed.
> Will update the cover letter in v5 to request for taking those patches
> first if no new issues and send v6 with changes on the rest of patches
> if any new comments on them.

Ok sure


>
>
>>
>> On 11/5/25 12:38, Sumit Gupta wrote:
>>> Add cppc_get_perf() function to read values of performance control
>>> registers including desired_perf, min_perf, max_perf, and energy_perf.
>>>
>>> This provides a read interface to complement the existing 
>>> cppc_set_perf()
>>> write interface for performance control registers.
>>>
>>> Signed-off-by: Sumit Gupta<sumitg@nvidia.com>
>>> ---
>>>   drivers/acpi/cppc_acpi.c | 73 
>>> ++++++++++++++++++++++++++++++++++++++++
>>>   include/acpi/cppc_acpi.h |  5 +++
>>>   2 files changed, 78 insertions(+)
>>>
>>> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
>>> index ab4651205e8a..05672c30187c 100644
>>> --- a/drivers/acpi/cppc_acpi.c
>>> +++ b/drivers/acpi/cppc_acpi.c
>>> @@ -1731,6 +1731,79 @@ int cppc_set_enable(int cpu, bool enable)
>>>       return cppc_set_reg_val(cpu, ENABLE, enable);
>>>   }
>>>   EXPORT_SYMBOL_GPL(cppc_set_enable);
>>> +/**
>>> + * cppc_get_perf - Get a CPU's performance controls.
>>> + * @cpu: CPU for which to get performance controls.
>>> + * @perf_ctrls: ptr to cppc_perf_ctrls. See cppc_acpi.h
>>> + *
>>> + * Return: 0 for success with perf_ctrls, -ERRNO otherwise.
>>> + */
>>> +int cppc_get_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
>>> +{
>>> +     struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpu);
>>> +     struct cpc_register_resource *desired_perf_reg, *min_perf_reg, 
>>> *max_perf_reg,
>>> +                                  *energy_perf_reg;
>>> +     u64 desired_perf = 0, min = 0, max = 0, energy_perf = 0;
>>> +     int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpu);
>>> +     struct cppc_pcc_data *pcc_ss_data = NULL;
>>> +     int ret = 0, regs_in_pcc = 0;
>>> +
>>> +     if (!cpc_desc) {
>>> +             pr_debug("No CPC descriptor for CPU:%d\n", cpu);
>>> +             return -ENODEV;
>>> +     }
>>> +
>>> +     if (!perf_ctrls) {
>>> +             pr_debug("Invalid perf_ctrls pointer\n");
>>> +             return -EINVAL;
>>> +     }
>>> +
>>> +     desired_perf_reg = &cpc_desc->cpc_regs[DESIRED_PERF];
>>> +     min_perf_reg = &cpc_desc->cpc_regs[MIN_PERF];
>>> +     max_perf_reg = &cpc_desc->cpc_regs[MAX_PERF];
>>> +     energy_perf_reg = &cpc_desc->cpc_regs[ENERGY_PERF];
>>> +
>>> +     /* Are any of the regs PCC ?*/
>>> +     if (CPC_IN_PCC(desired_perf_reg) || CPC_IN_PCC(min_perf_reg) ||
>>> +         CPC_IN_PCC(max_perf_reg) || CPC_IN_PCC(energy_perf_reg)) {
>>> +             if (pcc_ss_id < 0) {
>>> +                     pr_debug("Invalid pcc_ss_id forCPU:%d\n", cpu);
>>> +                     return -ENODEV;
>>> +             }
>>> +             pcc_ss_data = pcc_data[pcc_ss_id];
>>> +             regs_in_pcc = 1;
>>> +             down_write(&pcc_ss_data->pcc_lock);
>>> +             /* Ring doorbell once to update PCC subspace */
>>> +             if (send_pcc_cmd(pcc_ss_id, CMD_READ) < 0) {
>>> +                     pr_debug("Failed to send PCC command for 
>>> CPU:%d, ret:%d\n", cpu, ret);
>>> +                     ret = -EIO;
>>> +                     goto out_err;
>>> +             }
>>> +     }
>>> +
>>> +     /* Read optional elements if present */
>>> +     if (CPC_SUPPORTED(max_perf_reg))
>>> +             cpc_read(cpu, max_perf_reg, &max);
>>> +     perf_ctrls->max_perf = max;
>>> +
>>> +     if (CPC_SUPPORTED(min_perf_reg))
>>> +             cpc_read(cpu, min_perf_reg, &min);
>>> +     perf_ctrls->min_perf = min;
>>> +
>>
>> NIT: I think the 'desired_perf_reg' register is mandatory, so the check
>> could be removed.
>>
>>
>
> The register is optional when Autonomous mode is enabled.
> As per CPPC spec:
> "This register is optional when OSPM indicates support for CPPC2 in the
> platform-wide _OSC capabilities and the Autonomous Selection Enable
> register is Integer 1"

Yes, right indeed,

Regards,
Pierre


>
> Thank you,
> Sumit Gupta
>
>
>>> +     if (CPC_SUPPORTED(desired_perf_reg))
>>> +             cpc_read(cpu, desired_perf_reg, &desired_perf);
>>> +     perf_ctrls->desired_perf = desired_perf;
>>> +
>>> +     if (CPC_SUPPORTED(energy_perf_reg))
>>> +             cpc_read(cpu, energy_perf_reg, &energy_perf);
>>> +     perf_ctrls->energy_perf = energy_perf;
>>> +
>>> +out_err:
>>> +     if (regs_in_pcc)
>>> +             up_write(&pcc_ss_data->pcc_lock);
>>> +     return ret;
>>> +}
>>> +EXPORT_SYMBOL_GPL(cppc_get_perf);
>
> ....
>

