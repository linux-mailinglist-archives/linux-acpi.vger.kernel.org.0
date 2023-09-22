Return-Path: <linux-acpi+bounces-53-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98D117AAF87
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Sep 2023 12:32:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 55B57281074
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Sep 2023 10:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37F68803
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Sep 2023 10:32:28 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C647171B9
	for <linux-acpi@vger.kernel.org>; Fri, 22 Sep 2023 10:20:11 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E2BCA9;
	Fri, 22 Sep 2023 03:20:08 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RsSnZ4kGqz67nNy;
	Fri, 22 Sep 2023 18:15:14 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Fri, 22 Sep
 2023 11:20:06 +0100
Date: Fri, 22 Sep 2023 11:20:05 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Jiaqi Yan <jiaqiyan@google.com>, <linuxarm@huawei.com>
CC: <shiju.jose@huawei.com>, "Luck, Tony" <tony.luck@intel.com>,
	<dave.hansen@linux.intel.com>, <jon.grimm@amd.com>,
	<vilas.sridharan@amd.com>, David Rientjes <rientjes@google.com>,
	<linux-acpi@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <rafael@kernel.org>, <lenb@kernel.org>,
	<naoya.horiguchi@nec.com>, <james.morse@arm.com>, <david@redhat.com>,
	<jthoughton@google.com>, <somasundaram.a@hpe.com>, <erdemaktas@google.com>,
	<pgonda@google.com>, <duenwen@google.com>, <mike.malvestuto@intel.com>,
	<gthelen@google.com>, <jonathan.cameron@huawei.com>, <tanxiaofei@huawei.com>,
	<prime.zeng@hisilicon.com>
Subject: Re: [RFC PATCH 2/9] memory: scrub: sysfs: Add Documentation entries
 for set of scrub attributes
Message-ID: <20230922111740.000046d7@huawei.com>
In-Reply-To: <CACw3F50jRzJnr9h7qYyD3t+6h7Uw9QMfkCkgu7a=7Lv0Tpi8Zg@mail.gmail.com>
References: <20230915172818.761-1-shiju.jose@huawei.com>
	<20230915172818.761-3-shiju.jose@huawei.com>
	<CACw3F50jRzJnr9h7qYyD3t+6h7Uw9QMfkCkgu7a=7Lv0Tpi8Zg@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, 21 Sep 2023 17:07:04 -0700
Jiaqi Yan <jiaqiyan@google.com> wrote:

> On Fri, Sep 15, 2023 at 10:29=E2=80=AFAM <shiju.jose@huawei.com> wrote:
> >
> > From: Shiju Jose <shiju.jose@huawei.com>
> >
> > Add sysfs documentation entries for the set of attributes those are
> > exposed in /sys/class/scrub/ by the scrub driver. These attributes
> > support configuring parameters of a scrub device.
> >
> > Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> > ---
> >  .../ABI/testing/sysfs-class-scrub-configure   | 82 +++++++++++++++++++
> >  1 file changed, 82 insertions(+)
> >  create mode 100644 Documentation/ABI/testing/sysfs-class-scrub-configu=
re
> >
> > diff --git a/Documentation/ABI/testing/sysfs-class-scrub-configure b/Do=
cumentation/ABI/testing/sysfs-class-scrub-configure
> > new file mode 100644
> > index 000000000000..347e2167dc62
> > --- /dev/null
> > +++ b/Documentation/ABI/testing/sysfs-class-scrub-configure
> > @@ -0,0 +1,82 @@
> > +What:          /sys/class/scrub/
> > +Date:          September 2023
> > +KernelVersion: 6.7
> > +Contact:       linux-kernel@vger.kernel.org
> > +Description:
> > +               The scrub/ class subdirectory belongs to the
> > +               scrubber subsystem.
> > +
> > +What:          /sys/class/scrub/scrubX/
> > +Date:          September 2023
> > +KernelVersion: 6.7
> > +Contact:       linux-kernel@vger.kernel.org
> > +Description:
> > +               The /sys/class/scrub/scrub{0,1,2,3,...} directories =20
>=20
> This API (sysfs interface) is very specific to the ACPI interface
> defined for hardware patrol scrubber. I wonder can we have some
> interface that is more generic, for a couple of reasons:

Agreed that it makes sense to define a broad interface.  We have
some hardware focused drivers we can't share yet (IP rules until
a release date in the near future) where this is a reasonable fit
- but indeed there are others such as mapping this to DDR ECS
where it isn't a great mapping.

