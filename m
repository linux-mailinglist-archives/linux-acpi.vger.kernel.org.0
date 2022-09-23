Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98EB75E8286
	for <lists+linux-acpi@lfdr.de>; Fri, 23 Sep 2022 21:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbiIWTYS (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 23 Sep 2022 15:24:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231547AbiIWTYQ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 23 Sep 2022 15:24:16 -0400
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E455312DEAE
        for <linux-acpi@vger.kernel.org>; Fri, 23 Sep 2022 12:24:14 -0700 (PDT)
Date:   Fri, 23 Sep 2022 19:24:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1663961048; x=1664220248;
        bh=pfA3tJxIHq44CV8r/RRpBJGZGtaPAkBc9hUJzHent9c=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID;
        b=G7QIV5Sdj0R3G6E0v5Jh4Dae6N8ybX5xeRchi5qnOu/D4eJdHyINvrQuAeIKI+bIY
         maXf0bFhr4djQK7zNEISUse6DoJnDyFxXa1IYxPRJMmW6wD+dvzTUliwqJGPkHa1IV
         rMOeveAqwLQGJ5Tzaslcul1mZUalWca3KYbWkLlRG+TZhlWDy9YqPcjU0aecXhDIww
         IDOlbQjQjaHTCww2GCnqVbWO54FIQZYhQQGJB8f/no75yiMLtcYhxYrIkQ4LUzQnok
         EgFxrpPM67rY0r8Jj+qtUSxD0Fo9T++AtyfzYehhs8vsruqouX+oYFHBsBrgNO5DDV
         mSvUdFcBNBJDg==
To:     Arvid Norlander <lkml@vorpal.se>
From:   =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Cc:     platform-driver-x86@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-input@vger.kernel.org, Azael Avalos <coproscefalo@gmail.com>
Subject: Re: [PATCH RFC v2 1/2] platform/x86: quickstart: Add ACPI quickstart button (PNP0C32) driver
Message-ID: <4-mkye9NM7L93IKQAGjd8BmHi1_2zEnx4F8L3AvKk9RsNBtuoS5cpNCKV-nyb1Xpb1jmAZQDdpNlyvjoUfrFKkq4V-EOfXo9b_gRbyC1hSs=@protonmail.com>
In-Reply-To: <20220922182424.934340-2-lkml@vorpal.se>
References: <20220922182424.934340-1-lkml@vorpal.se> <20220922182424.934340-2-lkml@vorpal.se>
Feedback-ID: 20568564:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi

2022. szeptember 22., cs=C3=BCt=C3=B6rt=C3=B6k 20:24 keltez=C3=A9ssel, Arvi=
d Norlander =C3=ADrta:

> This is loosely based on a previous staging driver that was removed. See
> links below for more info on that driver. The original commit ID was
> 0be013e3dc2ee79ffab8a438bbb4e216837e3d52.
>=20
> However, here a completely different approach is taken to the user space
> API (which should solve the issues the original driver had). Each PNP0C32
> device is a button, and each such button gets a separate input device
> associated with it (instead of a shared platform input device).
>=20
> The button ID (as read from ACPI method GHID) is provided via a sysfs fil=
e
> "button_id".
>=20
> If the button caused a wakeup it will "latch" the "wakeup_cause" sysfs fi=
le
> to true. This can be reset by a user space process.
>=20
> Link: https://marc.info/?l=3Dlinux-acpi&m=3D120550727131007
> Link: https://lkml.org/lkml/2010/5/28/327
> Signed-off-by: Arvid Norlander <lkml@vorpal.se>
> ---
> [...]
> diff --git a/drivers/platform/x86/quickstart.c b/drivers/platform/x86/qui=
ckstart.c
> new file mode 100644
> index 000000000000..ce51abe012f7
> --- /dev/null
> +++ b/drivers/platform/x86/quickstart.c
> @@ -0,0 +1,320 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + *  quickstart.c - ACPI Direct App Launch driver
> + *
> + *  Copyright (C) 2022 Arvid Norlander <lkml@vorapal.se>
> + *  Copyright (C) 2007-2010 Angelo Arrifano <miknix@gmail.com>
> + *
> + *  Information gathered from disassembled dsdt and from here:
> + *  <https://archive.org/details/microsoft-acpi-dirapplaunch>
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License as published by
> + *  the Free Software Foundation; either version 2 of the License, or
> + *  (at your option) any later version.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *  GNU General Public License for more details.
> + *
> + */
> +
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/types.h>
> +#include <linux/acpi.h>
> +#include <linux/platform_device.h>
> +#include <linux/input.h>
> +#include <linux/input/sparse-keymap.h>
> +#include <asm/unaligned.h>
> +
> +MODULE_AUTHOR("Arvid Norlander <lkml@vorpal.se>");
> +MODULE_AUTHOR("Angelo Arrifano");
> +MODULE_DESCRIPTION("ACPI Direct App Launch driver");
> +MODULE_LICENSE("GPL");
> +
> +#define QUICKSTART_ACPI_DEVICE_NAME=09"quickstart"
> +#define QUICKSTART_ACPI_HID=09=09"PNP0C32"
> +
> +/*
> + * There will be two events:
> + * 0x02 - A hot button was pressed while device was off/sleeping.
> + * 0x80 - A hot button was pressed while device was up.
> + */
> +#define QUICKSTART_EVENT_WAKE=09=090x02
> +#define QUICKSTART_EVENT_RUNTIME=090x80
> +
> +/*
> + * Each PNP0C32 device is an individual button. This structure
> + * keeps track of data associated with said device.
> + */
> +struct quickstart_acpi {
> +=09struct platform_device *platform_dev;
> +=09struct input_dev *input_device;
> +=09struct quickstart_button *button;
> +=09/* ID of button as returned by GHID */
> +=09u32 id;
> +=09/* Name of input device */
> +=09char input_name[32];
> +=09/* Physical path for the input device */
> +=09char phys[32];
> +=09/* Track if a wakeup event was received */
> +=09bool wakeup_cause;
> +};
> +
> +#define quickstart_name(dev) acpi_device_bid(dev->acpi_dev)

This does not seem to be used.


> +
> +/*
> + * Knowing what these buttons do require system specific knowledge.
> + * This could be done by matching on DMI data in a long quirk table.
> + * However, it is easier to leave it up to user space to figure this out=
.
> + *
> + * Using for example udev hwdb the scancode 0x1 can be remapped suitably=
.
> + */
> +static const struct key_entry quickstart_keymap[] =3D {
> +=09{ KE_KEY, 0x1, { KEY_UNKNOWN } },
> +=09{ KE_END, 0 },
> +};
> +
> +static ssize_t wakeup_cause_show(struct device *dev,
> +=09=09=09=09 struct device_attribute *attr, char *buf)
> +{
> +=09struct quickstart_acpi *quickstart =3D dev_get_drvdata(dev);
> +
> +=09return sysfs_emit(buf, "%s\n",
> +=09=09=09  (quickstart->wakeup_cause ? "true" : "false"));
> +}
> +
> +static ssize_t wakeup_cause_store(struct device *dev,
> +=09=09=09=09  struct device_attribute *attr,
> +=09=09=09=09  const char *buf, size_t count)
> +{
> +=09struct quickstart_acpi *quickstart =3D dev_get_drvdata(dev);
> +
> +=09if (count < 2)
> +=09=09return -EINVAL;
> +
> +=09if (strncasecmp(buf, "false", 4) !=3D 0)
> +=09=09return -EINVAL;
> +

If "true"/"false" will be used in the final version, then I think this chec=
k
currently is too lax. You could use `sysfs_streq()`. And I think the `count=
 < 2`
check is not needed.


> +=09quickstart->wakeup_cause =3D false;
> +=09return count;
> +}
> +static DEVICE_ATTR_RW(wakeup_cause);
> +
> +static ssize_t button_id_show(struct device *dev, struct device_attribut=
e *attr,
> +=09=09=09      char *buf)
> +{
> +=09struct quickstart_acpi *quickstart =3D dev_get_drvdata(dev);
> +
> +=09return sysfs_emit(buf, "%u\n", quickstart->id);
> +}
> +static DEVICE_ATTR_RO(button_id);
> +
> +/* ACPI Driver functions */
> +static void quickstart_acpi_notify(acpi_handle handle, u32 event, void *=
context)
> +{
> +=09struct platform_device *device =3D context;
> +=09struct quickstart_acpi *quickstart =3D dev_get_drvdata(&device->dev);
> +
> +=09if (!quickstart)
> +=09=09return;
> +
> +=09switch (event) {
> +=09case QUICKSTART_EVENT_WAKE:
> +=09=09quickstart->wakeup_cause =3D true;
> +=09=09break;
> +=09case QUICKSTART_EVENT_RUNTIME:
> +=09=09if (!sparse_keymap_report_event(quickstart->input_device, 0x1,
> +=09=09=09=09=09=091, true)) {
> +=09=09=09pr_info("Key handling error\n");

I don't think this branch can ever be taken.


> +=09=09}
> +=09=09break;
> +=09default:
> +=09=09pr_err("Unexpected ACPI event notify (%u)\n", event);

I think `dev_{err,info}()` should be preferred.


> +=09=09break;
> +=09}
> +}
> +
> +/*
> + * The GHID ACPI method is used to indicate the "role" of the button.
> + * However, all the meanings of these values are vendor defined.
> + *
> + * We do however expose this value to user space.
> + */
> +static int quickstart_acpi_ghid(struct quickstart_acpi *quickstart)
> +{
> +=09acpi_handle handle =3D ACPI_HANDLE(&quickstart->platform_dev->dev);
> +=09acpi_status status;
> +=09struct acpi_buffer buffer =3D { ACPI_ALLOCATE_BUFFER, NULL };
> +=09int ret =3D 0;
> +=09union acpi_object *obj =3D NULL;
> +
> +=09/*
> +=09 * This returns a buffer telling the button usage ID,
> +=09 * and triggers pending notify events (The ones before booting).
> +=09 */
> +=09status =3D acpi_evaluate_object(handle, "GHID", NULL, &buffer);
> +=09if (ACPI_FAILURE(status)) {
> +=09=09dev_err(&quickstart->platform_dev->dev,
> +=09=09=09"GHID method failed, ACPI status %u\n", status);
> +=09=09return -EINVAL;
> +=09}
> +=09obj =3D buffer.pointer;
> +
> +=09/*
> +=09 * GHID returns buffers, sanity check that is the case.
> +=09 */
> +=09if (obj->type !=3D ACPI_TYPE_BUFFER) {
> +=09=09dev_err(&quickstart->platform_dev->dev,
> +=09=09=09"GHID did not return buffer\n");
> +=09=09ret =3D -EINVAL;
> +=09=09goto free_and_return;
> +=09}
> +
> +=09/*
> +=09 * Quoting the specification:
> +=09 * "The GHID method can return a BYTE, WORD, or DWORD.
> +=09 *  The value must be encoded in little-endian byte
> +=09 *  order (least significant byte first)."
> +=09 */
> +=09switch (obj->buffer.length) {
> +=09case 1:
> +=09=09quickstart->id =3D *(u8 *)obj->buffer.pointer;
> +=09=09break;
> +=09case 2:
> +=09=09quickstart->id =3D get_unaligned_le16(obj->buffer.pointer);
> +=09=09break;
> +=09case 4:
> +=09=09quickstart->id =3D get_unaligned_le32(obj->buffer.pointer);
> +=09=09break;
> +=09case 8:
> +=09=09quickstart->id =3D get_unaligned_le64(obj->buffer.pointer);
> +=09=09break;
> +=09default:
> +=09=09dev_err(&quickstart->platform_dev->dev,
> +=09=09=09"GHID method returned buffer of unexpected length %lu\n",
> +=09=09=09(unsigned long)obj->buffer.length);
> +=09=09ret =3D -EINVAL;
> +=09=09break;
> +=09}
> +
> +free_and_return:
> +=09kfree(buffer.pointer);
> +
> +=09return ret;
> +}
> +
> +static struct attribute *quickstart_attributes[] =3D {
> +=09&dev_attr_wakeup_cause.attr,
> +=09&dev_attr_button_id.attr,
> +=09NULL,
> +};
> +
> +static const struct attribute_group quickstart_attr_group =3D {
> +=09.attrs =3D quickstart_attributes,
> +};
> +
> +static int quickstart_remove(struct platform_device *device)
> +{
> +=09acpi_handle handle =3D ACPI_HANDLE(&device->dev);
> +
> +=09acpi_remove_notify_handler(handle, ACPI_DEVICE_NOTIFY,
> +=09=09=09=09   quickstart_acpi_notify);
> +
> +=09return 0;
> +}
> +
> +static int quickstart_probe(struct platform_device *device)
> +{
> +=09int ret;
> +=09acpi_handle handle =3D ACPI_HANDLE(&device->dev);
> +=09acpi_status status;
> +=09struct quickstart_acpi *quickstart;
> +
> +=09if (!device)
> +=09=09return -EINVAL;
> +
> +=09quickstart =3D
> +=09=09devm_kzalloc(&device->dev, sizeof(*quickstart), GFP_KERNEL);
> +=09if (!quickstart)
> +=09=09return -ENOMEM;
> +
> +=09/*
> +=09 * This must be set early for proper cleanup on error handling path.
> +=09 * After this point generic error handling can be used.
> +=09 */
> +=09quickstart->platform_dev =3D device;
> +=09dev_set_drvdata(&device->dev, quickstart);
> +
> +=09/* Retrieve the GHID ID */
> +=09ret =3D quickstart_acpi_ghid(quickstart);
> +=09if (ret < 0)
> +=09=09goto error;

You can replace all `goto`s in this function with `return`s. In fact, you s=
hould
because `quickstart_remove()` does not do useful work until the ACPI notify=
 handler
is registered, but if that succeeds, this function can no longer fail.


> +
> +=09/* Set up sysfs entries */
> +=09ret =3D devm_device_add_group(&quickstart->platform_dev->dev,
> +=09=09=09=09    &quickstart_attr_group);

In the meantime I realized there is a simpler solution. Use the `ATTRIBUTE_=
GROUPS()`
macro and then simply set the `.dev_groups` member of `quickstart_platform_=
driver.driver`.
(see drivers/platform/x86/hp-wmi.c)


> +=09if (ret) {
> +=09=09dev_err(&device->dev, "Unable to setup sysfs entries\n");
> +=09=09goto error;
> +=09}
> +
> +=09/* Set up input device */
> +=09quickstart->input_device =3D
> +=09=09devm_input_allocate_device(&quickstart->platform_dev->dev);
> +=09if (!quickstart->input_device) {
> +=09=09ret =3D -ENOMEM;
> +=09=09goto error;
> +=09}
> +=09ret =3D sparse_keymap_setup(quickstart->input_device, quickstart_keym=
ap,
> +=09=09=09=09  NULL);
> +=09if (ret)
> +=09=09goto error;
> +
> +=09snprintf(quickstart->input_name, sizeof(quickstart->phys),
> +=09=09 "Quickstart Button %u", quickstart->id);
> +=09snprintf(quickstart->phys, sizeof(quickstart->phys),
> +=09=09 QUICKSTART_ACPI_DEVICE_NAME "/input%u", quickstart->id);
> +
> +=09quickstart->input_device->name =3D quickstart->input_name;
> +=09quickstart->input_device->phys =3D quickstart->phys;
> +=09quickstart->input_device->id.bustype =3D BUS_HOST;
> +
> +=09ret =3D input_register_device(quickstart->input_device);
> +
> +=09/* Set up notify handler */
> +=09status =3D acpi_install_notify_handler(handle, ACPI_DEVICE_NOTIFY,
> +=09=09=09=09=09     quickstart_acpi_notify, device);
> +=09if (ACPI_FAILURE(status)) {
> +=09=09dev_err(&device->dev, "Error installing notify handler\n");
> +=09=09return -EIO;
> +=09}
> +
> +=09return 0;
> +error:
> +=09quickstart_remove(device);
> +=09return ret;
> +}
> +
> +static const struct acpi_device_id quickstart_device_ids[] =3D {
> +=09{ QUICKSTART_ACPI_HID, 0 },
> +=09{ "", 0 },

Small thing, but usually the comma after the sentinel entry is omitted.
(see quickstart_keymap, quickstart_attributes as well)


> +};
> +MODULE_DEVICE_TABLE(acpi, quickstart_device_ids);
> +
> +static struct platform_driver quickstart_platform_driver =3D {
> +=09.probe=09=3D quickstart_probe,
> +=09.remove=09=3D quickstart_remove,
> +=09.driver=09=3D {
> +=09=09.name =3D QUICKSTART_ACPI_DEVICE_NAME,
> +=09=09.acpi_match_table =3D quickstart_device_ids,
> +=09=09.owner =3D THIS_MODULE,
> +=09}
> +};
> +
> +module_platform_driver(quickstart_platform_driver);
> --
> 2.37.3


Regards,
Barnab=C3=A1s P=C5=91cze
