Return-Path: <linux-acpi+bounces-3081-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E728840AFE
	for <lists+linux-acpi@lfdr.de>; Mon, 29 Jan 2024 17:12:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42D881C21266
	for <lists+linux-acpi@lfdr.de>; Mon, 29 Jan 2024 16:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77BD1155A36;
	Mon, 29 Jan 2024 16:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JbqbEQLv"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9163D155A2D;
	Mon, 29 Jan 2024 16:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706544740; cv=fail; b=ERslQDXvsk5Qg56AwpFnTE7eS08uFlYl3SwdKqzJYhq3dpqwN9M5kspu8Vagg5e8WaSpuLd6RhdVeFs6lSh2+WvWdDwUniIKVCe255lT6JaT9GDM0nXD9GHLQ2XvgpOIiAvDCHMLbFkvLuV/vr8ckwZVwLEW/wINiMDMsGkguLg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706544740; c=relaxed/simple;
	bh=FKcylZbK6hfbi6V626vAb/bUbeCovYhcj9cmz9vFnO0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=l+9dCZBWzvxNFYwduTxLQellIKS64a+bM5+QRta+szp1T5HWsTCwKCD5uBZ36Ey6ycHXq1Fi12rXnPiM09KX037nFsdw+6M4TURY+SKel8j7ouh8dUEa+O78O2aLVZvguy3jlvhRhxPOLDjK6NTyyv4le4RBizNW0Gi7pfkbhQU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JbqbEQLv; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eHasazw7GnZA4Fq9hb1UB8qU1ozZxGAQ0COesDc1LAG6zbzkCGkIrB4iodVIAhtkCMKTttZjvkI7dHyFfm8k1Nd92JcEChVM4pC7Ge1eDLvYWZ1gg9N7Mo/z/Yp0xb2wLYehIE48t7SiHL5mMFTrDSel0gJTcLR9avwObCChP+peebtoZmaDsLnfU9t6DYoBeFQSjip1SRXDyss8MWmg9qOhy9VM7pA1+u4V1PRfPtx7DqZNayRuxnW98eBfS/CIEjXINAr+4Yd6MXklC2MwrUtrHJ+aP5Tc3eBUokPWQDAYyKWQFMOwEpzpozDuKWHpTik5MqYvfvIQ+DEPDbpb5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QwHTv7HzK2Ar2lLGcyA76rXtUaFVV5ulwcsDMDkI0v8=;
 b=Sgnh0qGg+vVB2XTXWeLr+4YxlZRJTRok58Dbd2U0Tf963qrnM99LGcjpjC9n3GEJc9KD4gTYm/AX/lw5qB6Omz/eN6rWSSPSa1oqxHlOLADXqAqBcqm3v68vqkxfeA+Nt0xrClI0tFPTXQq3ZVEEB2fM0YbnZHZ+MP/ffRg77ynJKq7rW04X0kYsKmuhUg/xz7rcJFT7sPYfRUDhw/nf/oRS5A9Xc5YpxjNk76KeIxz48fGkKI2fyEGpZRkK8i7LCTA5IhdgA7SZJQhltIh715rAVMTmphFyfYgZ8hnkkCWO6NDiJ/QlaS9TxQ4qhnW6pcOdm+Sg1577dsBuOTOnbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QwHTv7HzK2Ar2lLGcyA76rXtUaFVV5ulwcsDMDkI0v8=;
 b=JbqbEQLv2BqYxgglR8K4jDF8UMOo+uiISY86Objp3djs92FGQOjvBayRHeo1wLDN+FYLVF4UPy0nqI1vPydpIUur0Xq5rbggk0XOzxXBaHnZ1uJmwXmG/FyecN8PvgSiazJdeuPTSvJC5OgtZqNj/e8jSiuskJgyYsReP574zfU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SN7PR12MB6789.namprd12.prod.outlook.com (2603:10b6:806:26b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Mon, 29 Jan
 2024 16:12:14 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::c30:614f:1cbd:3c64]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::c30:614f:1cbd:3c64%4]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 16:12:14 +0000
Message-ID: <ad625d5f-6b4b-41bb-a9c0-edb513697802@amd.com>
Date: Mon, 29 Jan 2024 10:12:13 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] ACPI: video: Handle fetching EDID that is longer than
 256 bytes
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, Hans de Goede
 <hdegoede@redhat.com>, "open list:ACPI" <linux-acpi@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
 Melissa Wen <mwen@igalia.com>, Mark Pearson <mpearson-lenovo@squebb.ca>
