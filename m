Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDCEB262C03
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Sep 2020 11:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730128AbgIIJgD (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 9 Sep 2020 05:36:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730127AbgIIJf6 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 9 Sep 2020 05:35:58 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9E8AC061756
        for <linux-acpi@vger.kernel.org>; Wed,  9 Sep 2020 02:35:57 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id a12so1919387eds.13
        for <linux-acpi@vger.kernel.org>; Wed, 09 Sep 2020 02:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gEj+lZMiE2N3jtcmr4bdk2b4ihEa+T3DPwIHNq/FC0A=;
        b=MnAYd8sc0uAXa4xqRVnzLJOadO+X8KmqyIdvburVZXxUL900xJEyapW1Ct9zaawwd8
         kdze07iRXbco8NxlLs0ExiS6gTmQetCxZiIOmR9Yg+M8EawfaFn1iWYEgpGI0s42KylK
         dgB2r/HBUaniUTEIOcju/3mYFv4TyrExxjQTEOV00ZCEmbREPRWjjF7D9qzN19ighwhP
         0AsQKxChLAS+EvKvrfXgdsB0KUeINDtJ4IS3ZcAFQRpC/Muyg2qAxI6VwmuhLuXlBUFL
         8Q/nrHAacTrDozB1be9KjpVvtf3rTEIi0Ockq4zC2UPya7XOiPu4h5bCZRpWpz52UZcQ
         zWPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gEj+lZMiE2N3jtcmr4bdk2b4ihEa+T3DPwIHNq/FC0A=;
        b=dtjgWs5z8bSwhxYbJsSM7tPi9Vc0/CwoR2POB+yfigpJ83TRbno6j4qzPayRzsQ4CY
         0KN45hvFru3ebIsE58s8xCeZUV3twtIysDLrKLGVYeo2GqgnW6HGRfH9dd0RCtzXdZJU
         9/zHvQH23b6hb6WxT5WQhgIKkp5mbm0QNpmHApmGWgoUeWv35WvlF0eytdZBJqTQWY0Q
         ybPlWsc05Y57DTmc43Y4fPvjTq2esgijmhqQljxMlaiSCgH+rQ4YL0g2vKGH6gNHU5Dq
         YXC8HRy60JKaonzl3nBIFerPFT6dh3l8Kjrw+Pejh+jRK967yYmGl3agnmzm5yiwCCLU
         z7KQ==
X-Gm-Message-State: AOAM531ux08Kwzjua89MoxJ7BegZ5AztGqtSAzM/OAm3lF0S/FcnS+SP
        Zkabt38sev6ilxT1h2tn5YU0M0xwLbDI5NmsP1OmhQ==
X-Google-Smtp-Source: ABdhPJwhn4migTaK4XUgkdD/7pGNuIDSlXbAnJe2m4X+uNc0EalSYsW9Z+emyP0Y7X4qKQ74oQEQGGD1thAkW+JQzkY=
X-Received: by 2002:aa7:c9ce:: with SMTP id i14mr3328398edt.186.1599644156363;
 Wed, 09 Sep 2020 02:35:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200903081550.6012-1-sakari.ailus@linux.intel.com> <20200903081550.6012-7-sakari.ailus@linux.intel.com>
In-Reply-To: <20200903081550.6012-7-sakari.ailus@linux.intel.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Wed, 9 Sep 2020 11:35:45 +0200
Message-ID: <CAMpxmJX40=iYYxL9Uvs1Pjj9c3NvZBGJ9Mh9-87T0c==FKEXRw@mail.gmail.com>
Subject: Re: [PATCH v8 6/6] at24: Support probing while off
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     linux-i2c <linux-i2c@vger.kernel.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rajmohan Mani <rajmohan.mani@intel.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Bingbu Cao <bingbu.cao@intel.com>,
        Chiranjeevi Rapolu <chiranjeevi.rapolu@intel.com>,
        Hyungwoo Yang <hyungwoo.yang@intel.com>,
        linux-media <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Sep 3, 2020 at 10:15 AM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> In certain use cases (where the chip is part of a camera module, and the
> camera module is wired together with a camera privacy LED), powering on
> the device during probe is undesirable. Add support for the at24 to
> execute probe while being powered off. For this to happen, a hint in form
> of a device property is required from the firmware.
>
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> ---
>  drivers/misc/eeprom/at24.c | 43 +++++++++++++++++++++++---------------
>  1 file changed, 26 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
> index 8f5de5f10bbea..2d24e33788d7d 100644
> --- a/drivers/misc/eeprom/at24.c
> +++ b/drivers/misc/eeprom/at24.c
> @@ -595,6 +595,7 @@ static int at24_probe(struct i2c_client *client)
>         bool i2c_fn_i2c, i2c_fn_block;
>         unsigned int i, num_addresses;
>         struct at24_data *at24;
> +       bool low_power;
>         struct regmap *regmap;
>         bool writable;
>         u8 test_byte;
> @@ -733,25 +734,30 @@ static int at24_probe(struct i2c_client *client)
>
>         i2c_set_clientdata(client, at24);
>
> -       err = regulator_enable(at24->vcc_reg);
> -       if (err) {
> -               dev_err(dev, "Failed to enable vcc regulator\n");
> -               return err;
> -       }
> +       low_power = acpi_dev_state_low_power(&client->dev);
> +       if (!low_power) {
> +               err = regulator_enable(at24->vcc_reg);
> +               if (err) {
> +                       dev_err(dev, "Failed to enable vcc regulator\n");
> +                       return err;
> +               }
>
> -       /* enable runtime pm */
> -       pm_runtime_set_active(dev);
> +               pm_runtime_set_active(dev);
> +       }
>         pm_runtime_enable(dev);
>
>         /*
> -        * Perform a one-byte test read to verify that the
> -        * chip is functional.
> +        * Perform a one-byte test read to verify that the chip is functional,
> +        * unless powering on the device is to be avoided during probe (i.e.
> +        * it's powered off right now).
>          */
> -       err = at24_read(at24, 0, &test_byte, 1);
> -       if (err) {
> -               pm_runtime_disable(dev);
> -               regulator_disable(at24->vcc_reg);
> -               return -ENODEV;
> +       if (!low_power) {
> +               err = at24_read(at24, 0, &test_byte, 1);
> +               if (err) {
> +                       pm_runtime_disable(dev);
> +                       regulator_disable(at24->vcc_reg);
> +                       return -ENODEV;
> +               }
>         }
>
>         pm_runtime_idle(dev);
> @@ -771,9 +777,11 @@ static int at24_remove(struct i2c_client *client)
>         struct at24_data *at24 = i2c_get_clientdata(client);
>
>         pm_runtime_disable(&client->dev);
> -       if (!pm_runtime_status_suspended(&client->dev))
> -               regulator_disable(at24->vcc_reg);
> -       pm_runtime_set_suspended(&client->dev);
> +       if (!acpi_dev_state_low_power(&client->dev)) {
> +               if (!pm_runtime_status_suspended(&client->dev))
> +                       regulator_disable(at24->vcc_reg);
> +               pm_runtime_set_suspended(&client->dev);
> +       }
>
>         return 0;
>  }
> @@ -810,6 +818,7 @@ static struct i2c_driver at24_driver = {
>         .probe_new = at24_probe,
>         .remove = at24_remove,
>         .id_table = at24_ids,
> +       .flags = I2C_DRV_FL_ALLOW_LOW_POWER_PROBE,
>  };
>
>  static int __init at24_init(void)
> --
> 2.20.1
>

This currently conflicts with the fix I queued for at24 for v5.9.
Which tree is going to take this series?

Bartosz
