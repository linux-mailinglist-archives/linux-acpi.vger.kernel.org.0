Return-Path: <linux-acpi+bounces-1284-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F5BD7E2C1A
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Nov 2023 19:34:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFE671F21A34
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Nov 2023 18:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A6492D032
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Nov 2023 18:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Kd2m+dcb"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB54928E13;
	Mon,  6 Nov 2023 16:59:23 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2044.outbound.protection.outlook.com [40.107.244.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67AAA1BC;
	Mon,  6 Nov 2023 08:59:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OhTyLHssfhKx5JSglgv6018yRunxO8nlSFl87F66CtEpaV6nQG9sjerfFT7qLsd8WfN6Z+ghLPYlK8hOf0sZatG5aYMb3zWQWhczD3FR9XM8qCXHBwbQ+Ck/sXGnZqAhFYT0ZvQuVPQoBZ2bK/MiQfZPK6HFkpW06hZ86FbUXzzuSJ5+R/1ncrUSGqqCguLB+ES3lYMGLSbujxqCtQ6KNXxlSM6+3h1Vg92D/lyeO989aKF3SGzBRqZIxcMj1IGz2xB/F+eEPDv5H/lbqh44/rMCvHw6CFKU/WZxC7TgZq17J47uuw8ZO+JUwJ33vGOgm+Birca0EcWskEMcoP6YOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uFO9DUFf8Xo9CLO/loZ4PgLcz6BCj+RthB9zzIvOQ08=;
 b=CBvUGoJH6ul9fF4iZ3901oF/2NEbvv0Rxsi4tlS++lDe0QLRv11Gh196E59NjmQ2Xkd8qpMDj+FSZvz7nSfkyHQcrPc0aiEqPDc9W0kMVST5JFSkta+vAiVeuc4T2ANx5lkhvHPUjRToK9sHiXyCy43XaoBDFqcG32xHlsN3KRFiv37Hn4bAQJG/NTy4KNsPq/n+FfbxCxImsvXcBaWSZH1RDqXYPTaoxe3pNsB94M8Jr7mtL5kLc7fEeKeXVs+sxkNrhyUmKRPUYqCsBq/UXrqXJm5lpCaaxI723dJIvtjGqoF8i7r0lPTa07jnpxnx7XwYolTAKvQiIuS1bsLpMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uFO9DUFf8Xo9CLO/loZ4PgLcz6BCj+RthB9zzIvOQ08=;
 b=Kd2m+dcb7hPaR3eSm9fvxDbye71O2P2OtyQoMvWB6BnTqpaoGw2t9St79mVu/tHZ4Gj4ZAQPItOA7P5Vd/OVE5VR9ezSSasPCOxRZisz3+FTMDwOtpRavqwJufuD+7LldJzRdfaJfbESu3MsAz9M1QCkiWW3bjRvDe/SA0bI9ok=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH7PR12MB5806.namprd12.prod.outlook.com (2603:10b6:510:1d2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Mon, 6 Nov
 2023 16:59:18 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a%5]) with mapi id 15.20.6954.027; Mon, 6 Nov 2023
 16:59:18 +0000
