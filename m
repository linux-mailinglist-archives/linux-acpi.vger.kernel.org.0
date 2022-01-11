Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56EBB48B157
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Jan 2022 16:53:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349693AbiAKPw6 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 11 Jan 2022 10:52:58 -0500
Received: from mail-qv1-f48.google.com ([209.85.219.48]:41848 "EHLO
        mail-qv1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbiAKPw6 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 11 Jan 2022 10:52:58 -0500
Received: by mail-qv1-f48.google.com with SMTP id hu2so18747506qvb.8
        for <linux-acpi@vger.kernel.org>; Tue, 11 Jan 2022 07:52:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nynSAccmbpFQXMIOtbvj7qX+Qb+l9/00fgfzXa3Y82w=;
        b=T3n/gl/7nm2HLYSXMgBJN+oeidrQvWTOZvS1bD80AQR7Sb+l5n9IRx9mef9u9LnaEe
         JPI9QIPYIghViDiBWN9fJB7UlU/y5r+pdP2uSWWauh2J8ZFcUUcf5XhI0+naAqDWeLRb
         WqGm6q6pEHffwckPRD63LrzuUI3q1FzVC/cgIHSuWT8PwB67jZ6C0XgrJ8Cg+LJuJuRo
         6Fx9w8XpU2FGS/rSCNr5KY+hDs0K3FM4oyK2Z4vmai4msWY+Nv3X80pR/lNDUfk2XtA3
         FWt5wFtyg8kCnibLiOa/qZBgvZ+rhkEloVaN8FOvhPSrNa/upvaNZDeEPHSjVh8iqJP5
         RMgg==
X-Gm-Message-State: AOAM531Lqaa2lQiOSIL5gnM8DtU1OVvMVq2KFXETNlrLQsJfdEU1JjZz
        tl06KfG9Mo/0SagqAxo+t8PkLPN7aP948oIxOZw=
X-Google-Smtp-Source: ABdhPJyckBmy6Kkb2GE+4cFicmBDqEXBb233At9WH01P3w93SryGE+74gudOh9sd76uscUkqDMKbpdobqI3LBnhP4t8=
X-Received: by 2002:a05:6214:508b:: with SMTP id kk11mr4357485qvb.61.1641916377930;
 Tue, 11 Jan 2022 07:52:57 -0800 (PST)
MIME-Version: 1.0
References: <20220105193910.25678-1-mario.limonciello@amd.com>
In-Reply-To: <20220105193910.25678-1-mario.limonciello@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 11 Jan 2022 16:52:47 +0100
Message-ID: <CAJZ5v0g-q4SLfK65bvWum7+OQZgbNQs47Pu3y-BCs9Px2C3Jag@mail.gmail.com>
Subject: Re: [PATCH 0/3] On AMD platforms only offer s2idle w/ proper FW
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Jan 5, 2022 at 8:39 PM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> Currently the Linux kernel will offer s2idle regardless of whether the FADT
> indicates the system should use or on X86 if the LPS0 ACPI device has been
> activated.
>
> On some non-AMD platforms s2idle can be offered even without proper
> firmware support.  The power consumption may be higher in these instances
> but the system otherwise properly suspends and resumes.

Well, the idea is that s2idle should not require FW support at all.

It may not be possible to reach the minimum power level of the
platform without FW support, but that should not prevent s2idle from
being used.

> On AMD platforms however when the FW has been configured not to offer
> s2idle some different hardware initialization has occurred such that the
> system won't properly resume.

That's rather unfortunate.

Can you please share some details on what's going on in those cases?

Technically, without FW support there should be no difference between
the platform state reachable via s2idle and the platform state
reachable via runtime idle.
