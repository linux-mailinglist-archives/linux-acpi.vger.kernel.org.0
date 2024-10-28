Return-Path: <linux-acpi+bounces-9057-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C9B49B37C3
	for <lists+linux-acpi@lfdr.de>; Mon, 28 Oct 2024 18:37:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90B48282840
	for <lists+linux-acpi@lfdr.de>; Mon, 28 Oct 2024 17:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0220A1DF72D;
	Mon, 28 Oct 2024 17:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gTBD4TGS"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2077.outbound.protection.outlook.com [40.107.237.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79941DF251;
	Mon, 28 Oct 2024 17:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730137041; cv=fail; b=VTLXifO/8JoAoyXiMTHPoyAbpBHqKt7vYhKW7XFejxekmtsCGxEuJECTEeQW66z1yIiN6rRA0c6vD3656HxqHr+o2VjixngIHntA05Ve9Fp5aBwQbs4sFrYH1Qp1cS+SUGrvpZ2Te5Qbx+0IxYlJ6KHw1Iub5Lxe1wuX5AvesvU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730137041; c=relaxed/simple;
	bh=+aHgGE8gHqpEnjkJd4Z/ckC87SGG1z3IkI62ZmMwcCI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tma0XuR0Q2CuAvY9wuf5o8E4+NkdtfnaggvmRLMlFakHqiTf6iwkEdOHLvRRlhoDzbbGmUXieEg0PRyrD91L+a8sFzuGr6YC5PCXFM62Ecc8HVM7WofAFqoRT068MpJJuZ2snxtpzpfGZBw4oUSvun9CdV0VVPmTzMyetESgVgY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gTBD4TGS; arc=fail smtp.client-ip=40.107.237.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N4clQMfTl2NRALrBDwC6ytz+nBYlLFsM/wZi9IYRBp5j1bwnVHN1XSbQdCdZNv6Zq2H+/JjqpccIOxfVARzBOtT+7+SA1i4yCYdBmrWPEyydCr8fGQl9GP2zBvAM5Gq76zFHUKjxo1imM6z3564jlHdtieHX8YGktkc5tMxvFiWmYIDLRw5OWtpE4/yL+ndaHhkKGjOx4oVWUZrmhsmD1vxp+ArS0KqD+kY1vG2I30PTbJ/mUNSvsHzfRyfgDa9IUMj2gHthe4osR/jXpsQETtMOpdFRr2/DQSbJ5694OggENTrTjUfhsmXQ2v5hVvZfAUdv8ahahkjVJ/1DW3Fs8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oWoH55bwphRaWv/KjCzxnxw3uli5rftDpSURhvRoLYA=;
 b=pT73z808LATdtqLcu0ARwLvCEHtifA6BTa9B/LM50eWBru7KbGmBiPrzuzodHARg3gCe8HlYZn9hDn2OEvBma6uLybfoTXDBJakIhDl7+Vrn4WJoDBYb7FH1dZR07myzzPpswiLmdj+0cTOGMJk6WMwiS4+Mx92P/BAYcN1djGr/j9x9SLTOg3dEc+duw/LQnDACjszJFABz9UwD7OzaYr8RjlAlp97IEshlqs/pyHZNVDGhlYmA7g3sG94294OR2uJWNbYny8c689TN2AOdkkKUqZftnr4VsH6QjcFlH61FDFbAYHpxYsteTmZKzcZX+Up/yyjk5CgVO3/YS69T6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oWoH55bwphRaWv/KjCzxnxw3uli5rftDpSURhvRoLYA=;
 b=gTBD4TGSjGSW9tBO/UARLyTKyxh6ob1kvDW+89qUscUQaRZ3WetouhFfGOBTHxPF9GO5RF3kgt1bqZPEdXghFTUj9h5mlau6sr/Xc8FecgB2Xv7iApwJDONWER762mhE8SYyXz9dOBe8ZE9ImVbkosWIQRUwwbr0EWg6Z0mjhoo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by IA1PR12MB7567.namprd12.prod.outlook.com (2603:10b6:208:42d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.24; Mon, 28 Oct
 2024 17:37:17 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8093.021; Mon, 28 Oct 2024
 17:37:17 +0000
Message-ID: <3ae71745-4361-4056-9114-27af1caab63b@amd.com>
Date: Mon, 28 Oct 2024 12:37:14 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/15] platform/surface: aggregator: Add platform
 handler pointer to device
