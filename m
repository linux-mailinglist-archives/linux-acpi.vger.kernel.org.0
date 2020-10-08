Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D4A42879AB
	for <lists+linux-acpi@lfdr.de>; Thu,  8 Oct 2020 18:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729112AbgJHQHA (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 8 Oct 2020 12:07:00 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:38682 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbgJHQHA (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 8 Oct 2020 12:07:00 -0400
Received: by mail-oi1-f193.google.com with SMTP id 26so6820739ois.5
        for <linux-acpi@vger.kernel.org>; Thu, 08 Oct 2020 09:06:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gsxiiG9nWwjNYTQ2qQYugNFfet7AqvFYTmOXkFAp8Zg=;
        b=Myobm5I/cAfdGLpj+W9rYzUzLcsBJ91p3UE5uymF2OVGq5PQpNSNeWULA8Xq3l2noD
         lfcIxQTDu+h06Fbf2X6afhagUEDe6gWFJKWQy2mC1ng9oPY7qn16HJg26tECRjsP5pNH
         iQuaxr8rSkTD38WAvsNbkDeXnPBDohbmvirAU3dRDXnb+g/OKUY4o9x8L4T0vudhPbTr
         EIjkqVdjEj8Xbl1y0MWhD6oLo9oryPFaEgtTuXQKREcZvuKlQ4FSGi2hTXs9aTeX51XA
         kmvMsL4FFd2Njcs2Xe3kLnshnvmgmpm1x9ZOuIHKhQfD4eJRmAfgrawMAACzRzFXJVjW
         HHhg==
X-Gm-Message-State: AOAM532vKIdI72f+ZQf9RKtFM7BrOlIcw+UYHKafVatYHBFBF9iuS82y
        d92ZRfhrGk606DPHKtYI4QXUWk3WO1TY+7VJJII=
X-Google-Smtp-Source: ABdhPJw1gcctpSQyyr3LQ8mMSZDBGhh/4J20OChKiQbRq8Ys5sY2m6YcMVaoHLlgW1s0jSifXtZivr9EUNrmdrvw1aM=
X-Received: by 2002:aca:5c84:: with SMTP id q126mr5682184oib.71.1602173219317;
 Thu, 08 Oct 2020 09:06:59 -0700 (PDT)
MIME-Version: 1.0
References: <20201008025403.2401736-1-erik.kaneda@intel.com>
In-Reply-To: <20201008025403.2401736-1-erik.kaneda@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 8 Oct 2020 18:06:48 +0200
Message-ID: <CAJZ5v0hod0bH6xE34P_wfbN0P1FV0jnk+Q9jF=YG+OALDvNg7A@mail.gmail.com>
Subject: Re: [PATCH 0/9] ACPICA release 20200925
To:     Erik Kaneda <erik.kaneda@intel.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Oct 8, 2020 at 5:21 AM Erik Kaneda <erik.kaneda@intel.com> wrote:
>
> This release contains the ACPICA patches from the 20200925 release.
> This contains patches that are mostly for user space tools such as iASL,
> acpihelp. The only direct impact to the linux kernel is the addition of
> several predefined names that were found in the SMBus specification.
>
> Signed-off-by: Erik Kaneda <erik.kaneda@intel.com>
>
> Bob Moore (6):
>   ACPICA: Add predefined names found in the SMBus sepcification
>   ACPICA: acpi_help: Update UUID list
>   ACPICA: iASL: Return exceptions for string-to-integer conversions
>   ACPICA: Debugger: Add a new command: "ALL <NameSeg>"
>   ACPICA: Remove unnecessary semicolon
>   ACPICA: Update version to 20200925 Version 20200925.
>
> Colin Ian King (2):
>   ACPICA: Add support for 64 bit risc-v compilation.
>   ACPICA: Tree-wide: fix various typos and spelling mistakes
>
> Randy Dunlap (1):
>   ACPICA: Drop the repeated word "an" in a comment.
>
>  drivers/acpi/acpica/acdebug.h                 |   4 +
>  drivers/acpi/acpica/acpredef.h                |  33 +++-
>  drivers/acpi/acpica/dbexec.c                  |  39 +++-
>  drivers/acpi/acpica/dbinput.c                 |  14 +-
>  drivers/acpi/acpica/dbmethod.c                | 167 +++++++++++++++---
>  drivers/acpi/acpica/nsalloc.c                 |   2 +-
>  drivers/acpi/acpica/nsarguments.c             |   4 +-
>  drivers/acpi/acpica/nsxfobj.c                 |   3 +-
>  drivers/acpi/acpica/psparse.c                 |   4 +-
>  drivers/acpi/acpica/utpredef.c                |   5 +-
>  drivers/acpi/acpica/utstrsuppt.c              |  33 +++-
>  include/acpi/acconfig.h                       |   2 +-
>  include/acpi/acexcep.h                        |   4 +-
>  include/acpi/acpixf.h                         |   2 +-
>  include/acpi/actypes.h                        |   2 +-
>  include/acpi/acuuid.h                         |   7 +
>  include/acpi/platform/aclinux.h               |   3 +-
>  .../os_specific/service_layers/oslinuxtbl.c   |   2 +-
>  18 files changed, 270 insertions(+), 60 deletions(-)
>
> --

All applied as 5.10 material (I dropped a few terminating periods from
patch subjects), thanks!
