Return-Path: <linux-acpi+bounces-20613-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KErcOExOd2n0dwEAu9opvQ
	(envelope-from <linux-acpi+bounces-20613-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Jan 2026 12:21:48 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8484B87966
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Jan 2026 12:21:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DE5713004F17
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Jan 2026 11:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB8AE33290D;
	Mon, 26 Jan 2026 11:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="iUE+6cnu";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="iUE+6cnu"
X-Original-To: linux-acpi@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011000.outbound.protection.outlook.com [52.101.70.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE5D25771;
	Mon, 26 Jan 2026 11:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.0
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769426506; cv=fail; b=l7EIBUWxgBvMrdzKV+ybRHfVtR2katIp1hDOz1bkZlABHlkzCf2jFVU/RfH2GcyoLrlvGpTjgBEHjy+8KYu9/YEsjBHYR98u4c5bABc4+0RcJFLtK26EWLmoZxDk1pBlebkYNp2fTV83McL3uHPuTaqylPGV27pijPqK8jbsDRo=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769426506; c=relaxed/simple;
	bh=q54UaipgcT/Frc6yIoRzgr8KQGkI7gCBLACK9ssoZJk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=r9vhU4dG4OH+V+k77CCFxEZGLl+isNAWpWNMWLAgkJh07mLODjkPCuo3g/JuFpHal+ZCkdSl+I63ovSjwDhu0PRIwXq7P6kRvbjHdJn3cxyDecwixij11TKngpFEuOxUEhKf75KyM4ogntVFgJmXQbEkWt6fBD9qet/cdKhm9hQ=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=iUE+6cnu; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=iUE+6cnu; arc=fail smtp.client-ip=52.101.70.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=YuZlGkv96SCBe4WKlgvk3ogBPt1xz2GbDYSUJT7p19tnYC0pFAQIbBKDK6z2F9cKZ5UjHZLddGrPA9y6hPGPFpbPOEv0s998kB7gPSZJEQk1blQP7GF51bIifv5ZV47m23FtlMwBQVbU+WeECokWms+AaZQCGumWW7kQ/l0DyHo19CWxkr6+H4dct+GExeapfLCLSSgjmNlI0J0xoDUv7oxfnlk4s5d1us+ITK0++62kmSSAWbne4kMm6nhbHdrsx3dOYo3diEo1MVkcp8BDDUAbAvF1lgbWa7FKkAjOYlY3Yf43SkitllrO/ekusMML1OOngVWNV4kPaNlV6Q29dw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P1II9FUhbPd8gRnvAYs5mReHJdp8n+3xAt6f/XivhhI=;
 b=XpCi4f/IkLwdfxtRLcdK+OnsEehnxifzlXzkotAYq9/vG0IkbnZbmsXiOLIZQbNgXBjM9dTRXqxw3kYAit4OGfuM6A2F6LA2o3rAd5YaoMK3HEJd+oC1LP0cKgy21xtCL6wTGuxquvBoqr+CoJMWJfR+3iL1LdvSpmAcmaH3YBbnO/KuHserRo/OSfWkggHCELqi/hL6cFBimf+GtrVxc5qPEi/n37S19mMAmIkp2rU+LdjiikYSyoc+X2LAN8VSYuVC7do7hHuNg+aXyRd+TIr0ELSJm1GsuaELN6Mh1Kkf7PuwmExx+8VIjZFzX0NCIw5uUCo9LF1m2tDMABE/WA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=nvidia.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=timeout (key
 query timeout) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P1II9FUhbPd8gRnvAYs5mReHJdp8n+3xAt6f/XivhhI=;
 b=iUE+6cnuHyVxGU0MssG2MLOjGfUeBqo7qBpVZO18Abwc5DPPgwBAX/kONhnt86OCCRdzcEz5arZKfts75iy2umfKpHiPChvPjzj2JkREbxzfMCjb73PhMg46cjoGlhmNrEt7T5DoTXZmOsZ8n0x34Sc2y50S2ZHYEfU9M+9ala8=
Received: from DU7PR01CA0020.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50f::25) by VI0PR08MB11017.eurprd08.prod.outlook.com
 (2603:10a6:800:250::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Mon, 26 Jan
 2026 11:21:39 +0000
Received: from DB3PEPF0000885F.eurprd02.prod.outlook.com
 (2603:10a6:10:50f:cafe::a8) by DU7PR01CA0020.outlook.office365.com
 (2603:10a6:10:50f::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.16 via Frontend Transport; Mon,
 26 Jan 2026 11:22:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=timeout (key query timeout)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB3PEPF0000885F.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.3
 via Frontend Transport; Mon, 26 Jan 2026 11:21:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oqw0jueQNwQwQuDN3w8TY0HWtfMmV71iwUH6KvnvnPvq/SZK/8r/o6q/7w26n41YqIm/ycjWZbb4BcmkwMJ5USL+2je2KoQnieCX4PiFYi6/PsJPR4omVlOU/PhZl+ByQSbBtZuzG75jQM6bkj4pUyNBpHHgLx016rkxd0AxO9XiwyOVXhmPUn0sHFABpD55s1Xg2kF2Kw4cQj22vMq4yrEaawD0l1QzVQ8EUcABoqlttfJ1lZ79YovKe0UbBiAcpdsiKYBinan1OHXqkb37FDyVWBkP6MdWQbWq76WkuWcavwAe3a9l6QrRvUnXXnuSERHIDekE9CY6SsX/CX4VYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P1II9FUhbPd8gRnvAYs5mReHJdp8n+3xAt6f/XivhhI=;
 b=TX984CC6rNDxa/qWxy83RLOfi6tdSwh9SyMCktoyVS7KokyCoYWIKfemAvCwZ81/irpOTovL2fde3Zi2joFEqXHCMFb3vBRMcpHIGxdYxrTKBdOsAQC/mcDoMKnjSEgWONlHZA4k/kz730hqri+sB45Hu8DBFM2d7PKEOT+ZMG/dd8LLJh+VC9OcCwjTabWAoFTaIv57pzU11pmmDrGwgplSlgKJdNmWJYRIDZdW89FsFt+dLqrec2giUCev1hVArhNAaYMqLQg91nR7emLoF2/OF+Ulj1pQ5NtYRSJhrIgHO1al9YAjgfkcRfCaWzDHislZa/nqXJIgAvKPz+nV5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P1II9FUhbPd8gRnvAYs5mReHJdp8n+3xAt6f/XivhhI=;
 b=iUE+6cnuHyVxGU0MssG2MLOjGfUeBqo7qBpVZO18Abwc5DPPgwBAX/kONhnt86OCCRdzcEz5arZKfts75iy2umfKpHiPChvPjzj2JkREbxzfMCjb73PhMg46cjoGlhmNrEt7T5DoTXZmOsZ8n0x34Sc2y50S2ZHYEfU9M+9ala8=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com (2603:10a6:800:20c::6)
 by PAVPR08MB9329.eurprd08.prod.outlook.com (2603:10a6:102:305::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Mon, 26 Jan
 2026 11:20:34 +0000
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91]) by VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91%4]) with mapi id 15.20.9542.010; Mon, 26 Jan 2026
 11:20:34 +0000
