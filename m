Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94E4DA5D81
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Sep 2019 23:26:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727384AbfIBV02 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 2 Sep 2019 17:26:28 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:34958 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726964AbfIBV02 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 2 Sep 2019 17:26:28 -0400
Received: by mail-ot1-f66.google.com with SMTP id 100so14753193otn.2;
        Mon, 02 Sep 2019 14:26:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=51bqbB4DvSXg4Ew2o4zqEia3sJ8jFJPwKkEVreoHOaQ=;
        b=hAW3Z8h7HQqdOIgi3nveMVtZhB4P0WSi/TjNMIaG+kMDi5X9zg3Qq7ZKXFbRYOJ9ZH
         O7sq8ucmX8j88gOegDjIwEfcKx2Nh4XG+eKh8Da+W4SG+mI52cFsw3al+VG33Swy6mFU
         GRq71AmLGahHcx9hAIdC1W+DOrbSPqyJ7agKCMua1fV1BUM14MWbLkkWe1Ese5LlF7IF
         nRxr6HCiNVsrFm7PAc+Z5f2g6NP879Hy3DumL5w6vvAca5ns9tvIsCKy7eNv0E/CPs0o
         bxl3y6PJEOPBdrfRTpwdENnNec7ZNZHZeMfmBbiDO4ViohQel//ZNLTPaKrwDE0UCXhP
         xu7w==
X-Gm-Message-State: APjAAAUtWgrnjVAbd+23TrM/7tb9PWUL/LM7A3v0FPfG/Xe5JS5FOCJm
        NzlYuTrta1WBDUAXlbqrwCBeWBJ/A+uOXDSDzhE=
X-Google-Smtp-Source: APXvYqyUaffwR13IQSYSCljLxByT0+wOU3SzpStZdcxkTWgg2N0HBS0eY/sfMgMZHr4cE6nJGHZFFVvQMXyTWZcajro=
X-Received: by 2002:a9d:7411:: with SMTP id n17mr5844599otk.118.1567459587215;
 Mon, 02 Sep 2019 14:26:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190821145242.2330-1-Jonathan.Cameron@huawei.com> <20190821145242.2330-2-Jonathan.Cameron@huawei.com>
In-Reply-To: <20190821145242.2330-2-Jonathan.Cameron@huawei.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 2 Sep 2019 23:26:16 +0200
Message-ID: <CAJZ5v0ie8s-Ye7PD=xj0nXL228WDqhjJPCs+eV3n6_SAeaQowg@mail.gmail.com>
Subject: Re: [PATCH 1/4] ACPI: Support Generic Initiator only domains
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Keith Busch <keith.busch@intel.com>
Cc:     Linux Memory Management List <linux-mm@kvack.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Jerome Glisse <jglisse@redhat.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Linuxarm <linuxarm@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Aug 21, 2019 at 4:53 PM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> Generic Initiators are a new ACPI concept that allows for the
> description of proximity domains that contain a device which
> performs memory access (such as a network card) but neither
> host CPU nor Memory.
>
> This patch has the parsing code and provides the infrastructure
> for an architecture to associate these new domains with their
> nearest memory processing node.
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Dan, Keith, any comments?

AFAICS this clashes with the series from Dan that rearranges the ACPI
NUMA related code.

