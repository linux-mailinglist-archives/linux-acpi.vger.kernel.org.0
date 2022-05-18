Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21FE652BA02
	for <lists+linux-acpi@lfdr.de>; Wed, 18 May 2022 14:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236846AbiERMae (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 18 May 2022 08:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236947AbiERM3w (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 18 May 2022 08:29:52 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5315F196687
        for <linux-acpi@vger.kernel.org>; Wed, 18 May 2022 05:28:25 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id bd25-20020a05600c1f1900b0039485220e16so2477501wmb.0
        for <linux-acpi@vger.kernel.org>; Wed, 18 May 2022 05:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=vbZ35HTc/Z+9/YtPffCcXnSQ34v/inirF9FoyPpxltg=;
        b=XMZgvjHgjIEqx7BPEB+Mdfhrp5/F6NWKbVG3Q6DHC2nGEPXEQc90ld+Gz69p1flrqV
         psPqnkkcTUVGnyHvizy90TW1A/mBQtY+zxcholbkSylys2Fnwya1odyM8BuREjk7joN/
         4HBkKzziHy05hSlCMOE1nk1BJZ4Ialira3K2Jmw4xD9CwPdOdwzoxH8cc+4H4wnDhpnT
         VEQXw3FLimcMlPr9IArItdoBeDkD5Zfhi5sEiJL8EtWCtkYANpQPmY5aoTECOXjmSQ9v
         tnAsF5JNzAXVE8bou5eMoBJ+QYSCFHLIYVjE+OjhEnTW32uZN7AvpjybB1IRbckAh68v
         6qqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=vbZ35HTc/Z+9/YtPffCcXnSQ34v/inirF9FoyPpxltg=;
        b=b18IVZVVlsoFXRJO7E35rWhTxWUVi+umFuAxl7mcANyWZLAwjs93rCWFwIjbrz9fyn
         wCEF+3qAtlr2LjxT15z25BKwq7Q1xTVyCMTw3hJowfdRFhgvoSGgxSjpCg8ZP5ISunex
         +TmHp07Z4OD0a3Be/LyKyIidUhaeSob1UbVAvBKmpNlrGsLJMFgCsAU+fnPPxKDA+Ruu
         OXYCrvVJnN8gVOtjX/tPAYLwEx4gFnZe2j57ATcN2Tz3NYHip3D9ASElcNLvS5uT/W+n
         dgRE/Ks2XFRJ0CmAeokom0IsN30RB0eChDqNqUpenfHWLl/Zu3Tg/Ix7NXWm+lJe+NQJ
         LWVg==
X-Gm-Message-State: AOAM533uE/G+vpTHMZkanKs/5x0PfJQZ+xXooVWh7b5XwzUmqnHL/0Fx
        XG5+JgB8lmz782EwNXsx3eAJNA==
X-Google-Smtp-Source: ABdhPJxaPpelIGlhHrpTWKJVajqQdAKSpL79pB1ObInSUNS/WOVFT1qfZsR7QWypis9eBbi7xMO4jA==
X-Received: by 2002:a05:600c:1c17:b0:394:7ecb:5b3a with SMTP id j23-20020a05600c1c1700b003947ecb5b3amr36479002wms.185.1652876896879;
        Wed, 18 May 2022 05:28:16 -0700 (PDT)
Received: from localhost ([212.187.182.163])
        by smtp.gmail.com with ESMTPSA id e4-20020adf9bc4000000b0020d0c48d135sm1969667wrc.15.2022.05.18.05.28.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 05:28:16 -0700 (PDT)
Date:   Wed, 18 May 2022 13:28:15 +0100
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Pierre Gondois <pierre.gondois@arm.com>
Cc:     linux-kernel@vger.kernel.org, Ionela.Voinescu@arm.com,
        dietmar.eggemann@arm.com, sudeep.holla@arm.com,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org,
        devel@acpica.org
Subject: Re: [PATCH v2 1/5] ACPI: CPPC: Check _OSC for flexible address space
Message-ID: <20220518122815.7wzbzi2u55eq7tpv@viresh-thinkpad>
References: <20220518090901.2724518-1-pierre.gondois@arm.com>
 <20220518094243.6oxbdmf226jvqoef@viresh-thinkpad>
 <16566ef8-15d3-bf1b-37f2-c0b94b0493bc@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <16566ef8-15d3-bf1b-37f2-c0b94b0493bc@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 18-05-22, 12:34, Pierre Gondois wrote:
> 
> 
> On 5/18/22 11:42, Viresh Kumar wrote:
> > On 18-05-22, 11:08, Pierre Gondois wrote:
> > > ACPI 6.2 Section 6.2.11.2 'Platform-Wide OSPM Capabilities':
> > >    Starting with ACPI Specification 6.2, all _CPC registers can be in
> > >    PCC, System Memory, System IO, or Functional Fixed Hardware address
> > >    spaces. OSPM support for this more flexible register space scheme is
> > >    indicated by the “Flexible Address Space for CPPC Registers” _OSC bit
> > > 
> > > Otherwise (cf ACPI 6.1, s8.4.7.1.1.X), _CPC registers must be in:
> > > - PCC or Functional Fixed Hardware address space if defined
> > > - SystemMemory address space (NULL register) if not defined
> > > 
> > > Add the corresponding _OSC bit and check it when parsing _CPC objects.
> > > 
> > > Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
> > > Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
> > > ---
> > >   drivers/acpi/bus.c       | 18 ++++++++++++++++++
> > >   drivers/acpi/cppc_acpi.c |  9 +++++++++
> > >   include/linux/acpi.h     |  2 ++
> > >   3 files changed, 29 insertions(+)
> > 
> > It would be much useful to get a cover letter for this series with
> > what you have changed since the previous version. It is almost
> > impossible to find that out otherwise.
> > 
> 
> Yes indeed, sorry for that, the changelog is:
> v2:
> [1/5] ACPI: CPPC: Check _OSC for flexible address space
> - Renamed OSC_SB_CPC_FLEXIBLE_ADR_SP to OSC_SB_CPC_FLEXIBLE_ADR_SPACE
> [3/5] ACPI: CPPC: Assume no transition latency if no PCCT
> and
> [4/5] cpufreq: CPPC: Enable fast_switch
> - Renamed CPC_IN_SIO to CPC_IN_SYSTEM_IO
> - Renamed CPC_IN_SM to CPC_IN_SYSTEM_MEMORY
> 
> or do you prefer to have the serie re-submitted ?

No it is fine for now :)

-- 
viresh
