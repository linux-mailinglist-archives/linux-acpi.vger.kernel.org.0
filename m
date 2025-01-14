Return-Path: <linux-acpi+bounces-10621-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 309B9A10B97
	for <lists+linux-acpi@lfdr.de>; Tue, 14 Jan 2025 16:59:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18C5F188914C
	for <lists+linux-acpi@lfdr.de>; Tue, 14 Jan 2025 15:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0E8D172BA9;
	Tue, 14 Jan 2025 15:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fNUKyLGs"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2083.outbound.protection.outlook.com [40.107.244.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9245315746B;
	Tue, 14 Jan 2025 15:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736870387; cv=fail; b=Ez8LLKdFgwXQ6/hIhtqvHF/UNP9B67VDtEof1NlJD45cP5njmpkA0ffamdmemzz7cainmBKB4ZtD/taIzyQ3OGYdSjaXDW6CkvVl5DUFNQNPn0YlLupQHwQp4x2Ke4NJMYNKrQcIi8g0+JD/ynvWhFg3gLOrFa+EcDegULi7BtU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736870387; c=relaxed/simple;
	bh=HNsx5KyWia9NaVuHoG3tEO3FROfIkBdfuhm6NMjS2jA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GYkyYB+Zig4ZanRiFuyngCiLC6TphGUhQW5uA9ym1Yzfdn0RlhEmAxutKx0GujSTYNj0VzJcejCGOn5kJ6gNF3KO2iC0yHkBEkprfVgjK80+Wmswrd/ovOdPUE7sPMwHVQd4l1a16ID4BTscQRqYwJAGkPhhzB/ndD/i/NHr92E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fNUKyLGs; arc=fail smtp.client-ip=40.107.244.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BGhw381UHcseqkH1g7ZskpiupRukpSpuZSEPbLZRZlECjy6H0SnG+904ZXAZIpMYOF1QVrPZMfQk841AOuNx0I+sxs99iwLHlfGBrvnx9ZG1XNEnxxh4HzsMkDwUxJE+zeCLXsOnO+8Nx37PzJVJe5gKo3PjP0yiXFH4RCiHJG0OtNp25B1yo+hu5RdJqeb+JhubxT3pKnaWcvRorVtKc6GeLgyF+wwI8glmcm5QHgotd8lWJO8jM0kt0/iYzVnDdx8nokQp6m/FRiHYs5NNGId8UledlTvCNwY6ffZI+TwI34ekVeSu7XcElOMczAQXMqflRdDb9gkADp6zNDOHXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QvFSVEZjHA6ZZvQV7jIRrpN8BvSa1w8DHBqv/QomaIU=;
 b=QczmXaP0DGYpXf1mirNl8kaac4lNxxdyvswOxnWuWNwP1wtbyGVKo7fVeTFnHZUPWDAoLTRm8KtZaGkK1sdOh5fjkTcJDL3Jw+0Maf++5hoviLY/BWpLgbmBX1BT3LttGdJSVacA5qVFqN/BprRzxrGtEcL9++3lGTlYg+sDxC3JQnJSgHlTb8OMuaTN6ZnX/qM3o8Hicn6ZXP/3dbR/MbyjH/xhm0gNbhxc0VYMePXqsuWga23KM4il/O6u+ZnO8+EXfRtIlaQamrjGanTts/qsCGHR9WOKCKYOuDZ4+lzB/rMj5yxfiQ5BsTNvMH1yO1rpo1fnazXtBzIPo9q7CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QvFSVEZjHA6ZZvQV7jIRrpN8BvSa1w8DHBqv/QomaIU=;
 b=fNUKyLGs5Oqju16R7j1mANGYSeOrPX1DipAavMkru2EGwqV/24XJ6kOC3oFTbieDNeKD+UkV325Hm8PUn61gUODCxIC+nHK3isG1ZMGo5F+8OlAX1mpoKu7ZAdIU+ac9po2KRvr9iTeVl/tWqPimZColzPZDQaSiZyOMjXdOREk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SJ0PR12MB6807.namprd12.prod.outlook.com (2603:10b6:a03:479::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Tue, 14 Jan
 2025 15:59:42 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8335.017; Tue, 14 Jan 2025
 15:59:42 +0000
Message-ID: <ba4a9724-06e8-4d70-838f-992715ce8903@amd.com>
Date: Tue, 14 Jan 2025 09:59:39 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/18] ACPI: platform_profile: Remove
 platform_profile_handler from callbacks
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
References: <20250114153726.11802-1-kuurtb@gmail.com>
 <20250114153726.11802-4-kuurtb@gmail.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20250114153726.11802-4-kuurtb@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7P222CA0006.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:124::19) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SJ0PR12MB6807:EE_