To: Maximilian Luz <luzmaximilian@gmail.com>,
 Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Lee Chun-Yi <jlee@suse.com>, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 Corentin Chary <corentin.chary@gmail.com>, "Luke D . Jones"
 <luke@ljones.dev>, Ike Panhc <ike.pan@canonical.com>,
 Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
 Alexis Belmonte <alexbelm48@gmail.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Ai Chao <aichao@kylinos.cn>, Gergo Koteles <soyer@irl.hu>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:ACPI" <linux-acpi@vger.kernel.org>,
 "open list:MICROSOFT SURFACE PLATFORM PROFILE DRIVER"
 <platform-driver-x86@vger.kernel.org>,
 "open list:THINKPAD ACPI EXTRAS DRIVER"
 <ibm-acpi-devel@lists.sourceforge.net>,
 Mark Pearson <mpearson-lenovo@squebb.ca>,
 Matthew Schwartz <matthew.schwartz@linux.dev>
References: <20241028020131.8031-1-mario.limonciello@amd.com>
 <20241028020131.8031-3-mario.limonciello@amd.com>
 <2934c00a-8bbc-4090-ad0d-8bc5f79cacaf@gmail.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <2934c00a-8bbc-4090-ad0d-8bc5f79cacaf@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR13CA0048.namprd13.prod.outlook.com
 (2603:10b6:806:22::23) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|IA1PR12MB7567:EE_
