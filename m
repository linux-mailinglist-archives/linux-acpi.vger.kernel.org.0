Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BFAE3DCAF0
	for <lists+linux-acpi@lfdr.de>; Sun,  1 Aug 2021 11:47:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231557AbhHAJrN (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 1 Aug 2021 05:47:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29133 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231464AbhHAJrN (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 1 Aug 2021 05:47:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627811225;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ob39OXT5qhbZf1w6QolNk9fwKO5R4yn3IQjQVYIuDDk=;
        b=GkFDxquHumeP+tqOaVt29gGxnJI/IEuqzNGf5PWCJVVNbpU4ms9ojr1hf8nYj/F2WV5YdO
        V87cgnC7Z1ZFdHMsPk0nSmNOWUaqvNfx9ApqiM26YbIFq41JIfzH2UL8H/j8wDmYEneh4W
        a/c8X9I9NgAiIwzR2Sv3mQuJ6brX2D4=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-27-ETasV0bLNcmTpWjiwHzX7w-1; Sun, 01 Aug 2021 05:47:04 -0400
X-MC-Unique: ETasV0bLNcmTpWjiwHzX7w-1
Received: by mail-ej1-f72.google.com with SMTP id n9-20020a1709063789b02905854bda39fcso3945031ejc.1
        for <linux-acpi@vger.kernel.org>; Sun, 01 Aug 2021 02:47:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:cc:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ob39OXT5qhbZf1w6QolNk9fwKO5R4yn3IQjQVYIuDDk=;
        b=E0K9u85FcyXq3mYZix99OfHx2vUtc0qxCKKPmaFOf63HXS8fB1fDbHYVgCvLdjsdgF
         Gn7a2EBPm5Aa0NXHkrTtPbqBZanb4uPl64s9ZV/ojTtIXaJ9MM6utZbm+Q3K6zGw6Ur/
         c0w9j0F4pFp9Jj8RycOBBFlnSHyavYHJ6F0Cl4lmcjewPKmujHsWYeUJ1Jyz+FJa9waP
         ujT92aIfWaZFSJBseHaqCYUQ4bwFq0rUjIrcnyFIf67DTnC8u80Ev+6eJ4NyJumXOiSZ
         AOjy5Jq6JO/uBmd9wpaY11kaB7K4HjQl9F6Pi7lTpd7Q/G9EiOrl9l3J+iqkGrxFq1S9
         VuOg==
X-Gm-Message-State: AOAM530qKBtJnBjXiMabfg/q56oMVjgC+p7g0TtEb7AStUVS9QsYV5Gd
        mF/GFqTfySfuWQXjKvviWQglmzAidTFQahTGfl5z+grRaVkEqYLo0X364pO60hMYFPmTPehnmpj
        ZJrVhFn6q9KEvccqWZYjTkJ4QYdZuDDJ6e6/mPp4yRXYkPQPHwqyK9PNvCG1Bjc4tTQuziQvMvQ
        ==
X-Received: by 2002:a17:906:e54:: with SMTP id q20mr3361662eji.86.1627811222555;
        Sun, 01 Aug 2021 02:47:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzrznJYhzuiSu5tMSiPbtEiD8+h4F0LnaYtmLGSE1+BpMGDEjTR1bhBOdlYyaZxLdEuTZPJwg==
X-Received: by 2002:a17:906:e54:: with SMTP id q20mr3361646eji.86.1627811222267;
        Sun, 01 Aug 2021 02:47:02 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id bm1sm2841494ejb.38.2021.08.01.02.47.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Aug 2021 02:47:01 -0700 (PDT)
Subject: AMD laptops defaulting to S3 instead of S0ix (was amd_sfh)
To:     Stephen MacNeil <macneisj@gmail.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
References: <CALWF37bJU92DxcD4VhBxbS+X+EUv-UW2oY-ogwMyNyGAnn=0WA@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        linux-acpi <linux-acpi@vger.kernel.org>
Message-ID: <309288ec-27ac-0321-dce5-e9ba2bbab7ed@redhat.com>
Date:   Sun, 1 Aug 2021 11:47:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CALWF37bJU92DxcD4VhBxbS+X+EUv-UW2oY-ogwMyNyGAnn=0WA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Rafael, Mario,

Stephen is having an issue with a recent AMD laptop (a Lenovo Ideapad model)
where Linux defaults to using S3/deep suspend instead of S0ix/s2idle.

This is causing the sensors provided by the AMD Sensor Fusion Hub
to stop working after a suspend/resume. Adding mem_sleep_default=s2idle
to the kernel commandline fixes this.

Do you have any idea what might be causing this ?

Regards,

Hans



On 7/31/21 2:31 PM, Stephen MacNeil wrote:
> I wrote Basavaraj Natikar the new maintainer of amd_sfh for the kernel, after sending the information he wanted his reply was...
> 
>>>Thanks Stephen MacNeil,
> 
> On our hardware we do not see any amd_sfh issue with 5.14.0-rc2 kernel.
>  
> Could you please check with Lenovo, as we are not observing amd_sfh issue on our reference platforms too.
> 
> Thanks,
> Basavaraj
> <<
> looking at the information I sent him  i looks like the issue is (to me anyway)
> 
> cat /sys/power/mem_sleep
> [s2idle] deep
> 
> without
> cat /sys/power/mem_sleep
> s2idle [deep]
> 
> 
> this is the info he requested... any idea who else I can contact.
> this is the output with and without the kernel param
> 
>  
> 
> Thanks a lot Stephen MacNeil  for the information.
> 
>  
> 
> Could you please provide me below information:-
> 
> ·  what version of kernel is running.
> 
> uname -a
> Linux ideapad 5.14.0-051400rc2-generic #202107182230 SMP Sun Jul 18 22:34:12 UTC 2021 x86_64 x86_64 x86_64 GNU/Linux
> 
> 
> ·  Are you using latest patches from amd-sfh
> 
> only the kernel
> 
> ·  Could you please provide me output of /sys/power/mem_sleep
> 
> with kernel option mem_sleep_default=s2idle
> 
> cat /sys/power/mem_sleep
> [s2idle] deep
> 
> without
> cat /sys/power/mem_sleep
> s2idle [deep]
> 
> ·  Could you please provide output of below script after installing “apt install iasl*”. acpica-tools
> 
> with kernel option mem_sleep_default=s2idle
> 
> Intel ACPI Component Architecture
> ASL+ Optimizing Compiler/Disassembler version 20190509
> Copyright (c) 2000 - 2019 Intel Corporation
> 
> File appears to be binary: found 265 non-ASCII characters, disassembling
> Binary file appears to be a valid ACPI table, disassembling
> Input file apic.dat, Length 0x138 (312) bytes
> ACPI: APIC 0x0000000000000000 000138 (v02 LENOVO CB-01    00000000 LENO 00000001)
> Acpi Data Table [APIC] decoded
> Formatted output:  apic.dsl - 16071 bytes
> File appears to be binary: found 40 non-ASCII characters, disassembling
> Binary file appears to be a valid ACPI table, disassembling
> Input file batb.dat, Length 0x4A (74) bytes
> ACPI: BATB 0x0000000000000000 00004A (v02 LENOVO CB-01    00000000 LENO 00000001)
> Unknown ACPI table signature [BATB], decoding ACPI table header only
> Acpi Data Table [BATB] decoded
> Formatted output:  batb.dsl - 1274 bytes
> File appears to be binary: found 31 non-ASCII characters, disassembling
> Binary file appears to be a valid ACPI table, disassembling
> Input file bgrt.dat, Length 0x38 (56) bytes
> ACPI: BGRT 0x0000000000000000 000038 (v01 LENOVO CB-01    00000002 LENO 00000001)
> Acpi Data Table [BGRT] decoded
> Formatted output:  bgrt.dsl - 1606 bytes
> File appears to be binary: found 16 non-ASCII characters, disassembling
> Binary file appears to be a valid ACPI table, disassembling
> Input file cdit.dat, Length 0x29 (41) bytes
> ACPI: CDIT 0x0000000000000000 000029 (v01 LENOVO CB-01    00000001 LENO 00000001)
> Unknown ACPI table signature [CDIT], decoding ACPI table header only
> Acpi Data Table [CDIT] decoded
> Formatted output:  cdit.dsl - 1115 bytes
> File appears to be binary: found 2765 non-ASCII characters, disassembling
> Binary file appears to be a valid ACPI table, disassembling
> Input file crat.dat, Length 0xB80 (2944) bytes
> ACPI: CRAT 0x0000000000000000 000B80 (v01 LENOVO CB-01    00000001 LENO 00000001)
> Unknown ACPI table signature [CRAT], decoding ACPI table header only
> Acpi Data Table [CRAT] decoded
> Formatted output:  crat.dsl - 15424 bytes
> File appears to be binary: found 15189 non-ASCII characters, disassembling
> Binary file appears to be a valid ACPI table, disassembling
> Input file dsdt.dat, Length 0xAE9B (44699) bytes
> ACPI: DSDT 0x0000000000000000 00AE9B (v01 LENOVO AMD      00001000 INTL 20180313)
> Pass 1 parse of [DSDT]
> Pass 2 parse of [DSDT]
> Parsing Deferred Opcodes (Methods/Buffers/Packages/Regions)
> 
> Parsing completed
> Disassembly completed
> ASL Output:    dsdt.dsl - 384071 bytes
> File appears to be binary: found 229 non-ASCII characters, disassembling
> Binary file appears to be a valid ACPI table, disassembling
> Input file facp.dat, Length 0x10C (268) bytes
> ACPI: FACP 0x0000000000000000 00010C (v05 LENOVO CB-01    00000003 LENO 00000001)
> Acpi Data Table [FACP] decoded
> Formatted output:  facp.dsl - 10098 bytes
> File appears to be binary: found 59 non-ASCII characters, disassembling
> Binary file appears to be a valid ACPI table, disassembling
> Input file facs.dat, Length 0x40 (64) bytes
> ACPI: FACS 0x0000000000000000 000040
> Acpi Data Table [FACS] decoded
> Formatted output:  facs.dsl - 1368 bytes
> File appears to be binary: found 28 non-ASCII characters, disassembling
> Binary file appears to be a valid ACPI table, disassembling
> Input file fpdt.dat, Length 0x34 (52) bytes
> ACPI: FPDT 0x0000000000000000 000034 (v01 LENOVO CB-01    00000002 LENO 00000001)
> Acpi Data Table [FPDT] decoded
> Formatted output:  fpdt.dsl - 1452 bytes
> File appears to be binary: found 30 non-ASCII characters, disassembling
> Binary file appears to be a valid ACPI table, disassembling
> Input file hpet.dat, Length 0x38 (56) bytes
> ACPI: HPET 0x0000000000000000 000038 (v01 LENOVO CB-01    00000001 LENO 00000001)
> Acpi Data Table [HPET] decoded
> Formatted output:  hpet.dsl - 1865 bytes
> File appears to be binary: found 279 non-ASCII characters, disassembling
> Binary file appears to be a valid ACPI table, disassembling
> Input file ivrs.dat, Length 0x1A4 (420) bytes
> ACPI: IVRS 0x0000000000000000 0001A4 (v02 LENOVO CB-01    00000001 LENO 00000001)
> Acpi Data Table [IVRS] decoded
> Formatted output:  ivrs.dsl - 6001 bytes
> File appears to be binary: found 36 non-ASCII characters, disassembling
> Binary file appears to be a valid ACPI table, disassembling
> Input file mcfg.dat, Length 0x3C (60) bytes
> ACPI: MCFG 0x0000000000000000 00003C (v01 LENOVO CB-01    00000001 LENO 00000001)
> Acpi Data Table [MCFG] decoded
> Formatted output:  mcfg.dsl - 1526 bytes
> File appears to be binary: found 32 non-ASCII characters, disassembling
> Binary file appears to be a valid ACPI table, disassembling
> Input file msdm.dat, Length 0x55 (85) bytes
> ACPI: MSDM 0x0000000000000000 000055 (v03 LENOVO CB-01    00000000 LENO 00000001)
> Acpi Data Table [MSDM] decoded
> Formatted output:  msdm.dsl - 1557 bytes
> File appears to be binary: found 25 non-ASCII characters, disassembling
> Binary file appears to be a valid ACPI table, disassembling
> Input file sbst.dat, Length 0x30 (48) bytes
> ACPI: SBST 0x0000000000000000 000030 (v01 LENOVO CB-01    00000001 LENO 00000001)
> Acpi Data Table [SBST] decoded
> Formatted output:  sbst.dsl - 1282 bytes
> File appears to be binary: found 410 non-ASCII characters, disassembling
> Binary file appears to be a valid ACPI table, disassembling
> Input file ssdt10.dat, Length 0x47F (1151) bytes
> ACPI: SSDT 0x0000000000000000 00047F (v01 LENOVO AmdTable 00000001 INTL 20180313)
> Pass 1 parse of [SSDT]
> Pass 2 parse of [SSDT]
> Parsing Deferred Opcodes (Methods/Buffers/Packages/Regions)
> 
> Parsing completed
> Disassembly completed
> ASL Output:    ssdt10.dsl - 5673 bytes
> File appears to be binary: found 708 non-ASCII characters, disassembling
> Binary file appears to be a valid ACPI table, disassembling
> Input file ssdt11.dat, Length 0xC1D (3101) bytes
> ACPI: SSDT 0x0000000000000000 000C1D (v01 LENOVO AmdTable 00000001 INTL 20180313)
> Pass 1 parse of [SSDT]
> Pass 2 parse of [SSDT]
> Parsing Deferred Opcodes (Methods/Buffers/Packages/Regions)
> 
> Parsing completed
> Disassembly completed
> ASL Output:    ssdt11.dsl - 15424 bytes
> File appears to be binary: found 848 non-ASCII characters, disassembling
> Binary file appears to be a valid ACPI table, disassembling
> Input file ssdt12.dat, Length 0x9AD (2477) bytes
> ACPI: SSDT 0x0000000000000000 0009AD (v01 LENOVO AmdTable 00000001 INTL 20180313)
> Pass 1 parse of [SSDT]
> Pass 2 parse of [SSDT]
> Parsing Deferred Opcodes (Methods/Buffers/Packages/Regions)
> 
> Parsing completed
> Disassembly completed
> ASL Output:    ssdt12.dsl - 12474 bytes
> File appears to be binary: found 9207 non-ASCII characters, disassembling
> Binary file appears to be a valid ACPI table, disassembling
> Input file ssdt1.dat, Length 0x7216 (29206) bytes
> ACPI: SSDT 0x0000000000000000 007216 (v02 LENOVO AmdTable 00000002 MSFT 04000000)
> Pass 1 parse of [SSDT]
> Pass 2 parse of [SSDT]
> Parsing Deferred Opcodes (Methods/Buffers/Packages/Regions)
> 
> Parsing completed
> Disassembly completed
> ASL Output:    ssdt1.dsl - 208699 bytes
> File appears to be binary: found 3968 non-ASCII characters, disassembling
> Binary file appears to be a valid ACPI table, disassembling
> Input file ssdt2.dat, Length 0x1500 (5376) bytes
> ACPI: SSDT 0x0000000000000000 001500 (v01 LENOVO AmdTable 00000001 AMD  00000001)
> Pass 1 parse of [SSDT]
> Pass 2 parse of [SSDT]
> Parsing Deferred Opcodes (Methods/Buffers/Packages/Regions)
> 
> Parsing completed
> Disassembly completed
> ASL Output:    ssdt2.dsl - 59265 bytes
> File appears to be binary: found 449 non-ASCII characters, disassembling
> Binary file appears to be a valid ACPI table, disassembling
> Input file ssdt3.dat, Length 0x53A (1338) bytes
> ACPI: SSDT 0x0000000000000000 00053A (v01 LENOVO Tpm2Tabl 00009999 INTL 20180313)
> Pass 1 parse of [SSDT]
> Pass 2 parse of [SSDT]
> Parsing Deferred Opcodes (Methods/Buffers/Packages/Regions)
> 
> Parsing completed
> Disassembly completed
> ASL Output:    ssdt3.dsl - 10738 bytes
> File appears to be binary: found 474 non-ASCII characters, disassembling
> Binary file appears to be a valid ACPI table, disassembling
> Input file ssdt4.dat, Length 0x64C (1612) bytes
> ACPI: SSDT 0x0000000000000000 00064C (v01 LENOVO AmdTable 00000001 INTL 20180313)
> Pass 1 parse of [SSDT]
> Pass 2 parse of [SSDT]
> Parsing Deferred Opcodes (Methods/Buffers/Packages/Regions)
> 
> Parsing completed
> Disassembly completed
> ASL Output:    ssdt4.dsl - 8258 bytes
> File appears to be binary: found 400 non-ASCII characters, disassembling
> Binary file appears to be a valid ACPI table, disassembling
> Input file ssdt5.dat, Length 0x480 (1152) bytes
> ACPI: SSDT 0x0000000000000000 000480 (v01 LENOVO AmdTable 00000001 INTL 20180313)
> Pass 1 parse of [SSDT]
> Pass 2 parse of [SSDT]
> Parsing Deferred Opcodes (Methods/Buffers/Packages/Regions)
> 
> Parsing completed
> Disassembly completed
> ASL Output:    ssdt5.dsl - 5582 bytes
> File appears to be binary: found 1140 non-ASCII characters, disassembling
> Binary file appears to be a valid ACPI table, disassembling
> Input file ssdt6.dat, Length 0x1497 (5271) bytes
> ACPI: SSDT 0x0000000000000000 001497 (v01 LENOVO AmdTable 00000001 INTL 20180313)
> Pass 1 parse of [SSDT]
> Pass 2 parse of [SSDT]
> Parsing Deferred Opcodes (Methods/Buffers/Packages/Regions)
> 
> Parsing completed
> Disassembly completed
> ASL Output:    ssdt6.dsl - 20293 bytes
> File appears to be binary: found 1314 non-ASCII characters, disassembling
> Binary file appears to be a valid ACPI table, disassembling
> Input file ssdt7.dat, Length 0x1576 (5494) bytes
> ACPI: SSDT 0x0000000000000000 001576 (v01 LENOVO AmdTable 00000001 INTL 20180313)
> Pass 1 parse of [SSDT]
> Pass 2 parse of [SSDT]
> Parsing Deferred Opcodes (Methods/Buffers/Packages/Regions)
> 
> Parsing completed
> Disassembly completed
> ASL Output:    ssdt7.dsl - 30076 bytes
> File appears to be binary: found 4095 non-ASCII characters, disassembling
> Binary file appears to be a valid ACPI table, disassembling
> Input file ssdt8.dat, Length 0x353C (13628) bytes
> ACPI: SSDT 0x0000000000000000 00353C (v01 LENOVO AmdTable 00000001 INTL 20180313)
> Pass 1 parse of [SSDT]
> Pass 2 parse of [SSDT]
> Parsing Deferred Opcodes (Methods/Buffers/Packages/Regions)
> 
> Parsing completed
> Disassembly completed
> ASL Output:    ssdt8.dsl - 78242 bytes
> File appears to be binary: found 74 non-ASCII characters, disassembling
> Binary file appears to be a valid ACPI table, disassembling
> Input file ssdt9.dat, Length 0x90 (144) bytes
> ACPI: SSDT 0x0000000000000000 000090 (v01 LENOVO AmdTable 00000001 INTL 20180313)
> Pass 1 parse of [SSDT]
> Pass 2 parse of [SSDT]
> Parsing Deferred Opcodes (Methods/Buffers/Packages/Regions)
> 
> Parsing completed
> Disassembly completed
> ASL Output:    ssdt9.dsl - 1767 bytes
> File appears to be binary: found 32 non-ASCII characters, disassembling
> Binary file appears to be a valid ACPI table, disassembling
> Input file tpm2.dat, Length 0x38 (56) bytes
> ACPI: TPM2 0x0000000000000000 000038 (v04 LENOVO CB-01    00000002 LENO 00000001)
> Acpi Data Table [TPM2] decoded
> Formatted output:  tpm2.dsl - 1515 bytes
> File appears to be binary: found 189 non-ASCII characters, disassembling
> Binary file appears to be a valid ACPI table, disassembling
> Input file uefi.dat, Length 0x12A (298) bytes
> ACPI: UEFI 0x0000000000000000 00012A (v01 LENOVO CB-01    00000001 LENO 00000001)
> Acpi Data Table [UEFI] decoded
> Formatted output:  uefi.dsl - 2505 bytes
> File appears to be binary: found 37100 non-ASCII characters, disassembling
> Binary file appears to be a valid ACPI table, disassembling
> Input file vfct.dat, Length 0xD484 (54404) bytes
> ACPI: VFCT 0x0000000000000000 00D484 (v01 LENOVO CB-01    00000001 LENO 00000001)
> Unknown ACPI table signature [VFCT], decoding ACPI table header only
> Acpi Data Table [VFCT] decoded
> Formatted output:  vfct.dsl - 269557 bytes
> File appears to be binary: found 17 non-ASCII characters, disassembling
> Binary file appears to be a valid ACPI table, disassembling
> Input file wsmt.dat, Length 0x28 (40) bytes
> ACPI: WSMT 0x0000000000000000 000028 (v01 LENOVO CB-01    00000000 LENO 00000001)
> Acpi Data Table [WSMT] decoded
> Formatted output:  wsmt.dsl - 1313 bytes
> Low Power S0 Idle is 0
> The system does not support S0ix!
> 
> 
> without
> 
> Intel ACPI Component Architecture
> ASL+ Optimizing Compiler/Disassembler version 20190509
> Copyright (c) 2000 - 2019 Intel Corporation
> 
> File appears to be binary: found 265 non-ASCII characters, disassembling
> Binary file appears to be a valid ACPI table, disassembling
> Input file apic.dat, Length 0x138 (312) bytes
> ACPI: APIC 0x0000000000000000 000138 (v02 LENOVO CB-01    00000000 LENO 00000001)
> Acpi Data Table [APIC] decoded
> Formatted output:  apic.dsl - 16071 bytes
> File appears to be binary: found 40 non-ASCII characters, disassembling
> Binary file appears to be a valid ACPI table, disassembling
> Input file batb.dat, Length 0x4A (74) bytes
> ACPI: BATB 0x0000000000000000 00004A (v02 LENOVO CB-01    00000000 LENO 00000001)
> Unknown ACPI table signature [BATB], decoding ACPI table header only
> Acpi Data Table [BATB] decoded
> Formatted output:  batb.dsl - 1274 bytes
> File appears to be binary: found 31 non-ASCII characters, disassembling
> Binary file appears to be a valid ACPI table, disassembling
> Input file bgrt.dat, Length 0x38 (56) bytes
> ACPI: BGRT 0x0000000000000000 000038 (v01 LENOVO CB-01    00000002 LENO 00000001)
> Acpi Data Table [BGRT] decoded
> Formatted output:  bgrt.dsl - 1606 bytes
> File appears to be binary: found 16 non-ASCII characters, disassembling
> Binary file appears to be a valid ACPI table, disassembling
> Input file cdit.dat, Length 0x29 (41) bytes
> ACPI: CDIT 0x0000000000000000 000029 (v01 LENOVO CB-01    00000001 LENO 00000001)
> Unknown ACPI table signature [CDIT], decoding ACPI table header only
> Acpi Data Table [CDIT] decoded
> Formatted output:  cdit.dsl - 1115 bytes
> File appears to be binary: found 2765 non-ASCII characters, disassembling
> Binary file appears to be a valid ACPI table, disassembling
> Input file crat.dat, Length 0xB80 (2944) bytes
> ACPI: CRAT 0x0000000000000000 000B80 (v01 LENOVO CB-01    00000001 LENO 00000001)
> Unknown ACPI table signature [CRAT], decoding ACPI table header only
> Acpi Data Table [CRAT] decoded
> Formatted output:  crat.dsl - 15424 bytes
> File appears to be binary: found 15189 non-ASCII characters, disassembling
> Binary file appears to be a valid ACPI table, disassembling
> Input file dsdt.dat, Length 0xAE9B (44699) bytes
> ACPI: DSDT 0x0000000000000000 00AE9B (v01 LENOVO AMD      00001000 INTL 20180313)
> Pass 1 parse of [DSDT]
> Pass 2 parse of [DSDT]
> Parsing Deferred Opcodes (Methods/Buffers/Packages/Regions)
> 
> Parsing completed
> Disassembly completed
> ASL Output:    dsdt.dsl - 384071 bytes
> File appears to be binary: found 229 non-ASCII characters, disassembling
> Binary file appears to be a valid ACPI table, disassembling
> Input file facp.dat, Length 0x10C (268) bytes
> ACPI: FACP 0x0000000000000000 00010C (v05 LENOVO CB-01    00000003 LENO 00000001)
> Acpi Data Table [FACP] decoded
> Formatted output:  facp.dsl - 10098 bytes
> File appears to be binary: found 59 non-ASCII characters, disassembling
> Binary file appears to be a valid ACPI table, disassembling
> Input file facs.dat, Length 0x40 (64) bytes
> ACPI: FACS 0x0000000000000000 000040
> Acpi Data Table [FACS] decoded
> Formatted output:  facs.dsl - 1368 bytes
> File appears to be binary: found 28 non-ASCII characters, disassembling
> Binary file appears to be a valid ACPI table, disassembling
> Input file fpdt.dat, Length 0x34 (52) bytes
> ACPI: FPDT 0x0000000000000000 000034 (v01 LENOVO CB-01    00000002 LENO 00000001)
> Acpi Data Table [FPDT] decoded
> Formatted output:  fpdt.dsl - 1452 bytes
> File appears to be binary: found 30 non-ASCII characters, disassembling
> Binary file appears to be a valid ACPI table, disassembling
> Input file hpet.dat, Length 0x38 (56) bytes
> ACPI: HPET 0x0000000000000000 000038 (v01 LENOVO CB-01    00000001 LENO 00000001)
> Acpi Data Table [HPET] decoded
> Formatted output:  hpet.dsl - 1865 bytes
> File appears to be binary: found 279 non-ASCII characters, disassembling
> Binary file appears to be a valid ACPI table, disassembling
> Input file ivrs.dat, Length 0x1A4 (420) bytes
> ACPI: IVRS 0x0000000000000000 0001A4 (v02 LENOVO CB-01    00000001 LENO 00000001)
> Acpi Data Table [IVRS] decoded
> Formatted output:  ivrs.dsl - 6001 bytes
> File appears to be binary: found 36 non-ASCII characters, disassembling
> Binary file appears to be a valid ACPI table, disassembling
> Input file mcfg.dat, Length 0x3C (60) bytes
> ACPI: MCFG 0x0000000000000000 00003C (v01 LENOVO CB-01    00000001 LENO 00000001)
> Acpi Data Table [MCFG] decoded
> Formatted output:  mcfg.dsl - 1526 bytes
> File appears to be binary: found 32 non-ASCII characters, disassembling
> Binary file appears to be a valid ACPI table, disassembling
> Input file msdm.dat, Length 0x55 (85) bytes
> ACPI: MSDM 0x0000000000000000 000055 (v03 LENOVO CB-01    00000000 LENO 00000001)
> Acpi Data Table [MSDM] decoded
> Formatted output:  msdm.dsl - 1557 bytes
> File appears to be binary: found 25 non-ASCII characters, disassembling
> Binary file appears to be a valid ACPI table, disassembling
> Input file sbst.dat, Length 0x30 (48) bytes
> ACPI: SBST 0x0000000000000000 000030 (v01 LENOVO CB-01    00000001 LENO 00000001)
> Acpi Data Table [SBST] decoded
> Formatted output:  sbst.dsl - 1282 bytes
> File appears to be binary: found 410 non-ASCII characters, disassembling
> Binary file appears to be a valid ACPI table, disassembling
> Input file ssdt10.dat, Length 0x47F (1151) bytes
> ACPI: SSDT 0x0000000000000000 00047F (v01 LENOVO AmdTable 00000001 INTL 20180313)
> Pass 1 parse of [SSDT]
> Pass 2 parse of [SSDT]
> Parsing Deferred Opcodes (Methods/Buffers/Packages/Regions)
> 
> Parsing completed
> Disassembly completed
> ASL Output:    ssdt10.dsl - 5673 bytes
> File appears to be binary: found 708 non-ASCII characters, disassembling
> Binary file appears to be a valid ACPI table, disassembling
> Input file ssdt11.dat, Length 0xC1D (3101) bytes
> ACPI: SSDT 0x0000000000000000 000C1D (v01 LENOVO AmdTable 00000001 INTL 20180313)
> Pass 1 parse of [SSDT]
> Pass 2 parse of [SSDT]
> Parsing Deferred Opcodes (Methods/Buffers/Packages/Regions)
> 
> Parsing completed
> Disassembly completed
> ASL Output:    ssdt11.dsl - 15424 bytes
> File appears to be binary: found 848 non-ASCII characters, disassembling
> Binary file appears to be a valid ACPI table, disassembling
> Input file ssdt12.dat, Length 0x9AD (2477) bytes
> ACPI: SSDT 0x0000000000000000 0009AD (v01 LENOVO AmdTable 00000001 INTL 20180313)
> Pass 1 parse of [SSDT]
> Pass 2 parse of [SSDT]
> Parsing Deferred Opcodes (Methods/Buffers/Packages/Regions)
> 
> Parsing completed
> Disassembly completed
> ASL Output:    ssdt12.dsl - 12474 bytes
> File appears to be binary: found 9207 non-ASCII characters, disassembling
> Binary file appears to be a valid ACPI table, disassembling
> Input file ssdt1.dat, Length 0x7216 (29206) bytes
> ACPI: SSDT 0x0000000000000000 007216 (v02 LENOVO AmdTable 00000002 MSFT 04000000)
> Pass 1 parse of [SSDT]
> Pass 2 parse of [SSDT]
> Parsing Deferred Opcodes (Methods/Buffers/Packages/Regions)
> 
> Parsing completed
> Disassembly completed
> ASL Output:    ssdt1.dsl - 208699 bytes
> File appears to be binary: found 3968 non-ASCII characters, disassembling
> Binary file appears to be a valid ACPI table, disassembling
> Input file ssdt2.dat, Length 0x1500 (5376) bytes
> ACPI: SSDT 0x0000000000000000 001500 (v01 LENOVO AmdTable 00000001 AMD  00000001)
> Pass 1 parse of [SSDT]
> Pass 2 parse of [SSDT]
> Parsing Deferred Opcodes (Methods/Buffers/Packages/Regions)
> 
> Parsing completed
> Disassembly completed
> ASL Output:    ssdt2.dsl - 59265 bytes
> File appears to be binary: found 449 non-ASCII characters, disassembling
> Binary file appears to be a valid ACPI table, disassembling
> Input file ssdt3.dat, Length 0x53A (1338) bytes
> ACPI: SSDT 0x0000000000000000 00053A (v01 LENOVO Tpm2Tabl 00009999 INTL 20180313)
> Pass 1 parse of [SSDT]
> Pass 2 parse of [SSDT]
> Parsing Deferred Opcodes (Methods/Buffers/Packages/Regions)
> 
> Parsing completed
> Disassembly completed
> ASL Output:    ssdt3.dsl - 10738 bytes
> File appears to be binary: found 474 non-ASCII characters, disassembling
> Binary file appears to be a valid ACPI table, disassembling
> Input file ssdt4.dat, Length 0x64C (1612) bytes
> ACPI: SSDT 0x0000000000000000 00064C (v01 LENOVO AmdTable 00000001 INTL 20180313)
> Pass 1 parse of [SSDT]
> Pass 2 parse of [SSDT]
> Parsing Deferred Opcodes (Methods/Buffers/Packages/Regions)
> 
> Parsing completed
> Disassembly completed
> ASL Output:    ssdt4.dsl - 8258 bytes
> File appears to be binary: found 400 non-ASCII characters, disassembling
> Binary file appears to be a valid ACPI table, disassembling
> Input file ssdt5.dat, Length 0x480 (1152) bytes
> ACPI: SSDT 0x0000000000000000 000480 (v01 LENOVO AmdTable 00000001 INTL 20180313)
> Pass 1 parse of [SSDT]
> Pass 2 parse of [SSDT]
> Parsing Deferred Opcodes (Methods/Buffers/Packages/Regions)
> 
> Parsing completed
> Disassembly completed
> ASL Output:    ssdt5.dsl - 5582 bytes
> File appears to be binary: found 1140 non-ASCII characters, disassembling
> Binary file appears to be a valid ACPI table, disassembling
> Input file ssdt6.dat, Length 0x1497 (5271) bytes
> ACPI: SSDT 0x0000000000000000 001497 (v01 LENOVO AmdTable 00000001 INTL 20180313)
> Pass 1 parse of [SSDT]
> Pass 2 parse of [SSDT]
> Parsing Deferred Opcodes (Methods/Buffers/Packages/Regions)
> 
> Parsing completed
> Disassembly completed
> ASL Output:    ssdt6.dsl - 20293 bytes
> File appears to be binary: found 1314 non-ASCII characters, disassembling
> Binary file appears to be a valid ACPI table, disassembling
> Input file ssdt7.dat, Length 0x1576 (5494) bytes
> ACPI: SSDT 0x0000000000000000 001576 (v01 LENOVO AmdTable 00000001 INTL 20180313)
> Pass 1 parse of [SSDT]
> Pass 2 parse of [SSDT]
> Parsing Deferred Opcodes (Methods/Buffers/Packages/Regions)
> 
> Parsing completed
> Disassembly completed
> ASL Output:    ssdt7.dsl - 30076 bytes
> File appears to be binary: found 4095 non-ASCII characters, disassembling
> Binary file appears to be a valid ACPI table, disassembling
> Input file ssdt8.dat, Length 0x353C (13628) bytes
> ACPI: SSDT 0x0000000000000000 00353C (v01 LENOVO AmdTable 00000001 INTL 20180313)
> Pass 1 parse of [SSDT]
> Pass 2 parse of [SSDT]
> Parsing Deferred Opcodes (Methods/Buffers/Packages/Regions)
> 
> Parsing completed
> Disassembly completed
> ASL Output:    ssdt8.dsl - 78242 bytes
> File appears to be binary: found 74 non-ASCII characters, disassembling
> Binary file appears to be a valid ACPI table, disassembling
> Input file ssdt9.dat, Length 0x90 (144) bytes
> ACPI: SSDT 0x0000000000000000 000090 (v01 LENOVO AmdTable 00000001 INTL 20180313)
> Pass 1 parse of [SSDT]
> Pass 2 parse of [SSDT]
> Parsing Deferred Opcodes (Methods/Buffers/Packages/Regions)
> 
> Parsing completed
> Disassembly completed
> ASL Output:    ssdt9.dsl - 1767 bytes
> File appears to be binary: found 32 non-ASCII characters, disassembling
> Binary file appears to be a valid ACPI table, disassembling
> Input file tpm2.dat, Length 0x38 (56) bytes
> ACPI: TPM2 0x0000000000000000 000038 (v04 LENOVO CB-01    00000002 LENO 00000001)
> Acpi Data Table [TPM2] decoded
> Formatted output:  tpm2.dsl - 1515 bytes
> File appears to be binary: found 189 non-ASCII characters, disassembling
> Binary file appears to be a valid ACPI table, disassembling
> Input file uefi.dat, Length 0x12A (298) bytes
> ACPI: UEFI 0x0000000000000000 00012A (v01 LENOVO CB-01    00000001 LENO 00000001)
> Acpi Data Table [UEFI] decoded
> Formatted output:  uefi.dsl - 2505 bytes
> File appears to be binary: found 37100 non-ASCII characters, disassembling
> Binary file appears to be a valid ACPI table, disassembling
> Input file vfct.dat, Length 0xD484 (54404) bytes
> ACPI: VFCT 0x0000000000000000 00D484 (v01 LENOVO CB-01    00000001 LENO 00000001)
> Unknown ACPI table signature [VFCT], decoding ACPI table header only
> Acpi Data Table [VFCT] decoded
> Formatted output:  vfct.dsl - 269557 bytes
> File appears to be binary: found 17 non-ASCII characters, disassembling
> Binary file appears to be a valid ACPI table, disassembling
> Input file wsmt.dat, Length 0x28 (40) bytes
> ACPI: WSMT 0x0000000000000000 000028 (v01 LENOVO CB-01    00000000 LENO 00000001)
> Acpi Data Table [WSMT] decoded
> Formatted output:  wsmt.dsl - 1313 bytes
> Low Power S0 Idle is 0
> The system does not support S0ix!
> 
> 
> #################################################
> #!/bin/bash
> 
> cd /var/tmp/
> 
> acpidump -b
> 
> iasl -d *.dat
> 
> lp=$(grep "Low Power S0 Idle" /var/tmp/facp.dsl | awk '{print $(NF)}')
> 
> if [ "$lp" -eq 1 ]; then
> 
> echo "Low Power S0 Idle is" $lp
> 
> echo "The system supports S0ix!"
> 
> else
> 
> echo "Low Power S0 Idle is" $lp
> 
> echo "The system does not support S0ix!"
> 
> fi
> 
>  
> 
> Thanks,
> 
> Basavaraj
> 
> 
> 
> 
> -- 
> Stephen MacNeil
> 905 334 5092
> mglessons.com <http://mglessons.com>

