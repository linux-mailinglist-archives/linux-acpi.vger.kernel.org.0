Return-Path: <linux-acpi+bounces-21523-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OLY0G3VLrmnjBwIAu9opvQ
	(envelope-from <linux-acpi+bounces-21523-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Mon, 09 Mar 2026 05:24:21 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BA38B233A9E
	for <lists+linux-acpi@lfdr.de>; Mon, 09 Mar 2026 05:24:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9EBDA30151CE
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Mar 2026 04:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DACA6271A71;
	Mon,  9 Mar 2026 04:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PVq4zrG7"
X-Original-To: linux-acpi@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011023.outbound.protection.outlook.com [52.101.52.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503357FBAC
	for <linux-acpi@vger.kernel.org>; Mon,  9 Mar 2026 04:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773030257; cv=fail; b=gO81/+nrXJk8yc1KoRjnniYZKoAynFUvvjihJwtN/DQYcvO0fo8wMbZCmE4d3Pltf4za9xqagOOSWVNKoWiAO0WGrEIEx5IIFKAhZINPux9mq7e6q6SFp25DgcZUJnfHD6tUl3hMhDUQOKJnoHgfluxCna41FBnzexOeE7fn7TI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773030257; c=relaxed/simple;
	bh=ktv52ylbfaWkmv9ldI1kFjXpBVg9HCF7wy9/dwm4rQc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nHqAacYkF+bYWV9EWCGfeVccUuqL2pLNpKYtlmY22hg+ktCnUYiw+B8rtTki/4grDoYwyrtmL2zs/ungitQxCN2oyNZpGwrAnI24x3sfn62y2ahYXFM0D3XULhhAJoHLqyMPbXo/kufXqpPhYMrjRlWa5Gm8QAplUTZlrK9cF9Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PVq4zrG7; arc=fail smtp.client-ip=52.101.52.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hFPurROT1mEk6UPiEyIfklBEy9OShi+mBeOFWBhE8dtgh31bZFqSGksOuCXWy4e0KRGkmdlZfkyQBYDjTwy9H3H5m8hYL2qCe0tvC1bmxOjBcgKk6BEJH8AsCdpTd2BPd+A3S24DCR62w4YCWUzhn29p5hUjG/F/9u3tqgkyUlhYD8HiamjqvQ4DbJmPvYF1e6bF7RhvnS6TNz6m+gkuMFZEYmzsglk4gnTxGlmWsTRCCpf3qVoU4G64vy8yFS3pb1ORF8dmVo+fsCntlPcKFR2gNvRbZq/n6agIEimJSdPmld+2pV3qXSNkbmxGahagdNujGiJ0b9ib5IoW/PRiAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wsggi9UpTMGDoJOXPX855Hjw9FNlwAUyizOY7hALuaQ=;
 b=FeDwictDeNh7OsQgSDqwWyVKlXSfIIZlIPUO05/rngiLAvnzVzT3okaY9rzUXtRlkBp1IXgN6aByhdERq9y95QIK3eGrzZoV8nwKaTSMHH6AXE+1ERmfPGHu7BxU0R1QvsztQ0gZ77hGPFFbLNRdJOhDNW5tsR23rgvu98mGJl+p0+maN0yp4LUMknqcKC8jZ/CSvnUQe95eap9T1cO/fUcTXlibffhqYgp5iBDqkoiuYalNDwMaIgbDXC7D+0j5kJJxb5rEEZBTGYFkVjdg1ZCm9m2EKZfyPT7rdFSnPqAR/c5YhgG09ssWODsSTcnQFSX7qUbBo1z9uc2OtXo9rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wsggi9UpTMGDoJOXPX855Hjw9FNlwAUyizOY7hALuaQ=;
 b=PVq4zrG7w53gb5nmUguqPvhgGCQUyIMacK2DMaPOcS7F7UIGXqcI3xRWeiA5wYT9k2psSPsX15CLeUsQmzNvD5wMCjIZuFl2xlBt+b9af3nWWoX6X7WcJUPlPlOvPORcvNX5vyAZVZ6ZVKgPlA0rzp+WdZUX5DtYsS+6Vn98oB4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB9501.namprd12.prod.outlook.com (2603:10b6:8:250::17)
 by MN2PR12MB4093.namprd12.prod.outlook.com (2603:10b6:208:198::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Mon, 9 Mar
 2026 04:24:13 +0000
Received: from DS7PR12MB9501.namprd12.prod.outlook.com
 ([fe80::4564:457c:524b:6b96]) by DS7PR12MB9501.namprd12.prod.outlook.com
 ([fe80::4564:457c:524b:6b96%4]) with mapi id 15.20.9700.009; Mon, 9 Mar 2026
 04:24:13 +0000
Message-ID: <2c8c8740-a74b-4ca6-ae9d-f435339f2bc6@amd.com>
Date: Mon, 9 Mar 2026 00:24:10 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ACPI: video: Don't allow MFD devices to probe
Content-Language: en-GB
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 "Mario Limonciello (AMD)" <superm1@kernel.org>
Cc: mario.limonciello@amd.com, W_Armin@gmx.de, rafael.j.wysocki@intel.com,
 linux-acpi@vger.kernel.org
References: <20260306025144.604062-1-superm1@kernel.org>
 <CAJZ5v0hVm8Ceut_H74LOU7bHuzWCJERAtQ44q5VT4FY9-BwsNw@mail.gmail.com>
 <CAJZ5v0ihj+DARV3P52LMOn9U+bqwVW=2fQ_QtDsjeVZkR9hFmQ@mail.gmail.com>
 <5975968.DvuYhMxLoT@rafael.j.wysocki>
From: "Nirujogi, Pratap" <pnirujog@amd.com>
In-Reply-To: <5975968.DvuYhMxLoT@rafael.j.wysocki>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0042.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::17) To DS7PR12MB9501.namprd12.prod.outlook.com
 (2603:10b6:8:250::17)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9501:EE_|MN2PR12MB4093:EE_
X-MS-Office365-Filtering-Correlation-Id: ba00e4ad-2671-4837-f7ca-08de7d93b7a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	351LDUviKa/ShT253sXZAoyWUux8DLhGYszMDaw6s9ayn8kvRg05g68hQuPJMQ9PsmSZ2SYG62zxQAsfO5NQmi/V2DIsIXdLcGMrMOMgodwlm9PRcgir13QOrPJ0DDVMRXFdqLWRQGO+xBy0i0jEvwvVDVx2Qgk3+v6mgyMPNkdDwBQHENmAHHOlXUxL9vO3+CgrxohXkmSmXGn2GEGdqRVeeBGDNERHgWsEA4m180bhyVG6YSENZevVNMqscqzTTRjO372jriUm8nIS2ItQHF/1oyCJ8eyv05eM4tS8MEC/Vdux//Je/TZQqCJ4N9zCj2wMwfUoOCbjgNMssi3gM7Z78DU8wBc9Jt2WJsxdl3jXBMAmUtgOcgehkdUoL7L8k+751/MitXmp+LJH666IGUoo4NxMQGv+TXZRpQkUX2z+g1k5rf3nWePMolHr1sHF69LDlcIHeQPZSGsGv4irwkbnt1hzyQ0HmE7kq9/OJFq1Ohx5kXY8aF4u7l1rHTfrLV/Bomabjm4P+aYEgFoxaTnd4exOu5SP6hI0NyHYtPZYv11g63FbcCOoOI/IYoMQhLCHhmWdEFx2yxXKGdL/s1d5cb+lUGPBibjWVFRXRp2jbIyhyorBeyXD5Ui3bGqW+OnDminp24A0uAEqKe+gFa15HxYek2woYbsDc1OnA+pNZ4mODBp0yU0JDRQsDDUXdunzeMV9vR3JS4tIdYdLaQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9501.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OHVNZ0djNkZwU0d0RHp2UEI2c1diNmI0YS9WbzlLdnVqVEtQSVBVeU11eFk0?=
 =?utf-8?B?U01QeWNqS0F3WTBzNnExVUJUeWxNbDVyRG5EaktkOXBWM3NqdFZKZHBtajJk?=
 =?utf-8?B?dU9qWndmNEM2UDY5YlYvUnlXU1pMYkVMcDFFTWU5NW1GSHdodG4vWWlNWWpX?=
 =?utf-8?B?MFF5Rlg4bkxid3EvOUY1YTR3SDczMHA4OG9velpWTFZGVGJzc3NydzZhY21k?=
 =?utf-8?B?MnJXT3FmQjdhKzZuc1BNMmhXTGFSV1JpKzJWR1EwZTZ6bVR1cUJwd2JYQm5p?=
 =?utf-8?B?c1ZkUS9TNGhER01iRTFkODhTS0pMODRGdGZLUlJhTlNpeFJYOXZycTZQbTE2?=
 =?utf-8?B?R0dLa0l4ZmthUktGUUFIUzFXTzNlUEo3VEFSM09rZFVZbGkzSWpHQTRsSEh6?=
 =?utf-8?B?aEpLWklsb3BHODhSTi85aGJQQkxDVlloZ1I4LytadUpKZDUxWGFhcjVQWGhJ?=
 =?utf-8?B?ME03TEJNUXdUU251UXZqUWFSV3lxdmtuMzZtVDlYSVcwVkU4d0JvaVdHMFVC?=
 =?utf-8?B?MVlrUU9OMnZXYit2dG12ZE15V1BVTGlveDRMRXg3R3NnSm5UTThBVHZ0bVJF?=
 =?utf-8?B?QzVWNHRpSUV3UkxsY2JBb2kzSFNIL1FzUWpGZVhhc204L2YwVFVtQVMzWjJX?=
 =?utf-8?B?TU9UMDZvbWlKMzM0YVdBL2ZsbkYyS1lXREp0TTl6eW9DbW9sci9TSlFrcmpM?=
 =?utf-8?B?NXlnb2hTMElYbVM0WTNZczBqZEhkTHpoU3ZnbkczTGs5bjNMbWxGa1RTOTdv?=
 =?utf-8?B?b2JKampKZytFSDAwQmlnamtRV2hhYXVTTHZ2UXkreG9pNFVvQzdGc2REVENn?=
 =?utf-8?B?ZWVmbEtqdXgyeHVxWFdCZ2o5WUl5clc0WkRCWU5rOU56QjdFKzRuOUlHK2hz?=
 =?utf-8?B?K0MzUWEyV0RnU3NZdVZFMHl5dW9BT2lyN2hBVm82a1V4SHN5SUxrMnZrNWZ2?=
 =?utf-8?B?VjVHTHl3UVY1bmkwSDkwWjZnLzVuSGJLalVlczBtNDliclJQRUJDRmtlVlJV?=
 =?utf-8?B?ZDZPaEpGWGgxZXhibjdkRnRxRXY5VEhFd1F1cHZQUUJ6MnEvajczLzI2U09H?=
 =?utf-8?B?OStKbFRkekNyYkhWNTFOcC9DVTBKUkVZUlBSVlphdjBtR3ZIeVhveWpsUmNk?=
 =?utf-8?B?VmE2WkxZcVkrc2hDY1Z1R1loWHM4bUd6ZGlQbVZBNEVMcnFhZ1d3b2t0aWlZ?=
 =?utf-8?B?dElJN0hvVWlia0JYMDN6eWRSVFBZMHdxOEI1US9IWEl2aHBKL0NsVkpXWmtl?=
 =?utf-8?B?R21sSjJHRnZ1akZMd3JnVTU2NWlxcVR6c3hyUFFZTndoWVlBNkxQZmJaVGtD?=
 =?utf-8?B?c1QxL3V2aXhSOCtCaktjZ1FEYUJCNi9YS2N1WTVOaTRpZnIwNzc1VEVRT084?=
 =?utf-8?B?RFF5YUpQTUJZcDlPWkJqK1FiU2UxOEZFNlp6SkRKVzNGMzJLTFIxRTBOcXVN?=
 =?utf-8?B?Nng4WlFGNERHU3EzNEdjcW1XRUl4clR6d0o5UVo5NEM1akRDaVNteDY0dmlz?=
 =?utf-8?B?ZUFoRHZzR0xEK0d3MWJmcUd2THJGQVp6S0VCM2paeEpraFIxb2hZbndoVTV3?=
 =?utf-8?B?cDJ4eFhHbjJSa3hWS1lVNzlpeXJHdmlGMDJyMnd3SmlleDI0YkVUSWdrVUtW?=
 =?utf-8?B?aVkvSDN6NjdFMEpiNldyL1dDSnN4c2M0enA2TDNxTWh6aGpWb2t5dWRuQURF?=
 =?utf-8?B?TEMzUzV4UXMyNmhxR091QUtnNXl5eGZXclFzTVBHQVg5V3N5SGsraW10Z21o?=
 =?utf-8?B?b1psVVp3clNja09ScENRYVVZWHZ0QUJRemZ6UUdBSHhySU9OQ2xnenZuUFQr?=
 =?utf-8?B?dUZ5YjRWdXNEWDZubkpxRFFIdURqT1B6ei84cHhzRHU2aWp3VXV1RDVjWnQ3?=
 =?utf-8?B?UHZJbHQvcHVEeEJaT3M5TTZSZSs5dXkvblJqa05SS1l0MVdmQ2R5TllkRHNZ?=
 =?utf-8?B?Z05CZU1VRExFSWY2YnlkbzhVVnJKS0pzMUpoTEg5YnpxMmVpemo3M2xRZ3lE?=
 =?utf-8?B?cFJ3SVZVaDQ4M2cycTVUeVVsc2U4bEJOVWZoUmVDQ1RoNzc3RXNlVjE4Qy9h?=
 =?utf-8?B?dHYrUFkzOG95WnpoQkVDSDB6OE0vY3lONDI0bXdEOG5tdTAwVTlqQXhROTl4?=
 =?utf-8?B?QXdDbDN3K3lmT3djOG4rTGtYQS9hVnRWdFJua0pMZTg3UWo0UGxiQWMvM084?=
 =?utf-8?B?aUxUTStnVUw3ME5DTngzWmh1SVVkWGEwb1M4RnFtYVViMXJ6NVVHd3E5WjNS?=
 =?utf-8?B?S3lvZTdxOTd2K1UxVUFpVlhNcmhOWTR1cGx4OVJhVC91MU01MDEwM3FUdi90?=
 =?utf-8?B?RncvVjRmWHlpS0ovZ29FVXo0aXVkbS85bVYvaUNsZmlMejdjVkxxdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba00e4ad-2671-4837-f7ca-08de7d93b7a3
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9501.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 04:24:13.0602
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iG/AITnijy78bHlmY+BonFHprpFYbbXOLOkhWjKIxOpnAuU+uafTc33dQCXkuJOhZ7+QuFaSWLGLUrTPZ2AvBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4093
X-Rspamd-Queue-Id: BA38B233A9E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-21523-lists,linux-acpi=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[amd.com,gmx.de,intel.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pnirujog@amd.com,linux-acpi@vger.kernel.org];
	DKIM_TRACE(0.00)[amd.com:+];
	NEURAL_HAM(-0.00)[-0.987];
	TAGGED_RCPT(0.00)[linux-acpi];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action



On 3/6/2026 7:37 AM, Rafael J. Wysocki wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> On Friday, March 6, 2026 1:17:19 PM CET Rafael J. Wysocki wrote:
>> On Fri, Mar 6, 2026 at 11:50 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>>>
>>> On Fri, Mar 6, 2026 at 3:51 AM Mario Limonciello (AMD)
>>> <superm1@kernel.org> wrote:
>>>>
>>>> After ACPI video was converted into a platform device in
>>>> commit 02c057ddefef5 ("ACPI: video: Convert the driver to a platform one")
>>>> other devices that are MFD children of LNXVIDEO are being probed.
>>>> This isn't intended.
>>>>
>>>> During probe detect MFD cells and reject them.
>>>>
>>>> Fixes: 02c057ddefef5 ("ACPI: video: Convert the driver to a platform one")
>>>> Reported-by: Pratap Nirujogi <pnirujog@amd.com>
>>>> Closes: https://lore.kernel.org/regressions/007e3390-6b2b-457e-83c7-c794c5952018@amd.com/
>>>
>>> The link is broken, so I can't see what is really happening, but my
>>> guess is that MFD devices are created under the video bus device and
>>> they get the same device ID (confusingly enough).
>>>
>>>> Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
>>>> ---
>>>>   drivers/acpi/acpi_video.c | 4 ++++
>>>>   1 file changed, 4 insertions(+)
>>>>
>>>> diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
>>>> index 3fa28f1abca38..2cb526775ac47 100644
>>>> --- a/drivers/acpi/acpi_video.c
>>>> +++ b/drivers/acpi/acpi_video.c
>>>> @@ -14,6 +14,7 @@
>>>>   #include <linux/init.h>
>>>>   #include <linux/types.h>
>>>>   #include <linux/list.h>
>>>> +#include <linux/mfd/core.h>
>>>>   #include <linux/mutex.h>
>>>>   #include <linux/input.h>
>>>>   #include <linux/backlight.h>
>>>> @@ -1988,6 +1989,9 @@ static int acpi_video_bus_probe(struct platform_device *pdev)
>>>>          int error;
>>>>          acpi_status status;
>>>>
>>>> +       if (mfd_get_cell(pdev))
>>>> +               return -ENODEV;
>>>
>>> If the above is the case, I'd prefer this check
>>>
>>>          if (!device->pnp.type.backlight)
>>>
>>> which should also work, but is more general.
>>
>> Well, this will not work if the ACPI companion is shared between
>> multiple devices.
>>
>> However, adding an MFD check here is a "works for me" change rather.
>>
My apologies for not being clear about what works on my end. When I said 
it works, I meant that the MFD check had fixed the noisy error messages 
below. However, this does not resolve the automatic probe issue of AMD 
ISP device.

[    5.337676] acpi device:14: Error installing notify handler
[    5.337682] acpi device:15: Error installing notify handler
[    5.337684] acpi device:16: Error installing notify handler


>> I think what needs to be done is to extend the duplication check (see
>> my patch from yesterday at
>> https://lore.kernel.org/linux-acpi/5663583.Sb9uPGUboI@rafael.j.wysocki/)
>> to detect the cases when another platform device (not necessarily a
>> child of the same parent) sharing the same ACPI companion is probed.
> 
> So, Pratap, can you please test the appended patch (untested so far)?
> 
I verified the appended patch and the results are same as the MFD check 
suggested by Mario. Automatic modprobe of AMD ISP device issue is still 
observed.

Based on my debugging so far, I can confirm both automatic AMD ISP 
device probe and camera works only when the MFD child devices do not 
inherit the parent device ACPI companion. I shall run a git bisect to 
identify the specific commit that is causing this issue in 7.0.

> ---
>   drivers/acpi/acpi_video.c |   22 ++++++++++++++++++++++
>   1 file changed, 22 insertions(+)
> 
> --- a/drivers/acpi/acpi_video.c
> +++ b/drivers/acpi/acpi_video.c
> @@ -1978,16 +1978,38 @@ static int acpi_video_bus_put_devices(st
>          return 0;
>   }
> 
> +static bool acpi_video_bus_bound(struct acpi_device *adev)
> +{
> +       struct acpi_video_bus *video;
> +
> +       guard(mutex)(&video_list_lock);
> +
> +       list_for_each_entry(video, &video_bus_head, entry) {
> +               if (video->device == adev)
> +                       return true;
> +       }
> +
> +       return false;
> +}
> +
>   static int instance;
> 
>   static int acpi_video_bus_probe(struct platform_device *pdev)
>   {
>          struct acpi_device *device = ACPI_COMPANION(&pdev->dev);
> +       static DEFINE_MUTEX(probe_lock);
>          struct acpi_video_bus *video;
>          bool auto_detect;
>          int error;
>          acpi_status status;
> 
> +       /* Probe one video bus device at a time in case there are duplicates. */
> +       guard(mutex)(&probe_lock);
> +
> +       /* Bind only one platform device for the given ACPI companion. */
> +       if (acpi_video_bus_bound(device))
> +               return -EALREADY;
> +
>          status = acpi_walk_namespace(ACPI_TYPE_DEVICE,
>                                  acpi_dev_parent(device)->handle, 1,
>                                  acpi_video_bus_match, NULL,
> 
> 
> 
> 


