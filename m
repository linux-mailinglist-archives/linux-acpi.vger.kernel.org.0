Return-Path: <linux-acpi+bounces-3998-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E96686B1B8
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Feb 2024 15:29:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0D8F1F271DD
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Feb 2024 14:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A384D159574;
	Wed, 28 Feb 2024 14:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Po6BnweY"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2063.outbound.protection.outlook.com [40.107.243.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2ACF15957D;
	Wed, 28 Feb 2024 14:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709130531; cv=fail; b=F36cZlifU/egRWV3k+UE0pY5D9/NflYf7nX3hD3F1GElkyyHHcbUmnBxJIj+idGxWi0fYHXXQfH6tHTPuSjNZwtOQmFl3OxMU5ChS5ZmYja2b2BwOQvgmPqT9Yr7uYj8d3hgFulpjOyj0zBaD7R+TXAlL8Y8iYMoty2ohpYxBz4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709130531; c=relaxed/simple;
	bh=urlkHtRstBhObCQ/80yKr9fritvQVQHnYk+mioulDqQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FpRyP3Tjtml5yJFWLc1e8oRA1zJAJu1PzKJ8tZZzFfFlrJh41kd7IxN0YtgHZp/WhnkoasZa4Xh47FFrFbkhL5wmxp4IBHkk5Q1vJtfYjDsJ/1foh7PWaOhOcKq75SUQmOMFNUrlzvR2yNarJ4wl8R6lxdfOiEBK/wCP4eOj2oU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Po6BnweY; arc=fail smtp.client-ip=40.107.243.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pz/svnn9ZUa4vZh0XfRSrMfhCBfvt0yIWpdVMmcwReUshR8uo88tgN7vVc178txTCMB/dUKe/5RZltPXZ9qvSWRW25geiRJJ4fjqkv7TMg0LP8oQoE5P5yrSXP/+XAC10GZdYVVGlSey44A/R0HcqnpUn5gLWd1bYBUqnqzVCqwklrexGyDuN+z/AW6JLfV6T+8t3qsHsJvSLSYoUN1erbszRewA+kTfef3zY71Len782tpQ0BuCurDDZ2Ko3OByU+Ntw2szvGsaFAOF12kl3MsBobrSWFCbm3C9Rc9+g04zDiFxA90lTCBr/32e4dWU9HcKh8YQx1jLW5RBII3maA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P/CXl/zQ2zv3Vmd4UqUVAZz1wC4aoFvrscTH30oK4VA=;
 b=dm7oUcLPhlW+1qvVKBrrFHd+YY6ps9GAJk1x7FyfuNUp6ORYMCA5chts19Yu464YCdHZEWfEc8tvO8cOgiIO8XrRL5ikbT1BjvHBaZiN1eifM+PwPc8Q/vfPxjTiEXWpNcNlUhExa5AMoM0RZ+x59S+V6yFLD6xaLhnDMEZDKHNq3QK98NE2j2bfjsUmLITGDpen9oIR3+LeIPc/L2rFBxxm88HxMxocM8hDUoJurKs64xkESusxkif5lv/rnxP6Fv16RBbY1T+rlgmxrS/B+zOoq8U/AOdOW+5HUwL2t2KexBlLyIXD/fh4avb4RraLZ2ZeYfybmVDmaeRad1JncA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P/CXl/zQ2zv3Vmd4UqUVAZz1wC4aoFvrscTH30oK4VA=;
 b=Po6BnweYPfKcDCHlhh46mWLgtf1Im7OMdJnPO48qPH1TWs5Qr915Lb7JBBCG4qa9nqnmcMUobfng+Fd5gPe4DMhoKkqX8BGUycqxC2vLSS4ssIww9k14oRHfHZt3sZdKQ15KC+42MbnCJEGcnsnAQKPCNx4DNnOgmr7wR/qIhro=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8535.namprd12.prod.outlook.com (2603:10b6:610:160::19)
 by MW6PR12MB8913.namprd12.prod.outlook.com (2603:10b6:303:247::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Wed, 28 Feb
 2024 14:28:45 +0000
Received: from CH3PR12MB8535.namprd12.prod.outlook.com
 ([fe80::5302:26cf:a913:7e06]) by CH3PR12MB8535.namprd12.prod.outlook.com
 ([fe80::5302:26cf:a913:7e06%5]) with mapi id 15.20.7316.034; Wed, 28 Feb 2024
 14:28:45 +0000
Message-ID: <0317930f-c2ec-4ef7-8bc2-4c155f62ece1@amd.com>
Date: Wed, 28 Feb 2024 08:28:34 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 1/4] EINJ: Migrate to a platform driver
Content-Language: en-US
To: Dan Williams <dan.j.williams@intel.com>, jonathan.cameron@huawei.com,
 rafael@kernel.org, james.morse@arm.com, tony.luck@intel.com, bp@alien8.de
Cc: dave@stogolabs.net, dave.jiang@intel.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, linux-cxl@vger.kernel.org,
 linux-acpi@vger.kernel.org
