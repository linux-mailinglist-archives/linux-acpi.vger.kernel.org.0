Return-Path: <linux-acpi+bounces-3804-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94FBB85E966
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Feb 2024 22:01:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E39E1C22737
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Feb 2024 21:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A515D126F1D;
	Wed, 21 Feb 2024 21:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KL4iooCH"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2070.outbound.protection.outlook.com [40.107.94.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542A3126F05;
	Wed, 21 Feb 2024 21:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708549270; cv=fail; b=nuSMxrBDTK9ad4AjfjqeZPP9S2mQp8Uou7g7IhfPUehiSxWhhUbWgHPPFTQToxYDB8+oEgD6wYJt8lXck6yQ6bHWPmzIPmxR9tWOzjbjVZ/Va+lyvJGZbZiMZz3hEQi2pkC3qnTejcKJ3E9iVH+J8we7jNnBFZnF3cp3zfzWFFg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708549270; c=relaxed/simple;
	bh=8Ep2QYOY4P8KqpmVqP3pa/47PaT04EJAmTv2huxCivU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DE3lUhwpjStZy3hfgFm4O1S1qOT7WuBRGSmOIcJLclFX8vrqrpyZTu91DYnBEistzte/+dbsiUzUCz977kkO9J53ZJUgqdTf9uZK5GP1q3lfIHfivlucgmTVkDWZCFrdI3K26HsTy/xBwjW0Y4hEfEKsUXPwavNIPNm4dRbskWY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KL4iooCH; arc=fail smtp.client-ip=40.107.94.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I9siCSCq88f6WEy3t4FxXhDOO9aMwwR25jivJHGuAoQDo+HF5c+5CRkmowCRjdhEaxbuZUdCWKajBVUn8nbkOiSxWqKc8a5M9dztyBVyKlha6KDTSv8wAboY4+2JaFp8XszC4/B3dxFV4tc18a3VLW+xhv87tPdBUIbiFqw3rxrUQtSiMv3BtY9ztR2YQ/LIf5XG3qDv9CMmLr+bIz4ozfXfcrZOV/Zo3weI3snHHR+BUsCJk0WbBwsKT8/fqbrD0SWBiURS2BkJU60hrAkaG6w/1hsx4aEjVQIjjgazl+nkHorGPdqihPXbwjB5XtvKNw0HuFsYCOQONaRMraSFGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TaBHWvMf/RbKG3oiBR/hhQnjDoP/x9aHcKEE8NUAxM8=;
 b=L3+bOWym30mAq8yf0tRCIwqhmC8FiLMO71U5B0hwSLcdN4uTowkWGMaj2exIcj+C6kACnChBkBNUXEXxd7xHa42gw4AxtgbfGBzXV89XcIuUwe2sZNXuBw/1RXNrhRdA/5qoKYNw2LDZWEEKFsA6+Oc4UJt5eZbBrJQE4dxAW9th3pAqFvpKYioOz4C3Z2Z3xUwyHaLVMq9SBYuzakXiXZsga0rAy0H52lMfGrhSBjwPJbcqI+d46m2SCee+SDZiRNpWx/tmgUpZq15dB8W3kJZnuWwnESbUE42Pnj0o2u3VvX4hN2cogfSS51iRs6ckK7qkEF5/n7SMIYkN0B5prw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TaBHWvMf/RbKG3oiBR/hhQnjDoP/x9aHcKEE8NUAxM8=;
 b=KL4iooCHUbF4e5BddRx0zL2XsZjSzvkkjWMYpNrtpwybsMXhWuizmGhmczzDswbjfhQ6vQM+YzJRbl71euYpAWn6ih+oIYNSO4f4Li0m0zvxtOc8tREpvWbgY7QWkM4UdPE1fgpcamf6MLx6NsMdJM5QMaboymOSx3PV67Q5Aeo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8535.namprd12.prod.outlook.com (2603:10b6:610:160::19)
 by SA1PR12MB6774.namprd12.prod.outlook.com (2603:10b6:806:259::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.20; Wed, 21 Feb
 2024 21:01:04 +0000
Received: from CH3PR12MB8535.namprd12.prod.outlook.com
 ([fe80::d493:7200:e0ae:1458]) by CH3PR12MB8535.namprd12.prod.outlook.com
 ([fe80::d493:7200:e0ae:1458%7]) with mapi id 15.20.7316.018; Wed, 21 Feb 2024
 21:01:04 +0000
Message-ID: <f308f836-a41c-4de8-8522-7c086d89f167@amd.com>
Date: Wed, 21 Feb 2024 15:00:56 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 2/4] EINJ: Add CXL error type support
Content-Language: en-US
To: Dan Williams <dan.j.williams@intel.com>, jonathan.cameron@huawei.com,
 rafael@kernel.org, james.morse@arm.com, tony.luck@intel.com, bp@alien8.de
