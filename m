Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2252826C3AE
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Sep 2020 16:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbgIPO0m (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 16 Sep 2020 10:26:42 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:53422 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726332AbgIPNYr (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 16 Sep 2020 09:24:47 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=richard.weiyang@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0U97e8cp_1600260047;
Received: from localhost(mailfrom:richard.weiyang@linux.alibaba.com fp:SMTPD_---0U97e8cp_1600260047)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 16 Sep 2020 20:40:48 +0800
Date:   Wed, 16 Sep 2020 20:40:47 +0800
From:   Wei Yang <richard.weiyang@linux.alibaba.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Wei Yang <richard.weiyang@linux.alibaba.com>,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
        linux-hyperv@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-acpi@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-s390@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Kees Cook <keescook@chromium.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH] kernel/resource: make iomem_resource implicit in
 release_mem_region_adjustable()
Message-ID: <20200916124047.GA47042@L-31X9LVDL-1304.local>
Reply-To: Wei Yang <richard.weiyang@linux.alibaba.com>
References: <20200911103459.10306-1-david@redhat.com>
 <20200916073041.10355-1-david@redhat.com>
 <20200916100223.GA46154@L-31X9LVDL-1304.local>
 <d11eba75-71c0-4153-944b-56e22044e0eb@redhat.com>
 <20200916121051.GA46809@L-31X9LVDL-1304.local>
 <0ee45d30-daa4-190a-2932-fb710d9496db@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ee45d30-daa4-190a-2932-fb710d9496db@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Sep 16, 2020 at 02:16:25PM +0200, David Hildenbrand wrote:
>On 16.09.20 14:10, Wei Yang wrote:
>> On Wed, Sep 16, 2020 at 12:03:20PM +0200, David Hildenbrand wrote:
>>> On 16.09.20 12:02, Wei Yang wrote:
>>>> On Wed, Sep 16, 2020 at 09:30:41AM +0200, David Hildenbrand wrote:
>>>>> "mem" in the name already indicates the root, similar to
>>>>> release_mem_region() and devm_request_mem_region(). Make it implicit.
>>>>> The only single caller always passes iomem_resource, other parents are
>>>>> not applicable.
>>>>>
>>>>
>>>> Looks good to me.
>>>>
>>>> Reviewed-by: Wei Yang <richard.weiyang@linux.alibaba.com>
>>>>
>>>
>>> Thanks for the review!
>>>
>> 
>> Would you send another version? I didn't take a look into the following
>> patches, since the 4th is missed.
>
>Not planning to send another one as long as there are no further
>comments. Seems to be an issue on your side because all patches arrived
>on linux-mm (see
>https://lore.kernel.org/linux-mm/20200911103459.10306-1-david@redhat.com/)
>
>You can find patch #4 at
>https://lore.kernel.org/linux-mm/20200911103459.10306-5-david@redhat.com/
>
>(which has CC "Wei Yang <richardw.yang@linux.intel.com>")
>

Ok, I managed to apply 4th patch manually...

>-- 
>Thanks,
>
>David / dhildenb

-- 
Wei Yang
Help you, Help me
