Return-Path: <linux-acpi+bounces-3419-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A86908516C8
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Feb 2024 15:15:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 152761F25F84
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Feb 2024 14:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ACEB3CF7A;
	Mon, 12 Feb 2024 14:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="K0ZXzVmr"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2073.outbound.protection.outlook.com [40.107.244.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93CC13D0AA;
	Mon, 12 Feb 2024 14:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707747170; cv=fail; b=n5SAaKyb0PgYxNx6Ld5RQvkFj5pFhv2HM9Qm7I9Rm5sJAKQjmtqD1ijZevhOeRVpG1K9StRAAavO7m/0zr8WT8SEvsP/u3aTad0AIqTNM0zvplS2wdZ7+IWyRyjmViXQ8RrRq0tdAUInl44guW6wSMQ1V64x7HC3IK6bgr+Ko3M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707747170; c=relaxed/simple;
	bh=yogYOgumAZCsEJprsuiFngaQOShGIQcGDIlfYvSh0HQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GW4UMkQ1jaVJMlw1VTQYxrCyfuuuMqC8PBJD4xFJ0ucfXOaVpgSr3oc3yx0magg3Xco4Tjl0gEhlyQhFh1t+qmdqLMC2f4bypJSUz63DStQlggnPBy8ij5yzjScjd0gb4Vnm3D9XKBmDec+axubF9O4FJkS5b74llWTMquBN/cg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=K0ZXzVmr; arc=fail smtp.client-ip=40.107.244.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DOA+d9V6GaorfnTXpcen6vJSKlEkcnjakP2NErZBNAJXCefCjXmtMmTcOGhNzKijiqLOXzlJA6n4fwHzCfoVn0M3aflJbflmOOKdw1b37c2ywGfQpKmAoTRb0gr0x1SBGEPD4v/6/ejTwRmVpWqfBWrPD4MsgIH8Q7+xtL6899VQ6AWU7yIXZXWrYjeW4+Aawx8ljGBmYj7YjzPU4h5zSmq5McghaiyMoW1jjJYabJbqWlvGdR4y4Y/G9FVrOTNFyrYsr9MBgs5Q+1D35zVlvUUNNwSqMnE1AEZh/2AMgHjdu3LV5yyOq/YQg+WabdQgjhAdDfBYBAcqxRA80OJRyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sZ9wn11uLck3+poHz5bw2JZQvnNMNC0JQi+PMTwcvIQ=;
 b=brmEslHiZcGDKvvP0f2fx0/a4BmaFYfTYHjKJk5qGqth+WucwUv/ouKWC3tGmDs36tXR5HxRotU74/wTjUZWcDK0AUzscGXlDULCDaaaBZQcZjhN0B0rexWIwK2QH+PeWlRBOOXQ9VfucBwvhK/0S66wW3GdMAcSPzVChi8YHFXDeaQ02i0zn6QQE6rngJciolMFbC2VP1+zV8Xb19GJqs9/J8Oif9myg4VKalqc7QQt96ZdoRpHBfX0sz1UKRbJVHstqK+TFQaI0YL3sqvOhw86m9gVBF5kFPAPd71cU9sSxsPIZgfp+OmLtd3GeCZM2JQadwPUpQZojH3BO5Sviw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sZ9wn11uLck3+poHz5bw2JZQvnNMNC0JQi+PMTwcvIQ=;
 b=K0ZXzVmr2YxP1bcZz3tsl3YZoD3oU8xheBtGDChHoGa1AqQQkmD214OwjHvzHFzqFEEkPiq251IqxkENKPP6bGRHrVArpipg27PDQrMZIrbz7OPEtivk19ECVvZZrQGmON17JwXrZ/4Nzu4bYD1lnZP+9ma6v8KfDVMHYqFyWaQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8535.namprd12.prod.outlook.com (2603:10b6:610:160::19)
 by DM4PR12MB6133.namprd12.prod.outlook.com (2603:10b6:8:ae::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.11; Mon, 12 Feb 2024 14:12:44 +0000
Received: from CH3PR12MB8535.namprd12.prod.outlook.com
 ([fe80::b21f:aced:8bae:a73d]) by CH3PR12MB8535.namprd12.prod.outlook.com
 ([fe80::b21f:aced:8bae:a73d%7]) with mapi id 15.20.7292.018; Mon, 12 Feb 2024
 14:12:44 +0000
Message-ID: <2329b256-184a-4646-b92c-7d3f8589474f@amd.com>
Date: Mon, 12 Feb 2024 08:12:37 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 3/4] cxl/core, EINJ: Add EINJ CXL debugfs files and
 EINJ helper functions
To: Dan Williams <dan.j.williams@intel.com>, dave@stogolabs.net,
 jonathan.cameron@huawei.com, dave.jiang@intel.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 rafael@kernel.org
Cc: linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org
References: <20240208200042.432958-1-Benjamin.Cheatham@amd.com>
 <20240208200042.432958-4-Benjamin.Cheatham@amd.com>
 <6cd90997-0dea-4dd6-ab8e-2630efaa6209@amd.com>
 <65c6bd181bd36_5a7f294dc@dwillia2-xfh.jf.intel.com.notmuch>
 <65c71827726ae_5a7f29434@dwillia2-xfh.jf.intel.com.notmuch>
Content-Language: en-US
From: Ben Cheatham <benjamin.cheatham@amd.com>
In-Reply-To: <65c71827726ae_5a7f29434@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:86::15) To CH3PR12MB8535.namprd12.prod.outlook.com
 (2603:10b6:610:160::19)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8535:EE_|DM4PR12MB6133:EE_
