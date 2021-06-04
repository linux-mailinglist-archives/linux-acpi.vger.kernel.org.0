Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE8839C0F1
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Jun 2021 22:00:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbhFDUCC (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 4 Jun 2021 16:02:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231347AbhFDUCA (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 4 Jun 2021 16:02:00 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2A90C061766
        for <linux-acpi@vger.kernel.org>; Fri,  4 Jun 2021 12:59:59 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id k7so16188291ejv.12
        for <linux-acpi@vger.kernel.org>; Fri, 04 Jun 2021 12:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PiCjHeklg/T0SzOA7e406SgYZUGIw154ONY/fprUGik=;
        b=C+nZuRFR0WmApv+45ZEEZGXAA2OAqW+Q8qyxaJMOx6rFUh5NdCU7EKjnL71zOA4wYj
         WmigbfF2wjHovMIt1ewGxsiu8R2sYW2kbhvgspGuuPyf8sM45aJs4nfOVJ+9XUocgp5z
         /OPreMZz9n8TGQgUDUUDBPyLqmyimvO+/fyPdhuRL4ilaBNU2rhvTzgBnE0Fiw4f1oSF
         7dzxY9u6O7Gmk3JCkLOdphN+cQqLsN6BukO5aQqW9trk0j7deEBIu7uK5XIH/ZGnulDr
         PumSnBuiU653BQXRZY7skFyQjlsyqWJcEDprZicRBrY44oFjilv4IAtP4n6YJC+9MYGN
         qKcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PiCjHeklg/T0SzOA7e406SgYZUGIw154ONY/fprUGik=;
        b=grWoB+sQ/KAjk9IPelSJ5VhW/MCU4FHlSPUUISrMCRLNzLf2xHJyV+HZaIYhvT6V4z
         DJ86Kv1ZQ/y7ZV+hhHgZHufSDaajldv85G8Mx1VvSaaRNUr22OgXcJhR7XSXqKhQCdz0
         aP9e1FsKm0TWAj9DMJ32PuXPotJR0h8ZX5EPpptoKM5rndMgox8dIdNqlEDoAskeqKmE
         /bsujrZ1lVHODSf83DiTtCh+YAGJ/6opTeWd85u29ENHnjIc1F/a2/zFxDKYHxxTAmm3
         8ny6E46H/yrC4FqUYC8ILdHSN1mwsvqp2nD8NpjZPwfGOoLvNxkYW88w6hEbkshUmlx9
         EjrQ==
X-Gm-Message-State: AOAM533CLOnwbOMo3wx+x3qEQPsQJp6FHX/4VAyTjDISDrUR5xShTqAq
        owh/Mf5D5riSytX8syzdgk8=
X-Google-Smtp-Source: ABdhPJzDtXQq60L7ImYbm1KjBldo4PtWRwDq+GCRsoZFbTvHHd/qVL5ibtUaPD4oHZui7/dynFlezA==
X-Received: by 2002:a17:906:274d:: with SMTP id a13mr5873040ejd.51.1622836796818;
        Fri, 04 Jun 2021 12:59:56 -0700 (PDT)
Received: from ?IPv6:2a02:908:1984:a6c0::ed5b? ([2a02:908:1984:a6c0::ed5b])
        by smtp.gmail.com with ESMTPSA id f18sm3180025ejz.119.2021.06.04.12.59.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Jun 2021 12:59:56 -0700 (PDT)
Subject: Re: [PATCH v5 2/2] acpi: PM: Add quirks for AMD Renoir/Lucienne CPUs
 to force the D3 hint
To:     Mario Limonciello <mario.limonciello@amd.com>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc:     "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        linux-acpi@vger.kernel.org, rrangel@chromium.org,
        david.e.box@linux.intel.com, Shyam-sundar.S-k@amd.com,
        Alexander.Deucher@amd.com, prike.liang@amd.com
References: <20210604165403.2317-1-mario.limonciello@amd.com>
 <20210604165403.2317-2-mario.limonciello@amd.com>
From:   Julian Sikorski <belegdol@gmail.com>
Message-ID: <efa36cd9-c125-e660-048d-86b7178fbdbd@gmail.com>
Date:   Fri, 4 Jun 2021 21:59:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210604165403.2317-2-mario.limonciello@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Am 04.06.21 um 18:54 schrieb Mario Limonciello:
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
>   drivers/acpi/device_pm.c | 19 +++++++++++++++++++
>   1 file changed, 19 insertions(+)
> 
> Changes from v4->v5:
>   * Add this patch back in as it's been made apparent that the
>     system needs to be hardcoded for these.
>     Changes:
>     - Drop Cezanne - it's now covered by StorageD3Enable
>     - Rebase ontop of acpi_storage_d3 outside of NVME

Tested-by: Julian Sikorski <belegdol@gmail.com>
