Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D21EA309904
	for <lists+linux-acpi@lfdr.de>; Sun, 31 Jan 2021 00:54:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232619AbhA3XyP (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 30 Jan 2021 18:54:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232777AbhA3XyB (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 30 Jan 2021 18:54:01 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D71B9C061351
        for <linux-acpi@vger.kernel.org>; Sat, 30 Jan 2021 15:52:03 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id w18so9038081pfu.9
        for <linux-acpi@vger.kernel.org>; Sat, 30 Jan 2021 15:52:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=Ui0BeJCwGOKq8ej5x7M1Q9u0lMO3l7TRN0DCBw5DBWc=;
        b=MzV7DeqSQEU06RPg78K/siciEFk1jfbTpumwWmLQl6H6Gtps4XMqo2d69/O5cLG2ib
         sWHVna8f+tRiTekQ27iMrabwakv/X6Gbl2kRVK/U/BGlRXp3T9i1yQQSuVnU6lr+dm/x
         8FEPu29yNnBux/VASHH7ScQ+Jl0IiYohkU6+RCuQUg1EgQPqAcab+9vyY4J5yCbNcTRR
         nr53UK6NJNWZfhq5VD+V3Le0HG/nMeKhW74bPHwhTL5zw+kABM4AX6dL+VwufuqFX1nq
         tUL0JTNvh8Ct349k+VfR9Xo8+biP3GeU+ESkvAHVcmQEBivIFsiEhTmpY/WaIHhwMGhe
         hhVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=Ui0BeJCwGOKq8ej5x7M1Q9u0lMO3l7TRN0DCBw5DBWc=;
        b=O1Mz4wTQ5CBG1VPWrZlwc+Zi9WuOJ9pC3F2BwlI4jBk2W49jsy6IR5IS4sMioqrikt
         TrSzV0/3h5bUO0COEaU42Ciw6ss+37hx2tni4GBvRqvY41nFmVSPpk79QS/3y0XcGOYF
         H/EIkIC8U6bjyBMT6JYXuL1LJey8928A0j154m/vWjXGO4aIsyDCwNzJnaQ15Pei828Q
         mCJjzY2JxYBcjV8bVGOy0o0PMuYKuTD9p881rKtVEmpPlMrdDRo0T/H0jiXRpwH6zQ+M
         zRnebJjuq8E0bJWrCUKzfKqrfh3guiTRh3eArVE8FBPXVukh9iUKA4Ou4+dAEXG2uWfB
         Vuaw==
X-Gm-Message-State: AOAM5302VRpJOXCA38KRzC46j4aEIrYvLyyLu44dl3VCm8qY9FgJjmMd
        W65vJtzGvRfdmApEl74gkQwTb3HNiZMr6g==
X-Google-Smtp-Source: ABdhPJwhLUNT7kvzAUWFbzT9Lc1dFYnkmDtxMuvH7NNwX3Q8WOwnNGrRfaRhmDarU4sLoHVBNmVU6w==
X-Received: by 2002:a63:7947:: with SMTP id u68mr3474320pgc.451.1612050723241;
        Sat, 30 Jan 2021 15:52:03 -0800 (PST)
Received: from [2620:15c:17:3:4a0f:cfff:fe51:6667] ([2620:15c:17:3:4a0f:cfff:fe51:6667])
        by smtp.gmail.com with ESMTPSA id e12sm13104562pga.13.2021.01.30.15.52.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Jan 2021 15:52:02 -0800 (PST)
Date:   Sat, 30 Jan 2021 15:52:01 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
To:     Ben Widawsky <ben.widawsky@intel.com>
cc:     linux-cxl@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-pci@vger.kernel.org,
        Bjorn Helgaas <helgaas@kernel.org>,
        Chris Browy <cbrowy@avery-design.com>,
        Christoph Hellwig <hch@infradead.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Jon Masters <jcm@jonmasters.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        daniel.lll@alibaba-inc.com,
        "John Groves (jgroves)" <jgroves@micron.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>
Subject: Re: [PATCH 05/14] cxl/mem: Register CXL memX devices
In-Reply-To: <20210130002438.1872527-6-ben.widawsky@intel.com>
Message-ID: <ecd93422-b272-2b76-1ec-cf6af744ae@google.com>
References: <20210130002438.1872527-1-ben.widawsky@intel.com> <20210130002438.1872527-6-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, 29 Jan 2021, Ben Widawsky wrote:

> diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> new file mode 100644
> index 000000000000..fe7b87eba988
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> @@ -0,0 +1,26 @@
> +What:		/sys/bus/cxl/devices/memX/firmware_version
> +Date:		December, 2020
> +KernelVersion:	v5.12
> +Contact:	linux-cxl@vger.kernel.org
> +Description:
> +		(RO) "FW Revision" string as reported by the Identify
> +		Memory Device Output Payload in the CXL-2.0
> +		specification.
> +
> +What:		/sys/bus/cxl/devices/memX/ram/size
> +Date:		December, 2020
> +KernelVersion:	v5.12
> +Contact:	linux-cxl@vger.kernel.org
> +Description:
> +		(RO) "Volatile Only Capacity" as reported by the
> +		Identify Memory Device Output Payload in the CXL-2.0
> +		specification.
> +
> +What:		/sys/bus/cxl/devices/memX/pmem/size
> +Date:		December, 2020
> +KernelVersion:	v5.12
> +Contact:	linux-cxl@vger.kernel.org
> +Description:
> +		(RO) "Persistent Only Capacity" as reported by the
> +		Identify Memory Device Output Payload in the CXL-2.0
> +		specification.

Aren't volatile and persistent capacities expressed in multiples of 256MB?
