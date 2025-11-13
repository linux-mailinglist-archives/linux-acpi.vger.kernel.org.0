Return-Path: <linux-acpi+bounces-18878-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FF74C59F54
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Nov 2025 21:24:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E7E7A349FC1
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Nov 2025 20:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FDF23176E6;
	Thu, 13 Nov 2025 20:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Q6/qQDoC"
X-Original-To: linux-acpi@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011022.outbound.protection.outlook.com [40.93.194.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB57313E29;
	Thu, 13 Nov 2025 20:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763065492; cv=fail; b=s0AF2sV28Wt+rS3yIAKhj28koYaya5RyR0kmhwYhEPIdOq7ZwONJthokdbMIruysGggkKdgef+zBTCuT9XL/gH+WYR6XNzAa2xnGWD4A6Vg3/u5oJof3V1axHcrT/9J9MTtW/mlb2MVN6aNYFvgT185XrV6/W0uCGi8RDlgxnLY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763065492; c=relaxed/simple;
	bh=KYw6nrd4SHdhwky9/cmB+YB3BjXC5mQ3qmd2HMZBAwE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qwg9HmHnlZ1XT075ReDz2Zo8GDC3Lh4aLu7mmaP3PBny0hgksMVeAukN5KkYuhSFT17o4H5rZ7byKjuhTh/Io0z5eR6uIEgdFIO/QGer1DrCSAIGYG0zYbBqvdPfBBvJY3c40tYvkjvdSlF2cAtB/HS+DXf3EoiJY7FZjLydasI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Q6/qQDoC; arc=fail smtp.client-ip=40.93.194.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FkqtFOC1ZNxA63ttfkTDhrsrFQM/N3v1N1x9tCac4UHdvvlzbvADvNTEYyP5WHU14WK079Td7URKbuVuJLZfXLX42GcZno3Ywq0GvuhvEc8zmYoDuf+iIq8WEgUhuOdT3xD+kEklnD4oUt6lwp8XuTcl43/jjsq11jH0sihTz2veix1lHsXDEZg4tm3cLLUc0ziFYCt+pJBykt7RJwq9Wf7kesgBUvV88YUKkNvZvZp1139LCSKZb51HzfDS21S5mVzBEP1r0dSoGI+WORAsjVsWQ4soNyl5QVzIVXvYvxQ1HfwzGcrD2A3NzeBDVb8pe2FICD4bpvkYGtExDr3G2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DT7KRE/BYLOhCjZpXheuWtHMNrzMNhwDgWcdL+gZaYA=;
 b=IqjjwPPbiGTwQa79nAiKf4lppWgX002rC5eEd9dLGDFify01k9h1Tz304ZjzHU1jyx75K38J/3Fu9HeRMghb1SoCFlOU2e7NZdo2v4mPYPRyOZ6EHM9yNYvhcYoD6w7H341XvuEh55p6KbrQubdSRd6UHsi5ipmhob0kx7SFajA4As6ey1qpobBC/XMphTqjvIlxjmP1LsIkqQp5WhWqLKPvk20yQ96q6BEykOh72IujsPycZ2cMyWp6/IXRu1SUljfhczTi9HUOTAa0K6ITKwCia7KEn57Uhhg8R6bsJ1ts7p6uyvCSGBwTv+yP2V8iwo+SSi/YQ1kidAS10fR3tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DT7KRE/BYLOhCjZpXheuWtHMNrzMNhwDgWcdL+gZaYA=;
 b=Q6/qQDoCnLdaPA7xZCyts6QNnB/F+c3L1IPyBPkGoDG1ZD534DusTJnwvJMe3Cy2nKM1e9B6xxs9EspylMDlXrpGZiB3pXTLp4cEbxcQWbUdUhYM/y4gB+djFjaclCAJRwXnky4laZzXW1oDp/6npyroc4ysuoSVO5qngToBbqmgAzrdFBhSv61buV3mj3OE0hIgwpzGYGFWD8bb97u9UTIYslYex/lJlJjwtEB6aog1ZUNUG/mVwufY9JMQXId8Q4Q4MAQ+OnPIB0PCIqj6kHCYULlEr8Y4JrLQf7IPo/JRJyv7pJD3W1VX/DCyXDI6iSDR9/i2gJ2OZHvv+lb7rg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB2667.namprd12.prod.outlook.com (2603:10b6:5:42::28) by
 DS0PR12MB8443.namprd12.prod.outlook.com (2603:10b6:8:126::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.15; Thu, 13 Nov 2025 20:24:45 +0000
Received: from DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2]) by DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2%6]) with mapi id 15.20.9275.015; Thu, 13 Nov 2025
 20:24:45 +0000
