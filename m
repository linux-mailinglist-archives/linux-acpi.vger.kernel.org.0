Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 866F4DC295
	for <lists+linux-acpi@lfdr.de>; Fri, 18 Oct 2019 12:18:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389649AbfJRKSh (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 18 Oct 2019 06:18:37 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:46175 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387890AbfJRKSh (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 18 Oct 2019 06:18:37 -0400
Received: from 79.184.255.51.ipv4.supernova.orange.pl (79.184.255.51) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.292)
 id 2fe1e6cc54d2dbbb; Fri, 18 Oct 2019 12:18:33 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-mm@kvack.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        x86@kernel.org, Keith Busch <keith.busch@intel.com>,
        jglisse@redhat.com, linuxarm@huawei.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH V5 1/4] ACPI: Support Generic Initiator only domains
Date:   Fri, 18 Oct 2019 12:18:33 +0200
Message-ID: <1895971.7mY3IlW731@kreacher>
In-Reply-To: <20191004114330.104746-2-Jonathan.Cameron@huawei.com>
References: <20191004114330.104746-1-Jonathan.Cameron@huawei.com> <20191004114330.104746-2-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Friday, October 4, 2019 1:43:27 PM CEST Jonathan Cameron wrote:
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

This depends on the series from Dan at:

https://lore.kernel.org/linux-acpi/CAPcyv4gBSX58CWH4HZ28w0_cZRzJrhgdEFHa2g8KDqyv8aFqZQ@mail.gmail.com/T/#m1acce3ae8f29f680c0d95fd1e840e703949fbc48

AFAICS, so please respin when that one hits the Linus' tree.

