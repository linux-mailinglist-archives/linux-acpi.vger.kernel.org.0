Return-Path: <linux-acpi+bounces-5944-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7742D8CC52A
	for <lists+linux-acpi@lfdr.de>; Wed, 22 May 2024 18:51:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0C36B22B0A
	for <lists+linux-acpi@lfdr.de>; Wed, 22 May 2024 16:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63E33142E6A;
	Wed, 22 May 2024 16:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="I9dq+d/u"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2081.outbound.protection.outlook.com [40.107.237.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4BB51422C9;
	Wed, 22 May 2024 16:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716396659; cv=fail; b=UDUyJ3mvqe7jrAsK106NwUCH44plK1tnH0RuD0QulPD9KjMQ70DxMzEcZgbSVxofwFiZoyMCOmrJ2sGSFkCr1GcUXhSu17OS+IGSeYvrzbcSlBrvOq6ivmTY7qhypDk13fsUQ7NQ/zIV0Q7+nigMoMyObl3IMUmz9PVpWRwpAsQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716396659; c=relaxed/simple;
	bh=VjUHohwTF5TZZModP09iPcOFbR4md0kwp96Fk4xs9/Y=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=l00ailkGRUtFep+/fwoMbWM6FobDDs4LMEGfICbIhtsyxtyoz9lFbVc5lDKRaFhyfaUT+TowB+bhg90fDRIIsYMECuzk6I9KMaY6ZiHpFSSYlgL2ZateiZ4IWgIvt0O+0wdaBJp0Uam8/dJ/3Zo4gDCHzSHVTPy4h//h0y5w9WU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=I9dq+d/u; arc=fail smtp.client-ip=40.107.237.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nc/TMkgEPqxZUo3oRiqpMVM/Tm2NhSev1I0pZXUPFyazU5ncFwHnfOea3I8M88jaB9Hj/KS/0iliGGmK7WXFwbc5paxiX0XmhEdQnaf6+qpiWjXrx2MeB5og0ZYkKE5SEmQu1m/RVXlC9HPIuJVkffxPgwpzpkd8CUg4hO3pfZoif8i5H6dPffgUDNDY80cSkPQBzrLxpXSKa6YBUhpLKLD75Oija4KqEpuWklTVzIWa3v8pxmx28177rbgVFD3ms5Qs/Up8xXejk2vF2KLdtLsLwcFghWTlreoqjUULU9aHlOlHatV+upjkQYAxRrNcHmZcdBk/Miu2k9kTry8yXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Du/wB/uI7vuE/5n9phP6xSM7a19akzbwSZdTxetAgMc=;
 b=AiDqtH0/C7Hyi92dxuYD2xNw5U66/lUHFsfOa/ujv4Ok6nXxP6PiGyrIymdmHNOhunlJ6yjH+sUOhuThDt+4MEsfURE3Sp7Nn189yFDLniBP5ApvlWXn0fdmfzrnhxYqqqv8UMFaZkVTGuyGp1if23oMb24ZvbE+Hv64s7j9deMzSlJo9gs5H4jbSUAXEO4fOVZ7vHVm8rj93sEmRogslOqmQQI2So5Bkhz/aM9xZf105w0f3QsVOtLxom1EQUdx+uO8HV2mGsttFq1ZJIc4pLL7o88EdMy1SQR/X7gkcx48uz6bP/eV2jvI/c4DPUtgvljA3jvdkrN0aRnUdxqrFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Du/wB/uI7vuE/5n9phP6xSM7a19akzbwSZdTxetAgMc=;
 b=I9dq+d/ufcd5J2TMl1bg681uwi+LIcKsqisdIXfl4oisqj1blyR1Pqp0Lnc+vUPXRBZBvk4AO89T4KfmqwgoJ+SEsWRTCaJQOmJLw1Yy8c8O8LoIsxrewPVglujdCk/3HmvAoH6R6wdnwE/qg0fb/37kfsvKl6xr14XNY4lSLis=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8535.namprd12.prod.outlook.com (2603:10b6:610:160::19)
 by BL3PR12MB6570.namprd12.prod.outlook.com (2603:10b6:208:38d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Wed, 22 May
 2024 16:50:55 +0000
Received: from CH3PR12MB8535.namprd12.prod.outlook.com
 ([fe80::ad89:457b:e4bd:b619]) by CH3PR12MB8535.namprd12.prod.outlook.com
 ([fe80::ad89:457b:e4bd:b619%5]) with mapi id 15.20.7587.030; Wed, 22 May 2024
 16:50:55 +0000
Message-ID: <c68e02f8-2929-4719-a507-d8115523bbd9@amd.com>
Date: Wed, 22 May 2024 11:50:53 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 8/8] ACPI: APEI: EINJ: Update the documentation for
 EINJv2 support
To: Zaid Alali <zaidal@os.amperecomputing.com>, rafael@kernel.org,
 lenb@kernel.org, james.morse@arm.com, tony.luck@intel.com, bp@alien8.de,
 robert.moore@intel.com, Jonathan.Cameron@huawei.com,
 dan.j.williams@intel.com, arnd@arndb.de, Avadhut.Naik@amd.com,
 u.kleine-koenig@pengutronix.de, john.allen@amd.com,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 acpica-devel@lists.linux.dev
References: <20240521211036.227674-1-zaidal@os.amperecomputing.com>
 <20240521211036.227674-9-zaidal@os.amperecomputing.com>
Content-Language: en-US
From: Ben Cheatham <benjamin.cheatham@amd.com>
In-Reply-To: <20240521211036.227674-9-zaidal@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0906.namprd03.prod.outlook.com
 (2603:10b6:408:107::11) To CH3PR12MB8535.namprd12.prod.outlook.com
 (2603:10b6:610:160::19)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8535:EE_|BL3PR12MB6570:EE_
X-MS-Office365-Filtering-Correlation-Id: 3093751b-71b0-43d8-cb72-08dc7a7f58f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|7416005|366007|1800799015|921011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UTcwZGpoek1hVmZ0aE9FZ0o0a012YVRlUFhXSGFtMkVZLzgwMnB6cGxHL3Bl?=
 =?utf-8?B?NUFlM2h0LzV5TDd6M1cxV3l1eUt5aWgxc2FBY0VpTUlPTGl5SEtBQTlxVWVx?=
 =?utf-8?B?ZTUwY2pCR1VBTFJ6SmRDbi9ac25BWE5aLzdzUHRkUG1wdHgvanBDQ1E1Z1Bj?=
 =?utf-8?B?VEJleEtZTFpRMkRuZEtDdUxxWHRQMVpmVTgxRjY3cDRaSDlLSXdCTWE1eEtK?=
 =?utf-8?B?bVZhNVBBMlhlQ1ZNMlE0RTlSTjVnVEdGVGJIb29tQmQzQWxHOUZLQTVhaElE?=
 =?utf-8?B?OUhvK2QvRU1CZW1xTFJoeTNwVUxNc1c3SFQ1V1VpbDNweXpjcHM1Mys3U0FJ?=
 =?utf-8?B?ZEdhSjdTQXVOSWxHZ0dhUEhzSDB4NHVhem9mdGRGZzdPdFc3VmdUck5OdS9H?=
 =?utf-8?B?N3pPa1ZMMVhqL0t4ZU9MMG5jc1oySjN5eDhLVWxiVmF6NHpEMkl4K1lYaHBp?=
 =?utf-8?B?d1lucFBrYXJLRjBlem9NVkJxQjhJU09Ea01jTzBrMzU3cU9UV1dUbDNmMmhE?=
 =?utf-8?B?UUk0TkdIYzYwY3FnakZoTmo3MEJ4d2JCc0FzMjJHelAxUlA1bzdXYXZDSStX?=
 =?utf-8?B?V3lWOEJ3OTJhUjQrRS92TWxjOUFtUVZhUmdmWG9kRzVFZ1ZYQ3Y2N1lDNXEv?=
 =?utf-8?B?ZzZRUWJGZEY0TlBhN1kyK282aFBYOGJaejZmLzdvZEZ3UWdFQzdDY1dleGxV?=
 =?utf-8?B?MXFGN0tOSjlqRWhvQ2MrM2tCMnhURDdXOVhXQkcvY1MvSzljNEpFaElGV093?=
 =?utf-8?B?dk9LU3V1NGY4UHR1aWRocmdVaktDU2psNWtVOVlHa1B6czNIbzdaZEVoMWx3?=
 =?utf-8?B?TmpaRDBqMUdiRjZ2MzBtaW9lOXlRa0tGc3oxMlJIRUVRWTlRS2t1cXg3UGlE?=
 =?utf-8?B?MENkcEVzM1hYRUdOUlBXSi9mb1IwN24rQk9nVWR2VDhaVlZ1a2ZRb1NiZWtE?=
 =?utf-8?B?TjVHVHZSYnNUTWQrcUcrNWowMnVva0lJa1NzTnFlNjBqTjM4MjVNU0tXcjgw?=
 =?utf-8?B?VGxGRWppOExveFN1QkxKa0RXOXhmYWFMbjJUNS9FSG5Fc250RnVQNE9XbTZO?=
 =?utf-8?B?ZWhBMnhPMmd4clZSalV6N3hvajdONWJSTHgwcFZONmNyQWRWbmhHd3B1N2V1?=
 =?utf-8?B?R3Uwbkpsa1RzeWtDZHFKbDdpc1A5K3pwMXNIVVdDM2tQbDc1Q05ZV3dtM01C?=
 =?utf-8?B?R0pQSjU0WDZXQjlzRDN6UGpnK29PMVdrVHBmdjE5NkxyM1NDZ3hBRnl0N2Vt?=
 =?utf-8?B?WDd2WHc4SzFMeDdXWkxmclM1Q3hMM3dpa1VVZElrb1ZjT20vWk9sQjEzZlRW?=
 =?utf-8?B?ejFJUXhUbEFvWHFHNFB3czZJVnhDZWt6aUFDNGZZcm9mU3ppUnBHWEtkWjh0?=
 =?utf-8?B?SVhYd0N3SUYzb2xFaFQ4aDNObG5lT1B0TWZaMnAySWozVHNzZUkrRmNDTjBC?=
 =?utf-8?B?ZE1aVk5ZWklVWmI4Sms5eUJMaGxEc21tMlZoUjVSTWx4Tk1oREhsUHVNZ1py?=
 =?utf-8?B?WG0yU2FwMFd5eXprUThFZy9BVzVyUDIyalJIWTF6TXhrNXhJYnRsdGwxR09j?=
 =?utf-8?B?cGJrbkFDQjhkSlFQZWo4YjZqRm5aMEQ5cFJYVDN4aUVpNnlUT1RPLys0NGpq?=
 =?utf-8?B?V0hobWxuL3VXbHowZjVEMHVJeHhUVGo5dVI1REd5cEZSdFk3N2tKZW16ekNH?=
 =?utf-8?B?R1BGOENNc0IrR2xoVGNwcDg3MHBSbXRCanQ0ck5QWG1pWXc3SlExZ3J3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8535.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(366007)(1800799015)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?akNNOXk3UXl6K1phYWF6ZFhEUEJSTis3R0NjNHRrY1FBZ2FFMkJ2eC8vZlly?=
 =?utf-8?B?MUJMR1FlY3g2eHhzT3N0dWZTcWdLeG1sRHk5a0t0VVUxMmkyL0Q3ak15ZE5u?=
 =?utf-8?B?WWZMcUZOSTNiQmIxOEJ4aEVsS0QxUHVEeTR4ZUpET0p1YUVYL0ZyZjNJT1Z1?=
 =?utf-8?B?R2R6TWxHUHYvaWNEdEhURm9WT29oTS9hUU9QL0dObWd5aEtmeFlidXhRQW9D?=
 =?utf-8?B?N3dlOFR0ZGFMemh3c3lCSENoS2hINVdQb3ZOcXhJY0UwcDRqbXNMVXAvSVha?=
 =?utf-8?B?TVFFY2JkSTVmZmN2RVRtRlllamNaSlZwNkZFRW5GY1FnZWExRktOZXFWUElY?=
 =?utf-8?B?eitUZ1kyQU03UHRzRU5MelVPMERTL1NEQ0oveWtraFN1NHl1bXYxZC9INGZt?=
 =?utf-8?B?Y1pQVHVsc0ZIL1dSR2xSNC96czhENmNHRXR1Z3l1SEpvNlFkNUk0MlowTlU4?=
 =?utf-8?B?WklPTEJ0OVJSNngxLytTSWhvNlpScFVkLzduQkN0a2YrWVRwVlgyZ25ISThR?=
 =?utf-8?B?eVFWTnJoME9uNjd5UTZkc2dhR0ZHVERIWkF1czR1SHB4dXF0OVJwNWJjSGlT?=
 =?utf-8?B?UGlJMDF4TEZNalFHY0xBVENyOFdyUmE0WTc3M2dudklRelltVThhbFg2WXBq?=
 =?utf-8?B?UW5wcXhPK2RaSjlTdHkvQmp6TzBtZ1pxNmZObHUvSHNDVVBRRDlhTUpBaFpK?=
 =?utf-8?B?TzFIMkQ3ZXZJK0dBS1JzaVZBeHN1R0w0bnJ4RHMyblJ2RDVjTDNSUU5EdkJm?=
 =?utf-8?B?RWxjRmsvWjZZZzhQWWV2L2ZLd3QrSHV1MjdiRzVDUm1JaFgxclBUZlJvWi9i?=
 =?utf-8?B?QUJmR0RaOFVJc1JzV0lLNC9kRUtvQjVvN242cDZHaEhQRTBLMnBjd202UTgy?=
 =?utf-8?B?QXo2VnpsbWg3cVJSUGhTQWhnb2E4bW1FVUdic29BM0ZjcTBkUmRjdmtDTGpz?=
 =?utf-8?B?bU80V2lmdStvYnJHRFdMVW9sVkR1dHBCMFRZUmJBeGZ3cGFxek1TTVowYmJw?=
 =?utf-8?B?M013QWJyV3lZWTJ3SEdYcUcrR2EwZzFaQW81cDY2Z3J0NmdHOUZFclpFSmZV?=
 =?utf-8?B?TFJsSmYvWUVnNmI0WE1PTXplNmp0T25zNml2NkltTEllRFZydTM0NFdrakxE?=
 =?utf-8?B?NDhkdTlTa3ZaTjdYNW4xN2o2NkJjOXBDNm9YQXU2cnBCZTRZWHphK1ArMi9W?=
 =?utf-8?B?S2wxS3RVRklMSE5hSjh3Y043NDF2ejZVakdpNTY0b3NWM2JuK2FQSFQ0cjI3?=
 =?utf-8?B?TFlyUmFOZ1k0U1BmNzBjYm9VQmRuMEZwc25vSXdQMTFUc3MzakNtdWEvQ1ZE?=
 =?utf-8?B?TWNvSlpwK0luUGVrK0hGV2pjYXd4NnhzYUkyUVVrejN4QVp0eEFTWFNGKzVk?=
 =?utf-8?B?Z0lTVHJvdkF6eEpFdVpsZ2hPeHBJOVljYU5WZ3RRYWNJM2tWbjgxMk8rbHJo?=
 =?utf-8?B?VjVBcTZ5S3orUXNUeXpEMmRVeHM1bjFhRlYyMHhCNkJGNWx2aWVEbFgwNmNp?=
 =?utf-8?B?UjVCNXkzTld6ak5Jb3h0cFRnYjQ4a1BPb2ZWRWVabFVWaklqUVVUVys1SUVV?=
 =?utf-8?B?Z0Ewc3lRTk9rYjdkTUJsTUhVRUpjVzl0YzZZT3BpUFBjQnZVanFsTEdjMVRB?=
 =?utf-8?B?Qk5WUTFrR3BhSjlSVlVHRTVRWVpZdHIxclZxekdsQ0VVY05XNExzR05Za2l6?=
 =?utf-8?B?dkg4M0d1MFd5MHlKbHI3VVJ2ZEo5MGEzak1pd244T0RQMFk5bks1RHBleVlC?=
 =?utf-8?B?dkVDWll4M1JtaVZQM1B0Sy9uVW9nMWt0bDBHdWpLcWM2eGRMNEJOZjArME1Y?=
 =?utf-8?B?WjhVMjg4RGZOelBHb0hqdGVOS2ppMlBValVnYXp4b2V1c1RHVEZmMlhTRjZQ?=
 =?utf-8?B?U3RzTUd0anhSazQxZEQvUk02NDkvTFlWNVZoMVhzMDZZYitlNmpNSWVIa2k4?=
 =?utf-8?B?RzhpTlpqVGZzM3BYcGZxR1dLZWYvM3RKbTd2WXJSZWh5cnhsWWdyUWhQV2Z3?=
 =?utf-8?B?c0t6MmVuR0hjVEN5enNYOThCei9rZ0huT2FGeTFHNmpCam40ZEl1UG52cEdR?=
 =?utf-8?B?WUFVQnZiOFY1WFIyaVVsN3g2OGN3LzNHMlpJZHUvODQ2dFp4ckNJRm1kYncy?=
 =?utf-8?Q?81pOgJ+rge+krFQcj8VqjIsV/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3093751b-71b0-43d8-cb72-08dc7a7f58f4
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8535.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2024 16:50:55.2839
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: arwg+YkZKfDGJ3UMNs+ujNUqFOUEqz2JH8+YofZiwoc3UfIfi0+/5b32UvKSEYEddXdxNfMhbzZnantzePWb2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6570

On 5/21/24 4:10 PM, Zaid Alali wrote:
> Add documentation for the updated ACPI specs for EINJv2(1)(2)
> 
> (1)https://bugzilla.tianocore.org/show_bug.cgi?id=4615
> (2)https://bugzilla.tianocore.org/attachment.cgi?id=1446
> 
> Signed-off-by: Zaid Alali <zaidal@os.amperecomputing.com>
> ---
>  .../firmware-guide/acpi/apei/einj.rst         | 51 +++++++++++++++++--
>  1 file changed, 48 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/firmware-guide/acpi/apei/einj.rst b/Documentation/firmware-guide/acpi/apei/einj.rst
> index c52b9da08fa9..f2751cee9698 100644
> --- a/Documentation/firmware-guide/acpi/apei/einj.rst
> +++ b/Documentation/firmware-guide/acpi/apei/einj.rst
> @@ -61,8 +61,18 @@ The following files belong to it:
>    0x00000800        Platform Uncorrectable fatal
>    ================  ===================================
>  
> +  ================  ===================================
> +  Error Type Value      Error Description
> +  ================  ===================================
> +  0x00000001        EINJV2 Processor Error
> +  0x00000002        EINJV2 Memory Error
> +  0x00000004        EINJV2 PCI Express Error
> +  ================  ===================================
> +
>    The format of the file contents are as above, except present are only
> -  the available error types.
> +  the available error types. The available Error types are discovered by
> +  calling GET_ERROR_TYPE command, and if bit 30 is set in the returned
> +  value, then EINJv2 is supported by the system.
>  

I think this is a little too much information. I don't think it's really relevant
to how the available error types are determined since the raw value returned from
GET_ERROR_TYPE isn't user visible.

Thanks,
Ben

>  - error_type
>  
> @@ -85,9 +95,11 @@ The following files belong to it:
>      Bit 0
>        Processor APIC field valid (see param3 below).
>      Bit 1
> -      Memory address and mask valid (param1 and param2).
> +      Memory address and range valid (param1 and param2).
>      Bit 2
>        PCIe (seg,bus,dev,fn) valid (see param4 below).
> +    Bit 3
> +      EINJv2 extension structure is valid
>  
>    If set to zero, legacy behavior is mimicked where the type of
>    injection specifies just one bit set, and param1 is multiplexed.
> @@ -110,6 +122,7 @@ The following files belong to it:
>    Used when the 0x1 bit is set in "flags" to specify the APIC id
>  
>  - param4
> +
>    Used when the 0x4 bit is set in "flags" to specify target PCIe device
>  
>  - notrigger
> @@ -122,6 +135,18 @@ The following files belong to it:
>    this actually works depends on what operations the BIOS actually
>    includes in the trigger phase.
>  
> +- einjv2_component_count
> +
> +  The value from this file is used to set the "Component Array Count"
> +  field of EINJv2 Extension Structure.
> +
> +- einjv2_component_array
> +
> +  The contents of this file are used to set the "Component Array" field
> +  of the EINJv2 Extension Structure. The expected format is hex values
> +  for component id and syndrome separated by space, and multiple
> +  components are separated by new line.
> +
>  CXL error types are supported from ACPI 6.5 onwards (given a CXL port
>  is present). The EINJ user interface for CXL error types is at
>  <debugfs mount point>/cxl. The following files belong to it:
> @@ -139,7 +164,6 @@ is present). The EINJ user interface for CXL error types is at
>    under <debugfs mount point>/apei/einj, while CXL 1.1/1.0 port injections
>    must use this file.
>  
> -
>  BIOS versions based on the ACPI 4.0 specification have limited options
>  in controlling where the errors are injected. Your BIOS may support an
>  extension (enabled with the param_extension=1 module parameter, or boot
> @@ -194,6 +218,27 @@ An error injection example::
>    # echo 0x8 > error_type			# Choose correctable memory error
>    # echo 1 > error_inject			# Inject now
>  
> +An EINJv2 error injection example::
> +
> +  # cd /sys/kernel/debug/apei/einj
> +  # cat available_error_type            # See which errors can be injected
> +  0x00000002    Processor Uncorrectable non-fatal
> +  0x00000008    Memory Correctable
> +  0x00000010    Memory Uncorrectable non-fatal
> +  ==================
> +  0x00000001        EINJV2 Processor Error
> +  0x00000002        EINJV2 Memory Error
> +
> +  # echo 0x12345000 > param1            	# Set memory address for injection
> +  # echo 0xfffffffffffff000 > param2            # Range - anywhere in this page
> +  # comp_arr="0x1 0x2				# Fill in the component array
> +    >0x1 0x4
> +    >0x2 0x4"
> +  # echo "$comp_arr" > einjv2_component_array
> +  # echo 0x2 > error_type                       # Choose EINJv2 memory error
> +  # echo 0xa > flags				# set flags to indicate EINJv2
> +  # echo 1 > error_inject                       # Inject now
> +
>  You should see something like this in dmesg::
>  
>    [22715.830801] EDAC sbridge MC3: HANDLING MCE MEMORY ERROR

