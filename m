Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B634BAF17
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Sep 2019 10:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437271AbfIWIOr (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 23 Sep 2019 04:14:47 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:22110 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2437095AbfIWIOq (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 23 Sep 2019 04:14:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1569226485;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WgjhOA0zyVcAZNXjRIcpen414kkZtL+EdIeyI3wtD/s=;
        b=A2KujDtSR+8xDXv5y11wsB6MOkOniIOQroZI+w0BGQqm1DQ80cFsT9s893pL3wycoFEn0c
        z27DYoA3C4TbkMxBVtUS8zbkonU675g8Qpi+fUj33u4CI22OKH2iZ9xg/DqE2tyIaUNgev
        K20HxnCqLSs7xEANzDaNlV9l3lWz+Qc=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-212-v5AQxn7MM6OuDkdRgakW8A-1; Mon, 23 Sep 2019 04:14:43 -0400
Received: by mail-ed1-f70.google.com with SMTP id j8so8985408edl.11
        for <linux-acpi@vger.kernel.org>; Mon, 23 Sep 2019 01:14:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SGnsNHhO6VDfdoucoStGXGb4btl6LzMLnLQlg8egQPM=;
        b=K+UF+QZJA0d3jJoY7Sb58kSrGtNBPRytqUowqGIYJ7Cmbo19piiXkTWo5lp00KWzUw
         Kt8zTrBNP7mIiKeDmgr3wliw0STjNb5ffDX13teI0U0gcVxKzXXMbWcykot6Hcg1Hfak
         aJlhEJqyf2kaEMhgyhkpFfw1ELQHiWyqPNaycdAP9X9je2DCjriE9oct4QvOZItT61pm
         CY5x29oPxWH34cdxnMVf13o/D31vkZYNviiicBtSXE4AzTj2tE3G+r2gmyPu4bYdtb1I
         k/sitUtHX7E3trK3X6bXs+TyNUFNu3zK52tOq2hBnR6li0Dw9mzQnr6SeqbivyUlphOI
         2Oiw==
X-Gm-Message-State: APjAAAX0eQP55/KOhp/2lbuoymlloLhfVQDE+c2OIwLUvse4smtDtoUU
        HZn9eHj/iXEtaWLrdikq+iZxt+qA4oc340svDxegpYYe/J3vaR76semXY7DffMDQJXpBywPdptd
        qDuOLAzTiw0nQ38vY5EyYJA==
X-Received: by 2002:a50:8933:: with SMTP id e48mr35189225ede.51.1569226482500;
        Mon, 23 Sep 2019 01:14:42 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxc5e7k3VAzRdcPID6YxsIF0up8i6QsaNpxbtG6XkJUN3zr6gMWoDf/Moazau7pRW8wC7jlxQ==
X-Received: by 2002:a50:8933:: with SMTP id e48mr35189208ede.51.1569226482339;
        Mon, 23 Sep 2019 01:14:42 -0700 (PDT)
Received: from shalem.localdomain (84-106-84-65.cable.dynamic.v4.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id b16sm1025855eju.74.2019.09.23.01.14.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2019 01:14:41 -0700 (PDT)
Subject: Re: [PATCH] serdev: Add ACPI devices by ResourceSource field
To:     Maximilian Luz <luzmaximilian@gmail.com>
Cc:     Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Johan Hovold <johan@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-serial@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190919195624.1140941-1-luzmaximilian@gmail.com>
 <50b016a1-ed4a-b848-4658-a05731727d7e@redhat.com>
 <4c2cc8b7-8541-0912-3162-399777dc8dd2@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <8bed7cde-1f59-c5bf-9506-757dd89ad594@redhat.com>
Date:   Mon, 23 Sep 2019 10:14:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <4c2cc8b7-8541-0912-3162-399777dc8dd2@gmail.com>
Content-Language: en-US
X-MC-Unique: v5AQxn7MM6OuDkdRgakW8A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 23-09-2019 00:29, Maximilian Luz wrote:
> Hi all,
>=20
> On 9/20/19 5:00 PM, Hans de Goede wrote:
>> So as promised I've given this patch a try, unfortunately it breaks
>> existing users of ACPI serdev device instantation.
>>
>> After adding this patch "ls /sys/bus/serial/devices" is empty,
>> where as before it gives:
>>
>> [root@dhcp-45-50 ~]# ls -l /sys/bus/serial/devices/
>> total 0
>> lrwxrwxrwx. 1 root root 0 Sep 20 16:43 serial0 -> ../../../devices/pci00=
00:00/8086228A:00/serial0
>> lrwxrwxrwx. 1 root root 0 Sep 20 16:43 serial0-0 -> ../../../devices/pci=
0000:00/8086228A:00/serial0/serial0-0
>>
>> And since the serdev is missing bluetooth does not work.
>=20
> Thanks to some testing by Hans, it turns out that the reason for this is
> that acpi_walk_resources fails with AE_AML_INVALID_RESOURCE_TYPE for a
> specific device. If anyone is interested, the _CRS of the device in
> question is
>=20
>  =C2=A0=C2=A0=C2=A0 Method (_CRS, 0, NotSerialized)=C2=A0 // _CRS: Curren=
t Resource Settings
>  =C2=A0=C2=A0=C2=A0 {
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Name (NAM, Buffer (0x14)
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "\\_S=
B.PCI0.SDHB.BRC1"
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 })
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Name (SPB, Buffer (0x0C)
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* 00=
00 */=C2=A0 0x8E, 0x1D, 0x00, 0x01, 0x00, 0xC0, 0x02, 0x00,
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* 00=
08 */=C2=A0 0x00, 0x01, 0x00, 0x00
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 })
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Name (END, ResourceTemplate (=
)
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 })
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Concatenate (SPB, NAM, Local0=
)
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Concatenate (Local0, END, Loc=
al1)
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Return (Local1)
>  =C2=A0=C2=A0=C2=A0 }
>=20
> To solve this, I propose ignoring errors that occur when evaluating the
> _CRS method. Note that with the previously discussed change for v2,
> where we will only look at the first device in _CRS, we should be able
> to handle errors from the actual serdev device allocation separately
> (and only ignore AML evaluation errors).
>=20
> Further, I think it might also make sense to move the status and
> already-enumerated checks out of acpi_serdev_register_device to before
> looking at _CRS.

Ack, this is what drivers/i2c/i2c-core-acpi.c is doing and more in general
all ACPI enumeration code always first checks _STA before doing anything
else, so I think it would be best to do this here too.

Actually I think it might be best to fully copy how drivers/i2c/i2c-core-ac=
pi.c
does things.

Regards,

Hans

