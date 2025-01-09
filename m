Return-Path: <linux-acpi+bounces-10476-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94684A07DBA
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Jan 2025 17:36:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDF1A16995A
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Jan 2025 16:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6795E223336;
	Thu,  9 Jan 2025 16:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MFCC/NGp"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2066.outbound.protection.outlook.com [40.107.236.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69DC2236EC;
	Thu,  9 Jan 2025 16:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736440578; cv=fail; b=a0bGXkdmh40DpbvZVZA3KCBKeoXWl35wY93K7BxZheUgw2y9SdsA7HS5W6f/yYHDJrHMTCNDC+PZwiOwvGfKDcKIDVoIJgKn3FQRZRebYeZqzAx7SpBXqZSKkUibGwvIvE/HlHAeeokZP8q7YIAd/JcXSmjdk/b2Nn1pn4jLZAM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736440578; c=relaxed/simple;
	bh=l9wQiaSDrlPgfkSv/9DVR34zMmlF25san1UIomK7JRo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iwSCbjTmL6QV+7c8N+FrKNy2oRAFRjoPpbCvg+nogx8Idw/syEqYTbX9VbXkDxF0+V4QmRBEXtWCZsD1OcWre40LezlYFg9QdkDv/zzZs4KGTYoxItFxgk7vbOVHTFZWD1hdHtOfhYzft5IXr4UixKCVTvJ/5aL+fTmNqxYWZVg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MFCC/NGp; arc=fail smtp.client-ip=40.107.236.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bFfchGgYZ50j10sMIi8nhvM+lBhLHtAcEX5pU8ucZKY9WbdI7gardy+ZKIkLLruv2AZnKBQ3Gw60tnvFfXcKzZHC4v0q8nWf7LBY2wTGpsfRsd6Gt+9u4rQO36YcVSMu21WCYeoIzd5eqk5JpG1Ptu5hu3fZpUQ9p6JKDaw5GTxmrodZJsQU5o3P8C4XkYoozYlqskDvhBp18ziOlFsbnMHdVfxoHHEMbTozD8xHmv+MWE7nTZJXZWcWQD/4QbloyU3ca28bXiYcvJdDY42ulxqU8kGLFlbz0I0rLIoyhF7qQHZWB7eT6YRxgJeR3s80ToQo1b/r/xmiau7brAt0GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KRpMGze9PMpwu5V1rbTjXjEdjyBs+DrdxLCAwCsM5W8=;
 b=JF4sengez2zcnL45AjbOxQKD1ly6QbbdncRoHXB8l79ri84zDiVxDejLBlkyC8Wt7fNNyY0CY6GQwKoetA97EQQQdWiPffSydTxzBPRur/PRce/HOOFA7Jm+bq/DasnAlwPj3jVqBTX7dQ/1UvpO1Gw5TwlD7ZbVtLerqm4qkojTm63ncVKpV7BvXsvoVWAvQPjFYiE/r/GRiBrDgnmOi1Q0W00UE6B/JaQ0vPbhATcgxwmeKxOuZrlzbEw6/2xtBMkLcLJ9EwSKQ+AHsAIPzSGGMjXRoPlza51VYW8Ku6L0bcZj7vfpPEF+0EQQtuYwih8UpuLjXTGFbPdsPain7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KRpMGze9PMpwu5V1rbTjXjEdjyBs+DrdxLCAwCsM5W8=;
 b=MFCC/NGpgY1kY9fV29BKGNYYUy5Jj2FfzLl5LBjQ2SxCBR8PhGNre6Bxg8b5iLW518wEbxQkHjif2wtSSGsihqAj0Z2KrNmpE32+OamG9l6BoUnSl5/WiQ+WuprKEa59CpIwBwkD1hQ4KjAWzYKZaeVgJjDgvlroq2PDDkFEzC8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MN2PR12MB4128.namprd12.prod.outlook.com (2603:10b6:208:1dd::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Thu, 9 Jan
 2025 16:36:14 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8335.012; Thu, 9 Jan 2025
 16:36:14 +0000
Message-ID: <a86f37cc-8464-4732-94a4-0f3c0a1022e3@amd.com>
Date: Thu, 9 Jan 2025 10:36:21 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/18] platform/x86: asus-wmi: Use
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
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Gergo Koteles <soyer@irl.hu>, Dell.Client.Kernel@dell.com,
 ibm-acpi-devel@lists.sourceforge.net
