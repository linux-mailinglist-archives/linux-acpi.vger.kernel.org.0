Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 050CC346843
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Mar 2021 19:59:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231955AbhCWS7P (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 23 Mar 2021 14:59:15 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:54722 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232171AbhCWS6n (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 23 Mar 2021 14:58:43 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12NIshtC116204;
        Tue, 23 Mar 2021 18:58:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 mime-version; s=corp-2020-01-29;
 bh=G5rW7cgOz5HnMUYrviP2N24yfXctcvQxx/8M5DdAjnU=;
 b=AS+i9jveb02mNUqkJenAwMGd93Dpv00FMSZJZQFWp3Fokii9htJMCwQt62tCcEJ+a/lQ
 6qbh3qXaBXNju0YOligcI/AY8g3MH9qr6nzXdApp0YDf+x+IFoQKlu3fa66p7bZAPUMc
 1hJBCtN5vRQnsviYGrzwSEfqUyWwnFyPaH2adhbEoJ50xMydRLOj8DQBjMf6Dj2hZwUS
 UzwfvWQTtlMrvTt+aF5HF4b+7iEaRleZ1YDU5b2hdqREhkqfKPnu4AqlQ5Gvh09wKD6O
 yvwwtQ3+nW1Zb4e4HqFAuQQI+jthERR2Yd/XlWSixgdf3dTyUN8W1rfS/EUhBXsdrsNo 8Q== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 37d8fr89qf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Mar 2021 18:58:28 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12NIu9Rt149276;
        Tue, 23 Mar 2021 18:58:28 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
        by userp3020.oracle.com with ESMTP id 37dttsb8x0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Mar 2021 18:58:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MHRqebRVPS/hEHNW+ddSCCqo6Q7LpJs2fBym/N3Bkqkkrsgrx4dy1F3FcpkWGp5zFEtVNdKR6UaCUYFu+tfE3FJjdaYpJiQbGKu8vGifDQSqqO5HLIKgBJRf/KvLrTIlK+NU17wbRcVTAhRNoVQPpbOaaldqd2DY9XMOq3IHw4sUyPJ+mcRnv7HJ2vExSbgLEmF2NLAhKaHCv+l/0yWaYZZdcpa4F3tm6EC7vag50Qio6Hclx+lAUdx2zbZZkDMYGfzaa3usS6SreAaKVoAL/mZGXb3HdELqa5F43oxdHNJvSYywJE4fZF8eOryhZ/z+72LXYJzWdVfGudiz/+YRGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G5rW7cgOz5HnMUYrviP2N24yfXctcvQxx/8M5DdAjnU=;
 b=Gih2uFWZpHJx+cQ3xoR9u+0KgSE4DUeIbzxT7Ll7VPmreKbHb1JnCWzvneN0GSM9ts/yZ2YWFsw5YPb3ym6Eusf51os8xGVmyNfW74zUTIvnV407p3htxQxVa1GddnZ9W/8a+7oOKSKb/qz3J3kUWgl1Hb24zvHjNYdFLtdgl/4Y9RjPZpBtiBk+tOKPhtsgJ51Z1MDXz4QSPg/MPs5+lNn8MzU8sA91LLBPqRTkQI8rVwwn6RMU9vVS5FDtqNmZOIDnG1DLVU51NAq2VWIQWcQFmJNW10aq8GDZIJBqmTyBAo1QkFyNVHnPY8rmoiK2kFzsaYEWX8Bl5Va982USxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G5rW7cgOz5HnMUYrviP2N24yfXctcvQxx/8M5DdAjnU=;
 b=DR5JoruUpKEsffKck9rIsQa9Uyxlmf47rvyN3EI3uN+57/ey2oVu8gq+MR7pUuJgb/cZAxPNWzngo36BTP1Dt9aOniBC0Vf43PzoA5AhnUSrkYutb9i97RE0tYbhuLD0geIYTvx1yQB3K595IK29UQ+uV0wq6waD6wBXoxCiVHg=
Authentication-Results: siemens.com; dkim=none (message not signed)
 header.d=none;siemens.com; dmarc=none action=none header.from=oracle.com;
Received: from CY4PR1001MB2133.namprd10.prod.outlook.com
 (2603:10b6:910:43::27) by CY4PR10MB1301.namprd10.prod.outlook.com
 (2603:10b6:903:2b::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Tue, 23 Mar
 2021 18:58:25 +0000
Received: from CY4PR1001MB2133.namprd10.prod.outlook.com
 ([fe80::dde:fe5e:5b06:d9bd]) by CY4PR1001MB2133.namprd10.prod.outlook.com
 ([fe80::dde:fe5e:5b06:d9bd%6]) with mapi id 15.20.3955.027; Tue, 23 Mar 2021
 18:58:25 +0000
Subject: Re: slub freelist issue / BUG: unable to handle page fault for
 address: 000000003ffe0018
To:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Moore, Robert" <robert.moore@intel.com>,
        Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Jan Kiszka <jan.kiszka@siemens.com>
References: <202006041054.874AA564@keescook>
 <cb0cdaaa-7825-0b87-0384-db22329305bb@suse.cz>
 <34455dce-6675-1fc2-8d61-45bf56f3f554@suse.cz>
 <6b2b149e-c2bc-f87a-ea2c-3046c5e39bf9@oracle.com>
 <faea2c18-edbe-f8b4-b171-6be866624856@oracle.com>
 <CAJZ5v0jqmUmf7mv3wjniVM-YqPqhDSjxunU0E4VYCsUQqvrF_Q@mail.gmail.com>
 <ce333dcb-2b2c-3e1f-2a7e-02a7819b1db4@suse.cz>
 <894e8cee-33df-1f63-fb12-72dceb024ea7@oracle.com>
 <BYAPR11MB3096B20EECE8E5BCB12E3D09F0800@BYAPR11MB3096.namprd11.prod.outlook.com>
 <874c4ec0-5c2a-da39-c4c0-83f781cba41d@intel.com>
 <20210323183255.vot2rady3jjjl57f@box>
From:   Vegard Nossum <vegard.nossum@oracle.com>
Message-ID: <e193096a-ee4b-3fd4-e4a4-c2b6247dffbe@oracle.com>
Date:   Tue, 23 Mar 2021 19:58:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20210323183255.vot2rady3jjjl57f@box>
Content-Type: multipart/mixed;
 boundary="------------9EF9E8AC9C0930ED90F8301B"
Content-Language: en-US
X-Originating-IP: [86.254.109.96]
X-ClientProxiedBy: PR0P264CA0229.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1e::25) To CY4PR1001MB2133.namprd10.prod.outlook.com
 (2603:10b6:910:43::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.13] (86.254.109.96) by PR0P264CA0229.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:1e::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24 via Frontend Transport; Tue, 23 Mar 2021 18:58:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2615204b-ec8f-4956-daac-08d8ee2da2f3
X-MS-TrafficTypeDiagnostic: CY4PR10MB1301:
X-Microsoft-Antispam-PRVS: <CY4PR10MB1301D98967D0D1D6870F430997649@CY4PR10MB1301.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: owo99kZtYG5wQoH3DUDDEWreZC/joO3G2X0fvWjWK38m+bYKKqTBVGIxEwRaFYq1elyWno7Fd3yzYiYF8HB2FHYQ9SAo82bD7Yp+U/niPXjVEvRJa/kAtooolOmQbk7sNOlP5Ra1+pLnp04jyLN22Zbhv65LI21/pxZ29MpjxzKwDgwYgfXU6nUxlQTaIPSTPWwUDGVOj0LXy0mv9G78znUO2uBLA6DX/r57mSC7UOevdmK0nsdCqFsuogv+2ETWsnqvfE/kGp+v9R97dtntWF8VLM+Wdwkbz4G7zG3KUCLIe+HWvfz/SvScXh6+/wO+chxfpPZoAaYXWfN18LrqQMqmJwMeiwVyRTwUDbKpqJCdjrZOd+EnV1sCDhv6VNToly1nlSDpbOqgvl57KA0YJOoa9MiOmjO8ZPqCFE8B7jn6kU0HmFRp0kpiV3Y6bf31bGECk+6rzV+BAqIvInu9OltZkhDEp90uGFXcHVCr1DWT2RuIp7in4Z3XpLQCOLm/nvzaM3KpfZOgsAaHOsqmtRAHBVTWkY1dHRc1s9N7ephO6IsBTmMXUgPH+mqQS3e8RtbJhu/YrzZBXyPaedWFVdRz/sIT1EdmfoXY9o4fGPOqKnyDv8CTHbjfsvjj4dGJPPvAXT88xNtGMBeKufs9OubAPIm2NqFglH1vkbvU5p5t7BvjiBojsbPU6fO2VUplA2dXBiWPVhr7JXeSmLAHLXXY7/1rkmew/wmsLfJRzlrNe32zPgh9pRg5sNqGDCIUqtSGrAw+s7NNgGGoSkkHk2gkwl3exErvqu+HYgbhEPQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1001MB2133.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(396003)(366004)(376002)(39860400002)(186003)(16526019)(7416002)(956004)(478600001)(36756003)(2906002)(52116002)(66476007)(8676002)(33964004)(53546011)(31686004)(26005)(110136005)(5660300002)(30864003)(44832011)(16576012)(38100700001)(235185007)(31696002)(966005)(316002)(4326008)(66616009)(2616005)(8936002)(83380400001)(66946007)(6666004)(54906003)(86362001)(66556008)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?SUVCMHFtekNkQWVGOWNybktIanNCQ3NsSkw1N3FKWHZGRmJPVmJlOGNKL2pi?=
 =?utf-8?B?U0IvZU50RytQUVpYTzAvZ0RIMDdzYVFGcktUcGlINEdRVVZjeThBcjIrQ2o4?=
 =?utf-8?B?UTBsem9pYXJRRkZnSjdWeEx0TFdxUGRsRTZ0MHRkZDFnOG9HVVdTZDdyQjlw?=
 =?utf-8?B?cHo2SkMzZVlCVGczZmFGY3ZHbVQ3N2xmdndhL0kvYmdvU0JRdWtGeXNuS1g5?=
 =?utf-8?B?ODNtSVdlV1NLTjhsRlpqdFVkczdQaC9QZ1VuenJkUUpZT1RhZ2swbVRrdSt3?=
 =?utf-8?B?MVIxZHF5alZVOTcwbDNPV3o4dHpDOFdRbTVoekZTZ1ZqY1pVRitSMldzcThS?=
 =?utf-8?B?MGN0dTliRW4zdWh0eEhuVU9MR2FlSVVvUnRWTUx1ZWxldFdNSjliS0l2V29O?=
 =?utf-8?B?REd3TDNVYkZNejl2NG11bDJIbXI2RkJGRmVEYVhVanlSdkpVZm9WMTFPK1FF?=
 =?utf-8?B?QmFJR00vcVhMeXhKK0ZPekNoMUxlQVJ2Z1plazF2ODBrcjk2SVgxbnpkNlZF?=
 =?utf-8?B?ZTRKYzZaRm5McVc1RkV0MjVRamFlTXo0MmNXV0luL3JNNzcyYlU3ZFpvSmV2?=
 =?utf-8?B?cmVuTHdVZllSTWc3cStjQTdJQmc2Y3ZEVlRVNnZaRGRYTVBLWmxCU2xnNU9p?=
 =?utf-8?B?NVpPdmlVT0d5MURWZGU0QStoRnQ0TEpKelZrMDBVeVZ0YzZPaWFTMTNRaW9Q?=
 =?utf-8?B?YnkwMlAxVkJKRmpQS3lCZURMUzNHZ0V2SE41ci9IQXV3WjJPY2VZbVRtbWNQ?=
 =?utf-8?B?NXVBeXIrdzZxbSthR1k3aFptYTI5ZWo1Uk5mWU5ueDBac05XU0Q2bEF3dlBw?=
 =?utf-8?B?ZWJUWVhUWUhtL09wSnBlOGx1SmM1RUdNbkI5bnh5UldsMnhEOS9TVkdLOUZm?=
 =?utf-8?B?eHRndVFBbnVKYTRUS1ZFMkhwcmRQYVdYZ3ErQ0YraGt5L2pjQU56L1ZoVW5n?=
 =?utf-8?B?eWswbGpWWVl0UmprVGl5YitUbGNYd0puSTAxMjF0akhDa05XUWo5bHhyMGgw?=
 =?utf-8?B?a1BUQjN2ZTJmY1MwUWduRzV4dHpnNFZadDBQWmtNTVFVTUxCQzdkcFJpdHlr?=
 =?utf-8?B?a08xajN3UFBlWndiVFJlZVVod3A1ZGtIRzk3NVk4MERGc3VCSjA2b2p0N0pW?=
 =?utf-8?B?NVB0MUd3MWpocUs5blVibnVaWnZxQXVtK1Y2WWQ1TXNBaFZmMkJiRFdJYWpk?=
 =?utf-8?B?aXlQNEFEenFTNXJEaDkzSlgzZkhrV0xJcUpBOWhzeVVnRWdEeUxhUzQ4cytW?=
 =?utf-8?B?UWFzV2MzdXNOSmlrSjlRam1kYStyUXppRXVJY0NBdG1pSnZWaWpydzN2dXQy?=
 =?utf-8?B?OUJHNFhlTUc2ZTl2UlpESTBwa01PZTZ1S0RkVUFLTWh2VjZLK1M4RGF3M2VP?=
 =?utf-8?B?b0Qzcm04dEZTbzIvZFJhZ1ZiUzV1THF4dm5idlpJV1dxZUhwU1VlSkVyNzRV?=
 =?utf-8?B?TmYyQnE4YWZxOGJOK1pXc0xJdjh4TVUwZHQzT1ArNXliRElTSkE0Vkx0N1RN?=
 =?utf-8?B?UXJuOUFBZDkra09YRWhMRnRuT1Z5UEtYQmcvVjVVYkZqUkhVNk13ako5UEJF?=
 =?utf-8?B?bnRSdmhvcUJ4QW5XUm1OQWlqMXRETGp4N21rd2pNa29hbHN0eGhEdU5tTkQw?=
 =?utf-8?B?dlhIaVBoOEQzWVhHQ2FxS1p2Uit3WkFDQXNkM095NTdwb1ZkMTkycGhaQ29w?=
 =?utf-8?B?OHZDZkhRa0F0KzluMUJRMmlzeVdzbHV4VFMzS2Z4UFBjd2NuYmlmQ0FxcU1t?=
 =?utf-8?Q?56JXAMHKV37W3LkJNe19Uzq8/jNtaFaqnHNcv6E?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2615204b-ec8f-4956-daac-08d8ee2da2f3
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1001MB2133.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2021 18:58:25.3940
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VapXSgJzxq2UGC+E+cKE6JIUkpDlehHIQNBFFnpKMQylRfa2RunBZRdzT7IzBMhh8lNKNVk1Swk7CGX4NZldW9p/nrlQEHxT8jdK421f1rA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1301
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9932 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 mlxscore=0 phishscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103230137
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9932 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 spamscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 adultscore=0 malwarescore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103230137
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

--------------9EF9E8AC9C0930ED90F8301B
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

(trimmed CCs)

On 2021-03-23 19:32, Kirill A. Shutemov wrote:
> On Fri, Jun 12, 2020 at 02:26:58PM +0200, Rafael J. Wysocki wrote:
>> On 6/11/2020 3:40 AM, Kaneda, Erik wrote:
>>>
>>>> -----Original Message-----
>>>> From: Vegard Nossum <vegard.nossum@oracle.com>
>>>> Sent: Friday, June 5, 2020 7:45 AM
>>>> To: Vlastimil Babka <vbabka@suse.cz>; Rafael J. Wysocki
>>>> <rafael@kernel.org>; Moore, Robert <robert.moore@intel.com>; Kaneda,
>>>> Erik <erik.kaneda@intel.com>
>>>> Cc: Kees Cook <keescook@chromium.org>; Wysocki, Rafael J
>>>> <rafael.j.wysocki@intel.com>; Christoph Lameter <cl@linux.com>; Andrew
>>>> Morton <akpm@linux-foundation.org>; Marco Elver <elver@google.com>;
>>>> Waiman Long <longman@redhat.com>; LKML <linux-
>>>> kernel@vger.kernel.org>; Linux MM <linux-mm@kvack.org>; ACPI Devel
>>>> Maling List <linux-acpi@vger.kernel.org>; Len Brown <lenb@kernel.org>;
>>>> Steven Rostedt <rostedt@goodmis.org>
>>>> Subject: Re: slub freelist issue / BUG: unable to handle page fault for
>>>> address: 000000003ffe0018
>>>>
>>>> On 2020-06-05 16:08, Vlastimil Babka wrote:
>>>>> On 6/5/20 3:12 PM, Rafael J. Wysocki wrote:
>>>>>> On Fri, Jun 5, 2020 at 2:48 PM Vegard Nossum
>>>> <vegard.nossum@oracle.com> wrote:
>>>>>>> On 2020-06-05 11:36, Vegard Nossum wrote:
>>>>>>>> On 2020-06-05 11:11, Vlastimil Babka wrote:
>>>>>>>>> On 6/4/20 8:46 PM, Vlastimil Babka wrote:
>>>>>>>>>> On 6/4/20 7:57 PM, Kees Cook wrote:
>>>>>>>>>>> On Thu, Jun 04, 2020 at 07:20:18PM +0200, Vegard Nossum wrote:
>>>>>>>>>>>> On 2020-06-04 19:18, Vlastimil Babka wrote:
>>>>>>>>>>>>> On 6/4/20 7:14 PM, Vegard Nossum wrote:
>>>>>>>>>>>>>> Hi all,
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> I ran into a boot problem with latest linus/master
>>>>>>>>>>>>>> (6929f71e46bdddbf1c4d67c2728648176c67c555) that manifests
>>>> like this:
>>>>>>>>>>>>> Hi, what's the .config you use?
>>>>>>>>>>>> Pretty much x86_64 defconfig minus a few options (PCI, USB,
>>>>>>>>>>>> ...)
>>>>>>>>>>> Oh yes indeed. I immediately crash in the same way with this config.
>>>>>>>>>>> I'll
>>>>>>>>>>> start digging...
>>>>>>>>>>>
>>>>>>>>>>> (defconfig finishes boot)
>>>>>>>>>> This is funny, booting with slub_debug=F results in:
>>>>>>>>>> I'm not sure if it's ACPI or ftrace wrong here, but looks like
>>>>>>>>>> the changed free pointer offset merely exposes a bug in something
>>>>>>>>>> else.
>>>>>>>>> So, with Kees' patch reverted, booting with slub_debug=F (or even
>>>>>>>>> more specific slub_debug=F,ftrace_event_field) also hits this bug
>>>>>>>>> below. I wanted to bisect it, but v5.7 was also bad, and also
>>>>>>>>> v5.6. Didn't try further in history. So it's not new at all, and
>>>>>>>>> likely very specific to your config+QEMU? (and related to the ACPI
>>>>>>>>> error messages that precede it?).
>>>>>>>> I see it too, but not on v5.0. I can bisect it.
>>>>>>> commit 67a72420a326b45514deb3f212085fb2cd1595b5
>>>>>>> Author: Bob Moore <robert.moore@intel.com>
>>>>>>> Date:   Fri Aug 16 14:43:21 2019 -0700
>>>>>>>
>>>>>>>         ACPICA: Increase total number of possible Owner IDs
>>>>>>>
>>>>>>>         ACPICA commit 1f1652dad88b9d767767bc1f7eb4f7d99e6b5324
>>>>>>>
>>>>>>>         From 255 to 4095 possible IDs.
>>>>>>>
>>>>>>>         Link: https://github.com/acpica/acpica/commit/1f1652da
>>>>>>>         Reported-by: Hedi Berriche <hedi.berriche @hpe.com>
>>>>>>>         Signed-off-by: Bob Moore <robert.moore@intel.com>
>>>>>>>         Signed-off-by: Erik Schmauss <erik.schmauss@intel.com>
>>>>>>>         Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>>>> Bob, Erik, did we miss something in that patch?
>>>>> Maybe the patch just changes layout in a way that exposes the bug.
>>>>>
>>>>> Anyway the "ftrace_event_field" cache is not really involved, this is
>>>>> just because of slab merging. After adding "slub_nomerge" to
>>>>> "slub_debug=F", it starts making more sense, as the cache becomes
>>>>> Acpi-Namespace
>>>>>
>>>>> [    0.140408] ------------[ cut here ]------------
>>>>> [    0.140837] cache_from_obj: Wrong slab cache. Acpi-Namespace but
>>>> object is from kmalloc-64
>>>>> [    0.141406] WARNING: CPU: 0 PID: 1 at mm/slab.h:524
>>>> kmem_cache_free+0x1d3/0x250
>>>>> [    0.142105] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.7.0+ #45
>>>>> [    0.142393] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
>>>> BIOS rel-1.13.0-0-gf21b5a4-rebuilt.opensuse.org 04/01/2014
>>>>> [    0.142393] RIP: 0010:kmem_cache_free+0x1d3/0x250
>>>>> [    0.142393] Code: 18 4d 85 ed 0f 84 10 ff ff ff 4c 39 ed 74 2f 49 8b 4d 58 48
>>>> 8b 55 58 48 c7 c6 10 47 a1 ac 48 c7 c7 00 c2 b0 ac e8 b1 cc eb ff <0f> 0b 48 89 de
>>>> 4c 89 ef e8 10 d7 ff ff 48 8b 15 59 36 9b 00 4c 89
>>>>> [    0.142393] RSP: 0018:ffffb39cc0013dc0 EFLAGS: 00010282
>>>>> [    0.142393] RAX: 0000000000000000 RBX: ffff937287409e00 RCX:
>>>> 0000000000000000
>>>>> [    0.142393] RDX: 0000000000000001 RSI: 0000000000000092 RDI:
>>>> ffffffffacfdd32c
>>>>> [    0.142393] RBP: ffff93728742ef00 R08: ffffb39cc0013c7d R09:
>>>> 00000000000000fc
>>>>> [    0.142393] R10: ffffb39cc0013c78 R11: ffffb39cc0013c7d R12:
>>>> ffff937307409e00
>>>>> [    0.142393] R13: ffff937287401d00 R14: 0000000000000000 R15:
>>>> 0000000000000000
>>>>> [    0.142393] FS:  0000000000000000(0000) GS:ffff937287a00000(0000)
>>>> knlGS:0000000000000000
>>>>> [    0.142393] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>>> [    0.142393] CR2: 0000000000000000 CR3: 0000000003a0a000 CR4:
>>>> 00000000003406f0
>>>>> [    0.142393] Call Trace:
>>>>> [    0.142393]  acpi_os_release_object+0x5/0x10
>>>>> [    0.142393]  acpi_ns_delete_children+0x46/0x59
>>>>> [    0.142393]  acpi_ns_delete_namespace_subtree+0x5c/0x79
>>>>> [    0.142393]  ? acpi_sleep_proc_init+0x1f/0x1f
>>>>> [    0.142393]  acpi_ns_terminate+0xc/0x31
>>>>> [    0.142393]  acpi_ut_subsystem_shutdown+0x45/0xa3
>>>>> [    0.142393]  ? acpi_sleep_proc_init+0x1f/0x1f
>>>>> [    0.142393]  acpi_terminate+0x5/0xf
>>>>> [    0.142393]  acpi_init+0x27b/0x308
>>>>> [    0.142393]  ? video_setup+0x79/0x79
>>>>> [    0.142393]  do_one_initcall+0x7b/0x160
>>>>> [    0.142393]  kernel_init_freeable+0x190/0x1f2
>>>>> [    0.142393]  ? rest_init+0x9a/0x9a
>>>>> [    0.142393]  kernel_init+0x5/0xf6
>>>>> [    0.142393]  ret_from_fork+0x22/0x30
>>>>> [    0.142393] ---[ end trace 3539f236ef812ba1 ]---
>>>>> [    0.142396] ------------[ cut here ]------------
>>>>>
>>>>> I've also changed the warning so it's not printed just once, and also
>>>>> prints tracking info (see the hunk at the end of my mail, I'll turn this to a
>>>> proper patch later).
>>>>> With "slub_debug=FU slub_nomerge" there are now multiple warnings,
>>>> but they all look the same:
>>>>> [    0.143815] ------------[ cut here ]------------
>>>>> [    0.144131] cache_from_obj: Wrong slab cache. Acpi-Namespace but
>>>> object is from kmalloc-64
>>>>> [    0.144929] WARNING: CPU: 0 PID: 1 at mm/slab.h:524
>>>> kmem_cache_free+0x1d3/0x250
>>>>> [    0.145129] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.7.0+ #45
>>>>> [    0.145129] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
>>>> BIOS rel-1.13.0-0-gf21b5a4-rebuilt.opensuse.org 04/01/2014
>>>>> [    0.145129] RIP: 0010:kmem_cache_free+0x1d3/0x250
>>>>> [    0.145129] Code: 18 4d 85 ed 0f 84 10 ff ff ff 4c 39 ed 74 2f 49 8b 4d 58 48
>>>> 8b 55 58 48 c7 c6 10 47 c1 8d 48 c7 c7 00 c2 d0 8d e8 b1 cc eb ff <0f> 0b 48 89 de
>>>> 4c 89 ef e8 10 d7 ff ff 48 8b 15 59 36 9b 00 4c 89
>>>>> [    0.145129] RSP: 0018:ffff990b80013dc0 EFLAGS: 00010282
>>>>> [    0.145129] RAX: 0000000000000000 RBX: ffff972d474ada80 RCX:
>>>> 0000000000000000
>>>>> [    0.145129] RDX: 0000000000000001 RSI: 0000000000000092 RDI:
>>>> ffffffff8e1dd32c
>>>>> [    0.145129] RBP: ffff972d47425680 R08: ffff990b80013c7d R09:
>>>> 00000000000000fc
>>>>> [    0.145129] R10: ffff990b80013c78 R11: ffff990b80013c7d R12:
>>>> ffff972dc74ada80
>>>>> [    0.145129] R13: ffff972d474038c0 R14: 0000000000000000 R15:
>>>> 0000000000000000
>>>>> [    0.145129] FS:  0000000000000000(0000) GS:ffff972d47a00000(0000)
>>>> knlGS:0000000000000000
>>>>> [    0.145129] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>>> [    0.145129] CR2: 0000000000000000 CR3: 000000000660a000 CR4:
>>>> 00000000003406f0
>>>>> [    0.145129] Call Trace:
>>>>> [    0.145129]  acpi_os_release_object+0x5/0x10
>>>>> [    0.145129]  acpi_ns_delete_children+0x46/0x59
>>>>> [    0.145129]  acpi_ns_delete_namespace_subtree+0x5c/0x79
>>>>> [    0.145129]  ? acpi_sleep_proc_init+0x1f/0x1f
>>>>> [    0.145129]  acpi_ns_terminate+0xc/0x31
>>>>> [    0.145129]  acpi_ut_subsystem_shutdown+0x45/0xa3
>>>>> [    0.145129]  ? acpi_sleep_proc_init+0x1f/0x1f
>>>>> [    0.145129]  acpi_terminate+0x5/0xf
>>>>> [    0.145129]  acpi_init+0x27b/0x308
>>>>> [    0.145129]  ? video_setup+0x79/0x79
>>>>> [    0.145129]  do_one_initcall+0x7b/0x160
>>>>> [    0.145129]  kernel_init_freeable+0x190/0x1f2
>>>>> [    0.145129]  ? rest_init+0x9a/0x9a
>>>>> [    0.145129]  kernel_init+0x5/0xf6
>>>>> [    0.145129]  ret_from_fork+0x22/0x30
>>>>> [    0.145129] ---[ end trace 574554fca7bd06bb ]---
>>>>> [    0.145133] INFO: Allocated in acpi_ns_root_initialize+0xb6/0x2d1 age=58
>>>> cpu=0 pid=0
>>>>> [    0.145881]  kmem_cache_alloc_trace+0x1a9/0x1c0
>>>>> [    0.146132]  acpi_ns_root_initialize+0xb6/0x2d1
>>>>> [    0.146578]  acpi_initialize_subsystem+0x65/0xa8
>>>>> [    0.147024]  acpi_early_init+0x5d/0xd1
>>>>> [    0.147132]  start_kernel+0x45b/0x518
>>>>> [    0.147491]  secondary_startup_64+0xb6/0xc0
>>>>> [    0.147897] ------------[ cut here ]------------
>>>>>
>>>>> And it seems ACPI is allocating an object via kmalloc() and then
>>>>> freeing it via kmem_cache_free(<"Acpi-Namespace" kmem_cache>) which
>>>> is wrong.
>>>>>> ./scripts/faddr2line vmlinux 'acpi_ns_root_initialize+0xb6'
>>>>> acpi_ns_root_initialize+0xb6/0x2d1:
>>>>> kmalloc at include/linux/slab.h:555
>>>>> (inlined by) kzalloc at include/linux/slab.h:669 (inlined by)
>>>>> acpi_os_allocate_zeroed at include/acpi/platform/aclinuxex.h:57
>>>>> (inlined by) acpi_ns_root_initialize at
>>>>> drivers/acpi/acpica/nsaccess.c:102
>>>>>
>>> Hi Vegard,
>>>
>>>> That's it :-) This fixes it for me:
>>> We'll take this patch for ACPICA and it will be in the next release.
>>>
>>> Rafael, do you want to take this as a part of the next rc?
>>
>> Yes, I do.
> 
> Folks, what happened to the patch? I don't see it in current upstream.
> 
> Looks like it got reported again:
> 
> https://lore.kernel.org/r/a1461e21-c744-767d-6dfc-6641fd3e3ce2@siemens.com
> 

I've attached a properly formatted patch.

Thanks,


Vegard

--------------9EF9E8AC9C0930ED90F8301B
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-ACPICA-Always-create-namespace-nodes-using-acpi_ns_c.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-ACPICA-Always-create-namespace-nodes-using-acpi_ns_c.pa";
 filename*1="tch"

From a35302316c1c36e22b60d1644db0340558de695f Mon Sep 17 00:00:00 2001
From: Vegard Nossum <vegard.nossum@oracle.com>
Date: Mon, 8 Jun 2020 09:57:51 +0200
Subject: [PATCH] ACPICA: Always create namespace nodes using
 acpi_ns_create_node()

ACPI is allocating an object using kmalloc(), but then frees it
using kmem_cache_free(<"Acpi-Namespace" kmem_cache>).

This is wrong and can lead to boot failures manifesting like this:

    hpet0: 3 comparators, 64-bit 100.000000 MHz counter
    clocksource: Switched to clocksource tsc-early
    BUG: unable to handle page fault for address: 000000003ffe0018
    #PF: supervisor read access in kernel mode
    #PF: error_code(0x0000) - not-present page
    PGD 0 P4D 0
    Oops: 0000 [#1] SMP PTI
    CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.6.0+ #211
    Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Ubuntu-1.8.2-1ubuntu1 04/01/2014
    RIP: 0010:kmem_cache_alloc+0x70/0x1d0
    Code: 00 00 4c 8b 45 00 65 49 8b 50 08 65 4c 03 05 6f cc e7 7e 4d 8b 20 4d 85 e4 0f 84 3d 01 00 00 8b 45 20 48 8b 7d 00 48 8d 4a 01 <49> 8b 1c 04 4c 89 e0 65 48 0f c7 0f 0f 94 c0 84 c0 74 c5 8b 45 20
    RSP: 0000:ffffc90000013df8 EFLAGS: 00010206
    RAX: 0000000000000018 RBX: ffffffff81c49200 RCX: 0000000000000002
    RDX: 0000000000000001 RSI: 0000000000000dc0 RDI: 000000000002b300
    RBP: ffff88803e403d00 R08: ffff88803ec2b300 R09: 0000000000000001
    R10: 0000000000000dc0 R11: 0000000000000006 R12: 000000003ffe0000
    R13: ffffffff8110a583 R14: 0000000000000dc0 R15: ffffffff81c49a80
    FS:  0000000000000000(0000) GS:ffff88803ec00000(0000) knlGS:0000000000000000
    CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
    CR2: 000000003ffe0018 CR3: 0000000001c0a001 CR4: 00000000003606f0
    DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
    DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
    Call Trace:
     __trace_define_field+0x33/0xa0
     event_trace_init+0xeb/0x2b4
     tracer_init_tracefs+0x60/0x195
     ? register_tracer+0x1e7/0x1e7
     do_one_initcall+0x74/0x160
     kernel_init_freeable+0x190/0x1f0
     ? rest_init+0x9a/0x9a
     kernel_init+0x5/0xf6
     ret_from_fork+0x35/0x40
    CR2: 000000003ffe0018
    ---[ end trace 707efa023f2ee960 ]---
    RIP: 0010:kmem_cache_alloc+0x70/0x1d0

Bisection leads to unrelated changes in slab; Vlastimil Babka
suggests an unrelated layout or slab merge change merely exposed
the underlying bug.

Link: https://lore.kernel.org/lkml/4dc93ff8-f86e-f4c9-ebeb-6d3153a78d03@oracle.com/
Link: https://lore.kernel.org/r/a1461e21-c744-767d-6dfc-6641fd3e3ce2@siemens.com
Debugged-by: Vlastimil Babka <vbabka@suse.cz>
Debugged-by: Kees Cook <keescook@chromium.org>
Reported-by: Jan Kiszka <jan.kiszka@siemens.com>
Fixes: f79c8e4136eac37255ead8875593ae33a2c16d20 ("ACPICA: Namespace: simplify creation of the initial/default namespace")
Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
---
 drivers/acpi/acpica/nsaccess.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/acpi/acpica/nsaccess.c b/drivers/acpi/acpica/nsaccess.c
index 3f045b5953b2e..1be9b34732ab8 100644
--- a/drivers/acpi/acpica/nsaccess.c
+++ b/drivers/acpi/acpica/nsaccess.c
@@ -98,14 +98,12 @@ acpi_status acpi_ns_root_initialize(void)
 		 * predefined names are at the root level. It is much easier to
 		 * just create and link the new node(s) here.
 		 */
-		new_node =
-		    ACPI_ALLOCATE_ZEROED(sizeof(struct acpi_namespace_node));
+		new_node = acpi_ns_create_node(*ACPI_CAST_PTR (u32, init_val->name));
 		if (!new_node) {
 			status = AE_NO_MEMORY;
 			goto unlock_and_exit;
 		}
 
-		ACPI_COPY_NAMESEG(new_node->name.ascii, init_val->name);
 		new_node->descriptor_type = ACPI_DESC_TYPE_NAMED;
 		new_node->type = init_val->type;
 
-- 
2.16.1.72.g5be1f00a9.dirty


--------------9EF9E8AC9C0930ED90F8301B--
