Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D7381308E6
	for <lists+linux-acpi@lfdr.de>; Sun,  5 Jan 2020 16:59:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbgAEP7T (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 5 Jan 2020 10:59:19 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:44882 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726293AbgAEP7T (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 5 Jan 2020 10:59:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578239957;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Qsd4xQjV0MAUWYLcVjPUOgsuXdreREynKwW8aU1/grY=;
        b=G6xOnqan/xfkvCMqagdands1o3/KVcTXdXrzbP3MsjtB52jLqgemKkQTO7GEoUSCtrNk6p
        1vhsjC/fGc1s3uM9384hNX795Abk05eDlokMCxF1p/g89X9E6TG1yI3mUUv73U7X5tY7bh
        onSj0AV4XbfAWyOmk/CY3NQjv1pbkQY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-163-YOe7GonHNwuvpxWf5PvJ0w-1; Sun, 05 Jan 2020 10:59:16 -0500
X-MC-Unique: YOe7GonHNwuvpxWf5PvJ0w-1
Received: by mail-wr1-f69.google.com with SMTP id t3so25130804wrm.23
        for <linux-acpi@vger.kernel.org>; Sun, 05 Jan 2020 07:59:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Qsd4xQjV0MAUWYLcVjPUOgsuXdreREynKwW8aU1/grY=;
        b=mf9bAA9Muydw0n5GSAeI4Byf1lDSgzjI2EXJ6OZec0rAv2dZYleDomlh+6RCIDrDm6
         5t9oiNy+5ewaYI7vMuq1saAiPu6aXmRkDfAja5aq/P4SLe+PHKqMijoSbeU830IOhnzs
         spTysKkeTIDvY40FvtIqD77dOnCwKiNFtsBJ3q0/cPGNEOaVg7P43MHbQVR29Bc8gwyz
         Yf7ly2Kxfsoj1QjmIbAZxV7OWD/N41IZUfqs5tPKx8P/jbC16phIwmtRYvlgeEys6Rz8
         Jc7O4JTMYhmpBCvdK6S2Y2NbyakCLi0Gx60U0rT4RlCfdt2Wozi76uqwQqh1nWwsdxoC
         NeLA==
X-Gm-Message-State: APjAAAVWI4rg+03HaQp70FzzR73CbMvnu2cRhGF/Kz4oGpTiNtGRBxCM
        Q8GxjdKwPaT+qjWLRiwC1uLoTprsgVj2bRnRKfxJFeCQmKdQQ7Hqs0qgRjg3JIIjT12U22WsnPP
        gESY/ZITsnU/Q4bo4yHDqLQ==
X-Received: by 2002:a5d:62d1:: with SMTP id o17mr105239972wrv.9.1578239955351;
        Sun, 05 Jan 2020 07:59:15 -0800 (PST)
X-Google-Smtp-Source: APXvYqxmEjoTYwcL07PO4pxrSWxYiW4XxA/mVvxs6chBNaO4zCMMkvtLx8WFBp3GkOiqnd9PMMbj9Q==
X-Received: by 2002:a5d:62d1:: with SMTP id o17mr105239962wrv.9.1578239955196;
        Sun, 05 Jan 2020 07:59:15 -0800 (PST)
Received: from shalem.localdomain (2001-1c00-0c0c-fe00-7e79-4dac-39d0-9c14.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:7e79:4dac:39d0:9c14])
        by smtp.gmail.com with ESMTPSA id v62sm19764187wmg.3.2020.01.05.07.59.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Jan 2020 07:59:14 -0800 (PST)
Subject: Re: [PATCH v2 1/2] gpiolib: acpi: Turn dmi_system_id table into a
 generic quirk table
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
References: <20191127104509.10196-1-hdegoede@redhat.com>
 <CACRpkdZVPJyagQT4UwZDUHBvg0erFCwQumNKX9U3=AcHi=ZQGw@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <e9d400cd-5a3d-9f08-bfd7-58a24e365e94@redhat.com>
Date:   Sun, 5 Jan 2020 16:59:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <CACRpkdZVPJyagQT4UwZDUHBvg0erFCwQumNKX9U3=AcHi=ZQGw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 28-11-2019 14:35, Linus Walleij wrote:
> On Wed, Nov 27, 2019 at 11:45 AM Hans de Goede <hdegoede@redhat.com> wrote:
> 
>> Turn the existing run_edge_events_on_boot_blacklist dmi_system_id table
>> into a generic quirk table, storing the quirks in the driver_data ptr.
>>
>> This is a preparation patch for adding other types of (DMI based) quirks.
>>
>> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> 
> This patch does not apply to my "devel" branch, which I am about
> to send to Torvalds, so it will very soon be the mainline.

Sorry for being a bit slow with responding to this
(this mail got buried under a bunch of other mails).

> Could you rebase it and I will queue it up for fixes.

Done (on 5.5-rc4, which for gpiolib-acpi.c that is fully up2date with
your for-next).

> Also: should these two be tagged for stable? (I.e. a non-v5.5
> problem.) I suppose that requires backporting for -stable
> though.

Given that the problem which the second patch works around is somewhat
nasty, yes these should probably go to the stable series. I've added
Cc: stable to them for the rebase.

I will send out the new versions right away.

Regards,

Hans

