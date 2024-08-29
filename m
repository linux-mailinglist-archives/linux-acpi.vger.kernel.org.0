Return-Path: <linux-acpi+bounces-7959-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F6CF9645A9
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Aug 2024 15:02:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BADF1288EA0
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Aug 2024 13:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 926D7194A67;
	Thu, 29 Aug 2024 13:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cz/u4xeU"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2041.outbound.protection.outlook.com [40.107.223.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B889474;
	Thu, 29 Aug 2024 13:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724936516; cv=fail; b=XDRmFS5O1mOdF23HdVctD92Q+YoR9Pbqx9mwnWRH9K+LqQXz8+TE6w6klizbj93WVkwSe8U5+XwmAxqWmG9eBMeMmZ/wbI8/f3x0NjmAO6Gt1oSNLdV1f85nDddEvXZgxYgb4uGlVlhz7O4iVOz9+sgmvf68pUlwl1eLeUy/m18=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724936516; c=relaxed/simple;
	bh=tg3Uf/k1RUVdJwwZozg+Mp/nC+HCv29KrJBO5ekflhM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JHNYb+8uwMoQHDWokLkbd0VDkXRVEeH5+jQdWDFzz7Hp2XM/Ac5VT8xCUOdb5IwVCEMCTaJc1k7O1IzyWoszpVr14UgCtyCyL7KPFsQNTpIkF0mo0/du7Vof/MEpTCszYDOCzuKwtkIMUeOK4Ov4K1BAQ//Olm6RCupH5MSh+SQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cz/u4xeU; arc=fail smtp.client-ip=40.107.223.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NkvrZDZE2T6taHILCeo/Yd/CmuWrdLNlDJnISbt4aRY98Za9bBXD9loQ1f6gms8ipcC0u7uDEHZyDatNuE8watMC1K/3qyPkMRZoPrPb+QvT4/lJTZmPih7l1Xms3rYOHnxd4A+ddFdfmhqQ7WoOR2SaF1/+I6W+RVpAw/RXPdMPAGvxOkiCMST6dUcoty7TI0phqpzIpCq8U9Xfs891sj3y32HCFxhKF5O9qjnXHe6+mv2rRNtno/W5rQT4HLWvSAkc9iSJjnNPWUiQzDcHMbVUNppiI/WaDL4umOhvini2aXbH+kiqHW2dlESEm5/CYXl+CEqxaT9+w8wiRIoqFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CZ+5UUS7xElsF1N1mHoCj/ZMnUk7FDKpYtD+d3QOcv4=;
 b=UmjD8Hx4c26UVcr+N+CHfQI4akaFNwTT3JDFJ0PK+biNKqEADw2TPmwhuc/laIjBav7vasZKALaqME9vUfu3zqDEp0WJTSSuXS8Tpx2LOJSIkljeDd6kxKdJV3EvMt3cbXUENDkrARqpT1w7xEwniOt8DrYFu8p2Bl+nf+MTjwmHNIwlnSAu027Jbv4cTlwPDFJJiKhjwj4Blg1MuAt8Mp4jbggugOOOBTzj+y84n9T762xTp2qCqg5hZLOYwVpmd5cwVmSW32+ayTXOkR1WAaREysNLrEAVSWHo+mxGFSR6bicnBDi7x8AZjzXCTK5WLouW49xQfolE0ZizOk0OCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CZ+5UUS7xElsF1N1mHoCj/ZMnUk7FDKpYtD+d3QOcv4=;
 b=cz/u4xeU5xEAYAB+nFt3gtbh2dufrVlAQ+sikhugQbcM2DPBlrX4NR8t5ZWanqshl5lHe9sjw6yWQJ4RzeHkOQRioxT0aJzFVWGfqLArwOB6kRtuY08BFPxKgZjbOD1X1tCZnHnXHMLrFdmxQeI4B3YcQKJLH42kEvKjCXXYq1c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by IA1PR12MB7688.namprd12.prod.outlook.com (2603:10b6:208:420::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28; Thu, 29 Aug
 2024 13:01:52 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.7918.019; Thu, 29 Aug 2024
 13:01:52 +0000
Message-ID: <39b25272-83e9-442c-9cc3-185c4e5cd277@amd.com>
Date: Thu, 29 Aug 2024 08:01:48 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/8] cpufreq: amd-pstate: Drop some uses of
 cpudata->hw_prefcore
