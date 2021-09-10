Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8669C407089
	for <lists+linux-acpi@lfdr.de>; Fri, 10 Sep 2021 19:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231386AbhIJRaN (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 10 Sep 2021 13:30:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:57556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231731AbhIJRaM (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 10 Sep 2021 13:30:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A6AB2611CB;
        Fri, 10 Sep 2021 17:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631294941;
        bh=EHYCZa70bOceXqNDdDVeupdOzJn9wCS6p4a7peW8XKs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=chYiiH4xPl8dtMdO0K1zgS2A2NYPAO5mdMjhHzhEjWZqHrVZ1LgowFtKDW5aykomr
         5QOvRhVZBHAiU1au8Q2Pg0DvkcyGB6OHkejmsRufEgnxv153cc/KvAQbigh9YHwD66
         jWrgOOZ8p5ov3faOAppaY6ZMfdZ44Oyj093c9N0qJ571AFspigavfuadlBKEQohlyz
         L0ZFeImWr7YIFAc65Sl3ZrgRjo7fTP8lW1qOprBM08hesaz8MnxVViBwUpPdlb1OnG
         CbCQZAlKJTdUEIDTWuG/P3RSkJRufXxuccLNO+NYD6OMsOLJbMse8E//k+zuNcaV7u
         lZ6WwnN9iT71g==
Received: by mail-ot1-f45.google.com with SMTP id c19-20020a9d6153000000b0051829acbfc7so3193011otk.9;
        Fri, 10 Sep 2021 10:29:01 -0700 (PDT)
X-Gm-Message-State: AOAM531hXdoQ+UWVnVzQxwHEWpQ8tzBGLOfTToDl0xCxCwFHIv63cJRA
        j0magm6cKAOo3kJGTqJyKxVfsw+v5YTGcgPuux4=
X-Google-Smtp-Source: ABdhPJz27Hrx8nyBHi9b2wqnAZZVjoxZKErfMgZq+ttDL4xBLvLbEOV4GMoMa+Y4eTgygaldzsxJwTK+Kk7viJWD1MA=
X-Received: by 2002:a05:6830:603:: with SMTP id w3mr5442085oti.147.1631294941031;
 Fri, 10 Sep 2021 10:29:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210910122820.26886-1-justin.he@arm.com> <20210910143223.6705-1-justin.he@arm.com>
In-Reply-To: <20210910143223.6705-1-justin.he@arm.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 10 Sep 2021 19:28:49 +0200
X-Gmail-Original-Message-ID: <CAMj1kXG6Gu=g8P902NB2b+OvzqwJQPqQewYX5UwMiXALYAFkDw@mail.gmail.com>
Message-ID: <CAMj1kXG6Gu=g8P902NB2b+OvzqwJQPqQewYX5UwMiXALYAFkDw@mail.gmail.com>
Subject: Re: [PATCH v2] Revert "ACPI: Add memory semantics to acpi_os_map_memory()"
To:     Jia He <justin.he@arm.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Will Deacon <will@kernel.org>, Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Harb Abdulhamid <harb@amperecomputing.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, 10 Sept 2021 at 16:32, Jia He <justin.he@arm.com> wrote:
>
> This reverts commit 437b38c51162f8b87beb28a833c4d5dc85fa864e.
>
> After this commit, a boot panic is alway hit on an Ampere EMAG server
> with call trace as follows:
>  Internal error: synchronous external abort: 96000410 [#1] SMP
>  Modules linked in:
>  CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.14.0+ #462
>  Hardware name: MiTAC RAPTOR EV-883832-X3-0001/RAPTOR, BIOS 0.14 02/22/2019
>  pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [...snip...]
>  Call trace:
>   acpi_ex_system_memory_space_handler+0x26c/0x2c8
>   acpi_ev_address_space_dispatch+0x228/0x2c4
>   acpi_ex_access_region+0x114/0x268
>   acpi_ex_field_datum_io+0x128/0x1b8
>   acpi_ex_extract_from_field+0x14c/0x2ac
>   acpi_ex_read_data_from_field+0x190/0x1b8
>   acpi_ex_resolve_node_to_value+0x1ec/0x288
>   acpi_ex_resolve_to_value+0x250/0x274
>   acpi_ds_evaluate_name_path+0xac/0x124
>   acpi_ds_exec_end_op+0x90/0x410
>   acpi_ps_parse_loop+0x4ac/0x5d8
>   acpi_ps_parse_aml+0xe0/0x2c8
>   acpi_ps_execute_method+0x19c/0x1ac
>   acpi_ns_evaluate+0x1f8/0x26c
>   acpi_ns_init_one_device+0x104/0x140
>   acpi_ns_walk_namespace+0x158/0x1d0
>   acpi_ns_initialize_devices+0x194/0x218
>   acpi_initialize_objects+0x48/0x50
>   acpi_init+0xe0/0x498
>
> As mentioned by Lorenzo:
>   "We are forcing memory semantics mappings to PROT_NORMAL_NC, which
>   eMAG does not like at all and I'd need to understand why. It looks
>   like the issue happen in SystemMemory Opregion handler."
>
> Hence just revert it before everything is clear.
>

Can we try to find the root cause first? -rc1 is not even out yet, and
reverting it now means we can not resubmit it until the next merge
window.
