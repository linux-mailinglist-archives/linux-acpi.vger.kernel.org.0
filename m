Return-Path: <linux-acpi+bounces-9653-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B0E9D1F1F
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Nov 2024 05:13:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD42B1F20FD9
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Nov 2024 04:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F7621494C9;
	Tue, 19 Nov 2024 04:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AbOyi1ex"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2087.outbound.protection.outlook.com [40.107.244.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F4F1459FD;
	Tue, 19 Nov 2024 04:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731989608; cv=fail; b=YDHbDs6jCuAzH7Smr0YdzPtJYcIai6zMBZf/TKiA/OGMswynNqsbfpd8UbrhnqyaB+5NZjMRf/TXhiRnYnGU1y10r2NsY9dwKDrEP2zMZJUfhwh6VwS7Qtc7zW6hJBxj4XYyBTHeArneh1kH0d9Q/myZeLHYrecpfrzff6JK9NI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731989608; c=relaxed/simple;
	bh=ULJMVG5m7NRPCxcf06aUC9FjbJhctfPNRzi2A49v0KY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZIw9ee9psVkb13OxMmM58DYFmo148rUSaqM5RetT4pjmAN6jLzW0rArzgpad2Yfr/0y+5XXm1mlo1oznf0nxGhLKXzdW5r3l5NHJksarLfOmvuSS069tDV9v7vUaAyrnOwaI0xjBCAiC3Wp5/NzAQhAwhvFAFf8WZVPHHg2kPcc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AbOyi1ex; arc=fail smtp.client-ip=40.107.244.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nlF2gEFrV4KlmyIitmUzlaFh7e08C4eddo6HLK+xW92Tk++8bjnB/oNPz0JStFOAXJXL8NveNTgkx+RpaDqwEreeTQZ4pYPx+LEqkea0qDeJHJLHHUohUOGx1wUkUYUNt3vV2XNPd5/xZcRv+Tdbkug2Fy7ifkmHn9mg6Lca3Qt82hKgXgV1nG/P4T3MA1Xa7Sj9nUFCSadAej7AVLWNPGIDpSd143y+EpO7gy/CHAowWvAQ6KN+3O07ubWPpYeack8Qsjv9neh1g/7JrRWe/jgkpH9NbDOzkPqtE3S6QatlibztULfeOAa4OzmtgAZCf/dnQuFEbLK5qkjHnYlgUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qD4BE6S5JQdsuovGwlyBHkPulveEf/BWRHtaVlMgyfA=;
 b=KEbuSygoqaZIBwR7B3UcwzE1bOuDz0tsK8GAcmSehudnBsUZdHVcw7ocnuw/8ZQiJPbjjyQtxwsprUcZg9lX+lcB+4UPOyFNTwak9I9GNlNMjjHj7LiOPDmKNAzCclw1VAJGCHUYywCBN7+Fnl+LNGu6Am0T/YfBGSQcVqojm7r/vi6eVU4XxQEOgGOZ0qSf5uh9da+LPAxM6bMmUeWmjmU3tnrDoQnvPnYXVilwqpELJ+L671dpEGpJg73ZcXhtyhjyFmxybhbYWlEtSltBgCfCI8Ok/X3OiWA1AZSuMWYop6M14XnYqoWh8kpKCDaJn64zBJE0cWn4Hn38KDqaDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qD4BE6S5JQdsuovGwlyBHkPulveEf/BWRHtaVlMgyfA=;
 b=AbOyi1exT8so4on8fmkvw6Z0q/ermi519hrV1hFG+9N0IbyNVAEKDz3LXiOWACMxixkt1uqsY38buHtd1zliQQ+Kvln0KKUu5qG/HninwSqNchBuRBk9fMIBW6HGEkWAxFd08Wv3j49oW4HyvvS7xo69ceTo8zYpqNedH8uZFPc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by IA0PR12MB8862.namprd12.prod.outlook.com (2603:10b6:208:48e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24; Tue, 19 Nov
 2024 04:13:24 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8158.019; Tue, 19 Nov 2024
 04:13:24 +0000
Message-ID: <b6a4e31f-610a-42f0-8e3e-970d3610384b@amd.com>
Date: Mon, 18 Nov 2024 22:13:21 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/22] Add support for binding ACPI platform profile to
 multiple drivers
