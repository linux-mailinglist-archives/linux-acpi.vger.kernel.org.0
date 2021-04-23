Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D49C3695B1
	for <lists+linux-acpi@lfdr.de>; Fri, 23 Apr 2021 17:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbhDWPKn (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 23 Apr 2021 11:10:43 -0400
Received: from mail-ot1-f43.google.com ([209.85.210.43]:37641 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbhDWPKk (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 23 Apr 2021 11:10:40 -0400
Received: by mail-ot1-f43.google.com with SMTP id c8-20020a9d78480000b0290289e9d1b7bcso31506943otm.4
        for <linux-acpi@vger.kernel.org>; Fri, 23 Apr 2021 08:10:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Bd2URP2YFvsns0l2svtkyc4x2P2AiP7e9zstEgfra7Y=;
        b=o3DNMzP471HhGQyy+R7BtWoaUFZ3QOCDq9OnHbjsii60OpkJe+GtusJK+xySDVlWsv
         JTLKvUVT+SiAhoC1Ddm0yS8N7UcU1mkBFfGb3sBfjk60DvQhxXco0gtXjMY1sf3jMYmP
         5Dv+zZBho9+/s87w0AnKurzGOA/sFWMrZuo05SShqFJ27cK+IC5AqLvA2k1yLa7ibvXE
         2jnQCeZ7AZcF8ysZLgWNcfUI07tWHRdQ2HPKWO40tUc9JmIjatVuXdPOaRhXE3jnqgY4
         33EOb+ffIxrlfpYNtJjy4wTuxgMq+zAokny8hfQAhl8VmxIzRYk4XCKBzEyLhImtLFiw
         tHPw==
X-Gm-Message-State: AOAM533lIyvLSuCOjYETvwDBxMpxUZP5bFIICoD9CU+HTsqUJDGagJdf
        CsMAHWFg1D23qNZAieQy/gCPekE7tjgPbIgAh8g=
X-Google-Smtp-Source: ABdhPJwvdhpoaZTfubYu8ps9vQYmZGRUFK0OsKne5ZhRqqj69P2/s3el6xufIxHxKt3rR7bBY4FIdSrMMTia/Zdj660=
X-Received: by 2002:a05:6830:55b:: with SMTP id l27mr3776784otb.260.1619190603943;
 Fri, 23 Apr 2021 08:10:03 -0700 (PDT)
MIME-Version: 1.0
References: <59aad467-3526-b764-3310-456f8d14e651@redhat.com>
In-Reply-To: <59aad467-3526-b764-3310-456f8d14e651@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 23 Apr 2021 17:09:53 +0200
Message-ID: <CAJZ5v0jJzbZOz9OQnRz9FcNmxwaU2iaeMuZCw32TdNXD38iFmg@mail.gmail.com>
Subject: Re: Suspicious kfree at the end of cm_write
To:     Mark Langsdorf <mlangsdo@redhat.com>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Apr 23, 2021 at 4:38 PM Mark Langsdorf <mlangsdo@redhat.com> wrote:
>
> commit 03d1571d added an unconditional kfree() to the end of cm_write()
> in drivers/acpi/custom_method.c. I've been reviewing commits after the
> unm issue, and I think this code is wrong. If cm_write() is called with
> *ppos = 0 and count < table.length, the buf is kzalloc'd and immediately
> free'd. On subsequent calls to cm_write(), if cumulative count equals
> table.length, then the current contents of buf are passed to
> acpi_install_method. In the extremely unlikely case that buf has been
> reallocated and overwritten with a different but valid ACPI method, then
> some method other than the intended method could be installed. I'm not
> sure that this is a security issue but I don't think this code is correct.

The current code is not correct, so good catch!

If I'm not mistaken, it will lead to use-after-free on a subsequent
call to cm_write() it the current one does not write the entire
buffer.
