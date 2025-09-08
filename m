Return-Path: <linux-acpi+bounces-16454-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B3BD7B49325
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Sep 2025 17:26:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4B0E7AFD9C
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Sep 2025 15:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27EE430E0D1;
	Mon,  8 Sep 2025 15:25:40 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A89EC30E0EE;
	Mon,  8 Sep 2025 15:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757345140; cv=none; b=HVEp66+mqY0XQYvnL4WnNH5mqsD1R/6QAsHNfD3aKdze51jTqpwFusgKSGcmzQfj7iWzBqzz0ZlMinFOWGp0qgA5eoHSSbEPZtY0fNfN4RGpH8wOs3JBrOr2qFRycqtK6Z0k0VpFbndDdhnYyoz2jOKyrF5WtXEuEu2XSo28588=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757345140; c=relaxed/simple;
	bh=JwhbZ11zDpzqPD4kZUwZpyJAjuRGlZPvwguGQTdk+F0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sbhC73PiLTXRnpLFLgraGO+Fer0Wp1jJXV2JVF6q7UlDyaSjJkMoeXMttVmrdT6iPkSN8u36x3DkhtUkdbhobz3g23ulGGY5qryVu8sFYk6wh5p9pwxAHKTIdws8R156R2BnIzkJfa4BvwlkYesUZPdd8Vso4s+BIGYwyPUiff4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8B0712D8E;
	Mon,  8 Sep 2025 08:25:28 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.68])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1D0153F740;
	Mon,  8 Sep 2025 08:25:30 -0700 (PDT)
Date: Mon, 8 Sep 2025 16:25:28 +0100
From: Dave Martin <Dave.Martin@arm.com>
To: James Morse <james.morse@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
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
	Danilo Krummrich <dakr@kernel.org>
Subject: Re: [PATCH 10/33] arm_mpam: Add probe/remove for mpam msc driver and
 kbuild boiler plate
Message-ID: <aL71aP3qyyfD+T47@e133380.arm.com>
References: <20250822153048.2287-1-james.morse@arm.com>
 <20250822153048.2287-11-james.morse@arm.com>
 <aLWBqNMKoTl9VDIS@e133380.arm.com>
 <8265943b-536f-47ce-af05-129edd417863@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8265943b-536f-47ce-af05-129edd417863@arm.com>

On Fri, Sep 05, 2025 at 07:49:37PM +0100, James Morse wrote:
> Hi Dave,
> 
> On 01/09/2025 12:21, Dave Martin wrote:
> > On Fri, Aug 22, 2025 at 03:29:51PM +0000, James Morse wrote:
> >> Probing MPAM is convoluted. MSCs that are integrated with a CPU may
> >> only be accessible from those CPUs, and they may not be online.
> >> Touching the hardware early is pointless as MPAM can't be used until
> >> the system-wide common values for num_partid and num_pmg have been
> >> discovered.
> >>
> >> Start with driver probe/remove and mapping the MSC.
> >> diff --git a/drivers/resctrl/Kconfig b/drivers/resctrl/Kconfig
> >> new file mode 100644
> >> index 000000000000..dff7b87280ab
> >> --- /dev/null
> >> +++ b/drivers/resctrl/Kconfig
> >> @@ -0,0 +1,11 @@
> >> +# Confusingly, this is everything but the CPU bits of MPAM. CPU here means
> >> +# CPU resources, not containers or cgroups etc.
> >
> > Drop confusing comment?
> >
> > CPUs are not mentioned other than in the comment -- I think the
> > descriptions are sufficiently self-explanatory that they don't read
> > onto CPUs.
> 
> This used to add ARM_CPU_RESCTRL, to mirror X86_CPU_RESCTRL.
> It's been tidied up since then, but the comment remains.
> I'll remove it.

OK

