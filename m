Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFEB72CE8B5
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Dec 2020 08:42:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725550AbgLDHmC (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 4 Dec 2020 02:42:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726826AbgLDHmC (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 4 Dec 2020 02:42:02 -0500
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C651C061A51
        for <linux-acpi@vger.kernel.org>; Thu,  3 Dec 2020 23:41:21 -0800 (PST)
Received: by mail-ej1-x641.google.com with SMTP id f23so7317769ejk.2
        for <linux-acpi@vger.kernel.org>; Thu, 03 Dec 2020 23:41:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vFrjH1pebtHRVLO1ux9EWFCYu/RwreoyJELqX0+IPnc=;
        b=LARuI+TBPzO3Ga5vWARBohOjAhz9a8rtPxXGdu+uM/SIeQvEVkcmNETd82GJUvt3rP
         UrtJqgbdW6ofj9JvePmTccqxWbwXhQKehCAFsBRtyd4AmPM23y9oqmCA/52F8duQuhE9
         ugSYrm/Zt5Lf4gDKJkuNEru5WvX3EZKFZdrLk9Q9otKCm7bUFzMYZMQHekDZ1Sn/h6/H
         K176ykrgZ8Xv0bBj1DwoXSePkoBIoGAVtP5YtdqRamNk3LtaNfXoTvscrNM+Vtw5e4GX
         FI0ye2UTvhzyvRyCFU9frlG1XfC2dulBc8lj5YuXVKCkSDsPgtt48/x/5Bsnf46cRHZV
         wUfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vFrjH1pebtHRVLO1ux9EWFCYu/RwreoyJELqX0+IPnc=;
        b=I0juNlpW6ESJ78XABekFKVSTy4l+OAsQ3NjVGbivmMTujkHiUiLEJcwululqXUpAqD
         J04aTIu0zQVvTY9NLVk5bpoPfNxS729ubH5u5dVXJtyo0TwDZGWQTBB1ZNpr0TM5Eyh3
         Wo1q3onG2K4txRQr8PUuqDditaxEBezyZClL76okQDHoIPWRBc3lz8U7Coo0h7oQHuc6
         54zpQwllsLkozXeIapcWHMTEv260DfnkFyj8dSCfjpy/Zj9873HBZhgb8leyWjs2/+fF
         dTpgeVOmKYxB/E850gclqG8bLphSElGW1aoIvNsOdO+mosE5J/3MU43uID74pJ+b/jOk
         XhwQ==
X-Gm-Message-State: AOAM530l9/ea+1Ub4Rj85czUL/Yut8RVtMd3RddgSIDz/H98JXmeH7gu
        X2GgS50xCGmtuYAe0897Oe9e4PxIPYl70zAWa3278hC1vJk=
X-Google-Smtp-Source: ABdhPJzSsebV9eSwHiYkUbp1imTyDqj15HLUPCpdjs4KFLddINcAGKE19CPMZmHmEIqLI6eGZ5b3wsVn8kXTD1lBfD0=
X-Received: by 2002:a17:906:c20f:: with SMTP id d15mr5897853ejz.341.1607067680341;
 Thu, 03 Dec 2020 23:41:20 -0800 (PST)
MIME-Version: 1.0
References: <20201111054356.793390-1-ben.widawsky@intel.com> <20201111054356.793390-6-ben.widawsky@intel.com>
In-Reply-To: <20201111054356.793390-6-ben.widawsky@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 3 Dec 2020 23:41:16 -0800
Message-ID: <CAPcyv4g-hO5yz1bod6X+ZrL_8-6CRBvf==pB3sbuBzZmsT7Kng@mail.gmail.com>
Subject: Re: [RFC PATCH 5/9] cxl/mem: Find device capabilities
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     linux-cxl@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Nov 10, 2020 at 9:44 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> CXL devices contain an array of capabilities that describe the
> interactions software can interact with the device, or firmware running
> on the device. A CXL compliant device must implement the device status
> and the mailbox capability. A CXL compliant memory device must implement
> the memory device capability.
>
> Each of the capabilities can [will] provide an offset within the MMIO
> region for interacting with the CXL device.
>
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> ---
>  drivers/cxl/cxl.h | 89 +++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/mem.c | 58 +++++++++++++++++++++++++++---
>  2 files changed, 143 insertions(+), 4 deletions(-)
>  create mode 100644 drivers/cxl/cxl.h
>
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> new file mode 100644
> index 000000000000..02858ae63d6d
> --- /dev/null
> +++ b/drivers/cxl/cxl.h
[..]
> +static inline u32 __cxl_raw_read_reg32(struct cxl_mem *cxlm, u32 reg)

Going through my reworks and the "raw" jumped out at me. My typical
interpretation of "raw" in respect to register access macros is the
difference between readl() and __raw_readl()  which means "don't do
bus endian swizzling, and don't do a memory clobber barrier". Any
heartburn to drop the "raw"?

...is it only me that reacts that way?
