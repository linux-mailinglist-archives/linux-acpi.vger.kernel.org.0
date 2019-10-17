Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D11DBDA974
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Oct 2019 11:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404831AbfJQJ5a (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 17 Oct 2019 05:57:30 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39927 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727873AbfJQJ53 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 17 Oct 2019 05:57:29 -0400
Received: by mail-pl1-f194.google.com with SMTP id s17so879839plp.6
        for <linux-acpi@vger.kernel.org>; Thu, 17 Oct 2019 02:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sLCQZl2uZTgyC0e1AE4wxLx4qwv7+sx5Ge5fKPEc3ow=;
        b=EWUpYjUiykFAgXJehiPU2yup8xsN2H+6gnRnd9wKMumIPnBFqlTsMtqXbgpzwt3pnm
         4PCXI636wtQzrku4j4/gFWHOraQPvWSUhaUEjWGQ3wM4Xba0artzZn/Iw3ny6aVNlVFX
         qRBox1w6nzzgJYLaYiAa0vtzMmm5m0+8QMUmci6IyYf3l1JQvaWxdDxv/RpWHg1XNEhm
         gKRLexIUg2QoSvz+30i4ePbfr27D0lsb0zJ3crJ1gINuWfO3IAbq+NKMKNp4+eBwlqcE
         xtgIwXPdeRfxWdhZwFhjMKR183Ky0W1Z9sjZ/P2E30xQP5iWz4fIFCPLHj/e6iNwISW3
         uNLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sLCQZl2uZTgyC0e1AE4wxLx4qwv7+sx5Ge5fKPEc3ow=;
        b=JDrazGSVUmyEkV7LyHezJnmNfZGKyAJeHLyO7i1jOboi8sxj3so1RDqYedGmrNRFJA
         x/zN89r0WcR1ZY4Ab+ixjghF2pR5bGI/hyWKoMYj/b/qzs+5/zRss6hp1vg/8jKAJonB
         0uRV9X5bGZhTq1OKo180FjldvcNo+Y9RfdM68t4V2D+q6x9jznYzX3jUue9sMNw1SCq7
         EAPPxpbb67L1TsLFkq+Z1RHiSLo1Mw/ZhRSgsIkbz40YvveeKhTVw/H+bhaM/H+Nwm40
         rQPcG8999N8LwOwXp0bt8dNMxX9nH4L/FhfiEA4rwd0zOFKMp3PomHEZnbe5Lf4PfTHl
         fpUQ==
X-Gm-Message-State: APjAAAUNdyPoCPE8XSk9CrYMeNboi+psbGciCVjXlTRoZCwua47zcjE1
        XBHgIamNoZdXGnVgInshlozYTg==
X-Google-Smtp-Source: APXvYqy/qqLbQIcBtpLWWk2oo5FGRRzCxHrb9Kn+KaBGCJ1gUIfUg0L1YFsSFUFmJgE4MnuSkVSmhw==
X-Received: by 2002:a17:902:9a44:: with SMTP id x4mr3116695plv.127.1571306248898;
        Thu, 17 Oct 2019 02:57:28 -0700 (PDT)
Received: from localhost ([122.172.151.112])
        by smtp.gmail.com with ESMTPSA id i74sm2956392pfe.28.2019.10.17.02.57.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Oct 2019 02:57:27 -0700 (PDT)
Date:   Thu, 17 Oct 2019 15:27:25 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [RFT][PATCH 0/3] cpufreq / PM: QoS: Introduce frequency QoS and
 use it in cpufreq
Message-ID: <20191017095725.izchzl7enfylvpf3@vireshk-i7>
References: <2811202.iOFZ6YHztY@kreacher>
 <20191016142343.GB5330@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191016142343.GB5330@bogus>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 16-10-19, 15:23, Sudeep Holla wrote:
> Thanks for the spinning these patches so quickly.
> 
> I did give it a spin, but unfortunately it doesn't fix the bug I reported.
> So I looked at my bug report in detail and looks like the cpufreq_driver
> variable is set to NULL at that point and it fails to dereference it
> while trying to execute:
> 	ret = cpufreq_driver->verify(new_policy);
> (Hint verify is at offset 0x1c/28)
> 
> So I suspect some race as this platform with bL switcher tries to
> unregister and re-register the cpufreq driver during the boot.
> 
> I need to spend more time on this as reverting the initial PM QoS patch
> to cpufreq.c makes the issue disappear.

Is this easily reproducible ? cpufreq_driver == NULL shouldn't be the case, it
get updated only once while registering/unregistering cpufreq drivers. That is
the last thing which can go wrong from my point of view :)

-- 
viresh
