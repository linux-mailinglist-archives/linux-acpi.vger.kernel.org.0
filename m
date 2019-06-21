Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 559CD4EC03
	for <lists+linux-acpi@lfdr.de>; Fri, 21 Jun 2019 17:30:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726062AbfFUPaB (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 21 Jun 2019 11:30:01 -0400
Received: from mail.skyhub.de ([5.9.137.197]:44972 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726045AbfFUPaB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 21 Jun 2019 11:30:01 -0400
Received: from zn.tnic (p200300EC2F1252005DA783939A2C7933.dip0.t-ipconnect.de [IPv6:2003:ec:2f12:5200:5da7:8393:9a2c:7933])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E89171EC05C2;
        Fri, 21 Jun 2019 17:29:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1561131000;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=QymPJfTq9CSJWxXbhxI5r0cEEe5vOSbNiYfvwM6ccPk=;
        b=IPIlAwfS4A2nRQkvdTSlXZecQzcUOKweYBofku2qx1PBiZxq8GPJNFO9l+4ToWqCNQCvAA
        A8fAHN/irIYqX5OuKU/77PoeVhkXjJ1G2ZSvuwYwf1QL9pr6mc1I3fTPBPoD8m9A4eoNOQ
        SIJnZBTtGc/pSJisc2dc5k4K3JQm/xA=
Date:   Fri, 21 Jun 2019 17:29:51 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     luanshi <zhangliguang@linux.alibaba.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        James Morse <james.morse@arm.com>,
        Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH v2] ACPI / APEI: release resources if gen_pool_add fails
Message-ID: <20190621152951.GB19067@zn.tnic>
References: <1560734870-27742-1-git-send-email-zhangliguang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1560734870-27742-1-git-send-email-zhangliguang@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Jun 17, 2019 at 09:27:50AM +0800, luanshi wrote:
> To avoid memory leaks, destroy ghes_estatus_pool and release memory
> allocated via vmalloc() on errors in ghes_estatus_pool_init().
> 
> Signed-off-by: Liguang Zhang <zhangliguang@linux.alibaba.com>
> Reviewed-by: James Morse <james.morse@arm.com>
> Tested-by: James Morse <james.morse@arm.com>
> ---
>  drivers/acpi/apei/ghes.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index 993940d..4e5de30 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -153,6 +153,7 @@ static void ghes_unmap(void __iomem *vaddr, enum fixed_addresses fixmap_idx)
>  int ghes_estatus_pool_init(int num_ghes)
>  {
>  	unsigned long addr, len;
> +	int rc = 0;
>  
>  	ghes_estatus_pool = gen_pool_create(GHES_ESTATUS_POOL_MIN_ALLOC_ORDER, -1);
>  	if (!ghes_estatus_pool)
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
> +		gen_pool_destroy(ghes_estatus_pool);
> +		vfree((void *)addr);
> +	}
> +	return rc;

Please put the error path in labels at the end of the function to which
you goto from each error case, like it is usually done in kernel code,
instead of repeating the free calls in each error handling path.

Grep the tree for examples, if you need some.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
