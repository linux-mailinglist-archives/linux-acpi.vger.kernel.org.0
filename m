Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC72B39F64E
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Jun 2021 14:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232131AbhFHMW3 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 8 Jun 2021 08:22:29 -0400
Received: from mail-oi1-f178.google.com ([209.85.167.178]:39668 "EHLO
        mail-oi1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231993AbhFHMW2 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 8 Jun 2021 08:22:28 -0400
Received: by mail-oi1-f178.google.com with SMTP id m137so17437190oig.6;
        Tue, 08 Jun 2021 05:20:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OmTdNAirSU2hkyrUMU+ARQjy6bvUlpwnEGNeFoKbjA8=;
        b=AZvhwZq/UeFte7ZUzd34TXkXMBlB0cMkQHPti6/cN32rjwgvYWet4nbqjVzzi/pCn+
         jQDCR+/SQd3Fe5UsCrf1Sx7MFBAf6joIx12buswXanTCR3goYB0uTQx6ydnOwQqCCWIe
         pbKJ/r4dXfTwzLTLuDjdBn+oeprHBKBuMdqHjho6jySsn5QTYwbCqmEado+GF0aQhXiU
         PnTlJSSnvghJUQ2ondLgkVl3excJCPoRAuEhxS4/0/0yvlRL/9sDg9gj+de80s6VlsK1
         dVWPMBcDBNcMNmSaJuOSZu4Y2QljhhDvls/yixjF7Og2HsVYmWR5YLc7GCUUTjQLlmZo
         z3mw==
X-Gm-Message-State: AOAM5306uT4k9j3BjQ6ajpnxkriaKPFAa1GXJmSzLwYW+nxEUn8EAjWs
        FEmrso0wnEZCFU9hmhXFCAnGebEpJj6hf1TNAvE=
X-Google-Smtp-Source: ABdhPJzGnwuhGOuzkrFQmGHEbYgJZPCAHMUb8TTYp305sD+8WsA0diJEPnVIIf53jR51n274a7P1CxE1tcKsGbw4YpI=
X-Received: by 2002:aca:b406:: with SMTP id d6mr2621167oif.71.1623154835851;
 Tue, 08 Jun 2021 05:20:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210607195430.48228-1-david@redhat.com> <20210607195430.48228-9-david@redhat.com>
In-Reply-To: <20210607195430.48228-9-david@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 8 Jun 2021 14:20:24 +0200
Message-ID: <CAJZ5v0gnT6QSkhcgPbHOXm8_zRQrefkdZk3k3_Ne5XCqoAGguA@mail.gmail.com>
Subject: Re: [PATCH v1 08/12] ACPI: memhotplug: memory resources cannot be
 enabled yet
To:     David Hildenbrand <david@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Marek Kedzierski <mkedzier@redhat.com>,
        Hui Zhu <teawater@gmail.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mike Rapoport <rppt@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        virtualization@lists.linux-foundation.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Jun 7, 2021 at 9:55 PM David Hildenbrand <david@redhat.com> wrote:
>
> We allocate + initialize everything from scratch. In case enabling the
> device fails, we free all memory resourcs.
>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/acpi/acpi_memhotplug.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/drivers/acpi/acpi_memhotplug.c b/drivers/acpi/acpi_memhotplug.c
> index 1d01d9414c40..eb4faf7c5cad 100644
> --- a/drivers/acpi/acpi_memhotplug.c
> +++ b/drivers/acpi/acpi_memhotplug.c
> @@ -182,10 +182,6 @@ static int acpi_memory_enable_device(struct acpi_memory_device *mem_device)
>          * (i.e. memory-hot-remove function)
>          */
>         list_for_each_entry(info, &mem_device->res_list, list) {
> -               if (info->enabled) { /* just sanity check...*/
> -                       num_enabled++;
> -                       continue;
> -               }
>                 /*
>                  * If the memory block size is zero, please ignore it.
>                  * Don't try to do the following memory hotplug flowchart.
> --
> 2.31.1
>
