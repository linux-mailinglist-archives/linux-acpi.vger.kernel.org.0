Return-Path: <linux-acpi+bounces-12416-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26FF0A6DCFB
	for <lists+linux-acpi@lfdr.de>; Mon, 24 Mar 2025 15:29:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 816763B877D
	for <lists+linux-acpi@lfdr.de>; Mon, 24 Mar 2025 14:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DDD225F7BE;
	Mon, 24 Mar 2025 14:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bxgWsLNI"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2068.outbound.protection.outlook.com [40.107.93.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C2725DAF0;
	Mon, 24 Mar 2025 14:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742826319; cv=fail; b=EnHyLB/l/wSPKBQX0Fv4u4WctnwrU9fsgZEhWNFR86KhbR25Ieu3qHg4EDRDpSz8zv8uHmvOiA+z6LdM1iPiGq7Mr8GMbgww73/3HOuNi1KxYnI9Q4ikRVpNsyDJw80J7B+m5zEJY152Rd7omJ90yivwmGP9+qbMIRrfcB/V4DY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742826319; c=relaxed/simple;
	bh=Vq+ZgxWIdh9gkbe6MAJEoQrWxHSf5dgvRYdc1Iac9KU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mmeo+3sAa7J4FWTkMT4T4KDbYnvxxSFCn4RUIu7RPuNT2CPvw6fSQgI0bpz+Wf4JE2tCOpQ55kwNzewR1RpyOv4qsWB1yAC8yPwDmS2vudAPuOE5j3AX0/jiZ5No+R9dt+3VmLXJrwh5xu1c4oLAYSZiKJ4339tBlixOCMWba6I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bxgWsLNI; arc=fail smtp.client-ip=40.107.93.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AMj+LLyR1/fNi7BAB1m5MjXfasN0GblzzOUTx3Ri6yki25p+oCqsl6wAmASgjvMnFNgqL4tvZvTR+Rj2fFrx11OifZ9PPUEAAv3MSFIR9eNHZ1yz82/r/zVO3gbjSxLy6gZKSM17FOkeHW/MJm87YIiJHeU5nbIxm4GR0HCCrjXSgS+E/qaxAn+OWY03+1wmuUH68dpDjWvaWYpE1gFNie2HcS021f9WQYASZW9aydynEDeN3SUTduK4a3w/5DkUQaY8PoYyBRY+wdZC/rB1AKl4gK5e7tD9UaG5DzfGEr6tQwPsUPWtf94kjiuqJlrr45JPTvh89Udl8FEWCxUQ4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6erAipjQbrXZ/cwRqUPpo7PsXFUw08CXzFmdVjXB3+A=;
 b=DTBPyL5iXmXO8MaLcJzLY2Xb5lLukzOYWk3D4fnJmb4gIPX4D3zmQR2/+74CYqds0ziVXzmhGSPO39Qmot6Bng7YHXEegyMSTOA9QGPT7yVvL8eRvyJutHew6fY6gM+AQJiIFOgVC+J49b2MliEvcpRcEZGJQDx0WIwv0tQqV6dQeC3aTgOYjnmeAhbWk4/pi8lr0kF9OQ7GtjxL+MJ/Oduk/hTa27+40zDv0qIkzTl8WuOznLykBLXQyyrxrLNj0w+chIobYMdIB0vK9zD6Q2aS1102oZPvYo3XYKJ4Kzyr/0JNdoiEJuP5dNfN+YKIblXsp4hzszXl63RLvnxO3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6erAipjQbrXZ/cwRqUPpo7PsXFUw08CXzFmdVjXB3+A=;
 b=bxgWsLNIlJz1xRZoCdZEw6lWvHef/N9EOuFucKpVvfGxWJjgY3hYhD7GjJcFFcR82HeQdBBU8sB670Wv7CG3rEO+NCuDeuwpjR54ByXhFINFSOhMPYygGKG7gClhc7p46oLeJnbqr006PcJtSUp9W7xsghVaLCYoN3+upo05xiM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by LV2PR12MB5871.namprd12.prod.outlook.com (2603:10b6:408:174::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 14:25:14 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 14:25:14 +0000
Message-ID: <d55f0f78-f2a3-47cb-a070-e35edfad710d@amd.com>
Date: Mon, 24 Mar 2025 09:25:12 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ACPI: platform_profile: Optimize _aggregate_choices()
To: Kurt Borja <kuurtb@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Mark Pearson <mpearson-lenovo@squebb.ca>
Cc: Armin Wolf <W_Armin@gmx.de>, Len Brown <lenb@kernel.org>,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250322-pprof-opt-v1-1-105455879a82@gmail.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20250322-pprof-opt-v1-1-105455879a82@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR10CA0012.namprd10.prod.outlook.com
 (2603:10b6:806:a7::17) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|LV2PR12MB5871:EE_
X-MS-Office365-Filtering-Correlation-Id: 73692b20-5aa6-4d97-c91e-08dd6adfb146
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MlNndW5rSGdsMmQzQnBMb2R2d3FWZUM5ZkZWcjcwZGErc1pDSzZxTlltV1B2?=
 =?utf-8?B?cDJhV2hYbUNkcFRlYUFHTk4xQ0lSZUhRd1dBWUlqTFV6UEhhOWRVRUQxSUl4?=
 =?utf-8?B?YlorQW42bWU0U2pUTTYxMDZ2UkJBVHJPUmtnbkxra3d2cUs4QzBxeUIvNGM0?=
 =?utf-8?B?T0NXK0FGaTZFVlBNQWlodDdkMU5VQThZenp0QVN3cktaNU0rTk5oaWFwcHZh?=
 =?utf-8?B?MXp2aUhTRUgvK00vSy9ldldPOGt4UVZjZk01ZDEyWFRBbkZvR3ZpQ0xYUDk4?=
 =?utf-8?B?Ti9HY09nTlVDSGk4TXdJOEk0UWcyK0pBaEVRUkY0S0ZvZUdvQXdoMVQ4K3cv?=
 =?utf-8?B?NkJBY0NLRWFtVGVIa285UHdBSXNrbU14M0hFNy95TUNVaFZyMmtKWGZmaUpR?=
 =?utf-8?B?eUVDbWN5SnhZK0NHM2VESkZwMTg3UUJXN1hxTnY3ZGMzamJ6bUsxNjB2eU5H?=
 =?utf-8?B?REd1U05yYkdVVkVQMTR6ckFrRytReXhTSjZDNFhtK29sb0N3amVza2FwYTRD?=
 =?utf-8?B?KzBUZnBLaG5ObUUxSHlDa2tqMGYrVEx6MEF3WmpPMDdWNW1pSTVnZUVpRmtm?=
 =?utf-8?B?M1I5QW1XRGp3Snc1Z0NqWCtyL2xkRmF6WjkyRE1EUXZPNTlGSXM1TzJEbVlU?=
 =?utf-8?B?Zk95bnN4OXZRQTFibVEwYkY0ZUVtOVhSelFDcmFTUDl0bWdTeTNPaElSeUlF?=
 =?utf-8?B?V1VVYmx3Y1huUW8xVUlLME0ydmR4N0xHZFA4WXYvOTZ5WC8wNW9wYWdLYm1U?=
 =?utf-8?B?OTdERW9sOUFXcTQxV1QyMkRWR2JLRnN1TlBUTGZnalJuMmVLL3F4MllnN09F?=
 =?utf-8?B?cXRMOVVET0w1RGFKUGtnVjVUamxSKzlQYkNqdUtUSDZlV1p5T1V4QnUwOEd5?=
 =?utf-8?B?ZHpoSUJVNmlkRE0wdXk0SHp6UXJDbGNscG1BL3piYUl3YzRWeEV1YTlLU0NL?=
 =?utf-8?B?Wm16S0o4WkhjTDk0UGRsVEcyV1pCdUdiUktqK093eUtrZmZPdmRDZ2dhTmV5?=
 =?utf-8?B?RnhXUkVWV1JrM0x2MXNuYmNPNVRwanFJNk8rZEczSE43Unl0MU9kcmNubmF6?=
 =?utf-8?B?N0VMeEpQcUlvYkpXaFlxeHdYd2VQY2ZqQTBZZHUwQ3FOYWVhWVRwTzU2M0lB?=
 =?utf-8?B?QTgyNFFTaStRallzSzlIZTV0U1lTRjdoK29xbkFZQkI5ZHhtWGIzSVZhdDd5?=
 =?utf-8?B?YVVxOW4waWZQOTlhRzRHNjZOanliUWlkeFFlMXBVeTUzSVBSQkF3a2pNK3NC?=
 =?utf-8?B?Ym5JS01lRDhLcUhwdUdMN2JwakxwNHlkMVNRbUlpR0JCQVVkcG5qemtHanZ1?=
 =?utf-8?B?ZmdQSklERkkwbENDWWZZTGN3dGY0Y0VpZW5KSkpzMEVsaityVGV1RFFGdzl0?=
 =?utf-8?B?Nm45OWhzT09oMWVwNjRJMUhnZk11bXVZNGpCZ282QVN4bWtTYXN3S1hnRHU0?=
 =?utf-8?B?bFl3V0FMQmRnOFg5dmx4eWc3cXVHZTJiVnRtSDNCU2pKZ0lMQStpZzZDYXVw?=
 =?utf-8?B?SFczL3Y3ZjRRWnV2SkZaNGIwdmJuV3lOYU16TXBRSGpUV1I2djBscTR6SFVS?=
 =?utf-8?B?OUlQMm44dW45d1M0K3FsVHVWeE84MDJ4N0loNFVlT3pGNzQxK0ZVQnZYSzNr?=
 =?utf-8?B?SGRzWWQwQm9zcW5WVkkyaGRYUEE5enkwZ2FleCttS2VzMjFwdmVnRXZ5dURB?=
 =?utf-8?B?ZXhqSFdDTGhOa08vV0Z5TE4vdkZSZDlqcUJFTzFpREFFeFVVY0VmOS95NFpt?=
 =?utf-8?B?dXNPUSt5aGlGNHFEOHVUbGtVVG1CdUFNazRFdUpsZ0J1RHZSR3J4ck5zaGc5?=
 =?utf-8?B?WlJyemV2a3NRb0JCLzZYQUVNTmNXamk3MDhtaVFzaWgyZm03aU9vbmtidnk2?=
 =?utf-8?Q?2EyHk9UOmPZ62?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Yy95bDVUTTF5TlUxNWZ4VGRzUUwzQjN0LzhwZGlNLytBNDBTYnJybnMyakRH?=
 =?utf-8?B?RkZPeDlyUGZXajhqK3ZRV0FuR0V1eVh2aHlRTmZySkthMHpCRXVwVGtDbFZ4?=
 =?utf-8?B?NHNZOFliY2h3cWtCUDZaNXFRamowYWZnSVFYRm9ENGRGYUtsR1krSE9odEtp?=
 =?utf-8?B?QWNtSzY0QXB5Q0VwLzV5ZmZyeEYvSnZHcXpON3cvYmdaMytHUXp6Qllpbko2?=
 =?utf-8?B?Wmd5WjZaOWhyME1UWWtmejVrUktGU2JKcnhTbERqTTJpRnRtOFVEbjZDTkpo?=
 =?utf-8?B?S3pXWmhwYjVmQ2haalZxMDVmUlZVVEdpekw2Q1FZb1BvZy94S1BFME1YR3BF?=
 =?utf-8?B?RmpRQ0hJZlZWWDJRcXRoK0FSdHBhN1BPZnlDdm5CZCsvNExYbHY5TVFROTY0?=
 =?utf-8?B?d2IvZzNmak9wZzlpM1RHV0Mra3Z5a3AyRGVMdWtLc1ZYS2JySE1RRlBwVGNs?=
 =?utf-8?B?N0VVVDVSY1pKWGV6eDRZcWVzQlZ1N1NPYW1aVVN3VHJKcHNBV2lVY2EwOHNI?=
 =?utf-8?B?WE9lb3BROEZtbnBTL1ZsZmdDUlI4aVFyUUxLMHhyZEc1ZFFReFZlSHIzdCs5?=
 =?utf-8?B?bGZieHp0UWNLY1BTUVl6VGdSRm9id1Q1aERRZ00vVHNKU3NkL21pYXY0Rkkv?=
 =?utf-8?B?dW0rNmhvUWQ2MEpobmwrUVpRUDZUYXoxUGt6b3hwT3dZaUxIckw4NXBPNndr?=
 =?utf-8?B?cDdEcVYrVUN2cm4veHF4MmxUOUV3dGVCNElzYXhic1hqNys5U3RFVkQwL213?=
 =?utf-8?B?N2QyQU5JdXY2cWE3WkRFN2NDbmE1SGgrdjlFb3NlWlVCNjdJQ1NxU1d6WUI0?=
 =?utf-8?B?ZEhjRXd4cmFCaENDbzRPaVFDbFM5Rk16ZDRXb3lnVzFGUzM1OG8xVnZFRUlW?=
 =?utf-8?B?d294V1YxaFdJbTdOeFFkVmVZaU1oNWFuOXNrT2xqVWJkQUlUMnpIOWh4dlBx?=
 =?utf-8?B?UGdpUXRiMzZXM0hidUJYN3RqVi9WbmFWVlRHcC9CMldPdkViQWYrVDJCb1Bm?=
 =?utf-8?B?N0RhMHFNenJVcVhpQlFZSVIzVW9ITGxpeVE2ZW51bThoRDFGM3VwZVRwam5x?=
 =?utf-8?B?dkpWaUQ2RjdidGR0Wm43cGtIV29yQzZLb0hyMUVwWTlBenlaT05URERpRzh6?=
 =?utf-8?B?bU5UeTl4MGtMSWQ4ZGJ4TDRaNzVhb3dxRXZLTno5MzZsNkk2V1ZodFNmcGNY?=
 =?utf-8?B?eTNPUThBQjd1cUkyZHd1M3k1ZXBSWm00bjl2cUNqV1VwRUFOWk5VTjlxTnVS?=
 =?utf-8?B?bUt3cW8wNXZ6QTZjR3QrcTE2bEZXTFBreHFKbWVvUE9HOVh4Y2ZhdHN0UGIz?=
 =?utf-8?B?ZmpQSGVHeXZ4dHFuMnVmdExrc2paQy9DNW5lSi9tMUg4MkF4M0lOVzl4bTJ4?=
 =?utf-8?B?Qmkyb3lob0paRHFEbWlMaTdmN0FQNlMxem9kdTJhdEdoWEJiVEkySENkWHZQ?=
 =?utf-8?B?bDNlalIwcVd4VWw0WWZsQ2RwcjVabUNtVnlEOHlYNmNXMTRrVmJ3aEVlMGZn?=
 =?utf-8?B?a1Vrc0luL2ZaWGNzRG8yOFRCTzdQR2htM2lXRUZSL0h2bGlsVFhQL2JmS2Jp?=
 =?utf-8?B?TnFZT3ZnTXFEeTNTSm5CSjlrL3I1cllIeG9tZmtWODByODBnN3ppOE5wZXRa?=
 =?utf-8?B?WnFZZ3dQUC92eWRIMUtXcHYwWHVTdk10cWJUTzhFaFRhcVFXdW1ySGNUNk9H?=
 =?utf-8?B?NG5zZWFUbkJxNmU3L2dQS0ttTFg3KzNvcldqRkVYelQrbFZqa3VPZlZ4NTRP?=
 =?utf-8?B?OFFkOWhya0hrZGpxVjk0dUxML2xVM1lCK0VRQ2N2WlRFVm4rbktUb2tKd3FC?=
 =?utf-8?B?Yjl5ZmQyN1U0Ky9yTWtKQnp5d1ZtKzBLOWhEd2VxYlczQWl1RE1zYkJ2NEhJ?=
 =?utf-8?B?cW9tc3JRUEVYWkg5UVlaU3poSFdwUitrOUo3Y1RqNGVncS9SL21OZy9yN25O?=
 =?utf-8?B?OVFZa1B1Qzh1cm5ndFVlYTRVc3BTMmg5K016QnVYUWNUR0hTR0ROcW91aCs2?=
 =?utf-8?B?TlNFQXd0ZkFsRHVEdDdrVzh2L1I2ZjViazNsVlF1bkFwdWZ2M3J1bGg0d0lk?=
 =?utf-8?B?cFgxWXpqL3NIWU9XTWZrTnIramswN0c5TW5ldTJmNkVaOFh1UEVsekNLZkU4?=
 =?utf-8?Q?4MAGopCQYEJ9a44fhUrdND2j+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73692b20-5aa6-4d97-c91e-08dd6adfb146
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 14:25:14.2802
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /Y8QwcBp6f+dhS+V6MZEf2xQrSE+Rw19d7JJFh7PfOdg97YjrMuOg8aBux6OGH0qcfl4bY0Z9uh0PjjLZUxmrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5871

On 3/22/2025 16:03, Kurt Borja wrote:
> Choices aggregates passed to _aggregate_choices() are already filled
> with ones, therefore we can avoid copying a new bitmap on the first
> iteration.
> 
> This makes setting the PLATFORM_PROFILE_LAST bit on aggregates
> unnecessary, so drop it as well.
> 
> While at it, add a couple empty lines to improve style.
> 
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>

Good find!  This optimization is valid because of the changes in

commit 778b94d7ac17b ("ACPI: platform_profile: Add support for hidden 
choices")

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

> ---
>   drivers/acpi/platform_profile.c | 10 +++-------
>   1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
> index ef9444482db1982b19d2a17884e1c3ab0e5cb55c..b5b24b075af6dfa612d56eb95342c6af87a60d3e 100644
> --- a/drivers/acpi/platform_profile.c
> +++ b/drivers/acpi/platform_profile.c
> @@ -256,12 +256,10 @@ static int _aggregate_choices(struct device *dev, void *arg)
>   	struct platform_profile_handler *handler;
>   
>   	lockdep_assert_held(&profile_lock);
> +
>   	handler = to_pprof_handler(dev);
>   	bitmap_or(tmp, handler->choices, handler->hidden_choices, PLATFORM_PROFILE_LAST);
> -	if (test_bit(PLATFORM_PROFILE_LAST, data->aggregate))
> -		bitmap_copy(data->aggregate, tmp, PLATFORM_PROFILE_LAST);
> -	else
> -		bitmap_and(data->aggregate, tmp, data->aggregate, PLATFORM_PROFILE_LAST);
> +	bitmap_and(data->aggregate, tmp, data->aggregate, PLATFORM_PROFILE_LAST);
>   	data->count++;
>   
>   	return 0;
> @@ -305,7 +303,6 @@ static ssize_t platform_profile_choices_show(struct device *dev,
>   	};
>   	int err;
>   
> -	set_bit(PLATFORM_PROFILE_LAST, data.aggregate);
>   	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
>   		err = class_for_each_device(&platform_profile_class, NULL,
>   					    &data, _aggregate_choices);
> @@ -422,7 +419,7 @@ static ssize_t platform_profile_store(struct device *dev,
>   	i = sysfs_match_string(profile_names, buf);
>   	if (i < 0 || i == PLATFORM_PROFILE_CUSTOM)
>   		return -EINVAL;
> -	set_bit(PLATFORM_PROFILE_LAST, data.aggregate);
> +
>   	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
>   		ret = class_for_each_device(&platform_profile_class, NULL,
>   					    &data, _aggregate_choices);
> @@ -502,7 +499,6 @@ int platform_profile_cycle(void)
>   	enum platform_profile_option profile = PLATFORM_PROFILE_LAST;
>   	int err;
>   
> -	set_bit(PLATFORM_PROFILE_LAST, data.aggregate);
>   	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
>   		err = class_for_each_device(&platform_profile_class, NULL,
>   					    &profile, _aggregate_profiles);
> 
> ---
> base-commit: 9a43102daf64dd0d172d8b39836dbc1dba4da1ea
> change-id: 20250322-pprof-opt-caa7f7f349b8
> 
> Best regards,


