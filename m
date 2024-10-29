Return-Path: <linux-acpi+bounces-9085-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 492259B4FCF
	for <lists+linux-acpi@lfdr.de>; Tue, 29 Oct 2024 17:52:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9353B22A5C
	for <lists+linux-acpi@lfdr.de>; Tue, 29 Oct 2024 16:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E0221A0700;
	Tue, 29 Oct 2024 16:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="a4Hm9BTI"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2085.outbound.protection.outlook.com [40.107.236.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE6E19D072;
	Tue, 29 Oct 2024 16:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730220723; cv=fail; b=Ya8jRtfrjSCpZXYwjgHzZtc6iNEKszaR0elYMLMWTKTBgLFouS+JYLQBSFENzhaUgocs2hb06EOx4HLnG9AjzbVv5kBsAs+ohtvpKBUuaONUNYqMH5HYLVE+4E7isdcIgY/VMB67JkYOzDJ6szaAAfeI75mz+R2OX/jBCcO8ad8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730220723; c=relaxed/simple;
	bh=fDL6F6vY+/tvxmC3VMAv37NvLtA6orVUF/l74+5K304=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KG3y6giR8mIiFd8bu7kb+ZR3Uh263nZihkkWhj20yZ80bv5mLSK+DaZXuOgyI51+71AMvhQbXxSeTCjWXhlmsVqCmYMJIbW9iRaJGRRYefCNiC8rDRdUjBfeMRm7SQmvHzT6rAgcnj5+8tehCPU9ZmqHJbqs+9vcEmf9WjDp4hg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=a4Hm9BTI; arc=fail smtp.client-ip=40.107.236.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bTzI/GpryHt3E+6mGGnpv4wjK5UYPz3sZDkf3vwQF9tnAZ/fQaEzmBIRI6TTtx1AKeX/ahdb/RQm+lS594WZPGMSMOGFXq7d2oVUs7pC8MvJj9HCZzLY3D8fUrRx3RWtkZ4CsP38KJvJ4bul3VPbLSN9iUc8PlOaX95XhlR6lBhtxYngd1RnZ21ycZCmr4hdef9UVgo2mmpt6rjSSmDCsnqhtkvw8ctq0ADo0K1uisx+vuo/W9JQ6zoI4zkCE8q6s4lVFCl6PAu2WQ2vu/zp/u1H2rAprNnzmPTKmx72VwDZocQywNjLt2Q6ColbCKCOig+x0Ot8xM3kjWhTC9uHpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PGQN28mdEpiE0/bOJpli3AlxDv+zHOn1QEphvhKnTFI=;
 b=dyE1/ZXbRfEhsLcYeqawNTll5jyv7QTXbDVfljwmyJ/2Srx+1ROzn6McmapHeP6cyYo5rB3aXrYxq/CCf2DoVyBF1AEffHgWXtKbf6r0IOubDhbRFOml10XNmh5gi8r27AyL06XPCSdhccnrgm0f/2vn+fFuxGM25qKnD/cvBbRLH84Y/4g7Ug+x/wMEZ9qB11GOVXzoPLey8h0rI41CQGvYXFG9I/1e2SmoBH8IP7BkYq/GKD3y8T8Zqhw9QaENB/RH9k/l7ZE15vY2uX3qV6e0g9Z9m8SRQYpxMqcdxrmjxqJyMy16OviuVq8bdh2SQk29gBF43IBv5fmmWIVYww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PGQN28mdEpiE0/bOJpli3AlxDv+zHOn1QEphvhKnTFI=;
 b=a4Hm9BTIzAzZlxbV2qXmxWhNP9uycJy/MjcBHVdj+VjjHa2JABDGYKHEHqm1oZ/UEsD2FTEgcrufsehTp9iXwHP1xhCkVHjCxRK2nS0jp0NPiqTfy6OYgSPYMMRHJ6cn491F0Bx7qqp+gv/soZjDHuyQeLWQX7lHoZNGRUzVAmY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SA3PR12MB7831.namprd12.prod.outlook.com (2603:10b6:806:311::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.23; Tue, 29 Oct
 2024 16:51:56 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8114.015; Tue, 29 Oct 2024
 16:51:55 +0000
Message-ID: <5c08d5eb-19be-4a32-af52-97f03b127002@amd.com>
Date: Tue, 29 Oct 2024 11:51:51 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/15] ACPI: platform_profile: Set profile for all
 registered handlers
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
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
References: <20241028020131.8031-1-mario.limonciello@amd.com>
 <20241028020131.8031-12-mario.limonciello@amd.com>
 <46e19bc3-2624-f4b9-a946-050c92c0591d@linux.intel.com>
 <3fc47497-de43-4d77-8352-d6c0886e2db0@amd.com>
 <f65998f4-6396-9cff-09a1-6ee2a49dc254@linux.intel.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <f65998f4-6396-9cff-09a1-6ee2a49dc254@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN6PR16CA0059.namprd16.prod.outlook.com
 (2603:10b6:805:ca::36) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SA3PR12MB7831:EE_
X-MS-Office365-Filtering-Correlation-Id: 81799211-9514-4dd8-b9d1-08dcf839ff02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b010WFV6ZzNuOHlZOGNyTGlDUEg0am9ML2poYjVzRWtUaHFGelcrZWllREZ3?=
 =?utf-8?B?UHRPQkdrNVMvS1laOTlsbjNEcU1ncEVEaVBvWG5sblNFUEZPS0htcjJHZlVK?=
 =?utf-8?B?M0RPSVhrT0w5dDR6bFBwQUI1dkhELzBkOEl0bVFYUlhwaWJ6SG5GSGR6M1FE?=
 =?utf-8?B?TEYvc21mVUFvU1VHU0ZBQVQ4RUs4S3p4cE1qOHRXcTcyaGRlRGZuNE5HWmVR?=
 =?utf-8?B?N1Z5V080RFdqTjVlMjJNMnRNOHJYK0F1ZzFUYnV2Uk9WSXM1R3NOZmM0UGoz?=
 =?utf-8?B?TlBQRy9FSTc5OVBJKzhTSmRrV3VwekJMS3MveUZDb3RoT0VhL293d2pyamsx?=
 =?utf-8?B?YnNQcUcyajA0SC9VSUU5RWN4RGNodEhjV1RlWnZTZzZkVXN4ZFRKTElqcnUr?=
 =?utf-8?B?UjJlMTAzQTNNdWdZYU5jVnk3SXYxcGtYZU9qMG1zdHNzdG1IKzB3cUw0dzFl?=
 =?utf-8?B?Y01CUmZCVnRVcWdlaTJoRHBsVjdzdVhPRlp5MUowZkhwMzhvVkM3WkNoWDJx?=
 =?utf-8?B?VFhxWlpzL0tqUlRpclNrUkVWOE9hNGRwSXNzQXFMbEVQSjczSHFSczhFbjkx?=
 =?utf-8?B?bkMreEdwK3JmQ1hmMmxia0c2ZCtwWng1Zmg1aWF0UTdEYzRXZ3dkRTd5UGZF?=
 =?utf-8?B?Yy9JTlNVek1BZFpXS1RIWFh0L3l2RFI3NjNzZ0p3amFEYzF3U3k1QmZxamFv?=
 =?utf-8?B?RkhkZ1hhSWZvQVFiNXZQQk1ma2lESUI1dmdwQ1kzb0lSLys2R2RuVS9OSit2?=
 =?utf-8?B?YWZwOVYvckJJWDFJcmRCdVh0WWFuOFJyV3dOZ1V3Q1d3S1h2TjVZcU45NnFj?=
 =?utf-8?B?azhMeHBxc3lXVjVDWVJ3UFFaTVR5WnNnK1pnMk5mcU1Ld3lDa2VQaFhkUVVv?=
 =?utf-8?B?dDYxYzhDQlJ2VnFvelJpVGZkM3R5dWtHV3A2SlFDVGtpb0NxSTFNMWllT2NP?=
 =?utf-8?B?Tm9sVWpKMFplVmRJNnFvVnNzQ2Rqam1qempvUkZEZm16clZpTFpRMVp5VkYw?=
 =?utf-8?B?bWlRWFloVXF4T04vdWM3OHVQN3RHd2RVV3R5cURyN0IwNTRNejFmdGd3WUg5?=
 =?utf-8?B?SWJnT0dYY24zenc2cWM0VWNkOU9oZ2d6SzA5UmxVYXRnWHN3OFNra2IwWmQz?=
 =?utf-8?B?OFdFQ2ZwVW1hT0FHOFVvejJPeDRLMEszVklQRldwcHZPTUR3NkJ3QlpGVXl4?=
 =?utf-8?B?MmdaZ1c1RmZWWGw5K3hFMWg3aDhGc3M4UnNHbVorMVVxMlhCbk0rZllCbXZV?=
 =?utf-8?B?ZzcvNWozcWJ0dWM5RGZnb3YvajVpais5MTQzVUZ4MytzQ2dNYTJzdkxtSUZ3?=
 =?utf-8?B?L1UxYno3c0RYQldwVFZ0a1FDdC9MSTRWOVhQUVEwTU5LbytURmFjVGZpZytu?=
 =?utf-8?B?QTNaRVF6U3VEWVcydWg0dWhtMXlLdWlzZjBUZC80Q3FqQ1Zaa3BPbURCVlRT?=
 =?utf-8?B?cDZnVllSckZ6SWRZaU9Xa0xvK3RjWHlGZ0FoZ0hKcm9JWXNKNENaemxTUnFC?=
 =?utf-8?B?WU44eUh2M1dlMnNYZFpnUlpWc3JPMUptd1B5SHd5QTFrR1M3OVNhK09VWWlu?=
 =?utf-8?B?TGhrM2hucWF0RGNUT1hhbHltR0FHTElnMWJCM3pjUDQxa3ZTOEw3SlRDKzl4?=
 =?utf-8?B?Y3NRbWswdjE0Sk1KM0hGN29Ob1FBMGU0d2U3NXBrYVlvaVdJKzFtci95bXNo?=
 =?utf-8?B?WTl6elZhMEcyNXNOMUNoTmdkenA3bm1RNDRyRElqalVQbE1hZ3ZBY2dlVlY1?=
 =?utf-8?Q?suazWHypoE/wMvQaah1pg6j1hgDf5tWyoc+Ml0L?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NWV2bEo4azlnTTlxdEc0YjE3TksvekZ2UmtPTUQvNXFQNnAyaW0xOHZrR1Za?=
 =?utf-8?B?anp4RG83MVd1bzNBVEpKY2F0QVc0djlHbG1YMDBZVHpwZU1oOG51NVVEZXg3?=
 =?utf-8?B?RElIeTZiWkZhL2wyTGdla0VkOFJLdWhuYmdWNnRLK2c5OTh0TkphT3hFdW5Z?=
 =?utf-8?B?Smt6L3pJZm5MMXJpM3hONWlpTkc2cWpXN2ZKZ0k4TzEyY1k2TGdhNEN2RWxF?=
 =?utf-8?B?NVp0clhZdVhVKzhncHN1cUEzWFBpd04xMldkYnB1ZUVvOStHREg1djNsc3Rr?=
 =?utf-8?B?YVBzeDVxemhGRnFTenJzWkdkN2V1dFE2enNLUEw0bWhKYTJOL0EvZUc3N2di?=
 =?utf-8?B?Y0hxVEJsZnRwWXRUME5UN2V3UXBzT0ZuYlI0UlJZcnpBUmJJcTNQNjNBMjVJ?=
 =?utf-8?B?QVZrRU5mRm5QenhqV01sQ0FUVlZNWkM5MHlLL1FiNElHYk9mQzliaVp4TXdx?=
 =?utf-8?B?NWJvaU9pbGdpWTdFVkp1ek85MG5UU0dyaUNlTHk5M05NVFdNdlA3Q0dKVStq?=
 =?utf-8?B?V2dFa2Vtb2dJSFQ1SmJxT25haDhRQk9BTXU1SVZDcVltMXZuTzNaOTFlQUdz?=
 =?utf-8?B?OGRLS1czNTlaZjU3U1pjWXlVbUljZnYrYU1VRElvTUM5UldXVElveEpLSFBa?=
 =?utf-8?B?U2dhbThTV05TaU4xdHdEVEFkOTVjckVhMjRmYVV2OWF1VXE0ZHFsaFFkNmp1?=
 =?utf-8?B?Qk9DNHIxUjlTV2tNK3hTRDhrWmZ2VlF5QnhaMkxDZmxyWGR4MWUyVlVoaG4w?=
 =?utf-8?B?L0RFVGY5Tk81YjdmZy9iQW5BOU1hajdGYkRvZUVGV3RTNXg0b0U2S0Yrc25p?=
 =?utf-8?B?RytJdkVDbmNOVk9KRE1PRzBMcmM5UDg5R0I3VDI0RWFydXplaE5YdktoUVpS?=
 =?utf-8?B?RU1XS1hqK0kwQWFDcEdSOXZoODdZQ25LY29BRXFOUmxYdVdOcjAyWll1NHZ2?=
 =?utf-8?B?dE5QbFY0bGRrQ0hic09GOXU0N01yNzV0NkxncXNGSlc2NzJKZU40KytRZjlN?=
 =?utf-8?B?NWVEc2lzN1F1dC81M0hVbEgrdExHMnRGM3cvK3VhWWU4TUVoaGRTUlA3a2tq?=
 =?utf-8?B?R2tXTmJkR1lVQXFBQjZEZm1HcHZJbnNiK1puZEhYamxBem5NaWI1NHdWRldH?=
 =?utf-8?B?R2VkRDBxTHFVeVdFelZOQllsc1BMZlo4WHROR0JOclRNZ2J6WkxwZ2I5R3FG?=
 =?utf-8?B?K1VCSEpQSTFBdExnS251QzRtc3BvU3RSSVN0YWdOeVBXZWtYeVZLNWxmREdK?=
 =?utf-8?B?MU1UTU03TUVTaG5JM1lVQ0dSQ2UrUEluMEhpZ1pINEI3ek1BQTNTTnVrcTlp?=
 =?utf-8?B?SXlRVTF4NytyUlFNT0V4UFplNWpRcGhhKy9DNndsWGxoNlMwV0lrSVBkS0h6?=
 =?utf-8?B?UXFQVm42VVVldFkrYkFuVTNwSkcvMTdWdmFpTXRlUEFUNmNudVhLSUt3eVJr?=
 =?utf-8?B?MVErcWdxMFVjRUR4OFVmek9UWjRrNUhNb2ZNS3dUaGI0T1pjNGRrMjBzOFBm?=
 =?utf-8?B?bndmdkt4cExIdEErV1lhQzQwbVNDK0lCTXQ2aEMvcEhUbmRQcDJQb3pDV214?=
 =?utf-8?B?Sy9LREF4VlN2V1J4L25rcEo0MllQblBjQ2x2RkgwNStuZU95TnRSb0lPVS9W?=
 =?utf-8?B?YjZXVzhQdk1oOVlGZWcxbHIzVGZ1a3VDSUJsdEVNdzlZUWdqVFVXZWE5Rmxh?=
 =?utf-8?B?L2RIaHRLTTErdnpqbmExZit1aE9HMHZOcDBxdkk3bnA5azBKbExNdENvS3dv?=
 =?utf-8?B?d0t1QXpHNHQrMjVzd3d1UCt1NXhvNlZxZWR4WHMvc3VYd0lYZUJFZmxXNDBU?=
 =?utf-8?B?Z1ljeW9iRS9OSkZHakV5V2U5b1B6dTJrYlpTYVd6WVorOUdHUU5UNy8zT1Ba?=
 =?utf-8?B?eEFZNjZtK0sza05oOEJ6bHF2UHFnSWR3Qm4vVGNpVjhrVXZDalNKQzcxN1E4?=
 =?utf-8?B?SUpFenpQOGk5R2RuVmpOU0poNEFHcG9MNWUzZ1J3QU9lOWxPN2xkWnBnaU5o?=
 =?utf-8?B?dktiU0habFFCaGlKbnhWWlZUMThsYmI1c0hrTWc0Rmpibmx3TEc1MjJ5N1Jv?=
 =?utf-8?B?b3BkbG4zWjNtcVkvaFg2WDM1bzE4cHY3YW5MU0l4d1ZTVTFzUVAzeHRwQ1Rl?=
 =?utf-8?Q?2+733vid20RN4go3wk8NMZBq5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81799211-9514-4dd8-b9d1-08dcf839ff02
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 16:51:55.7074
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QfxDI2lEgttqD+wufqAbr4/v5LcDWwP7MrWmX/sG9O8tkBKw5UxCeUFO/jcPujjAPZtNJo7sSJxU5W303X+dNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7831

On 10/29/2024 11:50, Ilpo Järvinen wrote:
> On Tue, 29 Oct 2024, Mario Limonciello wrote:
> 
>> On 10/29/2024 05:22, Ilpo Järvinen wrote:
>>> On Sun, 27 Oct 2024, Mario Limonciello wrote:
>>>
>>>> If multiple platform profile handlers have been registered then when
>>>> setting a profile verify that all profile handlers support the requested
>>>> profile and set it to each handler.
>>>>
>>>> If this fails for any given handler, revert all profile handlers back to
>>>> balanced and log an error into the kernel ring buffer.
>>>>
>>>> Tested-by: Matthew Schwartz <matthew.schwartz@linux.dev>
>>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>>> ---
>>>>    drivers/acpi/platform_profile.c | 47 ++++++++++++++++++---------------
>>>>    1 file changed, 26 insertions(+), 21 deletions(-)
>>>>
>>>> diff --git a/drivers/acpi/platform_profile.c
>>>> b/drivers/acpi/platform_profile.c
>>>> index a83842f05022b..db2ebd0393cf7 100644
>>>> --- a/drivers/acpi/platform_profile.c
>>>> +++ b/drivers/acpi/platform_profile.c
>>>> @@ -105,37 +105,42 @@ static ssize_t platform_profile_store(struct device
>>>> *dev,
>>>>    			    struct device_attribute *attr,
>>>>    			    const char *buf, size_t count)
>>>>    {
>>>> +	struct platform_profile_handler *handler;
>>>> +	unsigned long choices;
>>>>    	int err, i;
>>>>    -	err = mutex_lock_interruptible(&profile_lock);
>>>> -	if (err)
>>>> -		return err;
>>>> -
>>>> -	if (!cur_profile) {
>>>> -		mutex_unlock(&profile_lock);
>>>> -		return -ENODEV;
>>>> -	}
>>>> -
>>>>    	/* Scan for a matching profile */
>>>>    	i = sysfs_match_string(profile_names, buf);
>>>>    	if (i < 0) {
>>>> -		mutex_unlock(&profile_lock);
>>>>    		return -EINVAL;
>>>>    	}
>>>>    -	/* Check that platform supports this profile choice */
>>>> -	if (!test_bit(i, cur_profile->choices)) {
>>>> -		mutex_unlock(&profile_lock);
>>>> -		return -EOPNOTSUPP;
>>>> -	}
>>>> +	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
>>>
>>> You made guard() conversions in the earlier patch but for some reason
>>> left scoped_cond_guard() ones mixed into other changes still. Is there
>>> a very good reason for that?
>>>
>>
>> Using scoped_cond_guard() requires changing the indentation which meant a bit
>> of back and forth with code coming and going.  If you think it makes more
>> sense to split up even considering the indentation changes I'll do another set
>> of patches for the scoped_cond_guard changes only.
> 
> There are ways to combat indentation changes while reviewing. However,
> it's a strange argument to bring up because now there are indentation
> changes in these patches exactly because you chose to make the
> scoped_cond_guard() change "while at it" rather than in a separate patch.
> 
> I believe the patches will become cleaner and easier to review if you do
> scoped_cond_guard() change separate from any other logic changes.

OK will do.


