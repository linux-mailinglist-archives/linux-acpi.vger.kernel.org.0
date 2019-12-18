Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D222124CA3
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Dec 2019 17:07:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727552AbfLRQG5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 18 Dec 2019 11:06:57 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44152 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727607AbfLRQG5 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 18 Dec 2019 11:06:57 -0500
Received: by mail-wr1-f65.google.com with SMTP id q10so2869121wrm.11
        for <linux-acpi@vger.kernel.org>; Wed, 18 Dec 2019 08:06:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ilGmQzgVpyz5+GgzhiMi4TnzxPgEeCNgmk38TMF+kZE=;
        b=C1i8TT0BKaZyqPij7EJiWtjjPH+4RB1V0a/wUUSe/JhD9Oslbx/1Q6XBpUW4q/UXah
         aoe7twq2cCcWk0bOOJ8Gb45nCWzluMIaHz3zLYW62oA0JAIGE4LCdpdOofh0hHYbNncr
         7MRGFnhVHQ4QYKCyBPZDcJ+yuntrIOsJELzFkUuNbHJ5GH97ieyD4Hx/gV1FrVok8xPE
         jNC4iIRl7+jgHUADTihavmD3bgyz/hMLa6NPMD4z0NlctNZH0ccJcgj2fU8QyAbECLao
         R/3/iPqI0xBufIyVNwBG7j7oOgv1rd4/DaFeC9pHElsyRmZy3qcm5xpPdim14xbF4VWO
         YKKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ilGmQzgVpyz5+GgzhiMi4TnzxPgEeCNgmk38TMF+kZE=;
        b=lLPXuQ02iJ9WD7l9lvtoPp7lUMZ+E9eLqGXuRuUA3G8kEBsbSSvnkkfe1hbS2JMRZY
         YnD1ZhmsE/vI7tzqO45/NOeVhcOitJXrgV0XqJMxXLyvzuSOSXkg10hOPSPU4+2mamyH
         dm+GqoFDzQLsStrvNRfaVGY12z0S3DFjJbxiCkIhcnHLnwNu/KH2/8OicTccqz9vDPLx
         uZhyRoEwys9SPSFWH1VOc4NA/7rN36hcvql9ImGsEB3fegaRrxx+SWMnfghm9Ow4p/z2
         2kJjLC6ADSIovoKTbOByHteXQYTzvBGMFNd0MHuPhinbFQSqmEoIYnJx75sMJb60lP9I
         zt7w==
X-Gm-Message-State: APjAAAXjy/TResBtkoBa1ILAIdlk1FZQonYWOeN8Qe4/Da43BqHbvxuQ
        rQRZ6oQAS7mGFDJ6LwQI8YzTww==
X-Google-Smtp-Source: APXvYqzlJfnzBPNvhgPh9GCf337cLxDV4nJ7SDFk/WvYc0UpuKM/kTPeUg6Rln8M6dK6UBAz2n6nYw==
X-Received: by 2002:a5d:4dc9:: with SMTP id f9mr3435991wru.297.1576685214969;
        Wed, 18 Dec 2019 08:06:54 -0800 (PST)
Received: from myrica (adsl-84-227-176-239.adslplus.ch. [84.227.176.239])
        by smtp.gmail.com with ESMTPSA id d14sm3236857wru.9.2019.12.18.08.06.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 08:06:54 -0800 (PST)
Date:   Wed, 18 Dec 2019 17:06:49 +0100
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Auger Eric <eric.auger@redhat.com>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
        iommu@lists.linux-foundation.org, joro@8bytes.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, guohanjun@huawei.com,
        sudeep.holla@arm.com, rjw@rjwysocki.net, lenb@kernel.org,
        will@kernel.org, robin.murphy@arm.com, bhelgaas@google.com,
        jonathan.cameron@huawei.com, zhangfei.gao@linaro.org
Subject: Re: [PATCH v3 03/13] iommu/arm-smmu-v3: Support platform SSID
Message-ID: <20191218160649.GE2371701@myrica>
References: <20191209180514.272727-1-jean-philippe@linaro.org>
 <20191209180514.272727-4-jean-philippe@linaro.org>
 <06c57de4-cfca-f95f-ac06-ab6f49a028a3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06c57de4-cfca-f95f-ac06-ab6f49a028a3@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Dec 18, 2019 at 11:17:40AM +0100, Auger Eric wrote:
> Hi Jean,
> 
> On 12/9/19 7:05 PM, Jean-Philippe Brucker wrote:
> > For platform devices that support SubstreamID (SSID), firmware provides
> > the number of supported SSID bits. Restrict it to what the SMMU supports
> > and cache it into master->ssid_bits, which will also be used for PCI
> > PASID.
> > 
> > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> the title of the patch does not really explain what it actually does. At
> this stage we are far from supporting SSIDs ;-) Same for 04?

Alright I'll make this "Parse PASID devicetree property of platform
devices" and "Parse SSID property of named component node"

Thanks,
Jean
