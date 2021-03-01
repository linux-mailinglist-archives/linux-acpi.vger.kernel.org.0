Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D354328369
	for <lists+linux-acpi@lfdr.de>; Mon,  1 Mar 2021 17:19:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237718AbhCAQS3 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 1 Mar 2021 11:18:29 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:40938 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237668AbhCAQRr (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 1 Mar 2021 11:17:47 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 121GFf1G104821;
        Mon, 1 Mar 2021 16:16:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=eJLtvPdTzSz6fWxMQvTZRoSvMTzT7uQH+PWL/40YmZc=;
 b=ZFsz8O+dukBYjrP60ld86sAGCKa6LY6rOe0xtNp4pm1u42T7lTkCVQQkdVhJXo4OLp9C
 CXPrq7eUfZzrlvKpk9dpL5lM4edgoEGPXQfEfnHYqHAksAxhSU126oK5dETxLcABcYQw
 iS56Ww4PPMImRUAQCk9rh9EenUXeZSQm1fvIQ6y5Vl4NR0zERdmCb6tXC/rxHb6Z4w54
 2JnJv4CrDBeYFEVs3q+6S9Ma00RH02uGO/sbU7z8VNQf5BjGO1BhxD/y+cZKCf3C2evw
 y/1vug1kJSEZ5quIbXKPB6wVpaFiBJx49osBPbqH0VIxpGXjyzYxWDGEhdd8KDTLnDwX /w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 36yeqmveb7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Mar 2021 16:16:42 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 121GEv2d037659;
        Mon, 1 Mar 2021 16:16:41 GMT
Received: from nam04-bn3-obe.outbound.protection.outlook.com (mail-bn3nam04lp2055.outbound.protection.outlook.com [104.47.46.55])
        by aserp3030.oracle.com with ESMTP id 36yynmxxrw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Mar 2021 16:16:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oEzshJiZcOV33AGdbLjp8MnEeJ56Jis/t68tGhyLW0ALghTZGEz+l21IK1Z2v1nCKtuY7UwDClVnFWbWXzrVCczs/tHRMZFG/IQ11trw7z/7J27eGRYjpVz3fISpfiOMVxKmZVxRDzjQAFo53olm/vN/e4bWNUpjI8RABpcJqGuhc0K+ty1rx/vYzAoy17ZdXV40UyraQpg9YdFpjmW4v8Hw5IR/gVNpFIEQ34YjDAGGPOLs0jIQnwKLG2f8wT47wvnBktyWZrcyxoXyo5JI1md7FNIsUs2fPWpVPcb6X+0GXqkHNyN4jwT/iPO41tvVMRwt92cCG8EKbTeYhcQJ3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eJLtvPdTzSz6fWxMQvTZRoSvMTzT7uQH+PWL/40YmZc=;
 b=F2qGVkdqW8s2JcP+D/gOo5rGIXEhnhFj+yqFNK/ugMno1fQT7iB2yFNZcFfGG6W8dcovDNnAGRszcmZ3b0Q/H7N9eUzi7igHzNPur83l+50u3535Gvyib0f/ts+Z/G8zpvjaqMCMOu8Rn0qnlzdtn0F4QMoU5Vb9iu86Aofh8yrQbJuu05fByJ06PAmLFfURXzuJh8x2zBVafIcgCTKCipk8hGCqOf66j9EatU4yNxu7WXiHvXUymw/msMrDTbE6jAzno3oxGATP9r3ZcalARuzUhjAyTwg5ffbUHEihHzcbpcq5WVDdu8rgj6ZNVokjpGSDMJNwhdV0yES9Adn3xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eJLtvPdTzSz6fWxMQvTZRoSvMTzT7uQH+PWL/40YmZc=;
 b=inq4BtgnySmG75oTAf/GyCVclZhZbsum+IMRidugBF/KQuqrbOJbuys3dBS2ANpheeCpVVv0lZBK5J6MatCtLyqjd43R4ZeicUTXiZ5i7wLG/1cxCRMp0Jd3QBYVFxJhccHePF88TWh5fONNV7btnqjYZ4YSKlOnUM/Lzm1UnbM=
Received: from BYAPR10MB3288.namprd10.prod.outlook.com (2603:10b6:a03:156::21)
 by BYAPR10MB3526.namprd10.prod.outlook.com (2603:10b6:a03:11c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.20; Mon, 1 Mar
 2021 16:16:39 +0000
Received: from BYAPR10MB3288.namprd10.prod.outlook.com
 ([fe80::f489:4e25:63e0:c721]) by BYAPR10MB3288.namprd10.prod.outlook.com
 ([fe80::f489:4e25:63e0:c721%7]) with mapi id 15.20.3890.028; Mon, 1 Mar 2021
 16:16:39 +0000
Subject: Re: [PATCH v1] xen: ACPI: Get rid of ACPICA message printing
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        xen-devel@lists.xenproject.org,
        Konrad Wilk <konrad.wilk@oracle.com>
References: <1709720.Zl72FGBfpD@kreacher>
 <eaeba4a0-7bb9-7b17-9ba6-49921f6e834c@oracle.com>
 <CAJZ5v0jr5Mxs9NYBz1ot8O+6dKYbfAo=cJqSVAOnrFEqUNwuTA@mail.gmail.com>
From:   Boris Ostrovsky <boris.ostrovsky@oracle.com>
Message-ID: <7c313ae8-6f3a-1281-a88a-1393e54f26a1@oracle.com>
Date:   Mon, 1 Mar 2021 11:16:35 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
In-Reply-To: <CAJZ5v0jr5Mxs9NYBz1ot8O+6dKYbfAo=cJqSVAOnrFEqUNwuTA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [73.249.50.119]
X-ClientProxiedBy: BYAPR04CA0016.namprd04.prod.outlook.com
 (2603:10b6:a03:40::29) To BYAPR10MB3288.namprd10.prod.outlook.com
 (2603:10b6:a03:156::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.104] (73.249.50.119) by BYAPR04CA0016.namprd04.prod.outlook.com (2603:10b6:a03:40::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20 via Frontend Transport; Mon, 1 Mar 2021 16:16:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 24553bd6-2f32-42bd-19eb-08d8dccd64e7
X-MS-TrafficTypeDiagnostic: BYAPR10MB3526:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB35260896AFBCADB41CC156F68A9A9@BYAPR10MB3526.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gEsC8dA+FfjwXI7lIw3Mp9cUcAFpchjnb8UBzwc8wcVGEOOfITp7iWf9xbyKJ/ZYqs6XayYkBwR060tMHP1T3m4tCmKwKtic6kBDm0e+rI1xQapbPGcFGvNRn7cc4AUMqUpmas9s4D9SPQmNi4OtALFz9oAr8nDBShhmwBqsutIHYXFzXzUY2tAxv/6aSGKuvjhKMjVH4HSLAMuwHzKMhCbbxJuOVgSY13lVNVjgRxTkfthIb2QhhkAXaVBGskkwhEFeJH3nS6mG2pTOOQaXnYxp6YZdILnlU3qwZ77zRvYkN+m09QXekBRRN3v26tXCDwvCGMMbW92h6x7Trniv1NZa0vItTltVYrNXlZiysPob9fhSaklJPvddEHpBfu18bncjJPUWq7qE5flaglfLL0URG9g8eUxmkBMBWtthM4+6nJRfEz9MELqm8lWTyqS5F4mW57A5es6qDBaMQnmbBa1rnx0phQCkSmrMMc1d5WtfEpQYvW1nauLcyC3RNJrrDVPGtZIkPi6Ge2pozkfoADdXbgKQiVCbKpJXiLg0wxBPAHIR5auouc0jLlrdnYXz0FRHpU8z+A2pNBkf812ua4LHPv3KMRwxZt0kyuyxWDOCEntOa15U1TxSXZvY6koPt1GMRloEg6ydX35vOeK0Rg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3288.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(366004)(376002)(39860400002)(396003)(136003)(186003)(53546011)(4326008)(16576012)(107886003)(66946007)(66556008)(86362001)(66476007)(316002)(83380400001)(31696002)(478600001)(26005)(2906002)(16526019)(6916009)(5660300002)(15650500001)(8676002)(6486002)(36756003)(54906003)(956004)(44832011)(8936002)(31686004)(6666004)(2616005)(26583001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?WE5wV2JORDNYajh5MVpCc0RBc1JCNzZZekk0TmJudlA4eUpNOWthb0w4WWlL?=
 =?utf-8?B?QVZpclMzSDd6dWFjVTdRaVlrcFA2dkVsRy9WY1p2YVdSNEtONHNqQ0dqUCtj?=
 =?utf-8?B?eGg3R01pMllZbVYrdWFqMUJsSFc3bU9tTzZZWG15VmVta1d0L3Y4SFQwTjRB?=
 =?utf-8?B?ZXFRbHFzR3lJRUpjUm96b05mbHBZREw0VGZ3L2xpVDBpVnNYd1VXMk9kT1RD?=
 =?utf-8?B?TDJXNy80RXVkZkxvVXFXajRGMzFyTHlTWWRtT01reDhlUmFMa09IZG1sdU10?=
 =?utf-8?B?S1c3WlFCL2pHd0tJTEJMdUhWT1NDT0I2WnJVbnJsQkJndUtjYkN6ZFpUY3Ar?=
 =?utf-8?B?SDl0R1k3UlU4d2J2SGlkUllRVHdIZVVwZ2NIN3BFSW9pS0MwSEJHbS9LRlBs?=
 =?utf-8?B?UERqREtwNDNMT2JCK0ptRitaWWdaT0lSV25CdEZEbEk1YXFTOGd1alFwbmI2?=
 =?utf-8?B?RTUwM3duQ3RXUkFkVnlXUkZWUnp4am1TTm5VVE1UeExnUG9BRGcrVC9veGxu?=
 =?utf-8?B?cnZDZVQ2OTFBS2tHL29LZVdqWUlsYmNJQ1dCM0lKMEx5cml5dEtuNWpOZ00y?=
 =?utf-8?B?WUJqc2NVNVFjYmhndUZnMFRIKzNzVXI3WWZjQWdQWURxbDlZSmYyVnlqOU8z?=
 =?utf-8?B?TzJ1Q3NDZjRUR2QxM3oyUFdMblVNMHNQdlljMzJkQWhrYjAzc2lreUV0ZWY4?=
 =?utf-8?B?cjZCMVNHTUp0b1NqQkJiVkUwSjVXblpRelRiQkc4N0RSUUxoRVdveVNNeWJv?=
 =?utf-8?B?MHNvYnVvRVhFL0pjRmdMakRDejgrOE5qK2w2enJVdHhUclg0Q3Y4d0RyQ0RL?=
 =?utf-8?B?QmJOd3lRdjFvcXdYMzFOcjRnZ3pyZm5ya2ZmZExPN0FxSFV3d1U5MWpVMzZl?=
 =?utf-8?B?d1FJQ0daZFZIaUFKbGtXd0dqL25uTmtPcWpGNlpBVTBuRitpaFZ3azlZaHNy?=
 =?utf-8?B?S2JuL2Q0clRZSnFLa3Q1bkJtZUIydUN3MmoycURXVzlNM3RieVRwS2JyR01N?=
 =?utf-8?B?SjNDbzhFdHpyUDVwZjQwckZKbkdmNHlRa3BsVEkvSjVEb3ZGVW54dzhaSHB4?=
 =?utf-8?B?cTVNRmh0SzlPQjkwM1lXd3Y1VHNwTDZqTDg3TTl2OFpybktNVk5yUUhjWFhm?=
 =?utf-8?B?Q2I0dFhtMVVsWjE3b0hYZXUwSGk3cEQvTFJyVitkbUlCMUFRUlVtT1ZRaFJV?=
 =?utf-8?B?K1lEa0RmWXRmczBiTlFhNFNJbFpxRHhhMXNhSi9oSW5IVDFCZkt6dG56ZlZN?=
 =?utf-8?B?ZWpBSlc1OUJzWGpHN0NTdVN1Z2hHL2VEdlZFMURXUm96M0pRUFpTalVKZXRo?=
 =?utf-8?B?UW5KRFdTR1gxckVOUTBMSVFXMHhUYzBSMjBHc2RreUFMdDRxWjlMUDRiVTFL?=
 =?utf-8?B?WkFkNWdGUWQ5aEtXR05BUzg1NUZQWHkvWHV1dk50VTJqdU8ySW0zVUJacmVF?=
 =?utf-8?B?MUpZQ2djZHR5NXhaWmFlTGZ4cVFvMkdLcmhLNFNVNDlmaWVOZXVDQ0o1V29r?=
 =?utf-8?B?L2x0enhScURKdGR3WWN0OVBDUDBRbXprOU54SGlNZkVDbU1NZU5PZHRyeGR1?=
 =?utf-8?B?MVp0SU1xdFZlVmowZVlTdEV5Q25tdEhScjE5Nnc3dHVGRGxkZFlVQzNqL1hi?=
 =?utf-8?B?TzZXWWphblN1NkttcTNjcGdWYnpGSy9xTmlBVnA4OEsrc2thaVlJMS9DZzFH?=
 =?utf-8?B?YkVFai9Uc2ZnUG5BejRlTjhZbi81clBxL0tVY2J0VHQ1TEIrTlZqWDRucUNt?=
 =?utf-8?Q?KTWfZdi64inM4kC0mS4dKQUn5LUnTo0PY9iLvFe?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24553bd6-2f32-42bd-19eb-08d8dccd64e7
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3288.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2021 16:16:39.4407
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SBOTVokuHgyBLRJJx8HtIsnEkcpkXXiZLhIpZnAWv+xjTPPRDFgKnvMmbFFdSQHgeMGYyuWGvg7f7eSnG/xU9ZQfzqnvpOg1B6Bzp81mUBo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3526
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9910 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 spamscore=0
 bulkscore=0 suspectscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103010134
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9910 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 clxscore=1011
 priorityscore=1501 mlxlogscore=999 suspectscore=0 malwarescore=0
 impostorscore=0 bulkscore=0 adultscore=0 mlxscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103010134
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


On 3/1/21 9:11 AM, Rafael J. Wysocki wrote:
> On Sun, Feb 28, 2021 at 2:49 AM Boris Ostrovsky
> <boris.ostrovsky@oracle.com> wrote:
>>
>> On 2/24/21 1:47 PM, Rafael J. Wysocki wrote:
>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>
>>> The ACPI_DEBUG_PRINT() macro is used in a few places in
>>> xen-acpi-cpuhotplug.c and xen-acpi-memhotplug.c for printing debug
>>> messages, but that is questionable, because that macro belongs to
>>> ACPICA and it should not be used elsewhere.  In addition,
>>> ACPI_DEBUG_PRINT() requires special enabling to allow it to actually
>>> print the message and the _COMPONENT symbol generally needed for
>>> that is not defined in any of the files in question.
>>>
>>> For this reason, replace all of the ACPI_DEBUG_PRINT() instances in
>>> the Xen code with acpi_handle_debug() (with the additional benefit
>>> that the source object can be identified more easily after this
>>> change) and drop the ACPI_MODULE_NAME() definitions that are only
>>> used by the ACPICA message printing macros from that code.
>>>
>>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>> ---
>>>  drivers/xen/xen-acpi-cpuhotplug.c |   12 +++++-------
>>>  drivers/xen/xen-acpi-memhotplug.c |   16 +++++++---------
>>
>> As I was building with this patch I (re-)discovered that since 2013 it depends on BROKEN (commit 76fc253723add). Despite commit message there saying that it's a temporary patch it seems to me by now that it's more than that.
>>
>>
>> And clearly noone tried to build these files since at least 2015 because memhotplug file doesn't compile due to commit cfafae940381207.
>>
>>
>> While this is easily fixable the question is whether we want to keep these files. Obviously noone cares about this functionality.
> Well, I would be for dropping them.
>
> Do you want me to send a patch to do that?


Yes, if you don't mind (but let's give this a few days for people to have a chance to comment).


-boris

