Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97D2526B665
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Sep 2020 02:04:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbgIPAES (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 15 Sep 2020 20:04:18 -0400
Received: from mail-41104.protonmail.ch ([185.70.41.104]:21498 "EHLO
        mail-41104.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727007AbgIPAES (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 15 Sep 2020 20:04:18 -0400
X-Greylist: delayed 333 seconds by postgrey-1.27 at vger.kernel.org; Tue, 15 Sep 2020 20:04:16 EDT
Received: from mail-03.mail-europe.com (mail-03.mail-europe.com [91.134.188.129])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        by mail-41104.protonmail.ch (Postfix) with ESMTPS id 779A820007FF
        for <linux-acpi@vger.kernel.org>; Tue, 15 Sep 2020 23:58:42 +0000 (UTC)
Authentication-Results: mail-41104.protonmail.ch;
        dkim=pass (1024-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="TNMS9MWj"
Date:   Tue, 15 Sep 2020 23:58:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1600214310;
        bh=pmmxd0OZrU7i19ricDTg0JAz6YI/Zw97KeB6gyb8Wyc=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=TNMS9MWj6NfaDxPbSyD5M+6AanhUv3wdizNckBI6UioYRPAyeo5mYA6+csErDeaW5
         lJkJ1z3uS9eYts5coEFvQSP6iIxUvzviG5YhkqlzPSsKy7OfXb4HQ2M3kg/hVDhHtb
         FET0PwobMD2HMTldPMjc554BxHi9dUpi+RmEo/5Y=
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
Message-ID: <EMZQgUl1xLN4o0hV9ZkCD563O85SuOYB5kNFZ5_hlxLQXbJCXpQfrM2afyFIr28h31tXMxD1mxE4DkA5Wy60A0Z2mDnstwF17tEdnX4IRas=@protonmail.com>
In-Reply-To: <20200910211520.1490626-1-luzmaximilian@gmail.com>
References: <20200910211520.1490626-1-luzmaximilian@gmail.com>
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

Hi


> [...]
> +static int surface_lid_enable_wakeup(struct device *dev, bool enable)
> +{
> +=09const struct surface_lid_device *lid =3D dev_get_drvdata(dev);
> +=09int action =3D enable ? ACPI_GPE_ENABLE : ACPI_GPE_DISABLE;
> +=09acpi_status status;
> +
> +=09status =3D acpi_set_gpe_wake_mask(NULL, lid->gpe_number, action);
> +=09if (status) {

I think 'if (ACPI_FAILURE(status))' would be better.


> +=09=09dev_err(dev, "failed to set GPE wake mask: %d\n", status);

I'm not sure if it's technically safe to print acpi_status with the %d form=
at
specifier since 'acpi_status' is defined as 'u32' at the moment.
 func("%lu", (unsigned long) status)
would be safer. You could also use 'acpi_format_exception()', which is poss=
ibly
the most correct approach since it assumes nothing about what 'acpi_status'
actually is.


> +=09=09return -EINVAL;

I'm not sure if -EINVAL is the best error to return here.


> +=09}
> +
> +=09return 0;
> +}
> [...]
> +static int surface_gpe_probe(struct platform_device *pdev)
> +{
> +=09struct surface_lid_device *lid;
> +=09u32 gpe_number;
> +=09int status;
> +
> +=09status =3D device_property_read_u32(&pdev->dev, "gpe", &gpe_number);
> +=09if (status)
> +=09=09return -ENODEV;

'device_property_read_u32()' returns an error code, you could simply return=
 that
instead of hiding it.


> +
> +=09status =3D acpi_mark_gpe_for_wake(NULL, gpe_number);
> +=09if (status) {
> +=09=09dev_err(&pdev->dev, "failed to mark GPE for wake: %d\n", status);
> +=09=09return -EINVAL;
> +=09}
> +
> +=09status =3D acpi_enable_gpe(NULL, gpe_number);
> +=09if (status) {
> +=09=09dev_err(&pdev->dev, "failed to enable GPE: %d\n", status);
> +=09=09return -EINVAL;
> +=09}

My previous comments about ACPI and the returned value apply here as well.
Furthermore, 'acpi_mark_gpe_for_wake()' and 'acpi_enable_gpe()' both return
a value of type 'acpi_status', not 'int'.


> +
> +=09lid =3D devm_kzalloc(&pdev->dev, sizeof(struct surface_lid_device),
> +=09=09=09   GFP_KERNEL);

 lid =3D devm_kzalloc(..., sizeof(*lid), ...)
is preferred.


> +=09if (!lid)
> +=09=09return -ENOMEM;

Isn't that problematic that the side effects of the previous two ACPI calls=
 are
not undone when returning here with -ENOMEM? Allocating this struct right a=
fter
querying 'gpe_number' could prevent it.


> +
> +=09lid->gpe_number =3D gpe_number;
> +=09platform_set_drvdata(pdev, lid);
> +
> +=09status =3D surface_lid_enable_wakeup(&pdev->dev, false);
> +=09if (status) {
> +=09=09acpi_disable_gpe(NULL, gpe_number);
> +=09=09platform_set_drvdata(pdev, NULL);

Why is 'platform_set_drvdata(pdev, NULL)' needed?


> +=09=09return status;
> +=09}
> +
> +=09return 0;
> +}
> +
> +static int surface_gpe_remove(struct platform_device *pdev)
> +{
> +=09struct surface_lid_device *lid =3D dev_get_drvdata(&pdev->dev);
> +
> +=09/* restore default behavior without this module */
> +=09surface_lid_enable_wakeup(&pdev->dev, false);
> +=09acpi_disable_gpe(NULL, lid->gpe_number);
> +
> +=09platform_set_drvdata(pdev, NULL);

I'm wondering why this is needed?


> +=09return 0;
> +}
> [...]
> +static int __init surface_gpe_init(void)
> +{
> +=09const struct dmi_system_id *match;
> +=09const struct property_entry *props;
> +=09struct platform_device *pdev;
> +=09struct fwnode_handle *fwnode;
> +=09int status;
> +
> +=09match =3D dmi_first_match(dmi_lid_device_table);
> +=09if (!match) {
> +=09=09pr_info(KBUILD_MODNAME": no device detected, exiting\n");

If you put
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
before including any headers, you can simply write 'pr_info("no device...")=
' and it'll
be prefixed by the module name. This is the "usual" way of achieving what y=
ou want.


> +=09=09return 0;

Shouldn't it return -ENODEV?


> +=09}
> +
> +=09props =3D match->driver_data;
> +
> +=09status =3D platform_driver_register(&surface_gpe_driver);
> +=09if (status)
> +=09=09return status;
> +
> +=09pdev =3D platform_device_alloc("surface_gpe", PLATFORM_DEVID_NONE);
> +=09if (!pdev) {
> +=09=09platform_driver_unregister(&surface_gpe_driver);
> +=09=09return -ENOMEM;
> +=09}
> +
> +=09fwnode =3D fwnode_create_software_node(props, NULL);
> +=09if (IS_ERR(fwnode)) {
> +=09=09platform_device_put(pdev);
> +=09=09platform_driver_unregister(&surface_gpe_driver);
> +=09=09return PTR_ERR(fwnode);
> +=09}
> +
> +=09pdev->dev.fwnode =3D fwnode;
> +
> +=09status =3D platform_device_add(pdev);
> +=09if (status) {
> +=09=09platform_device_put(pdev);
> +=09=09platform_driver_unregister(&surface_gpe_driver);
> +=09=09return status;
> +=09}
> +

It may be a matter of preference, but I think the 'if (err) goto X' pattern=
 would
be better in this function (at least for the last 3 or so error paths).


> +=09surface_gpe_device =3D pdev;
> +=09return 0;
> +}
> +module_init(surface_gpe_init);
> +
> +static void __exit surface_gpe_exit(void)
> +{
> +=09if (!surface_gpe_device)
> +=09=09return;

If you returned -ENODEV in init when no DMI match is found,
then this check would be redundant.


> [...]


Regards,
Barnab=C3=A1s P=C5=91cze