X-MS-Office365-Filtering-Correlation-Id: 14e7ca62-ab36-4496-173d-08dcf7772aba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Nk9KVitNUmdqaWRhdExsZ2pDTnhVSkNIN0hHQS9nS0ozNzEyUXFudlBUcHQz?=
 =?utf-8?B?SkZwVWZqdEdVZ21aRHJwb3c4azZRUHkvK3FtZjBJVkNLajlINzRvSXlCakZx?=
 =?utf-8?B?OUkvZkREb2JiSm9pVWFVcERMc0NiSm5nOXZJdmVlS3BkeUw5QncrSld4NUtX?=
 =?utf-8?B?RG5lVFI0dWJUMXJmZEtEcUZUbjM0a2krRENOS3Z3ZWpQYjlxZjZRVS9mMThv?=
 =?utf-8?B?UmRmN1J4NHJxaGxhNCthdGJ2bXVEbHVRSEZaTy9ZUVFMM0Q1VVZNSWNCMzlr?=
 =?utf-8?B?R3VLRVhUQjd5QjRveklqVzNHZCt1VTkrbkcyWW1SeXJyY3lSTExmRllDVGJs?=
 =?utf-8?B?Q2lqUEg5bVNkQ2xyZmZyNG1DbDNDWVVwWkRPbFVBMGhCUHpYeDVweDI0Q04x?=
 =?utf-8?B?Vmd5Qm9MVXBBTlphTEdzZW1iMk9XRmQxL0ZjOFk5NlpoR3lqTFJVQitNaTFm?=
 =?utf-8?B?VGJtZEw1U3h5dkpKV041T0J4cUcwWkRGTVNVZzVTanljTGFVUiswVW5NeEV4?=
 =?utf-8?B?NDlxaDJMdzd0eCthdENMR3RGY09NdEdzQlBQTFJLWXdKdUVsVEY0TkxXYUFr?=
 =?utf-8?B?aTRlMlpld21ESVcwTVM3SEpzemhBYmNMNzlSbmN4QW9Bc05JWTU2MnpsWUZp?=
 =?utf-8?B?bHIxdlNpUEszNUZMQ0FPTkh2Q3ZENHRoTGJnOE93dFdlUWtEVk5INGg5SVYz?=
 =?utf-8?B?cDBXRXBXNXNYbVRUbGZCZjhpNy8reHRrak9VT1pkaytuWWdPNlZ5N1BRNTFt?=
 =?utf-8?B?UjJ2cEdoSWY4d3pzWXpkOWxMWkg2dkhXTkZXcDUrVFJjRWN2Y3R6ZVhjbWZK?=
 =?utf-8?B?ejkwemN3VnVWOVNCckJTRW9Ea3ArZDgxamtYemR4OGhhV2ZlWTcyTWFBVGxN?=
 =?utf-8?B?RUkvOU81YS9RbzU5ZlhBTTlKOG5YeG9adnJ2SHBFbnBEZHBERXdxbEtpZ0Fk?=
 =?utf-8?B?ZGpIelNWbG9VU2FxUUx3UTdTN3pvOTFuQWhNZnNrTDdySGIzWXpSb2Rnd1lN?=
 =?utf-8?B?Wi9rbGtTbzJZZWxmUWJhQTM1TWN1c3FLWWVUY3p4K2prUnJtSVZiTklOcVFS?=
 =?utf-8?B?NEgvRWNqOHY1cXlQVjVsc3g0SkVEZlJXWE9rd1NrK1pNdnZhek44NW91Qm40?=
 =?utf-8?B?OHlOWXBuSjRFNVo5bnVoZmRmZ2JJM2xwQlFPYWtacm5MZ1ZSd09DL09WWVVX?=
 =?utf-8?B?T0t1NXJYYVYyeW1rcmh0OGJuN2NrU1ZWcWt6YzZmSHlnZjRUUTZXbXBaTjJn?=
 =?utf-8?B?d0VibUJJMllxN2RJOVRSdGdQU21SNFF6eHQyVTdPOUVGdU55clRpM3RPR1FL?=
 =?utf-8?B?UmxwTHdFblR0NzVSWjVwRDJvU3NVQk0xMmUwWkVBd2ZVb3hmVTdYS1IvRzZy?=
 =?utf-8?B?SWduYkcxMkxKNE5NcExWV051S29sK2Z2VTJyd2t3YU5LUjBEQmtUcjM0UDNJ?=
 =?utf-8?B?T08wNUI3WVd0QWwzTVoyTFJZMXgzNThCUHVlVEdFSUlMVUpFNWFrOXZ2R0Jk?=
 =?utf-8?B?b25WYWdZaFNmSzhneDYyRE9EQ1h4S3QzVTZpY0VWcGtNS1R0aEVkNTRoS0ZU?=
 =?utf-8?B?TnNYMjRyQkFiNW1ybmlxMlI2R24vVkpYTUF2ZUY1N25lSG5meFNXVmFvRklD?=
 =?utf-8?B?Rkl0cWh2djNwbzlLVXVTR1BwZEJHS1pIdEFGWG9DekFRbW1ISVR6SG1raXlN?=
 =?utf-8?B?MGhpaHBPMWJPTkFrdmNqODhGL3U4SDdTRTdwdWFSQ0tRNTZ0QnVyaDY4UGYx?=
 =?utf-8?Q?GSMya71QL85Ausrr/O96B4gd2pG6afmgyvuVqGz?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U0swRWdYK1drM0ZDQTlMdE01Z0JjY3pqTEhLZys2ZnhUbmFMT1EwTWVVR2p3?=
 =?utf-8?B?K3A3QnZIc0Qwem9NaFdETFBaZjYxTG5ScVkwbHZsZzU5bU5EZWV0NTU3UmJN?=
 =?utf-8?B?SWxISkkvbnJRR1FkZ1czQTNSZXVkcGZOQmpUTXRTQ2FUSEh4anphZWtXbzJE?=
 =?utf-8?B?Mlp4K1hzV2hjMUMrL1g4aHFod1R5ZTZsZjZkTG5aOFdrNFZ1cDZLVWFIb3Jy?=
 =?utf-8?B?V1lYMDl2UVlFdFNwYzlwbGRHYmhpZnMwa1VVK0pnN1NBU0kwbXlSTEJGU0Q0?=
 =?utf-8?B?a3ZJOTBEM09McHl2VFVMNkhoRExJelBQNUVsY1UwaEpLRWxHdDNvQkQ3SytO?=
 =?utf-8?B?VjhBRWIzcG5OaCtnV2xYcytBazBienpxOVRQV0FtQklqZVlkdUptTlJjcXFK?=
 =?utf-8?B?V0NueHhvZ2h4UlRkRjY2VzRLQ2dyNDgzRkJiOXE3d1MxZFoxaXRHV3hEbFIw?=
 =?utf-8?B?OEwycTRpMW5HQmlIVGprellFUnIwengrcnBNeCs3QkRvVUd2SU1CYXNZd2lw?=
 =?utf-8?B?VEpnMERkOXovSC9pTFF5Q0xPMEdXL0V0U3RkdnRWR3VCVmx3MnJLd2M2Nkpn?=
 =?utf-8?B?MzBpVThqUHVzKy9xMHlzZjdkZTI3NE1tSm1KSENVU2hXYWYwVWtLcEt5NjZ4?=
 =?utf-8?B?K2taNWVUMGZyeVZScHVqQnpLRnFWNm8wbmJwVmkrVHJ4R2l1SVY5NW0vaGFG?=
 =?utf-8?B?cVVIM2UyMW95dnV0NXdZRGhPQk5LRzlTcWdhZDBBUGlWOTJmNXRYNlVZeGZW?=
 =?utf-8?B?RG5EckJxdVRJQzdNQzMydk1hMWgwQ3RNUHNCcXBOQ3U3bE5Xc0dGU1lGYUI5?=
 =?utf-8?B?L1l3S2R3VEJxdVloSW96cmo3Z3BCM3Z4eXhXODd6VkpTa1hQQy9JczMxS0gv?=
 =?utf-8?B?S3k3OTA4aW5SbG1TaHlEQk5IdGw0eXlkb2FWZlRnTXlxNW5mbld5MzdOTVBD?=
 =?utf-8?B?bmlUMG01TURyTUpRa1VVeTAwK2JUSzM2aG56Vnd5dktxUEdwektPRlVvNU9V?=
 =?utf-8?B?MENUZExlNDFoemtKeS9sSi9qZzVRclpxTDhRbDFBR0xQMXBST2pDb3lWMm5t?=
 =?utf-8?B?eVF5bTJpRU41VlQwb1I4V285Wno1VkhGRzZyRnJZQnJIbXVsU1hWT0x2N0JC?=
 =?utf-8?B?bkIwZTEvVURNUXVZMmVIdHBsU3V0OFFyREUwcXpWOW1BRjFmOHJvUW9ZOVh3?=
 =?utf-8?B?ME5uS2U1WS9QeWdrNXVzRVV2MXpUNyswcTdYYzRldHI5QS9GYWFac3FjSkNn?=
 =?utf-8?B?M2FZQ1daYnVQZnV1TTl3VUtjNGRVaG1kWGhtNkNVZTZwU1pGYVdJZlZsd0hp?=
 =?utf-8?B?UGlZbWFtQ3Ryb3d6OW9TSTVrT29KYXh6UWdUTFZsVDFza1czbC82ZjJVeWVv?=
 =?utf-8?B?YzdseFdnZkNFT0VsMVNtQ2FUL09qSHREUWNzMzVHM0c1NEI1U3dtaW5HYmcy?=
 =?utf-8?B?U0h5RmJUaGY0bDJOZlA3aUZzM2E5WC9tN2lYeFJ1NUxLRU5TNmx6RW1ZZkFB?=
 =?utf-8?B?ZHhaNFlxSGozajRNQ2xZbXRNZE10SUpDcnllNS9sY0loZnVQTXZKODJENE5N?=
 =?utf-8?B?ZFZEd25KbFdUczV1MW1xZ242elh2cWRrbGJtaXlWS2NUZ2k5d0MvWnJ1ck80?=
 =?utf-8?B?SE1abUhzMzZYa291UXZ1NTQ2MkVZbjVDaWc2ZFpIeHQzSzlxcCs1cmY1SzBu?=
 =?utf-8?B?VmV1bTFNR2doWVQ2MndXOEd3L3JBS2srajNvbWowZU01UmgyeHEwWjhXRjR4?=
 =?utf-8?B?UUdRWE82ZHQwWmJQanAvVDMwa2NOS3VpRkRJYkZXdEVaUlI0VERoMldqbkV4?=
 =?utf-8?B?RnpvMGFOSzloQXdhN0huc25XNEQyZzdUa2RJSjhoY0dpRDNEWGFZK1RUaEJw?=
 =?utf-8?B?MmFIY3E1azg1Z2hxM1h3UHpqT0Q0Q2E2Y1RMbmd2NzczUkVYMXpaZVM5MkRM?=
 =?utf-8?B?SlZ3K3lXWERyQmcrOHdxeXVQblg1OVQvTzlEbGhUOWMzZ0x6WHZ5ZG0zaEUz?=
 =?utf-8?B?Z1VocnRVbytKeHAyM24yMmFuSUFHcFNRL0czZTdZZTU1RHF4QTdsUVM0VkRR?=
 =?utf-8?B?UGVteHdZanR4K01hRXg3Y1BObGRzWmJFTm04akdYK0xOQlBudjlJTU1tY0lQ?=
 =?utf-8?Q?Rhy73q9eMeb2YLRowjFzCiMMQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14e7ca62-ab36-4496-173d-08dcf7772aba
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 17:37:17.1341
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qWy+NlFwF9tYpFBwqJICXYFGmZM8uG0lQtQlQJUFPgEDK8duYnyYfHidyDW3UHo+SPKkLGmpwefG1MPFflGQng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7567

