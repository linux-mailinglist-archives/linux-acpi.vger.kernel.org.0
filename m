Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D7A4513BD5
	for <lists+linux-acpi@lfdr.de>; Thu, 28 Apr 2022 20:50:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351258AbiD1Sxl (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 28 Apr 2022 14:53:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351199AbiD1Sxl (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 28 Apr 2022 14:53:41 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C80F57B04
        for <linux-acpi@vger.kernel.org>; Thu, 28 Apr 2022 11:50:23 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id p12so10233198lfs.5
        for <linux-acpi@vger.kernel.org>; Thu, 28 Apr 2022 11:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/3kak4px7jr3LInyUqNpuxAJYL7n0yOLiasgLA10vts=;
        b=I6KWsFSB6vz32X8DnsS8yLCJaLOJTYxiA2Puz8Fx6icNuiQsPvy/oIhqF0ORPdhQOt
         Th9ZVpd9sHvAarrSdfHK/SpuW/5HWf1PYD+3siS5jtp1bykTFknkwTDU1LO62qH3wLG6
         907IvJnTw3shXZpDWyBzOOW5IM+QU51o4eZTM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/3kak4px7jr3LInyUqNpuxAJYL7n0yOLiasgLA10vts=;
        b=2i6/vrxL5TtYTPmbGZ3n/JhfkO5MlDYWraKUtHIxrkpl/7D7l1cjEaYVL7qJAppaVp
         AGMjoIfP/vzMc3E+4gujGXzaP48araLCYzNJH1h5PyRLmuK00RRKkLvwMdt2NieUU/GL
         7T2Dk/VS6KWAV3YNyMvGGCk4Y+LjoVTQKytL83DGGoaBfr0Xzu+QZThAHd/fjv7nv5c3
         zi2Y4wrR9ZSHCQINivU67J80FGKpdIZoGvEwEQxQcyVGjMovWfOVGqLR/cXKAC9/IBbi
         h8bUORpWR6oWRZk+NM+9H6gkSf39CgZXLVo0ORplHJQDcAdCAKqwguXVwmgbwRn1AwgX
         qH3w==
X-Gm-Message-State: AOAM530MuRas+90SC4/FLKHM6E1rWHb8F4SyFCXVDphFfoHBfl1rVS3F
        I3L2RFwA+Saux+3TF5Bas8kpxmgDsdSePH+xVi4=
X-Google-Smtp-Source: ABdhPJxEbabTq8j02+9sjqU3BYh+oFyT7qQrLaY0dBv8SL9xh1RkmVDtD74VuYHLhVBk7WT50aYxNA==
X-Received: by 2002:a05:6512:2289:b0:472:42ec:e69e with SMTP id f9-20020a056512228900b0047242ece69emr372628lfu.302.1651171821286;
        Thu, 28 Apr 2022 11:50:21 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id u12-20020a056512128c00b00446499f855dsm68934lfs.78.2022.04.28.11.50.19
        for <linux-acpi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Apr 2022 11:50:20 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id m23so7934819ljc.0
        for <linux-acpi@vger.kernel.org>; Thu, 28 Apr 2022 11:50:19 -0700 (PDT)
X-Received: by 2002:a2e:8245:0:b0:24b:48b1:a1ab with SMTP id
 j5-20020a2e8245000000b0024b48b1a1abmr22123546ljh.152.1651171819543; Thu, 28
 Apr 2022 11:50:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAJZ5v0hHYRsWkRsJj+_Wa=jTS5cHasajYeh14yxEDvxu7gWWRQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0hHYRsWkRsJj+_Wa=jTS5cHasajYeh14yxEDvxu7gWWRQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 28 Apr 2022 11:50:03 -0700
X-Gmail-Original-Message-ID: <CAHk-=wit9xfwAf=z6YqkZerH28qFYeTnhr3GtBqCYBnsTsSYXw@mail.gmail.com>
Message-ID: <CAHk-=wit9xfwAf=z6YqkZerH28qFYeTnhr3GtBqCYBnsTsSYXw@mail.gmail.com>
Subject: Re: [GIT PULL] ACPI fixes for v5.18-rc5
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Thu, Apr 28, 2022 at 8:30 AM Rafael J. Wysocki <rafael@kernel.org> wrote=
:
>
>  - Make the ACPI processor driver avoid falling back to C3 type of
>    C-states when C3 cannot be requested (Ville Syrj=C3=A4l=C3=A4).

Hmm.

Doesn't this avoid C3 for _everybody_ rather than some conditional
"when C3 cannot be requested"?

Of course, it looks like the 'has_lpi' state still potentially allows
C3 even for busmastering sleeps. Maybe that is what you meant.

             Linus
