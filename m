Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F03D3AB3BE
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Jun 2021 14:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231326AbhFQMkO (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 17 Jun 2021 08:40:14 -0400
Received: from mail-oi1-f174.google.com ([209.85.167.174]:36642 "EHLO
        mail-oi1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbhFQMkO (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 17 Jun 2021 08:40:14 -0400
Received: by mail-oi1-f174.google.com with SMTP id r16so6372351oiw.3;
        Thu, 17 Jun 2021 05:38:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oC5deIG40NoiZKemKVqpRg3hah2RwUir4ATSDp7s/lA=;
        b=M4KloQ/g+7TTgtUWmX2kbvPuXy/dezMjPzGXIRbCo6pJUOiN+jh8XJGsdzws1mEFA7
         Kaj0eu4O3B8xx520/BeTdxC7ee5rfWTY9vzQunMcOvCVJn1t8TqoPZFJH+IuP6kOBkbU
         bK8vcy9OMOSX7u/WlCMSQ5ZNDraXh5plr3d8OZe/5NG5/RrAIuwuIvERZM9iZegxnXzf
         yrmCXOF4SbY8VW6hxG4Qi3X1Jg6Kq5h6+lCg/WLdEdzqstao63zRee8l8xO0++wSc6xs
         3BfraM0FoSCdFx3J9fj5VsD1apWiUXwILe/x6qIsjhoeQ6TqYbbA+1U+2zzSDby9h61u
         TVaw==
X-Gm-Message-State: AOAM530pn30GXetsNlwAHNFO0hF50uWv+We6ZivfrrEwwoAaGC8O7oq9
        bFmLGqKAl5VDSVESgW3ptpZvtroso/zf4TeUFvI=
X-Google-Smtp-Source: ABdhPJzfj2c+cLNT1D2Df++KiZvZQQB+oQPww6gJ0F6hEkyKpOzyw+2FSFEu4m7xvIWIYVBpFqkwbDo6IDDLI/wRqE4=
X-Received: by 2002:a05:6808:f08:: with SMTP id m8mr3108363oiw.69.1623933486213;
 Thu, 17 Jun 2021 05:38:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210615074317.3103832-1-libaokun1@huawei.com>
In-Reply-To: <20210615074317.3103832-1-libaokun1@huawei.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 17 Jun 2021 14:37:55 +0200
Message-ID: <CAJZ5v0gtSbDdKOkUqfZQKiGvwmWUrhyw5GQN1GrYC7jKG=BM-Q@mail.gmail.com>
Subject: Re: [PATCH -next v2] acpi/nvs: fix doc warnings in nvs.c
To:     Baokun Li <libaokun1@huawei.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Yue Haibing <yuehaibing@huawei.com>, yangjihong1@huawei.com,
        yu kuai <yukuai3@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Jun 15, 2021 at 9:34 AM Baokun Li <libaokun1@huawei.com> wrote:
>
> Fixes the following W=1 kernel build warning(s):
>
>  drivers/acpi/nvs.c:94: warning: Function parameter or
>   member 'start' not described in 'suspend_nvs_register'
>  drivers/acpi/nvs.c:94: warning: Function parameter or
>   member 'size' not described in 'suspend_nvs_register'
>
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> ---
> V1->V2:
>         Fix the formatting of this kerneldoc comment
>
>  drivers/acpi/nvs.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/acpi/nvs.c b/drivers/acpi/nvs.c
> index 7f02e399047c..a2b11069e792 100644
> --- a/drivers/acpi/nvs.c
> +++ b/drivers/acpi/nvs.c
> @@ -84,13 +84,13 @@ struct nvs_page {
>  static LIST_HEAD(nvs_list);
>
>  /**
> - *     suspend_nvs_register - register platform NVS memory region to save
> - *     @start - physical address of the region
> - *     @size - size of the region
> + * suspend_nvs_register - register platform NVS memory region to save
> + * @start: Physical address of the region.
> + * @size: Size of the region.
>   *
> - *     The NVS region need not be page-aligned (both ends) and we arrange
> - *     things so that the data from page-aligned addresses in this region will
> - *     be copied into separate RAM pages.
> + * The NVS region need not be page-aligned (both ends) and we arrange
> + * things so that the data from page-aligned addresses in this region will
> + * be copied into separate RAM pages.
>   */
>  static int suspend_nvs_register(unsigned long start, unsigned long size)
>  {
> @@ -125,7 +125,7 @@ static int suspend_nvs_register(unsigned long start, unsigned long size)
>  }
>
>  /**
> - *     suspend_nvs_free - free data pages allocated for saving NVS regions
> + * suspend_nvs_free - free data pages allocated for saving NVS regions
>   */
>  void suspend_nvs_free(void)
>  {
> @@ -149,7 +149,7 @@ void suspend_nvs_free(void)
>  }
>
>  /**
> - *     suspend_nvs_alloc - allocate memory necessary for saving NVS regions
> + * suspend_nvs_alloc - allocate memory necessary for saving NVS regions
>   */
>  int suspend_nvs_alloc(void)
>  {
> @@ -166,7 +166,7 @@ int suspend_nvs_alloc(void)
>  }
>
>  /**
> - *     suspend_nvs_save - save NVS memory regions
> + * suspend_nvs_save - save NVS memory regions
>   */
>  int suspend_nvs_save(void)
>  {
> @@ -195,10 +195,10 @@ int suspend_nvs_save(void)
>  }
>
>  /**
> - *     suspend_nvs_restore - restore NVS memory regions
> + * suspend_nvs_restore - restore NVS memory regions
>   *
> - *     This function is going to be called with interrupts disabled, so it
> - *     cannot iounmap the virtual addresses used to access the NVS region.
> + * This function is going to be called with interrupts disabled, so it
> + * cannot iounmap the virtual addresses used to access the NVS region.
>   */
>  void suspend_nvs_restore(void)
>  {
> --

Applied as 5.14 material under a slightly edited subject, thanks!
