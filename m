Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8915F39F652
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Jun 2021 14:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232528AbhFHMWp (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 8 Jun 2021 08:22:45 -0400
Received: from mail-ot1-f51.google.com ([209.85.210.51]:43755 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232246AbhFHMWo (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 8 Jun 2021 08:22:44 -0400
Received: by mail-ot1-f51.google.com with SMTP id i12-20020a05683033ecb02903346fa0f74dso20060003otu.10;
        Tue, 08 Jun 2021 05:20:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aBvx0tMqvnsqasRMwdIjV828Q4KMfEaGuv9isdIMh6w=;
        b=AfriIGXHJdqcAM38Gv6UrSnFkVhDOaztKwBGacdZwnam3vJ8mSUStbcLynOlF6rCYG
         Bt1Ck+vueKHFANZQ+NNh92WbOYKVC4zyd+U8m8X2xCgNc1XIq1oGlLvR5WTV3rvd1s9a
         rT5SRFYJi/9e1ntWO4Brn/sugqgzykiI4TRQjP+Ot5388mITcuoItUeKeQ/GhNiehcOF
         1cId7F8t2qfVkPLq0kwi1mOzQgdwjv9iv7XjHGhYI+AVa/g7gNkegAIvct4bwIvWMw8P
         +KKmag6s0aK/laagl3SXQBIGjGdfqezwqnu82c6bjZVs0IxtN/ZsR0ci8TrUb4hzNAl1
         OOag==
X-Gm-Message-State: AOAM530r7JzBSDbX+lF7PFtF/eFilSI9VyCS2TSZdLuP91wCRKOgcMLQ
        hl9A0bgl0Oy1NHF86tNTyjyb5GRGEdVNUiPtGsg=
X-Google-Smtp-Source: ABdhPJxH/dWUiK6LlZLSUta/Ys0v09YjScxWXuTxxpG59lqd7H1n1RYtnEYQbcCaesHEWVw7jYVneuift9/T5XVCqBA=
X-Received: by 2002:a9d:63cd:: with SMTP id e13mr18583145otl.206.1623154851653;
 Tue, 08 Jun 2021 05:20:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210607195430.48228-1-david@redhat.com> <20210607195430.48228-10-david@redhat.com>
In-Reply-To: <20210607195430.48228-10-david@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 8 Jun 2021 14:20:40 +0200
Message-ID: <CAJZ5v0is=8897cneU7VwfV-HRpqAk=CU0833xyyxKjDZfJPHMw@mail.gmail.com>
Subject: Re: [PATCH v1 09/12] ACPI: memhotplug: use a single static memory
 group for a single memory device
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
> Let's group all memory we add for a single memory device - we want a
> single node for that (which also seems to be the sane thing to do).
>
> We won't care for now about memory that was already added to the system
> (e.g., via e820) -- usually *all* memory of a memory device was already
> added and we'll fail acpi_memory_enable_device().
>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/acpi/acpi_memhotplug.c | 35 +++++++++++++++++++++++++++++-----
>  1 file changed, 30 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/acpi/acpi_memhotplug.c b/drivers/acpi/acpi_memhotplug.c
> index eb4faf7c5cad..0c7b062c0e5d 100644
> --- a/drivers/acpi/acpi_memhotplug.c
> +++ b/drivers/acpi/acpi_memhotplug.c
> @@ -54,6 +54,7 @@ struct acpi_memory_info {
>  struct acpi_memory_device {
>         struct acpi_device *device;
>         struct list_head res_list;
> +       int mgid;
>  };
>
>  static acpi_status
> @@ -171,10 +172,31 @@ static int acpi_memory_enable_device(struct acpi_memory_device *mem_device)
>         acpi_handle handle = mem_device->device->handle;
>         int result, num_enabled = 0;
>         struct acpi_memory_info *info;
> -       mhp_t mhp_flags = MHP_NONE;
> -       int node;
> +       mhp_t mhp_flags = MHP_NID_IS_MGID;
> +       u64 total_length = 0;
> +       int node, mgid;
>
>         node = acpi_get_node(handle);
> +
> +       list_for_each_entry(info, &mem_device->res_list, list) {
> +               if (!info->length)
> +                       continue;
> +               /* We want a single node for the whole memory group */
> +               if (node < 0)
> +                       node = memory_add_physaddr_to_nid(info->start_addr);
> +               total_length += info->length;
> +       }
> +
> +       if (!total_length) {
> +               dev_err(&mem_device->device->dev, "device is empty\n");
> +               return -EINVAL;
> +       }
> +
> +       mgid = register_static_memory_group(node, PFN_UP(total_length));
> +       if (mgid < 0)
> +               return mgid;
> +       mem_device->mgid = mgid;
> +
>         /*
>          * Tell the VM there is more memory here...
>          * Note: Assume that this function returns zero on success
> @@ -188,12 +210,10 @@ static int acpi_memory_enable_device(struct acpi_memory_device *mem_device)
>                  */
>                 if (!info->length)
>                         continue;
> -               if (node < 0)
> -                       node = memory_add_physaddr_to_nid(info->start_addr);
>
>                 if (mhp_supports_memmap_on_memory(info->length))
>                         mhp_flags |= MHP_MEMMAP_ON_MEMORY;
> -               result = __add_memory(node, info->start_addr, info->length,
> +               result = __add_memory(mgid, info->start_addr, info->length,
>                                       mhp_flags);
>
>                 /*
> @@ -253,6 +273,10 @@ static void acpi_memory_device_free(struct acpi_memory_device *mem_device)
>         if (!mem_device)
>                 return;
>
> +       /* In case we succeeded adding *some* memory, unregistering fails. */
> +       if (mem_device->mgid >= 0)
> +               unregister_memory_group(mem_device->mgid);
> +
>         acpi_memory_free_device_resources(mem_device);
>         mem_device->device->driver_data = NULL;
>         kfree(mem_device);
> @@ -273,6 +297,7 @@ static int acpi_memory_device_add(struct acpi_device *device,
>
>         INIT_LIST_HEAD(&mem_device->res_list);
>         mem_device->device = device;
> +       mem_device->mgid = -1;
>         sprintf(acpi_device_name(device), "%s", ACPI_MEMORY_DEVICE_NAME);
>         sprintf(acpi_device_class(device), "%s", ACPI_MEMORY_DEVICE_CLASS);
>         device->driver_data = mem_device;
> --
> 2.31.1
>
