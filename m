Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C3602C393C
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Nov 2020 07:47:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbgKYGpr (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 25 Nov 2020 01:45:47 -0500
Received: from mail-dm6nam11on2056.outbound.protection.outlook.com ([40.107.223.56]:45441
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726027AbgKYGpr (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 25 Nov 2020 01:45:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aAIFHb4siDKV/aZ75CuxWwP7jjuM0TWmP+UN20lnweKhdlQB0yGdhWUuNm7EwRpxrSn4wLCqttHS4832SvkjoJTlBMHI5TmpF6EWyDWIYhp+4ONoQ+5nNY8nsXcgcgeza1pcCqnMrlqeKg6HLC+OKjz7y+WIOh07QshgOjR+zmQVfeBa4mIpN+alo2GMn8J7jPYrLRqAw4lzxQi/RI3ui875pgNtkokjrON+dIJG9aMV9Ld91idvJC72jnOA3HGZ05ZbOo4RHgQanPOZGY78jYQIDjwvZjl84whSUJ4AailwqbM6f2XLva7oJXrW/33yzjWg/bq0iPfhIUmtRhamgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FDkN02uVOo70lh1GgQTAgpd5NSota95a8zsyP239hMs=;
 b=GtTYsXCWM1qzuh6IfeqBxwDdvQFJHsxVTvgO6Wn+md8oP9Q9bnrnhFZsrZ31/+/Mt6Gj9cLnRuwCm7e0oIupiE1O8E1hww1/vzxaSXau+cQANL81yOGWtOZEBUy97nrMi0ysYQta68qPSQRI2yzHAm30DYrmFDe5xz1gPPJcx+62HrROI0oXHRrAbbuKu6nUGSZjuLM7OvoZeaHykKydLOQbYS3sIy6bGenImUrHmr1waKQJbZpH2SGvLQ7IIxz29PNepYGFF7FKAxChM6lTcsrxWRdZJGLfeMPtSpHO/TkZ9J22JV9xSkwTIDRMj1EmnGrNoDyr62Om1Pj+5oHlig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FDkN02uVOo70lh1GgQTAgpd5NSota95a8zsyP239hMs=;
 b=ebedf4buoA+7X99na+aCF1DHcdn8QKh717Kzaex0kqqAlssrQiz1KltdVcoVFgxw3FjokeJwPe3HEdZh5Pqt9LxAkRqRuAcLiztNxA6yrjtBjnh5Tp4VZdj3DbMjW8Jry1/9jfdqZOwz3gB2gHnqm8nkl686CHbyTB3u5GX5ABE=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2495.namprd12.prod.outlook.com (2603:10b6:802:32::17)
 by SA0PR12MB4351.namprd12.prod.outlook.com (2603:10b6:806:71::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20; Wed, 25 Nov
 2020 06:45:43 +0000
Received: from SN1PR12MB2495.namprd12.prod.outlook.com
 ([fe80::c9d:1af9:30b:c4ef]) by SN1PR12MB2495.namprd12.prod.outlook.com
 ([fe80::c9d:1af9:30b:c4ef%4]) with mapi id 15.20.3589.028; Wed, 25 Nov 2020
 06:45:43 +0000
Subject: Re: [PATCH v2] ACPI: PM: s2idle: Add AMD support to handle _DSM
 during S2Idle
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
References: <20201120060752.3146704-1-Shyam-sundar.S-k@amd.com>
 <CAJZ5v0jeoiZdgzKupakPn+82iur-nMLH3wEC07cHO1qyvoysug@mail.gmail.com>
From:   Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Message-ID: <e0cd4950-e19d-a158-c9c9-b6436854e663@amd.com>
Date:   Wed, 25 Nov 2020 12:15:31 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
In-Reply-To: <CAJZ5v0jeoiZdgzKupakPn+82iur-nMLH3wEC07cHO1qyvoysug@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [43.224.156.122]
X-ClientProxiedBy: MAXPR0101CA0064.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:e::26) To SN1PR12MB2495.namprd12.prod.outlook.com
 (2603:10b6:802:32::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.183] (43.224.156.122) by MAXPR0101CA0064.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:e::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.22 via Frontend Transport; Wed, 25 Nov 2020 06:45:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b366390e-2fb9-4d12-5811-08d8910dbae5
X-MS-TrafficTypeDiagnostic: SA0PR12MB4351:
X-Microsoft-Antispam-PRVS: <SA0PR12MB4351F9BB5316978631307CFC9AFA0@SA0PR12MB4351.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:81;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZkTzGTx/SS/PPY6tlk/h9xgNZc1eTxmtfoPPnHHnP1b2BT4HogPFQmv5QNTUnra6tL3AV4tDWmYmWUSkTCkZpLxAleunB5+wXNVxe3sJvG/756TTx9WggQfgCfYOH3mc1sxO58rrDc3vztOIWjXDmK+5NJEM/0zr8YpANarY8Ya20ZybQC6MaIBdp+hZVTkGApJrvMHj7NRhWODsjkL99J/QmDnD6yzDs1T2W8VExx4cxlwUEDh4MfUWVMS+v1RDzJbsZQbL9gfYbFBtXCXGQN8ZYZViJpDD9H0OMKdTSHy2xKBXGU6fEGrvt0rsv9iouXPNYqqUGTQOfhpGQKZSzHpPNvf/KmAxQv7DTuUHh4UAuEvIEaMI2QBZMTYL9WmcC3opgzJ4SbtAjcxJySpxojfPS2ww0XyDNrqgpjfEeaOjHEuxT6GPGk5o7hUHQ1pK9A/sdVkT1Cdh6eK2mVYXyw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN1PR12MB2495.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(396003)(136003)(366004)(376002)(54906003)(6916009)(316002)(16576012)(2906002)(4326008)(8936002)(966005)(52116002)(26005)(86362001)(45080400002)(66556008)(66946007)(66476007)(8676002)(2616005)(956004)(83380400001)(6486002)(31686004)(5660300002)(186003)(16526019)(31696002)(478600001)(6666004)(36756003)(53546011)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?aUNtSnFSN0FRT0tUUVY0UFNPV3Fkd1RwbXphOTZJRi90eWx0NEF4V2J3NTM5?=
 =?utf-8?B?bUlsUHRKNjc5REs3eHJqOHpqWHRBZWp3ckpuaWNyMWJSTHdON3daMW5kd3Br?=
 =?utf-8?B?a2ltcWJvVEYvRHRoMzN4SUN6VDdzYUI2Y0hEMFEyUmNNYW9JRkRTbVVmdC81?=
 =?utf-8?B?ZFZEWHZDWE5PMTc0MDBRQk1zNWRkTytlc1lHSkVvWmNTTkUwSWZWY21PNHVB?=
 =?utf-8?B?b2MvY3pEN1U2VFYvTTdQazl2UzNWa2FHYyt2QWpHb0xVeGw0RnNyZzlJUVpy?=
 =?utf-8?B?c0UzNHRKNlpTak0vUnVGNUdseHpqSWQvY1BKaDRZYVgwTmFGam9GbmRaNFV0?=
 =?utf-8?B?RCtvUjRHSHZZNkhKLzhEZDdLVEd3cUswY3FNNUxVcHN0SVREd1hZbXlqR29C?=
 =?utf-8?B?UUNpUFphYmZNOFBqcU43QlJPYnZERmdRK002NVVsRFlKWUE3bzZSUTduN0kw?=
 =?utf-8?B?SmVQZG9UZmk5eUt5dHZKMEhLZkJ2S0lXK1JYMzF0OTFGLzBueGU5ejdCOGxr?=
 =?utf-8?B?Vmc4ZkZtbXYzZElYOHN1Yy9QSFJuVktHanBqRHhhMDk2dVRzNnpMa2R2ODdH?=
 =?utf-8?B?VmF3SW9ZNWtDYkFtelFjSlBFYll6UXdXQ3dpSmcxa0l6dEdSdStZVnFRR3Bm?=
 =?utf-8?B?aElCdHpJazc4bnpPSGdHd0kwQ1NSWU9GYzhZcHYyWEJYODJKNTFpMHp5UW9U?=
 =?utf-8?B?Z05LZjErb0VjRjBiRitvTmtTbThxSTBXbFd4cDNYdzhYSEhqQ1Q1S3BzMFpV?=
 =?utf-8?B?U1dhQ25oYXJXTkVHdmtSMU9Vc01nN3A4aVBJMjF4TFV5U3BzVTRRTjI1UzlP?=
 =?utf-8?B?VnFOK09BcWpsWnk4N2FZaEJjblVoRWdHa04wNXpYU25idi9aZlM0NnB0T0pI?=
 =?utf-8?B?bUdkcGk2RnlnNWhsT3VIdFk2Rm03VVUxVE9kbVVVQnpEWnAvOWRDZUl1Slo4?=
 =?utf-8?B?UTNGdGJBeFp2VndtV01Vb1EvaFNtVlNVdExNaVlEbWhRbFZRaExvYW9mb1dV?=
 =?utf-8?B?eVN2Z2pDS0ExWFRiRG1LOU05NDJGSlN5dFFBZ24vRnNIMFBkWW5BNXhoV0Ra?=
 =?utf-8?B?S3I1cVJYaDZ1c294enVTUG44VjBEaDBZSExBeTI0WUZWL2ZuWHFHMzl4Rjhk?=
 =?utf-8?B?Z1ErcGxFRThYZ3YrM092aXZYRzV4dk4zdEpSVkppVzF4ZkxhVFZMcWJoaG1a?=
 =?utf-8?B?ai9FSS9ReVFPQjY0QjVmTXBRd24rbU55enRMbG0wY1M0alEwbm11cXZ1akdr?=
 =?utf-8?B?aHFsaFA2WlhNQ3hvNkxYamRST2JPeE9HNTFwYVVTb0Q2a0xYZ3ZGQm5qYmZy?=
 =?utf-8?Q?ACdjZM+EylVmTubqL+uTFOxo5hx60sBI8o?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b366390e-2fb9-4d12-5811-08d8910dbae5
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2495.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2020 06:45:43.1978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rYEPIv/xrxzB3EMdpb2Wf7mIXK2oi6G+gN+fQeMgJOKkrEwgD7hSWNof6gsF2bxJwT2SV8jvD0WiFM5uk2qEog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4351
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



On 11/23/2020 10:15 PM, Rafael J. Wysocki wrote:
> [CAUTION: External Email]
> 
> On Fri, Nov 20, 2020 at 7:10 AM Shyam Sundar S K
> <Shyam-sundar.S-k@amd.com> wrote:
>>
>> Initial support for S2Idle based on the Intel implementation [1] does not
>> work for AMD as the BIOS implementation for ACPI methods like the _DSM
>> are not standardized.
>>
>> So, the way in which the UUID's were parsed and the ACPI packages were
>> retrieved out of the ACPI objects are not the same between Intel and AMD.
>>
>> This patch adds AMD support for S2Idle to parse the UUID, evaluate the
>> _DSM methods, preparing the Idle constraint list etc.
>>
>> Link: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fuefi.org%2Fsites%2Fdefault%2Ffiles%2Fresources%2FIntel_ACPI_Low_Power_S0_Idle.pdf&amp;data=04%7C01%7CShyam-sundar.S-k%40amd.com%7C640970e0f42a4fd53a1408d88fcf25d8%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C1%7C637417467581911776%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C2000&amp;sdata=xPFj5OymQkr3xEaU8qQD1y8O95XCszUblRRuknNvD7I%3D&amp;reserved=0 # [1]
>> Signed-off-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
>> ---
>> v2:(https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fwww.spinics.net%2Flists%2Flinux-acpi%2Fmsg97104.html&amp;data=04%7C01%7CShyam-sundar.S-k%40amd.com%7C640970e0f42a4fd53a1408d88fcf25d8%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C1%7C637417467581911776%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C2000&amp;sdata=r5whv52ruKVbFgsV1qEuWKeePaUQhjXnxQwF7izFRf4%3D&amp;reserved=0)
>> - Remove default case in switch.
>> - Add a routine acpi_match_vendor_name() required when building on a
>>   non-x86 based environment.
>> - Fixed spelling mistakes.
>> ---
>>  drivers/acpi/sleep.c | 166 ++++++++++++++++++++++++++++++++++++++++---
>>  1 file changed, 157 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
>> index aff13bf4d947..b929fd0d2e04 100644
>> --- a/drivers/acpi/sleep.c
>> +++ b/drivers/acpi/sleep.c
>> @@ -710,6 +710,11 @@ static const struct acpi_device_id lps0_device_ids[] = {
>>  #define ACPI_LPS0_ENTRY                5
>>  #define ACPI_LPS0_EXIT         6
>>
>> +/* AMD */
>> +#define ACPI_LPS0_DSM_UUID_AMD      "e3f32452-febc-43ce-9039-932122d37721"
>> +#define ACPI_LPS0_SCREEN_OFF_AMD    4
>> +#define ACPI_LPS0_SCREEN_ON_AMD     5
>> +
>>  static acpi_handle lps0_device_handle;
>>  static guid_t lps0_dsm_guid;
>>  static char lps0_dsm_func_mask;
>> @@ -733,8 +738,124 @@ struct lpi_constraints {
>>         int min_dstate;
>>  };
>>
>> +/* AMD */
>> +/* Device constraint entry structure */
>> +struct lpi_device_info_amd {
>> +       int revision;
>> +       int count;
>> +       union acpi_object *package;
>> +};
>> +
>> +/* Constraint package structure */
>> +struct lpi_device_constraint_amd {
>> +       char *name;
>> +       int enabled;
>> +       int function_states;
>> +       int min_dstate;
>> +};
>> +
>>  static struct lpi_constraints *lpi_constraints_table;
>>  static int lpi_constraints_table_size;
>> +static int rev_id;
>> +
>> +static void lpi_device_get_constraints_amd(void)
>> +{
>> +       union acpi_object *out_obj;
>> +       int i, j, k;
>> +
>> +       out_obj = acpi_evaluate_dsm_typed(lps0_device_handle, &lps0_dsm_guid,
>> +                                         1, ACPI_LPS0_GET_DEVICE_CONSTRAINTS,
>> +                                         NULL, ACPI_TYPE_PACKAGE);
>> +
>> +       if (!out_obj)
>> +               return;
>> +
>> +       acpi_handle_debug(lps0_device_handle, "_DSM function 1 eval %s\n",
>> +                         out_obj ? "successful" : "failed");
>> +
>> +       for (i = 0; i < out_obj->package.count; i++) {
>> +               union acpi_object *package = &out_obj->package.elements[i];
>> +               struct lpi_device_info_amd info = { };
>> +
>> +               if (package->type == ACPI_TYPE_INTEGER) {
>> +                       switch (i) {
>> +                       case 0:
>> +                               info.revision = package->integer.value;
>> +                               break;
>> +                       case 1:
>> +                               info.count = package->integer.value;
>> +                               break;
>> +                       }
>> +               } else if (package->type == ACPI_TYPE_PACKAGE) {
>> +                       lpi_constraints_table = kcalloc(package->package.count,
>> +                                                       sizeof(*lpi_constraints_table),
>> +                                                       GFP_KERNEL);
>> +
>> +                       if (!lpi_constraints_table)
>> +                               goto free_acpi_buffer;
>> +
>> +                       acpi_handle_info(lps0_device_handle,
>> +                                        "LPI: constraints list begin:\n");
>> +
>> +                       for (j = 0; j < package->package.count; ++j) {
>> +                               union acpi_object *info_obj = &package->package.elements[j];
>> +                               struct lpi_device_constraint_amd dev_info = {};
>> +                               struct lpi_constraints *list;
>> +                               acpi_status status;
>> +
>> +                               for (k = 0; k < info_obj->package.count; ++k) {
>> +                                       union acpi_object *obj = &info_obj->package.elements[k];
>> +                                       union acpi_object *obj_new;
>> +
>> +                                       list = &lpi_constraints_table[lpi_constraints_table_size];
>> +                                       list->min_dstate = -1;
>> +
>> +                                       obj_new = &obj[k];
>> +                                       switch (k) {
>> +                                       case 0:
>> +                                               dev_info.enabled = obj->integer.value;
>> +                                               break;
>> +                                       case 1:
>> +                                               dev_info.name = obj->string.pointer;
>> +                                               break;
>> +                                       case 2:
>> +                                               dev_info.function_states = obj->integer.value;
>> +                                               break;
>> +                                       case 3:
>> +                                               dev_info.min_dstate = obj->integer.value;
>> +                                               break;
>> +                                       }
>> +
>> +                                       if (!dev_info.enabled || !dev_info.name ||
>> +                                           !dev_info.min_dstate)
>> +                                               continue;
>> +
>> +                                       status = acpi_get_handle(NULL, dev_info.name,
>> +                                                                &list->handle);
>> +                                       if (ACPI_FAILURE(status))
>> +                                               continue;
>> +
>> +                                       acpi_handle_info(lps0_device_handle,
>> +                                                        "Name:%s\n", dev_info.name);
>> +
>> +                                       list->min_dstate = dev_info.min_dstate;
>> +
>> +                                       if (list->min_dstate < 0) {
>> +                                               acpi_handle_info(lps0_device_handle,
>> +                                                                "Incomplete constraint defined\n");
>> +                                               continue;
>> +                                       }
>> +                               }
>> +                               lpi_constraints_table_size++;
>> +                       }
>> +               }
>> +       }
>> +
>> +       acpi_handle_info(lps0_device_handle, "LPI: constraints list end\n");
>> +
>> +free_acpi_buffer:
>> +       ACPI_FREE(out_obj);
>> +}
>>
>>  static void lpi_device_get_constraints(void)
>>  {
>> @@ -883,13 +1004,22 @@ static void acpi_sleep_run_lps0_dsm(unsigned int func)
>>         if (!(lps0_dsm_func_mask & (1 << func)))
>>                 return;
>>
>> -       out_obj = acpi_evaluate_dsm(lps0_device_handle, &lps0_dsm_guid, 1, func, NULL);
>> +       out_obj = acpi_evaluate_dsm(lps0_device_handle, &lps0_dsm_guid, rev_id, func, NULL);
>>         ACPI_FREE(out_obj);
>>
>>         acpi_handle_debug(lps0_device_handle, "_DSM function %u evaluation %s\n",
>>                           func, out_obj ? "successful" : "failed");
>>  }
>>
>> +static bool acpi_match_vendor_name(void)
>> +{
>> +#ifdef CONFIG_X86
>> +       if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD)
>> +               return true;
>> +#endif
>> +       return false;
>> +}
> 
> Well, I still don't like this (explicit CONFIG_X86 dependencies are
> not welcome in this file), but arguably the damage was done before
> already and there is a bunch of X86-specific code in here anyway, so
> I'm going to take your patch provisionally and rearrange the code on
> top of it so as to relocate the x86-specific part of it into
> acpi/x86/.
> 
> Thanks!

Thank you Rafael!
