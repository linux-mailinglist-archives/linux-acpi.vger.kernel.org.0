Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BFFFE11FEA2
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Dec 2019 07:53:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbfLPGxn (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 16 Dec 2019 01:53:43 -0500
Received: from mo-csw1516.securemx.jp ([210.130.202.155]:33644 "EHLO
        mo-csw.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbfLPGxn (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 16 Dec 2019 01:53:43 -0500
Received: by mo-csw.securemx.jp (mx-mo-csw1516) id xBG6rTSv011327; Mon, 16 Dec 2019 15:53:29 +0900
X-Iguazu-Qid: 34tKGlJZZm5ZOtrFJg
X-Iguazu-QSIG: v=2; s=0; t=1576479208; q=34tKGlJZZm5ZOtrFJg; m=1iGBw1Qi+KmDlKhNqILFR4qOVaGF3CybMVK/P0DyAvw=
Received: from imx2.toshiba.co.jp (imx2.toshiba.co.jp [106.186.93.51])
        by relay.securemx.jp (mx-mr1512) id xBG6rRun013693;
        Mon, 16 Dec 2019 15:53:28 +0900
Received: from enc01.localdomain ([106.186.93.100])
        by imx2.toshiba.co.jp  with ESMTP id xBG6rRcx004446;
        Mon, 16 Dec 2019 15:53:27 +0900 (JST)
Received: from hop001.toshiba.co.jp ([133.199.164.63])
        by enc01.localdomain  with ESMTP id xBG6rR6r026063;
        Mon, 16 Dec 2019 15:53:27 +0900
From:   Punit Agrawal <punit1.agrawal@toshiba.co.jp>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     linux-serial@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, nobuhiro1.iwamatsu@toshiba.co.jp,
        shrirang.bagul@canonical.com, robh@kernel.org,
        gregkh@linuxfoundation.org, johan@kernel.org
Subject: Re: [RFC 0/1] serdes: Add whitelist to bring back missing serial port
References: <20191216040825.523720-1-punit1.agrawal@toshiba.co.jp>
        <b1ce4dff-7239-640a-fcc3-4ff935fdb3a7@redhat.com>
Date:   Mon, 16 Dec 2019 15:54:06 +0900
In-Reply-To: <b1ce4dff-7239-640a-fcc3-4ff935fdb3a7@redhat.com> (Hans de
        Goede's message of "Mon, 16 Dec 2019 07:29:46 +0100")
X-TSB-HOP: ON
Message-ID: <87woawpxpt.fsf@kokedama.swc.toshiba.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Hans,

Thanks for chiming in.

Hans de Goede <hdegoede@redhat.com> writes:

> HI,
>
> On 16-12-2019 05:08, Punit Agrawal wrote:
>>
>> Hi,
>>
>> While booting v5.5-rc1 on Apollo Lake based UP2[0], I ran into an
>> issue with the primary serial port. The kernel is able to output to
>> ttyS0 but systemd isn't able to raise a login prompt. On further
>> investigation, it turns out that no serial device (/dev/ttyS0) is
>> being created as the device is claimed by serdev sub-system.
>>
>> The issue has been reported in a few different places[0][1]. A patch
>> was proposed to solve the issue but there doesn't seem to be any
>> further progress[2]. Feedback on the thread suggested implementing a
>> whitelist based approach - which is what this RFC does.
>>
>> With this patch, systemd is able to create a login prompt. The
>> whitelist has intentionally been left blank as it's not clear which
>> devices go in there.
>
> As I already mentioned when discussing this upstream:
>
> https://marc.info/?l=linux-serial&m=152460460418058&w=2
>
> I am afraid that a whitelist is not going to fly, that means
> duplicating all the device-ids in all the relevant drivers and that
> everytime we add a device-id we need to do so in 2 places. Just take
> a look at drivers/bluetooth/hci_bcm.c at the device-id list starting
> at line 1187 and that is just 1 driver.

I had seen the linked mail but was missing the context given here. I am
not that familiar with the serial devices framework.

>
> I also mention a hack for RTL8723BS devices there, but those have
> gotten a proper in kernel driver in the mean time.
>
> Looking at the ACPI device id list in the proposed upstream fix
> with a "hsuart serdev driver":
> https://www.spinics.net/lists/linux-serial/msg30035.html
>
> +static const struct acpi_device_id hsuart_acpi_match[] = {
> +	{"INT3511", 0},
> +	{"INT3512", 0},
> +	{ },
> +};
>
> Then blacklist with just these 2 ids would clearly be a much better
> approach, as we are talking 2 ids vs 50+ ids here for whitelist vs
> blacklist.
>
> The whitepaper on this:
> https://www.intel.com/content/dam/www/public/us/en/documents/white-papers/enabling-multi-com-port-white-paper.pdf
> Also mentions these 2 as "the default Hardware IDs (INT3511 and INT3512) used here are Intel HS-UART COM
> port peripheral device IDs." as the hardware ids to use if the port has no
> specific function, in other words to use these 2 ids when under Linux the
> serial-port should just show up as a /dev/ttyS* device.
>
> So I believe that the fix here is using a blacklist with just these 2
> ids in there.

That makes sense.

A shorter list of exceptions is better than the longer list of supported
device list that is going to be duplicated.

I will respin the patches taking the blacklist approach if there is no
other feedback.

Thanks,
Punit
