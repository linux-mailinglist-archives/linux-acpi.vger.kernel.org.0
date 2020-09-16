Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5962126C5F6
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Sep 2020 19:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbgIPR0u (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 16 Sep 2020 13:26:50 -0400
Received: from mail-41103.protonmail.ch ([185.70.41.103]:36783 "EHLO
        mail-41103.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726753AbgIPR0Z (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Sep 2020 13:26:25 -0400
X-Greylist: delayed 474 seconds by postgrey-1.27 at vger.kernel.org; Wed, 16 Sep 2020 13:26:20 EDT
Received: from mail-02.mail-europe.com (mail-02.mail-europe.com [51.89.119.103])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        by mail-41103.protonmail.ch (Postfix) with ESMTPS id 645FF2000BCB
        for <linux-acpi@vger.kernel.org>; Wed, 16 Sep 2020 17:15:48 +0000 (UTC)
Authentication-Results: mail-41103.protonmail.ch;
        dkim=pass (1024-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="N/9TNTrm"
Date:   Wed, 16 Sep 2020 17:13:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1600276424;
        bh=JfkCiR3nTJ/mdPJVdjMM9tXvtGnx5GT9uY15VG5lKb0=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=N/9TNTrm9BtFqruRuDqqSr/Z9jGECDWmWmIR4RsXQ8uXue0NKZL1BDjIWc/NuJsJ8
         d/loYpd5gGOzPxxD5w+aloSXe/W8sS2BE686fh3QQCX7ldI0DI/bsNcUKZMjceU/HU
         zau0B5DpWHPUb859f7zTKg32v1rfC3o72KEWUGMQ=
To:     Maximilian Luz <luzmaximilian@gmail.com>
From:   =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Gayatri Kammela <gayatri.kammela@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Reply-To: =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Subject: Re: [PATCH v2] platform/x86: Add Driver to set up lid GPEs on MS Surface device
Message-ID: <ID5eml6LsB6tCDrZwhbfin228LE3cor6ZEYbAHj6C3SZ9y0AcL40SWweP-iAjmEpCeEV5NZHJLKBpUo5qw1VR0Q7xOXAVSH7epRjTRkj64Y=@protonmail.com>
In-Reply-To: <355dae14-2508-706b-53f8-48b78f84e7cc@gmail.com>
References: <20200910211520.1490626-1-luzmaximilian@gmail.com> <EMZQgUl1xLN4o0hV9ZkCD563O85SuOYB5kNFZ5_hlxLQXbJCXpQfrM2afyFIr28h31tXMxD1mxE4DkA5Wy60A0Z2mDnstwF17tEdnX4IRas=@protonmail.com> <355dae14-2508-706b-53f8-48b78f84e7cc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

2020. szeptember 16., szerda 3:22 keltez=C3=A9ssel, Maximilian Luz =C3=
=ADrta:
> [...]
> >> +static int surface_lid_enable_wakeup(struct device *dev, bool enable)
> >> +{
> >> +=09const struct surface_lid_device *lid =3D dev_get_drvdata(dev);
> >> +=09int action =3D enable ? ACPI_GPE_ENABLE : ACPI_GPE_DISABLE;
> >> +=09acpi_status status;
> >> +
> >> +=09status =3D acpi_set_gpe_wake_mask(NULL, lid->gpe_number, action);
> >> +=09if (status) {
> >
> > I think 'if (ACPI_FAILURE(status))' would be better.
>
> Okay, I'll change that (here and below).
>
> >> +=09=09dev_err(dev, "failed to set GPE wake mask: %d\n", status);
> >
> > I'm not sure if it's technically safe to print acpi_status with the %d =
format
> > specifier since 'acpi_status' is defined as 'u32' at the moment.
> >   func("%lu", (unsigned long) status)
> > would be safer. You could also use 'acpi_format_exception()', which is =
possibly
> > the most correct approach since it assumes nothing about what 'acpi_sta=
tus'
> > actually is.
>
> I wasn't aware of acpi_format_exception(). That looks like a good thing
> to do here, thanks!
>
> >
> >> +=09=09return -EINVAL;
> >
> > I'm not sure if -EINVAL is the best error to return here.
>
> I'd argue that if this fails, it's most likely due to the GPE number
> being invalid (which I'd argue is an input), although I'm open for
> suggestions. Same reasoning for the -EINVALs below.
>

I see, I guess that makes sense, I didn't think of looking at it this way.


> >
> >> +=09}s
> >> +
> >> +=09return 0;
> >> +}
> >> [...]
> >> +static int surface_gpe_probe(struct platform_device *pdev)
> >> +{
> >> +=09struct surface_lid_device *lid;
> >> +=09u32 gpe_number;
> >> +=09int status;
> >> +
> >> +=09status =3D device_property_read_u32(&pdev->dev, "gpe", &gpe_number=
);
> >> +=09if (status)
> >> +=09=09return -ENODEV;
> >
> > 'device_property_read_u32()' returns an error code, you could simply re=
turn that
> > instead of hiding it.
>
> My thought there was that if the "gpe" property isn't present or of a
> different type, this is not a device that we want to/can handle. Thus
> the -ENODEV. Although I think a debug print statement may be useful
> here.
>

I see, I just wanted to bring to your attention that 'device_property_read_=
u32()'
returns various standard error codes and you could simply return those.


> [...]
> >> +
> >> +=09lid->gpe_number =3D gpe_number;
> >> +=09platform_set_drvdata(pdev, lid);
> >> +
> >> +=09status =3D surface_lid_enable_wakeup(&pdev->dev, false);
> >> +=09if (status) {
> >> +=09=09acpi_disable_gpe(NULL, gpe_number);
> >> +=09=09platform_set_drvdata(pdev, NULL);
> >
> > Why is 'platform_set_drvdata(pdev, NULL)' needed?
>
> Is this not required for clean-up once the driver data has been set? Or
> does the driver-base take care of that for us when the driver is
> removed/fails to probe? My reasoning was that I don't want to leave
> stuff around for any other driver to trip on (and rather have that
> driver oops on a NULL-pointer). If the driver-core already takes care of
> NULL-ing that, that line is not needed. Unfortunately that behavior
> doesn't seem to be explained in the documentation.
>

I'm not aware that it would be required. As a matter of fact, only two x86
platform drivers (intel_pmc_core, ideapad-laptop) do any cleanup of driver =
data.
There are much more hits (536) for "set_drvdata(.* NULL" when scanning all =
drivers.
There are 4864 hits for "set_drvdata(.*" that have no 'NULL' in them.

There is drivers/base/dd.c:really_probe(), which seems to be the place wher=
e driver
probes are actually called. And it calls 'dev_set_drvdata(dev, NULL)' if th=
e probe
fails. And it also sets the driver data to NULL in '__device_release_driver=
()',
so I'm pretty sure the driver core takes care of it.


> >> +=09=09return status;
> >> +=09}
> >> +
> >> +=09return 0;
> >> +}
> [...]
> >> +static int __init surface_gpe_init(void)
> >> +{
> >> +=09const struct dmi_system_id *match;
> >> +=09const struct property_entry *props;
> >> +=09struct platform_device *pdev;
> >> +=09struct fwnode_handle *fwnode;
> >> +=09int status;
> >> +
> >> +=09match =3D dmi_first_match(dmi_lid_device_table);
> >> +=09if (!match) {
> >> +=09=09pr_info(KBUILD_MODNAME": no device detected, exiting\n");
> >
> > If you put
> >   #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> > before including any headers, you can simply write 'pr_info("no device.=
..")' and it'll
> > be prefixed by the module name. This is the "usual" way of achieving wh=
at you want.
>
> Right, thanks!
>
> >> +=09=09return 0;
> >
> > Shouldn't it return -ENODEV?
>
> How does module auto-loading behave with a -ENODEV return value in init?
> I know that in the driver's probe callback it signals that the driver
> isn't intended for the device. Is this the same for modules or would a
> user get an error message in the kernel log? As I couldn't find any
> documentation on this, I assumed it didn't behave the same and would
> emit an error message.
>
> The reason I don't want to emit an error message here is that the module
> can be loaded for devices that it's not intended (and that's not
> something we can fix with a better MODULE_ALIAS as Microsoft cleverly
> named their 5th generation Surface Pro "Surface Pro", without any
> version number). Mainly, I don't want users to get a random error
> message that doesn't indicate an actual error.
>

I wasn't sure, so I tested it. It prints the "no device" message, but that'=
s it,
no more indication of the -ENODEV error in the kernel log during automatic
module loading at boot.

You could print "no compatible Microsoft Surface device found, exitig" (or =
something
similar). I think this provides enough information for any user to decide i=
f
they should be concerned or not.


> >> +=09}
> [...]


Regards,
Barnab=C3=A1s P=C5=91cze
