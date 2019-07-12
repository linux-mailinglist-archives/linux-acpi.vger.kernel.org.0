Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6993664D1
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Jul 2019 05:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729332AbfGLDKa (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 11 Jul 2019 23:10:30 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46153 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729239AbfGLDKa (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 11 Jul 2019 23:10:30 -0400
Received: by mail-pl1-f195.google.com with SMTP id c2so4029263plz.13
        for <linux-acpi@vger.kernel.org>; Thu, 11 Jul 2019 20:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UI3xZ6ZoClWPqrBnQqWKV86XGyEZlmgwirsJ/BmtMso=;
        b=LpcXRpiPevr9Wv6RrLEcBX6CiXmYw2fRd48ZYFmnyeyHgFcNRN8W0soUWSuzOmBuCW
         bh4NqBj8KrlEbp2S3Ft8i5AvzMPqvJ42sytaIGfXvIfzGKLUNWsQ0XauwNgTMSiMTMq3
         QaMwi2LINDyyQOBEu8disVlM8br/qWQ5JHY91xF0Bj703jwfp2wAAbhAaZUH2zT+U5SA
         TE4sid9/je2Nod9Upi3wqcyCOX1K9FAJ8/7KJHjQ+LEmPRQt/e4Aqh0d/B+QUe44/4us
         +S4ps/NAAZPTIGIT/JCbL/jU2vRKsbbvHN1khSARsx8n4jW5l4AZm5mtHnBbKEdgje3H
         hjLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UI3xZ6ZoClWPqrBnQqWKV86XGyEZlmgwirsJ/BmtMso=;
        b=JcA7KEt/PFC2GT6mWvVGDqkhWsVcBL18y+U8rJ6v2BLM2gtxlYoH9Q6wWEb5Pu4kH5
         6Xj85xQ+AlrnDvCMD9r3YlniLBISjFfMqfZkmBl6A1ig4n8/fwd5a8Tmyl6PujILpcP/
         KeKKQs7nZwzMHZjuqw3SMWtKsoqzg2RTkvWPdAM9aJlAoSJlP6fAD4zY74QMJQvmZv3k
         VAQWRrnnRka4BT7OlPuJxDbBWhqNuh87ksKf652upTSmIbG1vztXMxOBCcgeuY21bmZ4
         BvpKdcnHk6ozNrRZnM09gMLloERCXGLgPfusmAkQUEDaJ2dRzw2bULUoVUEWy2XL+97k
         BMfQ==
X-Gm-Message-State: APjAAAU5eaLttKFLPwd/OR4epg2y60VNER0pgyF/7hW7/V5cpYL6iDNF
        ccP6SR4ks4ddZqBuFLglfFIehg==
X-Google-Smtp-Source: APXvYqwBNG8IOxa583ljmPGfqrbou2cc4yby+KcGM/8n7SMWa4UmgE3hfrCGUNKuGq/xGrCe2jOkQw==
X-Received: by 2002:a17:902:7686:: with SMTP id m6mr8514635pll.239.1562901029202;
        Thu, 11 Jul 2019 20:10:29 -0700 (PDT)
Received: from localhost ([122.172.28.117])
        by smtp.gmail.com with ESMTPSA id m13sm5455233pgv.89.2019.07.11.20.10.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Jul 2019 20:10:28 -0700 (PDT)
Date:   Fri, 12 Jul 2019 08:40:25 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Janakarajan Natarajan <jnataraj@amd.com>
Cc:     "Natarajan, Janakarajan" <Janakarajan.Natarajan@amd.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Erik Schmauss <erik.schmauss@intel.com>,
        "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
Subject: Re: [PATCHv3 6/6] drivers/cpufreq: Add a CPUFreq driver for AMD
 processors (Fam17h and later)
Message-ID: <20190712031025.mylhtzehv3vs6db3@vireshk-i7>
References: <cover.1562781484.git.Janakarajan.Natarajan@amd.com>
 <e48c6b836f996a16472c777612f1e3343c542077.1562781484.git.Janakarajan.Natarajan@amd.com>
 <20190711061208.yqxt4ps67vmsy7sp@vireshk-i7>
 <eb208b15-d6b5-192d-b600-1f791c91eb4c@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb208b15-d6b5-192d-b600-1f791c91eb4c@amd.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 11-07-19, 16:58, Janakarajan Natarajan wrote:
> On 7/11/2019 1:12 AM, Viresh Kumar wrote:
> > On 10-07-19, 18:37, Natarajan, Janakarajan wrote:
> >> +static int amd_cpufreq_cpu_init(struct cpufreq_policy *policy)
> >> +{
> >> +	return 0;
> >> +}
> >> +
> >> +static int amd_cpufreq_cpu_exit(struct cpufreq_policy *policy)
> >> +{
> >> +	return 0;
> >> +}
> >> +
> >> +static int amd_cpufreq_cpu_verify(struct cpufreq_policy *policy)
> >> +{
> >> +	return 0;
> >> +}
> >> +
> >> +static int amd_cpufreq_cpu_target_index(struct cpufreq_policy *policy,
> >> +					unsigned int index)
> >> +{
> >> +	return 0;
> >> +}
> > All empty helpers ? There is nothing you need to do ?
> 
> 
> When we posted v2 of this patchset, Rafael let us know that he was 
> uncomfortable
> 
> going behind the (acpi-cpufreq) drivers back by letting the user 
> communicate directly
> 
> with the platform. That's the reason we have an empty driver whose 
> primary purpose
> 
> is to expose sysfs entries for the user.

I read his comments now and what he suggested is:

"What about handling this like the others do, through a proper cpufreq
driver?"

I am not sure if he meant something like that you have here. Only one
cpufreq driver can be registered at any point of time with the kernel,
and so if this one is there then acpi-cpufreq or intel-pstate can't be
there. Who will do DVFS ?

-- 
viresh
