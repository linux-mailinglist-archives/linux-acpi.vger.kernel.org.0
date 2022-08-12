Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD239591135
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Aug 2022 15:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237181AbiHLNLg (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 12 Aug 2022 09:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231698AbiHLNLf (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 12 Aug 2022 09:11:35 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D62616C13C
        for <linux-acpi@vger.kernel.org>; Fri, 12 Aug 2022 06:11:33 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id l4so1143258wrm.13
        for <linux-acpi@vger.kernel.org>; Fri, 12 Aug 2022 06:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc;
        bh=oBbits87Sh54Pv6OEfDdfWZYrwVvKln+o+HoHPpBNT0=;
        b=s4ddTScLTJaDLUFkiZ3TBa3nJtFTnumXRrFoezKDY9/HeFWIew4zitQN4HCRxdSuMN
         AI1TlchQml2Nbne0zQcQvvVkELdYXXjY9CRNmdUMpNH1ZIQCr0iTGvM4zW7BH74GccBr
         LZM0Stq/nIwqOeEWQuxBUSxqFsxd4FqhzRhZapA9vGlCIj466gdc66fFKTY57C01wlVx
         YawjSwDBzBtyktrL9O/Colyw1wBIFwJiYCVVJ6bhrWLll9yerrK+kByLaITALFhvlzSk
         IH1Zxzo+3qkM1G8YTG1HfSGfNNUK5T41HOVE1g+P8JThNJeigd5Ka01AzXV0G+hcDFD9
         jO2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=oBbits87Sh54Pv6OEfDdfWZYrwVvKln+o+HoHPpBNT0=;
        b=EMBuusVz6/EUbkzAoLXY1Sl5LOTbmlNbwQ3TKSljrVoehkgr/8xCf7TZ+jcNuC/rV0
         9Lf7JCul0NVZzP1IYhAJfHywSMHtK/5Em2OyE0rYjnlAgKJWD1n6GUc8omdlvHWx50Wa
         iDGVcujMF4+bAF7Co6kWkFrhG5oJZ5/aY3L8GOV5lAHGtoDXkxmtRE3j89Ke/uQuu6t1
         rUMU+hdS/AKJOFaqpNEmEscfMZ2SEuo2sLPKIxJvJ/oVTloBEH8N5seFlTWtiwIUEMBu
         Pnhtv1YHabbRlvgebE2JOT5irDR6OxAhOHzd43lE23lfHiZsu3jUryMPd+YtD7W7/6q0
         pMog==
X-Gm-Message-State: ACgBeo0krIK/h6TFfZnXgurjtXbrXY1y6va020z3NtFZ/74Bu66/9TrZ
        3aequSh2cPVrWRd/2FHlLKKzgQ==
X-Google-Smtp-Source: AA6agR6AuxoJ9bwmQi0vU/ySTcZsqisySBUe5l5ptauxg9gq8coDfUkOE+L1t6nDa3qVGWnjHUlVsA==
X-Received: by 2002:adf:f346:0:b0:21f:13ec:cacf with SMTP id e6-20020adff346000000b0021f13eccacfmr2080589wrp.525.1660309892485;
        Fri, 12 Aug 2022 06:11:32 -0700 (PDT)
Received: from localhost ([109.180.234.208])
        by smtp.gmail.com with ESMTPSA id e17-20020adfa451000000b0021e30e9e44asm2000849wra.53.2022.08.12.06.11.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Aug 2022 06:11:31 -0700 (PDT)
From:   Punit Agrawal <punit.agrawal@bytedance.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v1 0/5] ACPI: Device enumeration rearrangements and
 parent field elimination
In-Reply-To: <12036348.O9o76ZdvQC@kreacher> (Rafael J. Wysocki's message of
        "Wed, 10 Aug 2022 18:11:58 +0200")
References: <12036348.O9o76ZdvQC@kreacher>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
Date:   Fri, 12 Aug 2022 14:11:31 +0100
Message-ID: <875yixk3ng.fsf@stealth>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Rafael,

"Rafael J. Wysocki" <rjw@rjwysocki.net> writes:

> Hi All,
>
> There are still opportunities to clean up the ACPI support code and
> this series is part of the effort in that direction.
>
> It makes changes without functional impact (AFAICS) to the core ACPI
> code related to devices and to some of its users.
>
> Please refer to the patch changelogs for details.

Other than the single typo I noticed in Patch 2, the changes look good!

If it helps,

Reviewed-by: Punit Agrawal <punit.agrawal@bytedance.com>

Thanks,
Punit

[...]

