Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54398577FB0
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Jul 2022 12:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234282AbiGRKcn (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 18 Jul 2022 06:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234230AbiGRKcm (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 18 Jul 2022 06:32:42 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FFEC1D33F
        for <linux-acpi@vger.kernel.org>; Mon, 18 Jul 2022 03:32:41 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-31dfe25bd49so64606747b3.2
        for <linux-acpi@vger.kernel.org>; Mon, 18 Jul 2022 03:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=64V5h6/X7Wjx5m1nkylh2H6thEd31QIKHGVSbZXsoNg=;
        b=y+Bb11Nn7lbZpi48Ys1bbGVZsZpdwxRUCE6emMk5fmECkUxx56FTwNuAh5XDq3miIl
         pY7a4VhUtbU08BIN9YWUY1ThRtAWZCBszC31Vfig9C+BKGNXS5sKs06yTIK9S5hax1im
         zbIyc5MS9NotXbFgCNPRBpMyNIZnGYfxOycR0t1OQiDyEGXYNY9tWn8hHx69KDuU8iYN
         5CWvXp91eyy5P4HhQ3sBdoENDVtw5oKEgFnU+LxF2HrdY8m2LvgbWodLj89VlMaREDNq
         XK3MFOdT41xTlKuP4bEythSXGgYw0ASFGZpPAlvq51Z4C4o8UbIvgdbkqRQ+ORVDkNK5
         Hs8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=64V5h6/X7Wjx5m1nkylh2H6thEd31QIKHGVSbZXsoNg=;
        b=BhaVeKn3y3l8H0M4yGIXhGFR8LaXqfejwKrArWDWwTCpdtY0da+JyWntGa0HtoJzOv
         Wn5PQZ5t7LTJQ+MAmUP5XlQK9ZYGRa/+s/v40ZtcZrKzhP1/AUcYem37e0nQKc7o92C1
         exK3xjvxQlIQayZHpaKa+IDB01GkHAsEKf9cLwDq/1nG1uxs0ggPoyFMACIseX2KzZ2+
         Mu3XPGfIWKaHyPW/W2doJtGqVtuAen1TFygiasgXD6aD1kdFDosUOmY8gW5XaivhurzM
         yid3AgowFzoa5ZwkT+h/UtZLuPRPMd6Adr9j4q6dH5xqvQYMcrMtGHbhwaoB8QVKUr1q
         qcQg==
X-Gm-Message-State: AJIora+PdFdZP53pMuMDDBZxfvoNj5Ul+K7IR9ACRe34npcn+d4P1aDR
        xTxMKhdGYwdKhENdUCLlHh56H9PKL7YyHh3futhgWFrp7R8p7g==
X-Google-Smtp-Source: AGRyM1uO3lwXmKMJUHBOB5ohsirv0rbElHPlJvBvbUxHx2ntUT21qGZcSxbrFm6wLpSNCS8p96webSHut1HXQ33nOm8=
X-Received: by 2002:a81:7341:0:b0:31c:c547:ce02 with SMTP id
 o62-20020a817341000000b0031cc547ce02mr29182404ywc.108.1658140360551; Mon, 18
 Jul 2022 03:32:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220713131421.1527179-1-nuno.sa@analog.com> <20220713131421.1527179-4-nuno.sa@analog.com>
In-Reply-To: <20220713131421.1527179-4-nuno.sa@analog.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 18 Jul 2022 12:32:29 +0200
Message-ID: <CACRpkdbitDErSCMbKFe0yZB63+uTGwt5ROMbEV_iAPck_RN7sg@mail.gmail.com>
Subject: Re: [PATCH 3/4] gpiolib: acpi: support bias pull disable
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
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Jul 13, 2022 at 3:13 PM Nuno S=C3=A1 <nuno.sa@analog.com> wrote:

> On top of looking at PULL_UP and PULL_DOWN flags, also look at
> PULL_DISABLE and set the appropriate GPIO flag. The GPIO core will then
> pass down this to controllers that support it.
>
> Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>

Do we have a semantic check that PULLDOWN and PULLUP
is not used in combination with NOPULL here?

(We should also be checking that PULLDOWN and PULLUP
are not used simultaneously but that is an unrelated thing.)

Yours,
Linus Walleij
