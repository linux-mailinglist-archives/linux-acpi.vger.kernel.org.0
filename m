Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43D9C461A7
	for <lists+linux-acpi@lfdr.de>; Fri, 14 Jun 2019 16:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728560AbfFNOwD (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 14 Jun 2019 10:52:03 -0400
Received: from foss.arm.com ([217.140.110.172]:36062 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727560AbfFNOwC (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 14 Jun 2019 10:52:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 395AD344;
        Fri, 14 Jun 2019 07:52:02 -0700 (PDT)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6A7B03F246;
        Fri, 14 Jun 2019 07:52:01 -0700 (PDT)
Subject: Re: [PATCH] ACPI / APEI: release resources if gen_pool_add fails
To:     luanshi <zhangliguang@linux.alibaba.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>
References: <1560505783-130606-1-git-send-email-zhangliguang@linux.alibaba.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <fbd31c48-e1e0-55a5-b341-46d25b2c2001@arm.com>
Date:   Fri, 14 Jun 2019 15:51:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1560505783-130606-1-git-send-email-zhangliguang@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Liguang,

On 14/06/2019 10:49, luanshi wrote:
> To avoid memory leaks, destroy ghes_estatus_pool and release memory
> allocated via vmalloc() on errors in ghes_estatus_pool_init().
> 
> Signed-off-by: liguang.zlg <zhangliguang@linux.alibaba.com>

(I'm surprised your name has a '.' in it!)

Nit: This is v2. Please add a version number in the subject, e.g.:
| [PATCH v2] ACPI / APEI: release resources if gen_pool_add fails

This makes it easy for reviewers to know which is the latest. git format-patch will do
this for you if you add '-v 2' to its command-line.


> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index 993940d..8472c96 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -163,8 +164,10 @@ int ghes_estatus_pool_init(int num_ghes)
>  
>  	ghes_estatus_pool_size_request = PAGE_ALIGN(len);
>  	addr = (unsigned long)vmalloc(PAGE_ALIGN(len));
> -	if (!addr)
> +	if (!addr) {
> +		gen_pool_destroy(ghes_estatus_pool);
>  		return -ENOMEM;
> +	}
>  
>  	/*
>  	 * New allocation must be visible in all pgd before it can be found by
> @@ -172,7 +175,12 @@ int ghes_estatus_pool_init(int num_ghes)
>  	 */
>  	vmalloc_sync_all();
>  
> -	return gen_pool_add(ghes_estatus_pool, addr, PAGE_ALIGN(len), -1);
> +	rc = gen_pool_add(ghes_estatus_pool, addr, PAGE_ALIGN(len), -1);
> +	if (rc) {

> +		vfree(addr);

addr here is unsigned long, but vfree() wants a void *.

vfree() first leaves us with a pool containing memory we've vfree()d, which doesn't feel
like a good state to step through.
Can we vfree() after gen_pool_destroy()?


> +		gen_pool_destroy(ghes_estatus_pool);
> +	}
> +	return rc;
>  }


With that:
Reviewed-by: James Morse <james.morse@arm.com>
Tested-by: James Morse <james.morse@arm.com>


Thanks for cleaning this up!

James
