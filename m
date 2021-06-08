Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA71339EE7B
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Jun 2021 08:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbhFHGDq (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 8 Jun 2021 02:03:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbhFHGDp (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 8 Jun 2021 02:03:45 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F28EC061574
        for <linux-acpi@vger.kernel.org>; Mon,  7 Jun 2021 23:01:41 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id l7-20020a05600c1d07b02901b0e2ebd6deso1022011wms.1
        for <linux-acpi@vger.kernel.org>; Mon, 07 Jun 2021 23:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HPnNNnFk8ZJfdOepiUgC87XNGbVnqt8OoqKJvYcxXMM=;
        b=X1aXA1thb11a2kyKlVa0sPlBbxSMNiRT2AVV9Rdw6tvifc2j0MI83o42qwXqBXrog+
         mF/g8yIP+ThoslfsdTpZg5UZxkP3R+FXjod7Lo7vbXKmxkGAfHyAWk5/cPVJomP50r6j
         0LegrCktFXzU7nFpQyAO/gZKC7dx1KeClWVv0qXw6XNm3A8Ztv5MiTbwrm4M0aiV2hlT
         25RudjAqbOlx/6Pktzrr1RDG4xmvDZcr+7sg5KCRB6h20GeuazPOJHPcvL1fL4pETzJ5
         1C1opJlfutU4aCTWQahRZLhHuT5PR8RaWNtJmtDYgpfz+XuMbmJPbArZ7lPCHXdBlV0X
         RJxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HPnNNnFk8ZJfdOepiUgC87XNGbVnqt8OoqKJvYcxXMM=;
        b=U74xUP4zaqVCCIEiS/HaNmbypk8++UMPB2I+oOmxzv/pXfArtbBKBSBWh0k+vmHJdQ
         uQADJSsPUxv0fVKZ6KnFUm2lS3pl0vZrC6SC9bBO6MsasMTgi+ErN1bl1vVfB4SIgp6c
         L6lIKJNfn88KIIgrUCqu6LCf8jQGC2mU+2GokUY9IBWm1EcxncqvKJaZWN6tWUTSj33p
         gVp0U7xdaeLX0GFsn40GozqcbBlLXEe4EURuEb3EW+wdM8oavWQ7aVifi0LExpxnzVyW
         u6R0VlvyieuSgbIM4Vz9xd9qBhgz67TjZt5uZLA9UIRzkHYrVffm5EM+3a5AF4tDe38H
         FdyA==
X-Gm-Message-State: AOAM531ESgdmqcY1eOMm9h7EWR1hkUUJF2BQ/4FSbfJLR4mWcBRusS/z
        VrK3Dq5s45ZCz6D1g2ce2eI=
X-Google-Smtp-Source: ABdhPJxnySTQbq+Bn4oGnl+u7CvRfBOtu+sK+wz5uzXxsJGecEjC3JPWfbVtl8HcB9x9MSaxtI7Jaw==
X-Received: by 2002:a7b:c189:: with SMTP id y9mr20108803wmi.106.1623132099755;
        Mon, 07 Jun 2021 23:01:39 -0700 (PDT)
Received: from ?IPv6:2a02:908:1984:a6c0::ac4c? ([2a02:908:1984:a6c0::ac4c])
        by smtp.gmail.com with ESMTPSA id m3sm19354310wrr.32.2021.06.07.23.01.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Jun 2021 23:01:39 -0700 (PDT)
Subject: Re: [PATCH v6 2/2] ACPI: Add quirks for AMD Renoir/Lucienne CPUs to
 force the D3 hint
To:     Mario Limonciello <mario.limonciello@amd.com>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc:     "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        linux-acpi@vger.kernel.org, rrangel@chromium.org,
        david.e.box@linux.intel.com, Shyam-sundar.S-k@amd.com,
        Nehal-bakulchandra.Shah@amd.com, Alexander.Deucher@amd.com,
        prike.liang@amd.com
References: <20210607173156.5548-1-mario.limonciello@amd.com>
 <20210607173156.5548-2-mario.limonciello@amd.com>
From:   Julian Sikorski <belegdol@gmail.com>
Message-ID: <328f5fd7-f8d1-0543-a328-44ef0641c64b@gmail.com>
Date:   Tue, 8 Jun 2021 08:01:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210607173156.5548-2-mario.limonciello@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

W dniu 07.06.2021 o 19:31, Mario Limonciello pisze:
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

Tested-by: Julian Sikorski <belegdol@gmail.com>
