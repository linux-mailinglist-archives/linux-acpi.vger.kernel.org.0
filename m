Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 364B45B8EE0
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Sep 2022 20:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbiINS1e (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 14 Sep 2022 14:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiINS1c (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 14 Sep 2022 14:27:32 -0400
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C8167F12F;
        Wed, 14 Sep 2022 11:27:29 -0700 (PDT)
Date:   Wed, 14 Sep 2022 18:27:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1663180046; x=1663439246;
        bh=398dxQIvPKYdjnkWKOwJbWXWYGg+0dVLHBf87D2TXrU=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID;
        b=iUJ5opnhjtS4ZMQJFgSZyFukiD+gDhRQ207Ru3fNFn+mHZrY2/EGsrYfo0vBMqTgA
         cf8quHDl4BJJDPoNK+u9C2k4O/+uxty+338sSD55vA7iljR5AM7Pg/tQUQZLKVdpBA
         YKp6mqP8Cq130lL8FU6jtoQ6+d0uLoC2Rv4A65BfNJttl0vVfAJ2+ZpyDuSitPzaxb
         eIVmEYIEeZRpoupcpzRIKBjwDEiXs5UdGNtAgb8Dbh2KnUPZJ7JHn3OBwjIbrpB3Va
         jAB+IKxHWewmPLYSYynEjmRIITOSgJXIGDNnkwBDQ0q6vnByb4AVRpGCW32aMoqZ/1
         kgUR/lINWg/Ew==
To:     Arvid Norlander <lkml@vorpal.se>
From:   =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Cc:     platform-driver-x86@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-input@vger.kernel.org, Azael Avalos <coproscefalo@gmail.com>
Subject: Re: [PATCH RFC 1/2] staging: quickstart: Add ACPI quickstart button (PNP0C32) driver
Message-ID: <drXHqh3nyou52BleUraC71bm5y1IXzb1kfROkRvfC-PXNoNbaxfYrq8Lj-_8aS4pFl0RHy7ts9fkz-uw_dMy0jaf5Yx8Rw5InWgZduKnojE=@protonmail.com>
In-Reply-To: <20220911194934.558019-2-lkml@vorpal.se>
References: <20220911194934.558019-1-lkml@vorpal.se> <20220911194934.558019-2-lkml@vorpal.se>
Feedback-ID: 20568564:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi

2022. szeptember 11., vas=C3=A1rnap 21:49 keltez=C3=A9ssel, Arvid Norlander=
 =C3=ADrta:

> This is loosly based on a previous staging driver that was removed. See
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
> [...]
> +#define QUICKSTART_VERSION "1.04"
> +
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/types.h>
> +#include <linux/acpi.h>
> +#include <linux/input.h>
> +#include <linux/input/sparse-keymap.h>
> +
> +MODULE_AUTHOR("Arvid Norlander <lkml@vorpal.se>");
> +MODULE_AUTHOR("Angelo Arrifano");
> +MODULE_DESCRIPTION("ACPI Direct App Launch driver");
> +MODULE_LICENSE("GPL");
> +
> +#define QUICKSTART_ACPI_DEVICE_NAME=09"quickstart"
> +#define QUICKSTART_ACPI_CLASS=09=09"quickstart"
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
> +=09struct acpi_device *acpi_dev;
> +=09struct input_dev *input_device;
> +=09struct quickstart_button *button;
> +=09/* Name of button for debug messages */
> +=09char *name;
> +=09/* ID of button as returned by GHID */
> +=09u32 id;
> +=09/* Flags for cleanup */
> +=09unsigned int input_registered : 1;

This member is set, but never read.


> +=09unsigned int sysfs_created : 1;
> +=09/* Track if a wakeup event was received */
> +=09unsigned int wakeup_cause : 1;
> +=09/* Name of input device */
> +=09char input_name[32];
> +=09/* Physical path for the input device */
> +=09char phys[32];
> +};
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
> +=09return scnprintf(buf, PAGE_SIZE, "%s\n",
> +=09=09=09 (quickstart->wakeup_cause ? "true" : "false"));

Please use `sysfs_emit()` preferably. And I think it would be easier to use=
 0/1
instead of true/false. And you could use `kstrtobool()` in the _store() fun=
ction.


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
> +=09return scnprintf(buf, PAGE_SIZE, "%d\n", quickstart->id);

Since it is unsigned `%u` would probably be better.


> +}
> +static DEVICE_ATTR_RO(button_id);
> +
> +/* ACPI Driver functions */
> +static void quickstart_acpi_notify(struct acpi_device *acpi_dev, u32 eve=
nt)
> +{
> +=09struct quickstart_acpi *quickstart =3D acpi_driver_data(acpi_dev);
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
> +=09=09}
> +=09=09break;
> +=09default:
> +=09=09pr_err("Unexpected ACPI event notify (%u)\n", event);
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
> +=09acpi_status status;
> +=09struct acpi_buffer buffer =3D { ACPI_ALLOCATE_BUFFER, NULL };
> +=09int ret =3D 0;
> +=09union acpi_object *obj =3D NULL;
> +
> +=09/*
> +=09 * This returns a buffer telling the button usage ID,
> +=09 * and triggers pending notify events (The ones before booting).
> +=09 */
> +=09status =3D acpi_evaluate_object(quickstart->acpi_dev->handle, "GHID",
> +=09=09=09=09      NULL, &buffer);
> +=09if (ACPI_FAILURE(status)) {
> +=09=09pr_err("%s GHID method failed\n", quickstart->name);
> +=09=09return -EINVAL;
> +=09}
> +=09obj =3D buffer.pointer;
> +
> +=09/*
> +=09 * GHID returns buffers, sanity check that is the case.
> +=09 */
> +=09if (obj->type !=3D ACPI_TYPE_BUFFER) {
> +=09=09pr_err("%s GHID did not return buffer\n", quickstart->name);
> +=09=09return -EINVAL;

`buffer.pointer` is not freed here. Since you know the maximum size, you co=
uld
consider using an on-stack buffer.


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
> +=09=09quickstart->id =3D le16_to_cpu(*(u16 *)obj->buffer.pointer);

Probably does not matter here, but I personally like to use `get_unaligned_=
leN()`
because those functions just always work.


> +=09=09break;
> +=09case 4:
> +=09=09quickstart->id =3D le32_to_cpu(*(u32 *)obj->buffer.pointer);
> +=09=09break;
> +=09case 8:
> +=09=09quickstart->id =3D le64_to_cpu(*(u64 *)obj->buffer.pointer);
> +=09=09break;
> +=09default:
> +=09=09pr_err("%s GHID method returned buffer of unexpected length %lu\n"=
,
> +=09=09       quickstart->name, (unsigned long)obj->buffer.length);
> +=09=09ret =3D -EINVAL;
> +=09=09break;
> +=09}
> +
> +=09kfree(buffer.pointer);
> +
> +=09return ret;
> +}
> +
> +static int quickstart_acpi_config(struct quickstart_acpi *quickstart)
> +{
> +=09char *bid =3D acpi_device_bid(quickstart->acpi_dev);
> +=09char *name;
> +
> +=09name =3D kmalloc(strlen(bid) + 1, GFP_KERNEL);
> +=09if (!name)
> +=09=09return -ENOMEM;
> +
> +=09quickstart->name =3D name;
> +=09strcpy(quickstart->name, bid);

You could use `kstrdup()` here, but you could probably even use `devm_kstrd=
up()`
and then this function could be entirely removed.


> +
> +=09return 0;
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
> +static int quickstart_acpi_remove(struct acpi_device *acpi_dev)
> +{
> +=09struct quickstart_acpi *quickstart;
> +
> +=09if (!acpi_dev)
> +=09=09return -EINVAL;
> +
> +=09quickstart =3D acpi_driver_data(acpi_dev);
> +=09if (!quickstart)
> +=09=09return -EINVAL;
> +
> +=09if (quickstart->sysfs_created)
> +=09=09sysfs_remove_group(&quickstart->acpi_dev->dev.kobj,
> +=09=09=09=09   &quickstart_attr_group);
> +
> +=09kfree(quickstart->name);
> +=09quickstart->name =3D NULL;
> +
> +=09kfree(quickstart);
> +
> +=09return 0;
> +}
> +
> +static int quickstart_acpi_add(struct acpi_device *acpi_dev)
> +{
> +=09int ret;
> +=09struct quickstart_acpi *quickstart;
> +
> +=09if (!acpi_dev)
> +=09=09return -EINVAL;
> +
> +=09quickstart =3D kzalloc(sizeof(*quickstart), GFP_KERNEL);

Have you considered `devm_kzalloc()`?


> +=09if (!quickstart)
> +=09=09return -ENOMEM;
> +
> +=09/*
> +=09 * This must be set early for proper cleanup on error handling path.
> +=09 * After this point generic error handling can be used.
> +=09 */
> +=09acpi_dev->driver_data =3D quickstart;
> +=09quickstart->acpi_dev =3D acpi_dev;
> +=09dev_set_drvdata(&acpi_dev->dev, quickstart);
> +
> +=09strcpy(acpi_device_name(acpi_dev), QUICKSTART_ACPI_DEVICE_NAME);
> +=09strcpy(acpi_device_class(acpi_dev), QUICKSTART_ACPI_CLASS);
> +
> +=09/* Initialize device name */
> +=09ret =3D quickstart_acpi_config(quickstart);
> +=09if (ret < 0)
> +=09=09goto error;
> +
> +=09/* Retrieve the GHID ID */
> +=09ret =3D quickstart_acpi_ghid(quickstart);
> +=09if (ret < 0)
> +=09=09goto error;
> +
> +=09/* Set up sysfs entries */
> +=09ret =3D sysfs_create_group(&quickstart->acpi_dev->dev.kobj,
> +=09=09=09=09 &quickstart_attr_group);

You could use `devm_device_add_group()`. And then the `sysfs_created` membe=
r
could be removed.


> +=09if (ret) {
> +=09=09quickstart->sysfs_created =3D 0;
> +=09=09pr_err("Unable to setup sysfs entries\n");
> +=09=09goto error;
> +=09}
> +=09quickstart->sysfs_created =3D !ret;
> +
> +=09/* Set up input device */
> +=09quickstart->input_device =3D
> +=09=09devm_input_allocate_device(&quickstart->acpi_dev->dev);
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
> +=09if (ret) {
> +=09=09quickstart->input_registered =3D 0;
> +=09=09pr_err("Unable to register input device\n");
> +=09=09goto error;
> +=09}
> +=09quickstart->input_registered =3D !ret;
> +
> +=09return 0;
> +error:
> +=09quickstart_acpi_remove(acpi_dev);
> +=09return ret;
> +}
> +
> +static const struct acpi_device_id quickstart_device_ids[] =3D {
> +=09{ QUICKSTART_ACPI_HID, 0 },
> +=09{ "", 0 },
> +};
> +MODULE_DEVICE_TABLE(acpi, quickstart_device_ids);
> +
> +static struct acpi_driver quickstart_acpi_driver =3D {
> +=09.name=09=3D "quickstart",
> +=09.owner=09=3D THIS_MODULE,
> +=09.class=09=3D QUICKSTART_ACPI_CLASS,
> +=09.ids=09=3D quickstart_device_ids,
> +=09.flags=09=3D ACPI_DRIVER_ALL_NOTIFY_EVENTS,
> +=09.ops=09=3D {
> +=09=09.add =3D quickstart_acpi_add,
> +=09=09.remove =3D quickstart_acpi_remove,
> +=09=09.notify =3D quickstart_acpi_notify
> +=09},
> +};
> +
> +/* Module functions */
> +static void quickstart_exit(void)
> +{
> +=09acpi_bus_unregister_driver(&quickstart_acpi_driver);
> +}
> +
> +static int __init quickstart_init(void)
> +{
> +=09int ret;
> +
> +=09/* ACPI driver register */
> +=09ret =3D acpi_bus_register_driver(&quickstart_acpi_driver);
> +=09if (ret)
> +=09=09return ret;
> +
> +=09pr_info("ACPI Direct App Launch ver %s\n", QUICKSTART_VERSION);
> +
> +=09return 0;
> +}
> +
> +module_init(quickstart_init);
> +module_exit(quickstart_exit);

You could use the `module_acpi_driver()` macro to generate the init/exit me=
thods.


> --
> 2.37.3


Regards,
Barnab=C3=A1s P=C5=91cze
