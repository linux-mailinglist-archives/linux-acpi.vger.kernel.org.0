Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52AFA2C72AC
	for <lists+linux-acpi@lfdr.de>; Sat, 28 Nov 2020 23:09:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbgK1VuO (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 28 Nov 2020 16:50:14 -0500
Received: from mail-41104.protonmail.ch ([185.70.41.104]:15240 "EHLO
        mail-41104.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729360AbgK1S0U (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Nov 2020 13:26:20 -0500
Received: from mail-03.mail-europe.com (mail-03.mail-europe.com [91.134.188.129])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        by mail-41104.protonmail.ch (Postfix) with ESMTPS id 916C82004166;
        Sat, 28 Nov 2020 15:59:55 +0000 (UTC)
Authentication-Results: mail-41104.protonmail.ch;
        dkim=pass (1024-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="jf3/AZVL"
Date:   Sat, 28 Nov 2020 15:59:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1606579191;
        bh=nCw14+eeRE2dWy7T+MmkCMBCycxMTZVyvYRhCJzD/Sg=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=jf3/AZVLT3/Ws+H7k03k9RHrcl4g6ZiznjMjIK9RbTVHSq5FpgmbzXaPlLfYkBMZ7
         1wGsdyIHUWmk3zouyx+1cv/iIxV8VKN/alU4Ut6r+Gt1FFGtq7JcJZAQlzwYwQiqRc
         sotrnH5tE3Gj/Yf7n5aR2QCavl5QaGfMuWk9ukfo=
To:     Hans de Goede <hdegoede@redhat.com>
From:   =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Cc:     Mark Pearson <markpearson@lenovo.com>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "hadess@hadess.net" <hadess@hadess.net>,
        "mario.limnociello@dell.com" <mario.limnociello@dell.com>,
        "eliadevito@gmail.com" <eliadevito@gmail.com>,
        "bberg@redhat.com" <bberg@redhat.com>,
        "dvhart@infradead.org" <dvhart@infradead.org>
Reply-To: =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Subject: Re: [PATCH v4 3/3] platform/x86: thinkpad_acpi: Add platform profile support
Message-ID: <TdKdryhtwENRgSeQDP9Wa26xQkjONAjw8_sG43rTWK-z30pshFInUWuucPKhaX3qI7yirOqIbyMCMpRnA6sDJewK0b1VJP3z3vy9eBeI2n0=@protonmail.com>
In-Reply-To: <8e738a62-2d1b-0357-7ef6-fb080d365064@redhat.com>
References: <markpearson@lenovo.com> <20201126165143.32776-1-markpearson@lenovo.com> <20201126165143.32776-3-markpearson@lenovo.com> <ioprVbNER4h0HTVvyj2ElXiuNaSPjl8ycgp4XtOtj-Iwe4_6qnNRLYuvxIJKE2ULGPTRURY-1Dr9plCocTnx2S_ugBn7INWZScnn4-pTq4c=@protonmail.com> <8e738a62-2d1b-0357-7ef6-fb080d365064@redhat.com>
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


2020. november 28., szombat 16:00 keltez=C3=A9ssel, Hans de Goede <hdegoede=
@redhat.com> =C3=ADrta:

> [...]
> >> +static int tpacpi_dytc_profile_init(struct ibm_init_struct *iibm)
> >> +{
> >> +=09int err, output;
> >> +
> >> +=09dytc_profile_available =3D false;
> >> +=09dytc_ignore_next_event =3D false;
> >> +
> >> +=09err =3D dytc_command(DYTC_CMD_QUERY, &output);
> >> +=09/*
> >> +=09 * If support isn't available (ENODEV) then don't return an error
> >> +=09 * and don't create the sysfs group
> >> +=09 */
> >> +=09if (err =3D=3D -ENODEV)
> >> +=09=09return 0;
> >> +=09/* For all other errors we can flag the failure */
> >> +=09if (err)
> >> +=09=09return err;
> >> +
> >> +=09/* Check DYTC is enabled and supports mode setting */
> >> +=09if (output & BIT(DYTC_QUERY_ENABLE_BIT)) {
> >> +=09=09/* Only DYTC v5.0 and later has this feature. */
> >> +=09=09int dytc_version;
> >> +
> >> +=09=09dytc_version =3D (output >> DYTC_QUERY_REV_BIT) & 0xF;
> >> +=09=09if (dytc_version >=3D 5) {
> >> +=09=09=09dbg_printk(TPACPI_DBG_INIT,
> >> +=09=09=09=09   "DYTC version %d: thermal mode available\n", dytc_vers=
ion);
> >> +=09=09=09/* Create platform_profile structure and register */
> >> +=09=09=09do {
> >> +=09=09=09=09err =3D platform_profile_register(&dytc_profile);
> >> +=09=09=09} while (err =3D=3D -EINTR);
> >> [...]
> >
> > I'm wondering if this loop is really necessary?
>
> It is the result of using mutex_interruptible inside platform_profile_reg=
ister(),
> once that is fixed (as I just requested in my review of patch 2/3) then t=
his loop
> can go away.
>

Thank you, I see that, my question should've been "why not simply fail and
return the error?", but with your requested change the question is moot.


Regards,
Barnab=C3=A1s P=C5=91cze
