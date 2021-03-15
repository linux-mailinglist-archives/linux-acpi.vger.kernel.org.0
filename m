Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9C333B067
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Mar 2021 11:54:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbhCOKxd (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 15 Mar 2021 06:53:33 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:2697 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbhCOKxa (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 15 Mar 2021 06:53:30 -0400
Received: from fraeml709-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DzY344m1tz680MP;
        Mon, 15 Mar 2021 18:45:04 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml709-chm.china.huawei.com (10.206.15.37) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 15 Mar 2021 11:53:22 +0100
Received: from localhost (10.47.90.207) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Mon, 15 Mar
 2021 10:53:19 +0000
Date:   Mon, 15 Mar 2021 10:52:04 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
CC:     "tim.c.chen@linux.intel.com" <tim.c.chen@linux.intel.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "bsegall@google.com" <bsegall@google.com>,
        "mgorman@suse.de" <mgorman@suse.de>,
        "msys.mizuma@gmail.com" <msys.mizuma@gmail.com>,
        "valentin.schneider@arm.com" <valentin.schneider@arm.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "aubrey.li@linux.intel.com" <aubrey.li@linux.intel.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>, "xuwei (O)" <xuwei5@huawei.com>,
        "Zengtao (B)" <prime.zeng@hisilicon.com>,
        "guodong.xu@linaro.org" <guodong.xu@linaro.org>,
        yangyicong <yangyicong@huawei.com>,
        "Liguozhu (Kenneth)" <liguozhu@hisilicon.com>,
        "linuxarm@openeuler.org" <linuxarm@openeuler.org>,
        "hpa@zytor.com" <hpa@zytor.com>
Subject: Re: [RFC PATCH v4 1/3] topology: Represent clusters of CPUs within
 a die.
Message-ID: <20210315105204.00007047@Huawei.com>
In-Reply-To: <abe764db9c4b418fa5293feeff61f56a@hisilicon.com>
References: <20210301225940.16728-1-song.bao.hua@hisilicon.com>
        <20210301225940.16728-2-song.bao.hua@hisilicon.com>
        <abe764db9c4b418fa5293feeff61f56a@hisilicon.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.90.207]
X-ClientProxiedBy: lhreml723-chm.china.huawei.com (10.201.108.74) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, 15 Mar 2021 03:11:06 +0000
"Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com> wrote:

> > -----Original Message-----
> > From: Song Bao Hua (Barry Song)
> > Sent: Tuesday, March 2, 2021 12:00 PM
> > To: tim.c.chen@linux.intel.com; catalin.marinas@arm.com; will@kernel.org;
> > rjw@rjwysocki.net; vincent.guittot@linaro.org; bp@alien8.de;
> > tglx@linutronix.de; mingo@redhat.com; lenb@kernel.org; peterz@infradead.org;
> > dietmar.eggemann@arm.com; rostedt@goodmis.org; bsegall@google.com;
> > mgorman@suse.de
> > Cc: msys.mizuma@gmail.com; valentin.schneider@arm.com;
> > gregkh@linuxfoundation.org; Jonathan Cameron <jonathan.cameron@huawei.com>;
> > juri.lelli@redhat.com; mark.rutland@arm.com; sudeep.holla@arm.com;
> > aubrey.li@linux.intel.com; linux-arm-kernel@lists.infradead.org;
> > linux-kernel@vger.kernel.org; linux-acpi@vger.kernel.org; x86@kernel.org;
> > xuwei (O) <xuwei5@huawei.com>; Zengtao (B) <prime.zeng@hisilicon.com>;
> > guodong.xu@linaro.org; yangyicong <yangyicong@huawei.com>; Liguozhu (Kenneth)
> > <liguozhu@hisilicon.com>; linuxarm@openeuler.org; hpa@zytor.com; Jonathan
> > Cameron <jonathan.cameron@huawei.com>; Song Bao Hua (Barry Song)
> > <song.bao.hua@hisilicon.com>
> > Subject: [RFC PATCH v4 1/3] topology: Represent clusters of CPUs within a die.
> > 
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > Both ACPI and DT provide the ability to describe additional layers of
> > topology between that of individual cores and higher level constructs
> > such as the level at which the last level cache is shared.
> > In ACPI this can be represented in PPTT as a Processor Hierarchy
> > Node Structure [1] that is the parent of the CPU cores and in turn
> > has a parent Processor Hierarchy Nodes Structure representing
> > a higher level of topology.
> > 
> > For example Kunpeng 920 has 6 or 8 clusters in each NUMA node, and each
> > cluster has 4 cpus. All clusters share L3 cache data, but each cluster
> > has local L3 tag. On the other hand, each clusters will share some
> > internal system bus.
> > 
> > +-----------------------------------+                          +---------+
> > |  +------+    +------+            +---------------------------+         |
> > |  | CPU0 |    | cpu1 |             |    +-----------+         |         |
> > |  +------+    +------+             |    |           |         |         |
> > |                                   +----+    L3     |         |         |
> > |  +------+    +------+   cluster   |    |    tag    |         |         |
> > |  | CPU2 |    | CPU3 |             |    |           |         |         |
> > |  +------+    +------+             |    +-----------+         |         |
> > |                                   |                          |         |
> > +-----------------------------------+                          |         |
> > +-----------------------------------+                          |         |
> > |  +------+    +------+             +--------------------------+         |
> > |  |      |    |      |             |    +-----------+         |         |
> > |  +------+    +------+             |    |           |         |         |
> > |                                   |    |    L3     |         |         |
> > |  +------+    +------+             +----+    tag    |         |         |
> > |  |      |    |      |             |    |           |         |         |
> > |  +------+    +------+             |    +-----------+         |         |
> > |                                   |                          |         |
> > +-----------------------------------+                          |   L3    |
> >                                                                |   data  |
> > +-----------------------------------+                          |         |
> > |  +------+    +------+             |    +-----------+         |         |
> > |  |      |    |      |             |    |           |         |         |
> > |  +------+    +------+             +----+    L3     |         |         |
> > |                                   |    |    tag    |         |         |
> > |  +------+    +------+             |    |           |         |         |
> > |  |      |    |      |            ++    +-----------+         |         |
> > |  +------+    +------+            |---------------------------+         |
> > +-----------------------------------|                          |         |
> > +-----------------------------------|                          |         |
> > |  +------+    +------+            +---------------------------+         |
> > |  |      |    |      |             |    +-----------+         |         |
> > |  +------+    +------+             |    |           |         |         |
> > |                                   +----+    L3     |         |         |
> > |  +------+    +------+             |    |    tag    |         |         |
> > |  |      |    |      |             |    |           |         |         |
> > |  +------+    +------+             |    +-----------+         |         |
> > |                                   |                          |         |
> > +-----------------------------------+                          |         |
> > +-----------------------------------+                          |         |
> > |  +------+    +------+             +--------------------------+         |
> > |  |      |    |      |             |   +-----------+          |         |
> > |  +------+    +------+             |   |           |          |         |
> > |                                   |   |    L3     |          |         |
> > |  +------+    +------+             +---+    tag    |          |         |
> > |  |      |    |      |             |   |           |          |         |
> > |  +------+    +------+             |   +-----------+          |         |
> > |                                   |                          |         |
> > +-----------------------------------+                          |         |
> > +-----------------------------------+                         ++         |
> > |  +------+    +------+             +--------------------------+         |
> > |  |      |    |      |             |  +-----------+           |         |
> > |  +------+    +------+             |  |           |           |         |
> > |                                   |  |    L3     |           |         |
> > |  +------+    +------+             +--+    tag    |           |         |
> > |  |      |    |      |             |  |           |           |         |
> > |  +------+    +------+             |  +-----------+           |         |
> > |                                   |                          +---------+
> > +-----------------------------------+
> > 
> > That means the cost to transfer ownership of a cacheline between CPUs
> > within a cluster is lower than between CPUs in different clusters on
> > the same die. Hence, it can make sense to tell the scheduler to use
> > the cache affinity of the cluster to make better decision on thread
> > migration.
> > 
> > This patch simply exposes this information to userspace libraries
> > like hwloc by providing cluster_cpus and related sysfs attributes.
> > PoC of HWLOC support at [2].
> > 
> > Note this patch only handle the ACPI case.
> > 
> > Special consideration is needed for SMT processors, where it is
> > necessary to move 2 levels up the hierarchy from the leaf nodes
> > (thus skipping the processor core level).
> > 
> > Currently the ID provided is the offset of the Processor
> > Hierarchy Nodes Structure within PPTT.  Whilst this is unique
> > it is not terribly elegant so alternative suggestions welcome.
> > 
> > Note that arm64 / ACPI does not provide any means of identifying
> > a die level in the topology but that may be unrelate to the cluster
> > level.
> > 
> > [1] ACPI Specification 6.3 - section 5.2.29.1 processor hierarchy node
> >     structure (Type 0)
> > [2] https://github.com/hisilicon/hwloc/tree/linux-cluster
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
> > ---
> >   -v4:
> >   * used acpi_cpu_id for acpi_find_processor_node(addressing Masa's comment)
> > 
> >  Documentation/admin-guide/cputopology.rst | 26 +++++++++++--
> >  arch/arm64/kernel/topology.c              |  2 +
> >  drivers/acpi/pptt.c                       | 63 +++++++++++++++++++++++++++++++
> >  drivers/base/arch_topology.c              | 14 +++++++
> >  drivers/base/topology.c                   | 10 +++++
> >  include/linux/acpi.h                      |  5 +++
> >  include/linux/arch_topology.h             |  5 +++
> >  include/linux/topology.h                  |  6 +++
> >  8 files changed, 127 insertions(+), 4 deletions(-)
> > 
> > diff --git a/Documentation/admin-guide/cputopology.rst
> > b/Documentation/admin-guide/cputopology.rst
> > index b90dafc..f9d3745 100644
> > --- a/Documentation/admin-guide/cputopology.rst
> > +++ b/Documentation/admin-guide/cputopology.rst
> > @@ -24,6 +24,12 @@ core_id:
> >  	identifier (rather than the kernel's).  The actual value is
> >  	architecture and platform dependent.
> > 
> > +cluster_id:
> > +
> > +	the Cluster ID of cpuX.  Typically it is the hardware platform's
> > +	identifier (rather than the kernel's).  The actual value is
> > +	architecture and platform dependent.
> > +
> >  book_id:
> > 
> >  	the book ID of cpuX. Typically it is the hardware platform's
> > @@ -56,6 +62,14 @@ package_cpus_list:
> >  	human-readable list of CPUs sharing the same physical_package_id.
> >  	(deprecated name: "core_siblings_list")
> > 
> > +cluster_cpus:
> > +
> > +	internal kernel map of CPUs within the same cluster.
> > +
> > +cluster_cpus_list:
> > +
> > +	human-readable list of CPUs within the same cluster.
> > +
> >  die_cpus:
> > 
> >  	internal kernel map of CPUs within the same die.
> > @@ -96,11 +110,13 @@ these macros in include/asm-XXX/topology.h::
> > 
> >  	#define topology_physical_package_id(cpu)
> >  	#define topology_die_id(cpu)
> > +	#define topology_cluster_id(cpu)
> >  	#define topology_core_id(cpu)
> >  	#define topology_book_id(cpu)
> >  	#define topology_drawer_id(cpu)
> >  	#define topology_sibling_cpumask(cpu)
> >  	#define topology_core_cpumask(cpu)
> > +	#define topology_cluster_cpumask(cpu)
> >  	#define topology_die_cpumask(cpu)
> >  	#define topology_book_cpumask(cpu)
> >  	#define topology_drawer_cpumask(cpu)
> > @@ -116,10 +132,12 @@ not defined by include/asm-XXX/topology.h:
> > 
> >  1) topology_physical_package_id: -1
> >  2) topology_die_id: -1
> > -3) topology_core_id: 0
> > -4) topology_sibling_cpumask: just the given CPU
> > -5) topology_core_cpumask: just the given CPU
> > -6) topology_die_cpumask: just the given CPU
> > +3) topology_cluster_id: -1
> > +4) topology_core_id: 0
> > +5) topology_sibling_cpumask: just the given CPU
> > +6) topology_core_cpumask: just the given CPU
> > +7) topology_cluster_cpumask: just the given CPU
> > +8) topology_die_cpumask: just the given CPU
> > 
> >  For architectures that don't support books (CONFIG_SCHED_BOOK) there are no
> >  default definitions for topology_book_id() and topology_book_cpumask().
> > diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
> > index f6faa69..fe076b3 100644
> > --- a/arch/arm64/kernel/topology.c
> > +++ b/arch/arm64/kernel/topology.c
> > @@ -103,6 +103,8 @@ int __init parse_acpi_topology(void)
> >  			cpu_topology[cpu].thread_id  = -1;
> >  			cpu_topology[cpu].core_id    = topology_id;
> >  		}
> > +		topology_id = find_acpi_cpu_topology_cluster(cpu);
> > +		cpu_topology[cpu].cluster_id = topology_id;
> >  		topology_id = find_acpi_cpu_topology_package(cpu);
> >  		cpu_topology[cpu].package_id = topology_id;
> > 
> > diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
> > index 4ae9335..11f8b02 100644
> > --- a/drivers/acpi/pptt.c
> > +++ b/drivers/acpi/pptt.c
> > @@ -737,6 +737,69 @@ int find_acpi_cpu_topology_package(unsigned int cpu)
> >  }
> > 
> >  /**
> > + * find_acpi_cpu_topology_cluster() - Determine a unique CPU cluster value
> > + * @cpu: Kernel logical CPU number
> > + *
> > + * Determine a topology unique cluster ID for the given CPU/thread.
> > + * This ID can then be used to group peers, which will have matching ids.
> > + *
> > + * The cluster, if present is the level of topology above CPUs. In a
> > + * multi-thread CPU, it will be the level above the CPU, not the thread.
> > + * It may not exist in single CPU systems. In simple multi-CPU systems,
> > + * it may be equal to the package topology level.
> > + *
> > + * Return: -ENOENT if the PPTT doesn't exist, the CPU cannot be found
> > + * or there is no toplogy level above the CPU..
> > + * Otherwise returns a value which represents the package for this CPU.
> > + */
> > +
> > +int find_acpi_cpu_topology_cluster(unsigned int cpu)
> > +{
> > +	struct acpi_table_header *table;
> > +	acpi_status status;
> > +	struct acpi_pptt_processor *cpu_node, *cluster_node;
> > +	u32 acpi_cpu_id;
> > +	int retval;
> > +	int is_thread;
> > +
> > +	status = acpi_get_table(ACPI_SIG_PPTT, 0, &table);
> > +	if (ACPI_FAILURE(status)) {
> > +		acpi_pptt_warn_missing();
> > +		return -ENOENT;
> > +	}
> > +
> > +	acpi_cpu_id = get_acpi_id_for_cpu(cpu);
> > +	cpu_node = acpi_find_processor_node(table, acpi_cpu_id);
> > +	if (cpu_node == NULL || !cpu_node->parent) {
> > +		retval = -ENOENT;
> > +		goto put_table;
> > +	}
> > +
> > +	is_thread = cpu_node->flags & ACPI_PPTT_ACPI_PROCESSOR_IS_THREAD;
> > +	cluster_node = fetch_pptt_node(table, cpu_node->parent);
> > +	if (cluster_node == NULL) {
> > +		retval = -ENOENT;
> > +		goto put_table;
> > +	}
> > +	if (is_thread) {
> > +		if (!cluster_node->parent) {
> > +			retval = -ENOENT;
> > +			goto put_table;
> > +		}
> > +		cluster_node = fetch_pptt_node(table, cluster_node->parent);
> > +		if (cluster_node == NULL) {
> > +			retval = -ENOENT;
> > +			goto put_table;
> > +		}
> > +	}
> > +	retval = ACPI_PTR_DIFF(cluster_node, table);
> > +put_table:
> > +	acpi_put_table(table);
> > +
> > +	return retval;
> > +}
> > +
> > +/**
> >   * find_acpi_cpu_topology_hetero_id() - Get a core architecture tag
> >   * @cpu: Kernel logical CPU number
> >   *
> > diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
> > index de8587c..3079232 100644
> > --- a/drivers/base/arch_topology.c
> > +++ b/drivers/base/arch_topology.c
> > @@ -506,6 +506,11 @@ const struct cpumask *cpu_coregroup_mask(int cpu)
> >  	return core_mask;
> >  }
> > 
> > +const struct cpumask *cpu_clustergroup_mask(int cpu)
> > +{
> > +	return &cpu_topology[cpu].cluster_sibling;
> > +}
> > +
> >  void update_siblings_masks(unsigned int cpuid)
> >  {
> >  	struct cpu_topology *cpu_topo, *cpuid_topo = &cpu_topology[cpuid];
> > @@ -523,6 +528,11 @@ void update_siblings_masks(unsigned int cpuid)
> >  		if (cpuid_topo->package_id != cpu_topo->package_id)
> >  			continue;
> > 
> > +		if (cpuid_topo->cluster_id == cpu_topo->cluster_id) {
> > +			cpumask_set_cpu(cpu, &cpuid_topo->cluster_sibling);
> > +			cpumask_set_cpu(cpuid, &cpu_topo->cluster_sibling);
> > +		}
> > +  
> 
> I am seeing a machine without cluster is getting cluster,
> so I guess we need the below:

Makes sense and is inline with the docs above.

Thanks,

Jonathan

> 
> diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
> index 3079232ed8ed..ccd4b3b5cc6f 100644
> --- a/drivers/base/arch_topology.c
> +++ b/drivers/base/arch_topology.c
> @@ -528,7 +528,8 @@ void update_siblings_masks(unsigned int cpuid)
>                 if (cpuid_topo->package_id != cpu_topo->package_id)
>                         continue;
> 
> -               if (cpuid_topo->cluster_id == cpu_topo->cluster_id) {
> +               if (cpuid_topo->cluster_id == cpu_topo->cluster_id &&
> +                   cpu_topo->cluster_id != -1) {
>                         cpumask_set_cpu(cpu, &cpuid_topo->cluster_sibling);
>                         cpumask_set_cpu(cpuid, &cpu_topo->cluster_sibling);
>                 }
> @@ -568,6 +569,7 @@ void __init reset_cpu_topology(void)
>                 struct cpu_topology *cpu_topo = &cpu_topology[cpu];
> 
>                 cpu_topo->thread_id = -1;
> +               cpu_topo->cluster_id = -1;
>                 cpu_topo->core_id = -1;
>                 cpu_topo->package_id = -1;
>                 cpu_topo->llc_id = -1;
> 
> Hi Jonathan, thoughts?
> 
> Thanks
> Barry
> 

