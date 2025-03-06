Return-Path: <linux-acpi+bounces-11882-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCD43A5418B
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Mar 2025 05:12:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D215E3ADA26
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Mar 2025 04:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C4131993B7;
	Thu,  6 Mar 2025 04:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BhK/o5vf"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2049.outbound.protection.outlook.com [40.107.93.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C162B10E4;
	Thu,  6 Mar 2025 04:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741234325; cv=fail; b=C19ZVK2HaClkcx03SGUdE6UEfLgbE1PxtvAk/wdV+CFfjl+xaTERv3jIAiiY+GHLqHFHewzv1t0yKnvMh9TMMb9D8BcCvV8smfQryWHJeDz9XMwxFmaZnYXyhK5UayTxS0agsPQw2k3o4VgVUyDRK1CuxkzNyGF1qgJnhf0CjTc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741234325; c=relaxed/simple;
	bh=ukGbP6UhkV18hS6xI69PSqXwbtntZNJCiRYmbyGW/CE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rvXBZ8l3axVX9x8MIKAEXC4BY9tqmg1L2BqsWNWjA4Y57rRWU07OkWZ75R6gI4krkC+MbWSaMl00x/A7PBtVdMX4GAMxYAY8tlsdsQNIdXU5TYAP7f2UVZe+7nRyBfBZMBsgGQF3qVIUV/cVc5AK5NQkE8aOKm3RkkU/0QwRZdo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BhK/o5vf; arc=fail smtp.client-ip=40.107.93.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kfen86yuAPrFdrBpruSM5xldAIW1v95x0a6ugxnBEoJ894ccF9IKYlH0x8MYJtKzCPD5ZNpp+26oYAMghQy6dwRQY/MBtFO7IIUcskL2J+lnSyCG16Hcvg74iHZmv8iZOnD5sE96B3LXqeOMUWxR5Dt2btTZk4HTGYtNM+ca70WFrq2Yfp3+vb5p1l7CJdUx2PC9/HA8ZveyBu/CDoS3MwOW7Cunh6mFtU4CoU/SoZB1o0pJeqEj9hXzjyiViZliZ9fUwFeiswCNZ7UuI2s9HHozxHnhpAID2wJpV1Xy+0HVCDBMC0L7c4ppu6UYvYIO+EzYkzcaC0bi2728BS1qqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WjcZ/tdCrnHPSG+x1q6cHk/AumUdhq4Pp5zKAdZQYyo=;
 b=UVfcBZO1MAZkiAEO+fWtadYDT7vvBGM6sA9OOG60LOeYeuTiHFabiZrlfW7jn3eCYCzLOos2osnZJR4by/1rEGFyRGUursHDPnoDgU+1qyUqADutZsyAax6M4C2SEvVxbr8QU7VV0YjZk8TQeX59z4g4UJruf2NIFHnRe2LSzdeXDgBtiB8AV/+QsJxQat6bHps6szsgM0YGDqlwCBACXWr/+QtJePLQgIOs4YigGFRLhrD8GKmu08PLfDlcF64yIf5DHLCXy2jMzoUkGPeTNL+bqwuwE8xtIBavN0r8LnbKp69Sxm8z2IPLEGngF9csffnz+NqLR279Bh/AxJ5pSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WjcZ/tdCrnHPSG+x1q6cHk/AumUdhq4Pp5zKAdZQYyo=;
 b=BhK/o5vfYx0eJo2r2WyC5/ciJiRsaHsZZE3ncJ7zpAXgrThnavi8N0mj+jocOTsBgHqm250cKPVx4HX9v3gyABTti9k7Xk2tE4jxvUVs7qyUZ9vL+8H6RY9K2o9tchNCAFP/MzprbyPKi/aJtRe6T/mJa4hLq7ToJASpdecdIpw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5176.namprd12.prod.outlook.com (2603:10b6:208:311::19)
 by DM4PR12MB5939.namprd12.prod.outlook.com (2603:10b6:8:6a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Thu, 6 Mar
 2025 04:12:01 +0000
Received: from BL1PR12MB5176.namprd12.prod.outlook.com
 ([fe80::ed5b:dd2f:995a:bcf4]) by BL1PR12MB5176.namprd12.prod.outlook.com
 ([fe80::ed5b:dd2f:995a:bcf4%3]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 04:12:01 +0000
Message-ID: <a38a5f75-d131-4d14-b215-2de0c2d65446@amd.com>
Date: Thu, 6 Mar 2025 09:41:52 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86/amd: pmf: Fix missing hidden options for
 Smart PC
To: Mario Limonciello <superm1@kernel.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Hans de Goede
 <hdegoede@redhat.com>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>, "Luke D . Jones" <luke@ljones.dev>,
 Mark Pearson <mpearson-lenovo@squebb.ca>
Cc: "open list:AMD PMF DRIVER" <platform-driver-x86@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:ACPI" <linux-acpi@vger.kernel.org>,
 "Derek J . Clark" <derekjohn.clark@gmail.com>,
 Antheas Kapenekakis <lkml@antheas.dev>, me@kylegospodneti.ch,
 Denis Benato <benato.denis96@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Yijun Shen <Yijun.Shen@dell.com>
References: <20250306034402.50478-1-superm1@kernel.org>
Content-Language: en-US
From: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
In-Reply-To: <20250306034402.50478-1-superm1@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1PR01CA0163.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:68::33) To BL1PR12MB5176.namprd12.prod.outlook.com
 (2603:10b6:208:311::19)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5176:EE_|DM4PR12MB5939:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e027c5d-e48e-4b6a-c4b0-08dd5c650b5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MmN3WmpIcExGZFBhR3NmVHBYL2NLeE1LcGJVMm1RN1lMRkhBSENtbkdoY3Fp?=
 =?utf-8?B?dmtsdUN1eXdBdVNtdHZkWDh3NDREckNmYzVYWlFOWHZ0ejJ3THVtcEkzU0xF?=
 =?utf-8?B?ZThhbzNUY0hEVTM3b2czL3FiMUpRdVU4c1Fwajh4SzlSbVdlWXhWVTdBalBO?=
 =?utf-8?B?ZWNNVVMwTnpEUE05NGdTZTBWYVAxNXZyZDdrT3NDbzZGTjVSeWpzVWVMWWpp?=
 =?utf-8?B?TkNoUHVONVFGTFJWR2tUQ2NBMGZ4YlVwVDN1Qjg5RkFCcHcvN01HMmZmMlZE?=
 =?utf-8?B?MlBhNmwyMWRUR2FkbkdsM09CWlcwR0NycGJodnN1dldjbXdaT3ZxTjRxV0F6?=
 =?utf-8?B?WWlBSFk3cFkvbkFpL2dYSHpUNFNVZWFrS0xVMUlVaElQWkhkSE9lTVhVSjJ3?=
 =?utf-8?B?eU1NeFpNTy8wcWhLTEhkRHQ4UnkvRFA5T1VhZEhmeWVSVnNBSE11QVQ4MEdu?=
 =?utf-8?B?MVZvWFVtVXEwd2s1SWNqcTRpY3F4WHltRjRaeWJmZ3paWlVlYjJBUE9IajlL?=
 =?utf-8?B?M1ZYb2xta1dHQ3JhejJ6UjN4VHFiQmRITy9jM29WV0JWZkt0UnpjNTE3SktF?=
 =?utf-8?B?ajh0SFJ2VXBwdnJwWU0yVHRJS3haWHpETjVjZU9ieHFncHBOMWtJQlFTTXVW?=
 =?utf-8?B?V1JJTllNZnRTOGR3MmJFZlhUUFNTN2NVWVo1MFVSRytKSTVOblExM2RnU3lr?=
 =?utf-8?B?ZHlSa2tObGdWeGVHVXZBMzRvekZrblRVSUJWckxlMXB2OWY2UWIwZWp6WmEv?=
 =?utf-8?B?VEozd1FzTWdPRWE3ajZhSEt1U2JpVGpkWG5tdjBIMCtMVldoek5ZNWpnb3px?=
 =?utf-8?B?bUI2ZUpPNGFVbVY3dDNHb1ZveDlBTmg1Tml0TXByM21KWHlCMjlMVkdPQi9G?=
 =?utf-8?B?aHdYZDBBL2NWVDdjMmNRa2lxb0I0TDMwb2VibWNYRG83YU5rUUpYM0dRZkRN?=
 =?utf-8?B?RHFjanFKNzl0eVBMV2dCVWhKL3NnYTllT2lOMXdhOUpoME8rbTUzNFhudUJr?=
 =?utf-8?B?T1R5SGs5anptT2pwOG5Pc3JDSk55UWxYVWlndjdkTlFkcEdLQXlYRW10TGRT?=
 =?utf-8?B?bE1PZ3RrdWJ1Sk9ZNm5ad21xekdNUTRHaXg0S0pjUXZwLy9ZQkcwczNQNmpM?=
 =?utf-8?B?Z01tazNTejZOUE9CSW9nUVk1MFFiYkRCS2xqTENRb1J5dWlXWHJLQ05PRU9a?=
 =?utf-8?B?RXR5L3F6MEdzUVFVSDI0Ykc2ckphUFBabjZlQ21jNDY5RkNJbkpLTEkyM2Z2?=
 =?utf-8?B?V3M1aUt5YitSZjNDWVRKenJhQWpzK2JudGFGOFQ3SEFVQkJpT1RFeHJjb3BW?=
 =?utf-8?B?Tkl5Tmdmd2VpY3k0MkRKdzM3akRuSHU2bTRVRi9EMGVpek9wTUYwRUwvVklX?=
 =?utf-8?B?SjlVcm10dXBkcnFReUdMaVczbXhaUXJIQTBpeXM2QU1nUGJGcGxESlVBYjFI?=
 =?utf-8?B?amhXS2hnTGE4OGR4VjJtYnlrbTcwU2JSZ0dRd0pzUDJLUko4aGUzL0JsMWF0?=
 =?utf-8?B?YVhuMzd2dzI4cUFKa2RYKzJNR09yaU5oN3N3amI2OWpzbXJCUnhtNHllZzJs?=
 =?utf-8?B?UUZ3eENwVlBLWUVxcVdiaFp2KzR3RHJVNmZNeHV3SGhsZkRHZDk4TjNVRHh5?=
 =?utf-8?B?b01Jak1SYzRyb1ptNWRydHA0dU5nZ0ZCVmFkWDl6MEVWck1GZkZ4Y3V4UFhr?=
 =?utf-8?B?RUJ6SDcyTFNNNVVPbHBieHJ1UnVjS0JyZFIrdWlQOS9wQkJWMXpFK2RxQ1hw?=
 =?utf-8?B?OFVhM2hQaHh5UzZqWWxpcldkc1hKV2RBUmtlNEdlWkZYczFlV3dKOXlVdks3?=
 =?utf-8?B?ZjNIbUxzSy9lSDVPMGYxK01rdXUwd1lGYndmc2MwNnhsRXVyRkdLZkVSL01J?=
 =?utf-8?Q?4riEPjwWQSMsm?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TDJ2OGh5Z09WUUtMNVV4Njk2R2hZMjcvOXh2OGlwNUZFVVpBYVloTC9nT1d3?=
 =?utf-8?B?RGU1eUpWaXAvN0t3aXVnRnNuZXVJSjE2RzFIOW1WeVFsYTdPNEFldndDV3la?=
 =?utf-8?B?cG1DaW9zQlpra0Q0bzFiWitSMWVtWUNvVVFSMkFFRGRqUDNJTjV0TVVhdXBQ?=
 =?utf-8?B?UklUUmN1bHNCNHB2TFZEN1BzT2t4eGFTNW5JZ1dsWHBtZVhuODhyZE54bkt6?=
 =?utf-8?B?RnRlbEY2Q083ZlJFUnNRV3dQZ2c2SHo0RjBEeUszTEJRYmVvV1BxUEdGUHV4?=
 =?utf-8?B?MHl2blhVZ2pYWGxQKzc4b2Nab1JNRjFtYWhyYjFRVnl1NDR5SU80WVdSYWlB?=
 =?utf-8?B?cFJ6KzlQNmZ1SnJaUjVldnNLTmhtcW5xV1NPT2Rsc1NzeitvbHpRV2hWdkFj?=
 =?utf-8?B?bzVzVjM1Nm01b0xwSGFjRXpyZEZ0TGwzbXBndkwxZTY1SXVncnB4Q2VRTXRL?=
 =?utf-8?B?aXdyRFZaYncya1hWYUNyZ2ZPbnR1M3h0T2xmM3k4dS9BZ0cyLzVFUjVFY0cw?=
 =?utf-8?B?YlIrd1J1Q1BTMW5RejBsaWtMWXhBeFdZdmRuWnoxdlJlRlg1SjNDLzBMVFgv?=
 =?utf-8?B?SExUaDJNTFI3eEphN1hqY3JuTWduWEtzcVdRWHU2RW9HK0l5K1d6UVlUQTRv?=
 =?utf-8?B?S0kycHFsSS95M0FpVlRCWnhVdmlqVWtyL1ZEVzAvUHBra05Mcy9wR0Y4aFV3?=
 =?utf-8?B?bTM5UFJqK0pZNGhIZWQ0WFZucURoNzdRN1IySlRxMkNMUjlmMFlucEZacW1v?=
 =?utf-8?B?TVZSUjdQRHZwcEhZZEZOejZoS1pydisrWjJEdmVpWTJobGsxd0VNNUQrSWFh?=
 =?utf-8?B?KzRiRXVnY0ZrR3o5bjBKOEQxK2cwWjM4NGhXTlJMRkZTWFdPcmE0MFVRUmJZ?=
 =?utf-8?B?UGIvQjM0b0R0ZzNUWlNhV3JoZkgyd0t6NzBveXdOekhlaHhYWXp4WXVpM25V?=
 =?utf-8?B?a2ltMXJSVC9qckl0OUhjYzNnNU9ia0g2UE04bTIrNHliRmJSNkkwTHhPUk42?=
 =?utf-8?B?dDRpSTQzUWl4emwzOWE5UDl0TXBCNU0yUkxycVJJd1d3Z3AwNGsweFh3eCtu?=
 =?utf-8?B?ZXJjOUhBN0VQbHNwSEIvRXFDd2M5eFhHYk9PZkt3SlVrbTF6VkhCeU9ia1VY?=
 =?utf-8?B?MEJvaGgyVHZUZitLdXpMdjlmZFlST0hRMW1TRWFiMTMwWmxXemxsc21vdUJU?=
 =?utf-8?B?NDVSdGlma3BNdW5BRkNVSDFkODVJdlFteklVejhlYjFBOE8xVmZ0d3BnbEk4?=
 =?utf-8?B?TWR1dndpWVJqdWlLRzA0WHZ3K3ZDdEp5N2ZYTXQrbmtzVkxncmlkMVRtS25E?=
 =?utf-8?B?aVB4Y0MxMzdRajhzeDhhY3pzUUJBMHJSYVI0ZlR0ZW1nSlE4TGNUTXUwNC8z?=
 =?utf-8?B?RVE1aGJaVnhwYTlVWGtxNE51UVF1cEE0UVE4aFNQTGdTMzg4NUx3RlgzRm1n?=
 =?utf-8?B?WVNZK2xiRytjVHFmeDNucktJUmlQcm5TSHNLbldaZE1hdkMvRjU4NytlbWVF?=
 =?utf-8?B?ZjVCNVA1OExWVWVMdWUzQzZFTVphUlAvOUFTYlFMeDYwMUowL2VFazZJd1kw?=
 =?utf-8?B?bTVIRjdhSGdrbkl6R0tCTkdWcDh0WHFnYS9UOEg0L245ZytCMWxHeU9IeWNz?=
 =?utf-8?B?MFZhY2I4TjhuTEM5T0ZWQTVZSjBaZTBsV3ZrcS9CUE91akdwYnZGTVdoR0ha?=
 =?utf-8?B?T3JMV2l6K2J2ZTg5VFpDYTNrMHpyK2dTL0ZRRkJvKzVCd0hyQWM4T3ZkcGRG?=
 =?utf-8?B?cG1Vb1plNUFFOWg1UllrNUt6a01mU3VZcmViQk0xNWZkUmlnZW91WTAzNFph?=
 =?utf-8?B?SmpDTGE1NGpCMmQrclVJNUpTd21SK1FZZHhXVERjVThxRmx4bDdkZFpqOXIv?=
 =?utf-8?B?NHR6aXJMek12S1RmRFZoVW9PMDZwSjFZYjlXL0dyNGF0VENBbWx4aXdkakNT?=
 =?utf-8?B?Q3Q3NjIrdmFDSTMzT3lIR0h3S3YzMTg2cjMyWUo3cXpJRUZiU2VsdzFFN2Er?=
 =?utf-8?B?ZTZTZDlNZE5ZT0J6NkQwNzdrWW9aWFdka203WGI2MWxVbm5nZTRSUFBtbDRo?=
 =?utf-8?B?Zm1zQXFzWWZEWEovQzBkdUg4VFN6Skt6Zk1aeVc0UDFSYmpBRmc4bzVPbWpl?=
 =?utf-8?Q?8tIm4FC1KBnnESaL46U3C/qG3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e027c5d-e48e-4b6a-c4b0-08dd5c650b5f
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 04:12:01.2648
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3GeWf2qE/Y0pNxAGH7FRRwriB6T/QWH2WP/VJaeldv7SvrKfKShQ5fR0ZqqjLdOzwf1MEV5mkMxHIv/P6ARwLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5939



On 3/6/2025 09:14, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> amd_pmf_get_slider_info() checks the current profile to report correct
> value to the TA inputs.  If hidden options are in use then the wrong
> values will be reported to TA.
> 
> Add the two compat options PLATFORM_PROFILE_BALANCED_PERFORMANCE and
> PLATFORM_PROFILE_QUIET for this use.
> 
> Reported-by: Yijun Shen <Yijun.Shen@dell.com>
> Fixes: 9a43102daf64d ("platform/x86/amd: pmf: Add balanced-performance to hidden choices")
> Fixes: 44e94fece5170 ("platform/x86/amd: pmf: Add 'quiet' to hidden choices")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Acked-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>

> ---
>  drivers/platform/x86/amd/pmf/spc.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/platform/x86/amd/pmf/spc.c b/drivers/platform/x86/amd/pmf/spc.c
> index f34f3130c3307..1d90f9382024b 100644
> --- a/drivers/platform/x86/amd/pmf/spc.c
> +++ b/drivers/platform/x86/amd/pmf/spc.c
> @@ -219,12 +219,14 @@ static int amd_pmf_get_slider_info(struct amd_pmf_dev *dev, struct ta_pmf_enact_
>  
>  	switch (dev->current_profile) {
>  	case PLATFORM_PROFILE_PERFORMANCE:
> +	case PLATFORM_PROFILE_BALANCED_PERFORMANCE:
>  		val = TA_BEST_PERFORMANCE;
>  		break;
>  	case PLATFORM_PROFILE_BALANCED:
>  		val = TA_BETTER_PERFORMANCE;
>  		break;
>  	case PLATFORM_PROFILE_LOW_POWER:
> +	case PLATFORM_PROFILE_QUIET:
>  		val = TA_BEST_BATTERY;
>  		break;
>  	default:


