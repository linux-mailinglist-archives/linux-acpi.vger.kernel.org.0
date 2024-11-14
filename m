Return-Path: <linux-acpi+bounces-9573-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 371519C81FD
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Nov 2024 05:33:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFE611F2323E
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Nov 2024 04:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2627B16088F;
	Thu, 14 Nov 2024 04:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2TgJXc2e"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2045.outbound.protection.outlook.com [40.107.243.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539A48F6C;
	Thu, 14 Nov 2024 04:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731558810; cv=fail; b=ZS6LwgWYGRwzReXXkBfuiiubviHPbDMEsckXdoseTIhsVuQyP26KanDa2EO+8L4nSjtdfZglTmq1QdAYfx1KAifnQBrLU3cOVZv4/4qCeFZlduL8aaAvJUTxgiwMYmy9t7pfvuYWK0fIfPBqBb9/sH5TBBTnWQd+Yl3Sl76Qh4k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731558810; c=relaxed/simple;
	bh=M7tuDWyg0nX3+51t1WIJeOW3epOSJG7UUhZlLPdNjk4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oLRR3hQ4Pw7b/DENRg8nWHJmG5IbivTQMoAhsBDf7NlyMPA0AEDfayen81Mg4K0Ju6daJVKS/A77Fqhs6ZyrYUpZ4OsX69bY1cMlbPz3zcJ8TjtTQuhG8hMepAdqf+gmZ7t3/Kiny8GLnCRhaKeaB9Nyds9k66eSowIT40HDFg8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2TgJXc2e; arc=fail smtp.client-ip=40.107.243.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HpYbUG20WQaQikzcUYXh2beFQmYlLkBH6v6MhAEPIGnMdGUx1jXcVSaL4sCoEmH0V1YQY1DPdWEJCQ3YmVcy+xj0vPGEWA6I3zDrfczS1q1Gba/aa+TYYh9lDNfhPiDnSgtxTToL6uQwcNn+taxzjGjhnTqX355QfBgkYFLyJ24TFcsdCqA/pWIk1Tze+KAyW8TvYQmge5gNy8xyYrSQDD2Su3ECaBNtvEmDVdn7Z3svyFMV5rJ+3+lsVJ1rn4gMT4jetFU2JpaA0pdGhWu3aYibecvDU6NPXuxXP5LF0Uo4BS8T4q4m4bF20U9hDurZAb8tpKYdfO4VQmptc8gYCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TBDef40rWjCr1MPksinwUdDwNEQwMztj2gvmeOVq5kw=;
 b=n7mAhILAXwYG3R+sDa4BV/HNWhSMvUsiwz1pgy+2F/dMx/z/aOKYVHZBPFsHQrL8FCBxm9ffvNQGLODMvdFEt+vuvShzBeisRetC67NJM6dwkzkHtPSYDDc8FqNwp8FaoPcuaEOeGItqI8qACQ7et69AF9k4kluVrdwwmXSCdBkV//zFFTY5Mrz0Y2hWIuhvRw9oLcBwaAwWdosciwFwwaNKXOkfwE+i+HlGsxsUMoVmBZb1TwMMQ2f4EH3Uhh/w9CfeUF0ZkNlTfpIGKqF3KXSFa18bwEqUPqvsF6zdjwYnAf3UWI+1u+XNaZHebO1Dp3d53Y99tVgz6fYGrXgj7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TBDef40rWjCr1MPksinwUdDwNEQwMztj2gvmeOVq5kw=;
 b=2TgJXc2eRGGO20BvWry7wM/VB8reiXkOJwALAHD2+BEpVul7YzBKcrYlXrju7QwtMosjQ8dvMfd6xMZvnsIF7h/Dh+kW0Ckkg+0cWPm7ibpnK+XcAzpxTVyvJg2hrXVs4QqTAWJdOVYPxyfE/W9lImwigvDdIK38S4/p+fP1anM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5176.namprd12.prod.outlook.com (2603:10b6:208:311::19)
 by BL1PR12MB5899.namprd12.prod.outlook.com (2603:10b6:208:397::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Thu, 14 Nov
 2024 04:33:23 +0000
Received: from BL1PR12MB5176.namprd12.prod.outlook.com
 ([fe80::ed5b:dd2f:995a:bcf4]) by BL1PR12MB5176.namprd12.prod.outlook.com
 ([fe80::ed5b:dd2f:995a:bcf4%5]) with mapi id 15.20.8158.017; Thu, 14 Nov 2024
 04:33:23 +0000
Message-ID: <079db1b6-0f95-452e-832b-7d392e130028@amd.com>
Date: Thu, 14 Nov 2024 10:03:13 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/5] i3c: master: Add ACPI support to i3c subsystem
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Jarkko Nikula <jarkko.nikula@linux.intel.com>, Sanket.Goswami@amd.com,
 linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-acpi@vger.kernel.org
