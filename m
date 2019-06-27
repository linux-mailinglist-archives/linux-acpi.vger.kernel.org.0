Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C20195813A
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Jun 2019 13:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726187AbfF0LPM (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 27 Jun 2019 07:15:12 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:42433 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726431AbfF0LPM (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 27 Jun 2019 07:15:12 -0400
Received: by mail-oi1-f196.google.com with SMTP id s184so1262750oie.9;
        Thu, 27 Jun 2019 04:15:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vkwo17Jxfe5H5nbAVTLEzuj/Ttfe2mfI+ZP3IgtJV0U=;
        b=OUPqgu2JfWT6Uwh0CcoTTC7JJwjHEf/ietKvM5gPMbD9N1uvhnV5NEQasTxeoC7gXX
         7M4gpBfoIQ6lw1nXF4d0EEZwTaMsbQc6fjCYOROiGix89XVADw2ElqEGuXppGsA3KveW
         LTvDbzSlP0btXohk2XwOgNYxg+3QmGYhE3pHa8kybnJoSfNlc26ls6ySZFu99pOOwAj3
         /PmeC2MUDvV2qW4awQzR2y8kWJZ2PatCzZuCZi6Y8/cS9NgZZWvH7U7VEJ/KVY6W1YQS
         6QMqYLtP3xRIntNDMZAv7wB9rWNZL3K0v+sYVgISACsRgxsH/IJs2cudizjoPAzsxefr
         RCCw==
X-Gm-Message-State: APjAAAX4ZH48jPLeMfkTEEeh0vPgFp+0I8eLtKWo89DziLjVYO+ctS2G
        Txp7k9kHRm/rPLeI/lIQTfPdSiLzAOK7PQKP97edxA==
X-Google-Smtp-Source: APXvYqyNtP3I+OQkcwTXLakewZWO7PdxVHYhHgXqYPHJVPHIo+HivWejz3S0mN7DzNENmB04FtX/QkK8MfHFVJJiFRY=
X-Received: by 2002:aca:edc8:: with SMTP id l191mr1874535oih.103.1561634111149;
 Thu, 27 Jun 2019 04:15:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190626213718.39423-1-jeremy.linton@arm.com> <20190626213718.39423-2-jeremy.linton@arm.com>
In-Reply-To: <20190626213718.39423-2-jeremy.linton@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 27 Jun 2019 13:15:00 +0200
Message-ID: <CAJZ5v0hqDwEAuJ6rk5yBd7_OCW71Y5ihHHNDUUiW6a3wvWOuGg@mail.gmail.com>
Subject: Re: [PATCH v5 1/4] ACPI/PPTT: Modify node flag detection to find last IDENTICAL
To:     Jeremy Linton <jeremy.linton@arm.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Hanjun Gou <gouhanjun@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Jun 26, 2019 at 11:37 PM Jeremy Linton <jeremy.linton@arm.com> wrote:
>
> The ACPI specification implies that the IDENTICAL flag should be
> set on all non leaf nodes where the children are identical.
> This means that we need to be searching for the last node with
> the identical flag set rather than the first one.
>
> Since this flag is also dependent on the table revision, we
> need to add a bit of extra code to verify the table revision,
> and the next node's state in the traversal. Since we want to
> avoid function pointers here, lets just special case
> the IDENTICAL flag.
>
> Tested-by: Hanjun Gou <gouhanjun@huawei.com>
> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>

Assuming that the Tested-by tag will be fixed:

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/acpi/pptt.c | 35 +++++++++++++++++++++++++++++------
>  1 file changed, 29 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
> index b72e6afaa8fb..05344413f199 100644
> --- a/drivers/acpi/pptt.c
> +++ b/drivers/acpi/pptt.c
> @@ -432,17 +432,40 @@ static void cache_setup_acpi_cpu(struct acpi_table_header *table,
>         }
>  }
>
> +static bool flag_identical(struct acpi_table_header *table_hdr,
> +                          struct acpi_pptt_processor *cpu)
> +{
> +       struct acpi_pptt_processor *next;
> +
> +       /* heterogeneous machines must use PPTT revision > 1 */
> +       if (table_hdr->revision < 2)
> +               return false;
> +
> +       /* Locate the last node in the tree with IDENTICAL set */
> +       if (cpu->flags & ACPI_PPTT_ACPI_IDENTICAL) {
> +               next = fetch_pptt_node(table_hdr, cpu->parent);
> +               if (!(next && next->flags & ACPI_PPTT_ACPI_IDENTICAL))
> +                       return true;
> +       }
> +
> +       return false;
> +}
> +
>  /* Passing level values greater than this will result in search termination */
>  #define PPTT_ABORT_PACKAGE 0xFF
>
> -static struct acpi_pptt_processor *acpi_find_processor_package_id(struct acpi_table_header *table_hdr,
> -                                                                 struct acpi_pptt_processor *cpu,
> -                                                                 int level, int flag)
> +static struct acpi_pptt_processor *acpi_find_processor_tag(struct acpi_table_header *table_hdr,
> +                                                          struct acpi_pptt_processor *cpu,
> +                                                          int level, int flag)
>  {
>         struct acpi_pptt_processor *prev_node;
>
>         while (cpu && level) {
> -               if (cpu->flags & flag)
> +               /* special case the identical flag to find last identical */
> +               if (flag == ACPI_PPTT_ACPI_IDENTICAL) {
> +                       if (flag_identical(table_hdr, cpu))
> +                               break;
> +               } else if (cpu->flags & flag)
>                         break;
>                 pr_debug("level %d\n", level);
>                 prev_node = fetch_pptt_node(table_hdr, cpu->parent);
> @@ -480,8 +503,8 @@ static int topology_get_acpi_cpu_tag(struct acpi_table_header *table,
>
>         cpu_node = acpi_find_processor_node(table, acpi_cpu_id);
>         if (cpu_node) {
> -               cpu_node = acpi_find_processor_package_id(table, cpu_node,
> -                                                         level, flag);
> +               cpu_node = acpi_find_processor_tag(table, cpu_node,
> +                                                  level, flag);
>                 /*
>                  * As per specification if the processor structure represents
>                  * an actual processor, then ACPI processor ID must be valid.
> --
> 2.21.0
>