> ---
>  drivers/acpi/numa.c            | 62 +++++++++++++++++++++++++++++++++-
>  drivers/base/node.c            |  3 ++
>  include/asm-generic/topology.h |  3 ++
>  include/linux/nodemask.h       |  1 +
>  include/linux/topology.h       |  7 ++++
>  5 files changed, 75 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/numa.c b/drivers/acpi/numa.c
> index eadbf90e65d1..fe34315a9234 100644
> --- a/drivers/acpi/numa.c
> +++ b/drivers/acpi/numa.c
> @@ -170,6 +170,38 @@ acpi_table_print_srat_entry(struct acpi_subtable_header *header)
>                 }
>                 break;
>
> +       case ACPI_SRAT_TYPE_GENERIC_AFFINITY:
> +       {
> +               struct acpi_srat_generic_affinity *p =
> +                       (struct acpi_srat_generic_affinity *)header;
> +               char name[9] = {};
> +
> +               if (p->device_handle_type == 0) {
> +                       /*
> +                        * For pci devices this may be the only place they
> +                        * are assigned a proximity domain
> +                        */
> +                       pr_debug("SRAT Generic Initiator(Seg:%u BDF:%u) in proximity domain %d %s\n",
> +                                *(u16 *)(&p->device_handle[0]),
> +                                *(u16 *)(&p->device_handle[2]),
> +                                p->proximity_domain,
> +                                (p->flags & ACPI_SRAT_GENERIC_AFFINITY_ENABLED) ?
> +                               "enabled" : "disabled");
> +               } else {
> +                       /*
> +                        * In this case we can rely on the device having a
> +                        * proximity domain reference
> +                        */
> +                       memcpy(name, p->device_handle, 8);
> +                       pr_info("SRAT Generic Initiator(HID=%.8s UID=%.4s) in proximity domain %d %s\n",
> +                               (char *)(&p->device_handle[0]),
> +                               (char *)(&p->device_handle[8]),
> +                               p->proximity_domain,
> +                               (p->flags & ACPI_SRAT_GENERIC_AFFINITY_ENABLED) ?
> +                               "enabled" : "disabled");
> +               }
> +       }
> +       break;
>         default:
>                 pr_warn("Found unsupported SRAT entry (type = 0x%x)\n",
>                         header->type);
> @@ -378,6 +410,32 @@ acpi_parse_gicc_affinity(union acpi_subtable_headers *header,
>         return 0;
>  }
>
> +static int __init
> +acpi_parse_gi_affinity(union acpi_subtable_headers *header,
> +                      const unsigned long end)
> +{
> +       struct acpi_srat_generic_affinity *gi_affinity;
> +       int node;
> +
> +       gi_affinity = (struct acpi_srat_generic_affinity *)header;
> +       if (!gi_affinity)
> +               return -EINVAL;
> +       acpi_table_print_srat_entry(&header->common);
> +
> +       if (!(gi_affinity->flags & ACPI_SRAT_GENERIC_AFFINITY_ENABLED))
> +               return -EINVAL;
> +
> +       node = acpi_map_pxm_to_node(gi_affinity->proximity_domain);
> +       if (node == NUMA_NO_NODE || node >= MAX_NUMNODES) {
> +               pr_err("SRAT: Too many proximity domains.\n");
> +               return -EINVAL;
> +       }
> +       node_set(node, numa_nodes_parsed);
> +       node_set_state(node, N_GENERIC_INITIATOR);
> +
> +       return 0;
> +}
> +
>  static int __initdata parsed_numa_memblks;
>
>  static int __init
> @@ -433,7 +491,7 @@ int __init acpi_numa_init(void)
>
>         /* SRAT: System Resource Affinity Table */
>         if (!acpi_table_parse(ACPI_SIG_SRAT, acpi_parse_srat)) {
> -               struct acpi_subtable_proc srat_proc[3];
> +               struct acpi_subtable_proc srat_proc[4];
>
>                 memset(srat_proc, 0, sizeof(srat_proc));
>                 srat_proc[0].id = ACPI_SRAT_TYPE_CPU_AFFINITY;
> @@ -442,6 +500,8 @@ int __init acpi_numa_init(void)
>                 srat_proc[1].handler = acpi_parse_x2apic_affinity;
>                 srat_proc[2].id = ACPI_SRAT_TYPE_GICC_AFFINITY;
>                 srat_proc[2].handler = acpi_parse_gicc_affinity;
> +               srat_proc[3].id = ACPI_SRAT_TYPE_GENERIC_AFFINITY;
> +               srat_proc[3].handler = acpi_parse_gi_affinity;
>
>                 acpi_table_parse_entries_array(ACPI_SIG_SRAT,
>                                         sizeof(struct acpi_table_srat),
> diff --git a/drivers/base/node.c b/drivers/base/node.c
> index 75b7e6f6535b..6f60689af5f8 100644
> --- a/drivers/base/node.c
> +++ b/drivers/base/node.c
> @@ -980,6 +980,8 @@ static struct node_attr node_state_attr[] = {
>  #endif
>         [N_MEMORY] = _NODE_ATTR(has_memory, N_MEMORY),
>         [N_CPU] = _NODE_ATTR(has_cpu, N_CPU),
> +       [N_GENERIC_INITIATOR] = _NODE_ATTR(has_generic_initiator,
> +                                          N_GENERIC_INITIATOR),
>  };
>
>  static struct attribute *node_state_attrs[] = {
> @@ -991,6 +993,7 @@ static struct attribute *node_state_attrs[] = {
>  #endif
>         &node_state_attr[N_MEMORY].attr.attr,
>         &node_state_attr[N_CPU].attr.attr,
> +       &node_state_attr[N_GENERIC_INITIATOR].attr.attr,
>         NULL
>  };
>
> diff --git a/include/asm-generic/topology.h b/include/asm-generic/topology.h
> index 238873739550..54d0b4176a45 100644
> --- a/include/asm-generic/topology.h
> +++ b/include/asm-generic/topology.h
> @@ -71,6 +71,9 @@
>  #ifndef set_cpu_numa_mem
>  #define set_cpu_numa_mem(cpu, node)
>  #endif
> +#ifndef set_gi_numa_mem
> +#define set_gi_numa_mem(gi, node)
> +#endif
>
>  #endif /* !CONFIG_NUMA || !CONFIG_HAVE_MEMORYLESS_NODES */
>
> diff --git a/include/linux/nodemask.h b/include/linux/nodemask.h
> index 27e7fa36f707..1aebf766fb52 100644
> --- a/include/linux/nodemask.h
> +++ b/include/linux/nodemask.h
> @@ -399,6 +399,7 @@ enum node_states {
>  #endif
>         N_MEMORY,               /* The node has memory(regular, high, movable) */
>         N_CPU,          /* The node has one or more cpus */
> +       N_GENERIC_INITIATOR,    /* The node is a GI only node */
>         NR_NODE_STATES
>  };
>
> diff --git a/include/linux/topology.h b/include/linux/topology.h
> index 47a3e3c08036..2f97754e0508 100644
> --- a/include/linux/topology.h
> +++ b/include/linux/topology.h
> @@ -125,6 +125,13 @@ static inline void set_numa_mem(int node)
>  }
>  #endif
>
> +#ifndef set_gi_numa_mem
> +static inline void set_gi_numa_mem(int gi, int node)
> +{
> +       _node_numa_mem_[gi] = node;
> +}
> +#endif
> +
>  #ifndef node_to_mem_node
>  static inline int node_to_mem_node(int node)
>  {
> --
> 2.20.1
>
