Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1E23DA986
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Oct 2019 12:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389374AbfJQKAG (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 17 Oct 2019 06:00:06 -0400
Received: from [217.140.110.172] ([217.140.110.172]:37756 "EHLO foss.arm.com"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1726638AbfJQKAG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 17 Oct 2019 06:00:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C0BAC1AED;
        Thu, 17 Oct 2019 02:59:45 -0700 (PDT)
Received: from bogus (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D9AFF3F718;
        Thu, 17 Oct 2019 02:59:44 -0700 (PDT)
Date:   Thu, 17 Oct 2019 10:59:42 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [RFT][PATCH 0/3] cpufreq / PM: QoS: Introduce frequency QoS and
 use it in cpufreq
Message-ID: <20191017095942.GF8978@bogus>
References: <2811202.iOFZ6YHztY@kreacher>
 <20191016142343.GB5330@bogus>
 <20191017095725.izchzl7enfylvpf3@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191017095725.izchzl7enfylvpf3@vireshk-i7>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Oct 17, 2019 at 03:27:25PM +0530, Viresh Kumar wrote:
> On 16-10-19, 15:23, Sudeep Holla wrote:
> > Thanks for the spinning these patches so quickly.
> >
> > I did give it a spin, but unfortunately it doesn't fix the bug I reported.
> > So I looked at my bug report in detail and looks like the cpufreq_driver
> > variable is set to NULL at that point and it fails to dereference it
> > while trying to execute:
> > 	ret = cpufreq_driver->verify(new_policy);
> > (Hint verify is at offset 0x1c/28)
> >
> > So I suspect some race as this platform with bL switcher tries to
> > unregister and re-register the cpufreq driver during the boot.
> >
> > I need to spend more time on this as reverting the initial PM QoS patch
> > to cpufreq.c makes the issue disappear.
>
> Is this easily reproducible ? cpufreq_driver == NULL shouldn't be the case, it
> get updated only once while registering/unregistering cpufreq drivers. That is
> the last thing which can go wrong from my point of view :)
>

Yes, if I boot my TC2 with bL switcher enabled, it always crashes on boot.

--
Regards,
Sudeep
