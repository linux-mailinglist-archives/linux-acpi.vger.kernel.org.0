Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 646B231597A
	for <lists+linux-acpi@lfdr.de>; Tue,  9 Feb 2021 23:32:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233500AbhBIWab (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 9 Feb 2021 17:30:31 -0500
Received: from mail-ua1-f42.google.com ([209.85.222.42]:38331 "EHLO
        mail-ua1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233956AbhBIWU1 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 9 Feb 2021 17:20:27 -0500
Received: by mail-ua1-f42.google.com with SMTP id y35so987336uad.5;
        Tue, 09 Feb 2021 14:18:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=chF4AGWod1NaZkKppPWEQ1Io26jYw+8zMgU0N2aN71E=;
        b=Rd/iXNwp/bRwoAvDkfjCUAvVcziQWVONRtksXMfYCcBp/fbMKt03L2b2d6EqxKNgph
         g78S3ST5+36vPwRxpukhyEud/98HB7xiQvXl3Zy81wdYwhuvipLCwIxkxZTyNj+ceanG
         saImCa+6fsFDKt6wq/7NwJOualvXq3No7nD0LbYkgVDuMRkfQpC9iV5o+wMhF3Ur+ct1
         GAtAEYFpN7RKpa45karFIbZbmrDYWICbpgTvNXUfm7wZULl93Zfn0yUndcjol8VCAg58
         +xHisVzJW/JWP9epmdrVkbDXwDWpQIyPbrbp0tYGeIhRvrpUT1d8KEazrniTrFcRJ16+
         XPpw==
X-Gm-Message-State: AOAM5305dyPaOUzMIBhVvEM3TUozW2j41Q5jqGh6ImxfO01wr5nlw0dH
        R/M5LYL0lixXwO7cJHLpH1u5fkkdYw==
X-Google-Smtp-Source: ABdhPJyGu3u5I/yz8BcR5c4Z5Un368IPwJTe9EIJ9SQLRz14qAclf658hUeQwMCs2kjkfjj8BHycEw==
X-Received: by 2002:a9d:21ca:: with SMTP id s68mr17271906otb.164.1612906403390;
        Tue, 09 Feb 2021 13:33:23 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id o83sm418383ooo.37.2021.02.09.13.33.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 13:33:22 -0800 (PST)
Received: (nullmailer pid 232145 invoked by uid 1000);
        Tue, 09 Feb 2021 21:33:20 -0000
Date:   Tue, 9 Feb 2021 15:33:20 -0600
From:   Rob Herring <robh@kernel.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Len Brown <len.brown@intel.com>, Len Brown <lenb@kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-acpi@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        kernel-team@android.com
Subject: Re: [PATCH v4 4/8] of: property: Add fw_devlink support for optional
 properties
Message-ID: <20210209213320.GA219007@robh.at.kernel.org>
References: <20210205222644.2357303-1-saravanak@google.com>
 <20210205222644.2357303-5-saravanak@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210205222644.2357303-5-saravanak@google.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Feb 05, 2021 at 02:26:40PM -0800, Saravana Kannan wrote:
> Not all DT bindings are mandatory bindings. Add support for optional DT
> bindings and mark iommus, iommu-map, dmas as optional DT bindings.

I don't think we can say these are optional or not. It's got to be a 
driver decision somehow.

For example, if IOMMU is optional, what happens with this sequence:

driver probes without IOMMU
driver calls dma_map_?()
IOMMU driver probes
h/w accesses DMA buffer --> BOOM!
