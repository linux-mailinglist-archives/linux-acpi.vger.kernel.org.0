Return-Path: <linux-acpi+bounces-7900-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B28E961796
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Aug 2024 21:00:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FFDF1C235F1
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Aug 2024 19:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BC2E1D1756;
	Tue, 27 Aug 2024 19:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZdGvWpEC"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2084.outbound.protection.outlook.com [40.107.243.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B751CDA32;
	Tue, 27 Aug 2024 19:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724785254; cv=fail; b=HZAV6VPz2Vp6tchfMuAmiW6K/k5R+TV3cKFKp0nNzsikeCnIA/pRUoJbqTnw4h1V71+UsMnF76+lFjiowXxXKsiuYlNZNnCEfThMbo6ccyMlQk6m4L+WS+Z+LaQyTvsuhRS5mbYV72+iXu2XWnm114KvJEo3C2WyytfDsDeHSLk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724785254; c=relaxed/simple;
	bh=hgw7TOQ+m7Pcw/vELarEf4R/W14BvYutYYAiDfnAqDQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=s2xxv6uSUOoyy7MBeqFgjdsocJtIr5plXHmbV8rcElBIMbz3IRwqB0+KMioTrOf1SFu0GDyZCxn/PRtkoLaDQiDEm5+9qa+2La5OOkezOXmiOd/6k/nrSLnJHBRBJg8K8ItQj7xDFNlj7wn5wX8v6bP7FLoTr4Thg+A0NLBklCs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZdGvWpEC; arc=fail smtp.client-ip=40.107.243.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ui8wdXJMPZcs5m2vt3gYdB7bCFjr0JVahTZARaOlS739eJU8jqNYo0RPD3acHeM85Tew6yO2xdvx7lKvuN/MNbApHBNQGdI7c9grCMYQCrp0QcEODu0UCk3R9wDsk2IncFUN9UzOGJvkukpWRpIojvg0VgWYGBCVmsoeLWEZ+yaTT6hPxNcyhK8b+FxWOynUX4ZkmoZkj1YxNFM007rFdjkYo3TXmNzGKTkMP51+2+BkJwnFRBxPcEl4ERBPsHALUNphpV1Xt/Rwq9ePxLBaOZHwskhbK9lP57Tg94SdfHm0mOFxvkpfJlSfZFxj+r/h96VdFOU91SmW2BoRoNYJsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UdTmk2C5bWlUpFw3aXuvUFskpDCotpLYhvtHhjTqpHE=;
 b=yvEayG2IWDDZfjgp/duPcb2LNorX8txsQKcYvPG8b5AX9R4QEjIk7GnEGKICJr4aWKUxXNJbrlohcPuluFTeIdA3cadINIyni2ZBFvVj3CUeDUxQNELQmxnCzxjAS4gF1GwRfjLWPKLD9BFUVvFERWO3/K2DwCkYGQV5hQ5yBVFfZzlmP8jbUrPgODhCDmb+sz+Ofueb1VkvK1sUr/Ulqf2JBbc0GqlOzB5Hf+x74ZgHY7txQ9tmjRP0/dAH+f5Rrk7l2TEdIDGnt6JltlqpVZ/gduZ6hG1HlWfDE0mcFZ7KbXbbAj88OWT9ddPsan3sjTCxT+C2M98k9DLn0hjbDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UdTmk2C5bWlUpFw3aXuvUFskpDCotpLYhvtHhjTqpHE=;
 b=ZdGvWpECFe+8mz6uB3L7kvG5BrCECPCAGyzkZvRFpXdWIi6+Dngor5yvJBfQ7aPQ35pSBJKyGYHQHK6Dcs7FNbi06y5kuBgMxG4wPDnDdFq7QLc4/Q2Iypdf6eHAZMGwxCv5xzUxVRZrDIDXym+/uT/VTIR4YbqEFlPTvBkXWMg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SA1PR12MB8887.namprd12.prod.outlook.com (2603:10b6:806:386::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Tue, 27 Aug
 2024 19:00:49 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.7875.016; Tue, 27 Aug 2024
 19:00:49 +0000
Message-ID: <9782c8b9-d632-4f51-92bc-27a2b0346ede@amd.com>
Date: Tue, 27 Aug 2024 14:00:46 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/8] x86/amd: Detect preferred cores in
 amd_get_boost_ratio_numerator()
