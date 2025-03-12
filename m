Return-Path: <linux-acpi+bounces-12158-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F4E9A5E777
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Mar 2025 23:29:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDB8B17D00C
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Mar 2025 22:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BFBF1F03D6;
	Wed, 12 Mar 2025 22:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="PlZGiZC/"
X-Original-To: linux-acpi@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11022110.outbound.protection.outlook.com [40.93.200.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7106719E96D;
	Wed, 12 Mar 2025 22:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.200.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741818580; cv=fail; b=fq6+mXd8mTgHQa70UkKx+sG3JyWW40X/ynFcZIvDdk+sEGVR4LirzcIPha7nCUyTZMex53P4kN5qUgAyUkXvJXWGZcPtVk4qxruOYaXLHFdg7pwb/itiH76kxuKyfiGsyBXWB4kda4fXrrtppBXEQ7FINrDYpNyZ3yg0gEUr0Jw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741818580; c=relaxed/simple;
	bh=AF8yuIK0/xZe4k8hTHaG7vsA5r9sPvuTsDDY4n9JyEQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=apynjOItixH9iLisABtUTyZWCCHuki2/y0KHoB3sgwMeMzMLrN48Fag5t171ERyjlCobYitCwuLLdFAQfvXsz87Es05IqbZ94bT3hdP4api/wozQ0J649oXJMimUJ/YKXzfts9NZgk8GlsBp9Cgow2GMiuwQTp31keG0y9LLjHk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=PlZGiZC/ reason="key not found in DNS"; arc=fail smtp.client-ip=40.93.200.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ps0dB0TQp1NADLdGfRf+hENsfnOzsqArxWOCovKZGR0b3EPLBTkDj/VvVMfmaIihJ7TJpWidBpNo/d2hjBXTOGGn8jK0JzU3fYCcYYqbzm0acNpmiZV9mPRYXJ5lkAvz+UrHgj13ACL+Q0t+VE76jzSKJVo8liWvY54E1bi5TIF/HxNJIqMwWVPMc1FPfLRf/4N1APfzxD/GFiB0YyfDxeQoRfnDYDyGmJ232soc4ZatlHmbsOBNJzSz00zLDs6prz5F95fP2c0Rnz0nQmaMSLcnGP9y/2B/Ps9X10jgqYFJRDO4qbca9ZcqYGS685zlp/iJIBMhhaSr22/HvkAzlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mvmlKGcLIQ2ahQAaCWMNG507dORFWX9L7fO3rm55Pms=;
 b=GerGbh/jf0tQdPwGPo9rwwj8O3dP/AVAktgY6o2JSGHdVwO/Kg5mH/orx4DbkvCFQWHJh24kGXiylkpzaMzVLAY5sHdyHeEUA74UQ9XDcs43IjY6xviWoQK7qrrnEnBtU3Q0E5cDzzSVDT2fGRaX5TsXl4FoKPh9CPwWO23MHhtV/hUt2dO8XAZdunNTRdT26rKDPz0MnYmHfVfbV/R4HiGsSjv0VkpLEOkUdzGiGtV3n99hBqHjj0jZyPxO1EC03AfA4aFEms89pMP+nezMtM07McydNFW4OzeORLpYETWtj/7z/qKRlFRO7LuQ1h2y6f9VGJS71GEYiazK8u98dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mvmlKGcLIQ2ahQAaCWMNG507dORFWX9L7fO3rm55Pms=;
 b=PlZGiZC/fCxwyswD/YkHJr5h7SFNl9TUk/e1uTzIeHcR99yWD/OOUIUyC8xNCHBbsLYoVHnAzZfcfpJZ9W8YjjXSkVQsXuvHIQ8NsXDfiSA/ef9iv8d99YD/TcOF/KS4W7wEcXirPrllzedmxyd8tJBNS0kjcsS8KstZmXiCo6I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from SA0PR01MB6171.prod.exchangelabs.com (2603:10b6:806:e5::16) by
 SJ2PR01MB8402.prod.exchangelabs.com (2603:10b6:a03:536::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.27; Wed, 12 Mar 2025 22:29:35 +0000
Received: from SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d]) by SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d%4]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 22:29:34 +0000
Message-ID: <cd228f18-f77e-48cc-bcae-0c68209496d3@amperemail.onmicrosoft.com>
Date: Wed, 12 Mar 2025 18:29:31 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/13] mailbox: pcc: Refactor and simplify
 check_and_ack()
