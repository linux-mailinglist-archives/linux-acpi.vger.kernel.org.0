Return-Path: <linux-acpi+bounces-11565-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5626DA48661
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Feb 2025 18:17:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73798165991
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Feb 2025 17:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA7441D935C;
	Thu, 27 Feb 2025 17:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="H8LL3Q4Z"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2053.outbound.protection.outlook.com [40.107.236.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC04D1D4335;
	Thu, 27 Feb 2025 17:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740676249; cv=fail; b=C9B/fDdK80Yc/fjdlGoVpkGn6bEyFFtAIB0qfv45HC4Wj0ClTu0gHdEAiRg/pIs5QBDF9aJ0+EcgJi1GK9RLiMWxbQDRwWOSImr3xvLhMFiMV5zPtxV6du2pGghqod+OvYbHlCeawbCnmV5EzIYXEYR2E85h9m/gOqMUNwX/42U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740676249; c=relaxed/simple;
	bh=yjzxyaoAF29z6eR5EVq5CQdIquFnCujJqwkRRvWhDIQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ab9/DqJt1dNZfd6XDC8KxAkWL7wWmgjmQrJvTi9MRh8QrpHQBdmM8i4ue3/QTwZyWx1WLbk7Yov2w227lNap1ZtHmNpVRE0xIceapJHV+NeVfIVt4nGiARrf+MMfmv++/k+TklcoDiVhK5XmmCki+L/91bhkxKLYe4WzzrTy9uo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=H8LL3Q4Z; arc=fail smtp.client-ip=40.107.236.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FuZqYr5a2nsh743TLlTYDV7Ja3YZDFCo3kAkrIdx7I0u3WK41yJ+9VPCtXqpyenqYIZ7SFPSAnfw91uCmkYul3yBrucAwVT/uOpMLcUmW+vX4OPF9IgwiGj92kI4L7CveFUf0nGs83MUUDUd2f67coIwkQM9wbLT9WXQXPWaFabWIVLXg89akrGeR7sQFLzs3p53IHzo3Tu1hyModM8Wito5yw1XkcBTP+MI2EMVOp6wlmXy1OW5P7Ri8YAHmP3H9jFLu2RekWwAMD3s8qhnOLi1tWrrJGONGICToHGTWc0l1MICtWlpXuUDlls0bAgPoR1/yZ5GYLMiQ8cQ803NWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=74+fIwvrBGzIpEXJkUNsPjUlO3/l6pmY5qnJ8E4RzaE=;
 b=uHxauqW27lytWfK0q/K1VDXYe9I4iveGWyZ+jLNQ0YIS5FFAtMKVuLhAAhYaWByfxZkjPzqowcbrDSsO3xgTzZEfuptT7JIuljFwmWawUaeoVmzubvOPswCC/wLhPAUWzFb/MKVoDf7sqm9Ul6WrIHqPiV45QoJ6jWt9BJjqmwHEL8YgZiceHcUaGEaFCX/H+vnb/d/jGSOB5EN3YqpiWkwn2OnkzvR5hQUy4aVnzF4gfI92heIM6aiIKzIfRK2ULE+gVAjubYxqEluFa318wsntiAwPJuEPIvN20ZDepoqUGyOs3kDnbwpglaXNHUBqDAjm/pWfrY85NXZOrVqJrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=74+fIwvrBGzIpEXJkUNsPjUlO3/l6pmY5qnJ8E4RzaE=;
 b=H8LL3Q4ZJpZOaMPAqEbYjsj57F4TH05NbLQvXbf51nQQ4/pk9WsH4pwKUI1T2rErrOtY4ZkqlwS3PbBPsXdxyujwib1lYA/411Q3A9uZKtCxXQbUr19NLT0v+cX4QdY14O6Ww5XIpnudcIEJ3wfd2fZ7Yg+e24P2CBXH2we43Rw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by IA0PR12MB8375.namprd12.prod.outlook.com (2603:10b6:208:3dd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.19; Thu, 27 Feb
 2025 17:10:45 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8489.018; Thu, 27 Feb 2025
 17:10:45 +0000
Message-ID: <1ba0c88f-e0dc-4b9b-9ea2-47a6295910ce@amd.com>
Date: Thu, 27 Feb 2025 11:10:43 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] ACPI: platform_profile: make amd-pmf a secondary
 handler
To: Antheas Kapenekakis <lkml@antheas.dev>
Cc: mpearson-lenovo@squebb.ca, ilpo.jarvinen@linux.intel.com,
 lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 platform-driver-x86@vger.kernel.org, rafael@kernel.org, hdegoede@redhat.com,
 me@kylegospodneti.ch, luke@ljones.dev
References: <20250227153603.131046-1-lkml@antheas.dev>
 <20250227153603.131046-3-lkml@antheas.dev>
 <26c21df0-c885-4948-8902-685dcb7f13b8@amd.com>
 <CAGwozwG8wqGCmVxK_dxGxWmqMofUGaThjiG9SaBEKWZ-EokjVQ@mail.gmail.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CAGwozwG8wqGCmVxK_dxGxWmqMofUGaThjiG9SaBEKWZ-EokjVQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0154.namprd13.prod.outlook.com
 (2603:10b6:806:28::9) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|IA0PR12MB8375:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f56b331-3364-420b-e58c-08dd5751ac66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Vy8vSE5nZ2pjU3hNUEdzWHVDZVFZNUNoR3EvTm5yZGcrNUIzUmVpSzhTT1lk?=
 =?utf-8?B?enF2K3pLMkRGbjRsYXJHdnpCWkxOS3pxWFJpcjY1R3ZRa1RlZHhGL3ZWeEdw?=
 =?utf-8?B?Ymc0MzhrL2ozYlJkWWRxQldRZ0RkZ0NKa202YTRhSnZCM3cya2gwK25CYTIz?=
 =?utf-8?B?dVMySURXbGUvQWEzeU9tQXp2N05NcE9MMTBNYzF5NmFRQVp1eXVRYUh6MGVY?=
 =?utf-8?B?NkZ3L28xQU1wQ1lrQTJ3SXJ5VVNrbW56THRzNzVPanMycjJ1bGYzdHBWU3pG?=
 =?utf-8?B?RGpuNUVxNElCUVE3Z0EycWtJOE5UMXZGK05TYXdDREpodkFQbWhoeDM3STJS?=
 =?utf-8?B?ekdaVWVJVEt4aEp6QnpvZ0s2ZXQyd0pUZmlwRVNjckNpbG5hVmNrZmk5UXVw?=
 =?utf-8?B?dFp2Snczd1RTdUg0RTRyKzdPbHdFcGNiYWk1TExpZnY0STJwc3ZsY3JlQ2FD?=
 =?utf-8?B?Y0FjNW5ENjVlWDNPajZNN3lZVmlzQ1ZQZS9wSjg3em9FVzZOa2tkb0JqRUJ3?=
 =?utf-8?B?UFlhVEdzTHdmNFRpRnVJL1UxcXBncFhrUENtLy9xQi9JcGoycGh3T3l5ZUhG?=
 =?utf-8?B?d0FXcEx5TVRiQmJlMENXOUZBTGdMdkhERmQrNTJ0QUNPQ2kyRUlLbnM0KzNL?=
 =?utf-8?B?UDhnUHQxNno4UktmeklBempjd1FqaENwZHpjWjAvMmVpblhwakViTFpiakdj?=
 =?utf-8?B?M2d3bkhjNmN4QnprNWFyYjRBQ3E5UDF1WkpTL0VGWWFGanE2L0RhalJJUjA5?=
 =?utf-8?B?cVczUy9zNStDTU5jM25sMGhRVm4vZkpzVGxRVzAzTG9PdENXY25sZHVvMTFF?=
 =?utf-8?B?Z2loWDZBRG4wTm9DTDNlR2p0ZGxOM2c0bTdEVmMrTzZhRmplRlBiVENhcDM1?=
 =?utf-8?B?RmVyZS9NN3lSYjFjd29KcTJWREJ5WFBtK1J1MUR2cHZBSWZPR3NkVmtaQldG?=
 =?utf-8?B?MXl0NlFDdmJOdHhhcXpER3VnOXhrSWZtdGZsMHM4YWtFUmlIZkYvN2ozZVky?=
 =?utf-8?B?NnQ1UEQ0ZXRvZjJ2d3NDdloreklUeGJ2L1ZYZnU1OHdaRXdoQ0dNc1RqMmdo?=
 =?utf-8?B?Tk16V01RYnd5Rm0xejViU1FwV0ZMUkEzOWwzTWg0ZmxmalJZRFpLemU3YkVV?=
 =?utf-8?B?RWE0Y3BYZCtxeFRKM1JtVFlyeDJjcGJzWHFKZ3Y4Y2VsWERubWpYcU16MGUz?=
 =?utf-8?B?QVpwQ1VBVzI5Rnl4c01jVWZocTdpQ0c0RkRCWXVZQ0NqVEdHOHVPdlNaMWVM?=
 =?utf-8?B?VWZna0lLeEdtMUxHcUUwcEh4dks0M2NGSWM4WXhVTEtlNzdCb1Y5V1k1VFgr?=
 =?utf-8?B?R3VhQVJpTjhQeXF0Y3V0ejNLZmloeUNJRVZ1QWZKUVF6a1pqb3BRbDVQclly?=
 =?utf-8?B?bTBnMkl4b2ZoWTZoemQxZnlMQTltTWtFbUVsUEhqcm9ReHpubGtUaDRkOXVK?=
 =?utf-8?B?WFlHWmhGMGgvRllTYWhTVmJBZkZtWGpnQ2h0aFFqR3ZpZnFvNzVHTWlmZE5Y?=
 =?utf-8?B?MDNPdis1K3dkTm93QjM3TEo5SXBkWDdKSDlzVnlPTWRMVkV2N1lMa3RzQzdP?=
 =?utf-8?B?QXZtUHRaT0grREhRMGFVMzZCWlFSSEJkc0tnQ3pnSlN0RzNGVHdQSHdoK1Iw?=
 =?utf-8?B?MmJ1aGxZUWJ1SVBWNmdrOStqcUtrUm5oNFpnOWFrTEpCemd5U0tOK3d6ZHMv?=
 =?utf-8?B?MGdLbXp4Z2VIeENHQjRlSGZFNjh6bXB6UHBJdzlDSXNUZWlJNzhRMXdUZGpL?=
 =?utf-8?B?RDJyNUpzUmNTdWZhaURtaEpCSS96Z1R1dUFKOFZHZEQydTNKU3lKanBGQWo3?=
 =?utf-8?B?ZVoySUR3b25aTmlDT3NBUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K1lUZUM3MW56cFRyc1F5T09PaWNFMmE5R3VMMGtEWXdJVllrdEVVbExOa1Fk?=
 =?utf-8?B?cEVNcFJ2SkIrWGV3U1FXcytMSmxYQnFRTVplcG10RlVtT01VUHk5Vys1VWQv?=
 =?utf-8?B?VC9ETC91c1J4WE9QQzdHOXJRcWhIN2hnUkh2dXV2YklmYVNLQ2trTnZzZ0Zo?=
 =?utf-8?B?T3RGT0lSejM3QUVPcE5LOHBxbWZmd2hLeStNYXFMZVFJQzd1ZklKNXN5Vkpv?=
 =?utf-8?B?RTE2bk1PQnVScEpsUllBd3hlSmVvanQyTHd5UXUwQ0JUbVNCTWNtZmc0cVFY?=
 =?utf-8?B?eURHYzEyOXFLVnNWdmJIVi81ait1ZEQvZTBEeDV1N3NQeWJSbllJZTVUQ3I4?=
 =?utf-8?B?YnZyUnJSTGFXMUVqc0xQd0FqcEJmOFRHMjlzbldqeGpTTE9LUnR4Z3ZzWDhR?=
 =?utf-8?B?a1h6RldKNUxMaHdoRUQzRDJ4NVBGN1gzU0VLTmhac1ppcy9FRWtpUzJWSGhz?=
 =?utf-8?B?Ym1KZk8zcjJuWjlFS21mQkc5UmxHNUFMNGdQQUpFeHQvcHZkOFhXZWxDcHFJ?=
 =?utf-8?B?YzRja09KQXB3Z1lFb1JaOUZUemptcCsxMEVIRmhFS1I3NXJLYmpHdVNYNWVL?=
 =?utf-8?B?Z3RqSGo2ZDNLZzFBNENhTmVwTmFNVWtnc3FsTGNvTERDTjFPc1hGTkNueFND?=
 =?utf-8?B?dFJXdUVVVWhoR3BXWnJhK1lXdkNKaWtOS2xVQ3dUTFRhNlBHTlR0dWF2c3F2?=
 =?utf-8?B?MExKSXBuUmJYTGtXMURCTWR3ZHZKTGc1WTdqT2VZQVJtVU4vZ2QxY0lxOVJM?=
 =?utf-8?B?VDQ4anhjYm05R3lBbUhFR1ZZSnRHV3pNdnpTVkNQQWk2dXlXM2N0ODBTdVR6?=
 =?utf-8?B?ei9xOXUveEVJUGdRVkhrd09MZGYvaVBWUDQvRmw5d1gxM1FHdStOTjVHTzBn?=
 =?utf-8?B?SXl3Vk9Pc1Y1T2pkUmpHckVFVytBSFZwMysydXpiSmlqb2hHd1FPcHQ0NG1s?=
 =?utf-8?B?V3RWNmNZVVBBbFlKNDJ2aDFxc1JOakZUV1AvK2s5emZ3amtrb3lmdDBIUFNk?=
 =?utf-8?B?bEVZekg1dnNkVy9kdW1HWEpvTjZLSWdiNzE3cFFXclNyOVBjWmhoTnpXVTB6?=
 =?utf-8?B?Y01QUTJwb3ovWW9EN05Fem15Q3g2bHZPb3Y4bGpGK01kcCtLbDR6U0J2L2k4?=
 =?utf-8?B?VG82Z003UHlyR3dVRG9wU2xPWEsrblNXR0l0LzNTZXNzV0RPMWp3NlY0OExY?=
 =?utf-8?B?aGhNTHhLT1VmMmtNNksyOGxFd3pBNkZwVlZXOSs4NXdDaWNFYlV2RDg5emx5?=
 =?utf-8?B?b1FjRFlHYk1BbzV5TDBXY2pUUFdzY3ZQcWt0OUNSWjdXR1JOKzZmMjRFV1g3?=
 =?utf-8?B?dDdqR0QxU2dGWVptL29lSkdjNmxZN0lZTEV2ZS9lN21CaHo3cWNYYlFjZEtm?=
 =?utf-8?B?OHAxYzBVNTZSSitsTUx4NkV6OGZhb3VyS3hlL2V6MTNrK1FTYVViMEVaNE5o?=
 =?utf-8?B?VVd3UFZwR1VyN1BmTzZwSktwVmlxTVQwQ3BHQXMveGFrbEJhcmtPK0RWZlBj?=
 =?utf-8?B?czVGQk1RemczNEZIcjl6WHNBbU12a2lXR2xjZmYzbmE5ejlsUVZlWjIwUFdU?=
 =?utf-8?B?RDJDT0ZFbHdUSkh3aThPamNEcTR2MFd0eDRwZ3pnYkpqU0NVTWU5S3Q3b0NG?=
 =?utf-8?B?MFJPUzdOMVJUVjVpbVA5d3RmT081bE9ZKzRha0k2MUFxS2hjMFhkZzgzd2VY?=
 =?utf-8?B?eVhKVkhrcTZCNUZEUlEyai8xZUxRTHZhWlVzeStMUDdNcWF0R09zYy9EdXRP?=
 =?utf-8?B?OHFKanI3djJ1OTVDdFZ1NHpRSHFXU2tveGYrbTBweTFnUlJ2dFZCb0ZtTk14?=
 =?utf-8?B?VlNadWtheDlYaUJOdlEvVmEyajU4NUkvRXRyN3R6RS9XWHJreExocjhBWDlU?=
 =?utf-8?B?OGZiV0VVcjMvV1Uyd0N2c0F5Mm9NbXdhWDBvK0pjMWVvSFhkNFA3NExleTZM?=
 =?utf-8?B?U1UvS21xdkhsOXZxR0NJaDYrQWJJckp0TW1sUXRWMGlXY3JzcWQ3R3E1bWFJ?=
 =?utf-8?B?dUhDajVqMUR3ck1JZXMveE56UHgzcVRpTktxendLR3dlZDVVaUlDalJtekZR?=
 =?utf-8?B?diswYmFuWFUwUFZrUW1VLzU2ZXVrd2FlbjViTmtUWVhhMlNtbWtPelE3b1ZI?=
 =?utf-8?Q?BSAiegtSp6b5/QGUOvlPyqmek?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f56b331-3364-420b-e58c-08dd5751ac66
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 17:10:45.4772
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OhRADfXGxAXO/3iJnapnxrP5O8T6RtgQkYCvvLy2wP/qbTcMW0GKKZr+X4TQiSC+X2VK7oWNmLWInyMFswr4AA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8375

On 2/27/2025 11:04, Antheas Kapenekakis wrote:
> On Thu, 27 Feb 2025 at 17:46, Mario Limonciello
> <mario.limonciello@amd.com> wrote:
>>
>> On 2/27/2025 09:36, Antheas Kapenekakis wrote:
>>> Since amd-pmf is expected to run alongside other platform handlers, it
>>> should be able to accept all platform profiles. Therefore, mark it as
>>> secondary and in the case of a custom profile, make it NOOP without an
>>> error to allow primary handlers to receive a custom profile.
>>> The sysfs endpoint will still report custom, after all.
>>>
>>> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
>>> ---
>>>    drivers/platform/x86/amd/pmf/spc.c | 3 +++
>>>    drivers/platform/x86/amd/pmf/sps.c | 8 ++++++++
>>>    2 files changed, 11 insertions(+)
>>>
>>> diff --git a/drivers/platform/x86/amd/pmf/spc.c b/drivers/platform/x86/amd/pmf/spc.c
>>> index f34f3130c330..99c48378f943 100644
>>> --- a/drivers/platform/x86/amd/pmf/spc.c
>>> +++ b/drivers/platform/x86/amd/pmf/spc.c
>>> @@ -219,12 +219,15 @@ static int amd_pmf_get_slider_info(struct amd_pmf_dev *dev, struct ta_pmf_enact_
>>>
>>>        switch (dev->current_profile) {
>>>        case PLATFORM_PROFILE_PERFORMANCE:
>>> +     case PLATFORM_PROFILE_BALANCED_PERFORMANCE:
>>>                val = TA_BEST_PERFORMANCE;
>>>                break;
>>>        case PLATFORM_PROFILE_BALANCED:
>>>                val = TA_BETTER_PERFORMANCE;
>>>                break;
>>>        case PLATFORM_PROFILE_LOW_POWER:
>>> +     case PLATFORM_PROFILE_COOL:
>>> +     case PLATFORM_PROFILE_QUIET:
>>>                val = TA_BEST_BATTERY;
>>
>> I would really prefer we do the absolute bare minimum to help this issue
>> on ASUS (just special case quiet) and leave adding compat for other
>> profiles for other development.
> 
> I cannot risk other drivers having their options disabled. This can
> have carry-on effects in other drivers too.
> 
> Including in the legion v3 driver, in which you will end up disabling
> balanced-performance. Since Derek posted the v3 for that today.
> 

Sure - but let's handle that separately from this bug fix.  That driver 
will be targeted to 6.15 or later.

We need to be cognizant about what can go into 6.14 needs to be bug 
fixes for drivers in tree.

>> The reason for this is that if you look at power_modes_v2 there are
>> actually 4 'possible' modes for v2 platforms.  So there is a bit of
>> nuance involved and it's really not a 'bug fix' anymore by doing so much
>> at once.
>>
>>>                break;
>>>        default:
>>> diff --git a/drivers/platform/x86/amd/pmf/sps.c b/drivers/platform/x86/amd/pmf/sps.c
>>> index e6cf0b22dac3..a2a8511768ce 100644
>>> --- a/drivers/platform/x86/amd/pmf/sps.c
>>> +++ b/drivers/platform/x86/amd/pmf/sps.c
>>> @@ -297,12 +297,15 @@ int amd_pmf_get_pprof_modes(struct amd_pmf_dev *pmf)
>>>
>>>        switch (pmf->current_profile) {
>>>        case PLATFORM_PROFILE_PERFORMANCE:
>>> +     case PLATFORM_PROFILE_BALANCED_PERFORMANCE:
>>>                mode = POWER_MODE_PERFORMANCE;
>>>                break;
>>>        case PLATFORM_PROFILE_BALANCED:
>>>                mode = POWER_MODE_BALANCED_POWER;
>>>                break;
>>>        case PLATFORM_PROFILE_LOW_POWER:
>>> +     case PLATFORM_PROFILE_COOL:
>>> +     case PLATFORM_PROFILE_QUIET:
>>>                mode = POWER_MODE_POWER_SAVER;
>>>                break;
>>>        default:
>>> @@ -369,6 +372,10 @@ static int amd_pmf_profile_set(struct device *dev,
>>>        struct amd_pmf_dev *pmf = dev_get_drvdata(dev);
>>>        int ret = 0;
>>>
>>> +     /* If the profile is custom, bail without an error. */
>>> +     if (profile == PLATFORM_PROFILE_CUSTOM)
>>> +             return 0;
>>> +
>>
>> The legacy interface doesn't support writing custom.
>>
>> https://github.com/torvalds/linux/blob/v6.14-rc3/drivers/acpi/platform_profile.c#L382
>>
>> IoW this is dead code.
> 
> Noted.
> 
>>>        pmf->current_profile = profile;
>>>
>>>        /* Notify EC about the slider position change */
>>> @@ -400,6 +407,7 @@ static const struct platform_profile_ops amd_pmf_profile_ops = {
>>>        .probe = amd_pmf_profile_probe,
>>>        .profile_get = amd_pmf_profile_get,
>>>        .profile_set = amd_pmf_profile_set,
>>> +     .secondary = true,
>>
>> I really don't understand the need for declaring primary / secondary.
>> It really doesn't matter which driver can do it.  This same problem
>> could happen in any direction.
> 
> No. amd-pmf is responsible here. That's why you made the multiple
> platform profile series after all. Other WMI drivers never load
> together. To maintain existing compatibility, those drivers need to
> still show the same options under the legacy endpoint.

My point is mostly hypothetical right now because the realistic 
combinations right now are amd-pmf + other driver.

> 
>> As a different suggestion; how about a new "generic" callback for
>> 'compatibility' profiles?
>>
>> Right now the .probe() callback amd_pmf_get_pprof_modes() will set bits
>> for visible profiles.
>>
>> How about an optional .compat_profiles() for the hidden one(s)?  This
>> would allow any driver to implement them.
> 
> amd-pmf cannot obscure any settings of the primary platform, so even
> in this case it ends up implementing all of them, and compat profiles
> becomes equivalent to .secondary with more steps (incl. a probe).
> 
>>>    };
>>>
>>>    int amd_pmf_init_sps(struct amd_pmf_dev *dev)
>>