References: <20240126184639.8187-1-mario.limonciello@amd.com>
 <20240126184639.8187-2-mario.limonciello@amd.com>
 <CAJZ5v0iX5=u5y0JS2OzYMvYNnjZBCM2YfSTsSdg3CtH4rBMyUw@mail.gmail.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CAJZ5v0iX5=u5y0JS2OzYMvYNnjZBCM2YfSTsSdg3CtH4rBMyUw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR03CA0007.namprd03.prod.outlook.com
 (2603:10b6:806:20::12) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SN7PR12MB6789:EE_
X-MS-Office365-Filtering-Correlation-Id: 711d9a4b-14a7-485c-fde9-08dc20e50e99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Y2MCyB4jQM1fTlL6Fa6O9O2MHDnv8FFMTtWLnzRLYryZWJfVMXUSex74POZYYf5wTnX5ZT9iQeQAralwq+50WBNMHZ0En/WKaCEt3LmPQKb2mnzrniDQ/ysn8srU1j9QSa/mJUT+HJE9yLLXOJvVxe0jLIwjpBycLGEFV+lc1mY/NrdrBbCXD32ETfCmXE3X7TCfoRMQEWBUjgGQoA8RXM3OtBKC0dnhuPsPv4pkQ+SkE92EIsrkFsaxROeGlflhgTWWKzM7WkK2ejXLW7juCVnYTiLT0QaDBjMt/rx0pq8FSNa35XuIkRhpWu8QMt/e4OiATwSjHXAvifBlr5jnzVv/BRzFZAvnCO07+bHmXkFeZd4hWrQxJgA0cdvg5iV6IY6BLieyzOmP3Risk/f544bis1X6/0tTsXlcbOo9kIWHRwoJLklep7HOm/nhPhCV9N+2kaX2ODkH3I8iN3c8+ezf+zpABgeYNtVhW/VjblCvLKVPTZNlktWQRMuiuEJw2Nap8+u7r8/0Tys0A0wV74iFXU/ssjZ4FhYKVSCv2LbPFz5jW/Dzc5ejJiq/ptMjlhh2/mYgkafUa78gppKLn0C/LuwtjqmUfODRiGVhJa0FGSe+zGCDmPh5H4yWU9DFrHiYZPIWqTaWaS6yMI7h34dZIrWrvRib98V0Z393B3I=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(396003)(376002)(39860400002)(136003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(41300700001)(31686004)(38100700002)(66556008)(6506007)(86362001)(316002)(54906003)(53546011)(6916009)(66946007)(66476007)(6486002)(966005)(8676002)(8936002)(44832011)(2616005)(5660300002)(6512007)(26005)(478600001)(2906002)(4326008)(31696002)(83380400001)(36756003)(148743002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TjhiM0hBcTJ0ZnhYcXgrbnhBaXl2M3owbTNLSHgxUEwybzNQRmFzeHk5SHps?=
 =?utf-8?B?WG5KTms5WU8wMFN6WjR3Z21Eb1dhZWFjM1lGcHZ0ZEZHV1dRY2x4RDlSaVU2?=
 =?utf-8?B?NWVFUkpaOUFTMkZsSEJ5eGhyQllIYVI4TlpTd1FybEhpNFpvRkFoNkhjZlZw?=
 =?utf-8?B?QWpQSlFETEVxMUFJUWZrcVlHc21ydmRlbXFlQkF0S2ZPaDN0K0JkTWc1SGlL?=
 =?utf-8?B?VHhuSUFkV0o1a3lXRHhyUTBJTEZnYmV3bkY5NTFsUFBLMmUzRGgwUnk3d1Nr?=
 =?utf-8?B?MFpwSDlDS3JuNnM0K3RXeHpOMnl1OVhodlc2Tytyb2h3WEl2V0xlVnFPbndw?=
 =?utf-8?B?bEdMNUZDK083L2V1L0xCdE5UN0FLZFJFMjducEVZWUxqMVVBWVJCYlhKMGQ0?=
 =?utf-8?B?OEpWa0JJN29uY2VKNjRQM05GZ3l2eW93MlBRNlFZWnZqcXdPcE5vckR5WGg0?=
 =?utf-8?B?QzczRmF5UmhsZVVNUHVmb0g1ekJjbXRBV3hWVm4rOFR5blgvbC9HWjQ0cDJO?=
 =?utf-8?B?azhLQktFY0RRYmk4NFNEaC9Ed2piVlg4WTUvVnN1aHRtS1FXZ0RBM3JnQ1pt?=
 =?utf-8?B?bG5qalR3TlNFMXE1cU1LbzluRmVaWDJnTnRrQk9oeWM1ZXhaRTd0S3B3cHc3?=
 =?utf-8?B?V3lhdTFVbFZRblhYZG9FNHlPclRWMFUwVGJsZjhoVmJXeGVqRjV0M1lHM21O?=
 =?utf-8?B?YjUrNFFZT3NBQVlsRmV4UnhIUlR3dWh6MHVCR0lWSjBlN0RhSHAwMHNaN0tx?=
 =?utf-8?B?ZC9rMGxxUW1OVCtYbDBBUEordHhhMENtanlIV0xnT0RpdFdrMFNhRFNaUVFu?=
 =?utf-8?B?VlRvMThjbUZmdTh5ZXhyNXNrNHF0SURMTXVYZlptSVl5eHZHOXZJWGxDV3p3?=
 =?utf-8?B?Y2pIV2FENm9aUm9ETENwZWhrQWFCZHpSRTg3WGpPTzVPVXJ4RWMzNlFvY25J?=
 =?utf-8?B?WHhCd2duVU0yZmp1UTAxWmFDQ2pvZVE1aUhSaXVsNnJLVUQvUVkzTjVRRVd1?=
 =?utf-8?B?RVNPSUtrYTM4QTZrd0NvL0pGd2V5VXAydjdMN09lK1I4cUhSbWRPZE9FK2xj?=
 =?utf-8?B?Y1lUUjdva2x3NDU1TWFiYzJwUS9ZOUZzZHNpc0kyVlBOclhvWDNjMGttSEtV?=
 =?utf-8?B?dXdxZE5aZlQ3eTZ2NHRQRi9qcEZGVm9zSWNPRUkrVk9RVGxlQmFDZ0JZUGJm?=
 =?utf-8?B?OFBCb29mRnlqMmxxQS9sdjlRZTR4OWRwWDhCU25LL1dOL3JrS3g1eGpXQUJV?=
 =?utf-8?B?SDUzd1lyaDRDcDNIZXZiNFk3bGVPT0VxZ0dLN3FYdmEwVVJ3SjRNbHM3aVJw?=
 =?utf-8?B?SHRqdjFnZE92Y3ZXbVpoVGpaSC83V05XemhvRGhmanZBaU1scTlydmZ4QzUz?=
 =?utf-8?B?aSszTGN3Sjd3Z3F4S2Y0VXFSdTNCcWpCRk0vUzBSUmdTeTM4ekg4alRoZ0Vs?=
 =?utf-8?B?VHZZSUxvNGRVVndqTmphd0JHRCtORi9Ga1YvU29kSjgzRkZzOGVjWmpTVGgx?=
 =?utf-8?B?U3JvRVUxOWxVRkJkUzZlZzdpOGVPaVlUWEo4ZGxsMVVnVWpJQm1LaStDYjdh?=
 =?utf-8?B?VGpOSWh6Q0RLTFdEVTRtT0xManhqRkFSL1N3aE9hRWpiK2ttNG9uRCtwZFlI?=
 =?utf-8?B?dk5OV3VESzF5TSs2UVYyeWdhMDJEcXhnZWczbGNlRytUWnRDZmh1YnlsUGNN?=
 =?utf-8?B?RW5jU1cxM25BbHhqR3hVS2xKQW9NZUVUb2paNDg1WFlJTmE4R3BKWnl1WGFE?=
 =?utf-8?B?dis4WUVseU1zZ1E4bDNLbEU2UDliYm1KdUx4aFlCQ0dnL29leXM0UWJnS1pF?=
 =?utf-8?B?cXE3NENuR21jdGR6NDlEc2JUNVZkQjAxQzhxekM3L1JBZWNhSFhXQ2l6cjM1?=
 =?utf-8?B?VUtob3pEcTRNTWoyS2c5RXFMMktYQUNWSXJqOEF5Zk1hYTIzVnVaN0hUS0Ex?=
 =?utf-8?B?M2F0NlZpOWVabDhQQWRVZnR0Zm9XOHE0aThCVmx1M1JlL0Q4L0RIVGsyQ2hi?=
 =?utf-8?B?SzAySi9wTG04bzVPSjkrTjRkb3VMUGxpOU1zUGhCYlZnRkU2eXJKcVJZOWwr?=
 =?utf-8?B?aG1BUCtvMHluVFAyUWNtbjlZUURMY0V4SkF4YTltVDl2WElqTFBKMjRDdHA0?=
 =?utf-8?Q?iwuuXjqpv43BlbTHe5zIhZKDo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 711d9a4b-14a7-485c-fde9-08dc20e50e99
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 16:12:14.5492
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b4myuZIPKU1Kcuip4bj6+eD3uAlhYGPv4GXvCSIzeDBX1taSN11iY95B39x4keeoCszQV+vnh5xKgGlSFLc3DQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6789

On 1/29/2024 07:54, Rafael J. Wysocki wrote:
> On Fri, Jan 26, 2024 at 7:55 PM Mario Limonciello
> <mario.limonciello@amd.com> wrote:
>>
>> The ACPI specification allows for an EDID to be up to 512 bytes but
>> the _DDC EDID fetching code will only try up to 256 bytes.
>>
>> Modify the code to instead start at 512 bytes and work it's way
>> down instead.
>>
>> Link: https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/Apx_B_Video_Extensions/output-device-specific-methods.html#ddc-return-the-edid-for-this-device
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>   drivers/acpi/acpi_video.c | 23 ++++++++++++++++-------
>>   1 file changed, 16 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
>> index 62f4364e4460..b3b15dd4755d 100644
>> --- a/drivers/acpi/acpi_video.c
>> +++ b/drivers/acpi/acpi_video.c
>> @@ -624,6 +624,10 @@ acpi_video_device_EDID(struct acpi_video_device *device,
>>                  arg0.integer.value = 1;
>>          else if (length == 256)
>>                  arg0.integer.value = 2;
>> +       else if (length == 384)
>> +               arg0.integer.value = 3;
>> +       else if (length == 512)
>> +               arg0.integer.value = 4;
> 
> It looks like switch () would be somewhat better.
> 
> Or maybe even
> 
> arg0.integer.value = length / 128;
> 
> The validation could be added too:
> 
> if (arg0.integer.value > 4 || arg0.integer.value * 128 != length)
>          return -EINVAL;
> 
> but it is pointless, because the caller is never passing an invalid
> number to it AFAICS.
> 

Thanks.  I'll swap over to one of these suggestions.

I will also split this patch separately from the other as the other will 
take some time with refactoring necessary in DRM that will take a cycle 
or two.

>>          else
>>                  return -EINVAL;
>>
>> @@ -1443,7 +1447,7 @@ int acpi_video_get_edid(struct acpi_device *device, int type, int device_id,
>>
>>          for (i = 0; i < video->attached_count; i++) {
>>                  video_device = video->attached_array[i].bind_info;
>> -               length = 256;
>> +               length = 512;
>>
>>                  if (!video_device)
>>                          continue;
>> @@ -1478,13 +1482,18 @@ int acpi_video_get_edid(struct acpi_device *device, int type, int device_id,
>>
>>                  if (ACPI_FAILURE(status) || !buffer ||
>>                      buffer->type != ACPI_TYPE_BUFFER) {
>> -                       length = 128;
>> -                       status = acpi_video_device_EDID(video_device, &buffer,
>> -                                                       length);
>> -                       if (ACPI_FAILURE(status) || !buffer ||
>> -                           buffer->type != ACPI_TYPE_BUFFER) {
>> -                               continue;
>> +                       while (length) {
> 
> I would prefer a do {} while () loop here, which could include the
> first invocation of acpi_video_device_EDID() too (and reduce code
> duplication a bit).
> 
>> +                               length -= 128;
>> +                               status = acpi_video_device_EDID(video_device, &buffer,
>> +                                                               length);
> 
> No line break, please.
> 
>> +                               if (ACPI_FAILURE(status) || !buffer ||
>> +                                   buffer->type != ACPI_TYPE_BUFFER) {
>> +                                       continue;
>> +                               }
>> +                               break;
>>                          }
>> +                       if (!length)
>> +                               continue;
>>                  }
>>
>>                  *edid = buffer->buffer.pointer;
>> --


