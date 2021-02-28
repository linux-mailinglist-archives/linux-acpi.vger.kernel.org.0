Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73BD4326FFF
	for <lists+linux-acpi@lfdr.de>; Sun, 28 Feb 2021 02:49:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbhB1Bs4 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 27 Feb 2021 20:48:56 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:37360 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbhB1Bs4 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 27 Feb 2021 20:48:56 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11S1jE5J157296;
        Sun, 28 Feb 2021 01:48:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=JRCG3BWxZVhuS9n46tYU+6TTJsKzBBEdKYKlrw9u8Y0=;
 b=QGHXtHIJrArjI+NPlkRr1EUU7Zth721PmlH8D1D/kxSV172xWxKr6yIku/Bhp8Sdd8LH
 IhVVU9vy0JnTEeUjGJ2rh5qapjmyynyVn9nUFJGa1iHIEGdw6T82ecvkhwY4TXghE/Oc
 5lWKak74sjeFupApI/88Erln9EfNCyYkbj4gJnJ5b7oWmCDDQqwm5HAOICG3tevMAyzK
 zcS62qM9DuzA11VQsmFuO02KLfQsZXSK3Zd7Yo3usd6gpHmGB2FSn3OvBtGPHQfG+E7b
 xLSYPsFx1ztvyxomtxFJrgG1y4l3QuPYX7uy9DEEHkaMCrAIRgnZn0hKQnf55yjO9fiF hw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 36ye1m12e2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 28 Feb 2021 01:48:05 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11S1kL11142170;
        Sun, 28 Feb 2021 01:48:04 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by userp3020.oracle.com with ESMTP id 36yyup2177-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 28 Feb 2021 01:48:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VIAih/CfMpllZplrB2mlRB4v74bNQKFnBjaxYWUmjhPj/t4R45tSNNEDZeEbw9e0AAiqKZTFqZSJSxE/crPSIW2ppsDQMv8e54OsudvcMsXB8YW6RYNQDDNwXKLqeiXq9kcO0aNHox2LiYDv4RsD9jG55gzvbkL8bY09w/dK5gmCtEpk9EKgwouN/puAgJZ+N6Ts4pre8QNvf2tLUtRx1PrzcJqoAJPwP90Ae3csNT9ub+MttncRq0c2v/P1RMba8G+cIoBpfVv3xQxV78GESy7fmVr3hqFsQpXi5cUdo8qncvghlQE9Gc+djvILkJ8blpOU/6+LoZqR807soHO3vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JRCG3BWxZVhuS9n46tYU+6TTJsKzBBEdKYKlrw9u8Y0=;
 b=fKHYYbxdpxah3dvwFu2JTMyh0BKw6p+Rsf9ww541ikxmUkMNrZJI2/A6WrK4Vm9N+JbrqiJlq8e1e4BgLZwisPhZ7PzrweDrF4PeSxdewJy9WxGIGbKx7X2ru3x/NC0fDTdWOhuxbpPBsbtF7BikwKGtlnGjvg3k4jIQ5+yppdwNoBkHy7TVu37FnRJvdc+HLB+ZpJQjUMM/EvFyOkpBf6gYZEoaVgIj7iTQDcQcnHXd3kU7p84bm/cgdez0pzXWIkz/87VoYpLmCDz1e08Cmwd6myf/dhPpliZlBo+BdlgODXMb4SjEYLqOcIsE72bAeZ6QCIqbizfF6HYewEbfiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JRCG3BWxZVhuS9n46tYU+6TTJsKzBBEdKYKlrw9u8Y0=;
 b=fQUvBqvTuBrh+8yRT63Uq0gYBfVZF0YjeLy5OK+0vsnzxBJPF6hpWZ9MLay4cg6DwnoIky9/+uYwgjX2ZKjKZ057kVKPua+QcDGrKBfQjEAtvD4J+V4W48xgGMGzbj160ryT0xsIV/QYLdIvMuI0rd1Z+0qTvPlSaXjP2pAVJkw=
