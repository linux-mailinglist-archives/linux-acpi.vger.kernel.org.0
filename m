Return-Path: <linux-acpi+bounces-18065-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1E06BF973F
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Oct 2025 02:29:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6400018C6D19
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Oct 2025 00:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83AC918FC97;
	Wed, 22 Oct 2025 00:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dupHr21s"
X-Original-To: linux-acpi@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012049.outbound.protection.outlook.com [52.101.43.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9FDF7262A;
	Wed, 22 Oct 2025 00:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761092948; cv=fail; b=Tx7kD6fkqxLmuGt7EouWh7U3pJAit6qj7O23N7VbQEFjZLtQqw+CS4SK+19G5vOphBQJnBCPIA18k3zv9VWGmcyUxspFockss6uGikbyHmv0HaQcNqVimabhYP6SROIGbnmNDhuHzukAVkG0q4wxBjXQq63b98966/MMT9uQ7Ac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761092948; c=relaxed/simple;
	bh=6cG6AbHNJqtV4xb3Ih4lKHJlRbCVehd3H/AhAIhfrZM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oLjBVYR8mlU0rxCK8Cmqk6yvTISgUYwpqOrowDEiUDbDogMT7Jfnr5hT1U4KVQ8RJjPM0UKTmCfJKgMxuDaSYlclxMcprZGUToOmhz5Surtp0M0FuJiBtgGWr9J6GibEnz5mFW/yI9YW3u9EWF+6sJzlryY1bSh0OmERGR0wf6k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dupHr21s; arc=fail smtp.client-ip=52.101.43.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KhGJOFyVy0ERVRl4OqgOptH5UfB3e4xZZllE9jqtdY0vTiUeGDi+K9+vfqzDArnYmISXhVfn5C5Ngof42JipXFbet3Sc3epR1a799GznyEsagXDbbAvH3BxNEwgF5tweUcWxLVokMvgbFyT57XbTG7Q73VKYnymQ2srgO31IZsigieu1hHYtvlvGgcH0aXeS+jhwlwZ7cVP6pKQawKQsdGxAwRBau2xun0tc3N99r1XQ246mwqWJg2PM4GEgaHQNLu6/nM9v9HCC38RLQdtmB656mbvlsnDvp3D9FDkxEj5bBppV15L2OCBSnTXXTDLEcE0u3/kS828a2GC1rnLTlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m7CFn3JgqNpTb9fH7UBGqn2RGEy2Qw1SF2jltO5f1x4=;
 b=OrJWvQLuajMSfYmg6a0ciDG7OUqK6vXG3VLi7bjN+hFTAs2n0R4XSoP0Ufa5DkJKbB85ttxF16smZ5mTRB817jk4P8gwcvT72H5Ya/cSWSM8vlTweZ0THn25UY/NmrchsITU8RixYF9q7kXgdiQSaleT0Y54aUN5i0MueAyicOYZQY8wLNc+NjH2qHMwGjjNRJMBWHkZfjXOpmPsyYaQLXRVteL/ynWQTPT8If6MUGDP2xqjRTbVfebY7dD5R6QPzI+2Tl/hu3A2RvzGNx2e/6L2bWDVjipkuHjHoXMPWqO+XgbGpTMpV3KkKi04+kKJwlzbFv4ESwCdtDBCuOPcfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m7CFn3JgqNpTb9fH7UBGqn2RGEy2Qw1SF2jltO5f1x4=;
 b=dupHr21swUnvvNZPWThbaQL0x8ojvsY/132+IEhGpGxUFZ7Q6aPcuG6k00OoxlYeaHlWXFqfpKUmxTziuOqAp9KlK0DYmhXFcEGs+Tyid+kaqJQ9nVMaEwEuQhmS6psA41EDBmQOn9+dBuTM9D16rK09az6zBcwllRfEuP7/dE7IUdH56kttp4IinAFRFmKjwkARMr0YERrvNohqV2kNYiX9EZ+5ON5YdaCz5Ww+9kTDWCpbSAPPIYiOy86+3VnDKJF85ttgJUsbLa2O131sSxFe2gfeicEhi15A21uqV+tmv3pgaLCWXI7dgoJgemvJKlll5JH8n6iF68OOLYWLgw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB2667.namprd12.prod.outlook.com (2603:10b6:5:42::28) by
 SJ0PR12MB5609.namprd12.prod.outlook.com (2603:10b6:a03:42c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.17; Wed, 22 Oct
 2025 00:29:04 +0000
Received: from DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2]) by DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2%6]) with mapi id 15.20.9228.016; Wed, 22 Oct 2025
 00:29:03 +0000
