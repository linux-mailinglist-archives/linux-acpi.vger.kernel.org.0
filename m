Return-Path: <linux-acpi+bounces-20675-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cG6gF7vueGkCuAEAu9opvQ
	(envelope-from <linux-acpi+bounces-20675-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Jan 2026 17:58:35 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E1AB398151
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Jan 2026 17:58:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4FE483001320
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Jan 2026 16:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3186635FF41;
	Tue, 27 Jan 2026 16:58:33 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8C72BE034;
	Tue, 27 Jan 2026 16:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769533113; cv=none; b=obG0dY/BqGi0F1K0q9/xrKpDD5hrkmgYMQH0YNmzyejm8+FWcTf9fI2ZWiOjcquhwL3+EnlRTTgI1mzuJ3LAAwomVLK2NhHZZ7lridLGAMzzzd86X56sMbp4DbNOkTDE53NvqwkewsjQ+SGzNSyyDnLIThebRsKxnU6TDA+sYCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769533113; c=relaxed/simple;
	bh=xdbGX5OuXSqXPESzqj2vsm831HFui/rc4qwES/fLSrI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nP4Z74lq/vPNtxhEW7fwOBFKQHfxFt91CYH6Ou9yX5ze+ClT/fd97WXbnFlb6JGBov1FLswC5Zlih+/km9UUyrzijJRddLIKFkN4gfEfEBT35yD0yS1fHmzNX6Jd1yfnJUH1WAjYf/z4YE2duWa0esAe3dUQoPe1HeEyp+zTX1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4f0s5w6VpwzHnGkS;
	Wed, 28 Jan 2026 00:57:40 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id C830E40086;
	Wed, 28 Jan 2026 00:58:26 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 27 Jan
 2026 16:58:25 +0000
Date: Tue, 27 Jan 2026 16:58:24 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: Lifeng Zheng <zhenglifeng1@huawei.com>, <catalin.marinas@arm.com>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>, <gshan@redhat.com>, <miguel.luis@oracle.com>,
	<guohanjun@huawei.com>, <zhanjie9@hisilicon.com>, <lihuisong@huawei.com>,
	<yubowen8@huawei.com>, <zhangpengjie2@huawei.com>, <wangzhi12@huawei.com>,
	<linhongye@h-partners.com>, <salil.mehta@huawei.com>
Subject: Re: [PATCH] ACPI: processor: Add acpi_processor_start() back to
 parse _CPC tables before CPU online
Message-ID: <20260127165824.0000247f@huawei.com>
In-Reply-To: <CAJZ5v0hX839+J-MdKUwpRv0D9HSj-sbtMN0o-OOYatu9dU+bFQ@mail.gmail.com>
References: <20260120113242.3843463-1-zhenglifeng1@huawei.com>
	<CAJZ5v0hX839+J-MdKUwpRv0D9HSj-sbtMN0o-OOYatu9dU+bFQ@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml100010.china.huawei.com (7.191.174.197) To
 dubpeml500005.china.huawei.com (7.214.145.207)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[huawei.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-20675-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jonathan.cameron@huawei.com,linux-acpi@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,huawei.com:mid,huawei.com:email]
X-Rspamd-Queue-Id: E1AB398151
X-Rspamd-Action: no action

On Tue, 27 Jan 2026 15:42:16 +0100
"Rafael J. Wysocki" <rafael@kernel.org> wrote:

> On Tue, Jan 20, 2026 at 12:33=E2=80=AFPM Lifeng Zheng <zhenglifeng1@huawe=
i.com> wrote:
> >
> > Currently, if boot with maxcpus less than NR_CPUS, the cppc_cpufreq dri=
ver
> > will fail to register. Because it requires the domain information of all
> > possible CPUs to construct shared_cpu_map, which shows the CPUs that sh=
are
> > the same domain.
> >
> > Commit c1385c1f0ba3 ("ACPI: processor: Simplify initial onlining to use
> > same path for cold and hotplug") removes probe() of acpi_processor_driv=
er
> > and makes acpi_cppc_processor_probe() only being called the first time =
CPU
> > goes online. This means that CPUs that haven't yet gone online will not
> > have pre-parsed _CPC objects and causes cppc_cpufreq driver register fa=
il.
> >
> > Add acpi_processor_start() back as the probe() callback of
> > acpi_processor_driver and call acpi_cppc_processor_probe() in it to make
> > sure all _CPC tables will be parsed when acpi_processor_driver register=
ed.
> >
> > Fixes: c1385c1f0ba3 ("ACPI: processor: Simplify initial onlining to use=
 same path for cold and hotplug")
> > Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
> > ---
> >  drivers/acpi/processor_driver.c | 30 ++++++++++++++++++++++++++----
> >  1 file changed, 26 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor_d=
river.c
> > index 65e779be64ff..c8b4daf580b0 100644
> > --- a/drivers/acpi/processor_driver.c
> > +++ b/drivers/acpi/processor_driver.c
> > @@ -33,6 +33,7 @@ MODULE_AUTHOR("Paul Diefenbaugh");
> >  MODULE_DESCRIPTION("ACPI Processor Driver");
> >  MODULE_LICENSE("GPL");
> >
> > +static int acpi_processor_start(struct device *dev);
> >  static int acpi_processor_stop(struct device *dev);
> >
> >  static const struct acpi_device_id processor_device_ids[] =3D {
> > @@ -46,6 +47,7 @@ static struct device_driver acpi_processor_driver =3D=
 {
> >         .name =3D "processor",
> >         .bus =3D &cpu_subsys,
> >         .acpi_match_table =3D processor_device_ids,
> > +       .probe =3D acpi_processor_start,
> >         .remove =3D acpi_processor_stop,
> >  };
> >
> > @@ -162,10 +164,6 @@ static int __acpi_processor_start(struct acpi_devi=
ce *device)
> >         if (!pr)
> >                 return -ENODEV;
> >
> > -       result =3D acpi_cppc_processor_probe(pr);
> > -       if (result && !IS_ENABLED(CONFIG_ACPI_CPU_FREQ_PSS))
> > -               dev_dbg(&device->dev, "CPPC data invalid or not present=
\n");
> > -
> >         if (!cpuidle_get_driver() || cpuidle_get_driver() =3D=3D &acpi_=
idle_driver)
> >                 acpi_processor_power_init(pr);
> >
> > @@ -192,6 +190,30 @@ static int __acpi_processor_start(struct acpi_devi=
ce *device)
> >         return result;
> >  }
> >
> > +static int acpi_processor_start(struct device *dev)
> > +{
> > +       struct acpi_device *device =3D ACPI_COMPANION(dev);
> > +       struct acpi_processor *pr;
> > +       int result;
> > +
> > +       if (!device)
> > +               return -ENODEV;
> > +
> > +       pr =3D acpi_driver_data(device);
> > +       if (!pr)
> > +               return -ENODEV;
> > +
> > +       /* Protect against concurrent CPU hotplug operations */
> > +       cpu_hotplug_disable();
> > +       result =3D acpi_cppc_processor_probe(pr);
> > +       cpu_hotplug_enable(); =20
>=20
> This means that CPPC will be initialized for vCPUs that are not
> enabled on ARM if I'm not mistaken.

If we are just talking powered down at boot it used to do that
so I assume it was fine. The corner case is ones we are explicitly
saying are not onlineable yet but marked online capable and will
turn up later.

>=20
> I'm not sure if it is valid to do so.

The conclusion of the following is I think this is fine but I'm not
entirely confident about it.

I'm struggling to figure out the right answer to this and
it's not easy to test. I vaguely recall having some nasty emulation
hacks to poke some x86 related _CPC stuff a while back.
I might be able to hack something up for this as well and try to
create pathological corner cases.

The short answer is CPPC + hotplug isn't a thing today in KVM + QEMU,
but that's not to say it never will be if someone virtualizes CPC for
a guest.  Let's consider that hypothetical virtualization / emulation.

So the questions:
1) Does simply making this acpi_cppc_processor_probe() result in any
   register accesses to the registers that might be found in _CPC or
   used via other ACPI methods?
2) Can we rely on a a VMM not do something nasty if those are accessed
   on CPUs that haven't been instantiated yet?  e.g. Bus error.
   A related useful question is: Can we assume these registers are
   accessible on offlined CPUs?  If they can be unsafe to access from
   CPUs that are temporary powered down / offline then I think we are fine =
because
   the CPPC code must guarantee not to access them. (I'm relying on this!)

For the particular case Lifeng has run into, I think the code that matters
(beyond instantiation of the infrastructure) is the creation of the
domain info in acpi_get_psd(). I think _PSD can only be static data so
shouldn't cause any register accesses to the powered down CPUs.

So 'probably' fine + we'll not really know unless we get CPU HP and
CPC.

Alternative much more complex change would be to separate the grabbing of
static data (done here) from setting up anything dynamic which would remain
in the hotplug handler.  If those registers haven't been discovered we defi=
nitely
can't access them from the cpu freq driver.

Thanks,

Jonathan




>=20
> Jonathan?
>=20
> > +
> > +       if (result && !IS_ENABLED(CONFIG_ACPI_CPU_FREQ_PSS))
> > +               dev_dbg(&device->dev, "CPPC data invalid or not present=
\n");
> > +
> > +       return 0;
> > +}
> > +
> >  static int acpi_processor_stop(struct device *dev)
> >  {
> >         struct acpi_device *device =3D ACPI_COMPANION(dev);
> > --
> > 2.33.0
> >
> > =20
>=20


