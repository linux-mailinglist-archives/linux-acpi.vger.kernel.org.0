Return-Path: <linux-acpi+bounces-7902-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 666969617E0
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Aug 2024 21:17:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F7A5B20B7D
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Aug 2024 19:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F5B31D2788;
	Tue, 27 Aug 2024 19:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bFe8hXaD"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2046.outbound.protection.outlook.com [40.107.101.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ADB677117;
	Tue, 27 Aug 2024 19:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724786224; cv=fail; b=gzYc/L/0SBFmlFx4iL9ii4/s3lf7Sldn9ZW7Y2fPOqTNNsH/l8F7KqpeJxeq8R51RaEsxLORZO/QI2UONiADuA9VOHQynYNfvINtq1DVY2oPbBRQSu2iB7GDoP/uof/YZHwD2q5CIObDa2auRvfiBRBIGi8APJImA/ePjQn21Do=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724786224; c=relaxed/simple;
	bh=P3YkUbImCStXFZ+S1mZLoKlJoMCOh6IY1b7ztVytaqQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fwvnJvjrVjw9xNf97YnEqOM84ENbTdjrUlUUELumxu2/Zwz7z1EiEQzWVp+EuIw1VRKWXWW4BAuL9a6nI6CN5T5uHsE54bayMipnAXsw/QFhkL76LlBqzfjlUYplyd4Xsj+Y306XBFA8MXOVg9FUVRxsaDdqbcLG2M6h87HkJLs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bFe8hXaD; arc=fail smtp.client-ip=40.107.101.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IaxznNcT28jbLFgZbKWxrk8p4HVsNe1HnVgFQv9wyR7ZmDbBnxXuaHsbyoGpxYTeQgD3wpAraI99gCHnoh0edovmIYwBJadA3PQbCBl5w2obRev26gfmgbgIMnLnLLFKOlk/VxTsEuPyCUdAwC6xd+0fdC731vbjmfL5JaBxArqErCvdJ+FwFi3kpkT+8V7ngu5V5fhZTl4uFQDpdo4brlI4KibV+KWhcGAnfqpYuz6413TUzDXKNwRSH2rmvTkUhOyhF+8/mDfTH9foqf0apUAiqETl2r+59p3bBTLNP2uYzaMXEQpTP4FqwWwgSWyZrYSwIl8PARNHBNLgxNjrUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CEzqFPqtLWYslippUxgCyHqK1c6tToa255pro00HTZc=;
 b=LSXfrN/t0fujDT/DjdzFPW5iplvXog1AdY2sdGnx4Ffpgv1CZgVFNm84pFVvGRl1kvseO2/PhZU3rIxVYcz39/oWtbzE1BucQYSPtumADiPH9yDXVD7TYwLU8o7yYg8JlNWYADStL+zFmsptwN+lrG2VgewoqccStEiQeo3PzfbBOde5O8My9xrJc2mFKMi0/ZPAcXHUmDPN8TXCryXp9QLBMTE4/UAER7fFS9ErPjr3WemVkdRKDBmq8deFegE6MeZNWnGDpszhLtKxdmDcXOlYILC5y50DutZhYj/eK9kYrv805LOliCBPz+F1lel1mc5FNuubvG9z2FqD2iXGOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CEzqFPqtLWYslippUxgCyHqK1c6tToa255pro00HTZc=;
 b=bFe8hXaDYdlZT18S/iw/+NhOWDHRf4BYjU0fhVscoaOhNhmPMWGKrk4aVWPeEkyEfu+6OF94c3vjnXagyrU0UgmmwbnemBj54h9eo5nwMTImzwOcXL8mPlxfKuxCCiJSow30U7oSrzdzm5VtzZxpknSgFlak97zauYfzKTEi9hI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by IA1PR12MB6282.namprd12.prod.outlook.com (2603:10b6:208:3e6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Tue, 27 Aug
 2024 19:16:55 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.7875.016; Tue, 27 Aug 2024
 19:16:55 +0000
Message-ID: <61b96549-2969-4b64-a40d-f91f614ec3ab@amd.com>
Date: Tue, 27 Aug 2024 14:16:51 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/8] cpufreq: amd-pstate: Drop some uses of
 cpudata->hw_prefcore