Message-ID: <fa5187f0-293e-48f0-ab75-6641e284e8b4@nvidia.com>
Date: Tue, 21 Oct 2025 17:29:00 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/29] arm_mpam: Add probe/remove for mpam msc driver
 and kbuild boiler plate
To: James Morse <james.morse@arm.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org
Cc: D Scott Phillips OS <scott@os.amperecomputing.com>,
 carl@os.amperecomputing.com, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, amitsinght@marvell.com,
 David Hildenbrand <david@redhat.com>, Dave Martin <dave.martin@arm.com>,
 Koba Ko <kobak@nvidia.com>, Shanker Donthineni <sdonthineni@nvidia.com>,
 baisheng.gao@unisoc.com, Jonathan Cameron <jonathan.cameron@huawei.com>,
 Rob Herring <robh@kernel.org>, Rohit Mathew <rohit.mathew@arm.com>,
 Rafael Wysocki <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Hanjun Guo
 <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Danilo Krummrich <dakr@kernel.org>, Jeremy Linton <jeremy.linton@arm.com>,
 Gavin Shan <gshan@redhat.com>
References: <20251017185645.26604-1-james.morse@arm.com>
 <20251017185645.26604-8-james.morse@arm.com>
Content-Language: en-US
From: Fenghua Yu <fenghuay@nvidia.com>
In-Reply-To: <20251017185645.26604-8-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR08CA0027.namprd08.prod.outlook.com
 (2603:10b6:a03:100::40) To DM6PR12MB2667.namprd12.prod.outlook.com
 (2603:10b6:5:42::28)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2667:EE_|SJ0PR12MB5609:EE_
