Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D53A82BB5EE
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Nov 2020 20:53:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729504AbgKTTu6 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 20 Nov 2020 14:50:58 -0500
Received: from mail-02.mail-europe.com ([51.89.119.103]:35768 "EHLO
        mail-02.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729404AbgKTTu6 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 20 Nov 2020 14:50:58 -0500
Date:   Fri, 20 Nov 2020 19:50:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1605901854;
        bh=M2jHYTpwpp+g8gc1TsXXlWC/UVccnbY0a1aU0LGckOU=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=vw6emZtPcSedSwynDg1H4xwuG0ou9bK/nHmchsP9Z0TrJRipXF5XpBUgWfOokKW0K
         R8ue6Ti25Lgq3XXvIhZNZ8OdljTTQkrsiBsbcpJrQkfFRqqbN/kh/HNe6NHMrpHMtv
         O4x8CPRftFYWgS/QnKWsGtXoEFvVvLPywEyYMe3o=
To:     Mark Pearson <markpearson@lenovo.com>
From:   =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Cc:     "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
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
Message-ID: <nRyY5CKaU6WrkbMiM25gTT_bJlrQjTY_UCcQkj8ty-2mPEMVZd4BB9KwrRp7z4GaE3TTOFCXuXnt0_7J_Tj50syusBxTmS5yNZAvYX02X74=@protonmail.com>
In-Reply-To: <20201115004402.342838-1-markpearson@lenovo.com>
References: <markpearson@lenovo.com> <20201115004402.342838-1-markpearson@lenovo.com>
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


2020. november 15., vas=C3=A1rnap 1:44 keltez=C3=A9ssel, Mark Pearson =
=C3=ADrta:

> [...]
> +int platform_profile_register(struct platform_profile_handler *pprof)
> +{
> +=09mutex_lock(&profile_lock);
> +=09/* We can only have one active profile */
> +=09if (cur_profile) {
> +=09=09mutex_unlock(&profile_lock);
> +=09=09return -EEXIST;
> +=09}
> +
> +=09cur_profile =3D pprof;
> +=09mutex_unlock(&profile_lock);
> +=09return sysfs_create_group(acpi_kobj, &platform_profile_group);
> +}
> +EXPORT_SYMBOL_GPL(platform_profile_register);
> +
> +int platform_profile_unregister(void)
> +{
> +=09mutex_lock(&profile_lock);
> +=09sysfs_remove_group(acpi_kobj, &platform_profile_group);
> +=09cur_profile =3D NULL;
> +=09mutex_unlock(&profile_lock);
> +=09return 0;
> +}
> +EXPORT_SYMBOL_GPL(platform_profile_unregister);
> [...]


I just realized that the sysfs attributes are only created if a profile pro=
vider
is registered, and it is removed when the provide unregisters itself. I bel=
ieve
it would be easier for system daemons if those attributes existed from modu=
le load
to module unload since they can just just open the file and watch it using =
poll,
select, etc. If it goes away when the provider unregisters itself, then I b=
elieve
a more complicated mechanism (like inotify) would need to be implemented in=
 the
daemons to be notified when a new provider is registered. Thus my suggestio=
n
for the next iteration is to create the sysfs attributes on module load,
and delete them on unload.

What do you think?


Regards,
Barnab=C3=A1s P=C5=91cze
