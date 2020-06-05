Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2DC01EFE1B
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Jun 2020 18:38:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbgFEQio (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 5 Jun 2020 12:38:44 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:45064 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725961AbgFEQim (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 5 Jun 2020 12:38:42 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 055GWCR9129997;
        Fri, 5 Jun 2020 16:38:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=GBw2x+1slDH/L7nexbscolsh28QbJeWBYvPtLNFoXcg=;
 b=awYfieWRjiAW2PZAqKLuejsT7zkjRfWS1HASbQ9gFQEzqPxyn6Pw1tjmg3G4JiKOHxoP
 TepJsRqBJBvsg/3bZewWfH7LPGOXzjPFC3kfqXmTlklJI9EwuHUG78DyjO54ic/q+n4d
 JS+T+nulkrQkb+MbV3lWB7D3K+AXzWT7oypR3G9ry9skzHgEJePbr2CCiGAxy5WsTkR5
 DTisa6ksj3F6Ayr5eka9I/bRce8XotErDoYW9h8CEfBhSKVJJz6ICTP/ZDGW5K0NoiQ4
 gaWdxaNQ8zqYrzT0NYG5A43lPe3NdqlWM3QDeV1gUvVUnc2zzBKcZuGIDySuuuH/hdNH hQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 31f9263r2n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 05 Jun 2020 16:38:03 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 055GbdBQ010206;
        Fri, 5 Jun 2020 16:38:02 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 31f925pqcs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 Jun 2020 16:38:02 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 055Gc0lQ006773;
        Fri, 5 Jun 2020 16:38:00 GMT
Received: from [10.175.51.78] (/10.175.51.78)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 05 Jun 2020 09:38:00 -0700
Subject: Re: slub freelist issue / BUG: unable to handle page fault for
 address: 000000003ffe0018
To:     Kees Cook <keescook@chromium.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marco Elver <elver@google.com>,
        Waiman Long <longman@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Len Brown <lenb@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
References: <7839183d-1c0b-da02-73a2-bf5e1e8b02b9@suse.cz>
 <94296941-1073-913c-2adb-bf2e41be9f0f@oracle.com>
 <202006041054.874AA564@keescook>
 <cb0cdaaa-7825-0b87-0384-db22329305bb@suse.cz>
 <34455dce-6675-1fc2-8d61-45bf56f3f554@suse.cz>
 <6b2b149e-c2bc-f87a-ea2c-3046c5e39bf9@oracle.com>
 <faea2c18-edbe-f8b4-b171-6be866624856@oracle.com>
 <CAJZ5v0jqmUmf7mv3wjniVM-YqPqhDSjxunU0E4VYCsUQqvrF_Q@mail.gmail.com>
 <ce333dcb-2b2c-3e1f-2a7e-02a7819b1db4@suse.cz>
 <894e8cee-33df-1f63-fb12-72dceb024ea7@oracle.com>
 <202006050828.F85A75D13@keescook>
From:   Vegard Nossum <vegard.nossum@oracle.com>
Message-ID: <2055681b-35cf-1ca6-00d1-c47868bbf28d@oracle.com>
Date:   Fri, 5 Jun 2020 18:37:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <202006050828.F85A75D13@keescook>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9643 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 malwarescore=0 bulkscore=0 mlxscore=0 spamscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006050125
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9643 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 suspectscore=0 cotscore=-2147483648 bulkscore=0 clxscore=1015
 impostorscore=0 priorityscore=1501 malwarescore=0 mlxlogscore=999
 spamscore=0 lowpriorityscore=0 mlxscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006050124
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2020-06-05 17:44, Kees Cook wrote:
> On Fri, Jun 05, 2020 at 04:44:51PM +0200, Vegard Nossum wrote:
>> That's it :-) This fixes it for me:
>>
>> diff --git a/drivers/acpi/acpica/nsaccess.c b/drivers/acpi/acpica/nsaccess.c
>> index 2566e2d4c7803..b76bbab917941 100644
>> --- a/drivers/acpi/acpica/nsaccess.c
>> +++ b/drivers/acpi/acpica/nsaccess.c
>> @@ -98,14 +98,12 @@ acpi_status acpi_ns_root_initialize(void)
>>                   * predefined names are at the root level. It is much easier
>> to
>>                   * just create and link the new node(s) here.
>>                   */
>> -               new_node =
>> -                   ACPI_ALLOCATE_ZEROED(sizeof(struct
>> acpi_namespace_node));
>> +               new_node = acpi_ns_create_node(*ACPI_CAST_PTR (u32,
>> init_val->name));
>>                  if (!new_node) {
>>                          status = AE_NO_MEMORY;
>>                          goto unlock_and_exit;
>>                  }
>>
>> -               ACPI_COPY_NAMESEG(new_node->name.ascii, init_val->name);
>>                  new_node->descriptor_type = ACPI_DESC_TYPE_NAMED;
>>                  new_node->type = init_val->type;
> 
> I'm a bit confused by the internals of acpi_ns_create_note(). It can still
> end up calling ACPI_ALLOCATE_ZEROED() via acpi_os_acquire_object(). Is
> this fix correct?
> 

include/acpi/platform/aclinuxex.h:static inline void 
*acpi_os_acquire_object(acpi_cache_t * cache)
include/acpi/platform/aclinuxex.h-{
include/acpi/platform/aclinuxex.h-      return kmem_cache_zalloc(cache,
include/acpi/platform/aclinuxex.h- 
irqs_disabled()? GFP_ATOMIC : GFP_KERNEL);
include/acpi/platform/aclinuxex.h-}

No comment.


Vegard
