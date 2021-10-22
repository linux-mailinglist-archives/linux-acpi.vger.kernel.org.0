Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BE7E437E64
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Oct 2021 21:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232855AbhJVTPb (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 22 Oct 2021 15:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234236AbhJVTP0 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 22 Oct 2021 15:15:26 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9CECC061220
        for <linux-acpi@vger.kernel.org>; Fri, 22 Oct 2021 12:13:00 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 145so467867ljj.1
        for <linux-acpi@vger.kernel.org>; Fri, 22 Oct 2021 12:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i7WRTjXxQ4DN8M2vOlJwK7DMWJ23bbvUg+XH4CNTslE=;
        b=Wv8R9T10aobCrs3M+YmRan10VWCF8IcL93mBD4Pf53lVLMeWToKnlOMUFrNogXM3ds
         1y1qbj4mIWnXiy6yih2yRFJuy484nXKvol2id1K4zFAG/wJ5LRY9rMur7DD0N4cACwu/
         773pwmn74KsGp6Id34qu0eLBaOasLOkeN+3kg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i7WRTjXxQ4DN8M2vOlJwK7DMWJ23bbvUg+XH4CNTslE=;
        b=WDKG0GGbiQ9cKeYf9jkhtEscY3t5woJFrwaoDrgJdnslqBA7JWz8VOTb9zIB8soAaN
         h6LTO6PCPMHc35H647PKe2MTZFw0wDIrfHm5E5DZKz+T4LwiwQ6D6VWg7dNhoJw/JGt4
         IHHeDADZHjIcq8LzrM2PtrPhNNkY7AUUktqXd72zbRG25kDwgF4Kv4zZ/zLtjhcLda3J
         LwOmUdh0DO07rZDR+0PHHHrNw5x7jkLpsqhlvoWLS3aNOa6uJrz7zboVOH9ZjvGc6reG
         p3BPf5k5RdeWhzgJ2b15XaZ7IqSJVidd6NtXkqmIKwUUGnZceOJ0RhW4Fwe4deCfdjCY
         a1Xg==
X-Gm-Message-State: AOAM531g7awkaOowyo4HrC10yxQezmWoyiLGrIYhHqjLQNSvQ+ogAYc0
        ZhN0BlQk/v/P4rI8mN1iWNREaAs2E1aRqcU7
X-Google-Smtp-Source: ABdhPJxuHf/isYj+C8S+Eq2ugT7GDXFu2+mMoEWVQ/t/ozbIBcp2v8J8svsSElO258I7SF+CrEatEQ==
X-Received: by 2002:a2e:8813:: with SMTP id x19mr1892818ljh.388.1634929978690;
        Fri, 22 Oct 2021 12:12:58 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id b39sm879165lfv.200.2021.10.22.12.12.58
        for <linux-acpi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Oct 2021 12:12:58 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id d13so864131ljg.0
        for <linux-acpi@vger.kernel.org>; Fri, 22 Oct 2021 12:12:58 -0700 (PDT)
X-Received: by 2002:a2e:a4b6:: with SMTP id g22mr1839764ljm.191.1634929977783;
 Fri, 22 Oct 2021 12:12:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAJZ5v0hTtyu981j91vxH_u3bvHWWBho4YSAhd+os9Zn=sbwe2Q@mail.gmail.com>
In-Reply-To: <CAJZ5v0hTtyu981j91vxH_u3bvHWWBho4YSAhd+os9Zn=sbwe2Q@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 22 Oct 2021 09:12:41 -1000
X-Gmail-Original-Message-ID: <CAHk-=whCammRsz8PEbrft3M6vGjF506gkxtyGw81uGOUUvD51g@mail.gmail.com>
Message-ID: <CAHk-=whCammRsz8PEbrft3M6vGjF506gkxtyGw81uGOUUvD51g@mail.gmail.com>
Subject: Re: [GIT PULL] ACPI fixes for v5.15-rc7
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Oct 22, 2021 at 9:01 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
>  - Fix an ACPI tools build issue introduced recently when the minimal
>    stdarg.h was added (Miguel Bernal Marin).

Hmm. ACPI already has that odd ACPI_USE_BUILTIN_STDARG case in
acgcc.h, which ends up using _exactly_ the same macros as the
<linux/stdarg.h> implementation does, and is basically exactly the
same "minimal stdarg".

Ok, so the macro argument names are different, and there are
whitespace differences, but semantically identical.

So maybe the ACPI code could drop one or the other in favor of the
identical macros?

                 Linus
