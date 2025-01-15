Return-Path: <linux-acpi+bounces-10691-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7CC4A12916
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Jan 2025 17:46:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03D8916766B
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Jan 2025 16:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BD7316DEDF;
	Wed, 15 Jan 2025 16:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iQH4hQnE"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2074.outbound.protection.outlook.com [40.107.223.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A6124A7D6;
	Wed, 15 Jan 2025 16:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736959560; cv=fail; b=Ke9Tnw0HW2FuiL5bsCAsVszZltqnqIlRX9yjGaSXHh+RniHmBIu5tFctdA/AClP0CLyt0sDYuB85Z6xaoIP+O7sliGcGzPtxuzgb474bmfOCH603Nc6d7KqYKkM6l8lE+39JYOxNbrvDE/I1jI9ARsNHeFEkl1vWHW70Ry1p6dU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736959560; c=relaxed/simple;
	bh=jln0sMHtLI1Ha1kvA5nBaTKJ6nemv0nn7DHw/qQdaUc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=M/J+xx3Q3gRnw43ld6BYUHhPtTsTOquZvjks0xV0YTIsTuKTn/e6zujVPz5VYc9oKIjnnuOVeFHQHqYVOnSdkxsUUxPgddHdUz2GxN165q+SArACa2xEO3heZ9xhErvri6BaAYxNacVwA/+3irSj4eeqIETZcxSAdQ016ym8YR0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iQH4hQnE; arc=fail smtp.client-ip=40.107.223.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Px8xLke9HrX6xUcQdfgorF6FlTWH/zKNlggd9qiiuw3a6zmCB/sC8QgcvFuHuzBdqz4mAI3ZqN6VeXYmv9tAxTtbxdWgATXPG8+40F1mQrCPbWngyz+Bdq8CYAyB3aSlqWM6bEUQdA0t9qxJmt+UELRhwUv8xXv4O36pwy4RkpFydslllM2PbBFN5vsMKycvHtUZRRCCXGgKzKokKBPtBOMp8F8lS1qLxXKWIedGDYYM3thYPr+JFUTIGJIGV/qedgM265dA6yL6PCEbERf29k4LW0e/vvfSWo5xlqdOOQJM1qDzCokN0cYvxvnHor7+noYi9vDcYRsbr9f3o7voiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hr4sSCDnjZ6AXLKhhm+RfTim5OckSV31wzJhPpDoTw0=;
 b=Vzcyvgq/obkg1t91ypVHsd56vTfHkuH3n81YCJWyhSyv4PxdLNFUfWg6/9SJfOw1pq2AH7JmabqzcD7f49M+wHQPWqBveP4lMPHhpH17MrYfb2NwK0UH2PCdFn8ChEe/cQy/MnpqdFhaivYuD68dCUeq8JSZxTcsBYzJHTusWu2SkblDugTm7a+52oAY8A/I31W7wFmwhEfwHEsQqAYhUfHllz+cZp1hxDEuVgU6fFPic+/rE7tD5U7psTttMhI1oGyxTHiYSjuh8YMzTGjSDOAgFKEKpOoIMdwyookAXoDTEZZL1okmADr/QFXMkxCTHmKmWZ5lkEH1ReQ/jniyEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hr4sSCDnjZ6AXLKhhm+RfTim5OckSV31wzJhPpDoTw0=;
 b=iQH4hQnE7pcpL5hlaOaZB4zJ4oxA4hc2oypd+BzH0dEF5fDp6xUsEFTuCSchS9BJJyHtTgUp66pk755DbJeiI84/K7muW2IOXo+GIPlrR2qyd8xo6a7k8GFEnie6Xv5I1aPqnV7rXs+mLQLNfYv1bdyuUEtb9SqcNSYd12lDdvw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by IA0PR12MB8227.namprd12.prod.outlook.com (2603:10b6:208:406::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Wed, 15 Jan
 2025 16:45:55 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8335.017; Wed, 15 Jan 2025
 16:45:55 +0000
Message-ID: <d90eabb9-37c0-4763-b87e-696456da4e85@amd.com>
Date: Wed, 15 Jan 2025 10:45:48 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 19/19] ACPI: platform_profile: Add a prefix to log
 messages