Message-ID: <3f31ac34-1ce4-490d-9574-e6977b9ed3a8@nvidia.com>
Date: Thu, 13 Nov 2025 12:24:42 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 20/33] arm_mpam: Extend reset logic to allow devices to be
 reset any time
To: Ben Horgan <ben.horgan@arm.com>, james.morse@arm.com
Cc: amitsinght@marvell.com, baisheng.gao@unisoc.com,
 baolin.wang@linux.alibaba.com, bobo.shaobowang@huawei.com,
 carl@os.amperecomputing.com, catalin.marinas@arm.com, dakr@kernel.org,
 dave.martin@arm.com, david@redhat.com, dfustini@baylibre.com,
 gregkh@linuxfoundation.org, gshan@redhat.com, guohanjun@huawei.com,
 jeremy.linton@arm.com, jonathan.cameron@huawei.com, kobak@nvidia.com,
 lcherian@marvell.com, lenb@kernel.org, linux-acpi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 lpieralisi@kernel.org, peternewman@google.com, quic_jiles@quicinc.com,
 rafael@kernel.org, robh@kernel.org, rohit.mathew@arm.com,
 scott@os.amperecomputing.com, sdonthineni@nvidia.com, sudeep.holla@arm.com,
 tan.shaopeng@fujitsu.com, will@kernel.org, xhao@linux.alibaba.com,
 Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
References: <20251107123450.664001-1-ben.horgan@arm.com>
 <20251107123450.664001-21-ben.horgan@arm.com>
Content-Language: en-US
From: Fenghua Yu <fenghuay@nvidia.com>
In-Reply-To: <20251107123450.664001-21-ben.horgan@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY1P220CA0014.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::9) To DM6PR12MB2667.namprd12.prod.outlook.com
 (2603:10b6:5:42::28)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2667:EE_|DS0PR12MB8443:EE_
