Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74037647055
	for <lists+linux-acpi@lfdr.de>; Thu,  8 Dec 2022 14:01:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbiLHNBO (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 8 Dec 2022 08:01:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbiLHNBN (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 8 Dec 2022 08:01:13 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B6678D66E;
        Thu,  8 Dec 2022 05:01:11 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id e18so894225qvs.1;
        Thu, 08 Dec 2022 05:01:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fekV9oATPpFDs1lXKps2/TiD0fsHdaC60pqXyCCT6CA=;
        b=HrnMNcLFVA9+1T8Kv9eFSiQOYSSJnL5i9412wnnuT/Zle1WIPEIHTlcplWMr0KCRE0
         w3OZl4AafO4x7wNiEEtbSTPLuyuDUzkaDXvUFFMpB2qI5GyJwSg9admPrPTJb+bS2dx5
         W8azC1pq0vLf84sj9NPC1S6ptUIrges3JfOgls77oK8hWRWQdN66MUc+mE0nieaa+YsH
         QnEsIhdelRoAt7v9eYaeydX8Q8zBbx6Ucx/SPsM6iYs9y2vMNhdYSwxpmXxSEnmmK+OD
         MiyOY3vLLkNTmR7TNxJKepJvLC0cvtzFkcuGpi4rRjoVlTYO8WtjeT8k+PZosek913od
         jEbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fekV9oATPpFDs1lXKps2/TiD0fsHdaC60pqXyCCT6CA=;
        b=u20M5JOlyeCJ0whm8dNwYtUSh0d98OWDhQOzDuXUpW6lNaD9poT0FL0bNOnocpFkFg
         7/glfFkmvfYtafD4g0NF7fZbsqc9Y7bjrsBDNTZPQrYyK4zyhvkCVeE8qQK9Z4kDl5OX
         3ZnqVKW1vCgSBG1/SG1f1dLeUgimYdff083sQqmlpD1OJITn8cwQ+BRwPqiRNpoUewfR
         ZomwcwM5pNnwwVHU6rZW4X7Gd7cVL4SXkj7CzihL1xS91GPUefvi0MND6SSti4ukrjMN
         h8N+EW4rN9UBZsbRVmsqS5vdm5fG9t8S+DUMG81RED+Tubp1+C6ILt1mnixFfYb9o8qT
         9E4g==
X-Gm-Message-State: ANoB5pnG+eX47Oqvlpragr+mvKmuAj6joaV4ReKy8lbmtOO7R/QJEK9C
        0fUq4FsAa2Oge31KJPqcRxRtPBoZEfMMfluZm0iie3kmC8I=
X-Google-Smtp-Source: AA0mqf5IAq6OQH+V7WtQp87dAj/PAN5PzrOY6psk/23zLQDByhuFLl7u/aWjqt/iwn45EgKa7icd5S5lT1oLmafkaRw=
X-Received: by 2002:ad4:5366:0:b0:4c6:73ac:5a5 with SMTP id
 e6-20020ad45366000000b004c673ac05a5mr85807965qvv.48.1670504470503; Thu, 08
 Dec 2022 05:01:10 -0800 (PST)
MIME-Version: 1.0
References: <20221208110202.107326-1-hdegoede@redhat.com>
In-Reply-To: <20221208110202.107326-1-hdegoede@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 8 Dec 2022 15:00:34 +0200
Message-ID: <CAHp75VdADDeXbu6ERc8ng8AdacHK4=uZeqb5jy0Vx_z3_=ZQmQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] ACPI: x86: Add skip i2c clients quirk for Medion
 Lifetab S10346
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andy@kernel.org>, linux-acpi@vger.kernel.org,
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

On Thu, Dec 8, 2022 at 1:02 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> The Medion Lifetab S10346 is a x86 tablet which ships with Android x86 as
> factory OS. The Android x86 kernel fork ignores I2C devices described in
> the DSDT, except for the PMIC and Audio codecs.
>
> As usual the Medion Lifetab S10346's DSDT contains a bunch of extra I2C
> devices which are not actually there, causing various resource conflicts.
> Add an ACPI_QUIRK_SKIP_I2C_CLIENTS quirk for the Medion Lifetab S10346 to
> the acpi_quirk_skip_dmi_ids table to woraround this.

workaround


Both look good to me,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Side note. We adding a lot of DMI matching information here and there
in the drivers and often it gets duplicated in handful of times, Maybe
at some point we can create a global enum and matching table, let's
say driver/platform/x86/dmi-platforms.c with
include/linux/platform_data/x86/platform.h with global enum of the
platforms?

-- 
With Best Regards,
Andy Shevchenko
