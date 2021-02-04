Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9066E30B2B9
	for <lists+linux-acpi@lfdr.de>; Mon,  1 Feb 2021 23:24:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbhBAWYc (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 1 Feb 2021 17:24:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbhBAWYa (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 1 Feb 2021 17:24:30 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCDBDC061756
        for <linux-acpi@vger.kernel.org>; Mon,  1 Feb 2021 14:23:49 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id d2so537787pjs.4
        for <linux-acpi@vger.kernel.org>; Mon, 01 Feb 2021 14:23:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=bFIvq1iUBnF2uNTg/XXudUmq/LzMkpvkSS7sgQp5FVU=;
        b=DGUMvsvgtCsyOu5/4Ulasc7oslinB5t/JcszBUeqsrg01SmgO7CuSlAkMTB+IVPDpp
         +IMl/nxtXmJKqcIhqAuXke2BJIs0HW5Yg58xHGDP76qtLt4qwzAY1MRtIQHLT1+Aq5NR
         CV3XEEpjX5pMeXelmer6a1LbnGUxAaQdbTRN0p4wkVDvcm62X3B3VBkeA9U/4fwuiMI4
         VXaJfjxQ0BUKSnQtejvqxOoV9J4EW5uG68o0W83kyDWnPe+dkNwgDX3kT9keZzcbAhPE
         TCIa13u2rHfK9e7QIsiEcep21m4J6m3rmoOHu1cjS9eRcMsh2adEd+ryF6V+ydIlwEGA
         UV9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=bFIvq1iUBnF2uNTg/XXudUmq/LzMkpvkSS7sgQp5FVU=;
        b=rcQ0zm07keeLdwPiObFsW+bmgtn3jU300auDQwdQ/c0pozOAUK15whgGBKppWD9sRA
         WMPFrTo2LkvUdA+ADEQ7GW+rE2fQJEBvFP1imtLOTaXg75tMWy09ZkBBg1e03PpV5NHm
         QSmcUZe8LPjZhtS0YzKn/yaWzT795NUeS2yuNuwkI9Czs5AJWf3N2jXtjYfLaCfTNh0t
         8dD458VANwj5pFq0qz5GAytH4K1cQIyurKkBnnhFnzJKmm4vTrJ2IJTlh7k6W07OV20L
         OzcSGBMTsK4IBOcsLo66f+PWZ+4ST3i+AM2923GLJNIAQQqLreTjDdtR3EfgNx5i+saw
         hhpg==
X-Gm-Message-State: AOAM530ojv+YmmFBT4gGI0sKL/gNj08250npUveUUR0Ted/kUbwCpAjf
        euWwG7OVdP1cH+7SYixLm6lGdA==
X-Google-Smtp-Source: ABdhPJwMLSpGX0o+h2MFNvOFlmVc1GTAxnAxHJh9h3T5rMGwIj0rIL8nzRGWRD9t80SVGsT5UUpL2w==
X-Received: by 2002:a17:902:bf44:b029:df:f0eb:cb33 with SMTP id u4-20020a170902bf44b02900dff0ebcb33mr19537849pls.13.1612218229062;
        Mon, 01 Feb 2021 14:23:49 -0800 (PST)
Received: from [2620:15c:17:3:4a0f:cfff:fe51:6667] ([2620:15c:17:3:4a0f:cfff:fe51:6667])
        by smtp.gmail.com with ESMTPSA id 123sm19531753pfd.91.2021.02.01.14.23.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 14:23:48 -0800 (PST)
Date:   Mon, 1 Feb 2021 14:23:47 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
To:     Ben Widawsky <ben.widawsky@intel.com>
cc:     linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        Chris Browy <cbrowy@avery-design.com>,
        Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jon Masters <jcm@jonmasters.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        daniel.lll@alibaba-inc.com,
        "John Groves (jgroves)" <jgroves@micron.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>
Subject: Re: [PATCH 03/14] cxl/mem: Find device capabilities
In-Reply-To: <20210201215857.ud5cpg7hbxj2j5bx@intel.com>
Message-ID: <b46ed01-3f1-6643-d371-7764c3bde4f8@google.com>
References: <20210130002438.1872527-1-ben.widawsky@intel.com> <20210130002438.1872527-4-ben.widawsky@intel.com> <234711bf-c03f-9aca-e0b5-ca677add3ea@google.com> <20210201165352.wi7tzpnd4ymxlms4@intel.com> <32f33dd-97a-8b1c-d488-e5198a3d7748@google.com>
 <20210201215857.ud5cpg7hbxj2j5bx@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, 1 Feb 2021, Ben Widawsky wrote:

> > > > > +static int cxl_mem_setup_mailbox(struct cxl_mem *cxlm)
> > > > > +{
> > > > > +	const int cap = cxl_read_mbox_reg32(cxlm, CXLDEV_MB_CAPS_OFFSET);
> > > > > +
> > > > > +	cxlm->mbox.payload_size =
> > > > > +		1 << CXL_GET_FIELD(cap, CXLDEV_MB_CAP_PAYLOAD_SIZE);
> > > > > +
> > > > > +	/* 8.2.8.4.3 */
> > > > > +	if (cxlm->mbox.payload_size < 256) {
> > > > > +		dev_err(&cxlm->pdev->dev, "Mailbox is too small (%zub)",
> > > > > +			cxlm->mbox.payload_size);
> > > > > +		return -ENXIO;
> > > > > +	}
> > > > 
> > > > Any reason not to check cxlm->mbox.payload_size > (1 << 20) as well and 
> > > > return ENXIO if true?
> > > 
> > > If some crazy vendor wanted to ship a mailbox larger than 1M, why should the
> > > driver not allow it?
> > > 
> > 
> > Because the spec disallows it :)
> 
> I don't see it being the driver's responsibility to enforce spec correctness
> though. In certain cases, I need to use the spec, like I have to pick /some/
> mailbox timeout. For other cases... 
> 
> I'm not too familiar with what other similar drivers may or may not do in
> situations like this. The current 256 limit is mostly a reflection of that being
> too small to even support advertised mandatory commands. So things can't work in
> that scenario, but things can work if they have a larger register size (so long
> as the BAR advertises enough space).
> 

I don't think things can work above 1MB, either, though.  Section 
8.2.8.4.5 specifies 20 bits to define the payload length, if this is 
larger than cxlm->mbox.payload_size it would venture into the reserved 
bits of the command register.

So is the idea to allow cxl_mem_setup_mailbox() to succeed with a payload 
size > 1MB and then only check 20 bits for the command register?