To: "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
 Mario Limonciello <superm1@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>, Perry Yuan <perry.yuan@amd.com>,
 "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
 <linux-kernel@vger.kernel.org>, "open list:ACPI"
 <linux-acpi@vger.kernel.org>,
 "open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>
References: <20240826211358.2694603-1-superm1@kernel.org>
 <20240826211358.2694603-9-superm1@kernel.org>
 <Zs4G084+7MmzdYjU@BLRRASHENOY1.amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <Zs4G084+7MmzdYjU@BLRRASHENOY1.amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0083.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::28) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|IA1PR12MB6282:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fcec32e-1756-4403-8344-08dcc6ccd039
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dUxMOEZySWNVTXdRT2tkK1RtTFZNdmJXRlcvbUVuRWRTZ3lLSmNXNTlTNWlP?=
 =?utf-8?B?REd6KzRPd2lTaSt6SGlqNndSb1NkUmJDbTdVaXZNRms3aE40YnRyak9tNWZo?=
 =?utf-8?B?WHRaRXpUbkowNjJQY0pGNE9CYm9zZFk1NEtHVEtGNy8zUFUrTnRUazFYaSty?=
 =?utf-8?B?NHRCS2lVV29DSThXUVFaZzI1ajNhRjhyY0RPK3d1QWErQ1doOUgzaFV0ZHJR?=
 =?utf-8?B?T1ZHeldZWlY4eWFFLzllUVRZdHo0YzNFbzg2dXA4dHdpSHk0WmZNSGNaSUF3?=
 =?utf-8?B?TjZxSEZ0dHNUcWp2VnFqTVpkL2NRV05jN2FRTnUwMDhIazdyNWtnc2oybzQx?=
 =?utf-8?B?UVNkRVlDdmxERlpaZXA3Ly9PRStBYkFzZ1BSZWw3dis0OHNvWGhWMGc5Wlk3?=
 =?utf-8?B?SWIzaHBBMkpBMXc4cEliYldlNkVnd0hKYjBwRDNIbVVuQ0YrZWdZQUIzRTFn?=
 =?utf-8?B?UnE1RVhtU3p5b3ZpbkRUYjBQc1B3UUZueThtRXZrUHZyRHl3bXlvNEF4SUhI?=
 =?utf-8?B?NnptRGJ0YmV1M3JTdVdIY3RMK1ZVY25BZER6ZXd2bExBaTFRcmFvOHZNNlhv?=
 =?utf-8?B?ZUVQR1lLcEhKUlhpTURGRy9OWXJ0VHkzS01RQ21ma3ZqSlVFUS9WbFhhbmw0?=
 =?utf-8?B?cjRLRUxrRlN6cjIrN3Z5cXpQVHJNa2d0OGVIVWdxWUk1cnQ3VEF4QU1tYlNj?=
 =?utf-8?B?d0JwWUE3Z2dXOHc4SXUyek1taWdIeGxsa00wYXNNWlhLcEpKSU8zamtEdFhC?=
 =?utf-8?B?bDBjenNva3NCMTFzUkVyZW9ZSytrLy94U2IvQ0s0QkdWKzZqZzlocVkvMzJj?=
 =?utf-8?B?MG8wVkhQcE0xUEJJcHp4Vk1vSlFpVENScVVpTWxFOS9TTnVnZk5yVXlOcXBn?=
 =?utf-8?B?WXFKTzVmd3V2Z0lHNjZCOG5oR1F6V3RRL01qUnhEaU1ZNkZSSUJ6RkZ5a21W?=
 =?utf-8?B?YkRzeXZqR2RVYmlVVnFtR29XUW5VdHdOUGVVa3g5RlhBdVdvR28rUlNCTktn?=
 =?utf-8?B?YzNYT092ODBPNnJUTkF2Y2pDK1U2cUEzell3OER3YmhHRkplMTlXM0cxWElC?=
 =?utf-8?B?Zm5vQnVNcVpNWkxhT0dIRGtXcitoTDRFMng2ODN2ODh0bWJNREFyTkQvOGM4?=
 =?utf-8?B?eWxQRGlFQU9lTTZjSEFzREd4UWhkWXo3aThkcG9Lbm5jM3hVbDRpdCtBWVFL?=
 =?utf-8?B?Q3dRQ0lZdSsyS2tieldaSVpvWW1rZllFeHhDR3BNQnJ1WHJuSjZCcWVHSTZN?=
 =?utf-8?B?Y2FscW9tbXZGeEZvL0NMZFZJMEhVa1BUcVN3em5DeGV3NVFNWGtCR2JhaHNJ?=
 =?utf-8?B?bFUvUk5ZR3VHcDlibmdtZHBzdnNhbzlzWVR0ZDQvYzROUVBIMkRacXpmNDNx?=
 =?utf-8?B?d1R0cVRnb0M1b1ZqUnFXQ2lZUng2cEE5VzJnYTlnUkhNZXBmZ2p6VnNvbzda?=
 =?utf-8?B?dnpxVmhiSzBrS2VHR3NlcER6NVVlb0xlVzBEV0lkdWhTRGlTYTJLQ3JoblNU?=
 =?utf-8?B?WlJ6RjV6ckxsNEhuUk9ZZlNjUHdjTCtMSnRBTDZqZUUrWXBoTk1XVk8rU2hp?=
 =?utf-8?B?aEpocW5DY1lmM1Uxd29ab2VpNlFvM3NLeHdXWU1qMW04d3VsSEVnemJqM1pi?=
 =?utf-8?B?RUJOMC8xQlFFZTZMalVxdTRqbWZUQ2xnbGRXM1NRZ3hRVVF2V0I5OWJvSTl5?=
 =?utf-8?B?S1NnVVkrOGh2b2puV2ptNXJVTnhGczE3empYb3BSSmxyQVZpK0Y2ZEZqdUlT?=
 =?utf-8?B?b2dlL3h2M2xheDB0bnIvQlM2VmJRVU5venppaVN5OTR1YXpGb1d0cS9TRjJ1?=
 =?utf-8?B?TUlLN2h3dEIrOFBBdEJsdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?am0xd04vZ3EzVXBIQkViOThjTU90bUpZYnM4NXJJbHlZT3hkRkQ1RHUzZ0p4?=
 =?utf-8?B?b3M3NUdrQ0hKVTVDZ2RTM09iTjRuak9rTGtUWm1aNGNraXZYbEhNdzhsU01a?=
 =?utf-8?B?Y215SUMxYXhiTTRDT2dHV1VTTTk5c0ZxMUExTmRIbHdvUEsrWERMTUN1OFNz?=
 =?utf-8?B?eVJYOXRLelV6djJ2NlUyWDZFMTNaSWZMSWwwTXZwNXhwRVVPVFEzUE5LMVpz?=
 =?utf-8?B?TTRVUXBJSEdUZ2pwcjRlL3BYbFM5d2xUT1pRNFNiZGovc0dYc25WaW9BRTJv?=
 =?utf-8?B?MUIvV3N0WXhnRTRtOHNETFgzdUF1QjFCcHRnK3c4WlYrdnAxK2xHZ0pyN0pC?=
 =?utf-8?B?b1lIVllHQWNjdmlsVFRJeVQrZVI0WEpYT293VGVIaG1ZeXgxOVR1N2pzOHly?=
 =?utf-8?B?ZWtzaWlvamdWNGVtemc1Ym5OcUtMQWQwUEJIcnFaN0V2RmZhNEhJZVlDVUQ5?=
 =?utf-8?B?Mk5iKzRLaVd2aTgraTd4VzQ3TEtXM1d0NnYyaDdEWVJuL1hKNzZ6QmpKNURC?=
 =?utf-8?B?VGMrMzQvMW94cGFva3hEbWxwZGlQKzNhRlQxenh1MHJib3ZrVFVkazYra3dv?=
 =?utf-8?B?a1d3Wm4wL3NZQ3F3SURXNUNvM1paKzZocEZ6blRGbEI4OW5SZnNPU1l2OXNi?=
 =?utf-8?B?RlBnakN5alRSQXp5VzZyR2U1U3dIZ0RVUEIzSCtkNUNqVFFpZy9mWGNkQStZ?=
 =?utf-8?B?bjdWdS9YbmpiUEsvdGFWMXJoTFIveHVzdjlxcGhxeTRWMDdHb1laRXV2VXhQ?=
 =?utf-8?B?QXlNVlVVUDNlbDFsUzNnZ0dJbi9FckFvcUZqeVZrTkpGeE1ZVkk5dEkwNUlG?=
 =?utf-8?B?bjkzWCswdWQ2UHh6SG85blB6aVlOcWFremNac05KL0ovc21qbWNiejcwcTY5?=
 =?utf-8?B?UEx5SGMyUmlXVEJCTU4vU3ZGYU1heGxPbjJYL0JEWHZ4bitUNTRoUDBRajR5?=
 =?utf-8?B?MHpLcVRBd25oeUtxTUdBSzVUTjdKemxoTG9ONXQrS1B1V2lJRE9jYWpGcTlK?=
 =?utf-8?B?VEppNVByWlo1QWlST1R4NUtxUEZpWmtidjBsVk9IZUlTajcrT1pUeFRuRnZm?=
 =?utf-8?B?Z3RkZzV0NXpzUGZaT3prK2FWbmtVOSt2UWkzdUttbnZNOUZpdHBrODhxWUFa?=
 =?utf-8?B?SXpHNkZ5TjJTNWNCaWY4SDNSR0V4OHRIaldtUWRBQjdkYnA0OFJvQkFjRURT?=
 =?utf-8?B?V1lqUU1wQS9hek50eHQxNkdRcVQzMW1wcXVacWwwc2xxSTZod3pOQTU5VzZC?=
 =?utf-8?B?UEJwZUdTYkI5SHRvTXFPOFVpVVlCQVFmZFNaMnd5QnlBWDN6MG1rejZYWVMx?=
 =?utf-8?B?YlZRKy82T04wYUhjUzhEV2gzU0w4VzlqN2hFQ0pwUGN3cmFlVnpuMDc0TDNu?=
 =?utf-8?B?RjFZanBkTlc3TEkxKzRxOVJnSTcveGJjTFB5R3ZUdlFTQmJmbUtlTEkyUzk2?=
 =?utf-8?B?bksvYlFOM3FZd0tBN3hWdjE0Tm94VndNdTlqQ1VhWGJXSUEvK2ZyaVk0QVp1?=
 =?utf-8?B?ZVpiTmg5UXoyS2JsbWQwYzMxNC9lcS9OU2pnRmpvNnNTVzh6b2xsUnJpeDg1?=
 =?utf-8?B?dHFsK1VJQkZ6NWl6d2JiVzRSMmwxMUNTaUV1a3d1cTJmcXFsalZMK0NwUUEz?=
 =?utf-8?B?dnhJanExVC9aaGFlTDFLL3gvcmR1ZmFaaEVBZHJpeUdYSDNCSUFjY1lQY2Y2?=
 =?utf-8?B?TGlPNnp2N0o4RkpsYktvNUxYa3JPc3BTVW1lMktQN09ubXd1aUVZVVNOOTZC?=
 =?utf-8?B?ZFZzaTJPZ2F5eHl2Uzl0eWJ1Y3dIQ3lOTEZrUXh5bGgxL01Zbk5Da2pLNlVY?=
 =?utf-8?B?ZnkrMmR5NXZQcTVZY3VHQ244NXE1ck95NUhiZTNGQmgrNThOczdjb0pDZEF6?=
 =?utf-8?B?UE5DZU1Zd1JLS1M2NlpXVDR2RjhRaHhnZ0JUaW45OG15V2RlcnZ4ckRqSDZp?=
 =?utf-8?B?RndTODU4UTRsdnZxeDJ1b1pRUW1yV0FPbTlIcVdweE9Rb3czNnBkcDYvbWVY?=
 =?utf-8?B?SEwrZ1hWc0xUek1aTS9hc014NkVpQTZXSm52cFVjY1dHc1YwTUxMZWlIdVZQ?=
 =?utf-8?B?VkhKWnVUZFFuNGMvZERMNW9lREEvMC9hRm4xTnNWTDRVZHZ1bmNCMUo3MmM5?=
 =?utf-8?Q?DWp05Gnug3fb+2A/5X97B+ij3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fcec32e-1756-4403-8344-08dcc6ccd039
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 19:16:55.0331
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZNiRsNHuwIGa+o/DPeJd3rmiOOKsaxeFRLgsiFuZWzH2K/IwPygs877d9k3ecljTBd+JZP1eFn4rM4xcHy0B7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6282

