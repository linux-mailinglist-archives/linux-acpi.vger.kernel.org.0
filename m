Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 668705F1A5
	for <lists+linux-acpi@lfdr.de>; Thu,  4 Jul 2019 05:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726696AbfGDDA3 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 3 Jul 2019 23:00:29 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41273 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727004AbfGDDA3 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 3 Jul 2019 23:00:29 -0400
Received: by mail-pg1-f193.google.com with SMTP id q4so2172421pgj.8;
        Wed, 03 Jul 2019 20:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=ulgkacOC9MVQoeI7C3VdBpGEpxQUJnlA06nqtcm87I8=;
        b=DsYC2ozCdkMop+Za96eslk9BJsSKBWurQHezKCWW6geGoOfVIeuhxl4Sp5lHF39jBT
         9jgWopa5+cFAjZU5L9ZpZVUj8FUFZQtcURCTsffBbsSNQzvDgi5kcMTLPuJZ8REmXb5D
         r7/jyERNtwW5tfiNJA+QAlS3h0I0RVFUpeEBxJ57+MiQQZ69Di60oDmw2/e8H6IVntQK
         ijkqibXJn6OXEIuqNhVn67kGhBLKwB1xJqUxmOkmGjwq63eDwaGHpSPR2vXOwWKGEU1d
         wIc+Cx7ljseODdcbgFRO0t7bqtYTHfj7kz3Glp4peMDNx+oeX262DOzZLrPM1j8XIfoC
         M73A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding;
        bh=ulgkacOC9MVQoeI7C3VdBpGEpxQUJnlA06nqtcm87I8=;
        b=LT3GislaB48qPiWylvQQAxvSd5j4spZThCZ8/JWRD7BaHjIdPUsD7zYL5V9FOvrg5n
         VPZiICGfUln5FlKZJKRSwSjsJ0uAPeuwdWvv6thp8Yb/GwMKpVhrxkpFC0N2nUZhey9o
         AM5dAhfRctmfsmpH29cBtJlYMXNbJWfbAAe466TznIPsysoWLrQANNArykfN2IADawj0
         VdjqIvCzdMlf0KP1j5Sd6LlK5p8gv2SzhjMLw0y9vj4pAp76ymcav2q2kYu8d+8+/WlR
         iKIzKg3EbLRCvwtC0f6KfZl3XTxd+Tw87nNLyQW0O9yJxJX6aXVB/1AvHKmTervUGLmb
         /LtQ==
X-Gm-Message-State: APjAAAXF3zxHSSMrlhc+bCSW1Th0J+4bqWzR0u8XyYrlThlF9HK1cjW0
        BeVDJpKOM4SNOFs+oyK/MBo=
X-Google-Smtp-Source: APXvYqwFIuhyG5fIhnFFFWROZCNEDtg0pyhsJMvdB6pyvQ5FrQPtPEQhiWU5qPE4sfConRMZZRdUMg==
X-Received: by 2002:a63:6986:: with SMTP id e128mr42386432pgc.220.1562209228925;
        Wed, 03 Jul 2019 20:00:28 -0700 (PDT)
Received: from [0.0.0.0] ([80.240.31.150])
        by smtp.gmail.com with ESMTPSA id z13sm3247183pjn.32.2019.07.03.20.00.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jul 2019 20:00:27 -0700 (PDT)
Subject: Re: [PATCH RFC 0/3] Support CPU hotplug for ARM64
To:     Xiongfeng Wang <wangxiongfeng2@huawei.com>, rjw@rjwysocki.net,
        catalin.marinas@arm.com, james.morse@arm.com
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, guohanjun@huawei.com,
        xiexiuqi@huawei.com, huawei.libin@huawei.com,
        john.garry@huawei.com, jonathan.cameron@huawei.com
References: <1561720392-45907-1-git-send-email-wangxiongfeng2@huawei.com>
From:   Jia He <hejianet@gmail.com>
Organization: ARM
Message-ID: <2b22cf4d-9646-9f20-41ae-cceb83d9791b@gmail.com>
Date:   Thu, 4 Jul 2019 11:00:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <1561720392-45907-1-git-send-email-wangxiongfeng2@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Xiongfeng

It is a little bit awkful that I am also  investigating acpi based cpu hotplug 
issue silimar with

your idea. My question is your purpose to implement the vcpu hotplug in arm64 qemu?

Thanks for the ellaboration

---
Cheers,
Justin (Jia He)

On 2019/6/28 19:13, Xiongfeng Wang wrote:
> This patchset mark all the GICC node in MADT as possible CPUs even though it
> is disabled. But only those enabled GICC node are marked as present CPUs.
> So that kernel will initialize some CPU related data structure in advance before
> the CPU is actually hot added into the system. This patchset also implement
> 'acpi_(un)map_cpu()' and 'arch_(un)register_cpu()' for ARM64. These functions are
> needed to enable CPU hotplug.
>
> To support CPU hotplug, we need to add all the possible GICC node in MADT
> including those CPUs that are not present but may be hot added later. Those
> CPUs are marked as disabled in GICC nodes.
>
> Xiongfeng Wang (3):
>    ACPI / scan: evaluate _STA for processors declared via ASL Device
>      statement
>    arm64: mark all the GICC nodes in MADT as possible cpu
>    arm64: Add CPU hotplug support
>
>   arch/arm64/kernel/acpi.c  | 22 ++++++++++++++++++++++
>   arch/arm64/kernel/setup.c | 19 ++++++++++++++++++-
>   arch/arm64/kernel/smp.c   | 11 +++++------
>   drivers/acpi/scan.c       | 12 ++++++++++++
>   4 files changed, 57 insertions(+), 7 deletions(-)
>