Message-ID: <3097e4dd-a895-4c55-96c7-433ae1d046f9@arm.com>
Date: Mon, 26 Jan 2026 12:20:31 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/9] ACPI: CPPC: Add cppc_get_perf() API to read
 performance controls
To: Sumit Gupta <sumitg@nvidia.com>, "zhenglifeng (A)"
 <zhenglifeng1@huawei.com>
Cc: rafael@kernel.org, viresh.kumar@linaro.org, ionela.voinescu@arm.com,
 lenb@kernel.org, robert.moore@intel.com, corbet@lwn.net,
 rdunlap@infradead.org, ray.huang@amd.com, gautham.shenoy@amd.com,
 mario.limonciello@amd.com, perry.yuan@amd.com, zhanjie9@hisilicon.com,
 linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-doc@vger.kernel.org, acpica-devel@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
 treding@nvidia.com, jonathanh@nvidia.com, vsethi@nvidia.com,
 ksitaraman@nvidia.com, sanjayc@nvidia.com, nhartman@nvidia.com,
 bbasu@nvidia.com
References: <20260120145623.2959636-1-sumitg@nvidia.com>
 <20260120145623.2959636-5-sumitg@nvidia.com>
 <7f0b280d-9c22-46dc-a924-a85591e1034d@huawei.com>
 <fb4b68f7-ec64-4660-99a3-d288bc20ffac@nvidia.com>
 <53827af7-f3b6-4e1c-8c8d-2f57ef5be97e@nvidia.com>
