Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C43771A0BB
	for <lists+linux-acpi@lfdr.de>; Thu,  1 Jun 2023 16:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233670AbjFAOpz (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 1 Jun 2023 10:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233644AbjFAOpy (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 1 Jun 2023 10:45:54 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2063.outbound.protection.outlook.com [40.107.220.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F676134;
        Thu,  1 Jun 2023 07:45:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FBDIdDD6OPRAib7S0Bf0WC4a6hcPgc2KC9y2vak3/hKIOWwHBy/hli4mTk2QA1St4SZe7q8wtAaaEtZft3P9RVa2ZY789UliBiDpOqKKFQoL5dvEtNLOvxCBOLV54kIp8M1/oiCzT73AXQNs/iEWN3IrVUR+0km6JFWx6kXP9sCSxZwZPF00fEQSqrRpt/OJn1XiVQFu9PYv83lB3E5h7W2X3lnAGcq1p9S5bkSCLaNB/I429JQgrsLLs6pGEUnNM3OTbfYTdckJKBZfArLWZIDghokAWTNClO29ju3CsOkfB8yYLw+BIe+y3cpUB0RsmhtyFlc9jbymPvWfn4BjgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lC0V1snSCpdv86bo9gkQXb4XRAB+WizRibfIhd3MYhI=;
 b=giu/uTgiEt6giqO0ez2cpYkIBOqgWPpCeEAGnuCow3zj4y+CfGDd+2z9r8evdDC6/KVhUtPC2xJDTfeGzxN4sjRTIU92kgItJ2EYRlJMfVg8inwV9F6uIPKUSGomBSJLflFnLFrkHA17b3XiyK3L5q0tj/B65rQkPDWUS95FKjj2d93hyCnqNeZoGGYvlbeGj7nc4k37y8UFjPfb2sKdXX0I3wJ6BTk+f/sapZlDsALed9iDAdSV9qAVn5uoMrTFNkZLsVloBqNA5iftZqxGXp39BbrX2AM47HPlGtEhcZTNc6fe2K8a0HA8V2qHKQFPzkmxOA4o8PR2OHZi9041nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lC0V1snSCpdv86bo9gkQXb4XRAB+WizRibfIhd3MYhI=;
 b=TctjyvA8QuFxzFbi8cwrxejIvnubw2TcuflUDfkQeV4+vkQt61qncrDHHCB+qf6qppn7V4fCc3aDvgxsUUVceiKmrJVPO2HLzTecEsVyOg3xT9dR7Lp6AlYqMwjj4/iPg6H4Ku2KRnPQMsE2+osROj6qVduIau2eJtbd2I6b7mw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3268.namprd12.prod.outlook.com (2603:10b6:408:6c::18)
 by DM4PR12MB5232.namprd12.prod.outlook.com (2603:10b6:5:39c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.23; Thu, 1 Jun
 2023 14:45:08 +0000
Received: from BN8PR12MB3268.namprd12.prod.outlook.com
 ([fe80::bff2:b08a:4624:ec2]) by BN8PR12MB3268.namprd12.prod.outlook.com
 ([fe80::bff2:b08a:4624:ec2%6]) with mapi id 15.20.6455.020; Thu, 1 Jun 2023
 14:45:08 +0000
Message-ID: <20c70180-277e-4682-c3c4-27a53d9ed353@amd.com>
Date:   Thu, 1 Jun 2023 09:45:01 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
From:   Ben Cheatham <benjamin.cheatham@amd.com>
Subject: Re: [PATCH v2] ACPI, APEI, EINJ: Remove memory range validation for
 CXL error types
To:     Dan Williams <dan.j.williams@intel.com>, rafael@kernel.org,
        ira.weiny@intel.com, alison.schofield@intel.com,
        vishal.l.verma@intel.com
Cc:     yazen.ghannam@amd.com, linux-cxl@vger.kernel.org,
        linux-acpi@vger.kernel.org
References: <20230403151849.43408-1-Benjamin.Cheatham@amd.com>
 <6477bcbf96b48_168e2943b@dwillia2-xfh.jf.intel.com.notmuch>
Content-Language: en-US
In-Reply-To: <6477bcbf96b48_168e2943b@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0072.namprd11.prod.outlook.com
 (2603:10b6:806:d2::17) To BN8PR12MB3268.namprd12.prod.outlook.com
 (2603:10b6:408:6c::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3268:EE_|DM4PR12MB5232:EE_
X-MS-Office365-Filtering-Correlation-Id: 3aed798a-318c-4947-489d-08db62aecbb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: if5lPbBnuMixL5mCAL1vsqvCPXYpgj/NrVNVoTkPy30KBdZ/ubPto4cIY1n+Awuj4B6DNuR9ibk0vWen9rjv75Gv6mbmVDk2P36xzgpe9e6vtCln5HKnb4byL80YkIOGczFYfsunY1fVdZFnfNKXBi/u2KubprveXDmj7VBrv9RVj+KL45/NtkkXHNiUEaBkYwuDUV80o6ZKSPLcMUN1e5YfVkbB6xK9VYhhRWma7qcvAmDKhxhuBfeaK/pmL00V2IUngHtv/euT2Pxyos1sV9CQjgz9xT0xLyMCMcT8qECcKYI+c7JcqmbNTwQp32b5a5LzMRHTu705e8bjLpuHl2ETxFnp1bRtmUybIeo2eMX227K/GJgQ51Hgp1Df/W7dZ4blFm4BveW82epjX18eGc4TDO/ivkVY2KlqmCnIh/EQ9lpUfVp0ZbNYgnzJzM7TLZEzlR2b1Hnr1OKIoZgh2D11ZMFp1XDhET5w9BmEkV09I+mp5cn6SJfE1/Ltzi8wyttRPn36ahS78uG81n9/+GsWafjhs8/bw7X9u0pRswwYCr5ngcEKdG4Up1aZxQVELaMpf+hRT1hz/QKl7Dqypk0ey6xSJcRkp7m/aOuql0wN4epNSrqf0IBL9UqJUzdEq+3xJbe/Als7ZjUk7GFZzp+4QBlbZyqjYUEyfNN3KG/TGIeYtDlNSwmEJVSbLZxO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3268.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(366004)(396003)(39860400002)(136003)(451199021)(966005)(6666004)(6486002)(478600001)(186003)(36756003)(26005)(6506007)(6512007)(53546011)(83380400001)(2616005)(38100700002)(86362001)(31696002)(316002)(4326008)(41300700001)(66946007)(66556008)(66476007)(2906002)(31686004)(8936002)(8676002)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q3VsbHhRRXpPbUQvWG5uS3FhZWlYanpRb29xMkc0VmZZM2RkR2lkZ213bFg3?=
 =?utf-8?B?RXZaL29FVFNDekw1alJFenhRT3hIMGNHeFl5RDc4NG1jWXM0Z1F1R0twb1ZM?=
 =?utf-8?B?M292TnJIYXp1VUdFU2s0eFNrZTFyMDdDVkhDcm94cithTU5uYUNveThxaERT?=
 =?utf-8?B?ZVExdU1laXBualB0SFh4UVZwMXp3ODhDR0pWdXVtY3RDbDBnVHRGUC9aR2tI?=
 =?utf-8?B?RTdST093TTJ3NVFEcysrNkJXeEhFVjJjWk5HUFBudWhqNHBUZFpXckpOOFN4?=
 =?utf-8?B?dXRyNnJiVjdBZjJlRXZiaFlqS2krZExZMDhONWtlYVgvaHFmTXdLdzdCU0xz?=
 =?utf-8?B?U2NoVE5rRlpuUzJNMXB6MjdyemtGRDRxSHhBMVdrT0NCOFA2K3JadHhXT1NN?=
 =?utf-8?B?OXhNYXhYNllEbEJhZFNDZHQrTm40UHcwNmQwclF4a2pTSW8vS0NUdktWWkIv?=
 =?utf-8?B?SVNXVlZuSHBaVVljQjNRNEhPNjlNb3VPMXI3OUJ2alhlN204K1h6QzJxMTRH?=
 =?utf-8?B?ckx0enlZaHd6R3dIVUcxdjZndFgwVlZhZ0k4TWM2cWZYK0J3M1JzdFk0MHJz?=
 =?utf-8?B?TnRSRHM1ZVh3QW9SVXR3VTkrTnlxcnY2c2dCOWJpdGhzZE92U1NSZ0ZZbnUz?=
 =?utf-8?B?b2VwSlJNeVUrTG9nTG5qWkFDbWdDWVlab1djaWhGOTVpVUpvZDN0dW9UeVJR?=
 =?utf-8?B?cVE0NS9GK0dRYk90QTdJeUtNb3hER1RneVJ5VTIyQTB6UWkxUTZ6OUhHVFI3?=
 =?utf-8?B?QWdkM1kvMjhkZmVld0pZYW9BcDNpcFJSWUcyNGRkMXRaOEJIT2F2aGRjVzhL?=
 =?utf-8?B?aXZUd3ROWXdzWndJalJacnMvRXBlUTM1aFFndHJubXIxNXpKUDZleGVCNmhM?=
 =?utf-8?B?bk9YMVNuYms0SjlNRm54NmswMVhEaTFJQUJ0Ynh1K2M3b1V6dFdOaUlqVWR4?=
 =?utf-8?B?Q24zc3QxbU9aNk5naERYS2hEVlJJdDRzaWxPaTVwa2cyZnM4TUxEVzVwd0xa?=
 =?utf-8?B?OFV1TXo4SWZBSmc4STZ3dkZ2Y1lMUnBwZUZmbmlmQ3NZQTFiNjdnOHBJUENG?=
 =?utf-8?B?R3RkR0IzcW9Vd0JVdWJJVkltQy90TkRaM3pWWGMvRWYxb0VacWpFU056UjdR?=
 =?utf-8?B?TS93cFNCU0FjUURNR2tuWjFOai9YcUhwWWQxM01UcG45ODYvZkJkY1RuR3lB?=
 =?utf-8?B?bUdpODBqQm5TVUUxNUtFMU5ZU256MnJNWGNEQzB3WnBYOWM2cmcwamtjREZI?=
 =?utf-8?B?VnQwTTdiVi90eTJUL2NYQXliR0o5K0lXcitoMUtoU3A2RXV1WEhSSW5pY3pZ?=
 =?utf-8?B?WnZjdGlaMHJVTk03YThhMzR4ODJDS3BWT1RxWWs0MnVsMjdWTWFiK2VTMi8w?=
 =?utf-8?B?eS9SRzVZc2o5TForUThqM3NnYmUzZ0drODNiV0FiTmhyYWlvY0pFd29Ndi9I?=
 =?utf-8?B?T1ZYdzkyRXlRdGF3SXhCdG4rTGJFZ0xZQnB6TnYxYkFsc0lXdXRabk90THpL?=
 =?utf-8?B?N0FESjllYVBUV3J5djFRcXdzR1dBSHh3K0NheG9DSytoNFFTNWdhUGREZ2w0?=
 =?utf-8?B?RW9jcjVXa290MmorNHhOMDlrUmI4MEt2Y3QyN1hKVmxKeUMzSnRZV3hCdk5T?=
 =?utf-8?B?RGQxclByY0NWZXhaMHNkbVd3bkoxYnU1UUxGWDI0RDRZcVZLU1IvUGpDUk1x?=
 =?utf-8?B?RHQwUmNYUDlHSjQ2enkzaXVVWUJoS2xyTkwyZWwzemlLVmd4YTdKS0Z0Q0hB?=
 =?utf-8?B?YWhIdzRYbmhTWSt0NG9ycTdQYnRVeGljeTJIY29tS1JRbE9uZ1oyb0Z1RmJa?=
 =?utf-8?B?NWh5ZjlDV1Y1RFprbWkrSXlZOUVWTUU1R0xVNzcyUjNqSFY4ZGNlYlJNZm9O?=
 =?utf-8?B?d1JPbUY2VklwNHlrYWQxUHJQRmpRaTllMlpXcHZVNWhwT2IwU2l0VkxQNFJZ?=
 =?utf-8?B?QnZLTGJHWmZBQTlEVko1NEE2YzdFSGZuSGNrSVh3VGZsR09qWkQrT01kdlBC?=
 =?utf-8?B?bkYxQkRneVVQNjQ0T01aQ21RQnAwZ0NTQWUzdC9sNDdWVGUxL01NMy9nenFI?=
 =?utf-8?B?QU5zMXVpVmgxWlpwdHNVQ01MS3ptUmxveTRjUTZsUit4Qjk5QXpvUlRTakIy?=
 =?utf-8?Q?uQM7wI56pqwle+mgtwTNqFmal?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3aed798a-318c-4947-489d-08db62aecbb1
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3268.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 14:45:08.5975
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kO+7rQSisV/imVDb6sALQ4BiSEMQ5xiX3Lc0b1LyhP9IUjAoq07zwXOEg/emgIF/Cel8z+94DZ5IXmbxFSIw5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5232
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Thanks for the review Dan, responses inline.

On 5/31/23 4:31 PM, Dan Williams wrote:
> Hi Ben,
> 
> Ben Cheatham wrote:
>> From: Yazen Ghannam <yazen.ghannam@amd.com>
>>
>> V2 Changes:
>>  - Added Link tags for links
>>  - removed stray unused variable
>>
>> This patch is a follow up to the discussion at [1], and builds on Tony's
>> CXL error patch at [2].
>>
>> The new CXL error types will use the Memory Address field in the
>> SET_ERROR_TYPE_WITH_ADDRESS structure in order to target a CXL 1.1
>> compliant memory-mapped Downstream port. The value of the Memory Address
>> will be in the port's MMIO range, and it will not represent physical
>> (normal or persistent) memory.
>>
>> Allow error injection for CXL 1.1 systems by skipping memory range
>> validation for CXL error injection types.
> 
> This just feels a bit too loose especially when the kernel has
> the cxl_acpi driver to perform the enumeration of CXL root ports.
> 
> I know that Terry and Robert are teaching the PCI AER core how to
> coordinate with RCRB information [1] (I still need to go dig in deeper
> on that set). I would expect ACPI EINJ could benefit from similar
> coordination and validate these addresses.
>> Now, is it any address in the downstream-port RCRB range that is valid,
> or only the base?
> 
Response to above in your follow up email.

> Another minor comment below...
> 
> [1]: http://lore.kernel.org/r/20230523232214.55282-1-terry.bowman@amd.com
> 
>>
>> Output trying to inject CXL.mem error without patch:
>>
>> -bash: echo: write error: Invalid argument
>>
>> [1]:
>> Link: https://lore.kernel.org/linux-acpi/20221206205234.606073-1-Benjamin.Cheatham@amd.com/
>> [2]:
>> Link: https://lore.kernel.org/linux-cxl/CAJZ5v0hNQUfWViqxbJ5B4JCGJUuHpWWSpqpCFWPNpGuagoFbsQ@mail.gmail.com/T/#t
>>
>> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
>> Signed-off-by: Ben Cheatham <benjamin.cheatham@amd.com>
>> ---
>>  drivers/acpi/apei/einj.c | 12 +++++++++++-
>>  include/acpi/actbl1.h    |  6 ++++++
>>  2 files changed, 17 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj.c
>> index 013eb621dc92..68a20326ed7c 100644
>> --- a/drivers/acpi/apei/einj.c
>> +++ b/drivers/acpi/apei/einj.c
>> @@ -37,6 +37,13 @@
>>  				ACPI_EINJ_MEMORY_UNCORRECTABLE | \
>>  				ACPI_EINJ_MEMORY_FATAL)
>>  
>> +#define CXL_ERROR_MASK		(ACPI_EINJ_CXL_CACHE_CORRECTABLE	| \
>> +				ACPI_EINJ_CXL_CACHE_UNCORRECTABLE	| \
>> +				ACPI_EINJ_CXL_CACHE_FATAL		| \
>> +				ACPI_EINJ_CXL_MEM_CORRECTABLE		| \
>> +				ACPI_EINJ_CXL_MEM_UNCORRECTABLE		| \
>> +				ACPI_EINJ_CXL_MEM_FATAL)
>> +
>>  /*
>>   * ACPI version 5 provides a SET_ERROR_TYPE_WITH_ADDRESS action.
>>   */
>> @@ -537,8 +544,11 @@ static int einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
>>  	if (type & ACPI5_VENDOR_BIT) {
>>  		if (vendor_flags != SETWA_FLAGS_MEM)
>>  			goto inject;
>> -	} else if (!(type & MEM_ERROR_MASK) && !(flags & SETWA_FLAGS_MEM))
>> +	} else if (!(type & MEM_ERROR_MASK) && !(flags & SETWA_FLAGS_MEM)) {
>> +		goto inject;
>> +	} else if (type & CXL_ERROR_MASK) {
>>  		goto inject;
>> +	}
>>  
>>  	/*
>>  	 * Disallow crazy address masks that give BIOS leeway to pick
>> diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
>> index 81b9e794424d..c39837266414 100644
>> --- a/include/acpi/actbl1.h
>> +++ b/include/acpi/actbl1.h
>> @@ -1044,6 +1044,12 @@ enum acpi_einj_command_status {
>>  #define ACPI_EINJ_PLATFORM_CORRECTABLE      (1<<9)
>>  #define ACPI_EINJ_PLATFORM_UNCORRECTABLE    (1<<10)
>>  #define ACPI_EINJ_PLATFORM_FATAL            (1<<11)
>> +#define ACPI_EINJ_CXL_CACHE_CORRECTABLE     BIT(12)
>> +#define ACPI_EINJ_CXL_CACHE_UNCORRECTABLE   BIT(13)
>> +#define ACPI_EINJ_CXL_CACHE_FATAL           BIT(14)
>> +#define ACPI_EINJ_CXL_MEM_CORRECTABLE       BIT(15)
>> +#define ACPI_EINJ_CXL_MEM_UNCORRECTABLE     BIT(16)
>> +#define ACPI_EINJ_CXL_MEM_FATAL             BIT(17)
> 
> I expect these to come from the next ACPICA update just like the other
> definitions. The change in style from (x<<N) to BIT(N) was a tip-off.
> The process is to submit a pull request to the ACPICA project, for
> example:
> 
> https://github.com/acpica/acpica/commit/e948142526c0

I wasn't aware of this, I'll go ahead and do that.
