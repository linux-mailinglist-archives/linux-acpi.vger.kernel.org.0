Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBAC035E84A
	for <lists+linux-acpi@lfdr.de>; Tue, 13 Apr 2021 23:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231778AbhDMV24 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 13 Apr 2021 17:28:56 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:60568 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbhDMV2z (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 13 Apr 2021 17:28:55 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13DL99eM115740;
        Tue, 13 Apr 2021 21:28:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=vrI9h3AQGqM5K+zo8FhFAP836TgFhBqKGW4Ctv1BXCA=;
 b=f6fmQrE+aHCfL1ruDhV9N8QJSyz6cgrp78y2neUmTeXCE+ha4yNqo9mdDuOtJX9hZmpo
 UgKByCPiUG7K7nXe3Ofck2/6A5ezQWqDXzsn/mq77GNKj/bZjjZtrqQk1fosfi+BlRRI
 JKtxawsFb3AJjni48OdworEwKQKRl9dsWr4KPjilAE7OVS3RJZmeH/GkdsqmwLSzylmb
 Q/bDfiVw+dev14whno1BP288Y9mXhEK8zrbIF2vw3gr4VwW5jf6rET4IGrasmOAv0sxx
 a5xXyOQp7Q3q1vngf43C/HiQKMyA3bo2nRmKuar2CtxGxNiAlLN/4ZQv6MwVOJXFDMza eQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 37u4nngfss-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Apr 2021 21:28:26 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13DLGU67093752;
        Tue, 13 Apr 2021 21:28:25 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
        by aserp3030.oracle.com with ESMTP id 37unkq3777-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Apr 2021 21:28:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a3glfYNYTjpKqkJG/9MxAuZKqPuwk+aIMJilUcZR03C8p8d80D49jhSHlOIbhjGggi/XfT41ETCvsiS61/pFOujwoUeT0r+FVFURcumH0Hi5GQFJRzRXHsqPrqFDSA9Bxo8TOd+KHEV3a/GJPMdt76sIeTJPXdMVzBFzA/1p9hC0E6mA9bJqK8QcH+lFIM1dqWlKyO5qyFTs/Gq1GFJS1D3d+Srh0uo846furpLtTsDD5t860LPvEI45hhNrRLQpvdy6Z/Ne4d7RvMDL3sdONnYZKM/LKix97lQdz7c54MDiF/Yh8AQJ/cXf7FNX5UL3zfgSP6TTf+5yjCb8o1wE5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vrI9h3AQGqM5K+zo8FhFAP836TgFhBqKGW4Ctv1BXCA=;
 b=QS3pvFyEzXYnL7zafZaWWSYlYXjqEP688s6Nh8OKo5Aq9e3PTOxBfN5zbAVYL9l5RzCiEMHacGitYiD6yecAbTXRV5Y1+LUrMDCrVdLgZgKOgF5Ih0YvRZY7wQk1qEipf1fgc1RfwiTam86oYqnYp8toAANnkUVyovW2V6X6pThnHzHIw3b3pphgQwCFYlEBRs69DToxpuxlPFR216CI5Mr9X7FpUvZQ8jWcoPRbIyW6MifFXdYJhh72jB/+AI0/eaDTX+yskn5Emyhx+WTY8xZ/o1O0VlAAhVoo9MexqBApXiby0hNWUXT8wAgYm6at3vXC4u/yB0B8NmF5TPA1XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vrI9h3AQGqM5K+zo8FhFAP836TgFhBqKGW4Ctv1BXCA=;
 b=kmSrjfqQqJtOJ8NDCla+TNh4zULbU625oUyqzi48oqtoO/f9//lA+DU7qIe2GHsN3Klzhq4b8Bo2OcOO1Gxxr0vOHW/ky5Wz6/SbkZjSpmbIkVge7Cotm0p5HvWjbz03jn1ubRlDZ7iXI7+dmN7IySx99brdV7Eg6QlWedoCMqo=
Received: from DM6PR10MB3851.namprd10.prod.outlook.com (2603:10b6:5:1fb::17)
 by DM6PR10MB3436.namprd10.prod.outlook.com (2603:10b6:5:63::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.21; Tue, 13 Apr
 2021 21:28:23 +0000
Received: from DM6PR10MB3851.namprd10.prod.outlook.com
 ([fe80::e490:f9ff:f8f3:c1e6]) by DM6PR10MB3851.namprd10.prod.outlook.com
 ([fe80::e490:f9ff:f8f3:c1e6%7]) with mapi id 15.20.4020.023; Tue, 13 Apr 2021
 21:28:23 +0000
Subject: Re: [PATCH] ACPI: x86: Call acpi_boot_table_init() after
 acpi_table_upgrade()
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        x86 Maintainers <x86@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Dhaval Giani <dhaval.giani@oracle.com>
References: <11752259.O9o76ZdvQC@kreacher>
From:   George Kennedy <george.kennedy@oracle.com>
Organization: Oracle Corporation
Message-ID: <a3865ef0-6185-fdab-ffbe-8f5884e73486@oracle.com>
Date:   Tue, 13 Apr 2021 17:28:19 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
In-Reply-To: <11752259.O9o76ZdvQC@kreacher>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [108.26.147.230]
X-ClientProxiedBy: SA0PR11CA0181.namprd11.prod.outlook.com
 (2603:10b6:806:1bc::6) To DM6PR10MB3851.namprd10.prod.outlook.com
 (2603:10b6:5:1fb::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.246] (108.26.147.230) by SA0PR11CA0181.namprd11.prod.outlook.com (2603:10b6:806:1bc::6) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17 via Frontend Transport; Tue, 13 Apr 2021 21:28:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 222eb53d-4a82-4b21-7d19-08d8fec310de
X-MS-TrafficTypeDiagnostic: DM6PR10MB3436:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR10MB34360B86CCDA8185132FE5BFE64F9@DM6PR10MB3436.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QV3JASN1xhI30IMPCK5M4fk//GaukJynV3aoQSt+jb/ohGLdvItS/iyAJvEDvXxGX/3QbykVmXXS2gduwxaDDvQ5eeClNyv2TGEQKZPpqslF7z6WaoXczgVQse3e69XIKwrWkvxcFobJn7qpZzMQ+PzoKXvWVkj4S2emunGwqKLfsbPS8eHg1kY2VzqKy6LKE0+GF/U2RJ9lPdnjBONzR9QdiuITzMO+wSw0Qino8K7a9ea2fk1z5yPWIw+leFNdTeYLwPuO1WVFPkjgca31xttlEPcDzotUjVDRsH9AEvtylzyosUn0wxLXEiewPBCHCGAfRLISH4TV+fUeqneVH/U7hbL2u8bGk6cmLQn278H7WwlrGFgh7xnATUQC2CNmyDkIJwltFOcKO60Uk4SxyCwpl7GpAVzgVuk1bN8Pdr0KclZU1GSw6Evd1H8rKG5htvqnNLNBL3tIbtZeEB9x8q4XkM/YY2vjHUWcIjxEesWoGUX7lG3ujicF+Ud2j6hER879pcpfIjMAWkg2SHcSjhrWggUaLwgV2cdVNBXLg5ghzeLQT0QisHTsDVDi7KHBwb9llY1QDq4G97gqn8P1UembXol8mdjsukGeB05KfDNvYJ+fOkEk+keOn+Id1p+RDfDXPrJHf4hD4mNRu7pQbRSUJh+idN5e54tR1hcIN8mxx2a5DUvG4LuMWhp0ZFQY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB3851.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(346002)(396003)(366004)(39860400002)(956004)(2616005)(66476007)(316002)(5660300002)(66556008)(66946007)(4326008)(107886003)(44832011)(6486002)(53546011)(36916002)(8676002)(26005)(38100700002)(2906002)(186003)(8936002)(478600001)(31686004)(83380400001)(16576012)(54906003)(6666004)(86362001)(31696002)(16526019)(36756003)(110136005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?c21MTDZaRXltS0RKWGJXMjNoSVhIVzVKN3I5UFVKd1BrS0xyNFUrMEZia0lq?=
 =?utf-8?B?U0Jja3NZTjI1VDhnK2lQUXNNYktSRWZKdVE2M2tBUWtlalNZMEhGOXNsMGd0?=
 =?utf-8?B?RURaSG5XVjRQaXdTM1krYW5TRVpndkR3NytSaHVpajMvUkVNNThFMFZlZ0VP?=
 =?utf-8?B?VGxUOTdvakU5d21yS3ZCaWF0Vk1zV2pvUlNFRTZRbkxqUFI0bjhMekMxL2hJ?=
 =?utf-8?B?YTIwODAvSGhRdjVEd3BHT0dJeGNDMFRPWW4rampxNjZYZEFyQWp3OGJKUWQw?=
 =?utf-8?B?aWxWcTdoODZwSHhTWFVhOC9OK0pjenJ1V2c1NUpmNW42QnEzQlh4blkxRUx6?=
 =?utf-8?B?ZkprN3YzRDJQT1h5Qk4vaFRsY2dwb1RJdmFWMlhBTXo2WE8rOTVkR1Z2VWxu?=
 =?utf-8?B?U0FFQ3BQOEFiZGRBRTIzQjk1ajg4eVBqaS81b3ZQS0JMSjkxYVYrWGk0ZTlj?=
 =?utf-8?B?TFR0QXEvcDRweURpTmsrbnN0cEJ3K3kzdm1XYXVWK3RHOGlHcnJ4c2xDWk9n?=
 =?utf-8?B?V1kxNWZPM0tRVXRzL0gyYi9xeitNcVRqcVZzVlBQT2R2TVJQeWhjU2R0bWha?=
 =?utf-8?B?ejJZdmRxNDNyRXNWRHBqbmlTaFFoTlhkRkl1ZVBwa3QrVlF4RkN2L0dSL25H?=
 =?utf-8?B?Rjl3WTZmRzJqbnhrWVRxUkVUTGY0L2Q4aXdJMlB3Y3VhTHJwQTJ0ZnRQVkZS?=
 =?utf-8?B?Uk9GbWJjcGppL3UxMkY0NE1lZlU5dEJnYXFTUGpZUFp1RHB5Tm9uK0s3VE54?=
 =?utf-8?B?YkpjSjJPOVF0SjBBRzc4M3oyOCt5ZWVWaEZKR3Q5dHJmSEZ1VUdUbHZuNzBL?=
 =?utf-8?B?U2FhMGVGYnRtSml2UTNXcTBRc3k3eDE1VTBUaG5hblV5Zi9veS9iT3FUYVM0?=
 =?utf-8?B?aDNPWjJkSWJ2QkdNMXlCbUZMUHYrdGhTSGVERzF0SlZxYnErZjl5aWRvVmNJ?=
 =?utf-8?B?V3dlS3VhV3hhMnNsM29wKzJjRkt6aHFUcmUwdTlvUVpRR0VRMzRoR1VvQzNk?=
 =?utf-8?B?eFIwN0s2WlN6aEZkdjNhMDZ6MjFaaFhMYmsyVnQ3a20vRE92dEpZWm9vTFln?=
 =?utf-8?B?cVlTay9FRTRSaDdWenAzVXlXTTkwZkM4cU9pUXp3Z3J5ZWtUNVFtVGZVTnVB?=
 =?utf-8?B?VHJLSERYRGYwaHVhTG50Wk96c2Q5dnp2OGZhcnVjTTRYd2Uza3FmNmRGaEVM?=
 =?utf-8?B?bmdmSTFWaVFpUTkraTBzcEQySkk4blFKQjUzRkFJeUJiRGh4M3JBR1E3SzF2?=
 =?utf-8?B?QWgrZWo2S01jT1p5MnRZdlZuTkJiTnZNRmJvbWJqaFhVRWRReXVCdmJWY09J?=
 =?utf-8?B?TVFtakFzWVcwbCtIQnZ1L014TENXaTBMeGIxNlN3S1lrbW43cHZBaVRWejAv?=
 =?utf-8?B?bmdYVjdEeDJVK0RWZkMxdXBHL3YxVjVEd0ZZR1pvc0lva2ZZVVBMcElIdzNU?=
 =?utf-8?B?cXZHdW51azJGazFHZDhDT1VkUm1ISUhYK3ZwRDM5VnVyWEtWdjE5Ti80NVNz?=
 =?utf-8?B?OFJwYWxXOW40ZkhOMUZHdmk3UUwyMndEMytORytSZ1ZQQXZzeGpxYW9tTGJt?=
 =?utf-8?B?Q05TMFNndWo0ZWxDd0dxVUJjZW9vMmd2T2ZyM0FlV3ljVVhQMVFGMkQxZFhs?=
 =?utf-8?B?S0JjWThBUjFiQ241ZXRRek9vWFQ1N0h3amhUYXZBUk1DMVNkVzFzNkMxMnV3?=
 =?utf-8?B?VE9WVllwSXY5cmw2NWM4bllhbGhrMVh6V1FJYjRObC9TbFVQNy94THZrUGE0?=
 =?utf-8?Q?cUZjqDBBR41hlGC6cDcKS//LA9Pkc7WNmFEAR6w?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 222eb53d-4a82-4b21-7d19-08d8fec310de
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3851.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2021 21:28:22.9198
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XaIw0xRrumRqXJS8O6XpTF6uEuKX9bsJn0pKAyKAQn3xMvgv83vBA/0EujuZZvoryKueFeDmykaIqiHQvvHNGC+E/xZ+5hgtT1v/T6rBTIw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3436
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9953 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 adultscore=0 phishscore=0 malwarescore=0 mlxscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104130141
X-Proofpoint-ORIG-GUID: DRl2Pr4kf_gkEowCSNBmmndjuo2D58xJ
X-Proofpoint-GUID: DRl2Pr4kf_gkEowCSNBmmndjuo2D58xJ
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9953 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 phishscore=0 suspectscore=0 mlxlogscore=999 priorityscore=1501
 clxscore=1011 lowpriorityscore=0 spamscore=0 impostorscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104130141
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



On 4/13/2021 10:01 AM, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Commit 1a1c130ab757 ("ACPI: tables: x86: Reserve memory occupied by
> ACPI tables") attempted to address an issue with reserving the memory
> occupied by ACPI tables, but it broke the initrd-based table override
> mechanism relied on by multiple users.
>
> To restore the initrd-based ACPI table override functionality, move
> the acpi_boot_table_init() invocation in setup_arch() on x86 after
> the acpi_table_upgrade() one.
>
> Fixes: 1a1c130ab757 ("ACPI: tables: x86: Reserve memory occupied by ACPI tables")
> Reported-by: Hans de Goede <hdegoede@redhat.com>
> Tested-by: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>
> George, can you please check if this reintroduces the issue addressed by
> the above commit for you?

Will do.

George

>
> ---
>   arch/x86/kernel/setup.c |    5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
>
> Index: linux-pm/arch/x86/kernel/setup.c
> ===================================================================
> --- linux-pm.orig/arch/x86/kernel/setup.c
> +++ linux-pm/arch/x86/kernel/setup.c
> @@ -1045,9 +1045,6 @@ void __init setup_arch(char **cmdline_p)
>   
>   	cleanup_highmap();
>   
> -	/* Look for ACPI tables and reserve memory occupied by them. */
> -	acpi_boot_table_init();
> -
>   	memblock_set_current_limit(ISA_END_ADDRESS);
>   	e820__memblock_setup();
>   
> @@ -1132,6 +1129,8 @@ void __init setup_arch(char **cmdline_p)
>   	reserve_initrd();
>   
>   	acpi_table_upgrade();
> +	/* Look for ACPI tables and reserve memory occupied by them. */
> +	acpi_boot_table_init();
>   
>   	vsmp_init();
>   
>
>
>