Content-Language: en-US
From: Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <53827af7-f3b6-4e1c-8c8d-2f57ef5be97e@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0228.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:315::16) To VI0PR08MB10391.eurprd08.prod.outlook.com
 (2603:10a6:800:20c::6)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VI0PR08MB10391:EE_|PAVPR08MB9329:EE_|DB3PEPF0000885F:EE_|VI0PR08MB11017:EE_
X-MS-Office365-Filtering-Correlation-Id: afd53b33-dbaa-47c7-0646-08de5ccd1299
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|1800799024|366016|7416014|7053199007;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?V0VRUWpuRXk3cEw3REZCTi9NKzhMTTUwcW5UM3Z3b2V0Y1VTL0VDaDJzY0Jy?=
 =?utf-8?B?SklFd1JiVWh3dkx1eWtBZlJCRW1DQUJLK25qeStsb0dVWURPQi9UanQva3kv?=
 =?utf-8?B?SG5oYjZOelk5QVBTaEVnWVphUkJvcFBaWkgwQlp1amxmYmV3K3p2NW5GaFlI?=
 =?utf-8?B?a05lL3VTbW9UQktkV0I1NzVSNkNFY1dkOThjM3ZrSHh6QzZ4K0lKbHBoNCti?=
 =?utf-8?B?Q0NkcHVKMGtVOC9udU9KcW5QTTN5WjVxOHQ0NjF2c2xVN2g0QVBrL21JMGt3?=
 =?utf-8?B?aGRCeFQxMGZqMlVROFh1YVJjbkx0R0lEV0VVTlBvd2pNS3VQZHpoVGRaditG?=
 =?utf-8?B?aFlDM2ppeXIyM3Z1aGFRK2VWNXIwZ0RpRTR1V01MOHZQVCsxYmd4YXkybXBj?=
 =?utf-8?B?VWtoa1Y4Qzl3VmNkQjE0VVJMRitxQVhpZFlyL2VwWnBvMmUrRUlqLzhPM2JK?=
 =?utf-8?B?WTdQeTVOWWdPQkZYTVVlZ3MvbW9sWndoTlVxaDBldkxZMW9VbElrcEoyRVNS?=
 =?utf-8?B?K1FEV045VGJ3NTZBS3pZSVliR2diY1JlUFo2a3hoWjRnOFJCaS9yUWZxcUNr?=
 =?utf-8?B?RnFTQW1RYkI4WGpJQ1JmMXBaN2dCVGQxcml6VlNvanE3MzhlMS8vY28wUGdY?=
 =?utf-8?B?M212Ynk2TUhydWY2cFZIQkowRG1tOVB1d09yK0ZRWEE5YnN3QTd3OWtJcDRU?=
 =?utf-8?B?dWJoV2RwL09LL0lpd05KRUVJYitpVHRMZUdJd2Z5d200SVFxN3QrdGp4TnBY?=
 =?utf-8?B?djRFL1hTMVk2RkRtYkZpdE5JUjl1RkhpZnJRSWw2SUF4Y0lxWDlncDlrNllo?=
 =?utf-8?B?ZU5TWEMrd1hMM2FPTUdndTgwSkVrWjE5bEM4L29Fc25pZ0VJcEN5Nk9Xcm5J?=
 =?utf-8?B?QVRpRWhCbEo4a1JBNGYzbnR5WncwSUNoVXVvZjJGN0YwU2dmdDJKK1dtd29M?=
 =?utf-8?B?bHJpT1ZhL0t3eXNqMzBtbU03Q1BpODUwMlRDSHNHa2VNcXdlR2RYVjRTemlS?=
 =?utf-8?B?a216Skw3OVp2cE9LbTNCZFBJZGk0MCt1cCtCbXVtUlRNdkFzMWRIZ1UxNE5u?=
 =?utf-8?B?MHRXQXQvYjRVZmZ5czJIbEJaSG5rcUg0bWZTVVpSRzJkRCswSkQyb3lhb2tw?=
 =?utf-8?B?ajlOZldvQ09EMGVsNmphKzdYTWtIMENPdXJ4ZjVTQXMrRG5IaGhKbmFhMnFN?=
 =?utf-8?B?bHc4NzNGTVc2VTUwcFhOTktvcUdLYzVGZEI2dlRuMVlWTWJGZ2lHZU43eFVE?=
 =?utf-8?B?ZTkyaUdZTS8xaFlGbGZWVXJvTkt0bmJmb2hoL2VGYVFZSUdJMG9VdkJFQ2Vv?=
 =?utf-8?B?djJCdk00QlNrcWVLUjdlWE11c1R0WFZyak14eG85Wit1VjlYdXZ2eUlsQXFE?=
 =?utf-8?B?VlpETjR5VHJlcUVwTFlYc2h0Yks5V0ErakhmSTFPWmZhU0doRjBncmU1c0dn?=
 =?utf-8?B?ZmluREZyaVRmYkZ0SStOOUd3aTRXdWR1UjhHTmhOQjBaVTU1OVNZWG5yR0Jn?=
 =?utf-8?B?V29RTG1ueDMxV2xaU0tiRERQSjVwUElYUUt0N1JWZ04wRndFSkVYaDl3SFcv?=
 =?utf-8?B?cHJGYzdqTWZvWDZMa1B2ZG9nbWNDYThkUGtNRGx5dnVRMDVVeGltMDhXa0pT?=
 =?utf-8?B?bGRPNkE3emxzRDRBOUpvQ2tWTTRSMHlHZCtzUUV0U0xERW9hVzZBTEZ4N2NJ?=
 =?utf-8?B?VFJ3Qk1TMnR4VkdMdllvNCt3cXpGZlIxc2JiRHFGMXhwNXEvNmlUQ3dtbCt2?=
 =?utf-8?B?U3lxbENraVM4K29TZXkwTWd2bExXMlFYZEUybmxnNDZkQVVpY2ZrSWxNZnZJ?=
 =?utf-8?B?elBmbis0SWpGejNYZlBjS1JGS0Y4ZGdJR3dlNkorOXI5bUtTNWcwSUhiRVFL?=
 =?utf-8?B?d3ovbFk4dVB3ZmtIZnVKT3JSMnJLWnhvbE8zWkcvUWFYb3MyMXA5cFVHMlZl?=
 =?utf-8?B?MlBITXJzc3ZITDJxSTcrVDhJZHQxSExtenpnYUZlYzZMR2REU2cxc3N0SUM4?=
 =?utf-8?B?RWVvM3NuMllDck9oYlU2VWF6VTgrU2JDaC9nNmdja1FjUDZiWGtTamw0Mk9q?=
 =?utf-8?B?T0pBZGxZQnpRdEtYSDFSbms2ay8rUFBxZ3l5cXBYb1lMMXl4RmEyK0x0cTFD?=
 =?utf-8?Q?Pbc+ff+35zDWaqc69KyeXy+Cz?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB10391.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB9329
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB3PEPF0000885F.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	b53ae6b4-0863-4fa3-cd42-08de5cccec62
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|14060799003|35042699022|1800799024|36860700013|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aTVuSTFrTXphNzBiVnYvM0lONUoybFRCbjdWNThHMXRLT1lFNC9ITG5DaEtk?=
 =?utf-8?B?L2xid3dxTjA3ZlIzTHpxb29ldHUySWFjR053b3d0UXBDQ2NFWENPVWo4enNF?=
 =?utf-8?B?bzVqZkZKTi9VWUtVR1UrOWZoWFJxaFVkMkZzWDF2Rk11YW9yY29aUkoyRFI1?=
 =?utf-8?B?ZDIxZDB3S09ndjk1Z0Z6WDFPMFNIY3o0WjJJVkJ0bWpkMEw5akFzaWIySWQ4?=
 =?utf-8?B?TG4zdERwOU4vTXZ5Um1XSEJjbmNiZHdIeXB1QUo4UmlXeXpvUVdmUURqTnhX?=
 =?utf-8?B?SFpjTE0wWlJIOEo2MExGelo2Y0NjcE15VVIzM0ZFeEtnVzRrTTJiVTFaclpK?=
 =?utf-8?B?OXVGd2RYMTNwSWZKdDJRS2xCTm9GQ3FxT2ZKd216bjI2bEhwNTBWMjNFTXJ1?=
 =?utf-8?B?VlZlUHM5a1pPeThveGhOQlJLc05YVDh4YWt1YmE2MXZsc2E5MWFOOTZ1ZkxE?=
 =?utf-8?B?dnFhSmdaSEptck9FK29maEM1MlJyajFGV1RlRmpDa1pKQTFoWVlrcm5DdGRQ?=
 =?utf-8?B?MFkxTDIzVTU1UjgxZXNXWDRHZDgyU0VOL0tHbldyRVE4QWJoMlJIdTA0dUtK?=
 =?utf-8?B?a3hMajhqT0U2dEZKblNFNjQ1WlNiL0VUK1k1TEplZVY0cDM1MGltS05BN3NW?=
 =?utf-8?B?TVo3SmVZNWRaN0dhRXQ5Y1Y0K3NTUW5TMkNUWmx1Y282WGV3YVB1VGtUdWRs?=
 =?utf-8?B?bmtoS1dwamRrMFpsbG9FM2ZSM2NCRW0vbVNSZk5mbzZuY0RkaHZSbkVTUDdn?=
 =?utf-8?B?U0VuZ1kyNVhyRWRTdWtBTmVvMGZMTUhRR3NHUmIzODFmWm56RjJjcERQUmhM?=
 =?utf-8?B?cXlyazdTZFpYbDRSTFh3dDJ4TmZjVHdjaXNyVStXZ1QwYzJLd21aMngwU3U5?=
 =?utf-8?B?Q09TaHpLdDQyUDFTVVdtSDRyeHptWXJlb1FNVitGeVZoN3NHOW5vQUF2eWN0?=
 =?utf-8?B?Nm5pOWhPQmt3R0kwbU1Yd3Zsdm8vQlY3amQ4SjlDbG9rY1oycUx1TW1GSHB6?=
 =?utf-8?B?bkhtaXdBVm5CbkpOK2Exay93dDEwWDNIOGpCWEQza3hlSUJzQ2ZmblE0VzJi?=
 =?utf-8?B?KytYZnZrS2ZXN04wRmo3c2VlMzBMaS9tNEZST3ZpV2kxc01RSytwYm9VaTZm?=
 =?utf-8?B?VXdETXM5MDlBL25ndWJUZTZVSVp3RTlOUlQwaHdVZkJoSXJ3M2pYeFJWay91?=
 =?utf-8?B?TEpoZk1WeDkrTmlpWjhJeWtkSHkzK3VFbmhMZEFwWU5FNkNqdHRCR3R0UExO?=
 =?utf-8?B?NjdydllVK1BDZXRCWW5Ub1Z6OUdmNTY3ZWM2VVBMZlMzV2hQSXlCekhCNzFG?=
 =?utf-8?B?RGlvZDNIUDdDN3gzQ1FOZ0d6ZFVlbGxYRGtmWk9MaDg1ZXBOajNMWERaSEln?=
 =?utf-8?B?K2ZMS0lwelUyOXgvMlMxdndTMmk3VEVMYVNRZGMrRVhNSXFXcG9tTWo0dWpC?=
 =?utf-8?B?aGtaaTVVWDlxdkpVdzhDeHZTY0IwaWx0bDh4WXVTbzJ0d0hrdk1XcE5IMHp0?=
 =?utf-8?B?QXhGYmw0bCtEdXpjaXBMSXZSbFM1enNPUm1YYUF6bDZtbUc2NVQ0RWdNWFpp?=
 =?utf-8?B?NEVRcnh4V2xPVzVEaWVjTjFqLzViQ2xwSFpsZWdPV3NoZGNNWW1QeFFwZ2x1?=
 =?utf-8?B?VE14TEhBT2dDSHpzblZCZjRmK29jZkZWZEZSSkRYSGdKR3RYQnhOb2o1a0p1?=
 =?utf-8?B?NUhTbGVJV0d3cTBNdXZlSytVVnd4MVhTQjB2bk1nRGlrRlJTVktLK0lnWVpG?=
 =?utf-8?B?Y1RqSUhHcHNJNDBRWFJhSVkwWnRZQ3lZS2J2OWRkcmhyVTVhOEJ0b2RGbVpq?=
 =?utf-8?B?a090cXFUTTVocHBZdGVJaUw3bHJFeVJqZW5paS8zbC9iUG9jaW5ocEd0M3JW?=
 =?utf-8?B?ZzZ6RXBvWjg5S2pPVFkzRDVFbUlhRVJNSERyRjd2bXI3MnBwWVRtRlVibzVv?=
 =?utf-8?B?SUdOdjdoRFl2SzdFNmwzVUlwUjBiYTFwMGhwNnF5NUdsT1RvbCtoUFZ2Qkty?=
 =?utf-8?B?SlFOeU1HUGVLT1VITTY5aE5jTzIzTGJDYVlkZkd6dHlvTldQa29wQVhMc29i?=
 =?utf-8?B?NHVHTnhldU9ZSC9heEYxOXB1UzdrQzg1dk1XSHV0M25MbkhOQyt0ejdWSktO?=
 =?utf-8?B?TVdKeEkvR0Yxc012bkc0Z0w3MGNUT1l4YUZWQ0Nlc2VCb2QzcnBTQ3ZVK1Nu?=
 =?utf-8?B?NWYxcVM0dFdXclJiYkJPc1JDc1RLc3owRVRid3pMNEtNN2VQTEg3WWxrODcw?=
 =?utf-8?Q?1wEzyBQDfpClnyE8sK/DQ6isSw8fjlNSdkm3+IBglg=3D?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(14060799003)(35042699022)(1800799024)(36860700013)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 11:21:38.2141
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: afd53b33-dbaa-47c7-0646-08de5ccd1299
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB3PEPF0000885F.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB11017
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=3];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_DKIM_ALLOW(-0.20)[arm.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20613-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nvidia.com:email,arm.com:mid,arm.com:dkim];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	DKIM_TRACE(0.00)[arm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pierre.gondois@arm.com,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-acpi];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 8484B87966
X-Rspamd-Action: no action