Message-ID: <9b1a5e36-337b-4750-9dad-b54e28cde03a@amd.com>
Date: Mon, 6 Nov 2023 10:59:13 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/9] PCI: Rename is_thunderbolt to is_tunneled
Content-Language: en-US
To: Lukas Wunner <lukas@wunner.de>
Cc: Karol Herbst <kherbst@redhat.com>, Lyude Paul <lyude@redhat.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Danilo Krummrich <dakr@redhat.com>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Xinhui Pan <Xinhui.Pan@amd.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Mark Gross <markgross@kernel.org>,
 Andreas Noever <andreas.noever@gmail.com>,
 Michael Jamet <michael.jamet@intel.com>,
 Yehezkel Bernat <YehezkelShB@gmail.com>, =?UTF-8?Q?Pali_Roh=C3=A1r?=
 <pali@kernel.org>, =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>,
 "Maciej W . Rozycki" <macro@orcam.me.uk>,
 Manivannan Sadhasivam <mani@kernel.org>,
 "open list:DRM DRIVER FOR NVIDIA GEFORCE/QUADRO GPUS"
 <dri-devel@lists.freedesktop.org>,
 "open list:DRM DRIVER FOR NVIDIA GEFORCE/QUADRO GPUS"
 <nouveau@lists.freedesktop.org>, open list <linux-kernel@vger.kernel.org>,
 "open list:RADEON and AMDGPU DRM DRIVERS" <amd-gfx@lists.freedesktop.org>,
 "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
 "open list:ACPI" <linux-acpi@vger.kernel.org>,
 "open list:X86 PLATFORM DRIVERS" <platform-driver-x86@vger.kernel.org>,
 "open list:THUNDERBOLT DRIVER" <linux-usb@vger.kernel.org>
References: <20231103190758.82911-1-mario.limonciello@amd.com>
 <20231103190758.82911-7-mario.limonciello@amd.com>
 <20231105173946.GA31955@wunner.de>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20231105173946.GA31955@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR06CA0004.namprd06.prod.outlook.com
 (2603:10b6:5:120::17) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|PH7PR12MB5806:EE_
