Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD463417830
	for <lists+linux-acpi@lfdr.de>; Fri, 24 Sep 2021 18:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347267AbhIXQMC (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 24 Sep 2021 12:12:02 -0400
Received: from mail-ot1-f51.google.com ([209.85.210.51]:35435 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347149AbhIXQMB (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 24 Sep 2021 12:12:01 -0400
Received: by mail-ot1-f51.google.com with SMTP id 77-20020a9d0ed3000000b00546e10e6699so13848125otj.2
        for <linux-acpi@vger.kernel.org>; Fri, 24 Sep 2021 09:10:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4XFjCdTZfkB9perl5s+ANrngqRBBMs0NbLq4iZOMprY=;
        b=bsdXzAsAkzjOV6EBN4hAsT+w+dpyIiO4sYA0zH3cLlkC+ChCNpGO4LubFbMB/hKb/n
         hclZ6whrk5+S7aqO6jtlkhdULPjUSD92d0czfKyox0syxfQoTAQ7h6P0P/e/PaTL+vOP
         MrS/EMeU+V6sXxEyaDTzl5RNc76vOqZzrh9bO6FR75rKhnKsWfZ8CljVit5FXAZk7yox
         43AKCRNFTF/b9PO3ZdZb0anfFAtgkPBo74bGpJWgyZDwtK3KeNZb0nntAgEkc+FPOTO3
         EGMHHbsGyb5qDfEzVYxMyLir9t4iW+ocIBMrKlhh+NJn8p9cWRvTUOcLTWWs1f8UKrEk
         pLzg==
X-Gm-Message-State: AOAM5334ASFREbGJ24deK51TmtTIR8FZUsorrOjNZxBEtKdZWGmjeyfJ
        u6YiqaBSJFz+ve282hPYdpmo5sVKOm92M0vdHII=
X-Google-Smtp-Source: ABdhPJx6jEFxyoy8THqDGnuogNOXoC+tjXLoMq7A7ln/wglylMd872woHQJc6mOl1+74BnzOgl5f0JZ0ro6yFh9JyEQ=
X-Received: by 2002:a05:6830:82b:: with SMTP id t11mr4753199ots.319.1632499824618;
 Fri, 24 Sep 2021 09:10:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210916194957.197119-1-mlangsdo@redhat.com>
In-Reply-To: <20210916194957.197119-1-mlangsdo@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 24 Sep 2021 18:10:13 +0200
Message-ID: <CAJZ5v0gGena0k1ne265-+iSDRB9di24ASLuvxHHYk1R3qyz2_A@mail.gmail.com>
Subject: Re: [PATCH] ACPI: SPCR: check if table->serial_port.access_width is
 too wide
To:     Mark Langsdorf <mlangsdo@redhat.com>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Robert Moore <robert.moore@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Sep 16, 2021 at 9:50 PM Mark Langsdorf <mlangsdo@redhat.com> wrote:
>
> If table->serial_port.access_width is more than 29, it causes
> undefined behavior when ACPI_ACCESS_BIT_WIDTH shifts it to
> (1 << ((size) + 2)):
>
> [    0.000000] UBSAN: Undefined behaviour in drivers/acpi/spcr.c:114:11
> [    0.000000] shift exponent 102 is too large for 32-bit type 'int'
>
> Test that serial_port.access_width is less than 30 and set it to 6
> if it is not.
>
> Signed-off-by: Mark Langsdorf <mlangsdo@redhat.com>

This consists of a Linux part and an ACPICA part (the changes in
actypes.h).  The ACPICA part needs to be submitted to the upstream
project before applying this.

> ---
>  drivers/acpi/spcr.c    |  8 ++++++--
>  include/acpi/actypes.h | 10 ++++++++--
>  2 files changed, 14 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/acpi/spcr.c b/drivers/acpi/spcr.c
> index 134f7f60cf8102..52f17d631d24e9 100644
> --- a/drivers/acpi/spcr.c
> +++ b/drivers/acpi/spcr.c
> @@ -111,8 +111,12 @@ int __init acpi_parse_spcr(bool enable_earlycon, bool enable_console)
>                 pr_info("SPCR table version %d\n", table->header.revision);
>
>         if (table->serial_port.space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY) {
> -               switch (ACPI_ACCESS_BIT_WIDTH((
> -                       table->serial_port.access_width))) {
> +               u32 bit_width = table->serial_port.access_width;
> +               if(bit_width > ACPI_ACCESS_BIT_MAX) {
> +                       pr_err("Unacceptable wide SPCR Access Width.  Defaulting to byte size\n");
> +                       bit_width = ACPI_ACCESS_BIT_DEFAULT;
> +               }
> +               switch (ACPI_ACCESS_BIT_WIDTH((bit_width))) {
>                 default:
>                         pr_err("Unexpected SPCR Access Width.  Defaulting to byte size\n");
>                         fallthrough;
> diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
> index 92c71dfce0d5d9..cefbb7ad253e02 100644
> --- a/include/acpi/actypes.h
> +++ b/include/acpi/actypes.h
> @@ -536,8 +536,14 @@ typedef u64 acpi_integer;
>   * Can be used with access_width of struct acpi_generic_address and access_size of
>   * struct acpi_resource_generic_register.
>   */
> -#define ACPI_ACCESS_BIT_WIDTH(size)     (1 << ((size) + 2))
> -#define ACPI_ACCESS_BYTE_WIDTH(size)    (1 << ((size) - 1))
> +#define ACPI_ACCESS_BIT_SHIFT          2
> +#define ACPI_ACCESS_BYTE_SHIFT         -1
> +#define ACPI_ACCESS_BIT_MAX            (31 - ACPI_ACCESS_BIT_SHIFT)
> +#define ACPI_ACCESS_BYTE_MAX           (31 - ACPI_ACCESS_BYTE_SHIFT)
> +#define ACPI_ACCESS_BIT_DEFAULT                (8 - ACPI_ACCESS_BIT_SHIFT)
> +#define ACPI_ACCESS_BYTE_DEFAULT       (8 - ACPI_ACCESS_BYTE_SHIFT)
> +#define ACPI_ACCESS_BIT_WIDTH(size)    (1 << ((size) + ACPI_ACCESS_BIT_SHIFT))
> +#define ACPI_ACCESS_BYTE_WIDTH(size)   (1 << ((size) + ACPI_ACCESS_BYTE_SHIFT))
>
>  /*******************************************************************************
>   *
> --
> 2.26.3
>
