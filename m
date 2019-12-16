Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 510F311FE7E
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Dec 2019 07:30:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbfLPG3x (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 16 Dec 2019 01:29:53 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:38849 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726054AbfLPG3x (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 16 Dec 2019 01:29:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576477791;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3ubOp4aTqnj6ZbGuFbvUqKZ36Xlj3G+DpTScuo3T0AU=;
        b=OJtAqmo7njAgxg68Du1n2bRN0Qf0RSaX2DAQGWuDxFMIzth/1PEyuC37S1mmpWGoAHyytP
        ZQzCLwRruJNooqldryRwQVz0o7Ffr2fwJjW00/pbWLK6Rrk4LutG9qGGk1EYadU32UcGG4
        HvfmPsQHnW1bh+NF1P9tG2M0U4Q+d9s=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-278-erHkvDE2NYC8628KXNL7XA-1; Mon, 16 Dec 2019 01:29:50 -0500
X-MC-Unique: erHkvDE2NYC8628KXNL7XA-1
Received: by mail-wr1-f69.google.com with SMTP id c6so3238012wrm.18
        for <linux-acpi@vger.kernel.org>; Sun, 15 Dec 2019 22:29:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3ubOp4aTqnj6ZbGuFbvUqKZ36Xlj3G+DpTScuo3T0AU=;
        b=d2S3X01wg1ayPzVlQJK13j97UHlF0cJonWivykGoLEFAThJfSOgsEx2VJtu6H73DoO
         QEuaiUye46T9bop+0oRQccr4XmE+jM1/st+KdX8IYnJBrRuk1j4vwdsQtVyLxkQsPy/8
         srZ9X2ILHKzMuobfzijmEqxCAPVLD7qq/G3BDT/tMS0RDy8v1TgzUiQ24YYgbbtZ5iPi
         4OCcSumEwWnFEN8w8jWSExLNF5LOzMgtNpFGi1INq4RHDQ5EKc7wjZYo5yyVOKr2S/rb
         KANXGQ9/SLsyiwYK4N+yp0sV8s6HUc79LMSJYG2DJ9vCJqUX6LqPoK5CHFBjd29+f5gs
         yojA==
X-Gm-Message-State: APjAAAWx8Ja6+6ORqR9F7+DJ3CMCPijuRcclVak5uvZGaOakcMaVg3jQ
        agVXzm2MvuhhK18ea7IFFCOLnNF9+X3gHpKKJHoPKtjKEWTLWyrZR2gsVwHHLsnzuUI0HMUBcik
        EsX7oQXC7BqsvwAoqc2YGlQ==
X-Received: by 2002:a05:6000:1047:: with SMTP id c7mr28957262wrx.341.1576477789067;
        Sun, 15 Dec 2019 22:29:49 -0800 (PST)
X-Google-Smtp-Source: APXvYqy5v7XSpxm+l0b1T0k9utZR94Uy7YosafjTNXNGPHxOytdatpSqvDrmEJH9IFcj7ox38kO7Ig==
X-Received: by 2002:a05:6000:1047:: with SMTP id c7mr28957247wrx.341.1576477788836;
        Sun, 15 Dec 2019 22:29:48 -0800 (PST)
Received: from shalem.localdomain (2001-1c00-0c0c-fe00-7e79-4dac-39d0-9c14.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:7e79:4dac:39d0:9c14])
        by smtp.gmail.com with ESMTPSA id a9sm10614812wmm.15.2019.12.15.22.29.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Dec 2019 22:29:48 -0800 (PST)
Subject: Re: [RFC 0/1] serdes: Add whitelist to bring back missing serial port
To:     Punit Agrawal <punit1.agrawal@toshiba.co.jp>,
        linux-serial@vger.kernel.org
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        nobuhiro1.iwamatsu@toshiba.co.jp, shrirang.bagul@canonical.com,
        robh@kernel.org, gregkh@linuxfoundation.org, johan@kernel.org
References: <20191216040825.523720-1-punit1.agrawal@toshiba.co.jp>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <b1ce4dff-7239-640a-fcc3-4ff935fdb3a7@redhat.com>
Date:   Mon, 16 Dec 2019 07:29:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191216040825.523720-1-punit1.agrawal@toshiba.co.jp>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

HI,

On 16-12-2019 05:08, Punit Agrawal wrote:
> 
> Hi,
> 
> While booting v5.5-rc1 on Apollo Lake based UP2[0], I ran into an
> issue with the primary serial port. The kernel is able to output to
> ttyS0 but systemd isn't able to raise a login prompt. On further
> investigation, it turns out that no serial device (/dev/ttyS0) is
> being created as the device is claimed by serdev sub-system.
> 
> The issue has been reported in a few different places[0][1]. A patch
> was proposed to solve the issue but there doesn't seem to be any
> further progress[2]. Feedback on the thread suggested implementing a
> whitelist based approach - which is what this RFC does.
> 
> With this patch, systemd is able to create a login prompt. The
> whitelist has intentionally been left blank as it's not clear which
> devices go in there.

As I already mentioned when discussing this upstream:

https://marc.info/?l=linux-serial&m=152460460418058&w=2

I am afraid that a whitelist is not going to fly, that means
duplicating all the device-ids in all the relevant drivers and that
everytime we add a device-id we need to do so in 2 places. Just take
a look at drivers/bluetooth/hci_bcm.c at the device-id list starting
at line 1187 and that is just 1 driver.

I also mention a hack for RTL8723BS devices there, but those have
gotten a proper in kernel driver in the mean time.

Looking at the ACPI device id list in the proposed upstream fix
with a "hsuart serdev driver":
https://www.spinics.net/lists/linux-serial/msg30035.html

+static const struct acpi_device_id hsuart_acpi_match[] = {
+	{"INT3511", 0},
+	{"INT3512", 0},
+	{ },
+};

Then blacklist with just these 2 ids would clearly be a much better
approach, as we are talking 2 ids vs 50+ ids here for whitelist vs
blacklist.

The whitepaper on this:
https://www.intel.com/content/dam/www/public/us/en/documents/white-papers/enabling-multi-com-port-white-paper.pdf
Also mentions these 2 as "the default Hardware IDs (INT3511 and INT3512) used here are Intel HS-UART COM
port peripheral device IDs." as the hardware ids to use if the port has no
specific function, in other words to use these 2 ids when under Linux the
serial-port should just show up as a /dev/ttyS* device.

So I believe that the fix here is using a blacklist with just these 2
ids in there.

Regards,

Hans