X-MS-Office365-Filtering-Correlation-Id: f2d3ac18-aa3e-4908-4b47-08dc2bd4aecb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	bgC4HoVGyMfEN2rikt/RRJvom6RTEn7ocze6vqmjGTwpluXv2ieWz5LPsOIzCMdPcipnHw49FSFD1/jboM/usmI5QVwLe+PFkIcw6npvgz/WnANYBFAPVuW+U05Fa23ZoaiessOipqyx+ndygdaKAz9fixS6lFr3U5wmvANA1zzS1c4u/Jv7cDC9AqvFFv7uZ3RHOlNLe/RccnYyXtpvUV92HVjKVBAO2tU/mQgbZtZkcGIwT4GjA9+/bb4pPuGWADpXXHN+e67S/nKaM/iEfaca4zQBqtflAbyjt3y60AV2DL8h99og/v5mWIcJyojWVGYSMffLwEGzjgfMaYNyj1KcWCVC0WIcsix6YxE0LyBpPxv4I19Anb+IxCdQ2qcv2BgaCY3+zKvmaRy+bTrmD0PYx6vVUsO4Idusonp+kSxY7+k1si2Q2vOfNuj+0ra3HFClpKEZbLi8buhcdl5c3FOaS7ka/x27TwAmCZ+/e9gm3k9zuvlaA+ZHEhqZ5YD2zhK9SVEUU0VX5pLx1KjBTDLmku9Y6jy3CPBnZyReJJQzVXjVjJ8MlpFtKx5eAsuM
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8535.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(346002)(136003)(39860400002)(376002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(2906002)(30864003)(7416002)(8936002)(5660300002)(6506007)(36756003)(478600001)(6486002)(2616005)(86362001)(31696002)(26005)(53546011)(4326008)(66556008)(8676002)(83380400001)(66476007)(66946007)(6512007)(38100700002)(41300700001)(6666004)(316002)(31686004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aFZpbEIvTjRJRzhPdEw4aFVZYi94NFVqdm5rMGhQZ29mQ21YaXAzSmpmQTVk?=
 =?utf-8?B?SzNGeThIYlZyeFM3SG9FckFCUk5MOUhqUERoV0FjcWVaUjZZRTJQNmRPMmdp?=
 =?utf-8?B?MElxUU9VQlpmdWJMQkJmdjFOQzg1NUNGdnNBQkh6d0FJeFl5dmdyQXFOaEQ2?=
 =?utf-8?B?WktWeXJXWFRDT2lMVm4zeWpuMTZKWjl3MFFONnZGZVVnWldYeGNNblhZR0hS?=
 =?utf-8?B?ajV1ZFBQekdFdjFDd244WE51ZnYydXUwRWxMV0FXWGRyVk5FNHZlaHczUGtm?=
 =?utf-8?B?V0Y4TTNNMHRocVhuTnlMRVAxT2EvR0hxMnJyZmhjQXB0SFd4aVBjNDU2KzVM?=
 =?utf-8?B?bm5iZXYzV1d2eHFlS2tCMWQ5eDREMCtCaHdLTm1EemUyZDJsRGsyOG9hcWE5?=
 =?utf-8?B?RFdaYzNsMDI5ZVZwMHFXSy90a2pUWkNXTTdaWUdUMjNDTTBzRTJSTndrR0NX?=
 =?utf-8?B?ZGU3M0doTkNjOWdFc3QrL0piNXJsaGREZnhUUmRRTE9TVUwwYUJJN09jS3Fv?=
 =?utf-8?B?R1JSaW5sSXM3TEQ4SFVMb0t4c08wMjVTbUVBV1YrVmRMV0E4dHgxQ2ZSMk1q?=
 =?utf-8?B?TThSZ0d3RXN1RVZ4Vm1zdThFcjd2UTk3Unk0RGc1MkwyalZpOUc3S255U0Fa?=
 =?utf-8?B?bE9WNXlKcHJWOHljUG1JbldaNXdzRUt4VlJ6TVUvYjJjR09sQVdmN2VaNU9x?=
 =?utf-8?B?ZklYdy9RS2l0Y3VaWWIrYkxpVkw1VFRGbGJQU3BIdTk5clAzUHlWb1llT1d1?=
 =?utf-8?B?c09vMkwzVXpCWHpoRkxSbXloN2ZkM2orRlZrQ0lJYXFiT3EvTmlFQW04TFc1?=
 =?utf-8?B?NXp6ckV6TTd2clF0ZmVKR0Y4Yml4OHBoN0x0MVBPSTltVDBBTnpGbWV2cURE?=
 =?utf-8?B?UnFSR2F3ak1xUEhyYk1XS3FIMDNLMVVqMG5KZUhGbWJsUzdkaVlhd2huS04x?=
 =?utf-8?B?QXdka0srdGxtd21Jd3FHeThteTVDNWF1aWdBTzBWQ284R1dqaStNc2l4Mjhk?=
 =?utf-8?B?Zm1sNEJFeFFoQW9ReXV3SUdUcXJyQkVYZHRxTkhibmpvTDZMK3Q0Y2l4eld2?=
 =?utf-8?B?V0xRRFo0aDBYS0VhSHNlVTBMWExXeHcwTER0VHpVQ3FySDFTcnAvckN1bEFP?=
 =?utf-8?B?aHJFaEZ6a3psZkpWOERNWWoyeERXOUpNVEh5L0NpOEFKQy84SERpb3FvcWFC?=
 =?utf-8?B?d2VvNkplandDMzVUdS9CcFNobU5Nayt4QTVXRUZYbkcwcGFOUkhyZlJicmNr?=
 =?utf-8?B?UzUvQVpVOXROUDk0R2lZUTRvQ3p3Tm1yQzQ0eCt4aWpmU2h2UFowT3RybzBN?=
 =?utf-8?B?OFJkZ2tvRU5sTVFVV05IQXNhSi9XbVFOcVJRMzZ6MXhvWVg1clphTzZialFS?=
 =?utf-8?B?aVR2V2hNSzZGQUV2QmZMWW84aHhQdFZUd0pXWDQ5dXNxU2dmVFRhc3Y3bnQ0?=
 =?utf-8?B?SGlmT0J6T0wyZENoa3lTYVRuT0tkRlV4Vmc0Zlp5MlEvbXFaZzRKWVBLNzVY?=
 =?utf-8?B?L3RUTnRSSEtxRHBrejExTm5pVm1uOU9SL1E5RjB4RXQrbGp4L3NSREJnOFlO?=
 =?utf-8?B?bUJ3a2taaUhZTTNzcFU5d1hDMk5ONHdNemVYKzR0ODYwR2FpNUcydExISUxQ?=
 =?utf-8?B?V0pTb1V6TEgrYWw4UDM4VmJGY2Ztd1BncllERTR1SGJLMWxTcDZvWUgxaENO?=
 =?utf-8?B?T2RCaGxXNXZwTkRSZW9KUU41ZktqMy9UdldxZi9seVNOYTcvVWYwbnJBYXZE?=
 =?utf-8?B?YjRqWHY3eDBDK280MitYajgzUVR6MHBvN1gxOEtQaGdDenZkWjYyUFFFZ0NI?=
 =?utf-8?B?cE5MclNoNldKQ2VyckorbmlVZXh6Vi9nV3lvclg4dnI2anFkVGRUOVcrU3I4?=
 =?utf-8?B?NEhsS2FIMm9taStDOWRrenJKRnpuSm5LU0w4NjV2aHY1ZmlsRkN4UEdycFRi?=
 =?utf-8?B?K2kvM3Z5WkwrZ1hFZ3ZaSmtRYmJzM0ZwcVZJc3NPZ05SK1ZLakhmUHAvV2h0?=
 =?utf-8?B?VlhvNi94V0VrR2RQNUwvK0loNCtKUno3bzZVRVhqbXE4QVovTGRzL055WTZH?=
 =?utf-8?B?cEVuclFIM3F2L1lNS2dJK2RjZlpIam41SzZIbElTMkE1WkdLVWZYdUNRNlFP?=
 =?utf-8?Q?1VCNMcRkovLcUN1HKsypGVkwS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2d3ac18-aa3e-4908-4b47-08dc2bd4aecb
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8535.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2024 14:12:44.6900
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bdslzQi0xOjvgMBfE/XR5i1YiMFY7/KQd3YM1KjHyUiPTijXK6qUKW62ct8wQrQWtGfMWF9LQth5CWyboTVNEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6133



On 2/10/24 12:31 AM, Dan Williams wrote:
> Dan Williams wrote:
>> Ben Cheatham wrote:
>>>
>>>
>>> On 2/8/24 2:00 PM, Ben Cheatham wrote:
>>>> Implement CXL helper functions in the EINJ module for getting/injecting
>>>> available CXL protocol error types and export them to sysfs under
>>>> kernel/debug/cxl.
>>>>
>>>> The kernel/debug/cxl/einj_types file will print the available CXL
>>>> protocol errors in the same format as the available_error_types
>>>> file provided by the EINJ module. The
>>>> kernel/debug/cxl/$dport_dev/einj_inject is functionally the same as the
>>>> error_type and error_inject files provided by the EINJ module, i.e.:
>>>> writing an error type into $dport_dev/einj_inject will inject said error
>>>> type into the CXL dport represented by $dport_dev.
>>>>
>>>> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
>>>> Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
>>>> ---
>>>>  Documentation/ABI/testing/debugfs-cxl |  22 ++++
>>>>  MAINTAINERS                           |   1 +
>>>>  drivers/acpi/apei/einj.c              | 158 ++++++++++++++++++++++++--
>>>>  drivers/cxl/core/port.c               |  39 +++++++
>>>>  include/linux/einj-cxl.h              |  45 ++++++++
>>>>  5 files changed, 255 insertions(+), 10 deletions(-)
>>>>  create mode 100644 include/linux/einj-cxl.h
>>>>
>>>> diff --git a/Documentation/ABI/testing/debugfs-cxl b/Documentation/ABI/testing/debugfs-cxl
>>>> index fe61d372e3fa..bcd985cca66a 100644
>>>> --- a/Documentation/ABI/testing/debugfs-cxl
>>>> +++ b/Documentation/ABI/testing/debugfs-cxl
>>>> @@ -33,3 +33,25 @@ Description:
>>>>  		device cannot clear poison from the address, -ENXIO is returned.
>>>>  		The clear_poison attribute is only visible for devices
>>>>  		supporting the capability.
>>>> +
>>>> +What:		/sys/kernel/debug/cxl/einj_types
>>>> +Date:		January, 2024
>>>> +KernelVersion:	v6.9
>>>> +Contact:	linux-cxl@vger.kernel.org
>>>> +Description:
>>>> +		(RO) Prints the CXL protocol error types made available by
>>>> +		the platform in the format "0x<error number>	<error type>".
>>>> +		The <error number> can be written to einj_inject to inject
>>>> +		<error type> into a chosen dport.
>>>> +
>>>> +What:		/sys/kernel/debug/cxl/$dport_dev/einj_inject
>>>> +Date:		January, 2024
>>>> +KernelVersion:	v6.9
>>>> +Contact:	linux-cxl@vger.kernel.org
>>>> +Description:
>>>> +		(WO) Writing an integer to this file injects the corresponding
>>>> +		CXL protocol error into $dport_dev ($dport_dev will be a device
>>>> +		name from /sys/bus/pci/devices). The integer to type mapping for
>>>> +		injection can be found by reading from einj_types. If the dport
>>>> +		was enumerated in RCH mode, a CXL 1.1 error is injected, otherwise
>>>> +		a CXL 2.0 error is injected.
>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>> index 9104430e148e..02d7feb2ed1f 100644
>>>> --- a/MAINTAINERS
>>>> +++ b/MAINTAINERS
>>>> @@ -5246,6 +5246,7 @@ L:	linux-cxl@vger.kernel.org
>>>>  S:	Maintained
>>>>  F:	drivers/cxl/
>>>>  F:	include/uapi/linux/cxl_mem.h
>>>> +F:  include/linux/einj-cxl.h
>>>>  F:	tools/testing/cxl/
>>>>  
>>>>  COMPUTE EXPRESS LINK PMU (CPMU)
>>>> diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj.c
>>>> index 73dde21d3e89..9137cc01f791 100644
>>>> --- a/drivers/acpi/apei/einj.c
>>>> +++ b/drivers/acpi/apei/einj.c
>>>> @@ -21,6 +21,7 @@
>>>>  #include <linux/nmi.h>
>>>>  #include <linux/delay.h>
>>>>  #include <linux/mm.h>
>>>> +#include <linux/einj-cxl.h>
>>>>  #include <linux/platform_device.h>
>>>>  #include <asm/unaligned.h>
>>>>  
>>>> @@ -37,6 +38,20 @@
>>>>  #define MEM_ERROR_MASK		(ACPI_EINJ_MEMORY_CORRECTABLE | \
>>>>  				ACPI_EINJ_MEMORY_UNCORRECTABLE | \
>>>>  				ACPI_EINJ_MEMORY_FATAL)
>>>> +#ifndef ACPI_EINJ_CXL_CACHE_CORRECTABLE
>>>> +#define ACPI_EINJ_CXL_CACHE_CORRECTABLE     BIT(12)
>>>> +#define ACPI_EINJ_CXL_CACHE_UNCORRECTABLE   BIT(13)
>>>> +#define ACPI_EINJ_CXL_CACHE_FATAL           BIT(14)
>>>> +#define ACPI_EINJ_CXL_MEM_CORRECTABLE       BIT(15)
>>>> +#define ACPI_EINJ_CXL_MEM_UNCORRECTABLE     BIT(16)
>>>> +#define ACPI_EINJ_CXL_MEM_FATAL             BIT(17)
>>>> +#endif
>>>> +#define CXL_ERROR_MASK		(ACPI_EINJ_CXL_CACHE_CORRECTABLE | \
>>>> +				ACPI_EINJ_CXL_CACHE_UNCORRECTABLE | \
>>>> +				ACPI_EINJ_CXL_CACHE_FATAL | \
>>>> +				ACPI_EINJ_CXL_MEM_CORRECTABLE | \
>>>> +				ACPI_EINJ_CXL_MEM_UNCORRECTABLE | \
>>>> +				ACPI_EINJ_CXL_MEM_FATAL)
>>>>  
>>>>  /*
>>>>   * ACPI version 5 provides a SET_ERROR_TYPE_WITH_ADDRESS action.
>>>> @@ -543,8 +558,11 @@ static int einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
>>>>  	if (type & ACPI5_VENDOR_BIT) {
>>>>  		if (vendor_flags != SETWA_FLAGS_MEM)
>>>>  			goto inject;
>>>> -	} else if (!(type & MEM_ERROR_MASK) && !(flags & SETWA_FLAGS_MEM))
>>>> +	} else if (!(type & MEM_ERROR_MASK) && !(flags & SETWA_FLAGS_MEM)) {
>>>>  		goto inject;
>>>> +	} else if ((type & CXL_ERROR_MASK) && (flags & SETWA_FLAGS_MEM)) {
>>>> +		goto inject;
>>>> +	}
>>>>  
>>>>  	/*
>>>>  	 * Disallow crazy address masks that give BIOS leeway to pick
>>>> @@ -596,6 +614,9 @@ static const char * const einj_error_type_string[] = {
>>>>  	"0x00000200\tPlatform Correctable\n",
>>>>  	"0x00000400\tPlatform Uncorrectable non-fatal\n",
>>>>  	"0x00000800\tPlatform Uncorrectable fatal\n",
>>>> +};
>>>> +
>>>> +static const char * const einj_cxl_error_type_string[] = {
>>>>  	"0x00001000\tCXL.cache Protocol Correctable\n",
>>>>  	"0x00002000\tCXL.cache Protocol Uncorrectable non-fatal\n",
>>>>  	"0x00004000\tCXL.cache Protocol Uncorrectable fatal\n",
>>>> @@ -621,29 +642,44 @@ static int available_error_type_show(struct seq_file *m, void *v)
>>>>  
>>>>  DEFINE_SHOW_ATTRIBUTE(available_error_type);
>>>>  
>>>> -static int error_type_get(void *data, u64 *val)
>>>> +int einj_cxl_available_error_type_show(struct seq_file *m, void *v)
>>>>  {
>>>> -	*val = error_type;
>>>> +	int cxl_err, rc;
>>>> +	u32 available_error_type = 0;
>>>> +
>>>> +	if (!einj_initialized)
>>>> +		return -ENXIO;
>>>> +
>>>> +	rc = einj_get_available_error_type(&available_error_type);
>>>> +	if (rc)
>>>> +		return rc;
>>>> +
>>>> +	for (int pos = 0; pos < ARRAY_SIZE(einj_cxl_error_type_string); pos++) {
>>>> +		cxl_err = ACPI_EINJ_CXL_CACHE_CORRECTABLE << pos;
>>>> +
>>>> +		if (available_error_type & cxl_err)
>>>> +			seq_puts(m, einj_cxl_error_type_string[pos]);
>>>> +	}
>>>>  
>>>>  	return 0;
>>>>  }
>>>> +EXPORT_SYMBOL_NS_GPL(einj_cxl_available_error_type_show, CXL);
>>>>  
>>>> -static int error_type_set(void *data, u64 val)
>>>> +static int validate_error_type(u64 type)
>>>>  {
>>>> +	u32 tval, vendor, available_error_type = 0;
>>>>  	int rc;
>>>> -	u32 available_error_type = 0;
>>>> -	u32 tval, vendor;
>>>>  
>>>>  	/* Only low 32 bits for error type are valid */
>>>> -	if (val & GENMASK_ULL(63, 32))
>>>> +	if (type & GENMASK_ULL(63, 32))
>>>>  		return -EINVAL;
>>>>  
>>>>  	/*
>>>>  	 * Vendor defined types have 0x80000000 bit set, and
>>>>  	 * are not enumerated by ACPI_EINJ_GET_ERROR_TYPE
>>>>  	 */
>>>> -	vendor = val & ACPI5_VENDOR_BIT;
>>>> -	tval = val & 0x7fffffff;
>>>> +	vendor = type & ACPI5_VENDOR_BIT;
>>>> +	tval = type & 0x7fffffff;
>>>>  
>>>>  	/* Only one error type can be specified */
>>>>  	if (tval & (tval - 1))
>>>> @@ -652,9 +688,105 @@ static int error_type_set(void *data, u64 val)
>>>>  		rc = einj_get_available_error_type(&available_error_type);
>>>>  		if (rc)
>>>>  			return rc;
>>>> -		if (!(val & available_error_type))
>>>> +		if (!(type & available_error_type))
>>>>  			return -EINVAL;
>>>>  	}
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +static int cxl_dport_get_sbdf(struct pci_dev *dport_dev, u64 *sbdf)
>>>> +{
>>>> +	struct pci_bus *pbus;
>>>> +	struct pci_host_bridge *bridge;
>>>> +	u64 seg = 0, bus;
>>>> +
>>>> +	pbus = dport_dev->bus;
>>>> +	bridge = pci_find_host_bridge(pbus);
>>>> +
>>>> +	if (!bridge)
>>>> +		return -ENODEV;
>>>> +
>>>> +	if (bridge->domain_nr != PCI_DOMAIN_NR_NOT_SET)
>>>> +		seg = bridge->domain_nr << 24;
>>>> +
>>>> +	bus = pbus->number << 16;
>>>> +	*sbdf = seg | bus | dport_dev->devfn;
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +int einj_cxl_inject_rch_error(u64 rcrb, u64 type)
>>>> +{
>>>> +	u64 param1 = 0, param2 = 0, param4 = 0;
>>>> +	u32 flags;
>>>> +	int rc;
>>>> +
>>>> +	if (!einj_initialized)
>>>> +		return -ENXIO;
>>>> +
>>>> +	/* Only CXL error types can be specified */
>>>> +	if (type & ~CXL_ERROR_MASK || (type & ACPI5_VENDOR_BIT))
>>>> +		return -EINVAL;
>>>> +
>>>> +	rc = validate_error_type(type);
>>>> +	if (rc)
>>>> +		return rc;
>>>> +
>>>> +	param1 = (u64) rcrb;
>>>> +	param2 = 0xfffffffffffff000;
>>>> +	flags = 0x2;
>>>> +
>>>> +	return einj_error_inject(type, flags, param1, param2, 0, param4);
>>>> +}
>>>> +EXPORT_SYMBOL_NS_GPL(einj_cxl_inject_rch_error, CXL);
>>>> +
>>>> +int einj_cxl_inject_error(struct pci_dev *dport, u64 type)
>>>> +{
>>>> +	u64 param1 = 0, param2 = 0, param4 = 0;
>>>> +	u32 flags;
>>>> +	int rc;
>>>> +
>>>> +	if (!einj_initialized)
>>>> +		return -ENXIO;
>>>> +
>>>> +	/* Only CXL error types can be specified */
>>>> +	if (type & ~CXL_ERROR_MASK || (type & ACPI5_VENDOR_BIT))
>>>> +		return -EINVAL;
>>>> +
>>>> +	rc = validate_error_type(type);
>>>> +	if (rc)
>>>> +		return rc;
>>>> +
>>>> +	rc = cxl_dport_get_sbdf(dport, &param4);
>>>> +	if (rc)
>>>> +		return rc;
>>>> +
>>>> +	flags = 0x4;
>>>> +
>>>> +	return einj_error_inject(type, flags, param1, param2, 0, param4);
>>>> +}
>>>> +EXPORT_SYMBOL_NS_GPL(einj_cxl_inject_error, CXL);
>>>> +
>>>> +static int error_type_get(void *data, u64 *val)
>>>> +{
>>>> +	*val = error_type;
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +static int error_type_set(void *data, u64 val)
>>>> +{
>>>> +	int rc;
>>>> +
>>>> +	/* CXL error types have to be injected from cxl debugfs */
>>>> +	if (val & CXL_ERROR_MASK && !(val & ACPI5_VENDOR_BIT))
>>>> +		return -EINVAL;
>>>> +
>>>> +	rc = validate_error_type(val);
>>>> +	if (rc)
>>>> +		return rc;
>>>> +
>>>>  	error_type = val;
>>>>  
>>>>  	return 0;
>>>> @@ -690,6 +822,12 @@ static int einj_check_table(struct acpi_table_einj *einj_tab)
>>>>  	return 0;
>>>>  }
>>>>  
>>>> +bool einj_is_initialized(void)
>>>> +{
>>>> +	return einj_initialized;
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(einj_is_initialized);
>>>> +
>>>>  static int __init einj_probe(struct platform_device *pdev)
>>>>  {
>>>>  	int rc;
>>>> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
>>>> index 8c00fd6be730..c52c92222be5 100644
>>>> --- a/drivers/cxl/core/port.c
>>>> +++ b/drivers/cxl/core/port.c
>>>> @@ -3,6 +3,7 @@
>>>>  #include <linux/platform_device.h>
>>>>  #include <linux/memregion.h>
>>>>  #include <linux/workqueue.h>
>>>> +#include <linux/einj-cxl.h>
>>>>  #include <linux/debugfs.h>
>>>>  #include <linux/device.h>
>>>>  #include <linux/module.h>
>>>> @@ -797,6 +798,37 @@ static int cxl_dport_setup_regs(struct device *host, struct cxl_dport *dport,
>>>>  	return rc;
>>>>  }
>>>>  
>>>> +DEFINE_SHOW_ATTRIBUTE(einj_cxl_available_error_type);
>>>> +
>>>> +static int cxl_einj_inject(void *data, u64 type)
>>>> +{
>>>> +	struct cxl_dport *dport = data;
>>>> +
>>>> +	if (dport->rch)
>>>> +		return einj_cxl_inject_rch_error(dport->rcrb.base, type);
>>>> +
>>>> +	return einj_cxl_inject_error(to_pci_dev(dport->dport_dev), type);
>>>> +}
>>>> +DEFINE_DEBUGFS_ATTRIBUTE(cxl_einj_inject_fops, NULL, cxl_einj_inject, "%llx\n");
>>>> +
>>>> +static void cxl_debugfs_create_dport_dir(struct cxl_dport *dport)
>>>> +{
>>>> +	struct dentry *dir;
>>>> +
>>>> +	/*
>>>> +	 * dport_dev needs to be a PCIe port for CXL 2.0+ ports because
>>>> +	 * EINJ expects a dport SBDF to be specified for 2.0 error injection.
>>>> +	 */
>>>> +	if (!einj_is_initialized() ||
>>>> +	    (!dport->rch && !dev_is_pci(dport->dport_dev)))
>>>> +		return;
>>>> +
>>>> +	dir = cxl_debugfs_create_dir(dev_name(dport->dport_dev));
>>>> +
>>>> +	debugfs_create_file("einj_inject", 0200, dir, dport,
>>>> +			    &cxl_einj_inject_fops);
>>>> +}
>>>> +
>>>>  static struct cxl_port *__devm_cxl_add_port(struct device *host,
>>>>  					    struct device *uport_dev,
>>>>  					    resource_size_t component_reg_phys,
>>>> @@ -1144,6 +1176,8 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
>>>>  	if (dev_is_pci(dport_dev))
>>>>  		dport->link_latency = cxl_pci_get_latency(to_pci_dev(dport_dev));
>>>>  
>>>> +	cxl_debugfs_create_dport_dir(dport);
>>>> +
>>>>  	return dport;
>>>>  }
>>>>  
>>>> @@ -2220,6 +2254,11 @@ static __init int cxl_core_init(void)
>>>>  
>>>>  	cxl_debugfs = debugfs_create_dir("cxl", NULL);
>>>>  
>>>> +	if (einj_is_initialized()) {
>>>> +		debugfs_create_file("einj_types", 0400, cxl_debugfs, NULL,
>>>> +				    &einj_cxl_available_error_type_fops);
>>>> +	}
>>>> +
>>>>  	cxl_mbox_init();
>>>>  
>>>>  	rc = cxl_memdev_init();
>>>> diff --git a/include/linux/einj-cxl.h b/include/linux/einj-cxl.h
>>>> new file mode 100644
>>>> index 000000000000..af57cc8580a6
>>>> --- /dev/null
>>>> +++ b/include/linux/einj-cxl.h
>>>> @@ -0,0 +1,45 @@
>>>> +/* SPDX-License-Identifier: GPL-2.0-or-later */
>>>> +/*
>>>> + * CXL protocol Error INJection support.
>>>> + *
>>>> + * Copyright (c) 2023 Advanced Micro Devices, Inc.
>>>> + * All Rights Reserved.
>>>> + *
>>>> + * Author: Ben Cheatham <benjamin.cheatham@amd.com>
>>>> + */
>>>> +#ifndef CXL_EINJ_H
>>>> +#define CXL_EINJ_H
>>>> +
>>>> +#include <linux/pci.h>
>>>> +
>>>> +#if IS_ENABLED(CONFIG_ACPI_APEI_EINJ)
>>>
>>> I was testing some other work using this kernel and was getting a linker error
>>> when I had CXL_BUS set to 'y' and ACPI_APEI_EINJ set to 'm'. I went ahead and
>>> solved it by changing the line above to use IS_REACHABLE() instead. The change
>>> shouldn't actually affect the functionality of the patch since this is in a build
>>> configuration where the CXL driver isn't using the EINJ module since CONFIG_CXL_EINJ
>>> is set to n due to Kconfig restraints.
>>>
>>> I can submit another version of this series with this fix, but I don't think it
>>> makes much sense for a 1 line change, so I've but a diff below with the change
>>> for whoever ends up putting this in their tree:
>>
>> I don't think this is the right fix. CONFIG_CXL_EINJ should be disabled when
>> CONFIG_CXL_BUS is built-in. Looks like the polarity the dependency is
>> backwards. The problem with IS_REACHABLE() is it removes the simple
>> debug option of "send me your .config" to see why some functionality is
>> not turned on.
>>
>> Could you test out flipping the dependency from:
>>
>>     depends on ACPI_APEI_EINJ >= CXL_BUS
>>
>> ...to:
>>
>>     depends on ACPI_APEI_EINJ <= CXL_BUS
> 
> Wait, no y == 2 and m == 1, so:
> 
> depends on ACPI_APEI_EINJ >= CXL_BUS
> 
> ...is correct, but you need IS_ENABLED(CONFIG_CXL_EINJ), not
> IS_REACHABLE to guard those exports.

Ok, I'll test it out today and let you know if it works.

Thanks,
Ben

