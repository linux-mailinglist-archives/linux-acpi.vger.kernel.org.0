Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37DBB2419B6
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Aug 2020 12:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728456AbgHKK1o (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 11 Aug 2020 06:27:44 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57080 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728660AbgHKK1j (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 11 Aug 2020 06:27:39 -0400
Date:   Tue, 11 Aug 2020 12:27:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597141657;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jp00Rr/a4cDX95tUyF9kFZf8y43Q4hOeQjwY+IySvJE=;
        b=zkqeyvORSehZ1011o/jDBzYfgqEUWc7nSPhc+cuBiFnjrp59giKDvUWCHYXLdYT7f+2dVD
        +KtbUyoVte8z13xRz83p3Ps1FtHWO4nwlx+h9OMbbm24O7q/lEl7/FfX9Fat05KIlNDyD7
        vvw580NH77BBXxuB/MQfAPfSlwcyPaAE3xF/IKRKt333j05+15uH0YYwMga9s3u+9zE14E
        cXb9TfhLjljNhI6L+MiD6qnx8yXP21r6LxEIuFU8pw17GYR1MGgV8skNP1aB/GT5ne/4oG
        r7qri2wm18w7p53BsGT1LM0AKtS8Tqa78TDqvhlMZK7YcT6gGMu2GZGiEvEWqQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597141657;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jp00Rr/a4cDX95tUyF9kFZf8y43Q4hOeQjwY+IySvJE=;
        b=uRP3HjIjqKMTFF8Zk9/NrdRmUpb/WYsuP90kV8dQfAPvbaKiVMr614nI4JvggAfYdBb5PF
        90QeXgwmEsUE0ZAQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Stephen Berman <stephen.berman@gmx.net>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>
Subject: Re: power-off delay/hang due to commit 6d25be57 (mainline)
Message-ID: <20200811102735.yifejbx62ewzpfcs@linutronix.de>
References: <20200616155501.psduxnisltitodme@linutronix.de>
 <871rmesqkk.fsf@gmx.net>
 <20200617142734.mxwfoblufmo6li5e@linutronix.de>
 <87ftatqu07.fsf@gmx.net>
 <20200624201156.xu6hel3drnhno6c3@linutronix.de>
 <87ftak2kxr.fsf@rub.de>
 <20200714134410.3odqfvjq6rndjjf6@linutronix.de>
 <CAJZ5v0hZSUkEMCszDADGWk-v0xNEiDE45B3CHLi05BX6rPfm6g@mail.gmail.com>
 <20200714141135.47adndrsdgpiqfy4@linutronix.de>
 <CAJZ5v0iogereapmhcFi=iXHsjnzmC26mewUSTY3+5O3ei5kfDQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAJZ5v0iogereapmhcFi=iXHsjnzmC26mewUSTY3+5O3ei5kfDQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2020-07-14 17:53:15 [+0200], Rafael J. Wysocki wrote:
> acpi_evaluate_integer() doesn't show up in the trace, though, AFAICS.
>=20
> > I assumed acpi_ex_opcode_2A_0T_0R() since the other
> > candidate was acpi_ev_asynch_execute_gpe_method().
>=20
> Which probably is the case.  Specifically
>=20
> acpi_ev_asynch_execute_gpe_method: Evaluate _L66
>=20
> is likely to cause the Notify() to be dispatched.
=E2=80=A6
> > Rafael, are you also interested in an ACPI dump?
>=20
> That might help a bit.
>=20
> So what probably happens is that poking at the TZ causes a GPE to
> trigger and a Notify() to be dispatched which then goes into the
> workqueue for execution.
>=20
> Now, I'm not sure what happens to those Notify() items, though.  They
> each should cause a handler (in the thermal driver) to be executed,
> but does that happen?

Stephen's trace contains a few backtraces, all of them look like this:

| Call Trace:
|  acpi_ex_opcode_2A_0T_0R+0x93/0xdf
|  acpi_ds_exec_end_op+0x10d/0x701
|  acpi_ps_parse_loop+0x7f2/0x8c3
|  acpi_ps_parse_aml+0x1a5/0x540
|  acpi_ps_execute_method+0x1fe/0x2ba
|  acpi_ns_evaluate+0x345/0x4e2
|  acpi_evaluate_object+0x177/0x39f
|  acpi_evaluate_integer+0x4f/0x110
|  acpi_thermal_get_temperature.part.0+0x45/0xc4
|  thermal_get_temp.cold+0xc/0x2e
|  thermal_zone_get_temp+0x4c/0x70
|  thermal_zone_device_update.part.0+0x2a/0x110
|  acpi_thermal_notify+0xcf/0x140
|  acpi_ev_notify_dispatch+0x45/0x5a
|  acpi_os_execute_deferred_notify+0x34/0x60
|  process_one_work+0x1d2/0x3a0
|  worker_thread+0x45/0x3c0
|  kthread+0xf6/0x130
|  ret_from_fork+0x35/0x40

so no GPE and it comes the notify callback while parsing the ACPI table.
Any ideas? I guess acpi_ex_opcode_2A_0T_0R() uses the workqueue because
it may sleep and it might be invoked from non-preemptible context.

Sebastian
