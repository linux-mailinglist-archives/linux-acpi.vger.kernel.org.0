Return-Path: <linux-acpi+bounces-16247-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4083CB3E12E
	for <lists+linux-acpi@lfdr.de>; Mon,  1 Sep 2025 13:12:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F07DD3B350F
	for <lists+linux-acpi@lfdr.de>; Mon,  1 Sep 2025 11:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD4CA311589;
	Mon,  1 Sep 2025 11:10:12 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B1A30EF90;
	Mon,  1 Sep 2025 11:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756725012; cv=none; b=CyliKsrcuXgl044GdKuCer39lD9YjlAMmtVZu32Fh5Da6fivuTx29X//E9TqPN/DNqZpUpbRWXQ2nYJ6NYmy0XAOn031Sh6ZAK+lo/SdQL8LtqXhYF79oXM74XmSZVnk6w2AdAGEahLkOjVt3MOyTHxG3m2HbDxpthox4FtL0RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756725012; c=relaxed/simple;
	bh=SLPlGtYkhtJMyhgfQbDcReZPIm5jPnZRyWUTo+SsDMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lxqzta9HxVZ963tj27up8oFTubWAlu7MaoJQvTS6lMnJNM69/Zd2fngVsxFbIn5an2VXJ823mfthIwwsz5B6emY7SZm4rZXRPDe4obcQ7Fh0XnlKMwsXR+PTlbvTujgwGKsOaqd51pnE+uSQ7iD6xoaD3Jg/61AMeH5iro01FCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DAC511A00;
	Mon,  1 Sep 2025 04:10:00 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.68])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5B7673F6A8;
	Mon,  1 Sep 2025 04:10:03 -0700 (PDT)
Date: Mon, 1 Sep 2025 12:09:47 +0100
From: Dave Martin <Dave.Martin@arm.com>
To: James Morse <james.morse@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
	shameerali.kolothum.thodi@huawei.com,
	D Scott Phillips OS <scott@os.amperecomputing.com>,
	carl@os.amperecomputing.com, lcherian@marvell.com,
	bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
	baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
	Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
	dfustini@baylibre.com, amitsinght@marvell.com,
	David Hildenbrand <david@redhat.com>,
	Rex Nie <rex.nie@jaguarmicro.com>, Koba Ko <kobak@nvidia.com>,
	Shanker Donthineni <sdonthineni@nvidia.com>, fenghuay@nvidia.com,
	baisheng.gao@unisoc.com,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Rob Herring <robh@kernel.org>, Rohit Mathew <rohit.mathew@arm.com>,
	Rafael Wysocki <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>, Ben Horgan <ben.horgan@arm.com>
Subject: Re: [PATCH 12/33] arm_mpam: Add the class and component structures
 for ris firmware described
Message-ID: <aLV++1PELhKBeKR7@e133380.arm.com>
References: <20250822153048.2287-1-james.morse@arm.com>
 <20250822153048.2287-13-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250822153048.2287-13-james.morse@arm.com>

Hi,

> Subject: arm_mpam: Add the class and component structures for ris firmware described

Mangled subject line?


There is a fair intersection between the commit message and what the
patch does, but they don't quite seem to match up.

Some key issues like locking / object lifecycle management
and DT parsing (a bit of which, it appears, lives here too) are not
mentioned at all.

In lieu of a complete rewrite, it might be best to discard the
explanation of the various object types.  The comment in the code
speaks for itself, and looks clearer.

[...]