References: <20241108073323.523805-1-Shyam-sundar.S-k@amd.com>
 <20241108073323.523805-3-Shyam-sundar.S-k@amd.com>
 <ZzS1-nJMPiCp5jDi@kuha.fi.intel.com>
Content-Language: en-US
From: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
In-Reply-To: <ZzS1-nJMPiCp5jDi@kuha.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0142.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::27) To BL1PR12MB5176.namprd12.prod.outlook.com
 (2603:10b6:208:311::19)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5176:EE_|BL1PR12MB5899:EE_
X-MS-Office365-Filtering-Correlation-Id: dffd48c0-6728-4d5d-fb49-08dd0465795c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dTJ3eDJheHJ5SWdGdy9WU29kbXFnMFM5UTZqcE9Ha1dQY29Qb0pQQ2ZIakR3?=
 =?utf-8?B?MGVFRzI5SEtSUi9YWHAwM2JTT3dpNUpEVzJUeHNMcm9ma1ROQXdDMWlUdkhM?=
 =?utf-8?B?dVpjN3Z3MUh3Y1d6RHhTTXpvT3o4REJGL2dTWGl6am9OaUhNVjF3dXBXRTlr?=
 =?utf-8?B?Y3FaYUhlZGR6WVFEN25XMEVZaURUZWtSWFAxVHUrYytiSjdJcGMzVDlyVTVq?=
 =?utf-8?B?a1NnWHpVdVVTUVdKU0t0b3UyNGIzZ0oxWmM1eWlWZklmQitISVFsR0dhVGlZ?=
 =?utf-8?B?VGJMbk5aM21MV1JWczBPaW5XTy9TTWhqU25jL1F6LzR4cjc0VmlGUVFCQ01N?=
 =?utf-8?B?N2NGVFVZQTFLZHBDR2dqUFB2MWdNM0ZGUjlxQS9aaldiZDRoMHpNL091WXhi?=
 =?utf-8?B?Q0o3UGg1bVgvaDdyeEd3WjZybVVtNGNCdXVwRi90dm1rYjV4ZUlQbkRsRGg3?=
 =?utf-8?B?WGlESzBJU3NjSzZ2eHlxMUllVTR6N29WdkF5NFpvdFcvSEJKaWZUVUdSUlVo?=
 =?utf-8?B?SEpDUG9zYUJBSVFDNXl1bVFWZGtiUE5CQjNtWXlpTENPVTd6aGJCd0s3WDVP?=
 =?utf-8?B?dGF3TC9wbGQ4ejFMSTA0SkVYSUsxbnlaTEphcHJWd2ZzYkZGbDlBUHVVcFk0?=
 =?utf-8?B?QzN5bWk2M1dVM2FVd1JKVHcxTS9LV2xFaTlnMGxWejdEMlloSlZyL2c4d3JJ?=
 =?utf-8?B?U2EwKzB0Zk91ZjlRNVRFS01vRXJjMUJFMTljSkx5anNmR1pmNnh6SHJNQnVh?=
 =?utf-8?B?a3hka0NLQ2NXR0UyV3VQQkk2RDUyOWcrUkNKMGJEWDRQTHowTWxDbFROaysz?=
 =?utf-8?B?YmZmMHZIVWFhQ0gzTXpVWUV3N3d0ZHg3MERiTFJKRTNGVG5TWWltemJNRFZ1?=
 =?utf-8?B?RFFtVHFpaXhneTlxK3hRV1Vhbm5HOERZai91QjN1eFVUOUZEOTZiSkVZc2E4?=
 =?utf-8?B?TVdWMGdBVXY3V0swNXc1YXdCRm01aGFRUHB2SXNLeFZ6SzRLS240UzNzcmRa?=
 =?utf-8?B?ZlB5UnRJMEg3YkphYmFvZjJVK1UxR0pENmkvaEVaVWpIdjNzMk5XL05PSkl3?=
 =?utf-8?B?ajhDVW1BczVKSitWNjVTUEp3SzhEWmdhOEVNeWVGanRRMURCbnc3L2JIZVNz?=
 =?utf-8?B?YTJUTSs0dnY2OWM3dFVxZm8vU0pnSnF4djMrRzhlQVBpTzF3NlkyU2xiZFA5?=
 =?utf-8?B?UnhDM1hRdS9IdDVMQ0F4aG1MY2dXdW1PcnFheHVLQ3pLMkFwUWxSVUhDeVUv?=
 =?utf-8?B?dW16N3BRTHREeVd3RHFoMnp4RDRjMWJZUmF5dThOR2V2RENITzBWWi8zK2Vq?=
 =?utf-8?B?dmRmV2cwRjFDZXMydDZxeHpCSVkwSnNXRFlRQ09sbzNiY0NlbHUwblp6eEhP?=
 =?utf-8?B?c1ZxbDBCQmkya2Z3NnVFWHpadnZnNXl5cExuaXVteVF0Z2hLOU1wZ3VpeDBo?=
 =?utf-8?B?Yzdpcnl5MHk5Ky9zUUpVS0I0VjVxQ253MW45UXQ5UFpnOWVDMm1QWDMxTHRs?=
 =?utf-8?B?WUF3ZlJnZGl6bHZLMTA5WXNjV0hMZkIwVUY3MmROT2pZUyttdTlSSk81L09B?=
 =?utf-8?B?ZXUrdWE1THBnWk9pUWNEcFdGNkt4WGZRYXNqTjlycWtHbmxycURIVWtmbFFl?=
 =?utf-8?B?dFlhazU5WWVUQldNSE9uMmJJSmtwNUo4a29weEFEeE4yZ1lHWThXdEZxekxS?=
 =?utf-8?B?S3hMRDFFbmwyOUpYSitUTkRrY1lhY2VST1c3Mzltcmp6enRLUDl2aTRGRThC?=
 =?utf-8?Q?vD1p0tMlpJ6h4uvLi1PrWVeqvKTDF3PcrMGHCO9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UkpHeXdidnRlZ0NlcndhemZVd1dvREtJQ0NiQUROa3FNWExqSzdCVHRPYmlU?=
 =?utf-8?B?ZHpzK3pxTWNOTnlwZ1lraFJyWm1pR0EvSndSNjR3WjJNSWR0ME1iQVdpWWJ0?=
 =?utf-8?B?d2IyTGRxR1l5dFVKejJndllLVTFNbWVncTBPTEZkRnpkUWZmWUpSdzNaUkpq?=
 =?utf-8?B?RHRQRnNvQVFIWkhkUGFoMURKWVpubjVVUnBnU0k3YWlmZ1UwMHFoYjA3enFG?=
 =?utf-8?B?RnFxZnJCK3ZGa3JxZyszUTcrL0VOQ1BjVFIvSGFyMmhaSkpzMVZlVFd2UHdt?=
 =?utf-8?B?ck5MZFdiMTZZa29BRkg2ek04YmhCTk5Hby9idXo2b2lGMkxPc09tbmQxbmdY?=
 =?utf-8?B?SkZSaUVIeGtwS1A0bUNZenNiUkZvVVFnYVMwZkY2NThaOXVpL2g1MFZzSjVa?=
 =?utf-8?B?aDdSaWtSTXJzNVhiUWZGTWxwY0tpRVlSOXZ0TW9DeHhDZ1pFOHZVS1hacktI?=
 =?utf-8?B?R05Hb3hiUGpkNFJkS0E1YUkzSVg1cG1HNlI3U2xQelpXcDdrY1lLRzc4eTMw?=
 =?utf-8?B?bllZSDB5QzRsOEFwNnhsMXY4eEx2aE5ySW5jUnRVU2ppYU1XWGpnaUdzR3N4?=
 =?utf-8?B?dWUwNXhLVTFRZ29nTGIyWDhyTWgwaGpEQm5nU2lwQm5vVnhHMU9nYWdmZXls?=
 =?utf-8?B?WEFiMXM0elJoU3lDWktTalJwUTlHb2ZuMXV1U1hyMmt5RXc3U05QMUdVOHFt?=
 =?utf-8?B?bU5NNldiVEIzTS8rUThyVGZFV0RGT0M5VEhFOVdvN1NvRVdFS1diZFgybzRO?=
 =?utf-8?B?SjZoV0ZvM3hzUW95b0Z2TElQanAwcnViUHd1S2RSRUhGS1BOYzdZTVM3dm5u?=
 =?utf-8?B?bjd2ckNRM1p2SnVZdzFiQnZzT1RmT09semd5WmpQUjlRY013WkwrSitxcjVw?=
 =?utf-8?B?L2xEc29iYm5XQmJvTjBxVTM0NXlIamJSMW5SbXVVaU80bjkvR25rRnEyU1Ni?=
 =?utf-8?B?d3pHQklhRE1pQmZIZU4vSmVLVkhucjJRTmNLMjB4MVBDZEVPSWJtUWRCK2U3?=
 =?utf-8?B?MXM0YmJjRGpTL3BCMGp3alA3NktVZ2hzQnN2RC8raVNNeUFTWW1XRkRwVloz?=
 =?utf-8?B?T3BGVVBhMDlGV3lvSktLZCtKU1o0TlRYcFpQK0tUQ2Fibnd6bmg3SGNyaU1x?=
 =?utf-8?B?R2pwZWJjRkF1cHdyRi9VRUh1WEtKM1NMa2FFS2JldUFNamtnRXVKVWQyRkti?=
 =?utf-8?B?QzJETU01ODNKeGdUazR0eFVRYXBRRkNFV2g1MEdZVk4xK2xaRjZCVnd3RFBU?=
 =?utf-8?B?VTBiWG5EdHZQdzAvc09paUJvSVcvOXdXMGVOZE9Pd1NaVG1tS3RBOUUzTTFE?=
 =?utf-8?B?cUV0YXlIbnJ3cFlTK2x3aGtCWUR4bTVCL1k3ZDBQeGI4dEN2VFdLR0Y3Y3Ir?=
 =?utf-8?B?R2E5NXAyT202QlpJRHZtNnJNU29TUjJrMGpPZThIbkFPcDVJWTlqdWlYSlBq?=
 =?utf-8?B?YVUzYVMrZTNHTWVYNXN0d1dkZERXU25qaE52UmN0MlJSV2orM1RrcjJFNFRB?=
 =?utf-8?B?WDJkUG1Gb01mWWRUaHpXYzRvamh3VW1MV2EvV1RHbE1lUzhFUzFIcStTMWVp?=
 =?utf-8?B?MlFxT3l6RC85dGFzcG5keEtnakllQlgrR2NTMzk1OEYvNVNzVUVGbmtmMzl3?=
 =?utf-8?B?aUJiMzUrVVRvbG5Heng2aGJQc2NxL3AweEZFSi8yU2RxMEM3ME9WV2tqc3I2?=
 =?utf-8?B?cUtHTjd4bjRkUkxjRG9sUzFtb2VyMnRwaDRNQ2FwdVg2SE8vdEhEUjkyNTJV?=
 =?utf-8?B?Z1lXcFN1eEpmeEJUbDJqTFVjRkJMU3dXK3YxL1RpZ081SjMxbVhMWUZ6QzI1?=
 =?utf-8?B?ODVzbWtjYlk3WUQrTUZPNE5ydVlXUk45UTdCV29CWUFtaDNlZURlcTJxUExl?=
 =?utf-8?B?blZZdWxiSDlQSDl3VlluVHMrWlNSaXZWcVhsTTNMQUxpZXpBK0FubUFaakF4?=
 =?utf-8?B?eHh0cDZkbkZqNUdGaVJuR2oxRkNZSHpvbDRUc1EyVjNmWUUxSUhkTHFUaldG?=
 =?utf-8?B?dU1McVpzQ2VGNnNBMjQ3ZlFaK3JXelpZVktONUJCRldwdjRRZzJzWUVqb0xh?=
 =?utf-8?B?enhOSFFqQmozUCtKSGc0eStRSzRIWVVaL05UTjdWQW9CZVlMcDZIY2FKUm1E?=
 =?utf-8?Q?52WDggTisefoP//xtwSc6/9pU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dffd48c0-6728-4d5d-fb49-08dd0465795c
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 04:33:23.4053
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NJ7wfefzKCPQIP9yNJ6ueyb9vr5V5GwYjXXa2kylOTtAkXqQ3xEpuRJAqclH4o3DB24yWiW+wAbIdgwDb5BC9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5899



