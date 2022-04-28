Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF37A513C51
	for <lists+linux-acpi@lfdr.de>; Thu, 28 Apr 2022 22:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351618AbiD1UIL (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 28 Apr 2022 16:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351619AbiD1UIL (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 28 Apr 2022 16:08:11 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 161D3BF94E
        for <linux-acpi@vger.kernel.org>; Thu, 28 Apr 2022 13:04:55 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 4so8045078ljw.11
        for <linux-acpi@vger.kernel.org>; Thu, 28 Apr 2022 13:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e5qmgQrDnLOtncZ3275YmjeZwKcNo9SSdnjrjUy1pJA=;
        b=KvOxfE7bSF0qLmFgJXMr8pvaHcnvILpnzZmoVuGpiZZqrPs/kqyqRPpWxOQ+YqUul4
         9IUgQhjWtFc7FP87uRkOwOLJM8Oa5iY/v9kA4uBcqtjrpCuSW6QMt7WwBGqAV3jdX3mC
         1FQ/VCEfH6H4+EGcvAlentzQ3soQ5rMe/36gs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e5qmgQrDnLOtncZ3275YmjeZwKcNo9SSdnjrjUy1pJA=;
        b=CeCpkqPxFwQAihNO/1QOKrIWS7EbRqVqVmZ5feEILYfVHiv2Z11mHtJTP356AwTAfT
         aZq2Yjh3MTuNbc5SOO1NZJxnQNm/Q2k3Kwjg+d1vlq6NnPYZTKTPE38B+nPwGnaT/WwX
         jvb6q+HcwGL5F0SgNwMiXwt8ZaShWf1UWD3l0TcPSTWHD7VrXdVHbyl6Sq61eoYF5/hF
         iZh2I6YDL5cLQIIRLVn24bAB3Ickv6E1oZZdt4xKtx22JLQlpn4ic9+mR/8Qv9fguBq5
         zmai0XRilJMHxmLQ/v0TfNBuZ58jL8XaQekVOg243hQUOMYiK86o1QOzYUkTN1h2babZ
         FjBw==
X-Gm-Message-State: AOAM531UHWe1cfhKY6ZzVHpwbHv6MzO1nvNQBlkajWTO/MjpSXv2eyss
        pHCZMw81Q64w7wL7noO9Ql/scD9YTsfoZQ9m03I=
X-Google-Smtp-Source: ABdhPJzFkZhR0u7y2vY6nPD5TILQ1IdHR/R5kRcLQsFduBwr97zWjXGzMqarQ4dICHwpta6NTeCg+w==
X-Received: by 2002:a2e:894e:0:b0:24f:ad2:b192 with SMTP id b14-20020a2e894e000000b0024f0ad2b192mr17219522ljk.199.1651176293001;
        Thu, 28 Apr 2022 13:04:53 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id k9-20020a2ea289000000b0024afe447bc1sm69182lja.128.2022.04.28.13.04.52
        for <linux-acpi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Apr 2022 13:04:52 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id w19so10514441lfu.11
        for <linux-acpi@vger.kernel.org>; Thu, 28 Apr 2022 13:04:52 -0700 (PDT)
X-Received: by 2002:a05:6512:690:b0:472:4430:8f8 with SMTP id
 t16-20020a056512069000b00472443008f8mr256487lfe.531.1651176291646; Thu, 28
 Apr 2022 13:04:51 -0700 (PDT)
MIME-Version: 1.0
References: <CAJZ5v0hHYRsWkRsJj+_Wa=jTS5cHasajYeh14yxEDvxu7gWWRQ@mail.gmail.com>
 <CAHk-=wit9xfwAf=z6YqkZerH28qFYeTnhr3GtBqCYBnsTsSYXw@mail.gmail.com> <CAJZ5v0jpaAwq0Ad-ZA60bA5AU8JG1Y2muYtXy-bA4LapX8_dJQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0jpaAwq0Ad-ZA60bA5AU8JG1Y2muYtXy-bA4LapX8_dJQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 28 Apr 2022 13:04:35 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiABQnUatiSozcckyK+NLaUZ=PZZqgTxbN0d6wsBKzarA@mail.gmail.com>
Message-ID: <CAHk-=wiABQnUatiSozcckyK+NLaUZ=PZZqgTxbN0d6wsBKzarA@mail.gmail.com>
Subject: Re: [GIT PULL] ACPI fixes for v5.18-rc5
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Thu, Apr 28, 2022 at 12:50 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> The bug was that if acpi_idle_bm_check() returned 1, it would "fall
> back"  to the same state via safe_state_index.

That's actually quite hard to see in the source code.

Looking closer, the code calls "acpi_idle_enter_bm()" only when
"cx->type == ACPI_STATE_C3", but that is very non-obvious in the
context of that function (other than the comment).

It might be clearer if the function was actually called "enter_c3()"
rather than "enter_bm()". Particularly since it will continue to do
that "c3_cpu_count" stuff even if the actual power state it goes into
_isn't_ C3.

And the the C3 case doesn't seem to take that "demote C2 to C1" rule
into account, so now that code will go into "safe" C2 mode even if
ACPI_FADT_C2_MP_SUPPORTED isn't set.

It's all very confusing.

But whatever. I obviously already pulled the changes.

                Linus