To: Armin Wolf <W_Armin@gmx.de>, Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Maximilian Luz <luzmaximilian@gmail.com>, Lee Chun-Yi <jlee@suse.com>,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
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
References: <20241109044151.29804-1-mario.limonciello@amd.com>
 <7d06c91a-bf89-4880-b640-1fce38d51036@gmx.de>
 <c05d3199-03e3-4e60-a1a1-19e36150f3e3@gmx.de>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <c05d3199-03e3-4e60-a1a1-19e36150f3e3@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0031.namprd11.prod.outlook.com
 (2603:10b6:806:d0::6) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|IA0PR12MB8862:EE_
X-MS-Office365-Filtering-Correlation-Id: bbf19c7e-c0a8-41fa-1266-08dd085082f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MjdPdDkxZlZtRE5IckQwQVI4VjZyMEJWZ09DTkd3ZEVtdkU5N2tZSG5aSWRq?=
 =?utf-8?B?bHVuUUtNWnhJY3IrMTJsNW9MR2MvYW83UmFrejZreDdUVlFZYm13OXNITFIv?=
 =?utf-8?B?LzZha29nbGZWeUJyZDNvRkJyVW9hMEc4cjh1Q2FCWmtySDIwMFdOM3ZQQWsz?=
 =?utf-8?B?clp4NXRqeEJqVkFBVkI5bHBiV0VEMWlYK0hCMXJzOVVYYlh4Nk9tN1FzeFRD?=
 =?utf-8?B?LzBwVmxFUlZxNHVib2pjOXlyQlNFRWRUUWVuS1FibnNZQmVNQXEycmVBeDgw?=
 =?utf-8?B?Vmh6QW5UTzNMN0J4VXUrQVNzbHRDUnZoV21zWEIwWnVwZytodThmU0xoUlpK?=
 =?utf-8?B?SEt0Rjh5VTBCTG5Gamw4YlhQWWx1NGV2WERqV013ZVBzVU5DOXFoSFVWSTNK?=
 =?utf-8?B?Vkdxa1k0YmNzaDE1KzJGaHdjU2JBaEFwM1pSaE9ONURmZjNQK1Z1ME02Y2dl?=
 =?utf-8?B?NnFYdkdOQ3hDV1d6cWJLY281QkZjcnIxQ051S3VwNWNxVlRsYmF6a1Qzcy9I?=
 =?utf-8?B?UTkwcGxCV0w1QzhBYzNGblBpTVhEM1JtelZKUTNMK1JVbGlMdi9wbk44OUVv?=
 =?utf-8?B?QnNJNlZiZGRsdThRV1VEZVRNaVNlU2JiQ2hiWlBrcnlXbUhnQVRCeDBETVVO?=
 =?utf-8?B?TVpObkMxZFNOUUNQY1hEbWJHTjVaZFpYZ2thMkVGQ29qWkVyMTZlaGlWcHRX?=
 =?utf-8?B?Z1FBeHhmSlJnK0tjWFFhOWZCRXFySG1VVUxjbXlaRFVrTjI5UzBnYXo1Zk8w?=
 =?utf-8?B?ZUYrL3BrQlRWSm0xSmhSNjA0eC9RUnNhOUhEWGZGRFhvRzFWS1ExazNNaDdF?=
 =?utf-8?B?eXY5MmlxdllCakFNN2QzSXY1QWZ4ZTdxT2JEMks5dU9TQjBzNk1JRUdtalIr?=
 =?utf-8?B?czZmQzBoMVRCRGExK2RNVytoU0hhSEtnZEVOSVVZcFFuaCtyQklaWDNpRnlV?=
 =?utf-8?B?UXB6NHdaTFRJMVlmSEMzajBVK3p3SGlsejV3Tkc1VVZkTHgzSzhDaldBck10?=
 =?utf-8?B?RHM0Q3AzQnhYcE1lQ3ErQitLbTlxdmExb2pWY21iRW9TdGhNNW1oRUU0bFNa?=
 =?utf-8?B?eWRhN1BFKzF5dXpKK0lMUmF6NnJKYUhvRzdqQ29hN011RkJtR1R2L1ZobzhS?=
 =?utf-8?B?SExMZVJJdy91ZS9tb2lEVlo0Uk1yQ0p5eThOeS9oMklFWWQxdytYMjZZVUZh?=
 =?utf-8?B?eURFM1g0aEcwTU1velhwR3ZaU29RQkdJMVlOcmh3aVdLaE9pN3gwdk5hR2ov?=
 =?utf-8?B?ckZHSlVUQzA2RFl2WWdHWFg1blRsMGEwMThnMXJZVk11MWFabjFyTmJXZ1lo?=
 =?utf-8?B?azN6TUFNbWdkV2RlblNLUlBLOWl5SXBQVDdLZUhyRGMvM2dBSThudnVHYndG?=
 =?utf-8?B?YTF1ZUtZQklZMGZWWU1hZ1phbXdpMjBCc0t2ZkxXREdlamEzTEtqbEpIQXVS?=
 =?utf-8?B?bGpYVHVwQTVuamZyVHc1NkkrRUpVY0FSMUgrWWMrR0t3ZTFjS1Z2TVBPSUJh?=
 =?utf-8?B?d2N1cUtNeTREN2dhLzMyNjZ3UzRXNGltWnRITmxacnR1L2JXeVRHNWlsZDBW?=
 =?utf-8?B?cThVMlUvdUVSRGg3VW0xbm5BRXh6dlRJVEM5blh1U3Z1Ny9JY2NONHdYR1ov?=
 =?utf-8?B?eUY5cnpJckpsZ2dtQzhyQXJ6S3lsOG9OMlNzNVlWYVBIOWVoaHBSUTdDM0lk?=
 =?utf-8?B?R3ZCb2RpaDY3L1AxQWhoajRYS1BFUEpHeVBVVUY0b1VZOHRmSkdya2FLMzFp?=
 =?utf-8?Q?gWI6itN2BHN+gf5b5WwpMDaDzzUrU/I36O+2T+Q?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aFZyaURRclRhdUo0aDhDTXVCTmtacFZ6dUR5Z1RtamxkaXMvZTVpZE1kS3Nn?=
 =?utf-8?B?b1RJSkEvYmRBQUorS0Rha3c3eXgrYnIxRVZjK3ZHNzd5UUIxaHB4RmNVazZi?=
 =?utf-8?B?UHBWWVRoaUlrWWtrYlZQZFJMNzRybUJZNm9sUUMrR3hnMStUanBMZlJjeHpP?=
 =?utf-8?B?dVo2QzI0ajY1M2lWelBvZ0IxVHlFbEpwNzZiOVlJSmMrMHM3RDN1VzYxWmlq?=
 =?utf-8?B?bjI3ZlJUYUEvKzg3czJDYVJqMXdyL0FkT25Bekt5SmV1ckVOT014eUx0a1hw?=
 =?utf-8?B?bkd0T3I2UEltVDhYSGNtdW5qSFBncUpkUGxuc0s1eEx4MWIwNm9DeWlkR21N?=
 =?utf-8?B?eFh1MGtEMmU0YUErMUg5eVhlSEVQTDdKZ0YrcWZneXZCYjJQd29hRVNlamRI?=
 =?utf-8?B?U1lTWktsK1JQaVR6NjhtVkhhWHRtY2JMeUI3RVJkR1Q1UFlhenpTUTNiK0xL?=
 =?utf-8?B?RWNpM2kzVStGRTRaWis4TmVxUTdDSkUzQkZQTEE2MlJpbzNTQk1CL3VVSzNY?=
 =?utf-8?B?Uys4NHpPaFY4NHRnUmxCR0NzZEZudHVYbjdBZkU0RW1BUnkzVU5mZFdoMGVw?=
 =?utf-8?B?dmtzcUh4UUxidTVwUFdzZmVmS2E2QXhKVk5lVW01aVJrOEFJbGRwU2ZUVjZh?=
 =?utf-8?B?a21obWVGcDR3N2p0T3I0d0tldExnclBHSkNUek9Za3E3dGUxUi9vZXZqSm45?=
 =?utf-8?B?RXBWZUdiNWk4QjhSK21TNFhGQTJQcFMzcnZ6M1MxbWNSVjY2NTR3OGJBeGJ0?=
 =?utf-8?B?anNEbmxKbDZqWEFPblB4UlI5NUJMeWd1TFdhd2gwQ0UrZlByeWZneEE5TWdN?=
 =?utf-8?B?TVRTbXRxUFJWc3lySzRrWmxtOUlWMU9zNXM1Q1FSZGhnRlh5NDhxRkl6bE5u?=
 =?utf-8?B?OWNCV3Q5MDh0SHVXcFpOVW9DVW93SkpYN3MyQmFLQ0VTbjhSOTBtSVNoL2Fw?=
 =?utf-8?B?TkNmMTNkd2ZGQlFOUzhRUTk3dEpFai9zcnhCU1Q0SXpQZ1V5WmFvYnhTWFpU?=
 =?utf-8?B?MU12SWIvYWYwaUhJcytaUEEzTUdjd0hFRElYai9tN1hDV0c4VHRiTll5Mzli?=
 =?utf-8?B?VGpWcWRNbHAvZnVHQUFhQ2pHYVRwalY5aEpIRlFYRWNmSlUycXU4ZGdvcjZM?=
 =?utf-8?B?SWVCV0laNDRoOXYxbHNaRHdwNG9ka0txc0VicTJVajJqTWhrcG5Fc0J1TFJH?=
 =?utf-8?B?c3d3WlZrRncrV2RHN21WYzBLNWRiL2Z1alg0cHU5MjBibXZ4K0xFbWdyOUJG?=
 =?utf-8?B?L2hnWlVnM3JUNjVMZjZnSkkwQmFoWXliYTUvMWhNMnNGUm8zSElMd09vMHd3?=
 =?utf-8?B?ZExnVmtnY0k0YThtT0NJZEd2NjN2ZHZlelFxNVFQNERrTTJrSWJnVFhydllP?=
 =?utf-8?B?RTRmLzdkNG9zbWw3UngyaG9WeFpsT0ZXQTJoOFZVNXBpK0paWjEvY0N4QjNj?=
 =?utf-8?B?ZHhybXRqblZrRFIzZjczY1RFT2RpUFpSU0twOUI1SHFUZXlheEdjWjlnRVpm?=
 =?utf-8?B?cjZNTTdzNWlyK0tGS3d1NjdmQ21KS3p3bWVTaGcza29zUzVldHQ4NytVblh6?=
 =?utf-8?B?b3QyTTBhbCtWY2JhNXlqVHE4Y0YzWFZvd2tqNjQ1TFFWdk9pb1lrbDJjNFVY?=
 =?utf-8?B?UU1ucG0zV1JCTDdxbmxtU1hEdkNBN3pKT2pmK3AwQ1drTG9pdUFoQlVZc21x?=
 =?utf-8?B?dUtJRzhrTEgyL2U2eVFvV1Vzc0xqTm1mbFIzRk1pUFRtYnc1TEhlTmhwTXlG?=
 =?utf-8?B?WUlGQVNiUGRJNUdEZzdYbGdvc0FNQW82YjRXSnpxa2ZpdC9kUForTjlIY3Vp?=
 =?utf-8?B?K2dzbG1sRGl2bjlybW91RVJvY2pBdEplT2xUOFg4WVVlZm1wTFNPSm5kcUZi?=
 =?utf-8?B?NXZKdmx4QVhnUEFEVmhQKzZqMU02dnkyVUdKNzYwT20xYjFWUDhnaWRZN2dy?=
 =?utf-8?B?QW9SK3dXVHVZQ3pIckFWbUVOTWlrcE5lVEVBTE10MWNFRThkSGV3cGFJNlNN?=
 =?utf-8?B?VHB6Z3g5RDc1TzVFaldiVnc5MTBHY0I0Yk9sektHWDNtZ2IrU1owSTRMVmVF?=
 =?utf-8?B?THV6SDBQYUdCb3Uydys2d0pkbGJxMEo1UzZDUVoyK2J5RTBYZE80cnFkdDBE?=
 =?utf-8?Q?3kdxL/miOs7VR/FBwt4W5KaIY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbf19c7e-c0a8-41fa-1266-08dd085082f4
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 04:13:24.5236
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nXEZblpGtX+kMPeCOPcReLY8OENcAoC/spaPXcWTTMgbTmH+Qr7+tH0aiaBtxyMpWbTsssGM/t3lEXjOOW51Bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8862

