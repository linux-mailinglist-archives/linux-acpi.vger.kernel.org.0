Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 520346444A0
	for <lists+linux-acpi@lfdr.de>; Tue,  6 Dec 2022 14:34:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234232AbiLFNeT (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 6 Dec 2022 08:34:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233790AbiLFNeR (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 6 Dec 2022 08:34:17 -0500
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 825C725EA5
        for <linux-acpi@vger.kernel.org>; Tue,  6 Dec 2022 05:34:16 -0800 (PST)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-3bf4ade3364so151843327b3.3
        for <linux-acpi@vger.kernel.org>; Tue, 06 Dec 2022 05:34:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SzBlYeGeT15Xra75w9IZDBjQ7Da3XKSmRdlnDJDYrko=;
        b=plIPv+lnMIRiOFIe1dV+2tGtFokN2PX8I8Vl98aLxQc9p4eid896+qqRiD3cj5lfhx
         z1hiGYil0vHTQsGiaUgsnmnfx7Jsn5jop25MSUm4B/gJqMPAdiI+jqYGT4X+agKLBheY
         M4kLaJ4VYCDPrPdHz+VgEOo7V/8+VLiplXwZ5AxhmuB3ZAIj06bRIm6vVBa+cxsfUC69
         p7oJjaq1f7uQyzM8lwAnIzamm5TXtetx0xVW4yZv8ZN22bVtgp/BSdTYcvwessuJv/HS
         +NRVIrLiepTygJiUKe8fSjaB2LODMLrNxWaYxbpkKlISbamBewTovVPI3Q2nv//3DE4C
         AORg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SzBlYeGeT15Xra75w9IZDBjQ7Da3XKSmRdlnDJDYrko=;
        b=fF1KWVF2MtvBFtmNpDd3nbpvYrOPsAxQyFxmEhEt2TFnqD0cCq+zjj85i898g9kgsG
         vHul+65aqSDkq55gSvP2MfEObIzJgRaKEsaux3v0yyjSmKwJMMEkcFEye0uUuKlyrwAM
         5FH8DJd2uBIliwNQIqRWHwYZRLsJu8hM2V2Qc6ZTXjs6sfiH/2YXPazK4gKKhJhEaTtq
         JANBxiKiVctDnkfJ/68slwi4Z2J8Y+CfNZJ48CUCMVgrEtzvX1hzD0zfkJhJ8kmux/h8
         ZoBcrCYBvoSzljLn/6KSRxywWRTMvip41LldrB0FX2fT2sOJ4GrbYVXGw7fMsj2Pkz4j
         ku6Q==
X-Gm-Message-State: ANoB5pmS0l3Im+e67ywtpNLiSNfW8bJ4qzi+QEZxCEBZ+dx7jufE7c21
        05067iVTg7ZMb+cgCQjGJFxSdByFYKMqN6Rdz34=
X-Google-Smtp-Source: AA0mqf5LIFZdFA8gXtM15wCQVGRPhLW0DnkI1aVHz2d7yBbqXPecX+J2gwBesGTmYMSfngKxp/YLH/vq5s11h8+sSxc=
X-Received: by 2002:a81:5243:0:b0:3d2:2098:c5fb with SMTP id
 g64-20020a815243000000b003d22098c5fbmr31224498ywb.121.1670333655770; Tue, 06
 Dec 2022 05:34:15 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:7010:a205:b0:314:d2a3:70a with HTTP; Tue, 6 Dec 2022
 05:34:15 -0800 (PST)
Reply-To: mr.abraham022@gmail.com
From:   "Mr.Abraham" <mrkojofofone01@gmail.com>
Date:   Tue, 6 Dec 2022 13:34:15 +0000
Message-ID: <CACJtp8tgBjrWD7ywREfL1yUK0-utTuArETnYq7P42dWiPJKSBA@mail.gmail.com>
Subject: Hi
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

My Greeting, Did you receive the letter i sent to you. Please answer me.
Regard, Mr.Abraham
