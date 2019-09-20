Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10ED3B939B
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Sep 2019 17:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389244AbfITPAi (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 20 Sep 2019 11:00:38 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:52695 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388789AbfITPAi (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 20 Sep 2019 11:00:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1568991636;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eU6kqPiujW1B3w1mQlqkIqX0q06KEXv+uqjn+5HJvNc=;
        b=DWKHQCA4umLXUecck60mgO8kVJunvTuDt0eUH8DPdcjVUYdVafnUSgyYb+5V4Vw1pNe6tL
        oNdOWFk0ttHs2Jh0p8xheXM0d/cpw2naFasDM5T9DuZ+rzW5ZRK4qPKnW5QW7iZjnBcx1X
        Zr4tuRYeR65bKksDqCmkTdewWN00IPc=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-81-_TaOtYpzNYuSLZaQuEN0dA-1; Fri, 20 Sep 2019 11:00:34 -0400
Received: by mail-ed1-f71.google.com with SMTP id n12so4351715edr.22
        for <linux-acpi@vger.kernel.org>; Fri, 20 Sep 2019 08:00:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LIEvaHWl+TgVQ81gN9syCKlW+rXjlPdhuPqlnIXrkVA=;
        b=oT9Ku71q0LiEZAjfAsGjSRSiNnBWocUVHoMPCICNma2i9U09L1+X0HC5nXcje74hr8
         vT7gkeO557HBZ3leWn0t3cpfQInIhLE3giFgirNOAswyVZaZVz4gIdGZCJ1ERzIpLwkd
         lQYKtp7Vw1ahEOp+2n9WY7OfhUQIdoJe7La4u7QLbO+UGqYwRgvxGppxVwj4pIkVWhOp
         Wm5W+hkvXwJiJQsgDEGgA6U/5HLurrMi0I9qrZeRorFsl4r6lbT9kAgPF31phpW6V9le
         1TiEd5s9dRH3bjxkFxm+JEspV8NzMRnv22JsULkJuxLRz28cMEC1i82yBSOWBitPuZXD
         9OqA==
X-Gm-Message-State: APjAAAXwJV3Z10ebOTW5VUunQtFQaESGuv7TJA6w/z0ou/ll6a+czcFX
        DwFf7Fu4kHBdYW5GocOOcoh6Kq59JkWzLlPcYVl4fHSj9ToO1QL85yMou3QFAgOoCmeJ4L9W6aj
        kb1D3xPdqDeYfCm2RnXQxIA==
X-Received: by 2002:a17:906:4d58:: with SMTP id b24mr18592044ejv.263.1568991632680;
        Fri, 20 Sep 2019 08:00:32 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyoFOPw5hvUocXOrNuPY0ea52dYYJ7Fm2ithxt7/2Ck81TNLtAlq5H1WkBixjYklFhIo2uaOA==
X-Received: by 2002:a17:906:4d58:: with SMTP id b24mr18591948ejv.263.1568991631923;
        Fri, 20 Sep 2019 08:00:31 -0700 (PDT)
Received: from dhcp-44-196.space.revspace.nl ([2a0e:5700:4:11:6eb:1143:b8be:2b8])
        by smtp.gmail.com with ESMTPSA id y5sm368389edr.94.2019.09.20.08.00.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Sep 2019 08:00:31 -0700 (PDT)
Subject: Re: [PATCH] serdev: Add ACPI devices by ResourceSource field
To:     Maximilian Luz <luzmaximilian@gmail.com>
Cc:     Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Johan Hovold <johan@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-serial@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190919195624.1140941-1-luzmaximilian@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <50b016a1-ed4a-b848-4658-a05731727d7e@redhat.com>
Date:   Fri, 20 Sep 2019 17:00:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190919195624.1140941-1-luzmaximilian@gmail.com>
Content-Language: en-US
X-MC-Unique: _TaOtYpzNYuSLZaQuEN0dA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 9/19/19 9:56 PM, Maximilian Luz wrote:
> When registering a serdev controller, ACPI needs to be checked for
> devices attached to it. Currently, all immediate children of the ACPI
> node of the controller are assumed to be UART client devices for this
> controller. Furthermore, these devices are not searched elsewhere.
>=20
> This is incorrect: Similar to SPI and I2C devices, the UART client
> device definition (via UARTSerialBusV2) can reside anywhere in the ACPI
> namespace as resource definition inside the _CRS method and points to
> the controller via its ResourceSource field. This field may either
> contain a fully qualified or relative path, indicating the controller
> device. To address this, we need to walk over the whole ACPI namespace,
> looking at each resource definition, and match the client device to the
> controller via this field.
>=20
> Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>

So as promised I've given this patch a try, unfortunately it breaks
existing users of ACPI serdev device instantation.

After adding this patch "ls /sys/bus/serial/devices" is empty,
where as before it gives:

[root@dhcp-45-50 ~]# ls -l /sys/bus/serial/devices/
total 0
lrwxrwxrwx. 1 root root 0 Sep 20 16:43 serial0 -> ../../../devices/pci0000:=
00/8086228A:00/serial0
lrwxrwxrwx. 1 root root 0 Sep 20 16:43 serial0-0 -> ../../../devices/pci000=
0:00/8086228A:00/serial0/serial0-0

And since the serdev is missing bluetooth does not work.

(ACPI instantiated serdev is used for UART attached Blueooth HCI-s on
many Cherry Trail devices).

I haven't looked why your patch is breakig things, I have a large backlog
so I do not have time for that.

But if you can provide me with a version of the patch with a bunch of
debug printk-s added I'm happy to run that for you.

I'll also send you the DSDT of the device I tested on off-list.

Regards,

Hans




> ---
> This patch is similar to the the implementations in drivers/spi/spi.c
> (see commit 4c3c59544f33e97cf8557f27e05a9904ead16363) and
> drivers/i2c/i2c-core-acpi.c. However, I think that there may be an
> issues with these two implementations: Both walk over the whole ACPI
> namespace, but only match the first SPI or I2C resource (respectively),
> so I think there may be problems when multiple SPI or I2C resources are
> defined under the same ACPI device node (as in second or third SPI/I2C
> resource definitions being ignored). Please note, however, that I am by
> no means qualified with regards to this, and this might be totally fine.
> Nevertheless I'd appreciate if anyone with more knowledge on the subject
> could have a look at it. This patch would avoid this problem (for UART)
> by simply walking all resource definitions via acpi_walk_resources.
>=20
> There is a further issue in the serdev ACPI implementation that this
> patch does not address: ACPI UART resource definitions contain things
> like the initial baud-rate, parity, flow-control, etc. As far as I know,
> these things can currently only be set once the device is opened.
> Furthermore, some option values, such as ParityTypeMark, are not (yet)
> supported. I'd be willing to try and implement setting the currently
> supported values based on ACPI for a future patch, if anyone can provide
> me with some pointers on how to do that.
>=20
> I have personally tested this patch on a Microsoft Surface Book 2, which
> like all newer MS Surface devices has a UART EC, and it has been in use
> (in some form or another) for a couple of months on other Surface
> devices via a patched kernel [1, 2, 3]. I can, however, not speak for
> any non-Microsoft devices or potential Apple ACPI quirks.
>=20
> [1]: https://github.com/jakeday/linux-surface/
> [2]: https://github.com/qzed/linux-surface/
> [3]: https://github.com/qzed/linux-surfacegen5-acpi/
>=20
>   drivers/tty/serdev/core.c | 64 ++++++++++++++++++++++++++++++++++-----
>   1 file changed, 56 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
> index a0ac16ee6575..1c8360deea77 100644
> --- a/drivers/tty/serdev/core.c
> +++ b/drivers/tty/serdev/core.c
> @@ -582,18 +582,64 @@ static acpi_status acpi_serdev_register_device(stru=
ct serdev_controller *ctrl,
>   =09return AE_OK;
>   }
>  =20
> -static acpi_status acpi_serdev_add_device(acpi_handle handle, u32 level,
> -=09=09=09=09       void *data, void **return_value)
> +struct acpi_serdev_resource_context {
> +=09struct serdev_controller *controller;
> +=09struct acpi_device *device;
> +};
> +
> +static acpi_status
> +acpi_serdev_add_device_from_resource(struct acpi_resource *resource, voi=
d *data)
>   {
> -=09struct serdev_controller *ctrl =3D data;
> -=09struct acpi_device *adev;
> +=09struct acpi_serdev_resource_context *ctx
> +=09=09=3D (struct acpi_serdev_resource_context *)data;
> +=09struct acpi_resource_source *ctrl_name;
> +=09acpi_handle ctrl_handle;
> +
> +=09if (resource->type !=3D ACPI_RESOURCE_TYPE_SERIAL_BUS)
> +=09=09return AE_OK;
>  =20
> -=09if (acpi_bus_get_device(handle, &adev))
> +=09if (resource->data.common_serial_bus.type
> +=09    !=3D ACPI_RESOURCE_SERIAL_TYPE_UART)
>   =09=09return AE_OK;
>  =20
> -=09return acpi_serdev_register_device(ctrl, adev);
> +=09ctrl_name =3D &resource->data.common_serial_bus.resource_source;
> +=09if (ctrl_name->string_length =3D=3D 0 || !ctrl_name->string_ptr)
> +=09=09return AE_OK;
> +
> +=09if (acpi_get_handle(ctx->device->handle, ctrl_name->string_ptr,
> +=09=09=09    &ctrl_handle))
> +=09=09return AE_OK;
> +
> +=09if (ctrl_handle =3D=3D ACPI_HANDLE(ctx->controller->dev.parent))
> +=09=09return acpi_serdev_register_device(ctx->controller,
> +=09=09=09=09=09=09   ctx->device);
> +
> +=09return AE_OK;
>   }
>  =20
> +static acpi_status
> +acpi_serdev_add_devices_from_resources(acpi_handle handle, u32 level,
> +=09=09=09=09       void *data, void **return_value)
> +{
> +=09struct acpi_serdev_resource_context ctx;
> +=09acpi_status status;
> +
> +=09ctx.controller =3D (struct serdev_controller *)data;
> +=09status =3D acpi_bus_get_device(handle, &ctx.device);
> +=09if (status)
> +=09=09return AE_OK;=09=09// ignore device if not present
> +
> +=09status =3D acpi_walk_resources(handle, METHOD_NAME__CRS,
> +=09=09=09=09     acpi_serdev_add_device_from_resource,
> +=09=09=09=09     &ctx);
> +=09if (status =3D=3D AE_NOT_FOUND)
> +=09=09return AE_OK;=09=09// ignore if _CRS is not found
> +=09else
> +=09=09return status;
> +}
> +
> +#define SERDEV_ACPI_ENUMERATE_MAX_DEPTH=09=0932
> +
>   static int acpi_serdev_register_devices(struct serdev_controller *ctrl)
>   {
>   =09acpi_status status;
> @@ -603,8 +649,10 @@ static int acpi_serdev_register_devices(struct serde=
v_controller *ctrl)
>   =09if (!handle)
>   =09=09return -ENODEV;
>  =20
> -=09status =3D acpi_walk_namespace(ACPI_TYPE_DEVICE, handle, 1,
> -=09=09=09=09     acpi_serdev_add_device, NULL, ctrl, NULL);
> +=09status =3D acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,
> +=09=09=09=09     SERDEV_ACPI_ENUMERATE_MAX_DEPTH,
> +=09=09=09=09     acpi_serdev_add_devices_from_resources,
> +=09=09=09=09     NULL, ctrl, NULL);
>   =09if (ACPI_FAILURE(status))
>   =09=09dev_dbg(&ctrl->dev, "failed to enumerate serdev slaves\n");
>  =20
>=20