> ---
>  drivers/acpi/numa/srat.c       | 62 +++++++++++++++++++++++++++++++++-
>  drivers/base/node.c            |  3 ++
>  include/asm-generic/topology.h |  3 ++
>  include/linux/nodemask.h       |  1 +
>  include/linux/topology.h       |  7 ++++
>  5 files changed, 75 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
> index eadbf90e65d1..fe34315a9234 100644
> --- a/drivers/acpi/numa/srat.c
> +++ b/drivers/acpi/numa/srat.c
> @@ -170,6 +170,38 @@ acpi_table_print_srat_entry(struct acpi_subtable_header *header)
>  		}
>  		break;
>  
> +	case ACPI_SRAT_TYPE_GENERIC_AFFINITY:
> +	{
> +		struct acpi_srat_generic_affinity *p =
> +			(struct acpi_srat_generic_affinity *)header;
> +		char name[9] = {};
> +
> +		if (p->device_handle_type == 0) {
> +			/*
> +			 * For pci devices this may be the only place they
> +			 * are assigned a proximity domain
> +			 */
> +			pr_debug("SRAT Generic Initiator(Seg:%u BDF:%u) in proximity domain %d %s\n",
> +				 *(u16 *)(&p->device_handle[0]),
> +				 *(u16 *)(&p->device_handle[2]),
> +				 p->proximity_domain,
> +				 (p->flags & ACPI_SRAT_GENERIC_AFFINITY_ENABLED) ?
> +				"enabled" : "disabled");
> +		} else {
> +			/*
> +			 * In this case we can rely on the device having a
> +			 * proximity domain reference
> +			 */
> +			memcpy(name, p->device_handle, 8);
> +			pr_info("SRAT Generic Initiator(HID=%.8s UID=%.4s) in proximity domain %d %s\n",
> +				(char *)(&p->device_handle[0]),
> +				(char *)(&p->device_handle[8]),
> +				p->proximity_domain,
> +				(p->flags & ACPI_SRAT_GENERIC_AFFINITY_ENABLED) ?
> +				"enabled" : "disabled");
> +		}
> +	}
> +	break;
>  	default:
>  		pr_warn("Found unsupported SRAT entry (type = 0x%x)\n",
>  			header->type);
> @@ -378,6 +410,32 @@ acpi_parse_gicc_affinity(union acpi_subtable_headers *header,
>  	return 0;
>  }
>  
> +static int __init
> +acpi_parse_gi_affinity(union acpi_subtable_headers *header,
> +		       const unsigned long end)
> +{
> +	struct acpi_srat_generic_affinity *gi_affinity;
> +	int node;
> +
> +	gi_affinity = (struct acpi_srat_generic_affinity *)header;
> +	if (!gi_affinity)
> +		return -EINVAL;
> +	acpi_table_print_srat_entry(&header->common);
> +
> +	if (!(gi_affinity->flags & ACPI_SRAT_GENERIC_AFFINITY_ENABLED))
> +		return -EINVAL;
> +
> +	node = acpi_map_pxm_to_node(gi_affinity->proximity_domain);
> +	if (node == NUMA_NO_NODE || node >= MAX_NUMNODES) {
> +		pr_err("SRAT: Too many proximity domains.\n");
> +		return -EINVAL;
> +	}
> +	node_set(node, numa_nodes_parsed);
> +	node_set_state(node, N_GENERIC_INITIATOR);
> +
> +	return 0;
> +}
> +
>  static int __initdata parsed_numa_memblks;
>  
>  static int __init
> @@ -433,7 +491,7 @@ int __init acpi_numa_init(void)
>  
>  	/* SRAT: System Resource Affinity Table */
>  	if (!acpi_table_parse(ACPI_SIG_SRAT, acpi_parse_srat)) {
> -		struct acpi_subtable_proc srat_proc[3];
> +		struct acpi_subtable_proc srat_proc[4];
>  
>  		memset(srat_proc, 0, sizeof(srat_proc));
>  		srat_proc[0].id = ACPI_SRAT_TYPE_CPU_AFFINITY;
> @@ -442,6 +500,8 @@ int __init acpi_numa_init(void)
>  		srat_proc[1].handler = acpi_parse_x2apic_affinity;
>  		srat_proc[2].id = ACPI_SRAT_TYPE_GICC_AFFINITY;
>  		srat_proc[2].handler = acpi_parse_gicc_affinity;
> +		srat_proc[3].id = ACPI_SRAT_TYPE_GENERIC_AFFINITY;
> +		srat_proc[3].handler = acpi_parse_gi_affinity;
>  
>  		acpi_table_parse_entries_array(ACPI_SIG_SRAT,
>  					sizeof(struct acpi_table_srat),
> diff --git a/drivers/base/node.c b/drivers/base/node.c
> index 296546ffed6c..e5863baa8cb6 100644
> --- a/drivers/base/node.c
> +++ b/drivers/base/node.c
> @@ -977,6 +977,8 @@ static struct node_attr node_state_attr[] = {
>  #endif
>  	[N_MEMORY] = _NODE_ATTR(has_memory, N_MEMORY),
>  	[N_CPU] = _NODE_ATTR(has_cpu, N_CPU),
> +	[N_GENERIC_INITIATOR] = _NODE_ATTR(has_generic_initiator,
> +					   N_GENERIC_INITIATOR),
>  };
>  
>  static struct attribute *node_state_attrs[] = {
> @@ -988,6 +990,7 @@ static struct attribute *node_state_attrs[] = {
>  #endif
>  	&node_state_attr[N_MEMORY].attr.attr,
>  	&node_state_attr[N_CPU].attr.attr,
> +	&node_state_attr[N_GENERIC_INITIATOR].attr.attr,
>  	NULL
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
>  #endif	/* !CONFIG_NUMA || !CONFIG_HAVE_MEMORYLESS_NODES */
>  
> diff --git a/include/linux/nodemask.h b/include/linux/nodemask.h
> index 27e7fa36f707..1aebf766fb52 100644
> --- a/include/linux/nodemask.h
> +++ b/include/linux/nodemask.h
> @@ -399,6 +399,7 @@ enum node_states {
>  #endif
>  	N_MEMORY,		/* The node has memory(regular, high, movable) */
>  	N_CPU,		/* The node has one or more cpus */
> +	N_GENERIC_INITIATOR,	/* The node is a GI only node */
>  	NR_NODE_STATES
>  };
>  
> diff --git a/include/linux/topology.h b/include/linux/topology.h
> index eb2fe6edd73c..05ccf011e489 100644
> --- a/include/linux/topology.h
> +++ b/include/linux/topology.h
> @@ -140,6 +140,13 @@ static inline void set_numa_mem(int node)
>  }
>  #endif
>  
> +#ifndef set_gi_numa_mem
> +static inline void set_gi_numa_mem(int gi, int node)
> +{
> +	_node_numa_mem_[gi] = node;
> +}
> +#endif
> +
>  #ifndef node_to_mem_node
>  static inline int node_to_mem_node(int node)
>  {
> 