References: <20250109150731.110799-1-kuurtb@gmail.com>
 <20250109150731.110799-9-kuurtb@gmail.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20250109150731.110799-9-kuurtb@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0109.namprd05.prod.outlook.com
 (2603:10b6:803:42::26) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|MN2PR12MB4128:EE_
X-MS-Office365-Filtering-Correlation-Id: ec8312f1-b475-4cff-e0bf-08dd30cbbbbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eUwzSmpCV0FCWUgydnZCT2E1dkVvcHN2ZGx0U0NwUFE4bHhJdVZETmdMdFd6?=
 =?utf-8?B?TU1hUGQ2OTZBMHJKNWJvTlVObnoyLzdZSExLRTB0RUVETDA4a0lhdVBTQkF2?=
 =?utf-8?B?NGQ3ZGNrN3NGcjZkNHY2dTgyZFU0MElZUTB0aUMvQVFleXI0NWpDM2lTbWF4?=
 =?utf-8?B?OGluSnMrVjdPTjlEOUYrUm1UTEhmbWQrb3hBaDR4WXh2RSt5UmFaNlpmcnJ3?=
 =?utf-8?B?dWtNRzErNzFMWVJhS1g3MG8vMDhvSXJoa0Z5eHFDZUVzVHF3SWdYc1Fyd2NB?=
 =?utf-8?B?bG55ekhWRDBkTFF2SUFCeFFKYnp3RHZpcjd5eWJ6bU5NL01GVW5PeDI5MklE?=
 =?utf-8?B?eXF0KzZJODJXdHBUQmRuclYzdmVnekk1KzdEaDRMM0VZT0RvbXNUV3ZuRkxC?=
 =?utf-8?B?THoydldPWVpPSi9vK05OS1FYVC9VOFF1K1BOTDAwVWFnOVpyWm02azRqSElR?=
 =?utf-8?B?Y3pnbHlSaG9PUlVtaW5Fb3R3WSt2amE5eE94MmIyc25Tb0Npd0lub05tRHA2?=
 =?utf-8?B?QnUxT0hnL1JzUWxsbVMxUW5kY01jakxHckVObUJ2Vyt1QVdpQ0IxOGN2NVVs?=
 =?utf-8?B?anU2SzU0WUg1SDF6TlhiaGFWdWZvZEZqZGhTbnowdHZMdmNGN0JyUEhyTFBC?=
 =?utf-8?B?U0VZUExTU1p2Sm95N3FRZHJObllrV01McnVKOHByWW9qK0lYYmZFZVc4alph?=
 =?utf-8?B?YUJ6YnVqajB3K0ZXYkI5MDlXNXgxTGpZY3p2OC9oSGZiWmIyU1pWTXFtQjRD?=
 =?utf-8?B?NW5OK2ZLYTlUS3Rid1RKdUxTT3Vid0gvQmNmd3ppQVhneENCalNpdElzeUhY?=
 =?utf-8?B?RFdUSHE3ZEk2WDFHSlI4SnNxNFozNGF0ZW9BV0dkelllZ1NEcVZaWk9nS3Ns?=
 =?utf-8?B?N0pyYVdkeUZHN090WmJOelpIZk9QK3dpTFpVRUUxckFzTzNWcWZqQ2JEbHRS?=
 =?utf-8?B?WUJOYWlnelR1czVxai85N05HTTRpWXpSZHdPUmoxbjlsNmMxNy9oN2IydTA2?=
 =?utf-8?B?VnBHSExHTXcvZDRRNjlMRThyaDhKNHAxdVZlZW9IT3VaUWhqYytHT210amlY?=
 =?utf-8?B?TFR1Qkk5YnkxcVEzVXh5ZlJEM0FEdUh0dFBJWlI4SmNyQTFZVW5hZ3M1clFY?=
 =?utf-8?B?Z1dkbzBoQld2dDdWcUpZYzA5NldvSnVlTW1ZUXZPakJGeFBCWExJdnYzS2xQ?=
 =?utf-8?B?N1M1dTd5T0luZzdjZGIvQXgvbWdSbWZmYWpMQ1NyZDdsYTQxL09wQ05PbWVR?=
 =?utf-8?B?dlRCN1VoUmpmaTEwRk9XbGpscU82azZlYy82eEZiZjRDZ2NXdDNFd0I3SG8r?=
 =?utf-8?B?Q1Q5UXBnaVJZc1ZWdHAzN054M1Rzd3gxT1kzQlR4NHlQNjhYY3Z6Q1E4UHZm?=
 =?utf-8?B?aFQ3TWRYSVVlL1J3OGpvRzhLWWd0anVHcVJ2N09aL29iV3NHQStBWHl2REF2?=
 =?utf-8?B?UGJqNTRYcUhNZnpnSkxySXg5UzJvWnR1OXUxWmFUdzRuazBLMExOOWoxRHdk?=
 =?utf-8?B?ZE5XNDdpV3krRU5icHIzRVFMZHNJR2V6L2ZMNXpYYm0zeUplZFIzckZZdDZD?=
 =?utf-8?B?Yk9iNEt0NnFpVWw1cnBTbUZOSnJvdHRHeGV5elh5dm5XRGhhcExUWUc3M3la?=
 =?utf-8?B?M0hjZU9sUW10N0xCWjFQZ2NMTFpVck56SWgxMXkrS2hxeVJjbVVReVpkZXAy?=
 =?utf-8?B?U21pdy82TEpRRDRyWmtFN1pPMWpJQkloRjlFeUhwOUdwSmhYZGpjUHBqQmVY?=
 =?utf-8?B?MW9WNnk5MERucEt0STk4WE5mSHJycUptTW1LODVrQTRMSnJtcEpJRmY3WWlz?=
 =?utf-8?B?MDVHU0dFZ2l0MWxtZHkzdi9aVDcwRER2WUFEUTBkRHdqWTBaeWNRSzA3Wm9K?=
 =?utf-8?Q?irwj1lIxiRNqY?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WGRBSUZZUFQ3bHExMHcwWDNIS1JHUWJ2K1lodXN5Q0YvYlpLMEhkQzVjdzV6?=
 =?utf-8?B?UVVTVkIzNXE4MVZmcmtVNW1HVXgxUlBjeHlNcjRzR0c2TWU3akJSTTRQN0h1?=
 =?utf-8?B?WGhuSzJnQ1B0blhPclFkUkFNT2ZQdGhWQ1VuYTlySXNRcU5SWm9Fb1VjUy90?=
 =?utf-8?B?dS95NWxOTndya3VxZDBlc3hhUEtQOXVOUUt4TkZXbHRVaE9PbWJqSXRleklx?=
 =?utf-8?B?SUQxcFJrdHlRNHJ5QlFBbG5RbU9VMHhKbmlZQzNuWnViNlNIWi8walZvbzc5?=
 =?utf-8?B?V24xbDZlMUgvRjdmcVRsYU5xKy85UmtxV2hLcFVhdnkzQTBPUUdVQXJmTUhY?=
 =?utf-8?B?Qjg2ZmJDQXZxSzUwcGtpTUNVYjVZcWJIYUJtd3YvaXBmUm1VV251MWdXTmxa?=
 =?utf-8?B?UEU5MFh1ZlBSVzMvWVBwejU5d21QWHJmQTVUYUFmakt1UUgySUt4THA5VVZx?=
 =?utf-8?B?TVFaQndVWlpQZHBDNlNucHFCVmpjdWtjL3BEYmxDNFArSUNlblpRSnVmblpS?=
 =?utf-8?B?T2g5bUJEdU1lUVgzTGlwYzN0SkVtMTJ3N2cvTnh6cFFPOVVES0RQdStvazJY?=
 =?utf-8?B?VmFkdkw3MnljUUVQWlFaU1BEcWxsWXBzZHNiM3RHb3FwcHh0NkhWcm9LcHkw?=
 =?utf-8?B?d0VUM2dNd0I1NGtWT0RhSmhRVEdtUUs0SDQ3UENha2dlejBUR0x0K3ZnWlNz?=
 =?utf-8?B?Qm1kSGV2Ri9zRUhNSjhZTTNmRVNCUTRTV29sUTdFUUtKQTBETzFRZFpNcFpm?=
 =?utf-8?B?M0YyVis1TTRWSjJoU2t6cWJMby9ZVWV0akEwemNOa29kVHRVb3dhL0RxaGtk?=
 =?utf-8?B?Zml0akpyZXBOTHgrVGlNYzlTVWVJRVBQSTJUOWZpU0ExWjRzMCs0ZlJpS0tM?=
 =?utf-8?B?Ry9lWlA4M2xKcWEvVmEvbUdCSnNqMlNIQTRYK1J0ZXJDc2IxUm9aSmxnYlJn?=
 =?utf-8?B?cUFmZ1VFWTNJdGhRLzd0TjZyanJMUXZpWFFrbC9KS0JVeEhMWUhPbXphRkZy?=
 =?utf-8?B?QVpTRXZmOXZiV0JPd0pVSTNGeGVoMk5SRVd4aWE4QU02MXA0L05DY2RKSDZx?=
 =?utf-8?B?SHI4bUNGMGpuZGFLZUVZMStDU0lYMHpuMU53M1RaMEFIOTJmTU1GMXRHUTlF?=
 =?utf-8?B?cjlVQ2M1ODMzWTRjWlFIc2U3NWlhWFBEQ1VMdmdJZGEwWlZqTmFhU2hvWUxM?=
 =?utf-8?B?TDJVMlZya3RzWnREdTh6REZBK1AremVoK1ZmK3A2UUkwTnVZT2VOY1FyYkFm?=
 =?utf-8?B?cUVmOGgzSHhFejdROG1yTWV1L0hFNExNNlgva3owWS9wN3pDL0RXaFFJaDVj?=
 =?utf-8?B?aHU3amE3aDJ4ZU9qMTk2UmpFWW9TZlZLbkMwTUJCTVdqU2E4SjNvVHVtOFI0?=
 =?utf-8?B?YWRicnpBK3VDMXpCNzlMV2NTUGZzaFQrUnFOWVdSaUNXYmNPZHhPbERrUkN0?=
 =?utf-8?B?RGR6Q1NBNE5aeHNSZy9ZdlFsNDNWTlFJcWdKWjh4QlpEUGZkbWUyMktxK0s1?=
 =?utf-8?B?dVZwVWQyUnprMWhTL3dMN0llMU0zK2ZyYnFkbmxQWE1ZTUJUWEpWUFlTYWxn?=
 =?utf-8?B?b0ZvN3d3RmJiOFozUnc0WGpFU1dVMDh2aGpYNWNjOE5iTjFFMklJN3duOTFt?=
 =?utf-8?B?ZHpxZTZYSGdSSjFKSmJ2a3JEQW9iYVhXN0xMSEdlNG1vNSswUXpLOFRMUGtF?=
 =?utf-8?B?YU5ycG15NjV1NWRTUnVyRTY4cG0rVFdwS21NR0IybmJIbEZxbVg2ekVKMkp2?=
 =?utf-8?B?RW9kNjVsSUJMcWR6cjlBNjhHbVpsRjh3Q0tzejhBeFFteVBVOTJkRkFmR3NX?=
 =?utf-8?B?YTRjbW1BeXJSS2Y5c1B0L2lpNGwwcWpMMEE4N01xZldRai9lR0NQeDV0Y1ZW?=
 =?utf-8?B?cXkydFp5cm9yWTNsSU5LLzh0M0VpdXJ6OStVNjdVczBMNXZ6T2lqZVliMVZF?=
 =?utf-8?B?d2Y2MFdWdmdSYnhKOFNCMU9TTHRtT0ttMGk3OUtleStxd0NhSFN2bGloMlRP?=
 =?utf-8?B?MEY2V1RqNFU1OXBocnlEQTM0Ry9JZ2g4OW9qYkZobGdlcFlCRWFvR296cXFa?=
 =?utf-8?B?R0RGNWNIZVVZZ1RRTkFlQml1OTJKaUZXd2dtanV2NmdxS3VVU0xWMXdhNnVt?=
 =?utf-8?Q?UU03FziCSrYJUrXmk4I9nX4uX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec8312f1-b475-4cff-e0bf-08dd30cbbbbb
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2025 16:36:14.4377
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gn0Gpq1/OEqTYxcK40Eehf7KnG07G5pJU0ze3PECTRcfDvZ6YvkQ4MObBh/AP8n9gDpk/dtcKgxKBSMmM1dK5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4128

