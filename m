Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3680C36A3D3
	for <lists+linux-acpi@lfdr.de>; Sun, 25 Apr 2021 03:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbhDYBGz (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 24 Apr 2021 21:06:55 -0400
Received: from mail-40133.protonmail.ch ([185.70.40.133]:45457 "EHLO
        mail-40133.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbhDYBGz (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 24 Apr 2021 21:06:55 -0400
Date:   Sun, 25 Apr 2021 01:06:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1619312774;
        bh=H1qMUcszeVpiIb8uqcXaGdv2ktJ1dJmxagIhRMHp9e0=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=hJ60eizsVk6CxSGemow6q0kUrB+SAbCTu1mB3sUPcw4fE0fVIvAIbdaIp9LmzgXEw
         xFLFwXeB9DeueCg8q7PD8JUvJwBPwYf36AhNbziGeAOfsnr4z5O4gmqyj+XhpTu146
         msKywUuN/1RUhL+H6mKlBW4B26DeldTFAG2KhJ5s=
To:     Anupama K Patil <anupamakpatil123@gmail.com>
From:   =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Cc:     Jaroslav Kysela <perex@perex.cz>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "skhan@linuxfoundation.org" <skhan@linuxfoundation.org>,
        "bkkarthik@pesu.pes.edu" <bkkarthik@pesu.pes.edu>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "kernelnewbies@kernelnewbies.org" <kernelnewbies@kernelnewbies.org>
Reply-To: =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Subject: Re: [PATCH] drivers: pnp: proc.c: Handle errors while attaching devices
Message-ID: <CSBw5RbPfjHIC-pzsVOv-S6X9ir8mhLYp3cP3P6UizGPb-wc-OUBfXFXvAPr7fISCC2Bo_r1hHsoltEEEK7VXi8UyTNHc51lH_att8eNZqk=@protonmail.com>
In-Reply-To: <20210424194301.jmsqpycvsm7izbk3@ubuntu>
References: <20210424194301.jmsqpycvsm7izbk3@ubuntu>
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


2021. =C3=A1prilis 24., szombat 21:43 keltez=C3=A9ssel, Anupama K Patil =
=C3=ADrta:

> isapnp_proc_init() does not look at the return value from
> isapnp_proc_attach_device(). Check for this return value in
> isapnp_proc_detach_device().
>
> Cleanup in isapnp_proc_detach_device and
> isapnp_proc_detach_bus() for cleanup.
>
> Changed sprintf() to the kernel-space function scnprintf() as it returns
> the actual number of bytes written.
>
> Removed unnecessary variables de, e of type 'struct proc_dir_entry' to
> save memory.
>
> Suggested-by: Shuah Khan <skhan@linuxfoundation.org>
> Co-developed-by: B K Karthik <bkkarthik@pesu.pes.edu>
> Signed-off-by: B K Karthik <bkkarthik@pesu.pes.edu>
> Signed-off-by: Anupama K Patil <anupamakpatil123@gmail.com>
> ---
>  drivers/pnp/isapnp/proc.c | 40 +++++++++++++++++++++++++++++----------
>  1 file changed, 30 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/pnp/isapnp/proc.c b/drivers/pnp/isapnp/proc.c
> index 785a796430fa..46ebc24175b7 100644
> --- a/drivers/pnp/isapnp/proc.c
> +++ b/drivers/pnp/isapnp/proc.c
> @@ -54,34 +54,54 @@ static const struct proc_ops isapnp_proc_bus_proc_ops=
 =3D {
>  =09.proc_read=09=3D isapnp_proc_bus_read,
>  };
>
> +static int isapnp_proc_detach_device(struct pnp_dev *dev)
> +{
> +=09proc_remove(dev->procent);
> +=09dev->procent =3D NULL;
> +=09return 0;
> +}
> +
> +static int isapnp_proc_detach_bus(struct pnp_card *bus)
> +{
> +=09proc_remove(bus->procdir);

Is there any reason for not setting `bus->procdir` to `NULL`
similarly to the previous function?


> +=09return 0;
> +}
> +

Is there any reason why the previous two functions return something? It doe=
sn't
seem to be necessary.


>  static int isapnp_proc_attach_device(struct pnp_dev *dev)
>  {
>  =09struct pnp_card *bus =3D dev->card;
> -=09struct proc_dir_entry *de, *e;
>  =09char name[16];
>
> -=09if (!(de =3D bus->procdir)) {
> -=09=09sprintf(name, "%02x", bus->number);
> -=09=09de =3D bus->procdir =3D proc_mkdir(name, isapnp_proc_bus_dir);
> -=09=09if (!de)
> +=09if (!bus->procdir) {
> +=09=09scnprintf(name, 16, "%02x", bus->number);

I think `sizeof(name)` would be preferable to hard-coding 16.


> +=09=09bus->procdir =3D proc_mkdir(name, isapnp_proc_bus_dir);
> +=09=09if (!bus->procdir)
>  =09=09=09return -ENOMEM;
>  =09}
> -=09sprintf(name, "%02x", dev->number);
> -=09e =3D dev->procent =3D proc_create_data(name, S_IFREG | S_IRUGO, de,
> +=09scnprintf(name, 16, "%02x", dev->number);

Here as well.


> +=09dev->procent =3D proc_create_data(name, S_IFREG | S_IRUGO, bus->procd=
ir,
>  =09=09=09=09=09    &isapnp_proc_bus_proc_ops, dev);

Please align the continuation properly.


> -=09if (!e)
> +=09if (!dev->procent) {
> +=09=09isapnp_proc_detach_bus(bus);

I'm not sure if this should be here. If I'm not mistaken, the code
creates a procfs directory for a bus when it first sees a `pnp_dev` from th=
at bus.
This call removes the whole directory for the bus, and with that, the files=
 of
those `pnp_dev`s which were successfully created earlier.


>  =09=09return -ENOMEM;
> -=09proc_set_size(e, 256);
> +=09}
> +=09proc_set_size(dev->procent, 256);
>  =09return 0;
>  }
>
>  int __init isapnp_proc_init(void)
>  {
>  =09struct pnp_dev *dev;
> +=09int dev_attach;
>
>  =09isapnp_proc_bus_dir =3D proc_mkdir("bus/isapnp", NULL);

You could add a check to see if this `proc_mkdir()` call succeeds, and
possibly return early if it does not.


>  =09protocol_for_each_dev(&isapnp_protocol, dev) {
> -=09=09isapnp_proc_attach_device(dev);
> +=09=09dev_attach =3D isapnp_proc_attach_device(dev);
> +=09=09if (!dev_attach) {

`isapnp_proc_attach_device()` returns 0 on success, so the condition should=
 be inverted.
And maybe `err` or something like that would be a better name than `dev_att=
ach`.


> +=09=09=09pr_info("procfs: pnp: Unable to attach the device, not enough m=
emory");

If I'm not mistaken, allocation failures are logged, so this is probably no=
t needed.


> +=09=09=09isapnp_proc_detach_device(dev);

I'm also not sure if this is needed here. If `isapnp_proc_attach_device()` =
returns
an error, then `dev->procdir` could not have been "created". In other words=
,
if the execution reaches this point, `proc_create_data()` could not have su=
cceeded
because either it had not yet been called or it had failed.


> +=09=09=09return -ENOMEM;

It is usually preferable to return the error code you receive. E.g.:

  err =3D isapnp_proc_attach_device(...);
  if (err) {
    ...
    return err;
  }


> +=09=09}
>  =09}
>  =09return 0;
>  }
> --
> 2.25.1
>


Regards,
Barnab=C3=A1s P=C5=91cze
