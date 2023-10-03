Return-Path: <linux-acpi+bounces-362-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D3E7B6BAF
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Oct 2023 16:34:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 4471A281834
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Oct 2023 14:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AF0131A73
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Oct 2023 14:34:09 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BCA52915
	for <linux-acpi@vger.kernel.org>; Tue,  3 Oct 2023 12:40:23 +0000 (UTC)
Received: from bee.tesarici.cz (bee.tesarici.cz [77.93.223.253])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C240483;
	Tue,  3 Oct 2023 05:40:21 -0700 (PDT)
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id 3876318C6A3;
	Tue,  3 Oct 2023 14:40:20 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=none dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tesarici.cz; s=mail;
	t=1696336820; bh=k8ga/n4jJGZ2XopsRMCjNoqWPcsRfuxhU8cQlADnJE0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pYhr3Xr6pq9hwO4YMU7gmQ8e5vF4izsyq5RDibFbokrm46XgsDIPH1gRW11icTyFs
	 3+5XA1mwuBFFmBXpgQgSFSeSfqnVnaHcp1UA1cUjg80envP3EsiHS73pVLtenCL/x9
	 bgEnLNQ2Z6tDq1O6Q5tgXF17QDNzK8kiB7Qbc5wTZiLkJyotLxCFb5wJ8Ghit0yBxw
	 kFdqnfNdeVDc/4R1N4JvwbrAAMM3xxMOo4HezC61/09O2UIHQPA1GOAujGuAopmVNE
	 wqlOhZD4xKxHG5MTa7QM4ZNEDB3Vs5lcqu6GwbYsO+MQ4bMAzzxKOkX6vonEvMyT+5
	 w0EwiJryXaNeQ==
Date: Tue, 3 Oct 2023 14:40:19 +0200
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: Thinkpad E595 system deadlock on resume from S3
Message-ID: <20231003144019.24566b05@meshulam.tesarici.cz>
In-Reply-To: <CAJZ5v0hvEyVAwA3r5OWv4W_vTbRXt_Oxv+Avvn6N0=1RoN=NCg@mail.gmail.com>
References: <20230930122054.3cf727a4@meshulam>
	<20231003113135.38384a87@meshulam.tesarici.cz>
	<CAJZ5v0i-FV29TUq8E=FGxB_dRKEJvdoKxzwPGAX0C9vnD7O8eg@mail.gmail.com>
	<20231003130240.0c64bc2e@meshulam.tesarici.cz>
	<CAJZ5v0hvEyVAwA3r5OWv4W_vTbRXt_Oxv+Avvn6N0=1RoN=NCg@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, 3 Oct 2023 14:34:56 +0200
"Rafael J. Wysocki" <rafael@kernel.org> wrote:

