Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 514213AC525
	for <lists+linux-acpi@lfdr.de>; Fri, 18 Jun 2021 09:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbhFRHqR (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 18 Jun 2021 03:46:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbhFRHqR (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 18 Jun 2021 03:46:17 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AD01C061574
        for <linux-acpi@vger.kernel.org>; Fri, 18 Jun 2021 00:44:08 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id n20so7326334edv.8
        for <linux-acpi@vger.kernel.org>; Fri, 18 Jun 2021 00:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xrVDbV297cRNejKsonngV4vGhbIFMI93Q9VE4px56sk=;
        b=DJrFso3Sd/PK31zGllWY1zpb+A/KUBtA1E8u5Qir0hsdifTQYSdRZW1U6CNektQcl7
         8Gwsv7C1odv1jrBJeUaUkxlcjlp8X1pKeC2J+1DP3IUSv0CsFCITaq8JZc3WjTws7uPQ
         4IxWmREr3j6FYQj+LSiYl4jQTvWE68g/xCWzMfT0kpokkoIFlm0HlOIaovz3NUm3XRbN
         wE7uyBGbqLDvxaWPAzFanMx77+YZjL556iOB0wbtNEUUYyaZWtg3ae9HJjDoNyKVy1IK
         fvCBuKgdbz3tUsMUMs1z8Q2cwdxKNYtxY/sI/BfDgxkDL/babYZa0vN5UhC3RLA+ilVb
         2Qtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xrVDbV297cRNejKsonngV4vGhbIFMI93Q9VE4px56sk=;
        b=tPHNSfjzq9eCsZmaN/vxQzevE1qBzAyDJ5Y3/dpMVhjFfhfZU0BvVqBtb7zLhrS9na
         MhshgV0uKKMBNkeuR3nBOJavXPUITd52xV45mogdnj9QfICIRqm1NRUL48+E993PFOy8
         J9vc07FADTZthrfEdiYGrV3yZ6KPoTXGtyEgzn9hSJnaFroGVWvJXb/14AzRjH6lloBw
         IelllvgyFpSzbpJsWwWRkR+KizW87ayIlTA5epb9OBzUCsm5fIjhkF+sXDG/gf8hQT9C
         xvtoNf98kYLPmWs+aiG9RDxs73eJc3tTFlCzb7sW0o2nvJEhU22EkHWmR4gJtdlVph/7
         riwg==
X-Gm-Message-State: AOAM531Sa+YDuBv+j9R63G8UkPKJ9AdmOy6njdZ4KuPxrePWjneckFGX
        +geNuQm7qQpjrAK1gPiQRXrOMQ==
X-Google-Smtp-Source: ABdhPJzREIN0+D0Q7W8RSrNNQ4NDgbr/Euk9okd86tzehslscukuMpktyxR1ml4l0LZerVVX4xGYvQ==
X-Received: by 2002:a05:6402:17d3:: with SMTP id s19mr1921993edy.222.1624002246807;
        Fri, 18 Jun 2021 00:44:06 -0700 (PDT)
Received: from myrica (adsl-84-226-111-173.adslplus.ch. [84.226.111.173])
        by smtp.gmail.com with ESMTPSA id cf26sm680470ejb.38.2021.06.18.00.44.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 00:44:06 -0700 (PDT)
Date:   Fri, 18 Jun 2021 09:43:47 +0200
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Eric Auger <eric.auger@redhat.com>
Cc:     rjw@rjwysocki.net, lenb@kernel.org, joro@8bytes.org,
        mst@redhat.com, will@kernel.org, catalin.marinas@arm.com,
        baolu.lu@linux.intel.com, dwmw2@infradead.org,
        linux-acpi@vger.kernel.org, iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, sebastien.boeuf@intel.com,
        robin.murphy@arm.com, kevin.tian@intel.com,
        lorenzo.pieralisi@arm.com, guohanjun@huawei.com,
        sudeep.holla@arm.com
Subject: Re: [PATCH v4 3/6] ACPI: Add driver for the VIOT table
Message-ID: <YMxOs8MV+nlCKq7j@myrica>
References: <20210610075130.67517-1-jean-philippe@linaro.org>
 <20210610075130.67517-4-jean-philippe@linaro.org>
 <5a16c21f-ca02-1016-80e9-c374a6fe2b25@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a16c21f-ca02-1016-80e9-c374a6fe2b25@redhat.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Jun 16, 2021 at 03:26:08PM +0200, Eric Auger wrote:
> > +	default:
> > +		pr_warn("Unsupported node %x\n", hdr->type);
> > +		ret = 0;
> > +		goto err_free;
> > +	}
> > +
> > +	/*
> > +	 * To be compatible with future versions of the table which may include
> > +	 * other node types, keep parsing.
> > +	 */
> nit: doesn't this comment rather apply to the default clause in the
> switch.

Yes, the comment doesn't accurately explain the code below, I'll tweak it.

        /*
         * A future version of the table may use the node for other purposes.
         * Keep parsing.
         */

> In case the PCI range node or the single MMIO endoint node does
> not refer to any translation element, isn't it simply an error case?

It is permissible in my opinion. If a future version of the spec appends
new fields to the MMIO endpoint describing some PV property (I can't think
of a useful example), then the table can contain the vIOMMU topology as
usual plus one MMIO node that's only here to describe that property, and
doesn't have a translation element. If we encounter that I think we should
keep parsing.

> > +	if (!ep->viommu) {
> > +		pr_warn("No IOMMU node found\n");
> > +		ret = 0;
> > +		goto err_free;
> > +	}

> Besides
> Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks!
Jean
