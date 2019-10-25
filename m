Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00E01E4639
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Oct 2019 10:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436927AbfJYIvh (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 25 Oct 2019 04:51:37 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33992 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726986AbfJYIvh (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 25 Oct 2019 04:51:37 -0400
Received: by mail-pf1-f194.google.com with SMTP id b128so1152723pfa.1
        for <linux-acpi@vger.kernel.org>; Fri, 25 Oct 2019 01:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8o6EjIfqN25bChdB576+plHQp91qpYydoxPIwoMERx4=;
        b=ig5SOSgvEB3siL/ERQz6j33KrwwKzxL1zUp3xfMb5RU0dPThOC8RlTm44Jrra5oBDo
         gDoq8FmENLk3bGlty1/AZbNnVJk/bCmcoQ+JPZo4FL8oyFbwtQNXi4NAi+iwFUi8MHuY
         cKIfHTDHCl24b+kKXy6K+SFElDlXTwmHj4lEopxpWCVs8DgwS2sKQ7S7lh17HQNz2Nze
         +QP0vWaEekwMRoTJpo2pRA6NbArcLoSNKtFr0ivdXHsSpXZC317WSzljDyRh4SbTshdL
         ywU9VRy42nEuM273qR+BmINlEjy43G7v1mQiMxQHZF/mM0F+r32CLl6tJEbH0VVWRKLH
         ckTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8o6EjIfqN25bChdB576+plHQp91qpYydoxPIwoMERx4=;
        b=XP1mzIxV7tzRlDugyBRmC5wPpgY65SC8Y82A3sSfYwa4KpXK45i2iE1XWVDsVVbueO
         thj9zaxxGfCys9Q7LNEjUDyf7eEF3lfyteF+FI8vqt8QO6kgWpXKidDCd7aIMaJ5uFrb
         hN+yDIAkVQAJNLzYb7U41PPmZkzRZVCHbwwKy8t+wBDFTF99W1YIgQnSjnWoS4yOIxpJ
         EE73jBG9p884tVe/Z0F0PaI81z4YSq42m3Ij3IpnkoACmGGXzlof8WJg7uMWAC6lcSK1
         PG2nClgWpmirmyr2ATVSZ4MJljpMpV+fD5lyF2rrKUD4HqvV/q0F240j207QtpHqKa1Y
         8Rxg==
X-Gm-Message-State: APjAAAU0nxize3kXNeEqaE6ZG8HY03DaTx2IsSDJ+Xa0RvlET7yzZ7r0
        ZUBaZPMbiZO1sMmemDH3ngdKlg==
X-Google-Smtp-Source: APXvYqyeYikLu3j/t2D6AwdxoxPXvX51u7+dkh7OgZVYL/qG+aBDEDqw3nTis5fGL/9ccbruKTJ12g==
X-Received: by 2002:a65:5503:: with SMTP id f3mr2973662pgr.351.1571993495124;
        Fri, 25 Oct 2019 01:51:35 -0700 (PDT)
Received: from localhost ([122.172.151.112])
        by smtp.gmail.com with ESMTPSA id f8sm1454698pfn.147.2019.10.25.01.51.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Oct 2019 01:51:34 -0700 (PDT)
Date:   Fri, 25 Oct 2019 14:21:32 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ACPI: processor: Add QoS requests for all CPUs
Message-ID: <20191025085132.qk6iynyavgvp7wlm@vireshk-i7>
References: <2435090.1mJ0fSsrDY@kreacher>
 <20191025025343.tyihliza45os3e4r@vireshk-i7>
 <CAJZ5v0hyAX6zpr+2EzURg7ACmaXhbTAc7mBnr9ep11LkF1EBOg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hyAX6zpr+2EzURg7ACmaXhbTAc7mBnr9ep11LkF1EBOg@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 25-10-19, 10:17, Rafael J. Wysocki wrote:
> On Fri, Oct 25, 2019 at 4:53 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > On 25-10-19, 02:41, Rafael J. Wysocki wrote:
> > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > >
> > > The _PPC change notifications from the platform firmware are per-CPU,
> > > so acpi_processor_ppc_init() needs to add a frequency QoS request
> > > for each CPU covered by a cpufreq policy to take all of them into
> > > account.
> > >
> > > Even though ACPI thermal control of CPUs sets frequency limits
> > > per processor package, it also needs a frequency QoS request for each
> > > CPU in a cpufreq policy in case some of them are taken offline and
> > > the frequency limit needs to be set through the remaining online
> > > ones (this is slightly excessive, because all CPUs covered by one
> > > cpufreq policy will set the same frequency limit through their QoS
> > > requests, but it is not incorrect).
> > >
> > > Modify the code in accordance with the above observations.
> >
> > I am not sure if I understood everything you just said, but I don't
> > see how things can break with the current code we have.
> >
> > Both acpi_thermal_cpufreq_init() and acpi_processor_ppc_init() are
> > called from acpi_processor_notifier() which is registered as a policy
> > notifier and is called when a policy is created or removed. Even if
> > some CPUs of a policy go offline, it won't matter as the request for
> > the policy stays and it will be dropped only when all the CPUs of a
> > policy go offline.
> >
> > What am I missing ?
> 
> The way the request is used.

Yes, I missed the point :)

-- 
viresh
