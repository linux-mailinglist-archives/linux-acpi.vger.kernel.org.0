Return-Path: <linux-acpi+bounces-12196-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE61A5F936
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Mar 2025 16:07:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CB0A16C4BF
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Mar 2025 15:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BFD7267F77;
	Thu, 13 Mar 2025 15:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xsightlabs.com header.i=@xsightlabs.com header.b="VI14tNdv";
	dkim=pass (1024-bit key) header.d=xsightlabs.com header.i=@xsightlabs.com header.b="VI14tNdv"
X-Original-To: linux-acpi@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2112.outbound.protection.outlook.com [40.107.22.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6C4265610;
	Thu, 13 Mar 2025 15:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.112
ARC-Seal:i=4; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741878468; cv=fail; b=TsIq0cMw7PWOU/e9Ap+6Id2vIRCEWu50OAedkfqjmt/tg0ocKiBB1zFV4ZkI9PSuQmsjR7oWCoHs7WvAylcfyGjomt4fBrZl7j6EVWsqBDwAsDfvUtDNAGgmslzPKGvjP1Av2qmQaWj5rjGjBH18HSOQhLXWrlMK4XpVEkg8eQ4=
ARC-Message-Signature:i=4; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741878468; c=relaxed/simple;
	bh=qNcysEJWQOthf21BVpi/3JIx+r9NVvtcjARkKgQ7PeY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NH0reIWPp6uU1j1PY8zdnCsURL//2EVyLfOhtMdaApZzqtRFt/uqrH1zIYXr9IgAxpomyzUk8MAFTQd+U/lxIePYOSyloIkMwdGYZ9Q5VIlH2giGddmxVn/jyyN/aV58E0v67mqJ/D1fbLFJ9FSjlmyXX/Iq1ko/Jfh3bn0Cw6U=
ARC-Authentication-Results:i=4; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xsightlabs.com; spf=pass smtp.mailfrom=xsightlabs.com; dkim=pass (1024-bit key) header.d=xsightlabs.com header.i=@xsightlabs.com header.b=VI14tNdv; dkim=pass (1024-bit key) header.d=xsightlabs.com header.i=@xsightlabs.com header.b=VI14tNdv; arc=fail smtp.client-ip=40.107.22.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xsightlabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xsightlabs.com
ARC-Seal: i=3; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=NkGfeZrT6+fOmAX6z0/75MsHhHsbP3ifEVZ8JMaPBEJVhxra8zp8sWRXpuBo/L8T7MtYJLhCvcWBAZOs+kTah00utJxc9Cme2CONElxVP9jrdRz2j2bvRcBJcHqwbExRlM9/2itSQA7ul36P7V91/aPMIgxver/mGQLo4FHHYVCxVVYMV2l93qDug6B4HQ9hmNdCWv1n7ZKLhvgy64ab/sF/OijOGmNtN+xdYfj9mSIYRbSpLR6zXL6BF6bgP5R/GeRJEXxKQyY6Z5hjzMsJ0P0fAdgfGqu0AAqCHAAOwFXyypifhhaExsm13Yzh50MwAfhqlukGoNcVpc62l+IyQw==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pHDm2uzZGkMT3OjzQeCMP8HafMvKELiP5ESgWhBlQDQ=;
 b=LhmdVy6YzdzUIWV/qX9ah7mtyeF9khTYivyQYDkzfzvDXik9gz1Q3Wu793PDpWQ99VkEGVM7D3JL6Nlao2gkq+0dLxWLOFgRB6Tg5Mc+p+ksUo8mY9zBP1Uf3TUjF7knOpjfvAm4TSjTZLYuJEo04PFuhaeYnBcXViYh3wajKSls+gelNYxLbZ2G4qrAeyl4iytRin3By7N10/Tc3oXfxzvn3p0vyojNL0IDz/SaTiGmL4WDr4S19l+RfKIyt2rhP8FjPRZuVMLHVSGUC+hc7IpBTXiLpVFmynuJDej88FM5cZHPUStC7+NN5XJbVnK0jeT8si+rXVc09sCblb+Taw==
ARC-Authentication-Results: i=3; mx.microsoft.com 1; spf=pass (sender ip is
 52.17.62.50) smtp.rcpttodomain=arm.com smtp.mailfrom=xsightlabs.com;
 dmarc=bestguesspass action=none header.from=xsightlabs.com; dkim=pass
 (signature was verified) header.d=xsightlabs.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=xsightlabs.com] dkim=[1,1,header.d=xsightlabs.com]
 dmarc=[1,1,header.from=xsightlabs.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xsightlabs.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pHDm2uzZGkMT3OjzQeCMP8HafMvKELiP5ESgWhBlQDQ=;
 b=VI14tNdvN2WSbO+m1GCIoE8HuFCCK6UaEeaBBa5g4eKrlwhzA3J5ei3wQa78Cso/h76rJfp3Ct8Oz1F5BsW8f//GgZmt7/T0GFAz/UPtaQs+MJpKFKnscWZ/3bramx+8k/gGOZdnh89e7rYTHV42wmy2+wh5B/wVpQ4TVGUhkiE=
Received: from AM0PR01CA0180.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:aa::49) by PR3P193MB1005.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:102:a9::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.28; Thu, 13 Mar
 2025 15:07:38 +0000
