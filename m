Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D9E01D58EE
	for <lists+linux-acpi@lfdr.de>; Fri, 15 May 2020 20:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbgEOSTS (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 15 May 2020 14:19:18 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58693 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726257AbgEOSTR (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 15 May 2020 14:19:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589566755;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Fedn2inRka4QMAnXx9FxSm7/vZYS9uY++6sVEGlzAa0=;
        b=FmfAuVh4QGkOpPgfhCFAuYt7jmv7Qagj1fzOAUyM01z8aAILrmmE7Ffn2dB4qTegdq1Shp
        d/5G7ZCAVreovBNZmSD9zeIoqfER5+DTXru1T58BU9nfaNx7+GQTLlGXQU0xm81jmqojTk
        ePaeUnUZj/WKqZMpPivCquDW6Q5eJEI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-332-oqJ15Pk8N2GNU5bfGiJJfw-1; Fri, 15 May 2020 14:19:13 -0400
X-MC-Unique: oqJ15Pk8N2GNU5bfGiJJfw-1
Received: by mail-wm1-f72.google.com with SMTP id a67so1544941wme.6
        for <linux-acpi@vger.kernel.org>; Fri, 15 May 2020 11:19:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Fedn2inRka4QMAnXx9FxSm7/vZYS9uY++6sVEGlzAa0=;
        b=IoaUt0JGmevePabN0fLzFD/0ZcwOobxsaQdMhLiUux/C3UyNeewZr6osboaYYmBcqH
         0qRp0K1w6cRfNc/8wy4IcxihtM3N6lok0yyJFTgtDgWgC+vSo6iO025mV2PnMKRuqJW9
         tZ+CNY9lv9+3PJU2z5bczIDKjlSCM/a5p0+Xz979Shr4dncrgGJnIs3kcrCqYpOnHYky
         qwEBdrgFWzpeDTsI6cNY5imQopMH2dPn/iPhWQTXK21syR5KG7du4e1+tMonWaFiF918
         zCdPx5QEJ2yGcPdSbbW/dz1h4XOAWWENKP8HxIlzCa761wZiKThmm6ecWA8xI6Xq8OKn
         oVag==
X-Gm-Message-State: AOAM533DaUC8Q0RIv8YKGI5B79GGOfKS3Q+ZzNTO43V1Kw9VzIba7QSB
        nlksANehZGIZ70Ele3gEEoXkeaFU+WHHvYa7GyVI7XNbjmlPqiys/139LATTTLmb4c0f4faVQDB
        /EUKyduOJ+PE3hYGhEyXiCw==
X-Received: by 2002:a1c:b406:: with SMTP id d6mr5299521wmf.89.1589566752682;
        Fri, 15 May 2020 11:19:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwEhyZogIb52tbS8Sjh71yaPa5wKbVCzzV1bSu62tN2QyZWoHUXHTTKTerADtg5ez9J3v5UBw==
X-Received: by 2002:a1c:b406:: with SMTP id d6mr5299458wmf.89.1589566752273;
        Fri, 15 May 2020 11:19:12 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id a15sm4604338wrw.56.2020.05.15.11.19.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 May 2020 11:19:11 -0700 (PDT)
Subject: Re: [PATCHv2 0/7] Support inhibiting input devices
To:     Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        linux-input@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-tegra@vger.kernel.org,
        patches@opensource.cirrus.com,
        ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Barry Song <baohua@kernel.org>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Nick Dyer <nick@shmanahar.org>,
        Ferruh Yigit <fery@cypress.com>,
        Sangwon Jee <jeesw@melfas.com>,
        Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>,
        kernel@collabora.com, Peter Hutterer <peter.hutterer@redhat.com>,
        Benjamin Tissoires <btissoir@redhat.com>
References: <20200506002746.GB89269@dtor-ws>
 <20200515164943.28480-1-andrzej.p@collabora.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <842b95bb-8391-5806-fe65-be64b02de122@redhat.com>
Date:   Fri, 15 May 2020 20:19:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200515164943.28480-1-andrzej.p@collabora.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Andrezj,

On 5/15/20 6:49 PM, Andrzej Pietrasiewicz wrote:
> Userspace might want to implement a policy to temporarily disregard input
> from certain devices, including not treating them as wakeup sources.
> 
> An example use case is a laptop, whose keyboard can be folded under the
> screen to create tablet-like experience. The user then must hold the laptop
> in such a way that it is difficult to avoid pressing the keyboard keys. It
> is therefore desirable to temporarily disregard input from the keyboard,
> until it is folded back. This obviously is a policy which should be kept
> out of the kernel, but the kernel must provide suitable means to implement
> such a policy.

Actually libinput already binds together (inside libinput) SW_TABLET_MODE
generating evdev nodes and e.g. internal keyboards on devices with 360°
hinges for this reason. libinput simply closes the /dev/input/event#
node when folded and re-opens it when the keyboard should become active
again. Thus not only suppresses events but allows e.g. touchpads to
enter runtime suspend mode which saves power. Typically closing the
/dev/input/event# node will also disable the device as wakeup source.

So I wonder what this series actually adds for functionality for
userspace which can not already be achieved this way?

I also noticed that you keep the device open (do not call the
input_device's close callback) when inhibited and just throw away
any events generated. This seems inefficient and may lead to
the internal state getting out of sync. What if a key is pressed
while inhibited and then the device is uninhibited while the key
is still pressed?  Now the press event is lost and userspace
querying the current state will see the pressed key as being
released.

On top of this you add special inhibit and uninhibit callbacks
and implement those for just a few devices. How do these differ
from just closing the device and later opening it again ?

Also using a sysfs property for this is very weird given that the
rest of the evdev interface is using ioctls for everything...

So all in all I see a lot of question marks here and I think we
need to have a detailed discussion about what use-cases this
series tries to enable before moving forward with this.

Regards,

Hans

