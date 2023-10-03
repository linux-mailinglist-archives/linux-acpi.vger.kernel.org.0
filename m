Return-Path: <linux-acpi+bounces-361-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E83E7B6BAE
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Oct 2023 16:34:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 51968281810
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Oct 2023 14:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39F5EDDDC
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Oct 2023 14:34:04 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E215381
	for <linux-acpi@vger.kernel.org>; Tue,  3 Oct 2023 12:35:28 +0000 (UTC)
Received: from bee.tesarici.cz (bee.tesarici.cz [IPv6:2a03:3b40:fe:2d4::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CFADAC
	for <linux-acpi@vger.kernel.org>; Tue,  3 Oct 2023 05:35:26 -0700 (PDT)
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id 4811618DDC5;
	Tue,  3 Oct 2023 14:35:23 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=none dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tesarici.cz; s=mail;
	t=1696336523; bh=1xxn/DNj7bRTSIWCCgEm37x5aw7+iaYbn4pZE7w+ehA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nfPA/mewjvnJKuQTpJY0zKnuLaSRUCTyKfEJv2l08iy+rdZqnGJi/Y181712mgSxJ
	 X0YIFgka9f5JKWHU94cADbkuiajiA/huOeHKgzT44YAvoGddeOY+qOFxABtakJpcFY
	 i0lqVA5JyRMGx/lwHMGRR1sAvLVMxudwhZd7n3M+vBQaLqvPmAuSvTumctNjb01pb5
	 KN1+aSJI3Knf9+i6rkn3cPq+NpsjTBC6bcUnMQQqTkJy/3p1CyJXlJp/PpNf1y3x5m
	 vOQYhQST5uZ+auFMbf9wRMCl2czY3VhNdz0v9N1tXeMRhJbFLp/yKumydC9Q2bf9CI
	 BnGlABa2IO5iA==
Date: Tue, 3 Oct 2023 14:35:21 +0200
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: Thinkpad E595 system deadlock on resume from S3
Message-ID: <20231003143521.7b7dc86e@meshulam.tesarici.cz>
In-Reply-To: <20231003130240.0c64bc2e@meshulam.tesarici.cz>
References: <20230930122054.3cf727a4@meshulam>
	<20231003113135.38384a87@meshulam.tesarici.cz>
	<CAJZ5v0i-FV29TUq8E=FGxB_dRKEJvdoKxzwPGAX0C9vnD7O8eg@mail.gmail.com>
	<20231003130240.0c64bc2e@meshulam.tesarici.cz>
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
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, 3 Oct 2023 13:02:40 +0200
Petr Tesa=C5=99=C3=ADk <petr@tesarici.cz> wrote:

> On Tue, 3 Oct 2023 12:15:10 +0200
> "Rafael J. Wysocki" <rafael@kernel.org> wrote:
>=20
> > On Tue, Oct 3, 2023 at 11:31=E2=80=AFAM Petr Tesa=C5=99=C3=ADk <petr@te=
sarici.cz> wrote:
> > >
> > > Hi again (adding more recipients),
> > >
> > > On Sat, 30 Sep 2023 12:20:54 +0200
> > > Petr Tesa=C5=99=C3=ADk <petr@tesarici.cz> wrote:
> > > =20
> > > > Hi all,
> > > >
> > > > this time no patch (yet). In short, my Thinkpad running v6.6-rc3 fa=
ils
> > > > to resume from S3. It also fails the same way with Tumbleweed v6.5
> > > > kernel. I was able to capture a crash dump of the v6.5 kernel, and
> > > > here's my analysis:
> > > >
> > > > The system never gets to waking up my SATA SSD disk:
> > > >
> > > > [0:0:0:0]    disk    ATA      KINGSTON SEDC600 H5.1  /dev/sda
> > > >
> > > > There is a pending resume work for kworker/u32:12 (PID 11032), but =
this
> > > > worker is stuck in 'D' state:
> > > > =20
> > > > >>> prog.stack_trace(11032) =20
> > > > #0  context_switch (../kernel/sched/core.c:5381:2)
> > > > #1  __schedule (../kernel/sched/core.c:6710:8)
> > > > #2  schedule (../kernel/sched/core.c:6786:3)
> > > > #3  schedule_preempt_disabled (../kernel/sched/core.c:6845:2)
> > > > #4  __mutex_lock_common (../kernel/locking/mutex.c:679:3)
> > > > #5  __mutex_lock (../kernel/locking/mutex.c:747:9)
> > > > #6  acpi_device_hotplug (../drivers/acpi/scan.c:382:2)
> > > > #7  acpi_hotplug_work_fn (../drivers/acpi/osl.c:1162:2)
> > > > #8  process_one_work (../kernel/workqueue.c:2600:2)
> > > > #9  worker_thread (../kernel/workqueue.c:2751:4)
> > > > #10 kthread (../kernel/kthread.c:389:9)
> > > > #11 ret_from_fork (../arch/x86/kernel/process.c:145:3)
> > > > #12 ret_from_fork_asm+0x1b/0x20 (../arch/x86/entry/entry_64.S:304)
> > > >
> > > > acpi_device_hotplug() tries to acquire acpi_scan_lock, which is hel=
d by
> > > > systemd-sleep (PID 11002). This task is also in 'D' state:
> > > > =20
> > > > >>> prog.stack_trace(11002) =20
> > > > #0  context_switch (../kernel/sched/core.c:5381:2)
> > > > #1  __schedule (../kernel/sched/core.c:6710:8)
> > > > #2  schedule (../kernel/sched/core.c:6786:3)
> > > > #3  schedule_preempt_disabled (../kernel/sched/core.c:6845:2)
> > > > #4  __mutex_lock_common (../kernel/locking/mutex.c:679:3)
> > > > #5  __mutex_lock (../kernel/locking/mutex.c:747:9)
> > > > #6  device_lock (../include/linux/device.h:958:2)
> > > > #7  device_complete (../drivers/base/power/main.c:1063:2)
> > > > #8  dpm_complete (../drivers/base/power/main.c:1121:3)
> > > > #9  suspend_devices_and_enter (../kernel/power/suspend.c:516:2) =20
> > >
> > > I believe the issue must be somewhere here. The whole suspend and
> > > resume logic in suspend_devices_and_enter() is framed by
> > > platform_suspend_begin() and platform_resume_end().
> > >
> > > My system is an ACPI system, so suspend_ops contains:
> > >
> > >         .begin =3D acpi_suspend_begin,
> > >         .end =3D acpi_pm_end,
> > >
> > > Now, acpi_suspend_begin() acquires acpi_scan_lock through
> > > acpi_pm_start(), and the lock is not released until acpi_pm_end().
> > > Since dpm_complete() waits for the completion of a work that tries to
> > > acquire acpi_scan_lock, the system will deadlock. =20
> >=20
> > So holding acpi_scan_lock across suspend-resume is basically to
> > prevent the hotplug from taking place then IIRC.
> >=20
> > > AFAICS either:
> > >
> > > a. the ACPI lock cannot be held while dpm_complete() runs, or
> > > b. ata_scsi_dev_rescan() must not be scheduled before the system is
> > > resumed, or
> > > c. acpi_device_hotplug() must be implemented without taking dev->mute=
x.
> > >
> > > My gut feeling is that b. is the right answer. =20
> >=20
> > It's been a while since I looked at that code last time, but then it
> > has not changed for quite some time too.
> >=20
> > It looks like the acpi_device_hotplug() path attempts to acquire
> > acpi_scan_lock() while holding dev->mutex which is kind of silly.  I
> > need to check that, though.
>=20
> Thanks for your willingness. Well, it's not quite what you describe. If
> it was a simple ABBA deadlock, then it would be reported by lockdep.
> No, it's more complicated:
>=20
> 1. suspend_devices_and_enter() holds acpi_scan_lock,
> 2. an ACPI hotplug work runs, but acpi_device_hotplug() goes to sleep
>    when it gets to acquiring acpi_scan_lock,
> 3. ata_scsi_dev_rescan() submits a SCSI command and waits for its
>    completion while holding dev->mutex,
> 4. the SCSI completion work happens to be put on the same workqueue as
>    the ACPI hotplug work in step 2,
>    ^^^--- THIS is how the two events are serialized!

While wondering why the work was not taken by another worker, I noticed
that it was placed on the inactive_work list. Might be relevant.

Petr T