On 1/24/26 21:19, Sumit Gupta wrote:
>
> On 25/01/26 01:35, Sumit Gupta wrote:
>>
>> On 22/01/26 14:26, zhenglifeng (A) wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> On 2026/1/20 22:56, Sumit Gupta wrote:
>>>> Add cppc_get_perf() function to read values of performance control
>>>> registers including desired_perf, min_perf, max_perf, energy_perf,
>>>> and auto_sel.
>>>>
>>>> This provides a read interface to complement the existing
>>>> cppc_set_perf() write interface for performance control registers.
>>>>
>>>> Note that auto_sel is read by cppc_get_perf() but not written by
>>>> cppc_set_perf() to avoid unintended mode changes during performance
>>>> updates. It can be updated with existing dedicated cppc_set_auto_sel()
>>>> API.
>>>>
>>>> Use cppc_get_perf() in cppc_cpufreq_get_cpu_data() to initialize
>>>> perf_ctrls with current hardware register values during cpufreq
>>>> policy initialization.
>>>>
>>>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
>>>> ---
>>>>   drivers/acpi/cppc_acpi.c       | 80 
>>>> ++++++++++++++++++++++++++++++++++
>>>>   drivers/cpufreq/cppc_cpufreq.c |  6 +++
>>>>   include/acpi/cppc_acpi.h       |  5 +++
>>>>   3 files changed, 91 insertions(+)
>>>>
>>>> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
>>>> index a09bdabaa804..de35aeb07833 100644
>>>> --- a/drivers/acpi/cppc_acpi.c
>>>> +++ b/drivers/acpi/cppc_acpi.c
>>>> @@ -1739,6 +1739,86 @@ int cppc_set_enable(int cpu, bool enable)
>>>>   }
>>>>   EXPORT_SYMBOL_GPL(cppc_set_enable);
>>>>
>>>> +/**
>>>> + * cppc_get_perf - Get a CPU's performance controls.
>>>> + * @cpu: CPU for which to get performance controls.
>>>> + * @perf_ctrls: ptr to cppc_perf_ctrls. See cppc_acpi.h
>>>> + *
>>>> + * Return: 0 for success with perf_ctrls, -ERRNO otherwise.
>>>> + */
>>>> +int cppc_get_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
>>>> +{
>>>> +     struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpu);
>>>> +     struct cpc_register_resource *desired_perf_reg,
>>>> +                                  *min_perf_reg, *max_perf_reg,
>>>> +                                  *energy_perf_reg, *auto_sel_reg;
>>>> +     u64 desired_perf = 0, min = 0, max = 0, energy_perf = 0, 
>>>> auto_sel = 0;
>>>> +     int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpu);
>>>> +     struct cppc_pcc_data *pcc_ss_data = NULL;
>>>> +     int ret = 0, regs_in_pcc = 0;
>>>> +
>>>> +     if (!cpc_desc) {
>>>> +             pr_debug("No CPC descriptor for CPU:%d\n", cpu);
>>>> +             return -ENODEV;
>>>> +     }
>>>> +
>>>> +     if (!perf_ctrls) {
>>>> +             pr_debug("Invalid perf_ctrls pointer\n");
>>>> +             return -EINVAL;
>>>> +     }
>>>> +
>>>> +     desired_perf_reg = &cpc_desc->cpc_regs[DESIRED_PERF];
>>>> +     min_perf_reg = &cpc_desc->cpc_regs[MIN_PERF];
>>>> +     max_perf_reg = &cpc_desc->cpc_regs[MAX_PERF];
>>>> +     energy_perf_reg = &cpc_desc->cpc_regs[ENERGY_PERF];
>>>> +     auto_sel_reg = &cpc_desc->cpc_regs[AUTO_SEL_ENABLE];
>>>> +
>>>> +     /* Are any of the regs PCC ?*/
>>>> +     if (CPC_IN_PCC(desired_perf_reg) || CPC_IN_PCC(min_perf_reg) ||
>>>> +         CPC_IN_PCC(max_perf_reg) || CPC_IN_PCC(energy_perf_reg) ||
>>>> +         CPC_IN_PCC(auto_sel_reg)) {
>>>> +             if (pcc_ss_id < 0) {
>>>> +                     pr_debug("Invalid pcc_ss_id for CPU:%d\n", cpu);
>>>> +                     return -ENODEV;
>>>> +             }
>>>> +             pcc_ss_data = pcc_data[pcc_ss_id];
>>>> +             regs_in_pcc = 1;
>>>> +             down_write(&pcc_ss_data->pcc_lock);
>>>> +             /* Ring doorbell once to update PCC subspace */
>>>> +             if (send_pcc_cmd(pcc_ss_id, CMD_READ) < 0) {
>>>> +                     ret = -EIO;
>>>> +                     goto out_err;
>>>> +             }
>>>> +     }
>>>> +
>>>> +     /* Read optional elements if present */
>>>> +     if (CPC_SUPPORTED(max_perf_reg))
>>>> +             cpc_read(cpu, max_perf_reg, &max);
>>>> +     perf_ctrls->max_perf = max;
>>>> +
>>>> +     if (CPC_SUPPORTED(min_perf_reg))
>>>> +             cpc_read(cpu, min_perf_reg, &min);
>>>> +     perf_ctrls->min_perf = min;
>>>> +
>>>> +     if (CPC_SUPPORTED(desired_perf_reg))
>>>> +             cpc_read(cpu, desired_perf_reg, &desired_perf);
>>>> +     perf_ctrls->desired_perf = desired_perf;
>>> desired_perf_reg is not an optional one, so it has to be supported.
>
> Please ignore my previous reply on this. Had some problem with my email
> client and both mails got mixed.
>
> The register is optional when Autonomous mode is enabled.
> Seems the comment here is already resolved with Pierre's reply.
> We discussed this during v4 [1] also.
> [1] 
> https://lore.kernel.org/lkml/ccd45c1b-2f69-4725-918f-18063f00a864@nvidia.com/
>
> Thank you,
> Sumit Gupta
>
>
As suggested at:

https://lore.kernel.org/all/5afea521-7d80-4e72-8809-77af60b0d957@arm.com/

Maybe it would be useful to add a patch checking this:


diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c

index e3796b520e473..7db74e19425e6 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -854,6 +854,12 @@ int acpi_cppc_processor_probe(struct acpi_processor 
*pr)
         }
         per_cpu(cpu_pcc_subspace_idx, pr->id) = pcc_subspace_id;

+       if (!CPC_SUPPORTED(&cpc_ptr->cpc_regs[DESIRED_PERF]) &&
+           (!osc_sb_cppc2_support_acked ||
+ !CPC_SUPPORTED(&cpc_ptr->cpc_regs[AUTO_SEL_ENABLE])))
+               pr_warn("Desired perf. register is mandatory if CPPCV2 
is not supported "
+                       "or autonomous selection is disabled.\n");
+
         /*
          * Initialize the remaining cpc_regs as unsupported.
          * Example: In case FW exposes CPPC v2, the below loop will 
initialize


