Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A45DF3AC574
	for <lists+linux-acpi@lfdr.de>; Fri, 18 Jun 2021 09:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231889AbhFRH5i (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 18 Jun 2021 03:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233609AbhFRH5G (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 18 Jun 2021 03:57:06 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3877AC06175F
        for <linux-acpi@vger.kernel.org>; Fri, 18 Jun 2021 00:54:49 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id r7so7312180edv.12
        for <linux-acpi@vger.kernel.org>; Fri, 18 Jun 2021 00:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=o2WQZjhwoaHMxBb+srOde8YwelPLzLRldEZbtvlgRGU=;
        b=k1T0ECGGh1W0dhEm5YpW3R4tr4w2ouXUmoAkc4fnu+nm3wfGl1D/XzfrjxPVvNpD9R
         GUN87sw+XheVvqk6OE0++OuYZdogI1z1/Z+Lp7EcaWueCIl0eiIDcgBLTpL+k3ODqRRi
         o1irouPqfd1Q1/YN2nVPDXvXxcg204pgHRGlmEY1D6DM1HPSCvgbILp/o8l/Wvkr0Iw3
         rGuOE9LxvMTkCXpX5w0+1LTUHt3sZIF4mC2s2Skw8CTsGlTa12/M8ao345z4GdUAlnPd
         JDFt5F5xmanD8rpTrdfn3E8eDxfl207dVuGecnb6ZmTyEXAW4IxIunr2hSUFxui1Sf+u
         +S/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=o2WQZjhwoaHMxBb+srOde8YwelPLzLRldEZbtvlgRGU=;
        b=dwYydcD98eka5h5ySqwRXbwU+eHVkVgz3jw6BzFEi4FwYaqljOmDALqH+yofhG5XTI
         P1IK3xyC4sh0E7gSq4CPqrZNbz0nUAsDrP/MJrRadCk0jjwsZ7dEXRFDBQQVjR2Dy00a
         K/LXMC+eEfwvGgTcBDTOpD7FEjrC9bi5h8FJI3+kSQ19FbdaG1vxgfPDLFIa8eQeHrsS
         yHbZqW7g3jCMdkcJgb+G8A86bBxTNXw6rszCEKhgyvOXpaTipNJffgEwDhT9GfuenGO7
         GFeL8Dbw672HJEM4CmcEgCLpw2HRbfq0kxiw3ZJDI/ZlzcZAFJWjHg02nKbPd71lNiAF
         jweQ==
X-Gm-Message-State: AOAM530PrUcXwyds9xNtdMXK2Hh+MkBlTianDYsLWSgDkZPcdXWNS28k
        Wv6XyIJY9ci7pJ3jBF/1Fo5hCg==
X-Google-Smtp-Source: ABdhPJw47GTVGsZ2XZZsLWgVTPMHWXGLZ9JfMKbH6mO4cozlyWGnWGY9YGBYGbYr6USC4QNEMkKYww==
X-Received: by 2002:a05:6402:4395:: with SMTP id o21mr3261040edc.163.1624002887797;
        Fri, 18 Jun 2021 00:54:47 -0700 (PDT)
Received: from myrica (adsl-84-226-111-173.adslplus.ch. [84.226.111.173])
        by smtp.gmail.com with ESMTPSA id j22sm680988eje.123.2021.06.18.00.54.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 00:54:47 -0700 (PDT)
Date:   Fri, 18 Jun 2021 09:54:28 +0200
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:AMD IOMMU (AMD-VI)" <iommu@lists.linux-foundation.org>,
        virtualization@lists.linux-foundation.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Eric Auger <eric.auger@redhat.com>, sebastien.boeuf@intel.com,
        Robin Murphy <robin.murphy@arm.com>, kevin.tian@intel.com,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v4 3/6] ACPI: Add driver for the VIOT table
Message-ID: <YMxRNHVjKk3H6r7t@myrica>
References: <20210610075130.67517-1-jean-philippe@linaro.org>
 <20210610075130.67517-4-jean-philippe@linaro.org>
 <CAJZ5v0gTZDyEC7MuBEv2gg6Usq+PD-WEQJbiAqKrFC3KV-M52g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gTZDyEC7MuBEv2gg6Usq+PD-WEQJbiAqKrFC3KV-M52g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Jun 17, 2021 at 01:50:59PM +0200, Rafael J. Wysocki wrote:
> > diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> > index be7da23fad76..b835ca702ff0 100644
> > --- a/drivers/acpi/bus.c
> > +++ b/drivers/acpi/bus.c
> > @@ -27,6 +27,7 @@
> >  #include <linux/dmi.h>
> >  #endif
> >  #include <linux/acpi_iort.h>
> > +#include <linux/acpi_viot.h>
> >  #include <linux/pci.h>
> >  #include <acpi/apei.h>
> >  #include <linux/suspend.h>
> > @@ -1339,6 +1340,7 @@ static int __init acpi_init(void)
> >         pci_mmcfg_late_init();
> >         acpi_iort_init();
> >         acpi_scan_init();
> > +       acpi_viot_init();
> 
> Is there a specific reason why to call it right here?
> 
> In particular, does it need to be called after acpi_scan_init()?  And
> does it need to be called before the subsequent functions?  If so,
> then why?

It does need to be called after acpi_scan_init(), because it relies on
struct device and their fwnode to be initialized. In particular to find a
PCI device we call pci_get_domain_bus_and_slot(), which needs the PCI
topology made available by acpi_scan_init().

It does not need to be before the subsequent functions however, I can move
it at the end.

> > +void __init acpi_viot_init(void)
> > +{
> > +       int i;
> > +       acpi_status status;
> > +       struct acpi_table_header *hdr;
> > +       struct acpi_viot_header *node;
> > +
> > +       status = acpi_get_table(ACPI_SIG_VIOT, 0, &hdr);
> > +       if (ACPI_FAILURE(status)) {
> > +               if (status != AE_NOT_FOUND) {
> > +                       const char *msg = acpi_format_exception(status);
> > +
> > +                       pr_err("Failed to get table, %s\n", msg);
> > +               }
> > +               return;
> > +       }
> > +
> > +       viot = (void *)hdr;
> > +
> > +       node = ACPI_ADD_PTR(struct acpi_viot_header, viot, viot->node_offset);
> > +       for (i = 0; i < viot->node_count; i++) {
> > +               if (viot_parse_node(node))
> > +                       return;
> > +
> > +               node = ACPI_ADD_PTR(struct acpi_viot_header, node,
> > +                                   node->length);
> > +       }
> 
> Do you still need the table after the above is complete?  If not,
> release the reference on it acquired above.

We don't need the table anymore, I'll drop the reference

Thanks,
Jean

