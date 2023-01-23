Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CE32678192
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Jan 2023 17:36:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233203AbjAWQgU (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 23 Jan 2023 11:36:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233194AbjAWQgT (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 23 Jan 2023 11:36:19 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2087F2B2A3;
        Mon, 23 Jan 2023 08:36:17 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id x5so10090848qti.3;
        Mon, 23 Jan 2023 08:36:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QR7e4YRCVj8cKg8ngMh755LkWTsMzsOiwqZAsVidrUs=;
        b=Ts8b1aes1Iz/bEXZEyHKUidQtM4BDBQsn8ziWe4lTG5BCuBHABuubzbDOghuMiBmWI
         1nFhKxlIYhCxwKEsfty0hMl6HlUYideBjuvg8Wx5Yzz8F6cb6crRYVq+YM7KmXPiYnGT
         iureZG41yzWGxcUhv03P0J7iyQHR4SlofzkhRC2nfLC7/hs3Heatjl+hvSjP8Km7JtyM
         p9vWmavNbYp6lrhDYFFTqAcoYUTMeS8TqmaiKaO+cfjVvhID3tPMwPA1DruzMWmbcnmN
         3zrLbtpZR0PeSUi78sLnLZlxzkhPNhKrWjXQCuWcr41s1MAyg7wC3NDnAK6y8Yn83BBN
         zoVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QR7e4YRCVj8cKg8ngMh755LkWTsMzsOiwqZAsVidrUs=;
        b=ayI5IHIOEJiXgf3pbaDCZJEbploYrqyBXJ2+Y1QVuOKSzWE2zrJ62+uewRcSTJ8fEC
         pIK2qB3U1noM+Ez4pUampwyyZV0FgG/9NpiD3XHnIQ2K83wrztmV3cwmbjzow5UYSCJI
         DPXRt6t/yEIo1tCYMjMqLjS519TfxvCdb9IJkQh1aHg66/o/8NRx1OsWe1+c5NPbd+LE
         CUSoV1b9BIGEyQEsMXFZhbCdmAmokLghp7Y+Hct6wpqbRhoGBuMb9OG3wLGoiRfzQ3ky
         zwKHxI6PBWtEHoZnDuvum595TWs/MSd3qKMKpNwECtjOzukkYaxi9vdfKisl0iZKNdCe
         M8+g==
X-Gm-Message-State: AFqh2kpWZ3EsMacFAf00ybILAE2zDXjftBfbC6+rImEgI1tMVrqhRH3G
        70OQDcriD1AWzu7z6ylSYGtZQvGgZL0Abm7DWaw=
X-Google-Smtp-Source: AMrXdXs0Rd/0e9T7NpAi8gCcnF3rB9VsJIdkEbxgrSw3F0BX1sNrEqBKsP6vf/PM+aXUvnPiZMXw6X7/8x/SFcvOvus=
X-Received: by 2002:ac8:6e81:0:b0:3b6:3c45:ada4 with SMTP id
 c1-20020ac86e81000000b003b63c45ada4mr1144928qtv.481.1674491776071; Mon, 23
 Jan 2023 08:36:16 -0800 (PST)
MIME-Version: 1.0
References: <20230123113750.462144-1-hdegoede@redhat.com> <20230123113750.462144-3-hdegoede@redhat.com>
In-Reply-To: <20230123113750.462144-3-hdegoede@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 23 Jan 2023 18:35:39 +0200
Message-ID: <CAHp75VeGo7toEdcAxJ7TNxGxTVx9OSD85yLrRbJXObe8j+O_sA@mail.gmail.com>
Subject: Re: [PATCH 2/3] platform/x86: apple-gmux: Add apple_gmux_detect() helper
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Aditya Garg <gargaditya08@live.com>,
        Mark Gross <mgross@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>, linux-acpi@vger.kernel.org,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Jan 23, 2023 at 1:38 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Add a new (static inline) apple_gmux_detect() helper to apple-gmux.h
> which can be used for gmux detection instead of apple_gmux_present().
>
> The latter is not really reliable since an ACPI device with a HID
> of APP000B is present on some devices without a gmux at all, as well
> as on devices with a newer (unsupported) MMIO based gmux model.
>
> This causes apple_gmux_present() to return false-postives on

positives

> a number of different Apple laptop models.
>
> This new helper uses the same probing as the actual apple-gmux
> driver, so that it does not return false positives.
>
> To avoid code duplication the gmux_probe() function of the actual
> driver is also moved over to using the new apple_gmux_detect() helper.

...

> +       if (!apple_gmux_detect(pnp, &indexed)) {
> +               pr_info("gmux device not present\n");

You may start using dev_info(&pnp->dev, ...) if I'm not mistaken.

> +               return -ENODEV;
> +       }

...

> +static inline bool apple_gmux_detect(struct pnp_dev *pnp_dev, bool *indexed_ret)
> +{
> +       u8 ver_major, ver_minor, ver_release;
> +       struct resource *res;
> +       bool indexed = false;
> +
> +       if (!pnp_dev) {
> +               struct acpi_device *adev;
> +               struct device *dev;
> +
> +               adev = acpi_dev_get_first_match_dev(GMUX_ACPI_HID, NULL, -1);
> +               if (!adev)
> +                       return false;
> +
> +               dev = acpi_get_first_physical_node(adev);
> +               if (!dev)

I remember I saw something like this in your tree(?). I hope it's not
pending upstream (yet) because of a leak here. Don't forget to call
acpi_dev_put() after you finish with adev. Recently I have fixed a
bunch of similar issues in ASoC Intel.

> +                       return false;
> +
> +               pnp_dev = to_pnp_dev(dev);
> +       }
> +
> +       res = pnp_get_resource(pnp_dev, IORESOURCE_IO, 0);
> +       if (!res)
> +               return false;
> +
> +       if (resource_size(res) < GMUX_MIN_IO_LEN)
> +               return false;
> +
> +       /*
> +        * Invalid version information may indicate either that the gmux
> +        * device isn't present or that it's a new one that uses indexed io.
> +        */
> +       ver_major = inb(res->start + GMUX_PORT_VERSION_MAJOR);
> +       ver_minor = inb(res->start + GMUX_PORT_VERSION_MINOR);
> +       ver_release = inb(res->start + GMUX_PORT_VERSION_RELEASE);
> +       if (ver_major == 0xff && ver_minor == 0xff && ver_release == 0xff) {
> +               indexed = apple_gmux_is_indexed(res->start);
> +               if (!indexed)
> +                       return false;
> +       }
> +
> +       if (indexed_ret)
> +               *indexed_ret = indexed;
> +
> +       return true;
> +}

-- 
With Best Regards,
Andy Shevchenko