On 11/18/2024 15:05, Armin Wolf wrote:
> Am 14.11.24 um 22:57 schrieb Armin Wolf:
> 
>> Am 09.11.24 um 05:41 schrieb Mario Limonciello:
>>
>>> Currently there are a number of ASUS products on the market that
>>> happen to
>>> have ACPI objects for amd-pmf to bind to as well as an ACPI platform
>>> profile provided by asus-wmi.
>>>
>>> The ACPI platform profile support created by amd-pmf on these ASUS
>>> products is "Function 9" which is specifically for "BIOS or EC
>>> notification" of power slider position. This feature is actively used
>>> by some designs such as Framework 13 and Framework 16.
>>>
>>> On these ASUS designs we keep on quirking more and more of them to turn
>>> off this notification so that asus-wmi can bind.
>>>
>>> This however isn't how Windows works.  "Multiple" things are notified
>>> for
>>> the power slider position. This series adjusts Linux to behave
>>> similarly.
>>>
>>> Multiple drivers can now register an ACPI platform profile and will
>>> react
>>> to set requests.
>>>
>>> To avoid chaos, only positions that are common to both drivers are
>>> accepted when the legacy /sys/firmware/acpi/platform_profile interface
>>> is used.
>>>
>>> This series also adds a new concept of a "custom" profile.  This allows
>>> userspace to discover that there are multiple driver handlers that are
>>> configured differently.
>>>
>>> This series also allows dropping all of the PMF quirks from amd-pmf.
>>
>> Sorry for taking a bit long to respond, i am currently quite busy. I
>> will try to review this series
>> in the coming days.
>>
>> Thanks,
>> Armin Wolf
>>
> So far the patch series looks quite good, but a single issue remains: 
> the locking around the class attributes.
> Maybe someone with some knowledge about sysfs can help us here.
> 
> Also can you please rebase the patch series onto the current for-net 
> branch? This would solve a merge conflict
> inside the asus-wmi driver.