X-MS-Office365-Filtering-Correlation-Id: 77dd6e2a-be44-4f6c-bbd4-08de22f2af06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MkVrdGlyVkZVdFBhTjA2V1U2bmx6RGhXM1BMU2tkTUlDNUlqcHlFRDllT0Zq?=
 =?utf-8?B?aXc5cVdObUlQeXo0MUVHTkJSVkpsZVFXRDJSUkROVEdrWVJqd1llT0xQTXc3?=
 =?utf-8?B?eW9uWUF5ZU1GYXdEVUsrV0NQMDd6SW1FWkwvTTg5WmVQWnYyVDVtWjNoYnow?=
 =?utf-8?B?Z1NhdW9NZEhQOER5dVVzdVZJaU5XKzBTbDNBcnNPSUJnYlQzbkR6SWduZzM2?=
 =?utf-8?B?aWFRaWREVk9scUtCOHF4QkppZVZENGhaNStBRCsrbXZIcGhIQzhibGgwOEFL?=
 =?utf-8?B?QzNkbXhkTW1ndXd1UFo0aDRuc3hTUXNFbXN1OU9Td0IxQjN0R0psTjZtdjg0?=
 =?utf-8?B?L3piSjZMSmtpYTFQUzliUEpWcXVZbDREY2dUK2FvenNUVjZHU0dzc2lwZ1pE?=
 =?utf-8?B?R2Rxc3VEV0Q1cDJYTFJ6L1l5ZVRyWU5wOTRTdEFrMnpkcncxWThmTDNvbVBC?=
 =?utf-8?B?dG5Xa0dQeXdnQUE5c3YxNVphWG5OWDhVTmttT2p5V216ZGg3Y0t0R211Q3N2?=
 =?utf-8?B?cUJ0eDJUaU9xYUMwZjF1d3BIa2pjYk8ya2J6MEowbmJvUVZCVXZDS1ErZkhw?=
 =?utf-8?B?djZEMjlYWXMxWnpaYzlvcGhhdGN1Rzg4MzgxQzBBNDBEU29wMEd4MFdtVzhh?=
 =?utf-8?B?RXgxdExqQW9HTTlGOHdOZUYvNmtKL0lkWEFjQnNCbGVjeGQ0QW9tSjdPOXhT?=
 =?utf-8?B?cEo0K211RmcxeCtxcURvRUNtVVR6dTRBblErSEFJKzMrd2JXTkQvb1pkdHpv?=
 =?utf-8?B?S3JHKzBRTEc4eVFZaUlkWERnSnUxRjJuOFZBUHprMjNkOTVJc0puTmdZUlh1?=
 =?utf-8?B?TW9xOG9EVm1heW1wVlFta3NUemQ2TGR4UTgzZHBXMmtxOGhaS2VQdCtaU2Nj?=
 =?utf-8?B?ZGxraEcxdXQzd2ZIdHRXVWt6WEFuSW5xMUVxUHJYejBLTzUxTVNzYnR5VWJO?=
 =?utf-8?B?aWNsQjVJays5azRVa3BVdFZkUDJYTzlmSTd0VGNrdVgvSUpLRyt3dHlWTGFO?=
 =?utf-8?B?S1I1c3RKNkVvVlZRWTFhZXoxSGJZaGNoekNpUUs3TGc2VkpBYTRYWUZ4Z2xR?=
 =?utf-8?B?U0tpU3lna3A5VWZKV09DeFgxSDlMNVByT1RaeXp1VGorNmxmaW44bE9UZDFJ?=
 =?utf-8?B?dTRzM0dLWHY4dWNjTHhaZmt0TFZxcUJzYyt3ckFRVU1pc3MvSWszdHAvQWZz?=
 =?utf-8?B?UEFIcERyaWJvdDlOR3ZVWXVLRmhMclozSTZuNGczN1NZZ2VhWDQwODE0ZlB6?=
 =?utf-8?B?VThTdUZzY242bEkwbVc2MWczYUpXS0RJRmhPcU5MRHo5c0NxUW9ER1NzdUk0?=
 =?utf-8?B?SFhmMkZRRmNocjFBWWV6Q3hzTFJEKzZETWllNXhXRTU3YkZBZE1TTHBhNEht?=
 =?utf-8?B?WlhTZFczVnJoRlBRSjZBMUFrcCtEemwxL1dtMjlScG9vNnFvS3Z1TW9ZcVZW?=
 =?utf-8?B?Rk5NZTBMRFRoNXV0OFZoT2w0bjJDL0dIbW90Mlp6YWZSOTh4WkxHeVdxcEow?=
 =?utf-8?B?YWp6clN6bDZRbE9kOERwT1JuUnpoc0E1VUVEUVpkLzZFU3Eyd0xwVVREL2xk?=
 =?utf-8?B?bTJqc2Z6Tm9seUVybmNOUUw3RW8wWFhnOWVzZ3NCTG10ZHFTT3FZWndvUEZl?=
 =?utf-8?B?UTUwbUs2MXE3em8waXlmV1JMeWlTU0lrRjVnZ1ptNzJidDZLOGhaVWlmeFJD?=
 =?utf-8?B?V2IxeWg2M2JSdTBIL2lYSTU2V1RBam12RmdHYjE5aFJLczlySkx5VnBaSkRn?=
 =?utf-8?B?dXpiVnNiWlh3bVhnT2xjNzE4RjUycW5ZSHpScnJnVGJmbFAvcFJYRi8wcWlM?=
 =?utf-8?B?YVE1UG1KYU9sWUJqU0NDVVJJeFgxTHd2QjQxYndoTzhOa1B4WWJncTBGK0dW?=
 =?utf-8?B?cUhNQlRrNzNVQkh4Y0tQZW9vR293RG5kdWJscmV1eFQ0STA4Ujg4KzVwOCtB?=
 =?utf-8?Q?GMX3z50TRD11IJLI34tbAnjBf1IaJf07?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N0x1Vk5xNjI3bjJJNzhxY1J2RDRBYXlUOXMrZzlhSzZ6NkRPMjg1OGhXZlpC?=
 =?utf-8?B?Uk1LRjh3LytKUzM0ZnBDSU9EWDBhTU1WZDBGeGpVbHEwS2pYK0cwRU5kelNV?=
 =?utf-8?B?ZlFOMFF1a3VNTi9hazBYQnJqQU5hUnB5bW5mVUorTVJodU03K0w3UHJIeGhB?=
 =?utf-8?B?dXhDaHZ0aXRMRXByUmUyOEhwVCt2dzYyRDVJdjVJZkZWajY5VWhncTdRYmsx?=
 =?utf-8?B?QkVVRUJ3c0QzK05vSUdpRkRDVWQ2WFJKc25FZS9DYk5raDV3UjkvTldocG9U?=
 =?utf-8?B?a1k5cG5IMnR2SWo5bStBT3FhSlhhTHAwYVpqa3NSRUU4L2hGZ3VjQU5DWlh3?=
 =?utf-8?B?Znp0VUhqYVVjd0RLa2lOWXB4SjdDTy9ITEU4Mm9Ma0RyOGlyWGNHMkw1N1Ri?=
 =?utf-8?B?bDBYV1BtNnB5NVJKTUIwU1BDaVV1WFE1bmk2SXVBUjhCcFpaTzJNSk1aWnIx?=
 =?utf-8?B?NDFZMkxQSVdaL1FtaExQbzNzK0piZk1qSnorSFhwaFpja0FRRGFlN1J0dU0v?=
 =?utf-8?B?aTV3S0poM1REWTFXUXoybHZBS1ZhM1RzYWxXeDJ5SjJ0TVZNMVlOVW9IdXA3?=
 =?utf-8?B?OGNsaHByZ2xlQ1d5SWZLakZmbXRETVJHZWM4RlRVcDZCOE1pb3hkcDMzb01J?=
 =?utf-8?B?aWttb3FNb1VnMnZZSis5c2lKcVV3WERZNlFpY0F4ZkQvM011empvUnpXRito?=
 =?utf-8?B?MXdCYjJzcEljQThUL3U5OGdZTVVnbnlUenZsU1VUcmVvVEx2QWJEYlQ3bVRo?=
 =?utf-8?B?cnJaU3Y1WHlKTGwrenlNVXdNYVhSbG5oMXJsYVM5YUhzMVNzSVpMaFRyRXlE?=
 =?utf-8?B?bzh6QjAxckx3QTVUMmlMRjJ2NGxNbDlPb1RwMCtvcWVtcm1UQzF3M1VvUW85?=
 =?utf-8?B?d0s0QU5xajFIZDRXbklicWxOajFVU3d4V2RiblA1N2RISmk5Q2doeXNMNTZI?=
 =?utf-8?B?RXA3TGphNklGNnIwVmRVTHQ4QmNpY1dFbkZlYUlBaVZLNkxsd2ZldllaUkF5?=
 =?utf-8?B?Ni9aR1JJSTRwMWlweXR6TEpXUE8rTG5SVlFEVkVJbXgxVTg2dVlmSFc1Rkta?=
 =?utf-8?B?a09aMzQ5MExwOUZxcVFtRTYrZUxtSFlIeFhFOHBsY0RVOStNTC85ZElxQTBU?=
 =?utf-8?B?UnVaOFpVd3hRZlQwR2tzM29iWFlNblgzNHZuWFZ2RUlvLzBOWWRkb25rMjFD?=
 =?utf-8?B?QjJlOWtBWlJNV1R3QnZ2aHVJODJMcGRBTTZLM1p6OXFObEdxc3Q3dHU0N2pk?=
 =?utf-8?B?WDBoSE9uVnlrSW1mTFMvR0drVmFrNXlvUEJCZkdBY2tsQ2MyZUhJcGZjYXBE?=
 =?utf-8?B?eWpUdS9kNzBLNE8vbEp4eVpRRUxqVUZLT1Q4MnErVnhvYXhPYlQzYnNqWDFt?=
 =?utf-8?B?S1NmYzBxSTEvSGh3ckNtWFFIbWEySE14K3VEWlhUODc2K1VmSHc1UjdrZThF?=
 =?utf-8?B?UnZ0bUtFSDV3VHF3OHh5YzYrdTFQRDNRekx1c3c1Qk1udkJzSGxaSGx5cTM0?=
 =?utf-8?B?bHRBNnN3V1M0V0NoK3RUNFRjYlJ3Tmp6NHdrM0xwcnRIVTFWL1k5WldLNUxK?=
 =?utf-8?B?UTFRRlVSTGthMGxCOTlLZTdUR3ZqcjFrOXVMYkprNWZEUHA5SXJpT2NjY1ow?=
 =?utf-8?B?dWhGTGNEaVRFWWE4cnFhQlRIUDVTU0JhVGpnNEVFSmZ4aUcrQ1lRWTAzbHN2?=
 =?utf-8?B?dzhKNnh6TmRhcCtXb2p0eE52MkZ3M2t0YVE3UlpIS2hBalZwNnQwMkFRWHhi?=
 =?utf-8?B?YVJSZERHZ0pYaGVxRGtYWUhFRGtNdzFRWEF3NjJqUXN4dC80OFdEL3ZSUUxZ?=
 =?utf-8?B?MHdmTDdHNEFiRTFVZkRERDF3ZE1MUFlXejJoK3h1ZjhoR2htanBPS1VZaHpz?=
 =?utf-8?B?cGxrMTB5L2xMOEQzQlBVR1V1OTY2MlFPSFFLNEUvRmRFNS90UUNnbG9FcmFN?=
 =?utf-8?B?R3dtZU1mR0cwWVRuNFpvQ0M3dzUwUG9HS0xBbVFnR1ZnSGYraE5IR2duOXg4?=
 =?utf-8?B?RjM4RzgrM1Z4NVd1aTVod1hsZDQ2eHhpdVZMcE1xa3FPTkltZmMxZnMrenUr?=
 =?utf-8?B?Zk94OXQzV3ZZSW1LLzJBVmFSdUNkNXIydHA5bGI1ZlcvSU9PejZTYlo5aG9y?=
 =?utf-8?Q?xVZP/ko74mb8f9svtvE/+3Vys?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77dd6e2a-be44-4f6c-bbd4-08de22f2af06
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 20:24:44.9113
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7dUkgy8MyX9DwKch1buSl7Z79pOah6OqOFFY5RDmubiIQCXZg19+COOfR3/0BaekdlXtQkwi2657P9rX/ucnOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8443



On 11/7/25 04:34, Ben Horgan wrote:
> From: James Morse <james.morse@arm.com>
> 
> cpuhp callbacks aren't the only time the MSC configuration may need to
> be reset. Resctrl has an API call to reset a class.
> If an MPAM error interrupt arrives it indicates the driver has
> misprogrammed an MSC. The safest thing to do is reset all the MSCs
> and disable MPAM.
> 
> Add a helper to reset RIS via their class. Call this from mpam_disable(),
> which can be scheduled from the error interrupt handler.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Reviewed-by: Ben Horgan <ben.horgan@arm.com>
> Tested-by: Fenghua Yu <fenghuay@nvidia.com>
> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Tested-by: Peter Newman <peternewman@google.com>
> Signed-off-by: Ben Horgan <ben.horgan@arm.com>

Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>

Thanks.

-Fenghua

