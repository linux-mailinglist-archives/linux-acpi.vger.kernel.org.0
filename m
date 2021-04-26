Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93B8A36B626
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Apr 2021 17:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233971AbhDZPwj (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 26 Apr 2021 11:52:39 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:40402 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233919AbhDZPwj (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 26 Apr 2021 11:52:39 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13QFnTPo115157;
        Mon, 26 Apr 2021 15:51:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=WUOh9WgEtaJn7QqJpsPgAg5/Lw4ReF1JJdgdmhEyH84=;
 b=pghb832uq94MJ9DpQaHhqwKWDbbfVrdNTVbjPtLKJeBmgDbRYtjYu5g9DfdURfRHaMap
 xodlEygLrnUKA8lBTFKvZp2o/0qpqX+sb4RZ4Zmfm1pynmmUFKsoinnA5IuHNtFRWz12
 RHKx1zmgvsryGCliNafSBbRjrlJmopy5NbVncvDwTqLgbxJ/3No1VJoiWZ30L4JAIkHs
 DG+xU5c79FxNYWmAHgcvEwSLBJEzzMcmH4j+f4mY6Vl2b3r1zj03JFnYSQ+pLacag+1U
 97VTFf0WzxXFZUtTneffQ/I61R4okD/OT4c4OAXIP+pLGe6sAzRW7/pXiJynjz166gc7 7A== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 385ahbjhjf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Apr 2021 15:51:46 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13QFpiXq163307;
        Mon, 26 Apr 2021 15:51:46 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
        by aserp3020.oracle.com with ESMTP id 384b54vqu1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Apr 2021 15:51:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FcWDi3TyvU0dJXHibElT3IqDZSXRCHfK/xlLwDT4mSDwhHn3l7oKQHPz9s65pLD2TGavSZftYptjPQ5KsOafacabHPZzqMH8zPc1SXcU/1o1FEazx05g4C4WCwb8DvgN6L5K9DCAZY9E5QMrSyeMyktK5g3/Ky8qisfrPNTAB1pHazaMADInAVJ+QSeCQyvJpAvIDgzahYj6juijXJufo2JX2dmrA+uos2/LLr9vLyqNhFd0sFHDCiwhDZactlLXufZa25CzTNj1Y8zwfG2lAWHFYQqdgz8wAClofhSFSZDKySr8CVreWJqWTLzRwloRlQy/DNbrvNtnZ0BtsNUxfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WUOh9WgEtaJn7QqJpsPgAg5/Lw4ReF1JJdgdmhEyH84=;
 b=DWO701713b+/tBFoQlEuXCmXcJ8kCtGZFKiNmjNX2FH4qp67aDvnoYjG0iwUeCks7MvvUMdNVLXS6mAQLnCh4dG416NE9liLNAp8tG11etETxIxERku3ZcxKtMUGoI8OoaqQyEi6Z7KtpZXMLvBiXM9Gv7x9qYkzg6fpPPclYpeE8kXwpjnwTsBJVLbKwNytTPMd8kKXvs4FdtVqistOlvrKQHUlax+E6MhKH7YrKV0Ez/IMvvHASAhIQwjZEk0qYOyT1R0hkY+ADggGG3kV5sna5dVFAE0udR35na9weZ/c5jOA1Fh+Ije+84Qxiw0vXLpnONhZE0u9BylfAGfxPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WUOh9WgEtaJn7QqJpsPgAg5/Lw4ReF1JJdgdmhEyH84=;
 b=QfXApd0eRAn4WgKH3mdh3eO08fO4Y8EWOchsKOe9O9n/sgJO8vo0T+9S1NLcdG/aOIjzAsqVX0bNFFv0IVBEY88s0ufaOB2D4n3Fw5OUYk4SUm1i9jTeqqH2rlPryhtNpBCU2j0GaW2qpabTzUxldBcmPG1pjZLnHR+g8zoPXkg=
Received: from DM6PR10MB3851.namprd10.prod.outlook.com (2603:10b6:5:1fb::17)
 by DM5PR10MB1257.namprd10.prod.outlook.com (2603:10b6:4:f::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4065.20; Mon, 26 Apr 2021 15:51:41 +0000
Received: from DM6PR10MB3851.namprd10.prod.outlook.com
 ([fe80::e490:f9ff:f8f3:c1e6]) by DM6PR10MB3851.namprd10.prod.outlook.com
 ([fe80::e490:f9ff:f8f3:c1e6%7]) with mapi id 15.20.4065.027; Mon, 26 Apr 2021
 15:51:41 +0000
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
Message-ID: <5faa46fb-3732-2ba1-9bbf-3108605c85de@oracle.com>
Date:   Mon, 26 Apr 2021 11:51:38 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
In-Reply-To: <11752259.O9o76ZdvQC@kreacher>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [108.26.147.230]
X-ClientProxiedBy: SN2PR01CA0007.prod.exchangelabs.com (2603:10b6:804:2::17)
 To DM6PR10MB3851.namprd10.prod.outlook.com (2603:10b6:5:1fb::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.228] (108.26.147.230) by SN2PR01CA0007.prod.exchangelabs.com (2603:10b6:804:2::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21 via Frontend Transport; Mon, 26 Apr 2021 15:51:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b3f8aa17-858a-49ca-04dd-08d908cb2f12
X-MS-TrafficTypeDiagnostic: DM5PR10MB1257:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR10MB1257AA6C2A74896C3DE7CA7DE6429@DM5PR10MB1257.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x868UIc6kPN9KMBCrBWsM89gXzmP55QG80XaiFWCXoQqvUacdzQJChTvPvL68JxeaO3j9UDDEuaREjM06u4sRoHsNgDFQ/MmJYa/F8eZVqoQfhQCpyZxsBPFBh2dNH/eA8Vt/DNlvyKlnp4tKGgFAbK5n+ylJK1Xq4eQ3ORzLp91jcIQbEcvSMGkLSDPrvN4SjfaI4C+6BwVfAQM1+HFpkx8KzlOk7rDs6yena2Jyi2fmfoF9LlI43DcWUOD9TRGsiK6HAcvqlhD67XDh9ai9b6FK/kD59FfRPKx67fi6PdkdKomY3qYnMIBdg5pekG6so+cxKO8AQMQpo+4YRwMycdHpI4UarSojwTgKY+G8IoyhmO7+OtrgUxAeQUQfb++gGLDUU7FJbQOXvJ3CX/ynHFXlLy14awXSscxqJyrL/LWg+Z76USizIvrtl5aZXUuExzk29XPPRoGrnful0B6CWuwzWrjdbAqyqHjr8DYiSGJxQ3mWfKJ62EtinHoBVYiMkcydjjeltMFzkovwMYxZWhPX7/469RylhRuIiIG+mRInBpdXUlgeek91Z+zoLVy0aU1fD4GKIqOO+nx3jql5Y7LeOvhVdXnw+0xH1PjkMJ96vGh26KZrQrFgI6HWir5ppsgyKqBnWz482F2OwZSctguR9eh5fRiVBOh8bcZvR8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB3851.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(396003)(376002)(366004)(346002)(136003)(5660300002)(36916002)(6486002)(53546011)(8676002)(36756003)(16526019)(44832011)(316002)(31686004)(83380400001)(478600001)(66476007)(38100700002)(31696002)(86362001)(66556008)(66946007)(2906002)(54906003)(8936002)(186003)(26005)(110136005)(16576012)(107886003)(956004)(4326008)(2616005)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?WVFVSisxR1c5OTFNTmtSQ1JJOHNGUjEyOHdnbk1RaExGR2FENkVyNTZuQ2E3?=
 =?utf-8?B?blRhRUZmRzRBeUthTlRXcDF3RHVLTlhwTnRNY3gyRVVodHBVOVdWZ2tBWTRM?=
 =?utf-8?B?VSsrMHoxSTE5OHBEVm0xZllpbW9ISVNkT2J1T1RBamkwL1g3YWdEZUpPaUhh?=
 =?utf-8?B?NEduKzZhMWtZMkxwUlhhc055cE1qTXdQcVN6czZhYzV3UFY5TDJLNTd1bGNx?=
 =?utf-8?B?c2JERGYrK3ZET1p6ME9JRWtlZysyNVIxcjFkcVlSRUg4MVpnYkZWbFRONFRk?=
 =?utf-8?B?TEdQYzA5YUREL3BYeXZVeHhtZWQzNTMwbTFtZXQwL1lRRGRrT2pveEI4Wm44?=
 =?utf-8?B?L0k5Y1k5TnJwSjdmNE5YOGM3QTRsR1Z3NnRqcWxvV2tLQ21MWVZPWmNobnlU?=
 =?utf-8?B?Q1J2MnI0Sm1OOVRQNU4rUVJpQk1LN1VJbDJmemk1dWpic2JtT1pTSis1c0U5?=
 =?utf-8?B?ZE5PS2NreUZ1MkNValpLSVp1UFBlNDZnUDdENDN0V0plSVdIYnFzcDlsc2Vz?=
 =?utf-8?B?bVdpZnV5dm9yU3pqQ3BWR0JaQ1dZTFJlOXgwY0lraktVa1RNSWlXb0hDQU1N?=
 =?utf-8?B?blcxNTF1OTgrTi9jWTdaTk9sK0JvcndWTHQ2aEJHaG85TU9FSDVZNFVGbDVs?=
 =?utf-8?B?UDd2RExQakQ1U3B4N3g5NkVDN3JhZGJVTHMxcE5PaS84TTRvZFZpZHlrVkt3?=
 =?utf-8?B?SE9NMU1XNVhjVlF1VFk4UWgwZXhESEI2bEdXYkRNeDBaY0NIV1BWTG5OSEFP?=
 =?utf-8?B?S3VOMXFUeWFwMnV5RHVPQUpPeHlKRGtUeGZjUUNSSGRaS3Z1UG9ZdnpYTUVP?=
 =?utf-8?B?NnlTZkEzK0c4TGxKcjF3M25yQ2Z4N0RVUmZLY3g2SGk1Z2xsTVBVTGVrbEU5?=
 =?utf-8?B?N0xnRDdZYjlYcFpzMlpmL2VZK1RVNkk0a2ttdUFkeEl1eVYveUVVVmR0ak1u?=
 =?utf-8?B?YjhPdUJTNzNmN2pDV0x5TmFjUldrZlQ2R0QrdzZ4Z2F2bzFoT0NVMXBmQ1dY?=
 =?utf-8?B?ejYxbjdiUkN2bnZTbVg1aEZvNXh3dW9KSmw5cVBhSUVhQU5lRkhBV1BFbzZs?=
 =?utf-8?B?OERNVkFQM2U4Wm5vdUw0RHY4NVJ6eU1YMXYrQnVSSjNXVWJqY1Z2V2NnbWRZ?=
 =?utf-8?B?cXFyWEVReVNHUkxRNFFtZmV1TVplaVBaTXNGbXZGMFpaVGVCTlF0bTJQN041?=
 =?utf-8?B?dnlVeUNwOUYrUC9GbjQ0WTlwcUtKN1JhOEtmS3doTDFReEYrUVRDdyt1M2hE?=
 =?utf-8?B?cFBLdVlXd211TFlUSjN3Z3lVTmxraWdma2JZMDBVOW5ZeTVkalBEWDFDS052?=
 =?utf-8?B?VFpJR0J3R1I3WXVVdktnNnBQRHJvRCt0RnAyNE5WNnlUOC8ydnNTcWlNMTJu?=
 =?utf-8?B?MXUwak5saXd6cHlHSnRoSWpYUFBPVFJ5VjY2SytLTEkvelZkQVl0Z2lvb2xm?=
 =?utf-8?B?OGNmcnpKWG4rZSs0UW5USzMwcEpVR3ExdnpaSE81N2pMZy9VSkxrcnF3TGhG?=
 =?utf-8?B?UGIyUkllMEEwMEVLUUVET1VZZHJNWTdzcS93WGR3VEhFY0FLVWI4MVA4QkRR?=
 =?utf-8?B?Zm40SEwyMGpibDlmRU80bzRiNm03ZWJadTNsc3ZpU1ovT2ZLSElVcTM2d3pu?=
 =?utf-8?B?QzdsT04wV1N3VklTL21TN29DY1ZLK2diMUZkVm9ISlpLMjFORnhVSVNocXdU?=
 =?utf-8?B?VXRYbE5LNFJidG5xczZpVCtFbGQ3dVlHc1d2Y1NhUVkrOHpSemhpWFBFTytC?=
 =?utf-8?Q?RUlAksbsOVILJyLjivFpZjRh7PApICRQRLukUZt?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3f8aa17-858a-49ca-04dd-08d908cb2f12
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3851.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2021 15:51:41.1848
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GPkFFYiAsWXDAj55LGxFvD5HkNlyhyy8AUysFjcH6RCb5NcgqWkDGJvFAeSQE2kRf3II6xCHFR88WWOR10l1O+LW3jGuAhyzYARWkunrFYs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1257
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9966 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 phishscore=0 adultscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104260122
X-Proofpoint-GUID: 0aQDOFqt1lcMsZ-VRNIp5Hf7bVy3q1ld
X-Proofpoint-ORIG-GUID: 0aQDOFqt1lcMsZ-VRNIp5Hf7bVy3q1ld
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9966 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 priorityscore=1501 clxscore=1015 adultscore=0 suspectscore=0 spamscore=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104260122
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Rafael & Mike,

Do you still need this patch tested in the failing scenario?

Have not seen any recent activity on this.

Thank you,
George

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

