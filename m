Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6CD239E5A2
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Jun 2021 19:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbhFGRlB (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 7 Jun 2021 13:41:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbhFGRlB (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 7 Jun 2021 13:41:01 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A6BBC061766
        for <linux-acpi@vger.kernel.org>; Mon,  7 Jun 2021 10:38:58 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id k7so27972260ejv.12
        for <linux-acpi@vger.kernel.org>; Mon, 07 Jun 2021 10:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Jv6mdenEAUjxxqG8V1uZdiIteEsL88sRg9uJb9rd/1c=;
        b=MMyHMqib86ziBTzj86CHQvyb6ZCknnaHgqX8rvkmpfzD4d1nlV6Zhj2mRavi5vCzah
         ly/8jU65nHFXVshC9ypULejtjivTqZPc+KqXcY66Ct9m3OsgNkSLiSiyDozorH5A9JHJ
         fcTvowf6WrEf8xiyiEWnhQ0MnyE7Sp7/Ckd8Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Jv6mdenEAUjxxqG8V1uZdiIteEsL88sRg9uJb9rd/1c=;
        b=oTDGAJ3b+pPiDguZRDcD2L77UVWJjBDyBp3VyJ7clJazo6fLRIawjlfWcIU25RJg0C
         +dM1bEyJE1k1bUv1lwar3Ct98qjeGJYUQXWsM1kvGref1fBR2WuNdL21Dyb4eNyoPa1d
         RU6vD/L+1pK5bW1iWlSOOykb0+CHE5zl9RXKMsdx6TJgHCej7jt4aFL/uQZaJYhsVVit
         aoh3SDpPIvJp9OkXu4IeE+zk+HdyQTgnrvts8bjv/A/Nnz52shVQKrWaafHUV98qaPcz
         EsF/ofpmeIs9yCpRTvlx/U4jKN8yzHtqmXB1DLV1rgSbuul/nBPz+8sPfjlz6uZ2Bu5C
         Muqw==
X-Gm-Message-State: AOAM531zyaGQU8UQ1/+iQ6IDKaXL9cLwR0ce7MrR83p/WSU4A0/BhSH3
        +XNnxdC/BYFI0AfRXgHny5gz9wB5WirVajAt
X-Google-Smtp-Source: ABdhPJy5Xi/H0cHlw/79Tj0vetmds8CTXnf+y0po9jfFuAis2/PhgOghkpiku/HguSDCGQZVTUHktA==
X-Received: by 2002:a17:906:eb17:: with SMTP id mb23mr8874096ejb.239.1623087535866;
        Mon, 07 Jun 2021 10:38:55 -0700 (PDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id m18sm6659154ejx.56.2021.06.07.10.38.54
        for <linux-acpi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Jun 2021 10:38:54 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id t3so21366926edc.7
        for <linux-acpi@vger.kernel.org>; Mon, 07 Jun 2021 10:38:54 -0700 (PDT)
X-Received: by 2002:a50:9346:: with SMTP id n6mr20997175eda.365.1623087534175;
 Mon, 07 Jun 2021 10:38:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210607173156.5548-1-mario.limonciello@amd.com> <20210607173156.5548-2-mario.limonciello@amd.com>
In-Reply-To: <20210607173156.5548-2-mario.limonciello@amd.com>
From:   Raul Rangel <rrangel@chromium.org>
Date:   Mon, 7 Jun 2021 11:38:43 -0600
X-Gmail-Original-Message-ID: <CAHQZ30DXX+H=jPO74wKwsfN2nOgEjdyiUpkR8HWYN1L_EO-ucA@mail.gmail.com>
Message-ID: <CAHQZ30DXX+H=jPO74wKwsfN2nOgEjdyiUpkR8HWYN1L_EO-ucA@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] ACPI: Add quirks for AMD Renoir/Lucienne CPUs to
 force the D3 hint
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        linux-acpi@vger.kernel.org, david.e.box@linux.intel.com,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        "Shah, Nehal-bakulchandra" <Nehal-bakulchandra.Shah@amd.com>,
        Alex Deucher <Alexander.Deucher@amd.com>,
        Prike Liang <prike.liang@amd.com>,
        Julian Sikorski <belegdol@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Jun 7, 2021 at 11:32 AM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> AMD systems from Renoir and Lucienne require that the NVME controller
> is put into D3 over a Modern Standby / suspend-to-idle
> cycle.  This is "typically" accomplished using the `StorageD3Enable`
> property in the _DSD, but this property was introduced after many
> of these systems launched and most OEM systems don't have it in
> their BIOS.
>
> On AMD Renoir without these drives going into D3 over suspend-to-idle
> the resume will fail with the NVME controller being reset and a trace
> like this in the kernel logs:
> ```
> [   83.556118] nvme nvme0: I/O 161 QID 2 timeout, aborting
> [   83.556178] nvme nvme0: I/O 162 QID 2 timeout, aborting
> [   83.556187] nvme nvme0: I/O 163 QID 2 timeout, aborting
> [   83.556196] nvme nvme0: I/O 164 QID 2 timeout, aborting
> [   95.332114] nvme nvme0: I/O 25 QID 0 timeout, reset controller
> [   95.332843] nvme nvme0: Abort status: 0x371
> [   95.332852] nvme nvme0: Abort status: 0x371
> [   95.332856] nvme nvme0: Abort status: 0x371
> [   95.332859] nvme nvme0: Abort status: 0x371
> [   95.332909] PM: dpm_run_callback(): pci_pm_resume+0x0/0xe0 returns -16
> [   95.332936] nvme 0000:03:00.0: PM: failed to resume async: error -16
> ```
>
> The Microsoft documentation for StorageD3Enable mentioned that Windows has
> a hardcoded allowlist for D3 support, which was used for these platforms.
> Introduce quirks to hardcode them for Linux as well.
>
> As this property is now "standardized", OEM systems using AMD Cezanne and
> newer APU's have adopted this property, and quirks like this should not be
> necessary.
>
> CC: Julian Sikorski <belegdol@gmail.com>
> CC: Shyam-sundar S-k <Shyam-sundar.S-k@amd.com>
> CC: Alexander Deucher <Alexander.Deucher@amd.com>
> CC: Rafael J. Wysocki <rjw@rjwysocki.net>
> CC: Prike Liang <prike.liang@amd.com>
> Link: https://docs.microsoft.com/en-us/windows-hardware/design/component-guidelines/power-management-for-storage-hardware-devices-intro
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---

It's unfortunate these systems have already shipped. I'm guessing they
can't have their firmware updated either. So I guess it's the best
option for now.

Acked-by: Raul E Rangel <rrangel@chromium.org>
