Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82FCC74BE70
	for <lists+linux-acpi@lfdr.de>; Sat,  8 Jul 2023 18:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbjGHQ0G (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 8 Jul 2023 12:26:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjGHQ0F (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 8 Jul 2023 12:26:05 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BBC51B5
        for <linux-acpi@vger.kernel.org>; Sat,  8 Jul 2023 09:26:04 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1b88e5b3834so12418265ad.3
        for <linux-acpi@vger.kernel.org>; Sat, 08 Jul 2023 09:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20221208.gappssmtp.com; s=20221208; t=1688833564; x=1691425564;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n81lmkpIohF/iUaSujpw1NRiU2XjmhYlsAoXp3Ij8w0=;
        b=XoJYhRowRtKqhr6yAj3k3G47roVPlfesolIYJyVSQ5jmBRDNulN4MnX0TSgOHGE0sI
         eEfdbomyMeP3Vd+jM2tWEfFJXsFvzdk4ccig325fpQHhxp1pQjaOshrWNSVD5NQkDWTx
         s/SnHLirC7MuftFSinmcvvxsv8Jm7dPm2PXsjLJtd/QSTSkkOwPvmq5DAv0eVR4blSN7
         0ahQfSf1mjWdfPSTGzi2BrhKqh6qP681w6TjLGTBva8TQjhGORiQprYdLAgGx5xf+lTB
         uVyeR+Tk74WTeozdvUtGIXPS9Xje10Nm01Jty2IJdsKY2Yhy/syZm2ijhUY/iRA2F5mo
         RUNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688833564; x=1691425564;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n81lmkpIohF/iUaSujpw1NRiU2XjmhYlsAoXp3Ij8w0=;
        b=b3ovWXg+EEvI89dW0n+Bh6PouPVgyFKlRgCBRL2j4A2PHm3SUtLXxKsz+36/n4iRV9
         z/MYRVGWtzOxIJQcR2SiHdGBa+NtGeDBLlpWTnOP6hN485Ukq9FSNWTvfzNH8JIXOyIR
         G725V+L3U9glsNne/A3iDowuF5vdFEdropHgQttC/R/Dd7X3XPaTgWI8eNF3VDQUPvWR
         T+wgyjhatY4F4RowY2L6sSp5HkVHMrrkFdQThklXKrziQfObPAIMPaLLeQkTWabT6AYf
         bH8LELiF/kq+vkOfc+mQ8xZ1fcu3pDFD4Mv4g8r63/U/5h1X9lGt37F+zyxMQK9Q0CE9
         qQEA==
X-Gm-Message-State: ABy/qLYMTqs3+KtrsX+l/py2AR7AW0KSyNw8zVF1MpFGhFmFTB4NOiyb
        52cBsZczl9rVfNQC8wWn4vbQaQ==
X-Google-Smtp-Source: APBJJlHXpNokdQddu2gwij/B247jXEox4H02oR5fN5aljXmnnk6OpDbx1BH42oQu7t47hSMyA/Yf1A==
X-Received: by 2002:a17:902:b118:b0:1b3:c3ca:1513 with SMTP id q24-20020a170902b11800b001b3c3ca1513mr5118192plr.65.1688833563858;
        Sat, 08 Jul 2023 09:26:03 -0700 (PDT)
Received: from localhost ([135.180.227.0])
        by smtp.gmail.com with ESMTPSA id ju19-20020a170903429300b001aadd0d7364sm5142121plb.83.2023.07.08.09.26.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jul 2023 09:26:03 -0700 (PDT)
Date:   Sat, 08 Jul 2023 09:26:03 -0700 (PDT)
X-Google-Original-Date: Sat, 08 Jul 2023 09:26:01 PDT (-0700)
Subject:     Re: [External] Re: [PATCH v3 0/4] Obtain SMBIOS and ACPI entry from FFI
In-Reply-To: <CAMj1kXEkL0gF8uGcy2AjJvD-yZHmyLX9jiVVDtR+uBAYf+BfUg@mail.gmail.com>
CC:     Dong.Wei@arm.com, Conor Dooley <conor@kernel.org>,
        geshijian@bytedance.com, sunilvl@ventanamicro.com,
        Conor Dooley <conor.dooley@microchip.com>, rminnich@gmail.com,
        cuiyunhui@bytedance.com, jrtc27@jrtc27.com, kernel@esmil.dk,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>, lpieralisi@kernel.org,
        rafael@kernel.org, lenb@kernel.org, jdelvare@suse.com,
        yc.hung@mediatek.com, angelogioacchino.delregno@collabora.com,
        allen-kh.cheng@mediatek.com, pierre-louis.bossart@linux.intel.com,
        tinghan.shen@mediatek.com, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, weidong.wd@bytedance.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Message-ID: <mhng-d4a8b5de-5500-43ec-867a-972d873a0759@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sat, 08 Jul 2023 01:45:27 PDT (-0700), Ard Biesheuvel wrote:
> On Fri, 7 Jul 2023 at 18:21, Dong Wei <Dong.Wei@arm.com> wrote:
>>
>> On Arm systems today, the ACPI RSDP is found using the UEFI Configuration Table. This is true for all Arm SystemReady compliant systems: 1) SystemReady LS: LBBRv1 is using a minimal UEFI FW to load LinuxBoot, that minimal UEFI FW is producing the UEFI Configuration Table. We are working on LBBRv2. LBBRv2 is based on Coreboot loading LinuxBoot. But we do not have a way today to get CoreBoot to produce this pointer to ACPI RSDP. Arm does not support x86 E820 BIOS interface. 2) SystemReady IR: this solution uses DT rather than ACPI. 3) SystemReady ES: this solution can use UBoot or EDK2, and it requires ACPI. Since both UBoot and EDK2 support UEFI now, so ACPI RSDP can be found using the UEFI Configuration Table. 4) SystemReady SR: this solution typically uses EDK2 and requires ACPI, so no issue finding RSDP via UEFI Configuration Table.
>>
>>
>>
>> So the ACPI RSDP issue only exist if we want to remove the minimum UEFI FW and go to CoreBoot completely to load LinuxBoot. We are currently exploring how to solve that issue…
>>
>
> Hello Dong,
>
> This fixes the RSDP issue perhaps, but that is not the only problem. I
> have mentioned this many times already, but let me mention it again
> for completeness:
>
> ACPI does not have a memory map, and ARM is much more finicky about
> mapping memory regions with the right attributes, given that uncached
> accesses don't snoop the caches like they do on x86. This means it is
> essential that memory mappings constructed from AML code (which
> doesn't provide any context pertaining to the memory type either) are
> created with the right memory type.
>
> Currently, the Linux/arm64 glue code for the ACPI core
> cross-references every memory mapping created from a SystemMemory
> OpRegion by AML code against the EFI memory map, and uses the EFI
> memory type and attributes to infer the memory type to program into
> the page tables. So simply providing the RSDP is *not* sufficient: on
> arm64, more work is needed and currently, booting ACPI without a EFI
> memory map results in SystemMemory OpRegions not working at all.
>
> Of course, we might be able to work around that by providing a
> 'coreboot' memory map for doing ACPI on arm64, but that results in
> more fragmentation and an inflated validation matrix, which puts the
> burden on the Linux subsystem maintainers to make sure that all these
> different combinations remain supported.
>
> AIUI, this memory type issue does not exist for RISC-V today, but I'd
> suggest to the RISC-V maintainers to take a careful look at arm64's
> acpi_os_ioremap() implementation and decide whether or not RISC-V
> needs similar logic.

We've got a handful of messes around this in RISC-V already, I'd be 
surprised if we don't need anything for ACPI.  It's probably not going 
to show up until we're running on real platforms, though, and we're 
going to need some M-mode interface to get it right in the long run.
