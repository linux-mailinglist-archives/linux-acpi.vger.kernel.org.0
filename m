Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2115641595
	for <lists+linux-acpi@lfdr.de>; Sat,  3 Dec 2022 11:13:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbiLCKNu (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 3 Dec 2022 05:13:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbiLCKNs (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 3 Dec 2022 05:13:48 -0500
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CCDC60B47
        for <linux-acpi@vger.kernel.org>; Sat,  3 Dec 2022 02:13:45 -0800 (PST)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-3bfd998fa53so72210077b3.5
        for <linux-acpi@vger.kernel.org>; Sat, 03 Dec 2022 02:13:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wBmOYpLKCwO+tluU+vXuBFaOvnYFkQdkgAkJOn+z3dE=;
        b=c01aXZEpL0lsGvIA8axQe+u0D5W+oSU3f2s1Gm1moPtzCMq7V6qhDKa5+E4TFaauDq
         y5xA8RXPhwRaBOegCIutXehvF46kxBJD1BNcjadTbJXheEVd0LwRK4WaW1Sf9Bir6mZS
         ZmXMcBLfkCr+mg4Z7117YwF2NtNZoYCTx6/FPH82bE8UUdJQe4ELS3ACKG1LxTxv9/C9
         6CQmkibSdtiwQOR3k1LtbtnL6VBl0rXeRcC/7JOr6pkVEyNaOcXdwwAJMelTT291IJih
         djL6g7YGLqDZWZLMNbg56JMRNYbcY82lbDhHtNzq7uyAq9TXMe1f+ucw4g7JUfhzsWh/
         NtuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wBmOYpLKCwO+tluU+vXuBFaOvnYFkQdkgAkJOn+z3dE=;
        b=4Np91MaMFEDw27X+YtB7aYXnBUEZwoZEATMagjsi/AxGN+srDqgCBbwePFkXAFAH9o
         W1/rFrsSkNkJlWYIo4wlBBYvHwxyDLf/aZdvGxn2dq0IHmyAHaWug7WQb3qH5GxlDND+
         rMgui6WwNneS4MYxKnR1+wQ+7GLHfkG+cheLrJzBrr6VYkmOkCqi2ZfEIChTIuRZdRBh
         rFSG9/vG97pR7JbNJcNxLDlGspHsz/+WnJpK1RQaWNBcLjG/p8b+3ZJ1sLHEZ9R8jKAY
         E8DZGY8bv5Oqdx09qmcw0A3p/KWQecRkeyfbxyxjsH8ZygzY7DnSHNZpzhYWZYcVNBaI
         rUfA==
X-Gm-Message-State: ANoB5pmEiL3quWxH/6naAz8T8P4IzBXwaSUzdtwhW7yAaIZhO59xZqXb
        amPYA3JkGh7nKJHG7aJpyfHJbfSCJl4quc4qgswSWQ==
X-Google-Smtp-Source: AA0mqf5P+F3W24LqvzZ/BBOs/LJ4Ngbv0DrAifTQsBQOZeF8RCBig/ivNxeXFYX51WC62r2ttDGLXvEgNy1hqn2K9hw=
X-Received: by 2002:a0d:e645:0:b0:3bb:6406:3df1 with SMTP id
 p66-20020a0de645000000b003bb64063df1mr35954717ywe.319.1670062424683; Sat, 03
 Dec 2022 02:13:44 -0800 (PST)
MIME-Version: 1.0
References: <20211015164809.22009-1-asmaa@nvidia.com> <20211015164809.22009-3-asmaa@nvidia.com>
In-Reply-To: <20211015164809.22009-3-asmaa@nvidia.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 3 Dec 2022 11:13:33 +0100
Message-ID: <CACRpkdagKTDgUYBkF3hdE69Zew22uOpN9Ojsqwc=BrKpFOehNA@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] net: mellanox: mlxbf_gige: Replace non-standard
 interrupt handling
To:     Asmaa Mnebhi <asmaa@nvidia.com>
Cc:     andy.shevchenko@gmail.com, linux-gpio@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, andrew@lunn.ch, kuba@kernel.org,
        bgolaszewski@baylibre.com, davem@davemloft.net, rjw@rjwysocki.net,
        davthompson@nvidia.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Oct 15, 2021 at 6:48 PM Asmaa Mnebhi <asmaa@nvidia.com> wrote:

> Since the GPIO driver (gpio-mlxbf2.c) supports interrupt handling,
> replace the custom routine with simple IRQ request.
>
> Signed-off-by: Asmaa Mnebhi <asmaa@nvidia.com>

Should this also be merged into the GPIO tree with patch 1?

Yours,
Linus Walleij
