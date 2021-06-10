Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B50833A2F2C
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Jun 2021 17:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231467AbhFJPUb (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 10 Jun 2021 11:20:31 -0400
Received: from mail-pf1-f174.google.com ([209.85.210.174]:42826 "EHLO
        mail-pf1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231374AbhFJPUa (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 10 Jun 2021 11:20:30 -0400
Received: by mail-pf1-f174.google.com with SMTP id s14so1878120pfd.9
        for <linux-acpi@vger.kernel.org>; Thu, 10 Jun 2021 08:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mS2MKuQ1MIt5zD53BiXmwH5v3s+3aSWZOMRcLFPuyQQ=;
        b=aQo9cpvxebrDYW33Evapw/yzHiQs2RxOy61K7n6IgoUxXfISlrgVfdnJDR4OZgqovP
         yYwwBdVs3foftayF4m2A9wfEOAncKKn2BRzh1HtIvcmSvLMtsw/HHxtzrcY1+psDLHsc
         40TLCaGdp6NniC1rGVV5GIPP6vudH01wEdeJmKMaXJ95lJq3OLJDIqsTRGzNTM4OJrpa
         DwZpfxIW+A4Mqvse8uOyl2SMZ8N6V+1Oi9kbUwhek03aEk400N9J9eKocfp3NckjiLen
         FCAX3l3f1J1Ln8lqWl6H4IoUj9GnbnYM3FT3hXAZR6WPQh4m/nDjCW4F0zDww18ZIQEC
         WcRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mS2MKuQ1MIt5zD53BiXmwH5v3s+3aSWZOMRcLFPuyQQ=;
        b=CtjlrfHiYoT1fOp5mNTzxvdnsJajqdcNCt0snUSZF5uuRlLs/SG+lkZH24gT1KA/Qa
         eDsmLyHA96QMVM21BdIP4F0JOPTU5JKJ3uQzqFQeHO4irhAtnwlf9JawvHMhhJClJns2
         e9IVXyTMgJn757t1CTgSPZHv9W8BPNRNd3tpx+rw2wlssbaLFy/62K/0wYl/YCEt5ET9
         uu+9VwrdIrusLfgkpgi7M9CSE5y83iq3fNnHVmewqCxvtsEY3ymDI7dQbNz4D608Opur
         17fFIHK9ItnTeLo6vEbA8lqDRg6Q+rczla4e13bFmABafvC0UPny1dgax0gU3ts1bgBP
         5cjA==
X-Gm-Message-State: AOAM530onxgv4U9L8UOx9CyIXp18NuAKUXX++xjUg2j+2byq2F3nMw1r
        HUTnW+P0DfnCnwEdQRvwx9PTgJFUxTGhVcZpNTvHPA==
X-Google-Smtp-Source: ABdhPJwEZL6AolcfQZhCtpeWi9L4JRznxZSkG0jfVSTQeMveEIT9vlfwlPBapoWue5ubB3fyFFQoiZkPFIhMAYJAY0g=
X-Received: by 2002:a62:8287:0:b029:2ec:9b1f:9c0a with SMTP id
 w129-20020a6282870000b02902ec9b1f9c0amr3541997pfd.31.1623338254593; Thu, 10
 Jun 2021 08:17:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210524133938.2815206-1-Jonathan.Cameron@huawei.com> <20210524133938.2815206-2-Jonathan.Cameron@huawei.com>
In-Reply-To: <20210524133938.2815206-2-Jonathan.Cameron@huawei.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 10 Jun 2021 08:17:23 -0700
Message-ID: <CAPcyv4i5-d6HrhQwUmjx7HqKA+pr8aQjPGHJ=7Sh3eTgJ1UKyg@mail.gmail.com>
Subject: Re: [PATCH v4 1/5] PCI: Add vendor ID for the PCI SIG
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Linux PCI <linux-pci@vger.kernel.org>, linux-cxl@vger.kernel.org,
        Bjorn Helgaas <helgaas@kernel.org>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Chris Browy <cbrowy@avery-design.com>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Fangjian <f.fangjian@huawei.com>, Linuxarm <linuxarm@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, May 24, 2021 at 6:41 AM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> This ID is used in DOE headers to identify protocols that are defined
> within the PCI Express Base Specification.
>
> Specified in Table 7-x2 of the Data Object Exchange ECN (approved 12 March
> 2020) available from https://members.pcisig.com/wg/PCI-SIG/document/14143
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  include/linux/pci_ids.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index 4c3fa5293d76..dcc8b4b14198 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -149,6 +149,7 @@
>  #define PCI_CLASS_OTHERS               0xff
>
>  /* Vendors and devices.  Sort key: vendor first, device next. */
> +#define PCI_VENDOR_ID_PCI_SIG          0x0001

Should this not be:

PCI_DOE_VENDOR_ID_PCI_SIG?

...because I don't think this value will ever show up at the typical
config-offset 0 vendor-id, will it?
