Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C6315E2B6
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Jul 2019 13:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbfGCLRo (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 3 Jul 2019 07:17:44 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:41516 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbfGCLRo (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 3 Jul 2019 07:17:44 -0400
Received: by mail-ot1-f66.google.com with SMTP id o101so1923482ota.8;
        Wed, 03 Jul 2019 04:17:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6p7Ml1taBfw1pgfwjcyxPi4qSjAjlKpEhQ7dgExagw8=;
        b=mKSSaXJpH/H41N4Fm3Luq47EgNRGFNvk2mwVX9nAoVJF3OpDdfOjPA8sSuupd5phf+
         d1CHqPSB8mUsf7zStFgIdQF53aH43J1HzOpAk+9IabJ/TrMhcLTOZ+Qko0w1qsdelEXU
         fWm2LLwmBtbvc0HG8BLOOlk30EoWQyZWbJlekCWd/4dhVvGRA0RShUCOy0ihfKfRG2jv
         hKDS4w5Aj6u2FXWJfAz4OkFop+v+OUFT9GGpPGnhFoJ73ZH4gvBx3U2jkdyRwXt77oOb
         0qq0uzjbjlqRHpoH3f0whYQJn6SfYAeDoBP5iDWWZw8D+uAZWSCwUbI5b920InhzvsXd
         CCSA==
X-Gm-Message-State: APjAAAW6mqjhlrC+SKUhVsab+yho2I5V8sLsSeVK1KZwGLIG1BCAmEKc
        GLGgoxLTLkFYpQCtuMkfa+bqrIEYTDGLsauWrXw=
X-Google-Smtp-Source: APXvYqxaKpjJ5SbDkRCszXzemDFcQ5qrdoVchVV8t7MJfau/DDMWDTbG36vuyffe6H1hjkVc1tNkbmzNYVGWE1RmrUg=
X-Received: by 2002:a05:6830:1516:: with SMTP id k22mr8620913otp.189.1562152663517;
 Wed, 03 Jul 2019 04:17:43 -0700 (PDT)
MIME-Version: 1.0
References: <156140036490.2951909.1837804994781523185.stgit@dwillia2-desk3.amr.corp.intel.com>
 <156140042634.2951909.15878153818360710942.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <156140042634.2951909.15878153818360710942.stgit@dwillia2-desk3.amr.corp.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 3 Jul 2019 13:17:32 +0200
Message-ID: <CAJZ5v0gm3QD+qnFvuhdCi9Fa9NR2YLptKU8JEDuC9EH5k2oOyQ@mail.gmail.com>
Subject: Re: [PATCH v4 10/10] acpi/numa/hmat: Register "specific purpose"
 memory as an "hmem" device
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     "the arch/x86 maintainers" <x86@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Keith Busch <keith.busch@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
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

On Mon, Jun 24, 2019 at 8:34 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> Memory that has been tagged EFI_MEMORY_SP, and has performance
> properties described by the ACPI HMAT is expected to have an application
> specific consumer.
>
> Those consumers may want 100% of the memory capacity to be reserved from
> any usage by the kernel. By default, with this enabling, a platform
> device is created to represent this differentiated resource.
>
> The device-dax "hmem" driver claims these devices by default and
> provides an mmap interface for the target application.  If the
> administrator prefers, the hmem resource range can be made available to
> the core-mm via the device-dax hotplug facility, kmem, to online the
> memory with its own numa node.
>
> This was tested with an emulated HMAT produced by qemu (with the pending
> HMAT enabling patches), and "efi_fake_mem=8G@9G:0x40000" on the kernel
> command line to mark the memory ranges associated with node2 and node3
> as EFI_MEMORY_SP.
>
> qemu numa configuration options:
>
> -numa node,mem=4G,cpus=0-19,nodeid=0
> -numa node,mem=4G,cpus=20-39,nodeid=1
> -numa node,mem=4G,nodeid=2
> -numa node,mem=4G,nodeid=3
> -numa dist,src=0,dst=0,val=10
> -numa dist,src=0,dst=1,val=21
> -numa dist,src=0,dst=2,val=21
> -numa dist,src=0,dst=3,val=21
> -numa dist,src=1,dst=0,val=21
> -numa dist,src=1,dst=1,val=10
> -numa dist,src=1,dst=2,val=21
> -numa dist,src=1,dst=3,val=21
> -numa dist,src=2,dst=0,val=21
> -numa dist,src=2,dst=1,val=21
> -numa dist,src=2,dst=2,val=10
> -numa dist,src=2,dst=3,val=21
> -numa dist,src=3,dst=0,val=21
> -numa dist,src=3,dst=1,val=21
> -numa dist,src=3,dst=2,val=21
> -numa dist,src=3,dst=3,val=10
> -numa hmat-lb,initiator=0,target=0,hierarchy=memory,data-type=access-latency,base-lat=10,latency=5
> -numa hmat-lb,initiator=0,target=0,hierarchy=memory,data-type=access-bandwidth,base-bw=20,bandwidth=5
> -numa hmat-lb,initiator=0,target=1,hierarchy=memory,data-type=access-latency,base-lat=10,latency=10
> -numa hmat-lb,initiator=0,target=1,hierarchy=memory,data-type=access-bandwidth,base-bw=20,bandwidth=10
> -numa hmat-lb,initiator=0,target=2,hierarchy=memory,data-type=access-latency,base-lat=10,latency=15
> -numa hmat-lb,initiator=0,target=2,hierarchy=memory,data-type=access-bandwidth,base-bw=20,bandwidth=15
> -numa hmat-lb,initiator=0,target=3,hierarchy=memory,data-type=access-latency,base-lat=10,latency=20
> -numa hmat-lb,initiator=0,target=3,hierarchy=memory,data-type=access-bandwidth,base-bw=20,bandwidth=20
> -numa hmat-lb,initiator=1,target=0,hierarchy=memory,data-type=access-latency,base-lat=10,latency=10
> -numa hmat-lb,initiator=1,target=0,hierarchy=memory,data-type=access-bandwidth,base-bw=20,bandwidth=10
> -numa hmat-lb,initiator=1,target=1,hierarchy=memory,data-type=access-latency,base-lat=10,latency=5
> -numa hmat-lb,initiator=1,target=1,hierarchy=memory,data-type=access-bandwidth,base-bw=20,bandwidth=5
> -numa hmat-lb,initiator=1,target=2,hierarchy=memory,data-type=access-latency,base-lat=10,latency=15
> -numa hmat-lb,initiator=1,target=2,hierarchy=memory,data-type=access-bandwidth,base-bw=20,bandwidth=15
> -numa hmat-lb,initiator=1,target=3,hierarchy=memory,data-type=access-latency,base-lat=10,latency=20
> -numa hmat-lb,initiator=1,target=3,hierarchy=memory,data-type=access-bandwidth,base-bw=20,bandwidth=20
>
> Result:
>
> # daxctl list -RDu
> [
>   {
>     "path":"\/platform\/hmem.1",
>     "id":1,
>     "size":"4.00 GiB (4.29 GB)",
>     "align":2097152,
>     "devices":[
>       {
>         "chardev":"dax1.0",
>         "size":"4.00 GiB (4.29 GB)"
>       }
>     ]
>   },
>   {
>     "path":"\/platform\/hmem.0",
>     "id":0,
>     "size":"4.00 GiB (4.29 GB)",
>     "align":2097152,
>     "devices":[
>       {
>         "chardev":"dax0.0",
>         "size":"4.00 GiB (4.29 GB)"
>       }
>     ]
>   }
> ]
>
> # cat /proc/iomem
> [..]
> 240000000-43fffffff : Application Reserved
>   240000000-33fffffff : hmem.0
>     240000000-33fffffff : dax0.0
>   340000000-43fffffff : hmem.1
>     340000000-43fffffff : dax1.0
>
> Cc: Len Brown <lenb@kernel.org>
> Cc: Keith Busch <keith.busch@intel.com>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/acpi/numa/Kconfig |    1
>  drivers/acpi/numa/hmat.c  |  132 +++++++++++++++++++++++++++++++++++++++++----
>  2 files changed, 122 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/acpi/numa/Kconfig b/drivers/acpi/numa/Kconfig
> index d14582387ed0..c1be746e111a 100644
> --- a/drivers/acpi/numa/Kconfig
> +++ b/drivers/acpi/numa/Kconfig
> @@ -8,6 +8,7 @@ config ACPI_HMAT
>         bool "ACPI Heterogeneous Memory Attribute Table Support"
>         depends on ACPI_NUMA
>         select HMEM_REPORTING
> +       select MEMREGION
>         help
>          If set, this option has the kernel parse and report the
>          platform's ACPI HMAT (Heterogeneous Memory Attributes Table),
> diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
> index 1d329c4af3bf..622c5feb3aa0 100644
> --- a/drivers/acpi/numa/hmat.c
> +++ b/drivers/acpi/numa/hmat.c
> @@ -8,11 +8,16 @@
>   * the applicable attributes with the node's interfaces.
>   */
>
> +#define pr_fmt(fmt) "acpi/hmat: " fmt
> +#define dev_fmt(fmt) "acpi/hmat: " fmt
> +
>  #include <linux/acpi.h>
>  #include <linux/bitops.h>
>  #include <linux/device.h>
>  #include <linux/init.h>
>  #include <linux/list.h>
> +#include <linux/mm.h>
> +#include <linux/platform_device.h>
>  #include <linux/list_sort.h>
>  #include <linux/node.h>
>  #include <linux/sysfs.h>
> @@ -40,6 +45,7 @@ struct memory_target {
>         struct list_head node;
>         unsigned int memory_pxm;
>         unsigned int processor_pxm;
> +       struct resource memregions;
>         struct node_hmem_attrs hmem_attrs;
>  };
>
> @@ -92,21 +98,35 @@ static __init void alloc_memory_initiator(unsigned int cpu_pxm)
>         list_add_tail(&initiator->node, &initiators);
>  }
>
> -static __init void alloc_memory_target(unsigned int mem_pxm)
> +static __init void alloc_memory_target(unsigned int mem_pxm,
> +               resource_size_t start, resource_size_t len)
>  {
>         struct memory_target *target;
>
>         target = find_mem_target(mem_pxm);
> -       if (target)
> -               return;
> -
> -       target = kzalloc(sizeof(*target), GFP_KERNEL);
> -       if (!target)
> -               return;
> +       if (!target) {
> +               target = kzalloc(sizeof(*target), GFP_KERNEL);
> +               if (!target)
> +                       return;
> +               target->memory_pxm = mem_pxm;
> +               target->processor_pxm = PXM_INVAL;
> +               target->memregions = (struct resource) {
> +                       .name   = "ACPI mem",
> +                       .start  = 0,
> +                       .end    = -1,
> +                       .flags  = IORESOURCE_MEM,
> +               };
> +               list_add_tail(&target->node, &targets);
> +       }
>
> -       target->memory_pxm = mem_pxm;
> -       target->processor_pxm = PXM_INVAL;
> -       list_add_tail(&target->node, &targets);
> +       /*
> +        * There are potentially multiple ranges per PXM, so record each
> +        * in the per-target memregions resource tree.
> +        */
> +       if (!__request_region(&target->memregions, start, len, "memory target",
> +                               IORESOURCE_MEM))
> +               pr_warn("failed to reserve %#llx - %#llx in pxm: %d\n",
> +                               start, start + len, mem_pxm);
>  }
>
>  static __init const char *hmat_data_type(u8 type)
> @@ -428,7 +448,7 @@ static __init int srat_parse_mem_affinity(union acpi_subtable_headers *header,
>                 return -EINVAL;
>         if (!(ma->flags & ACPI_SRAT_MEM_ENABLED))
>                 return 0;
> -       alloc_memory_target(ma->proximity_domain);
> +       alloc_memory_target(ma->proximity_domain, ma->base_address, ma->length);
>         return 0;
>  }
>
> @@ -580,6 +600,81 @@ static __init void hmat_register_target_perf(struct memory_target *target)
>         node_set_perf_attrs(mem_nid, &target->hmem_attrs, 0);
>  }
>
> +static __init void hmat_register_target_device(struct memory_target *target,
> +               struct resource *r)
> +{
> +       /* define a clean / non-busy resource for the platform device */
> +       struct resource res = {
> +               .start = r->start,
> +               .end = r->end,
> +               .flags = IORESOURCE_MEM,
> +       };
> +       struct platform_device *pdev;
> +       struct memregion_info info;
> +       int rc, id;
> +
> +       rc = region_intersects(res.start, resource_size(&res), IORESOURCE_MEM,
> +                       IORES_DESC_APPLICATION_RESERVED);
> +       if (rc != REGION_INTERSECTS)
> +               return;
> +
> +       id = memregion_alloc(GFP_KERNEL);
> +       if (id < 0) {
> +               pr_err("memregion allocation failure for %pr\n", &res);
> +               return;
> +       }
> +
> +       pdev = platform_device_alloc("hmem", id);
> +       if (!pdev) {
> +               pr_err("hmem device allocation failure for %pr\n", &res);
> +               goto out_pdev;
> +       }
> +
> +       pdev->dev.numa_node = acpi_map_pxm_to_online_node(target->memory_pxm);
> +       info = (struct memregion_info) {
> +               .target_node = acpi_map_pxm_to_node(target->memory_pxm),
> +       };
> +       rc = platform_device_add_data(pdev, &info, sizeof(info));
> +       if (rc < 0) {
> +               pr_err("hmem memregion_info allocation failure for %pr\n", &res);
> +               goto out_pdev;
> +       }
> +
> +       rc = platform_device_add_resources(pdev, &res, 1);
> +       if (rc < 0) {
> +               pr_err("hmem resource allocation failure for %pr\n", &res);
> +               goto out_resource;
> +       }
> +
> +       rc = platform_device_add(pdev);
> +       if (rc < 0) {
> +               dev_err(&pdev->dev, "device add failed for %pr\n", &res);
> +               goto out_resource;
> +       }
> +
> +       return;
> +
> +out_resource:
> +       put_device(&pdev->dev);
> +out_pdev:
> +       memregion_free(id);
> +}
> +
> +static __init void hmat_register_target_devices(struct memory_target *target)
> +{
> +       struct resource *res;
> +
> +       /*
> +        * Do not bother creating devices if no driver is available to
> +        * consume them.
> +        */
> +       if (!IS_ENABLED(CONFIG_DEV_DAX_HMEM))
> +               return;
> +
> +       for (res = target->memregions.child; res; res = res->sibling)
> +               hmat_register_target_device(target, res);
> +}
> +
>  static __init void hmat_register_targets(void)
>  {
>         struct memory_target *target;
> @@ -587,6 +682,12 @@ static __init void hmat_register_targets(void)
>         list_for_each_entry(target, &targets, node) {
>                 int nid = pxm_to_node(target->memory_pxm);
>
> +               /*
> +                * Devices may belong to either an offline or online
> +                * node, so unconditionally add them.
> +                */
> +               hmat_register_target_devices(target);
> +
>                 /*
>                  * Skip offline nodes. This can happen when memory
>                  * marked EFI_MEMORY_SP, "specific purpose", is applied
> @@ -608,7 +709,16 @@ static __init void hmat_free_structures(void)
>         struct memory_initiator *initiator, *inext;
>
>         list_for_each_entry_safe(target, tnext, &targets, node) {
> +               struct resource *res, *res_next;
> +
>                 list_del(&target->node);
> +               res = target->memregions.child;
> +               while (res) {
> +                       res_next = res->sibling;
> +                       __release_region(&target->memregions, res->start,
> +                                       resource_size(res));
> +                       res = res_next;
> +               }
>                 kfree(target);
>         }
>
>
