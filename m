Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F58412BDB5
	for <lists+linux-acpi@lfdr.de>; Sat, 28 Dec 2019 14:58:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726088AbfL1N6g (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 28 Dec 2019 08:58:36 -0500
Received: from mail-ot1-f41.google.com ([209.85.210.41]:46261 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbfL1N6g (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Dec 2019 08:58:36 -0500
Received: by mail-ot1-f41.google.com with SMTP id k8so22886176otl.13
        for <linux-acpi@vger.kernel.org>; Sat, 28 Dec 2019 05:58:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=LE/mkhAtcJRxtczd4x1eRd3AeL/lAYsqVavJ5lKIKeY=;
        b=H/EVJ9ofV+M3yHnmHitO+2VBX8nLfvHC8STPjfQSQkv+ncBEmZkprnLZR5UDR4dsrq
         RE+SEMF33D9bqDlkYGlCqrt3qERgR65KJAHmm4a53zB7MJ2aKvbcE9RRCThCD/btyj1l
         osKvzQVMHE1ih0ABNg/Y95SRfrDyAnGusom5vZktgOir5j1IxoI2zmCwfijpOZiS0kWk
         xc/0uU3gbQ4QX6s85RGPCLNDkjFV0JtSFzScsa3xxTO/R0R3T/dbV7ZDblE7Sdm4jTeC
         aX2BBmwh2qYclmvwSBwea4hYetDjxQVMY/CFFBKSO5GdZjWcRKcwWOgKATQHAYtDajYN
         UoMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=LE/mkhAtcJRxtczd4x1eRd3AeL/lAYsqVavJ5lKIKeY=;
        b=fAx/jN5ginudxnT37sE+C8aGbmFJAJD83sgkTW7Go4QpgzXqpFm5mItS34xVN7G2kr
         Nhc/5ak2bS0S2vzcOrrqeRG8rHbgxpuuolT2X4FPV1MC+hzVQ/LivB09ein/y0MSiR/S
         WUKCuYbsZ3hdzzQMfUeXOtcacEnnAclwna0Uf+2cWY3znuQVJGTIxR1OZLRAYfwLJDi0
         rh8xuKq3lEch7EAok//OKRMnz9wmWO7EIwponWcWbLUXxHuzwjv+Jt8IIibn+qhIVlp2
         WyAWj94NOmWsYuEes/enHUXCPdtxdNBRpMHd+HMbbTUoyKTuunY8eqK6T/iIqQOdM6UO
         Q4ZA==
X-Gm-Message-State: APjAAAUowRrdzjnZA8P+N+bU8YOecBZia24ziMqNwXEVG2jqAPY02FH6
        op1fQqJVMlwFjLSvVp/HgB6B5pt/gd5V/rwm50Hv5fXK
X-Google-Smtp-Source: APXvYqy5wUdiHzHxRnsQEMq87IjfltxfXuSjGzxXRDOImhEfISpXb6eX/U4OifCunp73QFrC8a7Jk9A6n6ryED0lgAc=
X-Received: by 2002:a9d:6211:: with SMTP id g17mr57786049otj.168.1577541515447;
 Sat, 28 Dec 2019 05:58:35 -0800 (PST)
MIME-Version: 1.0
From:   =?UTF-8?Q?Nicol=C3=B2_Veronese?= <nicveronese@gmail.com>
Date:   Sat, 28 Dec 2019 14:58:23 +0100
Message-ID: <CAC8rN+BAr-JqJLJWNYfNoj_=BnLZDniY-pCbCCpjJCB3005JHQ@mail.gmail.com>
Subject: Troubleshooting an ACPI I2C driver that fails the match
To:     linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,
I'm new with kernel development so I might have done something stupid
during my troubleshooting procedure.

I'm trying to make working the Ambient Light Sensor on my old
Chromebook, this was working up to 4.15 but then something broke in
the chromeos_laptop driver. So now the people that are running an
alternative Chromebook firmware are using ACPI to load the right
modules instead of using the google SMBios table.
My first step was to create the ACPI node on coreboot with the i2c
hardware information. The ALS chip is the ISL29018 and the right
module should be this one:
https://elixir.bootlin.com/linux/v5.0.21/source/drivers/iio/light/isl29018.=
c#L810

According to tho the ACPI table of the driver the _HID should be
"ISL29018" we have created the DSDT:
https://github.com/MrChromebox/coreboot/blob/5a16469c9fb4131f04b2bc56da03fa=
b0f2faf1bc/src/mainboard/google/slippy/variants/peppy/include/variant/acpi/=
mainboard.asl#L163

The module is loaded, but nothing happens, so I have started with
ftrace to see if there was something wrong with the driver itself and
after some more tests I also started to build my own kernel with lots
of printk to know the parameters.

What I've discovered so far is:
i2c_device_probe() is not even called.
__acpi_match_device() fails to find a proper match. It is not scanning
the right ACPI/PNP from the DSDT. On the i2c bus the device also has
an Atmel touchscreen. It tries to match the Atmel TS, not the ALS. (It
fails the check here,
https://elixir.bootlin.com/linux/v4.18/source/drivers/acpi/bus.c#L783
device looks like it is NULL)

With that in mind and with the dmesg logs after "modprobe isl29018":
https://pastebin.com/84YzQ0GY
I have traced the problem up to the "acpi_primary_dev_companion()"
function. I think that that is the one that is returning NULL.
Talking with the COREBOOT guys the ACPI asl is correct and they have
no idea why the Linux kernel is failing to load that specific device.

For reference this is the touchpad dmesg , (as you will see the match
is found and the i2c device gets properly probed):
https://pastebin.com/PKiTKpD9

I have no more ideas to test out where the problem is. I've tried with
different kernel version all 4.18+

If someone has a suggestion/things to help me out with this issue I'm
facing it would be welcome.

Regards,
Nicol=C3=B2
