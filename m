Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 928DD73D0AE
	for <lists+linux-acpi@lfdr.de>; Sun, 25 Jun 2023 13:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231960AbjFYLzP (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 25 Jun 2023 07:55:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230457AbjFYLzE (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 25 Jun 2023 07:55:04 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F7D7E40
        for <linux-acpi@vger.kernel.org>; Sun, 25 Jun 2023 04:54:40 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-313e09a5b19so882580f8f.0
        for <linux-acpi@vger.kernel.org>; Sun, 25 Jun 2023 04:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1687694078; x=1690286078;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FutxFDyojhTB1VoP7BlVK4juCgnkY6pSYAe6U3OCTbI=;
        b=dtRQGimw3ml5X7h4zMQ6nCi+z8QJ8Dhu035HOdPmBxpQMw87NEboKY+eJLd40atLS/
         mASv28b+E4qseH/HKXXjmTwUTE6jB9sKB7UIcHEvYIVtbGsCCxYIW4xyQTAjJpF6uUh2
         tUxWAXHuxw9geky4kGM0T1gV3tRf52LpwcRyKSoQtNpP8odFHkNcKRvRznKy8f4cjsWF
         cvRRHfrXZMGEu2Xeqou7JdYun9eOeb/TyQHeqQQneKyRWlV6M6jWoy1iuxSVO0Dgptf6
         vIgaKDni6GizWDBTWAhNQ6pkm6SR1vEl4q6x/aP+kxw0Yr063AQYX1TFaw3pBbW+jkkF
         G+3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687694078; x=1690286078;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FutxFDyojhTB1VoP7BlVK4juCgnkY6pSYAe6U3OCTbI=;
        b=gQs8x54WnQmGB+HZzCmTAPk4cwMLeIYG+ZPZ1nFkJhgmFIz79iBPMlnasgrZUWnJKz
         iqgv4p3/itg+rdpfR6xNWknptIz3c+8kHwat4CCTm+7kdagBhSnwnHsrGf6t7Jg4u0ZP
         DurmciuntpbIr5v6n4s3eQP7htSLHRnKpaeb+PLRhtSisrh/GD5N34q9jevdXlFwHBLc
         OVwG8zG+WJ86lolkAo9AMqHm5Z4403WKuHdJL13n5KhsnlIS7ldcftORW7jq5sozNVjT
         zFPjlAgty5AeWk2GZEJbUTpwIjWx7QNvj4a5J3Bb1BTsSrURTz4LzNlCTKBmkf0RTxEu
         F+VQ==
X-Gm-Message-State: AC+VfDyHG7YkdpCVcmanzLX+sITkcRIOlDIRJaueUElPNLw4J+AHBpyJ
        aB9rudjxCns12At6H99cYzEh6jXSdytv0wUOkm6qNw==
X-Google-Smtp-Source: ACHHUZ5anTOQYI+AvwTyjdVQTxJtwENJi+NMu9Jx5cajPO+zIlc6YSbS0uCRxPQjpD0JvxKhocTap6Ua+o5xhbO7Hms=
X-Received: by 2002:adf:fed1:0:b0:312:849d:acc8 with SMTP id
 q17-20020adffed1000000b00312849dacc8mr12175696wrs.9.1687694078543; Sun, 25
 Jun 2023 04:54:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230426034001.16-1-cuiyunhui@bytedance.com> <CAMj1kXEKh9O-ndk3QFibJMYfMbG7vm-cLN2vVQM5eDsYK84NzQ@mail.gmail.com>
 <CAEEQ3wkJB5CKm33mHXUOPX5makYOHF8By6FYGnNzRkM-Mo72OQ@mail.gmail.com>
 <ZEj33QLZqEeL+/y4@FVFF77S0Q05N> <CAEEQ3wmDBJkfOeKCQfcnuE+1=1K0D2pzu+Sn+zPEWk+RHs0NFQ@mail.gmail.com>
 <CAP6exY+ydbzh1EkWTFejzwaW+PA-ySVO2Qj+CVJ1XbSMce2S9Q@mail.gmail.com>
 <CAP6exY+tqAU0j1TVEMTzTb18M6_mPH5bWWiAS=94gyDGTY3hyQ@mail.gmail.com>
 <CAEEQ3w=wBdpZWnUd2WWVBC3BtFiUp-PQtNAtdXE4cO4n0XT-fg@mail.gmail.com>
 <CAMj1kXFGpXEPtYpy1+bs13F2P_LLZf9rTMfYMU=6jzgd3=SEcw@mail.gmail.com>
 <CAEEQ3wnbXE0vJnQRLo5MhfDc-Q4PbNWBoWS-oMn71CcJU51JdA@mail.gmail.com> <CAMj1kXHfqkU2QxvjTkGBSkEcTf_HirbdOReOJwdpgz3hM8fBHw@mail.gmail.com>
In-Reply-To: <CAMj1kXHfqkU2QxvjTkGBSkEcTf_HirbdOReOJwdpgz3hM8fBHw@mail.gmail.com>
From:   =?UTF-8?B?6L+Q6L6J5bSU?= <cuiyunhui@bytedance.com>
Date:   Sun, 25 Jun 2023 19:54:27 +0800
Message-ID: <CAEEQ3wn2n48TpNQ3MuvrRH4zzg28SaiOswunPeZ01jFm-TbJ5w@mail.gmail.com>
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
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Ard,

On Sun, Jun 25, 2023 at 3:43=E2=80=AFPM Ard Biesheuvel <ardb@kernel.org> wr=
ote:
>
> acpi_os_ioremap() is used by all ACPI core code that needs to map MMIO
> regions or DRAM from AML code. AML does not pass memory type
> attributes, so we have to consult the EFI memory map for these.
>
> As I have explained to you multiple times, ACPI on arm64 is *broken*
> without the EFI memory map.
>

As Ron's suggested:
"...
It would be nice to separate those pieces on RISC-V; certainly they
were separate for a very long time in the x86 world (we had ACPI+SMM
on coreboot laptops without UEFI for example)
...
"

If it cannot be solved temporarily on arm64, then we cannot let it
continue to be bound in RISC-V.
And on the linux-next branch, RISC-V arch is not bound to EFI.
void *acpi_os_ioremap(acpi_physical_address phys, acpi_size size)
{
        return memremap(phys, size, MEMREMAP_WB);
}



>
> Incorrect. We are talking about any physical region here, not just
> DRAM. And some DRAM regions may not be covered by memblock.
>
It is very strange that so many devices can complete the hardware
description through DTS without the problem you mentioned.
Even if there is, then it shouldn't be the problem that this patch
should solve, should it?

> No, sorry. Please try to understand the objections that I am raising
> first. I am not saying this to annoy you, I am saying this because
> your approach is flawed.

The implementation is right in front of us, we need to support ACPI on
RISC-V based on coreboot.

Thanks,
Yunhui