To: "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
 Mario Limonciello <superm1@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>, Perry Yuan <perry.yuan@amd.com>,
 "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
 <linux-kernel@vger.kernel.org>, "open list:ACPI"
 <linux-acpi@vger.kernel.org>,
 "open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>
References: <20240826211358.2694603-1-superm1@kernel.org>
 <20240826211358.2694603-6-superm1@kernel.org>
 <Zs30P9EThSvLLZg5@BLRRASHENOY1.amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <Zs30P9EThSvLLZg5@BLRRASHENOY1.amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0208.namprd04.prod.outlook.com
 (2603:10b6:806:126::33) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SA1PR12MB8887:EE_
X-MS-Office365-Filtering-Correlation-Id: 2496b163-ca41-4b9a-f0b2-08dcc6ca9084
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Rno4NGY3UXIvMGk3eG15WnRXTHhUREhnOVNPYkY5L1RjelVIQXRadE55NE5l?=
 =?utf-8?B?a2VodGd3ck42UEdVR053QmhoaG5LdkRhY3ZXdUFpSWxxdUI2RzMyRDE3MVJl?=
 =?utf-8?B?d3BPdGJ1RDk5MUpHNjZEVVgrcWVpaGZNaFhJVERtZksxQU5EdTdmVUVjVGp4?=
 =?utf-8?B?djRNbFVDT1daM1F1V3VzVkN6b1hIYVZZNEJxM2xhVE5FK05nM0ZsREpNK09N?=
 =?utf-8?B?QWN2QVVFQVVFU2thTTEzWEVQVzNEbmFyQXpuT0tnZlNzZmJsMFNOWHFPK0ow?=
 =?utf-8?B?QTR3RlVzMnBmRTQ5YzR4T1Z1cVRTaHBZT2VadXluaTZZeUV0OGwzSWhMdjQ0?=
 =?utf-8?B?VTJaRUpYRGE1eldRbUM3M08zdjVLUURoU3VKaGlVK21WVjhZci8yMy9nRkNZ?=
 =?utf-8?B?ZmtlV3lkcEtsS2hENmZpM3lEbW5CTWVPanlxZzdOSVpvR2lnY2xrcHA3VHFu?=
 =?utf-8?B?dUFmTEd6d0lheitGeUoyTzJKMitBTDlnelZEa1Y0aTNuMDdVQzZjZU52OEFI?=
 =?utf-8?B?OHJEcitOdDVlNzJRbW1LUXI5ajdMR1JDOG1xVEllNlhJR2o2cW1ReUtpZTVX?=
 =?utf-8?B?ZFRSZ3haeVgrYWovQ0VMZmd6dXFrYW5XTVVDTlk1UjNqbmFHd05BSDRKOVNK?=
 =?utf-8?B?WWpPMndDOXVUeEFHSFZna3AyOWM1a1FNTnhBSFpVTUVaMm9nN3M1TXFNbi9n?=
 =?utf-8?B?d1FSYXZ3YkFsRldiaVlLOGNLbVl4QnZuYk1QMFgrRzI1ZWJCK2JiUVpTMTE1?=
 =?utf-8?B?NWd5bkhqcDhhR0tXSEJ2dWFzaitQalFCNEJiL1daYkFRT0ZmYnNqcWJ3UDFp?=
 =?utf-8?B?RStwTWtZQVpFd2VDY2N4bjd0bFNMbTFZV2pvdFlFNitWalQzZDd1Ry90N0tN?=
 =?utf-8?B?Wkd3L2FEcWd1WGp3SlRPOG5WbHZETG9lZEUrekRvbnpmR0RZd3BDUHlaTyty?=
 =?utf-8?B?WXB1dzRqeDlGUE54NjZOdlczLy9lejVKWUNNN0c5b1Ryekd2eEdCc2JBYVRR?=
 =?utf-8?B?QS9BeENZY0RiZExVV1N4a2loeUpCN0RDb0wwR1pOV1k5UEJUWlFSbit2RzBZ?=
 =?utf-8?B?RHhWWXoxWlBwVVNaOHBPVkpVdHFFK0h6R0dXQittU3ZaRmo1eXJadWkveE95?=
 =?utf-8?B?RUpPTHdwanpTbHgwZ29XMldVRTUweG1heUl2VmdDWEpDRHN0aElDcGtjVEtm?=
 =?utf-8?B?TjI1QmN2cFMrZ3IydE5GbnFkVVNHRTg0Q2ZkbS9vZ3RtV09kRWh5bTZTcG5v?=
 =?utf-8?B?NzlrcXB1YWZJUXJvN3AycUV2U1JjTnlNams2MXNuNUVHbE91czBmbEY4M3JC?=
 =?utf-8?B?cGVVZExWTW04NDcxWEVtV0JCVUpWdXlXYXVoWXpTdFdqYW1taUo0TlpXdU5E?=
 =?utf-8?B?dUl2RzBEWFpXZnNETnAzenk3dWFVOEh1SUxZQkRvYUwwSHFWZjZlZGM5cjFR?=
 =?utf-8?B?MUJxZEx0bGxLVGoxdjh4SkZyMTFHaXVQS1lGUTJCVXAxVTQ4RXg4M1dDME1T?=
 =?utf-8?B?WEZHNDV5OEF3LzhxTk82aWVtNXcxK3pMZEk5NGU4cVhtMWdLb1ZSRFVmdlVw?=
 =?utf-8?B?QzU5ZXV4N2VsZCtRenVsQlR2eWJpTXRYbTExTDdHMW5LK0VZbm5mYzFyWHht?=
 =?utf-8?B?ZkwxdFplb0w4clBjRloyK0c0UUI5VWNlL1NGMmNsblFIcFVBc1NNQzVKQ3Vp?=
 =?utf-8?B?VUx0VDQxVDdSM0o0K1BoRkF4TlQwY2g0cmJ2aUNKYzNYNFhiT2lTTDN2dTl3?=
 =?utf-8?B?aFdRaXFScUVzQkpNNFdUMnZpbEpLV2pDUXR6OUcwWklheHBXUmo5VjVkV1JF?=
 =?utf-8?B?b1BGdlB4TnZTRVhod282Zz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RGhvSG5ST3Y1aUM1UXVMMjU5Q0NFUU16NkFEMU9mTHBRVTNkYmc0M09icXNY?=
 =?utf-8?B?WlNZL2MzWk44dEp2ZGJwREhndlFZd0hoWURoUUI2L3NjdEJvOTMzRWZVRVpk?=
 =?utf-8?B?a3dwS0hsSjc3R3lYRmY5MlNvQ29oazlSN05LdytiUDFRZSttS0VIRm54YXE5?=
 =?utf-8?B?Q1lGajl5SVNRb2NPazVEcnM1THV6cFhVNUpLRUQ0Wm90MkpqNzFIU0FaSUhK?=
 =?utf-8?B?NlY3SWNBRERVM05xVE41bjV1MzhETDV5VEZrTDNSNDJZWW5PN09UWjRoUGtY?=
 =?utf-8?B?UVBaelh1clYvWlFWbGV4eXBqYm5RcEFlWmtuQ29STmhEVjJMNFFWdG5FTkRr?=
 =?utf-8?B?bDRpWUNPYmZpUnhHdFgvUDBEbVZjMW5HRkx4UVJvNUgvQnFWVG1rR3lkWXVY?=
 =?utf-8?B?WWZRVkxRbTkzVnN4ZTNMWXg1dUROYlpxb3VPZWc0eW1pZnptLzVyRTh3dzIz?=
 =?utf-8?B?MGZFY0lUVjNIWkliMWRmMkZraTV0dGdHbjF2c3k4bHREM1REdmNhaVUwZnlu?=
 =?utf-8?B?cXcrWWNxcEZiM2ZxWi94Wjg4cmZ5MWUrYU1qL3Q3bEhFN1pQcWd6Z1JUT0hu?=
 =?utf-8?B?bE5jZnNDYnVVUnVzZVlhZzZ3V1pCbzR0RHViQ05EK3d0dTdOV3h2Qm9uN3RS?=
 =?utf-8?B?ZlYzMjdCMmZYTnJ1eXZrcHNqdEFoNytBUFRkdXUzZ2Fkak1WVzkvc2sra3FB?=
 =?utf-8?B?M25wc0QyNVVRdlg5VkFoRXFtdk10ZXJXb092NXdKdUpUdzhBNThsMWNuNmt2?=
 =?utf-8?B?MDdyVzhGbE5kaWorYmRwM0I5K2c3YVJkbE9GQTdNRXM4dm9lNEpoZE5Hd1NN?=
 =?utf-8?B?b3U5UnEzcTE4ZjFIY2s3Q0xKZmhrT0RMaUVNbWxvUTIxYWlUa0VZcXBtMy9u?=
 =?utf-8?B?dzh6QytIdVMycjNwNXRHTkJFQzFnZ0xyQUl3cThOOEkrUXo0aG9jSk4yTVRz?=
 =?utf-8?B?Vm9lV0VMbUtUT1M3R0xVWUpsY2VqWEtRRjRaUUVURDRpWm9vaFpNWVBIM0Vi?=
 =?utf-8?B?VUt4c1lSUFZmWEFTOTJUWXlCdG95dGY3bTd0bXUxS1VnTEYwRFl3aEZuUUtP?=
 =?utf-8?B?MFd0WW0xQTJ5WHBtQWxKMlV2Z0Q2RXd2aG1wRDVOR0xIWGtIZXRNbUs5b05L?=
 =?utf-8?B?R1ZJREhSd1hCaTBRUldmNnRxRC9tWEtrcTkwc0J1bjdaRyt6UUtaRVBWOWNq?=
 =?utf-8?B?RjNZV2VWVHZ0Y1pleTJsOUM2dmQ0Ums2dnZUSjF5TzhIK1BjdU44R3dFT3I0?=
 =?utf-8?B?QWZmRFp6VVpqMkJKZis4WGxHamozeEdVYk5xM203ZEJTU0t2OGlLT2NvZnpZ?=
 =?utf-8?B?R2RmbVRjQVpILy9MSi85Nzd1R3RCUUNZanF6akRqRWVkeDFlckV2RXR6bENt?=
 =?utf-8?B?dEFNdGQ1UmpkWW95YXRWWVFmT2RqcnNZbnAyZ2xsU0RESHJYVzJaYTM2R2Zz?=
 =?utf-8?B?cHpyam9yemtsM3pCU21RNUY1WTRkSGZJbjJvZ2k4aS8xU0xreXpmTGFXMk1N?=
 =?utf-8?B?MlE1Q1YvT2tBb0hnMUFuRmRLNVpmZ2wrNk1lb2FnY3lnaXJkbkppUE5nYVpr?=
 =?utf-8?B?OVh2ZVZZODhwcHpmL0lncExXenV4NDBQeGJ3SUZYTjBrSlNQZUtYOFZjeUNy?=
 =?utf-8?B?ZmdLVlU4b2VTQkhVbUVRS0hmenQvWC9SdGw1L21BZ0pCMllsczFjakRDZnhl?=
 =?utf-8?B?REI1MTl0WkdycVRrYW0rSHlsTXphbU5GRTZiYk82WVROeU9nckU0MGt4L0pI?=
 =?utf-8?B?eHh4MWJBd3Z1dlB1V25Ob2lHb1UzOUkvY2FsUENvaFZDR3l6YUR6ZXRSUUZm?=
 =?utf-8?B?SXB3MUo3NWhMUzZqamlCbi9SYXVlUHQ2Z21OTXNmMXlDSmFrQW9NcjkzVWlZ?=
 =?utf-8?B?eWRxSXd6eWhwOUxUTE9hUk1Hc3RCMVVqc2wrVkNPUDBFRUNNTTBVWjdIM3Er?=
 =?utf-8?B?OGg4WS9wOWJ1OXF0NVFwK1Z1SlFxZnRrbGVJaStyVFNqZThuM0lGVXFCY2or?=
 =?utf-8?B?V0xJNCtnSm4xZTI0RnFubUM0MVJPV2NDKzQxNmFIb1lZTXU0V2NIOERtWTlP?=
 =?utf-8?B?VDA2M1VKbklvZlhkZUFneFRDZnVkSGRDZktHNmExcVJXZ2ZzeHRjcU9TM3Vw?=
 =?utf-8?Q?CXr+WQuI+GRBHOUhFSicaA5J1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2496b163-ca41-4b9a-f0b2-08dcc6ca9084
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 19:00:49.1524
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: naCdaSsp77gZEoC3SaMtMSSVWKgtWB38p3fvkSdYpptuoAtcwPh7z4tOiLvM6wpV2RiUXjbdrEWyxu0rpqOHHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8887

