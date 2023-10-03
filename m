Return-Path: <linux-acpi+bounces-364-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C5F87B6BB2
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Oct 2023 16:34:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 4E5F12817CC
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Oct 2023 14:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 371DB31A89
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Oct 2023 14:34:19 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8A42915
	for <linux-acpi@vger.kernel.org>; Tue,  3 Oct 2023 12:48:26 +0000 (UTC)
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E293983;
	Tue,  3 Oct 2023 05:48:24 -0700 (PDT)
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-6c7a4735a30so29456a34.1;
        Tue, 03 Oct 2023 05:48:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696337304; x=1696942104;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pZIw0Pfz3zKOuSAGEoKnEZhKYO7D6rtXe1s5fdv3hmo=;
        b=AYWutq06VsQPeLXvqAvw4ZbHxmhhRjkjw9xcfy7TP9twjf27rHdyfV25lOwj2eyy2t
         Ho30fv4oyIzeMb8TQr/Z5i+wfLoP+em25iOSx7cWoNwXoSnX+HpY4UI7cW65sK2G8cAm
         Ze+GxblVwtP4r5wDyKdHUFnNzWrACtAUwSF7uXgormIZOZyFTv1ejKiJ7iV7X49wvCoD
         3aLWJJr7KmWWNX3xA7SvEDqgPdgd2ikjau9YPaOzL9t9xAIy7MGuXsDDhWQiKeSfatjr
         V00ozSsfImtH2azsDoo8inSiwI/Ga59Cz1yAO+ZdF5w8vDujrUjKz6ETE73m/qxgcQsT
         8B6g==
X-Gm-Message-State: AOJu0Yy79YwK+LiJYbh5ZYttEo+1GNmdG7czo+AIcjA6oDoxOttvEza9
	pV+u3jrZ/BNCw96kESwB6V7ielMj+i9oA8/dQpEp9G6w
X-Google-Smtp-Source: AGHT+IGWPez02EFjVuR9HEIgbvYDwyrPXicPWLsS/gEGzJl0IRWknFlgSElTuFdKKGiwdi+gLLoee6wT45rkJROWqdw=
X-Received: by 2002:a05:6808:189b:b0:3ae:100d:5320 with SMTP id
 bi27-20020a056808189b00b003ae100d5320mr16806286oib.2.1696337304109; Tue, 03
 Oct 2023 05:48:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230930122054.3cf727a4@meshulam> <20231003113135.38384a87@meshulam.tesarici.cz>
 <CAJZ5v0i-FV29TUq8E=FGxB_dRKEJvdoKxzwPGAX0C9vnD7O8eg@mail.gmail.com>
 <20231003130240.0c64bc2e@meshulam.tesarici.cz> <CAJZ5v0hvEyVAwA3r5OWv4W_vTbRXt_Oxv+Avvn6N0=1RoN=NCg@mail.gmail.com>
 <20231003144019.24566b05@meshulam.tesarici.cz>
In-Reply-To: <20231003144019.24566b05@meshulam.tesarici.cz>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 3 Oct 2023 14:48:13 +0200
Message-ID: <CAJZ5v0jttFqKE_CLpF+-vJ_wDAuOo_BUS33htpFUs6idNMugKg@mail.gmail.com>
Subject: Re: Thinkpad E595 system deadlock on resume from S3
To: =?UTF-8?B?UGV0ciBUZXNhxZnDrWs=?= <petr@tesarici.cz>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 3, 2023 at 2:40=E2=80=AFPM Petr Tesa=C5=99=C3=ADk <petr@tesaric=
i.cz> wrote:
>
> On Tue, 3 Oct 2023 14:34:56 +0200
> "Rafael J. Wysocki" <rafael@kernel.org> wrote:
>
> > On Tue, Oct 3, 2023 at 1:02=E2=80=AFPM Petr Tesa=C5=99=C3=ADk <petr@tes=
arici.cz> wrote:
> > >
> > > On Tue, 3 Oct 2023 12:15:10 +0200
> > > "Rafael J. Wysocki" <rafael@kernel.org> wrote:
> > >
> > > > On Tue, Oct 3, 2023 at 11:31=E2=80=AFAM Petr Tesa=C5=99=C3=ADk <pet=
r@tesarici.cz> wrote:
> > > > >
> > > > > Hi again (adding more recipients),
> > > > >
> > > > > On Sat, 30 Sep 2023 12:20:54 +0200
> > > > > Petr Tesa=C5=99=C3=ADk <petr@tesarici.cz> wrote:
> > > > >
> > > > > > Hi all,
> > > > > >
> > > > > > this time no patch (yet). In short, my Thinkpad running v6.6-rc=
3 fails
> > > > > > to resume from S3. It also fails the same way with Tumbleweed v=
6.5
> > > > > > kernel. I was able to capture a crash dump of the v6.5 kernel, =
and
> > > > > > here's my analysis:
> > > > > >
> > > > > > The system never gets to waking up my SATA SSD disk:
> > > > > >
> > > > > > [0:0:0:0]    disk    ATA      KINGSTON SEDC600 H5.1  /dev/sda
> > > > > >
> > > > > > There is a pending resume work for kworker/u32:12 (PID 11032), =
but this
> > > > > > worker is stuck in 'D' state:
> > > > > >
> > > > > > >>> prog.stack_trace(11032)
> > > > > > #0  context_switch (../kernel/sched/core.c:5381:2)
> > > > > > #1  __schedule (../kernel/sched/core.c:6710:8)
> > > > > > #2  schedule (../kernel/sched/core.c:6786:3)
> > > > > > #3  schedule_preempt_disabled (../kernel/sched/core.c:6845:2)
> > > > > > #4  __mutex_lock_common (../kernel/locking/mutex.c:679:3)
> > > > > > #5  __mutex_lock (../kernel/locking/mutex.c:747:9)
> > > > > > #6  acpi_device_hotplug (../drivers/acpi/scan.c:382:2)
> > > > > > #7  acpi_hotplug_work_fn (../drivers/acpi/osl.c:1162:2)
> > > > > > #8  process_one_work (../kernel/workqueue.c:2600:2)
> > > > > > #9  worker_thread (../kernel/workqueue.c:2751:4)
> > > > > > #10 kthread (../kernel/kthread.c:389:9)
> > > > > > #11 ret_from_fork (../arch/x86/kernel/process.c:145:3)
> > > > > > #12 ret_from_fork_asm+0x1b/0x20 (../arch/x86/entry/entry_64.S:3=
04)
> > > > > >
> > > > > > acpi_device_hotplug() tries to acquire acpi_scan_lock, which is=
 held by