On Fri, Aug 22, 2025 at 03:29:53PM +0000, James Morse wrote:
> An MSC is a container of resources, each identified by their RIS index.
> Some RIS are described by firmware to provide their position in the system.
> Others are discovered when the driver probes the hardware.
> 
> To configure a resource it needs to be found by its class, e.g. 'L2'.
> There are two kinds of grouping, a class is a set of components, which
> are visible to user-space as there are likely to be multiple instances
> of the L2 cache. (e.g. one per cluster or package)
> 
> struct mpam_components are a set of struct mpam_vmsc. A vMSC groups the
> RIS in an MSC that control the same logical piece of hardware. (e.g. L2).
> This is to allow hardware implementations where two controls are presented
> as different RIS. Re-combining these RIS allows their feature bits to
> be or-ed. This structure is not visible outside mpam_devices.c
> 
> struct mpam_vmsc are then a set of struct mpam_msc_ris, which are not
> visible as each L2 cache may be composed of individual slices which need
> to be configured the same as the hardware is not able to distribute the
> configuration.
> 
> Add support for creating and destroying these structures.
> A gfp is passed as the structures may need creating when a new RIS entry
> is discovered when probing the MSC.
> 
> CC: Ben Horgan <ben.horgan@arm.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
> Changes since RFC:
>  * removed a pr_err() debug message that crept in.
> ---
>  drivers/resctrl/mpam_devices.c  | 488 +++++++++++++++++++++++++++++++-
>  drivers/resctrl/mpam_internal.h |  91 ++++++
>  include/linux/arm_mpam.h        |   8 +-
>  3 files changed, 574 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
> index 71a1fb1a9c75..5baf2a8786fb 100644
> --- a/drivers/resctrl/mpam_devices.c
> +++ b/drivers/resctrl/mpam_devices.c
> @@ -20,7 +20,6 @@

[...]

> @@ -35,11 +34,483 @@
>  static DEFINE_MUTEX(mpam_list_lock);
>  static LIST_HEAD(mpam_all_msc);
>  
> -static struct srcu_struct mpam_srcu;
> +struct srcu_struct mpam_srcu;

Why expose this here?  This patch makes no use of the exposed symbol.

>  
>  /* MPAM isn't available until all the MSC have been probed. */
>  static u32 mpam_num_msc;
>  
> +/*
> + * An MSC is a physical container for controls and monitors, each identified by
> + * their RIS index. These share a base-address, interrupts and some MMIO
> + * registers. A vMSC is a virtual container for RIS in an MSC that control or
> + * monitor the same thing. Members of a vMSC are all RIS in the same MSC, but
> + * not all RIS in an MSC share a vMSC.
> + * Components are a group of vMSC that control or monitor the same thing but
> + * are from different MSC, so have different base-address, interrupts etc.
> + * Classes are the set components of the same type.
> + *
> + * The features of a vMSC is the union of the RIS it contains.
> + * The features of a Class and Component are the common subset of the vMSC
> + * they contain.
> + *
> + * e.g. The system cache may have bandwidth controls on multiple interfaces,
> + * for regulating traffic from devices independently of traffic from CPUs.
> + * If these are two RIS in one MSC, they will be treated as controlling
> + * different things, and will not share a vMSC/component/class.
> + *
> + * e.g. The L2 may have one MSC and two RIS, one for cache-controls another
> + * for bandwidth. These two RIS are members of the same vMSC.
> + *
> + * e.g. The set of RIS that make up the L2 are grouped as a component. These
> + * are sometimes termed slices. They should be configured the same, as if there
> + * were only one.
> + *
> + * e.g. The SoC probably has more than one L2, each attached to a distinct set
> + * of CPUs. All the L2 components are grouped as a class.
> + *
> + * When creating an MSC, struct mpam_msc is added to the all mpam_all_msc list,
> + * then linked via struct mpam_ris to a vmsc, component and class.
> + * The same MSC may exist under different class->component->vmsc paths, but the
> + * RIS index will be unique.
> + */

