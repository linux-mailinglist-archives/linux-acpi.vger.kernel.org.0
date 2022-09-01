Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84BBA5A8B57
	for <lists+linux-acpi@lfdr.de>; Thu,  1 Sep 2022 04:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232761AbiIACRn (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 31 Aug 2022 22:17:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232279AbiIACRm (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 31 Aug 2022 22:17:42 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 724B816168F
        for <linux-acpi@vger.kernel.org>; Wed, 31 Aug 2022 19:17:40 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id g21so12276370qka.5
        for <linux-acpi@vger.kernel.org>; Wed, 31 Aug 2022 19:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=j4mrWd9ky+L9II6UDKVDLtEblb+62WK1l8D4i+ZLdeU=;
        b=VR0XMy7p1blRnOH42zVJHAVtkkRh7qTakgdbToz5bKvd5BpAI57dzC0EVbrAZ5umyu
         X6y1lHIgQj6JVN4yAfpqfbyClCg+I7jxZR+UFIQx98ZiKhFY6OLAHXqQZLGFbYKkwCLC
         0JtjU7v7iD5RJlv7d6uDAoIEkz9lEWlJiwBRc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=j4mrWd9ky+L9II6UDKVDLtEblb+62WK1l8D4i+ZLdeU=;
        b=8RzJgD2PZW0nq6QBN9iTbI/SfNYNOftODzJev1ZfSoTIqj4B/HP9oYopG2FAV4VrUB
         Oim0qhiqRXgaHsGmbuX9DDXR0Q2GRLUl3CawCZ2OnU4h33Iz+IsGgaTGeWTzP1UBvWHj
         5xSRc2V+msUAYA/eElNdNeYNIxldCM1CqYeXet54XOxzqZD1C3gIgKjdboqVWPJvXMSQ
         iVMAcAhBBWifXfGgfetxuJznw0FPUfZh2h/aP0Aqc0vvdPb6AJiuceE2oi6fxb4oD0cy
         CJuamTHl/+gUfAnAtgk5hP3CQLwt4w8f1gjbPo1lF5G2F4FgJi1JXV6K80eB/ymIkPqA
         KC/g==
X-Gm-Message-State: ACgBeo3WrCdd7UX7j7N68X5JwNBzHMgBc9JrlnX3sX56n1QBmFJYBqpf
        A77kXWtntd844Ojl0mScUbW8IiVvQB9U/A==
X-Google-Smtp-Source: AA6agR4cgocgB/pUO7yW8reKgJUgHwRicIsCUhI2oP/XMV4Wg6OKTGoiGS5H77Wo4OB+xd0XW0/BkQ==
X-Received: by 2002:a05:620a:1526:b0:6bb:f977:59bd with SMTP id n6-20020a05620a152600b006bbf97759bdmr16895947qkk.682.1661998659268;
        Wed, 31 Aug 2022 19:17:39 -0700 (PDT)
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com. [209.85.219.46])
        by smtp.gmail.com with ESMTPSA id bm2-20020a05620a198200b006b5f06186aesm11386364qkb.65.2022.08.31.19.17.35
        for <linux-acpi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Aug 2022 19:17:36 -0700 (PDT)
Received: by mail-qv1-f46.google.com with SMTP id cv7so9969074qvb.3
        for <linux-acpi@vger.kernel.org>; Wed, 31 Aug 2022 19:17:35 -0700 (PDT)
X-Received: by 2002:a05:6214:d66:b0:499:328:f654 with SMTP id
 6-20020a0562140d6600b004990328f654mr15720049qvs.26.1661998654736; Wed, 31 Aug
 2022 19:17:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220830231541.1135813-1-rrangel@chromium.org>
 <20220830171332.1.Id022caf53d01112188308520915798f08a33cd3e@changeid>
 <CAJZ5v0h10wrurjYG50dA+pCfRtNDqN=c8odQ0p6HJRnOyJh7KA@mail.gmail.com>
 <Yw+yqbaTi04Ydgkq@google.com> <Yw+zo9eUQM+T1eYZ@google.com>
In-Reply-To: <Yw+zo9eUQM+T1eYZ@google.com>
From:   Raul Rangel <rrangel@chromium.org>
Date:   Wed, 31 Aug 2022 20:17:23 -0600
X-Gmail-Original-Message-ID: <CAHQZ30C0Q39cSxTcfu3+6ZNj7iuRE6pJpc9aPdreFt4MNHqZRQ@mail.gmail.com>
Message-ID: <CAHQZ30C0Q39cSxTcfu3+6ZNj7iuRE6pJpc9aPdreFt4MNHqZRQ@mail.gmail.com>
Subject: Re: [PATCH 1/8] Input: elan_i2c - Use PM subsystem to manage wake irq
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        linux-input <linux-input@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Tim Van Patten <timvp@google.com>,
        "jingle.wu" <jingle.wu@emc.com.tw>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tony Lindgren <tony@atomide.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,WEIRD_QUOTING
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Aug 31, 2022 at 1:16 PM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> On Wed, Aug 31, 2022 at 12:12:41PM -0700, Dmitry Torokhov wrote:
> > On Wed, Aug 31, 2022 at 08:01:12PM +0200, Rafael J. Wysocki wrote:
> > > On Wed, Aug 31, 2022 at 1:16 AM Raul E Rangel <rrangel@chromium.org> wrote:
> > > >
> > > > The Elan I2C touchpad driver is currently manually managing the wake
> > > > IRQ. This change removes the explicit enable_irq_wake/disable_irq_wake
> > > > and instead relies on the PM subsystem. This is done by calling
> > > > dev_pm_set_wake_irq.
> > > >
> > > > i2c_device_probe already calls dev_pm_set_wake_irq when using device
> > > > tree, so it's only required when using ACPI. The net result is that this
> > > > change should be a no-op. i2c_device_remove also already calls
> > > > dev_pm_clear_wake_irq, so we don't need to do that in this driver.
> > > >
> > > > I tested this on an ACPI system where the touchpad doesn't have _PRW
> > > > defined. I verified I can still wake the system and that the wake source
> > > > was the touchpad IRQ GPIO.
> > > >
> > > > Signed-off-by: Raul E Rangel <rrangel@chromium.org>
> > >
> > > I like this a lot [...]
> >

> > I also like this a lot, but this assumes that firmware has correct
> > settings for the interrupt... Unfortunately it is not always the case
> > and I see that at least Chrome OS devices, such as glados line (cave, chell, sentry,
> > ect) do not mark interrupt as wakeup:
> >
> > src/mainboard/google/glados/variants/chell/overridetree.cb
> >
> >                         chip drivers/i2c/generic
> >                                 register "hid" = ""ELAN0000""
> >                                 register "desc" = ""ELAN Touchpad""
> >                                 register "irq" = "ACPI_IRQ_LEVEL_LOW(GPP_B3_IRQ)"
> >                                 register "wake" = "GPE0_DW0_05"
> >                                 device i2c 15 on end
> >

So the above entry specifies the `wake` register. This generates an
ACPI _PRW resource. The patch series will actually fix devices like
this. Today without this patch series we get two wake events for a
device. The ACPI wake GPE specified by the _PRW resource, and the
erroneous GPIO wake event. But you bring up a good point.

I wrote a quick and dirty script (https://0paste.com/391849) to parse
the coreboot device tree entries. Open source firmware is great isn't
it? ;)

$ find src/mainboard/google/ -iname '*.cb' | xargs awk -f touch.awk --
src/mainboard/google/eve/devicetree.cb
1
chip drivers/i2c/hid
register "generic.hid" = ""ACPI0C50""
register "generic.desc" = ""Touchpad""
register "generic.irq" = "ACPI_IRQ_LEVEL_LOW(GPP_B3_IRQ)"
register "hid_desc_reg_offset" = "0x1"
device i2c 49 on end
end
src/mainboard/google/eve/devicetree.cb
1
chip drivers/i2c/generic
register "hid" = ""GOOG0008""
register "desc" = ""Touchpad EC Interface""
device i2c 1e on end
end
src/mainboard/google/drallion/variants/drallion/devicetree.cb
1
chip drivers/i2c/generic
register "hid" = ""ELAN0000""
register "desc" = ""ELAN Touchpad""
register "irq" = "ACPI_IRQ_EDGE_LOW(GPP_B3_IRQ)"
register "probed" = "1"
device i2c 2c on end
end
src/mainboard/google/drallion/variants/drallion/devicetree.cb
1
chip drivers/i2c/generic
register "hid" = ""ELAN0000""
register "desc" = ""ELAN Touchpad""
register "irq" = "ACPI_IRQ_EDGE_LOW(GPP_B3_IRQ)"
register "probed" = "1"
device i2c 15 on end
end
src/mainboard/google/sarien/variants/arcada/devicetree.cb
1
chip drivers/i2c/generic
register "hid" = ""ELAN0000""
register "desc" = ""ELAN Touchpad""
register "irq" = "ACPI_IRQ_EDGE_LOW(GPP_B3_IRQ)"
register "probed" = "1"
device i2c 2c on end
end
src/mainboard/google/sarien/variants/arcada/devicetree.cb
1
chip drivers/i2c/hid
register "generic.hid" = ""PNP0C50""
register "generic.desc" = ""Cirque Touchpad""
register "generic.irq" = "ACPI_IRQ_LEVEL_LOW(GPP_B3_IRQ)"
register "generic.probed" = "1"
register "hid_desc_reg_offset" = "0x20"
device i2c 2a on end
end
src/mainboard/google/sarien/variants/sarien/devicetree.cb
1
chip drivers/i2c/generic
register "hid" = ""ELAN0000""
register "desc" = ""ELAN Touchpad""
register "irq" = "ACPI_IRQ_EDGE_LOW(GPP_B3_IRQ)"
register "probed" = "1"
device i2c 2c on end
end
Total Touchpad: 202
Total Wake: 195

Out of all the touchpads defined on ChromeOS it looks like only 4
devices are missing a wake declaration. I omitted touchpanels because
ChromeOS doesn't use those as a wake source. chromeos_laptop.c already
defines some devices with i2c board_info and it sets the
`I2C_CLIENT_WAKE` flag. I'm not sure if this is actually working as
expected. `i2c_device_probe` requires a `wakeup` irq to be present in
the device tree if the `I2C_CLIENT_WAKE` flag is set, but I'm assuming
the device tree was missing wake attributes.

Anyway, patches 6, and 7 are the ones that drop the legacy behavior. I
can figure out how to add the above boards to chromeos_laptop.c and
get the wake attribute plumbed, or I can add something directly to the
elan_i2c_core, etc so others can add overrides for their boards there.
I'll also send out CLs to fix the device tree configs (not that we
would run a FW qual just for this change).


> > I assume it should have been ACPI_IRQ_WAKE_LEVEL_LOW for the interrupt
> > to be marked as wakeup.
> >
> > (we do correctly mark GPE as wakeup).
> >
> > So we need to do something about older devices....
>
> After re-reading the patch I believe this comment is more applicable to
> the followup patch to elan_i2c, not this one, which is fine on its own.
>
> Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>
> Thanks.
>
> --
> Dmitry
