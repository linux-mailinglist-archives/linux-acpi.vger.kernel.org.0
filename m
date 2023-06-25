Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE35773CEF3
	for <lists+linux-acpi@lfdr.de>; Sun, 25 Jun 2023 09:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbjFYHdm (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 25 Jun 2023 03:33:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbjFYHdl (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 25 Jun 2023 03:33:41 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABAE71B5
        for <linux-acpi@vger.kernel.org>; Sun, 25 Jun 2023 00:33:15 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-3112f256941so1861624f8f.1
        for <linux-acpi@vger.kernel.org>; Sun, 25 Jun 2023 00:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1687678394; x=1690270394;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nMoaaCNx3twG1ycxl/WesfFQysfrMoD1rhufovtzPuY=;
        b=WKO0z8TAF54B8Al8xnQcCe2yDCh/qZgFmcO0iS+D2LusLapd1YNCVnHuHqrdegAZbC
         5/cZxh7fa5PH1qtVKaG1d+XgBH7RCc8uhAp7XJZnkwSECjtSHLA6Fu1D42DRrTIActu7
         7p2Wg0RtrBEIvAIY0LA5rc9THNirqMF2qxZn3pfshsVwZqO6RUUToCzXvmBP9Hvvy/TV
         tzHSaql39LseaPK8tCB21srI32X548Wq1e/2bCOHz/MI2wxnGl0U0gITXIGuFLraCWqe
         38MGjOywXh2cgaXGAIx35w4EEqZFLoGGdrYvsDFQ/HBNUE1JkxwY453XM3jY5R1Za2//
         dZjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687678394; x=1690270394;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nMoaaCNx3twG1ycxl/WesfFQysfrMoD1rhufovtzPuY=;
        b=kRAanLul4fh2Jo92wpIQTgrzwtJXwkqwZoMDCzbeR17y0kPAx3D2yBkIq2VEyJd00b
         pevQrCYEVXjX5fvqHeoAYzPxJW+nrQWhAMh2R5FaPc768cO6N0yXERASqdySWxk/I+wq
         ZiNzLrrIaw0oH/rRK6eG874DKtOiJxupi+eQJ6zqhbrHXlTrhbpbrzU4ujUemwpcVnwf
         0/R8VMd4V/fpEsfu31C/8O4yqrabhMF54axFGnFzJmlnneY9eH3kzFNSmI+MqJ3NYppk
         snWl5jdOl56ROvaLQAm0nYy3atpTcOiZleOwtoODdCWnKF2kpzkD01DavwJceTpQx4sN
         TCmA==
X-Gm-Message-State: AC+VfDx79C1aL8Pjvt/fbzNzEY3Q825cUOpkm60Ryee9EbjABrOt9JXJ
        I9MUHziGPfZZlB/O25GikqU89Tc0mED9Mb26tEjx1w==
X-Google-Smtp-Source: ACHHUZ5htAHjAlLvU1Hb4Gxjw3/f1jmrAmf+LuT0/BhnqrEGDtza8yGMMAWImDE1D9v1OF6uAA8CH0gu41VHfTNIlOc=
X-Received: by 2002:adf:d092:0:b0:307:7f38:37f with SMTP id
 y18-20020adfd092000000b003077f38037fmr16714130wrh.66.1687678394167; Sun, 25
 Jun 2023 00:33:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230426034001.16-1-cuiyunhui@bytedance.com> <CAMj1kXEKh9O-ndk3QFibJMYfMbG7vm-cLN2vVQM5eDsYK84NzQ@mail.gmail.com>
 <CAEEQ3wkJB5CKm33mHXUOPX5makYOHF8By6FYGnNzRkM-Mo72OQ@mail.gmail.com>
 <ZEj33QLZqEeL+/y4@FVFF77S0Q05N> <CAEEQ3wmDBJkfOeKCQfcnuE+1=1K0D2pzu+Sn+zPEWk+RHs0NFQ@mail.gmail.com>
 <CAP6exY+ydbzh1EkWTFejzwaW+PA-ySVO2Qj+CVJ1XbSMce2S9Q@mail.gmail.com>
 <CAP6exY+tqAU0j1TVEMTzTb18M6_mPH5bWWiAS=94gyDGTY3hyQ@mail.gmail.com>
 <CAEEQ3w=wBdpZWnUd2WWVBC3BtFiUp-PQtNAtdXE4cO4n0XT-fg@mail.gmail.com> <CAMj1kXFGpXEPtYpy1+bs13F2P_LLZf9rTMfYMU=6jzgd3=SEcw@mail.gmail.com>
In-Reply-To: <CAMj1kXFGpXEPtYpy1+bs13F2P_LLZf9rTMfYMU=6jzgd3=SEcw@mail.gmail.com>
From:   =?UTF-8?B?6L+Q6L6J5bSU?= <cuiyunhui@bytedance.com>
Date:   Sun, 25 Jun 2023 15:33:03 +0800
Message-ID: <CAEEQ3wnbXE0vJnQRLo5MhfDc-Q4PbNWBoWS-oMn71CcJU51JdA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] firmware: added a firmware information
 passing method FFI
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     ron minnich <rminnich@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>, rafael@kernel.org,
        lenb@kernel.org, jdelvare@suse.com, yc.hung@mediatek.com,
        angelogioacchino.delregno@collabora.com,
        allen-kh.cheng@mediatek.com, pierre-louis.bossart@linux.intel.com,
        tinghan.shen@mediatek.com, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, geshijian@bytedance.com,
        weidong.wd@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Ard,

On Sat, Jun 24, 2023 at 8:52=E2=80=AFPM Ard Biesheuvel <ardb@kernel.org> wr=
ote:
>
> How do you intend to provide the ACPI core with the memory attribute
> information that it needs to access SystemMemory OpRegions?

Regarding memory segments and attributes, our solution does not need
to build a memmap table in coreboot like EFI to connect to linux ACPI
core.

Because the memory segment and attributes have been passed through the
"memory" node and "reserved-memory" node attributes of DTS.

For Linux, no matter what kind of memory attributes of the firmware,
it is ultimately connected to the memblock module.

So the memory attributes you consider can be done through the existing
DTS (like Ron said before, Chrombook does everything through DTS).

So can we come to a consensus? Then start reviewing the code?

Thanks,
Yunhui
