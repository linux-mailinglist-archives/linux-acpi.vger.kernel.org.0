Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80BB139BF16
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Jun 2021 19:49:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbhFDRvj (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 4 Jun 2021 13:51:39 -0400
Received: from mail-lf1-f49.google.com ([209.85.167.49]:36554 "EHLO
        mail-lf1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbhFDRvi (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 4 Jun 2021 13:51:38 -0400
Received: by mail-lf1-f49.google.com with SMTP id v22so13951649lfa.3
        for <linux-acpi@vger.kernel.org>; Fri, 04 Jun 2021 10:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QzM9hRQ9yPLBo8yltzOsaJJDpS5Eg+eNbSkbpJeCOPs=;
        b=AhdudWhNLVtfqdVHQ46Zw54IW9N32wRucN6KBsEpo3OKfGF9l56tMXkaK9E+w51qdD
         mCA33ErtRKMZjDl8uFDjDJByh31dllDQATXRZ2Vd7SitdvrQUq3eR9FknCjCHO89PMBq
         sDFjU1XhzH5Db9zDLchYSeJpd/Dyf2qj2V99k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QzM9hRQ9yPLBo8yltzOsaJJDpS5Eg+eNbSkbpJeCOPs=;
        b=O18nu8OEe4q9IY9TkbHwb7oU4BQbPbEe0FsnmEVRjSeACtjG40n7oamMFIJi21B8K6
         CNfDq+TaOgLtpPFVNHfro7hw0CWGQg0xE2d3JbBnUwQRVS1413X/slmhNviDZFSdJmCO
         Vd//2j1HDWJG7S+m4L36p3zIam1dcKaVkCq2458W2iM+POURbc2iRCmEgP5rzRSe+kjp
         8MIaT9e/UcWaa46LFM4RVU76tOaQY7V88ytOHzkz/EM0vwjbgzf0Wr0dEUMI17vtE/sJ
         2trnrBv/FvSb3/bQH/ilgre0Bi4+PzlclHkGM3HXctiAy+Ylna2RWoBaudu+coaW1ock
         qS5w==
X-Gm-Message-State: AOAM532wVs5DbXMPHi5o9E/+3AVESANMQJqro6250j7cvpw0UKEaYi4C
        jLCRJ1w//gsrFFOKRj+GX3c+Ftt5Y293zSw7
X-Google-Smtp-Source: ABdhPJz79igLukmRDZ9h3f6xoXAWAFtw8sHu4p3MetSZvAzL2o0pNB9ONrMMttV8AjqFgcSkIk+iow==
X-Received: by 2002:ac2:5fcb:: with SMTP id q11mr3334634lfg.221.1622828915608;
        Fri, 04 Jun 2021 10:48:35 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id l23sm766710ljb.26.2021.06.04.10.48.35
        for <linux-acpi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Jun 2021 10:48:35 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id o8so12668815ljp.0
        for <linux-acpi@vger.kernel.org>; Fri, 04 Jun 2021 10:48:35 -0700 (PDT)
X-Received: by 2002:a50:9346:: with SMTP id n6mr5878355eda.365.1622828599683;
 Fri, 04 Jun 2021 10:43:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210604165403.2317-1-mario.limonciello@amd.com> <20210604165403.2317-2-mario.limonciello@amd.com>
In-Reply-To: <20210604165403.2317-2-mario.limonciello@amd.com>
From:   Raul Rangel <rrangel@chromium.org>
Date:   Fri, 4 Jun 2021 11:43:08 -0600
X-Gmail-Original-Message-ID: <CAHQZ30BWzY=oLvOtj==uinW2Fu__skuoLNYhz5NmDg=oRwq4Sw@mail.gmail.com>
Message-ID: <CAHQZ30BWzY=oLvOtj==uinW2Fu__skuoLNYhz5NmDg=oRwq4Sw@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] acpi: PM: Add quirks for AMD Renoir/Lucienne CPUs
 to force the D3 hint
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        linux-acpi@vger.kernel.org, david.e.box@linux.intel.com,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Alex Deucher <Alexander.Deucher@amd.com>,
        Prike Liang <prike.liang@amd.com>,
        Julian Sikorski <belegdol@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Jun 4, 2021 at 10:54 AM Mario Limonciello
<mario.limonciello@amd.com> wrote:

> +
> +#ifdef CONFIG_X86
> +static const struct x86_cpu_id storage_d3_cpu_ids[] = {
> +       X86_MATCH_VENDOR_FAM_MODEL(AMD, 23, 96, NULL),  /* Renoir */
> +       X86_MATCH_VENDOR_FAM_MODEL(AMD, 23, 104, NULL), /* Lucienne */
> +       {}
> +};
> +#endif
> +

Is this the same matching logic that Windows is using?
