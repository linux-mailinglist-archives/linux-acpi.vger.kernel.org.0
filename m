Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F8BCE4633
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Oct 2019 10:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393226AbfJYIvM (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 25 Oct 2019 04:51:12 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:32979 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393220AbfJYIvL (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 25 Oct 2019 04:51:11 -0400
Received: by mail-pf1-f194.google.com with SMTP id c184so1153712pfb.0
        for <linux-acpi@vger.kernel.org>; Fri, 25 Oct 2019 01:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0/2VGkxr+8G2DyN6AJ/qLkLy04gYTYqPnldxPju3Eyw=;
        b=UVrIPxrmpp4VIZvk5WQ3zEojF1Nv5OrM82Bxh1oh1Juu+H3ml16eMP5Fkr3ujqqWSL
         OiYb8ePePhOA/WyBQZW0MFFKkCzIkJ5ECKwzy8jaZ8/h+qMgF96BBdAfk6SbgZ6ysv2C
         V8SHKeSMXIDysvkEhofsoAjnmJ5dAKx3nQBGEhJy9FC9KYpCdxLsTjfR6P4um6nENeFD
         q0GuG47iOsQygO+UK41XXAVU+BmPWqXHQrhTGEdXwgDmscbnQf9Rywep48+rp6xSR62+
         IQ6ys5P11PUWnXlkC9enWFIEq5T81PVJ2cJfqiAkojuxgYlInsNywEEolj28MhuozE9p
         5PNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0/2VGkxr+8G2DyN6AJ/qLkLy04gYTYqPnldxPju3Eyw=;
        b=TpiQe0drginX1O3mbZDwkTmZSWMaQ5IpWuKsAYJLmdJkN0GrApjdKowK9k6hrDicoN
         GAub/lFbF3ZeMuXPU75v/rSCeWMGH+cKYSXiUDjJCVYGfd3ywMWhXaj5wFgW0KhpBfak
         mvShsaMojK4ciCrcmVIGv7LVJ0BGwRBMb2bqq3PTchrliu6chImuOvxTUnuYnqWns89k
         HXGIkNgbttDnBCkGDbR7mpvfATFq/GertV8aG5PxM/iIHJDyIYVpaq2HR2LTaLYWb+vP
         EWbcEVCscc0I61oSvc6cKeGXVS9jdCOsG0tO7dXlKxNaSC8WhGJ1+xaMdV8nL+KVRmcs
         2ObQ==
X-Gm-Message-State: APjAAAVacqIAfNJ2eFYnu6RsKcGfV/Qd9ETOfqKJenFdhyeoqJRp6J3Y
        +M7liqHmkUtFA8sf8w+IbZn2AEFle6Y=
X-Google-Smtp-Source: APXvYqwxOHGXj8cHC1BmkVSzOGi41l+QUtZzdNXr1vXgmobz7H2B0Zk35TQCMDgNLzUjhC5v9pUs7A==
X-Received: by 2002:a65:67d9:: with SMTP id b25mr2950459pgs.88.1571993471031;
        Fri, 25 Oct 2019 01:51:11 -0700 (PDT)
Received: from localhost ([122.172.151.112])
        by smtp.gmail.com with ESMTPSA id w2sm1523806pgr.78.2019.10.25.01.51.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Oct 2019 01:51:10 -0700 (PDT)
Date:   Fri, 25 Oct 2019 14:21:07 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ACPI: processor: Add QoS requests for all CPUs
Message-ID: <20191025085107.vp2fhvwi6zhnjkvh@vireshk-i7>
References: <2435090.1mJ0fSsrDY@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2435090.1mJ0fSsrDY@kreacher>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 25-10-19, 02:41, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The _PPC change notifications from the platform firmware are per-CPU,
> so acpi_processor_ppc_init() needs to add a frequency QoS request
> for each CPU covered by a cpufreq policy to take all of them into
> account.
> 
> Even though ACPI thermal control of CPUs sets frequency limits
> per processor package, it also needs a frequency QoS request for each
> CPU in a cpufreq policy in case some of them are taken offline and
> the frequency limit needs to be set through the remaining online
> ones (this is slightly excessive, because all CPUs covered by one
> cpufreq policy will set the same frequency limit through their QoS
> requests, but it is not incorrect).
> 
> Modify the code in accordance with the above observations.
> 
> Fixes: d15ce412737a ("ACPI: cpufreq: Switch to QoS requests instead of cpufreq notifier")
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/acpi/processor_perflib.c |   38 +++++++++++++++++++++++---------------
>  drivers/acpi/processor_thermal.c |   38 +++++++++++++++++++++++---------------
>  2 files changed, 46 insertions(+), 30 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
