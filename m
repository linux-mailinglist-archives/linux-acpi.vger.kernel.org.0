Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CCA7553239
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Jun 2022 14:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350467AbiFUMim (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 21 Jun 2022 08:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350532AbiFUMij (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 21 Jun 2022 08:38:39 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99C9D10FE8
        for <linux-acpi@vger.kernel.org>; Tue, 21 Jun 2022 05:38:38 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id i7so6561300ybe.11
        for <linux-acpi@vger.kernel.org>; Tue, 21 Jun 2022 05:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kCOMEdjBSgtz3/x5+tXgoigNB44uO36c23d/a03FMis=;
        b=s/nOETh/m0hKRj70rTFyR/sB/2MFkqF2S6j4pzrBiKLTu6U6Yno0A+lKisk/Q8A3ed
         DMIpUPnqavauoQkPPI9XSrVGCVer10lXzwgnYAQyqCll7MmvlrSZKWPJICyrL2lINYCP
         h8k1fikjUfYynG/FVthNq55FkW+4civzhBlXAWR1ReMwWirfEDBRp3fCvn45PrWrAj7+
         LbES9t8l2AwaUU0j74Inqoapwi7piyjqN9qU73eHblZQmGBXD4s73BZY2uYe/Zgto2Gj
         RMN0Fmv4/HPPcKEls60r0DDs8oWvGCXY7AIXN2ZsZCgpDjnTUk1cOR6GvfUHsiOUuRVx
         NLRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kCOMEdjBSgtz3/x5+tXgoigNB44uO36c23d/a03FMis=;
        b=dU5USYP+n5ErtXfK8Jp7CijlVUl38tNmCfCBuohenu9QuJDB1vLPpPTTyiE6FFmqHi
         Ge9TWM98KB/RgtYRcjv124yHUtJXOmUIUtHIyuXGvZoOh6L8rwkGNvfGDga4GJsbNmDJ
         NAMGsRdzeRAs/WB3BPZNBz+yZMP6ily1PNWovMbHigvagIAJe5A/WLIJPDDz/bJpx/Gl
         C2zUtRFwXWav0S2tJ511tGj9sk5xCi/uLD462ElAMfsXeoGuz6YvIIiCsCb7agubkIPU
         8xLwuXNypDFa/CM11/cX0xGhZAqhHeiy1tdgiEBBQlQWuqETXiN6YEpbNPIPA8lwLVlf
         JgIw==
X-Gm-Message-State: AJIora/vHFMt/R+JogJCRsomarjTak/RFgTzZBiC6N9Z2h/rlvXNvETJ
        shG8mPLb8Ljge3B867WZqnsHwpm12ISklPe8kiYW4A==
X-Google-Smtp-Source: AGRyM1uosJhHpPF+vcXs/IQuCXQnRAj4/Ok53LFOFch2pVQSNrNC054peiacjcunasehRXPUFI8vkJjSEKfGGyvBtzs=
X-Received: by 2002:a05:6902:1205:b0:669:22dc:e8ad with SMTP id
 s5-20020a056902120500b0066922dce8admr9430327ybu.371.1655815117791; Tue, 21
 Jun 2022 05:38:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220620092546.8298-1-hdegoede@redhat.com> <20220620092546.8298-3-hdegoede@redhat.com>
 <CAD8Lp45ismm5yG2ajGH_h=BKLh6hs8yC7gy3jq1Kn1pst0AFKg@mail.gmail.com>
 <b2ad4b62-89bc-48c5-ebc3-c9d8f86aa902@redhat.com> <CAD8Lp464t0NOqR4keodsv2XXq1s_9soFDHEduHZGk1UoP5vFHA@mail.gmail.com>
 <08660caa-6c01-73e3-306d-6f85af0f5e04@redhat.com>
In-Reply-To: <08660caa-6c01-73e3-306d-6f85af0f5e04@redhat.com>
From:   Daniel Drake <drake@endlessos.org>
Date:   Tue, 21 Jun 2022 20:38:27 +0800
Message-ID: <CAD8Lp466DCY3k0piSJLLxvHXi9Jbd=mdROrnMwVDQtwZDdNMng@mail.gmail.com>
Subject: Re: [PATCH 2/4] ACPI: EC: Drop the EC_FLAGS_IGNORE_DSDT_GPE quirk
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        devel@acpica.org, Chris Chiu <chris.chiu@canonical.com>,
        Jian-Hong Pan <jhp@endlessos.org>,
        Carlo Caione <carlo@caione.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Jun 21, 2022 at 4:37 PM Hans de Goede <hdegoede@redhat.com> wrote:
> If you look for "ACPI: EC: " in the dmesg you shoud find 2 blocks
> of log lines like this (note the output has changed somewhat
> overtime):

Got it.

I was able to verify matching addresses for GL702VMK, X505BA, X505BP,
X580VD, X542BP.

I also have logs for FX502VD, FX502VE and X550VX but they only log one
set of addresses, some kernel version along the way did not log both.

Don't have logs for X542BA.

I think this plus the code tracing is overly convincing,

Reviewed-by: Daniel Drake <drake@endlessos.org>

Thanks.