Cc: dave@stogolabs.net, dave.jiang@intel.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, linux-cxl@vger.kernel.org,
 linux-acpi@vger.kernel.org
References: <20240220221146.399209-1-Benjamin.Cheatham@amd.com>
 <20240220221146.399209-3-Benjamin.Cheatham@amd.com>
 <65d63647ecdb1_5e9bf294d6@dwillia2-xfh.jf.intel.com.notmuch>
 <5a650a49-8f80-4ade-8844-61f88172cecd@amd.com>
 <65d65ffdd40f_5c76294ce@dwillia2-mobl3.amr.corp.intel.com.notmuch>
From: Ben Cheatham <benjamin.cheatham@amd.com>
In-Reply-To: <65d65ffdd40f_5c76294ce@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR10CA0020.namprd10.prod.outlook.com
 (2603:10b6:806:a7::25) To CH3PR12MB8535.namprd12.prod.outlook.com
 (2603:10b6:610:160::19)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8535:EE_|SA1PR12MB6774:EE_
X-MS-Office365-Filtering-Correlation-Id: cb02a0d9-18ce-4812-0125-08dc3320373f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	pek5IQHwRviFXyNX8yBRDm7zolyfYPG8q2JoC4MNRthNYf8NNn4F7MX634Dt5g4/14AiNqzrn4Ah7lyO16MyfMk5RPcW5ayTrOdiX8FM/uhjqRXKQ2B9IZK/QRN2RSH8fwfI05z6gTdYJ+EGSsMMS6uRcvq4YK+1ccif/w8rF+rENaUf5ZnclBPnVBBAsKVj76CZ6ArGltza5o9DTKqTkLkoLkIu2Gb/bwsH7R9xie6Q03DXtBBJmJ1uwLLYpAROcg+WKJPsSbVULZFzM6ewWxhDq9xtiqG8/5p/AagTuNkUpVDlIrrTa102xzk/kRf+IR2BZKNX6H6KPrJ9uBkuNA3LsQMS7e9ZiUm1xRDvpy/a8CeRZORAvvZRMZ+IRRnAOsTjh0NZ0AjRI/56bZ9hXCqjzfgkRCMidrsxT13VizO4g5gjwa5A90Fhe9pnTzOM/3BMG3RzUYAJxD/RGdPigimSzJJvPc+QPMmFRZlyn4M+86DMef/dA7mOsLnqb3ksax+478WCERkoI/hkzTijICkBZBpZu/FPensoGs87GLY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8535.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TVlNMmg0bm9xUnRIcVhRRWVXVkJHdVdqeENBZksvNU9UV05vZ3ZmMkp1Wndu?=
 =?utf-8?B?YVIrSHh0b3lsQmNxK21obW9jZnRURWtGcVlhS1M2MSs0NHNHTld0Z3dVd25C?=
 =?utf-8?B?K3JkMElZS29yRXUyaGp2ZklpUG4yUWRrU1lvR0ljN2w2THF4Y3VQM2w0QTJR?=
 =?utf-8?B?UFArL1JUcFR3cVlGMzR4a0NBU0l6WXJMYVZGaWFHN0lOQWI0QUY2U1RDMjJL?=
 =?utf-8?B?cFFkaUNRV3EvUDdZNEU3b1BuUFlrQzFaT2hiNTFIeUtpU2JjK2hMYVBMblR6?=
 =?utf-8?B?TkdIbnkyb01raCtUOGRqTXM4RkQ0WVdYVm8xTEhzSE9XRkYybUVZU3JYeGgy?=
 =?utf-8?B?WEFKYnVrMlF0K1ZFOWdNcGxnWGhCOXV6b05GN3dyNDBiUGpubDcwa0k2NFJ1?=
 =?utf-8?B?K3VPU2VMSG5rSUpvTlhNNElXaHlhSkF2MUE4UUpJM3BGL0tDZHU1M0FMUjF6?=
 =?utf-8?B?a3NXaVc2OVV3cGpoQkRPUCtPTTdtcmRkMGVMMVFQWDRCN25raGhiYlhkSjdG?=
 =?utf-8?B?c3NUQmJ0UG9qTWZIREI5cEx2SHdlVVA1ZEdPVE45WVBoc0djREU2dmhmVVYr?=
 =?utf-8?B?UEJFNUFrVUZINGMraUd5NXFaeVVzTDlMdUwzUTFPY3FaTCs4Z3ZvZjdRZHJn?=
 =?utf-8?B?eGt2T0FxaE5qTTdSS1JOTnlZWmF3YkFqaXZOczdFampBc2s2MDZraVUxaFRi?=
 =?utf-8?B?RkZsajRockJsMnFWQWU2clluZmVLRXRseVNYc21VWnV4Sm1tY3RGRXBtMVcr?=
 =?utf-8?B?WE5HSWc4Zi9XZnNYbmtSQ3VaVUJzVXRDRmFpTTc4ZkV4RFNwMXY4dkF6MXkx?=
 =?utf-8?B?Z0hWN2hLOVVNYUxkYUdCb2Z2Mk1XMzNGeEsxUmhkakZzUmU3cGo1dWdiRHN0?=
 =?utf-8?B?K0xKSDhSY3pRelhqTGtaMUl4UWgyc0dBb3Z1eVVja0Y1OHVDVTIzaEx1Wkh6?=
 =?utf-8?B?aWJuSDI2NVQvY2J3aUVUbFovc1h6SU44MFQ0V1JqNGtza2hLdFI2dVN0WTZU?=
 =?utf-8?B?OGNxVDFyMXY5RWlNZ2dWQ0hCajN5NWRXUkV0RXMzaXdnUEQwcFQ1NGdpVDVP?=
 =?utf-8?B?L1VHaVgyU1FqUWphSEpZMWFjR1JlRGN1aktnNjZ3SUYyR3Vxc1JsUzR0aVZs?=
 =?utf-8?B?bU9rWXYySHlVSE1TVWhxcFBSSU42WnpkUWcxK3kwMkRrWkZtTGpsYWQ1TnY3?=
 =?utf-8?B?WjgyNlk0TnhiRmdrTEN4MlVJcjkrd1JnTnEyRnRZUytvTE8zSG16UUlSVGlZ?=
 =?utf-8?B?emU5SHBYT0lXRElKY2VoQlpQV2NZZjg2VENvaTUyOS9NQzFRNzFoM2p6OUpa?=
 =?utf-8?B?UWpOQ0RXTjE5OVYvRlY4K09jRWZ4UjJob1ZrTHh6WXFDQ21EaVFsT0UwV3Uw?=
 =?utf-8?B?dTZTVWRCN2hGcjZLSXBZSzBHeFQ1TmxwYk4rVHVuODI0YW1BR2lQakRNems5?=
 =?utf-8?B?SURRR29sdERNK1BiNlBwN0FyVTNpZ09KeWRWWkZ1OWx0TzJkSFlZVlBTZER1?=
 =?utf-8?B?RktMamhML2NNYTNseUlMbzZZcUtER2xXN0x0Y3dLbTl5eVR6SXlydU9BTHUw?=
 =?utf-8?B?OEZJQmpZODQyU01yUHhLaS9wSS9tdkVUTy8vZ2dEYWdvSytrMC9aaTIxWDZy?=
 =?utf-8?B?NUo4YTQ0eWNMbktOZkU3VTFqZVRYV2N0L01YTVkxWU9kSUJwc290Qk5NMmZr?=
 =?utf-8?B?R2dMWitLWUxOdG5hU1RYSmU1WWxGRjFrSVJyRjdRVEhHRXlEUlkrRXpsL3Vp?=
 =?utf-8?B?VS9JeHJvSGpnblZzdFdIT3czVnJEUDB3VnpOMzRic1FPRmM5ckdPdEpYY1Vj?=
 =?utf-8?B?My9PRzcrWlJvUUVEWW1WRFBCanFGMmlZNDZ3WVVraGhBNjJJc1FMeGxueFdn?=
 =?utf-8?B?K0ZUVmVYenJhTGp4VUpYN2s0Zmt3dURrVTk2WW12eXdqUHFUWHlwODhONWhJ?=
 =?utf-8?B?dGNoMll5ZEJkYlZUUDBnQytwM3lQblU0QlZXYmhpeldTT2pBRkJObWlUaVNZ?=
 =?utf-8?B?eG4rK2hrRUlUcnE1Y01rY0dZdWpsWDRWLzN1cHB4dUUzV3dJWXI0SCtpL0lr?=
 =?utf-8?B?azlZL0ljd3Z1TW95ell6TDJQdENPRFA2YlZpWUx3cm1MQWZpUG40c1lIQjcy?=
 =?utf-8?Q?TL8kZD1yXBm51fA0MtUTz6u8O?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb02a0d9-18ce-4812-0125-08dc3320373f
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8535.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2024 21:01:04.0484
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3tGgjkxnrKKtMTPkMqMG7A8CCtuEDz86Ulm/WVjxMNaHQ4Zmb+D+hvUEh3EG3gd7bTc1ofBn9gWkbbnlW6kiIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6774



