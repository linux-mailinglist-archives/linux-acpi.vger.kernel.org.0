Return-Path: <linux-acpi+bounces-20679-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kCytBGr9eGmOuQEAu9opvQ
	(envelope-from <linux-acpi+bounces-20679-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Jan 2026 19:01:14 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E9E298BA5
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Jan 2026 19:01:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D62BE303D31A
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Jan 2026 18:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 874622E11D2;
	Tue, 27 Jan 2026 18:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jmy0l9t6"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A19221F39
	for <linux-acpi@vger.kernel.org>; Tue, 27 Jan 2026 18:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769536848; cv=none; b=Ut6Hh+qwlaWC5lDyK7KqwB0ASX9QXUCb7iMTfJb4t1qqCDVYsYoWsMzrUa+8u79O88rzDnWK/ajkNDUnFzajTHiQyyF0AAb34enPjenAdfpmiFoZdtTb/xbUlfdHLH1Y1aA5G/pHib9oirxP8eVacYWfvGrBfRv86ltm1B6U+D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769536848; c=relaxed/simple;
	bh=wGAHLopxVevz/kZ16URL7O/c9HUuFKs2GLFRJryBR0s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l76xRNL0Vv1gxqswSdDm5J75+4xP4u9/razZ6vL2CFMYCTkRdTN8NsRoC0jIB0yyCOHz3HusjMmHOSFNrNs/7c+mat7Etnww+aKLlgh6eKqk46Jo4BKf62UB+UfRf04KGQQ1d2paNZUzjCCaim4lRUXWckSTXFvbrCntAziQyPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jmy0l9t6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25BB6C116C6
	for <linux-acpi@vger.kernel.org>; Tue, 27 Jan 2026 18:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769536848;
	bh=wGAHLopxVevz/kZ16URL7O/c9HUuFKs2GLFRJryBR0s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Jmy0l9t61KDwbL3J3iYEfgXu+27uUbCiWkTAj/6/yZbm+dWxJLOvqQRXicnqK7KEV
	 lyj9kz++cMAaBXiMAWuZfB2MBDRk0ir8jzAUKu/5pkDN9MtiHvNs5kvXMb3NobJfwr
	 +ivDxGZZwEA5oqk65xqlBbbwrJ2ZPblP0199UBkG9BZ0FD/qFyE3njMUXeXhiJsROB
	 iyWm6ole9c7djJiLvlUVGiX9obrwdDp/aWFZNKJ8L6KZah7sABV2bvrXIb7kS98d07
	 0e6F1N3P5Lilg9cHO3GJ22LafVjIzntq43Z/mv+qrRxQaOpTqSRo6c3ySONHfMvUUi
	 DjnyPuUDwR5tw==
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-40423dbe98bso2398941fac.2
        for <linux-acpi@vger.kernel.org>; Tue, 27 Jan 2026 10:00:48 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWo0chNZrVQt17TZVBNdlKTBbNHyyjfq+9FkHdKdOzvD8u3zl/Qx5LEr87GTB4/z2oVJNCwXVOuJrOB@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr1wer5CUp4Vyg5M+Lan4ztuSy8kEYw0tfvxjzNpLbcspZCt7X
	+mtNcz9X0BCyxjvEoZUUyAy8MGLSulvlBOth9r6Wee6CTBDeWx8LvNBLSWcYkfbBqarNkCaiqcv
	IU7uE/zaFxRDRLKkhBLKdc8vBelP9KDo=
X-Received: by 2002:a05:6820:3105:b0:662:c8be:573 with SMTP id
 006d021491bc7-662f20dc844mr1357612eaf.61.1769536846986; Tue, 27 Jan 2026
 10:00:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260120113242.3843463-1-zhenglifeng1@huawei.com>
 <CAJZ5v0hX839+J-MdKUwpRv0D9HSj-sbtMN0o-OOYatu9dU+bFQ@mail.gmail.com> <20260127165824.0000247f@huawei.com>
In-Reply-To: <20260127165824.0000247f@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 27 Jan 2026 19:00:35 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0irPpqEZkCLPmdMU4CxR6ma_j11Z6Nxx8c5fd0aFq9dBw@mail.gmail.com>
X-Gm-Features: AZwV_Qg9WHd5IHGlj4ynIWJzPRb2gtAwBTHHjcLih4r84KwR56Pp50sqWxYB59o
Message-ID: <CAJZ5v0irPpqEZkCLPmdMU4CxR6ma_j11Z6Nxx8c5fd0aFq9dBw@mail.gmail.com>
Subject: Re: [PATCH] ACPI: processor: Add acpi_processor_start() back to parse
 _CPC tables before CPU online
To: Jonathan Cameron <jonathan.cameron@huawei.com>, Lifeng Zheng <zhenglifeng1@huawei.com>
Cc: catalin.marinas@arm.com, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linuxarm@huawei.com, gshan@redhat.com, 
	miguel.luis@oracle.com, guohanjun@huawei.com, zhanjie9@hisilicon.com, 
	lihuisong@huawei.com, yubowen8@huawei.com, zhangpengjie2@huawei.com, 
	wangzhi12@huawei.com, linhongye@h-partners.com, salil.mehta@huawei.com, 
	Viresh Kumar <viresh.kumar@linaro.org>, Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20679-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-acpi@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-acpi];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,huawei.com:email]
