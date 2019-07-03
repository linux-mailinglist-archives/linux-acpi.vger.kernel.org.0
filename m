Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C26A95E29E
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Jul 2019 13:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726544AbfGCLLK (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 3 Jul 2019 07:11:10 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:33226 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726486AbfGCLLK (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 3 Jul 2019 07:11:10 -0400
Received: by mail-oi1-f195.google.com with SMTP id u15so1751396oiv.0;
        Wed, 03 Jul 2019 04:11:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5dj7wwiiT/uTLAOcQc9kC3UGFT63e367n3oRw7r2SNo=;
        b=YafON+g1TVwA2ty/TVG56QpQOfrPyhc4jkiWGkeIxKZcJGg9vImJMoECtSycJpHxKA
         DxNqEkvM+MlZFMHdXwMNcMn+2DiZI+zy8+YAagsAl0P38A0ME//MwA6CIqpxONU7xXvy
         942A5e9eAiRrHdwWaBT3pZV8rXM92nzSvr6v3D85BjjW7plq+QbITTrKUsNIS4Gw5X19
         u4H0nwl0pGpHuk4TAJ8g1iOrENJzrwrOethQZMiFsfBvuGRnZHu5vYkni0Lq0S5EltPI
         FOg633+QZH9Pp7eJzV0jDJQp47sxbOcza1SAFgLa8o5j9J5aIvZDavYm8tLFVQCDVqbU
         6oUw==
X-Gm-Message-State: APjAAAUcYLIWapLYKfdIbnfnADORhMYG1bAszVGdTYZXH3U2Pej4x/Lu
        9d8QO52EsJKiOcW2DJGPZNh4CwW19tV5cQpan0U=
X-Google-Smtp-Source: APXvYqymgr9Ny272krNuNKmRkdgKmiZYJjunZqxdcYHzBi9aN009dc+6dmS3hvuz0IX7ro5gfX21d95DOHEniSgtQv8=
X-Received: by 2002:aca:d907:: with SMTP id q7mr3109347oig.68.1562152269830;
 Wed, 03 Jul 2019 04:11:09 -0700 (PDT)
MIME-Version: 1.0
References: <156140036490.2951909.1837804994781523185.stgit@dwillia2-desk3.amr.corp.intel.com>
 <156140037770.2951909.3387200938880485927.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <156140037770.2951909.3387200938880485927.stgit@dwillia2-desk3.amr.corp.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 3 Jul 2019 13:10:58 +0200
Message-ID: <CAJZ5v0gAVXxnu22it_YTTm1HQPiBj5DOuiC1YCg5Eem8RQW0Ww@mail.gmail.com>
Subject: Re: [PATCH v4 02/10] acpi/numa/hmat: Skip publishing target info for
 nodes with no online memory
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     "the arch/x86 maintainers" <x86@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Jun 24, 2019 at 8:33 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> There are multiple scenarios where the HMAT may contain information
> about proximity domains that are not currently online. Rather than fail
> to report any HMAT data just elide those offline domains.
>
> If and when those domains are later onlined they can be added to the
> HMEM reporting at that point.
>
> This was found while testing EFI_MEMORY_SP support which reserves
> "specific purpose" memory from the general allocation pool. If that
> reservation results in an empty numa-node then the node is not marked
> online leading a spurious:
>
>     "acpi/hmat: Ignoring HMAT: Invalid table"
>
> ...result for HMAT parsing.
>
> Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/acpi/numa/hmat.c |   14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
> index 96b7d39a97c6..2c220cb7b620 100644
> --- a/drivers/acpi/numa/hmat.c
> +++ b/drivers/acpi/numa/hmat.c
> @@ -96,9 +96,6 @@ static __init void alloc_memory_target(unsigned int mem_pxm)
>  {
>         struct memory_target *target;
>
> -       if (pxm_to_node(mem_pxm) == NUMA_NO_NODE)
> -               return;
> -
>         target = find_mem_target(mem_pxm);
>         if (target)
>                 return;
> @@ -588,6 +585,17 @@ static __init void hmat_register_targets(void)
>         struct memory_target *target;
>
>         list_for_each_entry(target, &targets, node) {
> +               int nid = pxm_to_node(target->memory_pxm);
> +
> +               /*
> +                * Skip offline nodes. This can happen when memory
> +                * marked EFI_MEMORY_SP, "specific purpose", is applied
> +                * to all the memory in a promixity domain leading to
> +                * the node being marked offline / unplugged, or if
> +                * memory-only "hotplug" node is offline.
> +                */
> +               if (nid == NUMA_NO_NODE || !node_online(nid))
> +                       continue;
>                 hmat_register_target_initiators(target);
>                 hmat_register_target_perf(target);
>         }
>
