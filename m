Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 052C265453A
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Dec 2022 17:36:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbiLVQgv (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 22 Dec 2022 11:36:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbiLVQgs (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 22 Dec 2022 11:36:48 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D728286C8
        for <linux-acpi@vger.kernel.org>; Thu, 22 Dec 2022 08:36:47 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id p13-20020a05600c468d00b003cf8859ed1bso1704039wmo.1
        for <linux-acpi@vger.kernel.org>; Thu, 22 Dec 2022 08:36:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vNaGhqjJmSUPd8ZnqNzNoTlSAb4imPdRX0FygqicTdE=;
        b=LCV3+OATXySth/v7RuhmUF0ygRn0/ISulGDBdDDgghWh5OJpSelIvH6t1BiqpBLqYY
         WFdtaCI2KY8BiAMnbTOznig16eefM9+59VV8GPbYNUqo2Q2KSCdTAjywjfyrgU3O+m4R
         Pos8vk7Ih01Bl4gLEfh/d/np2YgM5RUHpv3CGXgMuEwfirSGz0lrLNiEzNaFtk+lmcH7
         c7weFDqmlifAttqkz5eTKZ7bBOCAbOBzcThmWTi02zChddSIV3y3zuqHCpyVKt+iEFGF
         RYVDvfdbSNJ9FrVVpVPzwAGUtEHdtizNBW4OzsRHo/NluQaZt12c+bV63WiO8YDk8lWX
         yRbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vNaGhqjJmSUPd8ZnqNzNoTlSAb4imPdRX0FygqicTdE=;
        b=r4Oq9Sth2rSajgvEwS08rYgrS5KAJH4Tur5l1fvwad6ehdIyxfsK1pRMukXrcLA24s
         8T0GfzQg5GoSSwkHP7OCqiizwuXNdZFH881XGvJPVZMpXObHODQ5ItW2az6InSQ3lEDl
         MaAlzQ/lI67AmuVBVVvWOCQ7VfXMY10YJkShQqp0a6ctSU74nrjZgnAJIM/PIgLGxrux
         MWvU5+s5lSijdLM2mWlWb0dQQr0vsFsXyHtJfXuVGmD3MPNxCKIudfkTeDnXTroOGhMs
         Fb+O9SNd9a4uj4obemeCQhfxhzutC8SxyWhGHbqlozN/NiRP2th4ZP2E95LdD7DD+7mM
         S0Pw==
X-Gm-Message-State: AFqh2koNfKbbomyrhq78iYIBcriwq6h94MApkNVa9Ge0wcxgBfRa/wC/
        QrBNkvCriLVlOC6woxZcXtODfZ9d45+YOIVQ8Iw=
X-Google-Smtp-Source: AMrXdXsiCrLkoVR3oj78JaTq3adEQ2GckFPdXYH+trcX3QESsNjc+JJ88uoOYDwJqVHZ7NlAJKjBzPDhEIeOyYmo1Ik=
X-Received: by 2002:a05:600c:430c:b0:3cf:7dc1:f432 with SMTP id
 p12-20020a05600c430c00b003cf7dc1f432mr370480wme.148.1671727005996; Thu, 22
 Dec 2022 08:36:45 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:adf:ff91:0:0:0:0:0 with HTTP; Thu, 22 Dec 2022 08:36:45
 -0800 (PST)
Reply-To: hustonkarim7712@gmail.com
From:   Huston Karim <hustonali2999@gmail.com>
Date:   Thu, 22 Dec 2022 17:36:45 +0100
Message-ID: <CALe2VC_ugEYCRVCdhd1CEvSA4BUtYMsbnWfQgGWDFBethGPo6Q@mail.gmail.com>
Subject: Hello,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hello, did you receive my email on 21/12/2022?
Please answer .Regards thanks.
