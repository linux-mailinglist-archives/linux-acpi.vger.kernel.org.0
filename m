Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0E7844488A
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Nov 2021 19:48:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbhKCSvL (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 3 Nov 2021 14:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbhKCSvK (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 3 Nov 2021 14:51:10 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9786DC061714
        for <linux-acpi@vger.kernel.org>; Wed,  3 Nov 2021 11:48:32 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id y26so7011561lfa.11
        for <linux-acpi@vger.kernel.org>; Wed, 03 Nov 2021 11:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qLY2jWhqalFDEIv6BXGfHi2ORZbhy7ia23ahAiBL5q8=;
        b=MnYIfh9K4iVdIy3/Q4jGlXOD785PXwFrrhp22S3h38IRAVyPUnzbxb2WF4fj/Q7oAZ
         k5gzuePlePHk9WLhHPRZ6KYD6FddHjWoMv8AHmbVHAQXRmVPVTvhoHcrxmRo3FWUaJMm
         +ofwiIHgazHGiQXZTih/ekH4r888DWo9POyRg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qLY2jWhqalFDEIv6BXGfHi2ORZbhy7ia23ahAiBL5q8=;
        b=UwTibC7av6WTE3X0s6EGfP1npJzlATDPoeYdlEJ1ql5j/Vv6ln4SV4v9hT5uS/CnPN
         /zMbiwDBUK2yme67tAvkvCTJG4akm1SFeKhCc/c2WbG3OoQDwbA/Ch6oUO/fG44R/BsK
         qmhzDrcMOaaxhYIsxqW0L+y4DE7xrvp81Uv+Bc1wdPHkWaiN4vyV+ZAxPckCc1CSPavK
         9gPCj8BvZ+HfqqzyHpZH2rz/GfMbxe1Z88k3RcKLdybJ0gzJa42XIfrxOfyzzaPdX7jn
         xPJIy7aCo9lcQRl5qrf8BfnsTBp1/iBQmNDmWR8iZg6wMQPvGDO1zugKVA2HUFLQtzuI
         HVvQ==
X-Gm-Message-State: AOAM532p7ovIsqdTlTG2t9RN9Kq4gDAdmk1hiAKNK9c/qBB1ZOZVaO8W
        yP9GhOVAhKcE8b5QYbxLaj584dP8d2WSWDnA
X-Google-Smtp-Source: ABdhPJzAFcLlsRcWQBc5+NDL1smfr0rJLtDEigx1l0DbyhzRIa/DoRWV8e24N5Wg0SXKNvosfKpqNw==
X-Received: by 2002:a05:6512:10d5:: with SMTP id k21mr15836138lfg.534.1635965310722;
        Wed, 03 Nov 2021 11:48:30 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id l14sm269876ljc.112.2021.11.03.11.48.30
        for <linux-acpi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Nov 2021 11:48:30 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id x27so7074276lfu.5
        for <linux-acpi@vger.kernel.org>; Wed, 03 Nov 2021 11:48:30 -0700 (PDT)
X-Received: by 2002:a05:6512:3993:: with SMTP id j19mr39722467lfu.402.1635965309983;
 Wed, 03 Nov 2021 11:48:29 -0700 (PDT)
MIME-Version: 1.0
References: <5779281.lOV4Wx5bFT@kreacher>
In-Reply-To: <5779281.lOV4Wx5bFT@kreacher>
From:   Linus Torvalds <torvalds@linuxfoundation.org>
Date:   Wed, 3 Nov 2021 11:48:13 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh2tO46FtJaRpCrdgifAusMbhsBAcg_ZmX3+AO_-sf-DA@mail.gmail.com>
Message-ID: <CAHk-=wh2tO46FtJaRpCrdgifAusMbhsBAcg_ZmX3+AO_-sf-DA@mail.gmail.com>
Subject: Re: [PATCH] ACPI: Drop ACPI_USE_BUILTIN_STDARG ifdef from acgcc.h
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Nov 3, 2021 at 11:46 AM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> The ACPI_USE_BUILTIN_STDARG symbol is never set in the kernel build,
> so stop checking it in include/acpi/platform/acgcc.h and drop all of
> the macros depending on it (which appear to duplicate the analogous
> macros from linux/stdarg.h, but in fact are never used).

Ack. Thanks,

                Linus
