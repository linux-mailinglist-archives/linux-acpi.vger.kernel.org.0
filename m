Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6715764744B
	for <lists+linux-acpi@lfdr.de>; Thu,  8 Dec 2022 17:29:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbiLHQ3P convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Thu, 8 Dec 2022 11:29:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbiLHQ3K (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 8 Dec 2022 11:29:10 -0500
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B69B0175AC;
        Thu,  8 Dec 2022 08:29:04 -0800 (PST)
Received: by mail-qt1-f180.google.com with SMTP id fz10so1442385qtb.3;
        Thu, 08 Dec 2022 08:29:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9SMMf+hquSFM569LOmgsVrquK2ebdVd9ejvYmGcH8kU=;
        b=zJ7bJHgnNRYyZx7P3CLrYXvezwcwwolkoAUb+lgCpwJf3hcB8ON5GYMzkUyZYFr3rT
         BgcSAkn7kILaAmTJgyg7/Nx9mQrHQzS4kVJY+uDeqsfmX0wm0vpWGIV3NjMTZy65H+B6
         dx1cAWxodhvxfnfuXgLNoKOkdUhLaU5z3dtMK86X+Gi46Xu5UDunbe2oofGLoCBjLwfR
         7I4vu0wq6FkqlsAK+xxoCWEBZTrwYP9CeFgk1ehxj4NwfQYL7Yqu47bc1y1Wqif12ZGI
         ObdpLVSAAlAjL3K3BeCN9MJjhCclQLunaCSm7Dgk/xkcKDXAqzYyhII32v16+t+FMnvi
         mPyQ==
X-Gm-Message-State: ANoB5pkA+UyLxuZTTZmWJLU2gB17L6t9W0SCr+btjSGUL7amHENFPyaI
        4X3bKQ8bcMdE3wyVoEKazCTDz9CkshuJiytDJfs=
X-Google-Smtp-Source: AA0mqf4lf5c+gJxv89EuXzWEId/JI8uNVeliPyftHqgt2w9CDgAykQB8Ak/PnOQ83rYcvJ31DYzm94UVrm6p9KzOBLI=
X-Received: by 2002:a05:622a:1989:b0:3a5:7cf8:1a6e with SMTP id
 u9-20020a05622a198900b003a57cf81a6emr86715503qtc.48.1670516943861; Thu, 08
 Dec 2022 08:29:03 -0800 (PST)
MIME-Version: 1.0
References: <20221208224016.2009797-1-amadeuszx.slawinski@linux.intel.com>
In-Reply-To: <20221208224016.2009797-1-amadeuszx.slawinski@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 8 Dec 2022 17:28:52 +0100
Message-ID: <CAJZ5v0izpg_awSBR-HUa58z-wQAm9QGNBV8T4bzavGUCou+R-w@mail.gmail.com>
Subject: Re: [PATCH v2] ACPICA: Fix operand resolution
To:     =?UTF-8?B?QW1hZGV1c3ogU8WCYXdpxYRza2k=?= 
        <amadeuszx.slawinski@linux.intel.com>
Cc:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Robert Moore <robert.moore@intel.com>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        devel@acpica.org, linux-kernel@vger.kernel.org,
        Cezary Rojewski <cezary.rojewski@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Dec 8, 2022 at 3:40 PM Amadeusz Sławiński
<amadeuszx.slawinski@linux.intel.com> wrote:
>
> In our tests we get UBSAN warning coming from ACPI parser. This is
> caused by trying to resolve operands when there is none.
>
> [    0.000000] Linux version 5.15.0-rc3chromeavsrel1.0.184+ (root@...) (gcc (Ubuntu 10.3.0-1ubuntu1~20.04) 10.3.0, GNU ld (GNU Binutils for Ubuntu) 2.34) #1 SMP PREEMPT Sat Oct 16 00:08:27 UTC 2021
> ...
> [ 14.719508] ================================================================================
> [ 14.719551] UBSAN: array-index-out-of-bounds in /.../linux/drivers/acpi/acpica/dswexec.c:401:12
> [ 14.719594] index -1 is out of range for type 'acpi_operand_object *[9]'
> [ 14.719621] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.15.0-rc3chromeavsrel1.0.184+ #1
> [ 14.719657] Hardware name: Intel Corp. Geminilake/GLK RVP2 LP4SD (07), BIOS GELKRVPA.X64.0214.B50.2009111159 09/11/2020
> [ 14.719694] Call Trace:
> [ 14.719712] dump_stack_lvl+0x38/0x49
> [ 14.719749] dump_stack+0x10/0x12
> [ 14.719775] ubsan_epilogue+0x9/0x45
> [ 14.719801] __ubsan_handle_out_of_bounds.cold+0x44/0x49
> [ 14.719835] acpi_ds_exec_end_op+0x1d7/0x6b5
> [ 14.719870] acpi_ps_parse_loop+0x942/0xb34
> ...
>
> Problem happens because WalkState->NumOperands is 0 and it is used when
> trying to access into operands table. Actual code is:
> WalkState->Operands [WalkState->NumOperands -1]
> which causes out of bound access. Improve the check before above access
> to check if ACPI opcode should have any arguments (operands) at all.
>
> Link: https://github.com/acpica/acpica/pull/745
> Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
> Reviewed-by: Cezary Rojewski <cezary.rojewski@intel.com>
> ---
>
> Changes:
> v2: Fix comment to tell that opcode has no arguments
>
> ---
>  drivers/acpi/acpica/dswexec.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/acpica/dswexec.c b/drivers/acpi/acpica/dswexec.c
> index e8ad41387f84..b082eb942a0f 100644
> --- a/drivers/acpi/acpica/dswexec.c
> +++ b/drivers/acpi/acpica/dswexec.c
> @@ -389,9 +389,11 @@ acpi_status acpi_ds_exec_end_op(struct acpi_walk_state *walk_state)
>
>                 /*
>                  * All opcodes require operand resolution, with the only exceptions
> -                * being the object_type and size_of operators.
> +                * being the object_type and size_of operators as well as opcodes that
> +                * take no arguments.
>                  */
> -               if (!(walk_state->op_info->flags & AML_NO_OPERAND_RESOLVE)) {
> +               if (!(walk_state->op_info->flags & AML_NO_OPERAND_RESOLVE) &&
> +                   (walk_state->op_info->flags & AML_HAS_ARGS)) {
>
>                         /* Resolve all operands */
>
> --

Applied, thanks!