On 11/13/2024 19:51, Heikki Krogerus wrote:
> Hi,
> 
> On Fri, Nov 08, 2024 at 01:03:20PM +0530, Shyam Sundar S K wrote:
>> As of now, the I3C subsystem only has ARM-specific initialization, and
>> there is no corresponding ACPI plumbing present. To address this, ACPI
>> support needs to be added to both the I3C core and DW driver.
>>
>> Add support to get the ACPI handle from the _HID probed and parse the apci
>> object to retrieve the slave information from BIOS.
>>
>> Based on the acpi object information propogated via BIOS, build the i3c
>> board information so that the same information can be used across the
>> driver to handle the slave requests.
>>
>> Co-developed-by: Sanket Goswami <Sanket.Goswami@amd.com>
>> Signed-off-by: Sanket Goswami <Sanket.Goswami@amd.com>
>> Signed-off-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
>> ---
>> Cc: linux-acpi@vger.kernel.org
>>
>>  drivers/i3c/internals.h            |  3 ++
>>  drivers/i3c/master.c               | 84 ++++++++++++++++++++++++++++++
>>  drivers/i3c/master/dw-i3c-master.c |  7 +++
>>  include/linux/i3c/master.h         |  1 +
>>  4 files changed, 95 insertions(+)
>>
>> diff --git a/drivers/i3c/internals.h b/drivers/i3c/internals.h
>> index 433f6088b7ce..178bc0ebe6b6 100644
>> --- a/drivers/i3c/internals.h
>> +++ b/drivers/i3c/internals.h
>> @@ -10,6 +10,9 @@
>>  
>>  #include <linux/i3c/master.h>
>>  
>> +#define I3C_GET_PID		0x08
>> +#define I3C_GET_ADDR		0x7F
>> +
>>  void i3c_bus_normaluse_lock(struct i3c_bus *bus);
>>  void i3c_bus_normaluse_unlock(struct i3c_bus *bus);
>>  
>> diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
>> index 6f3eb710a75d..0ceef2aa9161 100644
>> --- a/drivers/i3c/master.c
>> +++ b/drivers/i3c/master.c
>> @@ -2251,6 +2251,84 @@ static int of_i3c_master_add_dev(struct i3c_master_controller *master,
>>  	return ret;
>>  }
>>  
>> +#if IS_ENABLED(CONFIG_ACPI)
>> +static int i3c_acpi_configure_master(struct i3c_master_controller *master)
>> +{
>> +	struct acpi_buffer buf = {ACPI_ALLOCATE_BUFFER, NULL};
>> +	enum i3c_addr_slot_status addrstatus;
>> +	struct i3c_dev_boardinfo *boardinfo;
>> +	struct device *dev = &master->dev;
>> +	struct fwnode_handle *fwnode;
>> +	struct acpi_device *adev;
>> +	u32 slv_addr, num_dev;
>> +	acpi_status status;
>> +	u64 val;
>> +
>> +	status = acpi_evaluate_object_typed(master->ahandle, "_DSD", NULL, &buf, ACPI_TYPE_PACKAGE);
>> +	if (ACPI_FAILURE(status)) {
>> +		dev_err(&master->dev, "Error reading _DSD:%s\n", acpi_format_exception(status));
>> +		return -ENODEV;
>> +	}
> 
> Why do you need to do that?
> 
>> +	num_dev = device_get_child_node_count(dev);
>> +	if (!num_dev) {
>> +		dev_err(&master->dev, "Error: no child node present\n");
>> +		return -EINVAL;
>> +	}
> 
> I think Jarkko already pointed out the problem with that. The whole
> check should be dropped.
> 
>> +	device_for_each_child_node(dev, fwnode) {
>> +		adev = to_acpi_device_node(fwnode);
>> +		if (!adev)
>> +			return -ENODEV;
>> +
>> +		status = acpi_evaluate_integer(adev->handle, "_ADR", NULL, &val);
>> +		if (ACPI_FAILURE(status)) {
>> +			dev_err(&master->dev, "Error: eval _ADR failed\n");
>> +			return -EINVAL;
>> +		}
> 
> val = acpi_device_adr(adev);
> 
>> +		slv_addr = val & I3C_GET_ADDR;
>> +
>> +		boardinfo = devm_kzalloc(dev, sizeof(*boardinfo), GFP_KERNEL);
>> +		if (!boardinfo)
>> +			return -ENOMEM;
>> +
>> +		if (slv_addr) {
>> +			if (slv_addr > I3C_MAX_ADDR)
>> +				return -EINVAL;
>> +
>> +			addrstatus = i3c_bus_get_addr_slot_status(&master->bus, slv_addr);
>> +			if (addrstatus != I3C_ADDR_SLOT_FREE)
>> +				return -EINVAL;
>> +		}
>> +
>> +		boardinfo->static_addr = slv_addr;
>> +		if (boardinfo->static_addr > I3C_MAX_ADDR)
>> +			return -EINVAL;
>> +
>> +		addrstatus = i3c_bus_get_addr_slot_status(&master->bus,	boardinfo->static_addr);
>> +		if (addrstatus != I3C_ADDR_SLOT_FREE)
>> +			return -EINVAL;
>> +
>> +		boardinfo->pid = val >> I3C_GET_PID;
>> +		if ((boardinfo->pid & GENMASK_ULL(63, 48)) ||
>> +		    I3C_PID_RND_LOWER_32BITS(boardinfo->pid))
>> +			return -EINVAL;
>> +
>> +		/*
>> +		 * According to the specification, SETDASA is not supported for DIMM slaves
>> +		 * during device discovery. Therefore, BIOS will populate same initial
>> +		 * dynamic address as the static address.
>> +		 */
>> +		boardinfo->init_dyn_addr = boardinfo->static_addr;
>> +		list_add_tail(&boardinfo->node, &master->boardinfo.i3c);
>> +	}
>> +
>> +	return 0;
>> +}
>> +#else
>> +static int i3c_acpi_configure_master(struct i3c_master_controller *master) { return 0; }
>> +#endif
> 
> I think this code should be placed into a separate file.
> 
> If the goal is to add ACPI support for code that is written for DT
> only, then I think the first thing to do before that really should be
> to convert the existing code to use the unified device property
> interface, and move all the DT-only parts to a separate file(s).
> 

Thank you Jarkko and Heikki. Let me work and these remarks and come
back with a new version.

Jarkko, will you be able to pick 1/5 and 5/5 without a separate series
or do you want me to send one?

Thanks,
Shyam
> thanks,
> 

