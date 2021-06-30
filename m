Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BDF83B80F1
	for <lists+linux-acpi@lfdr.de>; Wed, 30 Jun 2021 12:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234150AbhF3KuF (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 30 Jun 2021 06:50:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbhF3KuE (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 30 Jun 2021 06:50:04 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9304C061756;
        Wed, 30 Jun 2021 03:47:35 -0700 (PDT)
Received: from zn.tnic (p200300ec2f12c30098bf4c52f71fbadd.dip0.t-ipconnect.de [IPv6:2003:ec:2f12:c300:98bf:4c52:f71f:badd])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2ACFC1EC0391;
        Wed, 30 Jun 2021 12:47:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1625050052;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=TkZy/QD833ha13+1IsV4q1qSizeGPCgUyVXoEPrETa0=;
        b=C7pdnqFEEK2T/fX3doHU2H9dhnWElzyZdk6lcxAG+/mRWm8i09G0hU8kCbGoGnByP06lAr
        h1BYRT350UhDMxencZmZJoJ0M5pwZ+y7jovHlmtW70GzdER3tSh/FjBqeIyVCE6dZnMjZ7
        RT3mcw55i6niPEBe1YSU/1K/fWdgwVc=
Date:   Wed, 30 Jun 2021 12:47:26 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Erik Kaneda <erik.kaneda@intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] ACPI updates for v5.14-rc1
Message-ID: <YNxLvhBBE7Ff6Q5u@zn.tnic>
References: <CAJZ5v0hm5ihfU_hBbMB9u7SmH18PLGp6+Z6=wBLa8WxaVQRTpg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hm5ihfU_hBbMB9u7SmH18PLGp6+Z6=wBLa8WxaVQRTpg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Jun 29, 2021 at 09:01:10PM +0200, Rafael J. Wysocki wrote:
> Erik Kaneda (6):
>       ACPICA: Fix memory leak caused by _CID repair function
>       ACPICA: iASL: add disassembler support for PRMT
>       ACPICA: Add support for PlatformRtMechanism OperationRegion handler
>       ACPICA: Add PRMT module header to facilitate parsing
>       ACPI: PRM: implement OperationRegion handler for the
> PlatformRtMechanism subtype

$ git checkout master
$ git pull
$ make oldconfig

Platform Runtime Mechanism Support (ACPI_PRMT) [Y/n/?] (NEW) ?

There is no help available for this option.
Symbol: ACPI_PRMT [=y]
Type  : bool
Defined at drivers/acpi/Kconfig:547
  Prompt: Platform Runtime Mechanism Support
  Depends on: EFI [=y] && X86_64 [=y]
  Location:
    -> Power management and ACPI options



Platform Runtime Mechanism Support (ACPI_PRMT) [Y/n/?] (NEW)

I don't know what that means, there's no help, no nothing. And it is
default y for no apparent reason.

/me looks at the commit message:

    Platform Runtime Mechanism (PRM) is a firmware interface that exposes
    a set of binary executables that can either be called from the AML
    interpreter or device drivers by bypassing the AML interpreter.
    This change implements the AML interpreter path.

I'm still unclear whether I need it or not.

Guys, you need to think about your users and to write help text which is
*actually* usable for people who do not deal with ACPI firmware gunk.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
