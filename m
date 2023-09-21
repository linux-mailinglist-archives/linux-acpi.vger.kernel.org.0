Return-Path: <linux-acpi+bounces-16-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E04697A9548
	for <lists+linux-acpi@lfdr.de>; Thu, 21 Sep 2023 16:32:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24B0BB20A7E
	for <lists+linux-acpi@lfdr.de>; Thu, 21 Sep 2023 14:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99559AC5D
	for <lists+linux-acpi@lfdr.de>; Thu, 21 Sep 2023 14:30:58 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689E3BA26;
	Thu, 21 Sep 2023 14:25:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01E48C4E75C;
	Thu, 21 Sep 2023 14:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695306344;
	bh=O/GSwqIMtF+fUfls/J78tZOTn7LuNjDRw/eKJTFzejI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=uUKLAogCghq5l3EvSi3Jwmr59oqKIzdo0IH4dHDGGUYaF8cctsx8br9e4KU3rycLc
	 NxGng6yxbFW+r4cIeRy+x0zIn1Z6xAdNCERr1yfIx1vxP1mVyltPuOf/UUfDlJnc+z
	 E8cpXxk6vg3kY+TWajKG8mbdtKtf6lAIODnCFnIXjlOM3DSdA1Pbww8K0vGLLJKGEA
	 qpypkk1sO7Ffjmp1HDBc/XInLTcWO8QMW3o2sd4OzO6W0fIzKSnLAxMjadwPNAGNBe
	 Wpjxjn67SBIiE1CHNY/cyV+KlpU9akX+9uLZi9ehxHkrqs3Tch8YBstV30aFx26H+a
	 rFNvFox/kt6sQ==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-50307759b65so1931211e87.0;
        Thu, 21 Sep 2023 07:25:43 -0700 (PDT)
X-Gm-Message-State: AOJu0YwbIYtVTPE37nBYg3VjQLgaogblgM7kHikwfpTCVnCvQU0/+xV7
	E/GtcYFoB154o7L5xdiOsq29mEOJKHXuCZ5rpA==
X-Google-Smtp-Source: AGHT+IHrmukbRoZ3s/8ATARI7VLoKjLFus0maTkXeK6qcvuGFFDUO9RS2h5qv7r6B2wWwqxbx9HdtE39hvBQhLCYW2Y=
X-Received: by 2002:ac2:4d93:0:b0:500:a7c8:1847 with SMTP id
 g19-20020ac24d93000000b00500a7c81847mr4429914lfe.66.1695306342159; Thu, 21
 Sep 2023 07:25:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230907214012.74978-1-sjg@chromium.org>
In-Reply-To: <20230907214012.74978-1-sjg@chromium.org>
From: Rob Herring <robh@kernel.org>
Date: Thu, 21 Sep 2023 09:25:29 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+WfWrZErmz4u3_-CoVAuxL21UndcRekfJ1e61ZMMBqRw@mail.gmail.com>
Message-ID: <CAL_Jsq+WfWrZErmz4u3_-CoVAuxL21UndcRekfJ1e61ZMMBqRw@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] schemas: Add some common reserved-memory usages
To: Simon Glass <sjg@chromium.org>
Cc: devicetree@vger.kernel.org, Dhaval Sharma <dhaval@rivosinc.com>, 
	Guo Dong <guo.dong@intel.com>, U-Boot Mailing List <u-boot@lists.denx.de>, 
	Yunhui Cui <cuiyunhui@bytedance.com>, Chiu Chasel <chasel.chiu@intel.com>, 
	Mark Rutland <mark.rutland@arm.com>, linux-acpi@vger.kernel.org, 
	Maximilian Brune <maximilian.brune@9elements.com>, Ard Biesheuvel <ardb@kernel.org>, 
	Tom Rini <trini@konsulko.com>, Lean Sheng Tan <sheng.tan@9elements.com>, 
	Gua Guo <gua.guo@intel.com>, ron minnich <rminnich@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 7, 2023 at 4:40=E2=80=AFPM Simon Glass <sjg@chromium.org> wrote=
:
>
> It is common to split firmware into 'Platform Init', which does the
> initial hardware setup and a "Payload" which selects the OS to be booted.
> Thus an handover interface is required between these two pieces.
>
> This aims to provide an small schema addition for the memory mapping
> needed to keep these two pieces working together well.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> Changes in v6:
> - Drop mention of UEFI
> - Use compatible strings instead of node names
>
> Changes in v5:
> - Drop the memory-map node (should have done that in v4)
> - Tidy up schema a bit
>
> Changes in v4:
> - Make use of the reserved-memory node instead of creating a new one
>
> Changes in v3:
> - Reword commit message again
> - cc a lot more people, from the FFI patch
> - Split out the attributes into the /memory nodes
>
> Changes in v2:
> - Reword commit message
>
>  .../reserved-memory/common-reserved.yaml      | 71 +++++++++++++++++++
>  1 file changed, 71 insertions(+)
>  create mode 100644 dtschema/schemas/reserved-memory/common-reserved.yaml
>
> diff --git a/dtschema/schemas/reserved-memory/common-reserved.yaml b/dtsc=
hema/schemas/reserved-memory/common-reserved.yaml
> new file mode 100644
> index 0000000..4889f59
> --- /dev/null
> +++ b/dtschema/schemas/reserved-memory/common-reserved.yaml
> @@ -0,0 +1,71 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/reserved-memory/common-reserved.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Common memory reservations
> +
> +description: |
> +  Specifies that the reserved memory region can be used for the purpose
> +  indicated by its compatible string.
> +
> +  Clients may reuse this reserved memory if they understand what it is f=
or,
> +  subject to the notes below.
> +
> +maintainers:
> +  - Simon Glass <sjg@chromium.org>
> +
> +allOf:
> +  - $ref: reserved-memory.yaml
> +
> +properties:
> +  compatible:
> +    description: |
> +      This describes some common memory reservations:
> +
> +         acpi-reclaim: Contains ACPI tables; memory may be reclaimed whe=
n the
> +           tables are no-longer needed

I think you are mixing 2 things with the name here. What the memory
contains and what to do with it. You don't need the latter. The
consumer of the region will know what to do with it if anything based
on knowing what is in the region. For example, The DTB passed to the
OS is typically in a reserved region (probably still /mem-reserve/
though). The DTB may remain there forever or the OS could copy it
somewhere else and free the reserved region. The Linux kernel does
both depending on the arch. (Of course there is no "dtb" compatible
because we have to pass the location of the dtb to even find the
reserved regions in the first place.)

So the question here is whether just "acpi" (or "acpi-tables"?) would
be explicit enough?

> +         acpi-nvs: Contains ACPI Non-volatile-storage data; memory may b=
e
> +           reclaimed when the tables are no-longer needed

No need to say anything about reclaiming.

I know some ACPIisms (e.g. DSDT), but I don't know what NVS or
"Non-volatile-storage data" is in an ACPI context.

> +         boot-code: Contains code used for booting; memory may be reclai=
med by
> +           the OS when it is running
> +         boot-code: Contains data used for booting; memory may be reclai=
med by

boot-data?

> +           the OS when it is running

I thought these were for stages before we get to OS?

> +         runtime-code: Contains code used for interacting with the syste=
m when
> +           running; memory may be reclaimed if this code is not called
> +         runtime-data: Contains data used for interacting with the syste=
m when
> +           running; memory may be reclaimed if the runtime code is not u=
sed

"boot" vs. "runtime" seem too vague. However, if these mean EFI boot
time services and runtime services, then I understand exactly what
they are. In that case dropping 'uefi,' was a mistake. But EFI has its
own way to define these regions, right?

Rob