To: Andrea Righi <andrea.righi@linux.dev>,
 "Gautham R. Shenoy" <gautham.shenoy@amd.com>
Cc: Mario Limonciello <superm1@kernel.org>, Borislav Petkov <bp@alien8.de>,
 Perry Yuan <perry.yuan@amd.com>,
 "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
 <linux-kernel@vger.kernel.org>, "open list:ACPI"
 <linux-acpi@vger.kernel.org>,
 "open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
 changwoo@igalia.com, David Vernet <void@manifault.com>,
 Tejun Heo <tj@kernel.org>
References: <20240826211358.2694603-1-superm1@kernel.org>
 <20240826211358.2694603-9-superm1@kernel.org>
 <Zs4G084+7MmzdYjU@BLRRASHENOY1.amd.com>
 <61b96549-2969-4b64-a40d-f91f614ec3ab@amd.com>
 <Zs6w3RktAb6fJrJ+@BLRRASHENOY1.amd.com> <Zs7Bwh6T3HCGlR9C@gpd3>
 <Zs866Myvbs0ByoAK@BLRRASHENOY1.amd.com> <ZtBvJk4MMCcF2SI8@gpd3>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <ZtBvJk4MMCcF2SI8@gpd3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0074.namprd04.prod.outlook.com
 (2603:10b6:806:121::19) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|IA1PR12MB7688:EE_
