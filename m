Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E91DA4687FC
	for <lists+linux-acpi@lfdr.de>; Sat,  4 Dec 2021 23:01:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234673AbhLDWEn (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 4 Dec 2021 17:04:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbhLDWEn (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 4 Dec 2021 17:04:43 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BE05C061751
        for <linux-acpi@vger.kernel.org>; Sat,  4 Dec 2021 14:01:17 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id t5so26530368edd.0
        for <linux-acpi@vger.kernel.org>; Sat, 04 Dec 2021 14:01:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PrArc/ifsgPokgBSC+Ea7AYzh1AFMkX0pvs51A3I4u4=;
        b=RbFJlew0CJwUua0mcM+UwWlLfDB+SvHq+bCujY26qJe03tLD8T4/o4D3aQzet0lIxM
         H3P8ImGLhgxwRq6PMV/CnAHDQrV+LCLwuv5vpralfCkN3myC7aKDAR4fCTef9EthYPV4
         Xb49U5ntDeqmLcYHi3cs9bqWUa1oiHprIOu0E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PrArc/ifsgPokgBSC+Ea7AYzh1AFMkX0pvs51A3I4u4=;
        b=66zWqCOiJzsLEPWU+prC0rjYiiKO1n6dQAvU7EPIORdVPsT6d4+DWDKrfefuyBNngu
         VuBpZjxgsxRi1iizuk7x8o5IBpq9NWnZ7PqhbQkEskuzlpJkz7hsHl7SYvpsN79WAU7U
         1XDdUAreayzYxpo+8NLF7UeD5F/ReNYtDSiMTOHQ0g8e+CemuxCoKtZ7jWYRAs4j+UA8
         WcfPtI0kT+93TiQppT9eLNJXIka9Zr0KwK1WHuWbiblyaKrPH4R9e9FqSEnwWv16ozUg
         keoh77uypaC1Q0rDJ7WVnBZneM6CXHKv9nW3YnTIO0NpTeLCzlYhl5cEyn1+Pf4w4aTu
         ITxA==
X-Gm-Message-State: AOAM532FRqokOHlBo7HHcpvFT7bw0ESd1cfkX+E8U84VBpFvW9J/wH+H
        N1C4yPe16c4N3ad71ezVSv/uapVZoaxCmWW5
X-Google-Smtp-Source: ABdhPJxRF6Wesx+0xjyL4bAsKee8AiPQO/ZBFNBqwCQbATqHiHob8uDMDpZEu5CCrmqiKX2T5iQEKA==
X-Received: by 2002:a50:ce51:: with SMTP id k17mr39191098edj.356.1638655275307;
        Sat, 04 Dec 2021 14:01:15 -0800 (PST)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com. [209.85.221.51])
        by smtp.gmail.com with ESMTPSA id j14sm4900368edw.96.2021.12.04.14.01.14
        for <linux-acpi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Dec 2021 14:01:14 -0800 (PST)
Received: by mail-wr1-f51.google.com with SMTP id a18so13718586wrn.6
        for <linux-acpi@vger.kernel.org>; Sat, 04 Dec 2021 14:01:14 -0800 (PST)
X-Received: by 2002:adf:f8c3:: with SMTP id f3mr31503846wrq.495.1638655273990;
 Sat, 04 Dec 2021 14:01:13 -0800 (PST)
MIME-Version: 1.0
References: <CAJZ5v0hQaF-ANLc4JO=Ub_JMsqLFpZev_gmpb=NPpg=zmqcauA@mail.gmail.com>
 <CAHk-=wiGbtmc+FoUjcgaQRavL=B=rfTmA_VhTtGpmhmk2873cA@mail.gmail.com> <CAJZ5v0janj--CTeVndJAwiaset5tP8XYdXmeW1hHREcO4BefZw@mail.gmail.com>
In-Reply-To: <CAJZ5v0janj--CTeVndJAwiaset5tP8XYdXmeW1hHREcO4BefZw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 4 Dec 2021 14:00:57 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjeN0FO7s+o=ZhxjCwTU6N17oT1h1WHRXtiysRRx5A1Uw@mail.gmail.com>
Message-ID: <CAHk-=wjeN0FO7s+o=ZhxjCwTU6N17oT1h1WHRXtiysRRx5A1Uw@mail.gmail.com>
Subject: Re: [GIT PULL] ACPI fixes for v5.16-rc3
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sat, Dec 4, 2021 at 12:11 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> but it is interesting that you can reproduce it.  I thought it would
> be rather theoretical.

Well, "reproduce it" may be putting it a bit strong...

It happened this morning, and after that suspend/resume was broken
until a reboot. But I've only ever seen it that one time.

              Linus