Received: from AMS1EPF0000004C.eurprd04.prod.outlook.com
 (2603:10a6:208:aa:cafe::6f) by AM0PR01CA0180.outlook.office365.com
 (2603:10a6:208:aa::49) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.19 via Frontend Transport; Thu,
 13 Mar 2025 15:07:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 52.17.62.50)
 smtp.mailfrom=xsightlabs.com; dkim=pass (signature was verified)
 header.d=xsightlabs.com;dmarc=bestguesspass action=none
 header.from=xsightlabs.com;
Received-SPF: Pass (protection.outlook.com: domain of xsightlabs.com
 designates 52.17.62.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=52.17.62.50; helo=eu-dlp.cloud-sec-av.com; pr=C
Received: from eu-dlp.cloud-sec-av.com (52.17.62.50) by
 AMS1EPF0000004C.mail.protection.outlook.com (10.167.16.137) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.20
 via Frontend Transport; Thu, 13 Mar 2025 15:07:37 +0000
Received: from emails-941190-6-mt-prod-cp-eu-2.checkpointcloudsec.com (ip-10-20-5-245.eu-west-1.compute.internal [10.20.5.245])
	by mta-outgoing-dlp-141-mt-prod-cp-eu-2.checkpointcloudsec.com (Postfix) with ESMTPS id 1837F805F8;
	Thu, 13 Mar 2025 15:07:37 +0000 (UTC)
ARC-Authentication-Results: i=2; mx.checkpointcloudsec.com; arc=pass;
  dkim=none header.d=none
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=checkpointcloudsec.com; s=arcselector01; t=1741878456; h=from : to :
 subject : date : message-id : content-type : mime-version;
 bh=pHDm2uzZGkMT3OjzQeCMP8HafMvKELiP5ESgWhBlQDQ=;
 b=JCUgaqwsvz5b3Cl4CkUnjKWkxo7/6w3sBXIOozUdMjFh3jrsvaxceYMJnRB1iWj+TCg0m
 QiZ258T1BZHtSLyF5ahbBiOObAxvTbmnQUmDPLHZZNgBEaX/SaPkWMtPl0y1NAYVbqot7P5
 1MNfHlrn+z0NbtQtNdyFXd2RjvBBrDo=
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=checkpointcloudsec.com;
 s=arcselector01; t=1741878456;
 b=eyXuurGRtkL1Jend2Lj2fSwvzWKLNwsu2IYDd0NXOlT8vjVGYbPDiZ+WToPq3Tj16qTb5
 ZxlkczXCUNXSXSAP8ubRkuwdl0TC0jOVBDrrYxzprCKPkxMl0QPxBjU+TnvFSBy9j5y1o/p
 Mk+SMVpwq0ysMPIqOsift6CDuWYBP+s=
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tcsod4wF3lLh9KOQpNM9EyLUPIi48FkVhkaxehrIcQwlovIYfLUmnCxvzHRkFiPvMxuXXPbHzXleAqryBwCPhll/7Kjhgx/o/Yv5vJMWAeaFRLoB010qEqjAJa3GjgPpV/Jhk9ltBY7k9i/svLj8m7B5VZH6AjKMQ6jvZA6Q10mAHcfbYvPIdLsKlltkJ8wnt2FpFsRuAbOzxe/qWyGB8kFjhzAvSky4PwxJsrMXA+sdQtd6ium5NDXozTwbam9/cdRCuf+5JJzPpluv6J+fz25Uydhyb0CABrukcQA6Zv3CepwMJGbbmvRJoIM0q/cP/5QM5rzvUe/J7SU9+zBFGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pHDm2uzZGkMT3OjzQeCMP8HafMvKELiP5ESgWhBlQDQ=;
 b=fwFI56IALVOD+rdYdnLjpTPqYf6b1moE07RoTzTdFfz2nX+dG0mObMqaGPkV8RWq3ZtdlJuBlo1atEpmr3VRBd15mVPOnnWTSpaK+K6zbBpP6gw6qvrBA+Dscq8xJZs5Kya7KcfFrxjPQ2LRG7amW1X3PLga3GFEAu2tr7ys/vF8Rlc0cx8wViUjr1FPMoraqiBDF4cY0/8iMHXPfhrYRLopHpXm2UkWH0SrDAg836l1Gx4fN7jgstqhIuvCD0jgE/ZgS5YuXk+gcMwO+vRqFuv+0ehc6sMNg6Ums3nZY/OSHqrD90pUFNRcD3tGhZye24Oufy7C7NS3GmewheJyYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xsightlabs.com; dmarc=pass action=none
 header.from=xsightlabs.com; dkim=pass header.d=xsightlabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xsightlabs.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pHDm2uzZGkMT3OjzQeCMP8HafMvKELiP5ESgWhBlQDQ=;
 b=VI14tNdvN2WSbO+m1GCIoE8HuFCCK6UaEeaBBa5g4eKrlwhzA3J5ei3wQa78Cso/h76rJfp3Ct8Oz1F5BsW8f//GgZmt7/T0GFAz/UPtaQs+MJpKFKnscWZ/3bramx+8k/gGOZdnh89e7rYTHV42wmy2+wh5B/wVpQ4TVGUhkiE=
Received: from AS8P193MB2335.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:446::5)
 by AM9P193MB1363.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:2fc::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.27; Thu, 13 Mar
 2025 15:07:29 +0000
