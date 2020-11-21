Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC84C2BC23E
	for <lists+linux-acpi@lfdr.de>; Sat, 21 Nov 2020 22:19:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728403AbgKUVTA (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 21 Nov 2020 16:19:00 -0500
Received: from mail-02.mail-europe.com ([51.89.119.103]:55792 "EHLO
        mail-02.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728402AbgKUVTA (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 21 Nov 2020 16:19:00 -0500
Date:   Sat, 21 Nov 2020 21:18:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1605993535;
        bh=yC9/J00wsdt87zvT5U4ngG4KDAlRMwKTW87Bo/OMRzM=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=HmRQT9Fm0k769ReZnIqDDSw00xoQyB9QEW7zxfcQ5GKDvsBQ/LeEJCocNBkaXr4AV
         /eAlxOVbKq88EPq0qVUINl7bLZcEG7GM8eemmGK0R66lxUFJQXTTXiyXAeDVRkWkO0
         nlX++SVj9Vvza9VRAwEz5DVMJPZFrZis93n3Qw50=
To:     Hans de Goede <hdegoede@redhat.com>
From:   =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Cc:     Mark Pearson <markpearson@lenovo.com>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "mario.limonciello@dell.com" <mario.limonciello@dell.com>,
        "eliadevito@gmail.com" <eliadevito@gmail.com>,
        "hadess@hadess.net" <hadess@hadess.net>,
        "bberg@redhat.com" <bberg@redhat.com>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "dvhart@infradead.org" <dvhart@infradead.org>
Reply-To: =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Subject: Re: [PATCH v3] ACPI: platform-profile: Add platform profile support
Message-ID: <8c3pjwAeJVjl5ZLmnajCVHjcyBjoQeQTupHqZZostKJt3YZ0seAAvD-UIcBYFAFUNjsi0iWrEBNfX1l0tqN-4x07TGQbsiOMEqCpPAxgqJQ=@protonmail.com>
In-Reply-To: <761671b3-ad26-230b-e709-05ce3bd69498@redhat.com>
References: <markpearson@lenovo.com> <20201115004402.342838-1-markpearson@lenovo.com> <nRyY5CKaU6WrkbMiM25gTT_bJlrQjTY_UCcQkj8ty-2mPEMVZd4BB9KwrRp7z4GaE3TTOFCXuXnt0_7J_Tj50syusBxTmS5yNZAvYX02X74=@protonmail.com> <761671b3-ad26-230b-e709-05ce3bd69498@redhat.com>
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

2020. november 21., szombat 15:27 keltez=C3=A9ssel, Hans de Goede =C3=ADrta=
:

> [...]
> > I just realized that the sysfs attributes are only created if a profile=
 provider
> > is registered, and it is removed when the provide unregisters itself. I=
 believe
> > it would be easier for system daemons if those attributes existed from =
module load
> > to module unload since they can just just open the file and watch it us=
ing poll,
> > select, etc. If it goes away when the provider unregisters itself, then=
 I believe
> > a more complicated mechanism (like inotify) would need to be implemente=
d in the
> > daemons to be notified when a new provider is registered. Thus my sugge=
stion
> > for the next iteration is to create the sysfs attributes on module load=
,
> > and delete them on unload.
> >
> > What do you think?
>
> Actually I asked Mark to move this to the register / unregister time sinc=
e
> having a non functioning files in sysfs is a bit weird.
> [...]

Ahh, I didn't know that, sorry. If a non-functioning sysfs attribute is a p=
roblem,
then there is another option: `platform_profile_choices` is always present;
if no provider is registered, it's empty. If a provider is (un)registered,
then `platform_profile_choices` is sysfs_notify()-ed. `platform_profile`
only exists while a provider is registered, so it is created on provider
registration and unregistered on provider unregistration.


Regards,
Barnab=C3=A1s P=C5=91cze

