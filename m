Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDD21401AE0
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Sep 2021 14:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241624AbhIFMEW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Mon, 6 Sep 2021 08:04:22 -0400
Received: from mail-ot1-f47.google.com ([209.85.210.47]:36786 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238900AbhIFMEI (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 6 Sep 2021 08:04:08 -0400
Received: by mail-ot1-f47.google.com with SMTP id a20-20020a0568300b9400b0051b8ca82dfcso8508411otv.3;
        Mon, 06 Sep 2021 05:03:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cxnMxCtKUlRmpKQo1q76tA0Pg/szRpejrv4RrJGuv64=;
        b=cMu2WTdI+y9p8QvPQEKuCcAzBNhrDEReV+zcYMK2UU/wjfzuYCswzRbpbQRo4pNok5
         bxJixmhT6Jft0GUt892rKbsRAsRJOaXn3ZGw4HqAmfndS/JPD0o3icGHkpS164bXi0vZ
         vTE5EjW6drl2Bopai4PVSNV5v3hay8LjHKlANOYF9ooB3ftngNBqJXpDvS6ZBMhUUq6n
         IpjSgCQ8NwzR0DPf2CPBAYS8hK4n1bIyigErXSVYtXmxpLYkC1K29vEfcouo7GpIgMhm
         mwDQkUPR+5HHcPF82UU2+X7C6EctOnAIwq6Hg+jht+dQiWilkCA/ytlyhYiJkfXY1vd1
         qEsg==
X-Gm-Message-State: AOAM532r0gt8kq07s9F/5Mc7/m/s6L0+MBh+x6XSdkFXbJe9ePnqgiw3
        5WdoaJUsdxjBdlsbSrRp2lPoGLBgCP3L/sgpFjM=
X-Google-Smtp-Source: ABdhPJyVHMF4axc5sJt9c9AR3QEI7XMCWPLcOHQG0lA8ye5NeZYJZ1KFtCKn895Ncy5RUuvWMwibarFzJhmNnua/kaA=
X-Received: by 2002:a9d:4d93:: with SMTP id u19mr10412050otk.86.1630929782506;
 Mon, 06 Sep 2021 05:03:02 -0700 (PDT)
MIME-Version: 1.0
References: <64150c95-3f7d-d21f-d6fb-b9d478ed6798@molgen.mpg.de> <766862fc-80fa-775b-6e63-6d9422d1d258@molgen.mpg.de>
In-Reply-To: <766862fc-80fa-775b-6e63-6d9422d1d258@molgen.mpg.de>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 6 Sep 2021 14:02:47 +0200
Message-ID: <CAJZ5v0i91+kPe4C-wy+oCDvYbR_Vp=MzwEyL+8T3xJU5O4XjRA@mail.gmail.com>
Subject: Re: New warning: PRMT not found
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Sep 6, 2021 at 1:51 PM Paul Menzel <pmenzel@molgen.mpg.de> wrote:
>
> Dear Rafael, dear Len,
>
>
> Intel’s MTA rejects Erik’s address:
>
>      <erik.kaneda@intel.com>: host mga17.intel.com[192.55.52.151] said:
> 550 #5.1.0
>          Address rejected. (in reply to RCPT TO command)
>
> So, I assume Erik left Intel.
>
>
> Am 26.07.21 um 09:42 schrieb Paul Menzel:
> > Dear Erik,
> >
> >
> > The new code added in commit cefc7ca462 (ACPI: PRM: implement
> > OperationRegion handler for the PlatformRtMechanism subtype) causes
> > Linux to log a warning on my desktop system Asus F2A85-M PRO.
> >
> >      PRMT not found
> >
> > The help text for the Kconfig option `ACPI_PRMT` suggests it’s mainly
> > used for server systems, so the warning does not apply to a lot of
> > systems. Therefore, in my opinion, the option should not be selected by
> > default, or the warning be removed or demoted, and phrased in a way,
> > that users can understand the consequences.
>
> The new warning shows up on a lot of systems, with no indication what to
> do about it or why Linux actually warns about it.
>
> Should the message be removed entirely? Or is there another indicator
> for systems where absent PRMT causes problems, so should be warned about?

This should be addressed by commit 2bbfa0addd63 "ACPI: PRM: Deal with
table not present or no module found", or yet another fix is needed.

Thanks!
