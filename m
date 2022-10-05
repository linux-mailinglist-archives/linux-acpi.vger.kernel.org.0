Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED4F95F592D
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Oct 2022 19:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbiJERlJ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 5 Oct 2022 13:41:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbiJERlI (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 5 Oct 2022 13:41:08 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 941D83640D
        for <linux-acpi@vger.kernel.org>; Wed,  5 Oct 2022 10:41:05 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-132e9bc5ff4so1624631fac.7
        for <linux-acpi@vger.kernel.org>; Wed, 05 Oct 2022 10:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9ET0IoJ6rEVtbRVeWGB0pVw9IcwTsGPczYsuOM1U4f0=;
        b=EJ6WcTBoO6oU/ezXuBkBYjEbQ7S8KRcou3xsWIrbiRwE9EOHqoC6FTsAgwu07Mfe6Z
         0beVDIN9DJs7HZ9oYRIYFeffRZ+wggTvShNIAeZ04kK/I7kiVn2nPmIYDHSxv9mrcTmq
         8i+3y+6uRFx9mVL0EBCbpPWxMRHMnS1wVblHM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9ET0IoJ6rEVtbRVeWGB0pVw9IcwTsGPczYsuOM1U4f0=;
        b=1RGaDUiFWgvXJU2k71QV9szn2pk1W/A6aJW9gS7q93vswdQCNxasnledhwiWByRJ/k
         aZ0P2C4kMKC4U6xuagmLp0t9Y/RLKYFLKWioaE8c7fPO6gLVmXZYKfcTXUs6XQX2vy9j
         2i30aQh3e9DwqjnzPMEq2UvJaj8eGS+xG0/Z0zc5RmYhAJwnFpY94sVRO05M/6M+z8TQ
         gp6bzvt0AhUk7wJrhXuE5YVygMKHYsi0OCAFgbvizhxZGzwb+zTP5NGphtfHNxHZOFLm
         HHJrN/LTzdPve4NvpzFlYokjj2wtF0sBD3gdNiPOlxJCQX3WJgUYo13WuNRu4ap8eNuE
         lB6Q==
X-Gm-Message-State: ACrzQf12+SDam4U2w57fyV42nHe9pXVeRdSvD9voYXS2DyYoMMGKPh6k
        JAgtjrF1r6uUWD9Ski5cP1Cdti4jr39Pow==
X-Google-Smtp-Source: AMsMyM6PFXphCzpe6ElUwcUgBNSzUrMoowXHNd3r1GOwxpk+Wnh+OzBqEbnOPc+akA03miqgBSn4kw==
X-Received: by 2002:a05:6870:f227:b0:132:f26c:e911 with SMTP id t39-20020a056870f22700b00132f26ce911mr369255oao.279.1664991664450;
        Wed, 05 Oct 2022 10:41:04 -0700 (PDT)
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com. [209.85.167.172])
        by smtp.gmail.com with ESMTPSA id r26-20020a056870179a00b0010c727a3c79sm5367130oae.26.2022.10.05.10.41.03
        for <linux-acpi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Oct 2022 10:41:03 -0700 (PDT)
Received: by mail-oi1-f172.google.com with SMTP id t79so4941490oie.0
        for <linux-acpi@vger.kernel.org>; Wed, 05 Oct 2022 10:41:03 -0700 (PDT)
X-Received: by 2002:aca:b957:0:b0:351:4ecf:477d with SMTP id
 j84-20020acab957000000b003514ecf477dmr465391oif.126.1664991663308; Wed, 05
 Oct 2022 10:41:03 -0700 (PDT)
MIME-Version: 1.0
References: <b23c765b-4999-17a4-d89a-55d6ba72f68d@redhat.com>
In-Reply-To: <b23c765b-4999-17a4-d89a-55d6ba72f68d@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 5 Oct 2022 10:40:45 -0700
X-Gmail-Original-Message-ID: <CAHk-=whDpj0wAwFK8tDjVUkRoT06ZD-d+OQpojodPPqE_eEcHg@mail.gmail.com>
Message-ID: <CAHk-=whDpj0wAwFK8tDjVUkRoT06ZD-d+OQpojodPPqE_eEcHg@mail.gmail.com>
Subject: Re: [GIT PULL] platform-drivers-x86 for 6.1-1
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Andy Shevchenko <andy@infradead.org>,
        Mark Gross <mark.gross@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        linux-acpi <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Oct 5, 2022 at 5:46 AM Hans de Goede <hdegoede@redhat.com> wrote:
>
> There also is a small conflict in drivers/platform/mellanox/mlxreg-lc.c
> due to a locking fix which landed mid 6.0 mixing unlock + return with
> goto style exits in error paths. My tree has a fix on top to consistently
> use the goto style. Here you can just take the version from me tree.

Ugh.

Why use goto when a simple 'break' would work for all but the first case?

I took your side rather than clean things up and not being able to
test the end result, but it does seem pointlessly complicated.

              Linus
