Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E684DC0DC
	for <lists+linux-acpi@lfdr.de>; Fri, 18 Oct 2019 11:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409691AbfJRJ1G (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 18 Oct 2019 05:27:06 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:40286 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390443AbfJRJ1G (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 18 Oct 2019 05:27:06 -0400
Received: by mail-ot1-f65.google.com with SMTP id y39so4390078ota.7;
        Fri, 18 Oct 2019 02:27:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WFCHWMpuOvk4Jfe0cTEExOuAzfZ+RF4o0B7Uope7Uy8=;
        b=q/eHwS61dV5wCG71vH8/Dz/Gt/tearl3+Uik1DP0mWR+2k2s3FgRAdN48biaFyRcjT
         tMf/AuFCHqxsPgUz9y+AfiiTaj7wValxNNx1Pj5vUNjiztPBcoRNnCKggcasXaaC/reS
         m2MNf27dv1DgLiHOv8DaUje9S+7IjXb0CUdRuF9TWOJA8vEY/59SGmGMS2xV3ndsG6i8
         QLZp4I91UYvPV8qHDNj2N8xRjxI8M/qRqqiMuq5Sb0Lg6LVFn/THJlls2a9Y69WOmOzn
         Fem+1tjau55y+0rdfXHq0Vb97QQ7UDl8W0lVifNpY1kuJsMfHlKsNeCWn4MW83KqPCB7
         uWuw==
X-Gm-Message-State: APjAAAWX5DBDH2GoFzYmCH0CvgOnjhJ5ZkltHyb8tukez14dzj3UlHTB
        RrrEy6b9hd4IxHIwbLElRwVEZjGCVHhWSoNwmp1XpQ==
X-Google-Smtp-Source: APXvYqya815uon46X6ZdQgw//057c7fKahm7VPCQTdOF2gkg3Gt2kr4c6a0k71jx5wPq06RXRMuVpt5Z3mVkg0JKRQ8=
X-Received: by 2002:a9d:664:: with SMTP id 91mr414823otn.189.1571390823637;
 Fri, 18 Oct 2019 02:27:03 -0700 (PDT)
MIME-Version: 1.0
References: <2811202.iOFZ6YHztY@kreacher> <20191016142343.GB5330@bogus>
 <20191017095725.izchzl7enfylvpf3@vireshk-i7> <20191017095942.GF8978@bogus>
 <CAJZ5v0ixS8ZS93Fgj8XGUMGcLdAy+Fgwp5z3QirccNSiiwLtDA@mail.gmail.com>
 <20191018054433.tq2euue675xk4o63@vireshk-i7> <CAJZ5v0hpfvy5iELVRWFA3HS8NoAH0=py0cE+fLaUq2hDReCrnQ@mail.gmail.com>
 <20191018082745.3zr6tc3yqmbydkrw@vireshk-i7> <CAJZ5v0gR45YNwqrc8JQ_2qQBnYrxPeCHTnvQtEELD8VpXJrxLA@mail.gmail.com>
 <20191018092447.2utqazqfob65x4k2@vireshk-i7>
In-Reply-To: <20191018092447.2utqazqfob65x4k2@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 18 Oct 2019 11:26:52 +0200
Message-ID: <CAJZ5v0hZc5g+AUDSJUkaGSA92mKNSXGyHLd5Qxuf88wP1i4AdA@mail.gmail.com>
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

On Fri, Oct 18, 2019 at 11:24 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 18-10-19, 10:30, Rafael J. Wysocki wrote:
> > On Fri, Oct 18, 2019 at 10:27 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > >
> > > On 18-10-19, 10:24, Rafael J. Wysocki wrote:
> > > > On Fri, Oct 18, 2019 at 7:44 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > > > >
> > > > > On 17-10-19, 18:34, Rafael J. Wysocki wrote:
> > > > > > [BTW, Viresh, it looks like cpufreq_set_policy() should still ensure
> > > > > > that the new min is less than the new max, because the QoS doesn't do
> > > > > > that.]
> > > > >
> > > > > The ->verify() callback does that for us I believe.
> > > >
> > > > It does in practice AFAICS, but in theory it may assume the right
> > > > ordering between the min and the max and just test the boundaries, may
> > > > it not?
> > >
> > > I think cpufreq_verify_within_limits() gets called for sure from
> > > within ->verify() for all platforms
> >
> > That's why I mean by "in practice". :-)
>
> Hmm, I am not sure if we should really add another min <= max check in
> cpufreq_set_policy() as in practice it will never hit :)

Fair enough, but adding a comment regarding that in there would be prudent IMO.


>
> --
> viresh
