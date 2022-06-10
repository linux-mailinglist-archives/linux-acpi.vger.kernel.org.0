Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94D2154679E
	for <lists+linux-acpi@lfdr.de>; Fri, 10 Jun 2022 15:49:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237373AbiFJNsm (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 10 Jun 2022 09:48:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233977AbiFJNsk (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 10 Jun 2022 09:48:40 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 218333B036
        for <linux-acpi@vger.kernel.org>; Fri, 10 Jun 2022 06:48:38 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-30ec2aa3b6cso272368627b3.11
        for <linux-acpi@vger.kernel.org>; Fri, 10 Jun 2022 06:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XwTm2wEFcPzM9otUDKYTRibEvpUn3l/6ZogWvW+AFbY=;
        b=a/DDq8tlGMDbAGV3qmEghrGw7Mwhg03Veu8NFNqQmFEYEUL5YRpnwK7cElEpAZzH4t
         9qsaaQiABUQ/vYBmhMhYC8knQ6rUxptG3/U/PQkPyfgaA/A7JwOHUR2mj5Dh3uuurfYv
         ThOn8VCUVub2hmJCg/iyCmF9AuUHkVVz+whrv4BcBZw0rrJlvOi1PSTmaV1bs+HifLlC
         OWPjiiH/6O1+5wlbDJnNqgfbahu4iR/BbsS87bIth7QCDQt7DJ8fW6QDG25b6yymHzfV
         5i0hbi+TaygGshkTFQE8alT+OE3n0HAU+lJOvDaaYXW+XtkhL+SheBQMGSroNz1GMApj
         NHFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XwTm2wEFcPzM9otUDKYTRibEvpUn3l/6ZogWvW+AFbY=;
        b=QWufau4R008XvRfT4GrSBpVHGVmdHQg6d5tsf/ap1/O1x6dVrLr4jWa97w3fawAnEe
         8x8Vh6IYfa1/yBC1uNF8VrMMtj3bdDbw7JvgRfgqOmHBCP9w1rT+e+gQy4z0F2MYT7Hz
         sWrMSdHq8BuOT5Yr+UZt7QtL7Mdq1bFueT+Q+7ff8dLBtn7JLKn8okMGNrdtUmVgOsyF
         4KlAps6mqoF9THnDnWrOdFQWBasRYtkIVCyL9yJqcAvEMtYBtla2Hg9kRRnAN1W0avAO
         kvDo3/bocvtKo2ffvAfKNkZjPKHCHvo1HQJ8dwfUtZb9UCxsP/y2X1WHdpl+ujk2SN3D
         craQ==
X-Gm-Message-State: AOAM530G/oDAANXhIQDkSH8Npr0ILx5YH039EwGItkZ9OEOlrl6I/Iu/
        6QJ4mtV5GY8VXJywCplABZwEZa7/dyeA5zvHknvxtg==
X-Google-Smtp-Source: ABdhPJwfNs16uySnE70fDRtkWMXwYd1E0PUX0Uc2tr4CEOsmC9YIf2x1vFsCOcvzh1S5ZzMwVcLoE5j+UGeMOMRXp44=
X-Received: by 2002:a81:fe0b:0:b0:30c:7e9c:701 with SMTP id
 j11-20020a81fe0b000000b0030c7e9c0701mr47839419ywn.118.1654868917363; Fri, 10
 Jun 2022 06:48:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220607120530.2447112-1-tarumizu.kohei@fujitsu.com>
In-Reply-To: <20220607120530.2447112-1-tarumizu.kohei@fujitsu.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 10 Jun 2022 15:48:25 +0200
Message-ID: <CACRpkdbPLFOoPdX4L6ABV8GKpC8cQGP3s2aN2AvRHEK49U9VMg@mail.gmail.com>
Subject: Re: [PATCH v5 0/6] Add hardware prefetch control driver for A64FX and x86
To:     Kohei Tarumizu <tarumizu.kohei@fujitsu.com>,
        Mel Gorman <mgorman@suse.de>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     catalin.marinas@arm.com, will@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, rafael@kernel.org, lenb@kernel.org,
        gregkh@linuxfoundation.org, eugenis@google.com,
        tony.luck@intel.com, pcc@google.com, peterz@infradead.org,
        marcos@orca.pet, marcan@marcan.st, nicolas.ferre@microchip.com,
        conor.dooley@microchip.com, arnd@arndb.de, ast@kernel.org,
        peter.chen@kernel.org, kuba@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-acpi@vger.kernel.org,
        Paolo Valente <paolo.valente@unimore.it>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Jun 7, 2022 at 2:07 PM Kohei Tarumizu
<tarumizu.kohei@fujitsu.com> wrote:

> This patch series add sysfs interface to control CPU's hardware
> prefetch behavior for performance tuning from userspace for the
> processor A64FX and x86 (on supported CPU).

OK

> A64FX and some Intel processors have implementation-dependent register
> for controlling CPU's hardware prefetch behavior. A64FX has
> IMP_PF_STREAM_DETECT_CTRL_EL0[1], and Intel processors have MSR 0x1a4
> (MSR_MISC_FEATURE_CONTROL)[2].

Hardware prefetch (I guess of memory contents) is a memory hierarchy featur=
e.

Linux has a memory hierarchy manager, conveniently named "mm",
developed by some of the smartest people I know. The main problem
addressed by that is paging, but prefetching into the CPU from the
next lowest level in the memory hierarchy is just another memory
hierarchy hardware feature, such as hard disks, primary RAM etc.

> These registers cannot be accessed from userspace.

Good. The kernel managed hardware. If the memory hierarchy people have
userspace now doing stuff behind their back, through some special
interface, that makes their world more complicated.

This looks like it needs information from the generic memory manager,
from the scheduler, and possibly all the way down from the block
layer to do the right thing, so it has no business in userspace.
Have you seen mm/damon for example? Access to statistics for
memory access patterns seems really useful for tuning the behaviour
of this hardware. Just my =E2=82=AC0.01.

If it does interact with userspace I suppose it should be using control
groups, like everything else of this type, see e.g. mm/memcontrol.c,
not custom sysfs files.

Just an example from one of the patches:

+                       - "* Adjacent Cache Line Prefetcher Disable (R/W)"
+                           corresponds to the
"adjacent_cache_line_prefetcher_enable"

I might only be on "a little knowledge is dangerous" on the memory
manager topics, but I know for sure that they at times adjust the members
of structs to fit nicely on cache lines. And now this? It looks really usef=
ul
for kernel machinery that know very well what needs to go into the cache
line next and when.

Talk to the people on linux-mm and memory maintainer Andrew Morton on
how to do this right, it's a really interesting feature! Also given
that people say
that the memory hierarchy is an important part in the performance of the Ap=
ple
M1 (M2) silicon, I expect that machine to have this too?

Yours,
Linus Walleij