To: Sudeep Holla <sudeep.holla@arm.com>, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Jassi Brar <jassisinghbrar@gmail.com>, Huisong Li <lihuisong@huawei.com>,
 Adam Young <admiyo@os.amperecomputing.com>,
 Robbie King <robbiek@xsightlabs.com>
References: <20250305-pcc_fixes_updates-v2-0-1b1822bc8746@arm.com>
 <20250305-pcc_fixes_updates-v2-8-1b1822bc8746@arm.com>
Content-Language: en-US
From: Adam Young <admiyo@amperemail.onmicrosoft.com>
In-Reply-To: <20250305-pcc_fixes_updates-v2-8-1b1822bc8746@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0007.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::12) To SA0PR01MB6171.prod.exchangelabs.com
 (2603:10b6:806:e5::16)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR01MB6171:EE_|SJ2PR01MB8402:EE_
X-MS-Office365-Filtering-Correlation-Id: a1745782-24d7-4d3c-ba62-08dd61b55db3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?akE0WFZBeElGdUI2ZHg3SGozSkcrYXJjU2h0Um80NWR3T2lFYUlmbTNRdjVW?=
 =?utf-8?B?OUxyT1c0cUJwSGhNVTd3S3E2ZHBCMXhUTmFRY2RucWN2cnVpL012dllyd2Nu?=
 =?utf-8?B?eFEvVHlGMVNBZVhXN1JqcjViZG1NSjJGRHV0VHVDSEN1MXR0eHlHMmJCakVu?=
 =?utf-8?B?VlArOUdmeHFCaGNSaVlUOXVTTncwa2Z0eVFsVUhmRnFGUHlyNkVSTFZuY1Bw?=
 =?utf-8?B?YnB6VmJHNWp5aVZwd3lsNVA3amZIbzFwMzdreUxyTHI2YUcxdGpzS2lremJX?=
 =?utf-8?B?R0crUUhVeG91cldIWjVZYlYyVGFlNFpuajNuaEFnQkVadHBSWExYWjk2aUFl?=
 =?utf-8?B?cUxER1B6YTBnYnkyNDIvMC8wa2pmTGpFWHBPU251bnJreURIRWVyVUhncVpu?=
 =?utf-8?B?TXRYS0VxRWQrZk9GUUNleURCczcvS0lmN1dhdCtidExCSk5KeHN3Mm5zd2tw?=
 =?utf-8?B?SFY4ZWw5eE5MWS9LVHlSUUdRVWZnVWJ4czhGOFVOZlprL01rOWd4TlcycVhx?=
 =?utf-8?B?eEFnRmJXdUVMdXBqb3dmZE5lekQ5TDlLNm5tS1ducjFBUzVRNENNUlkxMVFn?=
 =?utf-8?B?OWw3RFhsRDVFd2pGQ1l6UjlGM0kzZDduWmpJVHVkeW1XeWM3M2t3eXI4Nlpw?=
 =?utf-8?B?dnZ0bS9BUCtZdXZZY3dFbGI2MXF1RWVZdUNCM2trcnAvb05xb2lOVWRFcjRn?=
 =?utf-8?B?TGxLc01YTEZOMTlhVlJOSk9aa2NWTXQwR1pZYmFZOUdrMlZqb1FZU1JBWG15?=
 =?utf-8?B?T013RnFuRFJUc2F3VEhKNUxZbzgrZ3FTUW5NZmRueVlNNlpzWHdraHl3UFVJ?=
 =?utf-8?B?T283ZHpSOWIxUkRVZzNZQ2krSERyWk5FRlBFNWNEN3hpRXh4ay8vMVZSaFd1?=
 =?utf-8?B?b0hsQVNzVFNUOHlDc0dIYTllSTNYOFMxaHhsVHRBNWVXamxxT0o3RE1LSjRt?=
 =?utf-8?B?WU1zL1NCQUJseFlmcVZacGxvK0NWVUcvVlB1cHh1SWhCT3ROMUNYOWk1TWov?=
 =?utf-8?B?d2E0YmNoVmhSWHZraEdpU0Zyci9kS2dNc2pGR0hWMFYwUklOb1FSZURKb2kx?=
 =?utf-8?B?SW84UXp5WjVkUFdCemJsWUg1Tzg4L0hiQWduVXpQUFJWUmVTOHhWYmZNUlFz?=
 =?utf-8?B?M1lCaVhwS05pUnFTdEtaR0huZnJVeXI2YzAxbUVDQTRBNll1UlpxaGpWRTRV?=
 =?utf-8?B?ZitCNnI5SndJM1R4TUtveFZHMjRZNm8wVWJ1VFpqUGhqTGdSb0FuS1p6QmZQ?=
 =?utf-8?B?QlRKTlJPVDlZbW9wbUo0Rzk1eTY1Z1NrUHdCMFVDSnI1VTJ5MmZhYXFWdk80?=
 =?utf-8?B?MEk4Sk95aVhEQytIN01lVy9Xdis3SXVYN0xVVGhzZndjeEIyaG42ZEhWY3Rh?=
 =?utf-8?B?YjYyODMwN0ozVnZSdjhCc1pGZURZN3JvZG50M0hLUWRkRHVwNFhQV0xocWpi?=
 =?utf-8?B?Wm96UHNKeXU0dUIyZkwzM25OTFZCOUpUeCtVa3QyQnlyMDl5bmtVM1VVZFM0?=
 =?utf-8?B?cGtCRmdkdWNQREJOS1N3b0lkUm9VRUxyNVFUSFNBRE1BcDkvUGNjVjdnZ1gr?=
 =?utf-8?B?RXNPK2VNWDhtQ1p4TWs1YWN3NlFVQnZ3RmM3Y2dUbUxhLy9aQ3dmQUFZVHV2?=
 =?utf-8?B?WUpmQTZ0OW4rTms0cFpxbzdEV3BwNzlPUzhZZTBNd2RmTWpCRlhZVys4WnAz?=
 =?utf-8?B?MlpWemlZV0hyK1Q0OGdKRXZ6TzNaV2hjS1kwVlRGWE9lS2Q4V0RpQ3V3dWdL?=
 =?utf-8?B?Qi9EamVvcDljdS9IK1ZhZWtneW43cW50OWRyeC9zKzhiYUZ2THoxUC9DK0Vm?=
 =?utf-8?B?MlZaT3Z2Zk5aQURXcFVmT3ZnUTJIbTNZNDJzVXMzcExTM3dnNzhTUWFWQU5G?=
 =?utf-8?Q?/2dYBbrusDVPV?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR01MB6171.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bjlWT2JKLzN1NjgwK016ZEI2N2l6UUtmZWF2UHpBYU5kYll6NUtJTkFZZWZz?=
 =?utf-8?B?YjhoWUNEdDdZckZvY1BmdDFSS1VleVlsOTdFSGt3dHIwV1JreUdmVFRRRHM4?=
 =?utf-8?B?cFI2cy9iWkk3Qk5XUDY2M0hWMVRYN0oxRFVqY1F2MTBDa0szRWZPYWJNV1dM?=
 =?utf-8?B?ZUpxdm91bnE4dHQxRTBodVhFTlQ2SGEvOVpIaFA3TE02di85Tm9ndzl4ZVVr?=
 =?utf-8?B?ZHZYUU5GREJDR2Mwc0ZkSis1bmc0L3Q0b3ZaSmUzRGt5SnZwR3Z4THZRd0F0?=
 =?utf-8?B?emxmNHE2SGxqSWVzb1N0WldvK2trM1E1VWdYV3JlS2VOeC9HaU81N3BJOGpW?=
 =?utf-8?B?eDQ0WHE4UFZKVG5JckpVNHMvQzlQakVXS3U3b3RnN3A4Vml6Qk02dDVXcTBB?=
 =?utf-8?B?ZkVVSzAzL3liUXl4UGpFaHF1WlR2VXdiUHNPTU5jTWtkS2hWZ3BXVTFBWHA2?=
 =?utf-8?B?Y25Wd3hDVDZCSzBnaXF4dHkwaTFMRnpCY3lnYXFBV1VEVGtTNzczcVc3SGkx?=
 =?utf-8?B?YjV5NzZvUmZUM2J6L1RPcnV2eEY4M3AraXFmcFp3SUsweUlMZE1qVUoxVklN?=
 =?utf-8?B?Y0dzbmdTUDBHK0FHSnhpZGxHT1ViSmw1U01RUUt1Zm0rY2Jsd0kvUE05UkZt?=
 =?utf-8?B?VzlxTS9rSm42YUtwb2pDYTViWHZPdEt4ajIrR2UrU3dmTnhVR01KV2dhenVk?=
 =?utf-8?B?Y2hySDJpVWxIcU5JUjJVYW9vSDNRb0dXVy9WaXNXYzBTcXdRT0NKWlJ4NFVt?=
 =?utf-8?B?aDRRR2xaZEZPeTZ3VktKemdUV1VVeGI4bEMvN3QwUE9xaXZUUURSdngxODAv?=
 =?utf-8?B?ZUdobVgvVWZMT2UwNzh1S3lPbVprVWJvQ3R2Z09jUXFncFB5SHZCWGdrUWVI?=
 =?utf-8?B?bGRyZnprMmg3SGVDU2VkbG5GZkNSSHJtTVRXM2RzNFJiV1ZNU1JXQkd6MXBR?=
 =?utf-8?B?SzNrakFCYzdYRENEejhjY3dhZXZhNWJTWEVtbGNHUmJqc2FZa3dmMVdZZFNO?=
 =?utf-8?B?Q1VEdUF4SGFiSGpNNWJ6YkVvRkxqS2VTdjFnK0FrT2pkcjZaQ2RpR05sdWpt?=
 =?utf-8?B?OU1vM1VJOG9UZG9qSGEvc0QrZU1ZNVBCdDlrbXpkcGFaL29EQTVsNVhPNUx4?=
 =?utf-8?B?eVpINHpGSklZK3NRdVpVaHNTbmRjdWsxK3J2dTJrdzEzVy80L0QreTBJWTAr?=
 =?utf-8?B?eGJWMUovSG9xOWs4SmZrbGJaRldJR3RvWUxlSlYzNU04V3hBRVRJV3lTVE9w?=
 =?utf-8?B?OTkxY2l3bWxxRUJMT2J1dy8rYkNibGtBUHhLMHFlRUZpaHJNMk5RZEdNaVEr?=
 =?utf-8?B?RXFFNklKU3hRNjZlenZFTjVTY3prK3BIZVYxekQyOEdkRFBER0RFZkNVMGcz?=
 =?utf-8?B?dGlvZDRKVE1YVHlTY0RBNlJTR1RyRlFabFF0Q296RXpFZmh5Wndic1JWb3Jo?=
 =?utf-8?B?cDl2NzJ2VWF4VDZDa3ZOSjRudWt6YnFKRWVoMzhnT2p5YWh4SVk2ZjVUVUVh?=
 =?utf-8?B?cng3MVMwQlB0bjdOL3YyL1JsUms4dFQzeDROclExRHBlOEZJbVN0engzRjIw?=
 =?utf-8?B?eDEza2g1TjBBQjI3RWNNZ2ZpTEk0STNQbWhnSDFCMjV4Zi9tcmx4UjIxdmUw?=
 =?utf-8?B?UFdMckRIcmxycGhRMkV3WS9neDRTaHNnRlpOZTQ5d1UwYktjY2lCQTRtMHor?=
 =?utf-8?B?ZXFmTW5CMWpmSExKaGoxdFhMZkxmSHFYZmZjdFJORjFHZXF2ZS9ZR1djVDNS?=
 =?utf-8?B?WlRST2pZeUhzTU94NVh2OVpoYUdDTTkvbmxhMnMrMGRVM0xnYnBvUnR0SWk3?=
 =?utf-8?B?Y2VlN01tSVFqNUJsenNDNGpkbnUxSlR2NDMrY1N1U2xsV0FldTlXZWJsb3N0?=
 =?utf-8?B?QjZKSXVvSkZWajcvMlp0VVlkWTlUMVQ1T0hQdGRHRGg4QkI1ajBTT3pObTZs?=
 =?utf-8?B?Z0djZWFWeDlES3hYcHgyaERuYU1BbjZIVm9oT3FvNWdhWkNKMGhHL253bzdq?=
 =?utf-8?B?eWVsL2ZkMzVrWklhMkxrcmZkVmN6RVJUN0owdlFDOEZCTERLd0FhOVRIVUxO?=
 =?utf-8?B?WDFyMEhSWTZzZWMwOGpVM3hFVU5TYm5pQnhMa1IyTklLMXNqODE5MUkxd1V3?=
 =?utf-8?B?cXhMeWt4Y2Fvako1WHVHTXYwWW1VbnhDZzFLVTFJQVgrSXNTdHlRbXRzUk01?=
 =?utf-8?B?d0tFNnJHbTRUZ0hzMWxpbHZSb253NEpJdHBhSkFZOGdML3o0RTZya2Q5ZlF4?=
 =?utf-8?Q?yT6Q279+3G5dv3rsmXQUOt71BH9dM3nHx2xhLtmTxI=3D?=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1745782-24d7-4d3c-ba62-08dd61b55db3
