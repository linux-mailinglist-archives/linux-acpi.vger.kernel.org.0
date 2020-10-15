Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9011A28F210
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Oct 2020 14:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726103AbgJOM2g (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 15 Oct 2020 08:28:36 -0400
Received: from mail-ot1-f54.google.com ([209.85.210.54]:44397 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727988AbgJOM2e (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 15 Oct 2020 08:28:34 -0400
Received: by mail-ot1-f54.google.com with SMTP id e20so2671741otj.11;
        Thu, 15 Oct 2020 05:28:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PrP8EDXj/tPbjTGXn3kj+pdKTbRL6d9Pe6W+rT9RKYE=;
        b=t4/6ZTn74v3uCUX3JYxWg7Ouc4A5vot5ehadzsw/qbnpuxK87DIUVYIX1yz6cPX6xP
         EPgTWSyDszvgyB5zT2WkT8OA07ty1YoxC2a5XeiNxrTjRfPhGJ2CwMbRPz6pqbN3UhOs
         o5LyGiKQ2IhkIAR6Dr0fstJICJAD/Ttv5rsg540Vw+N1Srmkal3fk/uGTPdxNKfMdurJ
         R4fFdPdR46Q+38ylmrcZ/oQXi/CDKStnYdAx3N251DFoCzSoXFbOkpPQXDhlOOazZmEb
         UKIZzd9P5E39dxjUTAjQ8YSLB88Zs887j1WKf0jszC6zvvTY8u7aoYYdA4DF6AWYZir8
         Kefg==
X-Gm-Message-State: AOAM531eezQtIGg2dHBMRnIH8bdRDBLqrpBUiVXXOatj64561njHQCPg
        JESm72qYx6AKsEv5013FHxQ/mAUw7gnHkyxXGpQ/R9+f
X-Google-Smtp-Source: ABdhPJx7Znl8vuMykbq/96/l6Tonm0K3cUNheFN4a9cmZ0g1qKps5fVO7SbgUW1F+wQ9SSK0iXcHHqHeT4mHxAUmyx0=
X-Received: by 2002:a9d:ac9:: with SMTP id 67mr2562183otq.321.1602764913634;
 Thu, 15 Oct 2020 05:28:33 -0700 (PDT)
MIME-Version: 1.0
References: <20201015095311.GA11838@zn.tnic> <20201015095851.GB11838@zn.tnic>
 <d6cdf27b-04ef-7bc8-03ef-2115ca08bffe@intel.com> <20201015120639.GE11838@zn.tnic>
In-Reply-To: <20201015120639.GE11838@zn.tnic>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 15 Oct 2020 14:28:22 +0200
Message-ID: <CAJZ5v0g-8gcWNrnFDvcaVRb3qC1vbjsbp7o_6YUf-9uaADR94A@mail.gmail.com>
Subject: Re: DPTF_POWER and DPTF_PCH_FIVR
To:     Borislav Petkov <bp@alien8.de>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        lkml <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Oct 15, 2020 at 2:06 PM Borislav Petkov <bp@alien8.de> wrote:
>
> On Thu, Oct 15, 2020 at 01:31:55PM +0200, Rafael J. Wysocki wrote:
> > Well, they depend on ACPI too and it doesn't look like there is anything
> > more fine grained that could be used here.
> >
> > Also I'm not sure if adding ACPI_DPTF (bool, disabled by default and
> > depending on x86) would help a lot.
>
> So you're saying this is going to be present in current and future
> hardware so might as well enable it?

Yes.  [Only on clients AFAICS, but still.]

In the meantime I have concluded that having a submenu for it would
make sense, though.  At least from the clarity POV.
