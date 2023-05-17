Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1D5F70643E
	for <lists+linux-acpi@lfdr.de>; Wed, 17 May 2023 11:35:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbjEQJfy (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 17 May 2023 05:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbjEQJfw (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 17 May 2023 05:35:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17880210C
        for <linux-acpi@vger.kernel.org>; Wed, 17 May 2023 02:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684316108;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oxK8LY/FjzSiRfo409GBi+hU1V7Stjw8B2NwjQo24BU=;
        b=eadeaHJh6jSMqySvA3oxR9EJ9HhucNteTAqe08jSqkQrLYXrZOhKof5Dj3tdWcDcp4XklS
        e9blSi0nMu18Whep8ARFjsG1e8hSFZ8TXYnDtITluVJxCitheZbGfLxH2Ly2FfMVXv3Yzx
        WeBmWgUnFKCtg7wP4/88SZ9QVRMvZrU=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-443-EDPp8eD0M2aSnnjcUa-Ifg-1; Wed, 17 May 2023 05:35:06 -0400
X-MC-Unique: EDPp8eD0M2aSnnjcUa-Ifg-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-9663552473fso70467366b.1
        for <linux-acpi@vger.kernel.org>; Wed, 17 May 2023 02:35:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684316105; x=1686908105;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oxK8LY/FjzSiRfo409GBi+hU1V7Stjw8B2NwjQo24BU=;
        b=IMsS94IHWsGMQs6lhY/q7UE73qIzTmfgxnTyM9h1Rxbw2JF22b2RmCfluu0ZIbZlPy
         Nolvk1u+B6UQjHDqnOYCqlIsEzg+N9qQfDwSwqK4SI9Q1GrejVpE405DgiG+nOHu+VUa
         ujThgiQ1cJ0ELDcmESZB45osd1x4Uw1sTEI1Wfnc8Bwj6zbT2F36j2LrZNeAVbaZVkG3
         nABjdVVaDxNnfq6+aGYdd/GTAGZpEtH8mBTPecpRmFN/ya81gXHNX6mkyQrHyZdUMq6/
         WVlJRkd/y35ncQYo0Xf4fpylUx47qLMV/H0x1hgdiLnzdyYL7upUUa3xNdFx//PNMbTI
         TrWw==
X-Gm-Message-State: AC+VfDxxzgzuibj9ly7acP7RXH33w7goP9h/x9Snd+wpOaj7zRneR2Vp
        w7usWiaDsN1d2S1el1RgsItNvyfWpkapnrFJrig4XwANrdzyBYbOxZFK7EUwD2wauQ/7wrP11Ii
        KdDSShWPOCc7oznoLeoZ5W45H96ROrA==
X-Received: by 2002:a17:907:3f90:b0:953:9899:d9c1 with SMTP id hr16-20020a1709073f9000b009539899d9c1mr47645527ejc.1.1684316105286;
        Wed, 17 May 2023 02:35:05 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5clou2zt6lGzIyt6E7UdDBDzztuSK6ldxsv6RhHgB2iDKWzZxrwFZBUZxHEG6FWpRJRl1yVQ==
X-Received: by 2002:a17:907:3f90:b0:953:9899:d9c1 with SMTP id hr16-20020a1709073f9000b009539899d9c1mr47645505ejc.1.1684316104943;
        Wed, 17 May 2023 02:35:04 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id jl4-20020a17090775c400b009658475919csm12106548ejc.188.2023.05.17.02.35.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 02:35:04 -0700 (PDT)
Message-ID: <1454e65b-1d99-4542-fdcb-e72b1e447b1c@redhat.com>
Date:   Wed, 17 May 2023 11:35:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 00/34] Remove .notify callback in acpi_device_ops
Content-Language: en-US, nl
To:     Michal Wilczynski <michal.wilczynski@intel.com>,
        linux-acpi@vger.kernel.org
Cc:     rafael@kernel.org, srinivas.pandruvada@linux.intel.com
References: <20230517075724.153992-1-michal.wilczynski@intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230517075724.153992-1-michal.wilczynski@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi all,

On 5/17/23 09:56, Michal Wilczynski wrote:
> Currently drivers support ACPI event handlers by defining .notify
> callback in acpi_device_ops. This solution is suboptimal as event
> handler installer installs intermediary function acpi_notify_device as a
> handler in every driver. Also this approach requires extra variable
> 'flags' for specifying event types that the driver want to subscribe to.
> Additionally this is a pre-work required to align acpi_driver with
> platform_driver and eventually replace acpi_driver with platform_driver.
> 
> Remove .notify callback from the acpi_device_ops. Replace it with each
> driver installing and removing it's event handlers.
> 
> v3:
>  - lkp still reported some failures for eeepc, fujitsu and
>    toshiba_bluetooth, fix those
> v2:
>  - fix compilation errors for drivers
> 
> Michal Wilczynski (34):
>   acpi: Adjust functions installing bus event handlers
>   acpi/ac: Move handler installing logic to driver
>   acpi/video: Move handler installing logic to driver
>   acpi/battery: Move handler installing logic to driver
>   acpi/button: Move handler installing logic to driver
>   acpi/hed: Move handler installing logic to driver
>   acpi/nfit: Move handler installing logic to driver
>   acpi/thermal: Move handler installing logic to driver
>   acpi/tiny-power-button: Move handler installing logic to driver
>   hwmon: Move handler installing logic to driver
>   iio/acpi-als: Move handler installing logic to driver
>   platform/chromeos_tbmc: Move handler installing logic to driver
>   platform/wilco_ec: Move handler installing logic to driver
>   platform/surface/button: Move handler installing logic to driver
>   platform/x86/acer-wireless: Move handler installing logic to driver
>   platform/x86/asus-laptop: Move handler installing logic to driver
>   platform/x86/asus-wireless: Move handler installing logic to driver
>   platform/x86/classmate-laptop: Move handler installing logic to driver
>   platform/x86/dell/dell-rbtn: Move handler installing logic to driver
>   platform/x86/eeepc-laptop: Move handler installing logic to driver
>   platform/x86/fujitsu-laptop: Move handler installing logic to driver
>   platform/x86/lg-laptop: Move handler installing logic to driver
>   platform/x86/panasonic-laptop: Move handler installing logic to driver
>   platform/x86/system76_acpi: Move handler installing logic to driver
>   platform/x86/topstar-laptop: Move handler installing logic to driver
>   platform/x86/toshiba_acpi: Move handler installing logic to driver
>   platform/x86/toshiba_bluetooth: Move handler installing logic to
>     driver
>   platform/x86/toshiba_haps: Move handler installing logic to driver
>   platform/x86/wireless-hotkey: Move handler installing logic to driver
>   platform/x86/xo15-ebook: Move handler installing logic to driver

Michal, I just stumbled over this patch-set while looking at
the lore.kernel.org linux-acpi archives...

17 of the patches here are for platform/surface or platform/x86
so I must say that I'm quite surprised that
platform-driver-x86@vger.kernel.org is not in the Cc for this patch-set?

And several of the pdx86 drivers at least also have individual driver
maintainers which should be Cc-ed. So that those maintainers can
hopefully help with reviewing reducing the workload for the subsystem
maintainers.

Please make sure to run scripts/get_maintainer for all touched files
and put all the relevant people on the Cc. Either do so for a future
v4, or if there is no reason atm to do a v4, please resend v3
with the Cc list extended.

Regards,

Hans






>   virt/vmgenid: Move handler installing logic to driver
>   acpi/bus: Remove installing/removing notify handlers from probe/remove
>   acpi/bus: Remove redundant functions
>   acpi/bus: Remove notify callback and flags
> 
>  drivers/acpi/ac.c                             |  14 +-
>  drivers/acpi/acpi_video.c                     |  18 ++-
>  drivers/acpi/battery.c                        |  14 +-
>  drivers/acpi/bus.c                            |  53 ++-----
>  drivers/acpi/button.c                         |  18 ++-
>  drivers/acpi/hed.c                            |   6 +-
>  drivers/acpi/nfit/core.c                      |  25 ++--
>  drivers/acpi/thermal.c                        |  20 ++-
>  drivers/acpi/tiny-power-button.c              |  18 +--
>  drivers/hwmon/acpi_power_meter.c              |  15 +-
>  drivers/iio/light/acpi-als.c                  |  23 ++-
>  drivers/platform/chrome/chromeos_tbmc.c       |  14 +-
>  drivers/platform/chrome/wilco_ec/event.c      |  19 ++-
>  drivers/platform/surface/surfacepro3_button.c |  19 ++-
>  drivers/platform/x86/acer-wireless.c          |  22 ++-
>  drivers/platform/x86/asus-laptop.c            |  16 ++-
>  drivers/platform/x86/asus-wireless.c          |  24 ++--
>  drivers/platform/x86/classmate-laptop.c       |  12 +-
>  drivers/platform/x86/dell/dell-rbtn.c         |  15 +-
>  drivers/platform/x86/eeepc-laptop.c           |  18 ++-
>  drivers/platform/x86/fujitsu-laptop.c         |  19 ++-
>  drivers/platform/x86/lg-laptop.c              |  12 +-
>  drivers/platform/x86/panasonic-laptop.c       |  17 ++-
>  drivers/platform/x86/system76_acpi.c          |  28 ++--
>  drivers/platform/x86/topstar-laptop.c         |  16 ++-
>  drivers/platform/x86/toshiba_acpi.c           | 131 +++++++++---------
>  drivers/platform/x86/toshiba_bluetooth.c      |  30 ++--
>  drivers/platform/x86/toshiba_haps.c           |   9 +-
>  drivers/platform/x86/wireless-hotkey.c        |  23 ++-
>  drivers/platform/x86/xo15-ebook.c             |  11 +-
>  drivers/virt/vmgenid.c                        |  30 ++--
>  include/acpi/acpi_bus.h                       |  10 +-
>  32 files changed, 457 insertions(+), 262 deletions(-)
> 