Received: from AS8P193MB2335.EURP193.PROD.OUTLOOK.COM
 ([fe80::7f2f:5721:1f5:aade]) by AS8P193MB2335.EURP193.PROD.OUTLOOK.COM
 ([fe80::7f2f:5721:1f5:aade%4]) with mapi id 15.20.8534.027; Thu, 13 Mar 2025
 15:07:29 +0000
Message-ID: <132cbd87-cd5e-4e7e-a966-42c6232b88be@xsightlabs.com>
Date: Thu, 13 Mar 2025 11:07:25 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/13] mailbox: pcc: Fix the possible race in updation
 of chan_in_use flag
To: Sudeep Holla <sudeep.holla@arm.com>, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Jassi Brar <jassisinghbrar@gmail.com>, Huisong Li <lihuisong@huawei.com>,
 Adam Young <admiyo@os.amperecomputing.com>
References: <20250305-pcc_fixes_updates-v2-0-1b1822bc8746@arm.com>
 <20250305-pcc_fixes_updates-v2-1-1b1822bc8746@arm.com>
Content-Language: en-US
From: Robbie King <robbiek@xsightlabs.com>
In-Reply-To: <20250305-pcc_fixes_updates-v2-1-1b1822bc8746@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0023.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::12) To AS8P193MB2335.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:446::5)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AS8P193MB2335:EE_|AM9P193MB1363:EE_|AMS1EPF0000004C:EE_|PR3P193MB1005:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d610df9-a0d4-4869-0822-08dd6240caa6
X-CLOUD-SEC-AV-Info: xsightlabs,office365_emails,sent,inline
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?cjdjZVUwVVFOd2hlZ2VDd0dqcEpuYnZrUlZxRHQ4MDZzRUhmWkV0N0ZvbTlZ?=
 =?utf-8?B?REZPRUt1WFF5dnNISTF1S2ErTUxNWFJBRmdTQ3o0ZHNGMTdmcTMxMk42a1Nj?=
 =?utf-8?B?VFFFMnIrc3JTS0txemRvbitEc3hXMFlVdkc4dU9XamFoMU5qdkpDRGcyVmEw?=
 =?utf-8?B?dHp5ODI5NHVTUHNjdFJoYXN5TXl6ajdPWlkwZStFaWI1VGhUa1dqSjBoRWVV?=
 =?utf-8?B?TnFDVGNhMVJ6anc5RWg0SlN1M25lVTdSR3B3T2E0MWd2bkZvdzlra01sdkdY?=
 =?utf-8?B?Mkszd2ZVMiszY3N5QmcxUzFMMW5jZ3RlcEMwTFJranVUOGlUc3ZJUEhUTG85?=
 =?utf-8?B?K3hyRmsxUWRFOHBxRjJJU3hKbThiZjlGU0xmQXhabTgzdE1NQ1psVjUwaldz?=
 =?utf-8?B?bGFVbkRmYU1XbkZPKzBzNmFkZDhMS1ZBSEdEV2ZrYzJGWjVNVFpOVFZZT01l?=
 =?utf-8?B?NFVid3JrY2o0OUt1NTV2cHpRMWNvMHNqVFNEbkNZcmgzbk96UXBuaEF1bDhT?=
 =?utf-8?B?WktrVmg4VHA3NENHOGlVRnI5N09uMU81SDV2VU9QM01WMjVwUkwwaE15NCtP?=
 =?utf-8?B?M1JSSi83TC93VlhNSEx6OTNqbUs5Z2hsMWFsRHVqWm83U1UxRDVmZlFNNUor?=
 =?utf-8?B?RUcxZ25VVWtRQnJzb0h0TzFGalZKV1k5Q3BTQk9ZaEwwcldRajJvWkdaODVR?=
 =?utf-8?B?WW4wNUhHMTI2UGVzS1B4N3EwTGRoc2QvcGMzdVdISUxHeE1iQW5JRmg1VDBr?=
 =?utf-8?B?YnVXZ1ozQk9qWVk0Yll1V3RHc1lJRjgrTXdCeFQ1NWllbGZTUVAvKzFPeDRG?=
 =?utf-8?B?ekhNVkdrZCsyeVZQbUdseVYveU9QWklXelNZaXd2cERiQjJzZVN1NnhaVUdR?=
 =?utf-8?B?UXBBZWMxS1l3ODczZ3J2TktVcSszVG1PMlgrLzNEaTRnbkRjRHRyb0h4NFhP?=
 =?utf-8?B?SkdxbjhLaHJ2cnJpamVuOEtsZ3BzcmZpV3ZGeDlOT2xNNjRWOGVQZGRSeXNh?=
 =?utf-8?B?dk9YdTF4RjBSTGU0di9rYjE1NnptZEFzelBrWHo4VEg0ZDFUaTNPUlBOUU1C?=
 =?utf-8?B?SEFEUHZ4dGt0Y01jWkpydFdzTUlNOXlTS0xwN3RrUDBQaXE4RzVEdk5tcFE2?=
 =?utf-8?B?WTVoMUQrTGZRMmYyOForZElwQmlzV1RFNTZMcWdoM09hZk1JeXNhWTNWWUdW?=
 =?utf-8?B?SHpPeGdiSTJEa3lQS2JmdXlYTWxFbG9DQnNlSlgySDBiSGRHM3pVaEEvVWpY?=
 =?utf-8?B?YmFHR1hINmIwVVJmUFZCVHdHSGo4eUQzQ3ZWdFRTRzBidjZHZ3QrUWVjSGlo?=
 =?utf-8?B?RDdZcXJTQytnbHMwaU81MS9lWWZLM2lqRU1pR1dzNkdwREJ1YzFWWTgveDdX?=
 =?utf-8?B?Q0RIaFRuY2pRMitHWE5JeG0rLzdieW1tY3pNWVIycHg4NnBLVjdQOUFZckdJ?=
 =?utf-8?B?STdlU3FuTEFwOU9IblRPSTJtOTd1ZE02cCtNRnRQWUViMUs2bjZIRlYvd2py?=
 =?utf-8?B?ZEcyYkhsOEdpenFVcGREeWFTODJBRWVDKy9LTXVnbmo0eC9kZ2hRcGc5SlRh?=
 =?utf-8?B?M3VocDI5UkxvV2lLdTJnQkdYNXo5MWhnRlF2akRQQ1V1YkpMYjhpNmtaN1lT?=
 =?utf-8?B?RG9maE9nM08vOHNRUGFpbXBENUhJUm9PNTFDNm55RzEvdzRRejA3UTV5Ync2?=
 =?utf-8?B?QlY0YnQzQjkzUTN6T3Y5dnVLbFBiZnRRbHYrZW9ucnhQWTFWL2I2MHhzME4v?=
 =?utf-8?B?Z3VEclloQ3dzOVBoNVF3TDdiSGhVKzlXUUQyRkdCSXNXMCtuT0czTjVlTjNU?=
 =?utf-8?B?VmFvUUVtWlliM0VlKzZOSXF1VnZwb1NYNWs2amQ2b01lbzNPZ2w5ZHZJRGV2?=
 =?utf-8?Q?+PMOGqVZX7i5H?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P193MB2335.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P193MB1363
