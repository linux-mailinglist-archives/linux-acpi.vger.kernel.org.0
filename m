Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 068302A9E1E
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Nov 2020 20:34:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728273AbgKFTen (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 6 Nov 2020 14:34:43 -0500
Received: from foss.arm.com ([217.140.110.172]:44078 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726415AbgKFTen (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 6 Nov 2020 14:34:43 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BA17C1509;
        Fri,  6 Nov 2020 11:34:42 -0800 (PST)
Received: from [172.16.1.113] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5868E3F718;
        Fri,  6 Nov 2020 11:34:41 -0800 (PST)
Subject: Re: [PATCH] ACPI, APEI, Fix incorrect return value of
 apei_map_generic_address
To:     yaoaili126@163.com, rjw@rjwysocki.net, lenb@kernel.org
Cc:     tony.luck@intel.com, bp@alien8.de, linux-acpi@vger.kernel.org,
        yangfeng1@kingsoft.com, yaoaili@kingsoft.com
References: <28dc453f-40b8-8263-5aeb-f8979f54a941 () arm ! com>
 <20201102024726.8214-1-yaoaili126@163.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <e0e1cf62-6e49-1524-a370-41532c5b4ac7@arm.com>
Date:   Fri, 6 Nov 2020 19:34:39 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201102024726.8214-1-yaoaili126@163.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hello,

On 02/11/2020 02:47, yaoaili126@163.com wrote:
> From: Aili Yao <yaoaili@kingsoft.com>
> 
> From commit 6915564dc5a8 ("ACPI: OSL: Change the type of
> acpi_os_map_generic_address() return value"),acpi_os_map_generic_address
> will return logical address or NULL for error, but
> pre_map_gar_callback and related apei_map_generic_address ,for
> ACPI_ADR_SPACE_SYSTEM_IO case, it should be also return 0,as it's a
> normal case, but now it will return -ENXIO. so check it out for such
> case to avoid einj module initialization fail.

(Nit: To make the commit message easier to read, please put '()' after function names, and
spaces after commas.)


> Tested-by: Tony Luck <tony.luck@intel.com>

> Signed-off-by: James Morse <james.morse@arm.com>

You can't add other peoples 'signed off'. This is for tracking the path a patch takes, and
that each person who touches it 'signs off' their changes for the open-source license. See
the 'Developer's Certificate of Origin 1.1' in Documentation/process/submitting-patches.rst'.

Please remove this tag.


> Signed-off-by: Aili Yao <yaoaili@kingsoft.com>

As this fixes the bug where the einj module can't be loaded, I think its appropriate for
the stable kernels. The tags to do that are:
Fixes: 6915564dc5a8 ("ACPI: OSL: Change the type of acpi_os_map_generic_address() return
value")
Cc: <stable@vger.kernel.org>


With that, please add my:
Reviewed-by: James Morse <james.morse@arm.com>


Thanks!

James



> diff --git a/drivers/acpi/apei/apei-base.c b/drivers/acpi/apei/apei-base.c
> index 552fd9ffaca4..3294cc8dc073 100644
> --- a/drivers/acpi/apei/apei-base.c
> +++ b/drivers/acpi/apei/apei-base.c
> @@ -633,6 +633,10 @@ int apei_map_generic_address(struct acpi_generic_address *reg)
>  	if (rc)
>  		return rc;
>  
> +	/* IO space doesn't need mapping */
> +	if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_IO)
> +		return 0;
> +
>  	if (!acpi_os_map_generic_address(reg))
>  		return -ENXIO;
>  
> 

