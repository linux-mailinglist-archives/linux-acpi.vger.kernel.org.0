Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0F03315975
	for <lists+linux-acpi@lfdr.de>; Tue,  9 Feb 2021 23:32:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234013AbhBIW3P (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 9 Feb 2021 17:29:15 -0500
Received: from mail-yb1-f181.google.com ([209.85.219.181]:44812 "EHLO
        mail-yb1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234096AbhBIWOD (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 9 Feb 2021 17:14:03 -0500
Received: by mail-yb1-f181.google.com with SMTP id r2so19723786ybk.11;
        Tue, 09 Feb 2021 14:13:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VE2EhdIByMacgmRTG1LkrJDJV8t/c6l+WLOiRcExhRk=;
        b=P8wXqjrDeDo/u+ocFH/ssSayb70LQqtWWOspBYXQcaYmbmToZopaTHf8UltF/wEHPx
         DL2lNeFGqzjMc+Gqz2VF/aSqGSUHF7Wqk0Nr0nI9li6PWLZQmI0DSmtYsjrP5gAHcUxt
         cLC4CZbFd8Gatcp+hLpjoCEuRAJP9hK/FjhbCqD+oYWvE8eKcXvK1epCISkmazqDSjNO
         wUv5dwqLgQvN8u9hrpIBFb5tPYyDAl0gOm+gz/V9JlI4pObgG8jR3Z/hqnFNBe3Z3hTd
         10pnw5HwixOYTBw8JzPOKD7ANXbB5vXdeKPo2kAhYWxAIS1oN8zNIJB1NyU/2eWveUXk
         doUg==
X-Gm-Message-State: AOAM533ZyantgnKemp3v8sxPgizl4fdrveWTuoBCxsdga4CNEHXGCrkO
        BjSYpLKiwpgjEYS2VGJsNcVgwD3T5A==
X-Google-Smtp-Source: ABdhPJwOKR7aLyRiaGSdsTsdDouEbfAmDLNj7QHCR08u3CsoA27ruITo6RAAWtqCOIVCqMufvZQOmg==
X-Received: by 2002:a9d:32f4:: with SMTP id u107mr11203135otb.308.1612905924777;
        Tue, 09 Feb 2021 13:25:24 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id c2sm4302590ooo.17.2021.02.09.13.25.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 13:25:23 -0800 (PST)
Received: (nullmailer pid 218136 invoked by uid 1000);
        Tue, 09 Feb 2021 21:25:21 -0000
Date:   Tue, 9 Feb 2021 15:25:21 -0600
From:   Rob Herring <robh@kernel.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     linux-clk@vger.kernel.org, Kevin Hilman <khilman@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-acpi@vger.kernel.org,
        devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>, kernel-team@android.com,
        Michael Turquette <mturquette@baylibre.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-doc@vger.kernel.org,
        Len Brown <lenb@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Pavel Machek <pavel@ucw.cz>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-kernel@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
        linux-pm@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Len Brown <len.brown@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH v4 2/8] of: property: Don't add links to absent suppliers
Message-ID: <20210209212521.GA218083@robh.at.kernel.org>
References: <20210205222644.2357303-1-saravanak@google.com>
 <20210205222644.2357303-3-saravanak@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210205222644.2357303-3-saravanak@google.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, 05 Feb 2021 14:26:38 -0800, Saravana Kannan wrote:
> If driver core marks a firmware node as not a device, don't add fwnode
> links where it's a supplier.
> 
> Fixes: e590474768f1 ("driver core: Set fw_devlink=on by default")
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
>  drivers/of/property.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
