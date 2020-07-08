Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51B34218CC0
	for <lists+linux-acpi@lfdr.de>; Wed,  8 Jul 2020 18:17:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730322AbgGHQRU (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 8 Jul 2020 12:17:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:44816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730116AbgGHQRU (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 8 Jul 2020 12:17:20 -0400
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DCC19207DA
        for <linux-acpi@vger.kernel.org>; Wed,  8 Jul 2020 16:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594225040;
        bh=f1paydPvqX5mmoQC/Q4NS+87DmSKuFrcvAhN61O4cqE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ziSMIrlmeKAjIBmjG9aw8ReOp6AbE6L28PauO+XKuKjNuj3mUZJoSk+i8OPG3+loh
         Cqin3oiRDVumaZJi8+jWhxhrARR/DXKzpKKrTmW8X8cJU/nToJkupwYKdqIVvFw869
         Lmpr4j/ikyziR1ueitzFsf/2aBmHpnWx3VZmB02o=
Received: by mail-oi1-f171.google.com with SMTP id t4so20436958oij.9
        for <linux-acpi@vger.kernel.org>; Wed, 08 Jul 2020 09:17:19 -0700 (PDT)
X-Gm-Message-State: AOAM532wJAXxqKbIe5VoSQdXH4j1hlbmsVDr8O+6DPCUerpFEUqEJnkr
        dn7kQlSrReFk6VphyF3JAR39A1Jt5WVjKIFkG8E=
X-Google-Smtp-Source: ABdhPJxecRpEvEPRMVMbo2s6nVaZxwYg5eNwh2bAx1ZEx7RL90ErAcNU5zXlYC7f6VanZkv7skq+sjlNi5EDHM1TgJs=
X-Received: by 2002:aca:d643:: with SMTP id n64mr7803399oig.33.1594225039226;
 Wed, 08 Jul 2020 09:17:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200626155832.2323789-1-ardb@kernel.org>
In-Reply-To: <20200626155832.2323789-1-ardb@kernel.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 8 Jul 2020 19:17:08 +0300
X-Gmail-Original-Message-ID: <CAMj1kXGMhmsJmwog6iC+r5Nhyx9QwQkbNdUPSD+UbgZyNvtyzQ@mail.gmail.com>
Message-ID: <CAMj1kXGMhmsJmwog6iC+r5Nhyx9QwQkbNdUPSD+UbgZyNvtyzQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] arm64/acpi: restrict AML opregion memory access
To:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        James Morse <james.morse@arm.com>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

(+ James)

On Fri, 26 Jun 2020 at 18:58, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> v2:
> - do a more elaborate check on the region, against the EFI memory map
>
> v3:
> - split into two patches
> - fallback to __ioremap() for ACPI reclaim memory, in case it is not covered
>   by the linear mapping (e.g., when booting a kdump kernel)
>
> Ard Biesheuvel (2):
>   arm64/acpi: disallow AML memory opregions to access kernel memory
>   arm64/acpi: disallow writeable AML opregion mapping for EFI code
>     regions
>

With some adult supervision from James (thanks!), I have given this a
spin myself with kexec under QEMU/kvm, to boot a crashkernel, and
everything works as expected.


>  arch/arm64/include/asm/acpi.h | 15 +---
>  arch/arm64/kernel/acpi.c      | 75 ++++++++++++++++++++
>  2 files changed, 76 insertions(+), 14 deletions(-)
>
> --
> 2.27.0
>