On 10/28/2024 12:30, Maximilian Luz wrote:
> On 10/28/24 3:01 AM, Mario Limonciello wrote:
>> To be able to reference the platform handler in remove, add
>> a pointer to `struct ssam_device`.
>>
>> Tested-by: Matthew Schwartz <matthew.schwartz@linux.dev>
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>> v2:
>>   * Use ssam_device_set_drvdata()
>> ---
>>   drivers/platform/surface/surface_platform_profile.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/platform/surface/surface_platform_profile.c b/ 
>> drivers/platform/surface/surface_platform_profile.c
>> index 61aa488a80eb5..a18eb93eebb92 100644
>> --- a/drivers/platform/surface/surface_platform_profile.c
>> +++ b/drivers/platform/surface/surface_platform_profile.c
>> @@ -210,6 +210,7 @@ static int surface_platform_profile_probe(struct 
>> ssam_device *sdev)
>>           return -ENOMEM;
>>       tpd->sdev = sdev;
>> +    ssam_device_set_drvdata(sdev, tpd);
>>       tpd->handler.name = "Surface Platform Profile";
>>       tpd->handler.profile_get = ssam_platform_profile_get;
> 
> Looks good to me now, thanks!
> 
> Maybe this could/should be squashed into patch 03 now that it's just a
> one-line change, but I'll leave that decision to Hans or Ilpo.
> 
> Reviewed-by: Maximilian Luz <luzmaximilian@gmail.com>

Oh yeah; totally makes sense to squash now.  I'll merge the two patches 
for the next go around and pick up your tag.