X-CLOUD-SEC-AV-INT-Relay: sent<mta-outgoing-dlp-mt-prod-cp-eu-2.checkpointcloudsec.com>
X-CLOUD-SEC-AV-UUID: df162cc8e98b4e0ba28b936de14917c3:xsightlabs,office365_emails,sent,inline:62ed86a2fb091e1d53df26aa891d540a
Authentication-Results-Original: mx.checkpointcloudsec.com; arc=pass;
 dkim=none header.d=none
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS1EPF0000004C.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	28eb3b8c-21c5-4ff3-86bd-08dd6240c5af
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|14060799003|82310400026|1800799024|376014|35042699022;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R2lBN2x6QkFMOTBzSEpjRzUwU3NWQmxRaW0zbE1YODFXUHd0dzdBMUR1cWJI?=
 =?utf-8?B?R2IwakI2a2JHcDhCbVpJOW1MWmtITlIwTFpHWTkvcWtUYU9oUmdZajJHbVlZ?=
 =?utf-8?B?ZFBYV1M4anppWU1mQm1ncUdDdTFmelZEaWMyRVRDTkFqUFVVUTdRZXhJRHpN?=
 =?utf-8?B?RXNaaEV5WkZuSkg2RkdmaE1pbXFxOGNESDFPeHBWVC9tdzNJWlQ4QUd6SVhQ?=
 =?utf-8?B?K0VFNzU2RGgxei9oMjNhUDdLbXdWWTRTTFcyRWwvcElndXpYNTJ0aWRkeVRS?=
 =?utf-8?B?S29mQjkxbmQ2NnVlclZtaGpjdnBqODhDeENBMGFhNDhGMEg1ZjNjc3FHdVhL?=
 =?utf-8?B?ZjZUTWYzVmUxbGc2emV1eTI0di9rc0IzR1MzOGg3MjZoSFBqbi9jWEduTEJE?=
 =?utf-8?B?M2gzSHNlL1JEeXR1RDMrM1VrYmYra2RWcTBham80clMvOWtEN2FndmZLU3dz?=
 =?utf-8?B?UnBEK0RBTU1qYXo1Y0cza3RERm9GMXZlZlZuZWtNZUhNV1lTdTVVRGEvcENk?=
 =?utf-8?B?aVNKeTdhREJtc3o0dmcxUEFHWmlmcXVwM01iR0RYYXhrZkJTRThtNWJIUSs4?=
 =?utf-8?B?OWpHZmx3YWpYNlhLSGEwazMwanNvbGdZcjdQbklGQlFTQUJYNnhKTzRwMGJG?=
 =?utf-8?B?cERzR2dPSlI3dW81SlRmRTFoTWVtcHZmcXduL3YvRzV3WmNzZ09QaFFPcFhz?=
 =?utf-8?B?UUU1eGI2b3dJU21qUnY0WHdlOXJzVU0xTVpVN1Y5RWNzaG41Mkl1SldDMGV1?=
 =?utf-8?B?bWR6TzRHeFMxRVl5UGU3ZTEzS3o5cFFudFRZWHF2MUduMEh4dGpWMzVhRDQ4?=
 =?utf-8?B?dFk4dzZIUVZLdDVuVjVrcTdUalNTdVVQaXM4OEtLTFI4cmpNK1VJVDFhRjZJ?=
 =?utf-8?B?ZGpsQmdUMXdxeEhndFBRS3puVzJCSXhkV1VPcWMrdENEUUJtZlhSajg2YVVC?=
 =?utf-8?B?Qng2SURuQzl1L3hqNHFLU1g0WE9sZmdmL1M0aGRHS09rMmtRVlgycURqUU03?=
 =?utf-8?B?MkFialJHVDBBZUhDN2FWeDU5TWIvbVNIRStFSllmUU9ETU5TdWFQOEN1SjJl?=
 =?utf-8?B?K1RXNkZTdEljOXZPd0x3RHo2bUhocWE0OFl5bmIvWk5jMjRaRThMS2Q5aE9Z?=
 =?utf-8?B?bGdhVXAvd2psem1HL3pNK2thNk1hdy9QT3FGRE5WTGlmUjJCdDI1cHhyNVBh?=
 =?utf-8?B?NnJFUk1rSk4zb3k3MytCcE85RnZubVYrZkZwZGVDS3k1RlZmZSsvWmg2R3J2?=
 =?utf-8?B?bkU3NnBZV2hXNi9pQ2lEUG5tL2xJYVNURnFIMXhBRWZsT29YWEo0aDZDckVz?=
 =?utf-8?B?Qk90ZXE4NGpLalJoNXNRQUZrRXF0NEkxd294UUpCbjFhRGlYMjNraldDdkFS?=
 =?utf-8?B?VnVIeUVlVyt3N3pnbi94MGo5RGxWMXVpTXhBNkp2aHYyMGg4c1JTM2RhQjgr?=
 =?utf-8?B?NkxQSlB2MXU0QThraU9NUFF5Z0VCaU15MkZMakNmSlc2WlZnaEFQY293MVlt?=
 =?utf-8?B?NWE0bjBuOVdUaDFPTm5mNXZ5T29kTUxNdlIvWkEzUVU4L1Fwd1BTSzFNUExq?=
 =?utf-8?B?QnRySlIwWWJvMVlNU3p0ek1vKzR6d1ptcERqWDhHSDczekdxNE5heW9oYk1z?=
 =?utf-8?B?aFhpa3Z3a3VTMkxsODErcjVGVFhxSGFBNVRmdlpGaW9GTTA0K0ZZcUlrQUFJ?=
 =?utf-8?B?bEFsYk1QaGNGV2ptSTRYTGVBZURyMTBKZTFnSEI2NlY4UldKQ29RZHJvUWJH?=
 =?utf-8?B?cFEyczZlNTF2emFjeHBDSng3WVdvdWlyMWw5cEhvNkZNYzIwVjkvdTBBNTZs?=
 =?utf-8?B?dkJwK2J4Uk5uQktVT1lvdVV0OUVFYUNlZ0FFTndIYmNGZU8wSWgrUDNuVllo?=
 =?utf-8?B?Uk95TmZTanZWa3dyT0h5bWRxM3lYeTlJS0JhRlRvUEc2RHhzbk9DY2JaVXk2?=
 =?utf-8?B?U094TzAvRTcvbFRsRmlzenFVaUtlcjd4T1J1enNmQzJaN0JIckNtVE4zZWhj?=
 =?utf-8?B?MlBGUWdSYzd3PT0=?=
