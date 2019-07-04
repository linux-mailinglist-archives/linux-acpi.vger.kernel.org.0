Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9100D5F288
	for <lists+linux-acpi@lfdr.de>; Thu,  4 Jul 2019 08:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726199AbfGDGEv (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 4 Jul 2019 02:04:51 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39629 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbfGDGEv (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 4 Jul 2019 02:04:51 -0400
Received: by mail-pf1-f194.google.com with SMTP id j2so2410648pfe.6;
        Wed, 03 Jul 2019 23:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=IYNDMwEAAumzRZivDc5Bsr2LbGFMlienhp8YivPF7m8=;
        b=BBgZfVY7Yvqs01AOHbN9gnMwKmmlegENWbG/bQy8SAOFjEN0jWMh553QE4Vb4b8/zx
         fc7H4jq19IUIYrfl/1hWM9Jb5Ga0jrYCnFHdtT62VVbG/bTzqYHkLv8HYb9Facm5DRUw
         K6MdQazi/b4I1q4ansuOBXgG7Ba6PH0BXU/N/K7I5Eaj7m4m4sVSWsYM4QMVY+XxVFsN
         7xYNbEsYmX8QJbxkrh+HtKrWFXKM+acx63XccFk4CvXq59kh+08xdxgmzP/UGwdexZiF
         tqVGYtNPIaoE1woxWwdvEf1YvFDaDPV+WWYLcf/27yoa55VUyP5i6itJz9GPUdGSG4IL
         2MIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding;
        bh=IYNDMwEAAumzRZivDc5Bsr2LbGFMlienhp8YivPF7m8=;
        b=oNMFFu3r6BQc18xIv9aQTuMJWqo5J9/nm+B8bhk8uyDKM0cupiU3ey89riypQg/zYh
         xU2/oDp/F7eYScEQ66Gk2HcFhefuqGhJZnDLdO4n9gphsK1qzA4pZ3ychnNXlNUnOXBm
         I62kbBs6vr50qdibLGwRG7jXlXoS0yjRA2W1I7z3GCm9Ue2rl2U5zbrLiIW8fYPHlsRh
         Sp26r1eVcdfJZ3TWuQuD3lCq3a3bsJwxfxqiqOyjKuNiSI9dpzjjRwe50K1nSPfZQnnX
         7u99nwCEg1ZTdClpdwErAzIoFM7EFZAhIq8JyM84ruYGEKGbi0ZVxpoNz7vaFS0Fokni
         f6MQ==
X-Gm-Message-State: APjAAAXUVFGGkHUTsXyXi8SJUZj3r2+LMYQ7m0l55gmsPIMG4xMwt1A1
        qTNO5g1fLcGZF+0bHymDXVk=
X-Google-Smtp-Source: APXvYqwrpuHzxiXd2Uf2RAlh3u6kWiRxybILi9WncqhlipHt+FeUMIKk8gwQMibe2uLYysEmaK0rxw==
X-Received: by 2002:a17:90a:3aed:: with SMTP id b100mr17799640pjc.63.1562220290787;
        Wed, 03 Jul 2019 23:04:50 -0700 (PDT)
Received: from [0.0.0.0] ([80.240.31.150])
        by smtp.gmail.com with ESMTPSA id v12sm3289916pjk.13.2019.07.03.23.04.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jul 2019 23:04:50 -0700 (PDT)
Subject: Re: [PATCH RFC 0/3] Support CPU hotplug for ARM64
To:     Xiongfeng Wang <wangxiongfeng2@huawei.com>, rjw@rjwysocki.net,
        catalin.marinas@arm.com, james.morse@arm.com
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, guohanjun@huawei.com,
        xiexiuqi@huawei.com, huawei.libin@huawei.com,
        john.garry@huawei.com, jonathan.cameron@huawei.com
References: <1561720392-45907-1-git-send-email-wangxiongfeng2@huawei.com>
 <2b22cf4d-9646-9f20-41ae-cceb83d9791b@gmail.com>
 <135ee490-a5a6-46c9-208e-81849b20d6b6@huawei.com>
From:   Jia He <hejianet@gmail.com>
Organization: ARM
Message-ID: <7898e483-a8e4-39a2-358f-8fcf838c242f@gmail.com>
Date:   Thu, 4 Jul 2019 14:04:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <135ee490-a5a6-46c9-208e-81849b20d6b6@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Xiongfeng

Sorry, I missed your latter mail, you used a emulated SCI interrupt

---
Cheers,
Justin (Jia He)

On 2019/7/4 11:26, Xiongfeng Wang wrote:
> Hi Justin,
>
> On 2019/7/4 11:00, Jia He wrote:
>> Hi Xiongfeng
>>
>> It is a little bit awkful that I am also  investigating acpi based cpu hotplug issue silimar with
>>
>> your idea. My question is your purpose to implement the vcpu hotplug in arm64 qemu?
> Yes, my purpose is to implement the vcpu hotplug in arm64 qemu. So that I can add or remove vcpu
> without shutting down the Guest OS.
>
> Thanks,
> Xiongfeng
>
>> Thanks for the ellaboration
>>
>> ---
>> Cheers,
>> Justin (Jia He)
>>
>> On 2019/6/28 19:13, Xiongfeng Wang wrote:
>>> This patchset mark all the GICC node in MADT as possible CPUs even though it
>>> is disabled. But only those enabled GICC node are marked as present CPUs.
>>> So that kernel will initialize some CPU related data structure in advance before
>>> the CPU is actually hot added into the system. This patchset also implement
>>> 'acpi_(un)map_cpu()' and 'arch_(un)register_cpu()' for ARM64. These functions are
>>> needed to enable CPU hotplug.
>>>
>>> To support CPU hotplug, we need to add all the possible GICC node in MADT
>>> including those CPUs that are not present but may be hot added later. Those
>>> CPUs are marked as disabled in GICC nodes.
>>>
>>> Xiongfeng Wang (3):
>>>     ACPI / scan: evaluate _STA for processors declared via ASL Device
>>>       statement
>>>     arm64: mark all the GICC nodes in MADT as possible cpu
>>>     arm64: Add CPU hotplug support
>>>
>>>    arch/arm64/kernel/acpi.c  | 22 ++++++++++++++++++++++
>>>    arch/arm64/kernel/setup.c | 19 ++++++++++++++++++-
>>>    arch/arm64/kernel/smp.c   | 11 +++++------
>>>    drivers/acpi/scan.c       | 12 ++++++++++++
>>>    4 files changed, 57 insertions(+), 7 deletions(-)
>>>
>> .
>>
-- 