X-MS-Office365-Filtering-Correlation-Id: e008a772-da5a-4e04-51aa-08dd34b4750b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SERnNzFkTFRGTWFGNzNwWWNleGJ1OXpqbTh6WjJWeUhQUzhSSVB4VjNiQjNw?=
 =?utf-8?B?OFBTNEJKMEU5MjI0UVlvVTFjaTBCZSs0dUFLc1FJUHpVMmpqM2R1TE96Lysx?=
 =?utf-8?B?OFJ6eVMrdVo5YTExZWdiY2Rob0Znd1B1dW4zVC9WOG80MFMxdTc4WWI3RS8x?=
 =?utf-8?B?bHdEc2tWa1dMZllFc0tHc3pZWU5aT2dMS1daYkNUVWR2c3JwMzBxVGZLYmd3?=
 =?utf-8?B?SWJKUHQzVnRHYzBuK2twSUxwVk45OHJPUEhWN1hsK1k5WGhZWEU3V3BlY3Y1?=
 =?utf-8?B?NVJxRWlYZHFsQUdBdXRoTDFtN0JCTjBaU3lNL3JKM0VQdkRnTHpiR2RDMnhx?=
 =?utf-8?B?bE5GeHVtdXhvVDFiaEQyUmcxSFR1RGM3YlNxREd2aGhqMzJHTDNSL3JCSGtL?=
 =?utf-8?B?eEdoVkN4cWpMSWN1M25nQmNhajRxR0g2OHJ2c2UyZlRDUzErN3NaWkNVcmtK?=
 =?utf-8?B?d1kvOEs1bW9aazM1MXlpcFp3bGxsQ0JGSEdvZU1jR1BqNzEvZjU0a1ZUc2lP?=
 =?utf-8?B?b1dTQ25LL1M5dFBuL1czUlJsMVFwMDFFRWVoREZFYUhzZ09qeTBvZVhZTGhI?=
 =?utf-8?B?MUlhRG05Q0tlOVVWbVJWQWE5YkJoM0w0QkVwVHQyeHphT1JOU21ZVTcwVjNQ?=
 =?utf-8?B?azdFVkIxYmtwM213cXl5RjNlektsYThBUGxnWDI5TGdYamh6TXdKYnI1cU9q?=
 =?utf-8?B?UEN3RTE4V3pyRjJRbWpCbTZvOFErNjM5NDdza0ZZbG5Jd2lQUkZrZnMzRW1P?=
 =?utf-8?B?TnpVZzBFY2FEN2JRTC9zRnhyVjBVTjNnUFZQUXZTcjVQMkVTR0sraWsyRHUy?=
 =?utf-8?B?dHJsMXRvUnoyVGFCYnppeklSTUxiK1JxNTNnT04zeHNqRlNMVGpjTm1EME93?=
 =?utf-8?B?QW9FYStIZmhKaXlQc3dad21EOERIcGRhYkZqcEhUbWtUWmVpRUhnNVVxc2Zw?=
 =?utf-8?B?eEZnV1U2alIyV1VGSmdMcXl1a0lMZDFuYVdQeUpkZlVycFBjVHdzSTdSVEM1?=
 =?utf-8?B?NEFUTE9mSURRY3hBQXl5ZnlvcXZwVnpvOGdOOVhwbmFwbVBTVXBLR1JlM1Bx?=
 =?utf-8?B?MnFzUEd2Q3JjK2VTa293eWFsbUdqdzdhWnIxRkRFbjY3M1p4QzJuK28wdzhK?=
 =?utf-8?B?c1gva25zdFpyeGRFd2FoVDM2Zld1YVVCVTVFZkJ1RFJIVGl0TklHajVGQ0sx?=
 =?utf-8?B?ejRLRVZMZEdKa01mUFBPZnZjL2R1dnAwaHFySDJNS3RDMnhXcWpFTWJqQ1Mz?=
 =?utf-8?B?NEFuSHdzYWtwcFhzTHRyZzJGRmdLZHFOSURkdERGVjlRdmo0bHRPVkhyY3ow?=
 =?utf-8?B?bDh2N0hucWNNSlkxbGx1UHR3ek1RM1BoVU84K1FUbXhnN200REF0UWk5ZGwv?=
 =?utf-8?B?RS9ZVzJYamJZYW5TeTFuaXp6NElKWDRseVJQOFBOTmRrQmV4NW9qVXBCZzVG?=
 =?utf-8?B?M0EwbmYxTkttZG42Q2RBdFhjemRmR3dYZGIvVGxUUlFWTEJHQjJVZkJPZFNO?=
 =?utf-8?B?cFhhd3d6ODJBbFF2N0RoQnA4cDdPM2F1a2E2Y3hHeFVSR041U2toK1VsMExJ?=
 =?utf-8?B?bWllcTRScEFER0tWbWpCNzZKQmlOS1BJQ0VlRXFjQUpyaW9DMWhTcEcyY2dh?=
 =?utf-8?B?NmVrVmcvTjl6VEZ0Y2RUM0pndWtDR1dzejdzNExZbHh1ZGl0UVBtdDZmM3Ju?=
 =?utf-8?B?NjlpOG1ybmFGSXI1NTN2d2hrL1RCMVljWml1dXl1bmtFM1g0ZldML0toQ3Iy?=
 =?utf-8?B?MjZUNDBzbWg0Umcxdjh4bUNkQ1VBS0NiNE9zNVRudyszNGVJU01pS010bnFz?=
 =?utf-8?B?aUJXcHhtLy8wQWVJRzJmeitneTdTQk9TOWw5dlFnVlFRV2dydW16ekdZbVl0?=
 =?utf-8?Q?y7OIHbAgRwQbZ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Nlg3aHJIRlM3ZXQySjIwWTBsd0hJNUtldDdLWlZwMWk3OUxqOXNUd3U5MWMr?=
 =?utf-8?B?a251amN0U04vNm90aUt3Y2VDY1FLTVlMNWlodFZzUXdPVXhHTzdzTkkyQ1NE?=
 =?utf-8?B?bWZCbGNqYVlWUUpiQm1zQmZJRmRtVkZ5WkZ6S1ROcHlsZnRxMXduSi8rTVhW?=
 =?utf-8?B?SjBud1hUcjNNZzVGTFpFVXNKNGpDYWJBdmxRQ01Gc1ZYcmNuSTVoOTJlV1ZY?=
 =?utf-8?B?Mzl5MFU1cFNwMmtMN01WSko3L0JqOHdXd2xMVS91K3I4TzdMTFprZVpQeTVq?=
 =?utf-8?B?MmNYREYxVUZkazdMOHRGVWJMdnNlTXJKR28zWmJ3SHc5czQrSllOTUFMVWFB?=
 =?utf-8?B?QURWY2oycUdrRDYraEdOSk9GVkhlL2RiRXRGTnJnbW9JWlFnYVFMSkNSZzIw?=
 =?utf-8?B?ZkdVK0NldlZiMFlpNXRqRGJyYjFzdnhZOEZBWFQ0d0tIZU12Y0ZTbW9GWDVs?=
 =?utf-8?B?Wk53alJ0Uldad1hBcVRtcGRRcmJXQVN0QXFOSnYxRU1XaHE4Y0wyZ0V1dDky?=
 =?utf-8?B?aE1Rbm43eXE5NTZBWFMwTjQ0NXFkQnI3NXdUWWdpK3NJYWVoQkgwamMxOWpn?=
 =?utf-8?B?OEZwNkZkVDArOU9Jd3QxaGFtSnpmaktlR3RGRDhNY2NMOFh3VjZZTEdBWG12?=
 =?utf-8?B?ZXFtM0llSzVSaWsydC9VdHhqTWdrWHcxSVRFMFBRVEVGbHA5VHRvWFNNbEFQ?=
 =?utf-8?B?bkdwbDlxWkE5c0xSYXFkOWhORE9jMEh0MElRSUwyOGhQV1krd0ZoSElVSFhN?=
 =?utf-8?B?Q2JQNlFvR1JnM1ZwTDJNcUlIWGVwdk50NE9wdVdhVzZGU0lBZVgvam4vZjhF?=
 =?utf-8?B?Q1VVa3Qyd0JkalRYSVVjZzVUSjg2eDdLNDMzd1lZcC9KSEZCalQ4WEZrcHdQ?=
 =?utf-8?B?WjNzY09nZnh4MTZYd1VjTTFPa0lnZGJJbGNtNklwWXYzUlY5RE5iaUJ0aDlv?=
 =?utf-8?B?R0NMQTRQeVdkcWhSV1lDU1ZTYnlvR2Z4bEhWdllqaStnczZkcmdFbmkxS0FM?=
 =?utf-8?B?WHhHNzlZZWNJaWthYkJHTzA0amRlTXdyYXUrcTROMW5hVUJTVGdEU2N1UkxY?=
 =?utf-8?B?L3k2a3U4UitNRFpleFJPM2l5L0EyK2NQREF5NGtsY2M1VEdxTFdMQldBUC9U?=
 =?utf-8?B?eXdSdFR2dEpQc1JWQ0tKNnJnSWh6Um4yMjNZOWNWUmtvelEwUUlEVXJtbHR1?=
 =?utf-8?B?eEx3Nm5rUkdJa1BvdkRUbmoralpPd2ZpYjk2aVZkTWU1Y3lsZHdaTkFCQ21Z?=
 =?utf-8?B?ZTVHeUdFWTNvR1p0WndtYjdaTVhIaUxCdGM5aExqdDRJQWRnNDh2Tnd0Q2hv?=
 =?utf-8?B?cW5nVlFLQVQ5YlozLzZNL0xEckZuN3N3L1A3WjErSHV2enBwQnFzTTArN3k1?=
 =?utf-8?B?K2NJSFdGL3I3UUU1YWhCU05yNjJ4MTdhK1YwOG01YSt0MXNhRnUxNVU1eFkz?=
 =?utf-8?B?b2owMHBxeGJQck53blJZRjN4bDZsTTZxZk5jb0sybHpzdXpmK1JCZnk0NUow?=
 =?utf-8?B?VlM0Y2JrcXJ1TE4xY09yU2NhN2dQSFpGWWFQUGxZTWJCN2RRdUErRDBtWmhD?=
 =?utf-8?B?UDUzQjZRZHVncWdNMDlrazBkRnhYTWtNT1dDc2xGNnI3TGN4M1FmbUx4UjlC?=
 =?utf-8?B?aW9OUEZkOWxqZmlYQlpyRHNNc3Rxc2N6Ti9QOXZ0YTkrcDZsbklBMlZNY0lU?=
 =?utf-8?B?SlVpMmdsN2ZaZTB1MnFkcGRqYWg1WFRrNmxsZmZ2eDlWbUNkTDRwUzZBdWlk?=
 =?utf-8?B?NFdtanBUWWdTK0orbnd1MlZyN29XTjBSVjlZb2gwVVYvZTVtTmdxNUNiWU56?=
 =?utf-8?B?cXBUWVdHYUkzMlJ4WU9BTkE2R3Z4WmpOaVkzcVFuWUxadGdvU0RjR3RsUlM1?=
 =?utf-8?B?VU9HMVVwbFJpS2hYbHBoZGFrd3RxRFFGd0ExU1pWaTU3ZThxK0VtbE1FejZY?=
 =?utf-8?B?ZlJra1RMUW92c0VmNnE3SkNCTFE2V21MSUV6eTZHVVdFRnJZNVNLRi9nSHAz?=
 =?utf-8?B?NnZoWXIxWGpZMittL25FVXdyNUxWSG9HaGhTZVU1YWF3ODB6Tkd2dElGMi8y?=
 =?utf-8?B?NUhlVG80dC9aT2QyTWhEU3ZUeGVIbE1WL3Zkd0dORnJDVk5laGZiR0FDZGEw?=
 =?utf-8?Q?WkMe0UUxxwIBdkrTRLVpat1of?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e008a772-da5a-4e04-51aa-08dd34b4750b
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 15:59:42.0883
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9JGZ+ww1olQrl9EToiwzEsAmwQ+7OUEx/HAtpwiTyLOr2TEpMXe2+GpDK0JYn02KCSp98eDMTaSGsTTT2D/hzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6807

