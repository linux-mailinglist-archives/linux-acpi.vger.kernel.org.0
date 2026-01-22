Return-Path: <linux-acpi+bounces-20557-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eC9LA105cmmadwAAu9opvQ
	(envelope-from <linux-acpi+bounces-20557-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jan 2026 15:51:09 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C823F68245
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jan 2026 15:51:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5CE2B7045E7
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jan 2026 13:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F366332EBE;
	Thu, 22 Jan 2026 13:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z//9xsjj"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9EC32AAB7
	for <linux-acpi@vger.kernel.org>; Thu, 22 Jan 2026 13:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769090291; cv=none; b=QNlflWDwk7KSPfP11ix2tO3oSTKHuxNSk+ZlaWalLD+khfNTTGnSUEY+gO6RBSSO+Bew6DAAYguAJznsQRUo+HCPndJSJoN2lAGwAyAF8rrAzfunDFcagxUvUlPr63UqVH+Oi1NZ950uUmVTiD1ukHYauAmEJJn8XlkmM7r05Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769090291; c=relaxed/simple;
	bh=8hAHLFgI7wqxI2OMNozLQAg4oGip1bm880wlnt7Of1Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LtI0mGVmlmvFGBVemL61REM9hu0V7X6034/C5r3u4fMOL6q+0m0d1ECOSxj1i3lYGx5nsKgebjPNhU/Gqupy9jchDDNv98PRdSBU/EVEjOIb/FXzBNnRFI4o/t3ufUwTQkXZAt5jR/UxKKU7iUVgAV+VjEfCi7QakOA7uscDM9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z//9xsjj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF324C19425
	for <linux-acpi@vger.kernel.org>; Thu, 22 Jan 2026 13:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769090291;
	bh=8hAHLFgI7wqxI2OMNozLQAg4oGip1bm880wlnt7Of1Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Z//9xsjjnKb+CLnQPBQHw6QIYl1oEmJKo2dt6FZ9naOlszDZP08xR33C5LrAA/r3q
	 6kFZe11ZmwsTMzFMHKDLpirJt3itgo83Kk54WLi1+UhEJ1Qg5Cid2Szt1mqjyoZWd+
	 T2XP9pV0JOolVrun2xTwOvXg9Dv4GtWrWduhmVB43+ymPyYgKFJi3LsepZb5WvYxJO
	 GFvGkxER715o++xoY3OJNsxX6i/G0fJdeJVHp1glWsynR1ut6QnBRKrhxHiVfiBu4o
	 AuTYLLFPXKRI5oJIVxL0Ca8+LELA/kwJ8+3YrOshNqvjg/a56yx/ZofgwxBSgXq18g
	 NOAyx7+Gsr28A==
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-40438e0cba6so578712fac.1
        for <linux-acpi@vger.kernel.org>; Thu, 22 Jan 2026 05:58:10 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUM6vfSLvLJ9pA3gTREkyebiaKx6K3P+cKypXO5OSqKROGH6USz0NWCIa/ieyfNizuBU0kVB10TtUoF@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7wF/oo08zXfVqHqLk7U1wRCu2kHDEUpf47Z2wY+bJAlUC/nbe
	GUFB3LXJSBICCf+vFZG+YkGG5zQsJkTdf+ExF4UiT7m3IwL/O8w99zrhF6IfDa8L1AhTE7vuldv
	JpCBNvev4tdyTG5MOE5UjvvfC5K75Gak=
X-Received: by 2002:a4a:e911:0:b0:65d:1336:f675 with SMTP id
 006d021491bc7-662b0064eeemr4027725eaf.42.1769090289944; Thu, 22 Jan 2026
 05:58:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260122073446.45628-1-yang.yicong@picoheart.com>
 <20260122073446.45628-2-yang.yicong@picoheart.com> <2026012214-dinginess-improper-9bc1@gregkh>
 <ca98b360-ea68-4edc-af3e-0a3f4f87fc21@picoheart.com> <CAJZ5v0j+yFhD6Y-LeY5eLSdXKyXQtC6q=TT-a79LnLpO_zoODw@mail.gmail.com>
 <6ac7b51b-376e-4fa9-a7a9-dc0f5da90f64@picoheart.com>
In-Reply-To: <6ac7b51b-376e-4fa9-a7a9-dc0f5da90f64@picoheart.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 22 Jan 2026 14:57:57 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0j6u+kWxq8XAAhkoQjBAW4xqfu-XepAULx1c8syp6N8hw@mail.gmail.com>
X-Gm-Features: AZwV_QiJAs2KzjBg3nxh_VHkwe9QL3cEztSZ11IflGOIDJXU3qSU48_ttkjLhKk
Message-ID: <CAJZ5v0j6u+kWxq8XAAhkoQjBAW4xqfu-XepAULx1c8syp6N8hw@mail.gmail.com>
Subject: Re: [PATCH 1/2] ACPI: scan: Use async schedule function for acpi_scan_clear_dep_fn
To: Yicong Yang <yang.yicong@picoheart.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Greg KH <gregkh@linuxfoundation.org>, lenb@kernel.org, 
	tglx@kernel.org, dakr@kernel.org, akpm@linux-foundation.org, 
	apatel@ventanamicro.com, pjw@kernel.org, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, alex@ghiti.fr, geshijian@picoheart.com, 
	weidong.wd@picoheart.com, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-20557-lists,linux-acpi=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-acpi@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[linux-acpi];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns,picoheart.com:email]
