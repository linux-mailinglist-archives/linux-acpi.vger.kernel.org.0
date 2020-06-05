Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F5FE1EF845
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Jun 2020 14:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbgFEMsJ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 5 Jun 2020 08:48:09 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:43152 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726552AbgFEMsI (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 5 Jun 2020 08:48:08 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 055Cg3dp118504;
        Fri, 5 Jun 2020 12:47:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : references : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=KapCunL+f5y0ROBLNbLpuHlEjvE8kkYsJySPIhLHQcs=;
 b=eDCSh3wAm7SG1I8hSm6gf1YW6DbY2A+hUXR5XW0emL+T8aXdVq5MhPQYAfxQXCwBv/bh
 dDO2s7VpihC1HEZPEg3Ld8zouVmmp0NL7TJlub0KYMkJma01RZ3V0i+0RmQZjUQPc1EN
 B2OpZBAri6repN1dQbshuIAJLmfH8+C1BR5giWfrw/TMPH62E6sJBV4D5ja/IohzO0bH
 B4YTR7VX3ZOuh0XWdM+Y8CK7oY2zL35u6oU7lHT+/4EefWKWgl8VNlNtZ1AxRaBNPoAS
 RsuLSsktzjjR0t6odR1jVcaaeapNAZbJmj0iWimfl7mjBHJ0F4XYPEj/Tckcruivalrv hg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 31f9242p11-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 05 Jun 2020 12:47:26 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 055Cc7o5038704;
        Fri, 5 Jun 2020 12:47:26 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 31f927f48e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 Jun 2020 12:47:26 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 055ClN8V009606;
        Fri, 5 Jun 2020 12:47:23 GMT
Received: from [10.175.51.78] (/10.175.51.78)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 05 Jun 2020 05:47:23 -0700
Subject: Re: slub freelist issue / BUG: unable to handle page fault for
 address: 000000003ffe0018
From:   Vegard Nossum <vegard.nossum@oracle.com>
To:     Vlastimil Babka <vbabka@suse.cz>,
        Kees Cook <keescook@chromium.org>,
        Robert Moore <robert.moore@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marco Elver <elver@google.com>,
        Waiman Long <longman@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>, linux-acpi@vger.kernel.org,
        Erik Kaneda <erik.kaneda@intel.com>,
        Len Brown <lenb@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
References: <4dc93ff8-f86e-f4c9-ebeb-6d3153a78d03@oracle.com>
 <7839183d-1c0b-da02-73a2-bf5e1e8b02b9@suse.cz>
 <94296941-1073-913c-2adb-bf2e41be9f0f@oracle.com>
 <202006041054.874AA564@keescook>
 <cb0cdaaa-7825-0b87-0384-db22329305bb@suse.cz>
 <34455dce-6675-1fc2-8d61-45bf56f3f554@suse.cz>
 <6b2b149e-c2bc-f87a-ea2c-3046c5e39bf9@oracle.com>
Message-ID: <faea2c18-edbe-f8b4-b171-6be866624856@oracle.com>
Date:   Fri, 5 Jun 2020 14:47:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <6b2b149e-c2bc-f87a-ea2c-3046c5e39bf9@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9642 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 mlxscore=0 adultscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006050094
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9642 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 impostorscore=0
 adultscore=0 priorityscore=1501 mlxlogscore=999 mlxscore=0 bulkscore=0
 lowpriorityscore=0 cotscore=-2147483648 phishscore=0 spamscore=0
 malwarescore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006050094
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2020-06-05 11:36, Vegard Nossum wrote:
> 
> On 2020-06-05 11:11, Vlastimil Babka wrote:
>> On 6/4/20 8:46 PM, Vlastimil Babka wrote:
>>> On 6/4/20 7:57 PM, Kees Cook wrote:
>>>> On Thu, Jun 04, 2020 at 07:20:18PM +0200, Vegard Nossum wrote:
>>>>> On 2020-06-04 19:18, Vlastimil Babka wrote:
>>>>>> On 6/4/20 7:14 PM, Vegard Nossum wrote:
>>>>>>>
>>>>>>> Hi all,
>>>>>>>
>>>>>>> I ran into a boot problem with latest linus/master
>>>>>>> (6929f71e46bdddbf1c4d67c2728648176c67c555) that manifests like this:
>>>>>>
>>>>>> Hi, what's the .config you use?
>>>>>
>>>>> Pretty much x86_64 defconfig minus a few options (PCI, USB, ...)
>>>>
>>>> Oh yes indeed. I immediately crash in the same way with this config. 
>>>> I'll
>>>> start digging...
>>>>
>>>> (defconfig finishes boot)
>>>
>>> This is funny, booting with slub_debug=F results in:
>>> I'm not sure if it's ACPI or ftrace wrong here, but looks like the 
>>> changed
>>> free pointer offset merely exposes a bug in something else.
>>
>> So, with Kees' patch reverted, booting with slub_debug=F (or even more
>> specific slub_debug=F,ftrace_event_field) also hits this bug below. I
>> wanted to bisect it, but v5.7 was also bad, and also v5.6. Didn't try
>> further in history. So it's not new at all, and likely very specific to
>> your config+QEMU? (and related to the ACPI error messages that precede 
>> it?).
> 
> I see it too, but not on v5.0. I can bisect it.

