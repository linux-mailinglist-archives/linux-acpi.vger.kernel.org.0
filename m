Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36A8E285409
	for <lists+linux-acpi@lfdr.de>; Tue,  6 Oct 2020 23:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbgJFVtb (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 6 Oct 2020 17:49:31 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39164 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726668AbgJFVta (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 6 Oct 2020 17:49:30 -0400
Date:   Tue, 6 Oct 2020 23:49:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602020968;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wLExEVGZHnixuPxldWLoYuOXnjhKVAwnQQdvjmNvv6k=;
        b=GoXQ2/PesXmj2YlEFR2VG3y0C/qrbcKsmHP62AcCv32RWac5d+CQoG2xgjdyLLUv53dLZC
        d3Pm2H+BMV+vyh7NpsVuA9ZgoFLadv1tgt4biwsDZuA9yNQyQJtyOl36pCDbFJ8NAzJg29
        kOz8zjB7sJV39ELH9IS0yVUYtGkqceGHcFW7Y2gx+sVLmdNPucddomhP3/gynugvvbxdvo
        RIECjxIGjbEQ3seeEVYAAgX4AR+rTlQMDqyqEZ1Kd+5x+iSUMIM7ZsU7wEMBODgMKb2uHk
        2Tq4lNK323jMy4glfCMtPPzf0l0OfFSTX2lvmSsvPVycnAm5xtY0GblVKSyztQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602020968;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wLExEVGZHnixuPxldWLoYuOXnjhKVAwnQQdvjmNvv6k=;
        b=DzUbLG9QQwTXf/THyOyoi3ZR5QzdfED3L4/PunJuZ7f/e5PhnyjLfC/XWUzQqYtD7bvO1s
        Qmo6QQEz3QbblNDQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Stephen Berman <stephen.berman@gmx.net>,
        Zhang Rui <rui.zhang@intel.com>,
        Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>
Subject: Re: power-off delay/hang due to commit 6d25be57 (mainline)
Message-ID: <20201006214927.4nsqtfji4fdv3oed@linutronix.de>
References: <20200714134410.3odqfvjq6rndjjf6@linutronix.de>
 <CAJZ5v0hZSUkEMCszDADGWk-v0xNEiDE45B3CHLi05BX6rPfm6g@mail.gmail.com>
 <20200714141135.47adndrsdgpiqfy4@linutronix.de>
 <87blkbx1gt.fsf@gmx.net>
 <87imdp5r80.fsf@rub.de>
 <20200811132955.wbt55ns7bu5mxouq@linutronix.de>
 <CAJZ5v0h+n9VCz5=VixVbe_b=ZbTU3D=46stGhE9z7Y7yaUMJzw@mail.gmail.com>
 <20200811152551.dmfw46urecbmeklr@linutronix.de>
 <87ft8tayic.fsf@gmx.net>
 <20200811184902.2fm4eyprmpkfon2j@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200811184902.2fm4eyprmpkfon2j@linutronix.de>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2020-08-11 20:49:05 [+0200], To Stephen Berman wrote:
> On 2020-08-11 19:22:19 [+0200], Stephen Berman wrote:
> > Attached.
>=20
> ssdt6.dsl:
> |  ThermalZone (TZ10)
> |  {
> =E2=80=A6
> |      Method (_TSP, 0, Serialized)  // _TSP: Thermal Sampling Period
> |      {
> |          Return (0x0A)
> |      }
> |
> |      Method (_TZP, 0, Serialized)  // _TZP: Thermal Zone Polling
> |      {
> |          Return (0x0A)
> |      }
> |
> |      Method (_TMP, 0, Serialized)  // _TMP: Temperature
> |      {
> |          \GSA1.ZRC3 ()
> |          Sleep (0x03E8)
> |          Notify (\_TZ.TZ10, 0x81) // Thermal Trip Point Change
> |          Return (0x0B54)
> |      }
>=20
> So if I read this correctly then TZ10 should be polled every second
> (check) and the temperature function contains a `sleep(1 second)' (which
> explains the mysteries delay) followed by the Notify() (which schedules
> the worker).
>=20
> > Done as Bug 208877.

Rafael, do you have any suggestions?
=20
Sebastian
