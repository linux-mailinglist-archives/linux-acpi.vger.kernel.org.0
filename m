Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC0DA352529
	for <lists+linux-acpi@lfdr.de>; Fri,  2 Apr 2021 03:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbhDBBeP (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 1 Apr 2021 21:34:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233870AbhDBBeP (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 1 Apr 2021 21:34:15 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1063C061788
        for <linux-acpi@vger.kernel.org>; Thu,  1 Apr 2021 18:34:14 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id t18so2029326pjs.3
        for <linux-acpi@vger.kernel.org>; Thu, 01 Apr 2021 18:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=mMutIO+5Vq0+K4IsbVRAXhhUKaRfSoCin5JU2V1HQ9M=;
        b=AWm+56YMqZwsTjJBzqDLnhJYZvE6k2YrwwX5jiom8QWf83rVuMVaLjqEfRuEx5gTI0
         ha7tiFkiIwl2nqSF1NQPL/tOzUz2udc4VYg/PcPWay01oTW/hZHUiD2ZUfdAdrLGAbSC
         9tALuwiG1EFZt4dVzrYaoGiPTVzvJ7btQ4EyjPCrxXnNo0Fzsgw/o7z/tJw1zpf/ptMO
         +iaZSsLHm2FZx18STaffvK0eG/O3/7XEDpZlzu1UAjFLshWlGU9z4ss9JHaVJkdtgWBb
         MrebhzXvcjUrVlJhZDi2wxL6TKuzUjC60AbVxHZvkClgJdWzSnP7igmjXImQHBWzJuiB
         7CCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=mMutIO+5Vq0+K4IsbVRAXhhUKaRfSoCin5JU2V1HQ9M=;
        b=Imsh5D67KdoRefbJ7oqLjIinsjrdgpSz0n4xFw8DZbmwaRfbpMGgYBsxo+sWy/AsxB
         Z9lG3gO2NVm9HR45Sk1nktvsHoxElB9LDc7tXTR7sjylNPoXmCdaxc9+Tazih7tithZ4
         qiVObWDtqbOxQSHfGYfGigR0XyETs3vDH6b8eg+n3tCwixlC+Ylf6I0o5lrEPLNZ7tgo
         ajG7JU3uaLUrI1cY00iwVr4slSImcmmbQWiNakUipsqph/iBAGeCTv7bfJUKG2m1F9mT
         pg2nhIu0wVI55d7YYzsfEQwTaTZZ1muJqYoZJP6cKkwF5iOpQb7HqTXJuofVOTwPcS//
         NWhA==
X-Gm-Message-State: AOAM532l9GIPMWs+f0l4mqiBzY9o5QU5pt3Sy7sPjCUHZCiQ2XRNS7Iy
        9byxc8i++20MdBqj3EM1ehInrw==
X-Google-Smtp-Source: ABdhPJzdC0JhNLL0BglP12LotW9VT9boXJNnlktYWSmNFLHMQEz5J1OK80HqA9Dv57lVCK19/6Y4ig==
X-Received: by 2002:a17:90b:4910:: with SMTP id kr16mr11344355pjb.26.1617327254287;
        Thu, 01 Apr 2021 18:34:14 -0700 (PDT)
Received: from ?IPv6:240e:362:403:1700:58c5:c814:85bd:7d2e? ([240e:362:403:1700:58c5:c814:85bd:7d2e])
        by smtp.gmail.com with ESMTPSA id ha8sm6351510pjb.6.2021.04.01.18.34.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Apr 2021 18:34:13 -0700 (PDT)
Subject: Re: [PATCH v14 10/10] iommu/arm-smmu-v3: Add stall support for
 platform devices
To:     Will Deacon <will@kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     joro@8bytes.org, vivek.gautam@arm.com, guohanjun@huawei.com,
        linux-acpi@vger.kernel.org, lenb@kernel.org,
        devicetree@vger.kernel.org, kevin.tian@intel.com,
        robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        rjw@rjwysocki.net, iommu@lists.linux-foundation.org,
        sudeep.holla@arm.com, robin.murphy@arm.com,
        linux-accelerators@lists.ozlabs.org
References: <20210401154718.307519-1-jean-philippe@linaro.org>
 <20210401154718.307519-11-jean-philippe@linaro.org>
 <20210401171101.GB9447@willie-the-truck>
From:   Zhangfei Gao <zhangfei.gao@linaro.org>
Message-ID: <0292a8fb-9408-9c2b-0875-0b71e5f6e170@linaro.org>
Date:   Fri, 2 Apr 2021 09:34:00 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210401171101.GB9447@willie-the-truck>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi, Will

On 2021/4/2 上午1:11, Will Deacon wrote:
> On Thu, Apr 01, 2021 at 05:47:19PM +0200, Jean-Philippe Brucker wrote:
>> The SMMU provides a Stall model for handling page faults in platform
>> devices. It is similar to PCIe PRI, but doesn't require devices to have
>> their own translation cache. Instead, faulting transactions are parked
>> and the OS is given a chance to fix the page tables and retry the
>> transaction.
>>
>> Enable stall for devices that support it (opt-in by firmware). When an
>> event corresponds to a translation error, call the IOMMU fault handler.
>> If the fault is recoverable, it will call us back to terminate or
>> continue the stall.
> Which hardware is this useful for? Stalling adds a fair amount of complexity
> to the driver, so I don't think we should support it unless we're likely to
> see platforms that both implement it and do something useful with it.
I have tested the stall mode on Hisilicon Kunpeng920 board, as well as 
using drivers/misc/uacce/uacce.c.

Thanks
