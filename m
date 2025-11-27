Return-Path: <linux-acpi+bounces-19321-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FC98C8F025
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Nov 2025 16:02:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2ED43BAA59
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Nov 2025 14:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D343335062;
	Thu, 27 Nov 2025 14:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="TiyNz2oB";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="TiyNz2oB"
X-Original-To: linux-acpi@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013016.outbound.protection.outlook.com [52.101.72.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE18333756;
	Thu, 27 Nov 2025 14:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.16
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764255296; cv=fail; b=czcAEqswuCAQSCHPZxfgO37XyB0n74Oy4O+8jy06CVVO2Pl5tKRAMBQUvuNb/yiXdEELdgbtkiRyO9UAiOxv/9QcchNGaFRxz+181Nu1DnLfItChFGxMa/7REOiU0Hz3YDIDbm8I/fgYzCoMJdDF1YOeXxziQeWRsg3KI12uVBI=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764255296; c=relaxed/simple;
	bh=Hen+GGXnv/Kspn5Yl+N7ljkQ0Dc6VJjh2aF3JreeHTc=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ONMifA/KsPKJJLbSyIVUC0S/GWKb2KqkAMOW4/Poy0wRowboLfGGxNsjUHvU5NXeXdCNq5XArvWrmrTG0pYcgJn/GBKxaFIyFsNR3mkCu+FFahctvy2IpEI+NzkNMKV5pHBk7zMyRclLFFnYhqzlBO7f06GlROecygV6K3pNEt4=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=TiyNz2oB; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=TiyNz2oB; arc=fail smtp.client-ip=52.101.72.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=guxZ79V9FfA5N7FIU7bcCj9fDI65pGy5efe2yajTvrpXFLWPwPWo/sJDUd8YQs2HMoSp2aB0ZUoVH5fBAPuqNnPKIByYpOk5lHm4Dv9g5DB/eXhhSvbjasATYyGDT5ZEaMNSUsHeaMliyKIUSmvKyBnlnZuD431htVeTeeQ22Mx9pPc/Td3ZpJB/7V779+aCxkh9ZYKr9jA5xnAFOdW33ylhKnMX5Yr9FzG6xpSgD96B4RrZNGbNhhKANrA5d80RfKqv1JkSYQVsPdvnE4ixnmrOqEmH3WuJxjvBtkIaM48zfgN+mTQFSPA5uIOmYjmDeRljn6nZj8YeJH8lVHaOmA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BO+94qIMtPkeJURjLTKQxRXVXO9d3yKfWURX2abR8cE=;
 b=UGxf4y0wv4c2ELYnnNhmn7sIjafCx4Vk9SWd0P+oz9hG6BZhPhemG2zxdavRpnZgCYjhoX4iqyqz4WAZg6jEBue2qKNHuoPJv8RcvMWqMPV3ezKMFVLWzFxGxikm3JCGVGpvPB9iLUdd2s8nico7IJPppj+MiuhQSftzMMlxcJqAocbJUBiGi1mIT4hKBl1o+EqAr+3mhVQ4GnjYAWCcnKqGd/tcrrUPVpQH3CHCVpHlLJUqUdtY4w7ZM74Vi33L8lZ92aIs4Fn2bNYqvf0yFm4cx1Bw50Uf3mS4E169PNJUXoO/mJsZ9QPjfh19nMXyMZxBLFPaZ/unCJuXUIIZdQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=nvidia.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BO+94qIMtPkeJURjLTKQxRXVXO9d3yKfWURX2abR8cE=;
 b=TiyNz2oByCnqHTJEwoYbfCSg9GTqcz7IU2H3YO6m+2JXFA7OjTu0ZuURZqYHxpRCPhL59i0ac/NvbZpLmXMuRUSz2Bd5y1S6QaNter3IPyazX/wLyfUtfUt7HSXV8S8z8/GAyxfQhqECp6L2LqmNq4EVtyWDG3R6v/Man8Zob9g=
Received: from DU7P195CA0009.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:54d::10)
 by PAVPR08MB9505.eurprd08.prod.outlook.com (2603:10a6:102:315::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 27 Nov
 2025 14:54:46 +0000
Received: from DB3PEPF0000885E.eurprd02.prod.outlook.com
 (2603:10a6:10:54d:cafe::3) by DU7P195CA0009.outlook.office365.com
 (2603:10a6:10:54d::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.14 via Frontend Transport; Thu,
 27 Nov 2025 14:54:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB3PEPF0000885E.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.7
 via Frontend Transport; Thu, 27 Nov 2025 14:54:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QOEBPS+QRnhBg6di5PNky/w7+a6sFjle6rR7x4+9IGJqFaqCTJqWv5FUGFLgQI5FemjKuTIv4ECTsM83NjsLej7aZGJbNPDbJ60vaiZCFjg63gn7BGE8zQMdOo5IXos41fmnEchLKOjQ211HMl4pwaoyEsm4z4ek98K2FIzg8dCbib+eezNr8tDPFiipfOA/B5YrlDSejaSOLAX4Y6sIfNsce7rhIvTTxwBDWJqapfwJfU5UPGIZxWZ6FsRSITHaBsFpey1JGzyLW2XGdirWHNDJFIN5DtVc5KQ4EQWkgFY9WIxXI2I4y3yECCvzD/i7piKeis2FbIVruiR1Q8az3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BO+94qIMtPkeJURjLTKQxRXVXO9d3yKfWURX2abR8cE=;
 b=tF4V17HiAvH6dTfQIlQqnBZ8R04eG49N6ZxlJKdFpbNf5FV8s1oD/59Z8/jEGPGxfjuPdBmoq1gkURKKT8DEEaAEUIyU4YIPm6r7N/EoEkwoxYGX1TlnRGDUse7hctGsUWKjxEHG5ljmNqNAIfaWws/3RS9srSoqaKtBKQObnMjBt8KfRjMC6uM9ftCZKGho6fg8r7gfIZfGUeKXt9KrNdrIQ9rW07Mk7YAWmkVZNYApPWFAioc77b4WLweWc1hpmCM432adI8zxwpkDNVGo98GOvCQpm+PE8fqlI6Pet0uxUqfVANZaGRqx14bajUg/UzwX98MsEAyJ3e1VWfkwOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BO+94qIMtPkeJURjLTKQxRXVXO9d3yKfWURX2abR8cE=;
 b=TiyNz2oByCnqHTJEwoYbfCSg9GTqcz7IU2H3YO6m+2JXFA7OjTu0ZuURZqYHxpRCPhL59i0ac/NvbZpLmXMuRUSz2Bd5y1S6QaNter3IPyazX/wLyfUtfUt7HSXV8S8z8/GAyxfQhqECp6L2LqmNq4EVtyWDG3R6v/Man8Zob9g=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GVXPR08MB10408.eurprd08.prod.outlook.com
 (2603:10a6:150:149::17) by DB9PR08MB7891.eurprd08.prod.outlook.com
 (2603:10a6:10:39e::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.14; Thu, 27 Nov
 2025 14:54:11 +0000
Received: from GVXPR08MB10408.eurprd08.prod.outlook.com
 ([fe80::7727:253f:2e85:efb8]) by GVXPR08MB10408.eurprd08.prod.outlook.com
 ([fe80::7727:253f:2e85:efb8%5]) with mapi id 15.20.9366.009; Thu, 27 Nov 2025
 14:54:09 +0000
Message-ID: <8fb77549-ce33-4c89-959b-57113eb716b6@arm.com>
Date: Thu, 27 Nov 2025 15:54:04 +0100
User-Agent: Mozilla Thunderbird
From: Pierre Gondois <pierre.gondois@arm.com>
Subject: Re: [PATCH v4 3/8] ACPI: CPPC: extend APIs to support auto_sel and
 epp
To: Sumit Gupta <sumitg@nvidia.com>, mario.limonciello@amd.com
Cc: linux-kernel@vger.kernel.org, acpica-devel@lists.linux.dev,
 linux-doc@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-pm@vger.kernel.org, zhanjie9@hisilicon.com, ionela.voinescu@arm.com,
 perry.yuan@amd.com, gautham.shenoy@amd.com, ray.huang@amd.com,
 zhenglifeng1@huawei.com, corbet@lwn.net, lenb@kernel.org,
 robert.moore@intel.com, viresh.kumar@linaro.org, rafael@kernel.org,
 linux-tegra@vger.kernel.org, treding@nvidia.com, jonathanh@nvidia.com,
 vsethi@nvidia.com, ksitaraman@nvidia.com, sanjayc@nvidia.com,
 nhartman@nvidia.com, bbasu@nvidia.com, rdunlap@infradead.org
References: <20251105113844.4086250-1-sumitg@nvidia.com>
 <20251105113844.4086250-4-sumitg@nvidia.com>
Content-Language: en-US
In-Reply-To: <20251105113844.4086250-4-sumitg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0125.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c6::11) To GVXPR08MB10408.eurprd08.prod.outlook.com
 (2603:10a6:150:149::17)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GVXPR08MB10408:EE_|DB9PR08MB7891:EE_|DB3PEPF0000885E:EE_|PAVPR08MB9505:EE_
X-MS-Office365-Filtering-Correlation-Id: 64514f05-074b-4be9-99b0-08de2dc4e779
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?NGNnMFFtd1JTN2gyNUhrdU5jOVdkZXU1dHk0MHJUU3lRODcrWlNiSUVNVnVW?=
 =?utf-8?B?cEM2czVwdnJtYm52bVYramhQTjRnaDNyZitHeWtJOExnMXRxNTFGaW9aRnVW?=
 =?utf-8?B?MzVmWjV0azhucWh3dUJxMWVjR00yYzRoZE05SlFHeURwQkx6UVdlMnZad3N4?=
 =?utf-8?B?U0xTZEVDVS9ueG9SVGJMc29XUUhKT3pQUUNBbmNtcW1LV1VEYmZpUFgyUWpj?=
 =?utf-8?B?eEs1aFBTMHc1UUtPazA1QTVocUx3S0V3UVYvSG40Ryt4Rjk2YnE2QnloYVVo?=
 =?utf-8?B?bHRHaHFoZ3o5VHZ6QWU4Y3puVC9udFJjSjJ3L2E1TDhYSHZ3VWlRZC9SYmZC?=
 =?utf-8?B?OVArdEhwTmx1b3FCSitDNjNTQ2dJb2l6Tk9UeDNvZ1VBUlhHVTRJZkNUR09x?=
 =?utf-8?B?QWMwVncwaHJkb2QrelpUZllaZzlJRjhQRkE3WEp6NUh6d21qMUpURDQzZ2pN?=
 =?utf-8?B?ekNpVTArNW00Q25DTXNJYm80Qk1IVnRVWGZycTNDYWhuWmJ6SmxKUk9EQUF3?=
 =?utf-8?B?OFd1L3hTR0RTTUptcnBCdkJhNm1hMkY0UGVuZXF6VVgrc0ZFVDV4U0NONVpG?=
 =?utf-8?B?MWlEYUxLbnFad2hVUGgrNkI2eGNjMFVjYjd1d2xwVXVWOFFhQUJuQnlJRnpB?=
 =?utf-8?B?b0JUZXZPSkJuV3lRZWErbGFjeXRMVFpRRkdIbE1IWXNGeUx3RDFsOXNVaGdD?=
 =?utf-8?B?b0pKTWdaUEt0VmZXaUc5NU5HazJzeDZFOWxlS1JKaGhQd21PL2RnWFpqRkEv?=
 =?utf-8?B?MUZ6SG1vY2NKKzVqY1N6K0JCZlpXeGVOeHh4Y2ZmU0lYcUJtd0xwM0NXbWF3?=
 =?utf-8?B?ZFlTM1hDcjRvUGp4ZG4zYWhkZ3pYbEE0ZmoyS0FMVDIvUDRwNXNKYVI1VHM4?=
 =?utf-8?B?TDZ3SjJQTW9qdU4yc2tlbHlzTk9wVjhKajlXSGxwYlhYa2ZYaTRnYnNoalJL?=
 =?utf-8?B?RDZObnlkODd1dFFoMFZrdlRwb1Y0clErcWJzQzdLUUd5aEVoTTduUlNMWUk0?=
 =?utf-8?B?RVdCRENTaUVqRFcvS2MyQ08xSHBJVU9MeGVwWmpONFVqYXBLb1J3UGNWUUtW?=
 =?utf-8?B?amUxTHkrazVRMDZUNzl6bC9IOGZqdGkvK3N2UlR0WmZFd1Qvd2FMQlRobTZs?=
 =?utf-8?B?OVdqSENyend2R3E4dGJDNjI2QzFlN2lKSHJuLzNsakRvUERmbmN3S1FYa09T?=
 =?utf-8?B?NjNqVmNqald1eVNaRk80cXFTSHoyalJScmxzZkc1aG10ajBkdytsZHVwOW1X?=
 =?utf-8?B?a1B5U0doR2gvSWlENmt0OXhkME9NODhQV2F3cDM1OUljdTF6SWlBOUEvRHVs?=
 =?utf-8?B?OFRQNG1TVDFzKzRiWnRTdHdMNmtCQ29qTnEza0dUb0VnSjJ1eEI5ZGpuNzZO?=
 =?utf-8?B?N2tyQVFlbnJ4VGM3Z0dTaWt4T2Z6MllXK1JuUUV1ajcwZVR3NlQ5T2QvMHcy?=
 =?utf-8?B?bmRpM2pYWGE5YlloN29XblErZENuWXoxVWxiczBLbzFGYmptRGIyQUhJQmI3?=
 =?utf-8?B?aWNvOFVHZjI4R0tDRTViUEZFWm83VVlaSjh4ekFqRER3V1Bma3hrVnZsWmlF?=
 =?utf-8?B?RXZvQmFyU0M1ci9XZlBGUjZhay9jSnpTSnB2cTVkQ2NialVDQk80ZnA1dWEx?=
 =?utf-8?B?N2FET0JGK2pncDRCSEJSR3VoY0FDbXN2Z0NPWXN3bzl5a2dGZzdXeWdRSFY5?=
 =?utf-8?B?b1FDV3VvWDMzc29MVW1DVTFmSzlYTloxWWcvY25NK0pCRTlPYjRwekVrRSty?=
 =?utf-8?B?dTZpYTB0UDBNeW1oeEpzaURkOHZBenlmRklZSndscDZ3Z3Zhd3dETkozZkh5?=
 =?utf-8?B?YXhoQVZSR1c5MnhyWGtIY3JBZXVKVURId0RuSld5N1puNlJ1SzU4L0pKRk5M?=
 =?utf-8?B?eTBzN091Mkg1ajFpS2xsbTBXNjQ1UzlHMGZoVXV4T1FldnBFOG9WZE5PTk1t?=
 =?utf-8?B?eXJacS9lZTJnUTByNktJK0VUc1ArcUVDYTdxQ3I1SVR4MlJrV2RsblFxSXRZ?=
 =?utf-8?B?eWNnVzNZSFFRPT0=?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR08MB10408.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB7891
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB3PEPF0000885E.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	a64811cc-d01f-4b84-637e-08de2dc4d225
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|14060799003|35042699022|7416014|376014|36860700013|13003099007|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Tko5K2FnWHN3VkNJc1F3ekdpNHZvNTMvcVp2NmpVaFpKS3FhYjlseitSOU1a?=
 =?utf-8?B?OWxFcU9Ub01WUXFuV2FzendpWUlDRk5URDUyTlBvOTR4QXR4cXpiU0JLQVFY?=
 =?utf-8?B?aHU5VHh6ZVd1NlZHWHNqbTdYMkkyekxZWGFxNWI4T3lNYkh5TXY1UmxVaGpi?=
 =?utf-8?B?VDVOV1NVRTJBa3ZraVovdjVIMUdMb2xxTjBVMm04NysvQUc0d3Y5Z2RpdGFI?=
 =?utf-8?B?dk9ZUEduS3NwTFRvTUNHeDFuU0ptWWlzRkp2ZVM3ZE5OZDFSaWROSXpRVnlH?=
 =?utf-8?B?aHhQNkVXQXF1eVFSOTVEb3l6aHhvdHdHYnFpamwvcmxvcmw2UTgxeVMwdHpz?=
 =?utf-8?B?dVB3V1dpcEV1VUhkVXZuNGlqOXo4a1A5K2ttR3UvYmliZjBQS01EZGNrZzVG?=
 =?utf-8?B?VURaa1hPUitCM0V6NGoxTDg0WkU1NjM4clp6aEovczZxZVJIaEhNcnBFNXli?=
 =?utf-8?B?cGVjZ1M5TEZyK3MrTzJQaFBGUmd6Z05aMTlsU3hDdlJZbTU2QXhJSnZIV0JZ?=
 =?utf-8?B?NWttR3Bub1FJODVXaXkwUXJZaEQ5dUcrdHFTZnc4RnFsOFJEV25yWXJSSTJP?=
 =?utf-8?B?R09veWNrMFlXQWxldzhoSlRRejI5U2M1YVdhK0luaHhMUGNXaG0vQ0xYeExq?=
 =?utf-8?B?SDd6Qkg2Ykx1cGlpL21yTGJqVHNjenZycitNeVJqZ1RjazhmOUlHYy9SU0hK?=
 =?utf-8?B?aFp1cGhzOWJKYVZRTXZ4SEVTMWRnKzdNVGh3QXQ2N1F0MW11bVNobjVRUEkw?=
 =?utf-8?B?Z1FVY1VFdTVGa3JrNS9oMnZrRDJvU3d0R0J5VDlIYmRDWm5ZK29wQ0pkNFI4?=
 =?utf-8?B?TjhiMFRVOU9CKyt4TlpDbnR0RzZhUDIzbEdNVWJ1VW0wc2NaazRRaXkrbGc2?=
 =?utf-8?B?OEZNZWVWZkFKWXV1K0d0L3NaRnAvY0VaaGJzMTVjVXFvakw4azc4aGp2RThh?=
 =?utf-8?B?QjZVVnJNWUJtdVdJbzNDWDBITHhiNHdaN0VxODkyQk1EczN6YVZyeGFUM2pV?=
 =?utf-8?B?RTVKak5LMkZlTkJZUnBUMnJuUzg2RUtBVktjcEhHOE41K0FDTGRmeG9YNG5u?=
 =?utf-8?B?S1FjbUI2NWFuVlFONjJwUWNyVDZzaVlnMUpJcHlaV25QcTJVTGpUTmV0ZDdo?=
 =?utf-8?B?YWRqM0w5cWsyVWxMZDQvYlJQNGl5UHZIWlNxcVFPL0hQYlVjNVVVUVhsRFVB?=
 =?utf-8?B?L1lZclozemEraEZJY1F5V2pwOTU5YktRVzVhcnN2WkdGWktaSDlGUGY3UHp4?=
 =?utf-8?B?Q1hhbTJqTXRINnFKLzNpWkhEZm1zSVBEM1c1d1BQVGF6VHFjQ0xRV3V0UnVU?=
 =?utf-8?B?VFNvYzllZ3ZLSmpaRUlpbSsrb3BIdmZiMk80TlBTR1ZjeUgvKzN3TTNiN1Rv?=
 =?utf-8?B?TmdXbUpNVnNIV3BIN1FSdE9tRmFWQTdhSGc4SHBnK1U4M2lZSFJzZG9NczhQ?=
 =?utf-8?B?YnI3bE45WE05OXU2K2h0TmtneVZST1kzaWlSQUZqT21kRGFJbTdqQWJtb3Fv?=
 =?utf-8?B?cUNqcGhLZDdkLzg1YUJmY1M1VEJMYWl3aEdNY28weUJwazg4NmVINHdneXpX?=
 =?utf-8?B?UU5oNXhBZUFxaXhUWFA3WTNTd0NuWmpCTW41QUlCMVpRMW5GUWVjNU5MYXlD?=
 =?utf-8?B?Nk15NjM0SmJyMWwycy8rN1BXWUpwUEVXbFJZaWJlMzhtMmJnMm9VYlJDOUtr?=
 =?utf-8?B?UElmanUxMVk0S3VhQktBOFU2NEZJcHBlRkZ4QlE4WnhsRHUvcFEzNG5QVlFn?=
 =?utf-8?B?MVU2NGRpMFVEbFpEMDI2OGRPMXV5QVN3ZmswWUlkVE9IM3BnN3NiTnJMcEhI?=
 =?utf-8?B?U3lwWGZoTnJPQWcvWWUwc1p1QVJLMFNSMWVmM3dSTVpXdlRQNTdxeWhkcHkz?=
 =?utf-8?B?eHRoZ3lra3lsaE5LUzVRTUF1R2YrVVgwNlFJZFBhK0lNc3B4NXM5WU9pcURo?=
 =?utf-8?B?Y0RZMkNsc2tzWXdOYUpWajA3UGtQQmpLaTB1dmhjYnNhclMvOG5PNFVLRHRs?=
 =?utf-8?B?WkQwaUllcmUxZ0ZpQi9UVG14cVV0UysvOUtjaVVDY0JZcHFsUW40di82ZE44?=
 =?utf-8?B?Y3l6c2Nxd084Zk4zVktmSTdvUXp1Y2RMbTJwRnpIZlJ4dHY5dklsQkJjU0Na?=
 =?utf-8?Q?oiig=3D?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(14060799003)(35042699022)(7416014)(376014)(36860700013)(13003099007)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2025 14:54:45.2377
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64514f05-074b-4be9-99b0-08de2dc4e779
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB3PEPF0000885E.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB9505

Hello Sumit, Mario,

On 11/5/25 12:38, Sumit Gupta wrote:
> - Add auto_sel read support in cppc_get_perf_caps().
> - Add write of both auto_sel and energy_perf in cppc_set_epp_perf().
> - Remove redundant energy_perf field from 'struct cppc_perf_caps' as
>    the same is available in 'struct cppc_perf_ctrls' which is used.
>
> Signed-off-by: Sumit Gupta<sumitg@nvidia.com>
> ---
>   drivers/acpi/cppc_acpi.c | 42 ++++++++++++++++++++++++++++++++--------
>   include/acpi/cppc_acpi.h |  1 -
>   2 files changed, 34 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index 05672c30187c..757e8ce87e9b 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -1344,8 +1344,8 @@ int cppc_get_perf_caps(int cpunum, struct cppc_perf_caps *perf_caps)
>   	struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpunum);
>   	struct cpc_register_resource *highest_reg, *lowest_reg,
>   		*lowest_non_linear_reg, *nominal_reg, *guaranteed_reg,
> -		*low_freq_reg = NULL, *nom_freq_reg = NULL;
> -	u64 high, low, guaranteed, nom, min_nonlinear, low_f = 0, nom_f = 0;
> +		*low_freq_reg = NULL, *nom_freq_reg = NULL, *auto_sel_reg = NULL;
> +	u64 high, low, guaranteed, nom, min_nonlinear, low_f = 0, nom_f = 0, auto_sel = 0;

I am not sure this is really useful to get the auto_sel value register 
in this function as:
- All of the other registers read are read-only
- The name of the function doesn't match: the autonomous selection is 
not really
related to perf. capabilities

I assume this change comes from the presence of the auto_sel register in the
'struct cppc_perf_caps', but IMO this register should be placed in 
another structure.

I assume this is ok to let it in 'struct cppc_perf_caps' for now, but I 
think we should not
fetch the value with all the other perf. capabilities values.


>   	int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpunum);
>   	struct cppc_pcc_data *pcc_ss_data = NULL;
>   	int ret = 0, regs_in_pcc = 0;
> @@ -1362,11 +1362,12 @@ int cppc_get_perf_caps(int cpunum, struct cppc_perf_caps *perf_caps)
>   	low_freq_reg = &cpc_desc->cpc_regs[LOWEST_FREQ];
>   	nom_freq_reg = &cpc_desc->cpc_regs[NOMINAL_FREQ];
>   	guaranteed_reg = &cpc_desc->cpc_regs[GUARANTEED_PERF];
> +	auto_sel_reg = &cpc_desc->cpc_regs[AUTO_SEL_ENABLE];
>   
>   	/* Are any of the regs PCC ?*/
>   	if (CPC_IN_PCC(highest_reg) || CPC_IN_PCC(lowest_reg) ||
>   		CPC_IN_PCC(lowest_non_linear_reg) || CPC_IN_PCC(nominal_reg) ||
> -		CPC_IN_PCC(low_freq_reg) || CPC_IN_PCC(nom_freq_reg)) {
> +		CPC_IN_PCC(low_freq_reg) || CPC_IN_PCC(nom_freq_reg) || CPC_IN_PCC(auto_sel_reg)) {
>   		if (pcc_ss_id < 0) {
>   			pr_debug("Invalid pcc_ss_id\n");
>   			return -ENODEV;
> @@ -1414,6 +1415,9 @@ int cppc_get_perf_caps(int cpunum, struct cppc_perf_caps *perf_caps)
>   	perf_caps->lowest_freq = low_f;
>   	perf_caps->nominal_freq = nom_f;
>   
> +	if (CPC_SUPPORTED(auto_sel_reg))
> +		cpc_read(cpunum, auto_sel_reg, &auto_sel);
> +	perf_caps->auto_sel = (bool)auto_sel;
>   
>   out_err:
>   	if (regs_in_pcc)
> @@ -1555,6 +1559,8 @@ int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool enable)
>   	struct cpc_register_resource *auto_sel_reg;
>   	struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpu);
>   	struct cppc_pcc_data *pcc_ss_data = NULL;
> +	bool autosel_support_in_ffh_or_sysmem;
> +	bool epp_support_in_ffh_or_sysmem;
>   	int ret;
>   
>   	if (!cpc_desc) {
> @@ -1565,6 +1571,11 @@ int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool enable)
>   	auto_sel_reg = &cpc_desc->cpc_regs[AUTO_SEL_ENABLE];
>   	epp_set_reg = &cpc_desc->cpc_regs[ENERGY_PERF];
>   
> +	epp_support_in_ffh_or_sysmem = CPC_SUPPORTED(epp_set_reg) &&
> +				(CPC_IN_FFH(epp_set_reg) || CPC_IN_SYSTEM_MEMORY(epp_set_reg));
> +	autosel_support_in_ffh_or_sysmem = CPC_SUPPORTED(auto_sel_reg) &&
> +				(CPC_IN_FFH(auto_sel_reg) || CPC_IN_SYSTEM_MEMORY(auto_sel_reg));
> +
>   	if (CPC_IN_PCC(epp_set_reg) || CPC_IN_PCC(auto_sel_reg)) {
>   		if (pcc_ss_id < 0) {
>   			pr_debug("Invalid pcc_ss_id forCPU:%d\n", cpu);
> @@ -1589,14 +1600,29 @@ int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool enable)
>   		/* after writing CPC, transfer the ownership of PCC to platform */
>   		ret = send_pcc_cmd(pcc_ss_id, CMD_WRITE);
>   		up_write(&pcc_ss_data->pcc_lock);
> -	} else if (osc_cpc_flexible_adr_space_confirmed &&
> -		   CPC_SUPPORTED(epp_set_reg) && CPC_IN_FFH(epp_set_reg)) {
> -		ret = cpc_write(cpu, epp_set_reg, perf_ctrls->energy_perf);

I think this is a bit out of the scope of this patchset, but I'm not 
sure this is necessary
to check the value of "osc_cpc_flexible_adr_space_confirmed" here. 
Indeed, acpi_cppc_processor_probe() already loops over the CPPC fields 
and should detect when a field is using an address space that is not 
allowed by "osc_cpc_flexible_adr_space_confirmed".

 From what I understand:

- osc_cpc_flexible_adr_space_confirmed was introduced to check that CPPC 
registers are in the correct address space

- this broke some amd platforms that didn't configure the _OSC method 
correctly

- 8b356e536e69 ("ACPI: CPPC: Don't require _OSC if X86_FEATURE_CPPC is 
supported") introduced cpc_supported_by_cpu() to bypass the check of 
osc_cpc_flexible_adr_space_confirmed. Indeed, the broken amd platforms 
don't configure the _OSC method, but it is possible to check if there is 
CPPC support by reading an MSR register.

- an amd platform failed to set the EPP register. This seems to be due 
to the EPP register being located in FFH and not in PCC. However the 
handler only supported PCC at that time: 7bc1fcd39901 ("ACPI: CPPC: Add 
AMD pstate energy performance preference cppc control") The bug report 
thread: bugzilla.kernel.org/show_bug.cgi?id=218686

- to allow setting the EPP value when it is located in FFH, the 
following patch was done: aaf21ac93909 ("ACPI: CPPC: Add support for 
setting EPP register in FFH") This patch seems to have added a check 
over the _OSC flexible bit value due to this comment: 
https://bugzilla.kernel.org/show_bug.cgi?id=218686#c83 However the CPPC 
registers are always allowed to be located in the FFH and PCC address 
space. Cf: 0651ab90e4ad ("ACPI: CPPC: Check _OSC for flexible address 
space")

------------

Just to summarize, I think the check over 
osc_cpc_flexible_adr_space_confirmed could/should be removed. Ideally in 
a separate patch.

If Mario could confirm this is correct this would be nice.


> +	} else if (osc_cpc_flexible_adr_space_confirmed) {
> +		if (!epp_support_in_ffh_or_sysmem && !autosel_support_in_ffh_or_sysmem) {
> +			ret = -EOPNOTSUPP;
> +		} else {
> +			if (autosel_support_in_ffh_or_sysmem) {
> +				ret = cpc_write(cpu, auto_sel_reg, enable);
> +				if (ret)
> +					return ret;
> +			}
> +
> +			if (epp_support_in_ffh_or_sysmem) {
> +				ret = cpc_write(cpu, epp_set_reg, perf_ctrls->energy_perf);
> +				if (ret)
> +					return ret;
> +			}
> +		}
>   	} else {
> -		ret = -ENOTSUPP;
> -		pr_debug("_CPC in PCC and _CPC in FFH are not supported\n");
> +		ret = -EOPNOTSUPP;
>   	}
>   
> +	if (ret == -EOPNOTSUPP)
> +		pr_debug("_CPC in PCC and _CPC in FFH are not supported\n");
> +
>   	return ret;
>   }
>   EXPORT_SYMBOL_GPL(cppc_set_epp_perf);
> diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
> index 7190afeead8b..42e37a84cac9 100644
> --- a/include/acpi/cppc_acpi.h
> +++ b/include/acpi/cppc_acpi.h
> @@ -119,7 +119,6 @@ struct cppc_perf_caps {
>   	u32 lowest_nonlinear_perf;
>   	u32 lowest_freq;
>   	u32 nominal_freq;
> -	u32 energy_perf;
>   	bool auto_sel;
>   };
>   