X-Rspamd-Queue-Id: C823F68245
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 2:48=E2=80=AFPM Yicong Yang <yang.yicong@picoheart.=
com> wrote:
>
> On 1/22/26 9:21 PM, Rafael J. Wysocki wrote:
> > On Thu, Jan 22, 2026 at 1:43=E2=80=AFPM Yicong Yang <yang.yicong@picohe=
art.com> wrote:
> >>
> >> On 1/22/26 6:29 PM, Greg KH wrote:
> >>> On Thu, Jan 22, 2026 at 03:34:45PM +0800, Yicong Yang wrote:
> >>>> The device object rescan in acpi_scan_clear_dep_fn is scheduled
> >>>> in the system workqueue which is not guaranteed to be finished
> >>>> before entering userspace. This will cause the problem that
> >>>> some key devices are missed when the init task try to find them,
> >>>> e.g. console devices and root devices (PCIe nvme, etc).
> >>>> This issues is more possbile to happen on RISCV since these
> >>>> devices using GSI interrupt may depend on APLIC and will be
> >>>> scanned in acpi_scan_clear_dep_queue() after APLIC initialized.
> >>>>
> >>>> Fix this by scheduling the acpi_scan_clear_dep_queue() using async
> >>>> schedule function rather than the system workqueue. The deferred
> >>>> works will be synchronized by async_synchronize_full() before
> >>>> entering init task.
> >>>>
> >>>> Update the comment as well.
> >>>>
> >>>> Signed-off-by: Yicong Yang <yang.yicong@picoheart.com>
> >>>> ---
> >>>>  drivers/acpi/scan.c | 35 ++++++++++++++++-------------------
> >>>>  1 file changed, 16 insertions(+), 19 deletions(-)
> >>>>
> >>>> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> >>>> index 416d87f9bd10..bf0d8ba9ba19 100644
> >>>> --- a/drivers/acpi/scan.c
> >>>> +++ b/drivers/acpi/scan.c
> >>>> @@ -5,6 +5,7 @@
> >>>>
> >>>>  #define pr_fmt(fmt) "ACPI: " fmt
> >>>>
> >>>> +#include <linux/async.h>
> >>>>  #include <linux/module.h>
> >>>>  #include <linux/init.h>
> >>>>  #include <linux/slab.h>
> >>>> @@ -2365,39 +2366,35 @@ struct acpi_scan_clear_dep_work {
> >>>>      struct acpi_device *adev;
> >>>>  };
> >>>>
> >>>> -static void acpi_scan_clear_dep_fn(struct work_struct *work)
> >>>> +static void acpi_scan_clear_dep_fn(void *dev, async_cookie_t cookie=
)
> >>>>  {
> >>>> -    struct acpi_scan_clear_dep_work *cdw;
> >>>> -
> >>>> -    cdw =3D container_of(work, struct acpi_scan_clear_dep_work, wor=
k);
> >>>> +    struct acpi_device *adev =3D to_acpi_device(dev);
> >>>>
> >>>>      acpi_scan_lock_acquire();
> >>>> -    acpi_bus_attach(cdw->adev, (void *)true);
> >>>> +    acpi_bus_attach(adev, (void *)true);
> >>>>      acpi_scan_lock_release();
> >>>>
> >>>> -    acpi_dev_put(cdw->adev);
> >>>> -    kfree(cdw);
> >>>> +    acpi_dev_put(adev);
> >>>>  }
> >>>>
> >>>>  static bool acpi_scan_clear_dep_queue(struct acpi_device *adev)
> >>>>  {
> >>>> -    struct acpi_scan_clear_dep_work *cdw;
> >>>> -
> >>>>      if (adev->dep_unmet)
> >>>>              return false;
> >>>>
> >>>> -    cdw =3D kmalloc(sizeof(*cdw), GFP_KERNEL);
> >>>> -    if (!cdw)
> >>>> -            return false;
> >>>> -
> >>>> -    cdw->adev =3D adev;
> >>>> -    INIT_WORK(&cdw->work, acpi_scan_clear_dep_fn);
> >>>>      /*
> >>>> -     * Since the work function may block on the lock until the enti=
re
> >>>> -     * initial enumeration of devices is complete, put it into the =
unbound
> >>>> -     * workqueue.
> >>>> +     * Async schedule the deferred acpi_scan_clear_dep_fn() since:
> >>>> +     * - acpi_bus_attach() needs to hold acpi_scan_lock which canno=
t
> >>>> +     *   be acquired under acpi_dep_list_lock (held here)
> >>>> +     * - the deferred work at boot stage is ensured to be finished
> >>>> +     *   before entering init task by the async_synchronize_full()
> >>>> +     *   barrier
> >>>> +     *
> >>>> +     * Use _nocall variant since it'll return on failure instead of
> >>>> +     * run the function synchronously.
> >>>>       */
> >>>> -    queue_work(system_dfl_wq, &cdw->work);
> >>>> +    if (!async_schedule_dev_nocall(acpi_scan_clear_dep_fn, &adev->d=
ev))
> >>>> +            return false;
> >>>
> >>> This really feels wrong to me, you are taking a code path that has be=
en
> >>> working for quite a while and changing it.  Perhaps your system ACPI
> >>> tables are the thing that is incorrect here?
> >>>
> >>> What exactly is the problem that you are seeing?  Why not start with
> >>> that and then we can work out how to solve that issue?
> >>>
> >>
> >> two issues here we met (as briefly mentioned in the commit and cover l=
etter):
> >> 1. kernel panic due to userspace init cannot have an opened console. t=
he
> >>    console device scanning is queued in the system_dfl_wq in above cod=
e
> >>    and not finished by the time userspace init process running, thus b=
y
> >>    the time userspace init running, no console is created
> >> 2. entering rescue shell due to no root devices (PCIe nvme in our case=
)
> >>    found. same reason as above, the PCIe host bridge scanning is queue=
d
> >>    in above and finished after init process running.
> >>
> >> The reason why these devices are created here is because they both dep=
end
> >> on riscv-aplic irqchip to serve their interrupts (console's wired
> >> interrupt and PCI's INTx interrupts) and in order to keep the dependen=
cy
> >> these devices are scanned and created after riscv-aplic initialized. T=
he
> >> riscv-aplic is initialized in device_initcall and invoke above codes f=
or
> >> the scan/creation of these devices, it's close to the time running
> >> userspace init process. Since system_dfl_wq is used here and no synchr=
onized
> >> mechanism, the issues will happen if userspace init runs before these =
devices
> >> are ready.
> >
> > Well, there is flush_workqueue(), isn't it there?
> >
>
> sure, of course. I implement it using async schedule but open to any
> better ones. but..
>
> >> Previous solution [1] is to advance the initialization of riscv-aplic
> >> earlier but the order still cannot be guaranteed conceptually.
> >> With async_schedule_dev_nocal() the work queued is finished
> >> before entering userspace init since we'll wait for completion at
> >> async_synchronize_full() before executing userspace init process.
> >>
> >> To solve the issue I think we should make these devices ready before
> >> entering userspace and async schedule is one way to make it. It's also
> >> using an unbound workqueue but have additional synchronization. Any
> >> corrections or suggestions?
> >
> > You can flush the dedicated workqueue at the same spot where you do
> > async_synchronize_full(), can't you?
> >
>
> the async_synchronize_full() is already there in the init code right
> before entering usersapce [1] so if we use async schedule we don't
> need to add synchronize spot ourselves. For a dedicated workqueue we
> need to call flush_workqueue() explicitly somewhere (I suppose to be
> the last level initcall like late_initcall_sync). Furthermore we need
> to allocate it and I think not all the platforms need this piece of
> code.
>
> It seems no need to have a dedicated workqueue for this since async
> schedule can satisfy the needs already (from my view). Except less
> modifications can be made for this piece of code if we use a dedicated
> workqueue, is this the consideration and mandatory?
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/init/main.c?h=3Dv6.19-rc6#n1580

So please add the above information to the changelog of your patch
(that is, why it is better to use async for this than to use a
dedicated workqueue in your view) because it is kind of relevant.

And how does the second patch in the series depend on this one?

