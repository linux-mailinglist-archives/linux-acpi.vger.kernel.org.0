Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3595DBD2C
	for <lists+linux-acpi@lfdr.de>; Fri, 18 Oct 2019 07:44:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729683AbfJRFok (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 18 Oct 2019 01:44:40 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41991 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390035AbfJRFoh (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 18 Oct 2019 01:44:37 -0400
Received: by mail-pg1-f194.google.com with SMTP id f14so2702878pgi.9
        for <linux-acpi@vger.kernel.org>; Thu, 17 Oct 2019 22:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ahk63OI60utYOmx1X43UEwxnHBgJgQRBxI72JSyLR2Y=;
        b=Yih8JGSYgB3U/98qQiRBg5zdD9tqp45DIfKnIw4wj+YWNqUEsx/KGFXvTg+Vl4DGKZ
         cSSHhesE6odKblyh1TLucrLIVRtJbb5tOy5DK5Nt+IDpje8runTFOoCipgNdB7ZmeE4D
         KWBD3wCwXfjs2T2sPT9WVho7xE0n+1Oofp1LBaWB6n27TY/DLzwzvyMRx5t1iVkmzT8T
         M38Hb3tkzKxuKkBetK5urEZcTtwTZTnENPa/C1XQZaX5ODrAgfePjocq1+g+3uRawaEu
         70t52KnSuT9XTx43xt4CowesMZxHdxMs4FrUxqI41eGdwyXLKY6wtksvSsfcFYlQzWW/
         ALQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ahk63OI60utYOmx1X43UEwxnHBgJgQRBxI72JSyLR2Y=;
        b=m9eqavKp3LEKWylSRm/dzHgjLphDZIe3jBmiztRJzL+HF12mCsIJvRVqjLya3jX/CS
         kTRePmf8uV3jOvnIyHwD0XMAJ/dSUD63ovUXBlL5tb+84SqoRjd6LYv8wjdfYwGKfzSY
         EjCHQ2AtrXFY4J8aA/gCuHnkgoszh3Fwcz8inqm9/juFYTn7BRiCwAs/ovfXVPGrkyDc
         7PFrJc7LxpUksGK+RvZ3D9V84sFgEoX/Q62qr8ARMnBD/lEd19HXlIJLgscYNh2Y+Dx2
         r4mwvbRHdj/Bp8oCw7P2I16W2D+UbvXlL/4tdiuqzCvRJgpWaSPTREOTpv2vLsz9m371
         rFZw==
X-Gm-Message-State: APjAAAWca5NbXKH8MY1zBZ9HA2R1c14GlXO9yqVpVzK9EjE+nOXxKJRw
        7abYRMxz6GF04+V4E5wjKB4flw==
X-Google-Smtp-Source: APXvYqx+utmT/iqde3kt4kJ4rpoCw1TX48diX3ulQSDJ78ELdDEU/bI/wfkzp2s2DFsHtT8FP6pNlA==
X-Received: by 2002:a63:3853:: with SMTP id h19mr4808623pgn.55.1571377476416;
        Thu, 17 Oct 2019 22:44:36 -0700 (PDT)
Received: from localhost ([122.172.151.112])
        by smtp.gmail.com with ESMTPSA id f185sm5546751pfb.183.2019.10.17.22.44.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Oct 2019 22:44:35 -0700 (PDT)
Date:   Fri, 18 Oct 2019 11:14:33 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [RFT][PATCH 0/3] cpufreq / PM: QoS: Introduce frequency QoS and
 use it in cpufreq
Message-ID: <20191018054433.tq2euue675xk4o63@vireshk-i7>
References: <2811202.iOFZ6YHztY@kreacher>
 <20191016142343.GB5330@bogus>
 <20191017095725.izchzl7enfylvpf3@vireshk-i7>
 <20191017095942.GF8978@bogus>
 <CAJZ5v0ixS8ZS93Fgj8XGUMGcLdAy+Fgwp5z3QirccNSiiwLtDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0ixS8ZS93Fgj8XGUMGcLdAy+Fgwp5z3QirccNSiiwLtDA@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 17-10-19, 18:34, Rafael J. Wysocki wrote:
> [BTW, Viresh, it looks like cpufreq_set_policy() should still ensure
> that the new min is less than the new max, because the QoS doesn't do
> that.]

The ->verify() callback does that for us I believe.

-- 
viresh