X-MS-Office365-Filtering-Correlation-Id: 9869d3ac-c279-4711-57bb-08dcc82ac059
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bFRwSU1zSFZnRjhrVGJ6bWI5bkE0WmpFejNuaW9POE5lWjI0emtiNmx4a2Q3?=
 =?utf-8?B?dHEyeVh0QmpFMzd4bzU4K3JZRUkxUmdsc0tCcGZieEdxNDBEZUlhMkJxUVA0?=
 =?utf-8?B?eUw1RVBOV0w0NFZBdUhadjFLWWZXOEs4WDVuY3NUbkpPcGJPRjhweGNMZlVK?=
 =?utf-8?B?aHU3WHFUNXZjbEFLSEhNeFZXSlE4eWhJU2hrTStzaU9vUWRwbGdHOWI2Ty85?=
 =?utf-8?B?SjdRMEhiT20raEpoZ3RIK1RLNkoyc2tRVExWcUo3Z1lBTEpEdlhwaWsvNFBN?=
 =?utf-8?B?aFVSL0Y1eGtUdnNwTzFUK3hpZjRZV1BydzV2Z09XbGNXdnFmMWxSNWlqL1Q1?=
 =?utf-8?B?WjJnNW5kRzlvcENYdWxWdWo4aEhjZk1lNGh5dEV1eEpMWW5ZVHJISE81bjdW?=
 =?utf-8?B?ZXhVRHlKdXdEM3k1WjBDZ3MyblFHOWVrNWNDa2YwYjNZWnh5R3RWWXM5K3pn?=
 =?utf-8?B?QUFGVmFvK1Q0SWVuTXN4Z295blloNW02Zkkrc1dEM0FTRWhGbUN5b3JYQ2ls?=
 =?utf-8?B?bDh4TFNKUktBSVl0bmZsZ3dxUDQzbnZ5OUdCZWlpdHlVaDRLYnFpY01GVTZs?=
 =?utf-8?B?SzZLWkl3RWJ6YzJESC9hYzE4NjBXVkoyVWZJRHdCK3N6TDUwSytuYXI5OENz?=
 =?utf-8?B?VjFCTzArenhRbmpWMHM0Z1N0SjdKazJyUVNHQ0lxTEJ3NExWaE1WcXREeFlJ?=
 =?utf-8?B?cUZld0lBbG9NZ3FwUFQ3bHBlV2F5QjAzQnNIMmY0YjFKSGIyYlNwNHBrejhq?=
 =?utf-8?B?R2sydDJ5Z0hLdzd0emRaQnlLVklPam5uUVpHNzJVU2dwcENHSUpPNlpmRWFk?=
 =?utf-8?B?SEd1SHBoYU5xT0tuUlZpeHZFQ3FyT1FqdDB0MVc5SURvSXlxQjdMNWxXL3Rw?=
 =?utf-8?B?a0tBYysyZUZqUG53MUdNek5FaUNXNWl6UGxoUEw0Sm1YTWFUMnJXYmFPMlI2?=
 =?utf-8?B?ZG1nT01wVkxPN3pLK2Q3NkZFZFFpdzBEOXZpYlBwRzZ3SWJ5dVBYVXdvYXJ2?=
 =?utf-8?B?ZXJ4WE93d204T2FIaytZUzgyS3ZJVFlBL0s2OUg4bmtJTmh2bmxMYTkvS25E?=
 =?utf-8?B?bGZZMEVUWDhQNGlwODZaOWZDVzd0cHZZdWhlVEM1UzkrUmJ5R2ZLUWZHb0Rj?=
 =?utf-8?B?ZDdSVC9mM0JTM0MzVTgzYVhsZHZjb1hWcURKVG82bjJQK20ySHJOc2pON3ZC?=
 =?utf-8?B?MjM1N1JCVk5kZU1sbE5nTENjYVBzUW1vZDhLY1ArU3dVcmRyTDBCV29IdEVt?=
 =?utf-8?B?d0ZtazZDZ1FNQXU3WWVWNmtRVDJLVTRXM05tRGF0MlNWUVNmcm5FODYvaXpu?=
 =?utf-8?B?c1lKNnAxSDVnT0lsUjNEam1CTGZ1R3FNcXRHU3I5bTdTbkM3UGNLL3VHYWoy?=
 =?utf-8?B?MUxUeHNqNWZENUNCWFpiWmRjRzE1bEpiK3UvNUs5RXdqaFZ1K3BwZ0kxTktG?=
 =?utf-8?B?cytpYmpRUXBKUktnNVNUTExJR014SU5CU2JrTzJaSXZ3MFBDTFhsRHNMWGdw?=
 =?utf-8?B?R2hjNnZOK0JVb1RsS2NnOFFsQUEzN204a3Nrd2FZWG8zUTIycDcwNTVPSEpN?=
 =?utf-8?B?eEQ5TTNlSlVob2xJM0VWSS9ibVAwMHdYcGF6UmFUb096NGlQcVdoMElDN2Y1?=
 =?utf-8?B?ZWtWUlhWTjZsR2pLUnM2QjhYMlc0NFRtWXZVU1lsclRvaGhjTUVJOGxCWW1H?=
 =?utf-8?B?NmxDVHBBSzFmK0llRmxDWXpoS0NINWhWV1BhOWdSa1RVQ0hMRzdhOFdtWGg1?=
 =?utf-8?B?dnF5cWx3U2NUQ29XQlVaQ2lEQ1Jxck5KOStPYlVJZm5LcDlpUUw1NXA0d2xJ?=
 =?utf-8?B?N1VzWTViQ3RFanA3b2dqQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SGdBcDRSc3BINkw4Z1NRNUpseGNoaDhseHNCTFVzSzgrdW5rVnZYbG14bEJP?=
 =?utf-8?B?bjBKaC82VjZuOUd4NVhNdmVjNXpsVTNsTGlBcTRtNVJtcktqeU4rc2pTVG9h?=
 =?utf-8?B?VWRjbFM4K1l1VXJ4UUhtMTZhbGJRcUZRaDB1SUhSUEtueFF3eDFvSzF1QkUw?=
 =?utf-8?B?MlhUYkZZRmNvNEcxaWdYWHR0M2JwUy9LRHhjcGlIZmVIUmdiSDN0eUoxMnJL?=
 =?utf-8?B?K05pZkhneFY0WGU3SmRGb1VzVDJ5KzlIMEZ0RjF4WlNzY2lkT1g0Y1lSQmda?=
 =?utf-8?B?VmloZDNBdUVSaWRuU3N5VmN5RzZGRjczRXAvL3FOc3Z4VkU0Yy9kQUY2bFJO?=
 =?utf-8?B?bmMvVGQ5bHorcXg4dmFsNVVpdjFRUUVaV2o4UVo2WUdGL2dhc3R4ZTYvNXdZ?=
 =?utf-8?B?c2p1OC9KY09YVDJqL3NGcVdkOTRURmZHMjFnTmxjcWdHMWVjVmtleU8walYw?=
 =?utf-8?B?L2xzTGRTMk5EZ0x3U1dLTm45MmRyZ0IyVG5CWEdrVEpQMlRXUVZoWU9uTy9q?=
 =?utf-8?B?dVlMYnpjczEzNGlYUlNvNVY2RnQ3dmVTbHlLU1V2Sk55eVVXUGIyYkFYYXBz?=
 =?utf-8?B?YThRUWZQZmNIZ0QySXJjTDd5blEyVXdhZFY1WFNCSmpqQ1JqcWU0TjRRcmlL?=
 =?utf-8?B?OUhEbG85ZUxhQUh2dm81RkxIaDF6Q25TVXUzY3h1L0NTTUQyNEhtWTNmUW1O?=
 =?utf-8?B?bDN4R2ZDQVpOd0lxbGhna2pzbDAvYmFkSTc0VFg5UzlJS0tzdjNlamhVR3Fl?=
 =?utf-8?B?NGh5MWhxUnZ4SVY3aFFRL0hvN3U5WkUxT1IvbjZrU2taRUNBNGNqblpYT1Vw?=
 =?utf-8?B?dldiSUE4Z0tSaTVkWktsSlVSWWhVQVhNdHUyWnVoRjBKSVNkYkR5cFZmMnZu?=
 =?utf-8?B?Z2ZXM2I0RDdHT2pUMGdNay9CazhtTld5MnRuRFJ4cmRGa3BJZVJYZnVISjhN?=
 =?utf-8?B?SDZYTzZkK0IrREVsejF2bENxUldzSE45Uk5zSjJ2Vko0REZGOFR3aks2VjlH?=
 =?utf-8?B?UkFta2g5cllyZUdDUWNMdjNrM0pNWE54N2NPbzZlRGlHMUVIQjFpMWpKWWxp?=
 =?utf-8?B?a2w2YWl6ekl1bDk5WEJ0TW1BeUxhTDN6V2RHZXV6WXBSQStZVG4xWldsRms2?=
 =?utf-8?B?SmtRbWtGS2NEaWhVYlhVRFViOGd6WEVIR1lXR3pSdEZQdnh3UTFjaEFmeitN?=
 =?utf-8?B?Z1V5QW85WXVMMGRxTHJ3LytWOURFMDNwZUdxaE4rMmwrMzRYaTVzUGRJZmkr?=
 =?utf-8?B?UW1iNVVBQURuSVFDSExyb1lrakRMZVNOTlY5Q0tlM0c3YWxTdnVPVnRoQUZk?=
 =?utf-8?B?S1BEc045dVdUSVFhZWJMd0R0RjJUV2orT1VsT2xLUlkxM3VtWHZ0ZUowL3Vn?=
 =?utf-8?B?TGFpL2ZQTHdib2poN0RxQ1hkMGdtZ3QxMitSdkd1bmdHeHZHQTVKQlUyNkVQ?=
 =?utf-8?B?VVltVElWOWFvZ2JZaEhNNDNqVVBMNGUyTXZVVnVkSE1GRkZRTVpQYUJxWURp?=
 =?utf-8?B?NUI4TzFkb2FXQkIyVkxpZTE3K2FTL2pHVzNkd0lOTElEQ2oyVXJHQVlzRnp4?=
 =?utf-8?B?REQ1U0tBSFBhWWRodUUwSHJrdDNoaGhsRFlyK20xSWZoLzkwMzlOVmNYMUVm?=
 =?utf-8?B?WHFuNWpZVnVSOUZZL2pRTFI3VlNNSS9Fd1kxdGxWS3kxeHFqRkF4V1lJdStw?=
 =?utf-8?B?M2NBT3l1YUVjR0h4SnNBS1I2d0dpTVkwLzJwU0NOR2NEYWwxRHg5bTdaYWJQ?=
 =?utf-8?B?VS9BMDU3MkxteTFYeDhaVzBWODNKQ0lnZjVQbmhhMXgyRjVqeUo2K2lRRnlD?=
 =?utf-8?B?bFdaVEVRMnppOGRNdGcyM09hYzhEaE1nclV2VEdJMDg4N3o3S1lNZ3RTTTZL?=
 =?utf-8?B?cWxpSTNQMTZuMVc0djFBczNGR1hVN1NoeFZrdGtVVDBsL002SUYveEpnNFJj?=
 =?utf-8?B?b2hxeUVwb3MyYmd3Q2ZIL3UzNE9uWjdyMktDNGZ3bVZMT3orWllIMFFSelhM?=
 =?utf-8?B?TTJkYjlLWG5WaXBiMjU0blM0RzE3WHhJeGVnTkJXVk1hWjhpZ0Jpd2h4MmNK?=
 =?utf-8?B?dEt6VTIreGdYK0FncUFjYzRDY2Y2NzBmb3dKb0xpR2VqNWI2MjQwRnVTL0c2?=
 =?utf-8?Q?Y+8SiYQ7h+e4f+sQhn4jeJlhu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9869d3ac-c279-4711-57bb-08dcc82ac059
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 13:01:52.2571
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DHiig7pRiNDM4AyNUimsyvtf5qe111CGGYBryDhUqEn4RzHHqivTB3sD2DdcX5fsL1PA9VfFuBHfKpOnmj49qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7688

