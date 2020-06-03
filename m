Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBF481ED074
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Jun 2020 15:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725954AbgFCNEi (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 3 Jun 2020 09:04:38 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:33128 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726021AbgFCNEi (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 3 Jun 2020 09:04:38 -0400
Received: by mail-ot1-f67.google.com with SMTP id v17so1811354ote.0;
        Wed, 03 Jun 2020 06:04:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mtOO6Yo260XklTIiQiIWZ9Yju2CBqUc60RE+A6Pm0rA=;
        b=Y1ZBnJfiXM/JJLNCtrRLbPWvjImyqGMAMzRKBhoh5gOctdGCkZq8rOa+65cNj6hIPx
         8Uxnl5RjTjhjKKi1vROq/zVtSgu2kO8Z6QVLlBTRhfxvJTD0Ycu+UPGwfbbb7ldKhZQa
         hPShTiFrhNp7xw+bekoCHq847IPyeEcjXy2+zB/Dxev85B2jgk3t9KUHc7u4Vcet53Wh
         Sjq2+hzfSSQa7x7yLF3RbMEtaU2Bzog1d/EJ69BOa3x8rIaPMPRX6YFlelA87lUcukn0
         43svN37BBh6hCXlN+cu6J6nOz7b4Ks9yiziBXwuxafGSmMk12Tp3rCxjdGfskDtsVVol
         Nw1w==
X-Gm-Message-State: AOAM531Lc4aZ47yjVBUdDPHdn8psmI4OJxJtDrd86KAEiiPMDeORydPZ
        NL1IS8YKfDuHPlJa7ft86CAJboTag5/wvdd1XSk=
X-Google-Smtp-Source: ABdhPJx6us0pFTQb1gEUp5d/XmC4NV4kLDXSTNS709oXzUeSi+wWrPvST03n9hKL6tqPxXn6XgkrYN3yNPjvQvMtKmw=
X-Received: by 2002:a9d:6c0f:: with SMTP id f15mr2995408otq.118.1591189476842;
 Wed, 03 Jun 2020 06:04:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200602213958.GA32150@embeddedor>
In-Reply-To: <20200602213958.GA32150@embeddedor>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 3 Jun 2020 15:04:22 +0200
Message-ID: <CAJZ5v0hd87G055A+ezkyF+UJQAeBvozFCvoC2Fxa1o-5YXrEhg@mail.gmail.com>
Subject: Re: [PATCH v2] ACPICA: Replace one-element array with flexible-array
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Erik Kaneda <erik.kaneda@intel.com>
Cc:     Robert Moore <robert.moore@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Jun 2, 2020 at 11:34 PM Gustavo A. R. Silva
<gustavoars@kernel.org> wrote:
>
> The current codebase makes use of one-element arrays in the following
> form:
>
> struct something {
>     int length;
>     u8 data[1];
> };
>
> struct something *instance;
>
> instance = kmalloc(sizeof(*instance) + size, GFP_KERNEL);
> instance->length = size;
> memcpy(instance->data, source, size);
>
> but the preferred mechanism to declare variable-length types such as
> these ones is a flexible array member[1][2], introduced in C99:
>
> struct foo {
>         int stuff;
>         struct boo array[];
> };
>
> By making use of the mechanism above, we will get a compiler warning
> in case the flexible array does not occur last in the structure, which
> will help us prevent some kind of undefined behavior bugs from being
> inadvertently introduced[3] to the codebase from now on.
>
> This issue was found with the help of Coccinelle and audited _manually_.
>
> [1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> [2] https://github.com/KSPP/linux/issues/21
> [3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")
>
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Erik, can you take this to the upstream, please?

> ---
> Changes in v2:
>  - Don't use struct_size() for now.
>  - Update subject line and changelog text.
>
>  drivers/acpi/acpica/utids.c | 2 +-
>  include/acpi/actypes.h      | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/acpica/utids.c b/drivers/acpi/acpica/utids.c
> index 3bb06935a2ad3..225f3c60203c7 100644
> --- a/drivers/acpi/acpica/utids.c
> +++ b/drivers/acpi/acpica/utids.c
> @@ -263,7 +263,7 @@ acpi_ut_execute_CID(struct acpi_namespace_node *device_node,
>          * 3) Size of the actual CID strings
>          */
>         cid_list_size = sizeof(struct acpi_pnp_device_id_list) +
> -           ((count - 1) * sizeof(struct acpi_pnp_device_id)) +
> +           count * sizeof(struct acpi_pnp_device_id) +
>             string_area_size;
>
>         cid_list = ACPI_ALLOCATE_ZEROED(cid_list_size);
> diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
> index 4defed58ea338..c7bcda0ad366a 100644
> --- a/include/acpi/actypes.h
> +++ b/include/acpi/actypes.h
> @@ -1145,7 +1145,7 @@ struct acpi_pnp_device_id {
>  struct acpi_pnp_device_id_list {
>         u32 count;              /* Number of IDs in Ids array */
>         u32 list_size;          /* Size of list, including ID strings */
> -       struct acpi_pnp_device_id ids[1];       /* ID array */
> +       struct acpi_pnp_device_id ids[];        /* ID array */
>  };
>
>  /*
> --
> 2.27.0
>
