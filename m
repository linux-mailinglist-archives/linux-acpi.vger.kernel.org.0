Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA73D6AB1C5
	for <lists+linux-acpi@lfdr.de>; Sun,  5 Mar 2023 19:53:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbjCESxQ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 5 Mar 2023 13:53:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjCESxQ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 5 Mar 2023 13:53:16 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B22D683E5
        for <linux-acpi@vger.kernel.org>; Sun,  5 Mar 2023 10:53:14 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id x3so29948725edb.10
        for <linux-acpi@vger.kernel.org>; Sun, 05 Mar 2023 10:53:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1678042393;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AN0CzpsMcXbcM4GDtUWIdtCQSMN2+Da6rXDKr4ksjhc=;
        b=DRsFdOhN1l3A+3LyKjrUdnBrYoeaPuOvh1fPoOrJxNR/Bud+uY58s8j7kTv5jTYEZH
         Ai2AXC7qqr0ZL+/ZJFi0DTp372EUkK5zs+0G1O6zbkvAHzPS2kFi+VyA09qCdKttYZD0
         ZHAzNmuEFLBmUPCyo0AIWx9Gz2oQx1FBUhybY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678042393;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AN0CzpsMcXbcM4GDtUWIdtCQSMN2+Da6rXDKr4ksjhc=;
        b=VhMlCZ/NO8+Ur4GYc6F056bCS3xBbwQFbF5ajr51PW1JephPFtcfAVVMvKxiJWk7de
         XyopWNFvdEueALRPLZovd26NfqS5mBAO3Mts/RwcpsOEW3t5eDh9oUriC1Ep/TiO0QPe
         U05DktvAfDYDRYXdFHtq+U2sXwcD1HQEtEUCYET6cYVhy7Ncegd0deON4mbq/yyeWO1B
         uFEwpMkJF+dsuJXdTL0FAhLNCDxFEtjD7r/jKUgjsaW5QdRrSJcQU6kkjcF+qd1T9fea
         +Kaj72jwxfhc2hQuyBDu5VHUu2tjeoysKvt58UOIkAvCjx3BfjIou5P7aB8RZq6Li9cg
         cBoA==
X-Gm-Message-State: AO0yUKV6wI4djkV5kgEo8bSZV46OBR/IEzbkuBRU4EJYULAEbUFXG8qM
        t0fEQQobPlxzF/KfjS/7IaAg7TjWVZcA7nRxnRIWUg==
X-Google-Smtp-Source: AK7set+guqnrJNdr1aSfMNnGVN/dPxtOvsa2id5JPdqozGqxcTUK4rcGoYbDPiDmihgbeI5AJV6M5Q==
X-Received: by 2002:a17:907:e8d:b0:8af:5752:691f with SMTP id ho13-20020a1709070e8d00b008af5752691fmr9929223ejc.76.1678042392984;
        Sun, 05 Mar 2023 10:53:12 -0800 (PST)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id ig2-20020a1709072e0200b008e7916f0bdesm3531633ejc.138.2023.03.05.10.53.11
        for <linux-acpi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Mar 2023 10:53:12 -0800 (PST)
Received: by mail-ed1-f41.google.com with SMTP id ay14so26369263edb.11
        for <linux-acpi@vger.kernel.org>; Sun, 05 Mar 2023 10:53:11 -0800 (PST)
X-Received: by 2002:a17:906:4997:b0:877:7480:c75d with SMTP id
 p23-20020a170906499700b008777480c75dmr3946134eju.0.1678042390949; Sun, 05 Mar
 2023 10:53:10 -0800 (PST)
MIME-Version: 1.0
References: <20221016182349.49308-1-masahiroy@kernel.org> <CAK7LNASQfrL2JnL2QDE_fBLV6KmMuJATpvRk2vaB0db49OysEA@mail.gmail.com>
In-Reply-To: <CAK7LNASQfrL2JnL2QDE_fBLV6KmMuJATpvRk2vaB0db49OysEA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 5 Mar 2023 10:52:54 -0800
X-Gmail-Original-Message-ID: <CAHk-=wibvZQoNu3VCuH+WfOHdWeVG_Zz6GWXQwQ4EmSAQd8Avg@mail.gmail.com>
Message-ID: <CAHk-=wibvZQoNu3VCuH+WfOHdWeVG_Zz6GWXQwQ4EmSAQd8Avg@mail.gmail.com>
Subject: Re: [PATCH v3] Remove Intel compiler support
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>, Len Brown <lenb@kernel.org>,
        Nick Terrell <terrelln@fb.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Tom Rix <trix@redhat.com>, devel@acpica.org,
        linux-acpi@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sun, Mar 5, 2023 at 4:19=E2=80=AFAM Masahiro Yamada <masahiroy@kernel.or=
g> wrote:
>
> Are you happy with picking this up?
> https://lore.kernel.org/lkml/20221016182349.49308-1-masahiroy@kernel.org/

Done.

              Linus