On 1/14/2025 09:37, Kurt Borja wrote:
> Devices can now set drvdata to the class device, thus passing the
> platform_profile_handler to callbacks is unnecessary. Instead pass the
> class device.
> 
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   drivers/acpi/platform_profile.c                    |  4 ++--
>   .../platform/surface/surface_platform_profile.c    |  8 ++++----
>   drivers/platform/x86/acer-wmi.c                    |  4 ++--
>   drivers/platform/x86/amd/pmf/sps.c                 |  8 ++++----
>   drivers/platform/x86/asus-wmi.c                    |  8 ++++----
>   drivers/platform/x86/dell/alienware-wmi.c          |  4 ++--
>   drivers/platform/x86/dell/dell-pc.c                |  4 ++--
>   drivers/platform/x86/hp/hp-wmi.c                   | 14 +++++++-------
>   drivers/platform/x86/ideapad-laptop.c              |  8 ++++----
>   drivers/platform/x86/inspur_platform_profile.c     |  8 ++++----
>   drivers/platform/x86/thinkpad_acpi.c               |  4 ++--
>   include/linux/platform_profile.h                   |  6 ++----
>   12 files changed, 39 insertions(+), 41 deletions(-)
> 
> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
> index f8741201deea..66170fe436f0 100644
> --- a/drivers/acpi/platform_profile.c
> +++ b/drivers/acpi/platform_profile.c
> @@ -66,7 +66,7 @@ static int _store_class_profile(struct device *dev, void *data)
>   	if (!test_bit(*bit, handler->choices))
>   		return -EOPNOTSUPP;
>   
> -	return handler->profile_set(handler, *bit);
> +	return handler->profile_set(dev, *bit);
>   }
>   
>   /**
> @@ -103,7 +103,7 @@ static int get_class_profile(struct device *dev,
>   
>   	lockdep_assert_held(&profile_lock);
>   	handler = to_pprof_handler(dev);
> -	err = handler->profile_get(handler, &val);
> +	err = handler->profile_get(dev, &val);
>   	if (err) {
>   		pr_err("Failed to get profile for handler %s\n", handler->name);
>   		return err;
> diff --git a/drivers/platform/surface/surface_platform_profile.c b/drivers/platform/surface/surface_platform_profile.c
> index edb9362003a4..26c1230e75df 100644
> --- a/drivers/platform/surface/surface_platform_profile.c
> +++ b/drivers/platform/surface/surface_platform_profile.c
> @@ -154,14 +154,14 @@ static int convert_profile_to_ssam_fan(struct ssam_device *sdev, enum platform_p
>   	}
>   }
>   
> -static int ssam_platform_profile_get(struct platform_profile_handler *pprof,
> +static int ssam_platform_profile_get(struct device *dev,
>   				     enum platform_profile_option *profile)
>   {
>   	struct ssam_platform_profile_device *tpd;
>   	enum ssam_tmp_profile tp;
>   	int status;
>   
> -	tpd = dev_get_drvdata(&pprof->class_dev);
> +	tpd = dev_get_drvdata(dev);
>   
>   	status = ssam_tmp_profile_get(tpd->sdev, &tp);
>   	if (status)
> @@ -175,13 +175,13 @@ static int ssam_platform_profile_get(struct platform_profile_handler *pprof,
>   	return 0;
>   }
>   
> -static int ssam_platform_profile_set(struct platform_profile_handler *pprof,
> +static int ssam_platform_profile_set(struct device *dev,
>   				     enum platform_profile_option profile)
>   {
>   	struct ssam_platform_profile_device *tpd;
>   	int tp;
>   
> -	tpd = dev_get_drvdata(&pprof->class_dev);
> +	tpd = dev_get_drvdata(dev);
>   
>   	tp = convert_profile_to_ssam_tmp(tpd->sdev, profile);
>   	if (tp < 0)
> diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-wmi.c
> index 4594beb4b9d7..d609bd105db3 100644
> --- a/drivers/platform/x86/acer-wmi.c
> +++ b/drivers/platform/x86/acer-wmi.c
> @@ -1843,7 +1843,7 @@ static int acer_toggle_turbo(void)
>   }
>   
>   static int
> -acer_predator_v4_platform_profile_get(struct platform_profile_handler *pprof,
> +acer_predator_v4_platform_profile_get(struct device *dev,
>   				      enum platform_profile_option *profile)
>   {
>   	u8 tp;
> @@ -1878,7 +1878,7 @@ acer_predator_v4_platform_profile_get(struct platform_profile_handler *pprof,
>   }
>   
>   static int
> -acer_predator_v4_platform_profile_set(struct platform_profile_handler *pprof,
> +acer_predator_v4_platform_profile_set(struct device *dev,
>   				      enum platform_profile_option profile)
>   {
>   	int tp;
> diff --git a/drivers/platform/x86/amd/pmf/sps.c b/drivers/platform/x86/amd/pmf/sps.c
> index 259a598acd3e..cf2e51f67787 100644
> --- a/drivers/platform/x86/amd/pmf/sps.c
> +++ b/drivers/platform/x86/amd/pmf/sps.c
> @@ -282,10 +282,10 @@ bool is_pprof_balanced(struct amd_pmf_dev *pmf)
>   	return (pmf->current_profile == PLATFORM_PROFILE_BALANCED) ? true : false;
>   }
>   
> -static int amd_pmf_profile_get(struct platform_profile_handler *pprof,
> +static int amd_pmf_profile_get(struct device *dev,
>   			       enum platform_profile_option *profile)
>   {
> -	struct amd_pmf_dev *pmf = dev_get_drvdata(&pprof->class_dev);
> +	struct amd_pmf_dev *pmf = dev_get_drvdata(dev);
>   
>   	*profile = pmf->current_profile;
>   	return 0;
> @@ -363,10 +363,10 @@ int amd_pmf_power_slider_update_event(struct amd_pmf_dev *dev)
>   	return 0;
>   }
>   
> -static int amd_pmf_profile_set(struct platform_profile_handler *pprof,
> +static int amd_pmf_profile_set(struct device *dev,
>   			       enum platform_profile_option profile)
>   {
> -	struct amd_pmf_dev *pmf = dev_get_drvdata(&pprof->class_dev);
> +	struct amd_pmf_dev *pmf = dev_get_drvdata(dev);
>   	int ret = 0;
>   
>   	pmf->current_profile = profile;
> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
> index 0c68635a0aa3..9bed170abb92 100644
> --- a/drivers/platform/x86/asus-wmi.c
> +++ b/drivers/platform/x86/asus-wmi.c
> @@ -3800,13 +3800,13 @@ static ssize_t throttle_thermal_policy_store(struct device *dev,
>   static DEVICE_ATTR_RW(throttle_thermal_policy);
>   
>   /* Platform profile ***********************************************************/
> -static int asus_wmi_platform_profile_get(struct platform_profile_handler *pprof,
> +static int asus_wmi_platform_profile_get(struct device *dev,
>   					enum platform_profile_option *profile)
>   {
>   	struct asus_wmi *asus;
>   	int tp;
>   
> -	asus = dev_get_drvdata(&pprof->class_dev);
> +	asus = dev_get_drvdata(dev);
>   	tp = asus->throttle_thermal_policy_mode;
>   
>   	switch (tp) {
> @@ -3826,13 +3826,13 @@ static int asus_wmi_platform_profile_get(struct platform_profile_handler *pprof,
>   	return 0;
>   }
>   
> -static int asus_wmi_platform_profile_set(struct platform_profile_handler *pprof,
> +static int asus_wmi_platform_profile_set(struct device *dev,
>   					enum platform_profile_option profile)
>   {
>   	struct asus_wmi *asus;
>   	int tp;
>   
> -	asus = dev_get_drvdata(&pprof->class_dev);
> +	asus = dev_get_drvdata(dev);
>   
>   	switch (profile) {
>   	case PLATFORM_PROFILE_PERFORMANCE:
> diff --git a/drivers/platform/x86/dell/alienware-wmi.c b/drivers/platform/x86/dell/alienware-wmi.c
> index 28c39e25228e..b8131b803368 100644
> --- a/drivers/platform/x86/dell/alienware-wmi.c
> +++ b/drivers/platform/x86/dell/alienware-wmi.c
> @@ -1026,7 +1026,7 @@ static int wmax_game_shift_status(u8 operation, u32 *out_data)
>   	return 0;
>   }
>   
> -static int thermal_profile_get(struct platform_profile_handler *pprof,
> +static int thermal_profile_get(struct device *dev,
>   			       enum platform_profile_option *profile)
>   {
>   	u32 out_data;
> @@ -1052,7 +1052,7 @@ static int thermal_profile_get(struct platform_profile_handler *pprof,
>   	return 0;
>   }
>   
> -static int thermal_profile_set(struct platform_profile_handler *pprof,
> +static int thermal_profile_set(struct device *dev,
>   			       enum platform_profile_option profile)
>   {
>   	if (quirks->gmode) {
> diff --git a/drivers/platform/x86/dell/dell-pc.c b/drivers/platform/x86/dell/dell-pc.c
> index 1a0a721d706f..c86b05b5a1cb 100644
> --- a/drivers/platform/x86/dell/dell-pc.c
> +++ b/drivers/platform/x86/dell/dell-pc.c
> @@ -185,7 +185,7 @@ static int thermal_set_mode(enum thermal_mode_bits state)
>   	return dell_send_request(&buffer, CLASS_INFO, SELECT_THERMAL_MANAGEMENT);
>   }
>   
> -static int thermal_platform_profile_set(struct platform_profile_handler *pprof,
> +static int thermal_platform_profile_set(struct device *dev,
>   					enum platform_profile_option profile)
>   {
>   	switch (profile) {
> @@ -202,7 +202,7 @@ static int thermal_platform_profile_set(struct platform_profile_handler *pprof,
>   	}
>   }
>   
> -static int thermal_platform_profile_get(struct platform_profile_handler *pprof,
> +static int thermal_platform_profile_get(struct device *dev,
>   					enum platform_profile_option *profile)
>   {
>   	int ret;
> diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/hp-wmi.c
> index 8e5e1422e024..b8e62dc9cecd 100644
> --- a/drivers/platform/x86/hp/hp-wmi.c
> +++ b/drivers/platform/x86/hp/hp-wmi.c
> @@ -1221,7 +1221,7 @@ static int platform_profile_omen_get_ec(enum platform_profile_option *profile)
>   	return 0;
>   }
>   
> -static int platform_profile_omen_get(struct platform_profile_handler *pprof,
> +static int platform_profile_omen_get(struct device *dev,
>   				     enum platform_profile_option *profile)
>   {
>   	/*
> @@ -1318,7 +1318,7 @@ static int platform_profile_omen_set_ec(enum platform_profile_option profile)
>   	return 0;
>   }
>   
> -static int platform_profile_omen_set(struct platform_profile_handler *pprof,
> +static int platform_profile_omen_set(struct device *dev,
>   				     enum platform_profile_option profile)
>   {
>   	int err;
> @@ -1345,7 +1345,7 @@ static int thermal_profile_set(int thermal_profile)
>   							   sizeof(thermal_profile), 0);
>   }
>   
> -static int hp_wmi_platform_profile_get(struct platform_profile_handler *pprof,
> +static int hp_wmi_platform_profile_get(struct device *dev,
>   					enum platform_profile_option *profile)
>   {
>   	int tp;
> @@ -1374,7 +1374,7 @@ static int hp_wmi_platform_profile_get(struct platform_profile_handler *pprof,
>   	return 0;
>   }
>   
> -static int hp_wmi_platform_profile_set(struct platform_profile_handler *pprof,
> +static int hp_wmi_platform_profile_set(struct device *dev,
>   					enum platform_profile_option profile)
>   {
>   	int err, tp;
> @@ -1440,11 +1440,11 @@ static int platform_profile_victus_get_ec(enum platform_profile_option *profile)
>   	return 0;
>   }
>   
> -static int platform_profile_victus_get(struct platform_profile_handler *pprof,
> +static int platform_profile_victus_get(struct device *dev,
>   				       enum platform_profile_option *profile)
>   {
>   	/* Same behaviour as platform_profile_omen_get */
> -	return platform_profile_omen_get(pprof, profile);
> +	return platform_profile_omen_get(dev, profile);
>   }
>   
>   static int platform_profile_victus_set_ec(enum platform_profile_option profile)
> @@ -1472,7 +1472,7 @@ static int platform_profile_victus_set_ec(enum platform_profile_option profile)
>   	return 0;
>   }
>   
> -static int platform_profile_victus_set(struct platform_profile_handler *pprof,
> +static int platform_profile_victus_set(struct device *dev,
>   				       enum platform_profile_option profile)
>   {
>   	int err;
> diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86/ideapad-laptop.c
> index ed0d880a07a9..fc317f42bb82 100644
> --- a/drivers/platform/x86/ideapad-laptop.c
> +++ b/drivers/platform/x86/ideapad-laptop.c
> @@ -933,10 +933,10 @@ static int convert_profile_to_dytc(enum platform_profile_option profile, int *pe
>    * dytc_profile_get: Function to register with platform_profile
>    * handler. Returns current platform profile.
>    */
> -static int dytc_profile_get(struct platform_profile_handler *pprof,
> +static int dytc_profile_get(struct device *dev,
>   			    enum platform_profile_option *profile)
>   {
> -	struct ideapad_dytc_priv *dytc = dev_get_drvdata(&pprof->class_dev);
> +	struct ideapad_dytc_priv *dytc = dev_get_drvdata(dev);
>   
>   	*profile = dytc->current_profile;
>   	return 0;
> @@ -986,10 +986,10 @@ static int dytc_cql_command(struct ideapad_private *priv, unsigned long cmd,
>    * dytc_profile_set: Function to register with platform_profile
>    * handler. Sets current platform profile.
>    */
> -static int dytc_profile_set(struct platform_profile_handler *pprof,
> +static int dytc_profile_set(struct device *dev,
>   			    enum platform_profile_option profile)
>   {
> -	struct ideapad_dytc_priv *dytc = dev_get_drvdata(&pprof->class_dev);
> +	struct ideapad_dytc_priv *dytc = dev_get_drvdata(dev);
>   	struct ideapad_private *priv = dytc->priv;
>   	unsigned long output;
>   	int err;
> diff --git a/drivers/platform/x86/inspur_platform_profile.c b/drivers/platform/x86/inspur_platform_profile.c
> index 471fca50d1c9..47d2dbbf3392 100644
> --- a/drivers/platform/x86/inspur_platform_profile.c
> +++ b/drivers/platform/x86/inspur_platform_profile.c
> @@ -84,10 +84,10 @@ static int inspur_wmi_perform_query(struct wmi_device *wdev,
>    *         0x0: No Error
>    *         0x1: Error
>    */
> -static int inspur_platform_profile_set(struct platform_profile_handler *pprof,
> +static int inspur_platform_profile_set(struct device *dev,
>   				       enum platform_profile_option profile)
>   {
> -	struct inspur_wmi_priv *priv = dev_get_drvdata(&pprof->class_dev);
> +	struct inspur_wmi_priv *priv = dev_get_drvdata(dev);
>   	u8 ret_code[4] = {0, 0, 0, 0};
>   	int ret;
>   
> @@ -131,10 +131,10 @@ static int inspur_platform_profile_set(struct platform_profile_handler *pprof,
>    *         0x1: Performance Mode
>    *         0x2: Power Saver Mode
>    */
> -static int inspur_platform_profile_get(struct platform_profile_handler *pprof,
> +static int inspur_platform_profile_get(struct device *dev,
>   				       enum platform_profile_option *profile)
>   {
> -	struct inspur_wmi_priv *priv = dev_get_drvdata(&pprof->class_dev);
> +	struct inspur_wmi_priv *priv = dev_get_drvdata(dev);
>   	u8 ret_code[4] = {0, 0, 0, 0};
>   	int ret;
>   
> diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
> index fe37c26891d8..47f87bb213a9 100644
> --- a/drivers/platform/x86/thinkpad_acpi.c
> +++ b/drivers/platform/x86/thinkpad_acpi.c
> @@ -10414,7 +10414,7 @@ static int convert_profile_to_dytc(enum platform_profile_option profile, int *pe
>    * dytc_profile_get: Function to register with platform_profile
>    * handler. Returns current platform profile.
>    */
> -static int dytc_profile_get(struct platform_profile_handler *pprof,
> +static int dytc_profile_get(struct device *dev,
>   			    enum platform_profile_option *profile)
>   {
>   	*profile = dytc_current_profile;
> @@ -10489,7 +10489,7 @@ static int dytc_cql_command(int command, int *output)
>    * dytc_profile_set: Function to register with platform_profile
>    * handler. Sets current platform profile.
>    */
> -static int dytc_profile_set(struct platform_profile_handler *pprof,
> +static int dytc_profile_set(struct device *dev,
>   			    enum platform_profile_option profile)
>   {
>   	int perfmode;
> diff --git a/include/linux/platform_profile.h b/include/linux/platform_profile.h
> index 1c8fdda51eaa..5296d886c243 100644
> --- a/include/linux/platform_profile.h
> +++ b/include/linux/platform_profile.h
> @@ -34,10 +34,8 @@ struct platform_profile_handler {
>   	struct device class_dev;
>   	int minor;
>   	unsigned long choices[BITS_TO_LONGS(PLATFORM_PROFILE_LAST)];
> -	int (*profile_get)(struct platform_profile_handler *pprof,
> -				enum platform_profile_option *profile);
> -	int (*profile_set)(struct platform_profile_handler *pprof,
> -				enum platform_profile_option profile);
> +	int (*profile_get)(struct device *dev, enum platform_profile_option *profile);
> +	int (*profile_set)(struct device *dev, enum platform_profile_option profile);
>   };
>   
>   int platform_profile_register(struct platform_profile_handler *pprof, void *drvdata);


