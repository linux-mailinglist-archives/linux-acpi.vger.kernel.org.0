Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4F3799D04
	for <lists+linux-acpi@lfdr.de>; Sun, 10 Sep 2023 10:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344125AbjIJIIG (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 10 Sep 2023 04:08:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjIJIIB (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 10 Sep 2023 04:08:01 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 086FC187;
        Sun, 10 Sep 2023 01:07:56 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id 46e09a7af769-6bf2427b947so2322678a34.3;
        Sun, 10 Sep 2023 01:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694333276; x=1694938076; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IkX0/NLCs+uZeW+UKWZ7iWKytkFGyXc9WVXgBvwN01k=;
        b=C1CihWt84Ze+1xT48q7MzpdGdnRH62EWxigfUDLnG+Kn053xHEWBzruu7NcsNF96Np
         zE8p+JwjJDQCytBtlsMUHpaCfkB1ymeRks/F+uoVyXaYpMjzw2CjvDuBAG3cR+NPQach
         K1j5pQIxIEnhhjNd5Smd8mFgWLr2niZUt0D6hF2Yx9dI9unHzX51ylfBUhUSUYw5mbtq
         FZX3mKkFMxnI996UR4v+WSecHZ2WqARi3Oc4y6LU8FF3aB9tSjlHJtz6ivj0qYN1gV2v
         qf4nxIdVe0PECs+HN5qcKqgIZBJGTWqaBtmaues7ndbI66aLM5/8Y28KOZxmrA5+Fhb1
         421w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694333276; x=1694938076;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IkX0/NLCs+uZeW+UKWZ7iWKytkFGyXc9WVXgBvwN01k=;
        b=QFe4uS+Yn/uSgesXCQ7aCYbLSjlfoK4Iq7XMoIV0Gbmnm7mh+iGjuUZptPeA981P+8
         2xvcBm/EaOc/h8U+/fD6V98qYJM2wT9e6oDPtZJeHlUlVp1NWVaIFaV3YtHXCJtQpzHd
         O8UasfQuB2+khX0EUnyR32qpEN+UrOXrJNAAkI/edO/gVTAhZmvBZRvqB6GXn571ahxO
         KuEVn1xs9dl2IlN0Bx2gvfZ9YwCQFJat+gNQ1XL+HpHYYVgAiJ/6ho7VnX+zVpsB6GvI
         sgBiz2Qhgq7myUfrkt1F0JTjpD89QWmgxvIchFKgzsIF3xtUomggxSVAahuaYX4JNRaz
         lnNA==
X-Gm-Message-State: AOJu0Yz8eCUQcWFu9AgYactA1pGMoi/lU+x041AkbksQ/GThcDEKnXvO
        f7/XtkMjb8FBaHJEZSm2Mbg8TfbtiAP2VZ0jhiSpzIbiGJ8A8Q==
X-Google-Smtp-Source: AGHT+IETipyFGe2i+0fCQVv72PFcw6QafCmdBaoujU/sYAQDrNWn738XcH3j8m3O4W8r9K0V0xLuLHwQWCHN+l8xuZU=
X-Received: by 2002:a05:6870:b014:b0:196:45b7:9385 with SMTP id
 y20-20020a056870b01400b0019645b79385mr8082412oae.27.1694333276113; Sun, 10
 Sep 2023 01:07:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230909141816.58358-1-hdegoede@redhat.com> <20230909141816.58358-6-hdegoede@redhat.com>
In-Reply-To: <20230909141816.58358-6-hdegoede@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 10 Sep 2023 11:07:19 +0300
Message-ID: <CAHp75Vf0HC-PUZWLniUPZSYVbeVW33sT9yOQxgeftXi+GmQppw@mail.gmail.com>
Subject: Re: [PATCH 5/8] platform/x86: x86-android-tablets: Create a
 platform_device from module_init()
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sat, Sep 9, 2023 at 5:18=E2=80=AFPM Hans de Goede <hdegoede@redhat.com> =
wrote:
>
> Create a platform_device from module_init() and change
> x86_android_tablet_init() / cleanup() into platform_device
> probe() and remove() functions.
>
> This is a preparation patch for refactoring x86_android_tablet_get_gpiod(=
)
> to no longer use gpiolib private functions like gpiochip_find().

...

> +static int __init x86_android_tablet_init(void)
> +{

> +       if (!dmi_first_match(x86_android_tablet_ids)) {

Why do we need this? Module alias is based on DMI matching, is it
against manual loading?

> +               pr_err("error loaded on unknown tablet model\n");
> +               return -ENODEV;
> +       }
> +
> +       x86_android_tablet_device =3D platform_create_bundle(&x86_android=
_tablet_driver,
> +                                                  x86_android_tablet_pro=
be,
> +                                                  NULL, 0, NULL, 0);

So, in case of manual loading, would it be harmful for non-listed platforms=
?

> +       return PTR_ERR_OR_ZERO(x86_android_tablet_device);
> +}
> +
> +static void __exit x86_android_tablet_exit(void)
> +{
> +       platform_device_unregister(x86_android_tablet_device);
> +       platform_driver_unregister(&x86_android_tablet_driver);
> +}

> +

Instead of adding this blank line you can move
module_init()/module_exit() closer to the respective callbacks.

>  module_init(x86_android_tablet_init);
> -module_exit(x86_android_tablet_cleanup);
> +module_exit(x86_android_tablet_exit);

--=20
With Best Regards,
Andy Shevchenko
