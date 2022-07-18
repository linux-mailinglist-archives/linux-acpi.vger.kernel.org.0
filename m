Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 713F8577FB4
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Jul 2022 12:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234294AbiGRKdS (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 18 Jul 2022 06:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234267AbiGRKdR (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 18 Jul 2022 06:33:17 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 735181DA51
        for <linux-acpi@vger.kernel.org>; Mon, 18 Jul 2022 03:33:16 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id n74so20016437yba.3
        for <linux-acpi@vger.kernel.org>; Mon, 18 Jul 2022 03:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nB9TysPxASoCZq2mAu9xXViPEOO/JgqPxrNGpKeDpVM=;
        b=SBJxEmiH2w/cKdGxjgxmO0ELCL2TKEVUhjnrHf02yQcDhryh8KhJbZjCQLKQGk++Nb
         8NRjbtRS5fTBMu89pQaD4QQbY4IVRizv3Z4O870kh6S7lm/ldRQVOx5W9p8dE8uF8+q1
         gqg2Jd/fcZQHcRLuT+wb0O8fOnapWzaZMH5Liowteg/RcA8gHe0WV07PEXwSCJIfgWxk
         +wdXGDMDIJl3sz5FhRUP/2eq2YXFFYNpj2G+9C20ZrxnjY+gLD7DuEhrz0BMKf+9Ere+
         RH3XBHlqCJ8O07Lxqjw0ivBFpU9k3qjHLX2kXgQIAzto68wevq5RblZGEO7+W3NA0+fV
         qOaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nB9TysPxASoCZq2mAu9xXViPEOO/JgqPxrNGpKeDpVM=;
        b=gP4ALCVQEhW2LNVVC2qGCPh1nJCzuMV3E4FN2sIzwTojTNKghPYyInO7Gs1VOguaK6
         KqirCCNMOewf0F5gau/h8xd/sMsp28uzaNX/bQWJLmr5XFeqGj0OsMVP+LHAPH7ByoZ2
         BNPCslnKl9PdCyzb1omQV3S5CgM18MmgNau7RAwSygpmxGv3mlaZYSIiTjOAwrwIgfg9
         f7Ef5LruNq838+xG5J31XVYxlV5zQ33qgajTeX3MYh8Ug3o/1Mo/SaSSYXoQO6cwNDlK
         B3E0b8Nd6XWXccmq0L8ZxYRwDHORekkbLoF7UKCYpp7nCWuxgWENO3QPr2Rf9p4cpmr7
         buXA==
X-Gm-Message-State: AJIora+fzCbhBSQWqtItl9iftEkFIX+bQLSgqZ6R7trimlfOzTDZaHoY
        0Nx8uCCfJHEejxjNZf38LTU+8DqRVb31WOOJwK53Zw==
X-Google-Smtp-Source: AGRyM1vLEixkZHCYiYRq5YltGu2Qn8XImkgcCPCgMkUAGgYU0xegYa5n58mUOA0/a3wp8LIkZmDox8dNhNHDnjcvtHM=
X-Received: by 2002:a25:8c91:0:b0:670:5c00:7c6a with SMTP id
 m17-20020a258c91000000b006705c007c6amr1433817ybl.66.1658140395744; Mon, 18
 Jul 2022 03:33:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220713131421.1527179-1-nuno.sa@analog.com> <20220713131421.1527179-5-nuno.sa@analog.com>
In-Reply-To: <20220713131421.1527179-5-nuno.sa@analog.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 18 Jul 2022 12:33:04 +0200
Message-ID: <CACRpkdb7Sko3se4f8mYhyMxpr6rDYWO7_QnfizaHtBgLiVPFJA@mail.gmail.com>
Subject: Re: [PATCH 4/4] dt-bindings: gpio: add pull-disable flag
To:     =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>
Cc:     linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Frank Rowand <frowand.list@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Jul 13, 2022 at 3:13 PM Nuno S=C3=A1 <nuno.sa@analog.com> wrote:

> This extends the flags that can be used in GPIO specifiers to indicate
> that no bias is intended in the pin.
>
> Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
