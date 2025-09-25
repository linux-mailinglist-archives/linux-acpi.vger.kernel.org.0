Return-Path: <linux-acpi+bounces-17314-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D646BA0A3C
	for <lists+linux-acpi@lfdr.de>; Thu, 25 Sep 2025 18:36:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37DC4380E11
	for <lists+linux-acpi@lfdr.de>; Thu, 25 Sep 2025 16:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65DF5306D26;
	Thu, 25 Sep 2025 16:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="d1mi47+h"
X-Original-To: linux-acpi@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010021.outbound.protection.outlook.com [52.101.46.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFED12E6CCF;
	Thu, 25 Sep 2025 16:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758818211; cv=fail; b=cJ2pa5Gv7uB5opa7gF/BuZELZzxfWFUFdEa6kyWaFOwWavuE1aJAItrIKUHZ6bPsB8lD37JeGj5e965PefIMbGVqGhBKdUZlzP7AfW4KUsztKwAgpQOsIehLvLjalV0ZiGh0vClrHuXRXilV7qW99mKIME2JUEpubHC6mXJuH0k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758818211; c=relaxed/simple;
	bh=dx26ayi8+eXVtM//g5MFeBTI5+K9JZdhMz1B1vWIzBU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=f8tEwN2r/WkUbZakccXnicpAQYCRsAfzKIOXva0iS+eKb8Ty92q8ahdcSVRrLGYqB1JlTNDJpg9cQxD8aMMg5uIcgakflfUbgKvJijNpvQ/nwEh7TesCNT8luM6OrIfh8OIjEjPzX7hqFys2YRItu7ndxcG78LdUjNWzBvBRV5w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=d1mi47+h; arc=fail smtp.client-ip=52.101.46.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WArrY4JvxI63n80+8Z9N5WcAhgxAP8P/HANKoBDhjOvzpvY+q917ubdlQc/sJD0LIV25blvSeMSqNxJoRXzPo0Iy+mskEOBZauWhF4zVXTGO9/XEprsuSTJn2glgNb+kfIaAiLTw2aadtUecz/032zzF6H2o21hgtOjX8iEhi0MUxZV4bvAq1939vLmKEsd4NtO+II6KLVBbXY4wGl0rCAq8BU61avq2n+KXpNG7E/BLqBwnUQm1DGh0Pvmb+1qD9HZnIJaQKWxjK2MPj/3nVJQkdMN/TzDmpTcroE6Yx+2ZIMFxKQJYPdDsHWqwNkqMN17kDegBsvW60wmLJ3RwXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ePwdgqvSAWBsMq0B6n4fi5JkztCiWKdqBRGswAUIIBA=;
 b=iV3qNWI7cjMX8ti6FZSE//jqUMKDfNLuFxWCOn5KMwJOb0+h+WtYVkn5fxNXDGhYdAX3CUgu9Fp1pAmL1Sc0Gti200XZ4k7Z+YYosuTRycw0rtBJZswBAmnV5CXviXBHKauz+PneIabmmxuddqZdd+m1FAF9iu/O81zb/4Lz31VJMEqfLxWlPj0ngkWdgzlL5RjQWhC7iwQbDfpeoNx5HLtyZzsXru52lAqm4A4+k/hRja2+6Xx5EIeAOlCusiCeWWPqaFTmjzxJg1R4mI4eJVKx4fJ7jE/3aqVs2x5squeWR6vHFn63Fqla11h4LcbKkrxmJO41ppw6VstzNfH4rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ePwdgqvSAWBsMq0B6n4fi5JkztCiWKdqBRGswAUIIBA=;
 b=d1mi47+hJeT3hbTrCzhIAqGRchTGmoihp6dSv8ioUif+buKyqykbuMeNcW9R95OxuPoX/zqGB6q/1pymCTRoP7X+zzWZnH+GzTWs102lxWum7HUvLSURA6EK193QzHJ/OQWMCyeOQnrRcsCZ0qsmhyD/2MdUKNCi3qmy3zhABs4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7SPRMB0010.namprd12.prod.outlook.com (2603:10b6:8:87::8) by
 DM3PR12MB9349.namprd12.prod.outlook.com (2603:10b6:0:49::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.11; Thu, 25 Sep 2025 16:36:46 +0000
Received: from DS7SPRMB0010.namprd12.prod.outlook.com
 ([fe80::b021:a6a0:9c65:221e]) by DS7SPRMB0010.namprd12.prod.outlook.com
 ([fe80::b021:a6a0:9c65:221e%7]) with mapi id 15.20.9160.008; Thu, 25 Sep 2025
 16:36:46 +0000
Message-ID: <11e2cb33-05cd-4ef3-86e6-ef57e5f1222f@amd.com>
Date: Thu, 25 Sep 2025 11:36:43 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/4] cpufreq: CPPC: Avoid using CPUFREQ_ETERNAL as
 transition delay
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: Shawn Guo <shawnguo@kernel.org>, Qais Yousef <qyousef@layalina.io>,
 LKML <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>,
 Prashanth Prakash <pprakash@codeaurora.org>,
 Pierre Gondois <pierre.gondois@arm.com>,
 Linux ACPI <linux-acpi@vger.kernel.org>
References: <8605612.T7Z3S40VBb@rafael.j.wysocki>
 <22867781.EfDdHjke4D@rafael.j.wysocki>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <22867781.EfDdHjke4D@rafael.j.wysocki>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0111.namprd13.prod.outlook.com
 (2603:10b6:806:24::26) To DS7SPRMB0010.namprd12.prod.outlook.com
 (2603:10b6:8:87::8)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7SPRMB0010:EE_|DM3PR12MB9349:EE_
X-MS-Office365-Filtering-Correlation-Id: 69863a3d-eb9b-4d28-646d-08ddfc51b787
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MEFaTXorcjVyeEJ2N0J0UnZ5R1BHdGhNc0lXZWZ0cTVYV3ZpZDBSUkRmN1Fx?=
 =?utf-8?B?Tlk4RC9VTWxLQkVDSkZRT05FRG5XWTEvTmNYK0ppelpySDRsc1JlVVJ0NHdZ?=
 =?utf-8?B?TTJXTWxxL0N3UG5oL1o2ZFZseThnS3VreTRjZGJ4VVdXVmw5OXU1SmtLTkE2?=
 =?utf-8?B?aERicFc2dDRmb2IzWmhvSnIxR1k0MlFYZENFY3EzWndHd1JLOXpzdmVHL21x?=
 =?utf-8?B?NjJwd05YWTJPb2JGVVl3NGhjZkJvY2ovY2ZZQnE5UDdESDZjbXRsQjRnaEtL?=
 =?utf-8?B?U1VoMFI2ZzY3T1RJdTcvbVBJVVgwT20rU0pMaERYSWZFSXYwSG5wTkU1dXZO?=
 =?utf-8?B?TFAwemdpUjNySEJjUVBhRXNkRUwzdWx2K0FoODZaNEJmTmJ3bFAzcE1DbUQ3?=
 =?utf-8?B?dTVaVFlzc1NqcHJadCtjbXljaUlrbGhRL0ZtNXpleW9xREZEa0NreHBDbDUr?=
 =?utf-8?B?dFVUa3hVZmNQSWF5MHhHN0dYYll4dmx3UUJWTDZGVVcvK2NXTW4zVU9yaFN0?=
 =?utf-8?B?NjIyMkdOLzNuNFF1QlpZaGRJaGpBSGFsYXpiQ0NDUFl5YktQeUpQaXFoVHNn?=
 =?utf-8?B?bEFiQU13WHZXUGhmNHBkUnV1aE0zVFluWnJjeVRZcFFnUERHQnpFU0doLzRI?=
 =?utf-8?B?NjVxWWxtcjl6cHU0dnU2amhjclN3Nis4NWV6VzVqcXNOSDJJS1pma3VlbXpw?=
 =?utf-8?B?dktIUHRWaUUrK2lzZU55REY0dCtXcFRPMGZqUitGSXgxcUtTOGFiL1ZKelJV?=
 =?utf-8?B?aFZZcGhmL0RQOFZveitBWGlWNkphVWVnUTE5SUxHSkNPSTMxRS9qZTBZcmNX?=
 =?utf-8?B?dEdjVFpVMVBVR0IrVWMvRko3RVZrWW1HdWpsRnRvTmhhRzhleWpydjdWMnpC?=
 =?utf-8?B?dWdWZVpYbjNFbDZ2dEF0d3h4YkgwckQxbmVXczNmUTNvTW5aTlRJL0ZtaVp4?=
 =?utf-8?B?a2prK2ZqQVJUM3dSTksrRTZ0MllwMkFuT0xhOFU5TjN2MWtXakZKSUtaMm1n?=
 =?utf-8?B?ZWhNaVR6N1dkZ3JYVkEyRlFIQzhjMkFOVkFuWjBWVUUrVGxXYmdWZ21wMmxh?=
 =?utf-8?B?akZ5RGJLdVdlTlBmcGh0RlNTUWR3WGFoUjl4NktxcmtjSlpERWNhMVBGYlNs?=
 =?utf-8?B?M0Y4enRjakdqaFYxNUNPUkQyZytSS1d6WUw1QnM5azMzaHI1dHV6ekpMTmcr?=
 =?utf-8?B?ajg2aU83OE02VjBaR3N0enB4QmNsVWVyQzBMNXZPSFgvMVJXekNmZ3dHY09H?=
 =?utf-8?B?RzdCT0E2SFovdnVkK2Zkak80cXcxMms0aGV2Sk1hWUdDcUNjSndkYVU2ZVd5?=
 =?utf-8?B?eHcxbFJoeGtqRkNBckU2YXE5bmNNT3lnQUFtUXhSaC9QM3I2cnY2dzhGclBn?=
 =?utf-8?B?TlZRUitUOXEyRDhnbnVKVHd5anYzeG5uUnE0cWNwZXNBRjBZSHBzMlRsTXlI?=
 =?utf-8?B?NEtOM0pZWGJ6OTRZalVMbEhiYmd4elBEcjIrRjc2OUU3Y1I2b01WNnpGcytI?=
 =?utf-8?B?bGVwbEpYZVpjRlBDTTZpMGc0cVNFZUt1b0xkcER3eDQyMGQwR0ppR01OZ2FJ?=
 =?utf-8?B?cnB3M2J2c1grN092QWcyRzJhckhPUEFMMUcvdUhvTDFReUwzbUJVa3d6cERU?=
 =?utf-8?B?ZnMxOHpsdTNJWWo0aWkwRzNkWFJVTXhDUHNQV2pEYVlMN2VTOGU1WkhpRlJU?=
 =?utf-8?B?SkFVTjJPYjl2RUJKU09Yck0xZlN4WGFlWXEzUWR4ZTBwcm5YSXcrL05DNHp1?=
 =?utf-8?B?VmRvOEU5b1NkNmdUUDhVUStRaXFRdW82RFNxSkpxSnYwK05Lc0dUcWJMMito?=
 =?utf-8?B?ZklmcUhiWTFDUDdWYTZFM0IzMXk4bDdIcGZlOHN0b1RZb21HUllOa2Y2a2hk?=
 =?utf-8?B?Nm83d2xaOXBQazU3R0o2eTR0cUlSaFZ1ZnM3VEhoN1lVU2NOYWtPOHBKUW1y?=
 =?utf-8?Q?atFQPwmPUu0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7SPRMB0010.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZmFocTdHVkxuWnlMWWZZUkQvM05xelkzT0NPem5CdWc0UzByNlBOSXJvNFo1?=
 =?utf-8?B?eVMyejdLUklialNiSDdSMUtpODd5a2FML3lmb3dLQkwyNndLWGZpSmhqczJZ?=
 =?utf-8?B?VzN5YjYrWWZsZTRKcEFiM0IxbCt3OUdKRzliYXYvcUhCeG85cXU2NmplTHcy?=
 =?utf-8?B?ZzFaQ0kvQjdMaG9MS3FEWjR1TTFLSnF2ZTZiR0dmWGMwYjFtTDdHR3FBeHNu?=
 =?utf-8?B?b3AwWE5VZHI2Y0pCVzZBWXBGQkZWL0xEMVRtNHhYUzMwVC9pck9CWk1scHpM?=
 =?utf-8?B?dkRIWC9hN2gvcE5TUUdCRklSaWdQZExBMFR6RWsxM3d4SUpPWVEwTkdzMUQ3?=
 =?utf-8?B?STViVUZwYll6RXlKR3kxNEl5SWsramlRbEtHNko4Q3BlbWJ6ZGlZa01USm00?=
 =?utf-8?B?MDJRQ0l5VFZlaC9GekZ3L0pMTTgwMXN4VTM4OC9hbnNQN3BuRkw3NURMY1ZP?=
 =?utf-8?B?dG5IWkg2bE9zTndCclpQcU53Z2llWGdxWGVZeWF1Q2ZwenNtUGNwVG1Oa20y?=
 =?utf-8?B?bkgxZHd4blF6VkJYYkxLV0lES3RNcXhuWSsxb1l4NU4yWG1SNUFERUFBanM5?=
 =?utf-8?B?SVVtVERVZEFwM2pHbkJPRzZEYzd4bERSUm1SQmtERWg4R0tRM3doU09BUFAy?=
 =?utf-8?B?L1lRNW1JREM2TW5kUDU1cjJyRTZaY3FpOW5GT0pVT0EvVUZHRzMzY1o0OWc4?=
 =?utf-8?B?ZHNwcWJFWElkeVJnVXBsVmFRb1BrWXVJQys5Mk1XcUZCaVFubVg1cTdoRlVW?=
 =?utf-8?B?ZkN6Z3cwR0did1Q0M0c3UExGUGVXb0hObCszTE4xKzlseXVZaHNXNVJGYVdv?=
 =?utf-8?B?OHI4SnlrZjhyZ3J0L2ljMDRubGxnRG5nd1F6Q2dCNE9FYWNrSTd5a2lKbUpY?=
 =?utf-8?B?NWplRCt6N05KS0txRTdOdzVGbkdUYjJzK3FYNFVIb05HZU5NY21MME1NYUdt?=
 =?utf-8?B?Yi92cTJvS0owNzdZbVArQXp0YjlEeWpzdkUyNXJsdHZMNGx2dlZpZkZvdHlV?=
 =?utf-8?B?SHdEWDR1M1N5NVMxNnVyUWdpYW5TQzNKWHJCNWlCV2VxRS9zVkZBTmxzM3or?=
 =?utf-8?B?bmdkdndsLzhxVit3Qi9UemdTZmpxNzc1eW1PL1ZEVDRrbWNMQXlHTllqbUVR?=
 =?utf-8?B?MzFQN0YrUmYxZk5XQUVtSmpBMyt2bnFCbm1vSWlrbjlUWkhpTHVwckZrRndn?=
 =?utf-8?B?UDU5UEFZYnBhSUhZem5yRFhqQVNYUFBqKzBiZEc5N1krL3Z3TnlnSm84NUJr?=
 =?utf-8?B?NHpmRjhtcmZLQTVwNkNmb0dtUWsvSFdpNm0waWVVNmVpMG15VW53dXNxc3BI?=
 =?utf-8?B?ZVFTNkJiSjRDNVpNZ0dHelV2U3pMcjVmSlJSR3pZcGxQNFJmMGdpTkdhZVRP?=
 =?utf-8?B?M3QyTmZnYXlVYVZYNHJkV2V6R1VYdXdLZmZ3WHRpNzZoSk9MUUlnZ0xSVzlX?=
 =?utf-8?B?OHRYTnB0eXNVY0oyOEhVcFVyZllVVFliS0tqQlc0WThVK2hScTFiNGtwS3U4?=
 =?utf-8?B?WFdkL3U0S0FlazBYYmVvYm81MWxpdzRscDFzZmxMUnZhZmhVSnUrajFISzFt?=
 =?utf-8?B?eCtnbktZOWc5RlJ2OFNjbm5DZnRBbUJ0RjVVRzAzZUQ3YTIyYjRBaXZVYnRB?=
 =?utf-8?B?UENLQjJQTkRPUEVLQzhqZENhNFhsSXFTWkQwdjNXbjdEdmFpblBRYm1FcXFr?=
 =?utf-8?B?MnVSRGFuUmdSN21JeWNBRDVyRDBZeEZ2OW5VT1lGZFgvV0gyOXpOWlMzR0xj?=
 =?utf-8?B?c1dNSUE3UjFVc0M0RXFMMUNBQ3JJdnptdWl1WFRCVE80eE10a25xZHMzQ0V3?=
 =?utf-8?B?UU50MEFZMmZJc1AxZHFrSTNTUFl2VGJTQ29RU3cxNFVTQngzUHd6VW0wSXlp?=
 =?utf-8?B?aHJxR01rYWd1SW1ORG0yeVRWY25Bc2FaN0tmMlJ4aXVQRjlJVnlsRlNkOWtW?=
 =?utf-8?B?RmlMbnA2SVhWQ3Z5RThVc203VXpLTXRIYmRydHRXR1diWjg1VjRCU09pVkh0?=
 =?utf-8?B?QW84R3dzMUVBSUowdFBZN21CYmNIcFU0bFd5NnBhd25WVHdHbFM5dURoVml5?=
 =?utf-8?B?em51YUllQW8vaDJNT0dGa1NvQzBGNk1KUjJvZlA3L1c5R1QvTTd0ZUY0cEl3?=
 =?utf-8?Q?VYlsWWwNeOnuipTCs7Y+ir8Z9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69863a3d-eb9b-4d28-646d-08ddfc51b787
X-MS-Exchange-CrossTenant-AuthSource: DS7SPRMB0010.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 16:36:45.9144
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DHcc5Dccb0VybGBLuOJfchcrFl8MUGraNhemrERc8bOHTgfV18P8kg2n4mXWKigp3lEl7UP3BnwmHqOMdN/V1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9349



On 9/25/2025 10:44 AM, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> If cppc_get_transition_latency() returns CPUFREQ_ETERNAL to indicate a
> failure to retrieve the transition latency value from the platform
> firmware, the CPPC cpufreq driver will use that value (converted to
> microseconds) as the policy transition delay, but it is way too large
> for any practical use.
> 
> Address this by making the driver use the cpufreq's default
> transition latency value (in microseconds) as the transition delay
> if CPUFREQ_ETERNAL is returned by cppc_get_transition_latency().
> 
> Fixes: d4f3388afd48 ("cpufreq / CPPC: Set platform specific transition_delay_us")
> Cc: 5.19+ <stable@vger.kernel.org> # 5.19
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>> ---
>   drivers/cpufreq/cppc_cpufreq.c |   14 ++++++++++++--
>   1 file changed, 12 insertions(+), 2 deletions(-)
> 
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -308,6 +308,16 @@ static int cppc_verify_policy(struct cpu
>   	return 0;
>   }
>   
> +static unsigned int get_transition_latency_from_cppc(unsigned int cpu)
> +{
> +	unsigned int transition_latency_ns = cppc_get_transition_latency(cpu);
> +
> +	if (transition_latency_ns == CPUFREQ_ETERNAL)
> +		return CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS / NSEC_PER_USEC;
> +
> +	return transition_latency_ns / NSEC_PER_USEC;
> +}
> +
>   /*
>    * The PCC subspace describes the rate at which platform can accept commands
>    * on the shared PCC channel (including READs which do not count towards freq
> @@ -330,12 +340,12 @@ static unsigned int cppc_cpufreq_get_tra
>   			return 10000;
>   		}
>   	}
> -	return cppc_get_transition_latency(cpu) / NSEC_PER_USEC;
> +	return get_transition_latency_from_cppc(cpu);
>   }
>   #else
>   static unsigned int cppc_cpufreq_get_transition_delay_us(unsigned int cpu)
>   {
> -	return cppc_get_transition_latency(cpu) / NSEC_PER_USEC;
> +	return get_transition_latency_from_cppc(cpu);
>   }
>   #endif
>   
> 
> 
> 


