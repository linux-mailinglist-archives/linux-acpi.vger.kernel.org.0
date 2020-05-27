Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBF031E4480
	for <lists+linux-acpi@lfdr.de>; Wed, 27 May 2020 15:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388516AbgE0NwN (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 27 May 2020 09:52:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388899AbgE0NwJ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 27 May 2020 09:52:09 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 113A4C08C5C1
        for <linux-acpi@vger.kernel.org>; Wed, 27 May 2020 06:52:09 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id 5so1549302pjd.0
        for <linux-acpi@vger.kernel.org>; Wed, 27 May 2020 06:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=sVOrxsk18BnSFATyAjPbeo6+7yMbRqTwIElwDUYrAFk=;
        b=IQd9QRIugzIzBpTvp3+gDmqldfXigO2E49gsEa4gWjkW8zQ7okCePzzME85lMseCYp
         C6UogWhM76FwGK5GWiG8mRjoqMxQAiVMmmfU32mB1clNfA4oHsd9jNVbdkKq9iRLaZ6o
         /GSx8wknomZEweg/pRNTs5AEyhz2TlPsVfIh1FVWAsub3p7gsfYfKsWEW0GjuGLOSeH3
         JX/KrTERHguXCxqwKCC2l18gU5RD125PFLl4ooOSVZXxkfqWDt3XB8oULXtxbINGB7jy
         IZ+Ys2oL0/yBtqmoT9wOKg1LwOZXfABmxwNOY7WVGXRfz3jB/ahveiTxn+3ArAeBKNsp
         azNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=sVOrxsk18BnSFATyAjPbeo6+7yMbRqTwIElwDUYrAFk=;
        b=B88+wehxVVmMotv+p9ArXqnm2jkQf9Ukb5DQOLyKrft4qNeofKhdP4jDuN7APIGXkb
         Hdz0gHuuXQEIJ107KwaODTo02d6IU1py+SKIO4OGYh3wDqKBeGROsbQQOIE6Or0ODHa4
         aFJNso1xGIX8YTF1gDkR0cwDX1F6UeLX00lk8hmGOOIWk0RTEtACz68cPjNVDMvQYpCX
         WKg/kXAZIlK/VYPfqAfdpbTHuIvxLSN+T7hQi4hQrf+XjYkxXALXVrqm5i0cgrNkG5Dg
         0Nyhnyg7kJVCVetSVG8i0u/8JTtK7ItKs3TvTX13gi+SLI7Ln9+Ljl7n1FFWj3IbKrCk
         LYoQ==
X-Gm-Message-State: AOAM533wnJROweJRU7EaXfc4Xh4M03LrJcGZ5ykKtMJNfSfB0NpehpKW
        WELCRYSIgTgg6qkEblv3pO89YQ==
X-Google-Smtp-Source: ABdhPJyJEWrfFe5MlHVlgCY+nDX0MeA9yhMhsez39F2xUkBVmUD/N243xLXOBOeIAja47JbP7VfxPQ==
X-Received: by 2002:a17:90a:2ac2:: with SMTP id i2mr5055611pjg.80.1590587528565;
        Wed, 27 May 2020 06:52:08 -0700 (PDT)
Received: from [192.168.11.133] (li1566-229.members.linode.com. [139.162.86.229])
        by smtp.gmail.com with ESMTPSA id s15sm2106775pgv.5.2020.05.27.06.51.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 May 2020 06:52:07 -0700 (PDT)
Subject: Re: [PATCH 0/2] Introduce PCI_FIXUP_IOMMU
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        jean-philippe <jean-philippe@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        kenneth-lee-2012@foxmail.com, Wangzhou <wangzhou1@hisilicon.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-pci <linux-pci@vger.kernel.org>
References: <1590493749-13823-1-git-send-email-zhangfei.gao@linaro.org>
 <20200527090007.GA179718@kroah.com>
 <CAK8P3a35fjXt1F2hJygup5gWfjPHZTuU+VD69K5uzrNhhgu0Pw@mail.gmail.com>
From:   Zhangfei Gao <zhangfei.gao@linaro.org>
Message-ID: <ec994862-ac1c-bb6e-4fe6-ce5bf74f614a@linaro.org>
Date:   Wed, 27 May 2020 21:51:13 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a35fjXt1F2hJygup5gWfjPHZTuU+VD69K5uzrNhhgu0Pw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



On 2020/5/27 下午5:53, Arnd Bergmann wrote:
> On Wed, May 27, 2020 at 11:00 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
>> On Tue, May 26, 2020 at 07:49:07PM +0800, Zhangfei Gao wrote:
>>> Some platform devices appear as PCI but are actually on the AMBA bus,
>> Why would these devices not just show up on the AMBA bus and use all of
>> that logic instead of being a PCI device and having to go through odd
>> fixes like this?
> There is a general move to having hardware be discoverable even with
> ARM processors. Having on-chip devices be discoverable using PCI config
> space is how x86 SoCs usually do it, and that is generally a good thing
> as it means we don't need to describe them in DT
>
> I guess as the hardware designers are still learning about it, this is not
> always done correctly. In general, we can also describe PCI devices on
> DT and do fixups during the probing there, but I suspect that won't work
> as easily using ACPI probing, so the fixup is keyed off the hardware ID,
> again as is common for x86 on-chip devices.
>
>   
Yes, thanks Arnd :)

In order to use pasid, io page fault has to be supported,
either by PCI PRI feature (from pci device) or stall mode from smmu 
(platform device).
Here is letting system know the platform device can support smmu stall 
mode, as a result support pasid.
While stall is not a pci capability, so we use a fixup here.

Thanks

