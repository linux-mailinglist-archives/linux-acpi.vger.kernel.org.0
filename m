Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC7E1F7536
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Jun 2020 10:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726324AbgFLISQ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 12 Jun 2020 04:18:16 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:33504 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726297AbgFLISM (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 12 Jun 2020 04:18:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591949889;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LbTU48ojgO2FlIo9PAsC9R4igbZ13z+cUADaXE0FnOU=;
        b=aufwKLnvGuZrWaeCduCLOlFrAqSDZyJsk+VXEqBURvm/RlSqXyWsevYl1ZfX4reqfSRcyZ
        WLJW3gQBRcLPeNqSzaCHBMkR3GUuye3mbDYomI+8oWEibHId6yiPF4aiuJv1PDq6Yn8weu
        fR7bawkWoUgLg1nzEWyyoWS+DMBkI1E=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-360-BECNfx-xPuW-edIzBo8JZw-1; Fri, 12 Jun 2020 04:17:57 -0400
X-MC-Unique: BECNfx-xPuW-edIzBo8JZw-1
Received: by mail-ej1-f72.google.com with SMTP id gr26so3827496ejb.22
        for <linux-acpi@vger.kernel.org>; Fri, 12 Jun 2020 01:17:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LbTU48ojgO2FlIo9PAsC9R4igbZ13z+cUADaXE0FnOU=;
        b=s6O9znEcASwRUsKReOYRZpwTtW9WUEezAlv/1X8vm1GdId10s5LQowo8sfZpW3du4W
         YSHS9ANw+Kbmnz1URH/RYkPaYt8Y5J607v27LMAToUZMYKHpG4rTFFeX9be9NOSeevGB
         ISMd+1fiXOeAWytQI1ju/TCCp0SJyon/iGzU5jBBwkRYoVOM4quP4xaodTECTVy9ZJyv
         AoXqbiHC17TsvVqMZIwb5Dkr74PSyS0EwFWiOuWaOabjYGXXSgbhtaEDTo9tPekVO2V0
         ZZabngtsI6Jmwk1gm/Q6MWDwMPIhgbbTEtq4k/CRKKzl+qSfjH9v+qxZ9G1JpIdw0wX9
         I05g==
X-Gm-Message-State: AOAM53218svFklI5+Ym0MtvRx28ZtO5m2P4+ebphal/lsbDouEIQan9B
        zsQAO30VufLXj/lJEDoIvSmZaOY3XicPziJWQ1lfQoZf9LK1kJmBGGBs0V4BGtVHOVjUWkrwVJK
        VxyBJDAPq4y0dMxDjciCRXA==
X-Received: by 2002:a17:906:ccdd:: with SMTP id ot29mr11758803ejb.119.1591949875881;
        Fri, 12 Jun 2020 01:17:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxwtNGBDEJyj/avNl3UCU7R4ntwBo4aI35VOBMw7tHPjvk5hJcx1khBKXvQ05G75ytNLMmeTQ==
X-Received: by 2002:a17:906:ccdd:: with SMTP id ot29mr11758779ejb.119.1591949875662;
        Fri, 12 Jun 2020 01:17:55 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id mf24sm3166452ejb.13.2020.06.12.01.17.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jun 2020 01:17:54 -0700 (PDT)
Subject: Re: [PATCH v4 0/7] Support inhibiting input devices
To:     Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-input@vger.kernel.org,
        linux-tegra@vger.kernel.org, patches@opensource.cirrus.com,
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
        Peter Hutterer <peter.hutterer@redhat.com>,
        Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>,
        kernel@collabora.com
References: <2336e15d-ff4b-bbb6-c701-dbf3aa110fcd@redhat.com>
 <20200608112211.12125-1-andrzej.p@collabora.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <1821a5b7-cbf3-a739-2203-a93b06f0c6f2@redhat.com>
Date:   Fri, 12 Jun 2020 10:17:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200608112211.12125-1-andrzej.p@collabora.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 6/8/20 1:22 PM, Andrzej Pietrasiewicz wrote:
> This is a quick respin of v3, with just two small changes, please see
> the changelog below.
> 
> Userspace might want to implement a policy to temporarily disregard input
> from certain devices.
> 
> An example use case is a convertible laptop, whose keyboard can be folded
> under the screen to create tablet-like experience. The user then must hold
> the laptop in such a way that it is difficult to avoid pressing the keyboard
> keys. It is therefore desirable to temporarily disregard input from the
> keyboard, until it is folded back. This obviously is a policy which should
> be kept out of the kernel, but the kernel must provide suitable means to
> implement such a policy.
> 
> Due to interactions with suspend/resume, a helper has been added for drivers
> to decide if the device is being used or not (PATCH 1/7) and it has been
> applied to relevant drivers (PATCH 2,4,5,6/7).
> 
> PATCH 7/7 adds support for inhibiting input devices.
> 
> This work is inspired by:
> 
> https://chromium.googlesource.com/chromiumos/third_party/kernel/+/45c2d7bb398f74adfae0017e20b224152fde3822
> 
> and
> 
> https://chromium.googlesource.com/chromiumos/third_party/kernel/+/4ce0e8a3697edb8fd071110b3af65014512061c7
> 
> In this respin the elan_i2c patch is dropped and converting it will be
> addressed later.
> 
> v3..v4:
> - updated the comment in input_open_device() (Hans)
> - used more straightforward locking pattern in adc/exynos (Michał)
> 
> v2..v3:
> - ignored autorepeat events in input_get_disposition() if a key is not
> pressed (Hans)
> - dropped inhibit()/uninhibit() driver callbacks (Hans)
> - split ACPI button patch into taking the lock and using the helper (Rafael)
> - dropped the elan_i2c conversion
> - fixed typos in exynos adc
> 
> v1..v2:
> - added input_device_enabled() helper and used it in drivers (Dmitry)
> - the fact of open() and close() being called in inhibit/uninhibit paths has
> been emphasized in the commit message of PATCH 6/7 (Dmitry)
> 
> Andrzej Pietrasiewicz (6):
>    Input: add input_device_enabled()
>    Input: use input_device_enabled()
>    ACPI: button: Access input device's users under appropriate mutex
>    ACPI: button: Use input_device_enabled() helper
>    iio: adc: exynos: Use input_device_enabled()
>    platform/x86: thinkpad_acpi: Use input_device_enabled()
> 
> Patrik Fimml (1):
>    Input: Add "inhibited" property

The entire series looks good to me:

Acked-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


