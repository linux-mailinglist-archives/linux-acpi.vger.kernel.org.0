Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BCF56CEC01
	for <lists+linux-acpi@lfdr.de>; Wed, 29 Mar 2023 16:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbjC2OoV convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Wed, 29 Mar 2023 10:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbjC2OoB (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 29 Mar 2023 10:44:01 -0400
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A6B976A5;
        Wed, 29 Mar 2023 07:41:18 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id cn12so64326013edb.4;
        Wed, 29 Mar 2023 07:41:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680100877;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ut3vIYTXFPuTebq9JPHK5+BOxmY6RP9zm6nsO3SVW3A=;
        b=YwnwMqcdLruegFLeEY73YfIXiuBwV9exk/CqKImJgtOO6g3xWZa9X/UEIyt+Jm1jNh
         /QuY4iD529iqprvyl/kuQ2h0h8Qkf97NuFsl/DatFTw7UW1ks7SwaaFAG1rSuox9TtWW
         Wgc1Aofot7GSLXZ195GpzV3B7sQIM5RB4EJcvXNmAHLlDAUEnC7JTFjtyOc4Uoau8Iry
         002QlJd84+0k+D9wklB63YNA0ftrAAxfPSgPMc34PRpqfZfZwl0srvG6y4z1RG6Kzkm5
         G2+2NAjhA0SB5O9LObezVB8TWgCjwGzEW27P/3xHzlK+MTBbAPiYGxXPO7s6b/GgHgBQ
         dAgg==
X-Gm-Message-State: AAQBX9e1XHi3aNUi4OGmtKwmyifwpmnEwOMb6YGc7KdYclQmGvL5UE20
        mv5gJogX0TV9HRwJJrE7Um+CP1Vt9lrOA+6m6gsCxTbX
X-Google-Smtp-Source: AKy350ZaIxqYGU4RyZ6chFTQ0aojJvrpb44+D6ElfdC5q+XGJej3wI1D32wK7S8zkEY89qmr3rwqb4CgxA2U/bYMlnI=
X-Received: by 2002:a17:907:160e:b0:946:a095:b314 with SMTP id
 hb14-20020a170907160e00b00946a095b314mr3672747ejc.2.1680100877056; Wed, 29
 Mar 2023 07:41:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230329143813.25849-1-Benjamin.Cheatham@amd.com>
In-Reply-To: <20230329143813.25849-1-Benjamin.Cheatham@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 29 Mar 2023 16:41:05 +0200
Message-ID: <CAJZ5v0i4whXkwsM_G6fO6ws0JRNW3Wrrm=Q+2JGVZ-5FX4-V5A@mail.gmail.com>
Subject: Re: [PATCH] ACPI, APEI, EINJ: Remove memory range validation for CXL
 error types
To:     Ben Cheatham <Benjamin.Cheatham@amd.com>
Cc:     rafael@kernel.org, yazen.ghannam@amd.com,
        linux-acpi@vger.kernel.org, linux-cxl@vger.kernel.org,
        tony.luck@intel.com, Dan Williams <dan.j.williams@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Mar 29, 2023 at 4:38 PM Ben Cheatham <Benjamin.Cheatham@amd.com> wrote:
>
> From: Yazen Ghannam <yazen.ghannam@amd.com>
>
> This patch is a follow up to the discussion at [1], and builds on Tony's
> CXL error patch at [2].
>
> The new CXL error types will use the Memory Address field in the
> SET_ERROR_TYPE_WITH_ADDRESS structure in order to target a CXL 1.1
> compliant memory-mapped Downstream port. The value of the Memory Address
> will be in the port's MMIO range, and it will not represent physical
> (normal or persistent) memory.
>
> Allow error injection for CXL 1.1 systems by skipping memory range
> validation for CXL error injection types.
>
> Output trying to inject CXL.mem error without patch:
>
> # echo 0x8000 > error_type
> # echo 6 > flags
> # echo 0x3cd5d2000000 > param1
> # echo 0xFFFFFFFFFFFFF000 > param2
> # echo 0 > param3
> # echo 0x400000 > param4
> # echo 1 > error_inject
> -bash: echo: write error: Invalid argument
>
> [1]: https://lore.kernel.org/linux-acpi/20221206205234.606073-1-Benjamin.Cheatham@amd.com/
> [2]: https://lore.kernel.org/linux-cxl/CAJZ5v0hNQUfWViqxbJ5B4JCGJUuHpWWSpqpCFWPNpGuagoFbsQ@mail.gmail.com/T/#t

Link tags for the above, please, and an ACK from the CXL side,
preferably from Dan.

> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> Signed-off-by: Ben Cheatham <benjamin.cheatham@amd.com>
> ---
>  drivers/acpi/apei/einj.c | 13 ++++++++++++-
>  include/acpi/actbl1.h    |  6 ++++++
>  2 files changed, 18 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj.c
> index 82004abb9643..4e201dfb7d29 100644
> --- a/drivers/acpi/apei/einj.c
> +++ b/drivers/acpi/apei/einj.c
> @@ -37,6 +37,13 @@
>                                 ACPI_EINJ_MEMORY_UNCORRECTABLE | \
>                                 ACPI_EINJ_MEMORY_FATAL)
>
> +#define CXL_ERROR_MASK         (ACPI_EINJ_CXL_CACHE_CORRECTABLE        | \
> +                               ACPI_EINJ_CXL_CACHE_UNCORRECTABLE       | \
> +                               ACPI_EINJ_CXL_CACHE_FATAL               | \
> +                               ACPI_EINJ_CXL_MEM_CORRECTABLE           | \
> +                               ACPI_EINJ_CXL_MEM_UNCORRECTABLE         | \
> +                               ACPI_EINJ_CXL_MEM_FATAL)
> +
>  /*
>   * ACPI version 5 provides a SET_ERROR_TYPE_WITH_ADDRESS action.
>   */
> @@ -511,6 +518,7 @@ static int einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
>                              u64 param3, u64 param4)
>  {
>         int rc;
> +       u32 available_error_types = 0;
>         u64 base_addr, size;
>
>         /* If user manually set "flags", make sure it is legal */
> @@ -531,8 +539,11 @@ static int einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
>         if (type & ACPI5_VENDOR_BIT) {
>                 if (vendor_flags != SETWA_FLAGS_MEM)
>                         goto inject;
> -       } else if (!(type & MEM_ERROR_MASK) && !(flags & SETWA_FLAGS_MEM))
> +       } else if (!(type & MEM_ERROR_MASK) && !(flags & SETWA_FLAGS_MEM)) {
> +               goto inject;
> +       } else if (type & CXL_ERROR_MASK) {
>                 goto inject;
> +       }
>
>         /*
>          * Disallow crazy address masks that give BIOS leeway to pick
> diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
> index 15c78678c5d3..68588b2be716 100644
> --- a/include/acpi/actbl1.h
> +++ b/include/acpi/actbl1.h
> @@ -895,6 +895,12 @@ enum acpi_einj_command_status {
>  #define ACPI_EINJ_PLATFORM_CORRECTABLE      (1<<9)
>  #define ACPI_EINJ_PLATFORM_UNCORRECTABLE    (1<<10)
>  #define ACPI_EINJ_PLATFORM_FATAL            (1<<11)
> +#define ACPI_EINJ_CXL_CACHE_CORRECTABLE     BIT(12)
> +#define ACPI_EINJ_CXL_CACHE_UNCORRECTABLE   BIT(13)
> +#define ACPI_EINJ_CXL_CACHE_FATAL           BIT(14)
> +#define ACPI_EINJ_CXL_MEM_CORRECTABLE       BIT(15)
> +#define ACPI_EINJ_CXL_MEM_UNCORRECTABLE     BIT(16)
> +#define ACPI_EINJ_CXL_MEM_FATAL             BIT(17)
>  #define ACPI_EINJ_VENDOR_DEFINED            (1<<31)
>
>  /*******************************************************************************
> --
> 2.34.1
>
