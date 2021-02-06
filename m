Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA0B6311C8E
	for <lists+linux-acpi@lfdr.de>; Sat,  6 Feb 2021 11:19:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbhBFKSw (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 6 Feb 2021 05:18:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:40276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229507AbhBFKSu (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sat, 6 Feb 2021 05:18:50 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id CD55E64E36;
        Sat,  6 Feb 2021 10:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612606689;
        bh=wr55LoISR2ISFhuMU+VVCrOBtBumxiExhIBQ3wCHFgI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=L/whPWQhKpZHXrjc/lwJS/qVd19A9KqWQqsUWI9UkNdQfvFYXq3frJit0af3+h/Us
         yEnKbbqwycP3kGfvDMKYkzM2w64qs4tnh5TPvfr7PT+4XGRR3vyH296+5W2QhqTu7X
         DrOTZ4GNx/Iv4AlaRN91hyHWeP2Bau+2LhjPd0YrKI0afa16fGKQ+RFKVOr+iAIXQX
         NYNm5vOh605frJDfSKeMpBj5Sn2+K1WBREtfNrjhA9CBkDsDpZBTzey0eej25BpQv9
         2BD22w7Lqos9/w8NIfMxZV3d3D/jtzVBVFJsbdlmxmsus22DP/gHN5ZJ9+LxWdqyvA
         0WPM97YBpay/Q==
Received: by mail-ot1-f50.google.com with SMTP id k10so7112115otl.2;
        Sat, 06 Feb 2021 02:18:09 -0800 (PST)
X-Gm-Message-State: AOAM53179MJ2/Caw2LXEda6sHpZB7feG9SiP1htfnOilgLei5ozJD5rX
        UvoQ0vuosYpfvt88/hxDAHP/DCy7E+XkWEjsPZA=
X-Google-Smtp-Source: ABdhPJwks0SrxsDdLpt1PUeUPou3I4Jf5vuhtMAYKo6rqHcnqVYGLafX77qdLwgXNIB+vn/Dh0zsmujDiUKWHh/wbF4=
X-Received: by 2002:a05:6830:1614:: with SMTP id g20mr6226305otr.77.1612606689022;
 Sat, 06 Feb 2021 02:18:09 -0800 (PST)
MIME-Version: 1.0
References: <20200626155832.2323789-1-ardb@kernel.org> <20200626155832.2323789-3-ardb@kernel.org>
 <20210206031145.GA27503@dragon> <CAMj1kXHSkBcSDuHbsFMJjC89JrO8TxYUoabDmWerNp27s45Ngw@mail.gmail.com>
In-Reply-To: <CAMj1kXHSkBcSDuHbsFMJjC89JrO8TxYUoabDmWerNp27s45Ngw@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sat, 6 Feb 2021 11:17:57 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGWyY8vFAdpYJvxtNR5nrYaKQg9yL0o5Sp0BbnQnZaRCA@mail.gmail.com>
Message-ID: <CAMj1kXGWyY8vFAdpYJvxtNR5nrYaKQg9yL0o5Sp0BbnQnZaRCA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] arm64/acpi: disallow writeable AML opregion
 mapping for EFI code regions
To:     Shawn Guo <shawn.guo@linaro.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Will Deacon <will@kernel.org>, linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sat, 6 Feb 2021 at 09:10, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Sat, 6 Feb 2021 at 04:11, Shawn Guo <shawn.guo@linaro.org> wrote:
> >
> > Hi Ard,
> >
> > On Fri, Jun 26, 2020 at 05:58:32PM +0200, Ard Biesheuvel wrote:
> > > Given that the contents of EFI runtime code and data regions are
> > > provided by the firmware, as well as the DSDT, it is not unimaginable
> > > that AML code exists today that accesses EFI runtime code regions using
> > > a SystemMemory OpRegion. There is nothing fundamentally wrong with that,
> > > but since we take great care to ensure that executable code is never
> > > mapped writeable and executable at the same time, we should not permit
> > > AML to create writable mapping.
> > >
> > > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> >
> > I'm booting Lenovo Flex 5G laptop with ACPI, and seeing this change
> > causes a memory abort[1] when upgrading ACPI tables via initrd[2].
> > Dropping this change seems to fix the issue for me.  But does that
> > looks like a correct fix to you?
> >
> > Shawn
> >
> > [1] https://fileserver.linaro.org/s/iDe9SaZeNNkyNxG
> > [2] Documentation/admin-guide/acpi/initrd_table_override.rst
> >
>
> Can you check whether reverting
>
> 32cf1a12cad43358e47dac8014379c2f33dfbed4
>
> fixes the issue too?
>
> If it does, please report this as a regression. The OS should not
> modify firmware provided tables in-place, regardless of how they were
> delivered.
>

That patch modifies firmware provided tables in-place, which
invalidates checksums and TPM measurements, so it needs to be reverted
in any case, and I have already sent out  the patch for doing so.