References: <20240226222704.1079449-1-Benjamin.Cheatham@amd.com>
 <20240226222704.1079449-2-Benjamin.Cheatham@amd.com>
 <65dec8ec4d478_3651e29421@dwillia2-mobl3.amr.corp.intel.com.notmuch>
From: Ben Cheatham <benjamin.cheatham@amd.com>
In-Reply-To: <65dec8ec4d478_3651e29421@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0662.namprd03.prod.outlook.com
 (2603:10b6:408:10e::7) To CH3PR12MB8535.namprd12.prod.outlook.com
 (2603:10b6:610:160::19)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8535:EE_|MW6PR12MB8913:EE_
X-MS-Office365-Filtering-Correlation-Id: 112e7ad4-0783-4c85-a330-08dc386991f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	dfdit2GNXyZhUCrHodXaJAwHLQEX4cDRtzojxdmvwVvs0U1ki4O5xirh3KgZIZDnsHdiEsMFUS18Yr7Mi+2PIo5/ziFSxcVtqsdJbpvZaQVwQOmbjXOh+r3XmqZrSeDUfj3KC5j8W4Lab+JjD+WTpajY79a2wp+lmMQdFt5bNUp6k7d/mi8WJjy/ndGb+m5jhbGG/Q3+4W1jdANiUU4blQ6AketYHqkeuJhuUNaLErssIx7l2E2qUErc3ViOS/+iFmX5y6X4+EFLDjOg3ct/C4e24CBv8LwwqP5QuOHHgjKsXpfGj1bHEQMMwKHzz9P+1SBO+PG/KfG+IwlRQVURhn7Ya6CezrpESbZfvtoFnyTGnY5s0EfC1j6dKB3arRvBRPH1UPI1VNpkPv28rJk4e5KKK0W1S/h/qM8jsyt/eGZQV0Z7gPeaXz0x849YR3DSxJ4OzWpT2MXF/mMBGlbw5GiNp7TZb14HSjoSzB2NNN33uoBfFopTlNefD1cRW94Ekpfm/WitFSMSd5CHojSo+B/AbI4HgA149bN+WePnp+ukyd++6tvkqz+GPkPiOGYTlwld6TXwM/bIGzADT+GifOGew+EtLcQVXsPC91yXFRykVdelppx5Fpr8+GAJFQ5cgreFTrQTS90atuHbuPvrdyXkvV1KeNBZl+axUrdnTnQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8535.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(230273577357003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R3ZjelNNYWlDVTltRjZtdHJVMGhJQjhocUV5TldtVzdaSC9xWkhCelZlSFJw?=
 =?utf-8?B?Q08vc0pkQW5RMjBaeTFRY0VuazJPaTNQWE5nUld1MlpYNFh6bGRsRDVmWG9T?=
 =?utf-8?B?T0hUY0NLeWNBc3FQNjJJaFhxMm5yODl6VTFxYU8zamFYWmJIQVM0SUJVbmg2?=
 =?utf-8?B?VWF5Zy9sNmhQaWRjNGkreVd3TUwzd045TDNrb0pNVC9CYnpweFc1TWVEc1NJ?=
 =?utf-8?B?QVR1elVWd21uZnYwampKL01KWExZUld2ellZbXE5N3oxMWdvSFZ2SnhrYVRW?=
 =?utf-8?B?dGZUUDEvc0lzTDNCZERZUWlJKzJZVi9GZWZ6UGdKTjVHdll1d1VQZ1lZOGh5?=
 =?utf-8?B?elZGc00wVkZGREVEeVBkLzhNNmJ2REpOYStTRmpkMis0cmpvUVJWb0h0dnMy?=
 =?utf-8?B?ZFJ0SHdBdVRnckxmcWlJVkVTOFFjNERibzMvcmpFOE02cFFWSVNvYkIxQ3M4?=
 =?utf-8?B?MDAyTTNYdTUvUjBiaGZHOFVYSzJxSzJsQlI0TUlOTE1GZHNBRDd3QTFGdmxM?=
 =?utf-8?B?MVVMTjdWSVVsMWo1b3orcDYxS0NwTFliMzRxSUZleTRLYTlhckJPakE3R2Zl?=
 =?utf-8?B?cmZwWWJ3QlpYNitzTWorc2p6bWNMTzFmNEcrMEJYdWFiMlpUbkxMU0pRYWs3?=
 =?utf-8?B?R2tPM0NEZkFhYjQxN3lJZ200c0dtSVhGUHRMc29Jbm5YbGwxOUswVE5ROCtq?=
 =?utf-8?B?R3hCS25naWZQMkNWM3FRTjZvRndKS3hqNkxZWWRCS1FIdXcyVTVxUHllcXZN?=
 =?utf-8?B?WDlINHI5WVRad3dROXMzdkZQcm5DSUw5Zi9SNlVkS29ZOFBLd0YrVmgwTHpK?=
 =?utf-8?B?S0FLK0dKVUhETkoxKzFSOFNTeCtNem1zaTRKUzlMcEpvQy8xWjVTWFByMnI0?=
 =?utf-8?B?a0d2OWZxNHRSU0VOakplVHBQUTdBVEJJUTlGT1ZQbHNDQlRHMUlIZFlpdHdt?=
 =?utf-8?B?R0NsQk9xc0x3VTU2dStZbFpPK0RpWktvMmNtRkVZa0dYRTVSRExaVFJ6QzlU?=
 =?utf-8?B?Tlp2U1puZXpCay9CeVNXdCs2alVCajZFalVUblZPSmtBRUQrL0J2MmRqQUlj?=
 =?utf-8?B?clVnVlVzMENSTHJRcmJmek8xQ1Ayc2lsVkJKQ21YNjlFeWZNZ015YXJzUUVX?=
 =?utf-8?B?TGRvWjlkVWlEOVlTMzlnQ0ViWlh3cWN4ZkMvYVNPODhuZGpYK1lScmFscmtQ?=
 =?utf-8?B?TzBwempkSjlRWFo4OEljUzFDejlGZmpBUjlhd21tQlNrdEhtMEhNQXRBcW8r?=
 =?utf-8?B?NVpic2Y0VXU1dVNqbVN1THUwL3JOZGJETnB5a21uNGdRUTdxU0Jia2J4VjRY?=
 =?utf-8?B?TTJsd2QydHRzcW9pTDhYa25Oa1lUQW0xa0JlT2J4V2R2SXBlaUVUT2xSOGdk?=
 =?utf-8?B?Y204ZXN2YTNQbllFQURjMnFmUXNZdUJ3anBhMTZjaHlJcWlXTHF4K2JxVWJ3?=
 =?utf-8?B?ODFZMlk3b082bTdoMW5MeTNjL0J4QlhxT2tNTy9RZDA4TzBVMTJRSVZpQnFr?=
 =?utf-8?B?U1R5WTQ0Y1JnYVk4aUE4STlpd2xZd3cxTXVIVHpmaTJXOWIxWFhXdGZpaDVn?=
 =?utf-8?B?ZDZUVmEzMzNGc0F3dnJ2Uy81ek8rOHh1anJ6UThESUUzUTdxK3VHM25yQ1o5?=
 =?utf-8?B?SUI2bnhlcW5SWFM0dWNvaUNHNWFQYjlVRm1HUE8vcXNhUUNVaW0vRDVCa2RJ?=
 =?utf-8?B?dkdlVWZyalh2b1NoMFZNQzg2MlNuZ2VCelI4aVJKdFFZMzM1aUJ3T1lRLzZO?=
 =?utf-8?B?SjFzYUdWSW9pZWFZNGR4a2U2cGtCa0RNbUsrOWxRUVRXemlWUjJ2N3d4bjBC?=
 =?utf-8?B?RFIwWDJReUpGZ0haQm05bC8xb1U2UVNGVDZnN0dIckdkem00OHZROW5vNi82?=
 =?utf-8?B?MndRbXZVTG04Smh0dnZnVzgvVG5NQ1ZQUVpER2J6bmF5SWljd0luVWlBQnM2?=
 =?utf-8?B?QVJzQUF2OHRrU3I5MklEdHNLb3JpdlBDTGk5SlhDVDZOZUlXQ1NseTRWMERs?=
 =?utf-8?B?Nk5TdmRXWWkwR1VIZUFjd0NHbktObzc1T0VzdGxoMlluU0N6RS93UmNlVk9n?=
 =?utf-8?B?UWQ5QTVaYU1pcXo4a1RBcExmRmgxUXRmWUZQUlJQRk9XdXd2U0psRDcydVpk?=
 =?utf-8?Q?o8s1scf8BDOYRsTTYVCn/niB0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 112e7ad4-0783-4c85-a330-08dc386991f6
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8535.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 14:28:45.2768
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xKfy0ZJ2x3jQUM9pHd4YYPEr/XtI3NSygOkQkA7TvuIrQRhrAHtbFGEChvRnsdSjj830gtoAtPuFbry0q1Hzlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8913



On 2/27/24 11:47 PM, Dan Williams wrote:
> Ben Cheatham wrote:
>> Change the EINJ module to install a platform device/driver on module
>> init and move the module init() and exit() functions to driver probe and
>> remove. This change allows the EINJ module to load regardless of whether
>> setting up EINJ succeeds, which allows dependent modules to still load
>> (i.e. the CXL core).
>>
>> Since EINJ may no longer be initialized when the module loads, any
>> functions that are called from dependent/external modules should check
>> the einj_initialized variable before calling any EINJ functions.
> 
> Is this statement true given that no debugfs files are registered when
> einj_initialized() is false?
> 

That's true, I guess this would just be for redundancy/extra safety.

> It would be nice to remove that from the functions and just rely on
> debugfs files not being published for safety.
> 

I'll go ahead and remove those checks.

> With that fixed up you can add:
> 
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>

