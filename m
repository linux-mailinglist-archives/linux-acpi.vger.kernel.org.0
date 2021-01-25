Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED117302F48
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Jan 2021 23:44:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732386AbhAYWno (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 25 Jan 2021 17:43:44 -0500
Received: from mail-mw2nam12on2074.outbound.protection.outlook.com ([40.107.244.74]:12033
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732787AbhAYWna (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 25 Jan 2021 17:43:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OT8bbqartBXHn5G9fCq2umhd/TTB7VGZldc8njdeU3fZlUn1nzihIf75fNtj/k08RZQXrA5CYhzeXxa+8R+Pdk7E7h50PrcP4wfTGPB80Ud3waRtS0RrXAznr74AaDG2sxd5SxDjUAwlXCAfi7hT7sZQw+iX5fZ5KTYPqTSKYwFVvN87H9KUWgJkHiGK0SlOw3Qq3cgD+8OcxscRBWKic93v4BXWVgLqnNQRv4hHysc/jzIcSsy+DGhJ3KuUfScRAB2YL4wbyL7bpHuVg54qTlzsbV/6Ssx5hODIhexSf6OZ5d88bOMg1DWTtNVjVL8j+V4bSGL2E6czrB9f0e1T2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PxPdOY0lSV4rVKBD8gJpn9GbEQuHj1lvy0aweMzYXXE=;
 b=P55Rv2LQPQe6iOLWouaI6iW8yy9LRakjfiQtb8yC9QDScHdi6SGhSU98f9QGLo7orPNR433p+nnvcnfoTsHkyiAa1Fr755umrpYJLB81Pgq3roASGVYoyPA4lKbHCKHZE54ip/IVWL5pkvnF1PHmzASYeQ4pIjxFDq0ehgwXg/fKhRJzdyYMnxQ/PQpimeGWmLEnXNwZfbU0hmHDYlUG5eKhU94etX6cJo8N0NjK9tpjur4LDF4IOyxLu2jgPKdFaYKjuu5agjpAAS7dCR+JKJD0TYLzf6mRs/fDhN9m2qYo7l8T/gVsW6YF+aNEmraQ9V6VqI1TXTKJfUJfXfcYtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PxPdOY0lSV4rVKBD8gJpn9GbEQuHj1lvy0aweMzYXXE=;
 b=Sk7c9XcReIoQCVjNQ/ijxL3+AqGE9tFMaO/xyK1XWF2CL7jDY/JfmiCjaWhUZgJZHax2ezK6S9zLVfen9KH3rusvuQbAndWa6rFWk4BP6iui7mJC/WhB1/+VZF2oW5YGsmHjGzSAELhtnYeC10Jg/VuX5iU8iqf2YlkJfj5CXjw=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4512.namprd12.prod.outlook.com (2603:10b6:806:71::9)
 by SA0PR12MB4574.namprd12.prod.outlook.com (2603:10b6:806:94::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.16; Mon, 25 Jan
 2021 22:42:32 +0000
Received: from SA0PR12MB4512.namprd12.prod.outlook.com
 ([fe80::ed7d:d788:82d2:edd4]) by SA0PR12MB4512.namprd12.prod.outlook.com
 ([fe80::ed7d:d788:82d2:edd4%5]) with mapi id 15.20.3784.019; Mon, 25 Jan 2021
 22:42:32 +0000
From:   Terry Bowman <terry.bowman@amd.com>
Subject: Re: [PATCH] ACPI / APEI: Add is_ghes_type() to identify GHES sources
To:     Borislav Petkov <bp@alien8.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     James Morse <james.morse@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Colin Ian King <colin.king@canonical.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jon.grimm@amd.com
References: <20210122180322.1720413-1-terry.bowman@amd.com>
 <CAJZ5v0hoMe=XbwD-oRGiRxAia94JB1CfBiqEXGwan+pN5_pzqw@mail.gmail.com>
 <20210125171431.GI23070@zn.tnic>
Message-ID: <672fad2a-b8aa-25ab-ec0c-900e54f7ee2e@amd.com>
Date:   Mon, 25 Jan 2021 16:42:28 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
In-Reply-To: <20210125171431.GI23070@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [165.204.77.11]
X-ClientProxiedBy: CH2PR10CA0005.namprd10.prod.outlook.com
 (2603:10b6:610:4c::15) To SA0PR12MB4512.namprd12.prod.outlook.com
 (2603:10b6:806:71::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.10.186] (165.204.77.11) by CH2PR10CA0005.namprd10.prod.outlook.com (2603:10b6:610:4c::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.11 via Frontend Transport; Mon, 25 Jan 2021 22:42:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 40972004-6216-42ec-19cb-08d8c1828038
X-MS-TrafficTypeDiagnostic: SA0PR12MB4574:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB4574FB8A1DBFCD244DD8F19983BD9@SA0PR12MB4574.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1060;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xmnBUNnfGTd5QSf6Pu0LEBfclld7g5r9t4SbGxCSAhd1JDwVTbN9I4xPf54pUAKEaasxVtOCAOeGJ0xNEhMOQhJcKQ7S3F0CHBZ8nHjg1WWyQrkMDhUWJ0LSl2wijMeTeRsVkMhGBGEBh3TAlVqWjO2Y7ZjIQyQCw0VS0bydzYP4C2DhpA18D9EDu6uVHQiTEPk5FFUOC/Q4Z406iut5pWJCLeh2fyLVcLoUqZ8ocKnRTxGNbn/NvE9+px8MH4QqyEUC3AIuz7wv3HN9ccXPYlEgskoEBLiihTd6rYd8KTGM/X9+xddWJ7D9FBC071+v11g5hffvGV2eXCVPb97WxzNJZEFBWRh+teWXVh3GNppaXLhUaPwXxdaprlfWMvL/0vPo5MV+0JQ7dRRjjKn4EAiGqHSKQ+/6nLVStPl98t/Tm63RagwqDh/MpZWwyVHT4i3WbZyLZbFMKigUAHdXSk2eslB3Sy85CnqNjFirI/8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4512.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(136003)(396003)(366004)(39860400002)(86362001)(54906003)(31696002)(66946007)(110136005)(52116002)(956004)(7416002)(5660300002)(66556008)(83380400001)(478600001)(8936002)(44832011)(2906002)(4326008)(66476007)(53546011)(16526019)(6486002)(186003)(8676002)(26005)(31686004)(36756003)(16576012)(316002)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?NXhQcXBMUkdFSUFUZU5lNW44NVNTMW13eWltMDZiQVhnc1lDTGpWY0xyeEZ3?=
 =?utf-8?B?UURUMjZQaVVlZnJ5ZExZdVVJV2NVMWhSSDBzQmVlMEdtUVlKMkhoN1RJKzR5?=
 =?utf-8?B?bWd3b2FVZ1M5TWEyMlI5QjBRK0d1Q2JlM0R6YzN5blRsS2F4dUIxSlEvTklq?=
 =?utf-8?B?ZmgzdGwxRkllNlRQbVgrczlsYlVURGx4bUZaSGFCcFFLcUNYVkR0M3dzdEdx?=
 =?utf-8?B?OGJlVHA3bkQxK3h4VjR3Qnl2aEFTV1R3RDVQRXlhQkpRRW1mbTZiZ1dyZWdN?=
 =?utf-8?B?NVRtK2I3ZSs0dlJkTU1TRHZ1eGFkY2E3N2ZtUUhXSVR4YTBOMzhlVE9XQ21h?=
 =?utf-8?B?Tnpnc0NQbG5BZ1hGSnViZEZnR001ZnF6OXZocC93MUN2SzlDKzRFSUlGRE1G?=
 =?utf-8?B?RHVZeHVZb3J4MktXeUxPclVIekdWSnhiNFI1VWwrUHVwaXZvSms3NE9yd0VN?=
 =?utf-8?B?NGVmVmRpTCtuOXJnQ0FFenBEbldHbWJrdWJBVUs0VkZZL1pvNGhESW14cGY2?=
 =?utf-8?B?Q2dMNytiNGtaQnprcVgrN0xnVEpENENaZC8ybDAyeWRGc05zRllPR0Jmc3Ir?=
 =?utf-8?B?QmJqSklFSGJzRTN0TEsrSmlhbVkxZ3pGeDhwR2NKNnVob0NrWEJaeXdoUnNY?=
 =?utf-8?B?M1htMnhPY0ErZldleWJwc3IzMHg1VjdFT083cElyU3VueFhMUHd6cDlRMXRo?=
 =?utf-8?B?T3JGWE1obHZvSTFRSENvNE80c0hKWXlnZjlpQSs2SlZKZWVMMHZiWEdnUWNI?=
 =?utf-8?B?SWRQUE01SHpwd2tSNjFNd2gwSXJkUGZ3MHF3NnZUOC9xK2J6TW5EVUgrQlFy?=
 =?utf-8?B?UGxVajdzK3NIM0Rpb0xtSFZ6UjlKeStjY05KMk1FdUwwWGdKVUxtd2tIdFV5?=
 =?utf-8?B?S2RKWXYzZHhpSjc1alcwU21STmNBZ1hyYnRpbGs5OWVPK1c1THAvNFdHNDZI?=
 =?utf-8?B?ODU5MWZwam90Qit0eXhmd0xwYStTdXFJUUxhdWZhT1YzanY4b04wK083MHRS?=
 =?utf-8?B?SnJhVHoxQ1Q3ZEZYTElHdGRVMWdmcTdqcHNwdUdHYkJmZitISFNPaHZiNk4z?=
 =?utf-8?B?U3plYm0vVURaNEhxSjlMVjJ1WE5adkY5U2Y3cDFWWW50SlBxZXZGbVRZdDhs?=
 =?utf-8?B?SUFDWjJwMXczTlM1OHN5MGpQTHBRUXBQV3lKL0o3QVQraEJoUGIyNjlEWHQ3?=
 =?utf-8?B?YnVweFd5YmJZOWFIczVkRlQzMVBUMjgxeXEyTUFwemlXRG8xWnJxS2l4Rm5U?=
 =?utf-8?B?M3NNWUpqL21IZ20vVXRuVmtSOXdweW4xT05nVDNLNlJsQXVobCtNS1RjOGNH?=
 =?utf-8?B?VGNSUmxBcjVudlNKcUYvWXBkR1YvSjIrU2pSZURFajZMSThPZG1aYWRmWlRS?=
 =?utf-8?B?YVA4Um1WZTRHZUZhVnVJZ2NZb1RZZHZKbWVJTmIyTFJmdXFobjh2ZGczVVJk?=
 =?utf-8?Q?uU/Lpnf4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40972004-6216-42ec-19cb-08d8c1828038
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4512.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2021 22:42:32.1013
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s3mimjt9gq+Pvr86agqxDLlyz4W3KwLQ38Ngd9MBmEyW0XjW6tlB0UpNIlP0Aa50mRHxl7hNf/2BYgMtPF7NaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4574
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 1/25/21 11:14 AM, Borislav Petkov wrote:
> On Mon, Jan 25, 2021 at 05:41:04PM +0100, Rafael J. Wysocki wrote:
>> On Fri, Jan 22, 2021 at 7:05 PM Terry Bowman<terry.bowman@amd.com>  wrote:
>>> From: Yazen Ghannam<yazen.ghannam@amd.com>
>>>
>>> Refactor duplicated GHES identity logic into is_ghes_type().
>>>
>>> Signed-off-by: Yazen Ghannam<yazen.ghannam@amd.com>
>>> Reviewed-by: Robert Richter<rrichter@amd.com>
>>> Signed-off-by: Terry Bowman<terry.bowman@amd.com>
>> If Terry was a co-author of the patch, please add a Co-developed-by:
>> tag for him in addition to the s-o-b.  Otherwise the meaning of his
>> s-o-b is unclear.
I will add "co-developed-by" in V2.
>> Boris, James, any objections to the changes below?
>>
>>> ---
>>>   drivers/acpi/apei/hest.c | 12 ++++++++----
>>>   1 file changed, 8 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/acpi/apei/hest.c b/drivers/acpi/apei/hest.c
>>> index 6e980fe16772..bd702e0ef339 100644
>>> --- a/drivers/acpi/apei/hest.c
>>> +++ b/drivers/acpi/apei/hest.c
>>> @@ -49,6 +49,12 @@ static const int hest_esrc_len_tab[ACPI_HEST_TYPE_RESERVED] = {
>>>          [ACPI_HEST_TYPE_IA32_DEFERRED_CHECK] = -1,
>>>   };
>>>
>>> +static inline bool is_ghes_type(struct acpi_hest_header *hest_hdr)
>>> +{
>>> +       return hest_hdr->type == ACPI_HEST_TYPE_GENERIC_ERROR ||
>>> +              hest_hdr->type == ACPI_HEST_TYPE_GENERIC_ERROR_V2;
> I realize that this is supposed to test whether the table point to a
> generic hardware error source but everything in our code pertaining to
> GHES is called, well, "ghes".
>
> So I'd prefer to call that is_generic_error() or so.
Sure, I'll rename is_ghes_type() to is_generic_error() in v2.
> Thx.
>
