Return-Path: <linux-acpi+bounces-10479-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A7819A07DC4
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Jan 2025 17:37:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D60B188BE53
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Jan 2025 16:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53A5F2248B2;
	Thu,  9 Jan 2025 16:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mu+aDUy9"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2051.outbound.protection.outlook.com [40.107.223.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98FF92248A4;
	Thu,  9 Jan 2025 16:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736440592; cv=fail; b=GF+Fp9MmqC9oA3AGqqFjYhwe0urucflpk4S95Fb6HY/hc2S5IzamCAhKousztn2GL3pnuq8sC+KetdzGKIdZSI/yGTlpE9fyekoJkguvbqJUxJjPfnY7PBMgLKQY74nt+fKUeeSMGb69TQQHUUeeFdAvuVdxuE8Pjo1eJsJ/BN8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736440592; c=relaxed/simple;
	bh=+0ju9OUa2dZTgZmasIPQDKbqDt/ZQWB6FQVwb73H0Mw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NLJc7zr3hGWZTgrBWmgahtgMo2WBVWdhpp8Cbst/KAASWIesLBbrjjMp3pvInQYEn3K8tlMLqjiGFcL53VL1OdQQaT9m/m798v4tCrplqVBlNRmntpIeNUcmQzpk8u86bQKyzHVOqJpCRQP0X0fv/pVp9iG1wx0CBdKMXykf0iA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mu+aDUy9; arc=fail smtp.client-ip=40.107.223.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GijHJIsn1njKwfRAUb8bWSttVkYDXv1SSAtnIjeoLc6mlUOFfCTubgSWTVy15Q+vp0tBeDRAnc0ZYmO9UcaHoDEwnvCrkvwUBUidBBPqRcEDQ66QoCr7sQI7nN6la2ss6nsGlbtc6s2CMzUvJFXf5HBv04roJLmcMKFLAicxSMlcnpXRrNmTGc6TIF+vS6eTr5pvCX8o5b55rSIZ+NVaTjyoY8gdBanvpigZD6jIJxCL2G71Er1kDaM1ssVnx+3JQpCoOw73/SY91CGtAwjEU8IPmFmUIJshwOnTLqe7FoOZU6ohj6sSGgrBIMXr3o1qI1Wk+byJi1B1usIXxFwSjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kNvNXAmSi4SxTzB1FOVb00b5ySfgWX3EjChhKekSs+U=;
 b=o45QUbQYXHsJkFxj2OdhYKKRIFSDHX32jZUlSSh7Azv76p/ktZgi16kvjnAA6Rj0xJatqARozNEyYo47g3wXLe6zEPERwto4GBPTXYW9hi+DmM1IuiessHQUFgQFPy+OqMmTjoA+/lGgqYv4OA2Yai6OYAYvPwr0MQA7a05T7xSh6rCBmUmsfVTH9gOpq4R7zhJ2uHWz0DOASapbYXSwspZFz1/r52lqeuzpG+jY9MQbm9JNGb9g0LxkBlWRfUqPiRMRkMoYI5kPdEJtIxztzQOQHEjI2wxyVL20FWsGQXL273gce163GEolchLeDHLE4tQqTY8bc5EA4pobKKgVKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kNvNXAmSi4SxTzB1FOVb00b5ySfgWX3EjChhKekSs+U=;
 b=mu+aDUy9SnEHR0IYPdzPJr9EeTvZrrSthhnCMIXSRn017ewNwGVwydnzfNKROWk4OvvbcpktYAIaGUJMtjAdssITLVwofrFS4RVmGQ2sHE8LFXAhCT1MtEGGBFIhZ4irxGP+319hGqZsXO4mMdG/U/xvXkPilHt7RCAfQTPp9P8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by LV3PR12MB9353.namprd12.prod.outlook.com (2603:10b6:408:21b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Thu, 9 Jan
 2025 16:36:27 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8335.012; Thu, 9 Jan 2025
 16:36:27 +0000
Message-ID: <5907bdd7-2b91-482a-b633-71a286f0743a@amd.com>
Date: Thu, 9 Jan 2025 10:36:34 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/18] platform/surface: surface_platform_profile: Use
 devm_platform_profile_register()
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
 <20250109150731.110799-6-kuurtb@gmail.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20250109150731.110799-6-kuurtb@gmail.com>
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
X-MS-Office365-Filtering-Correlation-Id: c090fbd3-c939-476b-84d3-08dd30cbc380
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dlltQmU0NXVITGVrUzN1aHVNNk03S1RkaEZtSW15VVphMjJkak1BLzFDbUFv?=
 =?utf-8?B?eEk3OGliMllWT040TzYrVTgyZGtJQUVSemk0ZVQzRjRJNllBYktBWmJoMTFS?=
 =?utf-8?B?MmowQ3piQmhXa0ZiRElvd2ZVNGJUUXdsbGtqNUkybm1RSjJ0Ykwvd3E0RUM1?=
 =?utf-8?B?MkdrNitKbXg2SVlJWEJUdEFnVUJ4emVIL3ZmUHJVb1BzUm9NZzhYcmNJcC9z?=
 =?utf-8?B?bzduN21kcmJuMFh5eEtWN1YxMEN6ZUFuamswb2xzV2x2MEVvRVF4UlZrOWR1?=
 =?utf-8?B?amhBZEgyZnVVbjhBUGpHOEJMTUd4blFjbUdYT0xkUTVGMzVLei9xWG1EbUw0?=
 =?utf-8?B?dyt4bktDN1VRR2x2NXZjM0ZlTTA0MVdVOHpNdGkxeGRBR25sSzg0Ym9tcE9Y?=
 =?utf-8?B?YnNCSXhRWHROelZpZGRMOFdKOHFURXJLNktXcDJGVkRESVYrL2JHRnVIMXJJ?=
 =?utf-8?B?dUdnR0R0WmtEM3VSQnZ1K2xNN1JNNmNWTjUzVmxkVXdyRUJYNEJxK2h0enM4?=
 =?utf-8?B?WWJkRXR2bmpCRURoUlhZWXdRYWRjdVdHSEgwUDBScENlZUs2Ym80OUF0eGRa?=
 =?utf-8?B?cHd4Q2xRQjlFVVlyOHNPOVdNaEFnSnN6WFYrRkk1SFVVWGNSSURNRW13Qkcy?=
 =?utf-8?B?ZmhHUnkvMmVuQ0dYZHo5RWtFbmRuYzdjWkRMbFRGQ0krVlV3enhzRC9kUTRR?=
 =?utf-8?B?TTdXOVB3Z05lbzdlaE8yUFVuZ0ZJcG5sMWVoMXMyWGc5MFRlZm1RWXRUV0lU?=
 =?utf-8?B?N0diWW96Qkc3cnJEM0FjN2JzSmloY1I4TWY4ZHdhOGhGajRKNmE4bUVZazRj?=
 =?utf-8?B?YlIyV2VCYU8wSzVlMHAwUThjVGV1cWdKWWtLQlRkc1lkd2svSXVsNHhnMXBn?=
 =?utf-8?B?S2VGbkFrbyt6Nk9tYytuaENaMTAwaVlSRWlKSXlpK0d2cHdaKzdWMGtmWGVw?=
 =?utf-8?B?RG95d3NnQUVhbzV5K2RTVzh6cW5LU3pJVTV5UDJERmYrb3lra0NFdnQ2SE1S?=
 =?utf-8?B?eFhhaS9rU3VLZERMbDlKcjZOM2Qwc05aUjF5Q0VsYkVCSmhqdW9tdUg1RWhC?=
 =?utf-8?B?TEMzdm9uQjk5eXVqSWlreSsvR3gzT3hoejhONVpwNHBLSjVGbUZ1RSttOEY5?=
 =?utf-8?B?UGNTN2hLc1gvZElmREQyZVdnYVdmRVlaL2F4RmlETWJwajRVWTAxWkZjYjdK?=
 =?utf-8?B?bTFFbGdrOG4raGkxY1k3ckxtTWIwTEswLzNodHo3QXVpTm9aMEVTS2FSVHg2?=
 =?utf-8?B?bEEzYUllSVZNZEhwUEhITm01UVFsaXY2YnpiN1gvMUhaeUh6aWRHR0pDb0h6?=
 =?utf-8?B?WU5FRW9rNGRGK2FNQ29ySUl5VjBBOEJ3VnVCMTQ3ajlYa2hzY0hlU3I4U2FE?=
 =?utf-8?B?dUpzOEdJdXphRTdQb2tMWHE1Z1RwcEdIZ3ZuN0p3S2RrZVB1RmIwL05VcEJ5?=
 =?utf-8?B?N2dLSUtHbVdRSUZRb0hZbVJXNlpDSHg5My9IUG80citvTlVVZTR3RXRRbXNO?=
 =?utf-8?B?MXlyWHhGRjZOQzdZZXJ5bXN2VkN0QXpoWm90OThYQ2loS2t3SThIN0xvM1Jp?=
 =?utf-8?B?U0hmUGluejlrSjFyV2VTWmZUaTVQbU9oUVZ6STcrSVBuVUtZYWhZNm1MK3hh?=
 =?utf-8?B?b2FGRjdTb3JkSWRBM3YzSmpXS05wZGtPcFpiQ3Ixc0lmZ3Ayd2NYUFA2dGN4?=
 =?utf-8?B?NDEvajJpWm5UUFhYKzU3OXRWVUsxNE5RRUVuV0cxUWdiZUE3dFNpQk5zQ1Q2?=
 =?utf-8?B?V3BXUS9JTWRkNEdweWFDaHlONFlxRk9mZTAvcFJScjI1UmFlQlNmaHRsRVFT?=
 =?utf-8?B?RWNkcUxOUStPTVpKekcwQTI1MXNTdXo2Y0dvLzM3UzhXWTEwSzE0V0hwQWZX?=
 =?utf-8?Q?h0qAvx4+fJgpo?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OFVCczBKNitOMzk4WE80ZDIxZG1EbzlJaDYxMjNlazNsNERzQ3puQU1IZDdl?=
 =?utf-8?B?dXdXMHlkRUdJZkl2dUswWFVsNS9rY0lpNmpUbmFUWXRiV29Eeld4Z0V1dUtv?=
 =?utf-8?B?ZEkvK1VWODI0ZnRZYkhQUmVQVk5nUnJJVXNVRDVUOUJoOGVnSnEzSDNFVkIz?=
 =?utf-8?B?S1oxZVBtTXRLNmdmb2FvcG5hRFBMQnR0NG0xeDJVVWY3Q1lsM1M0Tkw5Q3pY?=
 =?utf-8?B?Unpnak5KeVhlLzJSUkJUbkVOdlNheUlDckl2NndrdS9YVWpVNzVMMjN0UDdC?=
 =?utf-8?B?MnB3UkplelJUSE16N3NlZ1JYTzczczRoR1UxdkJCbm1uOGY4dlJJNXNwSHdy?=
 =?utf-8?B?RzZqY3ZFeE81QjI2bSsxRTliUFNIb2xwMTQvRlc4dEhkSS83NDM5V2hVRHdo?=
 =?utf-8?B?UWp4bGFGNUdWdFFzdmExYXYvYVJyNFd5akNocWZPMW9FT0FaanZOeEs1M2V3?=
 =?utf-8?B?OHJsWDFUaTBQNm9lZ01mTm05Tmlrb1lBYndIamFCM1pIcG1WWFJTSmFzcTBn?=
 =?utf-8?B?YytoT2MzYzZZMm03dDNiNmJYcktNWHRvVHJBSGoxdU9TMWNrK0NLcStReFo3?=
 =?utf-8?B?ZDF0dHZCUXBtQTc3R09ZL1R5MTZLQWNRajRCUituMVZFU0RoLzA1blp6bC9z?=
 =?utf-8?B?Z3FDcURpS3lpR0xwMEtkQzlGdFZ1WWFSSjQ3TG5yTFZ5ZC8xSm5HbTREVHNL?=
 =?utf-8?B?bTY1N0xRR2VqNnlwVklOYkhTUlpFMHFQTUYwZ1VVUGZMUkhEemxpRVZPYWVU?=
 =?utf-8?B?Z0N5MGtBQ3pQK1ZwTTBaUHRPcEFWd2JCSDF5VmN5OENnVXlwNEpBRUlmQTlq?=
 =?utf-8?B?V0VqNjcxcFhXM0UvRFB6T2lldWcyUVIvdFBIc0ZnQVpWWlVVTloxU3N0SlRC?=
 =?utf-8?B?eGtieWo3R3RiWlA3RWErWExLbXArQlJyY0R0OEIyclRnODZDMk52RFpqUUly?=
 =?utf-8?B?YUtRZ0NsL0JnMlhqOUI1cmkrYU9nQWVJbVBRc3ZZczZ3THNQMU9pa2llQUlE?=
 =?utf-8?B?dVdXOGxIWHY2UG1KU1JXbGE5MVpJQkIrUGZEdGM2cE5yWnYxNkFGQVVTRVR6?=
 =?utf-8?B?d21QU2IyWkgzNkFqR3Y0M0IxdzNldTZmaUFBUG9sRXVDc2NOMVZBZGRuTVFN?=
 =?utf-8?B?QnYwZk8vc04rZW9wTlRPN2FZbWV1QUhkK2g2L292N29QYU9saTFRdDZ4MHJo?=
 =?utf-8?B?aklON0xxSldzbmFlaFVqSmE4TWFYeXQ2bVJHYjRvT25PbG90d2prcmMwMHF2?=
 =?utf-8?B?ajQreUNZclNTUlZUbTljOWZETHhacUtnNVU1WnA0UEc5OTNWdXJnclF6ZSt0?=
 =?utf-8?B?TEJPOGVtV1ZtdE5NR1JESWRaRnNydGw1SHE1SDlqbVZHMWptYUQrWUtFTFBr?=
 =?utf-8?B?QWJ2aW1TV3NCZlJSMG9jSFozL3k2NFhrMUV4OWs3R0ExVUdjVEhRYWZ2UzRy?=
 =?utf-8?B?c0JTSTYwYkpWWHBQbUcwVEZjMTBpa1U2endBV3dUd0xYYjNJdmJSSzFCUHZT?=
 =?utf-8?B?V0RKNHh4WCtWSEFBYUluMFRYVkhMZXFkSmdxR3VGY2FQZVc4NmI2cnk1T2ZB?=
 =?utf-8?B?ZlZET1UzNWM1TllWbjhjUjh5OHJaRHRsbGdOWXdPN2F1cXF5dmdnaVlOTWVS?=
 =?utf-8?B?dGpQbWFTYWNORkEyZGs4S3RQUUFPd3B2RGhPc0dlWlJZK0pLOUVTTmNHbTM2?=
 =?utf-8?B?ZmovRHVIQjJQYXplZnRlek9WZ2NwU3RWNDZ5MHdJSnZiZDBKbkdRRUVHY3dG?=
 =?utf-8?B?cURCaUpsRWR4anI4QXBHSTBuOXlEbUtOMEh6dVNYd2lvcTVRRU80QnZ1MlRr?=
 =?utf-8?B?OGpSWkJGT2NlR1UrUzE3ek5heUlZOUQ1RFdzM1V3emxJS1hianduSERJei83?=
 =?utf-8?B?eTJaQ2R6cUFyTXNsVmhSS0hLQ2w2V0lDNTJvcjFJczB6ai9Hb2FHV3Juc3dD?=
 =?utf-8?B?dFVuMDNiaW1BUlBJeTZZOGczYzNxQ1JMTzZDazJOeTREdDd3dTJHdGFlUFpU?=
 =?utf-8?B?b21LVVBHd2YwdTF6WHJDNDdrZVB1RU1SU3gvMlVuUFFFY2VGSWN6UDRiUDlX?=
 =?utf-8?B?VXhrS3dUNE9qZFZRQXVNUmlVRjNvbGVMUVV0dGw3YytwOUgwOWp0dW1GMkVO?=
 =?utf-8?Q?aLGkMh5byqhy6SgPiAoGVKsdT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c090fbd3-c939-476b-84d3-08dd30cbc380
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2025 16:36:27.4257
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: esERw888xEEH45z33evVKI30nfKV25fwKJDG6/mAZObqFxhDJWudZOeSoNdxTFBZBwb2Wcz5DIlIABtz9HAH/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9353

