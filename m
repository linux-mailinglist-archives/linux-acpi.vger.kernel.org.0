Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 935502A0760
	for <lists+linux-acpi@lfdr.de>; Fri, 30 Oct 2020 15:03:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbgJ3ODv (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 30 Oct 2020 10:03:51 -0400
Received: from foss.arm.com ([217.140.110.172]:35286 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725939AbgJ3ODu (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 30 Oct 2020 10:03:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 659A3139F;
        Fri, 30 Oct 2020 07:03:50 -0700 (PDT)
Received: from [172.16.1.113] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2BA4D3F68F;
        Fri, 30 Oct 2020 07:03:33 -0700 (PDT)
Subject: Re: [PATCH] Fix incorrect return value of pre_map_gar_callback
To:     yaoaili126@163.com
Cc:     rjw@rjwysocki.net, lenb@kernel.org, tony.luck@intel.com,
        bp@alien8.de, linux-acpi@vger.kernel.org, YANGFENG1@kingsoft.com,
        yaoaili@kingsoft.com
References: <6b71b5b3-b423-6768-15f4-44f7aa7dc12d () arm ! com>
 <20201029113023.6292-1-yaoaili126@163.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <28dc453f-40b8-8263-5aeb-f8979f54a941@arm.com>
Date:   Fri, 30 Oct 2020 14:03:25 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201029113023.6292-1-yaoaili126@163.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hello,

On 29/10/2020 11:30, yaoaili126@163.com wrote:
> From: Aili Yao <yaoaili@kingsoft.com>
>> From: James Morse [mailto:james.morse
>> The bug is it tries to map a GAR that doesn't need mapping.
>>
>>
>> Could we avoid this problem more clearly by returning 0 from
>> apei_map_generic_address() for address spaces that don't need mapping?
>> (e.g. IO)
>>
>> This would also fix any other callers lurking in apei.

> yes, you are right, I think we can move the ACPI_ADR_SPACE_SYSTEM_MEMORY check to:
> 
>     626 int apei_map_generic_address(struct acpi_generic_address *reg)
>     627 {
>     628         int rc;
>     629         u32 access_bit_width;
>     630         u64 address;
>     631 
>     632         rc = apei_check_gar(reg, &address, &access_bit_width);
>     633         if (rc)
>     634                 return rc;
>     635 
>     636         if (!acpi_os_map_generic_address(reg) &&
>     637          reg->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY)
>     638                 return -ENXIO;
>     639         
>     640         return 0;
>     641 }
>     642 EXPORT_SYMBOL_GPL(apei_map_generic_address);

This swallows the error code for other address spaces too, which would be nasty to debug
in the future!
Could you do something like:
|	rc = apei_check_gar(reg, &address, &access_bit_width);
|	if (rc)
|		return rc;
|
|	/* IO space doesn't need mapping */
|	if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_IO)
|		return 0;
|
|	return acpi_os_map_generic_address(reg);

(and it continues to get-away with the unmap call as that doesn't return anything, which I
think is fine)


If you post this, please follow the most popular style of previous patches for the
subject. See: git log --oneline drivers/acpi/apei/apei-base.c
(This is to let the maintainer spot which patches they need to do something with)


Thanks,

James