I'd love to come up with an interface that has the right blend
of generality and flexibility.  That is easiest done before we have
any implementation merged.

>=20
> 1. I am not aware of any chip/platform hardware that implemented the
> hw ps part defined in ACPI RASF/RAS2 spec. So I am curious what the
> RAS experts from different hardware vendors think about this. For
> example, Tony and Dave from Intel, Jon and Vilas from AMD. Is there
> any hardware platform (if allowed to disclose) that implemented ACPI
> RASF/RAS2? If so, will vendors continue to support the control of
> patrol scrubber using the ACPI spec? If not (as Tony said in [1], will
> the vendor consider starting some future platform?
>=20
> If we are unlikely to get the vendor support, creating this ACPI
> specific sysfs API (and the driver implementations) in Linux seems to
> have limited meaning.

There is a bit of a chicken and egg problem here. Until there is=20
reasonable support in kernel (or it looks like there will be),
BIOS teams push back on a requirement to add the tables.
I'd encourage no one to bother with RASF - RAS2 is much less
ambiguous.

>=20
> > +               correspond to each scrub device.
> > +
> > +What:          /sys/class/scrub/scrubX/name
> > +Date:          September 2023
> > +KernelVersion: 6.7
> > +Contact:       linux-kernel@vger.kernel.org
> > +Description:
> > +               (RO) name of the memory scrub device
> > +
> > +What:          /sys/class/scrub/scrubX/regionY/ =20
>=20
> 2. I believe the concept of "region" here is probably from
> PATROL_SCRUB defined in =E2=80=9CAPCI section 5.2.20.5. Parameter Block".=
 It
> is indeed powerful: if a process's physical memory spans over multiple
> memory controllers, OS can in theory scrub chunks of the memory
> belonging to the process. However, from a previous discussion [1],
> "From a h/w perspective it might always be complex". IIUC, the address
> translation from physical address to channel address is hard to
> achieve, and probably that's one of the tech reasons the patrol scrub
> ACPI spec is not in practice implemented?

Next bit is kind of an aside as I mostly agree with your conclusions ;)

This obviously depends on your memory interleave. You want to present
physical address ranges as single controllable regions - probably
most interesting being stuff that maps to NUMA nodes.  The short
answer is that any firmware control will end up writing to all the
memory controllers involved in a given PA range - firmware can easily
establish which those are.

A memory controller can support multiple scrub regions
which map from a PA range to a particular set of RAM addresses
- that's implementation specific. The memory controller is getting
the host PA and can carry out appropriate hashing if it wants to.
Many scrub solutions won't do this - in which case it's max one
region per memory controller (mapped by firmware to one region per
interleave set - assuming interleave sets take in whole memory
controllers - which they normally do).

I would expect existing systems (not design with this differentiated
scrub in mind) to only support scrub control by PA range at the
granularity of interleave sets.

Note that this general question of PA based controls also
maps to things like resource control (resctl) where it's only interesting
to partition memory bandwidth such that the partition applies to the
whole interleave set - that's done for ARM systems anyway by having
the userspace interface pretend there is only one control, but
write the settings to all actual controllers involved. Not sure what
x86 does.

Taking a few examples that I know of.  All 4 socket server - with
control of these as bios options ;).
Assuming individual memory controllers don't allow scrub to be
configured by PA range.

1. Full system memory interleave (people do this form of crazy)
   In that case, there is only one set of firmware controls
   that write to the interfaces of every memory controller.  Depending
   on the interleave design that may still allow multiple regions.
 =20
2. Socket wide memory interleave.  In that case, firmware controls
   need to effect all memory controllers in that socket if the
   requested 'region' maps to them.  So 4 PA regions.=20

3. Die wide memory interleave.  Finer granularity of control
   so perhaps 8 PA rgiones.

4. Finer granularity (there are reasons to do this for above mentioned
   bandwidth resource control which you can only do if not interleaving
   across multiple controllers).



>=20
> So my take is, control at the granularity of the memory controller is
> probably a nice compromise.=20
> Both OS and userspace can get a pretty
> decent amount of flexibility, start/stop/adjust speed of the scrubbing
> on a memory controller; meanwhile it doesn't impose too much pain to
> hardware vendors when they provide these features in hardware. In
> terms of how these controls/features will be implemented, I imagine it
> could be implemented:
> * via hardware registers that directly or indirectly control on memory
> controllers
> * via ACPI if the situation changes in 10 years (and the RASF/RAS2/PCC
> drivers implemented in this patchset can be directly plugged into)
> * a kernel-thread that uses cpu read to detect memory errors, if
> hardware support is unavailable or not good enough
>=20

