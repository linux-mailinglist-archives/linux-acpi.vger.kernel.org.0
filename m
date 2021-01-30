Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A59163098FE
	for <lists+linux-acpi@lfdr.de>; Sun, 31 Jan 2021 00:53:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232589AbhA3Xw5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 30 Jan 2021 18:52:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232636AbhA3XwV (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 30 Jan 2021 18:52:21 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3297C061756
        for <linux-acpi@vger.kernel.org>; Sat, 30 Jan 2021 15:51:41 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id d2so2771676pjs.4
        for <linux-acpi@vger.kernel.org>; Sat, 30 Jan 2021 15:51:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=cxvqbAo1IAIrwLB5kk+h8Luaw/WcNq7od57uwR/z/0A=;
        b=PjLjww8QTw6X6rVMAjtISyXtX7JMmqVaUJx3F60RM3ylFSLWRRcZCFrQlsjCSBGBqx
         Oj3eIeIel+lx5s/2LzA2cqzsOlBvs+jrSV4AXQBePenX9TqRNh4fBF2xa1vy/ZURdeOn
         +lhC0/eWjRwZcBS/1uE7a0/fxUpCmQEsIlkvVUw8XTrYgT7HEkD84ilH2PhECtGuizOl
         3L/Qf/himoTN1JGUyeYCivImS0tAyPYb9OeJvkMbXST578xzSCdUkQFxivOMQrwZRtAE
         nxCiaSxwoehw8rIP5fQZOuvdxKVzXZHozdLwXh4cjAQrPf6k9Zf1rWPHmWo72HtJywGU
         U2Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=cxvqbAo1IAIrwLB5kk+h8Luaw/WcNq7od57uwR/z/0A=;
        b=csEjpbqry00cEK5AhVvH3uw+1Q0rDyTNlDew9Imt5mhEQcqVg/8PBx1uRNeofRoOU7
         W/DBhokhERoNSm4xyF7g7Dje9nJl3jh7KmIBldY/9zNNp/CDKJ6Q6os2ZoJfjvfZ1n9e
         Xo44Z7Fr5+7gyIxSX6lnBxkhDsGmT9Q+cEcNHF5ldYnIe0dgveDnDgEOG2uHf57zfSuC
         q+5W4wOjPkH0esoH6Y4n90At0jkKhVwkqrIYjtkBFS20yKnqkRz63nqP2nRS21HKf3Lp
         XUXgOoQwXMfIuop8QCaoqzQO+KVGIEuGXeDOvOz+476Fli2KgKf4CS/PWhkT1851PmBi
         wuGw==
X-Gm-Message-State: AOAM531UKBoU9y1oqIwaZ46a8Ytd19OLqwCzKdQA+uH4zMVM/7qTEVnn
        s9ihLicN/EKxZUKYOpF8GhZ/wQ==
X-Google-Smtp-Source: ABdhPJyDODycXpp/h5ITu3myrcAhtELZTjRYPPBKofKsdhKWkycX4cAiMkSboMfRs6hOUzcld1n8Cw==
X-Received: by 2002:a17:902:edcd:b029:df:d2b1:ecf0 with SMTP id q13-20020a170902edcdb02900dfd2b1ecf0mr11639635plk.15.1612050701068;
        Sat, 30 Jan 2021 15:51:41 -0800 (PST)
Received: from [2620:15c:17:3:4a0f:cfff:fe51:6667] ([2620:15c:17:3:4a0f:cfff:fe51:6667])
        by smtp.gmail.com with ESMTPSA id c5sm12745797pfi.5.2021.01.30.15.51.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Jan 2021 15:51:40 -0800 (PST)
Date:   Sat, 30 Jan 2021 15:51:39 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
To:     Ben Widawsky <ben.widawsky@intel.com>
cc:     linux-cxl@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
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
Subject: Re: [PATCH 01/14] cxl/mem: Introduce a driver for CXL-2.0-Type-3
 endpoints
In-Reply-To: <20210130002438.1872527-2-ben.widawsky@intel.com>
Message-ID: <54655f17-2e4a-cc1e-262c-b365e3de9b20@google.com>
References: <20210130002438.1872527-1-ben.widawsky@intel.com> <20210130002438.1872527-2-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, 29 Jan 2021, Ben Widawsky wrote:

> diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> new file mode 100644
> index 000000000000..3b66b46af8a0
> --- /dev/null
> +++ b/drivers/cxl/Kconfig
> @@ -0,0 +1,35 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +menuconfig CXL_BUS
> +	tristate "CXL (Compute Express Link) Devices Support"
> +	depends on PCI
> +	help
> +	  CXL is a bus that is electrically compatible with PCI Express, but
> +	  layers three protocols on that signalling (CXL.io, CXL.cache, and
> +	  CXL.mem). The CXL.cache protocol allows devices to hold cachelines
> +	  locally, the CXL.mem protocol allows devices to be fully coherent
> +	  memory targets, the CXL.io protocol is equivalent to PCI Express.
> +	  Say 'y' to enable support for the configuration and management of
> +	  devices supporting these protocols.
> +
> +if CXL_BUS
> +
> +config CXL_MEM
> +	tristate "CXL.mem: Endpoint Support"

Nit: "CXL.mem: Memory Devices" or "CXL Memory Devices: CXL.mem" might look 
better, but feel free to ignore.

Acked-by: David Rientjes <rientjes@google.com>
