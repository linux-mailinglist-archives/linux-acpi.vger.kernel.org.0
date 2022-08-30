Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2029C5A5B3C
	for <lists+linux-acpi@lfdr.de>; Tue, 30 Aug 2022 07:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbiH3FpD (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 30 Aug 2022 01:45:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbiH3FpA (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 30 Aug 2022 01:45:00 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01C3E13F51
        for <linux-acpi@vger.kernel.org>; Mon, 29 Aug 2022 22:44:59 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id o4so10092970pjp.4
        for <linux-acpi@vger.kernel.org>; Mon, 29 Aug 2022 22:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=OZrB1r5czbXocki1k9M1K47PMyoT2lGbE+m2as71vbM=;
        b=Mre5u/psT8WNvzhuroGVULvJC5NMcDvaLlPHw2b1cX5H0SYPShdXYNuemxzcakUpoW
         iM1stJwHC9wP5S66wY/0Q62lLnSgoJw2+Y9VCUjLayiacdnaWMSGwkQTr/TadtSp4din
         9ZelUQ14tNa9fKomTov7Hnqh3bFyysgpjRdzVX4TW08PmJ04wc7XvmuKl/cepCquiPh2
         zAa4t0cj/JBeO/wOkq6xZf4JISIZUkzkzo4ptzCnvCEl6XP2HavtSoQZR3Slh5GzkNRT
         y5pxjw3RAc/WxPVBLVGb3qNYRk0CiWq3bfOMvt1tsQkG1qrZZyfaQSdNiSnGUSxIzhTO
         K6vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=OZrB1r5czbXocki1k9M1K47PMyoT2lGbE+m2as71vbM=;
        b=WnjFpdg320laYnOxhA4zby7l1i2VgEnaTWAEKr3Ze+RFtHkAfGbez3ohVk9ZdfR1by
         6gVoPZmSnJVipy3rKrHbjxugcInu4ytf/GFWQ03b47tVxZB0I3vpmWoTAjOBCx1AkEcE
         ufkeb/WDQgLA4sgvmw3boPvas9nV7RWPXpNLF6nMz9bbAVR8LsVsVKCR9oAXJV2nOgM+
         XMvKwk7WchXgI5PXjOopu+KrWobvHKP2MH2vUC3XZElZH/YuWrEAZHi5S0kd8eFdt4ri
         4nBKBCUYVK/yvfYSn6tmnibFy3inyvx+cJpk9sSNeK3UciMeJ4wXjjyP2pmRDczaLPKR
         MTRw==
X-Gm-Message-State: ACgBeo3vk9h48gedAFuftbuRsRZD1TIKrUPX+gHvi1Qvjuk/Mp+YTLjd
        1/Hm3Tz0x23DzTYWG8EYeXlaIQ==
X-Google-Smtp-Source: AA6agR5BViIHecxmZ6xtzj9KH/goF9PYHSdULnv0XdS2by1e/G3zHkzh1+Dg0Qc1q0AVHKyxFlAiZA==
X-Received: by 2002:a17:902:8f87:b0:172:83b5:d771 with SMTP id z7-20020a1709028f8700b0017283b5d771mr19656028plo.159.1661838298529;
        Mon, 29 Aug 2022 22:44:58 -0700 (PDT)
Received: from localhost ([122.171.18.80])
        by smtp.gmail.com with ESMTPSA id k4-20020a17090a3cc400b001fada871e97sm7631907pjd.13.2022.08.29.22.44.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 22:44:57 -0700 (PDT)
Date:   Tue, 30 Aug 2022 11:14:55 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-acpi@vger.kernel.org, rafael@kernel.or, lenb@kernel.org,
        robert.moore@intel.com, punit.agrawal@bytedance.com,
        ionela.voinescu@arm.com, pierre.gondois@arm.com,
        linux-kernel@vger.kernel.org, devel@acpica.org,
        linux-pm@vger.kernel.org,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Souvik Chakravarty <souvik.chakravarty@arm.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        vincent.guittot@linaro.org
Subject: Re: [PATCH v3 2/2] cpufreq: CPPC: Change FIE default
Message-ID: <20220830054455.pezg63zqxg6az77n@vireshk-i7>
References: <20220818211619.4193362-1-jeremy.linton@arm.com>
 <20220818211619.4193362-3-jeremy.linton@arm.com>
 <20220824061430.3aflygc4gno5j47y@vireshk-i7>
 <0d49c40d-02af-5190-76b0-e88f3622ab7a@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d49c40d-02af-5190-76b0-e88f3622ab7a@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 24-08-22, 15:04, Lukasz Luba wrote:
> On 8/24/22 07:14, Viresh Kumar wrote:
> > On 18-08-22, 16:16, Jeremy Linton wrote:
> > > FIE is mostly implemented as PCC mailboxes on arm machines.  This was
> > > enabled by default without any data suggesting that it does anything
> > > but hurt system performance. Lets change the default to 'n' until
> > > hardware appears which clearly benefits.
> > > 
> > > Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> > > ---
> > >   drivers/cpufreq/Kconfig.arm | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
> > > index 954749afb5fe..ad66d8f15db0 100644
> > > --- a/drivers/cpufreq/Kconfig.arm
> > > +++ b/drivers/cpufreq/Kconfig.arm
> > > @@ -22,7 +22,7 @@ config ACPI_CPPC_CPUFREQ
> > >   config ACPI_CPPC_CPUFREQ_FIE
> > >   	bool "Frequency Invariance support for CPPC cpufreq driver"
> > >   	depends on ACPI_CPPC_CPUFREQ && GENERIC_ARCH_TOPOLOGY
> > > -	default y
> > > +	default n
> > >   	help
> > >   	  This extends frequency invariance support in the CPPC cpufreq driver,
> > >   	  by using CPPC delivered and reference performance counters.
> > 
> > Why is this required after we have the first patch in ?
> > 

Well, my question was for the way the patches were added. If we are
disabling the feature based on platform, then there is no need to
disable the feature by default.

> There are a few issues with this ACPI_CPPC_CPUFREQ_FIE solution:
> 1. The design is very heavy and that kernel thread can be ~512 util
>    (that's what we have been told by one of our partners from servers'
>    world)
> 2. The HW & FW design is not suited for this task. Newer HW will just
>    have AMU counters (on Arm64) for FIE
> 3. The patches haven't been tested in terms of performance overhead
>    AFAIK. Although, it affects existing Arm64 servers with their
>    workloads.
> 4. AFAIK non of our server partners wasn't complaining about issues with
>    old FIE mechanism.
> 
> In our team we are not allowed to send code that we cannot prove in many
> ways.
> 
> I would just not compile this at all (or even revert this feature).
> If someone compiled in this by accident - make sure we disable it
> after checks like in the patch 1/2. I'll add also some comments
> to that patch.

If we don't really want the feature, which is open for discussion
(added Vincent to have a look as well), then we better mark it BROKEN
in Kconfig.

-- 
viresh