X-Forefront-Antispam-Report:
	CIP:52.17.62.50;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu-dlp.cloud-sec-av.com;PTR:eu-dlp.cloud-sec-av.com;CAT:NONE;SFS:(13230040)(36860700013)(14060799003)(82310400026)(1800799024)(376014)(35042699022);DIR:OUT;SFP:1102;
X-OriginatorOrg: xsightlabs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 15:07:37.2848
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d610df9-a0d4-4869-0822-08dd6240caa6
X-MS-Exchange-CrossTenant-Id: 646a3e34-83ea-4273-9177-ab01923abaa9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=646a3e34-83ea-4273-9177-ab01923abaa9;Ip=[52.17.62.50];Helo=[eu-dlp.cloud-sec-av.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF0000004C.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3P193MB1005

On 3/5/2025 11:38 AM, Sudeep Holla wrote:
> From: Huisong Li <lihuisong@huawei.com>
> 
> The function mbox_chan_received_data() calls the Rx callback of the
> mailbox client driver. The callback might set chan_in_use flag from
> pcc_send_data(). This flag's status determines whether the PCC channel
> is in use.
> 
> However, there is a potential race condition where chan_in_use is
> updated incorrectly due to concurrency between the interrupt handler
> (pcc_mbox_irq()) and the command sender(pcc_send_data()).
> 
> The 'chan_in_use' flag of a channel is set to true after sending a
> command. And the flag of the new command may be cleared erroneous by
> the interrupt handler afer mbox_chan_received_data() returns,
> 
> As a result, the interrupt being level triggered can't be cleared in
> pcc_mbox_irq() and it will be disabled after the number of handled times
> exceeds the specified value. The error log is as follows:
> 
>   |  kunpeng_hccs HISI04B2:00: PCC command executed timeout!
>   |  kunpeng_hccs HISI04B2:00: get port link status info failed, ret = -110
>   |  irq 13: nobody cared (try booting with the "irqpoll" option)
>   |  Call trace:
>   |   dump_backtrace+0x0/0x210
>   |   show_stack+0x1c/0x2c
>   |   dump_stack+0xec/0x130
>   |   __report_bad_irq+0x50/0x190
>   |   note_interrupt+0x1e4/0x260
>   |   handle_irq_event+0x144/0x17c
>   |   handle_fasteoi_irq+0xd0/0x240
>   |   __handle_domain_irq+0x80/0xf0
>   |   gic_handle_irq+0x74/0x2d0
>   |   el1_irq+0xbc/0x140
>   |   mnt_clone_write+0x0/0x70
>   |   file_update_time+0xcc/0x160
>   |   fault_dirty_shared_page+0xe8/0x150
>   |   do_shared_fault+0x80/0x1d0
>   |   do_fault+0x118/0x1a4
>   |   handle_pte_fault+0x154/0x230
>   |   __handle_mm_fault+0x1ac/0x390
>   |   handle_mm_fault+0xf0/0x250
>   |   do_page_fault+0x184/0x454
>   |   do_translation_fault+0xac/0xd4
>   |   do_mem_abort+0x44/0xb4
>   |   el0_da+0x40/0x74
>   |   el0_sync_handler+0x60/0xb4
>   |   el0_sync+0x168/0x180
>   |  handlers:
>   |   pcc_mbox_irq
>   |  Disabling IRQ #13
> 
> To solve this issue, pcc_mbox_irq() must clear 'chan_in_use' flag before
> the call to mbox_chan_received_data().
> 
> Signed-off-by: Huisong Li <lihuisong@huawei.com>
> (sudeep.holla: Minor updates to the subject and commit message)
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>

Tested-by: Robbie King <robbiek@xsightlabs.com>


