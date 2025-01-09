Return-Path: <linux-acpi+bounces-10480-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1763FA07DC8
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Jan 2025 17:38:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DECC3A2913
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Jan 2025 16:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22C49224AEA;
	Thu,  9 Jan 2025 16:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="k6H6nQ9I"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2053.outbound.protection.outlook.com [40.107.236.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B2C223330;
	Thu,  9 Jan 2025 16:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736440599; cv=fail; b=FpcmHHxsy/pzVXd6SogvDs8xrDB/70d4fwz8haWvvUxtJfTQyYt2zNnPCy+dBBvgXEW2b/jz5i6sQf1QZKR/Ib8T+NQFemdU72TJ3//lwg4kmbOo9w4uCYCpEZS/TNSbre+bkvky806kV6EzlpwWs5rhli6QgxEpOHV3di2Vs+4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736440599; c=relaxed/simple;
	bh=R2jrnddJE1uzluyIJhNgGHwUp5pXdNh+qpiAuKFM5JM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=l1BQogyBvZsWq2tB+O3foVh//n7PLMpgf2W3h4lVC9M/yoNxVHqFkcmnahdiyxtpi2TFmoSJKMRxYCvt9LActdo0sp+5OVjy+2bPreSpKfyNVeVlcJETs3nHGCGQbIzKCSkHY3io6oK2RPajEmOcrmTMttaJ+5qcQ582O6+iSJA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=k6H6nQ9I; arc=fail smtp.client-ip=40.107.236.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gyp0if58tIM7rP+pD8ZWM0wPfVOa8xhsCY+OxkFL16/p/8M/DEV6OKo/R5kaOoza5rt1w1Qy1US5th3CNyMjzM6EE+YsoC19nFfHGkKXQf/qWCmFQPJUKMH8yTlsc9O64Fnv8UUfAJ5Cv2Dc64HZTu/o/wY/42TerCOjytlH3Akl6YhVG3FXjz8hGAulMbNUU0ig3b8u4Dl2g0WURjQA/YhywZnKEF3ojD95m6UabVpcUGrgPARW4j0lCxRzC7OWCA1ByXqAUN8vrlOK9PvbyzlEVDrz2QqsPO8MxJ4oUV+tRj51LH/sb7HjETxR/f40hcAYSQVcJwInBk3Q2/eSeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FMJlVLDzK2r/caZeuN5puPcMLS/OXuG+h/Y6pW9ldcE=;
 b=w31GT9L4MeLnSjDOo8AARGfrzetwfbDXCBxHStC3QwH412uSy/48Aw9y628/MkYHFZMZLAHYIOjtebkdBcjQ0HXgDZxnhxlYX6fQ+qaGnmu8oSZgVqHjCfsvzeP5iCWtteW3R1TJ9vHEe7j+NL3iFZHsz2rqg7ztYDOATNr/+g9z6a6CBpsq6ToUL8LvgbyFEQTyyKpZMsvEuXaXlcVup34m0xT80vjQlKRD50YDdGlSupSY94k3TTdrAeL9wbRvdHTJTF5PGduhaboaop6H1lownqMT9iRa4CMX9KVZJzQVegQVHbF7Okr7rsklpmOlxm4bt8IRvB3jKerDh6JZbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FMJlVLDzK2r/caZeuN5puPcMLS/OXuG+h/Y6pW9ldcE=;
 b=k6H6nQ9InnH9eJ3+2dWAlR9tKMaDwVH6CefiR6Aji4ljxaXcf88rxc/45T9e2vibTywKKBsb7bm0+MGE3Z5ybiT2+v1Q/rt1ekbPrcfMUhLzzLX/RNivzIx6AytPBIVtpj1u9HGksODyZTKHJ3FB3CqT/qrlymISJh0dSPHFjOM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by LV3PR12MB9353.namprd12.prod.outlook.com (2603:10b6:408:21b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Thu, 9 Jan
 2025 16:36:34 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8335.012; Thu, 9 Jan 2025
 16:36:34 +0000
Message-ID: <2443e939-e92b-47dd-aefc-574920050a81@amd.com>
Date: Thu, 9 Jan 2025 10:36:41 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/18] ACPI: platform_profile: Let drivers set drvdata to
 the class device
To: Kurt Borja <kuurtb@gmail.com>, platform-driver-x86@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 Armin Wolf <W_Armin@gmx.de>, Joshua Grisham <josh@joshuagrisham.com>,
 "Derek J . Clark" <derekjohn.clark@gmail.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Hans de Goede <hdegoede@redhat.com>, Maximilian Luz
 <luzmaximilian@gmail.com>, "Lee, Chun-Yi" <jlee@suse.com>,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 Corentin Chary <corentin.chary@gmail.com>, "Luke D. Jones"
 <luke@ljones.dev>, Lyndon Sanche <lsanche@lyndeno.ca>,
 Ike Panhc <ike.pan@canonical.com>,
 Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
 Mark Pearson <mpearson-lenovo@squebb.ca>,
 Colin Ian King <colin.i.king@gmail.com>,
 Alexis Belmonte <alexbelm48@gmail.com>, Ai Chao <aichao@kylinos.cn>,
 Gergo Koteles <soyer@irl.hu>, Dell.Client.Kernel@dell.com,
 ibm-acpi-devel@lists.sourceforge.net
References: <20250109150731.110799-1-kuurtb@gmail.com>
 <20250109150731.110799-5-kuurtb@gmail.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20250109150731.110799-5-kuurtb@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0104.namprd05.prod.outlook.com
 (2603:10b6:803:42::21) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|LV3PR12MB9353:EE_
X-MS-Office365-Filtering-Correlation-Id: eed479b6-5a4d-4c1d-4fd6-08dd30cbc7d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZWVYdmlmZ1lkdWkvMkNmRlVuQ2hzcWVuMW5INGE3SHZpdHVFNjFSUnJSQmVK?=
 =?utf-8?B?eUw1VjlkVCtpRklwa1BwWnlEUkpXMWNGUXgzYnFNWFB3b3FqenpRK1RDeEdw?=
 =?utf-8?B?RDB0aWRNdHdGUHRoVHdKOFA2WlpWM2Z4R2wxUWZWdWMvSy9RVm44RHhaVGo3?=
 =?utf-8?B?eDJ0UkQrOGY5MFFBbXBKTHJDUDQ0VVZvUFg1ZzROWEhRRGZMZ201Z1UvNVMy?=
 =?utf-8?B?VHFLZUwwMEZlNElWbk5ObW1EL2V1amVTUDk4RGZGd0hBWmlqVzZLemhqcnlF?=
 =?utf-8?B?VTFCQm9JQ2paSzhTdjZhUUFYem1pWHVCbkc2Z3lKaUZibHlBZnZPNTdReDFa?=
 =?utf-8?B?N2huYzJ5Wm84M2hGckF0Qjg0S3FXSFo1djlhWFZrU0gxT1dsWnlTMmF0TjAz?=
 =?utf-8?B?WkhVSVJZU1ZQMjMzMGJ4YVRQd2FhQzVGR245ZG1JMjREWG54Y2hBSjlFOEZX?=
 =?utf-8?B?cHhxK0cvU3lOTHhRRWFRcktXSnZNL25iL0NpbkhFZ2xoK2EvdGVnUENmTklw?=
 =?utf-8?B?aEY4THRJSUNsVEJuSHFZcjJ3QXRnblphVWwvVUIvNWFtWXA2TU95M090RWJt?=
 =?utf-8?B?R0QwU2xTcDkzbGRpMHpOMjlkM2ViRWE2SzRQSzlnQWJPZXJBcHRQV0hzc3Ew?=
 =?utf-8?B?TC82TS9HeUllemRQQXRrRk02SGpqU1J2Q1g2S0pmTm15MXAzOGdvbmtEbExm?=
 =?utf-8?B?WHV4T1BrMTV2WHN1RWh6RTYvMlFKaHcxM3ROMSs1NVhWRGJXSjFPVFllRUtx?=
 =?utf-8?B?VXBmR0IzR2Q2ZzBlRlJNZkp6eWQ4c1RINmZwdGpRalh4a0grRkRLQ3lwSTNV?=
 =?utf-8?B?NDVoeisxajZ5Y3U1MEJPdVhWS0wxQjcycFh2cGRmY21GTlRxd2Q4Q0g0V0hX?=
 =?utf-8?B?L25hbmNPSjZMMTBySHp3bVhUSzRwV0hoNUpOOGZhN1RvblgxVmVPR0FmL0dG?=
 =?utf-8?B?b3d1K1Vhd1grcXJNVDdnWjdtOVhvZzRoWkRNUTliZU5aQ2FpQ3NHZEw5NExW?=
 =?utf-8?B?WHlOMUthNytrUStPNWgwU001R0psVGtyNlZtZDRxWjVVTVcweURJdjRFKzE1?=
 =?utf-8?B?L3ZPbDc4eFltWUVlbktaSW0zd242N1IvTGZDbElTWVNic0NNTTc1QUp2MWYz?=
 =?utf-8?B?aERub2RsaEUvSDVoZzM4QktkWmFaTE1tclZmWmc1bmFqc2huZ3JKMDVLaHd4?=
 =?utf-8?B?cGhMVUJ5aktEdkNMeDNRUlNIZUtPaHhkdFB4SGFRL0k0VC90Y1NPQTZlOGtv?=
 =?utf-8?B?NXBkMVByVTJ2UUhPNHFyc2RuVXhSQjM4SEYwVWVTeFJpdE44RUcyeEh2dC8y?=
 =?utf-8?B?MHlJcXI4bjZNMkJHZW9MUDRKWWFTc0FKR2FUMVFVSHlkMVBMSFVjbXVUR1lB?=
 =?utf-8?B?R3R2WEZSWExtYnBsVVhSdmlqbjA5NHZEVWJjb0trdnRhS3g4UXRyWG81SXBJ?=
 =?utf-8?B?dURsWkUrbHQzUVQyK3A5cDBsa2Z6c0VLSVZVaE5VMGVVVUN0WXpYVlRtSTk2?=
 =?utf-8?B?d3ZSSGMydGc2M3FQUWYzMlFYaERIL3hieDdtQ2FyakFkK2RXTi83RTQyMm1S?=
 =?utf-8?B?WHk2R2k2aXp1V3cySHNYMWVDL0wwR1FxNm5NcVltb0FwU2tJb1I2b1VqN09D?=
 =?utf-8?B?VCttU3MwRThGQ3pmNk1ReitOa2UvdXQyYXB6ZDI3WTlKaWpUclpNd2V0aUNI?=
 =?utf-8?B?a1V5RGREc3p0S3V2bGZDN3p2dW1rdFNEK2c3YUkrUHZNWktWaS90YzA4dlFw?=
 =?utf-8?B?dGNuYlFOZ0hObHZOZUZqekI3Z0tGTWs4REpFOHlkcTZjRDREajhQWC9SbGha?=
 =?utf-8?B?Q00yYVBWMzZsQllFOTJoUE4yUmVLcUh1MWNxeTZYSTR0TWc0RHdXcWwyVzUr?=
 =?utf-8?Q?L0qSPCOe+v4o9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K21lVzZSQVljcVBOZTZ4Yk5qY3BPRzN5SzFvOGh6WEw5YU5jRTZEeWFoVmF5?=
 =?utf-8?B?c3dDMzJXdDg1WUxKekNYVEg1Yzl2bEVPNTgxNFpNcHpWRjVsSTkvUWtqTUxZ?=
 =?utf-8?B?Z2dkcFcrLzQ1Y1NISkZwQkhYeFNLZHNYTUw1NzJVTGFRUkhsbUpJQVF4a2Y2?=
 =?utf-8?B?bHJZd1dmREpJOUp1UXlTUWw5K2wyRVoyT05VSnlzWjFRTWFGVHhpWEtYYzkz?=
 =?utf-8?B?MGpDUXQvTWd1KzBHS1NYNElmd2ZXWmcvK0lXcllDTkdVa2plSEljUzgzZ2NY?=
 =?utf-8?B?K0dxN3g2VkFuWHE4WUdhOWlGaXpySmw4blI0ekZTRXNFODREM01EK3JCV05E?=
 =?utf-8?B?ZzcycGkyekp0MWJva1JDUXFkUXpVQTNFYjJTaHZCMEFFVjB1Zll6YmdxTVUx?=
 =?utf-8?B?akg5TmdtQUwxMkJiN2dQdmR6Mmx0QU03YVo2VmJna0NadzZuMmIvaEIwdkIv?=
 =?utf-8?B?enNIYlJhMzNLTGs4VlpuWnA3U1RIei9pNUF2cWNZTjVscldoUTF5b3FDRjF6?=
 =?utf-8?B?NTlONVpUZ3BUQ1psaHdFZFNOOEFwZUNnT3p2MDBXRmJzTnpISmhlZXlObzM0?=
 =?utf-8?B?UmEzTmhKZG1EUkh3RGtaUjVNNU02aE5GdXc5QWh0Q3E3WWI1Q2Y2OUMvL0ZO?=
 =?utf-8?B?K3ZYbGd2YVo2c3RxV0ZTdy9UZVdVdndYTUwwRTk0bXlvTXhHTy9qVEtIVWwr?=
 =?utf-8?B?ME1JdXlSWmJOdTBjUlBRNUpDMUh4VDUxc3RSbDVxTVhEWm0yRG56UWFMV2Nt?=
 =?utf-8?B?dG1VdjZteCtJa3JlemhrNVhYM0FvV3RCTFdjMml6TGE0d1BudTkybkozSmJn?=
 =?utf-8?B?SEY4RGFRTlExN0NSQW9oajVVckZwMGJLenhJblF1WUtIVUplUDRicloxTFdC?=
 =?utf-8?B?S2h4UExFdU9pM1NsNmxPM1J1WXZXSHg2VnFEbmFNc2U3RU8xSGZnTnlXN2hF?=
 =?utf-8?B?K3JoSElqRjZvS0wxaHVxVXl1QndTREtQSGhLbzJPQ0hvZVVpK01uelpHSi9w?=
 =?utf-8?B?VENWQmMrZjVZU2xEQjZkSXJBNzJlcVRDRlFuazdvaHI0T09wRXBRdjdIeVRo?=
 =?utf-8?B?a2Y0czV2aXI2RnlzUkdaamlWQXFzUkpod2puYzZlWlppT2xFRkgwN1pITkx6?=
 =?utf-8?B?TGIzbCtYSlBwdHhaYzdneTBSUmJFZWVvb00yRjdjUnNQRCtYbTY5QnMvRXk2?=
 =?utf-8?B?TGxIbUh6a1p3cXBPTVprdEZaeTgxWGU1RHU3bDZ2c1o5VEdScW1rMU5OeXll?=
 =?utf-8?B?dHJOcHpycFpxbks1dGhwZUd5MlhlM0FuRTdUREcwdTJURGVGa0VtM1k1S0Mv?=
 =?utf-8?B?RXdnclVSMGVpUk9WNW5JVTNnZWJwempWcDhMRTFTR3ZXaWVJMW1rMlFGTldq?=
 =?utf-8?B?YVh1aXlBMkpNcjhLbkxMOTBwdU9RVUVtRmxPTWNhMnErbTdVZ2FNYUtYOUNm?=
 =?utf-8?B?R0F6S3E1V2dnN2FxK1dUZGtSSUdqVmJwcGtOQkNQVkRtdkhQTmpVSzg5TXpI?=
 =?utf-8?B?RmZ1WjhwKzNHdkpyQzA2ZThaaXNuL2JyTUNwU0tTQ25wS3JnWElUa3pmeTJQ?=
 =?utf-8?B?ekx3RlkyZXUzenB1cDl1Y0hxV3huL1VmN01Kelhlb3FVYmFNY05CNFNIRmxG?=
 =?utf-8?B?V3FVRXJWSVRMSi9pQlFBeGFseHFzZDdIVjJBbERuRnJWZDlNVVQxUGZ6WlJP?=
 =?utf-8?B?b2xRMzNXRk0vZnpUNmVCTGRqNWgySm5wM3ZvOUNjWFYzcGJRVlYwKy9QOVlN?=
 =?utf-8?B?V1UxZFJoV1lkZDZrbmRmQk5VVVF2Yk1nYnd4Y1hpMFg0TEIzZjRibGdnanRs?=
 =?utf-8?B?RjZHTnJLTjNhanY4VTZmNE5LZU1WMWJlQ09IRzNHMEVaV0FJbVJubzg0blZD?=
 =?utf-8?B?SHkvQ2dQWVU5anVIMlByemcwdFVxWFErSGg2YVN4eEY3Tk9hYUxTMDBjQ0pD?=
 =?utf-8?B?dGFMUFlQVS9pS1ByTWYvV0hucG55bEg3VTdxSlcwbUNwNUs3bldXTzJ4aW5U?=
 =?utf-8?B?cFZUWDlid1JnVEpPaVREVUZFMkY5aHBZRTBRWG9CNStvaUNIT3cweXpSbThi?=
 =?utf-8?B?VTlVQXhjZU1CSkZqbFQyQ0xDcWJoY2xaYURJRlpCWjgxZEIrd2J5bVBRV3My?=
 =?utf-8?Q?rZPzwg1N2CulmaD9PyTKRQWjX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eed479b6-5a4d-4c1d-4fd6-08dd30cbc7d8
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2025 16:36:34.6956
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DHTiWaZkrZNeKr3tCc51virkZjCjc4Wdsosvn5HaxUxnIj1BseYvA8Mj+vvolHzM3QyymD4jebYacyGigXxrDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9353

On 1/9/2025 09:06, Kurt Borja wrote:
> Add *drvdata to platform_profile_register() signature and assign it to
> the class device.
> 
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   drivers/acpi/platform_profile.c                     | 7 ++++---
>   drivers/platform/surface/surface_platform_profile.c | 2 +-
>   drivers/platform/x86/acer-wmi.c                     | 2 +-
>   drivers/platform/x86/amd/pmf/sps.c                  | 2 +-
>   drivers/platform/x86/asus-wmi.c                     | 2 +-
>   drivers/platform/x86/dell/alienware-wmi.c           | 2 +-
>   drivers/platform/x86/dell/dell-pc.c                 | 2 +-
>   drivers/platform/x86/hp/hp-wmi.c                    | 2 +-
>   drivers/platform/x86/ideapad-laptop.c               | 2 +-
>   drivers/platform/x86/inspur_platform_profile.c      | 2 +-
>   drivers/platform/x86/thinkpad_acpi.c                | 2 +-
>   include/linux/platform_profile.h                    | 4 ++--
>   12 files changed, 16 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
> index 3cbde8dfed0b..5a867b912964 100644
> --- a/drivers/acpi/platform_profile.c
> +++ b/drivers/acpi/platform_profile.c
> @@ -461,7 +461,7 @@ int platform_profile_cycle(void)
>   }
>   EXPORT_SYMBOL_GPL(platform_profile_cycle);
>   
> -int platform_profile_register(struct platform_profile_handler *pprof)
> +int platform_profile_register(struct platform_profile_handler *pprof, void *drvdata)
>   {
>   	int err;
>   
> @@ -490,6 +490,7 @@ int platform_profile_register(struct platform_profile_handler *pprof)
>   
>   	pprof->class_dev.class = &platform_profile_class;
>   	pprof->class_dev.parent = pprof->dev;
> +	dev_set_drvdata(&pprof->class_dev, drvdata);
>   	dev_set_name(&pprof->class_dev, "platform-profile-%d", pprof->minor);
>   	err = device_register(&pprof->class_dev);
>   	if (err)
> @@ -537,7 +538,7 @@ static void devm_platform_profile_release(struct device *dev, void *res)
>   	platform_profile_remove(*pprof);
>   }
>   
> -int devm_platform_profile_register(struct platform_profile_handler *pprof)
> +int devm_platform_profile_register(struct platform_profile_handler *pprof, void *drvdata)
>   {
>   	struct platform_profile_handler **dr;
>   	int ret;
> @@ -546,7 +547,7 @@ int devm_platform_profile_register(struct platform_profile_handler *pprof)
>   	if (!dr)
>   		return -ENOMEM;
>   
> -	ret = platform_profile_register(pprof);
> +	ret = platform_profile_register(pprof, drvdata);
>   	if (ret) {
>   		devres_free(dr);
>   		return ret;
> diff --git a/drivers/platform/surface/surface_platform_profile.c b/drivers/platform/surface/surface_platform_profile.c
> index b69fcc4c3858..00a1178e552f 100644
> --- a/drivers/platform/surface/surface_platform_profile.c
> +++ b/drivers/platform/surface/surface_platform_profile.c
> @@ -234,7 +234,7 @@ static int surface_platform_profile_probe(struct ssam_device *sdev)
>   
>   	tpd->has_fan = device_property_read_bool(&sdev->dev, "has_fan");
>   
> -	return platform_profile_register(&tpd->handler);
> +	return platform_profile_register(&tpd->handler, NULL);
>   }
>   
>   static void surface_platform_profile_remove(struct ssam_device *sdev)
> diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-wmi.c
> index 1fa0cd69da8c..585d54d8d80c 100644
> --- a/drivers/platform/x86/acer-wmi.c
> +++ b/drivers/platform/x86/acer-wmi.c
> @@ -1928,7 +1928,7 @@ static int acer_platform_profile_setup(struct platform_device *device)
>   		platform_profile_handler.ops =
>   			&acer_predator_v4_platform_profile_ops;
>   
> -		err = platform_profile_register(&platform_profile_handler);
> +		err = platform_profile_register(&platform_profile_handler, NULL);
>   		if (err)
>   			return err;
>   
> diff --git a/drivers/platform/x86/amd/pmf/sps.c b/drivers/platform/x86/amd/pmf/sps.c
> index 37316bc3e071..8e75ebd25e21 100644
> --- a/drivers/platform/x86/amd/pmf/sps.c
> +++ b/drivers/platform/x86/amd/pmf/sps.c
> @@ -425,7 +425,7 @@ int amd_pmf_init_sps(struct amd_pmf_dev *dev)
>   	dev->pprof.ops = &amd_pmf_profile_ops;
>   
>   	/* Create platform_profile structure and register */
> -	err = platform_profile_register(&dev->pprof);
> +	err = platform_profile_register(&dev->pprof, NULL);
>   	if (err)
>   		dev_err(dev->dev, "Failed to register SPS support, this is most likely an SBIOS bug: %d\n",
>   			err);
> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
> index 3e94986078a6..248490571e8c 100644
> --- a/drivers/platform/x86/asus-wmi.c
> +++ b/drivers/platform/x86/asus-wmi.c
> @@ -3895,7 +3895,7 @@ static int platform_profile_setup(struct asus_wmi *asus)
>   	asus->platform_profile_handler.dev = dev;
>   	asus->platform_profile_handler.ops = &asus_wmi_platform_profile_ops;
>   
> -	err = platform_profile_register(&asus->platform_profile_handler);
> +	err = platform_profile_register(&asus->platform_profile_handler, NULL);
>   	if (err == -EEXIST) {
>   		pr_warn("%s, a platform_profile handler is already registered\n", __func__);
>   		return 0;
> diff --git a/drivers/platform/x86/dell/alienware-wmi.c b/drivers/platform/x86/dell/alienware-wmi.c
> index 386b22e9c922..a8961de004ab 100644
> --- a/drivers/platform/x86/dell/alienware-wmi.c
> +++ b/drivers/platform/x86/dell/alienware-wmi.c
> @@ -1169,7 +1169,7 @@ static int create_thermal_profile(struct platform_device *platform_device)
>   	pp_handler.dev = &platform_device->dev;
>   	pp_handler.ops = &awcc_platform_profile_ops;
>   
> -	return devm_platform_profile_register(&pp_handler);
> +	return devm_platform_profile_register(&pp_handler, NULL);
>   }
>   
>   static int __init alienware_wmi_init(void)
> diff --git a/drivers/platform/x86/dell/dell-pc.c b/drivers/platform/x86/dell/dell-pc.c
> index ba366c28d9a6..1b6e60a63491 100644
> --- a/drivers/platform/x86/dell/dell-pc.c
> +++ b/drivers/platform/x86/dell/dell-pc.c
> @@ -281,7 +281,7 @@ static int thermal_init(void)
>   	thermal_handler->ops = &dell_pc_platform_profile_ops;
>   
>   	/* Clean up if failed */
> -	ret = platform_profile_register(thermal_handler);
> +	ret = platform_profile_register(thermal_handler, NULL);
>   	if (ret)
>   		goto cleanup_thermal_handler;
>   
> diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/hp-wmi.c
> index 3c2d4549eb7f..2cf1da00d5f9 100644
> --- a/drivers/platform/x86/hp/hp-wmi.c
> +++ b/drivers/platform/x86/hp/hp-wmi.c
> @@ -1652,7 +1652,7 @@ static int thermal_profile_setup(struct platform_device *device)
>   	platform_profile_handler.name = "hp-wmi";
>   	platform_profile_handler.dev = &device->dev;
>   
> -	err = platform_profile_register(&platform_profile_handler);
> +	err = platform_profile_register(&platform_profile_handler, NULL);
>   	if (err)
>   		return err;
>   
> diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86/ideapad-laptop.c
> index f5ea03763a54..43e4d9d8d595 100644
> --- a/drivers/platform/x86/ideapad-laptop.c
> +++ b/drivers/platform/x86/ideapad-laptop.c
> @@ -1123,7 +1123,7 @@ static int ideapad_dytc_profile_init(struct ideapad_private *priv)
>   	priv->dytc->pprof.ops = &dytc_profile_ops;
>   
>   	/* Create platform_profile structure and register */
> -	err = platform_profile_register(&priv->dytc->pprof);
> +	err = platform_profile_register(&priv->dytc->pprof, NULL);
>   	if (err)
>   		goto pp_reg_failed;
>   
> diff --git a/drivers/platform/x86/inspur_platform_profile.c b/drivers/platform/x86/inspur_platform_profile.c
> index 8fa9308d4686..43cb2a927fdf 100644
> --- a/drivers/platform/x86/inspur_platform_profile.c
> +++ b/drivers/platform/x86/inspur_platform_profile.c
> @@ -196,7 +196,7 @@ static int inspur_wmi_probe(struct wmi_device *wdev, const void *context)
>   	priv->handler.dev = &wdev->dev;
>   	priv->handler.ops = &inspur_platform_profile_ops;
>   
> -	return platform_profile_register(&priv->handler);
> +	return platform_profile_register(&priv->handler, NULL);
>   }
>   
>   static void inspur_wmi_remove(struct wmi_device *wdev)
> diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
> index a35453c3c605..a72790cc5e0e 100644
> --- a/drivers/platform/x86/thinkpad_acpi.c
> +++ b/drivers/platform/x86/thinkpad_acpi.c
> @@ -10649,7 +10649,7 @@ static int tpacpi_dytc_profile_init(struct ibm_init_struct *iibm)
>   
>   	dytc_profile.dev = &tpacpi_pdev->dev;
>   	/* Create platform_profile structure and register */
> -	err = platform_profile_register(&dytc_profile);
> +	err = platform_profile_register(&dytc_profile, NULL);
>   	/*
>   	 * If for some reason platform_profiles aren't enabled
>   	 * don't quit terminally.
> diff --git a/include/linux/platform_profile.h b/include/linux/platform_profile.h
> index f549067539af..cadbd3168d84 100644
> --- a/include/linux/platform_profile.h
> +++ b/include/linux/platform_profile.h
> @@ -47,9 +47,9 @@ struct platform_profile_handler {
>   	const struct platform_profile_ops *ops;
>   };
>   
> -int platform_profile_register(struct platform_profile_handler *pprof);
> +int platform_profile_register(struct platform_profile_handler *pprof, void *drvdata);
>   int platform_profile_remove(struct platform_profile_handler *pprof);
> -int devm_platform_profile_register(struct platform_profile_handler *pprof);
> +int devm_platform_profile_register(struct platform_profile_handler *pprof, void *drvdata);
>   int platform_profile_cycle(void);
>   void platform_profile_notify(struct platform_profile_handler *pprof);
>   


