Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3F772C6E9E
	for <lists+linux-acpi@lfdr.de>; Sat, 28 Nov 2020 04:21:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730776AbgK1DTD (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 27 Nov 2020 22:19:03 -0500
Received: from mail-41103.protonmail.ch ([185.70.41.103]:62150 "EHLO
        mail-41103.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730575AbgK0Tzy (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 27 Nov 2020 14:55:54 -0500
Received: from mail-02.mail-europe.com (mail-02.mail-europe.com [51.89.119.103])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        by mail-41103.protonmail.ch (Postfix) with ESMTPS id 26904200FFD4
        for <linux-acpi@vger.kernel.org>; Fri, 27 Nov 2020 19:25:04 +0000 (UTC)
Authentication-Results: mail-41103.protonmail.ch;
        dkim=pass (1024-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="p6rEVoVz"
Date:   Fri, 27 Nov 2020 19:22:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1606504981;
        bh=JA3R5kNZdeDaHj0Hz7a5oZ95EFWkeaJZqlDY0+PxPXU=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=p6rEVoVzdm57x+PHGSfKeTEp6AMvESTLYZxoP78SjXsn0PLJ+LRqurWKSy0CuoseF
         XvvVdm6B8+EH7zYyvIrmeOuoO3z8jqvw+FtDjz7MXHfbflzh1XEaqWsvUx93GdAbEC
         VVc1sAkT7VP9zjxPgXaxoA3+cq5zzWSh4S97JT3w=
To:     Mark Pearson <markpearson@lenovo.com>
From:   =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Cc:     "hdegoede@redhat.com" <hdegoede@redhat.com>,
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
Message-ID: <ioprVbNER4h0HTVvyj2ElXiuNaSPjl8ycgp4XtOtj-Iwe4_6qnNRLYuvxIJKE2ULGPTRURY-1Dr9plCocTnx2S_ugBn7INWZScnn4-pTq4c=@protonmail.com>
In-Reply-To: <20201126165143.32776-3-markpearson@lenovo.com>
References: <markpearson@lenovo.com> <20201126165143.32776-1-markpearson@lenovo.com> <20201126165143.32776-3-markpearson@lenovo.com>
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


2020. november 26., cs=C3=BCt=C3=B6rt=C3=B6k 17:51 keltez=C3=A9ssel, Mark P=
earson =C3=ADrta:

> [...]
> +static bool dytc_ignore_next_event;

As a sidenote: can the profile switching be triggered by means that's not t=
he
`/sys/firmware/acpi/platform_profile` attribute (e.g. a physical button)?
Because if so, then I'm not sure if `dytc_ignore_next_event` achieves its p=
urpose
robustly, although I believe it won't cause issues in practice. I think it =
could
be made more robust using a mutex to serialize and synchronize access to th=
e DYTC
interface, but I'm not sure if the effort is worth it.


> +static bool dytc_profile_available;
> +static enum platform_profile_option dytc_current_profile;
> [...]
> +static int tpacpi_dytc_profile_init(struct ibm_init_struct *iibm)
> +{
> +=09int err, output;
> +
> +=09dytc_profile_available =3D false;
> +=09dytc_ignore_next_event =3D false;
> +
> +=09err =3D dytc_command(DYTC_CMD_QUERY, &output);
> +=09/*
> +=09 * If support isn't available (ENODEV) then don't return an error
> +=09 * and don't create the sysfs group
> +=09 */
> +=09if (err =3D=3D -ENODEV)
> +=09=09return 0;
> +=09/* For all other errors we can flag the failure */
> +=09if (err)
> +=09=09return err;
> +
> +=09/* Check DYTC is enabled and supports mode setting */
> +=09if (output & BIT(DYTC_QUERY_ENABLE_BIT)) {
> +=09=09/* Only DYTC v5.0 and later has this feature. */
> +=09=09int dytc_version;
> +
> +=09=09dytc_version =3D (output >> DYTC_QUERY_REV_BIT) & 0xF;
> +=09=09if (dytc_version >=3D 5) {
> +=09=09=09dbg_printk(TPACPI_DBG_INIT,
> +=09=09=09=09   "DYTC version %d: thermal mode available\n", dytc_version=
);
> +=09=09=09/* Create platform_profile structure and register */
> +=09=09=09do {
> +=09=09=09=09err =3D platform_profile_register(&dytc_profile);
> +=09=09=09} while (err =3D=3D -EINTR);
> [...]

I'm wondering if this loop is really necessary?


Regards,
Barnab=C3=A1s P=C5=91cze