This description of the structures and how they relate to each other
seems OK (bearing in mind that I am already familiar with this stuff --
I can't speak for other people).

> +LIST_HEAD(mpam_classes);
> +
> +/* List of all objects that can be free()d after synchronise_srcu() */
> +static LLIST_HEAD(mpam_garbage);
> +
> +#define init_garbage(x)	init_llist_node(&(x)->garbage.llist)

[...]

> +#define add_to_garbage(x)				\
> +do {							\
> +	__typeof__(x) _x = x;				\

Nit:

= (x)

(for the paranoid)

> +	(_x)->garbage.to_free = (_x);			\

_x->garbage.to_free = _x;

(_x is an identifier, not a macro argument.  It can't get re-parsed as
something else -- assuming that there is not a #define for _x, but then
all bets would be off anyway.)

> +	llist_add(&(_x)->garbage.llist, &mpam_garbage);	\

&_x->...


[...]

> +static void mpam_ris_destroy(struct mpam_msc_ris *ris)
> +{
> +	struct mpam_vmsc *vmsc = ris->vmsc;
> +	struct mpam_msc *msc = vmsc->msc;
> +	struct platform_device *pdev = msc->pdev;
> +	struct mpam_component *comp = vmsc->comp;
> +	struct mpam_class *class = comp->class;
> +
> +	lockdep_assert_held(&mpam_list_lock);
> +
> +	cpumask_andnot(&comp->affinity, &comp->affinity, &ris->affinity);
> +	cpumask_andnot(&class->affinity, &class->affinity, &ris->affinity);

This is not the inverse of the cpumask_or()s in mpam_ris_create_locked(),
unless the the ris associated with each class and each component have
strictly disjoint affinity masks.  Is that checked anywhere, or should
it be impossible by construction?


But, thinking about it:

I wonder why we ever really need to do the teardown.  If we get an
error interrupt then we can just go into a sulk, spam dmesg a bit, put
the hardware into the most vanilla state that we can, and refuse to
manipulate it further.  But this only happens in the case of a software
or hardware *bug* (or, in a future world where we might implement
virtualisation, an uncontainable MPAM error triggered by a guest -- for
which tearing down the host MPAM would be an overreaction).

Trying to cleanly tear the MPAM driver down after such an error seems a
bit futile.

The MPAM resctrl glue could eventually be made into a module (though
not needed from day 1) -- which would allow for unloading resctrlfs if
that is eventually module-ised.  I think this wouldn't require the MPAM
devices backend to be torn down at any point, though (?)


If we can simplify or eliminate the teardown, does it simplify the
locking at all?  The garbage collection logic can also be dispensed
with if there is never any garbage.

Since MSCs etc. never disappear from the hardware, it feels like it
ought not to be necessary ever to remove items from any of these lists
except when trying to do a teardown (?)

(Putting the hardware into a quiecent state is not the same thing as
tearing down the data structures -- we do want to quiesce MPAM when
shutting down the kernel, as least for the kexec scenario.)

> +	clear_bit(ris->ris_idx, msc->ris_idxs);
> +	list_del_rcu(&ris->vmsc_list);
> +	list_del_rcu(&ris->msc_list);
> +	add_to_garbage(ris);
> +	ris->garbage.pdev = pdev;
> +
> +	if (list_empty(&vmsc->ris))
> +		mpam_vmsc_destroy(vmsc);
> +}

[...]

> +static int mpam_ris_create_locked(struct mpam_msc *msc, u8 ris_idx,
> +				  enum mpam_class_types type, u8 class_id,
> +				  int component_id, gfp_t gfp)
> +{
> +	int err;
> +	struct mpam_vmsc *vmsc;
> +	struct mpam_msc_ris *ris;
> +	struct mpam_class *class;
> +	struct mpam_component *comp;
> +
> +	lockdep_assert_held(&mpam_list_lock);
> +
> +	if (test_and_set_bit(ris_idx, msc->ris_idxs))
> +		return -EBUSY;

Is it impossible by construction to get in here with an out-of-range
ris_idx?

To avoid the callers (i.e., ACPI) needing to understand the internal
limitations of this code, maybe it is worth having a check here (even
if technically redundant).

[...]

Cheers
---Dave

