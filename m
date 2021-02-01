Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9435930A6BC
	for <lists+linux-acpi@lfdr.de>; Mon,  1 Feb 2021 12:43:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbhBALnt convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Mon, 1 Feb 2021 06:43:49 -0500
Received: from mail-oi1-f172.google.com ([209.85.167.172]:44363 "EHLO
        mail-oi1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbhBALnt (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 1 Feb 2021 06:43:49 -0500
Received: by mail-oi1-f172.google.com with SMTP id n7so18416421oic.11
        for <linux-acpi@vger.kernel.org>; Mon, 01 Feb 2021 03:43:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uZn7ZnnuCBX/W22GeRC16TXeNlhza967RHxAmFxVnzU=;
        b=FJ66a0hFWqVNiPY0ItGkKSuN4tbmPaF3H8aKh5XzFN6dEhN/Iau8gO423z7GF4Qa2q
         wT4mJV15Sj231q+WyojI8VYPvUs2s69TJd53N706md7vWInbUen0EglenNN8GkiqEyVv
         bH1cgWiySGeKnWE/3Y/uHHo3Zv8sboy+TeChcvrZuEIgXaB0q08ZIMBRglacNzfS7jIj
         ne7jmHqaogiHWWbepzFopCK5cdM88DE8iMNs6tzaAkjwj6DGrML+z++5YdKm/lTrW9cs
         5jSvzqdZrzOYqRg8MrSmdvtKbxP4CZ8UeUvmiRzbkm1lP5sN+MBPBD9YRAeFf+D8S9k1
         xWFQ==
X-Gm-Message-State: AOAM530edT5eCROIYYnrhcn7iPz9K278gmF4w2NOwBGowKg5iT/KT+M2
        hHLmW671c5WGhN9bkf9I6gctVso03C4bznt8eew=
X-Google-Smtp-Source: ABdhPJwQnP3u+qOoXMxYe6YhYqIR6+9UKvF8rIWwtA83rZ95dumube+bnWK+S3cxixTLoNX1L1XuYy6tcwYgDyB6RSY=
X-Received: by 2002:aca:d14:: with SMTP id 20mr11071141oin.157.1612179787831;
 Mon, 01 Feb 2021 03:43:07 -0800 (PST)
MIME-Version: 1.0
References: <CA+GA0_sPC3rp5K4qwZm-u+W1C=+2Y2p-dbF4DMdHkKaTpeKKkg@mail.gmail.com>
 <CAJZ5v0iapmc8ywuySwexwTagKr89Hj7TPXkAvd_HXMhdLoyyQQ@mail.gmail.com>
 <1f0f7273-597e-cdf0-87d1-908e56c13133@linux.intel.com> <CA+GA0_v3JUWS3G3=R4XuQ=OW91cpwiBP1Rp=uzYOF8c9TUJ46w@mail.gmail.com>
 <CA+GA0_sCdowanpZmg==c+xVqqNxG5whLGsKHaCfSmpERBhqMzA@mail.gmail.com>
 <1dc2639a-ecbc-c554-eaf6-930256dcda96@linux.intel.com> <CA+GA0_sZm2pqOfA3LsNQowb930QS_g5CiCCGthzsS=vAjB9Rjg@mail.gmail.com>
 <CAJZ5v0h+Kwn5u293QO+H2rfGx-ZMBr18tMCLB7jHKHWWRaovOw@mail.gmail.com>
 <CAJZ5v0h8abkdrdN97RHouzxynPBFXBoAuMSb7Zy56+-sTXkPKQ@mail.gmail.com>
 <CA+GA0_vYdxFj_SPWgdkufo04VaOuWqcNTSck6gvnMfN07ZdO_Q@mail.gmail.com>
 <CA+GA0_vKyJZSQZ9bA6_BSDeGfRZ_nz86gj2aVHaOoy1h57CMzA@mail.gmail.com> <CA+GA0_u8NA90GmMSDO-Ejg-C2YEXCn8rnVZpk-_+eXcDm7XRpg@mail.gmail.com>
In-Reply-To: <CA+GA0_u8NA90GmMSDO-Ejg-C2YEXCn8rnVZpk-_+eXcDm7XRpg@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 1 Feb 2021 12:42:53 +0100
Message-ID: <CAJZ5v0hqHihRdad16Djo+R1ezjFHt2YffgDg59TYYKJSSjmA4Q@mail.gmail.com>
Subject: Re: Crash in acpi_ns_validate_handle triggered by soundwire on Linux 5.10
To:     =?UTF-8?Q?Marcin_=C5=9Alusarz?= <marcin.slusarz@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        Erik Kaneda <erik.kaneda@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Jan 29, 2021 at 9:03 PM Marcin Ślusarz <marcin.slusarz@gmail.com> wrote:
>
> pt., 29 sty 2021 o 19:59 Marcin Ślusarz <marcin.slusarz@gmail.com> napisał(a):
> >
> > czw., 28 sty 2021 o 15:32 Marcin Ślusarz <marcin.slusarz@gmail.com> napisał(a):
> > >
> > > czw., 28 sty 2021 o 13:39 Rafael J. Wysocki <rafael@kernel.org> napisał(a):
> > > > The only explanation for that I can think about (and which does not
> > > > involve supernatural intervention so to speak) is a stack corruption
> > > > occurring between these two calls in sdw_intel_acpi_cb().  IOW,
> > > > something scribbles on the handle in the meantime, but ATM I have no
> > > > idea what that can be.
> > >
> > > I tried KASAN but it didn't find anything and kernel actually booted
> > > successfully.
> >
> > I investigated this and it looks like a compiler bug (or something nastier),
> > but I can't find where exactly registers get corrupted because if I add printks
> > the corruption seems on the printk side, but if I don't add them it seems
> > the value gets corrupted earlier.
> (...)
> > I'm using gcc 10.2.1 from Debian testing.
>
> Someone on IRC, after hearing only that "gcc miscompiles the kernel",
> suggested disabling CONFIG_STACKPROTECTOR_STRONG.
> It helped indeed and it matches my observations, so it's quite likely it
> is the culprit.
>
> What do we do now?

Figure out why the stack protection kicks in, I suppose.

The target object is not on the stack, so if the pointer to it is
valid (we need to verify somehow that it is indeed), dereferencing it
shouldn't cause the stack protection to trigger.