> >> +config ARM64_MPAM_DRIVER
> >> +	bool "MPAM driver for System IP, e,g. caches and memory controllers"
> >> +	depends on ARM64_MPAM && EXPERT
> >> +
> >> +config ARM64_MPAM_DRIVER_DEBUG
> >> +	bool "Enable debug messages from the MPAM driver."
> >
> > Nit: spurious full stop.
> >
> > (i.e., people don't add one in these one-line descriptions.
> > They are title-like and self-delimiting, even when the text is a valid
> > sentence.)
> 
> /me waves hands around

I did say "Nit" ;)  (This was mainly a "hmm, this doesn't look quite
like the rest" thing.)


> >> +	depends on ARM64_MPAM_DRIVER
> >> +	help
> >> +	  Say yes here to enable debug messages from the MPAM driver.
> 
> >> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
> >> new file mode 100644
> >> index 000000000000..a0d9a699a6e7
> >> --- /dev/null
> >> +++ b/drivers/resctrl/mpam_devices.c
> >> @@ -0,0 +1,336 @@
> 
> >> +/*
> >> + * mpam_list_lock protects the SRCU lists when writing. Once the
> >> + * mpam_enabled key is enabled these lists are read-only,
> >> + * unless the error interrupt disables the driver.
> >> + */
> >> +static DEFINE_MUTEX(mpam_list_lock);
> >> +static LIST_HEAD(mpam_all_msc);
> >> +
> >> +static struct srcu_struct mpam_srcu;
> >> +
> >> +/* MPAM isn't available until all the MSC have been probed. */
> >
> > Comment doesn't really explain the variable.
> >
> > Maybe something like "Number of MSCs that need to be probed for MPAM
> > to be usable" ?
> 
> Its the count not the remainder. I went with:
> | * Number of MSCs that have been probed. Once all MSC have been probed MPAM
> | * can be enabled.

Thanks, that's clearer.

> >> +static u32 mpam_num_msc;
> >
> > Any particular reason this is u32 and not unsigned int?
> u32 is less typing!

But more effort for the reader / reviewer -- it's semantic noise.

(It works either way though, obviosly.  It looks like this code may
have caught fixed-size-itis off the resctrl code, to some degree.)


> > How are accesses to this protected against data races?
> 
> It's under the list-lock, but after Rob's feedback I've made it an atomic_t and stopped
> using it as an id for all the print messages.

Converting to atomic_t reduces the chance of people asking the
question, but doesn't really answer the question.

Since mpam_num_msc shadows the contents of the lists and msc data
structures, it may matter whether the two can be seen out of sync.

Does it definitely not matter?

> > If there are supposed to be locks to protect globals in the MPAM driver,
> > is it worth wrapping them in access functions with a lockdep assert?
> > Otherwise, it feels rather easy to get this wrong -- I think I've found
> > at least one bug (see mpam_msc_drv_probe().)
> Broadly: everything is protected by the list_lock when things are being discovered.
> Once everything has been discovered, these things can become read-only.
> 
> It's not until everything has been discovered that interrupts get registered, and things
> like a potential PMU driver could make calls in a strange context.
> 
> Adding helpers would need some global state variable, if (state == foo) lockdep_assert...
> I had that early on, but figured it was overkill.

I wonder whether it would be worth migrating this, so that the probe-
time variables (which are read-write) can be kept separate from the
run-time system description variables (which are mostly write-once).

This would avoid having to support two different locking scenarios with
a single mechanism.


I have a bit of a concern that there are too many synchronisation
mechanisms in use, with purposes that overlap and are in some cases
not clealy described and not obvious -- at least, not to me.

I don't think the fact that there have been few comments on this area
necessarily indicates that other reviewers have fully understood the
locking.

> >> +static void mpam_discovery_complete(void)
> >> +{
> >> +	pr_err("Discovered all MSC\n");
> >> +}
> 
> > As others have commented, if this is non-functional code that gets
> > removed later on, it's probably best to drop this up-front?
> It's illustrating that something happens after all the MSC have been discovered.
> Knowing that from the beginning of the series is supposed to make the insertion of the
> cpuhp notifiers in the middle easier to think about...

So long as this was not unintentionally left behind when splitting the
series, I guess it's OK to have it here -- as you say, it does motivate
the shape that the code will eventually need to have.

> >> +static int mpam_dt_parse_resource(struct mpam_msc *msc, struct device_node *np,
> >> +				  u32 ris_idx)
> >> +{
> >> +	int err = 0;
> >> +	u32 level = 0;
> >> +	unsigned long cache_id;
> >> +	struct device_node *cache;
> >> +
> >> +	do {
> >> +		if (of_device_is_compatible(np, "arm,mpam-cache")) {
> >> +			cache = of_parse_phandle(np, "arm,mpam-device", 0);
> >> +			if (!cache) {
> >> +				pr_err("Failed to read phandle\n");
> >> +				break;
> >> +			}
> >> +		} else if (of_device_is_compatible(np->parent, "cache")) {
> >> +			cache = of_node_get(np->parent);
> >> +		} else {
> >> +			/* For now, only caches are supported */
> >> +			cache = NULL;
> >> +			break;
> >> +		}
> >> +
> >> +		err = of_property_read_u32(cache, "cache-level", &level);
> >> +		if (err) {
> >> +			pr_err("Failed to read cache-level\n");
> >> +			break;
> >> +		}
> >> +
> >> +		cache_id = cache_of_calculate_id(cache);
> >> +		if (cache_id == ~0UL) {
> >
> > The type of cache_id may change if the return type of
> > cache_of_calculate_id() changes (see comments on patch 1).
> 
> Yup,
> 
> > Possible #define for the exceptional value.
> 
> I don't think its any more surprising than '-1' as an error value, and its only got one
> caller, which is pretty obviously an error path.

A #define is not essential.  (As I say elsewhere, I don't entirely
trust uses of ~ where the types may be mixed.  But this case look low-
isk for future maintenance.)

> >> +			err = -ENOENT;
> >> +			break;
> >
> > The lack of a diagnostic here is inconsistent with the level of
> > diagnostics in the rest of the loop.
> 
> I've never needed to debug that one because its already visible to user-space. If the
> cache-id's are missing, you can tell that in sysfs, you don't need to instrument the kernel.
> 
> I'll add one if you think its important. They can all be _once, and as its related to
> the probing of a particular device, can use the dev_ print helpers.

No, I guess that's fine.  I don't have a strong feel for which things a
user is likely to have to debug in practice, and I accept that we
shouldn't try to cover absolutely everything.

> >> +		}
> >> +
> >> +		err = mpam_ris_create(msc, ris_idx, MPAM_CLASS_CACHE, level,
> >> +				      cache_id);
> >> +	} while (0);
> >
> > Abuse of do ... while () here?
> >
> > There is no loop.  The breaks are stealth "goto"s to this statement:
> Yes. The alternative would be actual gotos - which is surely worse!
> It just wasn't worth pulling this out as a separate function.

Again, it's semantic noise.  do ... while is a looping construct.
If you write "do {", the reader expects a loop and has to analyse the
code in order to conclude that there isn't.

Using a loop in order to avoid giving a label to the sequence point at
the closing bracket is a neat trick, but it's not helpful to someone
reading the code.  I can live with it, but as an idiom this seems rare.

Use of gotos for doing cleanup seems to be the most common idiom for
this in the kernel.  It may be inelegant, but it is likely to be readily
understood.  However...

> 
> 
> >> +	of_node_put(cache);
> >
> > (It works either way, but maybe gotos to an explicit label would be
> > more readable, as well as avoiding an unnecessary level of indentation.)
> As the cleanup magic has become fashionable, I'll switch to using that...

...I guess that works, too.

(Not that I much like that clunky bolt-on extension to the language,
but it should do the job and at least avoids arguments about precisely
how or where the cleanup happens.)

> >> +
> >> +	return err;
> >> +}
> >
> > [...]
> >
> >> +/*
> >> + * An MSC can control traffic from a set of CPUs, but may only be accessible
> >> + * from a (hopefully wider) set of CPUs. The common reason for this is power
> >> + * management. If all the CPUs in a cluster are in PSCI:CPU_SUSPEND, the
> >> + * the corresponding cache may also be powered off. By making accesses from
> >
> > Nit: the the
> 
> Fixed,
> 
> 
> >> + * one of those CPUs, we ensure this isn't the case.
> >> + */
> 
> >> +static int fw_num_msc;
> >
> > Does this need to be protected against data races?
> >
> > If individual mpam_msc_drv_probe() calls may execute on different CPUs
> > from mpam_msc_driver_init(), then seem to be potential races here.
> 
> Incrementing was under the list-lock, but not the last 'are they all done' read. Following
> Rob's comments I've made this an atomic_t.