commit 67a72420a326b45514deb3f212085fb2cd1595b5
Author: Bob Moore <robert.moore@intel.com>
Date:   Fri Aug 16 14:43:21 2019 -0700

     ACPICA: Increase total number of possible Owner IDs

     ACPICA commit 1f1652dad88b9d767767bc1f7eb4f7d99e6b5324

     From 255 to 4095 possible IDs.

     Link: https://github.com/acpica/acpica/commit/1f1652da
     Reported-by: Hedi Berriche <hedi.berriche @hpe.com>
     Signed-off-by: Bob Moore <robert.moore@intel.com>
     Signed-off-by: Erik Schmauss <erik.schmauss@intel.com>
     Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>


Vegard

>>> This would mean acpi_os_release_object() calling 
>>> kmem_cache_free(ftrace_event_field, x)
>>> where x is actually from kmalloc-64? Both parts of that sounds wrong.
>>>
>>> Thread starts here: 
>>> https://lore.kernel.org/linux-mm/4dc93ff8-f86e-f4c9-ebeb-6d3153a78d03@oracle.com/ 
>>>
>>>
>>> [    0.144386] ACPI: Added _OSI(Module Device)
>>> [    0.144496] ACPI: Added _OSI(Processor Device)
>>> [    0.144956] ACPI: Added _OSI(3.0 _SCP Extensions)
>>> [    0.145432] ACPI: Added _OSI(Processor Aggregator Device)
>>> [    0.145501] ACPI: Added _OSI(Linux-Dell-Video)
>>> [    0.145951] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
>>> [    0.146522] ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
>>> [    0.147070] ACPI Error: AE_BAD_PARAMETER, During Region 
>>> initialization (20200430/tbxfload-52)
>>> [    0.147494] ACPI: Unable to load the System Description Tables
>>> [    0.148104] ACPI Error: Could not remove SCI handler 
>>> (20200430/evmisc-251)
>>> [    0.148507] ------------[ cut here ]------------
>>> [    0.148985] cache_from_obj: Wrong slab cache. ftrace_event_field 
>>> but object is from kmalloc-64
>>> [    0.149502] WARNING: CPU: 0 PID: 1 at mm/slab.h:523 
>>> kmem_cache_free+0x248/0x260
>>> [    0.150254] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.7.0+ #43
>>> [    0.150490] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), 
>>> BIOS rel-1.13.0-0-gf21b5a4-rebuilt.opensuse.org 04/01/2014
>>> [    0.150490] RIP: 0010:kmem_cache_free+0x248/0x260
>>> [    0.150490] Code: ff 0f 0b e9 9d fe ff ff 49 8b 4d 58 48 8b 55 58 
>>> 48 c7 c6 10 47 c1 a4 48 c7 c7 f0 c1 d0 a4 c6 05 9f 05 b1 00 01 e8 bc 
>>> cc eb ff <0f> 0b 48 8b 15 5f 36 9b 00 4c 89 ed e9 d6 fd ff ff 0f 1f 
>>> 80 00 00
>>> [    0.150490] RSP: 0018:ffffb4dac0013dc0 EFLAGS: 00010282
>>> [    0.150490] RAX: 0000000000000000 RBX: ffffa38a07409e00 RCX: 
>>> 0000000000000000
>>> [    0.150490] RDX: 0000000000000001 RSI: 0000000000000092 RDI: 
>>> ffffffffa51dd32c
>>> [    0.150490] RBP: ffffa38a07403900 R08: ffffb4dac0013c7d R09: 
>>> 00000000000000eb
>>> [    0.150490] R10: ffffb4dac0013c78 R11: ffffb4dac0013c7d R12: 
>>> ffffa38a87409e00
>>> [    0.150490] R13: ffffa38a07401d00 R14: 0000000000000000 R15: 
>>> 0000000000000000
>>> [    0.150490] FS:  0000000000000000(0000) GS:ffffa38a07a00000(0000) 
>>> knlGS:0000000000000000
>>> [    0.150490] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>> [    0.150490] CR2: 0000000000000000 CR3: 000000000560a000 CR4: 
>>> 00000000003406f0
>>> [    0.150490] Call Trace:
>>> [    0.150490]  acpi_os_release_object+0x5/0x10
>>> [    0.150490]  acpi_ns_delete_children+0x46/0x59
>>> [    0.150490]  acpi_ns_delete_namespace_subtree+0x5c/0x79
>>> [    0.150490]  ? acpi_sleep_proc_init+0x1f/0x1f
>>> [    0.150490]  acpi_ns_terminate+0xc/0x31
>>> [    0.150490]  acpi_ut_subsystem_shutdown+0x45/0xa3
>>> [    0.150490]  ? acpi_sleep_proc_init+0x1f/0x1f
>>> [    0.150490]  acpi_terminate+0x5/0xf
>>> [    0.150490]  acpi_init+0x27b/0x308
>>> [    0.150490]  ? video_setup+0x79/0x79
>>> [    0.150490]  do_one_initcall+0x7b/0x160
>>> [    0.150490]  kernel_init_freeable+0x190/0x1f2
>>> [    0.150490]  ? rest_init+0x9a/0x9a
>>> [    0.150490]  kernel_init+0x5/0xf6
>>> [    0.150490]  ret_from_fork+0x22/0x30
>>> [    0.150490] ---[ end trace 967e9fbc065d7911 ]---
>>>
>>>
>>>
>>
> 

