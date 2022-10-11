Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B37955FAB60
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Oct 2022 05:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229453AbiJKDrD (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 10 Oct 2022 23:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbiJKDqd (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 10 Oct 2022 23:46:33 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FC8289807
        for <linux-acpi@vger.kernel.org>; Mon, 10 Oct 2022 20:46:05 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id g10so7397511oif.10
        for <linux-acpi@vger.kernel.org>; Mon, 10 Oct 2022 20:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gOCfVbhcmfemwDry8i3hJvK3Apv3toHgXqWLJkr3nNE=;
        b=DeN1JB/nmolLys/Yy/JmDaRoMglhhZ3TbR9eVxk4aCEtsK48S6sT94nPiaVhVoqQ/h
         +tV3Ko/3KHZTBeGjKdnhRc5+/9TxKK9+Zj+Kls1rJKDU8rIzz8sh8SuvEB0GTj308DIL
         pDq8XBO1OH+50wwV459S7kDAjk3O0a08z/v54=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gOCfVbhcmfemwDry8i3hJvK3Apv3toHgXqWLJkr3nNE=;
        b=WpqnQJKNu88M5lYQE5JxhNh8zBgCm5F+IJBzXHwLukFT7yGM/t+SqdGVJ6Wm1/nW2h
         xugZHODPwJ7Ym5sz3Z9E3CiCT7AZ4I6l205jYF3Eh4cmQG2V1SMk4Up5s5r00XYLVs1j
         XyiyauIQHhM7j3Kbk+CTyXw4aoYdTbCsEo3CgvgALqXLf3ka3JSCSb/WjI7P/C8lu0mv
         t7BoRly65dWloEjjHcC8WQZjQByYHjg6cTphCpMzjqalXoZFr2LccFR5bxhaioULXOu5
         xo6caKJatcr+ynJK08FSJtT5Z870Mkj3g/CobSvE1+PU52PbsJqtvgtJM38EclE7TK4K
         Htpg==
X-Gm-Message-State: ACrzQf3nNk2tNEZDB9Jcep4iPfzXUNVnOQMciFM6i88JYLJkohA5GZP6
        +RpPD0DbPyzVVAD5o4ek/ECHtS7WxgnNdQ==
X-Google-Smtp-Source: AMsMyM5TULjNLEfRn+DjYbQrkoaAtaDwSuA0EwGWOBsWn510/B6nlrfV5B+K13AU1TeBd9OzWwlqTQ==
X-Received: by 2002:a05:6808:181e:b0:350:e92a:9ab1 with SMTP id bh30-20020a056808181e00b00350e92a9ab1mr10262381oib.209.1665459964505;
        Mon, 10 Oct 2022 20:46:04 -0700 (PDT)
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com. [209.85.160.50])
        by smtp.gmail.com with ESMTPSA id ch15-20020a0568081c0f00b0035028730c90sm5079882oib.1.2022.10.10.20.46.03
        for <linux-acpi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Oct 2022 20:46:03 -0700 (PDT)
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-12c8312131fso14556362fac.4
        for <linux-acpi@vger.kernel.org>; Mon, 10 Oct 2022 20:46:03 -0700 (PDT)
X-Received: by 2002:a05:6870:c0c9:b0:127:c4df:5b50 with SMTP id
 e9-20020a056870c0c900b00127c4df5b50mr11380013oad.126.1665459963186; Mon, 10
 Oct 2022 20:46:03 -0700 (PDT)
MIME-Version: 1.0
References: <20221011031843.960217-1-masahiroy@kernel.org>
In-Reply-To: <20221011031843.960217-1-masahiroy@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 10 Oct 2022 20:45:47 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjP4=XP6E30mRp3OP2swZOrML9Z78kJvKo8ejFi4WGZjw@mail.gmail.com>
Message-ID: <CAHk-=wjP4=XP6E30mRp3OP2swZOrML9Z78kJvKo8ejFi4WGZjw@mail.gmail.com>
Subject: Re: [RFC PATCH] Remove Intel compiler support
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-ia64@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>, Len Brown <lenb@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Terrell <terrelln@fb.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Robert Moore <robert.moore@intel.com>,
        Tom Rix <trix@redhat.com>, devel@acpica.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
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

On Mon, Oct 10, 2022 at 8:19 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> I am sending this to Linus and the x86 maintainers with RFC.
> If somebody is still using ICC, please speak up!

Ack. I don't think anybody ever really used icc.

I can't recall having heard a single peep about icc problems, and I
don't think it's because it was *so* good at emulating gcc that nobody
ever hit any issues.

               Linus
