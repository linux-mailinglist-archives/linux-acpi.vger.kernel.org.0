Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E0B6DC0D3
	for <lists+linux-acpi@lfdr.de>; Fri, 18 Oct 2019 11:24:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409680AbfJRJYx (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 18 Oct 2019 05:24:53 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40359 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2409679AbfJRJYx (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 18 Oct 2019 05:24:53 -0400
Received: by mail-pf1-f195.google.com with SMTP id x127so3501896pfb.7
        for <linux-acpi@vger.kernel.org>; Fri, 18 Oct 2019 02:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=v3de0Qp2dEG4v6wLtc+9wSifLlx04TUsULf8ZNOAzfo=;
        b=W4GJ3YysV76ngGFa9Q/MKPTCmrRuklBK8Sig/JFoWCS/GdY4XsthMBFYsf2fazxszF
         078CVXdccd/fbVCPk6zvLKGm0yKvZ5GJmZz0mqTHOX6UvQNT0PNPCvJIawWtuTYFp/qB
         RulOH4AyHToa+0aEtHN3ZzMK3uOaV4aZ34akTt1ZDPXQyurQkSgngCFi5+24L0SG8fCF
         XFMX5fmEw56bqXBuDxlojv1muVzT6HR6by4OV/kDQc9Lo5kbqE3j/+6mlQjSH7Lpw4Ru
         4bZzBUNT3sTopm4+O75Q2Q8kZi6x630VLZLbdGcb+G5JQELAfOL8aiV1qXHBGrKh/HZA
         Yyew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=v3de0Qp2dEG4v6wLtc+9wSifLlx04TUsULf8ZNOAzfo=;
        b=IIDAA/P2hzutJz+Yz6XNtdXx2QlO0p5esjeKtNSSDNVADDgAeLD639J99fvD6CZCwP
         kmEYRfZdWryrRibbCddtVLBeoQFfcZo3i8456epXO7ogquXOrCf5EXj+ktBzCfzTK7tH
         8uAn+3qg2JwwgROF5svOCNiXjNNx6R7WvTI1Ta/k6KAvebVmNCujtUUbzFOS4lRvexAm
         ADVc27O7/my+UDhnotzc8xEw5vmVAW+mIihKv8cEJJz8+3uggyew61ivN2ZC43ZxF3pa
         OhD5l6NXjbiBWG5IdPBv7COBwnZNz197ydQui5Ax/TxFU4NiW7poy1lMrC56KxwBmS5w
         rmlQ==
X-Gm-Message-State: APjAAAXEQxcPfi6hoq/k2eFquMPHavmkUiQZvnyegFhjzT8a0OtLL5LS
        T6nFYqZrKAz9s62MNiIrkDTgkA==
X-Google-Smtp-Source: APXvYqwkH7aDyKc+7ed+bwZ6rBwWDlzPlXO9W/aj0PKz4MD3W9HH+2tq3+dXWpID2Rv3H10HgXzj3A==
X-Received: by 2002:a17:90a:9306:: with SMTP id p6mr9751961pjo.68.1571390692245;
        Fri, 18 Oct 2019 02:24:52 -0700 (PDT)
Received: from localhost ([122.172.151.112])
        by smtp.gmail.com with ESMTPSA id f13sm5441333pgr.6.2019.10.18.02.24.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Oct 2019 02:24:50 -0700 (PDT)
Date:   Fri, 18 Oct 2019 14:54:47 +0530
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
Message-ID: <20191018092447.2utqazqfob65x4k2@vireshk-i7>
References: <2811202.iOFZ6YHztY@kreacher>
 <20191016142343.GB5330@bogus>
 <20191017095725.izchzl7enfylvpf3@vireshk-i7>
 <20191017095942.GF8978@bogus>
 <CAJZ5v0ixS8ZS93Fgj8XGUMGcLdAy+Fgwp5z3QirccNSiiwLtDA@mail.gmail.com>
 <20191018054433.tq2euue675xk4o63@vireshk-i7>
 <CAJZ5v0hpfvy5iELVRWFA3HS8NoAH0=py0cE+fLaUq2hDReCrnQ@mail.gmail.com>
 <20191018082745.3zr6tc3yqmbydkrw@vireshk-i7>
 <CAJZ5v0gR45YNwqrc8JQ_2qQBnYrxPeCHTnvQtEELD8VpXJrxLA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gR45YNwqrc8JQ_2qQBnYrxPeCHTnvQtEELD8VpXJrxLA@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 18-10-19, 10:30, Rafael J. Wysocki wrote:
> On Fri, Oct 18, 2019 at 10:27 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > On 18-10-19, 10:24, Rafael J. Wysocki wrote:
> > > On Fri, Oct 18, 2019 at 7:44 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > > >
> > > > On 17-10-19, 18:34, Rafael J. Wysocki wrote:
> > > > > [BTW, Viresh, it looks like cpufreq_set_policy() should still ensure
> > > > > that the new min is less than the new max, because the QoS doesn't do
> > > > > that.]
> > > >
> > > > The ->verify() callback does that for us I believe.
> > >
> > > It does in practice AFAICS, but in theory it may assume the right
> > > ordering between the min and the max and just test the boundaries, may
> > > it not?
> >
> > I think cpufreq_verify_within_limits() gets called for sure from
> > within ->verify() for all platforms
> 
> That's why I mean by "in practice". :-)

Hmm, I am not sure if we should really add another min <= max check in
cpufreq_set_policy() as in practice it will never hit :)

-- 
viresh
