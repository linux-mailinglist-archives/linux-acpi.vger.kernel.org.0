Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E568C105A2B
	for <lists+linux-acpi@lfdr.de>; Thu, 21 Nov 2019 20:05:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbfKUTFc (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 21 Nov 2019 14:05:32 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47274 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726279AbfKUTFc (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 21 Nov 2019 14:05:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574363130;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=6nEG2k9gfRSN2ieHGWz+BU0SSVzLhzytgA1X+lfJNrE=;
        b=CJ82YAK0ZSRLdMUiuOT7QFuwTHysh6zOku/fLYz4hdMSd8Fgk1r0T8oBsJuQwXZ3ERpMLO
        rqyCQNyylDTXhnUPIr0a9W5XR9As49ur0bevwhJjwgcSF6Q4xCPLAmryXxTsLk7QYvWCUz
        eChDzRwpfwIqatZmR67b/6UfiALS4Gw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-352-JIUBxVESOaiZCNKbpKcJQw-1; Thu, 21 Nov 2019 14:05:28 -0500
Received: by mail-wm1-f69.google.com with SMTP id v8so1981389wml.4
        for <linux-acpi@vger.kernel.org>; Thu, 21 Nov 2019 11:05:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=KDr/7SX2LNVcwOKb++q8TjMzZUQQB7dhWNAZpKLHgWk=;
        b=X/ZIIVrOpC+TPw9pUltW51R6/9ADs/DPb5v/WXekHLkAWkEBksWF4bcISdKDht3kmg
         1JDfeej//jnjQGeo0T4ci0i7YgLqlq+P2O4fpBhxaYOB5DTbfG8c5ETAQXDDbM8l7d8n
         1e7f5/MlzGEsSiW8IZL+aO/XWz6TuiPiiystMGfrRShrbjicJD/xYGCLM0XCOZz0FV9y
         jyyMlqtbXsULO1yX7uf8hYatfrM8hLjKDaDC+XnAaXdDu8It5uYstCvH9PltnWB/nh6J
         iT10yTfQi42LeUWIZzhvyQccndEnObh9yObkowSRmC/PzNJ6C4sm51H7hqxYbD6EyuR8
         leAw==
X-Gm-Message-State: APjAAAX9xwhzWP6NGxZSIy+5A97qj+ihGAZXD6b3q/FbPtwxDkLQURw/
        S8cEqWqa+NO3yd58+7wKduYurcC57SkKaAH5U5saJpRv/ER5UXNQfCN+rlT3CKM2TvpIxpDaYKh
        oLMsHmyyRh6OSZQoWFzyTzg==
X-Received: by 2002:adf:f9c4:: with SMTP id w4mr12578411wrr.88.1574363126349;
        Thu, 21 Nov 2019 11:05:26 -0800 (PST)
X-Google-Smtp-Source: APXvYqyk6ViYl5WmxPfKyMeSYIYunYfPMdKhB/5hrolUy72bPiuCu2on1clhpE9fK21nsC73fC7sKQ==
X-Received: by 2002:adf:f9c4:: with SMTP id w4mr12578371wrr.88.1574363125969;
        Thu, 21 Nov 2019 11:05:25 -0800 (PST)
Received: from shalem.localdomain (84-106-84-65.cable.dynamic.v4.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id r25sm585147wmh.6.2019.11.21.11.05.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2019 11:05:24 -0800 (PST)
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-acpi <linux-acpi@vger.kernel.org>
From:   Hans de Goede <hdegoede@redhat.com>
Subject: Problems with s2idle and _AEI handlers which are marked as wakeup
Message-ID: <61450f9b-cbc6-0c09-8b3a-aff6bf9a0b3c@redhat.com>
Date:   Thu, 21 Nov 2019 20:05:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
Content-Language: en-US
X-MC-Unique: JIUBxVESOaiZCNKbpKcJQw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Rafael,

I received an email from a user about his HP X2 10-x2-10-p018wm 2-in-1
not suspending. I checked which devices I have access to and found the
very similar HP X2 10-x2-10-p002nd model and I've reproduced this on
this model and I have spend 1.5 days debugging this.

There are 2 causes of spurious wakeups, 1 cause is the INT0002 vgpio
device. I have a local fix (dmi quirk) for the driver for that, but
that otherwise is out of scope for this discussion.

The other, more troublesome, cause of spurious wakeups is the way the
embedded-controller is hooked up. AFAICT normally Cherry Trail tablet
designs follow the so called "Hardware-reduced ACPI model" and they
do not have a classic external (to the SoC) EC.

But HP seems to have decided they wanted an external EC anyways so
they have added one, but since the SoC lacks the regular interface
bits for this it is bolted on and it does not use the standard ACPI EC
interface :|

Instead it uses I2C accesses and to report events it uses a _AEI handler
connected to one of the SoC's GPIOs. This handler is marked
"ExclusiveAndWake" which is not surprising for an EC event hander,
but since this is not using the standard ACPI EC mechanism,
this _AEI handler avoids the workaround for spurious EC wakeups from
acpi_s2idle_wake(), and thus is causing spurious wakeups.
Here is an acpidump + ready to use dsdt.dsl:
https://fedorapeople.org/~jwrdegoede/hp-x2-10-cht-p002nd/

To be precise, the _AEI handler calls a method called INTC() (defined at
line 24836 of dsdt.dsl) which does:

                 Local0 =3D GEVT ()
                 Switch (Local0)
                 {
                     Case (0x09)
                         do-stuff...
                     Case (0x0A)
                         do-other-stuff...

Etc. GEVT reads an event register over i2c and then the event gets
dispatched. While suspended 2 events trigger:

0x33 calls SYNT(), which reads time from RTC, writes it to EC
  This happens say every half hour or so
0x85 calls STMP(), which reads something through SMI, writes result to EC r=
egister CM17
  When suspended through the power-button this does not get called.
  When suspended by closing the LID, this gets called once a minute.

These really should just be handled and then we should go back to sleep,
but with the way we currently handle s2idle these events cause a full
wakeup.

I've checked what Windows does and for s2idle Windows seems to just power
down as much as possible, without really "freezing" as we do. Since it is
hard to detect a spurious wakeup with the LID closed I used ping to detect
wake-ups, with Windows this does not work, it simply keeps on pinging when
the LID is closed, so it seems to stay somewhat more "alive" then we do
and likely does not have issues with HP's approach here because of that.

I have the feeling that supporting HP's approach here is not going to be
easy. My main reason for sending out this email is to get my findings out
here and to start a discussion on how we can possibly fix this.

Since I do not expect this to get fixed anytime soon, for now I'm going
to submit a workaround where I disable the wakeup flag on the _AEI handler
with a quirk. This should be safe to do in this case, the event 0x33 thing
seems ok to ignore and since when the LID is not closed no 0x85 events happ=
en
I assume we can safely ignore those while suspended too. This does mean tha=
t
when opening the LID the device will not wakeup without pressing the
power-button as that is handled by the INTC() method too, in that case
it also does:

                            Notify (PWRB, 0x02) // Device Wake

So it seems that any solution for this would involve ignoring _AEI
handlers as wakeup sources (like we do for EC events) except when they
do a Notify with a parameter of 0x02 on some device.

Regards,

Hans

