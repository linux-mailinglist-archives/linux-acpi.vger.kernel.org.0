Return-Path: <linux-acpi+bounces-20552-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OJDJIlYocmmadwAAu9opvQ
	(envelope-from <linux-acpi+bounces-20552-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jan 2026 14:38:30 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B4167657
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jan 2026 14:38:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7384A726528
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jan 2026 13:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7184330CDBF;
	Thu, 22 Jan 2026 13:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aFbfWNud"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5982E2DDD
	for <linux-acpi@vger.kernel.org>; Thu, 22 Jan 2026 13:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769088129; cv=none; b=Pn9WqeqXyNBWQU458w6wYuWtbaZNsTvdU7q6Yg0a51LdoDVuoKaVnbgaNitPykEMa2Kdytio++F+Qawduq94udtkVNfQtupTM/Fvfu7fo78OHQ9vQbS/V8p0C8ZrGb5xayoDI1+FMlPVBXntBzScQf1By4B2TKjbiJyyBEO8u8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769088129; c=relaxed/simple;
	bh=Xhdoiecow4soo7RSdBtxcDexMGIVImC+P0YHdSsaI5M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gj7PUPCj5ygMftOIMl+T3tw9/Y8b+1ZkyS9FNL8G2U7lZVNp3esPJb5N+MBzNAQgJeB0UNe5uyHVni6Q/PRgP9nX438p2BqpbF8ffwff6xtGnrG5boMbwWJQaz4o2l7HJ6PKqe5wHUdZPsUwjGHRsDrpCFliT6JTgb0dp8Lbj/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aFbfWNud; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0522DC2BC9E
	for <linux-acpi@vger.kernel.org>; Thu, 22 Jan 2026 13:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769088129;
	bh=Xhdoiecow4soo7RSdBtxcDexMGIVImC+P0YHdSsaI5M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=aFbfWNudNgpy5alNuA4ewG5YWOPnKX2AmUYh1ZH6TadlnE8EdVkr8L9oH6LtWA4Eq
	 /JandvjLlzba72ksUAqgUFfX1qMEDB2HU0IN2SK4f72gmIr8lyNuqAA9+BJ7ZZxURf
	 Bq/ztNS8mSmAqmvGd6YFxxMX4O0JIl3N0Ui4V4GzXJXUxvAUldtgoTqW8QrmjZMco5
	 6tnsnb2R2Jz0AVY49+ics92/1ZNEQ/RlHtWRpDHlSbmuxyU7pVl4YMfPIr+co++nbt
	 kkkcki5l3gEBe74h64pkihyevMLJGkuth2fG4BP2/7ZCvf8h3SLaxLrjU2I8EnPRCx
	 O6glQpNCY812w==
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-4041b3c1fa1so323057fac.3
        for <linux-acpi@vger.kernel.org>; Thu, 22 Jan 2026 05:22:08 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX+BOXN+9UrxSMX5p97G2/U5e/d7Sm/Ec1OzjUK8oGhgwMGB0OmCC+4LMBLCN6iHkuNelPeyrPgZrt4@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6WR0at1N1s+NwyJEIKOTM9L2pSgIcIQmODr9krjQKm4Bk8HIc
	brU4arTSBoCaHhOU/Lzs+AFq1aSIAcdFLrUFr5Q7iT8wkrpePLhXvjUnBDkj2P4Ncbq/mWNgP8T
	U8GocxIiAMkPILcWNdZDZtBhp+N97hSk=
X-Received: by 2002:a05:6870:249d:b0:3ec:a08c:9707 with SMTP id
 586e51a60fabf-4044cff37d3mr9457316fac.42.1769088127949; Thu, 22 Jan 2026
 05:22:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260122073446.45628-1-yang.yicong@picoheart.com>
 <20260122073446.45628-2-yang.yicong@picoheart.com> <2026012214-dinginess-improper-9bc1@gregkh>
 <ca98b360-ea68-4edc-af3e-0a3f4f87fc21@picoheart.com>
In-Reply-To: <ca98b360-ea68-4edc-af3e-0a3f4f87fc21@picoheart.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 22 Jan 2026 14:21:56 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0j+yFhD6Y-LeY5eLSdXKyXQtC6q=TT-a79LnLpO_zoODw@mail.gmail.com>
X-Gm-Features: AZwV_QjWOVv4QmIoNIFw7ZSnh8ZgiB5rfH-zMyuyza2HO_OqNOV6WJZ7QbgFQz8
Message-ID: <CAJZ5v0j+yFhD6Y-LeY5eLSdXKyXQtC6q=TT-a79LnLpO_zoODw@mail.gmail.com>
Subject: Re: [PATCH 1/2] ACPI: scan: Use async schedule function for acpi_scan_clear_dep_fn
To: Yicong Yang <yang.yicong@picoheart.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, rafael@kernel.org, lenb@kernel.org, 
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
	TAGGED_FROM(0.00)[bounces-20552-lists,linux-acpi=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns,picoheart.com:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 19B4167657
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 1:43=E2=80=AFPM Yicong Yang <yang.yicong@picoheart.=
com> wrote:
>
> On 1/22/26 6:29 PM, Greg KH wrote:
> > On Thu, Jan 22, 2026 at 03:34:45PM +0800, Yicong Yang wrote:
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
> >>      struct acpi_device *adev;
> >>  };
> >>
> >> -static void acpi_scan_clear_dep_fn(struct work_struct *work)
> >> +static void acpi_scan_clear_dep_fn(void *dev, async_cookie_t cookie)
> >>  {
> >> -    struct acpi_scan_clear_dep_work *cdw;
> >> -
> >> -    cdw =3D container_of(work, struct acpi_scan_clear_dep_work, work)=
;
> >> +    struct acpi_device *adev =3D to_acpi_device(dev);
> >>
> >>      acpi_scan_lock_acquire();
> >> -    acpi_bus_attach(cdw->adev, (void *)true);
> >> +    acpi_bus_attach(adev, (void *)true);
> >>      acpi_scan_lock_release();
> >>
> >> -    acpi_dev_put(cdw->adev);
> >> -    kfree(cdw);
> >> +    acpi_dev_put(adev);
> >>  }
> >>
> >>  static bool acpi_scan_clear_dep_queue(struct acpi_device *adev)
> >>  {
> >> -    struct acpi_scan_clear_dep_work *cdw;
> >> -
> >>      if (adev->dep_unmet)
> >>              return false;
> >>
> >> -    cdw =3D kmalloc(sizeof(*cdw), GFP_KERNEL);
> >> -    if (!cdw)
> >> -            return false;
> >> -
> >> -    cdw->adev =3D adev;
> >> -    INIT_WORK(&cdw->work, acpi_scan_clear_dep_fn);
> >>      /*
> >> -     * Since the work function may block on the lock until the entire
> >> -     * initial enumeration of devices is complete, put it into the un=
bound
> >> -     * workqueue.
> >> +     * Async schedule the deferred acpi_scan_clear_dep_fn() since:
> >> +     * - acpi_bus_attach() needs to hold acpi_scan_lock which cannot
> >> +     *   be acquired under acpi_dep_list_lock (held here)
> >> +     * - the deferred work at boot stage is ensured to be finished
> >> +     *   before entering init task by the async_synchronize_full()
> >> +     *   barrier
> >> +     *
> >> +     * Use _nocall variant since it'll return on failure instead of
> >> +     * run the function synchronously.
> >>       */
> >> -    queue_work(system_dfl_wq, &cdw->work);
> >> +    if (!async_schedule_dev_nocall(acpi_scan_clear_dep_fn, &adev->dev=
))
> >> +            return false;
> >
> > This really feels wrong to me, you are taking a code path that has been
> > working for quite a while and changing it.  Perhaps your system ACPI
> > tables are the thing that is incorrect here?
> >
> > What exactly is the problem that you are seeing?  Why not start with
> > that and then we can work out how to solve that issue?
> >
>
> two issues here we met (as briefly mentioned in the commit and cover lett=
er):
> 1. kernel panic due to userspace init cannot have an opened console. the
>    console device scanning is queued in the system_dfl_wq in above code
>    and not finished by the time userspace init process running, thus by
>    the time userspace init running, no console is created
> 2. entering rescue shell due to no root devices (PCIe nvme in our case)
>    found. same reason as above, the PCIe host bridge scanning is queued
>    in above and finished after init process running.
>
> The reason why these devices are created here is because they both depend
> on riscv-aplic irqchip to serve their interrupts (console's wired
> interrupt and PCI's INTx interrupts) and in order to keep the dependency
> these devices are scanned and created after riscv-aplic initialized. The
> riscv-aplic is initialized in device_initcall and invoke above codes for
> the scan/creation of these devices, it's close to the time running
> userspace init process. Since system_dfl_wq is used here and no synchroni=
zed
> mechanism, the issues will happen if userspace init runs before these dev=
ices
> are ready.

Well, there is flush_workqueue(), isn't it there?

> Previous solution [1] is to advance the initialization of riscv-aplic
> earlier but the order still cannot be guaranteed conceptually.
> With async_schedule_dev_nocal() the work queued is finished
> before entering userspace init since we'll wait for completion at
> async_synchronize_full() before executing userspace init process.
>
> To solve the issue I think we should make these devices ready before
> entering userspace and async schedule is one way to make it. It's also
> using an unbound workqueue but have additional synchronization. Any
> corrections or suggestions?

You can flush the dedicated workqueue at the same spot where you do
async_synchronize_full(), can't you?

> [1] https://lore.kernel.org/linux-riscv/20260114063730.78009-1-yang.yicon=
g@picoheart.com/

