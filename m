Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9128122697
	for <lists+linux-acpi@lfdr.de>; Tue, 17 Dec 2019 09:24:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725940AbfLQIX1 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 17 Dec 2019 03:23:27 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:42954 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbfLQIX1 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 17 Dec 2019 03:23:27 -0500
Received: by mail-ot1-f68.google.com with SMTP id 66so12750373otd.9;
        Tue, 17 Dec 2019 00:23:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JMeW8IXOTJKgWI7xudgMEupdZiEmd53J2UWjz91+kjc=;
        b=sM31rMZapetO6Ni7ou9+CBdLG1gbYNU7NYP1rj0l3aQkRWzwQX4AqGDtp6TSm4D5Z8
         ilF31TiA9TODiPMBav1uFEhOPdBeE3eWrBtwNbsQVTeizf3fguOVSly4Z4y3LyEhe8Jg
         qe0SebMMheb1ukEK/hZzg/BOJVhR8G0rcN5uOScP51ux06GZnB2KbrJVDeNVoojInObz
         QefH0vJu3H4Rp0bdj5ERsn9NVd//T5pfrOe+wfPiZ2sb18eSXmwTrMgUsNRtkQ0RcSl0
         QhZAI10XzQDoze1QEXjbUntUez1xxnPWEfDBk9A5dKO72GfzwEUE4jGAmucWxGOOs97T
         CPWQ==
X-Gm-Message-State: APjAAAXI/l0wKvViqQZnMrGMoHqgf+HeLzpEeDgt9l9T+l+OC5N4zq4w
        5b78rlVPOiBjIHpjljY4+ShwDmBmZ218sph8RNyNtw==
X-Google-Smtp-Source: APXvYqwU6UFXX7ZWRxkmNxJknYkkQQJcxP69ST8Knq9cN3tyhoz7l2BTSbOZP1Sd1lP9XXAK5Dfdz1cAJ0+8CWWQ6uA=
X-Received: by 2002:a05:6830:4b9:: with SMTP id l25mr37484806otd.266.1576571006380;
 Tue, 17 Dec 2019 00:23:26 -0800 (PST)
MIME-Version: 1.0
References: <201912162148.hTRbNfPp%lkp@intel.com> <CAJZ5v0iTOSnvZqKuL7gy7QBtdHxcM7wPS8qdgbvs6+sQxZX5yg@mail.gmail.com>
 <831EE4E5E37DCC428EB295A351E66249522A215D@shsmsx102.ccr.corp.intel.com>
In-Reply-To: <831EE4E5E37DCC428EB295A351E66249522A215D@shsmsx102.ccr.corp.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 17 Dec 2019 09:23:14 +0100
Message-ID: <CAJZ5v0gFbjbqTOD845RjzpJQXQY=ko=9GxwVxoqw0fPccfig4w@mail.gmail.com>
Subject: Re: [kbuild-all] Re: [pm:intel_idle+acpi 4/10] acpi_processor.c:undefined
 reference to `acpi_processor_ffh_cstate_probe'
To:     "Li, Philip" <philip.li@intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>, lkp <lkp@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Dec 17, 2019 at 1:31 AM Li, Philip <philip.li@intel.com> wrote:
>
> > Subject: [kbuild-all] Re: [pm:intel_idle+acpi 4/10] acpi_processor.c:undefined
> > reference to `acpi_processor_ffh_cstate_probe'
> >
> > On Mon, Dec 16, 2019 at 2:26 PM kbuild test robot <lkp@intel.com> wrote:
> > >
> > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
> > intel_idle+acpi
> > > head:   dcedc03145600b929a32acb85b212131b079bc46
> > > commit: 0300cf31f061e6287810c894337f29df2e200e2d [4/10] ACPI: processor:
> > Export acpi_processor_evaluate_cst()
> >
> > Outdated.  Please stop sending these.
> thanks for the input Rafael, we will ignore the following tests on it.

Well, the branch has been rebased since then and effectively it is a new one.

My point is that if something like that happens, the script should
discard the old branch and pull the new one from scratch.
