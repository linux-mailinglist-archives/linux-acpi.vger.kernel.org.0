Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C7DA2818C7
	for <lists+linux-acpi@lfdr.de>; Fri,  2 Oct 2020 19:07:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388233AbgJBRHR (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 2 Oct 2020 13:07:17 -0400
Received: from mail-oo1-f66.google.com ([209.85.161.66]:43591 "EHLO
        mail-oo1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388054AbgJBRHR (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 2 Oct 2020 13:07:17 -0400
Received: by mail-oo1-f66.google.com with SMTP id w25so511362oos.10
        for <linux-acpi@vger.kernel.org>; Fri, 02 Oct 2020 10:07:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iVdpyT1orToPkGsOL6ChlRjmfsWF5zRK/lf6o2mJCfg=;
        b=FOcw9YVU/PIhVh6H3BoRIvqUBC821NW7mhcLnCXzCS8Q5amJ0KohweAqudFfwot8RE
         8xJVa35xWJfeP4CIm2lAI3t9MeLWz0nFTOuxvUcM3I4g8s4RXyoD2Psb5Rq9NjxJK2p9
         HIDiAXbt9snw7wwB7cSecG3mwxVJEUqAthdcN/fKKetH64cmp4pN2wKMs/Pcd84+L0tc
         ky7IMfjAD+sTgCOkMjJANF0o2QS7z7GUWpEv/ZkLkxuLcMK19yBCuCjB4WkqDpwZ2jsQ
         Xm+wfTx2Joy/M7jZUpoc83dpukc/5J6wwzwbyvBL6CRNrPzevGXFosDdCC5yaCuZKIHb
         jWLg==
X-Gm-Message-State: AOAM531yE/gw/rziffZDmWxN82IH5/MrfNY4mwNHTk+vCJv9R4Uf6URc
        6ugRUOid/7IeJueK3+0WNTo9wNV57PEYUDZTacO+xsgD
X-Google-Smtp-Source: ABdhPJwvAikTNOd3bVIoajksmgg+bT/E9lro631VTMxr1UHeb8T+X0WTptcCeS83qeqyabWmjbk1mvcNo7gdT2nddmk=
X-Received: by 2002:a4a:dd0b:: with SMTP id m11mr2585489oou.75.1601658436412;
 Fri, 02 Oct 2020 10:07:16 -0700 (PDT)
MIME-Version: 1.0
References: <1601200549-8518-1-git-send-email-guohanjun@huawei.com>
In-Reply-To: <1601200549-8518-1-git-send-email-guohanjun@huawei.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 2 Oct 2020 19:07:05 +0200
Message-ID: <CAJZ5v0hpe2BByQXLx=Q8EDV6eA_1YGJ_hFXW3mdCtiywzSziCA@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: memhotplug: Remove the 'state' from struct acpi_memory_device
To:     Hanjun Guo <guohanjun@huawei.com>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sun, Sep 27, 2020 at 12:03 PM Hanjun Guo <guohanjun@huawei.com> wrote:
>
> After commit 315bbae9c5cb ("ACPI / memhotplug: deal with eject request
> in hotplug queue"), the memory device state which is defined in struct
> acpi_memory_device is not actually useful, so remove it along with
> symbols related to it.
>
> Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
> ---
> v1->v2:
> - Make it as a sparate cleanup patch.
>
>  drivers/acpi/acpi_memhotplug.c | 12 +-----------
>  1 file changed, 1 insertion(+), 11 deletions(-)
>
> diff --git a/drivers/acpi/acpi_memhotplug.c b/drivers/acpi/acpi_memhotplug.c
> index e294f44..468ebb7 100644
> --- a/drivers/acpi/acpi_memhotplug.c
> +++ b/drivers/acpi/acpi_memhotplug.c
> @@ -36,11 +36,6 @@
>
>  #ifdef CONFIG_ACPI_HOTPLUG_MEMORY
>
> -/* Memory Device States */
> -#define MEMORY_INVALID_STATE   0
> -#define MEMORY_POWER_ON_STATE  1
> -#define MEMORY_POWER_OFF_STATE 2
> -
>  static int acpi_memory_device_add(struct acpi_device *device,
>                                   const struct acpi_device_id *not_used);
>  static void acpi_memory_device_remove(struct acpi_device *device);
> @@ -64,8 +59,7 @@ struct acpi_memory_info {
>  };
>
>  struct acpi_memory_device {
> -       struct acpi_device * device;
> -       unsigned int state;     /* State of the memory device */
> +       struct acpi_device *device;
>         struct list_head res_list;
>  };
>
> @@ -233,7 +227,6 @@ static int acpi_memory_enable_device(struct acpi_memory_device *mem_device)
>         }
>         if (!num_enabled) {
>                 dev_err(&mem_device->device->dev, "add_memory failed\n");
> -               mem_device->state = MEMORY_INVALID_STATE;
>                 return -EINVAL;
>         }
>         /*
> @@ -304,9 +297,6 @@ static int acpi_memory_device_add(struct acpi_device *device,
>                 return result;
>         }
>
> -       /* Set the device state */
> -       mem_device->state = MEMORY_POWER_ON_STATE;
> -
>         result = acpi_memory_check_device(mem_device);
>         if (result) {
>                 acpi_memory_device_free(mem_device);
> --

Applied as 5.10 material with a couple of minor edits in the subject
and changelog, thanks!
