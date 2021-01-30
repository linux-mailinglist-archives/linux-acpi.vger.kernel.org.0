Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA7E30990F
	for <lists+linux-acpi@lfdr.de>; Sun, 31 Jan 2021 00:56:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232592AbhA3X4W (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 30 Jan 2021 18:56:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232683AbhA3XxJ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 30 Jan 2021 18:53:09 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BADB5C06178A
        for <linux-acpi@vger.kernel.org>; Sat, 30 Jan 2021 15:51:51 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id my11so7948764pjb.1
        for <linux-acpi@vger.kernel.org>; Sat, 30 Jan 2021 15:51:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=/7bS81IVu1JlzOqn6sxVl7PF7QPT/qamlj9psA4nrKw=;
        b=KakMFpmDEnIJAfIkwgFElM2OuCuzZHKBG8btmmU1ofJKTS7yI0zo08pqWacZX46IFI
         8fHWvBqPYFSupOKNtk43JJoG/x0xDILY1ny7YHyzKcQI/6v2eq+1+2sACm7zDjm9calq
         rah5jhD/eOqyjJnmkmMSpcrIa4Z4fOuHgRuowyV0XL+mnCr1BmkOz7ivyntQVH2EneOx
         iLG09O3UCbp8bUAmiA7k7GMVemtVjmTBSyL1T7IkifZ+NF1tJQKusqD8Mpl9Ru7GJRTO
         kL4WwHN7MMbiJL5NcAZkYBPC8h4+0dg3MVcVYtNOrdGtaqM3E3ELgyet8WY0yHGgx+NL
         TDeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=/7bS81IVu1JlzOqn6sxVl7PF7QPT/qamlj9psA4nrKw=;
        b=L3vvVqz/syL35i9qaDqr5yoPrPOaPADhzQpnnlmOOq4XTwYwTNMAqFhapKBUXDkdWs
         5lI3xoxsF2W1zi/u9IG++6XvQaqKGbQ9bDas69BnvpBgXKA9hw9c1XvvEWVEyi9eAXfg
         /BMKq9bSRU6PFcb+heVOv5RbBDzCT0nhZs6hYnsKVquBbm81hQ4l0wLhm/33o3FhCsjc
         uvz4sAWhPzfcXsmaAVcq6GAsvuD2qFXShTjU5iRtDCQ1aPgh2OEAz7U1clhw1b48mP13
         e6HWhwJ6gogYkcC7t0gDgDLpPOSS7G0kNbhCLv2KKT/Xr/ZT5SBhY22Noog6drg8/AMs
         LFIQ==
X-Gm-Message-State: AOAM532rVNzsl6R2lBgJm9nNfSBqJju5b4nhckhUeyy2lDbnI1cx8G9H
        YfrV5wlfHJFrYtW9MeW1DZ+pVQ==
X-Google-Smtp-Source: ABdhPJyWfU3F6QFSqgDGRamotw78d6vqTVIqlXrDVhMybwvQ7IKMWFaK63q32G3vVTVfyW5mjbPKKg==
X-Received: by 2002:a17:902:9b90:b029:e0:6c0:df4f with SMTP id y16-20020a1709029b90b02900e006c0df4fmr11725622plp.60.1612050711168;
        Sat, 30 Jan 2021 15:51:51 -0800 (PST)
Received: from [2620:15c:17:3:4a0f:cfff:fe51:6667] ([2620:15c:17:3:4a0f:cfff:fe51:6667])
        by smtp.gmail.com with ESMTPSA id b62sm13308050pfg.58.2021.01.30.15.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Jan 2021 15:51:50 -0800 (PST)
Date:   Sat, 30 Jan 2021 15:51:49 -0800 (PST)
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
In-Reply-To: <20210130002438.1872527-4-ben.widawsky@intel.com>
Message-ID: <234711bf-c03f-9aca-e0b5-ca677add3ea@google.com>
References: <20210130002438.1872527-1-ben.widawsky@intel.com> <20210130002438.1872527-4-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, 29 Jan 2021, Ben Widawsky wrote:

> +static int cxl_mem_setup_mailbox(struct cxl_mem *cxlm)
> +{
> +	const int cap = cxl_read_mbox_reg32(cxlm, CXLDEV_MB_CAPS_OFFSET);
> +
> +	cxlm->mbox.payload_size =
> +		1 << CXL_GET_FIELD(cap, CXLDEV_MB_CAP_PAYLOAD_SIZE);
> +
> +	/* 8.2.8.4.3 */
> +	if (cxlm->mbox.payload_size < 256) {
> +		dev_err(&cxlm->pdev->dev, "Mailbox is too small (%zub)",
> +			cxlm->mbox.payload_size);
> +		return -ENXIO;
> +	}

Any reason not to check cxlm->mbox.payload_size > (1 << 20) as well and 
return ENXIO if true?
