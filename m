Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0961ADBFF3
	for <lists+linux-acpi@lfdr.de>; Fri, 18 Oct 2019 10:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2632845AbfJRIat (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 18 Oct 2019 04:30:49 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:43954 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387458AbfJRIas (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 18 Oct 2019 04:30:48 -0400
Received: by mail-ot1-f68.google.com with SMTP id o44so4270955ota.10;
        Fri, 18 Oct 2019 01:30:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sR8LGNWn5ye4HV5wuqrSqbgPTz3HHIYZY265Ose77AA=;
        b=mjS11S6Tka6V8RX+s4ziVaIcr1kvyGUumQTrbZma3fn2wPGgE0pBNtKt9xFDQlnKpP
         CGKH6LkBKgzVfDwxOgNSoXJKE3q1UBef5bNQCcAqWPF03lF+dzaNeSUFsTfBb2uugxI0
         +QXn2hL2jFfPKHnBvSd9qAdVElXOaoz1Wzr7AectiKTR7toHmSoiiaoGYwIbPnVdzAda
         yG68ySWkckPnF5rDA6RnLJJ6LukuPVuasifKDiR3kvEYXoEMZTw2PasEVsqUYsfFOzBP
         l3EcQWqiA+kOjz9Szenvy4PGX5Tp/omrEwnSVh7CIMobXLf+bwXF+dokHj7kLnIVyxRp
         xeRA==
X-Gm-Message-State: APjAAAU5KqUyI55hMbX6iulgDgNtCz6z7pENPCSYaD/ONut8PlwR9z5z
        7vUkIgonV5fBo/Zgj+NmlXAZdyldWi0K3X59O2Y=
X-Google-Smtp-Source: APXvYqyOVj/WbgqsqGcPJx6u9Wa3Z53YLRML1XSQVYeYuPS2CTuwb8VYSp7/X11REuVAr8mknXzeAgjbgzlK6m++50Q=
X-Received: by 2002:a9d:5a0f:: with SMTP id v15mr6816536oth.266.1571387447135;
 Fri, 18 Oct 2019 01:30:47 -0700 (PDT)
MIME-Version: 1.0
References: <2811202.iOFZ6YHztY@kreacher> <20191016142343.GB5330@bogus>
 <20191017095725.izchzl7enfylvpf3@vireshk-i7> <20191017095942.GF8978@bogus>
 <CAJZ5v0ixS8ZS93Fgj8XGUMGcLdAy+Fgwp5z3QirccNSiiwLtDA@mail.gmail.com>
 <20191018054433.tq2euue675xk4o63@vireshk-i7> <CAJZ5v0hpfvy5iELVRWFA3HS8NoAH0=py0cE+fLaUq2hDReCrnQ@mail.gmail.com>
 <20191018082745.3zr6tc3yqmbydkrw@vireshk-i7>
In-Reply-To: <20191018082745.3zr6tc3yqmbydkrw@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 18 Oct 2019 10:30:36 +0200
Message-ID: <CAJZ5v0gR45YNwqrc8JQ_2qQBnYrxPeCHTnvQtEELD8VpXJrxLA@mail.gmail.com>
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

On Fri, Oct 18, 2019 at 10:27 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 18-10-19, 10:24, Rafael J. Wysocki wrote:
> > On Fri, Oct 18, 2019 at 7:44 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > >
> > > On 17-10-19, 18:34, Rafael J. Wysocki wrote:
> > > > [BTW, Viresh, it looks like cpufreq_set_policy() should still ensure
> > > > that the new min is less than the new max, because the QoS doesn't do
> > > > that.]
> > >
> > > The ->verify() callback does that for us I believe.
> >
> > It does in practice AFAICS, but in theory it may assume the right
> > ordering between the min and the max and just test the boundaries, may
> > it not?
>
> I think cpufreq_verify_within_limits() gets called for sure from
> within ->verify() for all platforms

That's why I mean by "in practice". :-)
