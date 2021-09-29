Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8EA141C66C
	for <lists+linux-acpi@lfdr.de>; Wed, 29 Sep 2021 16:09:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344495AbhI2OL0 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 29 Sep 2021 10:11:26 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:24218 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344431AbhI2OLE (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 29 Sep 2021 10:11:04 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18TCsqfY005942;
        Wed, 29 Sep 2021 14:09:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=ckLMaBPYYrT6cXQJAnJQVUWm5Nl7qUWJLaMtsNYmmUU=;
 b=gtREjzcZQMMgf6CmqeSxfTUgbqgB8p0Ai2d3m4vi/LdYuvhAiti3cW4i85da2+XZn7tG
 ctXtuYAMgaAPxEzqwZP14evisNhWnk16o0Hytoa0zi5yu/UefYHkGwsQ8WJQ7UUUa5ek
 aTSkbEiWj3a35WxK/Qq8P5HNAUWfvVGDAoc4HOSEK+JmSNKng40ZkwrVRmkald/u8vUZ
 LE4+vKJbG3jxguEacOHMlo6baTp7yBaGh2KfPLxsFqVL8u97yblA13ftD9oBBeFRINwe
 y5KSSogaf/bANJwKtc7kD5g7x2gazdxku/97dzT7Vm7lptKGfS32OVDEsQSEMSRBtD3g ng== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bchfktrx7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Sep 2021 14:09:19 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18TE70e1033153;
        Wed, 29 Sep 2021 14:09:07 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by aserp3030.oracle.com with ESMTP id 3bc4k9abf6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Sep 2021 14:09:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MXiWsWZNGFmxsHmLPu5OfADv4Fladu8zF8RQU4IcqgNzsdczluMIQ3SMTULmbNA1H3qOmOlguVsOnuL8ldd7zWHLqThoINXvk3F1CtSrY9MwCOoD8s7ahM1cneBhG1hBf7DqCQDVsKV+giVnSFdLzqunn5nMtw1H9vCd9pxg9LlGdGIwlnheNoZXWf3jPddIZonjtD8KAXRRJf+LO1ad9nfj/cHeiYnjTCrU8qEBILPnCv39heD+/KrcAb2f7B1OlW5lKZHQI6ZJoJWMrm5lyvDvam6ymXB9DjAet553MeIbXfSNkvWHIISMh+RjiFqKNokrYflMfuzb+eEZp+HR2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=ckLMaBPYYrT6cXQJAnJQVUWm5Nl7qUWJLaMtsNYmmUU=;
 b=FjJApEBxzOkhsZ0brC+9QNUepi3H8RAlHQNZtAp6fKXruBVSFSDU7LP48E0pga1ITjTtbZ+rhGOYMQo4iq0vw5eAsFNvkHgF3oY0G82LbhuvBB5gZAJBpbFVZuMR/5Yq3/VATPWOLIVuIGUhVOn127AEr0RTljrdj/jjoRjMGyBrJ0HzFllQkSgQ4LvLDCMa5Xw/3iJ1YpSaSQqYWe8WBI9qX71uPLoXCbUPeRmBWMUvi5SHfGNz031OKMGDTSXt15GzuYvbF9wuuPAPFnEEwdR5HZPAwFutrLFQiAKImxXBcXnOHg2peHrjrt0G2+zGvQB67J4PJl8J4Za5jfDUEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ckLMaBPYYrT6cXQJAnJQVUWm5Nl7qUWJLaMtsNYmmUU=;
 b=H22/o94+2sGKIi1UWiX4sADKybmlD/iqTLgfBiFl71kwz06m6ANa9d9/ytaPXm5S8tg5TMqKByjm0cwKvTxo8o7+Js2t1MeBOFqbeiR3rRVWRH+MGf8AnlVTKzn233wQwAs6B7fKdXnIYI60cdoM/4DlKHVrbwYRoDfXQnS/Mv4=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=oracle.com;
Received: from BLAPR10MB5009.namprd10.prod.outlook.com (2603:10b6:208:321::10)
 by BLAPR10MB4836.namprd10.prod.outlook.com (2603:10b6:208:326::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.20; Wed, 29 Sep
 2021 14:09:05 +0000
Received: from BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::3c49:46aa:83e1:a329]) by BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::3c49:46aa:83e1:a329%5]) with mapi id 15.20.4566.015; Wed, 29 Sep 2021
 14:09:05 +0000
Subject: Re: [PATCHv1] ACPI: processor idle: Allow playing dead in C3 state
To:     "Lazar, Lijo" <lijo.lazar@amd.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>,
        "Gong, Richard" <richard.gong@amd.com>
References: <20210922133116.102-1-richard.gong@amd.com>
 <CAJZ5v0jpOzNS5TFdJNXdxa_p2D_5QQMwwRcSMe8JmjOaTjR8gg@mail.gmail.com>
 <3b26b179-69ba-64a2-807e-8d7609fbeb6e@amd.com>
 <CAJZ5v0g+VcGz65s=iu4fzWmkHS7Z0Dx9tMpDgFZ46f3U4jRkoQ@mail.gmail.com>
 <7b8a7c2a-027f-16c9-0258-d91917c39bac@amd.com>
 <52fd74a5-c0cb-0dcc-b5da-fc84651c2253@amd.com>
