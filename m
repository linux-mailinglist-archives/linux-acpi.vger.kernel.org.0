Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2BE85DBFDB
	for <lists+linux-acpi@lfdr.de>; Fri, 18 Oct 2019 10:27:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393696AbfJRI1t (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 18 Oct 2019 04:27:49 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37587 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390231AbfJRI1t (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 18 Oct 2019 04:27:49 -0400
Received: by mail-pg1-f194.google.com with SMTP id p1so2962808pgi.4
        for <linux-acpi@vger.kernel.org>; Fri, 18 Oct 2019 01:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fO5rhP6K+WvHSLdZS4qIOwy93CBX5JrPts4O8zPdzYA=;
        b=YJG8HcWnBa42iQUCBZi5ndFdutUmpewAtXsB0gND6NykpkWOPqPnM9k6YtUZUImg2J
         jU8FIXzxGeuG3+Tg7NHlzpj0hoTu3YiNnjmKy6RyJ6ApKMRxY6FsTkHTwCDSpGFBiUIE
         l3vJnbtewBJzAZjfZyihH8/EBZtVhikhf090q3MtNGgNSVE1nRwCyGvYgMyIr8ts/PfT
         n2FmH117syo5pL2uvGxQpBcZJZUiX3nRFBkUKkCDNpxBRYHvsStOuxEAb58S7cRNA6YH
         +GOzybZSGgKZLVya0j8z3SMAmr/vgsAOBdKtu/jmAjhgnUJ/NSb89VEvvcPSEXeFp82y
         MSLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fO5rhP6K+WvHSLdZS4qIOwy93CBX5JrPts4O8zPdzYA=;
        b=Azr1NdWswWbtFVvJhR6gQ7GD9H+jnmZ3KoxcjPivGDLCLBW3qyrZtVRKbGgB+iW1P4
         a/3LzUPunKQmn/OHEz/6v4XQ3dw+C+73HOChWbV4GYzve+aKHQ7Gl/86e8nDbY2aMBKM
         ld8YjnKsOa/NA75ZTE56ighQHOtv8Nb4b513IUy5jskpk7aqqDlg351c7BKm3qhuZsCc
         G0HKVkbiQXeXmfNFRgdIKBSeHOLAlXFz7Psv9R+KoNcby3KFPQfpOt+fEkvz/t22vtnc
         i7Xg+Mtoz46h//mcul2tHO6MqzKQjPbOgZS/yZYHP8BoqDSdbV+xAv7iF2L+0RuLSFmr
         /mYw==
X-Gm-Message-State: APjAAAUx/OqTFl1WWz5kT2XcbSekT7OSIXFq/VQjnkvC1YQZmvuwPZ1U
        zGTv5QGfOt6uBU5aD7GrH8yCuQ==
X-Google-Smtp-Source: APXvYqwn4Yr1AA9BWoOMP8e6FHAENoPiUbPydHx5Rm3qNWFhvl1J7+WureQPtv22CeRrq7TuEXsLxQ==
X-Received: by 2002:a65:6701:: with SMTP id u1mr8928898pgf.368.1571387268548;
        Fri, 18 Oct 2019 01:27:48 -0700 (PDT)
Received: from localhost ([122.172.151.112])
        by smtp.gmail.com with ESMTPSA id g7sm10492580pfm.176.2019.10.18.01.27.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Oct 2019 01:27:47 -0700 (PDT)
Date:   Fri, 18 Oct 2019 13:57:45 +0530
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
Message-ID: <20191018082745.3zr6tc3yqmbydkrw@vireshk-i7>
References: <2811202.iOFZ6YHztY@kreacher>
 <20191016142343.GB5330@bogus>
 <20191017095725.izchzl7enfylvpf3@vireshk-i7>
 <20191017095942.GF8978@bogus>
 <CAJZ5v0ixS8ZS93Fgj8XGUMGcLdAy+Fgwp5z3QirccNSiiwLtDA@mail.gmail.com>
 <20191018054433.tq2euue675xk4o63@vireshk-i7>
 <CAJZ5v0hpfvy5iELVRWFA3HS8NoAH0=py0cE+fLaUq2hDReCrnQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hpfvy5iELVRWFA3HS8NoAH0=py0cE+fLaUq2hDReCrnQ@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 18-10-19, 10:24, Rafael J. Wysocki wrote:
> On Fri, Oct 18, 2019 at 7:44 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > On 17-10-19, 18:34, Rafael J. Wysocki wrote:
> > > [BTW, Viresh, it looks like cpufreq_set_policy() should still ensure
> > > that the new min is less than the new max, because the QoS doesn't do
> > > that.]
> >
> > The ->verify() callback does that for us I believe.
> 
> It does in practice AFAICS, but in theory it may assume the right
> ordering between the min and the max and just test the boundaries, may
> it not?

I think cpufreq_verify_within_limits() gets called for sure from
within ->verify() for all platforms and this explicitly checks

        if (policy->min > policy->max)
                policy->min = policy->max;

-- 
viresh
