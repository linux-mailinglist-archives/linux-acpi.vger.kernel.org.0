Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEDFD30782C
	for <lists+linux-acpi@lfdr.de>; Thu, 28 Jan 2021 15:36:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231373AbhA1Odi (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 28 Jan 2021 09:33:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231159AbhA1Odf (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 28 Jan 2021 09:33:35 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CCB9C061573
        for <linux-acpi@vger.kernel.org>; Thu, 28 Jan 2021 06:32:54 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id f16so4476587wmq.5
        for <linux-acpi@vger.kernel.org>; Thu, 28 Jan 2021 06:32:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RgS33G5QpkhweaMQZ/TRkHVV39bMFkPn1ijz5ZbkFpA=;
        b=ESlRX4mhGhk7EzrC+L7ikmD+Gk4yC+pCaLbT3ZXZfJp+xGElcG5VdkzTaaBZhSK+6I
         4W8wWr2rMUpCaPiA8DlmnrmS6L2/cPS0GdQbzFXJbohe5vG7vjLSuagPT0mo6qvFLbaQ
         9i4V1NEs7FlTdEsEwdgKZeQzMAoS/nAnG/BaSVXEQOU0r58mdy1vx/QTNcTrdZlXweUZ
         UyqZc79EFi79Hnl2+mqsVUiS3czJWAriMWlQ7wjMUWhH+I3XXVYvVwRlDIRR5zbnxqU1
         Kiox9uT70oaKF+A/B8bptmXyBZZK/AKpCYbfhE3Psbk1jodcKXfpxMmWzRm27PBiuEQ6
         xMuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RgS33G5QpkhweaMQZ/TRkHVV39bMFkPn1ijz5ZbkFpA=;
        b=LWkbAj+GYTrtHDeBv5ksOsqhgMhcNg7cduEs/x3txuN5Xp0OgoMl4o0nJrfSWH9zvL
         +xCaIuXLGjm0Qo0eFWeQkZTZFF/7kynhlGwk26y485qbY6VqKzVMZEflXGObGjrrBVaK
         7meD1w+7d8ubtELwQrADJjEla8jEKpQl2wydfZCtgY//ItGP2qVjKQUavbsb5czHZox3
         2ZxFEH/oYLpvUiNMWe1EWbNeAfLbePMuTRwo8szW4t8LJ1u6O+Pn8WgnGEMgNuX4gr/I
         n/RjGusGmGwg802njzY93ej9WjFzJuiCuiiiYyNZTffKJXJb/wE7ZVlgkfmXbYH3v03/
         e2Zw==
X-Gm-Message-State: AOAM530YYr64YeX8rbr3Ysy/0F591WJZ7Fs3rl+bexw/tevDH02C2Uol
        hOXgdpipouo3NcFFNh8xr+4/HU47LHZjkqeXmFc=
X-Google-Smtp-Source: ABdhPJy/rfCKGga6jpnBvbZP6RfUs4yzsi62pCuciAd3dV+sjkluWG5HRG/OMKS6llrBEHYMhQXpN3tbeR5L0dC/+zo=
X-Received: by 2002:a1c:e0d4:: with SMTP id x203mr8948783wmg.160.1611844373331;
 Thu, 28 Jan 2021 06:32:53 -0800 (PST)
MIME-Version: 1.0
References: <CA+GA0_sPC3rp5K4qwZm-u+W1C=+2Y2p-dbF4DMdHkKaTpeKKkg@mail.gmail.com>
 <CAJZ5v0iapmc8ywuySwexwTagKr89Hj7TPXkAvd_HXMhdLoyyQQ@mail.gmail.com>
 <1f0f7273-597e-cdf0-87d1-908e56c13133@linux.intel.com> <CA+GA0_v3JUWS3G3=R4XuQ=OW91cpwiBP1Rp=uzYOF8c9TUJ46w@mail.gmail.com>
 <CA+GA0_sCdowanpZmg==c+xVqqNxG5whLGsKHaCfSmpERBhqMzA@mail.gmail.com>
 <1dc2639a-ecbc-c554-eaf6-930256dcda96@linux.intel.com> <CA+GA0_sZm2pqOfA3LsNQowb930QS_g5CiCCGthzsS=vAjB9Rjg@mail.gmail.com>
 <CAJZ5v0h+Kwn5u293QO+H2rfGx-ZMBr18tMCLB7jHKHWWRaovOw@mail.gmail.com> <CAJZ5v0h8abkdrdN97RHouzxynPBFXBoAuMSb7Zy56+-sTXkPKQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0h8abkdrdN97RHouzxynPBFXBoAuMSb7Zy56+-sTXkPKQ@mail.gmail.com>
From:   =?UTF-8?Q?Marcin_=C5=9Alusarz?= <marcin.slusarz@gmail.com>
Date:   Thu, 28 Jan 2021 15:32:37 +0100
Message-ID: <CA+GA0_vYdxFj_SPWgdkufo04VaOuWqcNTSck6gvnMfN07ZdO_Q@mail.gmail.com>
Subject: Re: Crash in acpi_ns_validate_handle triggered by soundwire on Linux 5.10
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        Erik Kaneda <erik.kaneda@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

czw., 28 sty 2021 o 13:39 Rafael J. Wysocki <rafael@kernel.org> napisa=C5=
=82(a):
> The only explanation for that I can think about (and which does not
> involve supernatural intervention so to speak) is a stack corruption
> occurring between these two calls in sdw_intel_acpi_cb().  IOW,
> something scribbles on the handle in the meantime, but ATM I have no
> idea what that can be.

I tried KASAN but it didn't find anything and kernel actually booted
successfully.

Comparing to the initial log, there are some new ACPI messages,
but they were present also in the log with acpi_debug enabled:

"No Local Variables are initialized for Method [_STA]
No Arguments are initialized for method [_STA]"

Full kernel log here:
https://people.freedesktop.org/~mslusarz/tmp/kasan.txt