From:   Boris Ostrovsky <boris.ostrovsky@oracle.com>
Message-ID: <28f9ca92-85c3-9c3e-6685-2c35a757e616@oracle.com>
Date:   Wed, 29 Sep 2021 10:09:00 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
In-Reply-To: <52fd74a5-c0cb-0dcc-b5da-fc84651c2253@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: SJ0PR05CA0191.namprd05.prod.outlook.com
 (2603:10b6:a03:330::16) To BLAPR10MB5009.namprd10.prod.outlook.com
 (2603:10b6:208:321::10)
MIME-Version: 1.0
Received: from [10.74.99.231] (160.34.89.231) by SJ0PR05CA0191.namprd05.prod.outlook.com (2603:10b6:a03:330::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.7 via Frontend Transport; Wed, 29 Sep 2021 14:09:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 96750350-343a-4d87-79ab-08d98352b242
X-MS-TrafficTypeDiagnostic: BLAPR10MB4836:
X-Microsoft-Antispam-PRVS: <BLAPR10MB48368FD9099BAA153B410C858AA99@BLAPR10MB4836.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ykBToVsaL0ObcIsYBszaaSln6bOTl0fP94uyRgObFac5F059jNbH02yJwdH1MTwOceXTB5/8d+ujuOIgxzqXNQnyLngPH+BzIBnqLB/zQi2GSm+3TEcE0lN0XndVufXTdXOBol3EKj6L5+JMxC2xPqNyeB1NiWoTunTeIk4hPB75s0So4QVB5yLtfDVikv6M9D6pSlSyH3lfpza0m1OFZmGsImdepzPLpDE/Uuce9s4MxdgqzL4M0+RATtmS71khG1umNJO8ncOkGZhRAg03oYtcAZdTXZD8SnYjVmWVviBndsM9L/v0ttIoJBXI7IJE7adUbQ4db9YP/zr4ycKkYC9GukDyzCjlWxEUITyM42hG8lbH2NWNuej5VOJLpIYoAqTaoRwUBR+Cl6sE/JVz9DHBcemxp3Fv4J9s0bEYBFem5c94ZThY5X0UTvwW0aOQEI2p1rhuS21yrvOW3gjC1CC2XskWx33FvIH8xViuz2vxKnm7KzBibWwBpjm62dIv4nz/pmAOXi56LA8fJ83ZDDs650zjveyFRP/2C5Qy7NJKTAbyXrsCtJ6b+x+DUfKrmGcRBlHqGxM+tfLA0zh4+UKK5L3RcYIfj2BlKX54fpRK48ZYHbB8iNN1yKMAXAL7kN/bGO97+RWpmIWKYRfilc9NzpAWRchybds/iTSXJzyY10UczofustC+3ROxKkRM4sAD42d+q1t4BJVB4AXnrFn5ddGjwSvUwt16+JopAOamfudI7jlPzTMG958get98OPAN/1GLbKj0cn+JLzum9qXPGRzATnQG8Y3hrha3pPr++oSGKLlTRWqxfALuY669
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5009.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(2906002)(956004)(86362001)(31686004)(31696002)(38100700002)(4744005)(8676002)(2616005)(54906003)(6486002)(5660300002)(26005)(110136005)(8936002)(508600001)(966005)(44832011)(66946007)(36756003)(4326008)(66476007)(66556008)(53546011)(16576012)(316002)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V3ByQ09jUXovcWk1dDUySmdhV0J3bE0xWHpGaVJDRmdqMmhFUVRVQU9yLzZH?=
 =?utf-8?B?SHcycnRtK2ticzdrcVR5bXR3aVFFSDdQVC9FYVFrVEtWRXdhcE9Bb2RIZ0M2?=
 =?utf-8?B?cklqbC9XQWlxK0hjRmpDdGNoSU1aQ3hMVE01ZjBYRXdEQk5DY1NGWGJ0QWlx?=
 =?utf-8?B?T3lDbmlrVWVOY0puMVZwcDYvdFNVSDZPL2Ricmdmb21EK0gzYkNyVTNPOTVi?=
 =?utf-8?B?bTdDalAvUlpOcHFkMlNSYit4TWNEekJsbXdtN0NqRjhLRTQrSjVpYWVrRFBP?=
 =?utf-8?B?cHdEQmwvYzNqclpHTmZ1Wkt6dERpOVk0K2Vub1BZdEVVd3ZDS25WRE4rSE5m?=
 =?utf-8?B?SkJ5djc0NjJ3MFlxZWF1RWhpRW9MRStLVU1jcW5xWlQ1K1pkTHFRbXJtVEdh?=
 =?utf-8?B?RmtLRS9oSDhwdzBmbldlcVNXem10aFhDRFNvdjhCNGJDbFkyNkg4a2loMVlS?=
 =?utf-8?B?REtST3pXUFV4ZWRaUjVXV0QwbEt6VnN6ZWFOU2pCUDgyaEkvZWlwY2RCNXpP?=
 =?utf-8?B?Mm1wTEVNRlhVMGIyQURlWEs1dmdoejJ4NzI4bnBYWFU3VkNtaVBURnJia3dn?=
 =?utf-8?B?VG5sczFoVE5DRWtnMjIyazhLVXFSN0RRMWNkeE5RUXZYeXVrODRtYklER21D?=
 =?utf-8?B?WWpaZXI1MjB0eEF5c25wVHZFVzRKUnd6NXdTTnZsUE12RGtMMngrTkFMRG5x?=
 =?utf-8?B?ZHBkT1oxeTliK1NMbHVXQVdtZCsvc2MzNW1zZzlVUHhmWnVrWDZ4ZGp5aGlF?=
 =?utf-8?B?UWdaNWM5S01Bb1NaV25seklkVjlHWUU0VHgrM3JEdGQ5cXJXNGIwbTJUR0h1?=
 =?utf-8?B?S1JjSGtYZlpsdnBMUDY4TjhKVGlkZ0pTcDlLeStxUnNVbUxUMmRDaEVpY1FL?=
 =?utf-8?B?WklrK01qZ0dZanJYSm52b3RWVGhsSUZJRS9zWnR0NlFkN3BISmp2akNPVzlm?=
 =?utf-8?B?bmZESmNBUEFoOEpUeUVPaVYwWE4vVTdpUHh3a0FhNjhWc0ZwaUwrRHYvTTdp?=
 =?utf-8?B?OEEzaEovK256SGg4NmdvQVF2RkZOOGRrY0s3enlySkNiOHNSbUx0ZlZ1SXA1?=
 =?utf-8?B?SVBxdlRXY1VLZUl1bkptVkRoS0syOVE1ZTdSak5Pb3ZSeGtjSG5GNml3VW1U?=
 =?utf-8?B?WmNKS0I4V2JIVHc3ekJkbUVxbUFnckVNRGJLbTRHWWpFRytJbzViTTVSY3pR?=
 =?utf-8?B?eklSNWhvTUZJdjFVNjNWUnd4Sk9mY3d5N2pDWVQ3OGtKbjlRYkZPbG5ueFNM?=
 =?utf-8?B?UG54ODdXWXp4ZEluQnVXSUFPTVZKR01GZFdYUjBvQzdrWW1FamlwTmVwbnNS?=
 =?utf-8?B?RVA3Z0VCMk5ZbHhSbmhBQjQwQ3dkU081OFhCdmMxczQ1Y1dMY2pMK0oydVho?=
 =?utf-8?B?TkVLdG0wMmtVUnNLN2xnRWgwRUk2TW5LS2J6bERQNHVneXhkaURTSG0wZElx?=
 =?utf-8?B?SGZUeEV4WkFXa2lGZmNXaG83MFQyanE5NnFQNDUycDMvQXVaRzhYTWdWd2RH?=
 =?utf-8?B?c21SWm1Jd0lXQ2haRE4waVZQUzFFa2xuS0V1b2xINVdLZnNlR1MvWEdpWi8z?=
 =?utf-8?B?THUwc09OSzlndkR6b2VmRWpyekVqdSttcG9yUXpoaDZtTVNTRnM3MHBsNjRI?=
 =?utf-8?B?UjdjL0c0Wjk4R2U0SStvTks4Zk1KaTBCK3ZieEJMYno5V1JLUkgvUE81Y2ls?=
 =?utf-8?B?bjhtSjBrelg4cWxDMzh6blZ5S1hvUkIyamdlM2ZPMG9sTENWWklMcVRhcWR5?=
 =?utf-8?Q?xukHXv+sXgPxJBLCjkLmYRc4SIvzutkjtAxO6HI?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96750350-343a-4d87-79ab-08d98352b242
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5009.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2021 14:09:05.3283
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TtW3jMqkUXZ632HEbCZqmV1Ty0pWULBlk9yESuvmn27vLoDz6wtnCwO9uw5rxqbvDkOu32f2PFrDWvvrAlLuMibo9yHbTdfImzGmg9PDK2A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4836
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10122 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2109290088
X-Proofpoint-ORIG-GUID: 00oku0bW0EKOeGqciPsiCARjZvRFe5m9
X-Proofpoint-GUID: 00oku0bW0EKOeGqciPsiCARjZvRFe5m9
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


On 9/29/21 1:37 AM, Lazar, Lijo wrote:
>
>
>
> Apologies to barge in. This is regarding the patch you added years back - https://www.spinics.net/lists/linux-pm/msg27003.html
>
> Do you recall why C3 was not considered for offline/play dead scenarios in the original patch?


Not really. Perhaps processors from that time (at least AMD ones) did not support C3?


-boris
