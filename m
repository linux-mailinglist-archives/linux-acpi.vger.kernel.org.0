Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27CB419ABF1
	for <lists+linux-acpi@lfdr.de>; Wed,  1 Apr 2020 14:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732438AbgDAMoi (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 1 Apr 2020 08:44:38 -0400
Received: from foss.arm.com ([217.140.110.172]:50902 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732396AbgDAMoi (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 1 Apr 2020 08:44:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 908AC30E;
        Wed,  1 Apr 2020 05:44:37 -0700 (PDT)
Received: from [172.16.1.108] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1B43B3F68F;
        Wed,  1 Apr 2020 05:44:35 -0700 (PDT)
Subject: Re: [PATCH][V2] ACPI: sysfs: copy ACPI data using io memory copying
To:     Mark Rutland <mark.rutland@arm.com>,
        Colin King <colin.king@canonical.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, lorenzo.pieralisi@arm.com
References: <20200317165409.469013-1-colin.king@canonical.com>
 <20200320131951.GA6555@lakrids.cambridge.arm.com>
From:   James Morse <james.morse@arm.com>
Openpgp: preference=signencrypt
Message-ID: <698da6fc-3334-5420-5c97-4406914e4599@arm.com>
Date:   Wed, 1 Apr 2020 13:44:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200320131951.GA6555@lakrids.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hello!

On 3/20/20 1:19 PM, Mark Rutland wrote:
> [adding James and Lorenzo]

(but not actually...)


> On Tue, Mar 17, 2020 at 04:54:09PM +0000, Colin King wrote:
>> From: Colin Ian King <colin.king@canonical.com>
>>
>> Reading ACPI data on ARM64 at a non-aligned offset from
>> /sys/firmware/acpi/tables/data/BERT will cause a splat because
>> the data is I/O memory mapped

On your platform, on someone else's it may be in memory.

Which platform is this on?
(I've never seen one generate a BERT!)


>> and being read with just a memcpy.
>> Fix this by introducing an I/O variant of memory_read_from_buffer
>> and using I/O memory mapped copies instead.

> Just to check, is that correct is it correct to map those tables with
> Device attributes in the first place, or should we be mapping the tables
> with Normal Cacheable attributes with memremap()?
> 
> If the FW placed those into memory using cacheavble attributes, reading
> them using Device attributes could result in stale values, which could
> be garbage.

Yes. The BERT code should be using arch_apei_get_mem_attribute() to use the
correct attributes. See ghes_map() for an example. bert_init() will need to use
a version of ioremap() that takes the pgprot_t.

Always using ioremap_cache() means you get a cacheable mapping, regardless of
how firmware described this region in the UEFI memory map. This doesn't explain
why you got an alignment fault.

Otherwise, looks fine to me.


(N.B. I ignored this patch as it wasn't copied to linux-arm-kernel and the
subject says its about sysfs<->ACPI, nothing to do with APEI!)


Thanks,

James