X-MS-Office365-Filtering-Correlation-Id: 97f51e6b-f870-4531-a580-08dbdee9b6d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	HSCpNuaRHs+Qu6xyQBT0sgz9oh4LtSPSr6mxqQeLQGMZDzErGUnq1Vd7B/ejJzAvqAkfh+akERGpwjLophlrFEjsXBjriFLkx2FsFjKqHDFZKys+3qbRrCFjEn7NeWQokAIcCeeZJC8WKLU2RB5mFNheQoggq8T+w32Osx5MeOiDxvy4akBbZy8YCCsYFjbdgZNBTQ5CyRnOBkNFu/vZ8ohpBPvLz9GnKdcpqZXfmgComrP+xyzCeWYlVCyRcwrZN3v3ju3Z9KpvILJ3sgoP3R6hjK8DFa+BPavX7DihbKJNtsUQDIuCWIeEmSGP2+t0dElS1s23CU58UM4+VTzJ2VF9JUlhHgLgI5lmfX3wDGO1LElKhJnnPPh0ja7HmftMWV0+JpGXKLHjv37F4+gYudrRRhzBQUhSXdu4KvzDMwWiLdxzDzKR94psAfhAwTKN7ooNb4uDjHgL3VYQGXjZ0VF1lZxYYeaq09EfcNPBr7YOvqz1wR9WlmrKYfAwSLk4EsspWjvZV0KoGbNFwgy/M4RPuGOz+oB7itdiT3hoZayO0IP7AV0NK3FWisQh9gdiEUwD1sFzifUV5+7kTTIZhv/kYOdaQAZ9LtAV9hNTbjQ6Lmhg8KQ45eZ3hxE9r+MMQfsRPkuqclfxkjVzWrvnHg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(376002)(346002)(136003)(396003)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(54906003)(41300700001)(66946007)(44832011)(4326008)(8676002)(8936002)(66556008)(66476007)(6486002)(478600001)(31686004)(5660300002)(6916009)(316002)(2906002)(7416002)(6512007)(6666004)(6506007)(2616005)(26005)(36756003)(53546011)(38100700002)(31696002)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NVo1WDJOVUtGS3h3cER2Z292U0RGbXFBMVoySHV0Mlp3bXBLR2dwWjlwM3I4?=
 =?utf-8?B?Y2lGblhTckRLZnRyM0ZSQzhaVkRtYW1MUzNNNkx6UkpVUVJSM1FaV3lQMkFF?=
 =?utf-8?B?UWQ4Qm01T1gxNGRoM1RkVUdQUStVZEsrYXorRmRvZDNqdGUzamxGQnRnTVg4?=
 =?utf-8?B?dFljT0FBcjJDM0hpR2xEU3VzZ2N0UG5MRCs5ajJMQ09DVTB4eHFIR2NiT0hn?=
 =?utf-8?B?VHgwTkRGN29KOFNCTTdRampmQk5VNU83SW84dzNtd2xiYjU4MFc2RytRY2x3?=
 =?utf-8?B?a3ZHYm1ORlBqN3dRQm4weERsSTgxK2VlQTVQZ253S1o0K1Yyay9JeWt5UkdH?=
 =?utf-8?B?N2lIZ2xSWEQzaDlKeGdjZlJ6S0hQdlQyb1cxbElhR3VuMXZkV0dxUWZrUnZM?=
 =?utf-8?B?YVdQT3NTV0VEeWw4TThwVUZtdjk5YzcyQlFpMXd6ck5USDZZTG9qUDZUY0dq?=
 =?utf-8?B?MUsvVlVhVDM1dGhLemJtMTAwMGtqN2FDRDAwd1BqODZ5eUlKcVZ2MzYrRmEz?=
 =?utf-8?B?WHlDcXFPQTNqVVNQTkZ2djJwc3puNDBhclpQZEtzZDJCVG45TmNwb0lnc0pi?=
 =?utf-8?B?dXBjYVEzTDRaVlBmN3VZZzMzZXpFQVNRRDMwZzVtdHNKY3JXY2tRc3pTT29w?=
 =?utf-8?B?a2Z1Qld6aXkxT3R2Y2tmQW5nNjRiTGxwdGhLU3N0ek5wZG9hOEUyT1ljWXZE?=
 =?utf-8?B?VFF5bjk3ZjFMd3ZCMnZhV0wvQWlOREFqaDFLN3RjS05abTNCNXFoZU9nOWdX?=
 =?utf-8?B?anByMGt6YXRxYWlBSGR0WHRRYmlCVHV1ckRrdFJ3SXpUWkQwbUhwcjFpLzg4?=
 =?utf-8?B?L2VxdndlemlMb0hZL0RBVndjWWtoenJYd1I2UjVYVHJ5OHU3VFBvQ3hPaElV?=
 =?utf-8?B?REZGRzI3NXZrVWM3M09UNkRmRFFrR0x1NmRhcnVUeldIOUtsN1JEUHg1ckZp?=
 =?utf-8?B?OTUwUlhiQlpXYVkwQVNJcVE2OFh0MXc2anlVclFzOEQ5aWJ4SDJybFlrOTJW?=
 =?utf-8?B?L0kweU16ZDZzcG5vSkVOUE12bS9jSUhJY1lnK2lxdHJlbDFMWVljWm9YSUNm?=
 =?utf-8?B?MFhtd0o5ai9VcUFOVngxbFlmaWtkTklWY1BXdGduaENYRkRkQm4zZFhINmlm?=
 =?utf-8?B?VDlYb3RtR1ZVemdSSm1OVnN2Vm1ycVR5NGFONm5uVlpJUmFaNTAvSWVTaTVq?=
 =?utf-8?B?OWcwWDA1cnpFMXBPcjhLWDhZNEpuUzJ2R0RuOVN0a2pLa2lDQVBaUVg5clc4?=
 =?utf-8?B?TDczR1RaZGNDTmtPSXh2OEdTelBKK2JZeGdSVC8xQUpPMitrdlJidFVWdDJv?=
 =?utf-8?B?T25FNndWUW0vbE5QRU5oRk5UdkxDWEh0ejEwMTl4Q1U3VkdBV3BUOXZWOTky?=
 =?utf-8?B?Q2IrZFFXV0QxbnZ2alpqV1YwWE9ZTjFpNVMwSGJ4YXlxZkZRT1hGci9tNmZN?=
 =?utf-8?B?RFF5MXZxTmN1TWU5a2RScTJEVE9la1VlZGJ2S0ptUEF1T1ZwNkdMR1FxVWZC?=
 =?utf-8?B?Vm5nYWJrcWdKYjhYMmtmME9nbTBhZ2V6K0xmaE1QSDRsZmhLWXI4WHRDZDlY?=
 =?utf-8?B?dDFNWmFVd2dKZTJQVnVaZmZ4VktxUXJFdXBQbURjNjFxY2g1OHQyWFdVYnF1?=
 =?utf-8?B?dVRKNk9XOEVaVDZDZmhNZUZWL0E4cjMxS3ZBNVFCNGxKTklUeWJsTlRvZXRx?=
 =?utf-8?B?d3g1TXRialRJdVNIS21QU0dTSFN0QWtWWFZQeXBSdHJQd1d3QnZTZVBXekJh?=
 =?utf-8?B?a1hUSWVDdE95TnJTVDFZRXRKNmMrMUhUZ3JHaHREL09nclpPbEJVSVQzdGdQ?=
 =?utf-8?B?dkw4a3BwTlhpWDNTRkhqME92L0hQSmJtNUtoVXRhM0F6WlpjdWowcmY5TzdI?=
 =?utf-8?B?Y0pRTDViWmV5NnlydVFhem1HL3ZHVWFLcUhtSkw1UU5sYnNXb0pJWm81SWQw?=
 =?utf-8?B?UmRwdGl5cHBqSW9yeUg0c0l4ZXEwRFlnRWZ5V252T0lIR2JGd1RhdUFLWUVK?=
 =?utf-8?B?L2lraUlrczV0eXVRV0JuNGFQZXV2d25uQUJEbFZOMEU5NTlEMlZBZGxaVitT?=
 =?utf-8?B?WVEwelg2djNXaW5CMGZKNjBNL081bHF3Yzh0R1FqdldsZGJXT3UwaU50enE3?=
 =?utf-8?Q?V9fHI8bLiebJdylVPqUglJ6hO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97f51e6b-f870-4531-a580-08dbdee9b6d6
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2023 16:59:18.0995
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nmKEfuiiQxg97LxE1t/pGMHuA/Qfw/C0XLsYQR8X4IOI+/ZGRJYwrW8E6grWW6AU0a6qMHpVxmQ1b4DibyXBjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5806

