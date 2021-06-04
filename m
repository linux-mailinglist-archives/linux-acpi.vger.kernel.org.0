Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8952139BF2B
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Jun 2021 19:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbhFDSAG (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 4 Jun 2021 14:00:06 -0400
Received: from mail-bn7nam10on2083.outbound.protection.outlook.com ([40.107.92.83]:59168
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230380AbhFDSAG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 4 Jun 2021 14:00:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MrNzgdK0NrhaIYSQnbrLkPQnrEIEUJdI/Is746vQRHxcMTgMb5jV1ZamI+D3y6UHrUg+3xNJkwcUXw3BIlYkq8gnEdIYOuaocU2FOTAT8rYI/cTYKvp1ymTSAOuZsyHSC77UOnpDTgQwkPInOKvNPM/pzlKL//yCy5rqWgx/DXVjcKJM5EQvzWl+lo+iGP5gd8jEs2nRC5PWyDWKWuAIZ4uI7y92tVNXA4Q+hKBy80/jiH55Vmiwu3Ow6zs/WdhU5rJR/0ubf4rS8XPmN63Lt2j8M1c0zk5Jfeimn1XXulqFwg4hG3C4esUB68BGTUgpPVkEEw+ueN/3a7C2IGsjSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UOAePLq4tVJ3mUK8Q0ZtNywyZoM0CqHyBBwIs3gx7Vg=;
 b=SUw+/AnAV4ZGXAnSNaDM17o/qbm28E6xb8gpG9arOdal0hqUMgaEQkpGktILwEyJO41sRHBsxmqwiMnv8r4sJAGzV1V0yo6Fl28F5BkG6L45BK81JXN2VsGJZ0Nvjn0Pr3LWg5NGZ8q5OJhWNZTiBDsgO4mxNTGOf/j/eJ1w3atE/Y9wjp/ARQ2nGC+fkDpOuH8qMwmCsGeTd9+sWHLXi2ep96bI+vAKGy+jK1kWghv0H1glwQEENuoeI22r/MEBMqb8tl/KxUNoBuzJLe0HN0DwShlGbo3zUmH78qbp5aIV9PiJQDieiMshv0fyu8u9fyDA015yjKFHTkaCCHd92A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UOAePLq4tVJ3mUK8Q0ZtNywyZoM0CqHyBBwIs3gx7Vg=;
 b=KfVbPh8f2Z4JspPPy35MCkawClNcCOeMNk6tbVzDH9hYbv52uJ7YHGEuMXHW59Qb2OkpMObyhylgZghawWdGB+DpP8tbbSccdxP2mCWLZRffqlZgH3sk7YVIXikOiVQDjTAvmWTUW+JDd2fgKsYpASTldUTwXGff1bgAFGp+ekk=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
Received: from BN7PR12MB2689.namprd12.prod.outlook.com (2603:10b6:408:29::31)
 by BN8PR12MB2964.namprd12.prod.outlook.com (2603:10b6:408:43::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Fri, 4 Jun
 2021 17:58:18 +0000
Received: from BN7PR12MB2689.namprd12.prod.outlook.com
 ([fe80::c529:c932:4b33:9b60]) by BN7PR12MB2689.namprd12.prod.outlook.com
 ([fe80::c529:c932:4b33:9b60%6]) with mapi id 15.20.4173.032; Fri, 4 Jun 2021
 17:58:18 +0000
Subject: Re: [PATCH v5 2/2] acpi: PM: Add quirks for AMD Renoir/Lucienne CPUs
 to force the D3 hint
To:     Raul Rangel <rrangel@chromium.org>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        linux-acpi@vger.kernel.org, david.e.box@linux.intel.com,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Alex Deucher <Alexander.Deucher@amd.com>,
        Prike Liang <prike.liang@amd.com>,
        Julian Sikorski <belegdol@gmail.com>
References: <20210604165403.2317-1-mario.limonciello@amd.com>
 <20210604165403.2317-2-mario.limonciello@amd.com>
 <CAHQZ30BWzY=oLvOtj==uinW2Fu__skuoLNYhz5NmDg=oRwq4Sw@mail.gmail.com>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
Message-ID: <acd70140-aac1-bde2-225c-1a8c1c272753@amd.com>
Date:   Fri, 4 Jun 2021 12:57:55 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <CAHQZ30BWzY=oLvOtj==uinW2Fu__skuoLNYhz5NmDg=oRwq4Sw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2600:1700:70:f700:74e9:e494:9b0d:e2d1]
X-ClientProxiedBy: SA0PR11CA0003.namprd11.prod.outlook.com
 (2603:10b6:806:d3::8) To BN7PR12MB2689.namprd12.prod.outlook.com
 (2603:10b6:408:29::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2600:1700:70:f700:74e9:e494:9b0d:e2d1] (2600:1700:70:f700:74e9:e494:9b0d:e2d1) by SA0PR11CA0003.namprd11.prod.outlook.com (2603:10b6:806:d3::8) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.26 via Frontend Transport; Fri, 4 Jun 2021 17:58:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fa2a75a6-5461-4dd0-7906-08d927825528
X-MS-TrafficTypeDiagnostic: BN8PR12MB2964:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR12MB2964D6F50D0A640C4C353B74E23B9@BN8PR12MB2964.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xnMNaRlyQ+OTW2haUWv0MRzXk8OlPnHGysz8DGxw34DK0uGB4+j/g7CSGPSJhxzKzsn70M6j+XxWmn1kxSaupEDqdfUuvd0h3i1C4+nxVrp1T341Ru3WR7R5VQz65YzO2YAPWDhqjpErO8cPUo3gjj1M9VwZEbKwcz7poTvpJq+KizthDetvsSZ5PG7T2w6ITtbCoSRj1ZlhIGCbodaZIbKDtX+oH6eYyNYxUXCgF4W8feUQcgssGivI3pGyFT/yD0CjpXC/F9RSthVvrrnpzfOgigX4ibtZ2wPu45O+o+z5BT4vfMiWPgZ0GSWzcegr+LGOJRFkW8SrIjypEtjdZt0u7v5ggYzhUJbf5KXcJvUekLw2UlratGpIvtssXjWnPwwoQwcVaohc/vmOwEjAg0D+1FVx5ZpbCz1QTXS8XTZyKPMZU2cUiJKHL+xLN8re5xHmsOZGa1J/qQP4j8WVMzNcLmoyBvrSsR7jrgWHpJWT0zuD0W8P9XwzNB0QGAuhwCGx7YYIhuP8VBd5bmnxgar6Ssg/lTRvY9eO34ORh/nQyYJ2elOLMXFqAVYY+QAuiPDYgwAKQDkU4QnGi+sJBj8lBLgQhcG3AQDSWlcGixd3+roi9+mtKdO1r89X6NfryqReECQVrXQWTGJ1U4hvsYeQn1+RSYHc6mHxrJvp5VLIdVTorQwf5g0oTyAXRP17
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR12MB2689.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(136003)(39860400002)(366004)(346002)(4326008)(52116002)(6916009)(2906002)(31696002)(86362001)(6486002)(5660300002)(6666004)(53546011)(2616005)(66946007)(66556008)(66476007)(186003)(16526019)(7416002)(36756003)(38100700002)(83380400001)(478600001)(54906003)(8676002)(316002)(31686004)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?OXRIaCtzV3dPSFh3SnQ3b2EyV2pZazJVS3dmN2o5S3dWYjZzeVNXRElnZkVY?=
 =?utf-8?B?ZmdyN1lsYktEV3liSVV1QzZGd0pObUczeE1QZDgyN0dzOTl5dER3QWJmbUhV?=
 =?utf-8?B?SExIdXFFUHV4WkJBZlc5OS9lZUxWU0RkZ0lBT1VmS1cwRDJyQWJsMnc1YWhu?=
 =?utf-8?B?VEhQK2hpSG1lcDZWV3dyNWdodm9pRE54emcxK3ZKTjBOemtCMDFKN3VtMHFS?=
 =?utf-8?B?MENGMzJKeXhjejVxNFRFei9TQnZvZVQ3ZVhPc05EbUN5TGtxc2pldHI0NXVJ?=
 =?utf-8?B?VVViNHlqY3JRa2gyWC9oOXpubU1aaGVxNEd2Zk8xeldzMWxxUmJVQU9yOURC?=
 =?utf-8?B?Q0hibWJaV0RLWko4Q0grRWxzZ3RCMXEyQWNIT0haNWNiTGI4VnRENm1SZ1BZ?=
 =?utf-8?B?MW9wVGU3QmVNNXgvNUhFa1NDK0grYjQ3WGlVWU4wQit6OVpyK0VLTDFhQWdP?=
 =?utf-8?B?NGFIaldlSjFVNlA2N0dmcFFtT2dSZnZNaHR4VzhHaDk2dGwzQkkyOHF0ajdJ?=
 =?utf-8?B?UXUxVFQydGw1MnExZDl5SkdyOXlXQ0xDS3RPUVBLZnZZNDdqSlgzcjBONUJJ?=
 =?utf-8?B?VnE4NDFpTXVZclNnbFBVeEFpUjJPMkVVa0F0akFoemVzUDFFSnFoWmJPdlhm?=
 =?utf-8?B?bjVRL210dHR2N2ZQamYrRTI2bm0rZm9sMUMwSkxpazZLTFNQeVFueVhsU0Za?=
 =?utf-8?B?WkliWmR5NkF6LzZ5Q1hBcmRzdGxxWGRZZU1RNDZXNVpDUHNzb1Q1YWw1K3l4?=
 =?utf-8?B?ZWEzdCtyQkNFaERYSyswZmN3akZ0Y3dCUlFEYW5NQUpnQitLeHIvUjltazhT?=
 =?utf-8?B?VDkxZFJ1RHcwaUpxL0szck5GMDFiSFhPUlBpS3lwYUFJRE1obzRKVlRKbTZE?=
 =?utf-8?B?YVNhUGFCaFJ3c3dlUytSbFFhVCtMMzhDaCt5V1htcFdMNndGVG5kRFZYZnE3?=
 =?utf-8?B?K0lJQm1kTFZZT09rTWFKRC8wTDFYY3VLeDNtU21raXNHN1d0ekZaRXJsQXIy?=
 =?utf-8?B?emNremIvUFlqUzlTbDV5aWxHc0haQmpYdHB5VFJrVTNqVkVYU2VyRFprWHZP?=
 =?utf-8?B?TFNOd0xrSEdQZm9rRkViQTUycXV3TnBOTjlhK1hNTEtoenFkN042TytUcWts?=
 =?utf-8?B?allpNW1FanlZTHZNc3pvVEphRUtWOWwyVFZ3R0hOckt2WEpVd2JMdnNCRjg4?=
 =?utf-8?B?Y3BUOW5sVW4rQTdMVTBWZGNBa2U1Zk00ODRHUzRGZDFVc1F4Vk1BODN1Tk1S?=
 =?utf-8?B?ZU9HQjNwY0NjQ2VWcytsOUpnUDh4aFppSXpjTzBwZnA3OFU4NVJNTlhGeUxG?=
 =?utf-8?B?OTZpaG41eVNORjc4S2xQK3JCZDBhWDR0R0RicWhZcDcyLzlkbC9kQ1ZBWE8r?=
 =?utf-8?B?WDQwQWJ0TSs4K0dGK0pBSjNGenM2eDlweG84ay9yWTh0Zk9VcnBjTlNlYUhN?=
 =?utf-8?B?elpYajZ1QVBtL042UUlBdHZ6U0h1OTJFdzV3MVVXaUc1bzBNRUQvWERFZUdn?=
 =?utf-8?B?USs4MkJQZnlQRTdPaDNLTlhNRHlIalVQR2UzZlo1RmxaMFpFK1RkS3Jybm1t?=
 =?utf-8?B?TkVOVEVqeDV4RDU3dVU3TS9pK2c2bkM3K0V2NWNvSUJnbWxha3NwTXlTTUFI?=
 =?utf-8?B?aTJodGMxZXJSQ1VvNEN5NmZFNXhGaVhIVlNBZ0dSSDErNjZQMWJzdmRRdm9s?=
 =?utf-8?B?Yk50citLSTEyQWZmUnBKbUt0NEQvM1pLc1p4TzhDVk40emVjclpPaDZDTkFa?=
 =?utf-8?B?bGZOemlscGROQVU3dENiZ3lSbXdzZG5TUkZ4L3RyTkRYaWdTbUs3elR0Qm5v?=
 =?utf-8?B?WkloemQ2R2tzL0VKNWZDY0w0M1lRelVsOUVub1V0eEhQcXZBaFo2RWEvTm1J?=
 =?utf-8?Q?+q/EL8BrCbw2F?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa2a75a6-5461-4dd0-7906-08d927825528
X-MS-Exchange-CrossTenant-AuthSource: BN7PR12MB2689.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2021 17:58:17.9572
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: prHnMCTTjsrntJExaK0teIoroR0B65iZSEl8CGcldMCq+lsKCfzhYrPSjk2e6C3gW7rECB9yJc54AgE/Ruuz9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2964
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 6/4/2021 12:43, Raul Rangel wrote:
> On Fri, Jun 4, 2021 at 10:54 AM Mario Limonciello
> <mario.limonciello@amd.com> wrote:
> 
>> +
>> +#ifdef CONFIG_X86
>> +static const struct x86_cpu_id storage_d3_cpu_ids[] = {
>> +       X86_MATCH_VENDOR_FAM_MODEL(AMD, 23, 96, NULL),  /* Renoir */
>> +       X86_MATCH_VENDOR_FAM_MODEL(AMD, 23, 104, NULL), /* Lucienne */
>> +       {}
>> +};
>> +#endif
>> +
> 
> Is this the same matching logic that Windows is using?
> 

I don't have access to confirm their logic for it - but they do have an 
allowlist that was used for systems before StorageD3Enable was 
introduced as well as a registry key to override it in Windows.

In Linux we can do it a number of ways:

* Detect the CPU in RN/LCN platforms
   - Like I did in this patch

* Detect some other PCI device only present in RN/LCN platforms and set 
this hint
   - Like some earlier versions of this patch series from Prike did

* Introduce a tri-state module parameter like d3=auto,off,on
   - Set up logic behind auto to use acpi_storage_d3 primarily and look 
at a quirk list as a fallback if that was false.

* Add a compile time option to include these quirks in either acpi or 
nvme.ko only if a user selected them.

* Enumerate all the field systems SMBIOS we can find with these CPUs
   - Expect this to be a large quirk list.

I don't have a strong opinion between those two first options, but 
suspect the 3rd through 5th aren't really acceptable or scalable.

I'm open to other suggestions but testers of the patches thus far have 
made it clear that /something/ needs to be done to avoid the problems on 
RN with Linux though.