On 8/27/2024 10:43, Gautham R. Shenoy wrote:
> 
> On Mon, Aug 26, 2024 at 04:13:55PM -0500, Mario Limonciello wrote:
>> From: Mario Limonciello <mario.limonciello@amd.com>
>>
>> AMD systems that support preferred cores will use "166" as their
>> numerator for max frequency calculations instead of "255".
>>
>> Add a function for detecting preferred cores by looking at the
>> highest perf value on all cores.
>>
>> If preferred cores are enabled return 166 and if disabled the
>> value in the highest perf register. As the function will be called
>> multiple times, cache the values for the boost numerator and if
>> preferred cores will be enabled in global variables.
>>
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
> 
> [..snip..]
> 
>>   /**
>>    * amd_get_boost_ratio_numerator: Get the numerator to use for boost ratio calculation
>>    * @cpu: CPU to get numerator for.
>> @@ -162,20 +232,19 @@ EXPORT_SYMBOL_GPL(amd_get_highest_perf);
>>    */
>>   int amd_get_boost_ratio_numerator(unsigned int cpu, u64 *numerator)
>>   {
>> -	struct cpuinfo_x86 *c = &boot_cpu_data;
>> +	bool prefcore;
>> +	int ret;
>>   
>> -	if (c->x86 == 0x17 && ((c->x86_model >= 0x30 && c->x86_model < 0x40) ||
>> -			       (c->x86_model >= 0x70 && c->x86_model < 0x80))) {
>> -		*numerator = 166;
>> -		return 0;
>> -	}
>> +	ret = amd_detect_prefcore(&prefcore);
>> +	if (ret)
>> +		return ret;
>>   
>> -	if (c->x86 == 0x19 && ((c->x86_model >= 0x20 && c->x86_model < 0x30) ||
>> -			       (c->x86_model >= 0x40 && c->x86_model < 0x70))) {
>> -		*numerator = 166;
>> +	/* without preferred cores, return the highest perf register value */
>> +	if (!prefcore) {
>> +		*numerator = boost_numerator;
>>   		return 0;
>>   	}
>> -	*numerator = 255;
>> +	*numerator = CPPC_HIGHEST_PERF_PREFCORE;
> 
> 
> Interesting. So even when the user boots a system that supports
> preferred-cores with "amd_preferred=disable",
> amd_get_boost_ratio_numerator() will return CPPC_HIGHEST_PERF_PREFCORE
> as the call prefcore == true here.
> 
> I suppose that is as intended, since even though the user may not want
> to use the preferred core logic for task-scheduling/load-balancing,
> the numerator for the boost-ratio is purely dependent on the h/w
> capability.
> 
> Is this understanding correct? If so, can this be included as a
> comment in the code ?
> 

Yup, you got it all right.  I'll fold some of this into the function 
comment for v2.

> The rest of the patch looks good to me.
> 
> Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
> 
> --
> Thanks and Regards
> gautham.
> 
> 
> 
>>   
>>   	return 0;
>>   }
>> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
>> index f470b5700db58..ec32c830abc1d 100644
>> --- a/drivers/cpufreq/amd-pstate.c
>> +++ b/drivers/cpufreq/amd-pstate.c
>> @@ -807,32 +807,18 @@ static DECLARE_WORK(sched_prefcore_work, amd_pstste_sched_prefcore_workfn);
>>   
>>   static void amd_pstate_init_prefcore(struct amd_cpudata *cpudata)
>>   {
>> -	int ret, prio;
>> -	u32 highest_perf;
>> -
>> -	ret = amd_get_highest_perf(cpudata->cpu, &highest_perf);
>> -	if (ret)
>> +	/* user disabled or not detected */
>> +	if (!amd_pstate_prefcore)
>>   		return;
>>   
>>   	cpudata->hw_prefcore = true;
>> -	/* check if CPPC preferred core feature is enabled*/
>> -	if (highest_perf < CPPC_MAX_PERF)
>> -		prio = (int)highest_perf;
>> -	else {
>> -		pr_debug("AMD CPPC preferred core is unsupported!\n");
>> -		cpudata->hw_prefcore = false;
>> -		return;
>> -	}
>> -
>> -	if (!amd_pstate_prefcore)
>> -		return;
>>   
>>   	/*
>>   	 * The priorities can be set regardless of whether or not
>>   	 * sched_set_itmt_support(true) has been called and it is valid to
>>   	 * update them at any time after it has been called.
>>   	 */
>> -	sched_set_itmt_core_prio(prio, cpudata->cpu);
>> +	sched_set_itmt_core_prio((int)READ_ONCE(cpudata->highest_perf), cpudata->cpu);
>>   
>>   	schedule_work(&sched_prefcore_work);
>>   }
>> @@ -998,12 +984,12 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
>>   
>>   	cpudata->cpu = policy->cpu;
>>   
>> -	amd_pstate_init_prefcore(cpudata);
>> -
>>   	ret = amd_pstate_init_perf(cpudata);
>>   	if (ret)
>>   		goto free_cpudata1;
>>   
>> +	amd_pstate_init_prefcore(cpudata);
>> +
>>   	ret = amd_pstate_init_freq(cpudata);
>>   	if (ret)
>>   		goto free_cpudata1;
>> @@ -1453,12 +1439,12 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
>>   	cpudata->cpu = policy->cpu;
>>   	cpudata->epp_policy = 0;
>>   
>> -	amd_pstate_init_prefcore(cpudata);
>> -
>>   	ret = amd_pstate_init_perf(cpudata);
>>   	if (ret)
>>   		goto free_cpudata1;
>>   
>> +	amd_pstate_init_prefcore(cpudata);
>> +
>>   	ret = amd_pstate_init_freq(cpudata);
>>   	if (ret)
>>   		goto free_cpudata1;
>> @@ -1903,6 +1889,12 @@ static int __init amd_pstate_init(void)
>>   		static_call_update(amd_pstate_update_perf, cppc_update_perf);
>>   	}
>>   
>> +	if (amd_pstate_prefcore) {
>> +		ret = amd_detect_prefcore(&amd_pstate_prefcore);
>> +		if (ret)
>> +			return ret;
>> +	}
>> +
>>   	/* enable amd pstate feature */
>>   	ret = amd_pstate_enable(true);
>>   	if (ret) {
>> diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
>> index 2246ce0630362..1d79320a23490 100644
>> --- a/include/acpi/cppc_acpi.h
>> +++ b/include/acpi/cppc_acpi.h
>> @@ -137,10 +137,12 @@ struct cppc_cpudata {
>>   };
>>   
>>   #ifdef CONFIG_CPU_SUP_AMD
>> +extern int amd_detect_prefcore(bool *detected);
>>   extern int amd_get_highest_perf(unsigned int cpu, u32 *highest_perf);
>>   extern int amd_get_boost_ratio_numerator(unsigned int cpu, u64 *numerator);
>>   #else /* !CONFIG_CPU_SUP_AMD */
>>   static inline int amd_get_highest_perf(unsigned int cpu, u32 *highest_perf) { return -ENODEV; }
>> +static inline int amd_detect_prefcore(bool *detected) { return -ENODEV; }
>>   static inline int amd_get_boost_ratio_numerator(unsigned int cpu, u64 *numerator) { return -ENODEV; }
>>   #endif /* !CONFIG_CPU_SUP_AMD */
>>   
>> -- 
>> 2.43.0
>>