X-Rspamd-Queue-Id: 7E9E298BA5
X-Rspamd-Action: no action

+linux-pm and Viresh

On Tue, Jan 27, 2026 at 5:58=E2=80=AFPM Jonathan Cameron
<jonathan.cameron@huawei.com> wrote:
>
> On Tue, 27 Jan 2026 15:42:16 +0100
> "Rafael J. Wysocki" <rafael@kernel.org> wrote:
>
> > On Tue, Jan 20, 2026 at 12:33=E2=80=AFPM Lifeng Zheng <zhenglifeng1@hua=
wei.com> wrote:
> > >
> > > Currently, if boot with maxcpus less than NR_CPUS, the cppc_cpufreq d=
river
> > > will fail to register. Because it requires the domain information of =
all
> > > possible CPUs to construct shared_cpu_map, which shows the CPUs that =
share
> > > the same domain.
> > >
> > > Commit c1385c1f0ba3 ("ACPI: processor: Simplify initial onlining to u=
se
> > > same path for cold and hotplug") removes probe() of acpi_processor_dr=
iver
> > > and makes acpi_cppc_processor_probe() only being called the first tim=
e CPU
> > > goes online. This means that CPUs that haven't yet gone online will n=
ot
> > > have pre-parsed _CPC objects and causes cppc_cpufreq driver register =
fail.
> > >
> > > Add acpi_processor_start() back as the probe() callback of
> > > acpi_processor_driver and call acpi_cppc_processor_probe() in it to m=
ake
> > > sure all _CPC tables will be parsed when acpi_processor_driver regist=
ered.
> > >
> > > Fixes: c1385c1f0ba3 ("ACPI: processor: Simplify initial onlining to u=
se same path for cold and hotplug")
> > > Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
> > > ---
> > >  drivers/acpi/processor_driver.c | 30 ++++++++++++++++++++++++++----
> > >  1 file changed, 26 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor=
_driver.c
> > > index 65e779be64ff..c8b4daf580b0 100644
> > > --- a/drivers/acpi/processor_driver.c
> > > +++ b/drivers/acpi/processor_driver.c
> > > @@ -33,6 +33,7 @@ MODULE_AUTHOR("Paul Diefenbaugh");
> > >  MODULE_DESCRIPTION("ACPI Processor Driver");
> > >  MODULE_LICENSE("GPL");
> > >
> > > +static int acpi_processor_start(struct device *dev);
> > >  static int acpi_processor_stop(struct device *dev);
> > >
> > >  static const struct acpi_device_id processor_device_ids[] =3D {
> > > @@ -46,6 +47,7 @@ static struct device_driver acpi_processor_driver =
=3D {
> > >         .name =3D "processor",
> > >         .bus =3D &cpu_subsys,
> > >         .acpi_match_table =3D processor_device_ids,
> > > +       .probe =3D acpi_processor_start,
> > >         .remove =3D acpi_processor_stop,
> > >  };
> > >
> > > @@ -162,10 +164,6 @@ static int __acpi_processor_start(struct acpi_de=
vice *device)
> > >         if (!pr)
> > >                 return -ENODEV;
> > >
> > > -       result =3D acpi_cppc_processor_probe(pr);
> > > -       if (result && !IS_ENABLED(CONFIG_ACPI_CPU_FREQ_PSS))
> > > -               dev_dbg(&device->dev, "CPPC data invalid or not prese=
nt\n");
> > > -
> > >         if (!cpuidle_get_driver() || cpuidle_get_driver() =3D=3D &acp=
i_idle_driver)
> > >                 acpi_processor_power_init(pr);
> > >
> > > @@ -192,6 +190,30 @@ static int __acpi_processor_start(struct acpi_de=
vice *device)
> > >         return result;
> > >  }
> > >
> > > +static int acpi_processor_start(struct device *dev)
> > > +{
> > > +       struct acpi_device *device =3D ACPI_COMPANION(dev);
> > > +       struct acpi_processor *pr;
> > > +       int result;
> > > +
> > > +       if (!device)
> > > +               return -ENODEV;
> > > +
> > > +       pr =3D acpi_driver_data(device);
> > > +       if (!pr)
> > > +               return -ENODEV;
> > > +
> > > +       /* Protect against concurrent CPU hotplug operations */
> > > +       cpu_hotplug_disable();
> > > +       result =3D acpi_cppc_processor_probe(pr);
> > > +       cpu_hotplug_enable();
> >
> > This means that CPPC will be initialized for vCPUs that are not
> > enabled on ARM if I'm not mistaken.
>
> If we are just talking powered down at boot it used to do that
> so I assume it was fine. The corner case is ones we are explicitly
> saying are not onlineable yet but marked online capable and will
> turn up later.
>
> >
> > I'm not sure if it is valid to do so.
>
> The conclusion of the following is I think this is fine but I'm not
> entirely confident about it.
>
> I'm struggling to figure out the right answer to this and
> it's not easy to test. I vaguely recall having some nasty emulation
> hacks to poke some x86 related _CPC stuff a while back.
> I might be able to hack something up for this as well and try to
> create pathological corner cases.
>
> The short answer is CPPC + hotplug isn't a thing today in KVM + QEMU,
> but that's not to say it never will be if someone virtualizes CPC for
> a guest.  Let's consider that hypothetical virtualization / emulation.
>
> So the questions:
> 1) Does simply making this acpi_cppc_processor_probe() result in any
>    register accesses to the registers that might be found in _CPC or
>    used via other ACPI methods?
> 2) Can we rely on a a VMM not do something nasty if those are accessed
>    on CPUs that haven't been instantiated yet?  e.g. Bus error.
>    A related useful question is: Can we assume these registers are
>    accessible on offlined CPUs?  If they can be unsafe to access from
>    CPUs that are temporary powered down / offline then I think we are fin=
e because
>    the CPPC code must guarantee not to access them. (I'm relying on this!=
)
>
> For the particular case Lifeng has run into, I think the code that matter=
s
> (beyond instantiation of the infrastructure) is the creation of the
> domain info in acpi_get_psd(). I think _PSD can only be static data so
> shouldn't cause any register accesses to the powered down CPUs.
>
> So 'probably' fine + we'll not really know unless we get CPU HP and
> CPC.
>
> Alternative much more complex change would be to separate the grabbing of
> static data (done here) from setting up anything dynamic which would rema=
in
> in the hotplug handler.  If those registers haven't been discovered we de=
finitely
> can't access them from the cpu freq driver.

I'm thinking that maybe cppc_cpufreq should be updated instead.

I'm not really sure why it needs to collect information on offline
CPUs.  Surely, they don't matter until they are brought online.

