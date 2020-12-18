Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEEDA2DDEB7
	for <lists+linux-acpi@lfdr.de>; Fri, 18 Dec 2020 07:49:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732796AbgLRGsm (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 18 Dec 2020 01:48:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732794AbgLRGsm (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 18 Dec 2020 01:48:42 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD977C0617A7
        for <linux-acpi@vger.kernel.org>; Thu, 17 Dec 2020 22:48:01 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id v3so873921plz.13
        for <linux-acpi@vger.kernel.org>; Thu, 17 Dec 2020 22:48:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Nd22eKsSmk6waOLkekeVIJaN2h0vcQRGdExQuNh8r+o=;
        b=JV55w9RJHlNDrpbAs0KqCWm5jTeBirALv3OzEGNimJnmYPpOniRKISwjJZ99KwhMia
         LZ0cA/j4WGXRXImtf+x7TlBbmYI7cqTI/lNnoBocYvBqR78jTb5wkzTOE5fcLGIRCV54
         IJwjhcuUOQH2w+I7lEdNtGIM9ry2apQPMX4YimceNtL7qwHnAb1BSx4GOpcpCrkVUcgE
         8ItjJeUDB8wbN64mphSntnZpXnDtkrrdQKmSWbNcGYgUPqbPpb7IrGaaKwTg+PStjlIP
         LFy4K6txICy13Oly9GRbh2hxr0hNbKZ0STEFSLj1ymii+OWwgL6EI1gv9ZDgFpBEY8cM
         pSyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Nd22eKsSmk6waOLkekeVIJaN2h0vcQRGdExQuNh8r+o=;
        b=I+WSQD/GABsgTD9Xxkz/pLJaTmyXALsSm/trXeoq9Ww2WhwEvXjOOnE2pSP8cinOiQ
         bkRePfFxvIGP01QVL7F/wFf58UPiO/9BYdFXUlAPWLRGySwSXnI5miedqzjDfgQNGgqD
         r/E0WUhJH4ZlIBbg1FvnPCu8w8YSS7hR/3SUlRSulpXY1kkb2N+Fxvs639cX6QrAqRfm
         lrydNshapsiJ65ev/9CAtTWONPK/1GVn5198jDja/abt1ujVtUl26X0+5p9HTU/EDizm
         GuMsVCI0vSPhEYrl3SKoWDPLhoRiJv28NP9fvUQ3Y5Cm1hKdPIN1zfxFd02FqoQUJWEN
         IW8Q==
X-Gm-Message-State: AOAM532Q3Lw2pM49sGW419tnrKqg84ZIfkl4rmwvECDIh3J3QsdErpRp
        HxvjJFsi0qQWekwcRZffSYqstQ==
X-Google-Smtp-Source: ABdhPJxN+zyn/o5/ECghJrrBpTGxb9htIs8KNFZW3iJjEN2NNdnXvN4NN921DPcleas8TN59wDvxSg==
X-Received: by 2002:a17:90a:fe8e:: with SMTP id co14mr2998599pjb.105.1608274081410;
        Thu, 17 Dec 2020 22:48:01 -0800 (PST)
Received: from ?IPv6:240e:362:421:6800:e481:5ceb:8cc4:e9ab? ([240e:362:421:6800:e481:5ceb:8cc4:e9ab])
        by smtp.gmail.com with ESMTPSA id j20sm7610772pfd.106.2020.12.17.22.47.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Dec 2020 22:48:00 -0800 (PST)
Subject: Re: [PATCH v8 4/9] of/iommu: Support dma-can-stall property
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     joro@8bytes.org, will@kernel.org, lorenzo.pieralisi@arm.com,
        robh+dt@kernel.org, guohanjun@huawei.com, sudeep.holla@arm.com,
        rjw@rjwysocki.net, lenb@kernel.org, bhelgaas@google.com,
        Jonathan.Cameron@huawei.com, eric.auger@redhat.com,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org, baolu.lu@linux.intel.com,
        shameerali.kolothum.thodi@huawei.com, vivek.gautam@arm.com
References: <20201112125519.3987595-1-jean-philippe@linaro.org>
 <20201112125519.3987595-5-jean-philippe@linaro.org>
 <d0a61d79-82fc-3af8-570e-e2ae3d485455@arm.com> <X9dS9H9PrOZbND9E@myrica>
From:   Zhangfei Gao <zhangfei.gao@linaro.org>
Message-ID: <e4dd8876-efe9-d7d9-955e-cadb9e4ef4f7@linaro.org>
Date:   Fri, 18 Dec 2020 14:47:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <X9dS9H9PrOZbND9E@myrica>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



On 2020/12/14 下午8:51, Jean-Philippe Brucker wrote:
> On Thu, Nov 26, 2020 at 06:09:26PM +0000, Robin Murphy wrote:
>> On 2020-11-12 12:55, Jean-Philippe Brucker wrote:
>>> Copy the dma-can-stall property into the fwspec structure.
>> Can't we just handle this as a regular device property? It's not part of the
>> actual IOMMU specifier, it doesn't need to be translated in any way, and
>> AFAICS it's used a grand total of once, in a slow path. Simply treating it
>> as the per-device property that it is should require zero additional code
>> for DT, and a simple device_add_properties() call for IORT.
>>
>> TBH that appears to be true of pasid-num-bits as well.
> Right I think that's better, thanks for the pointer. I'll take care of
> pasid-num-bits too. The Huawei quirk (fake PCIe supporting stall) is a
> little worse this way, but it should work.

Thanks Jean, I tested the following diff, it works with Huawei quirk.

Thanks
