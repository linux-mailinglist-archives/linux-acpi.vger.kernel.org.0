Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6E57DBFCE
	for <lists+linux-acpi@lfdr.de>; Fri, 18 Oct 2019 10:25:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2632764AbfJRIZJ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 18 Oct 2019 04:25:09 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:38194 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2632763AbfJRIZJ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 18 Oct 2019 04:25:09 -0400
Received: by mail-ot1-f67.google.com with SMTP id e11so4276000otl.5;
        Fri, 18 Oct 2019 01:25:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jEbq9QSiMUBdFgNaRu0lx2kBkFKJqECZlDVnFyvhGgk=;
        b=NbD4/PUJZ51jDp5jGciPt8joG9eLxje610+QjVmfxHPB0FTJUnisNfOk/OQ3TjOb4w
         8uN4326iHS0BiTwZEYDR8FzwhtwRbgsW1o2QbEDUiCYwJHLPv2uDx7hkL9ekxSfj7LNj
         cqDp3BN+4vJnZO3nCVRwMhHGSfy/CMmkgSDHsOnKjEZ40JBM5efxIzX0NXbyMhfk8yPQ
         SkHbTR8gdxn82X20Ar8oqdKSmhfssZZOVElqaJjXAZqaweTpZrBnzeUShygH7F7L9Lub
         +bMB98UYdij2p+wvmx06CQw7rMs7ZAik4Y112KCTX8Eotrfg0iP5gX5qfALA4/TIRbyh
         ttNA==
X-Gm-Message-State: APjAAAUadT8183LwEl6LFQf1mLa/8GVdndUoiK1578qZaKnsfeuthlpR
        L8nk6bxd+mSErznOmWyOeJJu9fRSxC3GpIV3cAw=
X-Google-Smtp-Source: APXvYqwAdi4SbUncivySZf05920ohM9EzPpGF+cvDvfiO65zVjUe5FVnHgfQ1TQKvFSPNuyKSVyUItOZjrcK7vUTCVU=
X-Received: by 2002:a9d:664:: with SMTP id 91mr235402otn.189.1571387107123;
 Fri, 18 Oct 2019 01:25:07 -0700 (PDT)
MIME-Version: 1.0
References: <2811202.iOFZ6YHztY@kreacher> <20191016142343.GB5330@bogus>
 <20191017095725.izchzl7enfylvpf3@vireshk-i7> <20191017095942.GF8978@bogus>
 <CAJZ5v0ixS8ZS93Fgj8XGUMGcLdAy+Fgwp5z3QirccNSiiwLtDA@mail.gmail.com> <20191018054433.tq2euue675xk4o63@vireshk-i7>
In-Reply-To: <20191018054433.tq2euue675xk4o63@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 18 Oct 2019 10:24:56 +0200
Message-ID: <CAJZ5v0hpfvy5iELVRWFA3HS8NoAH0=py0cE+fLaUq2hDReCrnQ@mail.gmail.com>
Subject: Re: [RFT][PATCH 0/3] cpufreq / PM: QoS: Introduce frequency QoS and
 use it in cpufreq
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Oct 18, 2019 at 7:44 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 17-10-19, 18:34, Rafael J. Wysocki wrote:
> > [BTW, Viresh, it looks like cpufreq_set_policy() should still ensure
> > that the new min is less than the new max, because the QoS doesn't do
> > that.]
>
> The ->verify() callback does that for us I believe.

It does in practice AFAICS, but in theory it may assume the right
ordering between the min and the max and just test the boundaries, may
it not?
