Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7F0810D542
	for <lists+linux-acpi@lfdr.de>; Fri, 29 Nov 2019 12:56:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbfK2L4s (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 29 Nov 2019 06:56:48 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:63269 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbfK2L4s (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 29 Nov 2019 06:56:48 -0500
Received: from 79.184.255.242.ipv4.supernova.orange.pl (79.184.255.242) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.320)
 id fd5d8e3d9f99383b; Fri, 29 Nov 2019 12:56:46 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-nvdimm@lists.01.org, Michal Hocko <mhocko@suse.com>,
        peterz@infradead.org, vishal.l.verma@intel.com,
        dave.hansen@linux.intel.com, hch@lst.de,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH v2 14/18] acpi/numa: Up-level "map to online node" functionality
Date:   Fri, 29 Nov 2019 12:56:45 +0100
Message-ID: <1753949.6LdYI5zB43@kreacher>
In-Reply-To: <157401275104.43284.15865121806241743141.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <157401267421.43284.2135775608523385279.stgit@dwillia2-desk3.amr.corp.intel.com> <157401275104.43284.15865121806241743141.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sunday, November 17, 2019 6:45:51 PM CET Dan Williams wrote:
> The acpi_map_pxm_to_online_node() helper is used to find the closest
> online node to a given proximity domain. This is used to map devices in
> a proximity domain with no online memory or cpus to the closest online
> node and populate a device's 'numa_node' property. The numa_node
> property allows applications to be migrated "close" to a resource.
> 
> In preparation for providing a generic facility to optionally map an
> address range to its closest online node, or the node the range would
> represent were it to be onlined (target_node), up-level the core of
> acpi_map_pxm_to_online_node() to a generic mm/numa helper.
> 
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

It looks like this is the only patch in the series needing my attention and
it is fine by me, so

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/acpi/numa.c  |   41 -----------------------------------------
>  include/linux/acpi.h |   23 ++++++++++++++++++++++-
>  include/linux/numa.h |    9 +++++++++
>  mm/mempolicy.c       |   30 ++++++++++++++++++++++++++++++
>  4 files changed, 61 insertions(+), 42 deletions(-)
> 
> diff --git a/drivers/acpi/numa.c b/drivers/acpi/numa.c
> index eadbf90e65d1..47b4969d9b93 100644
> --- a/drivers/acpi/numa.c
> +++ b/drivers/acpi/numa.c
> @@ -72,47 +72,6 @@ int acpi_map_pxm_to_node(int pxm)
>  }
>  EXPORT_SYMBOL(acpi_map_pxm_to_node);
>  
> -/**
> - * acpi_map_pxm_to_online_node - Map proximity ID to online node
> - * @pxm: ACPI proximity ID
> - *
> - * This is similar to acpi_map_pxm_to_node(), but always returns an online
> - * node.  When the mapped node from a given proximity ID is offline, it
> - * looks up the node distance table and returns the nearest online node.
> - *
> - * ACPI device drivers, which are called after the NUMA initialization has
> - * completed in the kernel, can call this interface to obtain their device
> - * NUMA topology from ACPI tables.  Such drivers do not have to deal with
> - * offline nodes.  A node may be offline when a device proximity ID is
> - * unique, SRAT memory entry does not exist, or NUMA is disabled, ex.
> - * "numa=off" on x86.
> - */
> -int acpi_map_pxm_to_online_node(int pxm)
> -{
> -	int node, min_node;
> -
> -	node = acpi_map_pxm_to_node(pxm);
> -
> -	if (node == NUMA_NO_NODE)
> -		node = 0;
> -
> -	min_node = node;
> -	if (!node_online(node)) {
> -		int min_dist = INT_MAX, dist, n;
> -
> -		for_each_online_node(n) {
> -			dist = node_distance(node, n);
> -			if (dist < min_dist) {
> -				min_dist = dist;
> -				min_node = n;
> -			}
> -		}
> -	}
> -
> -	return min_node;
> -}
> -EXPORT_SYMBOL(acpi_map_pxm_to_online_node);
> -
>  static void __init
>  acpi_table_print_srat_entry(struct acpi_subtable_header *header)
>  {
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 8b4e516bac00..aeedd09f2f71 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -401,9 +401,30 @@ extern void acpi_osi_setup(char *str);
>  extern bool acpi_osi_is_win8(void);
>  
>  #ifdef CONFIG_ACPI_NUMA
> -int acpi_map_pxm_to_online_node(int pxm);
>  int acpi_map_pxm_to_node(int pxm);
>  int acpi_get_node(acpi_handle handle);
> +
> +/**
> + * acpi_map_pxm_to_online_node - Map proximity ID to online node
> + * @pxm: ACPI proximity ID
> + *
> + * This is similar to acpi_map_pxm_to_node(), but always returns an online
> + * node.  When the mapped node from a given proximity ID is offline, it
> + * looks up the node distance table and returns the nearest online node.
> + *
> + * ACPI device drivers, which are called after the NUMA initialization has
> + * completed in the kernel, can call this interface to obtain their device
> + * NUMA topology from ACPI tables.  Such drivers do not have to deal with
> + * offline nodes.  A node may be offline when a device proximity ID is
> + * unique, SRAT memory entry does not exist, or NUMA is disabled, ex.
> + * "numa=off" on x86.
> + */
> +static inline int acpi_map_pxm_to_online_node(int pxm)
> +{
> +	int node = acpi_map_pxm_to_node(pxm);
> +
> +	return numa_map_to_online_node(node);
> +}
>  #else
>  static inline int acpi_map_pxm_to_online_node(int pxm)
>  {
> diff --git a/include/linux/numa.h b/include/linux/numa.h
> index 110b0e5d0fb0..20f4e44b186c 100644
> --- a/include/linux/numa.h
> +++ b/include/linux/numa.h
> @@ -13,4 +13,13 @@
>  
>  #define	NUMA_NO_NODE	(-1)
>  
> +#ifdef CONFIG_NUMA
> +int numa_map_to_online_node(int node);
> +#else
> +static inline int numa_map_to_online_node(int node)
> +{
> +	return NUMA_NO_NODE;
> +}
> +#endif
> +
>  #endif /* _LINUX_NUMA_H */
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index 4ae967bcf954..e2d8dd21ce9d 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -127,6 +127,36 @@ static struct mempolicy default_policy = {
>  
>  static struct mempolicy preferred_node_policy[MAX_NUMNODES];
>  
> +/**
> + * numa_map_to_online_node - Find closest online node
> + * @nid: Node id to start the search
> + *
> + * Lookup the next closest node by distance if @nid is not online.
> + */
> +int numa_map_to_online_node(int node)
> +{
> +	int min_node;
> +
> +	if (node == NUMA_NO_NODE)
> +		node = 0;
> +
> +	min_node = node;
> +	if (!node_online(node)) {
> +		int min_dist = INT_MAX, dist, n;
> +
> +		for_each_online_node(n) {
> +			dist = node_distance(node, n);
> +			if (dist < min_dist) {
> +				min_dist = dist;
> +				min_node = n;
> +			}
> +		}
> +	}
> +
> +	return min_node;
> +}
> +EXPORT_SYMBOL_GPL(numa_map_to_online_node);
> +
>  struct mempolicy *get_task_policy(struct task_struct *p)
>  {
>  	struct mempolicy *pol = p->mempolicy;
> 