On 11/5/2023 11:39, Lukas Wunner wrote:
> On Fri, Nov 03, 2023 at 02:07:55PM -0500, Mario Limonciello wrote:
>> The `is_thunderbolt` bit has been used to indicate that a PCIe device
>> contained the Intel VSEC which is used by various parts of the kernel
>> to change behavior. To later allow usage with USB4 controllers as well,
>> rename this to `is_tunneled`.
> 
> This doesn't seem to make sense.  is_thunderbolt indicates that a device
> is part of a Thunderbolt controller.  See the code comment:
> 
>> -	unsigned int	is_thunderbolt:1;	/* Thunderbolt controller */
> 
> A Thunderbolt controller is not necessarily tunneled.  The PCIe switch,
> NHI and XHCI of the Thunderbolt host controller are not tunneled at all.
> 
> Thanks,
> 
> Lukas

I could really use some clarification which PCIe devices actually 
contain the Intel VSEC.

Is it in all 3 of those PCIe devices and not just the switch?

If so, I think I would rather introduce a separate bit.  So after this 
series we would have:

is_tunneled:1
is_thunderbolt:1
no_command_complete:1

* TBT1 devices would set no_command_complete
   - The consumer would be pcie_init()
* All devices with the Intel VSEC would set is_thunderbolt and the two 
consumers would be:
  - apple-gmux.c
  - pci_bridge_d3_possible()
* USB4 devices and PCIe switches with the VSEC would set is_tunneled.


