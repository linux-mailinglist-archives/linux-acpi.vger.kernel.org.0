Return-Path: <linux-acpi+bounces-20553-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6D9zAJktcmmadwAAu9opvQ
	(envelope-from <linux-acpi+bounces-20553-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jan 2026 15:00:57 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6137767A31
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jan 2026 15:00:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BDF318C9E54
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jan 2026 13:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1E4430DECB;
	Thu, 22 Jan 2026 13:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CGyBNZ/S"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D17430ACE5
	for <linux-acpi@vger.kernel.org>; Thu, 22 Jan 2026 13:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769088171; cv=none; b=Av1nrArgDYUHXEGAptETXyKrh+GUtQQFv6+vK0hlvojtfestT/dPCWK10Rti+Rq2niDvr963paDCLq2Re2T/+S+MrdrtdXhbLY7pdMH/OwW7FVHZllxAKgAUBVT0RHt60mdIdYt+JHArew34Ia5oq3aMs/2f73b1R41f6806V64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769088171; c=relaxed/simple;
	bh=y0PkLqx+vtabPgjqGUzX5K06qpvV+/WhZK31GBxVf4E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ulh9lvIHxB8O+jKoKSF83yNkFdwrlVT1tl6nL/2OfNbFobaPVkJfL2DNd33chyuqXiJdnAIOCKK1TkaMoudgICc07sAGohBliWeUAyQXUJsY6qMTWp0zPIUM0LuCN0oMiXGLuz/DhUr3DV8MsGW+0w0e9gLFx74AaG7Rlfu5pTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CGyBNZ/S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 406FFC2BCB1
	for <linux-acpi@vger.kernel.org>; Thu, 22 Jan 2026 13:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769088171;
	bh=y0PkLqx+vtabPgjqGUzX5K06qpvV+/WhZK31GBxVf4E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=CGyBNZ/SpgAThPn4InSKrcvQah829DEMbQMzZHHYgWFfe0uYLgG8nHlQ5F+YjF8NQ
	 cAX/neHWFWlpVSglcxILgX117B6UUqa6vdWkKEoPALLRUE5bhaN1U1zsEolROwkVAy
	 conmm4xAaDpPNsNPcDxSMDajMDx8rWbzasL1ryWDDvs9rBd9i8wY4Vp4FdS4UHUM6z
	 wt5QArc7I+I+H7Gic4MD1wCGHe5YQt1V//AEsoPoqYjWy+E3kDNuk1aeKFWrPYxTBa
	 KuoQLt39ZJB0nrdaar942QuFmKbcaBUMlcNPGPvLzUqlGrET7uZKJWig9of3LhAjno
	 jspSYWdq6rJBA==
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-404254ffe8aso546290fac.0
        for <linux-acpi@vger.kernel.org>; Thu, 22 Jan 2026 05:22:51 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXnjlHMMCMSXDg75nP1aGWsrTVumd5iJIkZUfVBvNZ7rIhkiJ77cH+55/Y6NqK+OYoVh4V5+0wwuZ67@vger.kernel.org
X-Gm-Message-State: AOJu0YwrCDEvGLRp+EaKtg8iPW8yI5Jp1uJNiJwh3G6OWLwFnvpG03cL
	+03skugjrUOWdYfSj4YG+YLF0U+TnoMgYsgOMk6cwfwlDngMwtRcVPmoL/GgkxneVzAmJlsC5/a
	dfoUfv65X3ezooEf40w249VfVlImOaYQ=
X-Received: by 2002:a05:6871:2b1c:b0:3ec:4067:c684 with SMTP id
 586e51a60fabf-40882a78429mr1831476fac.3.1769088170247; Thu, 22 Jan 2026
 05:22:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260122073446.45628-1-yang.yicong@picoheart.com>
 <20260122073446.45628-2-yang.yicong@picoheart.com> <CAJZ5v0iwfk4hnj7Lf5hq3uo4p+_CT35ZwJUnenLOzOoGqQcsgw@mail.gmail.com>
 <7512bdfc-96ff-480a-a4e2-3b544f86d59d@picoheart.com>
In-Reply-To: <7512bdfc-96ff-480a-a4e2-3b544f86d59d@picoheart.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 22 Jan 2026 14:22:39 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0iUfHQBaXZ65H2nfcwMAyvdw_x5_42z0b8VMvL356kZsA@mail.gmail.com>
X-Gm-Features: AZwV_Qh_oP3VWYUXH5YAMEm8jxBGG_L9hdLOk6iM-ikwfdmczgxAcysS4nDKmBs
Message-ID: <CAJZ5v0iUfHQBaXZ65H2nfcwMAyvdw_x5_42z0b8VMvL356kZsA@mail.gmail.com>
Subject: Re: [PATCH 1/2] ACPI: scan: Use async schedule function for acpi_scan_clear_dep_fn
To: Yicong Yang <yang.yicong@picoheart.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, lenb@kernel.org, tglx@kernel.org, 
	gregkh@linuxfoundation.org, dakr@kernel.org, akpm@linux-foundation.org, 
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
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20553-lists,linux-acpi=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	RCPT_COUNT_TWELVE(0.00)[17];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-acpi@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[linux-acpi];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 6137767A31
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 1:50=E2=80=AFPM Yicong Yang <yang.yicong@picoheart.=
com> wrote:
>
> On 1/22/26 7:19 PM, Rafael J. Wysocki wrote:
> > On Thu, Jan 22, 2026 at 8:35=E2=80=AFAM Yicong Yang <yang.yicong@picohe=
art.com> wrote:
> >>
> >> The device object rescan in acpi_scan_clear_dep_fn is scheduled
> >> in the system workqueue which is not guaranteed to be finished
> >> before entering userspace. This will cause the problem that
> >> some key devices are missed when the init task try to find them,
> >> e.g. console devices and root devices (PCIe nvme, etc).
> >> This issues is more possbile to happen on RISCV since these
> >> devices using GSI interrupt may depend on APLIC and will be
> >> scanned in acpi_scan_clear_dep_queue() after APLIC initialized.
> >>
> >> Fix this by scheduling the acpi_scan_clear_dep_queue() using async
> >> schedule function rather than the system workqueue. The deferred
> >> works will be synchronized by async_synchronize_full() before
> >> entering init task.
> >>
> >> Update the comment as well.
> >>
> >> Signed-off-by: Yicong Yang <yang.yicong@picoheart.com>
> >> ---
> >>  drivers/acpi/scan.c | 35 ++++++++++++++++-------------------
> >>  1 file changed, 16 insertions(+), 19 deletions(-)
> >>
> >> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> >> index 416d87f9bd10..bf0d8ba9ba19 100644
> >> --- a/drivers/acpi/scan.c
> >> +++ b/drivers/acpi/scan.c
> >> @@ -5,6 +5,7 @@
> >>
> >>  #define pr_fmt(fmt) "ACPI: " fmt
> >>
> >> +#include <linux/async.h>
> >>  #include <linux/module.h>
> >>  #include <linux/init.h>
> >>  #include <linux/slab.h>
> >> @@ -2365,39 +2366,35 @@ struct acpi_scan_clear_dep_work {
> >>         struct acpi_device *adev;
> >>  };
> >>
> >> -static void acpi_scan_clear_dep_fn(struct work_struct *work)
> >> +static void acpi_scan_clear_dep_fn(void *dev, async_cookie_t cookie)
> >>  {
> >> -       struct acpi_scan_clear_dep_work *cdw;
> >> -
> >> -       cdw =3D container_of(work, struct acpi_scan_clear_dep_work, wo=
rk);
> >> +       struct acpi_device *adev =3D to_acpi_device(dev);
> >>
> >>         acpi_scan_lock_acquire();
> >> -       acpi_bus_attach(cdw->adev, (void *)true);
> >> +       acpi_bus_attach(adev, (void *)true);
> >>         acpi_scan_lock_release();
> >>
> >> -       acpi_dev_put(cdw->adev);
> >> -       kfree(cdw);
> >> +       acpi_dev_put(adev);
> >>  }
> >>
> >>  static bool acpi_scan_clear_dep_queue(struct acpi_device *adev)
> >>  {
> >> -       struct acpi_scan_clear_dep_work *cdw;
> >> -
> >>         if (adev->dep_unmet)
> >>                 return false;
> >>
> >> -       cdw =3D kmalloc(sizeof(*cdw), GFP_KERNEL);
> >> -       if (!cdw)
> >> -               return false;
> >> -
> >> -       cdw->adev =3D adev;
> >> -       INIT_WORK(&cdw->work, acpi_scan_clear_dep_fn);
> >>         /*
> >> -        * Since the work function may block on the lock until the ent=
ire
> >> -        * initial enumeration of devices is complete, put it into the=
 unbound
> >> -        * workqueue.
> >> +        * Async schedule the deferred acpi_scan_clear_dep_fn() since:
> >> +        * - acpi_bus_attach() needs to hold acpi_scan_lock which cann=
ot
> >> +        *   be acquired under acpi_dep_list_lock (held here)
> >> +        * - the deferred work at boot stage is ensured to be finished
> >> +        *   before entering init task by the async_synchronize_full()
> >> +        *   barrier
> >> +        *
> >> +        * Use _nocall variant since it'll return on failure instead o=
f
> >> +        * run the function synchronously.
> >>          */
> >> -       queue_work(system_dfl_wq, &cdw->work);
> >> +       if (!async_schedule_dev_nocall(acpi_scan_clear_dep_fn, &adev->=
dev))
> >
> > If the problem is that system_dfl_wq is too slow, why don't you just
> > try a dedicated workqueue for this?
> >
> > There's no need to modify all of this code.
> >
>
> The problem is that these works are not finished before entering userspac=
e,
> so some key devices like console or PCIe nvme (for root device) is not re=
ady
> in time userspace init running.
>
> If we use a dedicated workqueue we still need to do the synchronization
> somewhere before entering the userspace to solve the problem. But that's =
just
> what async_schedule* does: queue the function in async_wq (also an unboun=
d one)
> and wait finish before execute init process by async_synchronize_full(). =
Does
> it make sense?

Well, please see my reply to the other message.