To: Kurt Borja <kuurtb@gmail.com>, platform-driver-x86@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 Armin Wolf <W_Armin@gmx.de>, Joshua Grisham <josh@joshuagrisham.com>,
 "Derek J. Clark" <derekjohn.clark@gmail.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Hans de Goede <hdegoede@redhat.com>, Maximilian Luz
 <luzmaximilian@gmail.com>, "Lee, Chun-Yi" <jlee@suse.com>,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 Corentin Chary <corentin.chary@gmail.com>, "Luke D. Jones"
 <luke@ljones.dev>, Lyndon Sanche <lsanche@lyndeno.ca>,
 Ike Panhc <ike.pan@canonical.com>,
 Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
 Mark Pearson <mpearson-lenovo@squebb.ca>,
 Alexis Belmonte <alexbelm48@gmail.com>, Ai Chao <aichao@kylinos.cn>,
 Gergo Koteles <soyer@irl.hu>, Dell.Client.Kernel@dell.com,
 ibm-acpi-devel@lists.sourceforge.net
References: <20250115071022.4815-1-kuurtb@gmail.com>
 <20250115071022.4815-20-kuurtb@gmail.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20250115071022.4815-20-kuurtb@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0122.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c5::17) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|IA0PR12MB8227:EE_
X-MS-Office365-Filtering-Correlation-Id: 6acf3c1d-8226-4f3a-a4eb-08dd358414a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UkFXdEJTU1hMaHR0Y3NFenJZbVpkUVJITmFxVWkrRzhaTVBMcHk5Rlg4a2tN?=
 =?utf-8?B?V0ZNSHVHNnl4N0JQbE1LcDJ1NHVrbEpDZS9EU2EwUVJIOEI3STNuVWxDU0pt?=
 =?utf-8?B?REVRUjkyblRYN1Fsc2dRZERjaENEV1NaMm9yZVFLZ1hyU2x2SjA2U1k5dmVt?=
 =?utf-8?B?WXhyeXFNU1hna05uL0ZqZ1pYR0RRWldyT2JxRHptWTNQSVBVejBNUVJHTy95?=
 =?utf-8?B?cjMyWUtLOXJFbkQwNjA0U0I1OWoxMzBUZ0hkc1hVbHJzSys5UTExc2xST2My?=
 =?utf-8?B?WWpTdXhpZnRHOS9KQ0JuRmVBSVUzQXVaL1ducEgxWXl4M2w4ZkJJWWFab0FE?=
 =?utf-8?B?Ujl2d2FUQWNSdFJFZTU1V200ODkrZk5tVWt0bStnZ05nTHFqdWRzcmR0c2NS?=
 =?utf-8?B?TG1OcVI5WGNmemhEQXY4aDE5bVN5THM4allBRzVNUWF3ZEV2N2M0ZVhrb2hW?=
 =?utf-8?B?eXdvQlVxMWpNdkh0VFVpK0JUd29iUlFQaEpMQWZsSWozMmkwUzh0VWVNTUoz?=
 =?utf-8?B?RDZ5eFpDTDBpRE9WNXlKOXhBbGpiYUljUEhIbzBQMG5iQ2ZtR3FpdGdwOTFj?=
 =?utf-8?B?eTM1Ylk4NzNRSFlPbUZ0c3dCSmhVQ3dPY2o0N3lsZGtBSk5tNVVuUHBCOFNs?=
 =?utf-8?B?ZmM1Y0o5LzRjdTcxUmRKYnRZREltRVYrNmJ4WkI1YjJuN3hHNGVzak43RjFv?=
 =?utf-8?B?a1NsK0Z4RFB6Qm9TSmhvSE4rV0FZUldMK3VJNDJXVTdCVlJRYTJycnZiWHBq?=
 =?utf-8?B?RTIzckI0cHd4L2RyR2R0RnRHbG5odHNnRVM1ZGZCV0dNdXFPaFkycjBkSTRI?=
 =?utf-8?B?ME8zVUgwZDl1MnhTQWE2NUN2SzkwQmV6TXFRMFhYblpnVmNqZlM1TmtEUlNw?=
 =?utf-8?B?N0RpRGlseWNXUTdoR2xzSm42RzZRVXJrT0dJSmpkdnBGK0svOG5qYm1sQ0RU?=
 =?utf-8?B?Tm95ekx3Yk1LbnVyeEFtRTJUcEh5dEZyTnJTWGpwS3gwY1Rsamw5SFBTZ2Rt?=
 =?utf-8?B?c1dVbUlkOHBsUUR5NHc0V2RiODhYM0tpZ3ltR1M4dUx5WmlIOFdTeER5Nnpn?=
 =?utf-8?B?QmJuRHpSRGxaWk5xZmVnWXBsNHVVR2pRUndSUytSQVZlQk9hczBkYTRFU09Q?=
 =?utf-8?B?RnNKMmtYaFJWOWx3T0cvcEFGRFpzV3F4NHdjQU9YTGo2Sjd3bTBPckVEUUVU?=
 =?utf-8?B?cTNYbzZzOEFJWlB6UnY2V2liT3BsQmlzWnRKVXFqREVqcktFVTl4c3gzSEo4?=
 =?utf-8?B?OG84WWJkU3pZdnZhTDRVWGJXUDRpZkdLOFVpNjZ3NHIzK2Z2b3FlNml6WUR3?=
 =?utf-8?B?TzZmd3Z0emNFS2w1K2JsbmlLSlY0d0I2Z1dFMkJuZ25aQTk3QUZQV3ZyUmp4?=
 =?utf-8?B?U3lBdW5nLzFOUDdKcTZaazIvQzJYTExrazdHSVRyd01MMVhPRDlVTFFKNXZK?=
 =?utf-8?B?Nlcza2g3Q1hOVHJCN01LcFRQTUFuUllqZGdaOWhNMUZiNGVCQ3hVVmNPS0kv?=
 =?utf-8?B?bVZ6N0prMWFWQnVDOXpXZkg1VWlBcy9sQ2hhL2E5RWZUcjNmSTR4ZGlhR0Js?=
 =?utf-8?B?QVRLZkJ3d1ZIdzgyb05odDl5bFQ2OFRMaW9GYXZ0SWxseEJ1LzZsaCt3K3dH?=
 =?utf-8?B?Q1VkSzlodzUxWXgydUFQWE1iNHB1ZHdJN3FvbTZKNUx0UzZQd3pvT3AzLzU2?=
 =?utf-8?B?OWtPUzlNanRLcXQ1VVBlcWlvaEZIb1prd1dqNHpDN3I3Z2Z6N0pTNVlWZ2FJ?=
 =?utf-8?B?c1plTHdNSnNiZEFxaTdqczFmclVuODR4TmxSRitOM3pVdGZMb3B6VnFBWDhS?=
 =?utf-8?B?Ymt2R3lxNlV3QWRVN0tGYzgzbHFtSzdpZExMQXU5d2p4S2xJSzVYR1dOOHBp?=
 =?utf-8?Q?17lGn7keDxDJL?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U25aSXZER2ZhTmlaYStPdDBXOHZCUkJaTmluRU80VGpqVUhPU0gyTUlHWUJm?=
 =?utf-8?B?NmxmdmdjcW1WenlSdWpUWTYwR3BSMmErV3RJMkFXOFVBajlQNUJobzFaQTZn?=
 =?utf-8?B?T3VsMHNmVHV4bmtXcDJsRVJnZXhhcjM0MlNwVmw2aStJelRoOWxDMEN4MHdF?=
 =?utf-8?B?YUhmZ2pRVlVjWVJaNWg3aDFYRGtvNjluTlRqczJrbkNCbVFzYkZHemFrU0V2?=
 =?utf-8?B?U1BuNC8rRXVBSi9XUDlJMWhOUnkvdHowRFZBTWh3VHdDbVhmUE4rWHRkdnhQ?=
 =?utf-8?B?OVZYSGdvUCsxS1hXR0pqb3FrWHdmRVRvRUxLUTQxcTlGQy8yS0xMMk56TUph?=
 =?utf-8?B?bFA0a09PRnJCWHIyY09Pc1NXektlZDZ6MjY3K0c4RkFRTUhudmExbEVTdXI1?=
 =?utf-8?B?aXBJUTdCQzRMancvQkswNjdoZTBYRjBFdkFCZGttSUFkM0NjZlljQjdRVWVS?=
 =?utf-8?B?WmdvbUJ4Wkx0eXF1eEhIdm5RbGd6bkY4anhFY25zTS9FSTIxSzNUV3VFaFpS?=
 =?utf-8?B?OUlZMXJBOVdKdlQ4dWQ2azZhbWxScC9IaXducVN2eU1iaW5ORFRrSUlQRE9B?=
 =?utf-8?B?Q2tvQndIOTdVV2U2QjVmeGthWXBRRmpIS1k1SjAyRGlEb085aGVtMXdkS0dM?=
 =?utf-8?B?SDhHbzNpc3dYTFRacSsvQWVibE1wOTRHRUhXVVJaWFRKaVBwQXhGWjZBeThu?=
 =?utf-8?B?d2QvQmZzQ2x1dXozVVVPcldMNUg0YzBXU2NRRWQyREZVMHFtKzY5WTFUWTUv?=
 =?utf-8?B?MXh3QnhwbnkyNFBOS2NnSWNYeTZYZU9XdFF6Q3U3cmhVNUdWUVNRRVR2MmIw?=
 =?utf-8?B?eW9MY1lGUjRTdmR5RURCZHJ4L0c4VGhPUjZ3c3JRN0EzT3pWZHRHWkQ4K3Fa?=
 =?utf-8?B?R3hQOGhxYmM0M3BpVThJcjQ4aWxHcVRielFieUYzZFVmN2sybmVmVTZLTWhm?=
 =?utf-8?B?T0t6WWFKejQ1dTBsczVVdmkzWmV3MHhtOFJXbDgwQXd0MWRQV1JhTG1RWTNq?=
 =?utf-8?B?cnZSYnRBNDRoY25zM1FSKzliWWp2cS9nV0pTK2dqTmdBUjdLR2xPaEJxbXJ6?=
 =?utf-8?B?ZnlRZFhuZndtQm5hRk5xV2llZ2EyTFo3OXNhNHIxRHBlY3ZvUGNkYmprdm10?=
 =?utf-8?B?dUZlQTByMmtqSW9WcTR5bWViT2twcUVSWFdqTFZjWXNWQzJybVRPTU1NK01F?=
 =?utf-8?B?dGhQd1BBQXlNeXI1WXgybGgrTXVaVjdyU0VqSXNyL25UNjdWR3huSGtka0N2?=
 =?utf-8?B?WFErck1pb3JEZDNvbWdMTHVWOUtnWUpua1RjcjRqdGVOUTQ1dHhxNjZpMEk3?=
 =?utf-8?B?d3hMZHRqcStKd0plblJDM21XbHU2ODZzbXlBaTJzSWU2VnBiZkt2OGliQUtR?=
 =?utf-8?B?M0JqQUdlY3Y3amtNaTJxVXpoYllGTUloZjg4aTdiK292SWI0REk2dmxRYUo4?=
 =?utf-8?B?UExqMkZsczEreFBqUUJhL1RPbXNCblNxTVFiOWFSU3FOcjZ1bHJ2QUVSR1lI?=
 =?utf-8?B?SHcvVEtIekQ4YTFSdTdrV1lxc0ZnK0dteEpMVFI0bXFtNlFYY3psNUdOQ1d3?=
 =?utf-8?B?U0trdUZNWnZ6dy9nb2dhVXY3anpsVFpkTTJiTlp5TSttVGRNM1JyaEpJUlFm?=
 =?utf-8?B?VFRWRGhUWXBEcU5IaFg4TnJIUXZZSmhHWCthUVhzQklMRjBXd2JUQUVwZlF2?=
 =?utf-8?B?czRYMVhacXZnUnhpeXVaQ3lhSWJLcDhGZHpNQ1JyUEdYSWFRZWlFTkFHOTRZ?=
 =?utf-8?B?cTBoeVZ2OVo4b2V1V09SSUQ0VnhaZXhaekJkU0gvRG1KY2ljTWtIUVBSbFFG?=
 =?utf-8?B?VTZURXZmSzdybWkyVjFRaGt4a3VUUkNUK3ZPaXVIMytzd29hamgyTVJTWW43?=
 =?utf-8?B?ZG5hRXlqTDFQb0RDc1YzQk1CVEV2MVdjRHMwK1U5UVhEdFE5b0JScFpmTmw5?=
 =?utf-8?B?Y1hMY1J3ZHAzMTFBNU4xUVd1WVREdThDSGRQZlFPNUtVRkozZXNCaSsvQ29z?=
 =?utf-8?B?S0ZYOGlQWndtWEFCdnQyQzRGQ0V2Vmg3KzhHVTBIVUlqZVBKKzVQdndsNy9S?=
 =?utf-8?B?TjdFSVQ3S3J2aTFtZUtpS3krcWhySjdDMnNFVm44djcxQXhHd2hSSG8rRW9D?=
 =?utf-8?Q?sMc56+saSu89bJnPScK3vC3nM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6acf3c1d-8226-4f3a-a4eb-08dd358414a5
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2025 16:45:55.6467
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +b/Dn/WUnjzV/Yf6bFjHcFC9mwRXkGm3VZwBsSDrGLP0vNd1+rzFN0mc5R4CbSgfs69LEppjjw7VnlQkM/SmNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8227

On 1/15/2025 01:10, Kurt Borja wrote:
> Declare a pr_fmt prefix.
> 
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>

I had to do a bit of a double take because you removed the prefix in 
patch 15/19 of one of existing messages.  So this makes sense at this 
place in the series, thanks!

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

> ---
>   drivers/acpi/platform_profile.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
> index 4895f37dd549..c9e46b6e27da 100644
> --- a/drivers/acpi/platform_profile.c
> +++ b/drivers/acpi/platform_profile.c
> @@ -2,6 +2,8 @@
>   
>   /* Platform profile sysfs interface */
>   
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
>   #include <linux/acpi.h>
>   #include <linux/bits.h>
>   #include <linux/cleanup.h>


