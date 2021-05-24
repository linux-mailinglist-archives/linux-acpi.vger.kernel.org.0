Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 748B838E8B2
	for <lists+linux-acpi@lfdr.de>; Mon, 24 May 2021 16:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232906AbhEXO0m (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 24 May 2021 10:26:42 -0400
Received: from mail-oo1-f48.google.com ([209.85.161.48]:43803 "EHLO
        mail-oo1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232424AbhEXO0m (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 24 May 2021 10:26:42 -0400
Received: by mail-oo1-f48.google.com with SMTP id e27-20020a056820061bb029020da48eed5cso6380209oow.10
        for <linux-acpi@vger.kernel.org>; Mon, 24 May 2021 07:25:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BDXQQsiG3mJ/ap0U5BPFBRHxsHR2d5voC1qh/JTfpY0=;
        b=nSwqfkmk/EYRMcQsssJKVIfHZhNtjYL8+SGUQj3Brn1YSpHHNaGj9Gdd/5J/YyMkCB
         TtnaKq/cskanzXlrGYhkGUPFGV+6HzwCMuIW6QzoXnS8gkcf2Pa/FRuQ19dRiz5zSHdX
         5i4uCInCypbkE66TsvfnuEyUG699Y5ZUGBrEMo7UjT42xswWXt+r4nAxsUDe8J8Xoyni
         HwdXfrtPbiFafY+bDC/hb2T5aDnLRpeMsA1LRZut9UDVQ2GwdYrPsIyA09XF861Zrtb7
         QlZIMdhQ60lH4kLtQNNJS+gJ/A60L97cJqXLe5tc385oA/UAw4vJmRLG+6oUHPW4hc4m
         m9LA==
X-Gm-Message-State: AOAM530Mir2cdLsiof+XVndSK1jOYTbL31sQ2ti8PUymlN7D4jAi9Iq7
        ws0EMdKP9AVevlH09ifuQzYYliZw+mMtqhuk+HO+XPMz
X-Google-Smtp-Source: ABdhPJzRf/PLTByx/fjwkYIMYnxEE6VroKzvASuGS3w8mvUrbADmAtnj6amwdKagdGStdYLnP3LaLg+pS7zqVMvnyjU=
X-Received: by 2002:a4a:ab83:: with SMTP id m3mr18392490oon.2.1621866314320;
 Mon, 24 May 2021 07:25:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210521222808.2174134-1-erik.kaneda@intel.com> <20210521222808.2174134-2-erik.kaneda@intel.com>
In-Reply-To: <20210521222808.2174134-2-erik.kaneda@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 24 May 2021 16:24:59 +0200
Message-ID: <CAJZ5v0j2JkYC45nnckV0+pXfO1HcPyeRsPxrviVmYQ9_g1+rmw@mail.gmail.com>
Subject: Re: [PATCH 1/1] ACPICA: Clean up context mutex during object deletion
To:     Erik Kaneda <erik.kaneda@intel.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        John Garry <john.garry@huawei.com>,
        Xiang Chen <chenxiang66@hisilicon.com>,
        Bob Moore <robert.moore@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sat, May 22, 2021 at 1:02 AM Erik Kaneda <erik.kaneda@intel.com> wrote:
>
> ACPICA commit bc43c878fd4ff27ba75b1d111b97ee90d4a82707
>
> Fixes: c27f3d011b08 ("Fix race in GenericSerialBus (I2C) and GPIO OpRegion parameter handling")
>
> Link: https://github.com/acpica/acpica/commit/bc43c878
> Reported-by: John Garry <john.garry@huawei.com>
> Reported-by: Xiang Chen <chenxiang66@hisilicon.com>
> Tested-by: Xiang Chen <chenxiang66@hisilicon.com>
> Signed-off-by: Erik Kaneda <erik.kaneda@intel.com>
> Signed-off-by: Bob Moore <robert.moore@intel.com>
> ---
>  drivers/acpi/acpica/utdelete.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/acpi/acpica/utdelete.c b/drivers/acpi/acpica/utdelete.c
> index 624a26794d55..e5ba9795ec69 100644
> --- a/drivers/acpi/acpica/utdelete.c
> +++ b/drivers/acpi/acpica/utdelete.c
> @@ -285,6 +285,14 @@ static void acpi_ut_delete_internal_obj(union acpi_operand_object *object)
>                 }
>                 break;
>
> +       case ACPI_TYPE_LOCAL_ADDRESS_HANDLER:
> +
> +               ACPI_DEBUG_PRINT((ACPI_DB_ALLOCATIONS,
> +                                 "***** Address handler %p\n", object));
> +
> +               acpi_os_delete_mutex(object->address_space.context_mutex);
> +               break;
> +
>         default:
>
>                 break;
> --

Applied as 5.13-rc material, thanks!