> > > > > > systemd-sleep (PID 11002). This task is also in 'D' state:
> > > > > >
> > > > > > >>> prog.stack_trace(11002)
> > > > > > #0  context_switch (../kernel/sched/core.c:5381:2)
> > > > > > #1  __schedule (../kernel/sched/core.c:6710:8)
> > > > > > #2  schedule (../kernel/sched/core.c:6786:3)
> > > > > > #3  schedule_preempt_disabled (../kernel/sched/core.c:6845:2)
> > > > > > #4  __mutex_lock_common (../kernel/locking/mutex.c:679:3)
> > > > > > #5  __mutex_lock (../kernel/locking/mutex.c:747:9)
> > > > > > #6  device_lock (../include/linux/device.h:958:2)
> > > > > > #7  device_complete (../drivers/base/power/main.c:1063:2)
> > > > > > #8  dpm_complete (../drivers/base/power/main.c:1121:3)
> > > > > > #9  suspend_devices_and_enter (../kernel/power/suspend.c:516:2)
> > > > >
> > > > > I believe the issue must be somewhere here. The whole suspend and
> > > > > resume logic in suspend_devices_and_enter() is framed by
> > > > > platform_suspend_begin() and platform_resume_end().
> > > > >
> > > > > My system is an ACPI system, so suspend_ops contains:
> > > > >
> > > > >         .begin =3D acpi_suspend_begin,
> > > > >         .end =3D acpi_pm_end,
> > > > >
> > > > > Now, acpi_suspend_begin() acquires acpi_scan_lock through
> > > > > acpi_pm_start(), and the lock is not released until acpi_pm_end()=
.
> > > > > Since dpm_complete() waits for the completion of a work that trie=
s to
> > > > > acquire acpi_scan_lock, the system will deadlock.
> > > >
> > > > So holding acpi_scan_lock across suspend-resume is basically to
> > > > prevent the hotplug from taking place then IIRC.
> > > >
> > > > > AFAICS either:
> > > > >
> > > > > a. the ACPI lock cannot be held while dpm_complete() runs, or
> > > > > b. ata_scsi_dev_rescan() must not be scheduled before the system =
is
> > > > > resumed, or
> > > > > c. acpi_device_hotplug() must be implemented without taking dev->=
mutex.
> > > > >
> > > > > My gut feeling is that b. is the right answer.
> > > >
> > > > It's been a while since I looked at that code last time, but then i=
t
> > > > has not changed for quite some time too.
> > > >
> > > > It looks like the acpi_device_hotplug() path attempts to acquire
> > > > acpi_scan_lock() while holding dev->mutex which is kind of silly.  =
I
> > > > need to check that, though.
> > >
> > > Thanks for your willingness. Well, it's not quite what you describe. =
If
> > > it was a simple ABBA deadlock, then it would be reported by lockdep.
> > > No, it's more complicated:
> > >
> > > 1. suspend_devices_and_enter() holds acpi_scan_lock,
> > > 2. an ACPI hotplug work runs, but acpi_device_hotplug() goes to sleep
> > >    when it gets to acquiring acpi_scan_lock,
> > > 3. ata_scsi_dev_rescan() submits a SCSI command and waits for its
> > >    completion while holding dev->mutex,
> > > 4. the SCSI completion work happens to be put on the same workqueue a=
s
> > >    the ACPI hotplug work in step 2,
> > >    ^^^--- THIS is how the two events are serialized!
> >
> > Which is unexpected.
> >
> > And quite honestly I'm not sure how this can happen, because
> > acpi_hotplug_schedule() uses a dedicated workqueue and it is called
> > from (a) the "eject" sysfs attribute (which cannot happen while system
> > suspend-resume is in progress) and (b) acpi_bus_notify() which has
> > nothing to do with SCSI.
>
> Oh, you're right, and I was too quick. They cannot be on the same
> queue...
>
> > Maybe the workqueue used for the SCSI completion is freezable?
>
> Yes, that's it:
>
> *(struct workqueue_struct *)0xffff97d240b2fe00 =3D {
> /* ... */
>         .flags =3D (unsigned int)4,
> /* WQ_FREEZABLE            =3D 1 << 2 */
>
> Good. But if this workqueue is frozen, the system still cannot make
> progress.

The problem seems to be that dev->mutex is held while the work item
goes to a freezable workqueue and is waited for, which is an almost
guaranteed deadlock scenario.