I more or less agree, but would tweak a little.

1) Allow for multiple regions per memory controller - that's needed
   for RASF etc anyway - because as far as they are concerned there
   is only one interface presented.
2) Tie the interface to interleave sets, not memory controllers.
   NUMA nodes often being a good stand in for those.
   Controlling memory controllers separately for parts of an interleave
   isn't something I'd think was very useful.  This will probably get
   messy in the future though and the complexity could be pushed to
   a userspace tool - as long as enough info is available elsewhere
   in sysfs.  So need those memory controller directories you propose
   to include info on the PA ranges that they are involved in backing
   (which to keep things horrible, can change at runtime via memory
    hotplug and remapping of host physical address ranges on CXL etc)

> Given these possible backends of scrubbing, I think a more generic
> sysfs API that covers and abstracts these backends will be more
> valuable right now. I haven=E2=80=99t thought thoroughly, but how about
> defining the top-level interface as something like
> =E2=80=9C/sys/devices/system/memory_controller_scrubX/=E2=80=9D, or
> =E2=80=9C/sys/class/memory_controllerX/scrub=E2=80=9D?

No particular harm in the rename of the directory I guess.
Though some of those 'memory_controllers' would be virtual as they
wouldn't correspond to actual memory controllers but rather to
sets of them.

Jonathan

>=20
> [1] https://lore.kernel.org/linux-mm/SJ1PR11MB6083BF93E9A88E659CED5EC4FC3=
F9@SJ1PR11MB6083.namprd11.prod.outlook.com/T/#m13516ee35caa05b506080ae805be=
e14f9f958d43

>=20
> > +Date:          September 2023
> > +KernelVersion: 6.7
> > +Contact:       linux-kernel@vger.kernel.org
> > +Description:
> > +               The /sys/class/scrub/scrubX/region{0,1,2,3,...}
> > +               directories correspond to each scrub region under a scr=
ub device.
> > +               Scrub region is a physical address range for which scru=
b may be
> > +               separately controlled. Regions may overlap in which cas=
e the
> > +               scrubbing rate of the overlapped memory will be at leas=
t that
> > +               expected due to each overlapping region.
> > +
> > +What:          /sys/class/scrub/scrubX/regionY/addr_base
> > +Date:          September 2023
> > +KernelVersion: 6.7
> > +Contact:       linux-kernel@vger.kernel.org
> > +Description:
> > +               (RW) The base of the address range of the memory region
> > +               to be patrol scrubbed.
> > +               On reading, returns the base of the memory region for
> > +               the actual address range(The platform calculates
> > +               the nearest patrol scrub boundary address from where
> > +               it can start scrubbing).
> > +
> > +What:          /sys/class/scrub/scrubX/regionY/addr_size
> > +Date:          September 2023
> > +KernelVersion: 6.7
> > +Contact:       linux-kernel@vger.kernel.org
> > +Description:
> > +               (RW) The size of the address range to be patrol scrubbe=
d.
> > +               On reading, returns the size of the memory region for
> > +               the actual address range.
> > +
> > +What:          /sys/class/scrub/scrubX/regionY/enable
> > +Date:          September 2023
> > +KernelVersion: 6.7
> > +Contact:       linux-kernel@vger.kernel.org
> > +Description:
> > +               (WO) Start/Stop scrubbing the memory region.
> > +               1 - enable the memory scrubbing.
> > +               0 - disable the memory scrubbing..
> > +
> > +What:          /sys/class/scrub/scrubX/regionY/speed_available
> > +Date:          September 2023
> > +KernelVersion: 6.7
> > +Contact:       linux-kernel@vger.kernel.org
> > +Description:
> > +               (RO) Supported range for the partol speed(scrub rate)
> > +               by the scrubber for a memory region.
> > +               The unit of the scrub rate vary depends on the scrubber.
> > +
> > +What:          /sys/class/scrub/scrubX/regionY/speed
> > +Date:          September 2023
> > +KernelVersion: 6.7
> > +Contact:       linux-kernel@vger.kernel.org
> > +Description:
> > +               (RW) The partol speed(scrub rate) on the memory region =
specified and
> > +               it must be with in the supported range by the scrubber.
> > +               The unit of the scrub rate vary depends on the scrubber.
> > --
> > 2.34.1
> >
> > =20
>=20