X-MS-Office365-Filtering-Correlation-Id: 59e62d2a-b6ca-462a-afa2-08de11020083
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?empId20xSXBCZGFCci9MUkR2U3pReWI4YUFJNTEyR1BFcjVzWmhtQno3TmhY?=
 =?utf-8?B?VUg2TjlBdVhYMklSYVB3elRoaEtTM1h5eTF6aU5PZHB1aC91VTFnSERQV2RI?=
 =?utf-8?B?UkdVL0kwR2pXd3E0SHVzM09wc2w0MHQzVEhXUEdOWmZ3OXJXcHB2SUJUeXpM?=
 =?utf-8?B?OEZKMjl3T2FsY0JpOGRUa2lTVVNldG8xSHVvcXlJajZXanJmb2QrazBpUG5i?=
 =?utf-8?B?L1pwNDh3RXREblpkcFJpejJUZnUxc3c2U2padjdJTWg5YmY4ZG92OTZSMGM2?=
 =?utf-8?B?UDNicU1ackxXRWs3Zzg1NEc5VHowMmFjRUdkRXBicGlOVTVUWTlxS3ArS2Nw?=
 =?utf-8?B?ajlVUmx2dW41RzRGUkNHaStBSG5wNVd5NERmR3RoWmFVWDV1d3dSM1QrKzVs?=
 =?utf-8?B?ZGZmWGVpMVdoZmJGUFVwNWplYjI0S3Rmb1M4YmNRNzFpMVBWa0JnMy9PdlJr?=
 =?utf-8?B?WW02YlIyYTN5ck1PZEFjT0JRdW82THB3NzZrclpRSzNZbEdtMlI0VUhlSm1S?=
 =?utf-8?B?Nkx2YVo2MmJaaVZLRDVLMnFyR2YxMk8wMy9Xb0E0VHNKSWEvYWU3cGJmRjdv?=
 =?utf-8?B?YTNTcllaV2NOSFVvb2tBa1FySkkrS0t4RXZaQ0lCQWgzd3JNVEhxc0R0OFE0?=
 =?utf-8?B?S3dPbU8yd091a3ZrQlpkQzFxZTdwODNKbnJKYStERUhsdXhmV3MrbkJTQW1p?=
 =?utf-8?B?Tkg1Vm5ubGpnK2NBbkVkZ0txNkMvSlAveUF4MTBqRXVNdm42T0w0QWFDMEtj?=
 =?utf-8?B?UTA2ODI5ZVVFTmMrLytrbzVITWU3d2xsU3pHTTRFSVlKTkJyb2VtOHNKOXZr?=
 =?utf-8?B?TFppckl0cHA5RjV5MHBQNDIyQTFqU2twZytaQkVNMi9xZWRDbkJEZndENm0z?=
 =?utf-8?B?cVFPaC9ORm8vNEtuV3Y4TG1CM1hOd3RQUTRCVWgzbWJ4QzlzdmVaaGdFWTJ2?=
 =?utf-8?B?WHoyeUFma2N1Z3B2ZDlNRzZvZFBiamFCZWYrcHMzbGR6VUtoY1NESEJybFlQ?=
 =?utf-8?B?YU8wY2QvSjZON1dsNlkycDMrSlh6RStUdk52UHdtSUVTSWVORDFZU1N6MHp6?=
 =?utf-8?B?YkJDTU8vdnRvd2x4MkY2R3d2ZkxHeS9pQmxDdUFHZGgrdW5KR0VDV01nc0JK?=
 =?utf-8?B?QlA2RUlTTDcxeWR4ZFdoaUFEZ1hva0NOcmJwZHZDL2JwSnBESDBhdXkwTGxj?=
 =?utf-8?B?SjI2UVNBMmRzbnZZN0h5c0ZiZS9tMDFpcmJDamN6UzM5cE1zQTlYR2V5Mm1E?=
 =?utf-8?B?NC9BUEZQSTM2VW8xc25rNHNydE0xM0NFMzhncTFxbTUwbWNzSE1IOURLUkND?=
 =?utf-8?B?SG94Z3hISFJXWUNjTndnOVczY1VDb3JmT3VYV2IvOTJzVXdFZUhBeXkvUXpP?=
 =?utf-8?B?cE9ROVp3YVRpcWx5akdYR2ZzMmNOcVdQM1ZPcHFBcWhQTUFycUtyTzNpN05u?=
 =?utf-8?B?WUMwTFU0MG1oVmttaldvNjBHNUhUQTJKaFZ3bXArSzdMRkpZS25ONnN3Ny9i?=
 =?utf-8?B?YzB2bHFRUTA0NXN5WXhkdXpya3RLWEErTUFrTVJXdUpGR3FwRjlvZSs1RDhC?=
 =?utf-8?B?SmJwZVEzRGZQUFZ2M2ZxZk9rNmp6ZDlvNHVIY0EvbGk4bisyeS80OEJBZS9N?=
 =?utf-8?B?MzlxM21kaFRRalhZRnRmZVdWZktkTnNIS3JwRStQL1BPSFA2Ujd5enVTYjNr?=
 =?utf-8?B?OFlmMHRaY0E5RDdZUy9BUVdUZWdkZlFxMXVkbmJSWEtodFMvbC84T09sTmxh?=
 =?utf-8?B?Sk1pcUVta1g1a0dFSkR1SU5FQnZvRDlLdjM3Ykp5ODdvQXN1N29tTEQvRHVB?=
 =?utf-8?B?Z3dYMDBLUnZDQUtCang2WGFWbzU3Q0JNTmJlcUlFNkV1Z3hzR0h4a25vYkF0?=
 =?utf-8?B?QnZ5YW1hTG9YYkFlS3RoSlVhZnRaT0xYRnlmTlpiYzJDTjJKSlRoTktYZVNS?=
 =?utf-8?Q?9JGZixJ6cYHcjWzxuC0+4IvXSz6Ffp1g?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TEFFQ3Fmc3VpTEZmUlE2eURaMHM2M05qQWx0Y0FwNXZ6eEU4VHREcFJpS3BS?=
 =?utf-8?B?TnN0NFZLM2pXRTVwMk9KY3QxVDRIVjNDbUN5ak9tanlHZU02YnVkckJmRUZD?=
 =?utf-8?B?SU5rak0xZnZZODl1QUtEQjhHTlhGWDdBYUNhYnJkZjhmMklscWFkNTNXUVl6?=
 =?utf-8?B?OWNNblRjMW9SbFRoSkJiZmx6M3dXQ1I0YTlOVWNyQ1hCT0RkdXROMzdGNnBv?=
 =?utf-8?B?MkNabXVlcVNucStMbzQ2U1JEeEdZYmNhQzBzbWRmRTJqWDd0ZjBobUVhdVg0?=
 =?utf-8?B?Wko0dnk3TGV6ZC9GRkhSdDV0bEp4UFVmV2s0N3NxWTlUMzJVOEp4N2RYNGQw?=
 =?utf-8?B?ZE91djJHM3pTZk85Yy84WUZ6WlA3QVIreU5nRzZIMnJaL05tV0Z6S0x5M0Rv?=
 =?utf-8?B?eW5BR2JXVndaNkJKT0tKYzFaOVVSMG1wZXFKZFhmMnczc2FkLzR4Ui9RZ21G?=
 =?utf-8?B?YmhIdXlCcng4T292UHVmdW1JZHpmYmJNNDNscmlFbVNWdGY4WXVvKzVJcU1u?=
 =?utf-8?B?T3cyUUNmRUo5dTRlcmVhMUdsUDJIK2kxbVJzcGU2eVgrcWozcmdOcVBncmRu?=
 =?utf-8?B?RWZUKzgwbFFSTS8yUTQ3djRxallXOWg5RU0rTmJmVWJKUlVocTlrZTg1bGlI?=
 =?utf-8?B?NWRBMDVVVUFEWU5KbWcxT2R5dWwrNy9VRTJFVGlnQlp4THFFVnZQZEdLaFBj?=
 =?utf-8?B?YWJvdE8xLzAwenpwTGdML0lmMWhSQTRqaWJ1NXorK2ZYcC9DV0NCUS9IVTYy?=
 =?utf-8?B?aW1QdjdrbGNvajRyby9Tcnc2ZUVXRVdvUlkyMUFEQnBIM2FqcUdrRlFlbzBH?=
 =?utf-8?B?TVRvbjVidnlUUUJQRUtIRTNIY3NjQ3h4VTdVa2hPbURCZ1ZIUzNLaUkzMWZT?=
 =?utf-8?B?VW5kaVQ3ZERVODhNVnJJd1lHUmpHelREMEt3V3liVlRJUVVRNXRMNnlNbFIr?=
 =?utf-8?B?RW1pVWpxem9NYXZnRmdBWHV2SWYwZStWL3Y1a0VkYWNjQy9YaVZxTFdKYVdq?=
 =?utf-8?B?ZHAwKytqWjVtM3FnYjVFS2pqdzR2alBjV01SR1l0ZmRtQjZ2RDUyajMyQkpt?=
 =?utf-8?B?c1dueFVqNks4ZjNIaFJuQ0Jpa1MrYjNJdTVYblpBUnRJQWY2OTFMVzVvUWRr?=
 =?utf-8?B?THlUeTlrcGtFb1FlVkdRcCtKOVBqM1ZQTEtnSjAyQTdESFJGd1o4SUxlVElI?=
 =?utf-8?B?M2hrd2dXNEo0NkxYMVJuK0VGblVwcHd3VVJlNjJsaEw5ZjRnNlVCM21tcUZo?=
 =?utf-8?B?b2dBNUp3QTYwQ1lPUHR0a1VkSStLSVhLVzhGRHA0Y3JBWG52YmtIZmxacUho?=
 =?utf-8?B?TG9aeE1RdkwvTC90SktGcWtFWmM4T1VNUStkeHU2d0U3UCt5STRobkZZYSs4?=
 =?utf-8?B?SUZsNmI5RXFQRGhiMHNSMTUzb1V2cnJxSGFhajhiWk9jTHFCZ1luQUdBSmFF?=
 =?utf-8?B?U2QrVmhpa2c1cDVNY0JMRlZiUUQwZXdjaDRPY0cvcTh1MTBmTUdqSU0zWmd4?=
 =?utf-8?B?d3Uvc2M3Nnd6UjFpVFo2am1mZmNCTmRIMGxOdVJZRWlUcXJCR3kzcjlGQjFN?=
 =?utf-8?B?NFB6UWxjZHMrbXYxU3F3YnBxZWkra3c5RDYzTE5NZCt6NTlnWisycDJ2Sjh5?=
 =?utf-8?B?b0p2ZHNWMDhZTlpNV2hZNzJpeG4rQ2c3a0hsZFJhU1VvdDJQa25zNHhKQnlp?=
 =?utf-8?B?T3NCUXNMUTBQOFluNjY2OHF4MzFJM3ZKU2F2ai8xVkNvVTh5Z0F5NlVIWEl2?=
 =?utf-8?B?ZmZqaEh5STVQRUtGS3FzV2dzY3M2d2NETGU3VDdNemlSTDFBbHdCaEJsS3RK?=
 =?utf-8?B?Qk83c3BNbjM4KzJvL1B4RjFaMGhHY2ZhdWRXS0VoL3JMVzBHYnBPUUhJNnVv?=
 =?utf-8?B?NjNDVFJXQ2xmMjBtTDlCOVZrTUE1MnJMdWp1cFlDbFgveTJQMXZMWCtINElQ?=
 =?utf-8?B?V3ZLdEMxd0xhaFRUVmpMcklvYkliQkt5YjZJNVBQWEkxaWpPUC8wUE56RG5s?=
 =?utf-8?B?MDN0UVZwaGx5dHlqcWVqT1lPZ1ZaaW45c0RxTlNFWHYyejliWmVuZzMxelpr?=
 =?utf-8?B?N2FCS3ZNN0ZqYjJGZ1RDaFJiQ1lwMnAzV0NwK3h0UEQzY081MWlkMytTNysr?=
 =?utf-8?Q?Sk939QvEiS24p8gR2YIVuGJyc?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59e62d2a-b6ca-462a-afa2-08de11020083
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 00:29:03.4597
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: udAVV6Y7bAZZFAq97UBnP26vSkK4nfijVDdEvLbw/kEQ58XTBIlTi9QXfFy7wok1bj/hJkefOKJPjnJqCoYGqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5609