> On Tue, Oct 3, 2023 at 1:02=E2=80=AFPM Petr Tesa=C5=99=C3=ADk <petr@tesar=
ici.cz> wrote:
> >
> > On Tue, 3 Oct 2023 12:15:10 +0200
> > "Rafael J. Wysocki" <rafael@kernel.org> wrote:
> > =20
> > > On Tue, Oct 3, 2023 at 11:31=E2=80=AFAM Petr Tesa=C5=99=C3=ADk <petr@=
tesarici.cz> wrote: =20
> > > >
> > > > Hi again (adding more recipients),
> > > >
> > > > On Sat, 30 Sep 2023 12:20:54 +0200
> > > > Petr Tesa=C5=99=C3=ADk <petr@tesarici.cz> wrote:
> > > > =20
> > > > > Hi all,
> > > > >
> > > > > this time no patch (yet). In short, my Thinkpad running v6.6-rc3 =
fails
> > > > > to resume from S3. It also fails the same way with Tumbleweed v6.5
> > > > > kernel. I was able to capture a crash dump of the v6.5 kernel, and
> > > > > here's my analysis:
> > > > >
> > > > > The system never gets to waking up my SATA SSD disk:
> > > > >
> > > > > [0:0:0:0]    disk    ATA      KINGSTON SEDC600 H5.1  /dev/sda
> > > > >
> > > > > There is a pending resume work for kworker/u32:12 (PID 11032), bu=
t this
> > > > > worker is stuck in 'D' state:
> > > > > =20
> > > > > >>> prog.stack_trace(11032) =20
> > > > > #0  context_switch (../kernel/sched/core.c:5381:2)
> > > > > #1  __schedule (../kernel/sched/core.c:6710:8)
> > > > > #2  schedule (../kernel/sched/core.c:6786:3)
> > > > > #3  schedule_preempt_disabled (../kernel/sched/core.c:6845:2)
> > > > > #4  __mutex_lock_common (../kernel/locking/mutex.c:679:3)
> > > > > #5  __mutex_lock (../kernel/locking/mutex.c:747:9)
> > > > > #6  acpi_device_hotplug (../drivers/acpi/scan.c:382:2)
> > > > > #7  acpi_hotplug_work_fn (../drivers/acpi/osl.c:1162:2)
> > > > > #8  process_one_work (../kernel/workqueue.c:2600:2)
> > > > > #9  worker_thread (../kernel/workqueue.c:2751:4)
> > > > > #10 kthread (../kernel/kthread.c:389:9)
> > > > > #11 ret_from_fork (../arch/x86/kernel/process.c:145:3)
> > > > > #12 ret_from_fork_asm+0x1b/0x20 (../arch/x86/entry/entry_64.S:304)
> > > > >
> > > > > acpi_device_hotplug() tries to acquire acpi_scan_lock, which is h=
eld by
> > > > > systemd-sleep (PID 11002). This task is also in 'D' state:
> > > > > =20
> > > > > >>> prog.stack_trace(11002) =20
> > > > > #0  context_switch (../kernel/sched/core.c:5381:2)
> > > > > #1  __schedule (../kernel/sched/core.c:6710:8)
> > > > > #2  schedule (../kernel/sched/core.c:6786:3)
> > > > > #3  schedule_preempt_disabled (../kernel/sched/core.c:6845:2)
> > > > > #4  __mutex_lock_common (../kernel/locking/mutex.c:679:3)
> > > > > #5  __mutex_lock (../kernel/locking/mutex.c:747:9)
> > > > > #6  device_lock (../include/linux/device.h:958:2)
> > > > > #7  device_complete (../drivers/base/power/main.c:1063:2)
> > > > > #8  dpm_complete (../drivers/base/power/main.c:1121:3)
> > > > > #9  suspend_devices_and_enter (../kernel/power/suspend.c:516:2) =
=20
> > > >
> > > > I believe the issue must be somewhere here. The whole suspend and
> > > > resume logic in suspend_devices_and_enter() is framed by
> > > > platform_suspend_begin() and platform_resume_end().
> > > >
> > > > My system is an ACPI system, so suspend_ops contains:
> > > >
> > > >         .begin =3D acpi_suspend_begin,
> > > >         .end =3D acpi_pm_end,
> > > >
> > > > Now, acpi_suspend_begin() acquires acpi_scan_lock through
> > > > acpi_pm_start(), and the lock is not released until acpi_pm_end().
> > > > Since dpm_complete() waits for the completion of a work that tries =
to
> > > > acquire acpi_scan_lock, the system will deadlock. =20
> > >
> > > So holding acpi_scan_lock across suspend-resume is basically to
> > > prevent the hotplug from taking place then IIRC.
> > > =20
> > > > AFAICS either:
> > > >
> > > > a. the ACPI lock cannot be held while dpm_complete() runs, or
> > > > b. ata_scsi_dev_rescan() must not be scheduled before the system is
> > > > resumed, or
> > > > c. acpi_device_hotplug() must be implemented without taking dev->mu=
tex.
> > > >
> > > > My gut feeling is that b. is the right answer. =20
> > >
> > > It's been a while since I looked at that code last time, but then it
> > > has not changed for quite some time too.
> > >
> > > It looks like the acpi_device_hotplug() path attempts to acquire
> > > acpi_scan_lock() while holding dev->mutex which is kind of silly.  I
> > > need to check that, though. =20
> >
> > Thanks for your willingness. Well, it's not quite what you describe. If
> > it was a simple ABBA deadlock, then it would be reported by lockdep.
> > No, it's more complicated:
> >
> > 1. suspend_devices_and_enter() holds acpi_scan_lock,
> > 2. an ACPI hotplug work runs, but acpi_device_hotplug() goes to sleep
> >    when it gets to acquiring acpi_scan_lock,
> > 3. ata_scsi_dev_rescan() submits a SCSI command and waits for its
> >    completion while holding dev->mutex,
> > 4. the SCSI completion work happens to be put on the same workqueue as
> >    the ACPI hotplug work in step 2,
> >    ^^^--- THIS is how the two events are serialized! =20
>=20
> Which is unexpected.
>=20
> And quite honestly I'm not sure how this can happen, because
> acpi_hotplug_schedule() uses a dedicated workqueue and it is called
> from (a) the "eject" sysfs attribute (which cannot happen while system
> suspend-resume is in progress) and (b) acpi_bus_notify() which has
> nothing to do with SCSI.

Oh, you're right, and I was too quick. They cannot be on the same
queue...

> Maybe the workqueue used for the SCSI completion is freezable?

Yes, that's it:

*(struct workqueue_struct *)0xffff97d240b2fe00 =3D {
/* ... */
        .flags =3D (unsigned int)4,
/* WQ_FREEZABLE            =3D 1 << 2 */

Good. But if this workqueue is frozen, the system still cannot make
progress.

Petr T

