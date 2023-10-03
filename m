Return-Path: <linux-acpi+bounces-356-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6EE47B6678
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Oct 2023 12:33:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 8B3492816D7
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Oct 2023 10:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74344208B9
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Oct 2023 10:33:22 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B94DF4F
	for <linux-acpi@vger.kernel.org>; Tue,  3 Oct 2023 09:39:50 +0000 (UTC)
X-Greylist: delayed 484 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 03 Oct 2023 02:39:48 PDT
Received: from bee.tesarici.cz (bee.tesarici.cz [IPv6:2a03:3b40:fe:2d4::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE7B6A1
	for <linux-acpi@vger.kernel.org>; Tue,  3 Oct 2023 02:39:48 -0700 (PDT)
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id 6713E18D84D;
	Tue,  3 Oct 2023 11:31:37 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=none dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tesarici.cz; s=mail;
	t=1696325497; bh=P+TM8hsW63TpOOR3YRCb5m9FSugqhKVXuZlubU4JFKo=;
	h=Date:From:To:Subject:In-Reply-To:References:From;
	b=BlKo0uiKzGMzXPWz57lQUL5ruXFlQZNkpQ4PAR5kpiY8q4KVixyaprBBlIrTWTZU4
	 cYb7u7YTJ3LIgRDMtpud1J/fV1qt//bhsoDyrVSzVT7STA+FhbUnLLzKoxmijRaK5h
	 EEHD6cu5uOX9AZC7TcLnuR9OrnDxHGQD5oIBGAjENJymcpSUbKp282ZrnD1oSKHj1b
	 tqOmdgvJ9eUcb4hWu5It8dmKGTgS6W3kk4LaDSr2j2LEZbfIt2jTl2o5kW0+81GuqV
	 Gnr9pl756KR3aFqSAETdgSFFcJgG3RjSMjPRoSYXbCG6FlBXVsKUYDxteisNSkTOTP
	 VRue+rJLbSxfQ==
Date: Tue, 3 Oct 2023 11:31:35 +0200
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, "Rafael J.
 Wysocki" <rafael@kernel.org>
Subject: Re: Thinkpad E595 system deadlock on resume from S3
Message-ID: <20231003113135.38384a87@meshulam.tesarici.cz>
In-Reply-To: <20230930122054.3cf727a4@meshulam>
References: <20230930122054.3cf727a4@meshulam>
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
	SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi again (adding more recipients),

On Sat, 30 Sep 2023 12:20:54 +0200
Petr Tesa=C5=99=C3=ADk <petr@tesarici.cz> wrote:

> Hi all,
>=20
> this time no patch (yet). In short, my Thinkpad running v6.6-rc3 fails
> to resume from S3. It also fails the same way with Tumbleweed v6.5
> kernel. I was able to capture a crash dump of the v6.5 kernel, and
> here's my analysis:
>=20
> The system never gets to waking up my SATA SSD disk:
>=20
> [0:0:0:0]    disk    ATA      KINGSTON SEDC600 H5.1  /dev/sda=20
>=20
> There is a pending resume work for kworker/u32:12 (PID 11032), but this
> worker is stuck in 'D' state:
>=20
> >>> prog.stack_trace(11032) =20
> #0  context_switch (../kernel/sched/core.c:5381:2)
> #1  __schedule (../kernel/sched/core.c:6710:8)
> #2  schedule (../kernel/sched/core.c:6786:3)
> #3  schedule_preempt_disabled (../kernel/sched/core.c:6845:2)
> #4  __mutex_lock_common (../kernel/locking/mutex.c:679:3)
> #5  __mutex_lock (../kernel/locking/mutex.c:747:9)
> #6  acpi_device_hotplug (../drivers/acpi/scan.c:382:2)
> #7  acpi_hotplug_work_fn (../drivers/acpi/osl.c:1162:2)
> #8  process_one_work (../kernel/workqueue.c:2600:2)
> #9  worker_thread (../kernel/workqueue.c:2751:4)
> #10 kthread (../kernel/kthread.c:389:9)
> #11 ret_from_fork (../arch/x86/kernel/process.c:145:3)
> #12 ret_from_fork_asm+0x1b/0x20 (../arch/x86/entry/entry_64.S:304)
>=20
> acpi_device_hotplug() tries to acquire acpi_scan_lock, which is held by
> systemd-sleep (PID 11002). This task is also in 'D' state:
>=20
> >>> prog.stack_trace(11002) =20
> #0  context_switch (../kernel/sched/core.c:5381:2)
> #1  __schedule (../kernel/sched/core.c:6710:8)
> #2  schedule (../kernel/sched/core.c:6786:3)
> #3  schedule_preempt_disabled (../kernel/sched/core.c:6845:2)
> #4  __mutex_lock_common (../kernel/locking/mutex.c:679:3)
> #5  __mutex_lock (../kernel/locking/mutex.c:747:9)
> #6  device_lock (../include/linux/device.h:958:2)
> #7  device_complete (../drivers/base/power/main.c:1063:2)
> #8  dpm_complete (../drivers/base/power/main.c:1121:3)
> #9  suspend_devices_and_enter (../kernel/power/suspend.c:516:2)

I believe the issue must be somewhere here. The whole suspend and
resume logic in suspend_devices_and_enter() is framed by
platform_suspend_begin() and platform_resume_end().

My system is an ACPI system, so suspend_ops contains:

	.begin =3D acpi_suspend_begin,
	.end =3D acpi_pm_end,

Now, acpi_suspend_begin() acquires acpi_scan_lock through
acpi_pm_start(), and the lock is not released until acpi_pm_end().
Since dpm_complete() waits for the completion of a work that tries to
acquire acpi_scan_lock, the system will deadlock.

AFAICS either:

a. the ACPI lock cannot be held while dpm_complete() runs, or
b. ata_scsi_dev_rescan() must not be scheduled before the system is
resumed, or
c. acpi_device_hotplug() must be implemented without taking dev->mutex.

My gut feeling is that b. is the right answer.

I'm afraid I can't contribute too much more ATM, at least not before I
find out what broke my USB hub between rc3 and rc4.

Regards
Petr T

> #10 enter_state (../kernel/power/suspend.c:592:10)
> #11 pm_suspend (../kernel/power/suspend.c:619:10)
> #12 state_store (../kernel/power/main.c:707:11)
> #13 kernfs_fop_write_iter (../fs/kernfs/file.c:334:9)
> #14 call_write_iter (../include/linux/fs.h:1877:9)
> #15 new_sync_write (../fs/read_write.c:491:8)
> #16 vfs_write (../fs/read_write.c:584:9)
> #17 ksys_write (../fs/read_write.c:637:9)
> #18 do_syscall_x64 (../arch/x86/entry/common.c:50:14)
> #19 do_syscall_64 (../arch/x86/entry/common.c:80:7)
> #20 entry_SYSCALL_64+0xaa/0x1a6 (../arch/x86/entry/entry_64.S:120)
>=20
> It is trying to acquire dev->mutex, which is in turn held by
> kworker/0:0 (PID 10830), also in 'D' state:
>=20
> >>> prog.stack_trace(10830) =20
> #0  context_switch (../kernel/sched/core.c:5381:2)
> #1  __schedule (../kernel/sched/core.c:6710:8)
> #2  schedule (../kernel/sched/core.c:6786:3)
> #3  blk_queue_enter (../block/blk-core.c:326:3)
> #4  blk_mq_alloc_request (../block/blk-mq.c:592:9)
> #5  scsi_alloc_request (../drivers/scsi/scsi_lib.c:1139:7)
> #6  scsi_execute_cmd (../drivers/scsi/scsi_lib.c:217:8)
> #7  scsi_vpd_inquiry (../drivers/scsi/scsi.c:312:11)
> #8  scsi_get_vpd_size (../drivers/scsi/scsi.c:345:11)
> #9  scsi_get_vpd_size (../drivers/scsi/scsi.c:336:5)
> #10 scsi_get_vpd_buf (../drivers/scsi/scsi.c:415:12)
> #11 scsi_attach_vpd (../drivers/scsi/scsi.c:483:12)
> #12 scsi_rescan_device (../drivers/scsi/scsi_scan.c:1628:2)
> #13 ata_scsi_dev_rescan (../drivers/ata/libata-scsi.c:4894:4)
> #14 process_one_work (../kernel/workqueue.c:2600:2)
> #15 worker_thread (../kernel/workqueue.c:2751:4)
> #16 kthread (../kernel/kthread.c:389:9)
> #17 ret_from_fork (../arch/x86/kernel/process.c:145:3)
> #18 ret_from_fork_asm+0x1b/0x20 (../arch/x86/entry/entry_64.S:304)
>=20
> And here we are, waiting for the completion of the resume work that is
> scheduled on the blocked kworker/u32:12 (PID 11032), see above.
>=20
> FWIW the deadlock does not happen if autosuspend is turned off for this
> disk.
>=20
> I'm willing to invest more time into debugging, but I'm not well-versed
> in power management, so I may need some help from you as to what else I
> should look at. Please, include me in Cc of all potential replies; I'm
> not subscribed to linux-pm.
>=20
> Petr T