As with mpam_num_msc, this eliminates data races on fw_num_msc, but
races between this variable and other data structures may remain.

Can you explain what prevents such races, or why they don't
matter?

> 
> 
> >> +
> >> +static void mpam_pcc_rx_callback(struct mbox_client *cl, void *msg)
> >> +{
> >> +	/* TODO: wake up tasks blocked on this MSC's PCC channel */
> >
> > So, is this broken in this commit?>
> > (If the series does not get broken up or applied piecemail, that's not
> > such a concern, though.)
> Unsupported - or at least only enough to not mistake them for MMIO devices.
> I've pulled this out to a later patch in the tree that isn't in this series.
> 
> The platforms that need this haven't yet materialised, (and may not!).
> There is a prototype for DT/SCMI, but nothing I've seen yet for ACPI.

OK; I guess deferring the introduction of this until there is more
context for it makes sense.

> >> +}
> >> +
> >> +static void mpam_msc_drv_remove(struct platform_device *pdev)
> >> +{
> >
> > The MPAM driver cannot currently be built as a module.
> >
> > Is it possible to exercise the driver remove paths, today?
> Yes, through the sysfs unbind interface.
> 
> It doesn't make a lot of sense for MPAM as the moment you unbind the driver from one MSC
> it has to work out if it needs to teardown resctrl...

Has to, but doesn't?  Have I missed something?

Are we supposed to put the MSC back into a sane state, for e.g. the
kexec path?

For resctrl, one option would be to stub out the backend -- i.e.,
we don't tell resctrl that the affected resources disappeared, but
attempts to manipulate the affected MSC(s) are stubbed out (similarly
to what happens to an open tty after a hangup).

(Something along these lines may be done somewhere, but I'm not
currently aware of it.)


Is there an outstanding get on the device that prevents us from getting
here until resctrl is shut down?  Thanks to the wisdom and restraint of
systemd I'd expect resctrl to tangled up in some rat's nest of
unremovable mounts by the time we try to shut down, but I hope I'm
being pessimistic.  (Arguably that's not our bug, if so.)

> >> +	struct mpam_msc *msc = platform_get_drvdata(pdev);
> >> +
> >> +	if (!msc)
> >> +		return;
> >> +
> >> +	mutex_lock(&mpam_list_lock);
> >> +	mpam_num_msc--;
> >> +	platform_set_drvdata(pdev, NULL);
> >> +	list_del_rcu(&msc->glbl_list);
> >> +	synchronize_srcu(&mpam_srcu);
> >> +	devm_kfree(&pdev->dev, msc);
> >> +	mutex_unlock(&mpam_list_lock);
> >> +}
> >> +
> >> +static int mpam_msc_drv_probe(struct platform_device *pdev)
> >> +{
> >> +	int err;
> >> +	struct mpam_msc *msc;
> >> +	struct resource *msc_res;
> >> +	void *plat_data = pdev->dev.platform_data;
> >> +
> >> +	mutex_lock(&mpam_list_lock);
> >> +	do {
> >> +		msc = devm_kzalloc(&pdev->dev, sizeof(*msc), GFP_KERNEL);
> >> +		if (!msc) {
> >> +			err = -ENOMEM;
> >> +			break;
> >> +		}
> >> +
> >> +		mutex_init(&msc->probe_lock);
> >> +		mutex_init(&msc->part_sel_lock);
> >> +		mutex_init(&msc->outer_mon_sel_lock);
> >> +		raw_spin_lock_init(&msc->inner_mon_sel_lock);
> >> +		msc->id = mpam_num_msc++;
> >> +		msc->pdev = pdev;
> >> +		INIT_LIST_HEAD_RCU(&msc->glbl_list);

msc->glbl_list is not a list head?  Does it need to be initialised at all?
list_add_rcu() will just splat it, by the looks of it.

> >> +		INIT_LIST_HEAD_RCU(&msc->ris);

Maybe INIT_LIST_HEAD_RCU() isn't needed here.  Do we ever access this
list without holding one of the MSC locks?

This list is not used until a cpuhp hook comes in to probe the MSC, and
then mpam_discovery_cpu_online() obtains a pointer via
list_for_each_entry() -- but this is not RCU-protected.  The MSC probe
lock is taken, there...

> >> +
> >> +		err = update_msc_accessibility(msc);
> >> +		if (err)
> >> +			break;
> >> +		if (cpumask_empty(&msc->accessibility)) {
> >> +			pr_err_once("msc:%u is not accessible from any CPU!",
> >> +				    msc->id);
> >> +			err = -EINVAL;
> >> +			break;
> >> +		}
> >> +
> >> +		if (device_property_read_u32(&pdev->dev, "pcc-channel",
> >> +					     &msc->pcc_subspace_id))
> >> +			msc->iface = MPAM_IFACE_MMIO;
> >> +		else
> >> +			msc->iface = MPAM_IFACE_PCC;
> >> +
> >> +		if (msc->iface == MPAM_IFACE_MMIO) {
> >> +			void __iomem *io;
> >> +
> >> +			io = devm_platform_get_and_ioremap_resource(pdev, 0,
> >> +								    &msc_res);
> >> +			if (IS_ERR(io)) {
> >> +				pr_err("Failed to map MSC base address\n");
> >> +				err = PTR_ERR(io);
> >> +				break;
> >> +			}
> >> +			msc->mapped_hwpage_sz = msc_res->end - msc_res->start;
> >> +			msc->mapped_hwpage = io;
> >> +		} else if (msc->iface == MPAM_IFACE_PCC) {
> >> +			msc->pcc_cl.dev = &pdev->dev;
> >> +			msc->pcc_cl.rx_callback = mpam_pcc_rx_callback;
> >> +			msc->pcc_cl.tx_block = false;
> >> +			msc->pcc_cl.tx_tout = 1000; /* 1s */
> >> +			msc->pcc_cl.knows_txdone = false;

... so, it feels like we may need to hold the probe lock, or ensure
that all iterations over the msc list are RCU-protected (see below for
counterexamples), or both.

> >> +
> >> +			msc->pcc_chan = pcc_mbox_request_channel(&msc->pcc_cl,
> >> +								 msc->pcc_subspace_id);
> >> +			if (IS_ERR(msc->pcc_chan)) {
> >> +				pr_err("Failed to request MSC PCC channel\n");
> >> +				err = PTR_ERR(msc->pcc_chan);
> >> +				break;
> >> +			}
> >> +		}
> 
> > Should the lock be held across initialisation of the msc fields?
> 
> The msc isn't visible until its added to the list, so provided all that inialisation is
> done 'before' its added to the list, it doesn't matter.

Is it possible for other code to get a pointer to the new msc after
this, other than by dereferencing the list?

(The obvious case is the interrupt handlers, but it looks like the msc
pointers used for registering the interrupts are indeed obtained
through an RCU-protected iteration over mpam_all_msc.)

Note, there seem to be non-RCU-protected iterations over mpam_all_msc
in the mpam_discovery_cpu_online() (patch 14) and
mpam_enable_merge_features() paths (patch 18).  The lack of symmetry
between list maintenance and consumption look a little suspect for
those -- is safety ensured in some other way?

> > list_add_rcu() might imply sufficient barriers to ensure that the
> > initialisations are visible to other threads that obtain the msc
> > pointer by iterating over mpam_all_msc.
> >
> > It's probably cleaner to hold the lock explicitly, though.
> 
> The list lock? We do.
> But the readers don't need to take the list lock, its only there to prevent concurrent
> writers.

I meant whatever lock is supposed to protect the fields of the specific
msc.  The list lock is not that lock.

> 
> 
> > What other ways of obtaining the msc pointer exist?
> The class/component/device structures in a subsequent patch, protected in the same way.
> Once MPAM is enabled all that can be sprayed through resctrl - at which point no
> modifications are allowed, and teardown for fatal errors depends on the static-key.

I'll bear this in mind as I review.

> >> +
> >> +		list_add_rcu(&msc->glbl_list, &mpam_all_msc);
> >> +		platform_set_drvdata(pdev, msc);
> >> +	} while (0);
> >> +	mutex_unlock(&mpam_list_lock);
> >> +
> >> +	if (!err) {
> >> +		/* Create RIS entries described by firmware */
> >> +		if (!acpi_disabled)
> >> +			err = acpi_mpam_parse_resources(msc, plat_data);
> >> +		else
> >> +			err = mpam_dt_parse_resources(msc, plat_data);
> >> +	}
> >> +
> >> +	if (!err && fw_num_msc == mpam_num_msc)
> 
> > Unlocked read of mpam_num_msc?
> Fixed as an atomic_t flavoured thing.

Ditto comments above about whether it is a problem that mpam_num_msc
can now be seen out of sync with the list.

> >> +		mpam_discovery_complete();
> >> +
> >> +	if (err && msc)
> >> +		mpam_msc_drv_remove(pdev);
> >> +
> >> +	return err;
> >> +}
> >> +/*
> >> + * MSC that are hidden under caches are not created as platform devices
> >> + * as there is no cache driver. Caches are also special-cased in
> >> + * update_msc_accessibility().
> >> + */
> >
> > Can you elaborate?  I don't understand quite what this is doing.
> 
> / {
>     my_thing {
>         compatible = "my_thing";
>         msc {
>            compatible = "arm,mpam-msc";
>         };
>     };
> 
>     other_thing {
>         compatible = "other_thing";
>     };
> 
>     msc {
>        compatible = "arm,mpam-msc";
>        arm,mpam-device = <&other_thing>;
>     };
> 
> 
>     l2-cache {
>       compatible = "cache";
>         msc {
>            compatible = "arm,mpam-msc";
>         };
>     };
> };
> 
> my_thing and other_thing's MSC will have devices created - but the cache will not, because
> it's a cache not a device, and anything below it is ignored.

OK.  Maybe reword as something like:

--8<--

MSCs that are declared by the firmware as being part of a cache may not
be created automatically as platform devices, since there is no
dedicated cache driver.

Deal with those MSCs here.

-->8--

Maybe add a comment at update_msc_accessibility() that references this
comment, instead of a reader of that function just needing to know that
this comment is here?

> 
> 
> >> +static void mpam_dt_create_foundling_msc(void)
> >> +{
> >> +	int err;
> >> +	struct device_node *cache;
> >> +
> >> +	for_each_compatible_node(cache, NULL, "cache") {
> >> +		err = of_platform_populate(cache, mpam_of_match, NULL, NULL);
> >> +		if (err)
> >> +			pr_err("Failed to create MSC devices under caches\n");
> >> +	}
> >> +}
> >
> > [...]
> >
> >> diff --git a/drivers/resctrl/mpam_internal.h b/drivers/resctrl/mpam_internal.h
> >> new file mode 100644
> >> index 000000000000..07e0f240eaca
> >> --- /dev/null
> >> +++ b/drivers/resctrl/mpam_internal.h
> >> @@ -0,0 +1,62 @@
> >> +/* SPDX-License-Identifier: GPL-2.0 */
> >> +// Copyright (C) 2024 Arm Ltd.
> >> +
> >> +#ifndef MPAM_INTERNAL_H
> >> +#define MPAM_INTERNAL_H
> >> +
> >> +#include <linux/arm_mpam.h>
> >> +#include <linux/cpumask.h>
> >> +#include <linux/io.h>
> >> +#include <linux/mailbox_client.h>
> >> +#include <linux/mutex.h>
> >> +#include <linux/resctrl.h>
> >> +#include <linux/sizes.h>
> >> +
> >> +struct mpam_msc {
> >> +	/* member of mpam_all_msc */
> >> +	struct list_head        glbl_list;
> 
> > It is worth making these names less mismatched?
> 
> all_msc_list ?
> 
> It's because its global. The pattern otherwise is parent has a list foo, and all the
> children have a member 'foo_list'.

"all_msc", then?

I'm not sure that it's essential for the list head's name to have
"list" in it: that's clear from the type and from how it is used.
"all" seems sufficient to imply that this is a list (?)

It doesn't get much more global than "all".

(This is purely cosmetic, of course.)

> 
> 
> >> +
> >> +	int			id;
> >> +	struct platform_device *pdev;
> >> +
> >> +	/* Not modified after mpam_is_enabled() becomes true */
> >> +	enum mpam_msc_iface	iface;
> >> +	u32			pcc_subspace_id;
> >> +	struct mbox_client	pcc_cl;
> >> +	struct pcc_mbox_chan	*pcc_chan;
> >> +	u32			nrdy_usec;
> >> +	cpumask_t		accessibility;
> >> +
> >> +	/*
> >> +	 * probe_lock is only take during discovery. After discovery these
> >> +	 * properties become read-only and the lists are protected by SRCU.
> >> +	 */
> >> +	struct mutex		probe_lock;
> >
> > Can we have more clarify about the locking strategy, including details
> > of which things each lock is supposed to apply to and when, and how (if
> > at all) the locks are intended to nest?
> 
> The comment above is supposed to describe that. A rule of thumb is its all the stuff
> 'below' it in the struct, there is also a comment for each order. This one is a bit of a
> catch all for the values in this struct that can be written.

I get that, but the devil is in the detail.

A lock that is "a bit of a catch-all" would always need to be taken,
if safety is the goal.

I guess we should try to close out the other discussions about locking
before working out whether anything else is needed, here.

> The purpose of the part_sel_lock and mon_sel_lock arrangement becomes much more obvious in
> subsequent patches when the driver starts accessing the registers of those names.

It's fair enough to defer that context until later -- though arguably
these could be added later when they are actually used.  Not really
worth resplitting the series just for that, though.

> 
> 
> > (Similarly for the global locks.)
> >
> >> +	unsigned long		ris_idxs[128 / BITS_PER_LONG];
> >> +	u32			ris_max;
> 
> > nrdy_usec, ris_idxs and ris_max appear unused in this patch (though I
> > suppose they get initialised by virtue of kzalloc()).  Is this
> > intentional?
> 
> To reduce the amount of churn in the series the bulk of the structure is added here, then
> the stuff that build more complicated structures, accesses hardware, deals with interrupts
> etc.

Ack, just checking that something wasn't unintentionally dropped.

> >> +
> >> +	/* mpam_msc_ris of this component */
> >> +	struct list_head	ris;
> >> +
> >> +	/*
> >> +	 * part_sel_lock protects access to the MSC hardware registers that are
> >> +	 * affected by MPAMCFG_PART_SEL. (including the ID registers that vary
> >> +	 * by RIS).
> >> +	 * If needed, take msc->lock first.
> >> +	 */
> 
> > What's msc->lock ?
> 
> The old name for probe_lock, before it was necessary to lock the hardware registers
> separately. I've fixed the name.
> 
> Thanks,
> 
> James

Ack

Cheers
---Dave
> 
> 