On 1/9/2025 09:06, Kurt Borja wrote:
> Replace platform_profile_register() with it's device managed version.
> While at it, pass ssam_platform_profile_device to the class device as
> drvdata and replace uses of container_of() with dev_get_drvdata().
> 
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   .../platform/surface/surface_platform_profile.c   | 15 +++------------
>   1 file changed, 3 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/platform/surface/surface_platform_profile.c b/drivers/platform/surface/surface_platform_profile.c
> index 00a1178e552f..efb6653ed1d5 100644
> --- a/drivers/platform/surface/surface_platform_profile.c
> +++ b/drivers/platform/surface/surface_platform_profile.c
> @@ -161,7 +161,7 @@ static int ssam_platform_profile_get(struct platform_profile_handler *pprof,
>   	enum ssam_tmp_profile tp;
>   	int status;
>   
> -	tpd = container_of(pprof, struct ssam_platform_profile_device, handler);
> +	tpd = dev_get_drvdata(&pprof->class_dev);
>   
>   	status = ssam_tmp_profile_get(tpd->sdev, &tp);
>   	if (status)
> @@ -181,7 +181,7 @@ static int ssam_platform_profile_set(struct platform_profile_handler *pprof,
>   	struct ssam_platform_profile_device *tpd;
>   	int tp;
>   
> -	tpd = container_of(pprof, struct ssam_platform_profile_device, handler);
> +	tpd = dev_get_drvdata(&pprof->class_dev);
>   
>   	tp = convert_profile_to_ssam_tmp(tpd->sdev, profile);
>   	if (tp < 0)
> @@ -234,15 +234,7 @@ static int surface_platform_profile_probe(struct ssam_device *sdev)
>   
>   	tpd->has_fan = device_property_read_bool(&sdev->dev, "has_fan");
>   
> -	return platform_profile_register(&tpd->handler, NULL);
> -}
> -
> -static void surface_platform_profile_remove(struct ssam_device *sdev)
> -{
> -	struct ssam_platform_profile_device *tpd;
> -
> -	tpd = ssam_device_get_drvdata(sdev);
> -	platform_profile_remove(&tpd->handler);
> +	return devm_platform_profile_register(&tpd->handler, tpd);
>   }
>   
>   static const struct ssam_device_id ssam_platform_profile_match[] = {
> @@ -253,7 +245,6 @@ MODULE_DEVICE_TABLE(ssam, ssam_platform_profile_match);
>   
>   static struct ssam_device_driver surface_platform_profile = {
>   	.probe = surface_platform_profile_probe,
> -	.remove = surface_platform_profile_remove,
>   	.match_table = ssam_platform_profile_match,
>   	.driver = {
>   		.name = "surface_platform_profile",


