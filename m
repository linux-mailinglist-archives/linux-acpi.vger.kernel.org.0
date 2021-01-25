Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19145302A71
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Jan 2021 19:40:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbhAYSjj (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 25 Jan 2021 13:39:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbhAYSj1 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 25 Jan 2021 13:39:27 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AD56C061573
        for <linux-acpi@vger.kernel.org>; Mon, 25 Jan 2021 10:38:46 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id z22so2024920edb.9
        for <linux-acpi@vger.kernel.org>; Mon, 25 Jan 2021 10:38:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dcK6x8/xylIn/6sMBxgIE4nEmQQwcKCRnSaqPeAZV6Y=;
        b=V4PO+ChCop+DUjlE39lf8SRRV092WMf5qzSQX2R7UgeoDE99NBpw0iADEHhIiUBbUR
         hsCq+ctGsKS0ghVcjjo8yJyz8HiHpeFAgE3BAJpZjR6R+YcqHz18srvEpdqxa35T8i7B
         2hJb7pB1/oE0G0jb040zF0fQNXeWMDZnlABdNxCnnjeo4eKtDAUoIUaR4lKGHAwIMEkB
         CbEMeXSSHg+D+1IDtDhr7hek9khDF9OdJ2mKDYstNjRZQ6W1b3BP4VoUig4Mkrcb5b5m
         +fTvt5gfO3L60n6f1rkFYqm/9fNUob6lm1i+vXjM9gw46PNfWG6/O70jqBqQdKLdl1q3
         IT4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=dcK6x8/xylIn/6sMBxgIE4nEmQQwcKCRnSaqPeAZV6Y=;
        b=tWcZw6z6dVr+UAg0HxqeNY4Kf03yWMdWx5YZdvz1hiDrXOzM+f3f7RenqnyijNtDKc
         GqlPljqCqhX98k72MVMte/bzDxCiS4tIm39lr46ktov1H2zUHaGneg5fnkARLgNR2EkF
         Y5139RO7KNEgpQ58GeYzGJBfiEtYb3btzTJqPnIu8pEWDkwzcJrObwdbFvB2m1bMbve3
         iCOqe4cBV069QRNQs8ARW+3YkWfjtVDXHRKERcTDFgyQ7spGFtXRCTCnYtMLezPYGNX4
         EWZGOtPY0gVufvppK8XMtQJ/NPs8xvbWDimG0ZcsnJEQE5x984UtD9QdFxq7eLC/bxGN
         0IYg==
X-Gm-Message-State: AOAM531lk0sVJtv5mpNpaRgziTp35ZN5rY7mIVrxKdjgBEEhGSXUUy+l
        BfdiLcgSf5yCTUjC4u4Z05c=
X-Google-Smtp-Source: ABdhPJyG2PmQiYa0+nA52Lnq12fuh+2M0Mq2EMEuMQf63aO4B1XMZLZUSurnBCqiE1ID8ieWa479/A==
X-Received: by 2002:aa7:cd07:: with SMTP id b7mr1594290edw.29.1611599925261;
        Mon, 25 Jan 2021 10:38:45 -0800 (PST)
Received: from eldamar (80-218-24-251.dclient.hispeed.ch. [80.218.24.251])
        by smtp.gmail.com with ESMTPSA id ko23sm8850110ejc.35.2021.01.25.10.38.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 10:38:44 -0800 (PST)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Date:   Mon, 25 Jan 2021 19:38:43 +0100
From:   Salvatore Bonaccorso <carnil@debian.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Marcin =?utf-8?Q?=C5=9Alusarz?= <marcin.slusarz@gmail.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Len Brown <lenb@kernel.org>, Kubo Hiroshi <hkubo@jiubao.jp>
Subject: Re: Crash in acpi_ns_validate_handle triggered by soundwire on Linux
 5.10
Message-ID: <YA8QM98xrHyefa7g@eldamar.lan>
References: <CA+GA0_sPC3rp5K4qwZm-u+W1C=+2Y2p-dbF4DMdHkKaTpeKKkg@mail.gmail.com>
 <CAJZ5v0iapmc8ywuySwexwTagKr89Hj7TPXkAvd_HXMhdLoyyQQ@mail.gmail.com>
 <1f0f7273-597e-cdf0-87d1-908e56c13133@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f0f7273-597e-cdf0-87d1-908e56c13133@linux.intel.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

As an additional datapoint if this can help:

On Wed, Jan 20, 2021 at 04:28:23PM -0600, Pierre-Louis Bossart wrote:
> 
> 
> 
> > > Linux 5.10 fails to boot on my IceLake laptop, where 5.9 worked fine.
> > > I'm not sure whether it's a bug in ACPI or Soundwire subsystem, so I'm
> > > sending this to both
> > > lists. The W taint flag is because of an unrelated nouveau failure (It
> > > was busted on 5.9, and is
> > > still on 5.10). Full kernel log down below.
> > > It's from a distro kernel, but I can build my own kernel with patches if needed.
> > 
> > Please try to add a check for handle against NULL to
> > snd_intel_dsp_check_soundwire() after
> > 
> > handle = ACPI_HANDLE(&pci->dev);
> > 
> > and see if this makes any difference.
> > 
> > This should check handle against NULL anyway, even if it didn't crash later on.
> 
> Is there a way you can share the DSDT?
> 
> The only thing we do in that sdw_intel_acpi_scan() function is check for an
> _ADR and read two _DSD properties. I think it's been 2 years since we wrote
> it and never had an issue, never say never I guess...
> 
> If you want to bypass this problem for the time being, you can add a kernel
> option in /etc/modprobe.d/alsa-base.conf
> 
> options snd-intel-dspcfg dsp_driver=1
> 
> that will force the use of the HDaudio legacy driver and bypass the driver
> autodetection.

A user in Debian,  Kubo Hiroshi reported what seems to be the same
issue in https://bugs.debian.org/981003 .

Regards,
Salvatore