Yeah; I've done this locally.  I was going to wait until 6.13-rc1 to 
send it out, but I guess if we don't have any other merge conflicts 
coming in this code I'll send it after we are in agreement on the 
locking and I do some more testing.

> 
> Thanks,
> Armin WOlf
> 
>>> ---
>>> v6:
>>>   * Add patch dev patch but don't make mandatory
>>>   * See other patches changelogs for individualized changes
>>>
>>> Mario Limonciello (22):
>>>    ACPI: platform-profile: Add a name member to handlers
>>>    platform/x86/dell: dell-pc: Create platform device
>>>    ACPI: platform_profile: Add device pointer into platform profile
>>>      handler
>>>    ACPI: platform_profile: Add platform handler argument to
>>>      platform_profile_remove()
>>>    ACPI: platform_profile: Pass the profile handler into
>>>      platform_profile_notify()
>>>    ACPI: platform_profile: Move sanity check out of the mutex
>>>    ACPI: platform_profile: Move matching string for new profile out of
>>>      mutex
>>>    ACPI: platform_profile: Use guard(mutex) for register/unregister
>>>    ACPI: platform_profile: Use `scoped_cond_guard`
>>>    ACPI: platform_profile: Create class for ACPI platform profile
>>>    ACPI: platform_profile: Add name attribute to class interface
>>>    ACPI: platform_profile: Add choices attribute for class interface
>>>    ACPI: platform_profile: Add profile attribute for class interface
>>>    ACPI: platform_profile: Notify change events on register and
>>>      unregister
>>>    ACPI: platform_profile: Only show profiles common for all handlers
>>>    ACPI: platform_profile: Add concept of a "custom" profile
>>>    ACPI: platform_profile: Make sure all profile handlers agree on
>>>      profile
>>>    ACPI: platform_profile: Check all profile handler to calculate next
>>>    ACPI: platform_profile: Notify class device from
>>>      platform_profile_notify()
>>>    ACPI: platform_profile: Allow multiple handlers
>>>    platform/x86/amd: pmf: Drop all quirks
>>>    Documentation: Add documentation about class interface for platform
>>>      profiles
>>>
>>>   .../ABI/testing/sysfs-platform_profile        |   5 +
>>>   .../userspace-api/sysfs-platform_profile.rst  |  28 +
>>>   drivers/acpi/platform_profile.c               | 537 ++++++++++++++----
>>>   .../surface/surface_platform_profile.c        |   8 +-
>>>   drivers/platform/x86/acer-wmi.c               |  12 +-
>>>   drivers/platform/x86/amd/pmf/Makefile         |   2 +-
>>>   drivers/platform/x86/amd/pmf/core.c           |   1 -
>>>   drivers/platform/x86/amd/pmf/pmf-quirks.c     |  66 ---
>>>   drivers/platform/x86/amd/pmf/pmf.h            |   3 -
>>>   drivers/platform/x86/amd/pmf/sps.c            |   4 +-
>>>   drivers/platform/x86/asus-wmi.c               |  10 +-
>>>   drivers/platform/x86/dell/alienware-wmi.c     |   8 +-
>>>   drivers/platform/x86/dell/dell-pc.c           |  36 +-
>>>   drivers/platform/x86/hp/hp-wmi.c              |   8 +-
>>>   drivers/platform/x86/ideapad-laptop.c         |   6 +-
>>>   .../platform/x86/inspur_platform_profile.c    |   7 +-
>>>   drivers/platform/x86/thinkpad_acpi.c          |  16 +-
>>>   include/linux/platform_profile.h              |   9 +-
>>>   18 files changed, 553 insertions(+), 213 deletions(-)
>>>   delete mode 100644 drivers/platform/x86/amd/pmf/pmf-quirks.c
>>>
>>>
>>> base-commit: d68cb6023356af3bd3193983ad4ec03954a0b3e2
>>