Hi, James,

On 10/17/25 11:56, James Morse wrote:
> Probing MPAM is convoluted. MSCs that are integrated with a CPU may
> only be accessible from those CPUs, and they may not be online.
> Touching the hardware early is pointless as MPAM can't be used until
> the system-wide common values for num_partid and num_pmg have been
> discovered.
> 
> Start with driver probe/remove and mapping the MSC.
> 
> CC: Carl Worth <carl@os.amperecomputing.com>
> Tested-by: Fenghua Yu <fenghuay@nvidia.com>
> Signed-off-by: James Morse <james.morse@arm.com>
[SNIP]> +/*
> + * An MSC can control traffic from a set of CPUs, but may only be accessible
> + * from a (hopefully wider) set of CPUs. The common reason for this is power
> + * management. If all the CPUs in a cluster are in PSCI:CPU_SUSPEND, the
> + * corresponding cache may also be powered off. By making accesses from
> + * one of those CPUs, we ensure this isn't the case.
> + */
> +static int update_msc_accessibility(struct mpam_msc *msc)
> +{
> +	u32 affinity_id;
> +	int err;
> +
> +	err = device_property_read_u32(&msc->pdev->dev, "cpu_affinity",
> +				       &affinity_id);
> +	if (err)
> +		cpumask_copy(&msc->accessibility, cpu_possible_mask);
> +	else
> +		acpi_pptt_get_cpus_from_container(affinity_id,
> +						  &msc->accessibility);
> +	return err;

The error is handled and there is no need to return the error to caller.
Returning the error causes probe failure and the mpam_msc driver cannot 
be installed.

s/return err;/return 0;/

> +}
> +
> +static int fw_num_msc;
> +
> +static void mpam_msc_destroy(struct mpam_msc *msc)
> +{
> +	struct platform_device *pdev = msc->pdev;
> +
> +	lockdep_assert_held(&mpam_list_lock);
> +
> +	list_del_rcu(&msc->all_msc_list);
> +	platform_set_drvdata(pdev, NULL);
> +}
> +
> +static void mpam_msc_drv_remove(struct platform_device *pdev)
> +{
> +	struct mpam_msc *msc = platform_get_drvdata(pdev);
> +
> +	if (!msc)
> +		return;
> +
> +	mutex_lock(&mpam_list_lock);
> +	mpam_msc_destroy(msc);
> +	mutex_unlock(&mpam_list_lock);
> +
> +	synchronize_srcu(&mpam_srcu);
> +}
> +
> +static struct mpam_msc *do_mpam_msc_drv_probe(struct platform_device *pdev)
> +{
> +	int err;
> +	u32 tmp;
> +	struct mpam_msc *msc;
> +	struct resource *msc_res;
> +	struct device *dev = &pdev->dev;
> +
> +	lockdep_assert_held(&mpam_list_lock);
> +
> +	msc = devm_kzalloc(&pdev->dev, sizeof(*msc), GFP_KERNEL);
> +	if (!msc)
> +		return ERR_PTR(-ENOMEM);
> +
> +	mutex_init(&msc->probe_lock);
> +	mutex_init(&msc->part_sel_lock);
> +	msc->id = pdev->id;
> +	msc->pdev = pdev;
> +	INIT_LIST_HEAD_RCU(&msc->all_msc_list);
> +	INIT_LIST_HEAD_RCU(&msc->ris);
> +
> +	err = update_msc_accessibility(msc);
> +	if (err)
> +		return ERR_PTR(err);

The returned error causes probe failure and the driver cannot be 
installed. Return 0 will make the probe succeed.

There is no probe failure in mpam/snapshot/v6.18-rc1 because its 
returned err=0.

[SNIP]

Thanks.

-Fenghua


