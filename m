Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69BAD3A1538
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Jun 2021 15:12:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236080AbhFINOU (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 9 Jun 2021 09:14:20 -0400
Received: from mail-oi1-f174.google.com ([209.85.167.174]:46032 "EHLO
        mail-oi1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233406AbhFINOU (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 9 Jun 2021 09:14:20 -0400
Received: by mail-oi1-f174.google.com with SMTP id w127so24993053oig.12;
        Wed, 09 Jun 2021 06:12:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+BDOuZeeT4Z4TP5OKIWycktukU1b6L+TuMqTeDM2SnU=;
        b=BWyk1SfTG770TJNYzu0UV/Qhn43GWH/Im2H3AzDFRJuVn3vi39S594/qu6YclRXngj
         n0B28++7AyZimPBX1YgHg8G5ZX6/do967xREr1ygz+tGl1UMbtjh0GDyDQwwnP6IK6Ht
         RoS0SFlpgJCkAdfBj0m8a2c/CxHRuebMgIZHvSKAIgp3FSWkqW0kMW8+BO8Deem/2B5n
         Ao9DbnfAdPWm0eO+4kqHyxEgehoR6srhN20T84+sp9lW1MpevEGMz14BRGh192MjXJLX
         YkNV4hMFokjYYP71qh4fa4bl3Luz5VJE7dwUVjHqixkehnS1R6f0W9FeeUM9l8G8oQ0Q
         t4pA==
X-Gm-Message-State: AOAM531kDwDMcTS5qyi0evVje5nRfN4TtxVdotPFAXgmWNo/zoQSpIeD
        fqPIi5bWZ9YDty8EIbXGgT3s7W9YTWcOUeZw0YU=
X-Google-Smtp-Source: ABdhPJxXQWiihRhJpSH+eRv+LWslZpAy4Cu7ivgz9UhYVYc7FoeB2scfzqBxu4uRMsogcv8y4rHFc5AzgPFHPcVnXS0=
X-Received: by 2002:aca:650d:: with SMTP id m13mr6553837oim.157.1623244345799;
 Wed, 09 Jun 2021 06:12:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210608023841.2746826-1-libaokun1@huawei.com>
In-Reply-To: <20210608023841.2746826-1-libaokun1@huawei.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 9 Jun 2021 15:12:14 +0200
Message-ID: <CAJZ5v0iPcSwjswJ7+1gPk-CKowLST7LG-4RQx_LkwFV+fUW6Gg@mail.gmail.com>
Subject: Re: [PATCH -next] acpi/nvs: fix doc warnings in nvs.c
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

On Tue, Jun 8, 2021 at 4:29 AM Baokun Li <libaokun1@huawei.com> wrote:
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
>  drivers/acpi/nvs.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/nvs.c b/drivers/acpi/nvs.c
> index 9f8712a557b3..4609a8a2e42d 100644
> --- a/drivers/acpi/nvs.c
> +++ b/drivers/acpi/nvs.c
> @@ -83,8 +83,8 @@ static LIST_HEAD(nvs_list);
>
>  /**
>   *     suspend_nvs_register - register platform NVS memory region to save
> - *     @start - physical address of the region
> - *     @size - size of the region
> + *     @start: physical address of the region
> + *     @size: size of the region

The format of this kerneldoc comment is still not following the common
style after your change.

Please fix it completely.

>   *
>   *     The NVS region need not be page-aligned (both ends) and we arrange
>   *     things so that the data from page-aligned addresses in this region will
> --
> 2.31.1
>
