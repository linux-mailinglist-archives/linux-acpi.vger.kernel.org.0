Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18F301F6608
	for <lists+linux-acpi@lfdr.de>; Thu, 11 Jun 2020 12:55:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727796AbgFKKzA (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 11 Jun 2020 06:55:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:48934 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726407AbgFKKzA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 11 Jun 2020 06:55:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 33160AAC6;
        Thu, 11 Jun 2020 10:55:01 +0000 (UTC)
Subject: Re: slub freelist issue / BUG: unable to handle page fault for
 address: 000000003ffe0018
To:     "Kaneda, Erik" <erik.kaneda@intel.com>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Moore, Robert" <robert.moore@intel.com>
Cc:     Kees Cook <keescook@chromium.org>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marco Elver <elver@google.com>,
        Waiman Long <longman@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Len Brown <lenb@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
References: <4dc93ff8-f86e-f4c9-ebeb-6d3153a78d03@oracle.com>
 <7839183d-1c0b-da02-73a2-bf5e1e8b02b9@suse.cz>
 <94296941-1073-913c-2adb-bf2e41be9f0f@oracle.com>
 <202006041054.874AA564@keescook>
 <cb0cdaaa-7825-0b87-0384-db22329305bb@suse.cz>
 <34455dce-6675-1fc2-8d61-45bf56f3f554@suse.cz>
 <6b2b149e-c2bc-f87a-ea2c-3046c5e39bf9@oracle.com>
 <faea2c18-edbe-f8b4-b171-6be866624856@oracle.com>
 <CAJZ5v0jqmUmf7mv3wjniVM-YqPqhDSjxunU0E4VYCsUQqvrF_Q@mail.gmail.com>
 <ce333dcb-2b2c-3e1f-2a7e-02a7819b1db4@suse.cz>
 <894e8cee-33df-1f63-fb12-72dceb024ea7@oracle.com>
 <BYAPR11MB3096B20EECE8E5BCB12E3D09F0800@BYAPR11MB3096.namprd11.prod.outlook.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <a36fdd61-285d-5994-a7f8-496544c9c65d@suse.cz>
Date:   Thu, 11 Jun 2020 12:54:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <BYAPR11MB3096B20EECE8E5BCB12E3D09F0800@BYAPR11MB3096.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 6/11/20 3:40 AM, Kaneda, Erik wrote:
> We'll take this patch for ACPICA and it will be in the next release.
> 
> Rafael, do you want to take this as a part of the next rc? Or should we wait for the next merge window?

IMHO this should rather be fixed in 5.8 with CC stable, not next merge window.

> Thanks,
> Erik
>> 
>> diff --git a/drivers/acpi/acpica/nsaccess.c b/drivers/acpi/acpica/nsaccess.c
>> index 2566e2d4c7803..b76bbab917941 100644
>> --- a/drivers/acpi/acpica/nsaccess.c
>> +++ b/drivers/acpi/acpica/nsaccess.c
>> @@ -98,14 +98,12 @@ acpi_status acpi_ns_root_initialize(void)
>>                   * predefined names are at the root level. It is much easier to
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
>> 
>> 
>> Vegard
> 

