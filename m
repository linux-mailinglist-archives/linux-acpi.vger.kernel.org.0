Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26621325A21
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Feb 2021 00:23:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbhBYXWt (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 25 Feb 2021 18:22:49 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:46374 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbhBYXWo (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 25 Feb 2021 18:22:44 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11PN4GJo060726;
        Thu, 25 Feb 2021 23:21:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=NCLzLTXLk/Yj5R2viPobLArIeniNbUdIBuWPMpeeGm8=;
 b=bwLMteU+YO0GvUZ42S8yXiS+cKbAF7EkwXF6iCThVrHNwq21ro/8lJ9Havog9+0Ic6I/
 FBsuNhS4J2tK6Gzo333rd24nP6JP3YrBEAh20lkBMLUnUIzl4/RMipCzgw/QFgNXz3vl
 peyF271j1XdOeI2CXiPeXR63kbIFOmAIMsqFViw+qfFawPwotqvT7wKUblCy7gw96dJo
 QQvVtXGYC4rDsz/znUFFWmbnTrtc87vQQTEkm3NhNB7sxeWu5OSygRNSbqRo2XcyVrSM
 3mTV8tgn/Z1iBSZ6MqIdiYa4LOXt6DbUxtVApXtdgHUD1lxGW2z2mdbfk2uum/XqcCBv HA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 36ttcmg7gt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Feb 2021 23:21:51 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11PN6FbY063914;
        Thu, 25 Feb 2021 23:21:51 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2105.outbound.protection.outlook.com [104.47.70.105])
        by userp3020.oracle.com with ESMTP id 36uc6v4w54-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Feb 2021 23:21:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BSnLO2N3HMqw4BQIdUx9Y8gp4wlkj+1hrz/3KDKMQ9r24wYpxXRt57z78HY/soKIVqrJPumKeb/9a4a1ooBp4s1Rg1btoBmYSow8510V4e48xlkKo+OD/gYr60l4344gKZTdZzoWdrqhBEeJb7QyKsaxcop9W97Ux/rCRerw5aNQLoyzJXbJhtj5zqQ0TH4Na5b44/3pSsM0lJbmJPhVpx+sW16ktTJWex8C9+1gOqaGGzm0tX2x017fWaCdhNNQkxUi6tEGA1Ibe13rDFe1t4HvxNcJg5luymekvbDDW60dbSdzVd4lZikiPlfJPKefZ/RJavan5PZsjdd6BqRLEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NCLzLTXLk/Yj5R2viPobLArIeniNbUdIBuWPMpeeGm8=;
 b=oKQEIVigqQ8GOy8Lhw9gtBzbd65HcLNp2jxJvS/8yQeapmRNf78VyXtxrD6sgvZ3Cz1jIlN4OTYjm5bFGyNnnBlYsT8gX1Kdre9rY3bhshN9A+9MBfrjuxOP0hiarRyxtjnmqp6/rOXSzOdHA8juLS+jWAsj9FSCDLKzKFv00bjGK3et2rq2xJZ11WD66qMm9LhExLyt7s6+EEn4l4+geqrOu+zG2VFFGsuWX3yDDi2pA4cCGh9sZRuv7lTfhRne2eFj+SRZXY8uN4jZktuhoyJhiGAIWJInyYfNhHC/RFGc6uOYHSj4VADDpjTREwRiUOWZlFpCuJo+w9y7D721vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NCLzLTXLk/Yj5R2viPobLArIeniNbUdIBuWPMpeeGm8=;
 b=Y6vRWUOQcpY3e/wY4BUChXI72/gG9XugCSCVcL6y5fO1pDveiS/H2G+QGbfn2Ra8wMGuyLCtEuV45spwzNU42OcAdE7d92Bv6ir7caF7YXKVLTVUIsB090RkGaDZKqWN1/abHEiarUxUM7QIEangcXQr8fdP8xJZxKPltZbbuqw=
Authentication-Results: lists.xenproject.org; dkim=none (message not signed)
 header.d=none;lists.xenproject.org; dmarc=none action=none
 header.from=oracle.com;
Received: from BYAPR10MB3288.namprd10.prod.outlook.com (2603:10b6:a03:156::21)
 by BYAPR10MB3429.namprd10.prod.outlook.com (2603:10b6:a03:81::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.31; Thu, 25 Feb
 2021 23:21:49 +0000
Received: from BYAPR10MB3288.namprd10.prod.outlook.com
 ([fe80::f489:4e25:63e0:c721]) by BYAPR10MB3288.namprd10.prod.outlook.com
 ([fe80::f489:4e25:63e0:c721%7]) with mapi id 15.20.3890.019; Thu, 25 Feb 2021
 23:21:48 +0000
Subject: Re: [PATCH v1] xen: ACPI: Get rid of ACPICA message printing
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Juergen Gross <jgross@suse.com>, xen-devel@lists.xenproject.org
References: <1709720.Zl72FGBfpD@kreacher>
From:   Boris Ostrovsky <boris.ostrovsky@oracle.com>
Message-ID: <f73290b7-9a50-829d-76f6-ba2db3d16305@oracle.com>
Date:   Thu, 25 Feb 2021 18:21:41 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
In-Reply-To: <1709720.Zl72FGBfpD@kreacher>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [138.3.200.62]
X-ClientProxiedBy: SN1PR12CA0107.namprd12.prod.outlook.com
 (2603:10b6:802:21::42) To BYAPR10MB3288.namprd10.prod.outlook.com
 (2603:10b6:a03:156::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.74.97.62] (138.3.200.62) by SN1PR12CA0107.namprd12.prod.outlook.com (2603:10b6:802:21::42) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend Transport; Thu, 25 Feb 2021 23:21:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5c3ce6d2-28c0-4660-ced3-08d8d9e42005
X-MS-TrafficTypeDiagnostic: BYAPR10MB3429:
X-Microsoft-Antispam-PRVS: <BYAPR10MB34290F4EB3764005086D74FB8A9E9@BYAPR10MB3429.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 70oDqX8LKf+t8CQOsXyZjiwlRZEvHfVRloIBPoEzxBzuXWxUXIK8rTPrsJJAqrckVv3lSxTQhP6+spioyfXZF4oBttJwyttXxRDKdOiJmZo7voXsUIZXzNV1KRlu3RhANMw8FwXhx5Qe8Jt6GjOUtb0lbZZpmLvRNCuTmoCecvRdSU+MrnoxUf4zXOyn1EGajRgI3Ubcl3XnUUcomum1BurbXqih10spqQc6XaqcA8dTBVEM0riqrKm4ns3fwFyqFVkncCJxYwevoWP7bRsw0Sc8ChWXsPMC1GZt2UnaNrgVipT7ufDnt8vPW8C4mbXr5zNrCI4sQJrPmxoAVwHGtqYzKgFKJ/4tfCzCSTTyPouYh78850bp+ehzhog49DWFPgX8ZVJT/Ij+UAchqQfYu35+hccIEa5gBNTg4qDmcyMBtdElWP0/FiTN4T5N4IPxgPJSvWMvzE6AA8bgTio8eBeSv5okiVJ+5tVauUk1lqAk9hOdDAdAuplbRUJvGAGR6wSvPm19CEpmWYYT0SVtxE+iQ8zlXQQkGBtVeBlaZvyH9JDowvWAX3oOM4UY/50JPKkXBQRh4a0HLLV98dM2dpVHRGj1eBZW1woXgXShyVFP6zeFdlcnMWIS2TrKHMFU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3288.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(136003)(346002)(366004)(396003)(39860400002)(66946007)(83380400001)(316002)(31686004)(4326008)(16526019)(5660300002)(16576012)(66556008)(478600001)(54906003)(186003)(15650500001)(26005)(66476007)(6666004)(36756003)(6486002)(53546011)(31696002)(44832011)(2616005)(2906002)(110136005)(8676002)(86362001)(956004)(8936002)(26583001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?VXlaa0JJS1VCaDQ5N1VvQ05Na1QrTXk3SWJHci9rZnloMHAvT0RKNmlOcExE?=
 =?utf-8?B?OWE0SHhORnliUXErN2ZMWVpSakhoVmhTSkQ3U1RZWW16TnZOQVRqbnJaM3hM?=
 =?utf-8?B?Uzg2djdBd3BoQmVEM3hvcWdVbXZRZ1BESWI4MWo5MnNZMVVkTmEveW5aZkNI?=
 =?utf-8?B?bTN4NkhJNGRyYVZCdDEyNklwREhUZm5tK1NLVmg2ZklWeTNwV3pRSmJWSis2?=
 =?utf-8?B?VEVxSlRVelpVODhrQ0ViOGJwQjhyWk41M3NBZE1Hc2xZbnBwcUVsVzhRTHp6?=
 =?utf-8?B?ZFk5WGNnd3lJb2dzUUhZanJscUFMUzlxaitxQm5hRWV1MW44UVRoS0UrSTFx?=
 =?utf-8?B?TCtGeldDWnY3QkJTWnc1VW5HeDNBVlB1MldEUndaeVBIU1ZSSVNsS3JRT2Fj?=
 =?utf-8?B?YlpMYmpHdG4vYW1HaVpwNUw1WmVzaXFwYUdqUXhZbzVCaWozamhpRmR4cnl0?=
 =?utf-8?B?YVVYNDRKdEMrQ3RZNE0rZXNZdEZzSnp3b3FCOUhlcGh4bmhySm05b2RXTzVY?=
 =?utf-8?B?UVlMemwyVEZCV0ZaUHZvN1pVWUwwUmgzaGl3Qi9hRnFKU2w5ajZzTmxkVFFX?=
 =?utf-8?B?QmxYL1FGYjdDZ2lmcnJJbVlteksxMnh0bm1sUXhrd2U2bUUwYk91UEs5dDZW?=
 =?utf-8?B?S3QwaGVSbktzajI0cWtNeHJYUlI1bjZPVU1jbWs0eDh0bzkyTUdoVDMwek1w?=
 =?utf-8?B?YWt6dnlsNHhsV2dETnpVck1YTHFOWmRUeDV5TWZWdkRZeXFCK3hySVBRMExB?=
 =?utf-8?B?N2x3NFhqVzRIV3pWRmg2cGJBYnl6VlRmZWhQSGRvdkNZdTFLcFMxZEdZemR0?=
 =?utf-8?B?YWduU1J4bEU0a1lzend3ZlJPUlNOdW5jdGZjcE83bFNzeHRvQVJ4T0szTytv?=
 =?utf-8?B?ck1xU0ZhWXZ2eTZnQTErcDVVZm9EZjFnaWFsV2FsV2dmOWN1MUdad2xBb2Z6?=
 =?utf-8?B?WWF4OUFvVUhGcEZmRnkrdWZYOXBiejF6K2JkUVVVV3NKd3JCbmM3ZGl2d1hI?=
 =?utf-8?B?ZkppdXIzN3NFbWIvODljdG9makt3c3JEOVpyNUlBeFI3emRIajhEazNGTVJG?=
 =?utf-8?B?a0xRTUhheThHSThVSk1hU0Mvd0NsMCtGU0FiU2hMQzI3MzBna29MbEovblNO?=
 =?utf-8?B?cXB3RHg0M2VKd2RPSFEycFZRYzZLY2ErZmt2dERTaDlsQzBqeTVhZXdITU9i?=
 =?utf-8?B?azlmTXVUZ0pzbmZZM21GdWJEMTZ1SlhjRXZnWU5IdnAzN3BNQlhsYWd2ekI0?=
 =?utf-8?B?b21iMlpuZmcvRW10Uk54c3NXeW1JalJoVFhDSFpGYmpkak54S25YcFBZR0lV?=
 =?utf-8?B?TlpVM2Y1WTMyOE44bTVZTEU1RE4ydnBaREcxNG9NS1lJRnBGR3dPWlBhYnFE?=
 =?utf-8?B?aVNYdis1V0x3ZVRkMmllRDkyM3p6TDg3ZVpIS2Q2UWxzVVRxc0lNRVBYRjgv?=
 =?utf-8?B?Qk1KUU9XYWZYTXpGbDJPcVpPUDI5TDFZeE9tNitmOG93VitzbEFqWjVCcEFD?=
 =?utf-8?B?V0V5Mk5IVXk0bFdRR3plc2NVMkczUlFKL0ViQmF3ek1YK0J2OGZsOFdDYXFO?=
 =?utf-8?B?TUptKzJwdUk0RHJ1S2ZYSGs0eklZM0VVL0h4TEV3KzhwUnZLK2l5YXZNaTdz?=
 =?utf-8?B?NllzNGF0eVVhbTdOMWNKWG9EdGNieUt5VEQ1UFR3djBLUFZTV0Y4MEk4L0F3?=
 =?utf-8?B?dTZ6c011UXUvdGpwSjk4WmMwMDJRallDTGt1ZWZwMlNUZlR1Ym5mK2VQaTRz?=
 =?utf-8?Q?9oRpAFgLFk0FbypXQDHGvsumjgX5MUCFvbLyMg+?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c3ce6d2-28c0-4660-ced3-08d8d9e42005
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3288.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2021 23:21:48.7666
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9V4925iD72Mty/9IIR/kUgw3SnyZQV1SdoTk1UcWkBGaNiU18EthUUGEAnjW3TXm/0Pkxwq5iJ1LMerecsA4U4++VzNwTH4hlTAQ+I0U704=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3429
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9906 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102250175
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9906 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 lowpriorityscore=0 spamscore=0 mlxscore=0 bulkscore=0 clxscore=1011
 priorityscore=1501 malwarescore=0 impostorscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102250175
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


On 2/24/21 1:47 PM, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> The ACPI_DEBUG_PRINT() macro is used in a few places in
> xen-acpi-cpuhotplug.c and xen-acpi-memhotplug.c for printing debug
> messages, but that is questionable, because that macro belongs to
> ACPICA and it should not be used elsewhere.  In addition,
> ACPI_DEBUG_PRINT() requires special enabling to allow it to actually
> print the message and the _COMPONENT symbol generally needed for
> that is not defined in any of the files in question.
>
> For this reason, replace all of the ACPI_DEBUG_PRINT() instances in
> the Xen code with acpi_handle_debug() (with the additional benefit
> that the source object can be identified more easily after this
> change) and drop the ACPI_MODULE_NAME() definitions that are only
> used by the ACPICA message printing macros from that code.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>


Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>



