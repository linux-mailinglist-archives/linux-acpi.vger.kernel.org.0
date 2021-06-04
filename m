Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 372DA39BDF3
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Jun 2021 19:03:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbhFDRFP (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 4 Jun 2021 13:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbhFDRFP (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 4 Jun 2021 13:05:15 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29432C061766
        for <linux-acpi@vger.kernel.org>; Fri,  4 Jun 2021 10:03:22 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id l1so15551543ejb.6
        for <linux-acpi@vger.kernel.org>; Fri, 04 Jun 2021 10:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hq4SLEuuP8OvsxIwZ6jr2msikPiKZx06r8wHUFyD0es=;
        b=XiWOMxbuIbcUdCPVeHIHSNXstmy2V/O86RerPh6KTf+jyrdvgSTXDTV4JROfPAnZ7X
         7TF7svwa+hNQOsshwP8G+31pCYfplgJZADKr2lEHL2amnrxsMFiy0s/Pedi4WnsupgZ9
         c6q5F+dClAvdcXfgKYEFcYDNZww+uKCTPbblQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hq4SLEuuP8OvsxIwZ6jr2msikPiKZx06r8wHUFyD0es=;
        b=lG3Rgo5SJQAvpHgVGFxd0Qf4yV0/ua4ylv/VRyoMT1Ltyym74+XozQZg7cVbRAgTrm
         qAy1UAhGfPbYwP9o1xpEt2K3pTTbIHXNB1xgFtoLAD2aLf08KQTtSqzdtXlv4wrlzVgV
         I1IWyEHf4pxe+9dOx6CQYv05PIkSxhTxlg6cDos/aK2/4kIKKeBNAiGuzY2zKyX4gfaW
         GBSUEMHSKbBxTO+sl5oQ++Wg0X9dgnm7tNnxz95ryeHz99qWeTapgxYYB9lwuFGXDNGr
         W7sMjW42iHNs2cMBZw0lynM85fW0Cue7jaOv8qcLwnF2THOVvxArKziD9q9YLmrjuZax
         BqlA==
X-Gm-Message-State: AOAM532G+vRZjSt7MPs/R6K+hYlheFdgwmVeG26TbyO1RMrJ6QFEQj9D
        uAFqZeeJv/I03M4uaP//TGo8bUpMvvBRRHxW
X-Google-Smtp-Source: ABdhPJwd+Ity94Ngzr61A0mVKapdj1H+N9/dBz9HUdvxQzcyohS6C1Rpb1cN3tvzDB8HEcI2q49HCg==
X-Received: by 2002:a17:906:268c:: with SMTP id t12mr5021835ejc.441.1622826199946;
        Fri, 04 Jun 2021 10:03:19 -0700 (PDT)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id f3sm3534571eds.59.2021.06.04.10.03.18
        for <linux-acpi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Jun 2021 10:03:19 -0700 (PDT)
Received: by mail-ej1-f51.google.com with SMTP id c10so15504441eja.11
        for <linux-acpi@vger.kernel.org>; Fri, 04 Jun 2021 10:03:18 -0700 (PDT)
X-Received: by 2002:a17:906:7fc5:: with SMTP id r5mr5288436ejs.474.1622826198524;
 Fri, 04 Jun 2021 10:03:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210604165403.2317-1-mario.limonciello@amd.com>
In-Reply-To: <20210604165403.2317-1-mario.limonciello@amd.com>
From:   Raul Rangel <rrangel@chromium.org>
Date:   Fri, 4 Jun 2021 11:03:07 -0600
X-Gmail-Original-Message-ID: <CAHQZ30B9niNnqPEi5XMjjiVv+N-GAeBOC0jk20owz3UZRyT4Gg@mail.gmail.com>
Message-ID: <CAHQZ30B9niNnqPEi5XMjjiVv+N-GAeBOC0jk20owz3UZRyT4Gg@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] acpi: PM: Move check for _DSD StorageD3Enable
 property to acpi
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        linux-acpi@vger.kernel.org, david.e.box@linux.intel.com,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Alex Deucher <Alexander.Deucher@amd.com>,
        Prike Liang <prike.liang@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Jun 4, 2021 at 10:54 AM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> Although first implemented for NVME, this check may be usable by
> other drivers as well. Microsoft's specification explicitly mentions
> that is may be usable by SATA and AHCI devices.  Google also indicates
> that they have used this with SDHCI in a downstream kernel tree that
> a user can plug a storage device into.
>
> Link: https://docs.microsoft.com/en-us/windows-hardware/design/component-guidelines/power-management-for-storage-hardware-devices-intro
> Suggested-by: Keith Busch <kbusch@kernel.org>
> CC: Shyam-sundar S-k <Shyam-sundar.S-k@amd.com>
> CC: Alexander Deucher <Alexander.Deucher@amd.com>
> CC: Rafael J. Wysocki <rjw@rjwysocki.net>
> CC: Prike Liang <prike.liang@amd.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/acpi/device_pm.c | 25 +++++++++++++++++++++++++
>  drivers/nvme/host/pci.c  | 28 +---------------------------
>  include/linux/acpi.h     |  5 +++++
>  3 files changed, 31 insertions(+), 27 deletions(-)
>
> Changes from v4->v5:
>  * Correct extra "Link:" word in commit message
>

Acked-by: Raul E Rangel <rrangel@chromium.org>
