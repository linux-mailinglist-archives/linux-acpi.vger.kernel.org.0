Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00CFE283783
	for <lists+linux-acpi@lfdr.de>; Mon,  5 Oct 2020 16:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725954AbgJEOTX (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 5 Oct 2020 10:19:23 -0400
Received: from mail-41104.protonmail.ch ([185.70.41.104]:60175 "EHLO
        mail-41104.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbgJEOTV (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 5 Oct 2020 10:19:21 -0400
Received: from mail-03.mail-europe.com (mail-03.mail-europe.com [91.134.188.129])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        by mail-41104.protonmail.ch (Postfix) with ESMTPS id 5CAF620090FC
        for <linux-acpi@vger.kernel.org>; Mon,  5 Oct 2020 14:19:19 +0000 (UTC)
Authentication-Results: mail-41104.protonmail.ch;
        dkim=pass (1024-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="aTfwPVgH"
Date:   Mon, 05 Oct 2020 14:19:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1601907556;
        bh=uxAbSn5iuW7/MieJ/5dseSbv7CZpwyQpt5rGrKEUIbI=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=aTfwPVgH+B9AibxU1wj/5tQ/JGcdsBDYi5o7DlUYLmBe3ucy24ssGQ2Vip9E79drh
         y6PY0wOsGOrqQZjEPIF6x4MXlp/kHlI1vfsSNDpTUOIZolTjIWU3qYZRToIl63gbbY
         3CR7oaGJ7Bh0dfF/f/2dH8trNijKyZ/W3O0tK0gQ=
To:     "Limonciello, Mario" <Mario.Limonciello@dell.com>
From:   =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Mark Gross <mgross@linux.intel.com>,
        Mark Pearson <mpearson@lenovo.com>,
        Elia Devito <eliadevito@gmail.com>,
        Bastien Nocera <hadess@hadess.net>,
        Benjamin Berg <bberg@redhat.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Pearson <markpearson@lenovo.com>
Reply-To: =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Subject: RE: [RFC] Documentation: Add documentation for new performance_profile sysfs class
Message-ID: <Mz2G7glm3yMTniKA6SHM011dDkTFF4_otICrMQfVLheopX8JMGSupPleyjyK8OY0tyUazu09nX7XhleBVdl4ozTCWXCPGyvV58Qc-UUTvig=@protonmail.com>
In-Reply-To: <DM6PR19MB263669227D122BB7699951E6FA0C0@DM6PR19MB2636.namprd19.prod.outlook.com>
References: <20201003131938.9426-1-hdegoede@redhat.com> <20201003131938.9426-2-hdegoede@redhat.com> <DM6PR19MB263669227D122BB7699951E6FA0C0@DM6PR19MB2636.namprd19.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi


2020. okt=C3=B3ber 5., h=C3=A9tf=C5=91 14:58 keltez=C3=A9ssel, Limonciello,=
 Mario =C3=ADrta:
> > On modern systems CPU/GPU/... performance is often dynamically configur=
able
> > in the form of e.g. variable clock-speeds and TPD. The performance is o=
ften
> > automatically adjusted to the load by some automatic-mechanism (which m=
ay
> > very well live outside the kernel).
> > These auto performance-adjustment mechanisms often can be configured wi=
th
> > one of several performance-profiles, with either a bias towards low-pow=
er
> > consumption (and cool and quiet) or towards performance (and higher pow=
er
> > consumption and thermals).
> > Introduce a new performance_profile class/sysfs API which offers a gene=
ric
> > API for selecting the performance-profile of these automatic-mechanisms=
.
>
> If introducing an API for this - let me ask the question, why even let ea=
ch
> driver offer a class interface and userspace need to change "each" driver=
's
> performance setting?
>
> I would think that you could just offer something kernel-wide like
> /sys/power/performance-profile
>
> Userspace can read and write to a single file. All drivers can get notifi=
ed
> on this sysfs file changing.
>

That makes sense, in my opinion, from the regular user's perspective:
one switch to rule them all, no fuss. However, I don't think that scales we=
ll.
What if the hypothetical users wants to run a CPU-heavy workload, and thus =
wants
to put the GPU into "low-power" mode and the CPU into "performance" mode? W=
hat if
the users wants to put one GPU into "low-power" mode, but the other one int=
o
"performance"? With the current specification, the user's needs could be ea=
sily
satisfied. I don't see how that's possible with a single switch. Nonetheles=
s, I think
that a single global switch *in addition* to the class devices could possib=
ly
simplify the userspace-kernel interaction for most users.


> The systems that react in firmware (such as the two that prompted
> this discussion) can change at that time. It leaves the possibility for a
> more open kernel implementation that can do the same thing though too by
> directly modifying device registers instead of ACPI devices.
>

Excuse my ignorance, but I don't really see why this interface would be tie=
d to
ACPI devices? Why is it not possible to write a driver that implements this=
 interface
and directly modifies device registers? Am I missing something obvious here=
?


> [...]


Thanks,
Barnab=C3=A1s P=C5=91cze
