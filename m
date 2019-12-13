Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1ECC11DB9E
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Dec 2019 02:24:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731620AbfLMBYR (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 12 Dec 2019 20:24:17 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42022 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731288AbfLMBYR (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 12 Dec 2019 20:24:17 -0500
Received: by mail-pf1-f193.google.com with SMTP id 4so526236pfz.9;
        Thu, 12 Dec 2019 17:24:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mVYnNLUWDZKpYLFTHOhdx5QMfZ/iaJU8SyrTIrnh1+U=;
        b=C9vmM3wb6Ku+BwbrsiOw8sJcOapH9ak4S6OvvOJfkUVaVtflB03QO2A3IdCTuIPlw1
         S0ecyAtDw8qd3a05aw/rdmjBr/xOrkoWb3NnVvNTm39DWW8P2ePVHV0BXKQlg6UNGRfi
         L4f26CTJ71IIL8zgTDQNb9viGP8uNnLVRvIzmp0qqCS3J1HdUzIbZpXJsTsRAzcnmaDJ
         gf5XOfBCm2jYtQryLN+pWkD/gTVVJztPbNTnmtbrTyFf//kGwyMRWcckgugnnxlXdu7I
         tWoXUcQbMSdEng1Tda8UbAfvrXu5sAacDHgOHc3pq20si1CQFu8f1mIS3gKbwGyXw/zK
         5YBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mVYnNLUWDZKpYLFTHOhdx5QMfZ/iaJU8SyrTIrnh1+U=;
        b=PuXgIgYik+HTvvbw8ohhzAxLB+NJq5R+BqI3g6GEU6q/2ZteagsOFWhAXyCttPMzzD
         pUnjeLeYKJj96aGF66nVFZM3YRCWkxX0k7T3xye8B9ZbSCWV21mk7XH9wxz17WuuBNNQ
         9h/vzbAuFqCJbnyXT6xCu/1Dc2EIwR7MzdNI3Nu6UcE+UfAPQmgRFR3e+UvltVksXKcW
         gwzdadHLt3144KqRjHBHs+2JEV/G1f0WoqCA97GKMCxvHJ5gwZCK/uzrZbKc+6Ikt/U7
         QmfVNUQJNS7KXBsZuBajlMwAeesogaEfuRZrFkAz+KDRy8qWGcebQirkHmaZu0Ow7VIq
         jxCA==
X-Gm-Message-State: APjAAAVEiAicRacZAxlJEAsm5hbhfve0vBAIa632IdaprRIMWNB1I+1a
        Fav5BKoHmcBhgBy7PertG1o=
X-Google-Smtp-Source: APXvYqzslQWCGhhjC4AVQ3m239kr2s7F0YOheuzUQOjc5GF3xeZkaRbeg83aAHQgMnfEAhySOKU1Mg==
X-Received: by 2002:a62:1883:: with SMTP id 125mr12979767pfy.166.1576200255999;
        Thu, 12 Dec 2019 17:24:15 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id c18sm8230295pgj.24.2019.12.12.17.24.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 17:24:14 -0800 (PST)
Date:   Thu, 12 Dec 2019 17:24:08 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        'Linux Samsung SOC' <linux-samsung-soc@vger.kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        Linux USB Mailing List <linux-usb@vger.kernel.org>
Subject: Re: [PATCH v8 1/6] software node: rename is_array to is_inline
Message-ID: <20191213012408.GH101194@dtor-ws>
References: <20191108042225.45391-1-dmitry.torokhov@gmail.com>
 <20191108042225.45391-2-dmitry.torokhov@gmail.com>
 <CGME20191212111237eucas1p1a278d2d5d2437e3219896367e82604cc@eucas1p1.samsung.com>
 <b3f6ca8b-dbdf-0cec-aa8f-47ffcc5c5307@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3f6ca8b-dbdf-0cec-aa8f-47ffcc5c5307@samsung.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Marek,

On Thu, Dec 12, 2019 at 12:12:36PM +0100, Marek Szyprowski wrote:
> Dear All,
> 
> On 08.11.2019 05:22, Dmitry Torokhov wrote:
> > We do not need a special flag to know if we are dealing with an array,
> > as we can get that data from ratio between element length and the data
> > size, however we do need a flag to know whether the data is stored
> > directly inside property_entry or separately.
> >
> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> 
> Today I've noticed that this patch got merged to linux-next as commit 
> e6bff4665c595b5a4aff173848851ed49ac3bfad. Sadly it breaks DWC3/xHCI 
> driver operation on Samsung Exynos5 SoCs (and probably on other SoCs 
> which use DWC3 in host mode too). I get the following errors during boot:
> 
> dwc3 12000000.dwc3: failed to add properties to xHCI
> dwc3 12000000.dwc3: failed to initialize host
> dwc3: probe of 12000000.dwc3 failed with error -61
> 
> Here is a full kernel log from Exynos5250-based Snow Chromebook on KernelCI:
> 
> https://storage.kernelci.org/next/master/next-20191212/arm/exynos_defconfig/gcc-8/lab-collabora/boot-exynos5250-snow.txt
> 
> (lack of 'ref' clk is not related nor fatal to the driver operation).
> 
> The code which fails after this patch is located in 
> drivers/usb/dwc3/host.c. Let me know if I can help more in locating the bug.

Does the following help? If, as I expect, it does, I'll submit it
formally.

---

diff --git a/drivers/usb/dwc3/host.c b/drivers/usb/dwc3/host.c
index 5567ed2cddbec..fa252870c926f 100644
--- a/drivers/usb/dwc3/host.c
+++ b/drivers/usb/dwc3/host.c
@@ -88,10 +88,10 @@ int dwc3_host_init(struct dwc3 *dwc)
 	memset(props, 0, sizeof(struct property_entry) * ARRAY_SIZE(props));
 
 	if (dwc->usb3_lpm_capable)
-		props[prop_idx++].name = "usb3-lpm-capable";
+		props[prop_idx++] = PROPERTY_ENTRY_BOOL("usb3-lpm-capable");
 
 	if (dwc->usb2_lpm_disable)
-		props[prop_idx++].name = "usb2-lpm-disable";
+		props[prop_idx++] = PROPERTY_ENTRY_BOOL("usb2-lpm-disable");
 
 	/**
 	 * WORKAROUND: dwc3 revisions <=3.00a have a limitation
@@ -103,7 +103,7 @@ int dwc3_host_init(struct dwc3 *dwc)
 	 * This following flag tells XHCI to do just that.
 	 */
 	if (dwc->revision <= DWC3_REVISION_300A)
-		props[prop_idx++].name = "quirk-broken-port-ped";
+		props[prop_idx++] = PROPERTY_ENTRY_BOOL("quirk-broken-port-ped");
 
 	if (prop_idx) {
 		ret = platform_device_add_properties(xhci, props);


-- 
Dmitry
