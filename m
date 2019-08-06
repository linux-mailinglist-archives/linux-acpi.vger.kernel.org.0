Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA5EA82D50
	for <lists+linux-acpi@lfdr.de>; Tue,  6 Aug 2019 10:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728975AbfHFIBS (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 6 Aug 2019 04:01:18 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:45759 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727259AbfHFIBS (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 6 Aug 2019 04:01:18 -0400
Received: by mail-ot1-f66.google.com with SMTP id x21so24815258otq.12;
        Tue, 06 Aug 2019 01:01:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zUs0xIhgTH6wwFy+pIi473fY3cNI70KH0eyUmBXIqyE=;
        b=hP8bMCfWQVwlcM70vKGu2JyEvNDXeZJQRciBJNJrLwRQ1mdtdKPz6jVTmmc8G+7lu+
         0YWu+RGe5Fk+pF7SZlK4bQjLghJsSOYKlj5FMZwQkZ75m0mQPRX7cbiIgz6tNEp3ICd9
         nX1i2/jQv5Ijnh/AMDuBYQ7zjLOdlgNWNQsbs5380b0rOOsVuLf8Zz6u1ujGZyxfe/QD
         eiJCkwp/rJTO7mIOnLUcqxCZ67lOcA9Ze2ktcIGQd6hqRQ/AoEvIkmbjKGlnKBqQTbuL
         ABiB96muXABEgh6ANtCSey0R1XljjY5IzzYJ8Rq+ibE/Es/q3ScCRxnGDcztrNnOcYwV
         dSBA==
X-Gm-Message-State: APjAAAVpyVaDnKRQa9AanlVgzfj1eS/9ssd6Ri4yEh72QxJSXFDSfv6U
        Q8Gi7KyD6nMbVNte2uVW44MMB2XFUVKH8QksvQQ=
X-Google-Smtp-Source: APXvYqywCxq1EnPd1Un9O/Ra9WUoJF8y5q5e6rNxxbDtgntcVTWejmBx8iAPavHTpNCItROyJW0urUxcpUKxGieVl4A=
X-Received: by 2002:a9d:6b96:: with SMTP id b22mr2075090otq.262.1565078476888;
 Tue, 06 Aug 2019 01:01:16 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1563862014.git.viresh.kumar@linaro.org> <86dc4a082ea00c278c0e1d7f3fcbdc4ab9af2eec.1563862014.git.viresh.kumar@linaro.org>
 <1782403.O7LH3UnqfR@kreacher> <20190806043904.dbpon4qf3mfsm4vz@vireshk-i7>
In-Reply-To: <20190806043904.dbpon4qf3mfsm4vz@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 6 Aug 2019 10:01:05 +0200
Message-ID: <CAJZ5v0iqwc4mvqHoTHwoNS-T1zueS07S2e-1STEsKhFhoOh0dA@mail.gmail.com>
Subject: Re: [PATCH V2 05/10] ACPI: cpufreq: Switch to QoS requests instead of
 cpufreq notifier
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
        Robert Moore <robert.moore@intel.com>,
        Erik Schmauss <erik.schmauss@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Aug 6, 2019 at 6:39 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 05-08-19, 11:42, Rafael J. Wysocki wrote:
> > On Tuesday, July 23, 2019 8:14:05 AM CEST Viresh Kumar wrote:
> > > @@ -310,8 +339,11 @@ static int __init acpi_processor_driver_init(void)
> > >     cpuhp_setup_state_nocalls(CPUHP_ACPI_CPUDRV_DEAD, "acpi/cpu-drv:dead",
> > >                               NULL, acpi_soft_cpu_dead);
> > >
> > > -   acpi_thermal_cpufreq_init();
> > > -   acpi_processor_ppc_init();
> > > +   if (!cpufreq_register_notifier(&acpi_processor_notifier_block,
> > > +                                  CPUFREQ_POLICY_NOTIFIER)) {
> > > +           acpi_processor_cpufreq_init = true;
> >
> > Can't that be set/cleared by acpi_processor_notifier() itself?
>
> This is required to be done only once at initialization and setting it
> to true again and again on every invocation of the notifier callback
> doesn't look right.
>
> I have updated the patch based on rest of your suggestions, please see
> if it looks okay now.

Yes, it does, thanks!

[No need to resend, I'll take it from this message.]
