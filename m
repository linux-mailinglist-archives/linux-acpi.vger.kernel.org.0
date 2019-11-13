Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6ACFFB1EC
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Nov 2019 14:57:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727682AbfKMN5a (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 13 Nov 2019 08:57:30 -0500
Received: from mga11.intel.com ([192.55.52.93]:50077 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726190AbfKMN53 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 13 Nov 2019 08:57:29 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Nov 2019 05:57:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,300,1569308400"; 
   d="scan'208";a="194675312"
Received: from rcao-mobl3.ccr.corp.intel.com (HELO [10.249.174.53]) ([10.249.174.53])
  by orsmga007.jf.intel.com with ESMTP; 13 Nov 2019 05:57:25 -0800
Subject: Re: [PATCH V5 1/4] ACPI: Support Generic Initiator only domains
To:     Jonathan Cameron <jonathan.cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Linux MM <linux-mm@kvack.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        X86 ML <x86@kernel.org>, Keith Busch <keith.busch@intel.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Linuxarm <linuxarm@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20191004114330.104746-1-Jonathan.Cameron@huawei.com>
 <20191004114330.104746-2-Jonathan.Cameron@huawei.com>
 <CAPcyv4jZG-5s6NsS-_-oNG45y0Qb1mVD_s8cCGqLYtzvHqEo+Q@mail.gmail.com>
 <20191113094742.00000dc4@huawei.com>
From:   Tao Xu <tao3.xu@intel.com>
Message-ID: <77b6a6e8-9d44-1e1c-3bf0-a8d04833598d@intel.com>
Date:   Wed, 13 Nov 2019 21:57:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191113094742.00000dc4@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 11/13/2019 5:47 PM, Jonathan Cameron wrote:
> On Tue, 12 Nov 2019 09:55:17 -0800
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
>> [ add Tao Xu ]
>>
>> On Fri, Oct 4, 2019 at 4:45 AM Jonathan Cameron
>> <Jonathan.Cameron@huawei.com> wrote:
>>>
>>> Generic Initiators are a new ACPI concept that allows for the
>>> description of proximity domains that contain a device which
>>> performs memory access (such as a network card) but neither
>>> host CPU nor Memory.
>>>
>>> This patch has the parsing code and provides the infrastructure
>>> for an architecture to associate these new domains with their
>>> nearest memory processing node.
>>
>> Thanks for this Jonathan. May I ask how this was tested? Tao has been
>> working on qemu support for HMAT [1]. I have not checked if it already
>> supports generic initiator entries, but it would be helpful to include
>> an example of how the kernel sees these configurations in practice.
>>
>> [1]: http://patchwork.ozlabs.org/cover/1096737/
> 
> Tested against qemu with SRAT and SLIT table overrides from an
> initrd to actually create the node and give it distances
> (those all turn up correctly in the normal places).  DSDT override
> used to move an emulated network card into the GI numa node.  That
> currently requires the PCI patch referred to in the cover letter.
> On arm64 tested both on qemu and real hardware (overrides on tables
> even for real hardware as I can't persuade our BIOS team to implement
> Generic Initiators until an OS is actually using them.)
> 
> Main real requirement is memory allocations then occur from one of
> the nodes at the minimal distance when you are do a devm_ allocation
> from a device assigned. Also need to be able to query the distances
> to allow load balancing etc.  All that works as expected.
> 
> It only has a fairly tangential connection to HMAT in that HMAT
> can provide information on GI nodes.  Given HMAT code is quite happy
> with memoryless nodes anyway it should work.  QEMU doesn't currently
> have support to create GI SRAT entries let alone HMAT using them.
> 
> Whilst I could look at adding such support to QEMU, it's not
> exactly high priority to emulate something we can test easily
> by overriding the tables before the kernel reads them.
> 
> I'll look at how hard it is to build an HMAT tables for my test
> configs based on the ones I used to test your HMAT patches a while
> back.  Should be easy if tedious.
> 
> Jonathan
> 
Indeed, HMAT can support Generic Initiator, but as far as I know, QEMU 
only can emulate a node with cpu and memory, or memory-only. Even if we 
assign a node with cpu only, qemu will raise error. Considering 
compatibility, there are lots of work to do for QEMU if we change NUMA 
or SRAT table.