On 8/27/2024 12:03, Gautham R. Shenoy wrote:
> On Mon, Aug 26, 2024 at 04:13:58PM -0500, Mario Limonciello wrote:
>> From: Mario Limonciello <mario.limonciello@amd.com>
>>
>> As the global variable is cleared when preferred cores is not present
>> the local variable use isn't needed in many functions.
>> Drop it where possible.  No intended functional changes.
>>
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>   drivers/cpufreq/amd-pstate.c | 7 +------
>>   1 file changed, 1 insertion(+), 6 deletions(-)
>>
>> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
>> index ed05d7a0add10..257e28e549bd1 100644
>> --- a/drivers/cpufreq/amd-pstate.c
>> +++ b/drivers/cpufreq/amd-pstate.c
>> @@ -1112,12 +1112,7 @@ static ssize_t show_amd_pstate_prefcore_ranking(struct cpufreq_policy *policy,
>>   static ssize_t show_amd_pstate_hw_prefcore(struct cpufreq_policy *policy,
>>   					   char *buf)
>>   {
>> -	bool hw_prefcore;
>> -	struct amd_cpudata *cpudata = policy->driver_data;
>> -
>> -	hw_prefcore = READ_ONCE(cpudata->hw_prefcore);
>> -
>> -	return sysfs_emit(buf, "%s\n", str_enabled_disabled(hw_prefcore));
>> +	return sysfs_emit(buf, "%s\n", str_enabled_disabled(amd_pstate_prefcore));
> 
> 
> If the user boots with "amd_prefcore=disable" on a system that
> supports preferred-core, pror to this patchset, cpudata->hw_prefcore
> would be true and thus, amd_pstate_hw_prefcore would show "enabled".
> 

Yes; you're right about the previous behavior.

> With this patchset, it would show "disabled". Or am I missing something?

This appears to be another case we don't have documentation for the 
sysfs file `amd_pstate_hw_prefcore`.

I had thought this was a malfunction in the behavior that it reflected 
the current status, not the hardware /capability/.

Which one makes more sense for userspace?  In my mind the most likely 
consumer of this information would be something a sched_ext based 
userspace scheduler.  They would need to know whether the scheduler was 
using preferred cores; not whether the hardware supported it.

Whichever direction we agree to go; I'll add documentation for v2.

> 
> 
> 
>>   }
>>   
>>   static ssize_t show_energy_performance_available_preferences(
>> -- 
>> 2.43.0
>>
> 
> --
> Thanks and Regards
> gautham.