On 1/9/2025 09:06, Kurt Borja wrote:
> Replace platform_profile_register() with it's device managed version.
> While at it, pass asus_wmi to the class device as drvdata and replace
> uses of container_of() with dev_get_drvdata().
> 
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   drivers/platform/x86/asus-wmi.c | 13 ++++---------
>   1 file changed, 4 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
> index 248490571e8c..5c7099dc6109 100644
> --- a/drivers/platform/x86/asus-wmi.c
> +++ b/drivers/platform/x86/asus-wmi.c
> @@ -3806,7 +3806,7 @@ static int asus_wmi_platform_profile_get(struct platform_profile_handler *pprof,
>   	struct asus_wmi *asus;
>   	int tp;
>   
> -	asus = container_of(pprof, struct asus_wmi, platform_profile_handler);
> +	asus = dev_get_drvdata(&pprof->class_dev);
>   	tp = asus->throttle_thermal_policy_mode;
>   
>   	switch (tp) {
> @@ -3832,7 +3832,7 @@ static int asus_wmi_platform_profile_set(struct platform_profile_handler *pprof,
>   	struct asus_wmi *asus;
>   	int tp;
>   
> -	asus = container_of(pprof, struct asus_wmi, platform_profile_handler);
> +	asus = dev_get_drvdata(&pprof->class_dev);
>   
>   	switch (profile) {
>   	case PLATFORM_PROFILE_PERFORMANCE:
> @@ -3895,12 +3895,12 @@ static int platform_profile_setup(struct asus_wmi *asus)
>   	asus->platform_profile_handler.dev = dev;
>   	asus->platform_profile_handler.ops = &asus_wmi_platform_profile_ops;
>   
> -	err = platform_profile_register(&asus->platform_profile_handler, NULL);
> +	err = devm_platform_profile_register(&asus->platform_profile_handler, asus);
>   	if (err == -EEXIST) {
>   		pr_warn("%s, a platform_profile handler is already registered\n", __func__);
>   		return 0;
>   	} else if (err) {
> -		pr_err("%s, failed at platform_profile_register: %d\n", __func__, err);
> +		pr_err("%s, failed at devm_platform_profile_register: %d\n", __func__, err);
>   		return err;
>   	}
>   
> @@ -4859,8 +4859,6 @@ static int asus_wmi_add(struct platform_device *pdev)
>   fail_sysfs:
>   fail_custom_fan_curve:
>   fail_platform_profile_setup:
> -	if (asus->platform_profile_support)
> -		platform_profile_remove(&asus->platform_profile_handler);
>   fail_fan_boost_mode:
>   fail_platform:
>   	kfree(asus);
> @@ -4886,9 +4884,6 @@ static void asus_wmi_remove(struct platform_device *device)
>   	throttle_thermal_policy_set_default(asus);
>   	asus_wmi_battery_exit(asus);
>   
> -	if (asus->platform_profile_support)
> -		platform_profile_remove(&asus->platform_profile_handler);
> -
>   	kfree(asus);
>   }
>   


