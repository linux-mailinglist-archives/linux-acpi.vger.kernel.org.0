Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75519797773
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Sep 2023 18:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238949AbjIGQ0b (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 7 Sep 2023 12:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240136AbjIGQ0X (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Sep 2023 12:26:23 -0400
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31F8D7DBA
        for <linux-acpi@vger.kernel.org>; Thu,  7 Sep 2023 09:23:24 -0700 (PDT)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-5922b96c5fcso11280797b3.0
        for <linux-acpi@vger.kernel.org>; Thu, 07 Sep 2023 09:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694103669; x=1694708469; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KDyS14lOc9gIdV8qqpJN7dVOi7FiXE2O1crBwgTrNhg=;
        b=wrWMmNlBJQ62IYQuiiCTyMxDhslC294qta65F5m04uq/CYBEXIfWUzNTe9qiTEfCEQ
         9IIh6kM7RnhgSORCFMFQJFCvavUN/M/Octx/ATFEBV0OJnQ5hdWRe98hZ95aD1epOJjc
         hW2gpFmaWz/zZa2VR6H8h37rkZf4HGHFEU3NkKALsC4Fcwj/pZZ6Twr2M7oJEiNRJ+tn
         pn2YVfcOpk3cG9s0f/JX6zMITLTiGpiNR5SClI6/x7rBv1csCkkK3itrwShabfdh35ci
         7Nfmv8ZHrZWH1Lu6LBT9CEXP+Q2RVdlU/Lv+Hoar5FHRjtEbbnQSj+q/4W2Q/0krkZHI
         K9uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694103669; x=1694708469;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KDyS14lOc9gIdV8qqpJN7dVOi7FiXE2O1crBwgTrNhg=;
        b=N/Tkb2hmehyJcDNF24ebO4+zkMz4tANcaPCZOi/lScHxy+i80kvkBFj19EZ4uralH4
         vMgNss/VWfgKp3emdetsn+WkKpW/2LayIQDe1jvnyjV1HfpvWycMK1QUMv5QBfuJRfMj
         xxbwOm5arUbHjXzvtqHzNzZWDsDEu8S4K1lOHm7qrQ0/tzSG2IQ9//GD2W6CoA14AoCb
         bZuG3n2N0et66KrFNcSMn4tfATaCLazJgrwLYUOUtsA4TR3MhLb9thhBSQMgYXuo/UZg
         kS2TnZGjq3ATzJP+9+fLDugUPKxpeuzasm2YV2o1iasgx47ZvZH9uEkBvqWdqHf+axXO
         W76g==
X-Gm-Message-State: AOJu0Yyi/YlH9roJWEu3PI/I7hlsksfCshkB6bTORaGNU3jI3I+AjdAJ
        gIgh1sUZesEPzgc1styBlkbdSCDK6RGPEK19vOrg3k8qumHMfuyg
X-Google-Smtp-Source: AGHT+IGJ2fOJYbfgZwCYkGOqpBoV8zRdwms0YQyjwmM812KoO4CG3kmEhKK7s/PjKGQeVe41+y3pVjBhSp9/fdWja/U=
X-Received: by 2002:a25:408a:0:b0:d06:49e9:a29c with SMTP id
 n132-20020a25408a000000b00d0649e9a29cmr19754022yba.34.1694071374753; Thu, 07
 Sep 2023 00:22:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230905185309.131295-1-brgl@bgdev.pl> <20230905185309.131295-13-brgl@bgdev.pl>
In-Reply-To: <20230905185309.131295-13-brgl@bgdev.pl>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 7 Sep 2023 09:22:43 +0200
Message-ID: <CACRpkdYJhP5otaFXbn49sK_33GJMy85MszyD9rqoQT1-fqd9dA@mail.gmail.com>
Subject: Re: [PATCH 12/21] hte: allow building modules with COMPILE_TEST enabled
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dipen Patel <dipenp@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-acpi@vger.kernel.org, timestamp@lists.linux.dev,
        linux-tegra@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Sep 5, 2023 at 8:53=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl> =
wrote:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> Allow building all HTE modules with COMPILE_TEST Kconfig option enabled.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

This should be a separate patch should it not?
Just send it separately to Dipen so he can merge it.
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