X-MS-Exchange-CrossTenant-AuthSource: SA0PR01MB6171.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 22:29:34.6565
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pRD6N9KdIiME2RsF/MS/3i4YjO/RTMIVBrRo+++zb8sh7WCWyUtsUcIPk8JBP8e4wt3HpaMpmlbue3mc/ARGhUaq2ocFj+OHPVT8bjMH5dAr7JgZrmTqskaIjid7lxuD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR01MB8402


On 3/5/25 11:38, Sudeep Holla wrote:
> The existing check_and_ack() function had unnecessary complexity. The
> logic could be streamlined to improve code readability and maintainability.
>
> The command update register needs to be updated in order to acknowledge
> the platform notification through type 4 channel. So it can be done
> unconditionally. Currently it is complicated just to make use of
> pcc_send_data() which also executes the same updation.
>
> In order to simplify, let us just ring the doorbell directly from
> check_and_ack() instead of calling into pcc_send_data(). While at it,
> rename it into pcc_chan_check_and_ack() to maintain consistency in the
> driver.
>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>   drivers/mailbox/pcc.c | 37 +++++++++++++------------------------
>   1 file changed, 13 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
> index b3d133170aac7f8acfd1999564c69b7fe4f6d582..90d6f5e24df7e796f8c29705808eb6df2806c1f2 100644
> --- a/drivers/mailbox/pcc.c
> +++ b/drivers/mailbox/pcc.c
> @@ -117,8 +117,6 @@ struct pcc_chan_info {
>   static struct pcc_chan_info *chan_info;
>   static int pcc_chan_count;
>   
> -static int pcc_send_data(struct mbox_chan *chan, void *data);
> -
>   /*
>    * PCC can be used with perf critical drivers such as CPPC
>    * So it makes sense to locally cache the virtual address and
> @@ -288,33 +286,24 @@ static int pcc_mbox_error_check_and_clear(struct pcc_chan_info *pchan)
>   	return 0;
>   }
>   
> -static void check_and_ack(struct pcc_chan_info *pchan, struct mbox_chan *chan)
> +static void pcc_chan_check_and_ack(struct pcc_chan_info *pchan)
>   {
> -	struct acpi_pcct_ext_pcc_shared_memory pcc_hdr;
> +	struct acpi_pcct_ext_pcc_shared_memory __iomem *pcc_hdr;
>   
>   	if (pchan->type != ACPI_PCCT_TYPE_EXT_PCC_SLAVE_SUBSPACE)
>   		return;
> -	/* If the memory region has not been mapped, we cannot
> -	 * determine if we need to send the message, but we still
> -	 * need to set the cmd_update flag before returning.
> -	 */
> -	if (pchan->chan.shmem == NULL) {
> -		pcc_chan_reg_read_modify_write(&pchan->cmd_update);
> -		return;
> -	}
> -	memcpy_fromio(&pcc_hdr, pchan->chan.shmem,
> -		      sizeof(struct acpi_pcct_ext_pcc_shared_memory));
> +
> +	pcc_chan_reg_read_modify_write(&pchan->cmd_update);
> +
> +	pcc_hdr = pchan->chan.shmem;
> +
>   	/*
> -	 * The PCC slave subspace channel needs to set the command complete bit
> -	 * after processing message. If the PCC_ACK_FLAG is set, it should also
> -	 * ring the doorbell.
> -	 *
> -	 * The PCC master subspace channel clears chan_in_use to free channel.
> +	 * The PCC slave subspace channel needs to set the command
> +	 * complete bit after processing message. If the PCC_ACK_FLAG
> +	 * is set, it should also ring the doorbell.
>   	 */
> -	if (pcc_hdr.flags & PCC_CMD_COMPLETION_NOTIFY)
> -		pcc_send_data(chan, NULL);
> -	else
> -		pcc_chan_reg_read_modify_write(&pchan->cmd_update);
> +	if (ioread32(&pcc_hdr->flags) & PCC_CMD_COMPLETION_NOTIFY)
> +		pcc_chan_reg_read_modify_write(&pchan->db);
>   }
>   
>   /**
> @@ -352,7 +341,7 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
>   	pchan->chan_in_use = false;
>   	mbox_chan_received_data(chan, NULL);
>   
> -	check_and_ack(pchan, chan);
> +	pcc_chan_check_and_ack(pchan);
>   
>   	return IRQ_HANDLED;
>   }
>

tested-by: Adam Young <admiyo@os.amperecomputing.com>



