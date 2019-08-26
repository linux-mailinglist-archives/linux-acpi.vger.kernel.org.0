Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C95F9CC2C
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Aug 2019 11:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730541AbfHZJGS (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 26 Aug 2019 05:06:18 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:41965 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730527AbfHZJGS (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 26 Aug 2019 05:06:18 -0400
Received: from 79.184.255.249.ipv4.supernova.orange.pl (79.184.255.249) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.275)
 id 5fd658606c77bc84; Mon, 26 Aug 2019 11:06:16 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Borislav Petkov <bp@alien8.de>
Cc:     luanshi <zhangliguang@linux.alibaba.com>,
        Len Brown <lenb@kernel.org>, James Morse <james.morse@arm.com>,
        Tony Luck <tony.luck@intel.com>, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v4.1] ACPI / APEI: release resources if gen_pool_add fails
Date:   Mon, 26 Aug 2019 11:06:15 +0200
Message-ID: <3203454.kQXdNjpmCg@kreacher>
In-Reply-To: <20190813171619.GH16770@zn.tnic>
References: <1563173924-47479-1-git-send-email-zhangliguang@linux.alibaba.com> <20190813171619.GH16770@zn.tnic>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tuesday, August 13, 2019 7:16:19 PM CEST Borislav Petkov wrote:
> Hi,
> 
> here's v4.1 with the labels properly balanced.

Applied, thanks!

> ---
> From: Liguang Zhang <zhangliguang@linux.alibaba.com>
> Date: Mon, 15 Jul 2019 14:58:44 +0800
> Subject: [PATCH] ACPI / APEI: Release resources if gen_pool_add() fails
> 
> Destroy ghes_estatus_pool and release memory allocated via vmalloc() on
> errors in ghes_estatus_pool_init() in order to avoid memory leaks.
> 
>  [ bp: do the labels properly and with descriptive names and massage. ]
> 
> Signed-off-by: Liguang Zhang <zhangliguang@linux.alibaba.com>
> Signed-off-by: Borislav Petkov <bp@suse.de>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: James Morse <james.morse@arm.com>
> Cc: Len Brown <lenb@kernel.org>
> Cc: linux-acpi@vger.kernel.org
> Cc: Tony Luck <tony.luck@intel.com>
> Link: https://lkml.kernel.org/r/1563173924-47479-1-git-send-email-zhangliguang@linux.alibaba.com
> ---
>  drivers/acpi/apei/ghes.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index a66e00fe31fe..66205ec54555 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -153,6 +153,7 @@ static void ghes_unmap(void __iomem *vaddr, enum fixed_addresses fixmap_idx)
>  int ghes_estatus_pool_init(int num_ghes)
>  {
>  	unsigned long addr, len;
> +	int rc;
>  
>  	ghes_estatus_pool = gen_pool_create(GHES_ESTATUS_POOL_MIN_ALLOC_ORDER, -1);
>  	if (!ghes_estatus_pool)
> @@ -164,7 +165,7 @@ int ghes_estatus_pool_init(int num_ghes)
>  	ghes_estatus_pool_size_request = PAGE_ALIGN(len);
>  	addr = (unsigned long)vmalloc(PAGE_ALIGN(len));
>  	if (!addr)
> -		return -ENOMEM;
> +		goto err_pool_alloc;
>  
>  	/*
>  	 * New allocation must be visible in all pgd before it can be found by
> @@ -172,7 +173,19 @@ int ghes_estatus_pool_init(int num_ghes)
>  	 */
>  	vmalloc_sync_all();
>  
> -	return gen_pool_add(ghes_estatus_pool, addr, PAGE_ALIGN(len), -1);
> +	rc = gen_pool_add(ghes_estatus_pool, addr, PAGE_ALIGN(len), -1);
> +	if (rc)
> +		goto err_pool_add;
> +
> +	return 0;
> +
> +err_pool_add:
> +	vfree((void *)addr);
> +
> +err_pool_alloc:
> +	gen_pool_destroy(ghes_estatus_pool);
> +
> +	return -ENOMEM;
>  }
>  
>  static int map_gen_v2(struct ghes *ghes)
> 