On 8/29/2024 07:52, Andrea Righi wrote:
> On Wed, Aug 28, 2024 at 08:27:44PM +0530, Gautham R. Shenoy wrote:
>> Hello Andrea,
>>
>> On Wed, Aug 28, 2024 at 08:20:50AM +0200, Andrea Righi wrote:
>>> On Wed, Aug 28, 2024 at 10:38:45AM +0530, Gautham R. Shenoy wrote:
>>> ...
>>>>> I had thought this was a malfunction in the behavior that it reflected the
>>>>> current status, not the hardware /capability/.
>>>>>
>>>>> Which one makes more sense for userspace?  In my mind the most likely
>>>>> consumer of this information would be something a sched_ext based userspace
>>>>> scheduler.  They would need to know whether the scheduler was using
>>>>> preferred cores; not whether the hardware supported it.
>>>>
>>>> The commandline parameter currently impacts only the fair sched-class
>>>> tasks since the preference information gets used only during
>>>> load-balancing.
>>>>
>>>> IMO, the same should continue with sched-ext, i.e. if the user has
>>>> explicitly disabled prefcore support via commandline, the no sched-ext
>>>> scheduler should use the preference information to make task placement
>>>> decisions. However, I would like to see what the sched-ext folks have
>>>> to say. Adding some of them to the Cc list.
>>>
>>> IMHO it makes more sense to reflect the real state of prefcore support
>>> from a "system" perspective, more than a "hardware" perspective, so if
>>> it's disabled via boot command line it should show disabled.
>>>
>>>  From a user-space scheduler perspective we should be fine either way, as
>>> long as the ABI is clearly documented, since we also have access to
>>> /proc/cmdline and we would be able to figure out if the user has
>>> disabled it via cmdline (however, the preference is still to report the
>>> actual system status).
>>
>> Thank you for confirming this.
>>
>>>
>>> Question: having prefcore enabled affects also the value of
>>> scaling_max_freq? Like an `lscpu -e`, for example, would show a higher
>>> max frequency for the specific preferred cores? (this is another useful
>>> information from a sched_ext scheduler perspective).
>>
>> Since the scaling_max_freq is computed based on the boost-numerator,
>> at least from this patchset, the numerator would be the same across
>> all kinds of cores, and thus the scaling_max_freq reported will be the
>> same across all the cores.
> 
> I see, so IIUC from user-space the most reliable way to detect the
> fastest cores is to check amd_pstate_highest_perf / amd_pstate_max_freq,
> right? I'm trying to figure out a way to abstract and generalize the
> concept of "fast cores" in sched_ext.

Right now the best way to do this is to look at the 
amd_pstate_precore_ranking file.

In this series there has been some discussion of dropping it though in 
favor of looking at the highest perf file.  I don't believe we're 
concluded one way or another on it yet though.

> 
> Also, is this something that has changed recently? I see this on an
> AMD Ryzen Threadripper PRO 7975WX 32-Cores running a 6.8 kernel:
> 
> $ uname -r
> 6.8.0-40-generic

You're missing the preferred core patches on this kernel.  They landed 
in 6.9, it's better to upgrade to 6.10.y or 6.11-rc.