On 2/21/24 2:41 PM, Dan Williams wrote:
> Ben Cheatham wrote:
>>
>>
>> On 2/21/24 11:43 AM, Dan Williams wrote:
>>> Ben Cheatham wrote:
>>>> Remove CXL protocol error types from the EINJ module and move them to
>>>> a new einj_cxl module. The einj_cxl module implements the necessary
>>>> handling for CXL protocol error injection and exposes an API for the
>>>> CXL core to use said functionality. Because the CXL error types
>>>> require special handling, only allow them to be injected through the
>>>> einj_cxl module and return an error when attempting to inject through
>>>> "regular" EINJ.
>>>
>>> So Robustness Principle says be conservative in what you send and
>>> liberal in what you accept. So cleaning up the reporting of CXL
>>> capabilities over to the new interface is consistent with that
>>> principle, but not removing the ability to inject via the legacy
>>> interface. Especially since that has been the status quo for a few
>>> kernel cycles is there a good reason to actively prevent usage of that
>>> path?
>>>
>>
>> For CXL 2.0+ ports it's fine since EINJ only expects an SBDF which is
>> pretty readily accessible by the user. CXL 1.1/1.0 ports however, it's a bit
>> of a headache. It would require the user to find the address of the RCRB
>> for the port and supply that to the EINJ module. I originally had this option
>> anyway, but I think it got shot down for being too obtuse to use (I think by
>> you, but it's been a while xD). If you think it's still worthwhile I can
>> remove the restriction for both types of ports or just the 2.0+ ports.
> 
> So, to be clear, yes I NAKd that being the primary interface, and I am
> not changing my mind on it being too obtuse to inflict on end users.
> However, just because it is too obtuse to be the primary interface does
> not mean that if someone runs that gauntlet, or has expert knowledge of
> where RCRB is located, that they be tripped up at the last moment from
> specifying that parameter via the legacy path.
> 
> So consider it an undocumented feature, and I think it only ends up
> being a one line change to let that parameter through, if it can be done
> safely.
> 
> That said, if there is any concern about input validation and safety
> then keep the policy as you have it.
> 
>> For CXL 1.0/1.1 ports there's also the security issue of being able to inject
>> to any address since the way it works is by skipping the memory address
>> checks, but since this is a debug module I don't think it's that big
>> of a deal.
> 
> Say more here, this seems like just the safety issue I just mentioned
> that would justify forcing folks through the CXL interface. Depending on
> how severe this is it might also require backporting the removal of CXL
> injection from older kernels.
> 
> The main concern would be whether einj needs to disabled when kernel
> lockdown is enabled.

So the way the EINJ module currently works (at least as I understand it)
is that any address supplied for memory errors is checked to make sure it's
a "normal" memory address. Looking at the comment above the memory checks:

	/*
	 * Disallow crazy address masks that give BIOS leeway to pick
	 * injection address almost anywhere. Insist on page or
	 * better granularity and that target address is normal RAM or
	 * NVDIMM.
	 */

it seems that's the case. What this means is that we can't supply the
RCRB of a CXL 1.0/1.1 port because it's an MMIO address and we have to disable
the checks to inject a CXL 1.0/1.1 error. So, there won't have to be anything
done in terms of backporting since CXL error injections will get caught by this
filter in all kernels that don't have these patches. For kernels that do have
these patches though, there won't be a check on the address you supply as long
as you specify a CXL error type.

So, it seems like a bad idea to provide legacy access for CXL 1.0/1.1 ports
due to this issue. CXL 2.0+ ports don't suffer from this issue though since
they are specified by an SBDF, not a MMIO address. And looking at the code,
it looks like EINJ error types that use an SBDF already get through the
filter. So it doesn't look like there's actually anything to be done for
CXL 2.0+ ports and the new interface is just a convenience feature for 2.0+
ports.

Thanks,
Ben

