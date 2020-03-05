Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84DB217A1DB
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Mar 2020 10:06:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725946AbgCEJGA (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 5 Mar 2020 04:06:00 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:37544 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbgCEJGA (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 5 Mar 2020 04:06:00 -0500
Received: by mail-oi1-f195.google.com with SMTP id q65so5224697oif.4;
        Thu, 05 Mar 2020 01:06:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TFaIpxONCt+sIKKd0QPqj0IgGgaDTj/hC/vgrFizdCQ=;
        b=GuzS8nT3AauttJ6WfU/a6zTaQ464al1hHmereqWJb/Ssz+PgO89ZNSWLT+2xGhbIAb
         k9erFuzRmTtgQv5VAtIXO2M48mIXQTze4OmmMGMkyHfBYvVnfvvpgphvSP7urJVN1uoT
         /hievaawLxaBuoYt6FFYCNHeMc6Tdx83HiNwDG3Di+L2TAP4dH1SjL3HelJ4Dq1OXm/6
         KN18lIlFBwzefLKQEUc0+4XbKPUztBe/OnkkwLdjaf9TbVf4wNLvBDv87SwCxw81eBvl
         jfy2O+jxRxuQsFahzVIwLFcI9fsEmN8fuusIlYPo0xo8ANcO89wlEEA74bxZ6UulYTki
         xPDw==
X-Gm-Message-State: ANhLgQ3c8xrF+uhqJ94aaBppbfyaejCbRxlkwV9HifavVxJzTm0aiYCV
        zPqBSuiafriJr3uXxEwSeQWDHCsiYkavvdE27pE=
X-Google-Smtp-Source: ADFU+vsVto72cKF3MbnXe+qIld4wE26jLbmiKoIvdaN3p8hl2BHPVRl6eXOwNLvQlumM0l5svFNoiVz3tZWVRYd3M0s=
X-Received: by 2002:aca:bfc2:: with SMTP id p185mr5074380oif.57.1583399159819;
 Thu, 05 Mar 2020 01:05:59 -0800 (PST)
MIME-Version: 1.0
References: <20200305013509.GF5972@shao2-debian> <951b0986-bb35-d9a5-1639-0a8cdb3dcd04@intel.com>
 <cbe4887c-d54a-c4aa-e4bf-981b5fcc291d@intel.com>
In-Reply-To: <cbe4887c-d54a-c4aa-e4bf-981b5fcc291d@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 5 Mar 2020 10:05:48 +0100
Message-ID: <CAJZ5v0g2vzYQ04GyrpubLx2+B0O4SDbqoTDCvhnSyaj1j1xswA@mail.gmail.com>
Subject: Re: [cpufreq] 909c0e9cc1: fwq.fwq.med 210.0% improvement
To:     Rong Chen <rong.a.chen@intel.com>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        Linux PM <linux-pm@vger.kernel.org>, lkp@lists.01.org,
        Rafael Wysocki <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Mar 5, 2020 at 9:18 AM Rong Chen <rong.a.chen@intel.com> wrote:
>
>
>
> On 3/5/20 3:50 PM, Rafael J. Wysocki wrote:
> > On 3/5/2020 2:35 AM, kernel test robot wrote:
> >> Greeting,
> >>
> >> FYI, we noticed a 210.0% improvement of fwq.fwq.med due to commit:
> >
> > Well, that sounds impressive. :-)
> >
> >
> >>
> >> commit: 909c0e9cc11ba39fa5a660583b25c2431cf54deb ("cpufreq:
> >> intel_pstate: Use passive mode by default without HWP")
> >> https://git.kernel.org/cgit/linux/kernel/git/rafael/linux-pm.git
> >> intel_pstate-passive
> >>
> >> in testcase: fwq
> >> on test machine: 16 threads Intel(R) Xeon(R) CPU D-1541 @ 2.10GHz
> >> with 48G memory
> >> with following parameters:
> >>
> >>     nr_task: 100%
> >>     samples: 100000ss
> >>     iterations: 18x
> >>     cpufreq_governor: powersave
> >
> > The governor should be schedutil, though, unless it is explicitly set
> > to powersave in the test environment.
> >
> > Is that the case?
> >
> >
>
> Hi Rafael,
>
> Yes, we set to powersave for this test.

I wonder why this is done?  Is there any particular technical reason
for doing that?