Received: from BYAPR10MB3288.namprd10.prod.outlook.com (2603:10b6:a03:156::21)
 by BY5PR10MB4226.namprd10.prod.outlook.com (2603:10b6:a03:210::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.23; Sun, 28 Feb
 2021 01:48:02 +0000
Received: from BYAPR10MB3288.namprd10.prod.outlook.com
 ([fe80::f489:4e25:63e0:c721]) by BYAPR10MB3288.namprd10.prod.outlook.com
 ([fe80::f489:4e25:63e0:c721%7]) with mapi id 15.20.3890.025; Sun, 28 Feb 2021
 01:48:02 +0000
Subject: Re: [PATCH v1] xen: ACPI: Get rid of ACPICA message printing
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        xen-devel@lists.xenproject.org,
        Konrad Wilk <konrad.wilk@oracle.com>
References: <1709720.Zl72FGBfpD@kreacher>
From:   Boris Ostrovsky <boris.ostrovsky@oracle.com>
Message-ID: <eaeba4a0-7bb9-7b17-9ba6-49921f6e834c@oracle.com>
Date:   Sat, 27 Feb 2021 20:47:57 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
In-Reply-To: <1709720.Zl72FGBfpD@kreacher>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [138.3.200.62]
X-ClientProxiedBy: SJ0PR13CA0083.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::28) To BYAPR10MB3288.namprd10.prod.outlook.com
 (2603:10b6:a03:156::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.74.98.190] (138.3.200.62) by SJ0PR13CA0083.namprd13.prod.outlook.com (2603:10b6:a03:2c4::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.9 via Frontend Transport; Sun, 28 Feb 2021 01:48:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4aa07595-649b-4024-faf7-08d8db8ae258
X-MS-TrafficTypeDiagnostic: BY5PR10MB4226:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR10MB4226A07E40ECF615230B45458A9B9@BY5PR10MB4226.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vqRZVxewTk1FwRwQvVF1b6YNt99L2SOFwK3C5U0YiMpBuSDeuPt9kc+YWJIWf2AASho+9K64OajT/aKWJSDrCfzSFewmqGBT0NDAMJUDFEv0HA27IQA5rRx0fLamvaOEsBHeOfnAQnVWTeYVtAz8u/G4mQ66PK49K6HM8AcBJQMvQ4BK57AHX/viq8cvLjoM9+PaWCjk+QPkNNVxZTXwItfFnyXEmaUGCgjuXg0pW1Fy97uZmqV6Tj3JNlUTmMAB69EBbuQ4ZK3GweNkecyo5/zat23eLWj09cHjjNKfLalNQtsOj4ZHugJICZYVot1yMNCSRJqK0XXn9wioo8YFnRkGW/hcXuyXnfwyWPXYXfHQjWTAJnZatAlRLMZOCSQ+CVNb7ADwBUpNg0R9eMD+TvOvbl0u7UZZo2uYCi1so8J0bEZd+C7YWSpsdhRzlvNpLoehlx47cOazyd9VhrGvEjgNmGThROr1ulkUD/bn5aqx2ikm6DdcgRnB2iWqBFPBcJcRq5j1Aj7U7zJinoBBcNKbThkd24X2i0nCV3v5YZXiLHtV/S7FLrTQRQFKJi6LnQXsDBj2G390Dmp585p+RSrvPCDA8UvgRfzXlMifqC/+pUCA0hnoDii+Kt6/0Op8EUze0DGN6nje3iZqwCRY0A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3288.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(39860400002)(366004)(136003)(396003)(346002)(53546011)(66946007)(86362001)(31696002)(478600001)(107886003)(5660300002)(4326008)(6666004)(66476007)(15650500001)(6486002)(31686004)(66556008)(8676002)(16526019)(2906002)(16576012)(186003)(316002)(8936002)(83380400001)(110136005)(956004)(44832011)(54906003)(2616005)(36756003)(26005)(26583001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?V3VaZzNEeGRYYjlNQTVHZzRrbTVtTk5kMkdXODAwSFE2dzRQZ0N3TFNWNVV1?=
 =?utf-8?B?dlRETUZHQytjblUwOUNhV2lHQ0gwYjFjMjNSdDM4OXhGRUZqaS9HQUR3Z09T?=
 =?utf-8?B?NU5EZ20wMTFPb2Rla0Jsd1phWEZidExNa3JkOVc1ZTNLUGRyQWlhZHhpd0d6?=
 =?utf-8?B?VDZ4Qk9GMElyWlRKbEFqWFllMFl3blZiMW5wYnU2eW40Y1J6Njh2UmRnSW1s?=
 =?utf-8?B?K0haZzQ1WmI4dHk2L1lHclpUN2Nhak1ydVFQZ2dnTExvdkJiS2Z5TTFrMUtB?=
 =?utf-8?B?alFkRDhPV2Fad3hqanRTbkE3Rnkwdm45L0FycFZJUnd1UytOWGlSTEFuWmxT?=
 =?utf-8?B?dU5PWDRVRlMzMDNRYno2L09BYXJ3R2lHLytBbUkzT2tQRkpsdkZ0NmF6c01U?=
 =?utf-8?B?YTYvc2xjenY0azNIMlZueEQ5YlNvMTA3VEQ1R1p2NHdrKzhVM2VBM2lzK0gx?=
 =?utf-8?B?SCtVbVBKRlU5clYrVHpJa0ltZ0ZVd2hjdFVNWWlXS0NZdEVSdmFoVkJkOWsz?=
 =?utf-8?B?NDdoUEV1YlNud1E4T0pEMUZVY2VlYk5PUzhNRWlOdE1iMWVNU05LWE01VTFu?=
 =?utf-8?B?a0dpeXBTaWtnTTdNSCtwaGo1NjM5UE9uR0xiTXN5MW51OEhiNk9kMXBDaWov?=
 =?utf-8?B?dXFySVlBSExZV0NZVTJrZ0lzeDlGTWdrZHhBTU95eGR4ckRRb0I1YmE3MThC?=
 =?utf-8?B?T2hFbkRwTEZwbm5WWG1KQjgwQjVoU1V6d2dDRDlZNW1ES0RMb0FCQXNFWEk2?=
 =?utf-8?B?WFdtcG53M0lTN3BJbXJRQXB2L0hZOS9PdnZ6cmVPQ3pnMXN4WWM2WGJnUEd5?=
 =?utf-8?B?cHJjNWQ4aFJuWGtTa2VYWkxvWWlOZFl0a3RBQjVNNVdXZ1NwZ0NmWnFwVzVD?=
 =?utf-8?B?cHhWR25oc2dDVXZtcU9jaHBDM2pWSWgyVFBINEZ1MzVTdjVUamhaemhvUG9I?=
 =?utf-8?B?c3d6dTNwbERWemw4U0dDK01ObWNXNjg2Nzc2Y2pIZldIVE1nT0szTTZja0RF?=
 =?utf-8?B?S0NmUW9pZXNNS0RFYkF6TjFOV1g4QU1rR0ttcDQrZENOaFFHRXhJdWFFMC9Y?=
 =?utf-8?B?Y2dZV0kxYVhWM2NSTEQxOXhVV2dpeGF3Ly95ZTE5bWpjeTUybGtFSFhSN1lh?=
 =?utf-8?B?TEhIdWt6ZTBUdkx4VkEvSDRTb2hCaW5WZzRnL01URGFpc01PLzl6UkpRL2k4?=
 =?utf-8?B?SUZTTGh6a0FsR0wrR2c2K0lzWEZWWTY4elNjL3dqSU9Hd2FPNWh6OVFCNDZ6?=
 =?utf-8?B?S0pqRzhyVUN6a0RncjIvNXEvOW9GV0ZnZklkTnN3dWhncjMwMERxZjNsem9h?=
 =?utf-8?B?QUVTUHdIQmxHcUNGeFdVWWppUDk1K0pUajFQUDlySldrZDdUci9lNFdCSitH?=
 =?utf-8?B?dU9UYTExa1QrSWdEM1pjV2hwZDhrVTRrcFhsbGNvRnQ4cklEZ1d4YzBhS0Er?=
 =?utf-8?B?dDVtWFZjY2FMTEVSN0tGQUkrL0o5RWhOL21YZjZqeHpPZkVuRkpyZTFHd0NQ?=
 =?utf-8?B?bkhOTnllNjh4M285VGZVWXNCNDduWUR2V1BoU282emZ2NFFlY1NFUXpMdVln?=
 =?utf-8?B?V0hHaEZoeFlsSkM0YmloOWJXb05lTlBrUkV5OG44UjhuSndJRjhDbStzV3pP?=
 =?utf-8?B?VzNub0FLeGhma2pvNGFBMmIvMitEWU1IQTZxTWV3UVUzSmhYaUwvMks4ZmZF?=
 =?utf-8?B?cWZLTUttWnZxRURQa0NVR3hOdEpoWnBlL1hNVVROdHQrVkVHVE03bFFkT0xJ?=
 =?utf-8?Q?lfNr4eOAUDYbTArF72TrhAuxmMTIu/83/AMBCLM?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4aa07595-649b-4024-faf7-08d8db8ae258
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3288.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2021 01:48:02.5335
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5XG48lgiocDWM4bpDfiLyWTk/MGDVwOlREfw8n5OKRZ9Kv7JkgMRjX5i0m2lGjgar5a1YFqFXN4KgZ9rzxU+AZvcxk2Fd8wOILAZP/QdERg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4226
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9908 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102280010
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9908 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 priorityscore=1501
 mlxlogscore=999 impostorscore=0 suspectscore=0 adultscore=0 malwarescore=0
 mlxscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102280010
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
> ---
>  drivers/xen/xen-acpi-cpuhotplug.c |   12 +++++-------
>  drivers/xen/xen-acpi-memhotplug.c |   16 +++++++---------


As I was building with this patch I (re-)discovered that since 2013 it depends on BROKEN (commit 76fc253723add). Despite commit message there saying that it's a temporary patch it seems to me by now that it's more than that.


And clearly noone tried to build these files since at least 2015 because memhotplug file doesn't compile due to commit cfafae940381207.


While this is easily fixable the question is whether we want to keep these files. Obviously noone cares about this functionality.


-boris

